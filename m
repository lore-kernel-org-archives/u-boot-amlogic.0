Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25F5CCA472
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 13:55:35 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by mx.groups.io with SMTP id smtpd.web10.16896.1759931727187878719
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 06:55:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=bLbGCR0+;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.181, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759931724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4kdW0j8LfTg3/6ZMEyqCTLeKN8L2vip3D9WboqmA3s=;
	b=bLbGCR0+nTux5t/OfvomDbPUbOgX0k+ynmvrqsOdaN+GbbMAYLAW+QgAnUhlvZyeyx2bJx
	9LRGezVQge/ba7D9huiyToGxhTzR9t/RLBTw+HndAgLULqo1Kqp9onzQU8sgfY2pJGP2uf
	MJWdJlqTdUAfHvf87YJEXkgc85IogCMXcSzur2N6vnZHB73gP9s+TfrxWq+KS75MD380/s
	uEjeEz3qmWPkK3FEfaAfY8UQFcki4VrdkGWYzVUMbzizAO/pJ9TX/CIIx7mws8SROR5Dh8
	G1IF2SN3LvEAKEaDF7VAp1G6RUeRmEn8Y62Xl0hlzNvWjkLcYQGLwV9vCLY2fg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 13:55:22 +0000
Message-Id: <DDCZQ7W6SBTB.11KBGFR01N96M@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH RFC v3 2/8] mmc: meson_gx_mmc: add minimal non-DM driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>, "Tom Rini" <trini@konsulko.com>, "Peng Fan"
 <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino
 Galvani" <b.galvani@gmail.com>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
 <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org>
 <d6b85855-f55e-4699-875c-86cf0200011b@linaro.org>
In-Reply-To: <d6b85855-f55e-4699-875c-86cf0200011b@linaro.org>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 13:55:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2803

On Wed Oct 8, 2025 at 1:33 PM UTC, Neil Armstrong wrote:
> <...>
>> @@ -67,7 +69,7 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>   	 * Other SoCs use CLK_CO_PHASE_180 by default.
>>   	 * It needs to find what is a proper value about each SoCs.
>>   	 */
>> -	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
>> +	if (IS_ENABLED(CONFIG_MESON_SM))
>
> I'm not a fan of that, technically while we keep the socs separated the
> driver should be generic and not rely on the soc config.
>
> I'k ok to have it in non-DM, but in DM it should still use meson_gx_mmc_i=
s_compatible().
>

I'll drop this for next revision then. Shouldn't change anything
anyway, given SPL uses non-DM.

Best regards,
Ferass

