Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.21401.1627635349122946246
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 01:55:49 -0700
Received: by mail-wr1-f51.google.com with SMTP id m12so5532032wru.12
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbqV0rLAycuche5CEuffOZvdUmfadvA6SjfRP4Xg+AI=;
        b=H9XQ41eCo0MsxrtqEfqofVpvpI6+W/liyc7GIAg0Wcw1w+NJErEaXBqonStHHy+aPP
         zj3sTi+2gsGuPhecgGIdgqZbEyN17+sjvlxkLUTm06yHAn/O7EMD7hCRW2petnFRzctq
         dySHyW8fk3aUUEochByGxg8FPT2g0JBchC6y6ig+14n53WYC76lsPuMWPqkWBVP29sXu
         5RZZmdAsA2AxMHPiBIUDxiHC8x+/TRTjooFvnzbibZWu/1COb5auK1x4cjGCV5vcCRmO
         t2RB3usC/ltSDyP6cJ/KEruAZ35TTPE5CCcfL++ZMoi3dNeob31GMxNoc22+GPJ/mftY
         MxDg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 3/5] configs: meson64_android: implement recovery boot via BCB
Date: Fri, 30 Jul 2021 10:55:29 +0200
Message-Id: <20210730085531.2849834-4-mkorpershoek@baylibre.com>
In-Reply-To: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
References: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Right now meson64_android does not know how to boot into Android
Recovery: it simply falls back to "fastboot" mode in the bootloader.

Implement the boot to recovery.
While at it, use the standard BCB way instead of a sm for consistency.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index d732032d1f..ce08346b70 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -21,6 +21,10 @@
 #define CONTROL_PARTITION "misc"
 #endif
 
+#ifndef RECOVERY_PARTITION
+#define RECOVERY_PARTITION "recovery"
+#endif
+
 #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
 	"bootcmd_fastboot=" \
 		"setenv run_fastboot 0;" \
@@ -51,20 +55,23 @@
 #define BOOTENV_DEV_NAME_FASTBOOT(devtypeu, devtypel, instance)	\
 		"fastboot "
 
-/* TOFIX: Run actual recovery instead of fastboot */
 #define BOOTENV_DEV_RECOVERY(devtypeu, devtypel, instance) \
 	"bootcmd_recovery=" \
 		"pinmux dev pinctrl@14;" \
 		"pinmux dev pinctrl@40;" \
-		"sm reboot_reason reason;" \
 		"setenv run_recovery 0;" \
 		"if run check_button; then " \
 			"echo Recovery button is pressed;" \
 			"setenv run_recovery 1;" \
-		"elif test \"${reason}\" = \"recovery\" -o " \
-			  "\"${reason}\" = \"update\"; then " \
-			"echo Recovery asked by reboot reason;" \
-			"setenv run_recovery 1;" \
+		"fi; " \
+		"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
+		CONTROL_PARTITION "; then " \
+			"if bcb test command = boot-recovery; then " \
+				"echo BCB: Recovery boot...; " \
+				"setenv run_recovery 1;" \
+			"fi;" \
+		"else " \
+			"echo Warning: BCB is corrupted or does not exist; " \
 		"fi;" \
 		"if test \"${skip_recovery}\" -eq 1; then " \
 			"echo Recovery skipped by environment;" \
@@ -76,7 +83,16 @@
 		"fi;" \
 		"if test \"${run_recovery}\" -eq 1; then " \
 			"echo Running Recovery...;" \
-			"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
+			"mmc dev ${mmcdev};" \
+			"setenv bootargs \"${bootargs} androidboot.serialno=${serial#}\";" \
+			"part start mmc ${mmcdev} " RECOVERY_PARTITION " boot_start;" \
+			"part size mmc ${mmcdev} " RECOVERY_PARTITION " boot_size;" \
+			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
+				"echo Running Android Recovery...;" \
+				"bootm ${loadaddr};" \
+			"fi;" \
+			"echo Failed to boot Android...;" \
+			"reset;" \
 		"fi\0"
 
 #define BOOTENV_DEV_NAME_RECOVERY(devtypeu, devtypel, instance)	\
-- 
2.30.2

