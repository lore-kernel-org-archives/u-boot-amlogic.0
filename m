Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web08.12751.1608043385179087557
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 06:43:06 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201215144248euoutp01605b7acbe7afec09d475483de7bdc2ca~Q6uxnkDxr1401714017euoutp01L
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 14:42:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201215144248euoutp01605b7acbe7afec09d475483de7bdc2ca~Q6uxnkDxr1401714017euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608043368;
	bh=qwSuF1jh/esXi6KlelBRAFBzXKlF2KJbW5RtxUp/CsE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IdbYjy1PD5gAo5yptoq7v9AHO75uH1yUXgI5dMpMqhVxFqQ0sw7pxfEWBdHVoQuqX
	 MFFtMvHF8SntWHahbQzje4Fg5h6KnjNvI3IgHL94DxhI7LrPfFRg89/8KqcYFyKhpi
	 HpZJR9mwTKggnnWUNlBixY1GfQiRM0kFm8PX9ZaI=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 0/7] VIM3: add support for checking 'Function' button state
Date: Tue, 15 Dec 2020 15:42:23 +0100
Message-Id: <20201215144230.9235-1-m.szyprowski@samsung.com>
References: <CGME20201215144242eucas1p1c837ea82b7365808b5384c9eb204b593@eucas1p1.samsung.com>
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


Changelog:
v2:
- removed Change-Id tags
- split defconfig changes into ADC and button related

v1: https://lists.denx.de/pipermail/u-boot/2020-December/434875.html
- initial submission


Patch summary:

Marek Szyprowski (7):
  clk: meson: add minimal driver for g12a-ao clocks
  adc: meson-saradc: add G12A variant
  adc: meson-saradc: skip hardware init only if ADC is enabled
  configs: khadas-vim3: enable ADC device support
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

