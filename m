Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web08.33110.1607945109580940643
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 03:25:09 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201214112453euoutp01650e1404d38e1c8dd773d6edc0ab3eb7~QkYsAQQU93266632666euoutp01E
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 11:24:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201214112453euoutp01650e1404d38e1c8dd773d6edc0ab3eb7~QkYsAQQU93266632666euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607945093;
	bh=A9WjImsRKdoFjKRWlhDpsz9eyqtnsUDUVBr8f2Ofub4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSrDDT7fiJhsmkHKEoOdZzbQjImorC03BjsCwedJPcI2dwkY/lsXHY3B88Q4exNvO
	 amKFSSDtnlP373uALdh4G+aZ0iYs91Y15u+XNZWH3ePeC557VJhXudzCU5oltz5Uq0
	 f9CM6lZj8dIRYMdG4Eg/npInfGw2q0YW6XwiZG98=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 6/6] configs: khadas-vim3: enable Function button support
Date: Mon, 14 Dec 2020 12:24:37 +0100
Message-Id: <20201214112437.18757-7-m.szyprowski@samsung.com>
In-Reply-To: <20201214112437.18757-1-m.szyprowski@samsung.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112452eucas1p2ceb557dffa15ea073f922bf59afb8578@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add options required to check the 'Function' button state.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 configs/khadas-vim3_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 9d7ba72d440..bc174305692 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -29,6 +29,10 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_DM_MMC=y
-- 
2.17.1

