Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.46271.1585560469095859668
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:49 -0700
Received: by mail-wr1-f46.google.com with SMTP id p10so20686380wrt.6
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbJoKRBCG/vyd2GoGgi7d3mPhk6mgZBCOQfC2bspw5E=;
        b=Bi/1nGC/2CdoL4HdhSaV1cjm0iD8pwzeQvPlGHWiqMhtxnCgALgd+FVMZwjofdsXA4
         e9GIz7smnAG2prQqZhKXzJ+wYUZw7RhMyMiOUx07WPWJ2Ag2PcZ8tEol95S1Dv0ypRUZ
         1bAcPU8UWI0DxULFBR1EW59/IOQokrSdEWJZUkjIO99++eLAYoNSP2SAdVWH9I7S0295
         295dwwf2eGwSI8pm6n+az8FdO0HhdGuzoePP2e9HPKQmci4O0RK4gw2IHKAgNFDVnHqt
         88spGNliu2Q/BlrmYNPKI1EnKiNY6t7PoRrLML+3sFV/9Bo2PW7wr3UQjeweEzms1c0x
         Lq3g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 06/10] configs: libretech-ac: Enable USB gadget with Mass Storage function
Date: Mon, 30 Mar 2020 11:27:28 +0200
Message-Id: <20200330092732.7198-7-narmstrong@baylibre.com>
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
 configs/libretech-ac_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 09b87c54d5..7e486757a2 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -27,6 +27,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
@@ -69,6 +70,12 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_KEYBOARD=y
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

