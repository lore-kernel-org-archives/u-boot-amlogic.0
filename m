Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web09.8776.1614242686643042118
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Feb 2021 00:44:46 -0800
Received: by mail-wr1-f48.google.com with SMTP id d11so4374826wrj.7
        for <u-boot-amlogic@groups.io>; Thu, 25 Feb 2021 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tn2rtjVDkBi7UZ+RPnyXmxnwwVHj7SmxAECivHoKMA=;
        b=lJ7MCyVHmmgft2wrPNsqz5RYPakYJYibaC5L99kJMvPI4tIgS4+OlZ72FWnJUn2BLJ
         xPn7MZwnFylbf4zzntsNSRAZlwRDrVOYkz5WjTIPHnzb9PYAAMGuGXRv2ZBpWE3M/+AG
         JI/TB80bwY2rt7uJDRnjoDm8V5TWhzQBMNmyIrp71pIbn6Khf5iL1GurDIRDdWBbEt/a
         Ly4zkEh2Dz7ZLxfCARqpvuPttUVH0wnGPSSGOz/g4j65i51loPN1JNm1InCvLMzv6UTL
         XlQnbWBWR9WhXcvCHq5SlBBkm+20IyslsxdqYgPldvujnu0Jq+XUweWV7rlqN8q+dBbd
         d9Tg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RFC/RFT 2/7] configs: update Amlogic Meson G12A, G12B & SM1 configs for MDIO MUX
Date: Thu, 25 Feb 2021 09:44:33 +0100
Message-Id: <20210225084438.2964558-3-narmstrong@baylibre.com>
In-Reply-To: <20210225084438.2964558-1-narmstrong@baylibre.com>
References: <20210225084438.2964558-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, christianshewitt@gmail.com, b.galvani@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Use DM_MDIO and the new G12A MDIO MUX driver for G12A, G12B & SM1 boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/beelink-gtking_defconfig    | 3 +++
 configs/beelink-gtkingpro_defconfig | 3 +++
 configs/khadas-vim3_defconfig       | 3 +++
 configs/khadas-vim3l_defconfig      | 3 +++
 configs/odroid-c4_defconfig         | 3 +++
 configs/odroid-n2_defconfig         | 3 +++
 configs/sei510_defconfig            | 5 +++--
 configs/sei610_defconfig            | 5 +++--
 configs/u200_defconfig              | 5 +++--
 9 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 6270c23bb0..ce349433be 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -30,6 +30,9 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index 310654e353..8c4a234900 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -30,6 +30,9 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index bc17430569..e37bc237d8 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -41,6 +41,9 @@ CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index c1877922c7..8cc0214abb 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -41,6 +41,9 @@ CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index 8a9b8b0c02..b5e427fda7 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -30,6 +30,9 @@ CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index b82bd78f2d..2e8b365ebc 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -30,6 +30,9 @@ CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 7b97a2f6f3..83ca0812ba 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -45,8 +45,9 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 # CONFIG_INPUT is not set
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=8
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_MESON_G12A_USB_PHY=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 0ed17091b5..f9f5ef657a 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -45,8 +45,9 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 # CONFIG_INPUT is not set
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=8
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_MESON_G12A_USB_PHY=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index b0b822b9cb..1fbb78dd34 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -27,8 +27,9 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=8
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_MESON_G12A_USB_PHY=y
-- 
2.25.1

