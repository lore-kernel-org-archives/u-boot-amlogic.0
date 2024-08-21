Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10ABC5B548
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:24 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.5385.1724271925797895530
 for <u-boot-amlogic@groups.io>;
 Wed, 21 Aug 2024 13:25:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=Cfr7QRxl;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 13C74120009;
	Wed, 21 Aug 2024 23:25:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 13C74120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724271922;
	bh=DCR2LF/AdOw/Uk8d6pVtB46wYFXJpmRLhPXoL+NdMUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Cfr7QRxlzb1ZXqo+/ZrY4BCH/jLfZPkIl5E/0owEhH1o5inggCI025BG4RLZKWRTB
	 jSkvG2oecUk2PHNjWBpa2efoY92vOXSCI4iOn5WwR8ciZpEwpslQsRQzPYs9ZxCtOY
	 y2llofaT2Q7KGE9/BYr3uGMElNcTM6ll1xnhrZcDnipE+2RrIuz7nkg+HZ3Be5MzjW
	 DgJXQ9MHaDm/9qbEVPZi1VEXwQgZ9tRC/7XajXwfyOPGuhBapzktHddvi4Jy3oosS3
	 bZp+BOMtbq0q2tk7G06Hf6a9CVujpiSfAJBWLnKvZ5NFidUlxq/jWRDjB8nryr0Bpa
	 QOp4yyoN08PiQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 21 Aug 2024 23:25:21 +0300 (MSK)
Message-ID: <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
Date: Wed, 21 Aug 2024 23:12:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
X-Originating-IP: [172.28.161.232]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187218 [Aug 21 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/21 19:14:00
X-KSMG-LinksScanning: Clean, bases: 2024/08/21 19:13:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/21 18:33:00 #26403583
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2370

Hi, sorry, pls ping  =F0=9F=98=84

Thanks

On 08.07.2024 10:13, Arseniy Krasnov wrote:
> Patchset is based on patchset for Linux (today merged to nand-next):
> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salu=
tedevices.com/
>=20
> Here is description from it:
>=20
>  >  Amlogic's boot ROM code needs that some pages on NAND must be written
>  >  in special "short" ECC mode with scrambling enabled. Such pages:
>  >  1) Contain some metadata about hardware.
>  >  2) Located with some interval starting from 0 offset, until some
>  >     specified offset. Interval and second offset are set in the
>  >     device tree.
>  > =20
>  >  This patchset adds R/W support for such pages. To enable it we can se=
tup
>  >  it in dts:
>  > =20
>  >      nand-is-boot-medium;
>  >      amlogic,boot-pages =3D <1024>;
>  >      amlogic,boot-page-step =3D <128>;
>  > =20
>  >  It means that each 128th page in range 0 to 1024 pages will be access=
ed
>  >  in special mode ("short" ECC + scrambling). In practice this feature =
is
>  >  needed when we want to update first block of NAND - driver will enabl=
e
>  >  required mode by itself using value from device tree.
>=20
> The only difference is that patchset for Linux updates DT bindings, while
> this adds NAND_IS_BOOT_MEDIUM flag support.
>=20
> Changelog:
>  v1 -> v2:
>  * Pls see per-patch changelog.
>=20
> Arseniy Krasnov (3):
>   mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
>   mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
>   mtd: rawnand: meson: read/write access for boot ROM pages
>=20
>  drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
>  drivers/mtd/nand/raw/nand_base.c  |  3 ++
>  include/linux/mtd/rawnand.h       |  5 ++
>  3 files changed, 65 insertions(+), 27 deletions(-)
>=20

