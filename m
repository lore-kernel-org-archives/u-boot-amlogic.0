Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.7296.1627550574106153286
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 02:22:54 -0700
Received: by mail-wr1-f50.google.com with SMTP id d8so6044067wrm.4
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N5mv82+6uvEdd1UI47c0D3iqT0WCpVm/rYfDNHMncnA=;
        b=QnYQuKW48SuXxlm1/ggJQZPQzJJrc3+sD6sUrB7LfTjjtEuz81U602yOKH+8KGo87A
         5VY2+XmvjCP/3SDrc24bDMN6sugNLrwIOu4UJfHECcHMIIn8Wyup7Q+tQptGOWlEwSQT
         KKQ/nxZW7tsc5LT2Gaz7bHVlxIYXCZp5Z/MZoFmpI+vmh5w8utAl8fL8aaU1RkwlcARh
         mvgHzw/+FjvSWaJqmspXovD7pZmSAFsXoI2fD6qf5S0c+Bqms86Nn3JD0Izvq0iAZ43W
         rotmtGaCqesxBKS+tDFsD7CK4ZXZEilgW5OZQ0oCxw3GpHCkY8x9fA8nNwb2TJwL7vrI
         h0lQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 5/6] configs: meson64_android: use logo part label instead of index
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
 <20210729072113.208099-6-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <13e2b768-c713-65de-3805-930a7893ca59@baylibre.com>
Date: Thu, 29 Jul 2021 11:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <20210729072113.208099-6-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2021 09:21, Mattijs Korpershoek wrote:
> To display the bootup logo, we read the gpt and assume that the
> partition with index "2" will be the "logo" partition.
> 
> This might not always be the case, and it's very error-prone.
> 
> Load the logo partition by label instead of by index.
> 
> Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index e22f05c889..56545a72f8 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -13,6 +13,10 @@
>  #define BOOT_PARTITION "boot"
>  #endif
>  
> +#ifndef LOGO_PARTITION
> +#define LOGO_PARTITION "logo"
> +#endif
> +
>  #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
>  	"bootcmd_fastboot=" \
>  		"sm reboot_reason reason;" \
> @@ -104,8 +108,8 @@
>  	"if test \"${boot_source}\" != \"usb\" && " \
>  		"gpt verify mmc ${mmcdev} ${partitions}; then; " \
>  		"mmc dev ${mmcdev};" \
> -		"part start mmc ${mmcdev} ${logopart} boot_start;" \
> -		"part size mmc ${mmcdev} ${logopart} boot_size;" \
> +		"part start mmc ${mmcdev} " LOGO_PARTITION " boot_start;" \
> +		"part size mmc ${mmcdev} " LOGO_PARTITION " boot_size;" \
>  		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
>  			"bmp display ${loadaddr} m m;" \
>  		"fi;" \
> @@ -114,7 +118,6 @@
>  #define CONFIG_EXTRA_ENV_SETTINGS                                     \
>  	"partitions=" PARTS_DEFAULT "\0"                              \
>  	"mmcdev=2\0"                                                  \
> -	"logopart=2\0"                                                \
>  	"gpio_recovery=88\0"                                          \
>  	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
>  	"load_logo=" PREBOOT_LOAD_LOGO "\0"			      \
> 


Acked-by: Neil Armstrong <narmstrong@baylibre.com>
