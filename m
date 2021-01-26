Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.10164.1611654674732811499
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Jan 2021 01:51:15 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210126095112euoutp02751b4e09b234afa3fac5c27a90c03829~dv2K2NKRR3205232052euoutp02_
	for <u-boot-amlogic@groups.io>; Tue, 26 Jan 2021 09:51:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210126095112euoutp02751b4e09b234afa3fac5c27a90c03829~dv2K2NKRR3205232052euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1611654672;
	bh=mrw1Am27lS8Hgq4OOG9yDXMlGg0SAcG2qHILTx2XzZI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=t9vJLqmPvBum9E5cBQxP78I1IkhSZdJPMt6c3psBOv1AyNJFYMs88a+F/L6hMR459
	 Log3zSanidG6ezxqi/emHiJ2d/X6zB4fS5fZMNcOoBCAIwGK+zd7UNlKedUC5b/dAo
	 cqZtYalemp5+ouPfnYGqDRfxX6kwNdOPECDXinKY=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 0/4] VIM3: add support for checking 'Function' button state
Date: Tue, 26 Jan 2021 10:50:32 +0100
Message-Id: <20210126095036.6429-1-m.szyprowski@samsung.com>
References: <CGME20210126095111eucas1p21e10e8470c39d555080f68fa36957c72@eucas1p2.samsung.com>
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
v5:
- rebased onto latest uboot-amlogic/u-boot-amlogic-next branch
- synchronized adc-keys binding with the recent version from the Linux
  kernel
- updated adc-keys driver to match behavior from dt-bindings
- added a patch for meson-saradc driver to register vdd reference supply
  to the ADC framework

v4: https://lists.denx.de/pipermail/u-boot/2020-December/435641.html
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

Marek Szyprowski (4):
  dt-bindings: input: adc-keys bindings documentation
  button: add a simple Analog to Digital Converter device based button
    driver
  adc: meson-saradc: add support for getting reference voltage value
  configs: khadas-vim3(l): enable Function button support

 configs/khadas-vim3_defconfig               |   2 +
 configs/khadas-vim3l_defconfig              |   2 +
 doc/device-tree-bindings/input/adc-keys.txt |  67 +++++++++
 drivers/adc/meson-saradc.c                  |  21 +++
 drivers/button/Kconfig                      |   8 +
 drivers/button/Makefile                     |   1 +
 drivers/button/button-adc.c                 | 156 ++++++++++++++++++++
 7 files changed, 257 insertions(+)
 create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
 create mode 100644 drivers/button/button-adc.c

-- 
2.17.1

