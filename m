Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F1DCDB474
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 14:15:21 +0000 (UTC)
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
 by mx.groups.io with SMTP id smtpd.web11.120262.1698066272729239497
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Oct 2023 06:04:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@protonmail.com header.s=protonmail3 header.b=f1mBsEG1;
 spf=pass (domain: protonmail.com, ip: 185.70.40.137, mailfrom: vitali64pmemail@protonmail.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1698066270; x=1698325470;
	bh=b41fpmOLMejtMudFXqGrokeQunLrrGSg1PsEeiuZVU0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=f1mBsEG10JdNzUwta7xLunhMJJD/skQyfHq4D+lQzdxvsNzg5oClf091Fr6BCtjHc
	 GkJKDHPlH72tKRzwHdhp4GtlYFp1C6LJWszzyZCPK6NZTmmsEiwmH9RnRSENiPFao8
	 S2MZh+kUr8YtK1PKou4WzruKNvKiiY+tgIUkWryyp9OdSsHiTzBRu0ohqFu5mD2r7J
	 9EUuSz647CuZXjT88fV6grQ2lBl+up/kMD5Tlcfdtob4xx2BupChE0DVhyhh9Yr5aB
	 hI3w5UNPm/PN93OqPmT9CYSQHDGTO5Io2QH/+TyWMf4jOdFrJCpP5tp6hDxnohjCDO
	 RLMakgf34CZ4g==
Date: Mon, 23 Oct 2023 13:04:11 +0000
To: neil.armstrong@linaro.org
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, christianshewitt@gmail.com, adeep@lexina.in, b.galvani@gmail.com
Subject: Re: [PATCH 0/4] ARM: meson: Add boot over DFU RAM as an USB boot step
Message-ID: <CWFU8EKJU032.2QE09681ITNVJ@protonmail.com>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 14:15:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1794

Hi,

> Add boot over DFU RAM as an alternate to running script at
> a fixed address like done today.
>
> The main culprit is that it's not possible to do that
> on G12A/SM1 platforms due to changes in the USB boot protocol.
>
> With this, U-Boot will present a DFU device with a ram slot where
> the Host could write a fitImage or legacy U-Boot image, then with the
> detach command boot will continue trying to boot the uploaded image.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Nice to see this! Next step would be to have this in U-Boot SPLin
Amlogic SoCs in the future. I'm tempted to implement this in my tree
before sending SPL support for (some) Amlogic SoCs upstream.

Cheers.


