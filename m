Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.10932.1583406778349022181
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Mar 2020 03:12:58 -0800
Received: by mail-wm1-f68.google.com with SMTP id 6so5805444wmi.5
        for <u-boot-amlogic@groups.io>; Thu, 05 Mar 2020 03:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUjkgVLFVyQzHZMTj/jw+yntrWDgaa6T8W/juUSakNM=;
        b=ltluy0GRvndiFAVQsVHJ1q4Nae55DkraUC3xwI1rrT8CIqE3XUHC6fr6D/q5uHozfE
         iXgwz1DZowQGH59EZ4nCfoPdx2l18gdU1ZxQ9hk3+8H9l25nYSNX6hEYKB0S+sqfZ3iz
         C0nNGklNmz7ETwNHAG2ybmnVquMJLpeCgNKhQUYN6dq5c9G3asjd23aTs5AqFARjGo6/
         3qv4DANFNx3BDkH2WrqsuFGypu5tXAMJG+U5/iHC7HcHxZo0TebqOCDZM7A9+yoOumhw
         Lv9IVbU7fQGbx7U9icB8RjNMBNzES9DSqCH+TXMqVPy0mWMMA6kQSb8u1tBo03x2p6/m
         3ZIw==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 6/6] arm64: dts: meson: add libretech-pc support
Date: Thu,  5 Mar 2020 12:12:40 +0100
Message-Id: <20200305111240.129010-7-jbrunet@baylibre.com>
In-Reply-To: <20200305111240.129010-1-jbrunet@baylibre.com>
References: <20200305111240.129010-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for the Amlogic based libretech-pc platform.
This platform comes with 2 variant, based on the s905d or s912 SoC.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/dts/Makefile                         |  2 +
 .../meson-gxl-s905d-libretech-pc-u-boot.dtsi  |  7 ++
 .../meson-gxm-s912-libretech-pc-u-boot.dtsi   |  7 ++
 configs/libretech-s905d-pc_defconfig          | 73 +++++++++++++++++++
 configs/libretech-s912-pc_defconfig           | 73 +++++++++++++++++++
 5 files changed, 162 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
 create mode 100644 configs/libretech-s905d-pc_defconfig
 create mode 100644 configs/libretech-s912-pc_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 9c593b2c986a..cfe1b7849f46 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -147,7 +147,9 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-gxl-s805x-libretech-ac.dtb \
 	meson-gxl-s905x-libretech-cc.dtb \
 	meson-gxl-s905x-khadas-vim.dtb \
+	meson-gxl-s905d-libretech-pc.dtb \
 	meson-gxm-khadas-vim2.dtb \
+	meson-gxm-s912-libretech-pc.dtb \
 	meson-axg-s400.dtb \
 	meson-g12a-u200.dtb \
 	meson-g12a-sei510.dtb \
diff --git a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
new file mode 100644
index 000000000000..c35158d7e9ee
--- /dev/null
+++ b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
new file mode 100644
index 000000000000..c35158d7e9ee
--- /dev/null
+++ b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
new file mode 100644
index 000000000000..7e0c95872a62
--- /dev/null
+++ b/configs/libretech-s905d-pc_defconfig
@@ -0,0 +1,73 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="q200"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_GXL=y
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xFFFF0000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_IDENT_STRING=" libretech-s905d-pc"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="usb start"
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905d-libretech-pc"
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_KEYBOARD=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_PHY=y
+CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXL=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_DM_VIDEO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
new file mode 100644
index 000000000000..5f4ee329e276
--- /dev/null
+++ b/configs/libretech-s912-pc_defconfig
@@ -0,0 +1,73 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="q200"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_GXM=y
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xFFFF0000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_IDENT_STRING=" libretech-s912-pc"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="usb start"
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-s912-libretech-pc"
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_KEYBOARD=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_PHY=y
+CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXL=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_DM_VIDEO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.24.1

