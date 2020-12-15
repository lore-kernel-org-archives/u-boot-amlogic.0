Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.10356.1608035543395440266
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 04:32:23 -0800
Received: by mail-wr1-f68.google.com with SMTP id w5so15935426wrm.11
        for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 04:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=onEabqdmtNzjpYK/tr7QwKjGVZ6M4J0y8id46375WXs=;
        b=YU64BV2alvIIxJCNE25UJe+2NWPxNANqkqV6jL6Sx/tDMTP5cTCYN9olyKIXRO8ca4
         q3S5GEtuaqeLFOVQAtEwtZTDk/w9egx29NACpcMtL9bM2V1HPls4/qhJr7vSfGepkATF
         ghL079a15xYro2hY4V54QIOqhlC8KZbgnJw3JmSc0CI+ScryClH7a0ukzyKFsFdeRVib
         VU5JnVl3n+sLfyaF/DJzeqDCsWV8ct/r1zDuojp5hr4xLEy22qYQdkiWBJU2JpW+0sBE
         MhtfzKNdaJxZr1kyVx2q8RB7UM0ap9fHTGJQrbNGrawZkUR1kOmyZiyY+cct9G3ZKB3Q
         HizA==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/3] boards: amlogic: add WeTek Core2 support
Date: Tue, 15 Dec 2020 12:32:13 +0000
Message-Id: <20201215123214.18661-3-christianshewitt@gmail.com>
In-Reply-To: <20201215123214.18661-1-christianshewitt@gmail.com>
References: <20201215123214.18661-1-christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Add a config for the WeTek Core2, largely based on the VIM2 config.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 configs/wetek-core2_defconfig | 70 +++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 configs/wetek-core2_defconfig

diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
new file mode 100644
index 0000000000..706abff962
--- /dev/null
+++ b/configs/wetek-core2_defconfig
@@ -0,0 +1,70 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_MESON_GXM=y
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" wetek-core2"
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-wetek-core2"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_CONSOLE_MUX=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXL=y
+CONFIG_DM_REGULATOR=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_GXL=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.17.1

