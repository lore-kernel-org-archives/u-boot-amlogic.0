Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web09.21408.1627635348537720852
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 01:55:48 -0700
Received: by mail-wm1-f51.google.com with SMTP id m19so5504320wms.0
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwXAkF87QPTPRc+zqGZAmDHELhNVXyx8HLzDgIG/iiM=;
        b=oA0HAp3mfCdzgTNmx/jeHL52TVPO25Fwwhqd9Hj6/WwshNpWfGESLJfehx5ME9FwsL
         0YiDo6c72OnJXXe6hOX6Lblci0AJW6bUaTGYxGOBvv3KqQ40o0Hp5XfYFNNPvT3H1BPc
         ScOHhHuJgqKoPTFR/P4HwUAacDc6yATjeCibY7duEsOjcA3fI69TFwwjNxTGumwG8yIa
         O0S9y8ZMgvxuCAPw+r5tA/aWpnOzSVkj9tyo1fq6oFPV2UWCPkZJL4U/OSzuXecQywP3
         8Vmrg9xa6Uk8JI+G5bkvwREOiwE7tph/0BKk1OIxdtJ4M7F8nCkbg1yMlLTXWTuH5K6d
         HohQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 2/5] configs: meson64_android: use BCB for reboot to bootloader
Date: Fri, 30 Jul 2021 10:55:28 +0200
Message-Id: <20210730085531.2849834-3-mkorpershoek@baylibre.com>
In-Reply-To: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
References: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

As of today, we use a "vendor specific" secure monitor call for the
reboot reason (sm).

We should not need this. Android uses the BCB (Bootloader Control Block)
to communicate with the bootloader.

Implement "reboot into bootloader" using the standard BCB way instead of
using sm calls.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 3b61d5f703..d732032d1f 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -17,9 +17,12 @@
 #define LOGO_PARTITION "logo"
 #endif
 
+#ifndef CONTROL_PARTITION
+#define CONTROL_PARTITION "misc"
+#endif
+
 #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
 	"bootcmd_fastboot=" \
-		"sm reboot_reason reason;" \
 		"setenv run_fastboot 0;" \
 		"if test \"${boot_source}\" = \"usb\"; then " \
 			"echo Fastboot forced by usb rom boot;" \
@@ -30,18 +33,15 @@
 			"echo Broken MMC partition scheme;" \
 			"setenv run_fastboot 1;" \
 		"fi;" \
-		"if test \"${reason}\" = \"bootloader\" -o " \
-			"\"${reason}\" = \"fastboot\"; then " \
-			"echo Fastboot asked by reboot reason;" \
-			"setenv run_fastboot 1;" \
-		"fi;" \
-		"if test \"${skip_fastboot}\" -eq 1; then " \
-			"echo Fastboot skipped by environment;" \
-			"setenv run_fastboot 0;" \
-		"fi;" \
-		"if test \"${force_fastboot}\" -eq 1; then " \
-			"echo Fastboot forced by environment;" \
-			"setenv run_fastboot 1;" \
+		"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
+		CONTROL_PARTITION "; then " \
+			"if bcb test command = bootonce-bootloader; then " \
+				"echo BCB: Bootloader boot...; " \
+				"bcb clear command; bcb store; " \
+				"setenv run_fastboot 1;" \
+			"fi; " \
+		"else " \
+			"echo Warning: BCB is corrupted or does not exist; " \
 		"fi;" \
 		"if test \"${run_fastboot}\" -eq 1; then " \
 			"echo Running Fastboot...;" \
-- 
2.30.2

