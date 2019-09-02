From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 2/4] configs: Add Khadas VIM3 defconfig
Date: Mon,  2 Sep 2019 14:19:08 +0200
Message-Id: <20190902121914.18946-3-afaerber@suse.de>
In-Reply-To: <20190902121914.18946-1-afaerber@suse.de>
References: <20190902121914.18946-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <u-boot-amlogic@groups.io>

Derived from odroid-n2_defconfig and README.odroid-n2.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 v1 -> v2:
 * Fixed branch name in README
=20
 board/amlogic/w400/MAINTAINERS        |   1 +
 board/amlogic/w400/README.khadas-vim3 | 132 ++++++++++++++++++++++++++++=
++++++
 configs/khadas-vim3_defconfig         |  54 ++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 board/amlogic/w400/README.khadas-vim3
 create mode 100644 configs/khadas-vim3_defconfig

diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAIN=
ERS
index 6e68fa73f7..3b21f50367 100644
--- a/board/amlogic/w400/MAINTAINERS
+++ b/board/amlogic/w400/MAINTAINERS
@@ -3,4 +3,5 @@ M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/w400/
+F:	configs/khadas-vim3_defconfig
 F:	configs/odroid-n2_defconfig
diff --git a/board/amlogic/w400/README.khadas-vim3 b/board/amlogic/w400/R=
EADME.khadas-vim3
new file mode 100644
index 0000000000..45ef90c1b0
--- /dev/null
+++ b/board/amlogic/w400/README.khadas-vim3
@@ -0,0 +1,132 @@
+U-Boot for Khadas VIM3
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ > export ARCH=3Darm
+ > export CROSS_COMPILE=3Daarch64-none-elf-
+ > make khadas-vim3_defconfig
+ > make
+
+Image creation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Amlogic doesn't provide sources for the firmware and for tools needed
+to create the bootloader image, so it is necessary to obtain them from
+the git tree published by the board vendor:
+
+ > wget https://releases.linaro.org/archive/13.11/components/toolchain/b=
inaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+ > wget https://releases.linaro.org/archive/13.11/components/toolchain/b=
inaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+ > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+ > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+ > export PATH=3D$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:=
$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
+
+ > DIR=3Dvim3-u-boot
+ > git clone --depth 1 \
+       https://github.com/khadas/u-boot.git -b khadas-vims-v2015.01 \
+       $DIR
+
+ > cd vim3-u-boot
+ > make kvim3_defconfig
+ > make
+ > export UBOOTDIR=3D$PWD
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
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bi=
n \
+					--output fip/bl30_new.bin.g12a.enc \
+					--level v3
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin=
.g12a.enc \
+					--output fip/bl30_new.bin.enc \
+					--level v3 --type bl30
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
+					--output fip/bl31.img.enc \
+					--level v3 --type bl31
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --c=
ompress lz4 \
+					--output fip/bl33.bin.enc \
+					--level v3 --type bl33 --compress lz4
+ > $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin =
\
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
+ > DEV=3D/dev/your_sd_device
+ > dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D512=
 skip=3D1 seek=3D1
+ > dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D1 c=
ount=3D444
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfi=
g
new file mode 100644
index 0000000000..cd37f7840e
--- /dev/null
+++ b/configs/khadas-vim3_defconfig
@@ -0,0 +1,54 @@
+CONFIG_ARM=3Dy
+CONFIG_SYS_BOARD=3D"w400"
+CONFIG_ARCH_MESON=3Dy
+CONFIG_SYS_TEXT_BASE=3D0x01000000
+CONFIG_MESON_G12A=3Dy
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_DEBUG_UART_BASE=3D0xff803000
+CONFIG_DEBUG_UART_CLOCK=3D24000000
+CONFIG_IDENT_STRING=3D" khadas-vim3"
+CONFIG_DEBUG_UART=3Dy
+CONFIG_OF_BOARD_SETUP=3Dy
+CONFIG_MISC_INIT_R=3Dy
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=3Dy
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_USB=3Dy
+CONFIG_CMD_USB_MASS_STORAGE=3Dy
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=3Dy
+CONFIG_OF_CONTROL=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"meson-g12b-a311d-khadas-vim3"
+CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_DM_GPIO=3Dy
+CONFIG_DM_MMC=3Dy
+CONFIG_MMC_MESON_GX=3Dy
+CONFIG_PHY_REALTEK=3Dy
+CONFIG_DM_ETH=3Dy
+CONFIG_ETH_DESIGNWARE=3Dy
+CONFIG_MESON_G12A_USB_PHY=3Dy
+CONFIG_PINCTRL=3Dy
+CONFIG_PINCTRL_MESON_G12A=3Dy
+CONFIG_DM_REGULATOR=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
+CONFIG_DM_RESET=3Dy
+CONFIG_DEBUG_UART_MESON=3Dy
+CONFIG_DEBUG_UART_ANNOUNCE=3Dy
+CONFIG_DEBUG_UART_SKIP_INIT=3Dy
+CONFIG_MESON_SERIAL=3Dy
+CONFIG_USB=3Dy
+CONFIG_DM_USB=3Dy
+CONFIG_USB_XHCI_HCD=3Dy
+CONFIG_USB_XHCI_DWC3=3Dy
+CONFIG_USB_DWC3=3Dy
+CONFIG_USB_DWC3_MESON_G12A=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=3D0xfada
+CONFIG_USB_GADGET_DWC2_OTG=3Dy
+CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=3Dy
+CONFIG_USB_GADGET_DOWNLOAD=3Dy
+CONFIG_OF_LIBFDT_OVERLAY=3Dy
--=20
2.16.4

