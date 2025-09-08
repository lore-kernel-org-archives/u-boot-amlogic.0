Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE07CA1013
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 08:12:12 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.7608.1757319122332616629
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Sep 2025 01:12:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=kbKuv4t7;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dea538b826so3436162f8f.2
        for <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757319121; x=1757923921; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxut2mr22fMNLLRFpScCkRI3WvncvzduqUsDFZJ917o=;
        b=kbKuv4t7OKDMidNDl3y7T1Ye2MhMkU+Wr1lszxnvOu2l3Oyb3soj8/2204BD4pXZl9
         iIHpqcKp4SVk4HLQRb1RGwtf3donjxs5JY7qDs4keQBkNkryuLUW1AHSZoDsfk5u0jsy
         F/7VRZCTg5XvJodhXoEfEHUdZABCjc11wHaOsURXf68fITygPyjenJpka82Uqta2Sfwl
         AoHxBE7f4BZHZSUgsAtVxa2NNBkbAvZUBeFcgG0DaJiWOORTl/wJmVbBb+wYwsMYJf92
         NnLmU3+ld5VXVgGI/aBVIEDQx24YZiPEcVqFSZF4W2NvFFpGKubFbo8oboHCoPBmWHKH
         Pp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319121; x=1757923921;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dxut2mr22fMNLLRFpScCkRI3WvncvzduqUsDFZJ917o=;
        b=AISQP8g07CD3LymbUxH3kz88eItnPqVobnaobsiKDKXzSZJsTUWhSIPMKIPEl/puPl
         Hk3HORFRNfg+Eh75Pj6odldYxybwBzHstmKEkUSOktmRffQuR6V9Hq8trcfDNYrHumOx
         ef39I+WoLnAAi3Xn0aBJ+bK9CFSSPwH+SXNUfm0NqqmhprzmgkPc9vo+kmTFNWUWgdNV
         Rno4isPKZeRn0bwyhih3MfF8c143+Tu7pTD49K31h8JcgEvtk/23cLhhI4cOPLZhNrmt
         EzgBCJJbpdc7pDivoq8+DprRmFX5qjP/uutLCPspkb/0vK+dt1JS7rVUZNuzZ+SkvAB9
         A7oA==
X-Forwarded-Encrypted: i=1; AJvYcCUC5DzLwkQBVXnUOD/au8GTIvhTLWzpmS/4aK42+BDj45c1yGmQw/ZL5gFMssjCxsy/5zk88NQX52o0WGtthQ==@groups.io
X-Gm-Message-State: AOJu0Yzof3HiB1lLaIYwrMDsaAMIb4p5cLg+zHxxH7QqXImSjz8tczLO
	AiHITqRQ4vATESwUDAOsyZCCGTUMIdVo2kqtCktBkXZblMNNOxmcn74zfe3sP4Ch6Tg=
X-Gm-Gg: ASbGncsWxZmQkgjVEkXnii+nVkasgDwBvcWfUeF0dEmWknh1SihB8BGlnNyi3dtSu3s
	CE44IcbBOIA63FXHGLOkzokDAciR3aP/8nwy2DQYBmz0YMMtLjhptkaGWHwGFN4DCEiW8yqzcoA
	3YCK3NfcLub0wm7XOKpNxZgTRE64OaDegfC1EbHlG7efZlodQvJTdG+IKBfb4UmE0t6khYi/wfO
	V+SJgzAaotD1CLJsOXrWoJDUWNkfedzd/1tX/GZPyCh2wvKQr2yDbD8cKebv4AIYYtFSGWci9ol
	/cfKie628kUfIWEXiMO/nZupDABiN29WfmBTqQ4rVrnlVt2VkBPmFNX5DK/NnsQ0/xULPiw1we7
	vAiQIrKHCFNroqH+fyPNxdwCxX6Wks/L4mBjBqMts5HBduhJarQ4QYiQA4NUg7e8mh7RG9mVBHO
	7WH2+yArLSwA==
X-Google-Smtp-Source: AGHT+IGbcjTrU8k26Mz7v0DR0hcSqrxSHpOMhC6jZ0m+ei0dgoXG1N+GIW6njo5BybsksmmQU+INlA==
X-Received: by 2002:adf:b350:0:b0:3e7:41ac:45f8 with SMTP id ffacd0b85a97d-3e741ac4939mr2933540f8f.55.1757319120653;
        Mon, 08 Sep 2025 01:12:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34493b8csm39799320f8f.59.2025.09.08.01.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:12:00 -0700 (PDT)
Message-ID: <199ecb7b-4c18-40fc-992a-af7535251112@linaro.org>
Date: Mon, 8 Sep 2025 10:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 08:12:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2754

On 07/09/2025 16:36, Ferass El Hafidi wrote:
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

Why is this needed ?

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


