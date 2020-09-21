Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.36833.1600673669926349894
 for <u-boot-amlogic@groups.io>;
 Mon, 21 Sep 2020 00:34:30 -0700
Received: by mail-wm1-f54.google.com with SMTP id k18so11449320wmj.5
        for <u-boot-amlogic@groups.io>; Mon, 21 Sep 2020 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqQJ/CMuc8Q/BfgWs3EViWsYcozCg54AiqA7BKxqES4=;
        b=bp5/VDNN6oBul1aJCBs37eDCDTsRBRHnlsLuOBXaoYGSCbfnScIpOPtwX9T12HEiuf
         9kzabadnCzCyzWhplVyYQXJzD3hTgJfuxihXDZ4Dck9WdEa3C3jyh84Q8zwUFZ6Of9eE
         HSkeDfXx4bU5w584XgQcfgast9ag3NooBWnT1OSRKNh2U+cCMn8Cxphl4p2KsNQGyn1G
         Gphj+6bKWJ2fVxvA5d2teeodnBd3DoA2Lx7E7INwKjN7dWIt7Y5i4LXKOZZ0JNbP1FnE
         vW3f5GjnFJxQfW6e+BzIddJxW+m2UZ7vZ10HT0avmq7Oi5RaJAKhf7kJw4u8CIoJt1PX
         OSQw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 4/4] board: amlogic: vim3: add support for dynamic PCIe enable
Date: Mon, 21 Sep 2020 09:34:15 +0200
Message-Id: <20200921073415.24211-5-narmstrong@baylibre.com>
In-Reply-To: <20200921073415.24211-1-narmstrong@baylibre.com>
References: <20200921073415.24211-1-narmstrong@baylibre.com>
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

This adds this dynamic switching right before booting Linux
and the configuration steps in the boards documentation.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 board/amlogic/vim3/khadas-mcu.h    |  81 ++++++++++++++++++++
 board/amlogic/vim3/vim3.c          | 116 +++++++++++++++++++++++++++++
 configs/khadas-vim3_defconfig      |   3 +
 configs/khadas-vim3l_defconfig     |   3 +
 doc/board/amlogic/khadas-vim3.rst  |  27 +++++++
 doc/board/amlogic/khadas-vim3l.rst |  27 +++++++
 6 files changed, 257 insertions(+)
 create mode 100644 board/amlogic/vim3/khadas-mcu.h

diff --git a/board/amlogic/vim3/khadas-mcu.h b/board/amlogic/vim3/khadas-mcu.h
new file mode 100644
index 0000000000..de3758cafe
--- /dev/null
+++ b/board/amlogic/vim3/khadas-mcu.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Khadas System control Microcontroller Register map
+ *
+ * Copyright (C) 2020 BayLibre SAS
+ *
+ * Author(s): Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef MFD_KHADAS_MCU_H
+#define MFD_KHADAS_MCU_H
+
+#define KHADAS_MCU_PASSWD_VEN_0_REG		0x00 /* RO */
+#define KHADAS_MCU_PASSWD_VEN_1_REG		0x01 /* RO */
+#define KHADAS_MCU_PASSWD_VEN_2_REG		0x02 /* RO */
+#define KHADAS_MCU_PASSWD_VEN_3_REG		0x03 /* RO */
+#define KHADAS_MCU_PASSWD_VEN_4_REG		0x04 /* RO */
+#define KHADAS_MCU_PASSWD_VEN_5_REG		0x05 /* RO */
+#define KHADAS_MCU_MAC_0_REG			0x06 /* RO */
+#define KHADAS_MCU_MAC_1_REG			0x07 /* RO */
+#define KHADAS_MCU_MAC_2_REG			0x08 /* RO */
+#define KHADAS_MCU_MAC_3_REG			0x09 /* RO */
+#define KHADAS_MCU_MAC_4_REG			0x0a /* RO */
+#define KHADAS_MCU_MAC_5_REG			0x0b /* RO */
+#define KHADAS_MCU_USID_0_REG			0x0c /* RO */
+#define KHADAS_MCU_USID_1_REG			0x0d /* RO */
+#define KHADAS_MCU_USID_2_REG			0x0e /* RO */
+#define KHADAS_MCU_USID_3_REG			0x0f /* RO */
+#define KHADAS_MCU_USID_4_REG			0x10 /* RO */
+#define KHADAS_MCU_USID_5_REG			0x11 /* RO */
+#define KHADAS_MCU_VERSION_0_REG		0x12 /* RO */
+#define KHADAS_MCU_VERSION_1_REG		0x13 /* RO */
+#define KHADAS_MCU_DEVICE_NO_0_REG		0x14 /* RO */
+#define KHADAS_MCU_DEVICE_NO_1_REG		0x15 /* RO */
+#define KHADAS_MCU_FACTORY_TEST_REG		0x16 /* R */
+#define KHADAS_MCU_BOOT_MODE_REG		0x20 /* RW */
+#define KHADAS_MCU_BOOT_EN_WOL_REG		0x21 /* RW */
+#define KHADAS_MCU_BOOT_EN_RTC_REG		0x22 /* RW */
+#define KHADAS_MCU_BOOT_EN_EXP_REG		0x23 /* RW */
+#define KHADAS_MCU_BOOT_EN_IR_REG		0x24 /* RW */
+#define KHADAS_MCU_BOOT_EN_DCIN_REG		0x25 /* RW */
+#define KHADAS_MCU_BOOT_EN_KEY_REG		0x26 /* RW */
+#define KHADAS_MCU_KEY_MODE_REG			0x27 /* RW */
+#define KHADAS_MCU_LED_MODE_ON_REG		0x28 /* RW */
+#define KHADAS_MCU_LED_MODE_OFF_REG		0x29 /* RW */
+#define KHADAS_MCU_SHUTDOWN_NORMAL_REG		0x2c /* RW */
+#define KHADAS_MCU_MAC_SWITCH_REG		0x2d /* RW */
+#define KHADAS_MCU_MCU_SLEEP_MODE_REG		0x2e /* RW */
+#define KHADAS_MCU_IR_CODE1_0_REG		0x2f /* RW */
+#define KHADAS_MCU_IR_CODE1_1_REG		0x30 /* RW */
+#define KHADAS_MCU_IR_CODE1_2_REG		0x31 /* RW */
+#define KHADAS_MCU_IR_CODE1_3_REG		0x32 /* RW */
+#define KHADAS_MCU_USB_PCIE_SWITCH_REG		0x33 /* RW */
+#define KHADAS_MCU_IR_CODE2_0_REG		0x34 /* RW */
+#define KHADAS_MCU_IR_CODE2_1_REG		0x35 /* RW */
+#define KHADAS_MCU_IR_CODE2_2_REG		0x36 /* RW */
+#define KHADAS_MCU_IR_CODE2_3_REG		0x37 /* RW */
+#define KHADAS_MCU_PASSWD_USER_0_REG		0x40 /* RW */
+#define KHADAS_MCU_PASSWD_USER_1_REG		0x41 /* RW */
+#define KHADAS_MCU_PASSWD_USER_2_REG		0x42 /* RW */
+#define KHADAS_MCU_PASSWD_USER_3_REG		0x43 /* RW */
+#define KHADAS_MCU_PASSWD_USER_4_REG		0x44 /* RW */
+#define KHADAS_MCU_PASSWD_USER_5_REG		0x45 /* RW */
+#define KHADAS_MCU_USER_DATA_0_REG		0x46 /* RW 56 bytes */
+#define KHADAS_MCU_PWR_OFF_CMD_REG		0x80 /* WO */
+#define KHADAS_MCU_PASSWD_START_REG		0x81 /* WO */
+#define KHADAS_MCU_CHECK_VEN_PASSWD_REG		0x82 /* WO */
+#define KHADAS_MCU_CHECK_USER_PASSWD_REG	0x83 /* WO */
+#define KHADAS_MCU_SHUTDOWN_NORMAL_STATUS_REG	0x86 /* RO */
+#define KHADAS_MCU_WOL_INIT_START_REG		0x87 /* WO */
+#define KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG	0x88 /* WO */
+
+enum {
+	KHADAS_BOARD_VIM1 = 0x1,
+	KHADAS_BOARD_VIM2,
+	KHADAS_BOARD_VIM3,
+	KHADAS_BOARD_EDGE = 0x11,
+	KHADAS_BOARD_EDGE_V,
+};
+
+#endif /* MFD_KHADAS_MCU_H */
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
diff --git a/doc/board/amlogic/khadas-vim3.rst b/doc/board/amlogic/khadas-vim3.rst
index c1c03212d2..d6a9642ad6 100644
--- a/doc/board/amlogic/khadas-vim3.rst
+++ b/doc/board/amlogic/khadas-vim3.rst
@@ -18,6 +18,33 @@ Technology Co., Ltd. with the following specifications:
 
 Schematics are available on the manufacturer website.
 
+PCIe Setup
+----------
+The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
+lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
+an USB3.0 Type A connector and a M.2 Key M slot.
+The PHY driving these differential lines is shared between
+the USB3.0 controller and the PCIe Controller, thus only
+a single controller can use it.
+
+To setup for PCIe, run the following commands from U-Boot:
+
+.. code-block:: none
+
+    i2c dev i2c@5000
+    i2c mw 0x18 0x33 1
+
+Then power-cycle the board.
+
+To set back to USB3.0, run the following commands from U-Boot:
+
+.. code-block:: none
+
+    i2c dev i2c@5000
+    i2c mw 0x18 0x33 0
+
+Then power-cycle the board.
+
 U-Boot compilation
 ------------------
 
diff --git a/doc/board/amlogic/khadas-vim3l.rst b/doc/board/amlogic/khadas-vim3l.rst
index b380c17456..3c0a415a87 100644
--- a/doc/board/amlogic/khadas-vim3l.rst
+++ b/doc/board/amlogic/khadas-vim3l.rst
@@ -18,6 +18,33 @@ Technology Co., Ltd. with the following specifications:
 
 Schematics are available on the manufacturer website.
 
+PCIe Setup
+----------
+The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
+lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
+an USB3.0 Type A connector and a M.2 Key M slot.
+The PHY driving these differential lines is shared between
+the USB3.0 controller and the PCIe Controller, thus only
+a single controller can use it.
+
+To setup for PCIe, run the following commands from U-Boot:
+
+.. code-block:: none
+
+    i2c dev i2c@5000
+    i2c mw 0x18 0x33 1
+
+Then power-cycle the board.
+
+To set back to USB3.0, run the following commands from U-Boot:
+
+.. code-block:: none
+
+    i2c dev i2c@5000
+    i2c mw 0x18 0x33 0
+
+Then power-cycle the board.
+
 U-Boot compilation
 ------------------
 
-- 
2.22.0

