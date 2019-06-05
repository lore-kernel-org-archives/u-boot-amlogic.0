Received: by mail-wr1-f68.google.com with SMTP id v14so654679wrr.4
        for <u-boot-amlogic@groups.io>; Wed, 05 Jun 2019 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hVGa0pAUD8kFzGVxX0XszBBFZiV1s1FJkyV5CkV0ayQ=;
        b=exoe/HNvDwDXPIj6heHFomSFL1P8suDJAlFibEQ6e3Zz4W4+rDKUMvTe7FgAq1JaV3
         nP1q+eTU/VJVWk4ECWuiWMZFU1RkUUoiumP56/8TSxCjHmMhH/Ii1Vt8Qr2XuQqzIHgf
         tKWzFGfQJbeDmd5009PCt/sCczGTptQyzYVzQxyOUj8m7yUBmidfkKHB60Or72lxThMx
         u7QpVKfERVRh1/PIxHLV8GRRiOcg8W9xFN9Bzo6zjs0XztYyDiahRRsCH0nDjj624iEW
         Rf0nWSYIzhp++bjfxet1wfjhSojA8UbY/G2RhIqbAOYQBpSbzkZhvfAcuzcTUqYW5WH6
         c7FQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] video: meson: hdmi-supply regulator should be optional
References: <20190604202619.6332-1-mjourdan@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <184d8b5d-45df-ed83-3efc-b5b8ca2ef636@baylibre.com>
Date: Wed, 5 Jun 2019 09:24:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190604202619.6332-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Maxime Jourdan <mjourdan@baylibre.com>, Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 04/06/2019 22:26, Maxime Jourdan wrote:
> Some boards don't have such a regulator, and don't need one to enable
> HDMI display. Make it optional, fixing hdmi display for those boards.
> 
> Also surround the regulator code with a config check on DM_REGULATOR.
> 
> Reported-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/video/meson/meson_dw_hdmi.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
> index 7a1c060856..483c93f6b6 100644
> --- a/drivers/video/meson/meson_dw_hdmi.c
> +++ b/drivers/video/meson/meson_dw_hdmi.c
> @@ -361,13 +361,19 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
>  	priv->hdmi.i2c_clk_high = 0x67;
>  	priv->hdmi.i2c_clk_low = 0x78;
>  
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>  	ret = device_get_supply_regulator(dev, "hdmi-supply", &supply);
> -	if (ret)
> +	if (ret && ret != -ENOENT) {
> +		pr_err("Failed to get HDMI regulator\n");
>  		return ret;
> +	}
>  
> -	ret = regulator_set_enable(supply, true);
> -	if (ret)
> -		return ret;
> +	if (!ret) {
> +		ret = regulator_set_enable(supply, true);
> +		if (ret)
> +			return ret;
> +	}
> +#endif
>  
>  	ret = reset_get_bulk(dev, &resets);
>  	if (ret)
> 

Good catch !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
