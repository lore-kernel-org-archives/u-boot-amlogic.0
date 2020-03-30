Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.46138.1585560468367419882
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:48 -0700
Received: by mail-wr1-f50.google.com with SMTP id d5so20746611wrn.2
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YkoFLD3dTn+ngZUMDZI25DXndxnkR2jd27PHx17Z4XQ=;
        b=ikSh5zbyr+GIO5YQVWFfm80hXkC4eUkorCVmwv+H3ghSkEGbejXATVCugYQjhnAjQC
         hZDTH1kaC2EnuQ88ccqEd+BQl/meTP8yLAmoTGpsXv31hv35gu5BIUo3VkQRvUTLMYKu
         UB3H6aSSKULWq1AmM5FQ1HeBeoRnmgmyabCoTrNpDzUfncw0Y/DJ/1BxSbxVjW53+Vbl
         SCl0x5XenH52qNSvFSjk01xgTl9GGfNUSxkhpeuqm927OAwmEymfHEI8XDa3WvwCkYCk
         hvcBZOkAyeyMF3IkcmglOShDP9DPsfV1R7C2KyOT8q9uESLA7fgkL266Zq8YlZvAvgFc
         mZqw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 05/10] configs: libretech-cc: Enable USB gadget with Mass Storage function
Date: Mon, 30 Mar 2020 11:27:27 +0200
Message-Id: <20200330092732.7198-6-narmstrong@baylibre.com>
In-Reply-To: <20200330092732.7198-1-narmstrong@baylibre.com>
References: <20200330092732.7198-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable configs to support USB gadget and Mass Storage

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/libretech-cc_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index 7c257b33b3..2c512ebc1e 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -19,6 +19,7 @@ CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
@@ -51,6 +52,12 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_DM_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 # CONFIG_VIDEO_BPP16 is not set
-- 
2.22.0

