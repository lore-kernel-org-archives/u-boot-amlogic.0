Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web08.4263.1608105145878737959
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 23:52:26 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201216075209euoutp02042f15b5c52ce2a7378b41d46ef4a981~RIxhe9NqC2696326963euoutp02w
	for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 07:52:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201216075209euoutp02042f15b5c52ce2a7378b41d46ef4a981~RIxhe9NqC2696326963euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608105129;
	bh=3TcxR5kF/t2gj5Q+KZvzZp616Dju0tO0NskbKLcotvc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KgSv+gJ5gm47+LvlRQ+J3CfmkYYk6CAejoEElXb6FyqnofdpYtd7eCBn7DV5ii8TP
	 xogVhxPu3jQ6qrpmFH15RBUNpkT7Eb8fOJldpIWCVd+PY2JbcpUxdYhC7ldphmSElY
	 4lc0hm7VlLsi28pADOsuglxJjtVEhjjRP5OJA7NE=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 0/6] VIM3: add support for checking 'Function' button state
Date: Wed, 16 Dec 2020 08:51:52 +0100
Message-Id: <20201216075158.16458-1-m.szyprowski@samsung.com>
References: <CGME20201216075203eucas1p2607f08a1d296c130a18177bb012642fd@eucas1p2.samsung.com>
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
if button Function
then
	echo Selected alternative boot
	...
fi
--->8---
The above script requires commit a6bfd71a96 ("cmd/button: return button
status") already present in mainline tree.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v3:
- removed 'button' env variable
- extended kconfig and patch descriptions

v2: https://lists.denx.de/pipermail/u-boot/2020-December/434991.html
- removed Change-Id tags
- split defconfig changes into ADC and button related

v1: https://lists.denx.de/pipermail/u-boot/2020-December/434875.html
- initial submission


Patch summary:

Marek Szyprowski (6):
  clk: meson: add minimal driver for g12a-ao clocks
  adc: meson-saradc: add G12A variant
  adc: meson-saradc: skip hardware init only if ADC is enabled
  configs: khadas-vim3: enable ADC device support
  button: add a simple ADC-based button driver
  configs: khadas-vim3: enable Function button support

 configs/khadas-vim3_defconfig |   4 ++
 drivers/adc/meson-saradc.c    |   9 ++-
 drivers/button/Kconfig        |   8 +++
 drivers/button/Makefile       |   1 +
 drivers/button/button-adc.c   | 117 ++++++++++++++++++++++++++++++++++
 drivers/clk/meson/Makefile    |   1 +
 drivers/clk/meson/g12a-ao.c   |  83 ++++++++++++++++++++++++
 7 files changed, 221 insertions(+), 2 deletions(-)
 create mode 100644 drivers/button/button-adc.c
 create mode 100644 drivers/clk/meson/g12a-ao.c

-- 
2.17.1

