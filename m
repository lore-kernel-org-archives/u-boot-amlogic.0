Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.11658.1589203055415882912
 for <u-boot-amlogic@groups.io>;
 Mon, 11 May 2020 06:17:35 -0700
Received: by mail-wr1-f41.google.com with SMTP id v12so10880859wrp.12
        for <u-boot-amlogic@groups.io>; Mon, 11 May 2020 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3BShulMwG34AudX1DTjzOI/dCcsoBgLJognomfm9rQ=;
        b=d5GrUupSwZilUVw8FZWAaAqC7TG9zYzgX5dcXCph9m+c8MAX4g/p5M7xIc6EWzyTMO
         etOgK4VwVEP6BirPonXjr0p0Z03tRshBTADU0onB3q2X5Pe8UvsTVJL5dJ7GRixUpGM2
         YkjWGo7uOHyv6cCJX9/d1ZZqC9BG5ymPimoyrw9VAeHilqbRkAA/EXNr9ne8VmMtgWoq
         BtswqDpWBZLJDjj3cTUknbgSgDclZJoQwVpYiig8SmzsiQOuYQmd+9RB4AKyYN8Q5qTI
         X1sAjeMeqzeYwPiWVX0Opwqe49OlZawvg3AH7imeMZyg3C3iCEynlHoc3ygn+FbdnO/Q
         6WsA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] configs: khadas-vim3: enable HDMI output
Date: Mon, 11 May 2020 15:17:28 +0200
Message-Id: <20200511131728.5570-2-narmstrong@baylibre.com>
In-Reply-To: <20200511131728.5570-1-narmstrong@baylibre.com>
References: <20200511131728.5570-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable options to permit HDMI output on Khadas VIM3 & VIM3L boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/khadas-vim3_defconfig  | 9 +++++++++
 configs/khadas-vim3l_defconfig | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 692138eb11..4aeab0e35d 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -40,6 +40,8 @@ CONFIG_ETH_DESIGNWARE=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_RESET=y
@@ -55,6 +57,7 @@ CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_KEYBOARD=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
 CONFIG_USB_GADGET=y
@@ -63,4 +66,10 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 28c20c0d6d..887885f329 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -57,6 +57,7 @@ CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_KEYBOARD=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
 CONFIG_USB_GADGET=y
@@ -66,6 +67,9 @@ CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MESON=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.22.0

