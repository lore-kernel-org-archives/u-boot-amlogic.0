Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.66611.1679554508222717633
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Mar 2023 23:55:08 -0700
Received: by mail-wr1-f41.google.com with SMTP id i9so19324475wrp.3
        for <u-boot-amlogic@groups.io>; Wed, 22 Mar 2023 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679554506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXOHldVjiKihy6Mya07M2G4oF2hn7XlNIO9GH0IBmjI=;
        b=ARn2TaF/HoRk4igezYcsCbGy0bLgTg3Cu4aRfHrLP8RalDXJecW1cJmALLEZomfAig
         NZgz9OF3LxuHaZFTfgbELhJNGS1Lc7R2pMpbY2BBzHvqL768M+P2HJJU+nbn/4qiR71k
         U3dAv/wibOjzPJ+QCbA+IzKsoZFVJyvlB48PgHK1hpVSBXbUSqSOIYia/wVLN9sz40nh
         CbCM7jLOwJ8ZrRAxBNODbP67cHfy97BXkO9OldP+J2dy+4L25wYditjAOi6qVJ1SVUIp
         OkVka60cNzGftgZF1gNxBwCMyEM4soiivfyzzqWA8PpKcPAg6rnaVgakP7fpYFWKpU5q
         efWA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 03/13] boards: add BananaPi M2-Pro defconfig
Date: Thu, 23 Mar 2023 06:54:48 +0000
Message-Id: <20230323065458.776029-4-christianshewitt@gmail.com>
In-Reply-To: <20230323065458.776029-1-christianshewitt@gmail.com>
References: <20230323065458.776029-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Add configuration for the BananaPi M2-Pro board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 configs/bananapi-m2-pro_defconfig | 76 +++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 configs/bananapi-m2-pro_defconfig

diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
new file mode 100644
index 0000000000..28b603fe20
--- /dev/null
+++ b/configs/bananapi-m2-pro_defconfig
@@ -0,0 +1,76 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m2-pro"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING="bpi-m2-pro"
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_DEBUG_UART=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
+CONFIG_REMAKE_ELF=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_SYS_MAXARGS=32
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
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
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
-- 
2.34.1

