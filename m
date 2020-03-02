Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.12097.1583142343487409874
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Mar 2020 01:45:43 -0800
Received: by mail-wr1-f68.google.com with SMTP id r17so11648737wrj.7
        for <u-boot-amlogic@groups.io>; Mon, 02 Mar 2020 01:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDqRb/B6tiZsxRrMB8p5IXq41fHa2fa9Hvluz9to70w=;
        b=P+p+TtYi8n6n5mzF0VEU/nEqNa7gjEqYXuqO6LOQG99SH9ehurhnNQZn+t3u5iwmus
         xYz3FCAnLofWItiOzSIIG4tidZg42JRhbzNG3iKTCUy73i11QVQSjEjpBDQdWo3fpFO1
         MP/IgbRysTokpGA/oR6q4Bc4eNn5JRs9lM9xe4ma/QYErmUH7DcOgvgQxlzTzvGoXh6R
         OZRjTU35wDi3JRw8i029cI7IW+3K7+8QID1/DT+BXcLJ09RDBPUZORHtTpHhHSHptXeD
         Hk5R399Eb5K6PNPt5VnvhkXJLMifwFRFHlA6bd3iuBWMEgv9nAD0fIg7IT0iZ2l9cVnN
         p6XQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 2/6] mmc: meson-gx: enable input clocks
References: <20200227112738.494579-1-jbrunet@baylibre.com>
 <20200227112738.494579-3-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1cc8927c-a3b8-d862-e053-442d10a47a8c@baylibre.com>
Date: Mon, 2 Mar 2020 10:45:41 +0100
MIME-Version: 1.0
In-Reply-To: <20200227112738.494579-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 27/02/2020 12:27, Jerome Brunet wrote:
> Until now, the mmc clock was left in a good enough state by the ROM
> code to be used by the controller. However on some SoC, if the ROM
> code finds a bootloader on USB or SPI, it might leave the MMC clock
> in state the controller cannot work with.
> 
> Enable the input clocks provided to the mmc controller. While the
> u-boot mmc controller driver is not doing fancy settings like the Linux,
> it at least needs to make these clocks are running.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/meson_gx_mmc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 031cc79ccb1f..7060f15787f6 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <common.h>
> +#include <clk.h>
>  #include <dm.h>
>  #include <fdtdec.h>
>  #include <malloc.h>
> @@ -240,12 +241,23 @@ static int meson_mmc_probe(struct udevice *dev)
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

This doesn't apply on master, will fix while applying.

Neil
