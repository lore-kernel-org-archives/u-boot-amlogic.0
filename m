Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.286.1570799547248013012
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 06:12:27 -0700
Received: by mail-wm1-f66.google.com with SMTP id m18so10185160wmc.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tFgWkLuWrY54lB3j9u/NrAbWjzFPl5Rx8+CaOYFn5g=;
        b=K0vKExOAxTaM1pvUTD8Wwu2dIZVG4HDo6pNW6eiiwigtyttzdmfuqh0ff6nmqdELp/
         mu9UHr2QVJKjOW9RQfjzwxPWldLh7VxmuBITLErZ0dfLx2xnNig9VmV2CM07iYGOSrcg
         La1/XqN5RKLcjDNCDf2Dh5QTTXLUCDGgqd1ipkbaErgO4+t6GXf3jgA+xYkBk2r9QM9r
         6Zful3EBe5+AENxZEsy6+K8KguXsXwQxnqXluBDooXZxF47u47vQR0GMXlti5fHTIsDZ
         k9n+oDjjzhKVGLmWdhD5NQYYCtotCJoyGHUUxtDJPhcoi6kcXGmhimxaCqRRlWhPND0y
         v3dQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] configs: sei510: enable everything-else power domain
Date: Fri, 11 Oct 2019 15:12:20 +0200
Message-Id: <20191011131220.10873-3-narmstrong@baylibre.com>
In-Reply-To: <20191011131220.10873-1-narmstrong@baylibre.com>
References: <20191011131220.10873-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jh80.chung@samsung.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The GX VPU Power Domain driver has been replaced by the Everything-Else
Power Domain driver for G12A and SM1.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/sei510_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 9eb205bc63..9df04c345d 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -48,7 +48,7 @@ CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MESON=y
-- 
2.22.0

