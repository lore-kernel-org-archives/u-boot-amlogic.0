Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web09.33378.1607945112062970289
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 03:25:12 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201214112455euoutp02aaa9a8bafb16ea2ea323b7aa4b260fa3~QkYuWkZ-42089520895euoutp02c
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 11:24:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201214112455euoutp02aaa9a8bafb16ea2ea323b7aa4b260fa3~QkYuWkZ-42089520895euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607945095;
	bh=UvIxNi3SeCIAlgAY7lX/+fWuWj62UXOqAKk1o2uM3lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sE/jnDgSXy15b3A5oI/1vexess6umkrMcEzgeEMDJxzgigINTIDF+vZocOdfb7z1g
	 yAchnXqlvPre32eGWvDVYW8U4Vc2ub9n8a6hGYn3Wz/BMOChfYaDS+1s9TNwwIAmt5
	 LwBHEl4szhYXpzZTrk/ECc4Qij/o2AmrvZ9A6kvk=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/6] adc: meson-saradc: add G12A variant
Date: Mon, 14 Dec 2020 12:24:33 +0100
Message-Id: <20201214112437.18757-3-m.szyprowski@samsung.com>
In-Reply-To: <20201214112437.18757-1-m.szyprowski@samsung.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112449eucas1p1ebcf51e2b91ed2bac7fc4d309a174499@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for the SARADC variant found on the G12A SoCs family.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Change-Id: If519d333e9773d089f37a8c7b4ccb144be68925b
---
 drivers/adc/meson-saradc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 72b0cc4e5bd..998cef24d88 100644
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

