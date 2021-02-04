Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.8192.1612447507203398811
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Feb 2021 06:05:07 -0800
Received: by mail-wm1-f52.google.com with SMTP id 190so3237546wmz.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Feb 2021 06:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gCiB2hyBOJ38bet9HtHD2F4WvNg9KGD1A51Q9JKkuPc=;
        b=LI00SSls6bFoEyjcqCbUSjqMCjPpxuT/fH/hjYzsJtZQNLAtR5/PNdGw6vKdjyJtjr
         GhpWQq6SlFLpkCgrWV850MxtKF0HltzpQeEDUGv7uiXezpTOT/aW2kHyCr9pTfZrFqHv
         sPaYIeS6eivqjWe/wCHwlJFArKHOXMLGbvknYs+OKcrK8Tk3s61c1y93H3lVaNu4sxSc
         WdzCcTTf68iFvPRLqc5i8rSfwpt5yanFBOIsQ1xetJ/lHyIZCdRz/hGkB0OKMCkFoWme
         IJpEtQ9HN7A5hsob+M7UnbJKb+7NqDK1NE0MTOqiLDy1zL2rhnPmaZx1THETE9yOcWbx
         NO/w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/3] mmc: meson_gx_mmc: use mmc_pwrseq instead of meson_mmc_pwrseq
References: <20210201092806.14314-1-jh80.chung@samsung.com>
 <CGME20210201092741epcas1p1d0ca675d8c002bcac09d9add543f938b@epcas1p1.samsung.com>
 <20210201092806.14314-3-jh80.chung@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <6bd080f7-62ab-7e71-46fa-4cf13e22b4ef@baylibre.com>
Date: Thu, 4 Feb 2021 15:05:01 +0100
MIME-Version: 1.0
In-Reply-To: <20210201092806.14314-3-jh80.chung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, sjg@chromium.org, kever.yang@rock-chips.com, yangbo.lu@nxp.com, faiz_abbas@ti.com, u-boot-amlogic@groups.io, philipp.tomsich@theobroma-systems.com
List-ID: <u-boot-amlogic@groups.io>

On 01/02/2021 10:28, Jaehoon Chung wrote:
> Use mmc_pwrseq instead of meson_mmc_pwrseq.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/meson_gx_mmc.c | 41 +++-----------------------------------
>  1 file changed, 3 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 8b6dfa3b9603..0ef140562cd2 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -292,12 +292,11 @@ static int meson_mmc_probe(struct udevice *dev)
>  
>  	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
>  
> -#ifdef CONFIG_PWRSEQ
> +#ifdef CONFIG_MMC_PWRSEQ
>  	/* Enable power if needed */
> -	ret = uclass_get_device_by_phandle(UCLASS_PWRSEQ, dev, "mmc-pwrseq",
> -					   &pwr_dev);
> +	ret = mmc_pwrseq_get_power(dev, cfg);
>  	if (!ret) {
> -		ret = pwrseq_set_power(pwr_dev, true);
> +		ret = pwrseq_set_power(cfg->pwr_dev, true);
>  		if (ret)
>  			return ret;
>  	}
> @@ -342,37 +341,3 @@ U_BOOT_DRIVER(meson_mmc) = {
>  	.of_to_plat = meson_mmc_of_to_plat,
>  	.plat_auto	= sizeof(struct meson_mmc_plat),
>  };
> -
> -#ifdef CONFIG_PWRSEQ
> -static int meson_mmc_pwrseq_set_power(struct udevice *dev, bool enable)
> -{
> -	struct gpio_desc reset;
> -	int ret;
> -
> -	ret = gpio_request_by_name(dev, "reset-gpios", 0, &reset, GPIOD_IS_OUT);
> -	if (ret)
> -		return ret;
> -	dm_gpio_set_value(&reset, 1);
> -	udelay(1);
> -	dm_gpio_set_value(&reset, 0);
> -	udelay(200);
> -
> -	return 0;
> -}
> -
> -static const struct pwrseq_ops meson_mmc_pwrseq_ops = {
> -	.set_power	= meson_mmc_pwrseq_set_power,
> -};
> -
> -static const struct udevice_id meson_mmc_pwrseq_ids[] = {
> -	{ .compatible = "mmc-pwrseq-emmc" },
> -	{ }
> -};
> -
> -U_BOOT_DRIVER(meson_mmc_pwrseq_drv) = {
> -	.name		= "mmc_pwrseq_emmc",
> -	.id		= UCLASS_PWRSEQ,
> -	.of_match	= meson_mmc_pwrseq_ids,
> -	.ops		= &meson_mmc_pwrseq_ops,
> -};
> -#endif
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

You should probably also update the amlogic defconfigs in this patchset, no ?

Neil
