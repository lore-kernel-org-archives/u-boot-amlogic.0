Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8E1E77188
	for <webhook@archiver.kernel.org>; Mon, 30 Dec 2024 14:05:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.29762.1735026956294019957
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Dec 2024 23:55:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=S+hOPyou;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CD248100015;
	Tue, 24 Dec 2024 10:55:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CD248100015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1735026952;
	bh=GLNXHe3zWhPPSHeSwXSZk78qBAx5u8s6lcWjmkhXeiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=S+hOPyouSMKeJUtmpp4TXTuYXEw4ef870GIlpDGam3F1FLGxHaEkzCq3Q/oBzPL+0
	 wRn1muYD/2d+r8cTZ+9wBFA0ePGZo4CcXnnMLNMNWdcv9cCG8Iwh147KIgObCy0IV2
	 XbI633JI3dQGsbCDdbbmO4GAXoA1NrqIw+Ib2oQQFbd4FWr1SihrFYd1EiDckx4nwU
	 sEgUcm8CPAha3bEpZnsPncwVzs2Wg9/D/tgB3/c9qjU++S4kPK1GLyPu8oO9ojxt9t
	 KFluFny3LxzOIZo/V9r/ZwVUZ1stjSJJSo6RquLZPn2pI/rGqpXqboGafPuyqbgAGQ
	 ZK1Hux/bz8kfQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 24 Dec 2024 10:55:52 +0300 (MSK)
Message-ID: <983f63fb-e61c-3aaf-9969-eef1ca3f23c9@salutedevices.com>
Date: Tue, 24 Dec 2024 10:55:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] mtd: rawnand: meson: always use OOB bytes during write
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	<u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@salutedevices.com>, <oxffffaa@gmail.com>
References: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
 <CAOf5uwmb6W1BjCsc437_aFnO0fjVHrr-mU0r8ZGK_jpwn-75Kg@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uwmb6W1BjCsc437_aFnO0fjVHrr-mU0r8ZGK_jpwn-75Kg@mail.gmail.com>
X-Originating-IP: [172.28.160.35]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190021 [Dec 24 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;source.denx.de:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/24 07:14:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/24 07:14:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/24 05:06:00 #26909694
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Dec 2024 14:05:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2598



On 23.12.2024 15:57, Michael Nazzareno Trimarchi wrote:
> On Sun, Dec 22, 2024 at 10:23=E2=80=AFPM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> If 'oob_required' is not set by the caller (for example 'oobbuf' is NULL=
),
>> then driver doesn't copy OOB data from 'oob_poi' to special controller
>> structures, so zeroes will be written as OOB. But, generic raw NAND logi=
c
>> in 'nand_base.c' already handles case when OOB is not required to write =
by
>> filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
>> always read 'oob_poi' data for OOB.
>>
>> Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same way,
>> so need to keep same behaviour here.
>>
>> Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/me=
son_nand.c
>> index 81122315f4..82a12ac061 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_inf=
o *mtd, struct nand_chip *ch
>>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
>>
>>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE)=
;
>> -
>> -       if (oob_required)
>> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
>> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
>>
>=20
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
>=20
> I will queue it

Thanks. You mean it will be merged to https://source.denx.de/u-boot/custodi=
ans/u-boot-nand-flash ?


>=20
>>         return meson_nfc_write_page_sub(chip, page, false);
>>  }
>> --
>> 2.30.1
>=20
>=20
>=20

