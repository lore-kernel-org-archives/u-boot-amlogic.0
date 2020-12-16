Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web09.4233.1608105148006767080
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 23:52:28 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201216075211euoutp0124c0fa8e28ebc45af9ac650c92d9d53c~RIxjaah5n2620226202euoutp01U
	for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 07:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201216075211euoutp0124c0fa8e28ebc45af9ac650c92d9d53c~RIxjaah5n2620226202euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608105131;
	bh=niKH6BNL1ADCXiwc4ADswQfLUZeqREE5EgoAsfjsh+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsBH3xUWBFJT8tSvIxf8mBbuhrDKnJiDDRo5bIp4y1nmmF9evEaisY3XdmJjCpIJL
	 jOcwu0s5JGCnKG0tIoQ0QCB7EHCetRjuPd3ZkNNVQCDUt/kyVeAhu2CoukFWWMXsD8
	 DmwHCtRfBXWPICV5VSc2LZzIUMvGNP2Gj46nHUrk=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 3/6] adc: meson-saradc: skip hardware init only if ADC is enabled
Date: Wed, 16 Dec 2020 08:51:55 +0100
Message-Id: <20201216075158.16458-4-m.szyprowski@samsung.com>
In-Reply-To: <20201216075158.16458-1-m.szyprowski@samsung.com>
References: <20201216075158.16458-1-m.szyprowski@samsung.com>
	<CGME20201216075205eucas1p1d1c5e19ec9e1cdd2867daddee81eb28e@eucas1p1.samsung.com>
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

