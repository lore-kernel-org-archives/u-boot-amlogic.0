Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web09.7064.1637316523127344973
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Nov 2021 02:08:43 -0800
Received: by mail-wm1-f48.google.com with SMTP id o29so7963697wms.2
        for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 02:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=efOGWcS6aFJ8laoI+K48LcWL3Z6SlzWxPe48MqD4zyw=;
        b=1fVYnwF6vBe0VCkawivxIQsrnF+0JKpTNEMQpO3B6UFDlMsX1tzNJh7GhWBHxN1+ix
         QE3B7J4MsjQujm2H73lTMl3oAP9j8YGqC8M8f1pAuQ8nYLkpdVjv2UB0FQ6u6SImOnN1
         tBZ0iuwg1v/snPKo5j55lN21wO3/4O5QubbywwwXs2cEwJPgY7jsoBqqpHjWhmlyTNia
         P18sZmGROX6amU5BIddxSeZItjeZHfYcmfMn+2Ks7KMJLa2udGSSegIKbByGGRGFvMVF
         5bd0jItyUhDJjxICklfcs/NHeoxzoMSWCcEGOLm9+JgHUi8oHiiWVmSzqMgPTpnMLFgJ
         O0Tg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 4/5] configs: prepare khadas-vim3{l}_ab_android for AOSP support
Date: Fri, 19 Nov 2021 11:08:28 +0100
Message-Id: <20211119100829.843139-5-mkorpershoek@baylibre.com>
In-Reply-To: <20211119100829.843139-1-mkorpershoek@baylibre.com>
References: <20211119100829.843139-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

In AOSP, the bot VIM3 and VIM3L have 2 bootloader flavors,
depending on A/B enablement.

For example, for vim3l, the naming is:
- u-boot_kvim3l_noab.bin : legacy support
- u-boot_kvim3l_ab.bin   : A/B support

Prepare a defconfig to support u-boot_kvim3_ab.bin and
u-boot_kvim3l_ab.bin.

This is identical to khadas-vim3{l}_ab_android but will be updated in the
next commit.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 board/amlogic/vim3/MAINTAINERS            |   2 +
 configs/khadas-vim3_android_ab_defconfig  | 107 ++++++++++++++++++++++
 configs/khadas-vim3l_android_ab_defconfig | 107 ++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 configs/khadas-vim3_android_ab_defconfig
 create mode 100644 configs/khadas-vim3l_android_ab_defconfig

diff --git a/board/amlogic/vim3/MAINTAINERS b/board/amlogic/vim3/MAINTAINERS
index e185d80ce1..d8848495c7 100644
--- a/board/amlogic/vim3/MAINTAINERS
+++ b/board/amlogic/vim3/MAINTAINERS
@@ -5,7 +5,9 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/vim3/
 F:	configs/khadas-vim3_defconfig
 F:	configs/khadas-vim3_android_defconfig
+F:	configs/khadas-vim3_android_ab_defconfig
 F:	configs/khadas-vim3l_defconfig
 F:	configs/khadas-vim3l_android_defconfig
+F:	configs/khadas-vim3l_android_ab_defconfig
 F:	doc/board/amlogic/khadas-vim3.rst
 F:	doc/board/amlogic/khadas-vim3l.rst
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
new file mode 100644
index 0000000000..9305a54b1b
--- /dev/null
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -0,0 +1,107 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="vim3"
+CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x10000
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
+CONFIG_AVB_VERIFY=y
+# CONFIG_CMD_BDI is not set
+CONFIG_CMD_ADTIMG=y
+CONFIG_CMD_ABOOTIMG=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_BCB=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
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
+CONFIG_CMD_AVB=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x6000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
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
+CONFIG_LIBAVB=y
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
new file mode 100644
index 0000000000..5eed79b263
--- /dev/null
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -0,0 +1,107 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="vim3"
+CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x10000
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
+CONFIG_AVB_VERIFY=y
+# CONFIG_CMD_BDI is not set
+CONFIG_CMD_ADTIMG=y
+CONFIG_CMD_ABOOTIMG=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_BCB=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
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
+CONFIG_CMD_AVB=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x6000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
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
+CONFIG_LIBAVB=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.32.0

