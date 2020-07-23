Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.8090.1595493497501212728
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Jul 2020 01:38:18 -0700
Received: by mail-wm1-f65.google.com with SMTP id f139so4388364wmf.5
        for <u-boot-amlogic@groups.io>; Thu, 23 Jul 2020 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OlOoCsiccN4vccpZHa4H/Kv/g4RBzXbJkJjSrD5GWv4=;
        b=0XuSkRGorD76YpeCGOBiwWgM/CY6RTDKc6MXxMm1mGETyfe8ltUqPvC2P3ELNW2ffK
         RVXpt29XW83ICn1Qau0EQo5K8T0/lkdJE7ghaqrV1Mg9uwXlxvwLxVHo6GyhoVH0UmyC
         57MwqSWWJYTWyYfRYATY5Up//o33JvmIuYdE1Hi30S2o/dkveQqsI83Ms6AA+m2d9NmW
         AfN9nOiE+zPmolHBYcNvOObkCsi9westroHYuJ2fs8cEA0hqqoOIR9lCkh5MDL/RJOnl
         UGJ0N1LPL0O+2v7L+O9coKEpw7xVCFU85A8m0bh8PWYXbxKdraSUAErjziGS55Eh7iXW
         Liow==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] serial: meson: handle RX errors
References: <20200721114114.1931-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <454c5452-6b17-8820-99c4-f868e1b47282@baylibre.com>
Date: Thu, 23 Jul 2020 10:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200721114114.1931-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 21/07/2020 13:41, Neil Armstrong wrote:
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
> 

Applied to u-boot-amlogic

Neil
