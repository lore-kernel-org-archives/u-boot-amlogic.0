Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3213CC5B55B
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:25 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.47182.1724653033722769300
 for <u-boot-amlogic@groups.io>;
 Sun, 25 Aug 2024 23:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=mPdfHInd;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E5029120008;
	Mon, 26 Aug 2024 09:17:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E5029120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724653030;
	bh=zj/bAFyAmzrMgz04rnhp+Ihd/G1cVWD/23kiqlNChkU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mPdfHIndBerRNFIXFmRt0c0J5mw02cypHgE97408ox3XxWpXGYBeOs7cLOmJXuRiI
	 2YkL9+3dytoSawb59NvJWrOyIrvFItKg1ICqszbfvrJFn4YW/yYgZuTxRliZKyr5/Q
	 SVw57F5NSSCYTSBpx9ppib+03j/8i+XLzAHd46sWtOyDIwUNEv/W4xS6QNUo5j9dfS
	 DlpQjEjUY9670t4nA+0aOwQLDHFeCFdesk6I87VNuuJaPLOXm82Z2zBehL0SWUH+Ht
	 IPH7KQhdCzdpp7LqLAKwvjfofSTi5n+FoTTLPrOKAt1EuRaEK/hRijqaSI/o2ugdoI
	 UiLj38MdR9Ruw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 26 Aug 2024 09:17:10 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [RESEND PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
Date: Mon, 26 Aug 2024 09:04:08 +0300
Message-ID: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
X-Originating-IP: [172.28.161.232]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187287 [Aug 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/26 04:18:00
X-KSMG-LinksScanning: Clean, bases: 2024/08/26 04:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/26 02:45:00 #26434133
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2366

Patchset is based on patchset for Linux (today merged to nand-next):
https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salute=
devices.com/

Here is description from it:

 >  Amlogic's boot ROM code needs that some pages on NAND must be written
 >  in special "short" ECC mode with scrambling enabled. Such pages:
 >  1) Contain some metadata about hardware.
 >  2) Located with some interval starting from 0 offset, until some
 >     specified offset. Interval and second offset are set in the
 >     device tree.
 > =20
 >  This patchset adds R/W support for such pages. To enable it we can setu=
p
 >  it in dts:
 > =20
 >      nand-is-boot-medium;
 >      amlogic,boot-pages =3D <1024>;
 >      amlogic,boot-page-step =3D <128>;
 > =20
 >  It means that each 128th page in range 0 to 1024 pages will be accessed
 >  in special mode ("short" ECC + scrambling). In practice this feature is
 >  needed when we want to update first block of NAND - driver will enable
 >  required mode by itself using value from device tree.

The only difference is that patchset for Linux updates DT bindings, while
this adds NAND_IS_BOOT_MEDIUM flag support.

Changelog:
 v1 -> v2:
 * Pls see per-patch changelog.

Arseniy Krasnov (3):
  mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
  mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
  mtd: rawnand: meson: read/write access for boot ROM pages

 drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
 drivers/mtd/nand/raw/nand_base.c  |  3 ++
 include/linux/mtd/rawnand.h       |  5 ++
 3 files changed, 65 insertions(+), 27 deletions(-)

--=20
2.30.1


