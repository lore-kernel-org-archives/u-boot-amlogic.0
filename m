Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web09.10170.1628176658741028729
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:39 -0700
Received: by mail-wm1-f51.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so6629535wms.2
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCHnjr/Ze2qLVyLHYtJB6YP4KbDbL4lVQpR9ACqXOvU=;
        b=RhIVgD/1yZdT9YyI+MO3ZxosF9B88frjWpYoi14bFNKaV8te9kGwO4PpkkqQz8+9X4
         Dy9HwFZTQ9pF8fYrOyA2hgCm+5h8J84E6ZsAZimGjmhLZ+8wF6IrdKeG90rdre6VWdhY
         tNCVNTBGQxQGvi2ncSlon404IVkfO3M1mnB/uOf/hClEAkbS3OG+7ta4NL/ePVCZ5PDi
         fpmzKVDFMK3gLBObRgaiAgayJmKmY8u8Ntq5H5FEL8NGhkofniB9F86jca87aBq96Vax
         UtidjCP0B8mHPcmuW2bkNwnkErYk4fZsSuok4z5CSCOqubSIRdb113POBMsOMn2KKkhC
         ZFQQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 5/9] configs: meson64_android: define BOOT_CMD macro
Date: Thu,  5 Aug 2021 17:17:24 +0200
Message-Id: <20210805151728.422329-6-mkorpershoek@baylibre.com>
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

BOOT_CMD might be different based on CONFIG_CMD_ABOOTIMG.

To prepare for abootimg support, extract the boot command
to a dedicated macro.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 83fa25bfb1..0ce616c17e 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -81,6 +81,8 @@
 #define RECOVERY_PARTITION "recovery"
 #endif
 
+#define BOOT_CMD "bootm ${loadaddr};"
+
 #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
 	"bootcmd_fastboot=" \
 		"setenv run_fastboot 0;" \
@@ -152,7 +154,7 @@
 			"part size mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_size;" \
 			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
 				"echo Running Android Recovery...;" \
-				"bootm ${loadaddr};" \
+				BOOT_CMD \
 			"fi;" \
 			"echo Failed to boot Android...;" \
 			"reset;" \
@@ -174,7 +176,7 @@
 		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
 			"setenv bootargs \"${bootargs} " AB_BOOTARGS "\"  ; " \
 			"echo Running Android...;" \
-			"bootm ${loadaddr};" \
+			BOOT_CMD \
 		"fi;" \
 		"echo Failed to boot Android...;" \
 		"reset\0"
-- 
2.30.2

