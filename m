Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.9938.1604658076849327518
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:21:17 -0800
Received: by mail-wm1-f65.google.com with SMTP id v5so841228wmh.1
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1yye6RlOoY7g6efYzyRbzrjZdA54XoyMn+FJxVOEAo=;
        b=hTMcavqF5GJIs18irQ9+tc8V6suBYIg7jJ/SCD9M6CmuaOEAHvd9Bfs1MO4+YVeIra
         sUuDYwE+OLKlQ1DK4y/56lTDPf/U+5H0jKZe1eoxXA8LId9sCyLscYOitORIO78DvhQw
         ymKnpAKeqQqvHCFtc/LOEXHeuYHH+hC2CPsf6MGO0zt2b+gnNiJgaZpWf1bzZOl1I3tD
         k2p2EcX1jLKGffNBJUXhBXEUyfP8ADWu+d71VLi8Y449eJvQs+TLYBzw4sQSkgD+RXyO
         4WfVGLZQgUfS+b2rSH/dUcLkXTV3lxARForYur/Rh2tej2QiNibfs2rYtYciv0dOrElQ
         0QVg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/4] configs: use the new MESON_EE_POWER_DOMAIN driver for Amlogic GXBB/GXL/GXM boards
Date: Fri,  6 Nov 2020 11:19:01 +0100
Message-Id: <20201106101901.2472557-5-narmstrong@baylibre.com>
In-Reply-To: <20201106101901.2472557-1-narmstrong@baylibre.com>
References: <20201106101901.2472557-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Linux 5.10-rc1 uses the new generic driver, so switch to it since GXBB and
later is now supported.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/libretech-ac_defconfig       | 2 +-
 configs/libretech-cc_defconfig       | 2 +-
 configs/libretech-s905d-pc_defconfig | 2 +-
 configs/libretech-s912-pc_defconfig  | 2 +-
 configs/odroid-c2_defconfig          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 171d793ae3..ca61591bd7 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -51,7 +51,7 @@ CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_RESET=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index aaab1a2d08..fb4bf4c929 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -38,7 +38,7 @@ CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_RESET=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index f4e289aca1..9d4c880a3b 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -46,7 +46,7 @@ CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_RESET=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index 24e410c5aa..cf600c1cbe 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -45,7 +45,7 @@ CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_RESET=y
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 5fdce3b463..a692179956 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -39,7 +39,7 @@ CONFIG_MESON_GXBB_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXBB=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-- 
2.25.1

