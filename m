Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.5220.1570629845382506133
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2019 07:04:05 -0700
Received: by mail-wr1-f68.google.com with SMTP id b9so3207954wrs.0
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2019 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGxRYMuJj1a92VJwi847jNJ5Ctuv3yif3Fh6oXff4zk=;
        b=u8sBWDytQV/e34sJhUYwRbDM9o4bder7ke2hidMsntcbT+OVcxDOVOWSatZszlkipk
         FMXTiHHOabXVcFe37nfwVk48WJLBdy2Y68XQ8bTzdPI1fi9tgjHnS/vUOGCu8GzmiDgD
         hdDVCO+h6EKEGohMMGmc5yP300M9lXeStTi3Cdpy1unBNOoVAOsy4HYOzPktYS5T2ij4
         NIzs+V7oNamk4Pl0aAdeiTxenZqleTVIzJgVkupjBLlIEdLoeHxEa1btNRYjxk5Udbtl
         dwfreBPXa3GB4hal+dk8WFTzNtEefRl6xdO3i+MB264Y/0tnfyt9Hsymh9oxANXZSdJj
         aBrw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 2/4] configs: Add Khadas VIM3 defconfig
Date: Wed,  9 Oct 2019 16:03:55 +0200
Message-Id: <20191009140357.27279-3-narmstrong@baylibre.com>
In-Reply-To: <20191009140357.27279-1-narmstrong@baylibre.com>
References: <20191009140357.27279-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: afaerber@suse.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Andreas Färber <afaerber@suse.de>

Derived from odroid-n2_defconfig and README.odroid-n2.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/w400/MAINTAINERS        |   1 +
 board/amlogic/w400/README.khadas-vim3 | 132 ++++++++++++++++++++++++++
 configs/khadas-vim3_defconfig         |  54 +++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 board/amlogic/w400/README.khadas-vim3
 create mode 100644 configs/khadas-vim3_defconfig

diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
index 6e68fa73f7..3b21f50367 100644
--- a/board/amlogic/w400/MAINTAINERS
+++ b/board/amlogic/w400/MAINTAINERS
@@ -3,4 +3,5 @@ M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/w400/
+F:	configs/khadas-vim3_defconfig
 F:	configs/odroid-n2_defconfig
diff --git a/board/amlogic/w400/README.khadas-vim3 b/board/amlogic/w400/README.khadas-vim3
new file mode 100644
index 0000000000..45ef90c1b0
--- /dev/null
+++ b/board/amlogic/w400/README.khadas-vim3
@@ -0,0 +1,132 @@
+U-Boot for Khadas VIM3
+======================
+
+Khadas VIM3 is a single board computer manufactured by Shenzhen Wesion
+Technology Co., Ltd. with the following specifications:
+
+ - Amlogic A311D Arm Cortex-A53 dual-core + Cortex-A73 quad-core SoC
+ - 4GB LPDDR4 SDRAM
+ - Gigabit Ethernet
+ - HDMI 2.1 display
+ - 40-pin GPIO header
+ - 1 x USB 3.0 Host, 1 x USB 2.0 Host
+ - eMMC, microSD
+ - M.2
+ - Infrared receiver
+
+Schematics are available on the manufacturer website.
+
+Currently the U-Boot port supports the following devices:
+ - serial
+ - eMMC, microSD
+ - Ethernet
+ - I2C
+ - Regulators
+ - Reset controller
+ - Clock controller
+ - ADC
+
+u-boot compilation
+==================
+
+ > export ARCH=arm
+ > export CROSS_COMPILE=aarch64-none-elf-
+ > make khadas-vim3_defconfig
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
+
+ > DIR=vim3-u-boot
+ > git clone --depth 1 \
+       https://github.com/khadas/u-boot.git -b khadas-vims-v2015.01 \
+       $DIR
+
+ > cd vim3-u-boot
+ > make kvim3_defconfig
+ > make
+ > export UBOOTDIR=$PWD
+
+ Go back to mainline U-Boot source tree then :
+ > mkdir fip
+
+ > cp $UBOOTDIR/build/scp_task/bl301.bin fip/
+ > cp $UBOOTDIR/build/board/khadas/kvim3/firmware/acs.bin fip/
+ > cp $UBOOTDIR/fip/g12b/bl2.bin fip/
+ > cp $UBOOTDIR/fip/g12b/bl30.bin fip/
+ > cp $UBOOTDIR/fip/g12b/bl31.img fip/
+ > cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
+ > cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
+ > cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
+ > cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
+ > cp $UBOOTDIR/fip/g12b/lpddr3_1d.fw fip/
+ > cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
+ > cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
+ > cp $UBOOTDIR/fip/g12b/piei.fw fip/
+ > cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
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
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
+					--output fip/bl30_new.bin.g12a.enc \
+					--level v3
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
+					--output fip/bl30_new.bin.enc \
+					--level v3 --type bl30
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
+					--output fip/bl31.img.enc \
+					--level v3 --type bl31
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
+					--output fip/bl33.bin.enc \
+					--level v3 --type bl33 --compress lz4
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
+					--output fip/bl2.n.bin.sig
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
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
+		--ddrfw8 fip/aml_ddr.fw \
+		--ddrfw9 fip/lpddr3_1d.fw \
+		--level v3
+
+and then write the image to SD with:
+
+ > DEV=/dev/your_sd_device
+ > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+ > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
new file mode 100644
index 0000000000..cd37f7840e
--- /dev/null
+++ b/configs/khadas-vim3_defconfig
@@ -0,0 +1,54 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="w400"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_G12A=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" khadas-vim3"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
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
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
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
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.22.0

