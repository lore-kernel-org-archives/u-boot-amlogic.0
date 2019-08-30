Received: by mail-wm1-f68.google.com with SMTP id n2so5817118wmk.4
        for <u-boot-amlogic@groups.io>; Fri, 30 Aug 2019 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOqpK98DTxziC6VGsqFySH+y3xjFe9ywzYK0ju0Gbro=;
        b=rMZo7P9CpD6qCxJf4Iku4oFiIs1AmzeHCeY6PjevrvKvvQlokBqgmgaOVwWoGH+eTe
         fBlhm0lS9/YPUGNEvPPBrKSdjZUNRyqNqW2aLJQLGGiEUHxs1/X4T95ckGg3P40/WW5j
         z06j+vdOzTYcYPdxlgu4isAHRbvZK7wNiCIwLd0kc2+CvqmRuCOqS/jDz8HqapGdyFiQ
         m3pigXSVClxupgcyMznlNBtbOKXoWPHzfj9dhofoqNQCi3WkpNxKTQJEuXH8kc2+8ent
         nZTIgX0v41jKIlzXndSkL6YJosmMXQkGzNi7w+abDrdFDKV61BlkhDjjzln9qGXgRw0V
         ZhWQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/8] video: meson: remove power domain get
Date: Fri, 30 Aug 2019 14:09:23 +0200
Message-Id: <20190830120928.23890-4-narmstrong@baylibre.com>
In-Reply-To: <20190830120928.23890-1-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, agust@denx.de, jh80.chung@samsung.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Remove getting and enabling the node power domain since it's now handled
by the dm core directly.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/video/meson/meson_vpu.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index 279401d597..34d35749eb 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -7,7 +7,6 @@
  */
 
 #include "meson_vpu.h"
-#include <power-domain.h>
 #include <efi_loader.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
@@ -93,7 +92,6 @@ static const struct udevice_id meson_vpu_ids[] = {
 static int meson_vpu_probe(struct udevice *dev)
 {
 	struct meson_vpu_priv *priv = dev_get_priv(dev);
-	struct power_domain pd;
 	struct udevice *disp;
 	int ret;
 
@@ -115,14 +113,6 @@ static int meson_vpu_probe(struct udevice *dev)
 	if (!priv->dmc_base)
 		return -EINVAL;
 
-	ret = power_domain_get(dev, &pd);
-	if (ret)
-		return ret;
-
-	ret = power_domain_on(&pd);
-	if (ret)
-		return ret;
-
 	meson_vpu_init(dev);
 
 	/* probe the display */
-- 
2.22.0

