Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07175C3ABC0
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 16:22:06 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
 by mx.groups.io with SMTP id smtpd.web11.276.1746721315952933872
 for <u-boot-amlogic@groups.io>;
 Thu, 08 May 2025 09:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=JGumOdy5;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.170, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1746721313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HF3qtxM4GkzT4fveHtK2OKQDWeTf7B0vIqVn8VNER5A=;
	b=JGumOdy5Jtv+kWoz7HuxgXYP8LmUdY8CCioAcz7CKXSlPEem1Ium//58jz77RwsZoaesS6
	T6Mo8tTiK0MVH/Hnalc7XrrXJyi33p8nHK3fDO4foDRahyi+KUYPNxjpAosfe0qUQnusTR
	D/m6AXdmMHUcGIfAvun52sDsD9yLeghFWm/jo/g3CFHphwJy6U7ClmGJ6tfa9xrouKGnBX
	bz+n3A95mvzcyhg235MNh38dfWs4ypRLe53WNyT0uboi0+z6fMmBDkmzA92AiNrgDt4vXt
	B2tU2UbvI3Gu4aNRVfk5RC4rMF+f88OAnAzgKm3ukx8cbmdkyinYfRAPbfl/tA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 May 2025 16:21:20 +0000
Message-Id: <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <u-boot@lists.denx.de>, "u-boot-amlogic@groups.io"
 <u-boot-amlogic@groups.io>, "linux-amlogic@lists.infradead.org"
 <linux-amlogic@lists.infradead.org>
To: "Wayne Schroeder" <raz@chewies.net>, "Neil Armstrong"
 <neil.armstrong@linaro.org>
Subject: Re: Odroid n2+ usb broken on reboot
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com> <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com> <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org> <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
In-Reply-To: <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 May 2025 16:22:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2674

On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> It's hard for me to quantify if usb works in u-boot as I'm not loading
> off of any usb storage devices.  It certainly never lets me use the
> keyboard to abort auto boot, and never has.  On reboot, to reliably

You can send bytes via UART to abort boot, if you happen to have a UART
adapter around.

