Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.17584.1599727720285033427
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 01:48:40 -0700
Received: by mail-wm1-f65.google.com with SMTP id k18so4935922wmj.5
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNsfxMRfvEMp7UqWQUsN0AUh8IKOX1aRlm2kT5BiNeg=;
        b=TvVjSlnc3Gw+sqmrO63DnXxYfqra2G/sHoPmgnGNE1CejOGJs8sXoGoHK0ibaZBUVV
         BOFwb9FD5+mn4ZEVM3vll8FaqDiTkzzIxNR9OQTFs+paP5UbQLSG/DTwg6QKu623CTdY
         THedrz/5eBDJ02cFR3zFcqwIEnD5eKTcls9QDAjG16C9mGCJ7HBCEYDzE8d5m5bcUY3M
         VzSzJYE+NADfwNJp3JjHYa6ct6GmPgAe4SYf2wj3krAr1o3IyD6+ZUrsOVNPYA3Z5HHL
         1fwi7n7IvX7o+vveQCpD4xAJjkiCaj0cWMEFGQkAH4zhyUP2MPsKxrGs6k87cKSxsmVj
         TR0g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 8/8] configs: s400: enable USB
Date: Thu, 10 Sep 2020 10:48:19 +0200
Message-Id: <20200910084819.25312-9-narmstrong@baylibre.com>
In-Reply-To: <20200910084819.25312-1-narmstrong@baylibre.com>
References: <20200910084819.25312-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable USB Host & Gadget on the Amlogic S400 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/s400_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index 3c9509411b..16c162434b 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -18,6 +18,8 @@ CONFIG_MISC_INIT_R=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
@@ -28,6 +30,7 @@ CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_AXG=y
 CONFIG_DM_REGULATOR=y
@@ -36,4 +39,16 @@ CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_GXL=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.22.0

