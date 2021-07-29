Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.6384.1627543281319941648
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 00:21:21 -0700
Received: by mail-wm1-f47.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so3310133wmb.5
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmNDMZ00AgINxFpQ9wH4V9eX1Y8RZdMLoXeGtXbbQxY=;
        b=TQ2AIY3ruR82sPzRxK792nRoReVrgZtwzz4kK11iJezz3utr3ioMOqna+ynBUdAgt3
         A9HbVxDZ9rWcixHRUF3czNPyVwsgFiUPbd/5glYVRjGFwFJ1o6EGptM7f7M4cgtBgKC9
         h7rwl+rWiBxcMDWr9/w1uAK0A9coLM0feOW3/enhd2n9L3RmBIxbSHJfIxKQKPuOuxC/
         Z5JhGIb+dprrf5H7mPD6D0T9j1IqF5tuKwOjuC8Y+CYEx3RutzzQKUKk+y11pERxFuv2
         k8WPE8PdCDo2K2T/hZ5QVXsQTK0rpsBM3+P/b2PQkr0V5XlT/73hsqmkE/QgJRAlu+ya
         Jbwg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 4/6] configs: meson64_android: use boot part label instead of index
Date: Thu, 29 Jul 2021 09:21:11 +0200
Message-Id: <20210729072113.208099-5-mkorpershoek@baylibre.com>
In-Reply-To: <20210729072113.208099-1-mkorpershoek@baylibre.com>
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

To boot Android, we read the gpt and assume that the partition with
index "1" will be the "boot" partition.

This might not always be the case, as there are no requirements from
Android on the partition order.

However, Android does seem to use the "boot" label quite a lot on their
public documentation [1]

Load the boot partition by label instead of by index

[1] https://source.android.com/devices/bootloader/partitions
Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 4027a7fe0d..e22f05c889 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -9,6 +9,9 @@
 #ifndef __MESON64_ANDROID_CONFIG_H
 #define __MESON64_ANDROID_CONFIG_H
 
+#ifndef BOOT_PARTITION
+#define BOOT_PARTITION "boot"
+#endif
 
 #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
 	"bootcmd_fastboot=" \
@@ -77,11 +80,11 @@
 
 #define BOOTENV_DEV_SYSTEM(devtypeu, devtypel, instance) \
 	"bootcmd_system=" \
-		"echo Loading Android boot partition...;" \
+		"echo Loading Android " BOOT_PARTITION " partition...;" \
 		"mmc dev ${mmcdev};" \
 		"setenv bootargs ${bootargs} console=${console} androidboot.serialno=${serial#};" \
-		"part start mmc ${mmcdev} ${bootpart} boot_start;" \
-		"part size mmc ${mmcdev} ${bootpart} boot_size;" \
+		"part start mmc ${mmcdev} " BOOT_PARTITION " boot_start;" \
+		"part size mmc ${mmcdev} " BOOT_PARTITION " boot_size;" \
 		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
 			"echo Running Android...;" \
 			"bootm ${loadaddr};" \
@@ -111,7 +114,6 @@
 #define CONFIG_EXTRA_ENV_SETTINGS                                     \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
-	"bootpart=1\0"                                                \
 	"logopart=2\0"                                                \
 	"gpio_recovery=88\0"                                          \
 	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
-- 
2.30.2

