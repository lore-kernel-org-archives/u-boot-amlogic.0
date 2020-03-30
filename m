Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.46273.1585560472752655747
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:53 -0700
Received: by mail-wr1-f67.google.com with SMTP id j17so20616233wru.13
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kn2S4+PqEMm8qSsLBOIotKDI4Qw34fBKEpsG8OQ6PyM=;
        b=lEqyO/eQFckuH1iNQcn43/zjDAGqnC0jqbavOuPdGj4Y9qSv7Cw9mEzU/EJiN67UjY
         qXIrJf/aSObPlBWUbIU7UWHmMU4pOJbUjOpvE4okVe93jx/DPmhqzujG90umnG/GNzZA
         lJfh2kUEdzNoCOvAEukt9nYXOm//IDzgTHf01JPeFDS9YYLtgytRiZ+XhTjqj9frrOOk
         H50QDYkAU6pX5Xwpy6GH02D8zm79Wol9xHX7qh5Db5WrmLHpF4DZ6UDsyhBlM6NtGV7x
         mBZA9MdquX20uOD1wPerllbF4jWQ089kmnOYZWCFL9vH/TWT/PzCjtxNH/I7z+03DUFY
         1R9g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 10/10] configs: libretech-s912-pc: Enable USB gadget with Mass Storage function
Date: Mon, 30 Mar 2020 11:27:32 +0200
Message-Id: <20200330092732.7198-11-narmstrong@baylibre.com>
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
 configs/libretech-s912-pc_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index 5f4ee329e2..595ec21da7 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
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

