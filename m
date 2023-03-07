Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.9807.1678177229326704874
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Mar 2023 00:20:29 -0800
Received: by mail-wr1-f49.google.com with SMTP id bx12so11225476wrb.11
        for <u-boot-amlogic@groups.io>; Tue, 07 Mar 2023 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177228;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB33Q/rIQRs3Qh9GoCxwcug/lSbpki4RCqxGKGHNDBA=;
        b=h/2nFd65N9KOI8WGIwON8zwN3jlrmBs1TJKRAVIWZSXBP9clhZMiOJ1add55zmm+Jz
         u/jUgWjVO2rozh5b0wmoKqzTBsxRhVZPBDajHAxe06vSTi01F/9rC8NUsR1aJcmkIbBV
         oZHV1BVtR9bLUwmIgFQSbWeyty+zu/+htHHJCw3nVGHsgGH4CcMCLLViBbAo+n1UNs+D
         jfRSw93tZc4GiMMqKtRzS0OQDqPmbc7zmyolecpRjKYrd/2P6nQOKg8AL6BGG7inP2qf
         WVwYUgzi43oWDRYhYECHR0wWVjiAOufsWo6aNW9+3oXvgk9RcdsWQcP4D1+W/OP2IAyD
         dNtA==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Tue, 07 Mar 2023 09:20:25 +0100
Subject: [PATCH 2/2] ARM: meson: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard
MIME-Version: 1.0
Message-Id: <20230307-u-boot-cm4-v1-2-43f5a393cd37@linaro.org>
References: <20230307-u-boot-cm4-v1-0-43f5a393cd37@linaro.org>
In-Reply-To: <20230307-u-boot-cm4-v1-0-43f5a393cd37@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Add support for both the BananaPi BPI-CM4 module and the BananaPi
baseboard which is compatible with the RaspberryPi CM4IO baseboard.

The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
but with a single HDMI port and a single DSI output.

The current CM4IO baseboard DT should work fine on the Raspberry CM4
baseboard and other derivatives baseboards, but proper DT should
be written for other baseboards.

[1] https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../dts/meson-g12b-bananapi-cm4-cm4io-u-boot.dtsi  |  6 ++
 board/amlogic/u200/MAINTAINERS                     |  1 +
 configs/bananapi-cm4-cm4io_defconfig               | 84 ++++++++++++++++++++++
 doc/board/amlogic/index.rst                        |  1 +
 4 files changed, 92 insertions(+)

diff --git a/arch/arm/dts/meson-g12b-bananapi-cm4-cm4io-u-boot.dtsi b/arch/arm/dts/meson-g12b-bananapi-cm4-cm4io-u-boot.dtsi
new file mode 100644
index 0000000000..a60ba27806
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-bananapi-cm4-cm4io-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
index 47cec234a1..7535e489d1 100644
--- a/board/amlogic/u200/MAINTAINERS
+++ b/board/amlogic/u200/MAINTAINERS
@@ -4,6 +4,7 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/u200/
 F:	configs/u200_defconfig
+F:	configs/bananapi-cm4-cm4io_defconfig
 F:	configs/bananapi-m5_defconfig
 F:	configs/radxa-zero_defconfig
 F:	doc/board/amlogic/u200.rst
diff --git a/configs/bananapi-cm4-cm4io_defconfig b/configs/bananapi-cm4-cm4io_defconfig
new file mode 100644
index 0000000000..0801b9d06f
--- /dev/null
+++ b/configs/bananapi-cm4-cm4io_defconfig
@@ -0,0 +1,84 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-bananapi-cm4-cm4io"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING="bpi-cm4io"
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
+CONFIG_CMD_PCI=y
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
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_PCI=y
+CONFIG_PCIE_DW_MESON=y
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
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
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
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_VIDEO_BMP_RLE8=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index f945f672dd..e51b904582 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -22,6 +22,7 @@ This matrix concerns the actual source code version.
 |                               |           | JetHub J80      |              |             |            | Odroid-Go-  | BananaPi-M5  |
 |                               |           |                 |              |             |            | Ultra       |              |
 |                               |           |                 |              |             |            | Odroid-N2L  |              |
+|                               |           |                 |              |             |            | BPI-M4      |              |
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
 | UART                          | **Yes**   | **Yes**         | **Yes**      | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+

-- 
2.34.1

