Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web09.7767.1637594538078252227
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 07:22:18 -0800
Received: by mail-wm1-f54.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so139657wmd.1
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9VH9vJ0zuFREPPxeoiZUFQcbeP3ci2FcA/XWupJ8n8=;
        b=P5PHsiJEdtgBpRmMXVoXL3OGXd46ClEUl/nE+7IH8T4gNaboOLjwYPiFghhCIt30gk
         relZujz/ZqmG7N9QU+wRcfnafGjlrnEl20OIB9COPPAQGuIBZ5oLXm6mGsuCjP8F6+Mw
         DwxeGH7evxtUrDKrnwwEtOFW4v9I1rLcq2Kg42Leykkuzrx7HGdmoTIdKAiZXU/YlpYE
         M83r1wJojnTED5X2M9ROH5QptWScPiuSq0QewWlVRYUGX8BRyNR3m9zj8+DxOhHHHZHm
         g5G102C3yU/vVeGuZBV+VUuIS+jyOxLKtder3Pd6IhlXQ+MkrAlXy0uf7Xf2IFWJImDJ
         9QmQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 2/4] configs: add khadas-vim3{l}_android for AOSP support
Date: Mon, 22 Nov 2021 16:22:05 +0100
Message-Id: <20211122152207.219023-3-mkorpershoek@baylibre.com>
In-Reply-To: <20211122152207.219023-1-mkorpershoek@baylibre.com>
References: <20211122152207.219023-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Khadas VIM3 and VIM3L board are well supported in AOSP[1].
However, there is no mainline U-Boot support for it.
The U-Boot used in AOSP is based on a vendor tree [2]

Add all the necessary bits to flash and boot Android for both Khadas
VIM3 and VIM3L boards.

For Android instructions, refer to [1]

[1] https://source.android.com/setup/build/devices#vim3_and_vim3l_boards
[2] https://gitlab.com/baylibre/amlogic/atv/u-boot
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 board/amlogic/vim3/MAINTAINERS         |   2 +
 configs/khadas-vim3_android_defconfig  | 107 +++++++++++++++++++++++++
 configs/khadas-vim3l_android_defconfig | 107 +++++++++++++++++++++++++
 include/configs/khadas-vim3_android.h  |  34 ++++++++
 include/configs/khadas-vim3l_android.h |  34 ++++++++
 include/configs/meson64_android.h      |  12 +++
 6 files changed, 296 insertions(+)
 create mode 100644 configs/khadas-vim3_android_defconfig
 create mode 100644 configs/khadas-vim3l_android_defconfig
 create mode 100644 include/configs/khadas-vim3_android.h
 create mode 100644 include/configs/khadas-vim3l_android.h

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
index 0000000000..9305a54b1b
--- /dev/null
+++ b/configs/khadas-vim3_android_defconfig
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
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
new file mode 100644
index 0000000000..5eed79b263
--- /dev/null
+++ b/configs/khadas-vim3l_android_defconfig
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
new file mode 100644
index 0000000000..a6f6dd0a7a
--- /dev/null
+++ b/include/configs/khadas-vim3_android.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration for the khadas VIM3 Android
+ *
+ * Copyright (C) 2021 Baylibre, SAS
+ * Author: Guillaume LA ROQUE <glaroque@baylibre.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
+#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
+
+#define PARTS_DEFAULT \
+	"uuid_disk=${uuid_gpt_disk};" \
+	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
+	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
+	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
+	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
+	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
+	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
+	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
+	"name=rootfs,size=-,uuid=" ROOT_UUID
+
+#define EXTRA_ANDROID_ENV_SETTINGS \
+	"board=vim3\0" \
+	"board_name=vim3\0" \
+
+#include <configs/meson64_android.h>
+
+#endif /* __CONFIG_H */
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
new file mode 100644
index 0000000000..7affc3e448
--- /dev/null
+++ b/include/configs/khadas-vim3l_android.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration for the khadas VIM3L Android
+ *
+ * Copyright (C) 2021 Baylibre, SAS
+ * Author: Guillaume LA ROQUE <glaroque@baylibre.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
+#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
+
+#define PARTS_DEFAULT \
+	"uuid_disk=${uuid_gpt_disk};" \
+	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
+	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
+	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
+	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
+	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
+	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
+	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
+	"name=rootfs,size=-,uuid=" ROOT_UUID
+
+#define EXTRA_ANDROID_ENV_SETTINGS \
+	"board=vim3l\0" \
+	"board_name=vim3l\0" \
+
+#include <configs/meson64_android.h>
+
+#endif /* __CONFIG_H */
diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 56dc9fcb07..0303d187de 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -104,6 +104,12 @@
 	"elif test $board_name = sei610; then " \
 		"echo \"  Reading DTB for sei610...\"; " \
 		"setenv dtb_index 1;" \
+	"elif test $board_name = vim3l; then " \
+		"echo \"  Reading DTB for vim3l...\"; " \
+		"setenv dtb_index 2;" \
+	"elif test $board_name = vim3; then " \
+		"echo \"  Reading DTB for vim3...\"; " \
+		"setenv dtb_index 3;" \
 	"else " \
 		"echo Error: Android boot is not supported for $board_name; " \
 		"exit; " \
@@ -117,6 +123,12 @@
 	"elif test $board_name = sei610; then " \
 		"echo \"  Reading DTBO for sei610...\"; " \
 		"setenv dtbo_index 1;" \
+	"elif test $board_name = vim3l; then " \
+		"echo \"  Reading DTBO for vim3l...\"; " \
+		"setenv dtbo_index 2;" \
+	"elif test $board_name = vim3; then " \
+		"echo \"  Reading DTBO for vim3...\"; " \
+		"setenv dtbo_index 3;" \
 	"else " \
 		"echo Error: Android boot is not supported for $board_name; " \
 		"exit; " \
-- 
2.32.0

