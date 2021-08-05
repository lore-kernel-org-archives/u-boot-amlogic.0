Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web08.11169.1628180478538853306
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:18 -0700
Received: by mail-wm1-f44.google.com with SMTP id l8-20020a05600c1d08b02902b5acf7d8b5so3401753wms.2
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Db7gAnkiq5WcyfHH1LbMJPt+6zUN1AABzXG+jubz9rc=;
        b=zRPaUHFwVENCnKRws8o5cbbDi7GoZIS2fWb9bXWwfVu7Cc1bADtdVHccLiNqtjU46U
         /qayFQmmtezVRT6gSTtG5QM55Eagct/USQVBYjyw3XxYvbs7pnc23k15nx6QTApFExrV
         N7bNkjl7BE79irj+MRpMa1B6LEZRX3c49HsYXzRfVmxvITIdfvKFVf0C60n5blybriY5
         fp3Z0jQtsqWNqwx15Rq8GLzgX6O79grtVZb01CG6tl0XteQOopA0B3iAqkiIZNJzr6/0
         8jv5/O1iI5iWLEeAG4OjSRQnSlpgkr2epsroNARnrEuMWH4YIvzPHv/mt1NEPIICZWsl
         bq3w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 5/9] configs: meson64_android: define BOOT_CMD macro
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-6-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <835219db-78ee-92ac-746b-0fd0750da8fb@baylibre.com>
Date: Thu, 5 Aug 2021 18:21:05 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-6-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> BOOT_CMD might be different based on CONFIG_CMD_ABOOTIMG.
> 
> To prepare for abootimg support, extract the boot command
> to a dedicated macro.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 83fa25bfb1..0ce616c17e 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -81,6 +81,8 @@
>  #define RECOVERY_PARTITION "recovery"
>  #endif
>  
> +#define BOOT_CMD "bootm ${loadaddr};"
> +
>  #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
>  	"bootcmd_fastboot=" \
>  		"setenv run_fastboot 0;" \
> @@ -152,7 +154,7 @@
>  			"part size mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_size;" \
>  			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
>  				"echo Running Android Recovery...;" \
> -				"bootm ${loadaddr};" \
> +				BOOT_CMD \
>  			"fi;" \
>  			"echo Failed to boot Android...;" \
>  			"reset;" \
> @@ -174,7 +176,7 @@
>  		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
>  			"setenv bootargs \"${bootargs} " AB_BOOTARGS "\"  ; " \
>  			"echo Running Android...;" \
> -			"bootm ${loadaddr};" \
> +			BOOT_CMD \
>  		"fi;" \
>  		"echo Failed to boot Android...;" \
>  		"reset\0"
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
