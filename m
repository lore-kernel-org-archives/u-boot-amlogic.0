Received: by mail-wr1-f67.google.com with SMTP id s15so1586320wra.12
        for <u-boot-amlogic@groups.io>; Wed, 03 Apr 2019 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YqbycqN9o+7GX4PDarzcV36uFWvKjlSY5SF7FYncFZk=;
        b=1CiiLYa0GyJHJpTz3dT/cnM4XshJlKP6g1EKHrwu9ZHIyaOSBRzt1XP3qh3CwE5/KA
         CJd6bmehqi5qUVlHTnz7iAp0FsWtRaOqtNHq1iIXvr+5CtCj4LAHt3ulPKKeu0n90Axw
         XYBvPF3ij//UtvxYkow9kddxsel+n68lr+yBt7EBVCoEACy9fNXRM8USNqUbIfjhcWGZ
         Daa3UbgOZj5PBZ+eKVvzMC1W2CSmKPyXVFLAhLxVF3arhjShaAC7fcU7kglGsPStBfpF
         X8uFCHnFabMaJpa6EuBYD+QWxyKDrPw30hgqusEY3T2Kifo+eoJ6EqeAVdLbQqOwRfgD
         jJ+w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] configs: khadas_vim2: Fix defconfig
Date: Wed,  3 Apr 2019 13:46:37 +0200
Message-Id: <20190403114637.32068-3-narmstrong@baylibre.com>
In-Reply-To: <20190403114637.32068-1-narmstrong@baylibre.com>
References: <20190403114637.32068-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de, ldevulder@suse.de, trini@konsulko.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The Khadas VIM2 defconfig was missing the USB PHY config and
two other misc configs to setup dram banks and call misc_init_r.
Align it on the other Amlogic SoC based boards defconfig.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/khadas-vim2_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 0f738cbb90..080dd19590 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -6,8 +6,10 @@ CONFIG_DEBUG_UART_BASE=0xc81004c0
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" khadas-vim2"
 CONFIG_DEBUG_UART=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_CONSOLE_MUX=y
+CONFIG_MISC_INIT_R=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 # CONFIG_CMD_BDI is not set
@@ -30,6 +32,7 @@ CONFIG_MTD=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_PHY=y
+CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.21.0

