Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.12792.1608043385167260994
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 06:43:06 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201215144246euoutp02726dbe20f9fca62974accce8b139b006~Q6uwK8XE11507815078euoutp02h
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 14:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201215144246euoutp02726dbe20f9fca62974accce8b139b006~Q6uwK8XE11507815078euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608043366;
	bh=niKH6BNL1ADCXiwc4ADswQfLUZeqREE5EgoAsfjsh+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A49SQpxjIUmq0hvhmf/SvLOKg+IVglxX2LztlSu4WsNjiRZRBTn65lmGDB7sH+XQ2
	 DNydCbj1Xxb8frA5qdkGYSJK8LVGaWaNVpK+doo9nvy3+4qgtatUlYWA0ckTR7zU6C
	 35Widjd7C7kY4Gw5H4esnl3dW0sXDwdxQ6PX1Jyo=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 3/7] adc: meson-saradc: skip hardware init only if ADC is enabled
Date: Tue, 15 Dec 2020 15:42:26 +0100
Message-Id: <20201215144230.9235-4-m.szyprowski@samsung.com>
In-Reply-To: <20201215144230.9235-1-m.szyprowski@samsung.com>
References: <20201215144230.9235-1-m.szyprowski@samsung.com>
	<CGME20201215144243eucas1p1d1a361740f20097fd2db505c9bdfee7d@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

The driver skips hardware initialization if it is already configured by
the earlier bootloader stage (BL30). Skip the initialization only if the
hardware is really initialized and enabled.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/adc/meson-saradc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 998cef24d8..ce7ae990ad 100644
--- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -512,8 +512,11 @@ static int meson_saradc_init(struct meson_saradc_priv *priv)
 	 * reading the temperature sensor.
 	 */
 	regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
-	if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
-		return 0;
+	if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED) {
+		regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
+		if (regval & MESON_SAR_ADC_REG3_ADC_EN)
+			return 0;
+	}
 
 	meson_saradc_stop_sample_engine(priv);
 
-- 
2.17.1

