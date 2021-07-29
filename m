Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.6387.1627543282655031287
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 00:21:23 -0700
Received: by mail-wm1-f44.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so662991wms.2
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 00:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10Dmd8yHQ9SOnTjpQsAY1qUXx0h8BepXL9g0+xCzzSY=;
        b=IQJKVhTgiYc5BKtAhoTI+rb+wwcpIgPTTuZHo3MeRfB44QP7LxtDM9tQ/g4jgT4JtK
         9rD+UO4zMkY//kl6JA08MY71ceHw3eLa8UXHuFrdCAzKDXYys2di+s3LmuEm3ocNZvqJ
         j7CQKlVbSbXhC9lczH7O+uilxIli8Q+k3xb1yzVbgY1ku2+MwzXX/AqkqNWQmAYArpqZ
         +/p9SoWfksDVeQ3GF+j7JiXd2Y0kj0Td7eyDdX6DBgBhbwcRniNyooMrv2cL4SgZjM2c
         OTACZRejQ3kPeiVscW7LfLzN7LAYhPYRhKdyvayZWk0fDXVmq7oThnN337/LwM3CoWJs
         gHaA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 6/6] configs: meson64_android: don't set console bootargs
Date: Thu, 29 Jul 2021 09:21:13 +0200
Message-Id: <20210729072113.208099-7-mkorpershoek@baylibre.com>
In-Reply-To: <20210729072113.208099-1-mkorpershoek@baylibre.com>
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The console bootargs are already set from the kernel commandline.
On Android, this is done in yukawa at [1]

Don't set it in the bootloader since it's overridden by the kernel anyways.

[1] https://android-review.googlesource.com/c/device/amlogic/yukawa/+/1112994
Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 56545a72f8..3b61d5f703 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -86,7 +86,7 @@
 	"bootcmd_system=" \
 		"echo Loading Android " BOOT_PARTITION " partition...;" \
 		"mmc dev ${mmcdev};" \
-		"setenv bootargs ${bootargs} console=${console} androidboot.serialno=${serial#};" \
+		"setenv bootargs ${bootargs} androidboot.serialno=${serial#};" \
 		"part start mmc ${mmcdev} " BOOT_PARTITION " boot_start;" \
 		"part size mmc ${mmcdev} " BOOT_PARTITION " boot_size;" \
 		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
@@ -121,8 +121,6 @@
 	"gpio_recovery=88\0"                                          \
 	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
 	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
-	"console=/dev/ttyAML0\0"                                      \
-	"bootargs=no_console_suspend\0"                               \
 	"stdin=" STDIN_CFG "\0"                                       \
 	"stdout=" STDOUT_CFG "\0"                                     \
 	"stderr=" STDOUT_CFG "\0"                                     \
-- 
2.30.2

