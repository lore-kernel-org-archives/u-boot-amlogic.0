Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.46457.1585560469758589335
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:50 -0700
Received: by mail-wr1-f66.google.com with SMTP id w10so20752990wrm.4
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/vuZzqDXNHhdZDkN7hhijROYnv0keWF8nN78J+MssA=;
        b=gIt/Cug+oySJmc8lh5XN8hQZy4zWywKnXrSdTIyG/dBFjGEnBCKlFHM9UZwspLLIba
         Z4qaTNM4KJkNfvHQ2HJosJAjY+L6S45brX6/KJFiS8xBPheWFWr7mccwtbp9u2XSR/Ex
         R2i2K5JU+t86dfpcBe3TNQyTXlHTem4yvK3U0fLRer3ixrOPr/jzNVRu4895OB9e0V/s
         jgb6sifMno+PF7FAyssK1EdhNsWWOrVZXDVUxW7vkJc4Kzxs/7gh5xprdhnsPg8IyMS3
         TfkjveiZE/0DECUdV8ZABhC5D9t3BFA/d+q3QUPqJnpElpemuLEOsAHiKCIYl0xfQ3lp
         hchw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 07/10] configs: khadas-vim2: Enable USB gadget with Mass Storage function
Date: Mon, 30 Mar 2020 11:27:29 +0200
Message-Id: <20200330092732.7198-8-narmstrong@baylibre.com>
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
 configs/khadas-vim2_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 9cb377e55e..a533566410 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -20,6 +20,7 @@ CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
@@ -49,4 +50,10 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.22.0

