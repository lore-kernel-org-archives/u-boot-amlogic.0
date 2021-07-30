Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.21549.1627635350560254239
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 01:55:50 -0700
Received: by mail-wm1-f51.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so5880325wmb.5
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wopJLbshBbJ0yAY6TGYxFarST2sO/FPyw0VH87cgZ0=;
        b=Hjnu/fvubRXIrCP3CKgX2D+4EKxfzA6lKqI5324bDY/bjz8g7iKOz12ojNFoEQ4Sgt
         5J3X8KVYfzdf1f5SaiPnug78y1OaxMLPDKAscVmWJxzR9R08GC0fUDFFq9SHwTir+J0c
         +Jqb99iXN8YAJu1PtMfCqfi7ReC2mdnhsGjFj7LIiZ7Sc9YRGee1UBv6hOPmnQOR1Tge
         Cs2RUiqUugIpwjMkpNBveJ8XS7bB74KUsTMgCes8bjmiwTEtcMLY8isUFh1g3d7NHQAt
         U0OIwAYkYYfB5iPbNSPe33akc42vsVYY7RUSA5L3UItJLvSv0UvVAolPmnLvL6UOXS6o
         FvYQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 5/5] configs: sei610/sei510: set CONFIG_CMD_BCB=y
Date: Fri, 30 Jul 2021 10:55:31 +0200
Message-Id: <20210730085531.2849834-6-mkorpershoek@baylibre.com>
In-Reply-To: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
References: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

SEI-610 and SEI-510 are both for Android boards based on Yukawa[1]

Enable the BCB command to enable the standard Android boot flow.

[1] https://android.googlesource.com/device/amlogic/yukawa/
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

