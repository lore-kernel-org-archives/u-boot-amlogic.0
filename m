Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.23272.1669218189650192739
 for <u-boot-amlogic@groups.io>;
 Wed, 23 Nov 2022 07:43:10 -0800
Received: by mail-wr1-f51.google.com with SMTP id v1so29931928wrt.11
        for <u-boot-amlogic@groups.io>; Wed, 23 Nov 2022 07:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0vru+2y+YkV/tsfTUF8e7PG64OdxLixARXcU8UCE5M=;
        b=e38zaGChhYSqag6DFx6WgSEUz/L2s/XyfWNapK+sAkbuAtz9Z9PAdDSjpcwy1j1trk
         3hcKHQHgd459LByHRuKHLzrmstvY6ap4u7G2T8LCFs3FjnwjmsR8fjwhzgedfgXSJWgi
         jZGKHAQsX2qTxSxFMLSVhJwwLlf1+wHEszROJBT3FK3HcuCOw2a3//AgrJuP8OBy478n
         PbOiGjIO/wYYR+2W0EWJ+nTRJODNcipHZ5MtgaLjzuYlpHF7ZthLioZDwpEk0jVrFJaT
         qWgK2FMm2xQ9CXjyl9V0AclLfMzkuAbnPMCFVU6nSQJyP7Z/3VDoax//R7iLnNTFznPy
         LMJg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Date: Wed, 23 Nov 2022 16:42:50 +0100
Subject: [PATCH 2/2] ARM: meson: g12a: switch dwc2 otg to DM
MIME-Version: 1.0
Message-Id: <20221024-meson-dm-usb-v1-2-2ab077a503b9@baylibre.com>
References: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
In-Reply-To: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <neil.armstrong@linaro.org>, Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

With CONFIG_DM_USB_GADGET=y, we no longer need any board_usb_*() logic
because:
* the dwc2 driver is DM compatible, and handles its own clock enabling
* the dwc3-meson-g12a glue drivers handles "force mode switching"

Remove all mach-meson/g12a usb code and enable CONFIG_DM_USB_GADGET.

Note: Only configs having both CONFIG_USB_DWC3_MESON_G12A=y *and*
      USB_GADGET_DWC2_OTG=y have been updated.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 arch/arm/mach-meson/board-g12a.c          | 127 ------------------------------
 configs/bananapi-m5_defconfig             |   1 +
 configs/beelink-gsking-x_defconfig        |   1 +
 configs/beelink-gtking_defconfig          |   1 +
 configs/beelink-gtkingpro_defconfig       |   1 +
 configs/khadas-vim3_android_ab_defconfig  |   1 +
 configs/khadas-vim3_android_defconfig     |   1 +
 configs/khadas-vim3_defconfig             |   1 +
 configs/khadas-vim3l_android_ab_defconfig |   1 +
 configs/khadas-vim3l_android_defconfig    |   1 +
 configs/khadas-vim3l_defconfig            |   1 +
 configs/odroid-c4_defconfig               |   1 +
 configs/odroid-hc4_defconfig              |   1 +
 configs/odroid-n2_defconfig               |   1 +
 configs/radxa-zero_defconfig              |   1 +
 configs/sei510_defconfig                  |   1 +
 configs/sei610_defconfig                  |   1 +
 configs/u200_defconfig                    |   1 +
 18 files changed, 17 insertions(+), 127 deletions(-)

diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index 2e59eee8f792..d5a830fb1db8 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -17,12 +17,6 @@
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
-#include <usb.h>
-#include <linux/usb/otg.h>
-#include <asm/arch/usb.h>
-#include <usb/dwc2_udc.h>
-#include <phy.h>
-#include <clk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -96,124 +90,3 @@ static struct mm_region g12a_mem_map[] = {
 };
 
 struct mm_region *mem_map = g12a_mem_map;
-
-#if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
-	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
-static struct dwc2_plat_otg_data meson_g12a_dwc2_data;
-
-int board_usb_init(int index, enum usb_init_type init)
-{
-	struct fdtdec_phandle_args args;
-	const void *blob = gd->fdt_blob;
-	int node, dwc2_node;
-	struct udevice *dev, *clk_dev;
-	struct clk clk;
-	int ret;
-
-	/* find the usb glue node */
-	node = fdt_node_offset_by_compatible(blob, -1,
-					     "amlogic,meson-g12a-usb-ctrl");
-	if (node < 0) {
-		debug("Not found usb-control node\n");
-		return -ENODEV;
-	}
-
-	if (!fdtdec_get_is_enabled(blob, node)) {
-		debug("usb is disabled in the device tree\n");
-		return -ENODEV;
-	}
-
-	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
-	if (ret) {
-		debug("Not found usb-control device\n");
-		return ret;
-	}
-
-	/* find the dwc2 node */
-	dwc2_node = fdt_node_offset_by_compatible(blob, node,
-						  "amlogic,meson-g12a-usb");
-	if (dwc2_node < 0) {
-		debug("Not found dwc2 node\n");
-		return -ENODEV;
-	}
-
-	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
-		debug("dwc2 is disabled in the device tree\n");
-		return -ENODEV;
-	}
-
-	meson_g12a_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
-	if (meson_g12a_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
-		debug("usbotg: can't get base address\n");
-		return -ENODATA;
-	}
-
-	/* Enable clock */
-	ret = fdtdec_parse_phandle_with_args(blob, dwc2_node, "clocks",
-					     "#clock-cells", 0, 0, &args);
-	if (ret) {
-		debug("usbotg has no clocks defined in the device tree\n");
-		return ret;
-	}
-
-	ret = uclass_get_device_by_of_offset(UCLASS_CLK, args.node, &clk_dev);
-	if (ret)
-		return ret;
-
-	if (args.args_count != 1) {
-		debug("Can't find clock ID in the device tree\n");
-		return -ENODATA;
-	}
-
-	clk.dev = clk_dev;
-	clk.id = args.args[0];
-
-	ret = clk_enable(&clk);
-	if (ret) {
-		debug("Failed to enable usbotg clock\n");
-		return ret;
-	}
-
-	meson_g12a_dwc2_data.rx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
-						     "g-rx-fifo-size", 0);
-	meson_g12a_dwc2_data.np_tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
-							"g-np-tx-fifo-size", 0);
-	meson_g12a_dwc2_data.tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
-						     "g-tx-fifo-size", 0);
-
-	/* Switch to peripheral mode */
-	ret = dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_PERIPHERAL);
-	if (ret)
-		return ret;
-
-	return dwc2_udc_probe(&meson_g12a_dwc2_data);
-}
-
-int board_usb_cleanup(int index, enum usb_init_type init)
-{
-	const void *blob = gd->fdt_blob;
-	struct udevice *dev;
-	int node;
-	int ret;
-
-	/* find the usb glue node */
-	node = fdt_node_offset_by_compatible(blob, -1,
-					     "amlogic,meson-g12a-usb-ctrl");
-	if (node < 0)
-		return -ENODEV;
-
-	if (!fdtdec_get_is_enabled(blob, node))
-		return -ENODEV;
-
-	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
-	if (ret)
-		return ret;
-
-	/* Switch to OTG mode */
-	ret = dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_HOST);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-#endif
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 6ab2d8ef0c44..49cf0495dd91 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -49,6 +49,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index 2c8c642dcb2d..f9fdfa41a860 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -50,6 +50,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 9848252e7e95..46bd18b666be 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -50,6 +50,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index 484e039fe034..dbb2ce83ea95 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -50,6 +50,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index f3e9f11a8edf..6266a288bbd7 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -84,6 +84,7 @@ CONFIG_MESON_SPIFC=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index f076b6e4e564..ab7666c5a128 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -82,6 +82,7 @@ CONFIG_MESON_SPIFC=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 0cf4bac809b9..bd264dd2bb15 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -70,6 +70,7 @@ CONFIG_MESON_SPIFC=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 828ce6dee9dd..f72c7adda7f4 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -84,6 +84,7 @@ CONFIG_MESON_SPIFC=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index ee1fa5c31f82..871f77dde8cb 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -82,6 +82,7 @@ CONFIG_MESON_SPIFC=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index f1524f562acb..32d6a00410e4 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -70,6 +70,7 @@ CONFIG_MESON_SPIFC=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index d244e71866e7..3253b0a53556 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -50,6 +50,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index fe70d5f12a16..2b6b6e9d51ad 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -68,6 +68,7 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MESON_SPIFC=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 3703d7e17cee..2fff63c753dc 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -50,6 +50,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index d3744f48a31b..dcd0b9b9ffcf 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -45,6 +45,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index b26e065a3dab..36306612451f 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -70,6 +70,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 2302c9eeef07..c15e81b0600b 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -70,6 +70,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index b4f2f21d7eda..cbe0f945a57d 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -44,6 +44,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y

-- 
b4 0.10.1
