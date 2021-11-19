Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.7062.1637316520633473726
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Nov 2021 02:08:41 -0800
Received: by mail-wr1-f47.google.com with SMTP id s13so17232174wrb.3
        for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 02:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KItTKkcvzTclD7NFE03bbt0tBpQsnR/n14bLXCDBW7U=;
        b=Ma7ga53d67lVSUV6/LLHjvLFHBrWPBL3OseyV9iQE3XynLkcGorIX5J+FejPAC3yhp
         BykJfxiYz/1WW7OLq/xiB9rLSj207yMFwCmxmw8IS8/QpiEeCWH9X7cG0dMNZCwSZgDo
         XATKNCY21PshUHXleF5BC0sPXsf8F7UohSMGMTMv/j15RZItsShbeugutJ7MaNf+wWKJ
         zsHk5VKX0cvBobUG0MqadLuNnOwDAFau6mmZYROoNtM8KAMLPoxvTWe75rpR5ittg2y2
         ruS6cnKNamfFoGCKdDn98l6kYtn+3gdo/EqIKHAxS6YSamyxTXVtcjbrNz0oHFFt0GS9
         w77w==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 1/5] configs: meson64_android: add board specific env settings
Date: Fri, 19 Nov 2021 11:08:25 +0100
Message-Id: <20211119100829.843139-2-mkorpershoek@baylibre.com>
In-Reply-To: <20211119100829.843139-1-mkorpershoek@baylibre.com>
References: <20211119100829.843139-1-mkorpershoek@baylibre.com>
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

