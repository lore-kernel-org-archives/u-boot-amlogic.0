Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web09.12731.1608043387016943616
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 06:43:07 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201215144248euoutp015df72a41a4e37608a56f2e93d2c424c8~Q6uyKlLpB1486114861euoutp01h
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 14:42:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201215144248euoutp015df72a41a4e37608a56f2e93d2c424c8~Q6uyKlLpB1486114861euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608043368;
	bh=knAMYuM5Fv2FwCCrJdg7R7ZZOjjU0BpAeAqjZRDnCJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njRUkEmbMJ45OCuaJUC1GgXqdJAzxxkaSd5tHpNpaB0MeACBYo8RENpk9k+nDoHJD
	 yhZQ2mvjMKZDqVc8QxjAFSIYZmmxaU6oCrL2I9R7f/+UpK721R4V8/DFhLGelZRY+U
	 d/ggBDjofBbgmC5XJg2SROIijb0DVCnjlGWwv0Cg=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 2/7] adc: meson-saradc: add G12A variant
Date: Tue, 15 Dec 2020 15:42:25 +0100
Message-Id: <20201215144230.9235-3-m.szyprowski@samsung.com>
In-Reply-To: <20201215144230.9235-1-m.szyprowski@samsung.com>
References: <20201215144230.9235-1-m.szyprowski@samsung.com>
	<CGME20201215144243eucas1p281404c3b46cd0b32811c1af3a2ef2ba4@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for the SARADC variant found on the G12A SoCs family.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/adc/meson-saradc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 72b0cc4e5b..998cef24d8 100644
--- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -711,6 +711,8 @@ static const struct udevice_id meson_saradc_ids[] = {
 	  .data = (ulong)&gxl_saradc_data },
 	{ .compatible = "amlogic,meson-gxm-saradc",
 	  .data = (ulong)&gxl_saradc_data },
+	{ .compatible = "amlogic,meson-g12a-saradc",
+	  .data = (ulong)&gxl_saradc_data },
 	{ }
 };
 
-- 
2.17.1

