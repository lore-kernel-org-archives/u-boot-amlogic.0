Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.45218.1674135862888189243
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Jan 2023 05:44:23 -0800
Received: by mail-wm1-f51.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso3593505wmc.4
        for <u-boot-amlogic@groups.io>; Thu, 19 Jan 2023 05:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjdsykXBrE0REl43ikDHvOfEsE8NxaTIb8Vg/gD/bog=;
        b=hbmD73NrLj0v7U4QPxyRcnSeGJoLS2NZrTQHPgHJYXXImvWwsicOK+rF9HivvlUm1T
         WuZFH410pQZHevDoNdDpp3Thwnv6twMbKENLcnFep3owfEAh9a7xX0iknwjolSwK9qyh
         h8NVFa6aP6xnizvN2Y/WAsa3rfEwfN4Y3x20YwplJsECzomG0E/9sP1ipbXTWIIFiCOR
         hCScHe+O4ZuinIHv6xbccNhU3kDepqBH6Z3z0AN+JDtjdlGd4lf4Flsm/V7P3jXrxuO6
         oaWmRQX/ZeSjG++WTp0OsuR7By9SQo8Eq5y+ANiJDVGBJBiJZFtoMKTuTiDJo293Djr7
         /3Dw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Thu, 19 Jan 2023 14:44:18 +0100
Subject: [PATCH 2/2] ARM: meson: add support for Odroid Go Ultra
MIME-Version: 1.0
Message-Id: <20230119-u-boot-odroid-go-ultra-v1-2-f96bab9db396@linaro.org>
References: <20230119-u-boot-odroid-go-ultra-v1-0-f96bab9db396@linaro.org>
In-Reply-To: <20230119-u-boot-odroid-go-ultra-v1-0-f96bab9db396@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

This adds initial support for the Hardkernel Odroid Go Ultra.

The Odroid Go Ultra is a portable gaming device with the following
characteristics:
- Amlogic S922X SoC
- RK817 & RK818 PMICs
- 2GiB LPDDR4
- On board 16GiB eMMC
- Micro SD Card slot
- 5inch 854×480 MIPI-DSI TFT LCD
- Earphone stereo jack, 0.5Watt 8Ω Mono speaker
- Li-Polymer 3.7V/4000mAh Battery
- USB-A 2.0 Host Connector
- x16 GPIO Input Buttons
- 2x ADC Analog Joysticks
- USB-C Port for USB2 Device and Charging

The following are not yet handled:
- Battery RK818 Gauge and Charging
- 5inch 854×480 MIPI-DSI TFT LCD

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi | 16 +++++
 configs/odroid-go-ultra_defconfig                  | 70 ++++++++++++++++++++++
 doc/board/amlogic/index.rst                        |  4 +-
 doc/board/amlogic/odroid-go-ultra.rst              | 34 +++++++++++
 4 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi b/arch/arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi
new file mode 100644
index 0000000000..00852f5e54
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
+
+/* RK817/818 BOOST regulator aren't supported yet, so remove phandles from PHY nodes */
+
+&usb2_phy1 {
+	/delete-property/ phy-supply;
+};
+
+&usb3_pcie_phy {
+	/delete-property/ phy-supply;
+};
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
new file mode 100644
index 0000000000..a4d349fba4
--- /dev/null
+++ b/configs/odroid-go-ultra_defconfig
@@ -0,0 +1,70 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="w400"
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-go-ultra"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" odroid-go-ultra"
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
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RESET=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 4d407f9362..11443d9f2c 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -19,7 +19,8 @@ This matrix concerns the actual source code version.
 |                               | Nanopi-K2 | Khadas-VIM      | Libretech-PC | JetHub J100 | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
 |                               | P200      | LibreTech-CC v1 | WeTek Core2  |             | Radxa Zero | GT-King/Pro | Odroid-C4    |
 |                               | P201      | LibreTech-AC v2 |              |             |            | GSKing-X    | Odroid-HC4   |
-|                               |           | JetHub J80      |              |             |            |             | BananaPi-M5  |
+|                               |           | JetHub J80      |              |             |            | Odroid-Go-  | BananaPi-M5  |
+|                               |           |                 |              |             |            | Ultra       |              |
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
 | UART                          | **Yes**   | **Yes**         | **Yes**      | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
@@ -105,6 +106,7 @@ Board Documentation
    odroid-c2
    odroid-c4
    odroid-n2
+   odroid-go-ultra
    p200
    p201
    p212
diff --git a/doc/board/amlogic/odroid-go-ultra.rst b/doc/board/amlogic/odroid-go-ultra.rst
new file mode 100644
index 0000000000..8df9e0cb79
--- /dev/null
+++ b/doc/board/amlogic/odroid-go-ultra.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for ODROID-GO-ULTRA
+==========================
+
+The Odroid Go Ultra is a portable gaming device with the following
+characteristics:
+
+ - Amlogic S922X SoC
+ - RK817 & RK818 PMICs
+ - 2GiB LPDDR4
+ - On board 16GiB eMMC
+ - Micro SD Card slot
+ - 5inch 854×480 MIPI-DSI TFT LCD
+ - Earphone stereo jack, 0.5Watt 8Ω Mono speaker
+ - Li-Polymer 3.7V/4000mAh Battery
+ - USB-A 2.0 Host Connector
+ - x16 GPIO Input Buttons
+ - 2x ADC Analog Joysticks
+ - USB-C Port for USB2 Device and Charging
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make odroid-go-ultra_defconfig
+    $ make
+
+Image creation
+--------------
+
+Pleaser refer to :doc:`pre-generated-fip` with codename `odroid-go-ultra`

-- 
2.34.1
