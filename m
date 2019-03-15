Received: by mail-ed1-f66.google.com with SMTP id e10so4031073edy.5
        for <u-boot-amlogic@groups.io>; Fri, 15 Mar 2019 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wAlqGKWG8aMhmoZvnLdoG+laKRx1RzcE+dZWMcGQ08=;
        b=az+J6ga3fEP33gJ9tZhPHypDiwh8w/M7XtBs7/CQpo2jrBmeDV1ZFwUY59DAghzbVn
         kcNM2keBOilG/BkSBYHw/ufeWZlI83IfhZQd5VW+BmLUv5vC0MmDgiCe2HYcIGBMiWDF
         uO8ovTTrDACo44bDyU2qFkIMFBM5pBeCw4Rm9YmRE9kugN/Ux3Pjzbn+XJVbCwX5CJrb
         wa2UP6IoTwcMtxW0K7WuqtheWS2P3N2iY8BjB4cDw1lpkioEoFIlFA3xd/sjGgvmCsmp
         sVOA2iTKE7ian0X/yDytd92l/vHigxvFX9sgGGcsZHZZtukLF23ewUXizv/eoj+u7Gnx
         j4Jg==
Return-Path: <mohammad.rasim96@gmail.com>
From: Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH v4 4/5] ARM: board: meson: add p200 board
Date: Fri, 15 Mar 2019 18:19:45 +0300
Message-Id: <20190315151946.23105-3-mohammad.rasim96@gmail.com>
In-Reply-To: <20190315151946.23105-1-mohammad.rasim96@gmail.com>
References: <20190315151946.23105-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, narmstrong@baylibre.com, jbrunet@baylibre.com
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This adds the p200 defconfig

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
---
 configs/p200_defconfig | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 configs/p200_defconfig

diff --git a/configs/p200_defconfig b/configs/p200_defconfig
new file mode 100644
index 000000000000..3980e4eb5f1d
--- /dev/null
+++ b/configs/p200_defconfig
@@ -0,0 +1,41 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" p200"
+CONFIG_DEBUG_UART=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXBB=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_BOARD="p200"
--
2.21.0

