Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.10545.1621006928891185204
 for <u-boot-amlogic@groups.io>;
 Fri, 14 May 2021 08:42:09 -0700
Received: by mail-wm1-f53.google.com with SMTP id p14-20020a05600c358eb029015c01f207d7so1656077wmq.5
        for <u-boot-amlogic@groups.io>; Fri, 14 May 2021 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e0xW5VZu2sOZqb1kCFEt3DnOlqWoJgZz3C0+JGQAy9Y=;
        b=MngKt+FH1d+iv6qoJ4od7qEWjANgyZZzoqbZKmismgWrrC0ZjyOTiIP5FPW6ZYdaDY
         cko0FZy4M1HFbTZ3GuwCpjRNToo+6jZaGL6DYs332zttL1bFtEvEksJUZdpTdOL2daQn
         hMBBpxA4XolPt4/Cgu/ShnnKswxa4Gs4MbXig1XZA6zodhHrwaeKLYHAg5FNlP72piCN
         72ElzZk2erAQc2+lEpnMNmzdWkBWkqENnBYt19WZHdsE8sXJVaTaQC+uvEjElHHAQIJG
         KcjuJimUNq5fcvGRha0W7KdRGcZEat4GcSjJIwUgvBet5d8Mfr3DjQ9O2IXv7T0ftoYC
         w3zA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: dwc3-meson-g12a: skip phy on -ENODATA aswell
References: <20210505084150.3862010-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e0f17f32-7317-4b97-b619-ee7e10a22b75@baylibre.com>
Date: Fri, 14 May 2021 17:42:06 +0200
MIME-Version: 1.0
In-Reply-To: <20210505084150.3862010-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, marex@denx.de
List-ID: <u-boot-amlogic@groups.io>

On 05/05/2021 10:41, Neil Armstrong wrote:
> If the PHY isn't specified in the DT, -ENODATA means it should be skipped,
> handle it like -ENOENT.
> 
> With that, devices without USB3 supported can have USB working (Odroid-HC4).
> 
> Fixes: adb049abf7 ("usb: dwc3: Add Meson G12A USB Glue")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index bd8bf227c8..90418ddc1d 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -298,7 +298,7 @@ static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
>  	for (i = 0 ; i < PHY_COUNT ; ++i) {
>  		ret = generic_phy_get_by_name(priv->dev, phy_names[i],
>  					      &priv->phys[i]);
> -		if (ret == -ENOENT)
> +		if (ret == -ENOENT || ret == -ENODATA)
>  			continue;
>  
>  		if (ret)
> 

Applied to u-boot-amlogic

Neil
