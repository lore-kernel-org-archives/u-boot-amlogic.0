Received: by mail-wm1-f68.google.com with SMTP id z24so2929683wmi.5
        for <u-boot-amlogic@groups.io>; Wed, 10 Apr 2019 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BPc9n0EMRDNki3TTGwAH0D6xkHBTW0nLKHZTff5jjw=;
        b=umHhcH88WliuwfL7SnHPKrmNXolTTlpIOPo1iFKZkBuSU4orjmrAigInNIfHeL+0GV
         FHGHyBgSE66NQQs4ddLftDL7dbzjNH0of8XvQipebpG4Xun2OkhtsAyUi/GYAEJCXbGK
         3a2uQNetoqDJLmF95MrUbORaHdALkJuGuG4ZNUzWIlLgF6ON9oq8NPPQbdbgLZ+ju9Qn
         5cvjpoNejo1zB4gjI0RYV93lj0Wotnms7ssO1nDqe4vHMUbZFl2HDIAYk8QfW9NBtenG
         IWf6m964eijtQNqikocQHOdBVke2yW1QCD0XZnLJab7jVZf+L8BYPVCTtSYu7FCqIajC
         6fVg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] board: amlogic: enable PHY_REALTEK for selected boards
Date: Wed, 10 Apr 2019 16:46:09 +0200
Message-Id: <20190410144609.1091-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

When using the generic PHY on boards using an RGMII Realtek PHY,
gigabit speed is not always reliable.

This patch enables the Realtek PHY driver for such boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/khadas-vim2_defconfig | 1 +
 configs/nanopi-k2_defconfig   | 1 +
 configs/odroid-c2_defconfig   | 1 +
 configs/s400_defconfig        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 080dd19590..f7fb9338e2 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -31,6 +31,7 @@ CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_PHY_REALTEK=y
 CONFIG_PHY=y
 CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index 8bbf48f41f..106c5c0193 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -28,6 +28,7 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_PHY_REALTEK=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXBB=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 747da184b3..91baddbb60 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -29,6 +29,7 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_PHY_REALTEK=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXBB=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index 1bd4b7127b..9b8448e003 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -26,6 +26,7 @@ CONFIG_DM_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_PHY_REALTEK=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_AXG=y
 CONFIG_DM_REGULATOR=y
-- 
2.21.0

