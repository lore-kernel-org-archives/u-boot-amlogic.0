Received: by mail-wr1-f41.google.com with SMTP id w1so14800372wrp.2
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N844wq8ejUV4DnzAT1m1c7L2IrOgRe9pTVOwY5+Txxs=;
        b=hLF8iuH/O0tzrqYaBfB6/XGMNWGqI2w+RXzeSrUEIOREjEM5hwhDiQHjjIdP/zA7SQ
         d4/rzkMs1Q/ggaEmZAHPJsJwUfSBUpKOQyq4UIEADgVgTpiOdzaxWO6wWs1FP1p3Cyrr
         mdeCmeh9hWWiApx02Ui6ben1ljxq7dzpywE2bwN5+Cxtw35gGZgty5N4WoaWcLxOmUHW
         lEL0N1N/uUk3Pq1GK0dRTzSeRCQk0eisF13k1dTmIOqiAiaGB+HG3I2n4O2pC+hNzcuw
         bCvVp1tRjhBEcpqLpp458ioUSNle0chk91wi5w1ETiQI4JOR4eh70hNu3ezM0Yoo/jXf
         cXLw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 6/6] boards: meson: add g12a u200
Date: Tue, 26 Mar 2019 16:02:40 +0100
Message-Id: <20190326150240.20620-7-narmstrong@baylibre.com>
In-Reply-To: <20190326150240.20620-1-narmstrong@baylibre.com>
References: <20190326150240.20620-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Jerome Brunet <jbrunet@baylibre.com>

The Amlogic U200 board is based on the Amlogic S905D2 SoC
from the Amlogic G12A SoC family.

The board has the following specifications :
 - Amlogic S905D2 ARM Cortex-A53 quad-core SoC
 - XGB DDR4 SDRAM
 - 10/100 Ethernet (Internal PHY)
 - 1 x USB 3.0 Host
 - eMMC
 - SDcard
 - Infrared receiver
 - SDIO WiFi Module
 - MIPI DSI Connector
 - Audio HAT Connector
 - PCI-E M.2 Connector

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/u200/MAINTAINERS |   5 ++
 board/amlogic/u200/Makefile    |   6 ++
 board/amlogic/u200/README      | 128 +++++++++++++++++++++++++++++++++
 board/amlogic/u200/u200.c      |  22 ++++++
 configs/u200_defconfig         |  40 +++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 board/amlogic/u200/MAINTAINERS
 create mode 100644 board/amlogic/u200/Makefile
 create mode 100644 board/amlogic/u200/README
 create mode 100644 board/amlogic/u200/u200.c
 create mode 100644 configs/u200_defconfig

diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
new file mode 100644
index 0000000000..baf3813fd0
--- /dev/null
+++ b/board/amlogic/u200/MAINTAINERS
@@ -0,0 +1,5 @@
+U200
+M:	Neil Armstrong <narmstrong@baylibre.com>
+S:	Maintained
+F:	board/amlogic/u200/
+F:	configs/u200_defconfig
diff --git a/board/amlogic/u200/Makefile b/board/amlogic/u200/Makefile
new file mode 100644
index 0000000000..485791bbb2
--- /dev/null
+++ b/board/amlogic/u200/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2016 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= u200.o
diff --git a/board/amlogic/u200/README b/board/amlogic/u200/README
new file mode 100644
index 0000000000..bffac5e7ae
--- /dev/null
+++ b/board/amlogic/u200/README
@@ -0,0 +1,128 @@
+U-Boot for Amlogic U200
+=======================
+
+U200 is a reference board manufactured by Amlogic with the following
+specifications:
+
+ - Amlogic S905D2 ARM Cortex-A53 quad-core SoC
+ - 2GB DDR4 SDRAM
+ - 10/100 Ethernet (Internal PHY)
+ - 1 x USB 3.0 Host
+ - eMMC
+ - SDcard
+ - Infrared receiver
+ - SDIO WiFi Module
+ - MIPI DSI Connector
+ - Audio HAT Connector
+ - PCI-E M.2 Connector
+
+Schematics are available from Amlogic on demand.
+
+Currently the u-boot port supports the following devices:
+ - serial
+ - Ethernet
+ - Regulators
+ - Clock controller
+
+u-boot compilation
+==================
+
+ > export ARCH=arm
+ > export CROSS_COMPILE=aarch64-none-elf-
+ > make u200_defconfig
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
+ > git clone https://github.com/BayLibre/u-boot.git -b buildroot-openlinux-20180418 amlogic-u-boot
+ > cd amlogic-u-boot
+ > make g12a_u200_v1_defconfig
+ > make
+ > export UBOOTDIR=$PWD
+
+Download the latest Amlogic Buildroot package, and extract it :
+ > wget http://openlinux2.amlogic.com:8000/ARM/filesystem/Linux_BSP/buildroot_openlinux_kernel_4.9_fbdev_20180706.tar.gz
+ > tar xfz buildroot_openlinux_kernel_4.9_fbdev_20180706.tar.gz buildroot_openlinux_kernel_4.9_fbdev_20180706/bootloader
+ > export BRDIR=$PWD/buildroot_openlinux_kernel_4.9_fbdev_20180706
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
diff --git a/board/amlogic/u200/u200.c b/board/amlogic/u200/u200.c
new file mode 100644
index 0000000000..94ee3ce6e4
--- /dev/null
+++ b/board/amlogic/u200/u200.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <environment.h>
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
+	return 0;
+}
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
new file mode 100644
index 0000000000..c351913f0e
--- /dev/null
+++ b/configs/u200_defconfig
@@ -0,0 +1,40 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" u200"
+CONFIG_DEBUG_UART=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-u200"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ADDR=8
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.21.0

