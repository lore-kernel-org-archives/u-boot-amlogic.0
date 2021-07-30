Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.23510.1627648102518340007
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 05:28:22 -0700
Received: by mail-wr1-f50.google.com with SMTP id b7so11115232wri.8
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6xjfYLb2KkACiu2TpYIGwLGxJUHNGbEWNTo3GWvBz8=;
        b=NUtcCGm892odpMao+62O/yqXdNbeSFBbQrTkbpqQ7W4DadgJzg3fhUOzMsk9Z+ETHp
         Wq8jJSb3Yfp2d1KnBYDT06yYTU/307TiLLxXWVDkmhvmq+uqYiqJmVpUqRIzDYoDkFMP
         841ZSLh18IhDGSEVXxlnmaJdxZoCEg3i1+qsZqfEt/Fy6n1xOjTdRoUhIci8QlXYRlXu
         i0QTDgIYFJf90cyxdqGmt12n+BnTx1nZblEGKWy7oAQT9PJzqdimJRRMwSzaxRLeFhXm
         TpH4FZFOYjksRtA79qrR4/Hm6lOxS7ShCC28a/u88+KYsGoFh08wao+yE+98aqhjMV6T
         yQ0g==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 3/5] configs: meson64_android: reboot to fastbootd from bootloader
Date: Fri, 30 Jul 2021 14:28:10 +0200
Message-Id: <20210730122812.3011529-4-mkorpershoek@baylibre.com>
In-Reply-To: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
References: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
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
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
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

