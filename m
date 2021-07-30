Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web12.23102.1627648103184943656
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 05:28:23 -0700
Received: by mail-wr1-f42.google.com with SMTP id b7so11115284wri.8
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Um4xMNLtpnXAHSbdw3xyZRQbMwTCm27xxuxWxDhzXTg=;
        b=RgLgrS6fA3Z2tsh6nSGUTReaIAMi0C5WPq79fTcw7G8NBZYcwXCXdbZgYx1fTwAJRW
         hes8v3COddgVHIkm1FIwb+spGf47XeSKxzgGArmx948DgYLsYtUKD0Wsdzii6VohETar
         joNVQ1ObOzErcop/2VigDq3gk9ihx0jduzccvpRE8KbequfqiplDdNkNE2Lv24/an8WI
         bJFNkJbObQV8SRLHWnGuXAmExrsDmlAmcAz9/m+1UMEAZ+BXqIn3Sv+BE7uLZnWj0n5D
         YYtEjut0h4/T3ELWSPGnXO7rjJWewaaY7CLiXO62Ov7RhdYfFGy3W/cH+ayKNzUh3yBW
         H4ZA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 4/5] configs: sei610/sei510: set CONFIG_CMD_BCB=y
Date: Fri, 30 Jul 2021 14:28:11 +0200
Message-Id: <20210730122812.3011529-5-mkorpershoek@baylibre.com>
In-Reply-To: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
References: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

SEI-610 and SEI-510 are both for Android boards based on Yukawa[1]

Enable the BCB command to enable the standard Android boot flow.

[1] https://android.googlesource.com/device/amlogic/yukawa/
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/sei510_defconfig | 1 +
 configs/sei610_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 63b3043a15..74328f2fd4 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -22,6 +22,7 @@ CONFIG_PREBOOT="run load_logo"
 CONFIG_MISC_INIT_R=y
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_BCB=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 # CONFIG_CMD_LOADS is not set
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 56f136ed96..2a6d0e5995 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -22,6 +22,7 @@ CONFIG_PREBOOT="run load_logo"
 CONFIG_MISC_INIT_R=y
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_BCB=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 # CONFIG_CMD_LOADS is not set
-- 
2.30.2

