Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.6505.1627543280745964700
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 00:21:21 -0700
Received: by mail-wm1-f42.google.com with SMTP id b128so3034912wmb.4
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 00:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOdHuJ8bzGKrTZoaGkHFTl2j8CkHaoIFOL5h1XfWE6s=;
        b=wQyQ4RRvtnzhBTbWhofCPSUbvlL5jwbOMZPa5kttxurSejzFsSM1qrxzpkprQLi674
         +7fChvHD3rhSUkuvdmJiTj6GhCxbnHAespEQUx7Hnv1ubo2+YhSMEd00lwO2MgZpfEAN
         j+90EyYPFTCXLIo77gI6WBLfNoJNR9TVmh7/bCPNIgImRSD7DtrjGnoFaFvJ9i+KbS5V
         cXRfyqHcc6Q/xHVjpkVSeVFNodJZeCOWmUWrkL7CeFl7iitFPiqfJ/yOVaAaVRJo65+e
         KvF8f0bO7tt6xT6+8Qem2T68Nvsf53u6Iio5lGldoajAa11aUg8OXI7OVwWKtXh3nnBT
         TO4Q==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 3/6] configs: meson64_android: use CONFIG_FASTBOOT_USB_DEV
Date: Thu, 29 Jul 2021 09:21:10 +0200
Message-Id: <20210729072113.208099-4-mkorpershoek@baylibre.com>
In-Reply-To: <20210729072113.208099-1-mkorpershoek@baylibre.com>
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Right now, when running fastboot we use a hard-coded "0" for the
device number.

Use the Kconfig option named CONFIG_FASTBOOT_USB_DEV instead.

Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 661de76fd7..4027a7fe0d 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -38,7 +38,7 @@
 		"fi;" \
 		"if test \"${run_fastboot}\" -eq 1; then " \
 			"echo Running Fastboot...;" \
-			"fastboot 0;" \
+			"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
 		"fi\0"
 
 #define BOOTENV_DEV_NAME_FASTBOOT(devtypeu, devtypel, instance)	\
@@ -69,7 +69,7 @@
 		"fi;" \
 		"if test \"${run_recovery}\" -eq 1; then " \
 			"echo Running Recovery...;" \
-			"fastboot 0;" \
+			"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
 		"fi\0"
 
 #define BOOTENV_DEV_NAME_RECOVERY(devtypeu, devtypel, instance)	\
-- 
2.30.2

