Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.70221.1674726518108112953
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Jan 2023 01:48:38 -0800
Received: by mail-wm1-f41.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso2879093wmn.5
        for <u-boot-amlogic@groups.io>; Thu, 26 Jan 2023 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMIt0IDHqrf8Q/B+/ijprhoZ4ml6e5GfJrLmcn8HZCA=;
        b=LsfIjPda16zJP+i2ut9WOyHuhZ/kHPdMxMwY0EEYccjDQq3gCRPEV6kTcdhtBeZJIt
         EP8D3srT2WZZstTbL33H/wZSwz24heAc+lEAc2p6tX1OaU8XHoPSJkoEmpIZZKUyCM+e
         klnn2TdZiS1B+bVVWAevx/R0tHeKE9S6L/jk9R8A6r/TPentuyXIDHzvdeal59eZ032p
         KcQ3vIOAaMxC7Pl7mJNwWbtptmg1hBf9Yq7knLXe/XLK+wbG9jo4lCeVwZb5UyguuDhI
         Kq90iLSV8d4nS38HfsHcf1MHjrH8XxH35LgPiO5tVIRbX+8hrl0RZCKF4jdpyN+LDzaP
         C61g==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Thu, 26 Jan 2023 10:48:21 +0100
Subject: [PATCH 2/2] ARM: meson: Add support for Odroid-N2L
MIME-Version: 1.0
Message-Id: <20230126-u-boot-odroid-n2l-v1-2-c60f695e0f6c@linaro.org>
References: <20230126-u-boot-odroid-n2l-v1-0-c60f695e0f6c@linaro.org>
In-Reply-To: <20230126-u-boot-odroid-n2l-v1-0-c60f695e0f6c@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

ODROID-N2L is a variant SBC in small form factor and some peripherals
are removed from ODROID-N2PLUS based on S922X SoC.

- On-board ethernet is removed
- On-board RTC is removed
- USB 3.0 hub is removed, so one USB 2.0 and one USB 3.0 host ports
  are available
- Huge heatsink is replaced with 40x40mm heatsink, 5V active heatsink
  is recommended or a tall passive sink is optional
- 3.5mm earjack is removed
- IR remote receiver is removed
- MIPI DSI port is added

It doesn't use the odroid-n2 board support since ADC revision
collides with Odroid-N2+ and since it doesn't have on-board ethernet
no need to load the MAC address from eFuses.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/dts/meson-g12b-odroid-n2l-u-boot.dtsi |  7 +++
 configs/odroid-n2l_defconfig                   | 70 ++++++++++++++++++++++++++
 doc/board/amlogic/index.rst                    |  2 +
 doc/board/amlogic/odroid-n2l.rst               | 31 ++++++++++++
 4 files changed, 110 insertions(+)

diff --git a/arch/arm/dts/meson-g12b-odroid-n2l-u-boot.dtsi b/arch/arm/dts/meson-g12b-odroid-n2l-u-boot.dtsi
new file mode 100644
index 0000000000..236f2468dc
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-odroid-n2l-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
diff --git a/configs/odroid-n2l_defconfig b/configs/odroid-n2l_defconfig
new file mode 100644
index 0000000000..7f9e64d942
--- /dev/null
+++ b/configs/odroid-n2l_defconfig
@@ -0,0 +1,70 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="w400"
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2l"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" odroid-n2l"
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_DEBUG_UART=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
+CONFIG_REMAKE_ELF=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_SYS_MAXARGS=32
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
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_MMC_MESON_GX=y
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
+CONFIG_DM_USB_GADGET=y
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
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 11443d9f2c..f945f672dd 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -21,6 +21,7 @@ This matrix concerns the actual source code version.
 |                               | P201      | LibreTech-AC v2 |              |             |            | GSKing-X    | Odroid-HC4   |
 |                               |           | JetHub J80      |              |             |            | Odroid-Go-  | BananaPi-M5  |
 |                               |           |                 |              |             |            | Ultra       |              |
+|                               |           |                 |              |             |            | Odroid-N2L  |              |
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
 | UART                          | **Yes**   | **Yes**         | **Yes**      | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
@@ -106,6 +107,7 @@ Board Documentation
    odroid-c2
    odroid-c4
    odroid-n2
+   odroid-n2l
    odroid-go-ultra
    p200
    p201
diff --git a/doc/board/amlogic/odroid-n2l.rst b/doc/board/amlogic/odroid-n2l.rst
new file mode 100644
index 0000000000..afd4409d1b
--- /dev/null
+++ b/doc/board/amlogic/odroid-n2l.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for ODROID-N2L
+=====================
+
+ODROID-N2L is a single board computer manufactured by Hardkernel
+Co. Ltd with the following specifications:
+
+ - Amlogic S922X ARM Cortex-A53 dual-core + Cortex-A73 quad-core SoC
+ - 4GB DDR4 SDRAM
+ - HDMI 2.1 4K/60Hz display
+ - 40-pin GPIO header
+ - 1 x USB 3.0 Host, 1 x USB USB 2.0 Host
+ - eMMC, microSD
+ - MIPI DSI Port
+
+Schematics are available on the manufacturer website.
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make odroid-n2l_defconfig
+    $ make
+
+Image creation
+--------------
+
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `odroid-n2l`

-- 
2.34.1

