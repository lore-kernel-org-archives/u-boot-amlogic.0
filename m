Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web08.14864.1604070249042885329
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Oct 2020 08:04:09 -0700
Received: by mail-wr1-f65.google.com with SMTP id b3so904725wrx.11
        for <u-boot-amlogic@groups.io>; Fri, 30 Oct 2020 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o047Mtfnd56TayA6tBZollNI9M9F09foxc9AKiYBGb0=;
        b=LZMfIZ8dDHzwkJ13PH4ZhRC5g2WlUGl9jxzGK4URsnViXfyaCNQPf410ZVV2VnHiMB
         M6hksZWU7BMrujFgDIvkXC03P46aGS87UbENnfBHIqUIRoyJJypuXE74jORo/0VvLR5H
         9QEry5pwNEveRHTltuRQyGXvjhDOER78xnLHUYag6is3PJvTypARMZ278nSaNEzvUMAp
         BV64fk4D3ATgwn7cpWS+petLdIBHsqq2w29X/jNlfCgRuObO+/ZwSuY2WsrEFVgnomqi
         eb0JnTq2xACqlT+lSfvVAmhFkOEFk7L9B91rQzZI2Chp1UepncbbjABYkyllLxoA3Mo8
         CSMA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH] configs: meson64_android: don't show logo on ROM USB boot
Date: Fri, 30 Oct 2020 16:03:44 +0100
Message-Id: <20201030150345.121429-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Guillaume La Roque <glaroque@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

From: Guillaume La Roque <glaroque@baylibre.com>

When booting from rom usb, skip the boot logo logic as it's possible
that the partition containing the logo does not exist yet.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 8fff915b50a4..c47d51c85368 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -98,11 +98,14 @@
 	func(SYSTEM, system, na) \
 
 #define PREBOOT_LOAD_LOGO \
-	"mmc dev ${mmcdev};" \
-	"part start mmc ${mmcdev} ${logopart} boot_start;" \
-	"part size mmc ${mmcdev} ${logopart} boot_size;" \
-	"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
+	"if test \"${boot_source}\" != \"usb\" && " \
+		"gpt verify mmc ${mmcdev} ${partitions}; then; " \
+		"mmc dev ${mmcdev};" \
+		"part start mmc ${mmcdev} ${logopart} boot_start;" \
+		"part size mmc ${mmcdev} ${logopart} boot_size;" \
+		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
 			"bmp display ${loadaddr} m m;" \
+		"fi;" \
 	"fi;"
 
 #define CONFIG_EXTRA_ENV_SETTINGS                                     \
-- 
2.25.1

