Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.1231.1587712726670324745
 for <u-boot-amlogic@groups.io>;
 Fri, 24 Apr 2020 00:18:47 -0700
Received: by mail-wr1-f68.google.com with SMTP id t14so9452332wrw.12
        for <u-boot-amlogic@groups.io>; Fri, 24 Apr 2020 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFp+IeoJUd9hkhYt0jN/bWcNNmPg/DTGJxYS54vA+4g=;
        b=alIyWTeGrr9n5kl9lkpuR0Kedeolo0xv1OC0N3nuxLi47M/QlVwqCHTLkswoGomj2Y
         wAsRQQeP7LP7EIcJCgTtIEu7Qyn3wsN7y2jQcI9GDNcQvhnG+dLB/DDDIooE/nQo979V
         xB8DipWNdpZpoXjTHDrwYAc9IzuoeBez5jSln1vcR0utIqwlqKrDixy8GU2th7ymz/DE
         qE0FU+wfIIvSzDRXo++fAd0FMp2EImHlCV1AiJQiPAodLrXyZT+mnBlTUenl1MVE3B4x
         vp+C7RS+ZBLjfLRy6KfWX/q/D9m5Q9negJnfXGNKU8FtkVGqID6f1d63JLSEBex/Ul+A
         TngQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <16078B20C191ED17.15323@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3cb25222-cc59-6326-62cb-f6ff811188b9@baylibre.com>
Date: Fri, 24 Apr 2020 09:18:43 +0200
MIME-Version: 1.0
In-Reply-To: <16078B20C191ED17.15323@groups.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, marex@denx.de
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 20/04/2020 15:46, Neil Armstrong via groups.io wrote:
> Power on/off the PHYs to enable power to the USB ports, fixing USB support
> on Khadas VIM3/VIM3L boards.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index d4453f8784..8f4a2f3f82 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>  			goto err_phy_init;
>  	}
>  
> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
> +		if (!priv->phys[i].dev)
> +			continue;
> +
> +		ret = generic_phy_power_on(&priv->phys[i]);
> +		if (ret)
> +			goto err_phy_init;
> +	}
> +
>  	return 0;
>  
>  err_phy_init:
> @@ -430,6 +439,13 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
>  
>  	clk_release_all(&priv->clk, 1);
>  
> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
> +		if (!priv->phys[i].dev)
> +			continue;
> +
> +		 generic_phy_power_off(&priv->phys[i]);
> +	}
> +
>  	for (i = 0 ; i < PHY_COUNT ; ++i) {
>  		if (!priv->phys[i].dev)
>  			continue;
> 

Applied to u-boot-amlogic
