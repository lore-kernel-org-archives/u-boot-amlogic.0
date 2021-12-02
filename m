Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.6597.1638441344492265067
 for <u-boot-amlogic@groups.io>;
 Thu, 02 Dec 2021 02:35:45 -0800
Received: by mail-wr1-f47.google.com with SMTP id q3so35779180wru.5
        for <u-boot-amlogic@groups.io>; Thu, 02 Dec 2021 02:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OoSiLmPEZGOMFzlX475pJcvAcqYuqI+vtMF1xH/HWuQ=;
        b=m0K5O3RZNB5iQSWlNVdWiBBwlLVDG4vzN8SMY8e7CPFcH6QtrOkF1ml1Qm+D1PcTHi
         4aFGSoBcpcR7hGJFQ+6kNdn9fqLrYKnwBMPtQItCo3ZsWSqCi0m+e11uOk3vAwe/1/Nv
         1+JAts3O1NGVJjBXOqnlGqg/iG+q5WZnULQedxdRoCnr1jNR9EOpK1FAoq/ITlSEsT/0
         hYlsABaRGV8e4TFv0sioJkvBdaO3FeueeORavwc8x2nfG/F7QVaEDcHtbSZt0vmITbOR
         it3iExmJZ0hGb9n1797gtY6tzplr8LBIgCT+POWkyVLbirruQbCxl6OxoiZyJYcA4Ao2
         It+A==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 5/5] clk: Add clk_get_by_name_optional
References: <20211201184332.2166897-1-seanga2@gmail.com>
 <20211201184332.2166897-6-seanga2@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a1241f79-cd60-c81b-7f77-9ee0da068d3e@baylibre.com>
Date: Thu, 2 Dec 2021 11:35:41 +0100
MIME-Version: 1.0
In-Reply-To: <20211201184332.2166897-6-seanga2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Cc: Dario Binacchi <dariobin@libero.it>, Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 01/12/2021 19:43, Sean Anderson wrote:
> This adds a helper function for clk_get_by_name in cases where the clock is
> optional. Hopefully this helps point driver writers in the right direction.
> Also convert some existing users.
> 
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
>  drivers/clk/clk_zynq.c  |  5 +++--
>  drivers/rng/meson-rng.c |  4 ++--
>  include/clk.h           | 24 ++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
> index 18915c3e04..e80500e382 100644
> --- a/drivers/clk/clk_zynq.c
> +++ b/drivers/clk/clk_zynq.c
> @@ -472,8 +472,9 @@ static int zynq_clk_probe(struct udevice *dev)
>  
>  	for (i = 0; i < 2; i++) {
>  		sprintf(name, "gem%d_emio_clk", i);
> -		ret = clk_get_by_name(dev, name, &priv->gem_emio_clk[i]);
> -		if (ret < 0 && ret != -ENODATA) {
> +		ret = clk_get_by_name_optional(dev, name,
> +					       &priv->gem_emio_clk[i]);
> +		if (ret) {
>  			dev_err(dev, "failed to get %s clock\n", name);
>  			return ret;
>  		}
> diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
> index 5a4f45ad5a..e0a1e8c7e0 100644
> --- a/drivers/rng/meson-rng.c
> +++ b/drivers/rng/meson-rng.c
> @@ -91,8 +91,8 @@ static int meson_rng_of_to_plat(struct udevice *dev)
>  		return -ENODEV;
>  
>  	/* Get optional "core" clock */
> -	err = clk_get_by_name(dev, "core", &pdata->clk);
> -	if (err && err != -ENODATA)
> +	err = clk_get_by_name_optional(dev, "core", &pdata->clk);
> +	if (err)
>  		return err;
>  
>  	return 0;
> diff --git a/include/clk.h b/include/clk.h
> index 103ef16bf9..36721188d0 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -292,6 +292,30 @@ static inline int clk_release_all(struct clk *clk, int count)
>  }
>  #endif
>  
> +/**
> + * clk_get_by_name_optional() - Get/request a optional clock by name.
> + * @dev:	The client device.
> + * @name:	The name of the clock to request, within the client's list of
> + *		clocks.
> + * @clk:	A pointer to a clock struct to initialize.
> + *
> + * Behaves the same as clk_get_by_name(), except when there is no clock
> + * provider. In the latter case, return 0.
> + *
> + * Return: 0 if OK, or a negative error code.
> + */
> +static inline int clk_get_by_name_optional(struct udevice *dev,
> +					   const char *name, struct clk *clk)
> +{
> +	int ret;
> +
> +	ret = clk_get_by_name_optional(dev, name, clk);
> +	if (ret == -ENODATA)
> +		return 0;
> +
> +	return ret;
> +}
> +
>  /**
>   * clk_get_by_name_nodev_optional - Get/request an optinonal clock by name
>   *		without a device.
> 


For meson-rng:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
