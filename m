Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.8912.1614242690667991321
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Feb 2021 00:44:50 -0800
Received: by mail-wm1-f48.google.com with SMTP id i9so3639543wml.0
        for <u-boot-amlogic@groups.io>; Thu, 25 Feb 2021 00:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1GFk9NyLbuMJs2UD1pGvI0QhVOfRk2sTwRHTVFnXmk=;
        b=onyahgIwClxq3WUS0XK02FqD256rfkp+bPUt7fcD0Vc8uqC3OEDJfh9P+8KJbzvjl7
         pP3a1c+rCmwW5S+My8MDmZ2GelRCI5m2cQZK30mRfXG+pWUaJq98ZCxVfA0nkQQi0HEA
         n+I3fje94F0fVdOC7Ttbgwtf3iPHc05PfXwnQgIuyujqJ80oT4ogN3a8i0+MRfCUrkxH
         7SVnMog9VfrsllzHeFzKdhit1fyozSq70244d0qz5uk/tgwtMIv57uXx+pCF/KmIOvbT
         1rYDYVK5bxGXatJaxPIHPtvLm757BC8Z8OCiNGj04JmeQ1zCHG5hDbQk76uF1XQj91Dk
         fXmw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RFC/RFT 5/7] net: designware: remove amlogic compatibles
Date: Thu, 25 Feb 2021 09:44:36 +0100
Message-Id: <20210225084438.2964558-6-narmstrong@baylibre.com>
In-Reply-To: <20210225084438.2964558-1-narmstrong@baylibre.com>
References: <20210225084438.2964558-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Cc: u-boot-amlogic@groups.io, christianshewitt@gmail.com, b.galvani@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

These compatibles are now handled by the dwmac_meson8b glue driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/net/designware.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index acf3a82828..b8ba00b7c0 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -947,9 +947,6 @@ int designware_eth_of_to_plat(struct udevice *dev)
 static const struct udevice_id designware_eth_ids[] = {
 	{ .compatible = "allwinner,sun7i-a20-gmac" },
 	{ .compatible = "amlogic,meson6-dwmac" },
-	{ .compatible = "amlogic,meson-gx-dwmac" },
-	{ .compatible = "amlogic,meson-gxbb-dwmac" },
-	{ .compatible = "amlogic,meson-axg-dwmac" },
 	{ .compatible = "st,stm32-dwmac" },
 	{ .compatible = "snps,arc-dwmac-3.70a" },
 	{ }
-- 
2.25.1

