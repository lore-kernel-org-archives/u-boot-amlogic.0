Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.6385.1627543282017404401
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 00:21:22 -0700
Received: by mail-wm1-f50.google.com with SMTP id n11so3043193wmd.2
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ilB/0KtVhgiWDvHkupwVm1+e0wwidjKmxaTajvjvnqg=;
        b=oLqBFsAZ6no3vZQFSHgLbueArqyD05CzA6tUXLaalueIMA2eiPppNYGGMYrIfBC2ed
         KaCILkLnRa2vDU4216U5620zg6aih/dgUpBSKZmAoHecsBbxvy+5tuxOVeQrJOVRwKON
         UAhvQdvoDly4xjg/IkATsxhVgaTM4m3x5ik7cabxDICrU55gOrN+Dbx61LCqA1CFgP24
         tbEa9VFhLcxqrz9fc9mmX8AMF9j7JdVEutjjobI56K57Kr3EmKe85chGo6X3acD4EbOJ
         aSwEwHe1m2L0K0ox2iwsh9ogKx3AmXRPuau50N9oTZNzqWpcaXGnhAqhFbiNMKXnIXAV
         pDDQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 5/6] configs: meson64_android: use logo part label instead of index
Date: Thu, 29 Jul 2021 09:21:12 +0200
Message-Id: <20210729072113.208099-6-mkorpershoek@baylibre.com>
In-Reply-To: <20210729072113.208099-1-mkorpershoek@baylibre.com>
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

To display the bootup logo, we read the gpt and assume that the
partition with index "2" will be the "logo" partition.

This might not always be the case, and it's very error-prone.

Load the logo partition by label instead of by index.

Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index e22f05c889..56545a72f8 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -13,6 +13,10 @@
 #define BOOT_PARTITION "boot"
 #endif
 
+#ifndef LOGO_PARTITION
+#define LOGO_PARTITION "logo"
+#endif
+
 #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
 	"bootcmd_fastboot=" \
 		"sm reboot_reason reason;" \
@@ -104,8 +108,8 @@
 	"if test \"${boot_source}\" != \"usb\" && " \
 		"gpt verify mmc ${mmcdev} ${partitions}; then; " \
 		"mmc dev ${mmcdev};" \
-		"part start mmc ${mmcdev} ${logopart} boot_start;" \
-		"part size mmc ${mmcdev} ${logopart} boot_size;" \
+		"part start mmc ${mmcdev} " LOGO_PARTITION " boot_start;" \
+		"part size mmc ${mmcdev} " LOGO_PARTITION " boot_size;" \
 		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
 			"bmp display ${loadaddr} m m;" \
 		"fi;" \
@@ -114,7 +118,6 @@
 #define CONFIG_EXTRA_ENV_SETTINGS                                     \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
-	"logopart=2\0"                                                \
 	"gpio_recovery=88\0"                                          \
 	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
 	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
-- 
2.30.2

