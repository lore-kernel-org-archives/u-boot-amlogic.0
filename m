Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9286DD1A43A
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.13602.1728657923850546233
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 07:45:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=JlSKJfFN;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 25CC210000B;
	Fri, 11 Oct 2024 17:45:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 25CC210000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728657920;
	bh=okmdvEherz+gJD2zQiYiqmmEiKyC6LL5ZKLRSoxV51U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=JlSKJfFNswtYh8rldqaZbO+2thhX5VazaZA8xFdU05pS9mMpWovmX2pfIMolIhJp2
	 LyDp4o9PH5i95JjaDXto/qLVQBZ/xOV47Dw5HPFHhkFZtboAgrO6aMUJ/xxVeBakPA
	 ehASG/5y3IBqB5bwFEaZUEJ6zAJpIcygeKJckwx4mw7CMr2jln46N2QhaBgf3jHX21
	 4+H4BFqE52jxkiL78BjRVc2MUO3oIt4raJBQJ33tbdMrQKJPe5qIwZZhO6Z27BczDL
	 8j3C/sttwyxKydjW3Rj42DZIV9nXkl9y09c028TATMVNVgZ0WTdyfrfM9FGr46epQS
	 Imu11YwSv6tvw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 11 Oct 2024 17:45:19 +0300 (MSK)
Date: Fri, 11 Oct 2024 17:45:19 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: <u-boot-amlogic@groups.io>, Simon Glass <sjg@chromium.org>, Igor Opaniuk
	<igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
	<u-boot@lists.denx.de>, <rockosov@gmail.com>, <kernel@salutedevices.com>
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print BCB block content
Message-ID: <20241011144519.xukl22ksrjsqz55l@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
 <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
 <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
 <17FD1697482D61A4.19251@groups.io>
 <87bjzqhg7g.fsf@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <87bjzqhg7g.fsf@baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.226.150]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188387 [Oct 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/11 13:07:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/11 13:07:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/11 09:57:00 #26735895
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2474

Hello Mattijs,

On Fri, Oct 11, 2024 at 04:22:43PM +0200, Mattijs Korpershoek wrote:
> Hi Dmitry,
> 
> On jeu., oct. 10, 2024 at 14:17, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
> 
> [...]
> 
> >>> > >
> >>> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> >>> > >
> >>> > > Can you also update the test?
> >>> >
> >>> > I apologize, but I didn't quite understand your point. Could you please
> >>> > clarify? This patch series includes additional tests for the 'ab_dump'
> >>> > subcommand. For more details, please refer to:
> >>> >
> >>> > https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/
> >>> 
> >>> OK, thank you. Sometimes it is easier (for reviewers) if you update
> >>> the test in the same commit.
> >>
> >> Should I resend the patch series with ab_dump implementation and tests
> >> in the same commit?
> >>
> >> I can prepare new version, if needed, no problem.
> >
> > No need to resend a new version just for this, since it's already
> > been reviewed.
> >
> > Keep the suggestion in mind for future series!
> 
> If you do need to re-spin this as v4, you can squash the test commit
> with this one if you wish.

Of course, I can re-spin that.
I believe I can save all RvB trailers during the squashing process.
Could you please clarify if my understanding is correct? 

-- 
Thank you,
Dmitry

