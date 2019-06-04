Received: by mail-wm1-f66.google.com with SMTP id v22so14401603wml.1
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0mVaqXKba6pb6bANsjvK+04LtxLgqpLkWCmi035xMU=;
        b=QoEXKK1ySzz9mTcb+M2hpmC0unlfLW/PXp+1xcv2Vy2LGIkzrkXwi98siExDVgn6vb
         EHSsLKcti/hRXRZTkGGsjNU/j5JUqEz/BPAne+fxgy/N/5GCIqOAxS+YMpiZslQd4mst
         xEE9uwWTDJDI79HX5aKx+upDbvg/1Us+xDxLibnJiySwuSB1qs8LWBBXrN1IQ31t8+Ik
         W0s82rC01TZSoEbsKrnz9Tcr4ne3EuNjDRMX+Dnbnx5hMbr/Z7PT6RVC7YNhzgi5Xb75
         rsnowCDMM1CIjHNaD6g7LlsSquqpa3po/adkAuiJK5U6SQWwjAv/MRG8GZ70YTy20RDs
         0ecQ==
Return-Path: <glaroque@baylibre.com>
From: "Guillaume La Roque" <glaroque@baylibre.com>
Subject: [PATCH 3/3] pinctrl: meson: g12a: add DS bank value
Date: Tue,  4 Jun 2019 13:53:08 +0200
Message-Id: <20190604115308.26510-4-glaroque@baylibre.com>
In-Reply-To: <20190604115308.26510-1-glaroque@baylibre.com>
References: <20190604115308.26510-1-glaroque@baylibre.com>
To: narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

add drive-strength bank regiter and bit value for G12A SoC

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 9cc2b9d52b..115e8b5616 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -1204,19 +1204,19 @@ static struct meson_pmx_func meson_g12a_aobus_functions[] = {
 };
 
 static struct meson_bank meson_g12a_periphs_banks[] = {
-	/*    name   first                   last                   pullen  pull   dir     out     in   */
-	BANK("Z",    PIN(GPIOZ_0, EE_OFF),   PIN(GPIOZ_15, EE_OFF), 4,  0,  4,  0, 12,  0, 13,  0, 14,  0),
-	BANK("H",    PIN(GPIOH_0, EE_OFF),   PIN(GPIOH_8,  EE_OFF), 3,  0,  3,  0,  9,  0, 10,  0, 11,  0),
-	BANK("BOOT", PIN(BOOT_0,  EE_OFF),   PIN(BOOT_15,  EE_OFF), 0,  0,  0,  0,  0,  0,  1,  0,  2,  0),
-	BANK("C",    PIN(GPIOC_0, EE_OFF),   PIN(GPIOC_7,  EE_OFF), 1,  0,  1,  0,  3,  0,  4,  0,  5,  0),
-	BANK("A",    PIN(GPIOA_0, EE_OFF),   PIN(GPIOA_15, EE_OFF), 5,  0,  5,  0, 16,  0, 17,  0, 18,  0),
-	BANK("X",    PIN(GPIOX_0, EE_OFF),   PIN(GPIOX_19, EE_OFF), 2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
+	/*       name   first                   last                   pullen  pull   dir     out     in      ds*/
+	BANK_DS("Z",    PIN(GPIOZ_0, EE_OFF),   PIN(GPIOZ_15, EE_OFF), 4,  0,  4,  0, 12,  0, 13,  0, 14,  0, 5, 0),
+	BANK_DS("H",    PIN(GPIOH_0, EE_OFF),   PIN(GPIOH_8,  EE_OFF), 3,  0,  3,  0,  9,  0, 10,  0, 11,  0, 4, 0),
+	BANK_DS("BOOT", PIN(BOOT_0,  EE_OFF),   PIN(BOOT_15,  EE_OFF), 0,  0,  0,  0,  0,  0,  1,  0,  2,  0, 0, 0),
+	BANK_DS("C",    PIN(GPIOC_0, EE_OFF),   PIN(GPIOC_7,  EE_OFF), 1,  0,  1,  0,  3,  0,  4,  0,  5,  0, 1, 0),
+	BANK_DS("A",    PIN(GPIOA_0, EE_OFF),   PIN(GPIOA_15, EE_OFF), 5,  0,  5,  0, 16,  0, 17,  0, 18,  0, 6, 0),
+	BANK_DS("X",    PIN(GPIOX_0, EE_OFF),   PIN(GPIOX_19, EE_OFF), 2,  0,  2,  0,  6,  0,  7,  0,  8,  0, 2, 0),
 };
 
 static struct meson_bank meson_g12a_aobus_banks[] = {
-	/*   name    first                   last                   pullen  pull   dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, 0),       PIN(GPIOAO_11, 0),     3,  0,  2,  0,  0,  0,  4,  0,  1,  0),
-	BANK("E",    PIN(GPIOE_0, 0),        PIN(GPIOE_2, 0),       3, 16,  2, 16,  0, 16,  4, 16,  1,  16),
+	/*      name    first                   last                   pullen  pull   dir     out     in      ds*/
+	BANK_DS("AO",   PIN(GPIOAO_0, 0),       PIN(GPIOAO_11, 0),     3,  0,  2,  0,  0,  0,  4,  0,  1,  0, 0, 0),
+	BANK_DS("E",    PIN(GPIOE_0, 0),        PIN(GPIOE_2, 0),       3, 16,  2, 16,  0, 16,  4, 16,  1,  16, 1, 0),
 };
 
 static struct meson_pmx_bank meson_g12a_periphs_pmx_banks[] = {
-- 
2.17.1

