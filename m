Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web09.1243.1610698264596996765
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Jan 2021 00:11:05 -0800
Received: by mail-wr1-f42.google.com with SMTP id l12so3089902wry.2
        for <u-boot-amlogic@groups.io>; Fri, 15 Jan 2021 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BmU5wt6kyQx/P5eBRIx4GtWq6le65W8j0XUf2SEPQOE=;
        b=cIRhgiHIeXFGYrbs61HYUuxFBk+DBs6ctvNNN1JhrEKh4IozUrwZ4XcxYxgzRNnlsD
         N6wsIN2UKX9sJ5r7gkeMNmiLnUDcmoMl8Sr1p3RFrH7NaoUxC4NwG47BYgl2EyQrJc9F
         8K8aiPfd78FG6kblxjB1tBh8Rc+hYrdvzrbQxim5EeHPnAA2zEyTWqqrnRatQPRm5FF4
         EUZYd4qgGaqrUp837Gk1YlQuxAeGlS643tjzsbLT5Gvg+NTucRwBot/6E3bg7J7+5y7g
         ym8mIutLR7Pixpuz2mYfECuNlnTPdfNyi3FHB6CSUCHatNgjnu/jRB59PwNc6M4tNukX
         18Zw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] gpio: gpio-uclass: add OPEN_DRAIN flag parsing
References: <20210115051558.469734-1-art@khadas.com>
 <20210115051558.469734-2-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <6fb41621-123c-2472-55c3-17653f777fe1@baylibre.com>
Date: Fri, 15 Jan 2021 09:11:01 +0100
MIME-Version: 1.0
In-Reply-To: <20210115051558.469734-2-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, hs@denx.de, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

This has already been pushed on u-boot master:
https://patchwork.ozlabs.org/project/uboot/patch/20200505084318.15307-2-narmstrong@baylibre.com/

Commit: 47bd533e9dd0f967ff7b62f3edfd6c97131e1501
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Tue May 5 10:43:17 2020 +0200

    gpio: emulate open drain & open source in dm_gpio_set_value()

    Handle the GPIOD_OPEN_DRAIN & GPIOD_OPEN_SOURCE flags to emulate open drain
    and open source by setting the GPIO line as input depending on the
    requested value.

    The behaviour is taken from the Linux gpiolib.

    Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
    Reviewed-by: Simon Glass <sjg@chromium.org>

Neil

On 15/01/2021 06:15, Artem Lapkin wrote:
> add GPIOD_OPEN_DRAIN flag which cant parsed properly
> 
> Problem: for example cant power video system for sm1 g12a socs
> because OPEN_DRAIN flag cant parsed
> 
> DTS examples:
> 
> ```
> $ grep GPIO_OPEN_DRAIN\>  arch/arm/dts/meson-*.dt*
> arch/arm/dts/meson-g12a-sei510.dts:		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> arch/arm/dts/meson-g12a-u200.dts:		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> arch/arm/dts/meson-gx-libretech-pc.dtsi:	gpio = <&gpio GPIOH_3 GPIO_OPEN_DRAIN>;
> arch/arm/dts/meson-khadas-vim3.dtsi:		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> arch/arm/dts/meson-sm1-sei610.dts:		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> ```
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  drivers/gpio/gpio-uclass.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index bad6b71e0c..6225f32457 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -574,6 +574,15 @@ int dm_gpio_set_value(const struct gpio_desc *desc, int value)
>  	if (ret)
>  		return ret;
>  
> +	if (desc->flags & GPIOD_OPEN_DRAIN) {
> +		if (value)
> +			gpio_get_ops(desc->dev)->direction_input(desc->dev, desc->offset);
> +		else
> +			gpio_get_ops(desc->dev)->direction_output(desc->dev, desc->offset, 0);
> +
> +		return 0;
> +	}
> +
>  	if (desc->flags & GPIOD_ACTIVE_LOW)
>  		value = !value;
>  
> 

