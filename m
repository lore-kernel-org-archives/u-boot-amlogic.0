Received: by mail-wr1-f68.google.com with SMTP id n4so13229687wrw.13
        for <u-boot-amlogic@groups.io>; Wed, 05 Jun 2019 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+G/JzJRk/M18W8+TC/1B8+ANp3GlMFYNVEvCJdAVFw=;
        b=fS2BGKVQKpVxUUwdM/1OrpFCM6410eNs9AymMGhX0Ogpa+1zcCa7XVgF0wmfoytfzS
         RQk0/q8WvTT1iFfCd35gDcHtwn5DuhuIHLaB/+ct8tSJWNKge0B9i8C3Gmd86heRwNfC
         bcsQgd2CKGb2YurDZ1x16tN3sTJf1XtZle5puDPIh+ufQ/hO+whnhBlJBeQ/61GaCLGQ
         9x2qSFZ3YwEqLT07Bxl+u5h0lxwwZh+dViopPeMd0qn/plG22p/axV+5dhoVp73rPz4n
         wyWWjBSZg4LwCykBPb8EwEHwcNCxZb7HKPEyeYnkRPLMMyneni1u0k+0vIdbohVU6uwG
         1O9g==
Return-Path: <mohammad.rasim96@gmail.com>
Date: Wed, 5 Jun 2019 11:17:51 +0300
From: "Mohammad Rasim" <mohammad.rasim96@gmail.com>
Subject: Re: [PATCH] video: meson: hdmi-supply regulator should be optional
Message-ID: <20190605081751.k7hcnu3sxxwnvbrx@manjaro.localdomain>
References: <20190604202619.6332-1-mjourdan@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20190604202619.6332-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Maxime Jourdan <mjourdan@baylibre.com>
Cc: Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 19/06/04 10:26PM, Maxime Jourdan wrote:
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
> --
> 2.21.0
>
Tested-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
