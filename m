Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE2EC4167D
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 11:03:30 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.10202.1699959805995646197
 for <u-boot-amlogic@groups.io>;
 Tue, 14 Nov 2023 03:03:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=sUJASY+e;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8514B100022;
	Tue, 14 Nov 2023 14:03:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8514B100022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699959801;
	bh=gZM1KKetJXSxfXpTo3SyiodBPvM8rH4Dfhd1nhrmD/g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=sUJASY+e95NNTRKOWqdYxUsG9pOn5UpBG18Dd8RoNrw4kF90xxsFxDo93uJf7u/ja
	 JH4I81nHYp6cwiiIRnhZE0BV+B7LxzetH5IE8fwkhcsxvXsOVbERbwKAiaaolSCvOM
	 rBf751/bGddmx5A4PR/3Qx2Draq/iUUq4dVIPJkwMKPpusYlbUvEOPZ6FaLZbYKLhH
	 rGXCUjrTvmvvTjyLzQt+rkxBo9HJS8mwrKAEGSKJ2Kj+rIGcTLQWH3hcZCz1b6jThZ
	 9wUSPXYO19j4fU6Mi0SRMQzvMqUA09ePaQX51i1kWAgwBLEMUegEi4XVvdRNmitf11
	 WSv+os+dk1vdA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 14 Nov 2023 14:03:21 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:20 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
	<kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Abdellatif
 El Khlifi <abdellatif.elkhlifi@arm.com>, Alexander Dahl <ada@thorsis.com>,
	Alexey Romanov <avromanov@salutedevices.com>, Andy Fleming
	<afleming@gmail.com>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, Bin Meng <bmeng.cn@gmail.com>, Bin
 Meng <bmeng@tinylab.org>, Chanho Park <chanho61.park@samsung.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Daniel Schwierzeck
	<daniel.schwierzeck@gmail.com>, Dario Binacchi
	<dario.binacchi@amarulasolutions.com>, Eugen Hristev
	<eugen.hristev@collabora.com>, Jagan Teki <jagan@amarulasolutions.com>, Leo
	<ycliang@andestech.com>, Marek Vasut <marex@denx.de>, Mario Six
	<mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Max
 Filippov <jcmvbkbc@gmail.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Nishanth Menon <nm@ti.com>, Priyanka Jain <priyanka.jain@nxp.com>, Rick Chen
	<rick@andestech.com>, Scott McNutt <smcnutt@psyent.com>, Stefan Roese
	<sr@denx.de>, Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>,
	<u-boot-amlogic@groups.io>
Subject: [PATCH 00/13] Import "string" I/O functions from Linux
Date: Tue, 14 Nov 2023 14:02:44 +0300
Message-ID: <20231114110257.2488-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181340 [Nov 14 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/14 07:58:00 #22462416
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 14 Nov 2023 11:03:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1874

This series imports generic versions of ioread_rep/iowrite_rep and
reads/writes from Linux. Some cleanup is done to make sure that all
platforms have proper defines for implemented functions and there are no
redefinitions.


Igor Prusov (13):
  sandbox: move asm-generic include to the end of file
  x86: Add defines for ins/outs functions
  mips: io.h: Add const to reads functions params
  mips: io.h: Add defines for read/write/in/out functions
  riscv: io.h: Add defines for reads/writes functions
  riscv: io.h: Fix signatures of reads/writes functions
  nios2: io.h: Add defines for ins/outs functions
  powerpc: io.h: Add defines for __raw_{read,write} functions
  xtensa: io.h: Add defines for ins/outs functions
  asm-generic: Import functions from Linux
  spi: meson_spifc_a1: Switch to io{read,write}32_rep()
  treewide: Include linux/io.h instead of asm-generic/io.h
  musb-new: Remove implementation of io.h functions

 arch/mips/include/asm/io.h                   |  35 +-
 arch/nios2/include/asm/io.h                  |   6 +
 arch/powerpc/include/asm/io.h                |  11 +
 arch/riscv/include/asm/io.h                  |  26 +-
 arch/sandbox/include/asm/io.h                |  28 +-
 arch/x86/include/asm/io.h                    |   6 +
 arch/xtensa/include/asm/io.h                 |   6 +
 drivers/mtd/nand/raw/atmel/nand-controller.c |  34 --
 drivers/mtd/nand/raw/nand_base.c             |  33 --
 drivers/spi/cadence_qspi.c                   |   2 +-
 drivers/spi/meson_spifc_a1.c                 |   4 +-
 drivers/usb/cdns3/cdns3-ti.c                 |   1 -
 drivers/usb/dwc3/dwc3-meson-g12a.c           |   2 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c            |   2 +-
 drivers/usb/musb-new/musb_io.h               |  24 --
 include/asm-generic/io.h                     | 348 +++++++++++++++++++
 16 files changed, 450 insertions(+), 118 deletions(-)

--=20
2.34.1


