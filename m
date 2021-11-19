Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.6943.1637316521739804302
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Nov 2021 02:08:42 -0800
Received: by mail-wr1-f50.google.com with SMTP id a9so17203970wrr.8
        for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 02:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2xXssXfHPh0Q/egzTqFlJ+k4Rdilro10UK4HmAa1Ju8=;
        b=HFKaE1tmUJANZ85Pqd/vbqZHm2lTIOwZ8aQaZIDmIj07BPiLAr3ei1spIGh9viRyGC
         M/4+hk3di4tplqojbQ7hTmdOfzhWUIoNmYEsudAEjoGe+n7MbdC2skiWlmzAWhNeOnIM
         QpAKIUDTqANZ6KdeqXJcqtHoeJSx7ZOwg7E+5cy3OR8loyHASzb5gOAAfC3FSe6yvkE/
         WEn+VwT6khv/g54QWxa9N7cUbL4ur3kxkt5+yhIH1J0Hb1Wbv4K2Di/abEN0/B0Q43Kw
         OcV5wCYYkB3A06KjMMCXJQ966+ApsltLoM9Gqmvr922TNqeuyJVOfGL5xwYfcnVftuoB
         AJMw==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 2/5] configs: prepare khadas-vim3{l}_android for AOSP support
Date: Fri, 19 Nov 2021 11:08:26 +0100
Message-Id: <20211119100829.843139-3-mkorpershoek@baylibre.com>
In-Reply-To: <20211119100829.843139-1-mkorpershoek@baylibre.com>
References: <20211119100829.843139-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Khadas VIM3 and VIM3L board are well supported in AOSP[1].
However, there is no mainline U-Boot support for it.
The U-Boot used in AOSP is based on a vendor tree [2]

Add a special defconfig for each board to allow booting Android.

Note: this is a copy-paste of khadas-vim3{l}_defconfig (commit
49c8ef0e45a91ec894ef15e7d043dafe8f1c5efd) and will be updated
in future commits.

[1] https://source.android.com/setup/build/devices#vim3_and_vim3l_boards
[2] https://gitlab.com/baylibre/amlogic/atv/u-boot
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 board/amlogic/vim3/MAINTAINERS         |  2 +
 configs/khadas-vim3_android_defconfig  | 95 ++++++++++++++++++++++++++
 configs/khadas-vim3l_android_defconfig | 95 ++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 configs/khadas-vim3_android_defconfig
 create mode 100644 configs/khadas-vim3l_android_defconfig

diff --git a/board/amlogic/vim3/MAINTAINERS b/board/amlogic/vim3/MAINTAINERS
index 92b426f66d..e185d80ce1 100644
--- a/board/amlogic/vim3/MAINTAINERS
+++ b/board/amlogic/vim3/MAINTAINERS
@@ -4,6 +4,8 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/vim3/
 F:	configs/khadas-vim3_defconfig
+F:	configs/khadas-vim3_android_defconfig
 F:	configs/khadas-vim3l_defconfig
+F:	configs/khadas-vim3l_android_defconfig
 F:	doc/board/amlogic/khadas-vim3.rst
 F:	doc/board/amlogic/khadas-vim3l.rst
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
new file mode 100644
index 0000000000..a225a564b2
--- /dev/null
+++ b/configs/khadas-vim3_android_defconfig
@@ -0,0 +1,95 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="vim3"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" khadas-vim3"
+CONFIG_DEBUG_UART=y
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_NVME=y
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
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_USB=y
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
+CONFIG_DM_VIDEO=y
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
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
new file mode 100644
index 0000000000..9d94c31891
--- /dev/null
+++ b/configs/khadas-vim3l_android_defconfig
@@ -0,0 +1,95 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="vim3"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" khadas-vim3l"
+CONFIG_DEBUG_UART=y
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_NVME=y
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
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_USB=y
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
+CONFIG_DM_VIDEO=y
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
-- 
2.32.0

