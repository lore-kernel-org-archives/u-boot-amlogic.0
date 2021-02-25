Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.8911.1614242685606110684
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Feb 2021 00:44:45 -0800
Received: by mail-wr1-f49.google.com with SMTP id w11so4364929wrr.10
        for <u-boot-amlogic@groups.io>; Thu, 25 Feb 2021 00:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjAZ1pUFDCQX0u3wiKEycvmY8rSJB94FvTsRvhJYXDk=;
        b=yisqvbbqlx+DVQ8V8ULZD4pw8H+uFF2OF0McezIOmQ5WbflmZoNP53k1wTH/KrX2cd
         I2pBl6UChZWNV6yjkfy37tfWUTQpHXXMU5rewOHeDo2WhM9Y7XyLuD5lXhlNbpWYAVYJ
         U8nxSh3INsEJ/rIL5xhqZxky/Y0UlmuGteKjIULUG/IvxSAce2eTYELRDbhJZbFnNJ1u
         SphSDtFPhGENzwn9NIIpwontaR97KJ6CCgS05Dutj+fvXH9Zlxz7tGGijqW3BW2tLx+P
         G6ZrTZDLag40wq/6X6n25+0+rdghqnWxgBxnSkpfo7js1WyCn+v0SmUHYboU0h/F2aXN
         Jw9Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RFC/RFT 1/7] configs: update Amlogic Meson GXL & GXM config for MDIO MUX
Date: Thu, 25 Feb 2021 09:44:32 +0100
Message-Id: <20210225084438.2964558-2-narmstrong@baylibre.com>
In-Reply-To: <20210225084438.2964558-1-narmstrong@baylibre.com>
References: <20210225084438.2964558-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, christianshewitt@gmail.com, b.galvani@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Use DM_MDIO and the new MMIOREG MDIO MUX driver for GXL & GXM board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/khadas-vim2_defconfig        | 3 +++
 configs/khadas-vim_defconfig         | 5 +++--
 configs/libretech-ac_defconfig       | 5 +++--
 configs/libretech-cc_defconfig       | 5 +++--
 configs/libretech-cc_v2_defconfig    | 5 +++--
 configs/libretech-s905d-pc_defconfig | 3 +++
 configs/libretech-s912-pc_defconfig  | 3 +++
 configs/p212_defconfig               | 5 +++--
 configs/wetek-core2_defconfig        | 3 +++
 9 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index c26c0ca45c..3fd7543c12 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -36,6 +36,9 @@ CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index e7e5c42035..0e64f91d0a 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -30,8 +30,9 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=8
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index ca61591bd7..388974209e 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -37,13 +37,14 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=8
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index fb4bf4c929..5308e90bd1 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -29,8 +29,9 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=8
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index 017e81bb5d..af60bfc488 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -38,8 +38,9 @@ CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=8
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index 9d4c880a3b..0d54563dd2 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -39,6 +39,9 @@ CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index cf600c1cbe..e08c1bcca3 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -38,6 +38,9 @@ CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index da66c50ea0..b0ef69d0c6 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -27,8 +27,9 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=8
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index cbe747b63e..4a1ba522fe 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -31,6 +31,9 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.25.1

