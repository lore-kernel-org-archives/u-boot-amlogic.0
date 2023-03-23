Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.66611.1679554508222717633
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Mar 2023 23:55:21 -0700
Received: by mail-wr1-f41.google.com with SMTP id i9so19324910wrp.3
        for <u-boot-amlogic@groups.io>; Wed, 22 Mar 2023 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679554520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7QTlql6gHJ/9dufI5rRY7wtq8yqE56iTyJomQVRJVc=;
        b=Vy4I8CnJy4IL8TZ12Cu3GSzW0ln7RJzyT6mRRYDc0j4n0UoJLBjN1/d060OMh/XS6f
         MLDQma2CmaSmAimPiWEy6qixITn6xMpS8yZJTPwLPqrpEzDXWYIyCxGnGQLBqtYL+IQn
         XzJMTMqDWJIM9o65rJohXJ8kI/ViGGDj07RkUPLMoNpMVc7cT6Pu+f8Z3CXdSPoUs3tw
         LUxIpssW+IAbzBZlWCoRxrst5ASqSksOk0BWZpycdICBJG5j0bwQ3N8tOP+1ZsEBZUML
         n+2FgVTPbFHGFFy2noJOml/1qh2rfp37XJ+ATzWKlArNeEN3C3TDOHM/sWJIzDT4jkZF
         Ir8Q==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 12/13] boards: amlogic: add WeTek Hub and WeTek Play2 defconfig
Date: Thu, 23 Mar 2023 06:54:57 +0000
Message-Id: <20230323065458.776029-13-christianshewitt@gmail.com>
In-Reply-To: <20230323065458.776029-1-christianshewitt@gmail.com>
References: <20230323065458.776029-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Add configurations for the WeTek Hub and WeTek Play2 boards along
with files for the wetek-gxbb board family to ensure the ethernet
MAC is correctly discovered. Set myself as the maintainer for the
board family.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/p200/MAINTAINERS |  2 +
 configs/wetek-hub_defconfig    | 70 ++++++++++++++++++++++++++++++++++
 configs/wetek-play2_defconfig  | 70 ++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 configs/wetek-hub_defconfig
 create mode 100644 configs/wetek-play2_defconfig

diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
index 33ca3df5c6..264218e3be 100644
--- a/board/amlogic/p200/MAINTAINERS
+++ b/board/amlogic/p200/MAINTAINERS
@@ -7,6 +7,8 @@ F:	board/amlogic/p200/
 F:	configs/nanopi-k2_defconfig
 F:	configs/odroid-c2_defconfig
 F:	configs/p200_defconfig
+F:	configs/wetek-hub_defconfig
+F:	configs/wetek-play2_defconfig
 F:	doc/board/amlogic/p200.rst
 F:	doc/board/amlogic/nanopi-k2.rst
 F:	doc/board/amlogic/odroid-c2.rst
diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
new file mode 100644
index 0000000000..634833f7fe
--- /dev/null
+++ b/configs/wetek-hub_defconfig
@@ -0,0 +1,70 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" wetek-hub"
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
+CONFIG_DEBUG_UART=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_PHY=y
+CONFIG_MESON_GXBB_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXBB=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_KEYBOARD=y
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
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
new file mode 100644
index 0000000000..6d33b09a94
--- /dev/null
+++ b/configs/wetek-play2_defconfig
@@ -0,0 +1,70 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" wetek-play2"
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
+CONFIG_DEBUG_UART=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_PHY=y
+CONFIG_MESON_GXBB_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXBB=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_KEYBOARD=y
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

