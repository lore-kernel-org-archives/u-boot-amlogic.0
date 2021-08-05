Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.10251.1628176655927659104
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:36 -0700
Received: by mail-wm1-f41.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so3980157wmg.4
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VVIRquFL4wZn6s8y/e8bM3pgaZ6EL8aINJf4APXbCc=;
        b=RvPG63HgSPLNUsymJvknEjokIlF/4mEaDgKQQhcIOFRSt4o2CKboRdWOBBYzFeU6iL
         wkZVCbXi2ct0C8HH0T21ea4OGfeUgtY0HfukSURtcMYzR9+7qL4AjzB4M5HGvc4h8pN5
         iBu7uY5X+Zb8sjDj6a+T9ntyMLPy10fHqHKXYz3wpqqdugbhukrZzMg0rJZosS6rPTyB
         Na/U7HcCLAPwQe2y9UYtHgg/05WI0R5YuctUWNt7H0nRnkG4Zith50rfmIjAE+lxcpCk
         33kKMbKX8vBAriFCkqvHvSxdwhdlQN6IdGAZPHPkh9O0zieTddo6RA/OzzmHI/vWI69w
         H9LQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 1/9] configs: meson64: permit redefining SYS_MALLOC_LEN
Date: Thu,  5 Aug 2021 17:17:20 +0200
Message-Id: <20210805151728.422329-2-mkorpershoek@baylibre.com>
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Permit redefining SYS_MALLOC_LEN for board specific configs.
This is especially useful for Android with AVB, which requires a malloc
length of 128M.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index fb7f16d148..f9bb0240d2 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -32,7 +32,9 @@
 #define CONFIG_CPU_ARMV8
 #define CONFIG_REMAKE_ELF
 #define CONFIG_SYS_MAXARGS		32
+#ifndef CONFIG_SYS_MALLOC_LEN
 #define CONFIG_SYS_MALLOC_LEN		(32 << 20)
+#endif
 #define CONFIG_SYS_CBSIZE		1024
 
 #define CONFIG_SYS_SDRAM_BASE		0
-- 
2.30.2

