Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web11.11475.1604929162988940452
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 05:39:23 -0800
Received: by mail-wm1-f66.google.com with SMTP id h2so8012370wmm.0
        for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2020 05:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1fPC8rTsBH6EhFqT4enbRhaFALBw/LwDQ54HT+/mgNM=;
        b=JDgdQzsUhHS92UEPcNEgbgqGG6XQp0IVyBwJIOFl7BJD9pwrez9hY8fPmUGreklz9C
         HM/lqpINXXSrqJ9m7rCgZrGRY3olbHoF00mYENhEmGNa/ZOwOqg3IecahZ3qSAze0ilf
         YQgjsEElS7bkhLOvC8Fb6+8F5oFGpsJKxfrBcP77aBGH1JcItBx5XwW6XM3ykg0Yoaqa
         4N0U9KJa5pLIlQrolyZlcx5iSvT7QGpq9ppgIFbdaQ+OAwOPxnMKsLjqjdLfeafw5gHb
         3JVRyHKGzMOxliE6vyjFM7UHZ1r6BtDxJRNOWmqL8f+V4vkLGy59yuRo5XTRLVKN0MF7
         73yg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
 <20201109031233.25320-1-jh80.chung@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
Date: Mon, 9 Nov 2020 14:37:09 +0100
MIME-Version: 1.0
In-Reply-To: <20201109031233.25320-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 09/11/2020 04:12, Jaehoon Chung wrote:
> Core clock phase value is changed from 180' to 270'.
> It's more stable than before.
> - Odroidn-N2/C4 : Working fine with 52MHz
> - VIM3 : Working fine with 52MHz
> 
> Before this patch, Odroid-C4 doesn't work fine with 52MHz.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 719dd1e5e570..7c60e0566560 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  	}
>  	clk_div = DIV_ROUND_UP(clk, mmc->clock);
>  
> -	/* 180 phase core clock */
> -	meson_mmc_clk |= CLK_CO_PHASE_180;
> -
> -	/* 180 phase tx clock */
> +	/*
> +	 * Clock Phase needs to set a proper value.
> +	 * It can be changed to other value.
> +	 * Because CORE : 270' Phase and TX : 0' Phase are stable,
> +	 * set to them by default.
> +	 */
> +	/* Core Clock Phase */
> +	meson_mmc_clk |= CLK_CO_PHASE_270;
> +
> +	/* TX Clock Phase */
>  	meson_mmc_clk |= CLK_TX_PHASE_000;
>  
>  	/* clock settings */
> 

The previous values were aligned on the Linux driver, which is functional.

How did you test these ?

Neil
