Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73693C41513
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 07:52:46 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.74533.1720423570516591100
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Jul 2024 00:26:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=PCT50Hmt;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A0550120003;
	Mon,  8 Jul 2024 10:26:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A0550120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720423567;
	bh=zj/bAFyAmzrMgz04rnhp+Ihd/G1cVWD/23kiqlNChkU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PCT50HmtGIkZdjS1rRvFnoRQJTsC4XMcyrCpkcdLaRDqzs4bpXVR7Sf0KwCp2jorZ
	 fhjCFUgYAB4blw02iCAMriANtxEN7VLK6N7mtpMWQlpo+5/bLBOzqNSizLjCcGgDnC
	 WkI64hzeJrkNICpD2vThdHeusKtuoEaWEo7hiJBMkW6IV30lqrIEMmkuK3e+ZoeCjc
	 mLw64uZKsKmsn4Ah0Np382Ce86jTAWLMBs2nK5saLszpkbL/934vdA2aSbad+v4aPz
	 snnX5tycbvZD9ll1D/vRq2ywMwKAwkGjOjIIec71gmOwe1ZIrKXTZSZfFIf/HME2Rm
	 VS+hKDfp2YeMg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  8 Jul 2024 10:26:07 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jul 2024 10:26:06 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
Date: Mon, 8 Jul 2024 10:13:49 +0300
Message-ID: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186359 [Jul 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/08 06:16:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/08 06:16:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/08 05:54:00 #25895811
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jul 2024 07:52:46 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2353

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


