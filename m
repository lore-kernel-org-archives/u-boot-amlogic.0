Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web12.10049.1611654675313268645
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Jan 2021 01:51:15 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210126095113euoutp02f1f4777a199c7803b5295cbe0b9fed04~dv2MQrmN_3205232052euoutp02A
	for <u-boot-amlogic@groups.io>; Tue, 26 Jan 2021 09:51:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210126095113euoutp02f1f4777a199c7803b5295cbe0b9fed04~dv2MQrmN_3205232052euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1611654673;
	bh=txv+bFh9xDbqQOiyvI95mIA15L7JnhrzXb1RhxQZZts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmshGJp9fdJLLzojuu80syQEjqlFixoIYUVydAOi6dvZSTXfTMBfAj4SLWbPYzDaB
	 Rn9pKT7wvEbG5hYzgb5EHUv658EbTtLBuUrHg7XiVwd5TFS88Nbx8gqbI1Xe1WBVX2
	 qzuYMV7L2x5jYZs50ZZitUj4a58cVXSwMIe7GE/M=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 3/4] adc: meson-saradc: add support for getting reference voltage value
Date: Tue, 26 Jan 2021 10:50:35 +0100
Message-Id: <20210126095036.6429-4-m.szyprowski@samsung.com>
In-Reply-To: <20210126095036.6429-1-m.szyprowski@samsung.com>
References: <20210126095036.6429-1-m.szyprowski@samsung.com>
	<CGME20210126095113eucas1p1cbd41e98d0d5f454fe45a4c5e4bb5e2f@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for getting the 'vref-supply' regulator and register it as
ADC's reference voltage regulator, so clients can translate sampled ADC
values to the voltage.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/adc/meson-saradc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 21db55831d..1a45a3a265 100644
--- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/math64.h>
 #include <linux/bitfield.h>
+#include <power/regulator.h>
 
 #define MESON_SAR_ADC_REG0					0x00
 	#define MESON_SAR_ADC_REG0_PANEL_DETECT			BIT(31)
@@ -656,7 +657,10 @@ static int meson_saradc_stop(struct udevice *dev)
 
 static int meson_saradc_probe(struct udevice *dev)
 {
+	struct adc_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
 	struct meson_saradc_priv *priv = dev_get_priv(dev);
+	struct udevice *vref;
+	int vref_uv;
 	int ret;
 
 	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
@@ -675,6 +679,23 @@ static int meson_saradc_probe(struct udevice *dev)
 
 	priv->active_channel = -1;
 
+	ret = device_get_supply_regulator(dev, "vref-supply", &vref);
+	if (ret) {
+		printf("can't get vref-supply: %d\n", ret);
+		return ret;
+	}
+
+	vref_uv = regulator_get_value(vref);
+	if (vref_uv < 0) {
+		printf("can't get vref-supply value: %d\n", vref_uv);
+		return vref_uv;
+	}
+
+	/* VDD supplied by common vref pin */
+	uc_pdata->vdd_supply = vref;
+	uc_pdata->vdd_microvolts = vref_uv;
+	uc_pdata->vss_microvolts = 0;
+
 	return 0;
 }
 
-- 
2.17.1

