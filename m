Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web11.4145.1608105143153803753
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 23:52:24 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201216075206euoutp02578b3bb98a2d467295b7297a1cebfd80~RIxelKeuH2646526465euoutp02N
	for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 07:52:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201216075206euoutp02578b3bb98a2d467295b7297a1cebfd80~RIxelKeuH2646526465euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608105126;
	bh=knAMYuM5Fv2FwCCrJdg7R7ZZOjjU0BpAeAqjZRDnCJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsKbcrFjm7gjfYP7F3B3K+mQ7holmGOjGja+T+HabVliStlnmPJReh+asbz9cuvj1
	 AwLx/uiWbENMYPLjaWYSBjdxTO5PT+nMD9XOjRMijvExVcLa4AV8lW6bctZn0wC2Ic
	 ADqEFbL5KjBofaluLFfW5xXVGwhae16H8PIA6+Ew=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 2/6] adc: meson-saradc: add G12A variant
Date: Wed, 16 Dec 2020 08:51:54 +0100
Message-Id: <20201216075158.16458-3-m.szyprowski@samsung.com>
In-Reply-To: <20201216075158.16458-1-m.szyprowski@samsung.com>
References: <20201216075158.16458-1-m.szyprowski@samsung.com>
	<CGME20201216075205eucas1p2043cffb1d821e8a367522c3bc4313e97@eucas1p2.samsung.com>
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

