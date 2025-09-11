Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B4CAC58E
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 15:37:22 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by mx.groups.io with SMTP id smtpd.web11.673.1757605032545402833
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Sep 2025 08:37:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=iUNsBYeu;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.181, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757605030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqXlA/qzOIG1EGvoEBH/emACYjf+DBvtfZOlUYJbEkQ=;
	b=iUNsBYeu8eyOKwZ8x0cg6IoIiU96zj7DQbqCo9dXuQME4snWAh066QmwB1pz1EFbQ6xnWf
	C04H7qe68ZpkIuOVw+zucQ/xT3DG7AiGnRZcgOxnla98qj6Eyd4noxq+GyMhxy7vc6n2+F
	xiB8WFmfAyD6NaUtq91Lw1U5ks9tbVmFBUZRtDkWJ5bGGG9oDOdOYuqrh3OZpVxln+gZ5r
	+FkqEsx35yUNFd05O3soAK6nH+hmEoBBCw2tLf4SSb3R4nPuEvZHhkP1MRpq/j+WSdyAF+
	q7VaZz636fJmasF6LrAcKf4bCZfiI2PGsCpwm4oCja7Hnd0ptTD2CnpJGz2XVA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 15:37:07 +0000
Message-Id: <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>, "Tom Rini" <trini@konsulko.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Peng Fan"
 <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino
 Galvani" <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Ferass El
 Hafidi" <funderscore@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
 <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
In-Reply-To: <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Sep 2025 15:37:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2781

On Wed Sep 10, 2025 at 8:30 PM UTC, Heinrich Schuchardt wrote:
> On 9/10/25 22:14, Ferass El Hafidi wrote:
>> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
>>> <...>
>>>> +static int meson_serial_getc(void)
>>>> +{
>>>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(DE=
BUG_UART_BASE);
>>>> +	uint32_t status =3D readl(&uart->status);
>>>> +
>>>> +	if (status & AML_UART_RX_EMPTY)
>>>> +		return -EAGAIN;
>>>> +
>>>> +	if (status & AML_UART_ERR) {
>>>> +		u32 val =3D readl(&uart->control);
>>>> +
>>>> +		/* Clear error */
>>>> +		val |=3D AML_UART_CLR_ERR;
>>>> +		writel(val, &uart->control);
>>>> +		val &=3D ~AML_UART_CLR_ERR;
>>>> +		writel(val, &uart->control);
>>>> +
>>>> +		/* Remove spurious byte from fifo */
>>>> +		readl(&uart->rfifo);
>>>> +		return -EIO;
>>>> +	}
>>>> +
>>>> +	return readl(&uart->rfifo) & 0xff;
>>>> +}
>>>> +
>>>> +static int meson_serial_tstc(void)
>>>> +{
>>>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(DE=
BUG_UART_BASE);
>>>
>>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=3Dy and
>>> CONFIG_SPL=3Dy. Shall all configurations depend on CONFIG_DEBUG_UART=3D=
y?
>>>
>>> Creating this dependency does not look right to me.
>>>
>>=20
>> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remove
>> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
>> right.
>
> We should avoid the possibility of build failures for changed configurati=
on.
>
> Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
> or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?

Then it might be best to not use DEBUG_UART_BASE.  I'll fix that for
next revision.  Thanks!

