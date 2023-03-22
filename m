Subject: [PATCHv2 2/3] ARM: meson: Add initial support for beelink gt1
From: exkc_maillist@list.ru
MIME-Version: 1.0
Date: Wed, 22 Mar 2023 12:19:16 -0700
Message-ID: <M5Yp.1679512756605742819.bwvE@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add initial support for beelink gt1

Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>

---

This patch is base on this patch from in pm os .

https://gitlab.com/postmarketOS/pmaports/-/blob/master/device/testing/u-boo=
t-beelink-gt1/0001-add-basic-support-for-beelink-gt1.patch

---

 .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
 arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
 board/amlogic/q200/MAINTAINERS                |  2 +
 configs/beelink_gt1_ultimate_defconfig        | 85 +++++++++++++++++
 doc/board/amlogic/beelink-gt1.rst             | 65 +++++++++++++
 doc/board/amlogic/index.rst                   |  3 +-
 6 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
 create mode 100644 configs/beelink_gt1_ultimate_defconfig
 create mode 100644 doc/board/amlogic/beelink-gt1.rst

diff --git a/configs/beelink_gt1_ultimate_defconfig b/configs/beelink_gt1_u=
ltimate_defconfig
new file mode 100644
index 000000000000..b5ed30fab412
--- /dev/null
+++ b/configs/beelink_gt1_ultimate_defconfig
@@ -0,0 +1,85 @@
+CONFIG_ARM=3Dy
+CONFIG_ARCH_MESON=3Dy
+CONFIG_TEXT_BASE=3D0x01000000
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
+CONFIG_ENV_SIZE=3D0x10000
+CONFIG_ENV_OFFSET=3D0xFFFF0000
+CONFIG_ENV_SECT_SIZE=3D0x10000
+CONFIG_DM_GPIO=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxm-gt1-ultimate"
+CONFIG_DM_RESET=3Dy
+CONFIG_MESON_GXM=3Dy
+CONFIG_DEBUG_UART_BASE=3D0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=3D24000000
+CONFIG_IDENT_STRING=3D" gt1-ultimate"
+CONFIG_SYS_LOAD_ADDR=3D0x1000000
+CONFIG_DEBUG_UART=3Dy
+CONFIG_REMAKE_ELF=3Dy
+CONFIG_OF_BOARD_SETUP=3Dy
+CONFIG_USE_PREBOOT=3Dy
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=3Dy
+CONFIG_SYS_MAXARGS=3D32
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=3Dy
+CONFIG_CMD_GPIO=3Dy
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_SF_TEST=3Dy
+CONFIG_CMD_SPI=3Dy
+CONFIG_CMD_USB=3Dy
+CONFIG_CMD_USB_MASS_STORAGE=3Dy
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=3Dy
+CONFIG_OF_CONTROL=3Dy
+CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
+CONFIG_SARADC_MESON=3Dy
+CONFIG_MMC_MESON_GX=3Dy
+CONFIG_MTD=3Dy
+CONFIG_DM_SPI_FLASH=3Dy
+CONFIG_SPI_FLASH_GIGADEVICE=3Dy
+CONFIG_PHY_REALTEK=3Dy
+CONFIG_DM_MDIO=3Dy
+CONFIG_DM_MDIO_MUX=3Dy
+CONFIG_ETH_DESIGNWARE_MESON8B=3Dy
+CONFIG_MDIO_MUX_MMIOREG=3Dy
+CONFIG_MESON_GXL_USB_PHY=3Dy
+CONFIG_PINCTRL=3Dy
+CONFIG_PINCTRL_MESON_GXL=3Dy
+CONFIG_POWER_DOMAIN=3Dy
+CONFIG_MESON_EE_POWER_DOMAIN=3Dy
+CONFIG_DM_REGULATOR=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
+CONFIG_DEBUG_UART_ANNOUNCE=3Dy
+CONFIG_DEBUG_UART_SKIP_INIT=3Dy
+CONFIG_MESON_SERIAL=3Dy
+CONFIG_SPI=3Dy
+CONFIG_DM_SPI=3Dy
+CONFIG_MESON_SPIFC=3Dy
+CONFIG_USB=3Dy
+CONFIG_DM_USB_GADGET=3Dy
+CONFIG_USB_XHCI_HCD=3Dy
+CONFIG_USB_XHCI_DWC3=3Dy
+CONFIG_USB_DWC3=3Dy
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_GXL=3Dy
+CONFIG_USB_KEYBOARD=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=3D0xfada
+CONFIG_USB_GADGET_DWC2_OTG=3Dy
+CONFIG_USB_GADGET_DOWNLOAD=3Dy
+CONFIG_VIDEO=3Dy
+CONFIG_SYS_WHITE_ON_BLACK=3Dy
+CONFIG_VIDEO_MESON=3Dy
+CONFIG_VIDEO_DT_SIMPLEFB=3Dy
+CONFIG_SPLASH_SCREEN=3Dy
+CONFIG_SPLASH_SCREEN_ALIGN=3Dy
+CONFIG_VIDEO_BMP_RLE8=3Dy
+CONFIG_BMP_16BPP=3Dy
+CONFIG_BMP_24BPP=3Dy
+CONFIG_BMP_32BPP=3Dy
+CONFIG_OF_LIBFDT_OVERLAY=3Dy
--
2.39.1
