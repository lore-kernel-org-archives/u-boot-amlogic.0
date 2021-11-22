Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.7626.1637594538572322598
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 07:22:19 -0800
Received: by mail-wm1-f46.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso17113799wmr.4
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXffb14r2MCjzP1T/jNxvDHPgQkjLmjkQRluCd91ENI=;
        b=LKoQMUpL2bRhZXV9Qb9Pxlos53IEm2A2rbsRcwSu+16xeRqM45mSxIfe2iWN28V16G
         bP4Qmr+60z9rH+uv6Rm5foFAThqs9s43hErBMFjflI4zPmEHXPzZUhAaVmomwrEHrxZa
         tzpO7NJZM1JOKbhXx+izY/Mw+LyDd+67WndIFtdUXJQedddiDcvZh+yKEkWbRUAY50Zm
         oFEKxbnv6M1H6NArNuISGlyCEly817Q6unQY9TiZ7eh76PT30G65i+8X3Wv0RmT9XNbf
         VMl784GsRpHWB9eLjYfws/sXWpE/DBJaJYnci0epvFK1H56cSffcMkxL2gvqR2YXYdCk
         Fv1w==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 3/4] configs: prepare khadas-vim3{l}_ab_android for AOSP support
Date: Mon, 22 Nov 2021 16:22:06 +0100
Message-Id: <20211122152207.219023-4-mkorpershoek@baylibre.com>
In-Reply-To: <20211122152207.219023-1-mkorpershoek@baylibre.com>
References: <20211122152207.219023-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

In AOSP, both VIM3 and VIM3L have 2 bootloader flavors,
depending on A/B enablement.

For example, for vim3l, the naming is:
- u-boot_kvim3l_noab.bin : legacy support
- u-boot_kvim3l_ab.bin   : A/B support

Prepare a defconfig to support u-boot_kvim3_ab.bin and
u-boot_kvim3l_ab.bin.

This is identical to khadas-vim3{l}_ab_android but will be updated in
the next commit.

Also update partitioning tables for A/B support.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 board/amlogic/vim3/MAINTAINERS            |   2 +
 configs/khadas-vim3_android_ab_defconfig  | 107 ++++++++++++++++++++++
 configs/khadas-vim3l_android_ab_defconfig | 107 ++++++++++++++++++++++
 include/configs/khadas-vim3_android.h     |  16 ++++
 include/configs/khadas-vim3l_android.h    |  16 ++++
 5 files changed, 248 insertions(+)
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
diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index a6f6dd0a7a..da6adf6c41 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -12,6 +12,21 @@
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
+#if defined(CONFIG_CMD_AB_SELECT)
+#define PARTS_DEFAULT \
+	"uuid_disk=${uuid_gpt_disk};" \
+	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
+	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
+	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
+	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
+	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
+	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
+	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
+	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
+	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
+	"name=rootfs,size=-,uuid=" ROOT_UUID
+#else
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
@@ -24,6 +39,7 @@
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
+#endif
 
 #define EXTRA_ANDROID_ENV_SETTINGS \
 	"board=vim3\0" \
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index 7affc3e448..b1768e2d82 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -12,6 +12,21 @@
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
+#if defined(CONFIG_CMD_AB_SELECT)
+#define PARTS_DEFAULT \
+	"uuid_disk=${uuid_gpt_disk};" \
+	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
+	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
+	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
+	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
+	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
+	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
+	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
+	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
+	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
+	"name=rootfs,size=-,uuid=" ROOT_UUID
+#else
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
@@ -24,6 +39,7 @@
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
+#endif
 
 #define EXTRA_ANDROID_ENV_SETTINGS \
 	"board=vim3l\0" \
-- 
2.32.0

