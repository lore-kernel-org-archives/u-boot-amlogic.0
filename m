Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web12.33290.1607945111624898389
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 03:25:11 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201214112455euoutp02a5dd8af565c85db465505509c3808392~QkYt983Nt2236322363euoutp02j
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 11:24:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201214112455euoutp02a5dd8af565c85db465505509c3808392~QkYt983Nt2236322363euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607945095;
	bh=GAtq9w9p9jAEKxT5Ja90cjvbtW3OXTS+9gKCvMoivqg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=X1R1STAEjZbfobc/WNq2Daoc1QzIDywXfKJURph4tlBHewuwNO2clHWxkQyyQFKbk
	 ksS5wrHIVQHztgXtXC99UjVjcl4sbPr/jbltf2hBKxFcgfI6JJSkTmyl28N7SPDWFz
	 dZYeYkcZ7KXb3eLuWshbfVC2kZodqWx8zdu2gGuY=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/6] VIM3: add support for checking 'Function' button state
Date: Mon, 14 Dec 2020 12:24:31 +0100
Message-Id: <20201214112437.18757-1-m.szyprowski@samsung.com>
References: <CGME20201214112449eucas1p28f3ade12253fb8b60c1396c706a65220@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi All,

This patchset adds all building blocks needed for checking the 'Function'
button state in the boot script on Amlogic A311D based VIM3 board. This
button is connected to the ADC lines of the SoC, so it required to enable
meson SARADC, the clocks needed for it and a simple button-adc drivers.

Once applied, one can use following commands in the boot scripts:
-->8---
echo Checking Func button state: \\c
button Function
if test ${button} = on
then
	echo Selected alternative boot
	...
fi
--->8---

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Marek Szyprowski (6):
  clk: meson: add minimal driver for g12a-ao clocks
  adc: meson-saradc: add G12A variant
  adc: meson-saradc: skip hardware init only if ADC is enabled
  button: add a simple ADC-based button driver
  cmd: button: store button state in the 'button' env
  configs: khadas-vim3: enable Function button support

 cmd/button.c                  |   4 +-
 configs/khadas-vim3_defconfig |   4 ++
 drivers/adc/meson-saradc.c    |   9 ++-
 drivers/button/Kconfig        |   8 +++
 drivers/button/Makefile       |   1 +
 drivers/button/button-adc.c   | 117 ++++++++++++++++++++++++++++++++++
 drivers/clk/meson/Makefile    |   1 +
 drivers/clk/meson/g12a-ao.c   |  83 ++++++++++++++++++++++++
 8 files changed, 224 insertions(+), 3 deletions(-)
 create mode 100644 drivers/button/button-adc.c
 create mode 100644 drivers/clk/meson/g12a-ao.c

-- 
2.17.1

