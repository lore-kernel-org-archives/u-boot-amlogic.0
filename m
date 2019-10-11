Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.1822.1570808048094673676
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 08:34:08 -0700
Received: by mail-wr1-f67.google.com with SMTP id z9so12413859wrl.11
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ivoyAkPPMDGigW1duJIYLJ5WZ69ryCQWV3eXwtLMTU=;
        b=re9B7h/2coKCbKdwkzy9u/K1aV8DQcA2zpclA9UdYtag0XjPslutmH6IBLFURQ+AfP
         w/PBV1s0oBVIJjfD6Yj1MER+80bj0yyNM/aazcBAYFtnr8M20rozdaF/LkXFFVWitygF
         Sest/9SP7ZEz4nZJTkm7jcN9dmaJs0+B4g7K4OktjhXIvymfphefP44V4bSIXNV7LBsn
         CKGfHz5LW3yxpfNwh0S6cGGXHpbcyebo9qsnGpbUjEnpfGSYJqI9Xu32uqTzm2u6Muoo
         9cKo4rqxpZx9+p2/b5d9UYT9SHHl+cu54xytE8l/y70H6O9O6hZAjNhpeYuF5mOWHowE
         3bAw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 6/8] boards: amlogic: add SEI610 support
Date: Fri, 11 Oct 2019 17:33:56 +0200
Message-Id: <20191011153358.29739-7-narmstrong@baylibre.com>
In-Reply-To: <20191011153358.29739-1-narmstrong@baylibre.com>
References: <20191011153358.29739-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for the customer board SEI610 manufactured by SEI Robotics
with the following specifications:
 - Amlogic S905X3 ARM Cortex-A35 quad-core SoC
 - 2GB DDR4 SDRAM
 - 10/100 Ethernet (Internal PHY)
 - 1 x USB 3.0 Host
 - 1 x USB Type-C DRD
 - 1 x FTDI USB Serial Debug Interface
 - eMMC
 - SDcard
 - Infrared receiver
 - SDIO WiFi Module

Like it's SEI510 counterpart, the boot flow is designed to boot
Android AOSP built for the Yukawa Android device.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/sei610/MAINTAINERS |   6 ++
 board/amlogic/sei610/Makefile    |   6 ++
 board/amlogic/sei610/README      | 119 +++++++++++++++++++++++++++++++
 board/amlogic/sei610/sei610.c    |  26 +++++++
 configs/sei610_defconfig         |  76 ++++++++++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100644 board/amlogic/sei610/MAINTAINERS
 create mode 100644 board/amlogic/sei610/Makefile
 create mode 100644 board/amlogic/sei610/README
 create mode 100644 board/amlogic/sei610/sei610.c
 create mode 100644 configs/sei610_defconfig

diff --git a/board/amlogic/sei610/MAINTAINERS b/board/amlogic/sei610/MAINTAINERS
new file mode 100644
index 0000000000..20f12334e9
--- /dev/null
+++ b/board/amlogic/sei610/MAINTAINERS
@@ -0,0 +1,6 @@
+SEI610
+M:	Neil Armstrong <narmstrong@baylibre.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/sei610/
+F:	configs/sei610_defconfig
diff --git a/board/amlogic/sei610/Makefile b/board/amlogic/sei610/Makefile
new file mode 100644
index 0000000000..428792afea
--- /dev/null
+++ b/board/amlogic/sei610/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2016 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= sei610.o
diff --git a/board/amlogic/sei610/README b/board/amlogic/sei610/README
new file mode 100644
index 0000000000..836809ccdb
--- /dev/null
+++ b/board/amlogic/sei610/README
@@ -0,0 +1,119 @@
+U-Boot for Amlogic SEI610
+=======================
+
+SEI610 is a customer board manufactured by SEI Robotics with the following
+specifications:
+
+ - Amlogic S905X3 ARM Cortex-A35 quad-core SoC
+ - 2GB DDR4 SDRAM
+ - 10/100 Ethernet (Internal PHY)
+ - 1 x USB 3.0 Host
+ - 1 x USB Type-C DRD
+ - 1 x FTDI USB Serial Debug Interface
+ - eMMC
+ - SDcard
+ - Infrared receiver
+ - SDIO WiFi Module
+
+u-boot compilation
+==================
+
+ > export ARCH=arm
+ > export CROSS_COMPILE=aarch64-none-elf-
+ > make sei610_defconfig
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
+ > git clone https://github.com/BayLibre/u-boot.git -b buildroot-openlinux-4.9-g12a-201904 amlogic-u-boot
+ > cd amlogic-u-boot
+ > make sm1_ac200_v1_defconfig
+ > make
+ > export UBOOTDIR=$PWD
+
+Download the latest Amlogic Buildroot package, and extract it :
+ > wget http://openlinux2.amlogic.com:8000/ARM/filesystem/buildroot-openlinux-A113-201901.tgz
+ > tar xfz buildroot-openlinux-A113-201901.tgz buildroot-openlinux-A113-201901/bootloader
+ > export BRDIR=$PWD/buildroot-openlinux-A113-201901
+ > export FIPDIR=$BRDIR/bootloader/uboot-repo/fip
+
+Go back to mainline U-Boot source tree then :
+ > mkdir fip
+
+ > wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
+ > cp $UBOOTDIR/build/scp_task/bl301.bin fip/
+ > cp $UBOOTDIR/build/board/amlogic/g12a_u200_v1/firmware/acs.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl2/bin/g12a/bl2.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl30/bin/g12a/bl30.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl31_1.3/bin/g12a/bl31.img fip/
+ > cp $FIPDIR/g12a/ddr3_1d.fw fip/
+ > cp $FIPDIR/g12a/ddr4_1d.fw fip/
+ > cp $FIPDIR/g12a/ddr4_2d.fw fip/
+ > cp $FIPDIR/g12a/diag_lpddr4.fw fip/
+ > cp $FIPDIR/g12a/lpddr4_1d.fw fip/
+ > cp $FIPDIR/g12a/lpddr4_2d.fw fip/
+ > cp $FIPDIR/g12a/piei.fw fip/
+ > cp u-boot.bin fip/bl33.bin
+
+ > sh fip/blx_fix.sh \
+	fip/bl30.bin \
+	fip/zero_tmp \
+	fip/bl30_zero.bin \
+	fip/bl301.bin \
+	fip/bl301_zero.bin \
+	fip/bl30_new.bin \
+	bl30
+
+ > sh fip/blx_fix.sh \
+	fip/bl2.bin \
+	fip/zero_tmp \
+	fip/bl2_zero.bin \
+	fip/acs.bin \
+	fip/bl21_zero.bin \
+	fip/bl2_new.bin \
+	bl2
+
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
+					--output fip/bl30_new.bin.g12a.enc \
+					--level v3
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
+					--output fip/bl30_new.bin.enc \
+					--level v3 --type bl30
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
+					--output fip/bl31.img.enc \
+					--level v3 --type bl31
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
+					--output fip/bl33.bin.enc \
+					--level v3 --type bl33
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
+					--output fip/bl2.n.bin.sig
+ > $FIPDIR/g12a/aml_encrypt_g12a --bootmk \
+		--output fip/u-boot.bin \
+		--bl2 fip/bl2.n.bin.sig \
+		--bl30 fip/bl30_new.bin.enc \
+		--bl31 fip/bl31.img.enc \
+		--bl33 fip/bl33.bin.enc \
+		--ddrfw1 fip/ddr4_1d.fw \
+		--ddrfw2 fip/ddr4_2d.fw \
+		--ddrfw3 fip/ddr3_1d.fw \
+		--ddrfw4 fip/piei.fw \
+		--ddrfw5 fip/lpddr4_1d.fw \
+		--ddrfw6 fip/lpddr4_2d.fw \
+		--ddrfw7 fip/diag_lpddr4.fw \
+		--level v3
+
+and then write the image to SD with:
+
+ > DEV=/dev/your_sd_device
+ > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+ > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
diff --git a/board/amlogic/sei610/sei610.c b/board/amlogic/sei610/sei610.c
new file mode 100644
index 0000000000..b17eb9ef55
--- /dev/null
+++ b/board/amlogic/sei610/sei610.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <env_internal.h>
+#include <asm/io.h>
+#include <asm/arch/axg.h>
+#include <asm/arch/sm.h>
+#include <asm/arch/eth.h>
+#include <asm/arch/mem.h>
+
+int misc_init_r(void)
+{
+	meson_eth_init(PHY_INTERFACE_MODE_RMII,
+		       MESON_USE_INTERNAL_RMII_PHY);
+
+	meson_generate_serial_ethaddr();
+
+	env_set("serial#", "AMLG12ASEI610");
+
+	return 0;
+}
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
new file mode 100644
index 0000000000..89e7bd7bab
--- /dev/null
+++ b/configs/sei610_defconfig
@@ -0,0 +1,76 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="sei610"
+CONFIG_SYS_CONFIG_NAME="sei510"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_G12A=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" sei610"
+# CONFIG_PSCI_RESET is not set
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="run load_logo"
+# CONFIG_CONSOLE_MUX is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_BMP=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-sei610"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x6000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_DM_GPIO=y
+# CONFIG_INPUT is not set
+CONFIG_PWRSEQ=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ADDR=8
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
+CONFIG_DM_VIDEO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_LZ4=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.22.0

