Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web08.12749.1608043385178211327
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 06:43:06 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201215144246euoutp02456c9a8d9dcd1fed5ebf2290055df4de~Q6uwdeJuV1507815078euoutp02j
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 14:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201215144246euoutp02456c9a8d9dcd1fed5ebf2290055df4de~Q6uwdeJuV1507815078euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608043366;
	bh=td8uawKm1W8t8Dtxc9yvshPvyyJ1X5yUjQUrR9tBTM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAbLSzkUq99e5jyG1tUMkpQzgcusrxAmelqE1NuJJRaUoUDcizKfVFi0EOlmG/Ag8
	 D3zQ4iuH7C8SZIlP2V0u2GuIlfTa/b8Go9zsWvwJv9hK4hux+boM+IBlY1tT31rgDM
	 OMds/qgyuLUwL1fwavDuOVMqgbhQIZNQbWgPnF4g=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 7/7] configs: khadas-vim3: enable Function button support
Date: Tue, 15 Dec 2020 15:42:30 +0100
Message-Id: <20201215144230.9235-8-m.szyprowski@samsung.com>
In-Reply-To: <20201215144230.9235-1-m.szyprowski@samsung.com>
References: <20201215144230.9235-1-m.szyprowski@samsung.com>
	<CGME20201215144245eucas1p112636015eaba5f50cc79044080ce9fed@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add options needed to check the 'Function' button state.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 configs/khadas-vim3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 5d16652fd6..bc17430569 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -31,6 +31,8 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_DM_MMC=y
-- 
2.17.1

