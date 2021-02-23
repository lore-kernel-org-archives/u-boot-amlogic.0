Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web08.10936.1614093045395305826
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Feb 2021 07:10:45 -0800
Received: by mail-wm1-f51.google.com with SMTP id a132so2759844wmc.0
        for <u-boot-amlogic@groups.io>; Tue, 23 Feb 2021 07:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYXcGCKLPQyLunVq17wzU/f/ag1R5MHJfBHoudOzugI=;
        b=d8zFQRI7Nw9/3h0SFfQc02kBp7THmGXnIVcQ6U3FLqjh8pQMd7cuxCGvlO0fWFPA/y
         itpq8nTYHOMrwg+W7svGEldDUF5R+Bhk0RWPMlmXfcCgF1Fru6q/7gPmKtifSG4i/wjf
         AsSCRs1RqJUYjKAfjiaQJHwPYBs4qUSAZoqFF+qI2atOKWqt4NkPbsuhy9U06rtY1ZQS
         9ufvSPtijk6MMoHmS4TTOFFfcukwcp89D+A1P26Jt4FciOljFVk1KX9xw2uNWrs6m59h
         1VARcNIRUcl8bYBJuiLi7nM6v4Z689n5Bq82AndeH+pa7kQgeAy9AypiRV1PoSp07J52
         /jwg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] button: adc: fix treshold typo
Date: Tue, 23 Feb 2021 16:10:40 +0100
Message-Id: <20210223151040.2201981-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, m.szyprowski@samsung.com, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Fix the treshold typo in code by threshold.

Fixes: c0165c85c3 ("button: add a simple Analog to Digital Converter device based button driver")
Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/button/button-adc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
index eed86564fb..fd896c76f9 100644
--- a/drivers/button/button-adc.c
+++ b/drivers/button/button-adc.c
@@ -55,7 +55,7 @@ static int button_adc_of_to_plat(struct udevice *dev)
 	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	struct button_adc_priv *priv = dev_get_priv(dev);
 	struct ofnode_phandle_args args;
-	u32 treshold, up_treshold, t;
+	u32 threshold, up_threshold, t;
 	ofnode node;
 	int ret;
 
@@ -73,12 +73,12 @@ static int button_adc_of_to_plat(struct udevice *dev)
 		return ret;
 
 	ret = ofnode_read_u32(dev_ofnode(dev->parent),
-			      "keyup-threshold-microvolt", &up_treshold);
+			      "keyup-threshold-microvolt", &up_threshold);
 	if (ret)
 		return ret;
 
 	ret = ofnode_read_u32(dev_ofnode(dev), "press-threshold-microvolt",
-			      &treshold);
+			      &threshold);
 	if (ret)
 		return ret;
 
@@ -87,13 +87,13 @@ static int button_adc_of_to_plat(struct udevice *dev)
 		if (ret)
 			return ret;
 
-		if (t > treshold)
-			up_treshold = t;
+		if (t > threshold)
+			up_threshold = t;
 	}
 
 	priv->channel = args.args[0];
-	priv->min = treshold;
-	priv->max = up_treshold;
+	priv->min = threshold;
+	priv->max = up_threshold;
 
 	return ret;
 }
-- 
2.25.1

