Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.11130.1628180478884927879
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:19 -0700
Received: by mail-wr1-f41.google.com with SMTP id p5so7338946wro.7
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPdaWT+JzzDUe7qsRK7jjsme9Y1i7NtcKl3QyMm+cwM=;
        b=iC0djHS1oCBlhuvh3cRBD9Bgl3fkQ4V11lFkllpslgPQq3mheRA0N9REsGa2jbUkyX
         pp7YesKWSyZ1x4B91f5izJS+Ap6sWhr9rKAB8IAovadFz2XRd69EfMMGnT7BNPJIe22n
         +ZKg476BjFxD3mQbam//FPvIgKtmv43NdITWDDWr0liRkVZ/LuJTiJw076JvH6HFg0/k
         HvOFFEeL9kgoE84+s1cPuqEdJaVuIk2nKPcMZqL2K7u+h1SO/zI099cYsjAX+/ByF5/y
         R8oKiBv16Hjt68/IyiVlE3Fu0DXU4Q9VL3jO2xDh6nNVJQsKnPt9QCDqtJ0k2lpUcFL/
         WwMQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/9] configs: meson64_android: implement A/B slot support
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-5-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c16e95a2-599a-543a-09d3-24b82e19aeb8@baylibre.com>
Date: Thu, 5 Aug 2021 18:21:02 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-5-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> Implement A/B slot selection using the U-Boot ab_select command.
> 
> Keep support for non A/B.
> 
> Not: We need to redefine the recovery partition label, as RecoveryOS
> is included in the boot image for A/B systems [1]
> 
> [1] https://source.android.com/devices/tech/ota/ab/ab_implement#recovery
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 55 ++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 48a23b6e41..83fa25bfb1 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -25,9 +25,6 @@
>  #define CONTROL_PARTITION "misc"
>  #endif
>  
> -#ifndef RECOVERY_PARTITION
> -#define RECOVERY_PARTITION "recovery"
> -
>  #if defined(CONFIG_CMD_AVB)
>  #define AVB_VERIFY_CHECK \
>  	"if test \"${force_avb}\" -eq 1; then " \
> @@ -42,12 +39,48 @@
>  		"echo Running without AVB...; "\
>  	"fi;"
>  
> -#define AVB_VERIFY_CMD "avb_verify=avb init ${mmcdev}; avb verify;\0"
> +#define AVB_VERIFY_CMD "avb_verify=avb init ${mmcdev}; avb verify $slot_suffix;\0"
>  #else
>  #define AVB_VERIFY_CHECK ""
>  #define AVB_VERIFY_CMD ""
>  #endif
>  
> +#if defined(CONFIG_CMD_AB_SELECT)
> +#define ANDROIDBOOT_GET_CURRENT_SLOT_CMD "get_current_slot=" \
> +	"if part number mmc ${mmcdev} " CONTROL_PARTITION " control_part_number; " \
> +	"then " \
> +		"echo " CONTROL_PARTITION \
> +			" partition number:${control_part_number};" \
> +		"ab_select current_slot mmc ${mmcdev}:${control_part_number};" \
> +	"else " \
> +		"echo " CONTROL_PARTITION " partition not found;" \
> +	"fi;\0"
> +
> +#define AB_SELECT_SLOT \
> +	"run get_current_slot; " \
> +	"if test -e \"${current_slot}\"; " \
> +	"then " \
> +		"setenv slot_suffix _${current_slot}; " \
> +	"else " \
> +		"echo current_slot not found;" \
> +		"exit;" \
> +	"fi;"
> +
> +#define AB_SELECT_ARGS \
> +	"setenv bootargs_ab androidboot.slot_suffix=${slot_suffix}; " \
> +	"echo A/B cmdline addition: ${bootargs_ab};" \
> +	"setenv bootargs ${bootargs} ${bootargs_ab};"
> +
> +#define AB_BOOTARGS " androidboot.force_normal_boot=1"
> +#define RECOVERY_PARTITION "boot"
> +#else
> +#define AB_SELECT_SLOT ""
> +#define AB_SELECT_ARGS " "
> +#define ANDROIDBOOT_GET_CURRENT_SLOT_CMD ""
> +#define AB_BOOTARGS " "
> +#define RECOVERY_PARTITION "recovery"
> +#endif
> +
>  #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
>  	"bootcmd_fastboot=" \
>  		"setenv run_fastboot 0;" \
> @@ -112,9 +145,11 @@
>  			"echo Running Recovery...;" \
>  			"mmc dev ${mmcdev};" \
>  			"setenv bootargs \"${bootargs} androidboot.serialno=${serial#}\";" \
> +			AB_SELECT_SLOT \
> +			AB_SELECT_ARGS \
>  			AVB_VERIFY_CHECK \
> -			"part start mmc ${mmcdev} " RECOVERY_PARTITION " boot_start;" \
> -			"part size mmc ${mmcdev} " RECOVERY_PARTITION " boot_size;" \
> +			"part start mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_start;" \
> +			"part size mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_size;" \
>  			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
>  				"echo Running Android Recovery...;" \
>  				"bootm ${loadaddr};" \
> @@ -131,10 +166,13 @@
>  		"echo Loading Android " BOOT_PARTITION " partition...;" \
>  		"mmc dev ${mmcdev};" \
>  		"setenv bootargs ${bootargs} androidboot.serialno=${serial#};" \
> +		AB_SELECT_SLOT \
> +		AB_SELECT_ARGS \
>  		AVB_VERIFY_CHECK \
> -		"part start mmc ${mmcdev} " BOOT_PARTITION " boot_start;" \
> -		"part size mmc ${mmcdev} " BOOT_PARTITION " boot_size;" \
> +		"part start mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_start;" \
> +		"part size mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_size;" \
>  		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
> +			"setenv bootargs \"${bootargs} " AB_BOOTARGS "\"  ; " \
>  			"echo Running Android...;" \
>  			"bootm ${loadaddr};" \
>  		"fi;" \
> @@ -163,6 +201,7 @@
>  #define CONFIG_EXTRA_ENV_SETTINGS                                     \
>  	"partitions=" PARTS_DEFAULT "\0"                              \
>  	"mmcdev=2\0"                                                  \
> +	ANDROIDBOOT_GET_CURRENT_SLOT_CMD                              \
>  	AVB_VERIFY_CMD                                                \
>  	"force_avb=0\0"                                               \
>  	"gpio_recovery=88\0"                                          \
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
