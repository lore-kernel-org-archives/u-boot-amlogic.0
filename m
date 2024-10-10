Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6B6CFC501
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.40029.1728555659221887774
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Oct 2024 03:21:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=oW12eFtQ;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7E595100009;
	Thu, 10 Oct 2024 13:20:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7E595100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728555652;
	bh=rASYDwPLjIJ7B1QaU9Y7M282q10+qMGDRaeFL+IOMCE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=oW12eFtQVl7dtuKBNXQZDi8cQi0jSnmAEnn8tE7jDw0V1fLhpAGRILykhlFTVnbIa
	 9BX/xGJThAta17ifmC8ndNrm+3Zri+7JAPAOOhIHe5x3f/9D89har3WlmqUhnveK0H
	 g9L+LktLSCFMPb09ExYAIOcfPsHOKg9BAw/3P62htYYLvyesjK701O8uRNmtdBrns2
	 lvN1qdSOKVA8xUZwx6700EsH5oQKwj7xqo5UUagp/DzMS2QzD9+MUlgAyp4572u/uy
	 ov2Z6vbcKrB4ll6p6ix34sramLj2aNe8AW4GWWgXULMHngxYC65v+ouknS07UZPogU
	 rMCsbyu+G2Rig==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 10 Oct 2024 13:20:52 +0300 (MSK)
Date: Thu, 10 Oct 2024 13:20:51 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
	<u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print BCB block content
Message-ID: <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
 <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.226.150]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188352 [Oct 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/10 08:57:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/10 08:56:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/10 09:24:00 #26730447
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2470

On Wed, Oct 09, 2024 at 03:13:57PM -0600, Simon Glass wrote:
> Hi Dmitry,
> 
> On Wed, 9 Oct 2024 at 07:26, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> >
> > Hello Simon,
> >
> > On Tue, Oct 08, 2024 at 07:57:15PM -0600, Simon Glass wrote:
> > > On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> > > >
> > > > It's really helpful to have the ability to dump BCB block for debugging
> > > > A/B logic on the board supported this partition schema.
> > > >
> > > > Command 'bcb ab_dump' prints all fields of bootloader_control struct
> > > > including slot_metadata for all presented slots.
> > > >
> > > > Output example:
> > > > =====
> > > > > board# bcb ab_dump ubi 0#misc
> > > > > Read 512 bytes from volume misc to 000000000bf07580
> > > > > Read 512 bytes from volume misc to 000000000bf42f40
> > > > > Bootloader Control:       [misc]
> > > > > Active Slot:              _a
> > > > > Magic Number:             0x42414342
> > > > > Version:                  1
> > > > > Number of Slots:          2
> > > > > Recovery Tries Remaining: 0
> > > > > CRC:                      0x2c8b50bc (Valid)
> > > > >
> > > > > Slot[0] Metadata:
> > > > >       - Priority:         15
> > > > >       - Tries Remaining:  0
> > > > >       - Successful Boot:  1
> > > > >       - Verity Corrupted: 0
> > > > >
> > > > > Slot[1] Metadata:
> > > > >       - Priority:         14
> > > > >       - Tries Remaining:  7
> > > > >       - Successful Boot:  0
> > > > >       - Verity Corrupted: 0
> > > > ====
> > > >
> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > > ---
> > > >  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
> > > >  include/android_ab.h | 10 ++++++++
> > > >  3 files changed, 113 insertions(+)
> > > >
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Can you also update the test?
> >
> > I apologize, but I didn't quite understand your point. Could you please
> > clarify? This patch series includes additional tests for the 'ab_dump'
> > subcommand. For more details, please refer to:
> >
> > https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/
> 
> OK, thank you. Sometimes it is easier (for reviewers) if you update
> the test in the same commit.

Should I resend the patch series with ab_dump implementation and tests
in the same commit?

I can prepare new version, if needed, no problem.

-- 
Thank you,
Dmitry

