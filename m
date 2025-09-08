Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7587CAC581
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 18:04:47 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
 by mx.groups.io with SMTP id smtpd.web11.1741.1757354684767826170
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Sep 2025 11:04:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=ne+WGkrN;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.170, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757354682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xiNM3VnV6D/E+QmcNisEYrhQvBPAjSm0U0VhVfSknY=;
	b=ne+WGkrNSR76eqr+ct3utJpR33V5NnPeN3VJRzVqhYeUss4A9zyMJg03YibvZ/m3dkM2rb
	sCiwcvlNr80lHw3FvQ33IErol8bIWBdnz73lfCdUI5nzXyax5x5fvblXnF7+NVAlaVqJJJ
	+EvY1A8zOWeMtk9hffS7KvrXQwbWuD9wxKfC2f8jPiJKtKRYx7QjQdvmTH3/vARjPxMINO
	XdBUekbquJmIHNaz71L9AYXDoRThqAXL6ZFBCJnlYJihedPvciDwD+XPnQ0mpa7al30v+w
	/NSROvVolDUK2Or9wp9Cjv+tKzxC0U2zjDjNUeEygEMqO8YiMAv8M1HB6HCcCw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 18:04:41 +0000
Message-Id: <DCNM8RIX4GOC.2QL9I19VMJQXW@postmarketos.org>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: <u-boot-amlogic@groups.io>, <neil.armstrong@linaro.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <199ecb7b-4c18-40fc-992a-af7535251112@linaro.org>
In-Reply-To: <199ecb7b-4c18-40fc-992a-af7535251112@linaro.org>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 18:04:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2760

On Mon Sep 8, 2025 at 8:11 AM UTC, Neil Armstrong via groups.io wrote:
> On 07/09/2025 16:36, Ferass El Hafidi wrote:
>> It is very limited and minimal, only implements putc/puts.
>> This minimal driver is intended to be used in SPL, and other
>> size-constrained situations.
>>=20
>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>> ---
>>   drivers/serial/serial.c       |   2 +
>>   drivers/serial/serial_meson.c | 112 ++++++++++++++++++++++++++++++++++=
+++++++-
>>   2 files changed, 113 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
>> index e10ca6eef768502ea32bf39a41ae2e3ccd168c66..c0b1eb3056181b95e1861f1c=
e08fcd82ff81eb71 100644
>> --- a/drivers/serial/serial.c
>> +++ b/drivers/serial/serial.c
>> @@ -129,6 +129,7 @@ serial_initfunc(pxa_serial_initialize);
>>   serial_initfunc(smh_serial_initialize);
>>   serial_initfunc(sh_serial_initialize);
>>   serial_initfunc(mtk_serial_initialize);
>> +serial_initfunc(meson_serial_initialize);
>>  =20
>>   /**
>>    * serial_register() - Register serial driver with serial driver core
>> @@ -167,6 +168,7 @@ int serial_initialize(void)
>>   	smh_serial_initialize();
>>   	sh_serial_initialize();
>>   	mtk_serial_initialize();
>> +	meson_serial_initialize();
>>  =20
>>   	serial_assign(default_serial_console()->name);
>>  =20
>> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson=
.c
>> index bb79b9729579a661084425d6b3c5357da31dc3c0..981ea5e159062b7d13885325=
e17b833145281158 100644
>> --- a/drivers/serial/serial_meson.c
>> +++ b/drivers/serial/serial_meson.c
>> @@ -3,9 +3,11 @@
>>    * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
>>    */
>>  =20
>> +#if CONFIG_IS_ENABLED(DM_SERIAL)
>>   #include <dm.h>
>> -#include <errno.h>
>>   #include <fdtdec.h>
>> +#endif
>> +#include <errno.h>
>>   #include <linux/kernel.h>
>>   #include <linux/bitops.h>
>>   #include <linux/compiler.h>
>> @@ -51,6 +53,7 @@ struct meson_serial_plat {
>>   #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud =
rate register) */
>>   #define AML_UART_REG5_BAUD_MASK		0x7fffff
>>  =20
>> +#if CONFIG_IS_ENABLED(DM_SERIAL)
>>   static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>>   {
>>   	/*
>> @@ -245,6 +248,113 @@ U_BOOT_DRIVER(serial_meson) =3D {
>>   	.plat_auto	=3D sizeof(struct meson_serial_plat),
>>   };
>>  =20
>> +DM_DRIVER_ALIAS(serial_meson, amlogic_meson_gx_uart);
>
> Why is this needed ?
>

Hmm, probably leftover from some other thing I was trying to do.  I'll
remove that for the next revision.

>> +
>> +#else
>> +
>> +static int meson_serial_init(void)
>> +{
>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(DEBU=
G_UART_BASE);
>> +	u32 val;
>> +
>> +	val =3D readl(&uart->control);
>> +	val |=3D (AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
>> +	writel(val, &uart->control);
>> +	val &=3D ~(AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
>> +	writel(val, &uart->control);
>> +	val |=3D (AML_UART_RX_EN | AML_UART_TX_EN);
>> +	writel(val, &uart->control);
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_serial_stop(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void meson_serial_setbrg(void)
>> +{
>> +}
>> +
>> +static void meson_serial_putc(const char ch)
>> +{
>> +	struct meson_uart *uart =3D (struct meson_uart *)CONFIG_VAL(DEBUG_UART=
_BASE);
>> +
>> +	/* On '\n' also do '\r' */
>> +	if (ch =3D=3D '\n')
>> +		meson_serial_putc('\r');
>> +
>> +	while (readl(&uart->status) & AML_UART_TX_FULL)
>> +		;
>> +
>> +	writel(ch, &uart->wfifo);
>> +}
>> +
>> +static void meson_serial_puts(const char *s)
>> +{
>> +	while (*s)
>> +		meson_serial_putc(*s++);
>> +}
>> +
>> +static int meson_serial_getc(void)
>> +{
>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(DEBU=
G_UART_BASE);
>> +	uint32_t status =3D readl(&uart->status);
>> +
>> +	if (status & AML_UART_RX_EMPTY)
>> +		return -EAGAIN;
>> +
>> +	if (status & AML_UART_ERR) {
>> +		u32 val =3D readl(&uart->control);
>> +
>> +		/* Clear error */
>> +		val |=3D AML_UART_CLR_ERR;
>> +		writel(val, &uart->control);
>> +		val &=3D ~AML_UART_CLR_ERR;
>> +		writel(val, &uart->control);
>> +
>> +		/* Remove spurious byte from fifo */
>> +		readl(&uart->rfifo);
>> +		return -EIO;
>> +	}
>> +
>> +	return readl(&uart->rfifo) & 0xff;
>> +}
>> +
>> +static int meson_serial_tstc(void)
>> +{
>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(DEBU=
G_UART_BASE);
>> +	uint32_t status =3D readl(&uart->status);
>> +
>> +	if (status & AML_UART_RX_EMPTY)
>> +		return 0;
>> +	return 1;
>> +}
>> +
>> +struct serial_device meson_serial_device =3D {
>> +	.name	=3D "meson_serial",
>> +	.start	=3D meson_serial_init,
>> +	.stop	=3D meson_serial_stop,
>> +	.setbrg	=3D meson_serial_setbrg,
>> +	.getc	=3D meson_serial_getc,
>> +	.tstc	=3D meson_serial_tstc,
>> +	.putc	=3D meson_serial_putc,
>> +	.puts	=3D meson_serial_puts,
>> +};
>> +
>> +void meson_serial_initialize(void)
>> +{
>> +	serial_register(&meson_serial_device);
>> +}
>> +
>> +__weak struct serial_device *default_serial_console(void)
>> +{
>> +	return &meson_serial_device;
>> +}
>> +
>> +#endif
>> +
>>   #ifdef CONFIG_DEBUG_UART_MESON
>>  =20
>>   #include <debug_uart.h>
>>=20
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2754): https://groups.io/g/u-boot-amlogic/message/275=
4
> Mute This Topic: https://groups.io/mt/115113901/8399868
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [funderscore@postma=
rketos.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


