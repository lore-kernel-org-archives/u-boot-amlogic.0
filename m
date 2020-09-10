Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.17394.1599727716196750214
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 01:48:36 -0700
Received: by mail-wr1-f66.google.com with SMTP id a17so5769588wrn.6
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgjgJ+J/iHD1UqJKn4gltzZaOnBT1hkwEMFW/ghy/U4=;
        b=zA86iNq/KNkF4xTQdL+xl/KeMMPzFJV6ngnQ4/5Rq4NYhM1FGaKKtHhmVuZGtVWucn
         aCYfrhsiPX/2DlCzlymvBsUz471Woct9MUXxeTYZ1pn7RrkpF5xYroflPwX7fR4FEV3f
         OsdGSdE+Be9okCblZMsvIIfyQs4mg6DJe+nWVxlQlLeRQ2R6Cs6k5QEfIXAwjOYpxV6Z
         3IYSNqfJ5W2WZXeWIKhP1ZLrnRYMQlCg0J/qhc+rOi3OKk3NNjYc3nZFRales80+p3/n
         i68H42+CGYlE5POPT0EB5/WmpaHXXxA1N3M12Ti1tYW+/Qq+jzh3ZHhYSZC6ryR6pGRx
         SodA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 6/8] arm: meson-axg: add board_usb_init()/cleanup() for USB gadget
Date: Thu, 10 Sep 2020 10:48:17 +0200
Message-Id: <20200910084819.25312-7-narmstrong@baylibre.com>
In-Reply-To: <20200910084819.25312-1-narmstrong@baylibre.com>
References: <20200910084819.25312-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add the board_usb_init()/cleanup() for USB gadget for AXG based
on the code for the G12A architecture.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-axg.c | 128 ++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
index 5e0b3f6cb5..0d4eda93b8 100644
--- a/arch/arm/mach-meson/board-axg.c
+++ b/arch/arm/mach-meson/board-axg.c
@@ -14,6 +14,11 @@
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
+#include <usb.h>
+#include <linux/usb/otg.h>
+#include <asm/arch/usb-gx.h>
+#include <usb/dwc2_udc.h>
+#include <clk.h>
 #include <phy.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -118,3 +123,126 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 	/* Enable power gate */
 	clrbits_le32(AXG_MEM_PD_REG_0, AXG_MEM_PD_REG_0_ETH_MASK);
 }
+
+#if CONFIG_IS_ENABLED(USB_DWC3_MESON_GXL) && \
+	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
+static struct dwc2_plat_otg_data meson_gx_dwc2_data;
+
+int board_usb_init(int index, enum usb_init_type init)
+{
+	struct fdtdec_phandle_args args;
+	const void *blob = gd->fdt_blob;
+	int node, dwc2_node;
+	struct udevice *dev, *clk_dev;
+	struct clk clk;
+	int ret;
+
+	/* find the usb glue node */
+	node = fdt_node_offset_by_compatible(blob, -1,
+					     "amlogic,meson-gxl-usb-ctrl");
+	if (node < 0) {
+		debug("Not found usb-control node\n");
+		return -ENODEV;
+	}
+
+	if (!fdtdec_get_is_enabled(blob, node)) {
+		debug("usb is disabled in the device tree\n");
+		return -ENODEV;
+	}
+
+	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
+	if (ret) {
+		debug("Not found usb-control device\n");
+		return ret;
+	}
+
+	/* find the dwc2 node */
+	dwc2_node = fdt_node_offset_by_compatible(blob, node,
+						  "amlogic,meson-g12a-usb");
+	if (dwc2_node < 0) {
+		debug("Not found dwc2 node\n");
+		return -ENODEV;
+	}
+
+	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
+		debug("dwc2 is disabled in the device tree\n");
+		return -ENODEV;
+	}
+
+	meson_gx_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
+	if (meson_gx_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
+		debug("usbotg: can't get base address\n");
+		return -ENODATA;
+	}
+
+	/* Enable clock */
+	ret = fdtdec_parse_phandle_with_args(blob, dwc2_node, "clocks",
+					     "#clock-cells", 0, 0, &args);
+	if (ret) {
+		debug("usbotg has no clocks defined in the device tree\n");
+		return ret;
+	}
+
+	ret = uclass_get_device_by_of_offset(UCLASS_CLK, args.node, &clk_dev);
+	if (ret)
+		return ret;
+
+	if (args.args_count != 1) {
+		debug("Can't find clock ID in the device tree\n");
+		return -ENODATA;
+	}
+
+	clk.dev = clk_dev;
+	clk.id = args.args[0];
+
+	ret = clk_enable(&clk);
+	if (ret) {
+		debug("Failed to enable usbotg clock\n");
+		return ret;
+	}
+
+	meson_gx_dwc2_data.rx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+						     "g-rx-fifo-size", 0);
+	meson_gx_dwc2_data.np_tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+							"g-np-tx-fifo-size", 0);
+	meson_gx_dwc2_data.tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+						     "g-tx-fifo-size", 0);
+
+	/* Switch to peripheral mode */
+	ret = dwc3_meson_gxl_force_mode(dev, USB_DR_MODE_PERIPHERAL);
+	if (ret)
+		return ret;
+
+	return dwc2_udc_probe(&meson_gx_dwc2_data);
+}
+
+int board_usb_cleanup(int index, enum usb_init_type init)
+{
+	const void *blob = gd->fdt_blob;
+	struct udevice *dev;
+	int node;
+	int ret;
+
+	/* find the usb glue node */
+	node = fdt_node_offset_by_compatible(blob, -1,
+					     "amlogic,meson-gxl-usb-ctrl");
+	if (node < 0) {
+		debug("Not found usb-control node\n");
+		return -ENODEV;
+	}
+
+	if (!fdtdec_get_is_enabled(blob, node))
+		return -ENODEV;
+
+	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
+	if (ret)
+		return ret;
+
+	/* Switch to OTG mode */
+	ret = dwc3_meson_gxl_force_mode(dev, USB_DR_MODE_HOST);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+#endif
-- 
2.22.0

