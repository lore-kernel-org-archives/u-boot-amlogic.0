Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web11.17335.1595333112924672181
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Jul 2020 05:05:13 -0700
Received: by mail-wr1-f65.google.com with SMTP id f2so20916336wrp.7
        for <u-boot-amlogic@groups.io>; Tue, 21 Jul 2020 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Ye9bYcOFM9MBekDfwGPs9b2QEZtK64o2EFfPj/QJtMQ=;
        b=AY781T/gwT+RwqKGsdoSLTSbHimxQGWhJQujkRyUDkJrGv7JDpQsH3x3VWqn6ab5uN
         G2f0KOGaeFmfGAyFhZfnXLElm5NGVzZ3onxzxYOdBAjRRfQUWMaziQlDjWUnKpzyT4Hp
         1P3JJ7LLOyvdOoP06N1+kUHVIjHnMd2MDhJ2TvxA0no64h39kpXx3LF134UQDMMONACm
         gCDy8IIoo708MOcRWv0k1qXaTf2iRXKtUwwYPSMSCM/JdLLYtCllNE0GEt8iMVfwfIdr
         hhwJFRONM5lsNds5/QoEyLHom9+R/lSkY9vWX+q80+AtCe2xurftnKYD0eUaE4bTDmyE
         PVAA==
Return-Path: <glaroque@baylibre.com>
Subject: Re: [PATCH] serial: meson: handle RX errors
References: <20200721114114.1931-1-narmstrong@baylibre.com>
From: "Guillaume La Roque" <glaroque@baylibre.com>
Message-ID: <d7d92d59-b9ee-aeda-2950-09c1422f0b14@baylibre.com>
Date: Tue, 21 Jul 2020 14:05:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200721114114.1931-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,


On 7/21/20 1:41 PM, Neil Armstrong wrote:
> This checks and handles RX errors on the Amlogic UART controller
> after experiencing errors on the Khadas VIM3 & VIM3L when UART AO A
> lines are not connected.
>
> When the RX line is not connected, the first byte is erroneous and breaks
> the U-Boot autoboot, breaking automatic boot.
>
> This checks and drops any erroneous RX byte on pending and getc callbacks
> to avoid returning true to pending when an error byte is in the FIFO.
>
> Fixes: bfcef28ae4 ("arm: add initial support for Amlogic Meson and ODROID-C2")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/serial/serial_meson.c | 43 +++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index 439057b1b9..1b1725f6aa 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -65,14 +65,36 @@ static int meson_serial_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> +static void meson_serial_rx_error(struct udevice *dev)
> +{
> +	struct meson_serial_platdata *plat = dev->platdata;
> +	struct meson_uart *const uart = plat->reg;
> +	u32 val = readl(&uart->control);
> +
> +	/* Clear error */
> +	val |= AML_UART_CLR_ERR;
> +	writel(val, &uart->control);
> +	val &= ~AML_UART_CLR_ERR;
> +	writel(val, &uart->control);
> +
> +	/* Remove spurious byte from fifo */
> +	readl(&uart->rfifo);
> +}
> +
>  static int meson_serial_getc(struct udevice *dev)
>  {
>  	struct meson_serial_platdata *plat = dev->platdata;
>  	struct meson_uart *const uart = plat->reg;
> +	uint32_t status = readl(&uart->status);
>  
> -	if (readl(&uart->status) & AML_UART_RX_EMPTY)
> +	if (status & AML_UART_RX_EMPTY)
>  		return -EAGAIN;
>  
> +	if (status & AML_UART_ERR) {
> +		meson_serial_rx_error(dev);
> +		return -EIO;
> +	}
> +
>  	return readl(&uart->rfifo) & 0xff;
>  }
>  
> @@ -95,10 +117,23 @@ static int meson_serial_pending(struct udevice *dev, bool input)
>  	struct meson_uart *const uart = plat->reg;
>  	uint32_t status = readl(&uart->status);
>  
> -	if (input)
> -		return !(status & AML_UART_RX_EMPTY);
> -	else
> +	if (input) {
> +		if (status & AML_UART_RX_EMPTY)
> +			return false;
> +
> +		/*
> +		 * Handle and drop any RX error here to avoid
> +		 * returning true here when an error byte is in the FIFO
> +		 */
> +		if (status & AML_UART_ERR) {
> +			meson_serial_rx_error(dev);
> +			return false;
> +		}
> +
> +		return true;
> +	} else {
>  		return !(status & AML_UART_TX_FULL);
> +	}
>  }
>  
>  static int meson_serial_ofdata_to_platdata(struct udevice *dev)

Tested-by: Guillaume La Roque <glaroque@baylibre.com>

on Khadas VIM3L


thanks for this patch.

Guillaume

