Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308FAC83F27
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 15:03:04 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.13691.1753193518830008184
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Jul 2025 07:11:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Yb90Hf5H;
 spf=pass (domain: linaro.org, ip: 209.85.128.50, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45629702e52so25123055e9.2
        for <u-boot-amlogic@groups.io>; Tue, 22 Jul 2025 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753193517; x=1753798317; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6ucfMS5OU9pYnnuYLa0fyLbsUIqQnH7ZgjPHwbEhBg=;
        b=Yb90Hf5HM5OdNWN7jSNCB/Oimki0yNPtLSVI7Xrk4/SBuBlG0u7nzxI8lOGkqJaN8u
         R1VG8F9zSNECSTYf1ulQuKEEBLaQZMz6gmD497dgk8kXD4WXnKcH9nMGdrNlBEenEMUk
         mtaQQJcT7dF0yF5nbRGhpqXw+2jSchOA/IKmbHn5gSDcNGbV7HoarZs5OAnO8xBSC7y0
         PoHVCG02CBetTKwSX1srb6ywWd2uwuDyD0hLwoIaW6AIn0mrYf7BTC6cF7AKykgdg6dh
         z3yELHx3g0LhqQdjfPO0zFlD2FApI8UMRxW/pNwL1lwgxAGzSlM0ZTbVzHRvPhQAS16T
         sn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193517; x=1753798317;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6ucfMS5OU9pYnnuYLa0fyLbsUIqQnH7ZgjPHwbEhBg=;
        b=G+NyyIF48eZlxegn74VX6nCfwIZE+iVJGwIRnTQU65D0PHl6paugGJER0a+G2aZbEl
         PbX5rwnQdoTkzZmui09jFeDEldhNu8eelBoVjSSiikjB0rkLgMo5w/z0AQoxFhE70lYR
         nxWd75Y6bSLmu6EGG0Uj7dZoJO2OEZG02kBTRY4H1tXv0rKt48UrbHT12FMdmxWfFo6c
         QuCvlixkk/ysb4irl1BdPUuWJszidzNe3I1LrZ5R6e1A0kUmdstcSE0fIOfZBu/Q4NNA
         qvANWEWqRrwmQgKD9pz2jns16c3BM8utl5kOx3YlSvZTojrcSrK/UwDIBX03WYvH44aV
         yTgw==
X-Gm-Message-State: AOJu0YzOouQXUegX4f+n2rlf6rXIwg7HDq1WO8H35fxQSl5A/pl/vBkX
	zrH0FqbbQ5OeqeNP0kiUh2BqKeo/tlV0rjZHDNLYK/pQ/Bin0IJc9460ZmG+Cj4+yU9hyb0Uqjr
	xhO+J
X-Gm-Gg: ASbGnctsXmz/qwZxuhSmJVK0nj3753IL/2RmQQe/4EsPRsPXJH79RTPMHAbf1mIrd2q
	QJG2CMQbJ9uKz3pcmDrsogNm4rbQEkF0bv9ElOTnSur3b8mgo8JDKInJSW9tpYxxgkoarN2TZrR
	movr3O+PqZj6ctUntU+bG02mC970WvuMq2M0/OhYtNd6fUoFkLhdRwukrjdImJTvYKnsk6Z0ae4
	sd14D8dY3UTYd27R2faMqsy6WDUpqRnKd1onmjeEo6MRi4TzIcLU5BJmcxlQjR7zki4Nucs4cZA
	eZ/acTyndcb5leDnNzMpVQTbWDTop29I3Xe5VSS6cfNxDrpSTiU+q4euQN63qrEBr3JM+TEODfs
	/ylKYPzqACa24zbG2ccjFZrMOtPXv9wjZ9Sxkn3XFvsU+1e2pLjU=
X-Google-Smtp-Source: AGHT+IESmEyV9d3QVuAb7fm9m/hjTGtBqPoydbnRv/ZsM333S5FcON/gg8kCHdoG2ik+ABTEUmNVRg==
X-Received: by 2002:a05:600c:468b:b0:456:2419:dc05 with SMTP id 5b1f17b1804b1-4562e33db7fmr260061875e9.12.1753193174889;
        Tue, 22 Jul 2025 07:06:14 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:eb9:1701:2943:d0d1:b3a5:d7fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca319cbsm13790157f8f.38.2025.07.22.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:06:14 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 22 Jul 2025 15:06:14 +0100
Subject: [PATCH] adc: meson-saradc: uint cannot be less than zero
MIME-Version: 1.0
Message-Id: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
X-B4-Tracking: v=1; b=H4sIANWaf2gC/x2NQQqDMBAAvyJ7bkATxdavlCKbZNU9GGW3iCD+3
 ehxGIY5QEmYFLriAKGNlZeUoXoVECZMIxmOmcGWtilba81MuqReUTAGU3uPnxiqt3MOcuJRyXj
 BFKY7mlH/JLdYhQben8/3d54X6TFThXcAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 22 Jul 2025 15:03:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2728

timeout is declared as a uint but then tested for being less than zero
which must always fail. Change the while loop for a pre-decrement on
timeout and test timeout for being zero.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/adc/meson-saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 60e348968fb..0144ff828c5 100644
--- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -205,9 +205,9 @@ static int meson_saradc_lock(struct meson_saradc_priv *priv)
 	do {
 		udelay(1);
 		regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
-	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
+	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && --timeout);
 
-	if (timeout < 0) {
+	if (!timeout) {
 		printf("Timeout while waiting for BL30 unlock\n");
 		return -ETIMEDOUT;
 	}
@@ -256,9 +256,9 @@ static int meson_saradc_wait_busy_clear(struct meson_saradc_priv *priv)
 	do {
 		udelay(1);
 		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
-	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
+	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && --timeout);
 
-	if (timeout < 0)
+	if (!timeout)
 		return -ETIMEDOUT;
 
 	return 0;

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250722-meson_saradc-4bba9dc18333

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


