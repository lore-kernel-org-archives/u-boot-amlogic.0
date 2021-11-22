Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.5043.1637579239005274608
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 03:07:19 -0800
Received: by mail-wr1-f46.google.com with SMTP id d27so31975898wrb.6
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 03:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYipmdmkDhVY6+wsShk6Wy+9wsTqYYAwLOG3h5zShU0=;
        b=YDu+LWQ2t2stm9IUacjD9UDZ0tdx+pGIU/1PDZd9UXPypoS4LDE5YrVpQ9e7Fletqx
         5vgvKgzHlzWk3tyTxe0nq9OKQUa0OZjFNxJbStYZdcBgiXuCtn4VRoGTJKSR1tCKEJ5Z
         mhUj0yVFdS7E+Dpwh8ayBgTiIF2B6yrHOyl7Zk1GLB5kkTBl3cNXbQpoilGKrBfhxLx9
         VMoZHQ7Nng1WDgGA552qIdGj6ctjoMlolJRa6WH+KAxx1JRoPr4QjAPWmImdLZkoPG2+
         b7Qn//c41WE45jjYlipx0Zmf+mE91zEljquBsXEcY06bfhyU0Sz741PWy6wUfc8rrIug
         6Tkg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] configs: amlogic: Disable CONFIG_NET_RANDOM_ETHADDR when unnecessary
Date: Mon, 22 Nov 2021 12:07:10 +0100
Message-Id: <20211122110710.1038893-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: christianshewitt@gmail.com, adeep@lexina.in, trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On Meson GXL, GXM, AXG, G12A, G12B & SM1 SoCs, we can generate an unique
MAC address if none valid found in the eFuses storage.

Only the GXBB based boards doesn't have a fallback way to generate an
unique MAC address, so we rely on CONFIG_NET_RANDOM_ETHADDR to have
a valid one.

An exception is the Radxa Zero board who doesn't have Ethernet on board
so depends on an (or multiple) eventual USB adapters, so leaving the
CONFIG_NET_RANDOM_ETHADDR configs seems safer.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/bananapi-m5_defconfig        | 1 -
 configs/beelink-gsking-x_defconfig   | 1 -
 configs/beelink-gtking_defconfig     | 1 -
 configs/beelink-gtkingpro_defconfig  | 1 -
 configs/jethub_j80_defconfig         | 1 -
 configs/khadas-vim2_defconfig        | 1 -
 configs/khadas-vim3_defconfig        | 1 -
 configs/khadas-vim3l_defconfig       | 1 -
 configs/khadas-vim_defconfig         | 1 -
 configs/libretech-ac_defconfig       | 1 -
 configs/libretech-cc_defconfig       | 1 -
 configs/libretech-cc_v2_defconfig    | 1 -
 configs/libretech-s905d-pc_defconfig | 1 -
 configs/libretech-s912-pc_defconfig  | 1 -
 configs/odroid-c4_defconfig          | 1 -
 configs/odroid-hc4_defconfig         | 1 -
 configs/odroid-n2_defconfig          | 1 -
 configs/p212_defconfig               | 1 -
 configs/s400_defconfig               | 1 -
 configs/sei510_defconfig             | 1 -
 configs/sei610_defconfig             | 1 -
 configs/u200_defconfig               | 1 -
 configs/wetek-core2_defconfig        | 1 -
 23 files changed, 23 deletions(-)

diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 7ca14a5f6a..4bf81b2faa 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -25,7 +25,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index 54ac1c9315..e60e754f56 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 7735c70e3f..2ec3221563 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index 93c5739672..60d316d80a 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index ad6bec0c43..eb1e4c4a53 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -33,7 +33,6 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index c852f7f3f9..81cff3cee8 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -29,7 +29,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index a225a564b2..65050efd3f 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -30,7 +30,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 9d94c31891..b9162c9f1e 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -30,7 +30,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 5565635ab1..81eeff4982 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -27,7 +27,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_MESON_GXL=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index fa4427a815..7dcd8540a9 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -34,7 +34,6 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index b729308c8e..b4413ed9b7 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_MESON_GXL=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index 9f8a914bb7..99a0b28d16 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -30,7 +30,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index bde2bb877c..6e8c8a497e 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -32,7 +32,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index 536f9e8d12..b08ca44abe 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -31,7 +31,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index bc778a641a..1ea003f3f8 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 2fe761e939..d632670db0 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -29,7 +29,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_SATA=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 8e9e8f8fb7..7f87504a9c 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index b1d2ca8350..bca0fa8404 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -25,7 +25,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index 4467e66929..8483694685 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -25,7 +25,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 690a0ca8d4..5e2496edbe 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -43,7 +43,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
 CONFIG_FASTBOOT_FLASH=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 63080aec2d..df53c91d8b 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -43,7 +43,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
 CONFIG_FASTBOOT_FLASH=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index 144c394010..7f46dcf5c2 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -25,7 +25,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_ETH=y
 CONFIG_DM_MDIO=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index ce947b5625..006cebc711 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
-- 
2.25.1

