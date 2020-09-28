Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.31568.1601278637722165663
 for <u-boot-amlogic@groups.io>;
 Mon, 28 Sep 2020 00:37:18 -0700
Received: by mail-wm1-f68.google.com with SMTP id l15so3756903wmh.1
        for <u-boot-amlogic@groups.io>; Mon, 28 Sep 2020 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0/NBBp/WqId/VTWDpdLX73bCS/CcU51WGOiGYdhsdP4=;
        b=DhcM+3PFQ3sUzmHBUWT91FjpWkaHRxm0baE+tkYd6Y+Nbc8klzxpAPvyLgkSgFa/u9
         5n46p9/977aGFz1PAgURVM4vUkulVvcXIba03hDxbCK+o4hp6cvX36D5EqBJxvPd0Ioh
         P9B7d9S7nqy+5I7I9CE/KdbD/yCNyfsV4c8Ee/qaVdHrestc1Wk4G61zxyJNWkG2kBX6
         VTye3CfmloWtu2RA5gvnmvBvJP23c7sLByXN/scUUzKXvk9xbSjzfdB9JtkNJOmkctoB
         Gm6uj5FP/lTiRRU3zsPS+0ekQBx9tTsy5y5pA4D/vdrk5C3MPmzwZ+f89Rhb3DPCUWCc
         c1Fw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] rng: meson: make core clock optional
References: <20200925071920.9211-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1925383f-c77b-eefd-68fd-5364e1652c47@baylibre.com>
Date: Mon, 28 Sep 2020 09:37:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200925071920.9211-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, sughosh.ganu@linaro.org
Cc: u-boot-amlogic@groups.io, Heinrich Schuchardt <xypron.glpk@gmx.de>, Scott K Logan <logans@cottsay.net>
List-ID: <u-boot-amlogic@groups.io>

On 25/09/2020 09:19, Neil Armstrong wrote:
> This fixes HWRNG support on Amlogic GXL, GXM, G12A, G12B & SM1
> based boards dues to the lack of the core clock in the device tree.
> 
> It was reported breaking EFI boot in the Linux EFI stub, because the
> EFI_RNG_PROTOCOL didn't check for the RNG device presence before
> installing itself.
> 
> The Linux amlogic,meson-rng.yaml doesn't mandate the core clock,
> this the clock should be ignores if not present.
> 
> Nevertheless, the clock should be present and this should be fixed
> on the Linux meson-gxl.dtsi & meson-g12-common.dtsi then synced
> with U-Boot.
> 
> The change has been tested on a Khadas VIM3, which uses the common
> meson-g12-common.dtsi like the Odroid-C4 & Odroid-N2 in Scott's
> report, along with the RNG cmd.
> 
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reported-by: Scott K Logan <logans@cottsay.net>
> Fixes: bc40eb278b ("drivers/rng: add Amlogic hardware RNG driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/rng/meson-rng.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
> index 4b81a62353..57a5a702a2 100644
> --- a/drivers/rng/meson-rng.c
> +++ b/drivers/rng/meson-rng.c
> @@ -90,8 +90,9 @@ static int meson_rng_ofdata_to_platdata(struct udevice *dev)
>  	if (!pdata->base)
>  		return -ENODEV;
>  
> +	/* Get optional "core" clock */
>  	err = clk_get_by_name(dev, "core", &pdata->clk);
> -	if (err)
> +	if (err && err != -ENODATA)
>  		return err;
>  
>  	return 0;
> 


Applied to u-boot-amlogic

Neil
