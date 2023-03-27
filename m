Received: from sonic311-3.consmr.mail.sg3.yahoo.com (sonic311-3.consmr.mail.sg3.yahoo.com [106.10.244.180])
 by mx.groups.io with SMTP id smtpd.web11.41314.1679936124229860292
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Mar 2023 09:55:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679936121; bh=ipyg24XffIVWZtCDa+KZ5TwS0gll3+CKIc4/CQsTQwM=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=nE/VFjWuP2G6W+xVXVDhMd97pcC43yAsqzsjkfCjZd+wXU9Xc5FGOssfllqmnUbUsQIACg5gbzXSHKwiRdqXwJkAVQ9n3wGBngmxXQXJ+0wLv3dI5tXzXRNQVePELxlHtPDj9tC6uOquMCLPlakURyuBvnbuXLnWtKKiWETRAk/Tq8eQzzjFlUdOYBbYnO7pBZwONUatHMBNt1n5dZV1sqfUwYNys42GwOBafSDqPDVB3gOvR6agL+hFbQg6pXhx5Q82iN93BxZIfmuIF+ESidrWGRknMBQUJ+qTkoKgY/Z7U5w0sdkO87qRCzw+9W2ABs9rOd7cMGO2nMqiJ43ZVg==
Message-ID: <5ccea814-bf90-68c2-2f82-ed77ac9f7b0d@yahoo.com>
Date: Tue, 28 Mar 2023 04:06:38 +0800
MIME-Version: 1.0
From: "Karl Chan" <exkcmailist@yahoo.com>
Subject: [RESENT][PATCHv7 2/3] boards: amlogic: add Beelink GT1 Ultimate defconfig
References: <5ccea814-bf90-68c2-2f82-ed77ac9f7b0d.ref@yahoo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add configuration for the Beelink GT1 Ultimate board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
---
  configs/beelink-gt1-ultimate_defconfig | 78 ++++++++++++++++++++++++++
  1 file changed, 78 insertions(+)
  create mode 100644 configs/beelink-gt1-ultimate_defconfig

diff --git a/configs/beelink-gt1-ultimate_defconfig 
b/configs/beelink-gt1-ultimate_defconfig
new file mode 100644
index 0000000000..4ec76cb9af
--- /dev/null
+++ b/configs/beelink-gt1-ultimate_defconfig
@@ -0,0 +1,78 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-gt1-ultimate"
+CONFIG_DM_RESET=y
+CONFIG_MESON_GXM=y
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" beelink-gt1"
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_DEBUG_UART=y
+CONFIG_REMAKE_ELF=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_SYS_MAXARGS=32
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MMIOREG=y
+CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXL=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_GXL=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_VIDEO=y
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
