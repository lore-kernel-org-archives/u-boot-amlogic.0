Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.5480.1637147061542507668
 for <u-boot-amlogic@groups.io>;
 Wed, 17 Nov 2021 03:04:21 -0800
Received: by mail-wm1-f53.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4418652wmr.4
        for <u-boot-amlogic@groups.io>; Wed, 17 Nov 2021 03:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJxnSwV2hsIsQ7Oum0dsqr6RxiYLzb481swo0dfk2xo=;
        b=4/B2YZYZ0WsJvIJI6mLJmVov2+V3FzQqlroUiivCfAFqBXbi7tzx/sNzRaEonpbQ9z
         LbId70GzGWKPIHg5XDbBOWX0O8GlCE3KNhixgsIwZZTzvv2IMgo9iKEGoj/GnxaLIGf7
         XElD4AfDvV0ap0mFBXrEjNLFAaiqCxLYhW1RvdHtqU6nk0fohChcLmS7sZEvO31QM5/k
         nBRNfuhCjzsoRYu9149XNGzCw/WfqFKSYJ730EGbQi0ytcp8l0P8vHJ7LAOPeqCwbkN6
         c0RfCPsZ6PAZDIHWGhNn8e5hGZN3aE7cSgvOJU6mPZeabsWr+OhD31JWVYmtXh7A+wzF
         Y+pg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 2/2] configs: meson64_android: add PANIC stage for SYSTEM fails
Date: Wed, 17 Nov 2021 12:04:11 +0100
Message-Id: <20211117110411.710190-3-mkorpershoek@baylibre.com>
In-Reply-To: <20211117110411.710190-1-mkorpershoek@baylibre.com>
References: <20211117110411.710190-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: "To : Neil Armstrong" <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Neil Armstrong <narmstrong@baylibre.com>

If bootloader was updated without running oem format, reboot will cause
boot loop because the SYSTEM stage fails.

Add a final PANIC stage running fastboot to permit recovery.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 93d8f8ec99de..7cd1ab034118 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -233,16 +233,24 @@
 			"echo Running Android...;" \
 			BOOT_CMD \
 		"fi;" \
-		"echo Failed to boot Android...;" \
-		"reset\0"
+		"echo Failed to boot Android...;\0"
 
 #define BOOTENV_DEV_NAME_SYSTEM(devtypeu, devtypel, instance)	\
 		"system "
 
+#define BOOTENV_DEV_PANIC(devtypeu, devtypel, instance) \
+	"bootcmd_panic=" \
+		"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
+		"reset\0"
+
+#define BOOTENV_DEV_NAME_PANIC(devtypeu, devtypel, instance)	\
+		"panic "
+
 #define BOOT_TARGET_DEVICES(func) \
 	func(FASTBOOT, fastboot, na) \
 	func(RECOVERY, recovery, na) \
 	func(SYSTEM, system, na) \
+	func(PANIC, panic, na) \
 
 #define PREBOOT_LOAD_LOGO \
 	"if test \"${boot_source}\" != \"usb\" && " \
-- 
2.32.0

