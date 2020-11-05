Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.7920.1604585751470945869
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Nov 2020 06:15:51 -0800
Received: by mail-wr1-f66.google.com with SMTP id a3so1792420wrx.13
        for <u-boot-amlogic@groups.io>; Thu, 05 Nov 2020 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sCGQvFU/zZ7HtTPj3BQOLLF5V4fF1rtuL7B/tbn9Vc=;
        b=qaz+WPGHYv25sOb916Xk5AIESWE6MkHweK9qlPHPrCx2CSenuNVk3oJSa9llBtm0G8
         CNpfi7ALVBi/653pMjy1L/SWRE+yv2rzn8tzz8JPJkKwOCzNgafPUlxyWQXrAWCYUH0h
         JtEmcaiNgHzH0mjLdmBP6RzZDIL+EGfS9cv0QrA65/U0bO1D2Bm51PhYkD71tUNAyfgl
         2w+oFA6J35B4R7XggmtuFjjw4FLl5FZlRcWxP/US0l+WM15pI+3+STi2xiMnRnIvl0Ch
         grXYR/2+HIf9kLoJMobdb3i+m8Bi60fRXu7E8XuK9yVehwwJ3YWbw5asT6tBPp2gsWsq
         dZ1Q==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/2] arm64: meson: add support for libretech-cc v2
Date: Thu,  5 Nov 2020 15:15:29 +0100
Message-Id: <20201105141529.666149-3-jbrunet@baylibre.com>
In-Reply-To: <20201105141529.666149-1-jbrunet@baylibre.com>
References: <20201105141529.666149-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@libre.computer>
List-ID: <u-boot-amlogic@groups.io>

Add support for the Amlogic based libretech cc version 2.
As version 1, it is based on the s905x SoC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/dts/Makefile                         |  1 +
 ...eson-gxl-s905x-libretech-cc-v2-u-boot.dtsi |  7 ++
 configs/libretech-cc_v2_defconfig             | 82 +++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
 create mode 100644 configs/libretech-cc_v2_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b195723f1645..e957820e8e62 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -159,6 +159,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-gxl-s905x-p212.dtb \
 	meson-gxl-s805x-libretech-ac.dtb \
 	meson-gxl-s905x-libretech-cc.dtb \
+	meson-gxl-s905x-libretech-cc-v2.dtb \
 	meson-gxl-s905x-khadas-vim.dtb \
 	meson-gxl-s905d-libretech-pc.dtb \
 	meson-gxm-khadas-vim2.dtb \
diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
new file mode 100644
index 000000000000..8ff5a0ef2ba5
--- /dev/null
+++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include "meson-gxl-u-boot.dtsi"
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
new file mode 100644
index 000000000000..e71f88edaec6
--- /dev/null
+++ b/configs/libretech-cc_v2_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0xFFFF0000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_MESON_GXL=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" libretech-cc-v2"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="usb start"
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-libretech-cc-v2"
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_DM_KEYBOARD=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ADDR=8
+CONFIG_PHY_MESON_GXL=y
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
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.28.0

