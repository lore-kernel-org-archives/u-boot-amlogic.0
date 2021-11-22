Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.7766.1637594537120849922
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 07:22:17 -0800
Received: by mail-wr1-f45.google.com with SMTP id b12so33384401wrh.4
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KItTKkcvzTclD7NFE03bbt0tBpQsnR/n14bLXCDBW7U=;
        b=zfeDhAq1DR/3SR8V/bhG+3ZwT4aLQkN1JQlYEQgSK9WctKgzAO6BlI1S+hmYEtpvaY
         r5wWEl0KC8VZBi5SByTwPUfWAiJ+ZQTFVRKaXJBBW+e6l9w7yAG6C7A5k+y14lA6C90i
         vSnaVYvUmasJtVjd4xOt8D7HS2L5fkW8g9K0PX32D6nxC7HEO+eD0rhB5dcWC9j4UnhI
         JuIdrPOzyQOgjBQdi+jicpTd1XBI9+Opz9wPlOLlvODNRv5RWCdXBejiXPuPR+B9dz4Y
         oRcOFkuomVd5ES1FJLtHd146P0JE2lsEeNb57igELFbzCLiCBPg4uZcjyOB6Dy+Hm9w/
         yHww==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 1/4] configs: meson64_android: add board specific env settings
Date: Mon, 22 Nov 2021 16:22:04 +0100
Message-Id: <20211122152207.219023-2-mkorpershoek@baylibre.com>
In-Reply-To: <20211122152207.219023-1-mkorpershoek@baylibre.com>
References: <20211122152207.219023-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This allows us to define extra board variables, such as "board" and
"board_name".

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 7cd1ab0341..56dc9fcb07 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -23,6 +23,10 @@
 #define CONTROL_PARTITION "misc"
 #endif
 
+#ifndef EXTRA_ANDROID_ENV_SETTINGS
+#define EXTRA_ANDROID_ENV_SETTINGS ""
+#endif
+
 #if defined(CONFIG_CMD_AVB)
 #define AVB_VERIFY_CHECK \
 	"if test \"${force_avb}\" -eq 1; then " \
@@ -264,6 +268,7 @@
 	"fi;"
 
 #define CONFIG_EXTRA_ENV_SETTINGS                                     \
+	EXTRA_ANDROID_ENV_SETTINGS                                    \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
 	ANDROIDBOOT_GET_CURRENT_SLOT_CMD                              \
-- 
2.32.0

