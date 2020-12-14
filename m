Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web10.32899.1607945108563993749
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 03:25:09 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201214112451euoutp01f10d4a354b5a2218d18d7f0f6a5b42b3~QkYqQ8HFy0131301313euoutp01W
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 11:24:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201214112451euoutp01f10d4a354b5a2218d18d7f0f6a5b42b3~QkYqQ8HFy0131301313euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607945091;
	bh=2H9BBNyv5/vxNOUw1+2E7KnTxYztD616hrCcE1zfDEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KII3jivTQTsOdpnQ/fO2aOBlqDESmLS4GS14qo0yxlWoO/ZFw83xvUbUGtKcvTyCX
	 SAe4sZOLAOmoI963kjPPx45Do12RO52Mk1aIRW6nxCzRH4iBRPrrLx1XeuB4y9dJaW
	 hJBoxbss11EsXLO0g6HyJWwiaAvWbh0PzuWuf6Xo=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/6] adc: meson-saradc: skip hardware init only if ADC is enabled
Date: Mon, 14 Dec 2020 12:24:34 +0100
Message-Id: <20201214112437.18757-4-m.szyprowski@samsung.com>
In-Reply-To: <20201214112437.18757-1-m.szyprowski@samsung.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112450eucas1p1e7ad389bceaaf1082c9afdcb0733e9c0@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

The driver skips hardware initialization if it is already configured by
the earlier bootloader stage (BL30). Skip the initialization only if the
hardware is really initialized and enabled.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Change-Id: I3e2e2d270ad3e7e7f38e2bc3ce2a924a47b164af
---
 drivers/adc/meson-saradc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 998cef24d88..ce7ae990ad0 100644
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

