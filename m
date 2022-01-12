Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.20764.1641978232451792393
 for <u-boot-amlogic@groups.io>;
 Wed, 12 Jan 2022 01:03:53 -0800
Received: by mail-wr1-f43.google.com with SMTP id x4so2882662wru.7
        for <u-boot-amlogic@groups.io>; Wed, 12 Jan 2022 01:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ftj0xoAjIECjgdNu2bQHNOc4/QPBta7cLZ6hDDdDsFE=;
        b=qsuZcRPSYigIlzX6yPhJtt4B4xlibqYDOHFMQ5Hcxw+TuWSfqNigP90tgetIm1n8Qj
         nT/kmOuz48PFVxbiR4xF8mXZEe8FyMqFcWDEh63jNF+j+b+YivbxlmDRCZ9vlkDFjtwn
         f6tJbFEmGFs54p4pf4ngY2UPpnL1N3WF8HFNiF8vRojrHuygqFFPjEEeDoF7cCUWVXiJ
         i5lxLiJ2fwodwt4jiOhbbVSXndRK44UgLGxSTsGuY3GmcFOLIq5l4gty/R4jVm3alPRP
         xjGDKrhbiBsSmsooTFWhnk355Ibt18q1+3yfbZfEPKKlD3kpR1JtsXGeyn4HzFpHx0Vq
         capQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: amlogic: Disable CONFIG_NET_RANDOM_ETHADDR for android
References: <20220112084023.2858375-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <056e759b-a2af-cbf5-ed4f-b1528e2067ea@baylibre.com>
Date: Wed, 12 Jan 2022 10:03:50 +0100
MIME-Version: 1.0
In-Reply-To: <20220112084023.2858375-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 12/01/2022 09:40, Mattijs Korpershoek wrote:
> The Khadas vim3 and vim3l defconfigs introduced with:
> * f89b90d2d9 ("configs: add khadas-vim3{l}_android for AOSP support")
> * 425f06f86e ("configs: prepare khadas-vim3{l}_ab_android for AOSP support")
> 
> were based on an outdated defconfig prior to the ede1f4f297 ("configs:
> amlogic: Disable CONFIG_NET_RANDOM_ETHADDR when unnecessary") cleanup.
> 
> Disable CONFIG_NET_RANDOM_ETHADDR for the android configs as well to
> stay consistent.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  configs/khadas-vim3_android_ab_defconfig  | 1 -
>  configs/khadas-vim3_android_defconfig     | 1 -
>  configs/khadas-vim3l_android_ab_defconfig | 1 -
>  configs/khadas-vim3l_android_defconfig    | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index 88325c37db..c5aaaf3ce7 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -39,7 +39,6 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_ADC=y
>  CONFIG_SARADC_MESON=y
>  CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index 9305a54b1b..f0b2c205a7 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -37,7 +37,6 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_ADC=y
>  CONFIG_SARADC_MESON=y
>  CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 608b54dca2..3401c51721 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -39,7 +39,6 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_ADC=y
>  CONFIG_SARADC_MESON=y
>  CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 5eed79b263..429db2b344 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -37,7 +37,6 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_ADC=y
>  CONFIG_SARADC_MESON=y
>  CONFIG_BUTTON=y
> 

Applied to u-boot-amlogic

Thanks,
Neil
