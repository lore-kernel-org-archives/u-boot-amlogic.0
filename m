Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web09.7349.1576836906242524575
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Dec 2019 02:15:06 -0800
Received: by mail-wr1-f65.google.com with SMTP id z7so8806760wrl.13
        for <u-boot-amlogic@groups.io>; Fri, 20 Dec 2019 02:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z8jHUWBPJRGLZCHplvMIBEUtUBD0BWUsGpNLtfkiegM=;
        b=A5MFJJKk+ZKUFvDvt6z0SZrsOzjPVW2HwrAMuar9UNyQUY5Vd1DrGlgtwn+H23r0yO
         VuetsnZkX8JSw04VupKQpEuZFoVnqC9V19leXupPM3mu3DaxGQ0mmUZRJfPfG+oifZtb
         hBcDp9DXxr3QsoKUCkNXZKP5lUS/WSUxk553qPfpBzUjMbVEh5CFSstz+cElcfRgABCR
         DtQGn38a7h/VOqKLRpExVfhAbmTT9kBEAu9I5gUHR2Y5CoA+oIPOX/JWKSOit4uUkHAb
         w4nX4TYVYNh1CangWX/zxbwaMevoar793PUKAMjzrcDVJPyG0XpU+rC3zMRDe4JOjBk1
         l0Dg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/5] mmc: meson-gx: enable input clocks
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
 <20191219183620.1423118-3-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9e54d1eb-5fb0-a55b-e07c-01fd1f997ae1@baylibre.com>
Date: Fri, 20 Dec 2019 11:15:01 +0100
MIME-Version: 1.0
In-Reply-To: <20191219183620.1423118-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 19/12/2019 19:36, Jerome Brunet wrote:
> Until now, the mmc clock was left in a good enough state by the ROM
> code to be used by the controller. However on some SoC, if the ROM
> code finds a bootloader on USB or SPI, it might leave the MMC clock
> in state the controller cannot work with.
> 
> Enable the input clocks provided to the mmc controller. While the
> u-boot mmc controller driver is not doing fancy settings like the Linux,
> it at least needs to make these clocks are running.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/meson_gx_mmc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index b5f5122b1b7b..86c1a7164a93 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <common.h>
> +#include <clk.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <fdtdec.h>
> @@ -241,12 +242,23 @@ static int meson_mmc_probe(struct udevice *dev)
>  	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
>  	struct mmc *mmc = &pdata->mmc;
>  	struct mmc_config *cfg = &pdata->cfg;
> +	struct clk_bulk clocks;
>  	uint32_t val;
> +	int ret;
> +
>  #ifdef CONFIG_PWRSEQ
>  	struct udevice *pwr_dev;
> -	int ret;
>  #endif
>  
> +	/* Enable the clocks feeding the MMC controller */
> +	ret = clk_get_bulk(dev, &clocks);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable_bulk(&clocks);
> +	if (ret)
> +		return ret;
> +
>  	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
>  			MMC_VDD_31_32 | MMC_VDD_165_195;
>  	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
