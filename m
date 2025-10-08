Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC94FCCA472
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 13:31:15 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.16064.1759930271782430710
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 06:31:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=KXezGw42;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2e363118so67759225e9.0
        for <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759930270; x=1760535070; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDh0lRX8+hZOTqS5Bp2oT/xfNgwI1WJoX/Z+c1xFIMg=;
        b=KXezGw42TaCcjppOwVnT6WiC6NYCI3Hto5YSgJDCrHX5E8qViRqy9rMQOYHYRpwCD/
         Vp97OPIfIVEZ4iMBBvoMHx17Wp/uuD+ch9GFyGGw4Kcd/q1fZCC8f0Vf1lWv4VTmgTDc
         aWKzphvRBIJd+zqqUx/6W9XRav6joBN3DvZ4EYmKAPIb0pJXDTpogB8IWXEDjQDVNb9B
         glKYqmOZmGCW7oIxoWagzENqUWM3X1g1d+4WNMg11StHm5eWEQynQIG8lMKr2dM66ror
         xvRP8POXOZmwncWvaeieSNGAgP6moGHjBZh7kH1WqbvDq8I2YNmZWbBWGV8xqY3phPlU
         eVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930270; x=1760535070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oDh0lRX8+hZOTqS5Bp2oT/xfNgwI1WJoX/Z+c1xFIMg=;
        b=wgUMhFpse9za2mBOzOklCvMEPA2EDg64KUFXLIzWWEYMFTUdIAZn9jhgqOmSOa8An8
         79vlMupvfZ7U6fV+tkbWjpIUCCzGYkiQLQ303SZos66HA4hhyQqP+c9aNyIx4rrOEGj2
         XslqVH0XkEv1/DdOMPSkJ7E0KoHnwVi3AGM5sHIo5f/sZNkd9q5O/bAz9k7ebeeZr5St
         35q1uCKPDSL3JiAq6hBeJymbYaYkcmiSZIpZgOXYqIO6IbHskp4WNmhyJaUuq0TlFGdO
         rLEWYSiHkXuxpu/fLwJbW8+tC87OLp7XbYYS16/mxrmX7W24Nlg2ZAbnqOFBsvwOg2rq
         Ig3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaNciulCPmyRXv5Gmp3hxeKXAUSLtjiZNOBv7JGYaiwwMmOYcOB+vwB6jrclxnkq9GOKZ4l/nid+FvUzvaew==@groups.io
X-Gm-Message-State: AOJu0YyQZa42/8bXDb3mChuxwV2EilSq7Kav2mjBG0m1N2zklM8Z8bJ/
	rEGa7OM/W4e8mPxPxC/NAc+blek+Rlz1xajhNSjyarEdJf6WBmaOJX3LSrhZlAbM+Sw=
X-Gm-Gg: ASbGncuLAS50mEP9/2VEb9FCQuiAEi+WpFtldvuVOx/S7ZMZ4CjVN5mz97k1ZXDze0/
	ZTKLr14qCmnOM4G9MiudH8DQKf1BZOOOXOc/jKxKrZEgZqIABK2KaUossQlAQWPuaw1IIJUvPTb
	QJVK4zCPaLBroKK3qL4Q6vAgQxI+w8f6mSGjzgEeDFfnprvFcc37CavWgjFg6lVAj8BmVHdKJfy
	1TmhpomwRUa1hJfzXZQ4PDcunmGzuUNxFsPBBv9JCKDInV8R2e2bMjqGo7XTHQRQqeILpm1K0E+
	n12RMGJBdhp8t6Eflf8ea/Oh2Qh1c9OakXVZf+qaeybd6kuN+3gFdsIIeFkj6CMoWF1geUrolFk
	c3iSo9lzgakM7Z+aE97BLy8oni/qtqy9Ch+qqJTvGvEBtvWavT0HBO0BuZAZ3sQ1NbMQ2lf1OuZ
	fKpBwMC9XZCMRzxL3JmLg=
X-Google-Smtp-Source: AGHT+IEiVSoC0qkB4ss4tHl06E/3yzS/aomHsh77+KTpAKRlZq0pW/04ZpCkvA8bBQqWd21fpejApQ==
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-46fa9b11794mr21038735e9.37.1759930269893;
        Wed, 08 Oct 2025 06:31:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b264:afbc:dee:3d? ([2a01:e0a:3d9:2080:b264:afbc:dee:3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9b622cdsm38082805e9.0.2025.10.08.06.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:31:09 -0700 (PDT)
Message-ID: <9ca9f483-16dc-462b-93bf-22197e890886@linaro.org>
Date: Wed, 8 Oct 2025 15:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v3 3/8] serial: serial_meson: add minimal non-DM
 driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
 <20251008-spl-gx-v3-3-5999637df4b9@postmarketos.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251008-spl-gx-v3-3-5999637df4b9@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 13:31:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2800

On 10/8/25 12:00, Ferass El Hafidi wrote:
> It is very limited and minimal, only implements putc/puts.
> This minimal driver is intended to be used in SPL, and other
> size-constrained situations.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   drivers/serial/serial.c       |   2 +
>   drivers/serial/serial_meson.c | 119 +++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 120 insertions(+), 1 deletion(-)
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
> index bb79b9729579a661084425d6b3c5357da31dc3c0..cc71381f87e1e2d192e5f4450f881c2a69511ca3 100644
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
> @@ -25,6 +27,15 @@ struct meson_serial_plat {
>   	struct meson_uart *reg;
>   };
>   
> +#if !CONFIG_IS_ENABLED(DM_SERIAL)
> +/* UART base address */
> +#if defined(CONFIG_MESON_GX)
> +#define AML_UART_BASE	0xc81004c0
> +#else /* G12A, AXG, ... */
> +#define AML_UART_BASE	0xff803000
> +#endif
> +#endif
> +
>   /* AML_UART_STATUS bits */
>   #define AML_UART_PARITY_ERR		BIT(16)
>   #define AML_UART_FRAME_ERR		BIT(17)
> @@ -51,6 +62,7 @@ struct meson_serial_plat {
>   #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
>   #define AML_UART_REG5_BAUD_MASK		0x7fffff
>   
> +#if CONFIG_IS_ENABLED(DM_SERIAL)
>   static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>   {
>   	/*
> @@ -245,6 +257,111 @@ U_BOOT_DRIVER(serial_meson) = {
>   	.plat_auto	= sizeof(struct meson_serial_plat),
>   };
>   
> +#else
> +
> +static int meson_serial_init(void)
> +{
> +	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
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
> +	struct meson_uart *uart = (struct meson_uart *)AML_UART_BASE;
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
> +	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
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
> +	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

