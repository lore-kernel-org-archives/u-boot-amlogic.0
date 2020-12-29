Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.9338.1609230227337905540
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Dec 2020 00:23:48 -0800
Received: by mail-wr1-f54.google.com with SMTP id t16so13956532wra.3
        for <u-boot-amlogic@groups.io>; Tue, 29 Dec 2020 00:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M/zI0wWEy7OEGs68RqYyjEccDc7+9aVyU2SPAnRkwDA=;
        b=qsSlD6rx6EUEFzJBxaW/BQxe57Wd7DwI227pateNcamIrWWzVf69xtJyz0TYAmzYQL
         NKPGxZ6XA2x6rOSZPHxB6bfVbtbWx9hzs7zx94w52W227rq0Pq5E5WKRRkTBqvgjW4KI
         1iRfFqCsTy7az815rF7j0wE2X8AuBGQeh50+9c4jXU2CnaBssPBVWtAfnD+ZEuPOO8R7
         SwU1gfatIzkebn9aH90e8D1ZxwO3L0jUog56nzHRwVT+jC3YUVfMvg5qN3cN+vJoaJQ1
         Tmgp+VeApN3bNi0kYyNAMoK6mamWcpGO51SJPGKD+QTR5KzLrjCkPny6PW5PNLCvQBJr
         XaKQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] adc: meson-saradc: use correct printf code
References: <20201227084646.4172-1-xypron.glpk@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e68b8221-5756-4081-4e60-f9b26ff3f76c@baylibre.com>
Date: Tue, 29 Dec 2020 09:23:43 +0100
MIME-Version: 1.0
In-Reply-To: <20201227084646.4172-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 27/12/2020 09:46, Heinrich Schuchardt wrote:
> For printing unsigned int we have to use %u not %d.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/adc/meson-saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
> index 13a8f49dc5..406583e474 100644
> --- a/drivers/adc/meson-saradc.c
> +++ b/drivers/adc/meson-saradc.c
> @@ -282,7 +282,7 @@ static int meson_saradc_read_raw_sample(struct meson_saradc_priv *priv,
>  	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
>  	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
>  	if (fifo_chan != channel) {
> -		printf("ADC FIFO entry belongs to channel %d instead of %d\n",
> +		printf("ADC FIFO entry belongs to channel %u instead of %u\n",
>  		       fifo_chan, channel);
>  		return -EINVAL;
>  	}
> --
> 2.29.2
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
