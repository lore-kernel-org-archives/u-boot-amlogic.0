Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web10.10168.1611654676225302586
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Jan 2021 01:51:16 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210126095114euoutp01ff5775337c8449a6754593df263e061d~dv2NAQ8iY0650406504euoutp01M
	for <u-boot-amlogic@groups.io>; Tue, 26 Jan 2021 09:51:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210126095114euoutp01ff5775337c8449a6754593df263e061d~dv2NAQ8iY0650406504euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1611654674;
	bh=9IdDzZ8GdWGcUmRPgYEgd990FpUtNOEQigb+SpSli+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyilzVjum74MbYTZ6CIotQQ2iNnalKsCkIFEYVZmudKCVqd104a0ouQ+IciSJ1ZT3
	 njFgBl+CC0SWEp4AiLRJKYJinocrYZclxeq38a9rOAEPh1NcDZEWOIwQhlkDH0Zpnn
	 XhJQ+b5po1NISVUwKkbOIPOnjZbDsRNpWUqTKrAw=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 4/4] configs: khadas-vim3(l): enable Function button support
Date: Tue, 26 Jan 2021 10:50:36 +0100
Message-Id: <20210126095036.6429-5-m.szyprowski@samsung.com>
In-Reply-To: <20210126095036.6429-1-m.szyprowski@samsung.com>
References: <20210126095036.6429-1-m.szyprowski@samsung.com>
	<CGME20210126095113eucas1p1154fc4a8742f9a969a5a19114fb79000@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add options required to check the 'Function' button state.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 configs/khadas-vim3_defconfig  | 2 ++
 configs/khadas-vim3l_defconfig | 2 ++
 2 files changed, 4 insertions(+)

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
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 6b13ce045c..c1877922c7 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
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

