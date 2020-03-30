Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.46140.1585560471509100681
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:51 -0700
Received: by mail-wr1-f47.google.com with SMTP id h15so20664773wrx.9
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=og42L6MAnFwnb0qkelVhFStRt3VQOBd+bxe0RdkQk7w=;
        b=iGDu74ofx2Ng+xPPmt6RG8mEg4HnFmQOUDLjoP1GJiYWuYunKh/4kvdLWq3eS6AfLO
         U9VIZEJtgDcjJTeWmI+mw5B+Zb5K+CRUYwmXFpL5WSmTvYxfTM1lcSjqXjHvjqYHfBb0
         +TVkMlkqtgAFnG4Au4QsqdH82SYdf4XgQSO8kdAFkWIXLEZxhvA4VF0HZFoH47UKD7PH
         l9+/u9l/dXvKxSh1KYLFA9q9WszNkN3lnZC3/PcOBvn+TsKfi1XMvjxtBChU7Uy2YUw3
         5y5JQsAgreQBiG2YSAUsjF1f6NYMT4D315DYCE9pCP+HKF16yJ6eOeou0LanT5KlYoRD
         veuw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 09/10] configs: libretech-s905d-pc: Enable USB gadget with Mass Storage function
Date: Mon, 30 Mar 2020 11:27:31 +0200
Message-Id: <20200330092732.7198-10-narmstrong@baylibre.com>
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
 configs/libretech-s905d-pc_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index 7e0c95872a..531d519a7c 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -26,6 +26,7 @@ CONFIG_CMD_SF=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
@@ -65,6 +66,12 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_DM_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
-- 
2.22.0

