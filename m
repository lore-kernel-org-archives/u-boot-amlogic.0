Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.6401.1627543279279293049
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 00:21:19 -0700
Received: by mail-wm1-f53.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so3310069wmb.5
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNuhRKWm7Lki5/NX4/1aTIVU5eLQDEL8hCbQgtsntRk=;
        b=ClXxs6TE387ddmA0I3lx1P5wMdGKX3MTy7V89+A8L0t79KrARC8RoaWOW+L0dMfpDC
         ioKEbdbtyVUEQ652THXhz4Xp9wd8bqfxhQtxauKFAr/uvR68GrpCWc9mTPF628Pdp7Sb
         4rN5TG1IGmGiULgUoAh0su5mwWZfjlrn+tx3z9NqMLsMhygmx4b92bE95IFU7gpA4vbn
         Um4uc1T7W0bjTycDTg/GsPTq7Pr/vVkndkR1OPpg5gDeLb6aX0LBGkL8fK1bJ6WswP6r
         1gdyz/gRJao4r21ynCOMUnDkbV4d0hnm805kZlpdEw5LCke3ZvuQs2vZVKURTsG8kF92
         mJ4w==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 1/6] configs: sei610: fix typo in header comment
Date: Thu, 29 Jul 2021 09:21:08 +0200
Message-Id: <20210729072113.208099-2-mkorpershoek@baylibre.com>
In-Reply-To: <20210729072113.208099-1-mkorpershoek@baylibre.com>
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

s/510/610/

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/sei610.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/sei610.h b/include/configs/sei610.h
index 6d093161c9..9eeffdd72c 100644
--- a/include/configs/sei610.h
+++ b/include/configs/sei610.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Configuration for the SEI510
+ * Configuration for the SEI610
  *
  * Copyright (C) 2019 Baylibre, SAS
  * Author: Jerome Brunet <jbrunet@baylibre.com>
-- 
2.30.2

