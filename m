Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA300CDB483
	for <webhook@archiver.kernel.org>; Thu, 19 Oct 2023 20:46:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.38968.1697748358734130036
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Oct 2023 13:46:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=riGTvay5;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 369D4120010;
	Thu, 19 Oct 2023 23:45:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 369D4120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697748355;
	bh=RAKKteZO90EjfHvaZR5wO63nnMnC+BwbsJYHHbcNS90=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=riGTvay5iq828Vp6nPZL0aVxzKcDIbaUYtgSsgt4ema8wd3ZBsPIGwBND103ME8QI
	 VuMahPK7VlVK0EsSwJMIYmeryhCOaTVW60uTTcHd6Es5grKyJ9+E1gYBRIK5ehYj1z
	 VcTZdvcKiQrPBDIASOSKKtwa9ri8r3iF5wh5VzNAbzcDoysnS7IXPGKpAcQpJBnIas
	 D/os5RFTczecNQW0bPJgS3FPx0+Gx5PND6lcLfli7FdHWlzVm/S55mTYn6WzHpDPnV
	 g6NPb4+HFOARvoZzJhceMGH6QKRRIjZmgg91iUOqZVvQ4m3/tsyINHbIRlPjeFz9vf
	 CzkLoIhIUG+gw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 19 Oct 2023 23:45:55 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 19 Oct
 2023 23:45:54 +0300
Date: Thu, 19 Oct 2023 23:45:53 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Simon Glass <sjg@google.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki
	<jagan@amarulasolutions.com>, <prusovigor@gmail.com>,
	<kernel@sberdevices.ru>, Igor Prusov <IVPrusov@sberdevices.ru>, Martin
 Kurbanov <mmkurbanov@sberdevices.ru>, <u-boot-amlogic@groups.io>,
	<u-boot@lists.denx.de>
Subject: Re: [RESEND PATCH v1 1/2] spi: add support for Amlogic A1 SPI Flash
 Controller
Message-ID: <20231019204553.sb2qij65h6qsszik@pc>
References: <20231017171733.3989-1-ivprusov@salutedevices.com>
 <20231017171733.3989-2-ivprusov@salutedevices.com>
 <CAPnjgZ06Le0qRukSRsCZ5CoKur6ciaCGGUnRpbfz7OQYzZaGBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ06Le0qRukSRsCZ5CoKur6ciaCGGUnRpbfz7OQYzZaGBA@mail.gmail.com>
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180745 [Oct 19 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 542 542 3d23828e213bab96daa5e52f9cef518f74e40214, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/19 19:07:00 #22234857
X-KSMG-AntiVirus-Status: Clean, skipped
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 19 Oct 2023 20:46:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1786

On Tue, Oct 17, 2023 at 09:33:02PM -0600, Simon Glass wrote:
> Hi Igor,
> 
> On Tue, 17 Oct 2023 at 11:18, Igor Prusov <ivprusov@salutedevices.com> wrote:
> >
> > From: Igor Prusov <IVPrusov@sberdevices.ru>
> >
> > Add A1 SPIFC driver from Linux. Slightly modified to use u-boot driver
> > framework and accommodate to lack of ioread32_rep/iowrite32_rep.
> 
> Well, you could bring them in!
> 
I was thinking about it, but I'd prefer to make a separate series with
it, if you don't mind. Need some time to figure out best way to
integrate them into u-boot and I'd like to take a look at other drivers
that could use those while I'm at it.

[...]

-- 
Best Regards,
Igor Prusov

