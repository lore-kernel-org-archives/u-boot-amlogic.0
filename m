Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B0ACAC58F
	for <webhook@archiver.kernel.org>; Sun, 14 Sep 2025 12:24:08 +0000 (UTC)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
 by mx.groups.io with SMTP id smtpd.web10.8384.1757852644167594354
 for <u-boot-amlogic@groups.io>;
 Sun, 14 Sep 2025 05:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=iEGR++Or;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.186, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757852642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbJb38WU3tO7kUGJwBpvRDPP1Fe4TJZcvMNUncxM2gU=;
	b=iEGR++OroNxaQYxbWB9OFCPCoX9OkzQzDnDGKNs1mexetml+pUXyxm8RwZyT6n91h0H6Ji
	2dqn8ohy441Nzjd20b2bam4l6ljat2SojA4bLudHUxr8XcFOR5hZWc2Xqisythym35S4R2
	NzvHXWfzC8718VvcGSCLF0ja4W9i6c3nVm4jVscEkrLzLjJpSE3Xm08xfosFJX8oz7YmC1
	7L3JXDjum2qzHhJJWZ6mbhfJvw99cqb19vaD8//WlcSKEH8O0AjMwgnlm2yZRYOH4+j7YL
	YlnA/LiXu/oBlEf78bWSTAo62Mnyv7VqBzcCRgSd/O0kGPxDVhM6+b98A/OHRw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 12:23:58 +0000
Message-Id: <DCSIR5UWG23F.17XD45AIS72TP@postmarketos.org>
To: "Simon Glass" <sjg@chromium.org>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>
Cc: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, <u-boot@lists.denx.de>,
 <u-boot-amlogic@groups.io>, <~postmarketos/upstreaming@lists.sr.ht>, "Tom
 Rini" <trini@konsulko.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Beniamino Galvani" <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
 <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
 <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
 <CAFLszTjxY6c0unXvdcjC36hhpB-BwxM_FcgpRdkXBa+V3GynvQ@mail.gmail.com>
In-Reply-To: <CAFLszTjxY6c0unXvdcjC36hhpB-BwxM_FcgpRdkXBa+V3GynvQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 14 Sep 2025 12:24:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2783

On Fri Sep 12, 2025 at 11:41 PM UTC, Simon Glass wrote:
> Hi Ferass,
>
> On Thu, 11 Sept 2025 at 09:37, Ferass El Hafidi
> <funderscore@postmarketos.org> wrote:
>>
>> On Wed Sep 10, 2025 at 8:30 PM UTC, Heinrich Schuchardt wrote:
>> > On 9/10/25 22:14, Ferass El Hafidi wrote:
>> >> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
>> >>> <...>
>> >>>> +static int meson_serial_getc(void)
>> >>>> +{
>> >>>> +  struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VA=
L(DEBUG_UART_BASE);
>> >>>> +  uint32_t status =3D readl(&uart->status);
>> >>>> +
>> >>>> +  if (status & AML_UART_RX_EMPTY)
>> >>>> +          return -EAGAIN;
>> >>>> +
>> >>>> +  if (status & AML_UART_ERR) {
>> >>>> +          u32 val =3D readl(&uart->control);
>> >>>> +
>> >>>> +          /* Clear error */
>> >>>> +          val |=3D AML_UART_CLR_ERR;
>> >>>> +          writel(val, &uart->control);
>> >>>> +          val &=3D ~AML_UART_CLR_ERR;
>> >>>> +          writel(val, &uart->control);
>> >>>> +
>> >>>> +          /* Remove spurious byte from fifo */
>> >>>> +          readl(&uart->rfifo);
>> >>>> +          return -EIO;
>> >>>> +  }
>> >>>> +
>> >>>> +  return readl(&uart->rfifo) & 0xff;
>> >>>> +}
>> >>>> +
>> >>>> +static int meson_serial_tstc(void)
>> >>>> +{
>> >>>> +  struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VA=
L(DEBUG_UART_BASE);
>> >>>
>> >>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=3Dy and
>> >>> CONFIG_SPL=3Dy. Shall all configurations depend on CONFIG_DEBUG_UART=
=3Dy?
>> >>>
>> >>> Creating this dependency does not look right to me.
>> >>>
>> >>
>> >> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remo=
ve
>> >> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
>> >> right.
>> >
>> > We should avoid the possibility of build failures for changed configur=
ation.
>> >
>> > Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
>> > or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?
>>
>> Then it might be best to not use DEBUG_UART_BASE.  I'll fix that for
>> next revision.  Thanks!
>
> I've been thinking about doing something about a minimal UART (and
> i2c) for a while.
>
> Before driver model we just called serial_putc() and *the* serial
> driver would handle it. Can we do something similar here?
>
> My suggestion for an API:
>
> CONFIG_SERIAL_ONE to indicate that driver model is not used for serial
>
> Then in serial-uclass.c update serial_putc() to use that config and
> call serial_one_putc(int ch), with that function being defined in the
> only serial driver that is compiled in. Update serial_init() to call
> serial_one_init().
>
> That way we keep things compatible with driver model and avoid
> building on the old serial.c
>
> This is similar to how the debug UART, but the debug UART is special.

Sounds good to me, I'm excited to see a very minimal serial driver API
that doesn't rely on the legacy API, while still being small enough for
SPL.

>
> Regards,
> Simon

