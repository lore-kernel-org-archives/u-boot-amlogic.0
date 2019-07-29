Received: by mail-wr1-f49.google.com with SMTP id n9so62094729wru.0
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=llDFVMszhLET9cQ8bLpsax0pN2u7XyZFv9kX4KLbGTQ=;
        b=SYMOGom2k1I/kFOxD10u9oWgHwLdBvNDXxAEva1n12dD49gnDS2DccMxpW1GywXJEm
         c+QHsf3Zx43LHl1zwixuc8F35KeQmtm5nHyeU8ru8TkPBZ/sxvAsfOKQl9iDwMDDJIy6
         BRT+5TMb1/xht2TSvkY+yD1iuG0AyoM4xEu3hTw+Hy0khoS9Myuq+pAYJ21pmi0UDnsU
         KcBpoWPi3hJ66P2ZVewh0rd1G7mW9dhsuxZUrBREFU4J+z27ioRZkZrLGMgo8l/qkFJt
         Z22lJ+viau1jQh80uUpb5vPjjIrDI0PA8I//Wq/48yompnU6hPqgHykwEsNTZ7D1RG24
         nM8g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/5] configs: meson64: permit redefining ENV_SIZE
Date: Mon, 29 Jul 2019 16:01:55 +0200
Message-Id: <20190729140158.6954-3-narmstrong@baylibre.com>
In-Reply-To: <20190729140158.6954-1-narmstrong@baylibre.com>
References: <20190729140158.6954-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Permit redefining ENV_SIZE for board specific configs.
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

