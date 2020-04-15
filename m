Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.17927.1586966830754898478
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Apr 2020 09:07:11 -0700
Received: by mail-wm1-f68.google.com with SMTP id x25so192505wmc.0
        for <u-boot-amlogic@groups.io>; Wed, 15 Apr 2020 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RI8+7L/RMOxz5ns2j2dohVoi2NKVDz0zU1d+FlYyx6Q=;
        b=Z5QAEG4Nmcjxoo91rgBkVJslwblU5kyHp5igOBluAoj/8VIV4/4VwVcfE4/3GVz65v
         EyHH6HtN5aLaydnvrWen4y0JAFqyyzERbzd/aW2ENkof039HwDBXsriz8Dw7Wg0YwynH
         VIQfj2jDsFLxA56aUMhoyK7uJFtlL9wjaTeOBM7CQkVu5AQxmjgt+8YDc+EVC+gTAeRc
         AX1rXohJnfskEBifKLYYKgifUQZZ8aJr1SjT3LZ1x6yR6dbj5DWF0Utbi30dKV4EC66g
         Yt2bVqROnJnyBiMd0r1pqv6VzKVbN2mzyhxGG7sC0fJ4nNmLKKqzsb/+EWPLiuAGktd9
         UgCg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm: meson: imply DM_RNG
References: <20200405102023.15217-1-xypron.glpk@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a9089abe-0f4c-4b12-6103-2909e126744e@baylibre.com>
Date: Wed, 15 Apr 2020 18:07:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200405102023.15217-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, open list <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

On 05/04/2020 12:20, Heinrich Schuchardt wrote:
> All ARCH_MESON boards have a hardware random number generator. So we should
> enable building the RNG driver.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index bbb1e2738b..eee4538c7e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -762,6 +762,7 @@ config ARCH_OMAP2PLUS
>  config ARCH_MESON
>  	bool "Amlogic Meson"
>  	imply DISTRO_DEFAULTS
> +	imply DM_RNG
>  	help
>  	  Support for the Meson SoC family developed by Amlogic Inc.,
>  	  targeted at media players and tablet computers. We currently
> --
> 2.25.1
> 

Applied to u-boot-amlogic
