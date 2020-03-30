Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.46269.1585560466973580990
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:47 -0700
Received: by mail-wr1-f68.google.com with SMTP id h15so20664487wrx.9
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QYNQt1WaGJQ+2y8XTtnEUasMCrE2jGufKrL8Aa73y2c=;
        b=ZSxGV/jtj6aDJ7VAy30hcJFvV0Qy34HyhdU48wcIwbH9rY46OqhIA6uNb5NyPumwn/
         gALnXwPRi/Qgey4ykgNDb9+yyMyr+OCK+h/99ecUMP2LZLLrDZzCyirKSuYhEgYcLX59
         Ilu9RcZyL1reXo0HC/icvO+xRa+CncvXFNaJd7kh4bPIldcn2R7Wkf4ShMMDXndyEUs5
         B4mCFF/3be5fqnXMfC8+/Fm+4kBH0dn1RIQ+7tRYvR9TmP+nj446otZmx9CTyfPXrO7U
         sTe97sEEJh+dLwVPu3bggg9lqaVJIR5wy7yWB2lep2wj4eGSnu3cT5pL9yQpf3LVcJDL
         brsw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 03/10] arm: meson-gx: add board_usb_init()/cleanup() for USB gadget
Date: Mon, 30 Mar 2020 11:27:25 +0200
Message-Id: <20200330092732.7198-4-narmstrong@baylibre.com>
In-Reply-To: <20200330092732.7198-1-narmstrong@baylibre.com>
References: <20200330092732.7198-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add arch code to initialize USB Gadget mode using the DWC2 controller,
and using the previously added set_mode() phy functions.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-gx.c | 118 +++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index 191fd49005..1a7e102c38 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
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
@@ -149,3 +154,116 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 	/* Enable power gate */
 	clrbits_le32(GX_MEM_PD_REG_0, GX_MEM_PD_REG_0_ETH_MASK);
 }
+
+#if CONFIG_IS_ENABLED(USB_XHCI_DWC3_OF_SIMPLE) && \
+	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
+static struct dwc2_plat_otg_data meson_gx_dwc2_data;
+static struct phy usb_phys[2];
+
+int board_usb_init(int index, enum usb_init_type init)
+{
+	struct ofnode_phandle_args args;
+	struct udevice *clk_dev;
+	ofnode dwc2_node;
+	struct clk clk;
+	int ret, i;
+	u32 val;
+
+	/* find the dwc2 node */
+	dwc2_node = ofnode_by_compatible(ofnode_null(), "snps,dwc2");
+	if (!ofnode_valid(dwc2_node)) {
+		debug("Not found dwc2 node\n");
+		return -ENODEV;
+	}
+
+	if (!ofnode_is_available(dwc2_node)) {
+		debug("dwc2 is disabled in the device tree\n");
+		return -ENODEV;
+	}
+
+	/* get the PHYs */
+	for (i = 0; i < 2; i++) {
+		ret = generic_phy_get_by_node(dwc2_node, i, &usb_phys[i]);
+		if (ret && ret != -ENOENT) {
+			pr_err("Failed to get USB PHY%d for %s\n",
+			       i, ofnode_get_name(dwc2_node));
+			return ret;
+		}
+	}
+
+	for (i = 0; i < 2; i++) {
+		ret = generic_phy_init(&usb_phys[i]);
+		if (ret) {
+			pr_err("Can't init USB PHY%d for %s\n",
+			       i, ofnode_get_name(dwc2_node));
+			return ret;
+		}
+	}
+
+	for (i = 0; i < 2; i++) {
+		ret = generic_phy_power_on(&usb_phys[i]);
+		if (ret) {
+			pr_err("Can't power USB PHY%d for %s\n",
+			       i, ofnode_get_name(dwc2_node));
+			return ret;
+		}
+	}
+
+	phy_meson_gxl_usb3_set_mode(&usb_phys[0], USB_DR_MODE_PERIPHERAL);
+	phy_meson_gxl_usb2_set_mode(&usb_phys[1], USB_DR_MODE_PERIPHERAL);
+
+	meson_gx_dwc2_data.regs_otg = ofnode_get_addr(dwc2_node);
+	if (meson_gx_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
+		debug("usbotg: can't get base address\n");
+		return -ENODATA;
+	}
+
+	/* Enable clock */
+	ret = ofnode_parse_phandle_with_args(dwc2_node, "clocks",
+					     "#clock-cells", 0, 0, &args);
+	if (ret) {
+		debug("usbotg has no clocks defined in the device tree\n");
+		return ret;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_CLK, args.node, &clk_dev);
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
+	ofnode_read_u32(dwc2_node, "g-rx-fifo-size", &val);
+	meson_gx_dwc2_data.rx_fifo_sz = val;
+	ofnode_read_u32(dwc2_node, "g-np-tx-fifo-size", &val);
+	meson_gx_dwc2_data.np_tx_fifo_sz = val;
+	ofnode_read_u32(dwc2_node, "g-tx-fifo-size", &val);
+	meson_gx_dwc2_data.tx_fifo_sz = val;
+
+	return dwc2_udc_probe(&meson_gx_dwc2_data);
+}
+
+int board_usb_cleanup(int index, enum usb_init_type init)
+{
+	int i;
+
+	phy_meson_gxl_usb3_set_mode(&usb_phys[0], USB_DR_MODE_HOST);
+	phy_meson_gxl_usb3_set_mode(&usb_phys[1], USB_DR_MODE_HOST);
+
+	for (i = 0; i < 2; i++)
+		usb_phys[i].dev = NULL;
+
+	return 0;
+}
+#endif
-- 
2.22.0

