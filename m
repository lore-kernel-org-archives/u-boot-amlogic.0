Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.9020.1600421359515335560
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Sep 2020 02:29:19 -0700
Received: by mail-wr1-f66.google.com with SMTP id s12so4881311wrw.11
        for <u-boot-amlogic@groups.io>; Fri, 18 Sep 2020 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/B/TiaE/nrNWbaq6WXTbxIQxiUoB6ABp6srambL22Q=;
        b=XGkw8bBNKhSio0dn5Ok4vCTDEP+L7+iWkRjJWEe6VY+xmHFJKH6m6TvTNUrXRz0Koh
         8msVdJQvRwO+9mnNNrPNpGyuctMMBwsP6///GQIEZHD1EcDsrH7rENXOWICJNXyEv6cP
         +pVtcOQEn996o4FkntGtFXyQVeBiRMYKrAsAtj/IfoegueyByJ1iRy75jmHeCKFjsFTH
         IhESc3jpuog/kS2AnM3VEF+uJG7JmrTL5G8gWs9aiw4dNvkPVBM6i/91pk7sjKr5HZLS
         t1XO3XFL1WYhK7/6IBrJftKlSdNAccUFi9oGBJlbC8557Ek+iQmT2gQw5r3xBvqsmCNO
         cF+Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/4] board: amlogic: vim3: add support for dynamic PCIe enable
Date: Fri, 18 Sep 2020 11:29:02 +0200
Message-Id: <20200918092902.28028-5-narmstrong@baylibre.com>
In-Reply-To: <20200918092902.28028-1-narmstrong@baylibre.com>
References: <20200918092902.28028-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, khilman@baylibre.com, nick@khadas.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
an USB3.0 Type A connector and a M.2 Key M slot.
The PHY driving these differential lines is shared between
the USB3.0 controller and the PCIe Controller, thus only
a single controller can use it.

This adds this dynamic switching right before booting Linux.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/vim3/vim3.c      | 116 +++++++++++++++++++++++++++++++++
 configs/khadas-vim3_defconfig  |   3 +
 configs/khadas-vim3l_defconfig |   3 +
 3 files changed, 122 insertions(+)

diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 02d8cd0ce0..cf730fa0d1 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -11,6 +11,122 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/eth.h>
+#include <i2c.h>
+#include "khadas-mcu.h"
+
+/*
+ * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
+ * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
+ * an USB3.0 Type A connector and a M.2 Key M slot.
+ * The PHY driving these differential lines is shared between
+ * the USB3.0 controller and the PCIe Controller, thus only
+ * a single controller can use it.
+ */
+int meson_ft_board_setup(void *blob, struct bd_info *bd)
+{
+	struct udevice *bus, *dev;
+	int node, i2c_node, ret;
+	unsigned int i2c_addr;
+	u32 *val;
+
+	/* Find I2C device */
+	node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "khadas,mcu");
+	if (node < 0) {
+		printf("vim3: cannot find khadas,mcu node\n");
+		return 0;
+	}
+
+	/* Get addr */
+	val = (u32 *)fdt_getprop(gd->fdt_blob, node, "reg", NULL);
+	if (!val) {
+		printf("vim3: cannot find khadas,mcu node i2c addr\n");
+		return 0;
+	}
+	i2c_addr = fdt32_to_cpu(*val);
+
+	/* Get i2c device */
+	i2c_node = fdt_parent_offset(gd->fdt_blob, node);
+	if (node < 0) {
+		printf("vim3: cannot find khadas,mcu i2c node\n");
+		return 0;
+	}
+
+	ret = uclass_get_device_by_of_offset(UCLASS_I2C, i2c_node, &bus);
+	if (ret < 0) {
+		printf("vim3: cannot find i2c bus (%d)\n", ret);
+		return 0;
+	}
+
+	ret = i2c_get_chip(bus, i2c_addr, 1, &dev);
+	if (ret < 0) {
+		printf("vim3: cannot find i2c chip (%d)\n", ret);
+		return 0;
+	}
+
+	/* Read USB_PCIE_SWITCH_REG */
+	ret = dm_i2c_reg_read(dev, KHADAS_MCU_USB_PCIE_SWITCH_REG);
+	if (ret < 0) {
+		printf("vim3: failed to read i2c reg (%d)\n", ret);
+		return 0;
+	}
+	debug("MCU_USB_PCIE_SWITCH_REG: %d\n", ret);
+
+	/*
+	 * If in PCIe mode, alter DT
+	 * 0：Enable USB3.0，Disable PCIE, 1：Disable USB3.0, Enable PCIE
+	 */
+	if (ret > 0) {
+		static char data[32] __aligned(4);
+		const void *ptmp;
+		int len;
+
+		/* Find USB node */
+		node = fdt_node_offset_by_compatible(blob, -1, "amlogic,meson-g12a-usb-ctrl");
+		if (node < 0) {
+			printf("vim3: cannot find amlogic,meson-g12a-usb-ctrl node\n");
+			return 0;
+		}
+
+		/* Update PHY names (mandatory to disable USB3.0) */
+		len = strlcpy(data, "usb2-phy0", 32) + 1;
+		len += strlcpy(&data[len], "usb2-phy1", 32 - len) + 1;
+		ret = fdt_setprop(blob, node, "phy-names", data, len);
+		if (ret < 0) {
+			printf("vim3: failed to update usb phy names property (%d)\n", ret);
+			return 0;
+		}
+
+		/* Update PHY list, by keeping the 2 first entries (optional) */
+		ptmp = fdt_getprop(blob, node, "phys", &len);
+		if (ptmp) {
+			memcpy(data, ptmp, min(2 * sizeof(u32), len));
+
+			ret = fdt_setprop(blob, node, "phys", data, min(2 * sizeof(u32), len));
+			if (ret < 0)
+				printf("vim3: failed to update usb phys property (%d)\n", ret);
+		} else
+			printf("vim3: cannot find usb node phys property\n");
+
+		/* Find PCIe node */
+		node = fdt_node_offset_by_compatible(blob, -1, "amlogic,g12a-pcie");
+		if (node < 0) {
+			printf("vim3: cannot find amlogic,g12a-pcie node\n");
+			return 0;
+		}
+
+		/* Enable PCIe */
+		len = strlcpy(data, "okay", 32);
+		ret = fdt_setprop(blob, node, "status", data, len);
+		if (ret < 0) {
+			printf("vim3: failed to enable pcie node (%d)\n", ret);
+			return 0;
+		}
+
+		printf("vim3: successfully enabled PCIe\n");
+	}
+
+	return 0;
+}
 
 int misc_init_r(void)
 {
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index ee5990426d..df2d5bda5b 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -17,6 +17,7 @@ CONFIG_MISC_INIT_R=y
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
@@ -28,6 +29,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 5729d339e9..39e74c3ccb 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -17,6 +17,7 @@ CONFIG_MISC_INIT_R=y
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
@@ -28,6 +29,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
-- 
2.22.0

