Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web08.12750.1608043385178957167
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 06:43:06 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201215144246euoutp01b7e5a3aafa6e3011569502e9f97fecc3~Q6uwTLgN51485614856euoutp01d
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 14:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201215144246euoutp01b7e5a3aafa6e3011569502e9f97fecc3~Q6uwTLgN51485614856euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608043366;
	bh=gdX/SWG3cofRDmYv7DV/EUjzT0L8GOfezczTVzI9fu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usCcE9x6lETcfH+55IjazTKM9T0/CkTvsSEuigoRbudAmIjBUkamnYSmScPmD8uo6
	 oR3ZyMwmOsrLt6roPFdhV+6n3lls9a4BGfAQ41aDFuYT9ATh0fCOXhFP1qXiZqCA8n
	 0GydHIKShJI01XVzmzXgi1C5FQywsXY7MK0FQhcY=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 4/7] configs: khadas-vim3: enable ADC device support
Date: Tue, 15 Dec 2020 15:42:27 +0100
Message-Id: <20201215144230.9235-5-m.szyprowski@samsung.com>
In-Reply-To: <20201215144230.9235-1-m.szyprowski@samsung.com>
References: <20201215144230.9235-1-m.szyprowski@samsung.com>
	<CGME20201215144244eucas1p2a581daac51d792e119f8db88bdda7086@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

ADC device (Meson SARADC) will be used for probing 'Function' button state.

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

