Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web09.967.1607972060620695942
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 10:54:20 -0800
Received: by mail-wr1-f67.google.com with SMTP id a12so17484338wrv.8
        for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIrYRNwsTGG1c+zLZVDMZv5mrVU6yW2NYsrNUGKSBBo=;
        b=l3ZLq5QNTGIHKjF6k8N7Da5OswpGhWRcFhMdjUNYyT8bXGg75v/Vbli5uMsJ/Btd8a
         xx1Hq326BOo48VgKOvil2N94myEnNYmx+NP+bFJwvLuRvYPGneH5A9hb/S//V8h/przY
         eDuAes3b49DMlfas+9Gp5QiQlR0Ch9BkgrR+FHEZmOcy2gk8+0N+Oqrzm7xsKxzxoixB
         bn0ufZB6fgdHD36lloAcz2cfWm+39sQM54KbXp85zGdh8BhTojMFCqgSgdpkfnhoXrYp
         nL7R5xV0c1m0XH3A9Vdikqk7pQghAbvicfo0P4UQGFRylfASF2OeZwkQJzT58ee5Lc0n
         mNrQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/6] adc: meson-saradc: skip hardware init only if ADC is enabled
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
 <CGME20201214112450eucas1p1e7ad389bceaaf1082c9afdcb0733e9c0@eucas1p1.samsung.com>
 <20201214112437.18757-4-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e2f7c87c-562f-de3a-edef-5a9ebd51dcc4@baylibre.com>
Date: Mon, 14 Dec 2020 19:54:17 +0100
MIME-Version: 1.0
In-Reply-To: <20201214112437.18757-4-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 14/12/2020 12:24, Marek Szyprowski wrote:
> The driver skips hardware initialization if it is already configured by
> the earlier bootloader stage (BL30). Skip the initialization only if the
> hardware is really initialized and enabled.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Change-Id: I3e2e2d270ad3e7e7f38e2bc3ce2a924a47b164af

Ditto

> ---
>  drivers/adc/meson-saradc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
> index 998cef24d88..ce7ae990ad0 100644
> --- a/drivers/adc/meson-saradc.c
> +++ b/drivers/adc/meson-saradc.c
> @@ -512,8 +512,11 @@ static int meson_saradc_init(struct meson_saradc_priv *priv)
>  	 * reading the temperature sensor.
>  	 */
>  	regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> -	if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
> -		return 0;
> +	if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED) {
> +		regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
> +		if (regval & MESON_SAR_ADC_REG3_ADC_EN)
> +			return 0;
> +	}
>  
>  	meson_saradc_stop_sample_engine(priv);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
