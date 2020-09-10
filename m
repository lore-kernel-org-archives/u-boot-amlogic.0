Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web10.17580.1599727711015251447
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 01:48:31 -0700
Received: by mail-wr1-f65.google.com with SMTP id z1so5777866wrt.3
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRPU5Zf/SOBuGSYJXKcFsi960RAhLhvM8/uxo9A7I0o=;
        b=OFl6+xkhefTh2Ipm93LWt2861qB0cpyKJC4QOsZ2YyoyfjIiLAWuGEeUOVepX31dtH
         lucvhiKdEGG/Z5LjyIbs5YCartwb44a1L1FpWQMzluV+ZoA/l7xwnA14IkEzNdV0xTZc
         dZWDdoq54w49QBpObV0N2hUCzrPHhzGN2qFbbTF1DWQG2FeQSo6RieXN21Dia9jgY+Lu
         k1YMl5rwqVIxq0FXtZFxBX1u6PubaIli0k2FYturr3eYIVq+1tNDzbZdoIJfkOlv+aXO
         +eotfYcyNQu/FN+lnESgygp+Rsa46YdZKfzITvrEPJKPAvpTEAi2XIIdGpu2bvcji3v9
         /4Eg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/8] ARM: mach-meson: use new DWC3 glue for GXL & GXM
Date: Thu, 10 Sep 2020 10:48:14 +0200
Message-Id: <20200910084819.25312-4-narmstrong@baylibre.com>
In-Reply-To: <20200910084819.25312-1-narmstrong@baylibre.com>
References: <20200910084819.25312-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Use the new Amlogic GXL/GXM USB Glue instead of the set of USB3 PHY
and Simple DWC3 wrapper.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-gx.c       | 127 +++++++++++++++------------
 configs/khadas-vim2_defconfig        |   2 +-
 configs/khadas-vim_defconfig         |   2 +-
 configs/libretech-ac_defconfig       |   2 +-
 configs/libretech-cc_defconfig       |   2 +-
 configs/libretech-s905d-pc_defconfig |   2 +-
 configs/libretech-s912-pc_defconfig  |   2 +-
 configs/p212_defconfig               |   2 +-
 8 files changed, 79 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index c4cc11f1de..7a0e703596 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -156,79 +156,70 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 	clrbits_le32(GX_MEM_PD_REG_0, GX_MEM_PD_REG_0_ETH_MASK);
 }
 
-#if CONFIG_IS_ENABLED(USB_XHCI_DWC3_OF_SIMPLE) && \
+#if CONFIG_IS_ENABLED(USB_DWC3_MESON_GXL) && \
 	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
 static struct dwc2_plat_otg_data meson_gx_dwc2_data;
-static struct phy usb_phys[2];
 
 int board_usb_init(int index, enum usb_init_type init)
 {
-	struct ofnode_phandle_args args;
-	struct udevice *clk_dev;
-	ofnode dwc2_node;
+	struct fdtdec_phandle_args args;
+	const void *blob = gd->fdt_blob;
+	int node, dwc2_node;
+	struct udevice *dev, *clk_dev;
 	struct clk clk;
-	int ret, i;
-	u32 val;
-
-	/* find the dwc2 node */
-	dwc2_node = ofnode_by_compatible(ofnode_null(), "snps,dwc2");
-	if (!ofnode_valid(dwc2_node)) {
-		debug("Not found dwc2 node\n");
-		return -ENODEV;
+	int ret;
+
+	/* find the usb glue node */
+	node = fdt_node_offset_by_compatible(blob, -1,
+					     "amlogic,meson-gxl-usb-ctrl");
+	if (node < 0) {
+		node = fdt_node_offset_by_compatible(blob, -1,
+					"amlogic,meson-gxm-usb-ctrl");
+		if (node < 0) {
+			debug("Not found usb-control node\n");
+			return -ENODEV;
+		}
 	}
 
-	if (!ofnode_is_available(dwc2_node)) {
-		debug("dwc2 is disabled in the device tree\n");
+	if (!fdtdec_get_is_enabled(blob, node)) {
+		debug("usb is disabled in the device tree\n");
 		return -ENODEV;
 	}
 
-	/* get the PHYs */
-	for (i = 0; i < 2; i++) {
-		ret = generic_phy_get_by_index_nodev(dwc2_node, i,
-						     &usb_phys[i]);
-		if (ret && ret != -ENOENT) {
-			pr_err("Failed to get USB PHY%d for %s\n",
-			       i, ofnode_get_name(dwc2_node));
-			return ret;
-		}
+	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
+	if (ret) {
+		debug("Not found usb-control device\n");
+		return ret;
 	}
 
-	for (i = 0; i < 2; i++) {
-		ret = generic_phy_init(&usb_phys[i]);
-		if (ret) {
-			pr_err("Can't init USB PHY%d for %s\n",
-			       i, ofnode_get_name(dwc2_node));
-			return ret;
-		}
+	/* find the dwc2 node */
+	dwc2_node = fdt_node_offset_by_compatible(blob, node,
+						  "amlogic,meson-g12a-usb");
+	if (dwc2_node < 0) {
+		debug("Not found dwc2 node\n");
+		return -ENODEV;
 	}
 
-	for (i = 0; i < 2; i++) {
-		ret = generic_phy_power_on(&usb_phys[i]);
-		if (ret) {
-			pr_err("Can't power USB PHY%d for %s\n",
-			       i, ofnode_get_name(dwc2_node));
-			return ret;
-		}
+	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
+		debug("dwc2 is disabled in the device tree\n");
+		return -ENODEV;
 	}
 
-	phy_meson_gxl_usb3_set_mode(&usb_phys[0], USB_DR_MODE_PERIPHERAL);
-	phy_meson_gxl_usb2_set_mode(&usb_phys[1], USB_DR_MODE_PERIPHERAL);
-
-	meson_gx_dwc2_data.regs_otg = ofnode_get_addr(dwc2_node);
+	meson_gx_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
 	if (meson_gx_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
 		debug("usbotg: can't get base address\n");
 		return -ENODATA;
 	}
 
 	/* Enable clock */
-	ret = ofnode_parse_phandle_with_args(dwc2_node, "clocks",
+	ret = fdtdec_parse_phandle_with_args(blob, dwc2_node, "clocks",
 					     "#clock-cells", 0, 0, &args);
 	if (ret) {
 		debug("usbotg has no clocks defined in the device tree\n");
 		return ret;
 	}
 
-	ret = uclass_get_device_by_ofnode(UCLASS_CLK, args.node, &clk_dev);
+	ret = uclass_get_device_by_of_offset(UCLASS_CLK, args.node, &clk_dev);
 	if (ret)
 		return ret;
 
@@ -246,25 +237,51 @@ int board_usb_init(int index, enum usb_init_type init)
 		return ret;
 	}
 
-	ofnode_read_u32(dwc2_node, "g-rx-fifo-size", &val);
-	meson_gx_dwc2_data.rx_fifo_sz = val;
-	ofnode_read_u32(dwc2_node, "g-np-tx-fifo-size", &val);
-	meson_gx_dwc2_data.np_tx_fifo_sz = val;
-	ofnode_read_u32(dwc2_node, "g-tx-fifo-size", &val);
-	meson_gx_dwc2_data.tx_fifo_sz = val;
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
 
 	return dwc2_udc_probe(&meson_gx_dwc2_data);
 }
 
 int board_usb_cleanup(int index, enum usb_init_type init)
 {
-	int i;
+	const void *blob = gd->fdt_blob;
+	struct udevice *dev;
+	int node;
+	int ret;
+
+	/* find the usb glue node */
+	node = fdt_node_offset_by_compatible(blob, -1,
+					     "amlogic,meson-gxl-usb-ctrl");
+	if (node < 0) {
+		node = fdt_node_offset_by_compatible(blob, -1,
+					"amlogic,meson-gxm-usb-ctrl");
+		if (node < 0) {
+			debug("Not found usb-control node\n");
+			return -ENODEV;
+		}
+	}
 
-	phy_meson_gxl_usb3_set_mode(&usb_phys[0], USB_DR_MODE_HOST);
-	phy_meson_gxl_usb2_set_mode(&usb_phys[1], USB_DR_MODE_HOST);
+	if (!fdtdec_get_is_enabled(blob, node))
+		return -ENODEV;
 
-	for (i = 0; i < 2; i++)
-		usb_phys[i].dev = NULL;
+	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
+	if (ret)
+		return ret;
+
+	/* Switch to OTG mode */
+	ret = dwc3_meson_gxl_force_mode(dev, USB_DR_MODE_HOST);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index b6d5dbdd2e..ac962e7199 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -41,6 +41,7 @@ CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_USB_DWC3_MESON_GXL=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_DM_REGULATOR_FIXED=y
@@ -55,7 +56,6 @@ CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_GADGET=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 2a57cfb400..be18c025e9 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -37,6 +37,7 @@ CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_USB_DWC3_MESON_GXL=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_DM_REGULATOR_FIXED=y
@@ -48,7 +49,6 @@ CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_GADGET=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index d5a812c3d8..d0690d47ae 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -49,6 +49,7 @@ CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_USB_DWC3_MESON_GXL=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
@@ -65,7 +66,6 @@ CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_KEYBOARD=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index dce861b8aa..4533cda013 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -36,6 +36,7 @@ CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_USB_DWC3_MESON_GXL=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
@@ -49,7 +50,6 @@ CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_GADGET=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index 225a21f0ff..0a32239e1d 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -44,6 +44,7 @@ CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_USB_DWC3_MESON_GXL=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
@@ -60,7 +61,6 @@ CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_KEYBOARD=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index 005dc0b25e..534b235ea9 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -43,6 +43,7 @@ CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_USB_DWC3_MESON_GXL=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
@@ -59,7 +60,6 @@ CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_KEYBOARD=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index 108b60889b..182321151a 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -34,6 +34,7 @@ CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_USB_DWC3_MESON_GXL=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_DM_REGULATOR=y
@@ -46,6 +47,5 @@ CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.22.0

