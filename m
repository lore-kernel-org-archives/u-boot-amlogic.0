Received: by mail-wm1-f66.google.com with SMTP id y197so4521915wmd.0
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFyKg61pqgtziaxpbonOGLguHYXY5cWqt1Y0Q//ToaA=;
        b=Bg8Ic8xIwoNFEFHx8IXAMI3CF9v4dT87Ud11PxeySIayktjhgFJyn+6qOThvfwSujo
         MXT80/kohlcBOM8M3/oXhP0VI4KYxPBwTlqX+GqQBKevU8mU6PICb6D2pJ6NOAzyrqHV
         1tJwbGIaCHaOm9EByGvjmx7s7z6Y9pNhuAUCBtZMyV2cJTE9ni2lJI2MHo3VjCji1q9t
         ezjstV48V1tS4qKyiruMNl14BuCXlUcIqcbaScW7Zcb1vyvLCagktOlaKVr6unJCo7m9
         TSgmgdgIrkSUehQSIaCquYlnnqlXfyeTG409uy5jT220UEQc7QxsxULBJoIa31Eq7H4Z
         woLQ==
Return-Path: <mohammad.rasim96@gmail.com>
From: "Mohammad Rasim" <mohammad.rasim96@gmail.com>
Subject: [PATCH v5 4/5] ARM: board: meson: add p200 board
Date: Sat, 23 Mar 2019 14:55:08 +0300
Message-Id: <20190323115508.3540-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, narmstrong@baylibre.com, jbrunet@baylibre.com
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This adds the defconfig and README files for p200 board

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/p200/MAINTAINERS |   1 +
 board/amlogic/p200/README.p200 | 103 +++++++++++++++++++++++++++++++++
 configs/p200_defconfig         |  41 +++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 board/amlogic/p200/README.p200
 create mode 100644 configs/p200_defconfig

diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
index 77a055b681d9..96fe92dd0874 100644
--- a/board/amlogic/p200/MAINTAINERS
+++ b/board/amlogic/p200/MAINTAINERS
@@ -5,3 +5,4 @@ S:	Maintained
 F:	board/amlogic/p200/
 F:	configs/nanopi-k2_defconfig
 F:	configs/odroid-c2_defconfig
+F:	configs/p200_defconfig
diff --git a/board/amlogic/p200/README.p200 b/board/amlogic/p200/README.p200
new file mode 100644
index 000000000000..01d82d1e79e3
--- /dev/null
+++ b/board/amlogic/p200/README.p200
@@ -0,0 +1,103 @@
+U-Boot for Amlogic P200
+=======================
+
+P200 is a reference board manufactured by Amlogic with the following
+specifications:
+
+ - Amlogic S905 ARM Cortex-A53 quad-core SoC @ 1.5GHz
+ - ARM Mali 450 GPU
+ - 2GB DDR3 SDRAM
+ - Gigabit Ethernet
+ - HDMI 2.0 4K/60Hz display
+ - 2 x USB 2.0 Host
+ - eMMC, microSD
+ - Infrared receiver
+ - SDIO WiFi Module
+ - CVBS+Stereo Audio Jack
+
+Schematics are available from Amlogic on demand.
+
+Currently the u-boot port supports the following devices:
+ - serial
+ - eMMC, microSD
+ - Ethernet
+ - I2C
+ - Regulators
+ - Reset controller
+ - Clock controller
+ - USB Host
+ - ADC
+
+u-boot compilation
+==================
+
+ > export ARCH=arm
+ > export CROSS_COMPILE=aarch64-none-elf-
+ > make p200_defconfig
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
+ > git clone https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
+ > cd amlogic-u-boot
+ > make gxb_p200_v1_defconfig
+ > make
+ > export FIPDIR=$PWD/fip
+
+Go back to mainline U-boot source tree then :
+ > mkdir fip
+
+ > cp $FIPDIR/gxl/bl2.bin fip/
+ > cp $FIPDIR/gxl/acs.bin fip/
+ > cp $FIPDIR/gxl/bl21.bin fip/
+ > cp $FIPDIR/gxl/bl30.bin fip/
+ > cp $FIPDIR/gxl/bl301.bin fip/
+ > cp $FIPDIR/gxl/bl31.img fip/
+ > cp u-boot.bin fip/bl33.bin
+
+ > $FIPDIR/blx_fix.sh \
+	fip/bl30.bin \
+	fip/zero_tmp \
+	fip/bl30_zero.bin \
+	fip/bl301.bin \
+	fip/bl301_zero.bin \
+	fip/bl30_new.bin \
+	bl30
+
+ > $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+
+ > $FIPDIR/blx_fix.sh \
+	fip/bl2_acs.bin \
+	fip/zero_tmp \
+	fip/bl2_zero.bin \
+	fip/bl21.bin \
+	fip/bl21_zero.bin \
+	fip/bl2_new.bin \
+	bl2
+
+ > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
+ > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl31.img
+ > $FIPDIR/gxl/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
+ > $FIPDIR/gxl/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
+ > $FIPDIR/gxl/aml_encrypt_gxl --bootmk \
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
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
new file mode 100644
index 000000000000..3980e4eb5f1d
--- /dev/null
+++ b/configs/p200_defconfig
@@ -0,0 +1,41 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" p200"
+CONFIG_DEBUG_UART=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXBB=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_BOARD="p200"
--
2.21.0

