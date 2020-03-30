Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.46139.1585560470710500989
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:51 -0700
Received: by mail-wr1-f66.google.com with SMTP id 31so20681376wrs.3
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERXzjX8SVhh21DHqeVrBecKkkd+/RdhwQeUJB2mF92k=;
        b=DqMXwKH15oxSYhaDRwTATvXmdTwnIs4icCOQWGcE5LBLi/06piqi1rU3A+OP8n+RAi
         BbzRqkChICnpkczU2tULRI/9EwrP2ivPWKl7HcKjbNKbsK+0E47vdDHppSHyXGRYqU3j
         bqZdlpG1hsBDeyzs54sT5Q8yrwkQNJOsbkEDapoowU/e0HhUOevbJLuz5LhvuChR1+5e
         rcGb6hFJHu5JLQTAUOY1fMwL1bWBz4U2wHRofOlTw0h7elIyKQjcRUpp5QDCS0crrYMK
         uvHCN9RgkTIi0HVBqwPYxLqdO89zVWRAucQHnlOzwcy1/IOeLK57bQpny7mNJtXObv3e
         PEVw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 08/10] configs: khadas-vim: Enable USB gadget with Mass Storage function
Date: Mon, 30 Mar 2020 11:27:30 +0200
Message-Id: <20200330092732.7198-9-narmstrong@baylibre.com>
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
 configs/khadas-vim_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index e18a5e62bb..8a0af5cebb 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -20,6 +20,7 @@ CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
@@ -50,4 +51,10 @@ CONFIG_USB_XHCI_HCD=y
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

