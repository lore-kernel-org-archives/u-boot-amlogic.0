Received: by mail-wm1-f67.google.com with SMTP id z11so13162464wmi.0
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mggUSjmXFXGcVUCUiWN0uenJecDUdG1SsbVKs0JHcU=;
        b=I2uKvZk1EFPXMReOBEowIh5rYjmgxTOgnRkBAqXhkWn4eXlzT7MPelKx2gjOQFqPJ0
         VGrpM7vIrhLyAMrYwQpm7SckyvloxE6y61nC//Qovy1nBUTfza2dOk0bAd1ibNvfvWny
         Cy7JSq+C9pfNfWP8NHVajpzDTtbg4kVtsUbJhMTlu3PR5MH2WDUg456d+jOl4QXWwaga
         SDoa7xdnoIY2yMdS1loZoCQNZexsHe1rZ4dzVA3nZy+lzzH5LJdDgzYp8SApq/9BhaUy
         VU0RAj/dIPsCqacSWqhWqgFNkQzJrgcuSPKMHZMmaztVUZu/k0D9YA8gWLSWbhHUUKpg
         zMBA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/3] mach-meson: g12a: add DWC2 peripheral mode support
Date: Tue, 26 Mar 2019 16:15:37 +0100
Message-Id: <20190326151537.23118-4-narmstrong@baylibre.com>
In-Reply-To: <20190326151537.23118-1-narmstrong@baylibre.com>
References: <20190326151537.23118-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Adds support for Amlogic G12A USB Device mode.

The DWC2 Controller behind the Glue can be connected to an OTG
capable PHY. The Glue setups the PHY mode.

This patch implements Device mode support by adding a board_usb_init/cleanup
setting up the DWC2 controller and switch the OTG capable port to Device
before starting the DWC2 controller in Device mode.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/usb.h |  12 +++
 arch/arm/mach-meson/board-g12a.c      | 126 ++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/usb.h

diff --git a/arch/arm/include/asm/arch-meson/usb.h b/arch/arm/include/asm/arch-meson/usb.h
new file mode 100644
index 0000000000..b794b5ce77
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/usb.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef __MESON_USB_H__
+#define __MESON_USB_H__
+
+int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode);
+
+#endif /* __MESON_USB_H__ */
diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index fc3764b960..1652970fbd 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -12,7 +12,12 @@
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
+#include <usb.h>
+#include <linux/usb/otg.h>
+#include <asm/arch/usb.h>
+#include <usb/dwc2_udc.h>
 #include <phy.h>
+#include <clk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -148,3 +153,124 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 	/* Enable power gate */
 	clrbits_le32(G12A_MEM_PD_REG_0, G12A_MEM_PD_REG_0_ETH_MASK);
 }
+
+#if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
+	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
+static struct dwc2_plat_otg_data meson_g12a_dwc2_data;
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
+					     "amlogic,meson-g12a-usb-ctrl");
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
+	meson_g12a_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
+	if (meson_g12a_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
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
+	meson_g12a_dwc2_data.rx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+						     "g-rx-fifo-size", 0);
+	meson_g12a_dwc2_data.np_tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+							"g-np-tx-fifo-size", 0);
+	meson_g12a_dwc2_data.tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
+						     "g-tx-fifo-size", 0);
+
+	/* Switch to peripheral mode */
+	ret = dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_PERIPHERAL);
+	if (ret)
+		return ret;
+
+	return dwc2_udc_probe(&meson_g12a_dwc2_data);
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
+					     "amlogic,meson-g12a-usb-ctrl");
+	if (node < 0)
+		return -ENODEV;
+
+	if (!fdtdec_get_is_enabled(blob, node))
+		return -ENODEV;
+
+	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
+	if (ret)
+		return ret;
+
+	/* Switch to OTG mode */
+	ret = dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_HOST);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+#endif
-- 
2.21.0

