Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E812CCAC594
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 12:15:29 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by mx.groups.io with SMTP id smtpd.web10.28797.1757534027621248434
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 12:53:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@canonical.com header.s=20210705 header.b=uq+HSgxH;
 spf=pass (domain: canonical.com, ip: 185.125.188.122, mailfrom: heinrich.schuchardt@canonical.com)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90D8F3F491
	for <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757534023;
	bh=zAirtni7BJeRkch+LX/5dEkgb7GPmYDDfSa71Lf5AFA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type;
	b=uq+HSgxHFpaC0T4YPstWaJnm4mzBv7jVbr+CxZQGzqj9j99Z75ZYAIrdu/wDSXdHz
	 7yB+ozqJkR4PBnMoLCM3OhfdzMn/zRLN/br6KjfIZrLw04sTUYPdAwPNl9KA+a9Zdo
	 QRBqVS1p6Ah73f6y+ANyBpT2TOZrmEIwNTYDUlkMu+2MV4DhnP8Pim/ygnp7CdQg12
	 Ee2RaltuDy7G4KRVqi3TuQvIgy8mUHYhS7ZaZ9vgGobO/VuQUwlUeOMZyl7Y3JMKqi
	 1a3vKtu+H2c4JE8TEKMpAjmx+kw2Z+umTD9/Lbh7BlciKDVgnmK/mBfP/LqMWSS26v
	 lnbRvHau/mHoQ==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e3b77972cbso5995f8f.1
        for <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 12:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757534023; x=1758138823;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAirtni7BJeRkch+LX/5dEkgb7GPmYDDfSa71Lf5AFA=;
        b=xD6KVQSoIZaBegsHXXrFcR5+Zpp8TDPs5lg6eULcZdhvuiLImWv+lOLgvPCi7yjZDH
         gV4gRkCxVeBm1vt8RHiCBIKs6VxSUGgkgznPO26CMYSnN7mYwN9eD/qXoXtiICOLv4Bp
         CFr5Wdj0eMM2LeExa/fiCGdYBAZKo9e2/Ig5Pp9jQZKjayigt0fExM9MjSElLsbIRBG5
         9C0W/BMD79Zosxk7NerfORsz4TLWvacSHOaHU2rCuete7DchTbFitNuImmckcdRmWx0o
         NcoNvEPcS44keCV7jUSFGlebwD0mG3C9IBZ/xzlh9i4E48xGdR1NCJZrFzmzumUpBOCF
         AAzw==
X-Forwarded-Encrypted: i=1; AJvYcCUS76DJtHkhDt9jWOD8Ar5kQsb8+2oEVdmkbK3zEph5cgLMh/XxvPwJffFbAgby6wKV6FAiJCBHbIv4fQbfDg==@groups.io
X-Gm-Message-State: AOJu0YwZok0EuMZuLsjtapTQJsQwRrZGWmeiJspEKk3cm4nIk/oiTEBF
	iMQk3oCSU1cmrGufiFZmh+/1UYR0LA8JEgIuM6Yw/o3sK/x8ue5lgKEVKLLx7sZH4GaHmhC2Vcv
	TeGvdTAuAH2xSQxkcBXEKpMXKD3fcB9RcCrnKYZJGdkSxhLbjcuueuBPCYwj2wRdPL5wx87gadR
	B4
X-Gm-Gg: ASbGncvR2RRl5Tw5bvmClXJ796t7blXSQqUReVFAR640SI/0q+WKfXo3fFiFXtbtjvK
	vbj16J6HzckmGI2m0bSa6d8zBs1os/Dt5hCxeq5HPU5u3zmJHAYmXuoS7jry8hHnEs6D/3pw0ak
	nfbkkVQzfAFn/vfaAm7hUK3+Ju7364TvAVB+LPc1Ik509jTGx9Irq+EvRw8JEeAL+N0cAiV6CXk
	C172jevA9l8eGieTiLFH6dh5aWxiFyxgHssRfICzv0QgGBFlcnaxrB0X6oj4e9FYSIu4PTkfwUf
	n16WepZRN4liMI5CLo2jl/1XdaUqoiEYcbDeeFbu9WGA6BApFREe7vY/oqCghZa4N9w+Y+14mjf
	L41Er8eFvDltAUntVlKqdgl1EjJzMTkM=
X-Received: by 2002:a5d:5889:0:b0:3e0:6dbd:df8a with SMTP id ffacd0b85a97d-3e64c3b02c1mr13692541f8f.48.1757534023148;
        Wed, 10 Sep 2025 12:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFePEPIDNe7PNIE5/d1nER879pikTsHV0C3TxiDMbZw3cbmcyt22EchsgDueg+Qk7SWaXR48Q==
X-Received: by 2002:a5d:5889:0:b0:3e0:6dbd:df8a with SMTP id ffacd0b85a97d-3e64c3b02c1mr13692524f8f.48.1757534022753;
        Wed, 10 Sep 2025 12:53:42 -0700 (PDT)
Received: from [192.168.103.116] (dynamic-046-114-109-180.46.114.pool.telefonica.de. [46.114.109.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7522387acsm8024492f8f.40.2025.09.10.12.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 12:53:42 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
Date: Wed, 10 Sep 2025 21:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Sep 2025 12:15:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2779

On 9/7/25 16:36, Ferass El Hafidi wrote:
> It is very limited and minimal, only implements putc/puts.
> This minimal driver is intended to be used in SPL, and other
> size-constrained situations.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   drivers/serial/serial.c       |   2 +
>   drivers/serial/serial_meson.c | 112 +++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
> index e10ca6eef768502ea32bf39a41ae2e3ccd168c66..c0b1eb3056181b95e1861f1ce08fcd82ff81eb71 100644
> --- a/drivers/serial/serial.c
> +++ b/drivers/serial/serial.c
> @@ -129,6 +129,7 @@ serial_initfunc(pxa_serial_initialize);
>   serial_initfunc(smh_serial_initialize);
>   serial_initfunc(sh_serial_initialize);
>   serial_initfunc(mtk_serial_initialize);
> +serial_initfunc(meson_serial_initialize);
>   
>   /**
>    * serial_register() - Register serial driver with serial driver core
> @@ -167,6 +168,7 @@ int serial_initialize(void)
>   	smh_serial_initialize();
>   	sh_serial_initialize();
>   	mtk_serial_initialize();
> +	meson_serial_initialize();
>   
>   	serial_assign(default_serial_console()->name);
>   
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index bb79b9729579a661084425d6b3c5357da31dc3c0..981ea5e159062b7d13885325e17b833145281158 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -3,9 +3,11 @@
>    * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
>    */
>   
> +#if CONFIG_IS_ENABLED(DM_SERIAL)
>   #include <dm.h>
> -#include <errno.h>
>   #include <fdtdec.h>
> +#endif
> +#include <errno.h>
>   #include <linux/kernel.h>
>   #include <linux/bitops.h>
>   #include <linux/compiler.h>
> @@ -51,6 +53,7 @@ struct meson_serial_plat {
>   #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
>   #define AML_UART_REG5_BAUD_MASK		0x7fffff
>   
> +#if CONFIG_IS_ENABLED(DM_SERIAL)
>   static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>   {
>   	/*
> @@ -245,6 +248,113 @@ U_BOOT_DRIVER(serial_meson) = {
>   	.plat_auto	= sizeof(struct meson_serial_plat),
>   };
>   
> +DM_DRIVER_ALIAS(serial_meson, amlogic_meson_gx_uart);
> +
> +#else
> +
> +static int meson_serial_init(void)
> +{
> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> +	u32 val;
> +
> +	val = readl(&uart->control);
> +	val |= (AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
> +	writel(val, &uart->control);
> +	val &= ~(AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
> +	writel(val, &uart->control);
> +	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
> +	writel(val, &uart->control);
> +
> +	return 0;
> +}
> +
> +static int meson_serial_stop(void)
> +{
> +	return 0;
> +}
> +
> +static void meson_serial_setbrg(void)
> +{
> +}
> +
> +static void meson_serial_putc(const char ch)
> +{
> +	struct meson_uart *uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> +
> +	/* On '\n' also do '\r' */
> +	if (ch == '\n')
> +		meson_serial_putc('\r');
> +
> +	while (readl(&uart->status) & AML_UART_TX_FULL)
> +		;
> +
> +	writel(ch, &uart->wfifo);
> +}
> +
> +static void meson_serial_puts(const char *s)
> +{
> +	while (*s)
> +		meson_serial_putc(*s++);
> +}
> +
> +static int meson_serial_getc(void)
> +{
> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> +	uint32_t status = readl(&uart->status);
> +
> +	if (status & AML_UART_RX_EMPTY)
> +		return -EAGAIN;
> +
> +	if (status & AML_UART_ERR) {
> +		u32 val = readl(&uart->control);
> +
> +		/* Clear error */
> +		val |= AML_UART_CLR_ERR;
> +		writel(val, &uart->control);
> +		val &= ~AML_UART_CLR_ERR;
> +		writel(val, &uart->control);
> +
> +		/* Remove spurious byte from fifo */
> +		readl(&uart->rfifo);
> +		return -EIO;
> +	}
> +
> +	return readl(&uart->rfifo) & 0xff;
> +}
> +
> +static int meson_serial_tstc(void)
> +{
> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);

CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=y and 
CONFIG_SPL=y. Shall all configurations depend on CONFIG_DEBUG_UART=y?

Creating this dependency does not look right to me.

Best regards

Heinrich

> +	uint32_t status = readl(&uart->status);
> +
> +	if (status & AML_UART_RX_EMPTY)
> +		return 0;
> +	return 1;
> +}
> +
> +struct serial_device meson_serial_device = {
> +	.name	= "meson_serial",
> +	.start	= meson_serial_init,
> +	.stop	= meson_serial_stop,
> +	.setbrg	= meson_serial_setbrg,
> +	.getc	= meson_serial_getc,
> +	.tstc	= meson_serial_tstc,
> +	.putc	= meson_serial_putc,
> +	.puts	= meson_serial_puts,
> +};
> +
> +void meson_serial_initialize(void)
> +{
> +	serial_register(&meson_serial_device);
> +}
> +
> +__weak struct serial_device *default_serial_console(void)
> +{
> +	return &meson_serial_device;
> +}
> +
> +#endif
> +
>   #ifdef CONFIG_DEBUG_UART_MESON
>   
>   #include <debug_uart.h>
> 


