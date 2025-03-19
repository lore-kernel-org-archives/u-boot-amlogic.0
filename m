Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F3C3600C
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.4612.1742415660459905067
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=LanijTgF;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 18F9012000E;
	Wed, 19 Mar 2025 23:20:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 18F9012000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415657;
	bh=cLFMeZinsNGDDWR59OrZqdkhRVvSj+jMeMccz5dxOI8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LanijTgFWMCqrWBbOghKgXAMoSfHTUBB4R4EiKBjD/KdfkJMEO9kpAUjj+lTRBBWu
	 VHMqo794agwxB+LcExiUUSkAjkf86oyF0nq39NzCkNpVl9aNBBn+o0szO+dmjeL7Se
	 rmeE9uSGMyijzWBN6HwJmuwv70/peTUWEZhKFMmbg7OitBkPk2+gsRqWQ58tZ0SXqZ
	 bDLQkOoIvDYlz2rv4BER+u1WfWyGs64b1GHGwvgR3K8MjUePZSO/1HQPpxE1y74Ie7
	 3r9/WtCyJa1cKdT+Vjp5RorYLi7++oR3C7OO3QXZJkGc4ngwj7ZsXzet2QGEioebnn
	 7HsG8dffOEwkg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 19 Mar 2025 23:20:56 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
	Viacheslav Bocharov <adeep@lexina.in>, Sumit Garg <sumit.garg@linaro.org>,
	Simon Glass <sjg@chromium.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jerome Forissier
	<jerome.forissier@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, <oxffffaa@gmail.com>,
	<avkrasnov@salutedevices.com>
Subject: [PATCH v1 00/11] Amlogic: ADNL and Optimus protocols support
Date: Wed, 19 Mar 2025 23:20:34 +0300
Message-ID: <20250319202045.1407-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [172.28.65.111]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191951 [Mar 19 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, github.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/03/19 19:47:00
X-KSMG-LinksScanning: Clean, bases: 2025/03/19 19:47:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/19 19:45:00 #27804052
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Mar 2025 14:56:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2636

This patchset adds support of two Amlogic firmware burning protocols:
ADNL and Optimus. Each protocol is supported on the following SoC:

axg, g12a, g12b, sm1 - Optimus.
a1, s4, a5, c1, c2, c3, sc2, t3, t7, p1 - ADNL.

Both work in fastboot manner, but significant feature is that they are
supported by current Amlogic BootROMs. As transport both use USB:
device is switched to gadget mode and then it can communicate with PC.
On PC side protocols are supported by:

1) https://github.com/superna9999/pyamlboot (with some limitation)

   For example:
   pyamlboot/./ubt.py --img <image> --wipe all --reset

   Note, image has special format, specific for Amlogic.

2) Proprietary vendor tools.

As protocols are supported by BootROM, it allows to "resurrect" devices
when boot image (BL2, Uboot) missed/invalid. Typical flow for such cases
is (both protocols):

      DEVICE                       PC

                          *-------------------*
                          |                   |
                          | Runs update tool, |
                          | waits for device  |
                          |    on USB bus.    |
                          |                   |
                          *-------------------*
                                    |
*---------------------*             |
|      Power on       |<-----<------/
*---------------------*
          |
          |
*---------------------*
|                     |
| Boot ROM switches   |
| device to USB gadget|>----->------\
| mode and waits for  |             |
| commands.           |             |
|                     |             |
*---------------------*             |
                                    |
                          *-------------------*
                          | Detects device on |
                          |     USB bus.      |
                          *-------------------*
                                    |
                                    |
                          *-------------------*
                          |  Sends BL2 image  |
                          |     over USB.     |
                          *-------------------*
                                    |
*---------------------*             |
|     Boot ROM runs   |<-----<------/
|       BL2 image.    |
*---------------------*
          |
          |
*---------------------*
|    BL2 waits for    |>----->------\
|  Uboot image (FIP). |             |
*---------------------*             |
                                    |
                          *-------------------*
                          | Sends Uboot image |
                          |     over USB.     |
                          *-------------------*
                                    |
*---------------------*             |
|  BL2 runs received  |<-----<------/
|     Uboot image.    |
*---------------------*
           |
           |
*---------------------*
|   Uboot waits for   |>----->------\
|      commands.      |             |
*---------------------*             |
                                    |
                          *-------------------*
                          | Sends commands to |
                          |    over USB.      |
                          *-------------------*
                                    |
*---------------------*             |
| Uboot processes     |             |
| commands: erases,   |             |
| writes NAND, checks |<-----<------/
| CRC of written data |
| etc.                |
*---------------------*
           |
           |
*---------------------*
| Uboot does reboot   |
*---------------------*

There is also another mode to operate both protocols when  we run not
from BootROM, but from Uboot shell. To do that, we enter protocol
specific command in shell ("adnl" or "optimus"). In this case Uboot
switches device to gadget mode, write some value to special register
and does reboot. Then BootROM checks above mentioned register and then
switches device to gadget mode. After that flow from above is executed.
This mode has same purposes as image update by 'fastboot'.

Limitations:
1) Only limited set of each protocol commands are supported -
   it is enough to update image. But, for example 'secureboot'
   feature is not implemented.
2) ADNL was tested on A1 SoC only.
3) Optimus was tested on AXG SoC only.

For more details of each protocol pls see the following:
ADNL - drivers/usb/gadget/amlogic/adnl/f_adnl.c
Optimus - drivers/usb/gadget/amlogic/optimus/f_optimus.c.

Arseniy Krasnov (8):
  arch: arm: meson: use 'meson_sm_call()' in 'meson_sm_pwrdm_set()'
  usb: gadget: fastboot: make part of USB fastboot code shared
  usb: gadget: amlogic: common code for Amlogic flashing commands
  mtd: rawnand: meson: move some defines to dedicated header
  arch: arm: meson: bootloader write support
  arm: meson: a1: add A1_SYSCTRL_SEC_STICKY_REG2
  usb: gadget: amlogic: implement ADNL protocol
  arm: meson: a1: ADNL protocol support

Vladimir Mitrofanov (3):
  arch: arm: meson: sm: add commands to reboot device in different modes
  usb: gadget: amlogic: implement Optimus protocol
  arch: arm: axg: Optimus protocol support

 arch/arm/include/asm/arch-meson/a1.h          |  19 +
 arch/arm/include/asm/arch-meson/axg.h         |  12 +
 arch/arm/include/asm/arch-meson/nand.h        |  34 +
 arch/arm/include/asm/arch-meson/rawnand.h     |  38 +
 arch/arm/include/asm/arch-meson/sm.h          |  98 +-
 arch/arm/include/asm/arch-meson/spinand.h     |  43 +
 arch/arm/mach-meson/Kconfig                   |  31 +
 arch/arm/mach-meson/Makefile                  |   4 +-
 arch/arm/mach-meson/board-a1.c                |  32 +-
 arch/arm/mach-meson/board-axg.c               |  12 +
 arch/arm/mach-meson/board-common.c            |  32 +
 arch/arm/mach-meson/rawnand.c                 | 291 ++++++
 arch/arm/mach-meson/sm.c                      |  43 +-
 arch/arm/mach-meson/spinand.c                 | 158 ++++
 cmd/Kconfig                                   |  14 +
 cmd/meson/Makefile                            |   2 +
 cmd/meson/adnl.c                              |  27 +
 cmd/meson/gadget.c                            | 183 ++++
 cmd/meson/gadget.h                            |  28 +
 cmd/meson/optimus.c                           |  21 +
 drivers/mtd/nand/raw/meson_nand.c             |  13 +-
 drivers/sm/meson-sm.c                         |   3 +
 drivers/usb/gadget/Kconfig                    |   2 +
 drivers/usb/gadget/Makefile                   |   4 +-
 drivers/usb/gadget/amlogic/Kconfig            |  12 +
 drivers/usb/gadget/amlogic/adnl/Kconfig       |  29 +
 drivers/usb/gadget/amlogic/adnl/Makefile      |   4 +
 drivers/usb/gadget/amlogic/adnl/adnl.h        | 124 +++
 .../gadget/amlogic/adnl/adnl_buff_manager.c   | 316 +++++++
 drivers/usb/gadget/amlogic/adnl/adnl_media.c  | 235 +++++
 .../usb/gadget/amlogic/adnl/adnl_storage.c    | 140 +++
 drivers/usb/gadget/amlogic/adnl/f_adnl.c      | 835 ++++++++++++++++++
 drivers/usb/gadget/amlogic/optimus/Kconfig    |  12 +
 drivers/usb/gadget/amlogic/optimus/Makefile   |   7 +
 .../usb/gadget/amlogic/optimus/f_optimus.c    | 687 ++++++++++++++
 .../gadget/amlogic/optimus/optimus_download.c | 188 ++++
 .../gadget/amlogic/optimus/optimus_download.h |  86 ++
 drivers/usb/gadget/f_fastboot.c               | 295 +------
 drivers/usb/gadget/f_fastboot_common.c        | 320 +++++++
 drivers/usb/gadget/f_fastboot_common.h        |  71 ++
 include/meson/sm.h                            |   3 +
 41 files changed, 4202 insertions(+), 306 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-meson/nand.h
 create mode 100644 arch/arm/include/asm/arch-meson/rawnand.h
 create mode 100644 arch/arm/include/asm/arch-meson/spinand.h
 create mode 100644 arch/arm/mach-meson/rawnand.c
 create mode 100644 arch/arm/mach-meson/spinand.c
 create mode 100644 cmd/meson/adnl.c
 create mode 100644 cmd/meson/gadget.c
 create mode 100644 cmd/meson/gadget.h
 create mode 100644 cmd/meson/optimus.c
 create mode 100644 drivers/usb/gadget/amlogic/Kconfig
 create mode 100644 drivers/usb/gadget/amlogic/adnl/Kconfig
 create mode 100644 drivers/usb/gadget/amlogic/adnl/Makefile
 create mode 100644 drivers/usb/gadget/amlogic/adnl/adnl.h
 create mode 100644 drivers/usb/gadget/amlogic/adnl/adnl_buff_manager.c
 create mode 100644 drivers/usb/gadget/amlogic/adnl/adnl_media.c
 create mode 100644 drivers/usb/gadget/amlogic/adnl/adnl_storage.c
 create mode 100644 drivers/usb/gadget/amlogic/adnl/f_adnl.c
 create mode 100644 drivers/usb/gadget/amlogic/optimus/Kconfig
 create mode 100644 drivers/usb/gadget/amlogic/optimus/Makefile
 create mode 100644 drivers/usb/gadget/amlogic/optimus/f_optimus.c
 create mode 100644 drivers/usb/gadget/amlogic/optimus/optimus_download.c
 create mode 100644 drivers/usb/gadget/amlogic/optimus/optimus_download.h
 create mode 100644 drivers/usb/gadget/f_fastboot_common.c
 create mode 100644 drivers/usb/gadget/f_fastboot_common.h

--=20
2.30.1


