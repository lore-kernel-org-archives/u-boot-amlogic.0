Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.10218.1628176656508822623
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:36 -0700
Received: by mail-wm1-f49.google.com with SMTP id m28-20020a05600c3b1cb02902b5a8c22575so3768216wms.0
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A94euIs+oi1jrBIZrCCQiiV1yZfIktz5TDSAM6NedDg=;
        b=mYbcAPXbJwEQzkmdMtBPIQOF1gWV3OtLUDhYbVH+djf18ZtmEjmhnwMrXRaRwoaZFu
         O+ZMzUGVYj+8XTAx1eagewg8LhdDKY4mHTtd31+K8t+N2/at0CgPddzmviwhuM3GZ3vV
         FSvbvqRhiqUTgh+T287cKL0Vtkkn1jp5yOIUX9hbuQB3TQnPTg+5DI2cHuRZZjSSmVEs
         dX6gu4+ZnDbzJGhVAseNjyi2UJeS4PqpyUzW7Fsh8TmcVsAykxqbqqwMRRvpnpPHYFYM
         xz1m2ITSdBfxzwrr/tEmbFSciZp5IrEo+QAw/RLr/LKwBRx8VIYU1th/zdJhD7hMjTSG
         /e8w==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 2/9] configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB
Date: Thu,  5 Aug 2021 17:17:21 +0200
Message-Id: <20210805151728.422329-3-mkorpershoek@baylibre.com>
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

To prepare for AVB support, increase SYS_MALLOC_LEN to 128M.
This value has been found by testing the following on khadas vim3l:
  => avb init
  => avb verify

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index f9f2b26416..bc3ffb9ca5 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -9,6 +9,10 @@
 #ifndef __MESON64_ANDROID_CONFIG_H
 #define __MESON64_ANDROID_CONFIG_H
 
+#include <linux/sizes.h>
+
+#define CONFIG_SYS_MALLOC_LEN	       SZ_128M
+
 #ifndef BOOT_PARTITION
 #define BOOT_PARTITION "boot"
 #endif
-- 
2.30.2

