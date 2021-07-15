Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.3972.1626325240682688014
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Jul 2021 22:00:40 -0700
Received: by mail-pl1-f175.google.com with SMTP id j3so2562503plx.7
        for <u-boot-amlogic@groups.io>; Wed, 14 Jul 2021 22:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SIpmeBMqzPgPWeYQsEdzrMqNI1K1YOXb5LArwdixWrg=;
        b=Jrir+0wU5DGQC+mGwx61ANOWlNRuAxoyShX87k9oJ/nzBMCp+ia2vtiDzZeVQnO+Vj
         o8or9RVbHawCUuHyQ5XARoJBa9whpZlo+BZP4udAWYgyN1rqklPwM//9UgmdP38lvc3G
         s9OywJbSBkkpX7RxYlIHVqDd23B7XSqOwCoIg3U9EziIoIL0PooO15F8Sx0yTVfspRn3
         mCb1+qVyGwL6rRaJEtaqZCddNbFRflr0cnMu3TCliQx9xCWCFpzos9hrN5vsJuYp72o+
         KGRkL4lnKUEjx8Zmpcc5dhpTTSHiF18y25tCAPr8tfEAej3jssxDqEaLCowFBTvfWaIq
         jMkg==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] configs: khadas-vim*: Enable SMBIOS
Date: Thu, 15 Jul 2021 13:00:26 +0800
Message-Id: <20210715050026.2940786-2-art@khadas.com>
In-Reply-To: <20210715050026.2940786-1-art@khadas.com>
References: <20210715050026.2940786-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Enable configs to support SMBIOS for all Khadas vim* boards

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 configs/khadas-vim2_defconfig  | 2 ++
 configs/khadas-vim3_defconfig  | 2 ++
 configs/khadas-vim3l_defconfig | 2 ++
 configs/khadas-vim_defconfig   | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 32513998..5d673463 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -50,6 +50,8 @@ CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MESON_SPIFC=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index c4b24fc3..5a7a9006 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -61,6 +61,8 @@ CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MESON_SPIFC=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 0c731d4c..d719511f 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -61,6 +61,8 @@ CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MESON_SPIFC=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 2df00d54..dc6365fc 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -44,6 +44,8 @@ CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
 CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.25.1

