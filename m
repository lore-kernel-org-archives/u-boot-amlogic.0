Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF47C54FAA
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:24 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.47188.1724653066670143360
 for <u-boot-amlogic@groups.io>;
 Sun, 25 Aug 2024 23:17:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=OZS0CXH5;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 26380120008;
	Mon, 26 Aug 2024 09:17:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 26380120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724653065;
	bh=7aMoCqtCm4gGmozuueOdTHbmR+fr1AvpmZ/ggmdD/og=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=OZS0CXH5V93XKWNSiHws8bVRfaFer6hJUJGYf9eehlCKCqOA9mzP4I2zYR/m+inu+
	 dAvypjcuy/2V0qaJqbdoT+/ADWz365+ZYNaKQza+73RovZ7s0R0gfsnzjdxnbYNnvl
	 A5uC0go+bGza7vwhsZMfQRf6Um+htlGAxuVzntwNFLv1H6Qp5/9TK9F6QywK9wQPIg
	 aSNX33H1HPLnhMQOQXZo0Igu3Iez/UkRgNY+OYG3MQ7ouFrr0lZZUROot3Qs8rgrQ7
	 D5AdJznKgeTs3NRH6DkQaWWnPzfdBJ/K4fVJYSBnRKPVLkZIm104XN1xkjetiOhs61
	 BQQQpUERoI4AA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 26 Aug 2024 09:17:44 +0300 (MSK)
Message-ID: <3f0cbb8c-6dc7-73f2-db81-f01484f4bde3@salutedevices.com>
Date: Mon, 26 Aug 2024 09:04:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	<neil.armstrong@linaro.org>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, Sean Anderson
	<seanga2@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>,
	<u-boot-amlogic@groups.io>, kernel <kernel@sberdevices.ru>,
	<oxffffaa@gmail.com>
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
 <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
 <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
 <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
 <0343aa52-8f23-4447-1827-3de7710735f3@salutedevices.com>
 <887fcb7b-5bd7-40ef-9bb5-ab9ed5079b06@linaro.org>
 <CAOf5uwnH-RTPWshLt_SnB=U=Fdug38m7Jsvm_PDm3kaCQEb_jA@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uwnH-RTPWshLt_SnB=U=Fdug38m7Jsvm_PDm3kaCQEb_jA@mail.gmail.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_uf_ne_domains}, {Tracking_arrow_http, text}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/26 04:18:00
X-KSMG-LinksScanning: Clean, bases: 2024/08/26 04:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/26 02:45:00 #26434133
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2373



On 26.08.2024 09:15, Michael Nazzareno Trimarchi wrote:
> Hi Aresenly
>=20
> On Fri, Aug 23, 2024 at 10:53=E2=80=AFAM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> On 23/08/2024 10:29, Arseniy Krasnov wrote:
>>> Hi! Got it, thanks!
>>>
>>> On 23.08.2024 11:10, Michael Nazzareno Trimarchi wrote:
>>>> Hi Arseniy
>>>>
>>>> On Thu, Aug 22, 2024 at 9:04=E2=80=AFAM Arseniy Krasnov
>>>> <avkrasnov@salutedevices.com> wrote:
>>>>>
>>>>> Hi, thanks!
>>>>>
>>>>> Thanks, Arseniy
>>>>>
>>>>> On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
>>>>>> Hi
>>>>>>
>>>>>> I will read them tomorrow ;)
>>>>>>
>>>>>> Thank you for understanding
>>>>>>
>>>>
>>>> All the series are delegated to Neil. I will review anyway but I think
>>>> that will then pick from him
>>
>> Sure I can pick them if reviewed!
>>
>=20
> Can you please resend the series? I don't find in my mailbox (strange)

Hi, sure, done. With 'RESEND' prefix.

Thanks

>=20
> Michael
>=20
>> Neil
>>
>>>>
>>>> Michael
>>>>
>>>>>> Michael
>>>>>>
>>>>>> Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.c=
om> ha
>>>>>> scritto:
>>>>>>
>>>>>>> Hi, sorry, pls ping  =F0=9F=98=84
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> On 08.07.2024 10:13, Arseniy Krasnov wrote:
>>>>>>>> Patchset is based on patchset for Linux (today merged to nand-next=
):
>>>>>>>>
>>>>>>> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasno=
v@salutedevices.com/
>>>>>>>>
>>>>>>>> Here is description from it:
>>>>>>>>
>>>>>>>>   >  Amlogic's boot ROM code needs that some pages on NAND must be=
 written
>>>>>>>>   >  in special "short" ECC mode with scrambling enabled. Such pag=
es:
>>>>>>>>   >  1) Contain some metadata about hardware.
>>>>>>>>   >  2) Located with some interval starting from 0 offset, until s=
ome
>>>>>>>>   >     specified offset. Interval and second offset are set in th=
e
>>>>>>>>   >     device tree.
>>>>>>>>   >
>>>>>>>>   >  This patchset adds R/W support for such pages. To enable it w=
e can
>>>>>>> setup
>>>>>>>>   >  it in dts:
>>>>>>>>   >
>>>>>>>>   >      nand-is-boot-medium;
>>>>>>>>   >      amlogic,boot-pages =3D <1024>;
>>>>>>>>   >      amlogic,boot-page-step =3D <128>;
>>>>>>>>   >
>>>>>>>>   >  It means that each 128th page in range 0 to 1024 pages will b=
e
>>>>>>> accessed
>>>>>>>>   >  in special mode ("short" ECC + scrambling). In practice this =
feature
>>>>>>> is
>>>>>>>>   >  needed when we want to update first block of NAND - driver wi=
ll
>>>>>>> enable
>>>>>>>>   >  required mode by itself using value from device tree.
>>>>>>>>
>>>>>>>> The only difference is that patchset for Linux updates DT bindings=
, while
>>>>>>>> this adds NAND_IS_BOOT_MEDIUM flag support.
>>>>>>>>
>>>>>>>> Changelog:
>>>>>>>>   v1 -> v2:
>>>>>>>>   * Pls see per-patch changelog.
>>>>>>>>
>>>>>>>> Arseniy Krasnov (3):
>>>>>>>>    mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
>>>>>>>>    mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
>>>>>>>>    mtd: rawnand: meson: read/write access for boot ROM pages
>>>>>>>>
>>>>>>>>   drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----=
------
>>>>>>>>   drivers/mtd/nand/raw/nand_base.c  |  3 ++
>>>>>>>>   include/linux/mtd/rawnand.h       |  5 ++
>>>>>>>>   3 files changed, 65 insertions(+), 27 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>>>
>>>>
>>
>=20
>=20

