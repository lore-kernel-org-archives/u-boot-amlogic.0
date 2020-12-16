Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.4264.1608105143243180281
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 23:52:24 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201216075206euoutp024918eb20f3da268df397c57966a1d29d~RIxe7ZPGe2646526465euoutp02P
	for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 07:52:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201216075206euoutp024918eb20f3da268df397c57966a1d29d~RIxe7ZPGe2646526465euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608105126;
	bh=gjXQ1LSUIoC9r/p9kpzsq/9uKmzmzHDc8vSPPzXpUDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gd8twKJ5/s9pSAxrSjiUCw+IQgkUbDfXqZZrFOswKjf9Dc3hSTYA52AjkcG/tTXoV
	 MkJO1UC7dzRQWhjo6oAGGBGBneR1cw+XOIKlHcg0tP5TTyC7qhsmK2TK2wxJfwbH/y
	 hzMoh/I0pQisMARgZfYjpn/CaFJWcZHoi6o87GZw=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 4/6] configs: khadas-vim3: enable ADC device support
Date: Wed, 16 Dec 2020 08:51:56 +0100
Message-Id: <20201216075158.16458-5-m.szyprowski@samsung.com>
In-Reply-To: <20201216075158.16458-1-m.szyprowski@samsung.com>
References: <20201216075158.16458-1-m.szyprowski@samsung.com>
	<CGME20201216075205eucas1p2a5f90911b5f213f56dca1709eb71843a@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Analog to Digital Converter device (Meson SARADC) will be used for
probing 'Function' button state.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 configs/khadas-vim3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 9d7ba72d44..5d16652fd6 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -29,6 +29,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_DM_MMC=y
-- 
2.17.1

