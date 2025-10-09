Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE6ACCD187
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 09:12:16 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
 by mx.groups.io with SMTP id smtpd.web11.7687.1760001132636562367
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Oct 2025 02:12:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=aaTGshKb;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.177, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1760001130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veUkMAsdpUe1n46IKzIOjAlYwK1WBCV8N8nhTOQE+GE=;
	b=aaTGshKbq8TsubWBq5DdIHtz2Qp2YIcZUg/tfXFiSM+SRK9gtGDxnngJnYouWmO+sg41gg
	YrK0KLnjkKFougSpKA3KClOf+Wko88GqMGmekf/ivp190j5Sn5ocKwQM9gPnMV7pTL8LzH
	nXRGpv7rBrSF+/IZXJ/w3AP1lv0sSysGtczxO0LLFgdbaG2y7QnEeL4p9YQfyYt6620aQX
	e5IErYCnwczTj+U/4xezVyu3WC03uS31uxuCfTQIbBkqoLi5w0rNGa2SIwf3XbAE1sRkI9
	rgRP0n1iSUaqCR7SQdbOWVDiPUHRAnkoDIZKSzRR/iA4m0EjE+FoOwBQoLcr9A==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 09:12:07 +0000
Message-Id: <DDDOBW6QZ0IP.3EDF7J3OH4FJS@postmarketos.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Yao Zi" <ziyao@disroot.org>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>, "Tom Rini" <trini@konsulko.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Peng Fan" <peng.fan@nxp.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino Galvani"
 <b.galvani@gmail.com>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH RFC v3 2/8] mmc: meson_gx_mmc: add minimal non-DM driver
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
 <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org> <aOd73MIbAhvilmWK@pie>
In-Reply-To: <aOd73MIbAhvilmWK@pie>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Oct 2025 09:12:16 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2805

On Thu Oct 9, 2025 at 9:09 AM UTC, Yao Zi wrote:
> On Wed, Oct 08, 2025 at 10:00:38AM +0000, Ferass El Hafidi wrote:
>> Add a minimal non-DM MMC driver for use in size-constrained
>> environments.
>>=20
>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>> ---
>>  arch/arm/include/asm/arch-meson/gx.h |  5 +++
>>  drivers/mmc/meson_gx_mmc.c           | 75 +++++++++++++++++++++++++++++=
++++++-
>>  2 files changed, 79 insertions(+), 1 deletion(-)
>>=20
>> --- a/drivers/mmc/meson_gx_mmc.c
>> +++ b/drivers/mmc/meson_gx_mmc.c
>
> ...
>
>> +#if !CONFIG_IS_ENABLED(DM_MMC)
>
> This is a large conditional compilation block with nested #if's, do you
> think commenting #else and #endif with the condition improves the
> readibility? i.e.
>
> 	#if !CONFIG_IS_ENABLED(DM_MMC)
>
> 	...
>
> 	#else /* !CONFIG_IS_ENALBED(DM_MMC) */
>
> 	...
>
> 	#endif /* CONFIG_IS_ENALBED(DM_MMC) */
>

Sounds good to me, thanks for the suggestion.

Best regards,
Ferass

