Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web09.7270.1608281157470046632
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 00:45:57 -0800
Received: by mail-wr1-f41.google.com with SMTP id r7so1245796wrc.5
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 00:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4a9d42Ugfhu8lYfBL9bKXO26rwaj2hx/JHFij18RrU=;
        b=cUYVGDBv9X/tu64a2ATpz2xE7pXNVV+pLEA3sKGVIywmnq1MxK/5z8uquliFz2X0ix
         ku8Z7EwbtcYxN7+v3faeI6MxsUWpJXPj4ppwHobRpjgLeVnkXFnWsPqPs3BuL9pxr8EK
         2ADs0swsN0KmrOmsLR54qzXXHBO0osbvMiHkVYj1PV7jDZIWdHc8cUHKcAph+qQRGmYN
         jdCPA+FP79jurWVVEUSF1wLCaYlRt64eBTzOcm91WMjPqR8de6QzytC9/x2tV/LUf0Iv
         w8gqSKtck+88f3Stq0tbzfG92rZACkkM9usfelAwBvqwrgK3ZTmvemf0DMLOwi53xige
         7TQQ==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 4/5] boards: amlogic: add Beelink GT-King Pro defconfig
Date: Fri, 18 Dec 2020 08:45:44 +0000
Message-Id: <20201218084545.29135-5-christianshewitt@gmail.com>
In-Reply-To: <20201218084545.29135-1-christianshewitt@gmail.com>
References: <20201218084545.29135-1-christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Add a defconfig for the Beelink GT-King Pro Android STB, which is based
on the Amlogic W400 reference design.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 configs/beelink-gtkingpro_defconfig | 71 +++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 configs/beelink-gtkingpro_defconfig

diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
new file mode 100644
index 0000000000..569031600a
--- /dev/null
+++ b/configs/beelink-gtkingpro_defconfig
@@ -0,0 +1,71 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="beelink-s922x"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" beelink"
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking-pro"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
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
+CONFIG_DM_USB=y
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
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.17.1

