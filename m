Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.11168.1628180475991028527
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:16 -0700
Received: by mail-wr1-f52.google.com with SMTP id p5so7338798wro.7
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SLuzHapQSvw1NC06rlP/p1OoTWfxrSQW31tNBjO7llQ=;
        b=EzxAXRedSnYEGjBZwCGqs/n1wTxiKAreQHrOsjjq1T4EHKd8W1HlsIwYdGM09GgAoz
         w5+TRknAxcp4Apsu90ekGJtN2+aty1tuWnXmpkATDjiox/owQmRgcyQRvvCRL2GDL+YY
         j3p8pBk2M6PFUm9sjoCO6T4fmFZ9ZSqXAYpqImLabfh0mbaHeTDeOw5FGGRIlJDobFrp
         wHYlX2eBnUnMDkm9Agdzh1APntXgsw1MrKvJUaQOQTs3nLNZdrhVuKwr+hoZMAs9g5x7
         nd9efmTYR/2d0ziQ3+FNyUYqQOKNCenWXRq2kT9kRdhGUCeQNcUhU75qkv0MuCk+hTrO
         zSoA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/9] configs: meson64_android: implement AVB support
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-4-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5667bca3-034f-7af8-158f-61d3452df008@baylibre.com>
Date: Thu, 5 Aug 2021 18:20:59 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-4-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> AVB (Android Verified Boot) is well supported in U-Boot already.
> Add support for it in meson64_android.
> 
> This is controlled by the "force_avb" environment variable and the
> CONFIG_CMD_AVB option.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index bc3ffb9ca5..48a23b6e41 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -27,6 +27,25 @@
>  
>  #ifndef RECOVERY_PARTITION
>  #define RECOVERY_PARTITION "recovery"
> +
> +#if defined(CONFIG_CMD_AVB)
> +#define AVB_VERIFY_CHECK \
> +	"if test \"${force_avb}\" -eq 1; then " \
> +		"if run avb_verify; then " \
> +			"echo AVB verification OK.;" \
> +			"setenv bootargs \"$bootargs $avb_bootargs\";" \
> +		"else " \
> +			"echo AVB verification failed.;" \
> +		"exit; fi;" \
> +	"else " \
> +		"setenv bootargs \"$bootargs androidboot.verifiedbootstate=orange\";" \
> +		"echo Running without AVB...; "\
> +	"fi;"
> +
> +#define AVB_VERIFY_CMD "avb_verify=avb init ${mmcdev}; avb verify;\0"
> +#else
> +#define AVB_VERIFY_CHECK ""
> +#define AVB_VERIFY_CMD ""
>  #endif
>  
>  #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
> @@ -93,6 +112,7 @@
>  			"echo Running Recovery...;" \
>  			"mmc dev ${mmcdev};" \
>  			"setenv bootargs \"${bootargs} androidboot.serialno=${serial#}\";" \
> +			AVB_VERIFY_CHECK \
>  			"part start mmc ${mmcdev} " RECOVERY_PARTITION " boot_start;" \
>  			"part size mmc ${mmcdev} " RECOVERY_PARTITION " boot_size;" \
>  			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
> @@ -111,6 +131,7 @@
>  		"echo Loading Android " BOOT_PARTITION " partition...;" \
>  		"mmc dev ${mmcdev};" \
>  		"setenv bootargs ${bootargs} androidboot.serialno=${serial#};" \
> +		AVB_VERIFY_CHECK \
>  		"part start mmc ${mmcdev} " BOOT_PARTITION " boot_start;" \
>  		"part size mmc ${mmcdev} " BOOT_PARTITION " boot_size;" \
>  		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
> @@ -142,6 +163,8 @@
>  #define CONFIG_EXTRA_ENV_SETTINGS                                     \
>  	"partitions=" PARTS_DEFAULT "\0"                              \
>  	"mmcdev=2\0"                                                  \
> +	AVB_VERIFY_CMD                                                \
> +	"force_avb=0\0"                                               \
>  	"gpio_recovery=88\0"                                          \
>  	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
>  	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
