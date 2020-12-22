Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web08.9108.1608627402586801102
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Dec 2020 00:56:42 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201222085640euoutp01e0170437efd1a29e1d0a7de45f709024~S-hkkRclu1260712607euoutp01v
	for <u-boot-amlogic@groups.io>; Tue, 22 Dec 2020 08:56:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201222085640euoutp01e0170437efd1a29e1d0a7de45f709024~S-hkkRclu1260712607euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608627400;
	bh=9IdDzZ8GdWGcUmRPgYEgd990FpUtNOEQigb+SpSli+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtvcuTMv3bTslHoyZ0l8onzXsyYTRrLQqkj1S7WD6RBCyyfz3jVfR3G1QLXGymotK
	 rl9DZOkFNZHT3c8SQ1rALnF7WWHK/4CbOnr338sx8Ho54/mpzjqqgtrX6+6+DyQ5Oq
	 tYlYxdHbdsQtZYEaZqZ4sigxCZILl866dVMUxPTc=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 3/3] configs: khadas-vim3(l): enable Function button support
Date: Tue, 22 Dec 2020 09:56:33 +0100
Message-Id: <20201222085633.10194-4-m.szyprowski@samsung.com>
In-Reply-To: <20201222085633.10194-1-m.szyprowski@samsung.com>
References: <20201222085633.10194-1-m.szyprowski@samsung.com>
	<CGME20201222085640eucas1p295da269be60f5193ebd2ebc027a668d2@eucas1p2.samsung.com>
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

