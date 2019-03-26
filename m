Received: by mail-wr1-f68.google.com with SMTP id t5so13563443wri.7
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 03:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0JTFAES+3t6B+rampYd0xoQfjHRPqAeeO9GqBIm36A=;
        b=lgcEh9oPzTo3gE8xBxgxE2oveqUwk/lMdP/QXWeIcI5+n2r0kCtOcasdSkEnk15IbR
         ucLUJOtJBb8hDtVaJfT75zGnKdDpYNopx6H1U5xqe1H0m0WjKDL9Rvwugh03kytBbzaj
         4jCu5mNdUL1ughQKDURbHAevGDed2JLr6M9dUsT8x8RMe+XO7HTX1X4iIa2LqET7aLZ9
         2e/G3OcmsaSPb5XKQUk/ywsVQsk4gi0G13+hWmF34lnH8u5ymANLT4/mfPTrmcBPW/Yn
         uA20nsTqkUa9re0AqjhY3CLD+EJ709jZ0V/DAMEAL+QDOPL7K05pDrnlnnB7AmItEwhp
         YZ9g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] boards: Amlogic: Add support for Libretech-AC
Date: Tue, 26 Mar 2019 11:20:35 +0100
Message-Id: <20190326102035.9239-3-narmstrong@baylibre.com>
In-Reply-To: <20190326102035.9239-1-narmstrong@baylibre.com>
References: <20190326102035.9239-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

LibreTech AC is a single board computer manufactured by Libre Technology
with the following specifications:

 - Amlogic S805X ARM Cortex-A53 quad-core SoC @ 1.2GHz
 - ARM Mali 450 GPU
 - 512MiB DDR4 SDRAM
 - 10/100 Ethernet
 - HDMI 2.0 4K/60Hz display
 - 40-pin GPIO header
 - 4 x USB 2.0 Host
 - eMMC, SPI NOR Flash
 - Infrared receiver

The u-boot specific code is the same as the P212 support,
so use the P212 board support code with a distinct defconfig
and config include files.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/p212/MAINTAINERS         |   1 +
 board/amlogic/p212/README.libretech-ac | 103 +++++++++++++++++++++++++
 configs/libretech-ac_defconfig         |  74 ++++++++++++++++++
 include/configs/libretech-ac.h         |  24 ++++++
 4 files changed, 202 insertions(+)
 create mode 100644 board/amlogic/p212/README.libretech-ac
 create mode 100644 configs/libretech-ac_defconfig
 create mode 100644 include/configs/libretech-ac.h

diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index 07ca6f204d..74ad3716ec 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -4,5 +4,6 @@ S:	Maintained
 F:	board/amlogic/p212/
 F:	include/configs/p212.h
 F:	configs/khadas-vim_defconfig
+F:	configs/libretech-ac_defconfig
 F:	configs/libretech-cc_defconfig
 F:	configs/p212_defconfig
diff --git a/board/amlogic/p212/README.libretech-ac b/board/amlogic/p212/README.libretech-ac
new file mode 100644
index 0000000000..538604261b
--- /dev/null
+++ b/board/amlogic/p212/README.libretech-ac
@@ -0,0 +1,103 @@
+U-Boot for LibreTech AC
+=======================
+
+LibreTech AC is a single board computer manufactured by Libre Technology
+with the following specifications:
+
+ - Amlogic S805X ARM Cortex-A53 quad-core SoC @ 1.2GHz
+ - ARM Mali 450 GPU
+ - 512MiB DDR4 SDRAM
+ - 10/100 Ethernet
+ - HDMI 2.0 4K/60Hz display
+ - 40-pin GPIO header
+ - 4 x USB 2.0 Host
+ - eMMC, SPI NOR Flash
+ - Infrared receiver
+
+Schematics are available on the manufacturer website.
+
+Currently the U-Boot port supports the following devices:
+ - serial
+ - eMMC
+ - Ethernet
+ - USB
+
+U-Boot compilation
+==================
+
+ > export ARCH=arm
+ > export CROSS_COMPILE=aarch64-none-elf-
+ > make libretech-ac_defconfig
+ > make
+
+Image creation
+==============
+
+Amlogic doesn't provide sources for the firmware and for tools needed
+to create the bootloader image, so it is necessary to obtain them from
+the git tree published by the board vendor:
+
+ > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+ > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+ > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+ > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+ > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
+ > git clone https://github.com/BayLibre/u-boot.git -b libretech-ac amlogic-u-boot
+ > cd amlogic-u-boot
+ > wget https://raw.githubusercontent.com/BayLibre/u-boot/libretech-cc/fip/blx_fix.sh
+ > make libretech_ac_defconfig
+ > make
+ > export UBOOTDIR=$PWD
+
+Download the latest Amlogic Buildroot package, and extract it :
+ > wget http://openlinux2.amlogic.com:8000/ARM/filesystem/Linux_BSP/buildroot_openlinux_kernel_4.9_fbdev_20180418.tar.gz
+ > tar xfz buildroot_openlinux_kernel_4.9_fbdev_20180418.tar.gz buildroot_openlinux_kernel_4.9_fbdev_20180418/bootloader
+ > export BRDIR=$PWD/buildroot_openlinux_kernel_4.9_fbdev_20180418
+
+Go back to mainline U-Boot source tree then :
+ > mkdir fip
+
+ > cp $UBOOTDIR/build/scp_task/bl301.bin fip/
+ > cp $UBOOTDIR/build/board/amlogic/libretech_ac/firmware/bl21.bin fip/
+ > cp $UBOOTDIR/build/board/amlogic/libretech_ac/firmware/acs.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl2/bin/gxl/bl2.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl30/bin/gxl/bl30.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl31/bin/gxl/bl31.img fip/
+ > cp u-boot.bin fip/bl33.bin
+
+ > sh $UBOOTDIR/blx_fix.sh \
+	fip/bl30.bin \
+	fip/zero_tmp \
+	fip/bl30_zero.bin \
+	fip/bl301.bin \
+	fip/bl301_zero.bin \
+	fip/bl30_new.bin \
+	bl30
+
+ > $BRDIR/bootloader/uboot-repo/fip/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+
+ > sh $UBOOTDIR/blx_fix.sh \
+	fip/bl2_acs.bin \
+	fip/zero_tmp \
+	fip/bl2_zero.bin \
+	fip/bl21.bin \
+	fip/bl21_zero.bin \
+	fip/bl2_new.bin \
+	bl2
+
+ > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
+ > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
+ > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
+ > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
+ > $BRDIR/bootloader/uboot-repo/fip/gxl/aml_encrypt_gxl --bootmk \
+		--output fip/u-boot.bin \
+		--bl2 fip/bl2.n.bin.sig \
+		--bl30 fip/bl30_new.bin.enc \
+		--bl31 fip/bl31.img.enc \
+		--bl33 fip/bl33.bin.enc
+
+and then write the image to SD with:
+
+ > DEV=/dev/your_sd_device
+ > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+ > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
new file mode 100644
index 0000000000..2cdfcf42f5
--- /dev/null
+++ b/configs/libretech-ac_defconfig
@@ -0,0 +1,74 @@
+CONFIG_ARM=y
+CONFIG_SYS_CONFIG_NAME="libretech-ac"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_GXL=y
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" libretech-ac"
+CONFIG_DEBUG_UART=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
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
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s805x-libretech-ac"
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_SPANSION=y
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
+CONFIG_USB_STORAGE=y
+CONFIG_CONSOLE_MUX=y
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_DM_VIDEO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/include/configs/libretech-ac.h b/include/configs/libretech-ac.h
new file mode 100644
index 0000000000..419dc61587
--- /dev/null
+++ b/include/configs/libretech-ac.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration for LibreTech AC
+ *
+ * Copyright (C) 2017 Baylibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CONFIG_ENV_SECT_SIZE	0x10000
+#define CONFIG_ENV_OFFSET	(-0x10000)
+
+#define BOOT_TARGET_DEVICES(func) \
+	func(ROMUSB, romusb, na)  \
+	func(MMC, mmc, 0) \
+	BOOT_TARGET_DEVICES_USB(func) \
+	func(PXE, pxe, na) \
+	func(DHCP, dhcp, na)
+
+#include <configs/meson64.h>
+
+#endif /* __CONFIG_H */
-- 
2.21.0

