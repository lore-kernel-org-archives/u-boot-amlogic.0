Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.10116.1601629547933090940
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Oct 2020 02:05:48 -0700
Received: by mail-wr1-f68.google.com with SMTP id k15so919223wrn.10
        for <u-boot-amlogic@groups.io>; Fri, 02 Oct 2020 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9/9fEVeniVn7qkF7Bmi5BuicI09VaGEuVWCgJ9Ba1Q=;
        b=BcLB+eOcbpFdXAxtf4Lj6e7/+M+O76IR43tAH7eR3KNvaVLuUwLlE6H0hsek7ZPeQS
         qBUOlEEYXNIXrVStRZ438ch0ZjeAGPs1ql7j9S8yBxRnSBIq33aG9qKluFNaZZevzxzv
         dAqlBeP4mLk0Ta3t7xte81xgTymgb1KMoMXkPP+LiwDXwa1z05JZg+dr/2tWNGHZTsb3
         No2jTTs4wfrxqccZlZJ53RQwhDD1YrH9EaH/72HdmT2HlxthWMShz5+LQxCYQGEZA+sF
         kna1OBrCO3V1nhEDIpNMTL7aMTATEyjJI3+9OTqqGpFB0EzRIhkR0RMRq84Y+IzaySNi
         HkhQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] pinctrl: meson-axg: add missing GPIOA_18
Date: Fri,  2 Oct 2020 11:05:40 +0200
Message-Id: <20201002090540.1022341-2-narmstrong@baylibre.com>
In-Reply-To: <20201002090540.1022341-1-narmstrong@baylibre.com>
References: <20201002090540.1022341-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add the missing GPIOA_18 from the missing EE gpio list.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 8f23c8cef1..11809b29f3 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -298,6 +298,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GPIO_GROUP(GPIOA_15, EE_OFF),
 	GPIO_GROUP(GPIOA_16, EE_OFF),
 	GPIO_GROUP(GPIOA_17, EE_OFF),
+	GPIO_GROUP(GPIOA_18, EE_OFF),
 	GPIO_GROUP(GPIOA_19, EE_OFF),
 	GPIO_GROUP(GPIOA_20, EE_OFF),
 
-- 
2.25.1

