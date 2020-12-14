Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.987.1607972047811438458
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 10:54:08 -0800
Received: by mail-wr1-f68.google.com with SMTP id a11so9747367wrr.13
        for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 10:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=anU8BLTvVSq+gHPeHAz0ue3wdg4z6nH597LWKgVxpJo=;
        b=iYDc3vepI1N6OAT7WbXQhKf7mDLCFzAeiLPbs8VfumjeR+eD7EBT1bSZWvzV1SJ6zn
         KOzT9lQs2B5YhMHx/iZQ+dE+oB6h4iZ37yFx0qNOdqFej6V1hBId7AC2cky/JtwT4DmW
         PBo1UQKjnRjBedWP4twN+Jy9hPl4S4ehpXoCeaLgCBtSxf66na8WlYMdku+oNNsDRxsm
         j8NP4cIWYN7HWFbNvBBkPetX8E+vd3g6uD1sY1PRb05K/F9NOl1Nn7apAAkBw1hVc3SO
         FiOqi90zu0rm+LOmvUd98tPrqfJfhG82DrSk/ReLouLPSbMbXTc4K9vf0y3q6zp6vbFL
         bOqw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/6] adc: meson-saradc: add G12A variant
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
 <CGME20201214112449eucas1p1ebcf51e2b91ed2bac7fc4d309a174499@eucas1p1.samsung.com>
 <20201214112437.18757-3-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <cf38019c-b65a-ead2-cfd1-f58a2cd0f97f@baylibre.com>
Date: Mon, 14 Dec 2020 19:54:04 +0100
MIME-Version: 1.0
In-Reply-To: <20201214112437.18757-3-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 14/12/2020 12:24, Marek Szyprowski wrote:
> Add support for the SARADC variant found on the G12A SoCs family.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Change-Id: If519d333e9773d089f37a8c7b4ccb144be68925b

Ditto

> ---
>  drivers/adc/meson-saradc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
> index 72b0cc4e5bd..998cef24d88 100644
> --- a/drivers/adc/meson-saradc.c
> +++ b/drivers/adc/meson-saradc.c
> @@ -711,6 +711,8 @@ static const struct udevice_id meson_saradc_ids[] = {
>  	  .data = (ulong)&gxl_saradc_data },
>  	{ .compatible = "amlogic,meson-gxm-saradc",
>  	  .data = (ulong)&gxl_saradc_data },
> +	{ .compatible = "amlogic,meson-g12a-saradc",
> +	  .data = (ulong)&gxl_saradc_data },
>  	{ }
>  };
>  
> 


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
