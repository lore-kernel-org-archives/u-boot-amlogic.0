Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.12109.1631110663986186696
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 07:17:44 -0700
Received: by mail-wm1-f44.google.com with SMTP id n14-20020a05600c3b8e00b002f8bd2f8ab6so1746929wms.5
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCefJ6s/vM8OPmdk2faay5HwW3Vzb1ppW4pbO9zrjI8=;
        b=OFhZbvozvgDHUpMTElLoEYpB0p0vi2A5aDM9K0Eoas0ZAiamrVn1TRpx//xYEFpg2o
         VI+1Kic3qj+O+ea+wv8JxqPzVd3ErRaJUxK63+YF3YxCm1V/p/CvvlgpeuoDBFNPlYnU
         0jcfVIubE8NdfkhaPj0x6g21nIzysnUDXr1743Dr3nAlB6ZQmWbHdPBSgjej1MbiyEr9
         mNQF+Wx0BYz/Y0Q+9Ej+Qu5JD1RZv6AZC73RH1Xd0USTWplatNxBJK92Fc71X/yc2upo
         iWb7RV2ax7DGlBqAgcQKEL/tgpLmcpaHQCUDkaXbToDe7EVt8c2p+Wxy8NBS9tP/Kctu
         CVew==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 8/9] ARM: meson: add Beelink GS-King X board
Date: Wed,  8 Sep 2021 16:17:27 +0200
Message-Id: <20210908141728.585797-8-narmstrong@baylibre.com>
In-Reply-To: <20210908141728.585797-1-narmstrong@baylibre.com>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Beelink GS-King X is a variant of the GS King boards but with an internal
USB to SATA bridge and advanced audio features.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi |  7 ++
 configs/beelink-gsking-x_defconfig           | 70 ++++++++++++++++++++
 doc/board/amlogic/index.rst                  |  2 +-
 3 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi
 create mode 100644 configs/beelink-gsking-x_defconfig

diff --git a/arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi b/arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi
new file mode 100644
index 0000000000..236f2468dc
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
new file mode 100644
index 0000000000..8a76e8829a
--- /dev/null
+++ b/configs/beelink-gsking-x_defconfig
@@ -0,0 +1,70 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="beelink-s922x"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gsking-x"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" beelink"
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
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
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
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index af12f94fde..de1a9ce284 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -18,7 +18,7 @@ This matrix concerns the actual source code version.
 | Boards                       	| Odroid-C2 | P212            | Khadas VIM2  | S400       | U200       | Odroid-N2   | SEI610       |
 |        			| Nanopi-K2 | Khadas-VIM      | Libretech-PC |	          | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
 |        			| P200	    | LibreTech-CC v1 |	WeTek Core2  |	          |            | GT-King/Pro | Odroid-C4    |
-|        			| P201	    | LibreTech-AC v2 |	             |	          |            |             | Odroid-HC4   |
+|        			| P201	    | LibreTech-AC v2 |	             |	          |            | GSKing-X    | Odroid-HC4   |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
 | UART                       	| **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
-- 
2.25.1

