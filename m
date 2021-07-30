Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web12.21402.1627635349930172559
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 01:55:50 -0700
Received: by mail-wm1-f53.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso2258891wms.1
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikuaBi3MWYFHK3dpRhSbiC86S4s+BFWddXPBKrf9rUI=;
        b=nafdGK1w4nm9cTIRdlz69P5PY1dVhi+kCQWaPLhkuUnBkz8brOWGkq4xDv7srA8z8e
         SklhpAaWQ9Qmv3Mp7jMTdiboDQUagdhkSv06RdHaa3lD/dHCdwEDnxZl31g64Q6Fl13U
         v8DSPdOsE3ZrJboN3hk/ZGSJHJHkKCDDYYORCtfx26LN4OvOxlaUapwnN+YwjNzdxBpP
         MpOdwkURomwoYz6lpQqQNldL18r+aUnjNILieD6GXkpau/Bs4DsrTUwYgQSUB1Cj4T/G
         DPMtZdYNAhP/EoTrtpdoMseq4xcwtJOuZ7bgr7cLqTZ7YKaV7oh33btelp0ihDMjEMnZ
         h6pw==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 4/5] configs: meson64_android: reboot to fastbootd from bootloader
Date: Fri, 30 Jul 2021 10:55:30 +0200
Message-Id: <20210730085531.2849834-5-mkorpershoek@baylibre.com>
In-Reply-To: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
References: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Whenever we test for boot-fastboot in the BCB, it means that Android
wants us to boot into recovery with a special mode (fastbootd).

Force reboot into recovery in that case.

Note: we don't erase the bcb on purpose here: recoveryOS needs to read
the BCB as well to know if it boots into regular recovery mode or
fastbootd mode.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index ce08346b70..f9f2b26416 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -44,6 +44,10 @@
 				"bcb clear command; bcb store; " \
 				"setenv run_fastboot 1;" \
 			"fi; " \
+			"if bcb test command = boot-fastboot; then " \
+				"echo BCB: fastboot userspace boot...; " \
+				"setenv force_recovery 1;" \
+			"fi; " \
 		"else " \
 			"echo Warning: BCB is corrupted or does not exist; " \
 		"fi;" \
-- 
2.30.2

