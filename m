Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.10219.1628176657209201177
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:37 -0700
Received: by mail-wm1-f45.google.com with SMTP id u15so3600309wmj.1
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7G233Z/nsEmw3ml1knD5a3G7CkfabTWR9eG6Z9Vj8c4=;
        b=ud17pusSKPeHUUW1PMrm+jEC86LzU0+Lio2x2bQXJJpZiNmLQrH5EezzClAWA0wLba
         UGTNF7zSXQfTVpUP2q6jy0B1JmGSVuCC1ctvLv+OH65ZGqFtWTPsLnwe+awYCvWA2hRC
         43adFH1gAF9SzZXbqi1fp+vPrc6YLoPA91TuTtFYDfXXrXaxNjJwRucoGknNs9iWISXv
         I7f78CWTmPAPEbrZNmWDOF38YsWdvAwXSbWArm2JLPLq/rTmcYeBlyiT4nqNFlOX/Bus
         3mJSG2svJHW1p44e7nMzRgFkDpwuHKnxDwVciZWJN0wTu8kBaLohBvffB59IT9TYHowq
         pQsQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 3/9] configs: meson64_android: implement AVB support
Date: Thu,  5 Aug 2021 17:17:22 +0200
Message-Id: <20210805151728.422329-4-mkorpershoek@baylibre.com>
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

AVB (Android Verified Boot) is well supported in U-Boot already.
Add support for it in meson64_android.

This is controlled by the "force_avb" environment variable and the
CONFIG_CMD_AVB option.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index bc3ffb9ca5..48a23b6e41 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -27,6 +27,25 @@
 
 #ifndef RECOVERY_PARTITION
 #define RECOVERY_PARTITION "recovery"
+
+#if defined(CONFIG_CMD_AVB)
+#define AVB_VERIFY_CHECK \
+	"if test \"${force_avb}\" -eq 1; then " \
+		"if run avb_verify; then " \
+			"echo AVB verification OK.;" \
+			"setenv bootargs \"$bootargs $avb_bootargs\";" \
+		"else " \
+			"echo AVB verification failed.;" \
+		"exit; fi;" \
+	"else " \
+		"setenv bootargs \"$bootargs androidboot.verifiedbootstate=orange\";" \
+		"echo Running without AVB...; "\
+	"fi;"
+
+#define AVB_VERIFY_CMD "avb_verify=avb init ${mmcdev}; avb verify;\0"
+#else
+#define AVB_VERIFY_CHECK ""
+#define AVB_VERIFY_CMD ""
 #endif
 
 #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
@@ -93,6 +112,7 @@
 			"echo Running Recovery...;" \
 			"mmc dev ${mmcdev};" \
 			"setenv bootargs \"${bootargs} androidboot.serialno=${serial#}\";" \
+			AVB_VERIFY_CHECK \
 			"part start mmc ${mmcdev} " RECOVERY_PARTITION " boot_start;" \
 			"part size mmc ${mmcdev} " RECOVERY_PARTITION " boot_size;" \
 			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
@@ -111,6 +131,7 @@
 		"echo Loading Android " BOOT_PARTITION " partition...;" \
 		"mmc dev ${mmcdev};" \
 		"setenv bootargs ${bootargs} androidboot.serialno=${serial#};" \
+		AVB_VERIFY_CHECK \
 		"part start mmc ${mmcdev} " BOOT_PARTITION " boot_start;" \
 		"part size mmc ${mmcdev} " BOOT_PARTITION " boot_size;" \
 		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
@@ -142,6 +163,8 @@
 #define CONFIG_EXTRA_ENV_SETTINGS                                     \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
+	AVB_VERIFY_CMD                                                \
+	"force_avb=0\0"                                               \
 	"gpio_recovery=88\0"                                          \
 	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
 	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
-- 
2.30.2

