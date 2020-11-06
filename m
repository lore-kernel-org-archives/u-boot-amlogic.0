Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web08.9483.1604655968129838230
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:46:08 -0800
Received: by mail-wr1-f43.google.com with SMTP id e6so635554wro.1
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60svgmNUKzmtE63Ps/+IRRw2cTSbD0ZLJOicFTHGXno=;
        b=PpTlXGsvFnRJ5y3V9/YazAuBoKOuxW7JBPjm4aoX14QpGtO/AZH+seXdJ0q59bDNGS
         0YWAwBN/3nPrWIJUhV8YFGHyU0dOUqzfOEYSoCoVm4LTmih2QVQG2cPlCw8V1S8ieuyg
         T+TeuXRHU28Xh/yxc/IamF4kdmpxLd/niVXwNzG5/Emnkz8m828yWtbBzLPGwRDd+de2
         DOtIUoOukUg3VL3apTFMoYkyCDg+oE9vxdz8Oi1jqXpHf6C0CjP7t3RUQLQx5o0I59GD
         J8CSHIIRJgcgH5TmpATDvc5XAz2+izKx4Qn9/AeLUKmCMh3RRooJyUYpjhnsmEAYqHgn
         R+pw==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH RESEND v2 2/2] arm64: meson: add support for libretech-cc v2
Date: Fri,  6 Nov 2020 10:45:55 +0100
Message-Id: <20201106094555.34241-3-jbrunet@baylibre.com>
In-Reply-To: <20201106094555.34241-1-jbrunet@baylibre.com>
References: <20201106094555.34241-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@libre.computer>
List-ID: <u-boot-amlogic@groups.io>

Add support for the Amlogic based libretech cc version 2.
As version 1, it is based on the s905x SoC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 ...eson-gxl-s905x-libretech-cc-v2-u-boot.dtsi |   7 ++
 board/amlogic/p212/MAINTAINERS                |   1 +
 configs/libretech-cc_v2_defconfig             |  82 ++++++++++++
 doc/board/amlogic/index.rst                   | 117 +++++++++---------
 doc/board/amlogic/libretech-cc.rst            |  15 ++-
 5 files changed, 161 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
 create mode 100644 configs/libretech-cc_v2_defconfig

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
diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index cae6994393d7..3d622af29ba9 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -7,6 +7,7 @@ F:	include/configs/p212.h
 F:	configs/khadas-vim_defconfig
 F:	configs/libretech-ac_defconfig
 F:	configs/libretech-cc_defconfig
+F:	configs/libretech-cc_v2_defconfig
 F:	configs/p212_defconfig
 F:	doc/board/amlogic/p212.rst
 F:	doc/board/amlogic/libretech-ac.rst
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
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 0e2f8c9aadde..37451028288a 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -10,64 +10,65 @@ An up-do-date matrix is also available on: http://linux-meson.com
 
 This matrix concerns the actual source code version.
 
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-|                    		| S905      | S905X        | S912         | A113X      | S905X2     | S922X       | S905X3       |
-|				|	    | S805X   	   | S905D        |	       | S905D2     | A311D       | S905D3       |
-|				|	    |		   |	          |            | S905Y2     |	          |              |
-+===============================+===========+==============+==============+============+============+=============+==============+
-| Boards               		| Odroid-C2 | P212         | Khadas VIM2  | S400       | U200       | Odroid-N2   | SEI610       |
-|				| Nanopi-K2 | Khadas-VIM   | Libretech-PC |	       | SEI510	    | Khadas-VIM3 | Khadas-VIM3L |
-|				| P200	    | LibreTech-CC |	          |	       |            |	          | Odroid-C4    |
-|				| P201	    | LibreTech-AC |	          |	       |            |             |    	         |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| UART               		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| Pinctrl/GPIO       		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| Clock Control      		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| PWM                		| No        | No           | No           | No         | No         | No          | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| Reset Control      		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| Infrared Decoder   		| No        | No           | No           | No         | No         | No          | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| Ethernet           		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| Multi-core         		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| Fuse access        		| **Yes**   | **Yes**      |**Yes**       |**Yes**     |**Yes**     |**Yes**      | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| SPI (FC)          		| **Yes**   | **Yes**      | **Yes**      | **Yes**    |**Yes**     | **Yes**     | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| SPI (CC)           		| No        | No           | No           | No         | No         | No          | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| I2C               		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| USB               		| **Yes**   | **Yes**      | **Yes**      | No         | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| USB OTG          		| No        | **Yes**      | **Yes**      | No         | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| eMMC              		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| SDCard            		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| NAND              		| No        | No           | No           | No         | No         | No          | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| ADC               		| **Yes**   | **Yes**      | **Yes**      | No         | No         | No          | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| CVBS Output        		| **Yes**   | **Yes**      | **Yes**      | *N/A*      | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| HDMI Output        		| **Yes**   | **Yes**      | **Yes**      | *N/A*      | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| CEC                		| No        | No           | No           | *N/A*      | No         | No          | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| Thermal Sensor     		| No        | No           | No           | No         | No         | No          | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| LCD/LVDS Output    		| No        | *N/A*        | No           | No         | No         | No          | No           |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| SoC (version) information    	| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
-+-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+|                               | S905      | S905X           | S912         | A113X      | S905X2     | S922X       | S905X3       |
+|                               |           | S805X           | S905D        |            | S905D2     | A311D       | S905D3       |
+|                               |           |                 |              |            | S905Y2     |             |              |
++===============================+===========+=================+==============+============+============+=============+==============+
+| Boards                        | Odroid-C2 | P212            | Khadas VIM2  | S400       | U200       | Odroid-N2   | SEI610       |
+|                               | Nanopi-K2 | Khadas-VIM      | Libretech-PC |            | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
+|                               | P200      | LibreTech-CC v1 |              |            |            |             | Odroid-C4    |
+|                               | P201      | LibreTech-CC v2 |              |            |            |             |              |
+|                               |           | LibreTech-AC    |              |            |            |             |              |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| UART                          | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| Pinctrl/GPIO                  | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| Clock Control                 | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| PWM                           | No        | No              | No           | No         | No         | No          | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| Reset Control                 | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| Infrared Decoder              | No        | No              | No           | No         | No         | No          | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| Ethernet                      | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| Multi-core                    | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| Fuse access                   | **Yes**   | **Yes**         |**Yes**       |**Yes**     |**Yes**     |**Yes**      | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| SPI (FC)                      | **Yes**   | **Yes**         | **Yes**      | **Yes**    |**Yes**     | **Yes**     | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| SPI (CC)                      | No        | No              | No           | No         | No         | No          | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| I2C                           | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| USB                           | **Yes**   | **Yes**         | **Yes**      | No         | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| USB OTG                       | No        | **Yes**         | **Yes**      | No         | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| eMMC                          | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| SDCard                        | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| NAND                          | No        | No              | No           | No         | No         | No          | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| ADC                           | **Yes**   | **Yes**         | **Yes**      | No         | No         | No          | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| CVBS Output                   | **Yes**   | **Yes**         | **Yes**      | *N/A*      | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| HDMI Output                   | **Yes**   | **Yes**         | **Yes**      | *N/A*      | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| CEC                           | No        | No              | No           | *N/A*      | No         | No          | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| Thermal Sensor                | No        | No              | No           | No         | No         | No          | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| LCD/LVDS Output               | No        | *N/A*           | No           | No         | No         | No          | No           |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| SoC (version) information     | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
 
 Board Documentation
 -------------------
diff --git a/doc/board/amlogic/libretech-cc.rst b/doc/board/amlogic/libretech-cc.rst
index f2e26cabf908..3e510c756201 100644
--- a/doc/board/amlogic/libretech-cc.rst
+++ b/doc/board/amlogic/libretech-cc.rst
@@ -1,11 +1,12 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-U-Boot for LibreTech CC
-=======================
+U-Boot for LibreTech CCs
+========================
 
 LibreTech CC is a single board computer manufactured by Libre Technology
 with the following specifications:
 
+ V1:
  - Amlogic S905X ARM Cortex-A53 quad-core SoC @ 1.5GHz
  - ARM Mali 450 GPU
  - 2GB DDR3 SDRAM
@@ -15,6 +16,11 @@ with the following specifications:
  - 4 x USB 2.0 Host
  - eMMC, microSD
  - Infrared receiver
+ - Jack for CVBS and Audio
+
+ V2:
+ - Added SPI NOR
+ - Removed Jack
 
 Schematics are available on the manufacturer website.
 
@@ -27,6 +33,8 @@ U-Boot compilation
     $ make libretech-cc_defconfig
     $ make
 
+Use libretech-cc_v2_defconfig for v2.
+
 Image creation
 --------------
 
@@ -41,7 +49,8 @@ bootloaders:
 * acs.bin: built from vendor u-boot source
 
 These binaries and the tools required below have been collected and prebuilt
-for convenience at <https://github.com/BayLibre/u-boot/releases/>
+for convenience at <https://github.com/BayLibre/u-boot/releases/>. These
+apply to both v1 and v2.
 
 Download and extract the libretech-cc release from there, and set FIPDIR to
 point to the `fip` subdirectory.
-- 
2.28.0

