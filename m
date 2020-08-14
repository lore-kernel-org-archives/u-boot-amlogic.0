Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
 by mx.groups.io with SMTP id smtpd.web10.13043.1597386325917607761
 for <u-boot-amlogic@groups.io>;
 Thu, 13 Aug 2020 23:25:25 -0700
Received: by mail-pj1-f68.google.com with SMTP id c6so3935919pje.1
        for <u-boot-amlogic@groups.io>; Thu, 13 Aug 2020 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrJiVmAl3bVQXeb314j430/8L1bsuUgt4WYaHKuBMb8=;
        b=A2ZFrWvZfi0kBBKaoVOK02Rv5SzmBfD4/1wWAjLiCPVz/Pvgmuk52BWA6KV5Jt20yw
         SStgnjifQAz6p8+KH7fjbpxg8IhHbPTG7KKuVxKcwGNNZtpOdfof1EjxzNPRW6yTm68e
         CKSYMPSpmY39G+XRxpj9rJu3Ika1wUXA6qvWfkGf7jLPMJIavD8QARWJo01JzOgXuZ6u
         kc2MHuHWKTxA0oGqMpP3/leFrG3M/4Ta7TePglAd7LcMzPagVHQ5HMyi/xIpcxfoc+Wg
         whUtOmhIMCxLq4GWc4dO2UJEzN93YJ+rqPuyjV8yBQ0dr5Yswh5PI5551JtoW+Bys3So
         5J+A==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 2/2] configs: odroid-c4: update for HDMI output background & USB keyboard
Date: Fri, 14 Aug 2020 06:25:15 +0000
Message-Id: <20200814062515.1803-2-linux.amoon@gmail.com>
In-Reply-To: <20200814062515.1803-1-linux.amoon@gmail.com>
References: <20200814062515.1803-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, Beniamino Galvani <b.galvani@gmail.com>, Christian Hewitt <christianshewitt@gmail.com>, Anand Moon <linux.amoon@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Enable options SYS_WHITE_ON_BLACK to permit HDMI background
screen from white to back, also enable USB_KEYBOARD.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/odroid-c4_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index 4d112d3490..50653de638 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -49,6 +49,7 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_USB_KEYBOARD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
 CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
@@ -56,6 +57,9 @@ CONFIG_USB_GADGET_DWC2_OTG=y
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
2.28.0

