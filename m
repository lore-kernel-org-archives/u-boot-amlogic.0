Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.4265.1608105143953274579
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 23:52:24 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201216075207euoutp029cc40db3014bb8add515ba9263b39de4~RIxfsSO_x2686326863euoutp025
	for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 07:52:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201216075207euoutp029cc40db3014bb8add515ba9263b39de4~RIxfsSO_x2686326863euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608105127;
	bh=zjNcJlCouTC2Ts3manBXqRKhnVIrhQC65zXuYnlUoQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pr2sRM9MdmiJPolrBxdXpfWz09sZJeC6iXjpkhlyh6W3N0xKO2e2s+MbVfAS/S49c
	 Engr5AWenRrLFNeWk0J15/rDkBdy/4E87lASZvFzNahBwSUWLlR94AoZamwlQpN28q
	 bWT821+/6q4qiWUeMvyXpx351eKt68BjEupjr3IY=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 6/6] configs: khadas-vim3: enable Function button support
Date: Wed, 16 Dec 2020 08:51:58 +0100
Message-Id: <20201216075158.16458-7-m.szyprowski@samsung.com>
In-Reply-To: <20201216075158.16458-1-m.szyprowski@samsung.com>
References: <20201216075158.16458-1-m.szyprowski@samsung.com>
	<CGME20201216075206eucas1p2b61e6298a430419f039a7089567db1de@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add options required to check the 'Function' button state.

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

