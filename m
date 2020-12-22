Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web12.9211.1608627401525335371
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Dec 2020 00:56:42 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201222085639euoutp02a252e9aa9c04e99901424d5dd2b83f77~S-hjGmJB00056900569euoutp02k
	for <u-boot-amlogic@groups.io>; Tue, 22 Dec 2020 08:56:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201222085639euoutp02a252e9aa9c04e99901424d5dd2b83f77~S-hjGmJB00056900569euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608627399;
	bh=1/oZNWy+ZOf5uuMoUZdQsjOvYoFte06Fgcu1znUeKi0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=qQowP4oblPN+q7INQIbIf2mqe9ay6oNdmjagOUwnflNh7GJTq3wYydW4odcHRtctD
	 MZmvvzJSxm0hlNhA1bxrqK4aRjpvGfI2vpn5agEWXeu7Z+Ii6QOF8g5aXNaZQD2Cuc
	 qve3qmQMSqh5NjlugUkp+NPMZ+4dBIDHjucpCbPQ=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 0/3] VIM3: add support for checking 'Function' button state
Date: Tue, 22 Dec 2020 09:56:30 +0100
Message-Id: <20201222085633.10194-1-m.szyprowski@samsung.com>
References: <CGME20201222085638eucas1p158d91ce4a22d13623b19706b26374078@eucas1p1.samsung.com>
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

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v4:
- rebased onto uboot-amlogic/u-boot-amlogic-next and dropped merged patches
- added adc-keys bindings docs (copied from Linux kernel)
- minor code adjustments pointed by Simon
- enabled driver also in khadas-vim3l_defconfig

v3: https://lists.denx.de/pipermail/u-boot/2020-December/435072.html
- removed 'button' env variable
- extended kconfig and patch descriptions

v2: https://lists.denx.de/pipermail/u-boot/2020-December/434991.html
- removed Change-Id tags
- split defconfig changes into ADC and button related

v1: https://lists.denx.de/pipermail/u-boot/2020-December/434875.html
- initial submission


Patch summary:

Marek Szyprowski (3):
  dt-bindings: input: adc-keys bindings documentation
  button: add a simple Analog to Digital Converter device based button
    driver
  configs: khadas-vim3(l): enable Function button support

 configs/khadas-vim3_defconfig               |   2 +
 configs/khadas-vim3l_defconfig              |   2 +
 doc/device-tree-bindings/input/adc-keys.txt |  49 ++++++++
 drivers/button/Kconfig                      |   8 ++
 drivers/button/Makefile                     |   1 +
 drivers/button/button-adc.c                 | 121 ++++++++++++++++++++
 6 files changed, 183 insertions(+)
 create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
 create mode 100644 drivers/button/button-adc.c

-- 
2.17.1

