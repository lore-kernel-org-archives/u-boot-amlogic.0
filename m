Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.9411.1631864240730831490
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Sep 2021 00:37:21 -0700
Received: by mail-wr1-f45.google.com with SMTP id u18so11856258wrg.5
        for <u-boot-amlogic@groups.io>; Fri, 17 Sep 2021 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4eGreGfsjikpTY3s082Lehjw2MhvJ48NsZ/3/zDUmuQ=;
        b=Pimqizw2ofT8HndzfUlyi0jQoQmySl1BsNjYEJm6kOStqo0FuDwyX6fHUZOG99Gyvz
         wcipmVNoXg+WgPO813TFJcMRbjEYH4kdrqtEh1xeByS+jKbU2sA3dsYw0hiNN2gEan/1
         OP22t91597AopQjup/e9qy/CXbSR58yAV5M1fchBEkjnoNNN8rq1Rjti2VN6Or3Blvxf
         mbxeDxvJyi8v9AwVFcqt8BqlV8f758YcGz8mO/c2CtSWSo+X5fP0XJf2XJCDOlycWvMi
         fQELkTz46zebqZd3tYTI6CY3YeULAtX6cuymvwCjHFv1NayZQSiym7aK/UV0d0zLLJLk
         JGtA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 09/10] ARM: meson: add Beelink GS-King X board
Date: Fri, 17 Sep 2021 09:37:08 +0200
Message-Id: <20210917073709.1052133-9-narmstrong@baylibre.com>
In-Reply-To: <20210917073709.1052133-1-narmstrong@baylibre.com>
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
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
 board/amlogic/beelink-s922x/MAINTAINERS      |  1 +
 configs/beelink-gsking-x_defconfig           | 70 ++++++++++++++++++++
 doc/board/amlogic/index.rst                  |  2 +-
 4 files changed, 79 insertions(+), 1 deletion(-)
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
diff --git a/board/amlogic/beelink-s922x/MAINTAINERS b/board/amlogic/beelink-s922x/MAINTAINERS
index 7f223df4ae..47b622765a 100644
--- a/board/amlogic/beelink-s922x/MAINTAINERS
+++ b/board/amlogic/beelink-s922x/MAINTAINERS
@@ -5,5 +5,6 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/beelink-s922x/
 F:	configs/beelink-gtking_defconfig
 F:	configs/beelink-gtkingpro_defconfig
+F:	configs/beelink-gsking-x_defconfig
 F:	doc/board/amlogic/beelink-gtking.rst
 F:	doc/board/amlogic/beelink-gtkingpro.rst
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

