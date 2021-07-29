Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.6383.1627543279839740596
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 00:21:20 -0700
Received: by mail-wm1-f47.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so3301193wmg.4
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B85v4AHjaHlgDF7ucYK1MEmIdKZ9FLBYgFJAGaWKLi0=;
        b=xrsvJnCCRdjyJlntNrOuxaBtOq+uj/PsqO3Anj2D+wKfuPd2cCdODT3hhPuV4VGT9a
         WqEhR31pyxD7AWLPfUIo4phZQWu350hVJP3JVHUlHyrtZbHle2B4tGSF9LGMbHDLKdqN
         19SMVWOeinKHHztLqZRVjSx9ChApx2Ho9Bf4qtg6CYujrTc9qtE5L4kB48XsnE+3ANpI
         CNWl0rp0+sz7OudU2M4Lm5WjBFEKC6+MyblXC03w7pzPB5KhmWxTpbnyV85Lwuv7ihkf
         39201VCxlrDp8RMOCHj651E+5BmjLgy0DvncR3MNxeBmgtf8ZZhSmPoxH/Jj5JRNlxPR
         y8hQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 2/6] configs: meson64_android: fix bad indent in EXTRA_ENV_SETTINGS
Date: Thu, 29 Jul 2021 09:21:09 +0200
Message-Id: <20210729072113.208099-3-mkorpershoek@baylibre.com>
In-Reply-To: <20210729072113.208099-1-mkorpershoek@baylibre.com>
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

both lines seem to be joined together which is not the case for the
meson64.h EXTRA_ENV_SETTINGS.

Add a newline for consistency.

Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index c47d51c853..661de76fd7 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -127,7 +127,8 @@
 	"kernel_addr_r=0x01080000\0"                                  \
 	"pxefile_addr_r=0x01080000\0"                                 \
 	"ramdisk_addr_r=0x13000000\0"                                 \
-	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" BOOTENV
+	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0"        \
+	BOOTENV
 
 #include <configs/meson64.h>
 
-- 
2.30.2

