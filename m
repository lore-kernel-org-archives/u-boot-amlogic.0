Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.3586.1574802742003018626
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2019 13:12:22 -0800
Received: by mail-pj1-f54.google.com with SMTP id v93so5604648pjb.6
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2019 13:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s9SYFed2li0gjwdLiy4aTYNCTG6N2ZIHd14LywtY+OI=;
        b=L6fv7z55lgc6PYXoGFP0DW2KMgDbejupISVeIPYytWDM0DdbCvaIw3IfeR7rSb7e4/
         Lszq1IcVgmenK1HToqIs/E5xvlsCK5nGXMwcU9Se6r8xfoMO7ZKisKT7mAcHJEciyko3
         QSEWHqkA0voNlj4z1b0DAX/e8pkpNIgxDxQ1jX+SbN/8o5Q+2IiE+/2/6jTee3CnqDI+
         5XDa5jIIxhNMzmKKwOI19lls4Yzzmw5tNsLa+M5NsXaCYEG2V3Sro1mO+Ieftuq2Wyea
         UIqbthETS6uEKj2EGj0MvieDzjnbbT5w7/igIvkdzOgOwvHIAY8aJJBY7F7wmOvRYBwi
         qt9A==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCH 4/4] board: amlogic: Add missing config option
Date: Tue, 26 Nov 2019 21:12:06 +0000
Message-Id: <20191126211206.4537-5-linux.amoon@gmail.com>
In-Reply-To: <20191126211206.4537-1-linux.amoon@gmail.com>
References: <20191126211206.4537-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add missing config option CONFIG_MESON_GXBB and CONFIG_SYS_BOARD,
for odroid-c2 and nanopi k2 board

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/nanopi-k2_defconfig | 2 ++
 configs/odroid-c2_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index 7bdeb7906a..3d6265c587 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -1,6 +1,8 @@
 CONFIG_ARM=y
+CONFIG_SYS_BOARD="p200"
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_GXBB=y
 CONFIG_ENV_SIZE=0x2000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 1f5a52c57c..700c871918 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -1,6 +1,8 @@
 CONFIG_ARM=y
+CONFIG_SYS_BOARD="p200"
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_GXBB=y
 CONFIG_ENV_SIZE=0x2000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEBUG_UART_BASE=0xc81004c0
-- 
2.24.0

