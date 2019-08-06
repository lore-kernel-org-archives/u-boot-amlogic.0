Received: by mail-wr1-f67.google.com with SMTP id p17so88367989wrf.11
        for <u-boot-amlogic@groups.io>; Tue, 06 Aug 2019 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IOPinJTfhAVrdrGO39xRDSQE9HEOZGlfngkUTMtczY=;
        b=XwPSe7640FMjO7sbQrrFqnm50BAXQwO8QJ581gWX0IM13x+n7UVVihQeDQHHkujseJ
         Y+khIccQFprWXHzb8yU5mMdf3X1+45lG47TaNrpsgB6mKSYvnsGX6xvgMZ2ouyzrwC33
         +5j4ZwG1m5kqJowvJ5zeEmRnOU5+HnxjYY+JThVLOcQwq3zwPubL0b4DgyJYl4Ycogqq
         4aq7sQZcttaSU59aLEuE8COye7UIVt/bPffsG8je4xjbve2cnd70W5tFMugdqhl/1pJ+
         X3jnWybm2Utu9ptnsfPrW7wtsF2dFvvZrjoviOUhlk5Wtw+m7HvF79dgSsO4gbM7voJ3
         s3uA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 2/7] configs: meson64: permit redefining ENV_SIZE
Date: Tue,  6 Aug 2019 17:43:14 +0200
Message-Id: <20190806154319.10505-3-narmstrong@baylibre.com>
In-Reply-To: <20190806154319.10505-1-narmstrong@baylibre.com>
References: <20190806154319.10505-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Permit redefining ENV_SIZE for board specific configs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/configs/meson64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 78b1615d5c..f8d3eee292 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -37,7 +37,9 @@
 
 #define CONFIG_CPU_ARMV8
 #define CONFIG_REMAKE_ELF
+#ifndef CONFIG_ENV_SIZE
 #define CONFIG_ENV_SIZE			0x2000
+#endif
 #define CONFIG_SYS_MAXARGS		32
 #define CONFIG_SYS_MALLOC_LEN		(32 << 20)
 #define CONFIG_SYS_CBSIZE		1024
-- 
2.22.0

