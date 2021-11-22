Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.7832.1637594539235696411
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 07:22:19 -0800
Received: by mail-wr1-f52.google.com with SMTP id i5so33451156wrb.2
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3BL8PUj89s9yYnYm+GvHrt0holqi4LIX35uo1kykiJg=;
        b=Wx4iiH8EtHs1JOf5cO2+rrc3BAtSA6hpY3ekRRbpIMPRs71ft3JWIWue/ynvXgzY8g
         4RP1tkgzznA7644t8ep7QfqVHT8ZJbGkHemvYuMKg50Ios5UqpK4se4VNV0vope81EzV
         NsTXawhsXZQLvOQ2RHsNHpZ9v+4zoq1VOGSFabTsDPWCg9TeTGzqqkbpbdhgQvFZAKSA
         YRHCypSw7tS5YpGn95UimMmIL+8heo8XHJUKKC+7wiu64s9xHk0eZ9He5BUv09uKK1fH
         VMQ/5OIROTed3ryZIYRM69t5hFQTfWjdDdZHOGuRyS3l5WMcec1EHnEb846FbvRTcA10
         zlfg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 4/4] configs: khadas-vim3{l}_android_ab: enable A/B support
Date: Mon, 22 Nov 2021 16:22:07 +0100
Message-Id: <20211122152207.219023-5-mkorpershoek@baylibre.com>
In-Reply-To: <20211122152207.219023-1-mkorpershoek@baylibre.com>
References: <20211122152207.219023-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

meson64_android.h also relies on CMD_AB_SELECT so enable that as well.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  | 2 ++
 configs/khadas-vim3l_android_ab_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index 9305a54b1b..88325c37db 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_AVB_VERIFY=y
+CONFIG_ANDROID_AB=y
 # CONFIG_CMD_BDI is not set
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
@@ -33,6 +34,7 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 5eed79b263..608b54dca2 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_AVB_VERIFY=y
+CONFIG_ANDROID_AB=y
 # CONFIG_CMD_BDI is not set
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
@@ -33,6 +34,7 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
-- 
2.32.0

