Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.9496.1631864242483410351
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Sep 2021 00:37:22 -0700
Received: by mail-wm1-f45.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so2845153wmj.3
        for <u-boot-amlogic@groups.io>; Fri, 17 Sep 2021 00:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ija7go++JdZdt7PJ+31MN/9qT2e81Xggn52oE/2Sahc=;
        b=Q98ENKuYXdhOiMD5RJEbbsFnV4GDwbQd3/XRcJMukvznrZi1kWMpFkDchOsHmVpLMj
         +ryErr3oODuuNlguh8EMAAEfDNg/F1dut1Z4E82KBD3dy49m6DRR+3/vToLdCxn5Qv0l
         Xs2CqWLJeqZf/GpW+MfM1oWgLu9Te7udXaLFbp5HnkArr2/tGAXUmv3p6TxBszFCHgP8
         o5R7g4/XBT9qBj4PtXdzCkceIKmdWuQ/Bwg3FhNZeDMRo8tXG5GA06ltEHJ8ThXDJ5yq
         pUdVOjotkEc/AFqcQwEbHuxlfGriyCJOc2cT3e2JUSMUcfzc+heIptxKS6fBhGQ6xFYd
         VmZw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 10/10] ARM: amlogic: add Banana Pi M5
Date: Fri, 17 Sep 2021 09:37:09 +0200
Message-Id: <20210917073709.1052133-10-narmstrong@baylibre.com>
In-Reply-To: <20210917073709.1052133-1-narmstrong@baylibre.com>
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Banana Pi BPI-M5 is a credit card format SBC with the following features:
- Amlogic S905X3 quad core Cortex-A55
- Mali-G31 GPU
- 4GB LPDDR4
- 16GB eMMC flash
- 4 USB 3.0
- 1 GbE ethernet
- HDMI output
- 2x LEDS
- SDCard
- 2.5mm Jack with Stereo Audio + CVBS
- Infrared Received
- ADC Button
- GPIO Button
- 40 pins header + 3pins debug header

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../arm/dts/meson-sm1-bananapi-m5-u-boot.dtsi | 13 ++++
 board/amlogic/u200/MAINTAINERS                |  1 +
 configs/bananapi-m5_defconfig                 | 73 +++++++++++++++++++
 doc/board/amlogic/index.rst                   |  1 +
 4 files changed, 88 insertions(+)
 create mode 100644 arch/arm/dts/meson-sm1-bananapi-m5-u-boot.dtsi
 create mode 100644 configs/bananapi-m5_defconfig

diff --git a/arch/arm/dts/meson-sm1-bananapi-m5-u-boot.dtsi b/arch/arm/dts/meson-sm1-bananapi-m5-u-boot.dtsi
new file mode 100644
index 0000000000..a86fdb5668
--- /dev/null
+++ b/arch/arm/dts/meson-sm1-bananapi-m5-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-sm1-u-boot.dtsi"
+
+&ethmac {
+	snps,reset-gpio = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
index 8c23f9a7d3..655cf64a3d 100644
--- a/board/amlogic/u200/MAINTAINERS
+++ b/board/amlogic/u200/MAINTAINERS
@@ -4,4 +4,5 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/u200/
 F:	configs/u200_defconfig
+F:	configs/bananapi-m5_defconfig
 F:	doc/board/amlogic/u200.rst
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
new file mode 100644
index 0000000000..a088761622
--- /dev/null
+++ b/configs/bananapi-m5_defconfig
@@ -0,0 +1,73 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m5"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING="bpi-m5"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_VIDEO_BMP_RLE8=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index de1a9ce284..2913ab281a 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -19,6 +19,7 @@ This matrix concerns the actual source code version.
 |        			| Nanopi-K2 | Khadas-VIM      | Libretech-PC |	          | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
 |        			| P200	    | LibreTech-CC v1 |	WeTek Core2  |	          |            | GT-King/Pro | Odroid-C4    |
 |        			| P201	    | LibreTech-AC v2 |	             |	          |            | GSKing-X    | Odroid-HC4   |
+|                               |           |                 |              |            |            |             | BananaPi-M5  |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
 | UART                       	| **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
-- 
2.25.1

