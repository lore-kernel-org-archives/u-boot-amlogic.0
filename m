Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.5625.1637147060916035271
 for <u-boot-amlogic@groups.io>;
 Wed, 17 Nov 2021 03:04:21 -0800
Received: by mail-wr1-f46.google.com with SMTP id i5so3879457wrb.2
        for <u-boot-amlogic@groups.io>; Wed, 17 Nov 2021 03:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fE6VzjC5ZDGCCiZgblX9l8PcIdLIGAuRlD+eDG5YwlA=;
        b=CgYWdTSje4/eWVX57FIV5JoHElMm+gtCzEu/fuLhmI1h0WpUc1SSt3F+bqgTEDxYQo
         i4oB/n9/u4MYm+j6s5nM8QXsqtAyv0kfs0lI7sRNlbzDLh4ygYqXD91QCx07Ge5DzSr9
         pxs8KcZR72SVDqJjue+bDMxQ2ptudbcGhzb9inKMM4u3C9Ow6YoQjAkUXEagPxR3+Njn
         rj4U3OMiH+6WbCfdkSDOR1bsVC8Ks5BcL5O8kZEwGuukbuBbrp6aNupyqTfjJhGDZSU1
         C1ebKNa3PqBzwePuLyS2mJyAR/p4bbdo0Vnsmdj/Jcq01DE3/2aoCcsYCtsI/1PK8Zpn
         zbVw==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 1/2] configs: meson64_android: bypass other checks on run_fastboot=1
Date: Wed, 17 Nov 2021 12:04:10 +0100
Message-Id: <20211117110411.710190-2-mkorpershoek@baylibre.com>
In-Reply-To: <20211117110411.710190-1-mkorpershoek@baylibre.com>
References: <20211117110411.710190-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: "To : Neil Armstrong" <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Neil Armstrong <narmstrong@baylibre.com>

This can lead to GPT and BCB errors even if fastboot was selected early
by usb rom boot and the eMMC is blank/invalid.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 35 +++++++++++++++++--------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index fb3ccc329a7e..93d8f8ec99de 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -140,24 +140,27 @@
 			"echo Fastboot forced by usb rom boot;" \
 			"setenv run_fastboot 1;" \
 		"fi;" \
-		"if gpt verify mmc ${mmcdev} ${partitions}; then; " \
-		"else " \
-			"echo Broken MMC partition scheme;" \
-			"setenv run_fastboot 1;" \
-		"fi;" \
-		"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
-		CONTROL_PARTITION "; then " \
-			"if bcb test command = bootonce-bootloader; then " \
-				"echo BCB: Bootloader boot...; " \
-				"bcb clear command; bcb store; " \
+		"if test \"${run_fastboot}\" -eq 0; then " \
+			"if gpt verify mmc ${mmcdev} ${partitions}; then; " \
+			"else " \
+				"echo Broken MMC partition scheme;" \
 				"setenv run_fastboot 1;" \
 			"fi; " \
-			"if bcb test command = boot-fastboot; then " \
-				"echo BCB: fastboot userspace boot...; " \
-				"setenv force_recovery 1;" \
-			"fi; " \
-		"else " \
-			"echo Warning: BCB is corrupted or does not exist; " \
+		"fi;" \
+		"if test \"${run_fastboot}\" -eq 0; then " \
+			"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
+			CONTROL_PARTITION "; then " \
+				"if bcb test command = bootonce-bootloader; then " \
+					"echo BCB: Bootloader boot...; " \
+					"bcb clear command; bcb store; " \
+					"setenv run_fastboot 1;" \
+				"elif bcb test command = boot-fastboot; then " \
+					"echo BCB: fastboot userspace boot...; " \
+					"setenv force_recovery 1;" \
+				"fi; " \
+			"else " \
+				"echo Warning: BCB is corrupted or does not exist; " \
+			"fi;" \
 		"fi;" \
 		"if test \"${run_fastboot}\" -eq 1; then " \
 			"echo Running Fastboot...;" \
-- 
2.32.0

