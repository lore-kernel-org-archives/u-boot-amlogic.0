Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2917C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:06:49 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
 by mx.groups.io with SMTP id smtpd.web11.18808.1742555202267695433
 for <u-boot-amlogic@groups.io>;
 Fri, 21 Mar 2025 04:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=kjOEsPpE;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.177, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1742555199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzlB10e7/cRMkh5JAfQQqNyhfRgwtpcP9T6THDKeTHQ=;
	b=kjOEsPpEd2s31RwKlP3eh+Olr92c2RVP1YtkcZ63fwLsN1yBGwDjiT0Vl4aHSOZvJhq07d
	/VpB9q+ckY/zwKiJ4wq99yo00C1GeXHkiW9Wrv3NKE+MEpkduvUPYBNOBm2dlUDX3t9ol7
	seIW5rxDCr5PXDHm5f/jUNixy/ufKtWrPcZW0Wkv2iLibAaq/zSY+CIGsqW2WALhGG32ve
	2L747DjujEFfWlCwERABKFqlLI9ET1xmTdT22/Vl330xHVXuEiMd4HHhfXpIe/44VTBgfp
	U2TVY/3TdcP3IYBcL3KeftxQJr4RLvU4zFgbV3p+x+FsmdCLWvXhQDfrVE/yYQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 11:06:10 +0000
Message-Id: <D8LW969044RD.26NPQM1ZK8FXP@postmarketos.org>
To: <u-boot-amlogic@groups.io>, <avkrasnov@salutedevices.com>, "Tom Rini"
 <trini@konsulko.com>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Dario
 Binacchi" <dario.binacchi@amarulasolutions.com>, "Michael Trimarchi"
 <michael@amarulasolutions.com>, "Lukasz Majewski" <lukma@denx.de>, "Mattijs
 Korpershoek" <mkorpershoek@baylibre.com>, "Marek Vasut" <marex@denx.de>,
 "Viacheslav Bocharov" <adeep@lexina.in>, "Sumit Garg"
 <sumit.garg@linaro.org>, "Simon Glass" <sjg@chromium.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Jerome Forissier"
 <jerome.forissier@linaro.org>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Vitaliy Vasylskyy" <vitaliy.vasylskyy@globallogic.com>
Subject: Re: [PATCH v1 00/11] Amlogic: ADNL and Optimus protocols support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <oxffffaa@gmail.com>
References: <20250319202045.1407-1-avkrasnov@salutedevices.com>
In-Reply-To: <20250319202045.1407-1-avkrasnov@salutedevices.com>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 21 Mar 2025 11:06:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2646

On Wed Mar 19, 2025 at 8:20 PM UTC, Arseniy Krasnov via groups.io wrote:
> This patchset adds support of two Amlogic firmware burning protocols:
> ADNL and Optimus. Each protocol is supported on the following SoC:
>
> axg, g12a, g12b, sm1 - Optimus.
> a1, s4, a5, c1, c2, c3, sc2, t3, t7, p1 - ADNL.
>

Out of curiosity, don't GXL and GXBB also support Optimus?  Or is it
completely different?

> Both work in fastboot manner, but significant feature is that they are
> supported by current Amlogic BootROMs. As transport both use USB:
> device is switched to gadget mode and then it can communicate with PC.
> On PC side protocols are supported by:
>
> 1) https://github.com/superna9999/pyamlboot (with some limitation)
>
>    For example:
>    pyamlboot/./ubt.py --img <image> --wipe all --reset
>
>    Note, image has special format, specific for Amlogic.

Awesome :)


Regards.

