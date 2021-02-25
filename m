Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web09.8777.1614242689558961663
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Feb 2021 00:44:49 -0800
Received: by mail-wm1-f54.google.com with SMTP id i9so3639511wml.0
        for <u-boot-amlogic@groups.io>; Thu, 25 Feb 2021 00:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quMGEk8MhuxER+h0+wyqhiwQDvCgwSP2uRA7LKU/nIg=;
        b=XqDw2DN7ONJfZRqoiiPqA3mTnTjdvpMW3B+AOaUy546UTKK58mOE4tI1kb+3jrXU+m
         b6+kI7AwtADvIdkawDhFc9N66QJ6lKDcUp/Tr4cLuIm4dIFqdqcKG6Xvs/u3AC8FxT9A
         Yet1cKC7HWoVMy8RgwkuJPA5tA2QDkrQvuvUiJ3+TdGEZTme7DE4gzf4SsohXdU8UZ/4
         9Dhx1ECZZ3ugJWY+HAJM9Lal4hMQygWUaiSb+XT5X/eRSCGIeZlLmSD2BSDg3Lmwc7I5
         D9qymWLO1YL4NzpO8ZF1ygIb0fJADwVi4nO58vi0e7pkzdXiWFNg1ysnknu398oI6M7N
         clgQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RFC/RFT 4/7] configs: meson: use Designware glue driver for Amlogic Meson8b & later SoCs
Date: Thu, 25 Feb 2021 09:44:35 +0100
Message-Id: <20210225084438.2964558-5-narmstrong@baylibre.com>
In-Reply-To: <20210225084438.2964558-1-narmstrong@baylibre.com>
References: <20210225084438.2964558-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, christianshewitt@gmail.com, b.galvani@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Use the proper Synopsys DWMAC Meson8b glue to handle the ethernet link type.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/beelink-gtking_defconfig     | 2 +-
 configs/beelink-gtkingpro_defconfig  | 2 +-
 configs/khadas-vim2_defconfig        | 2 +-
 configs/khadas-vim3_defconfig        | 2 +-
 configs/khadas-vim3l_defconfig       | 2 +-
 configs/khadas-vim_defconfig         | 2 +-
 configs/libretech-ac_defconfig       | 2 +-
 configs/libretech-cc_defconfig       | 2 +-
 configs/libretech-cc_v2_defconfig    | 2 +-
 configs/libretech-s905d-pc_defconfig | 2 +-
 configs/libretech-s912-pc_defconfig  | 2 +-
 configs/nanopi-k2_defconfig          | 2 +-
 configs/odroid-c2_defconfig          | 2 +-
 configs/odroid-c4_defconfig          | 2 +-
 configs/odroid-n2_defconfig          | 2 +-
 configs/p200_defconfig               | 2 +-
 configs/p201_defconfig               | 2 +-
 configs/p212_defconfig               | 2 +-
 configs/s400_defconfig               | 2 +-
 configs/sei510_defconfig             | 2 +-
 configs/sei610_defconfig             | 2 +-
 configs/u200_defconfig               | 2 +-
 configs/wetek-core2_defconfig        | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index ce349433be..12caa58697 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -35,7 +35,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index 8c4a234900..2b022e42ed 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -35,7 +35,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 3fd7543c12..0aaa6c0db3 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -41,7 +41,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index e37bc237d8..cd0327c06b 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -46,7 +46,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 8cc0214abb..ef85f00dd8 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -46,7 +46,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 0e64f91d0a..60cdfffe39 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -35,7 +35,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 388974209e..b383dfb654 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -47,7 +47,7 @@ CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index 5308e90bd1..ba59dee637 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -34,7 +34,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index af60bfc488..9afcf183cf 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -43,7 +43,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index 0d54563dd2..e0086081bd 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -44,7 +44,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index e08c1bcca3..68abbaf55b 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -43,7 +43,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index c2dc488171..4332271779 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -29,7 +29,7 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXBB=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 5c02fa1e62..7ce65b1376 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -32,7 +32,7 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_PHY=y
 CONFIG_MESON_GXBB_USB_PHY=y
 CONFIG_PINCTRL=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index b5e427fda7..48fb8915a0 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -35,7 +35,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 2e8b365ebc..d2a8c342c2 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -35,7 +35,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
index 6efc7bc92d..c61e974321 100644
--- a/configs/p200_defconfig
+++ b/configs/p200_defconfig
@@ -28,7 +28,7 @@ CONFIG_SYS_I2C_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXBB=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/p201_defconfig b/configs/p201_defconfig
index a1d3f04b4f..34dc154d69 100644
--- a/configs/p201_defconfig
+++ b/configs/p201_defconfig
@@ -29,7 +29,7 @@ CONFIG_SYS_I2C_MESON=y
 CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXBB=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index b0ef69d0c6..c36a674eab 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -32,7 +32,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index a15ac32986..39e44c0c44 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -29,7 +29,7 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_AXG=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 83ca0812ba..2c84abf591 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -49,7 +49,7 @@ CONFIG_DM_MDIO=y
 CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index f9f5ef657a..392ab64642 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -49,7 +49,7 @@ CONFIG_DM_MDIO=y
 CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index 1fbb78dd34..4da02f1598 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -31,7 +31,7 @@ CONFIG_DM_MDIO=y
 CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MESON_G12A=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index 4a1ba522fe..098e2493e3 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -36,7 +36,7 @@ CONFIG_DM_MDIO_MUX=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
-- 
2.25.1

