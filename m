Received: by mail-wr1-f47.google.com with SMTP id f9so61988128wre.12
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjLiupVMcBA4uYDyJ7A3d3DQgxXn/Bs7/+W9rroi4A4=;
        b=kwyeBMT2fEBxcjaqyYD2NP+ZLjt6tnHJIs6Jzoh8Vx+TFmq+kELveFL1w9nWMHtjyc
         /V7I38ZMoHYB98MW6vb+0TITBfE1Q56U3+qFa74VZMdv7E7Hd+oGHNDBXumbg3u0Kvio
         x8P5ELDl6yb0POf9fCnwZoN8DNLeO3g1u6FzIUffsRvfZT/qpihSydQNb1w2ZNVA587I
         9moSQ9mr+kYYiOPR2Ek9iq7beKhknsFcHSQTiC0uwfJ6hSWeE5ri6JCcKRaC9m6wJ/Tj
         QIC5wfG/7r0fBWLlAu01bxwmTsbad43WUKMPUe369j5VNZgdQrjG4ubd4yCspQ0DGLMf
         xPkQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RESEND PATCH 2/5] configs: meson64: permit redefining ENV_SIZE
Date: Mon, 29 Jul 2019 16:07:48 +0200
Message-Id: <20190729140751.7851-3-narmstrong@baylibre.com>
In-Reply-To: <20190729140751.7851-1-narmstrong@baylibre.com>
References: <20190729140751.7851-1-narmstrong@baylibre.com>
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
index d82a674270..e707a1893f 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -38,7 +38,9 @@
 
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

