Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web09.3823.1637569088650268653
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 00:18:09 -0800
Received: by mail-wm1-f43.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so12812622wmb.5
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 00:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ROyz7/luHFKvLdz3YXzWwjWtrCjVARUP0WV1tZLkzuQ=;
        b=JB+Gg2wjphDFxKii5UcebBzd/o5swNuMS0tSDY3Z1rKGdCcmgBJAgC7k/70oEsCxro
         rZmfqm1YxcnvoTHSAH7haJZxs92QT9Y734XYDyDYYNCH8WIMFznHMVsNR1oyfznoicLo
         A1ZNHSOb97JwD35v1DhcwQSLyztb7FSXqCBIOF9HmQEgVLt5CxhY52yt+lpY7IBCnp0z
         BIVO7GTm99Oa+QmEworU9V7HZjxNPFXifakONMRLuHdOthdj0goB57jSf8ctSq7Ok5hQ
         e3Anmu8ptN9QrezgqD9T3il+j+l/PB8flBsrriidNnLYrxo5FmCglvULctVZmoK/XPKJ
         jQpA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 5/5] configs: khadas-vim3{l}_android_ab: enable A/B support
References: <20211119100829.843139-1-mkorpershoek@baylibre.com>
 <20211119100829.843139-6-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c1056a56-2f5a-c453-68e7-d7352c0108ff@baylibre.com>
Date: Mon, 22 Nov 2021 09:18:05 +0100
MIME-Version: 1.0
In-Reply-To: <20211119100829.843139-6-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 19/11/2021 11:08, Mattijs Korpershoek wrote:
> meson64_android.h also relies on CMD_AB_SELECT so enable that as well.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  configs/khadas-vim3_android_ab_defconfig  |  2 ++
>  configs/khadas-vim3l_android_ab_defconfig |  2 ++
>  include/configs/khadas-vim3_android.h     | 16 ++++++++++++++++
>  include/configs/khadas-vim3l_android.h    | 16 ++++++++++++++++
>  4 files changed, 36 insertions(+)
> 
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index 9305a54b1b..88325c37db 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -17,6 +17,7 @@ CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
>  CONFIG_AVB_VERIFY=y
> +CONFIG_ANDROID_AB=y
>  # CONFIG_CMD_BDI is not set
>  CONFIG_CMD_ADTIMG=y
>  CONFIG_CMD_ABOOTIMG=y
> @@ -33,6 +34,7 @@ CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_AB_SELECT=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 5eed79b263..608b54dca2 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -17,6 +17,7 @@ CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
>  CONFIG_AVB_VERIFY=y
> +CONFIG_ANDROID_AB=y
>  # CONFIG_CMD_BDI is not set
>  CONFIG_CMD_ADTIMG=y
>  CONFIG_CMD_ABOOTIMG=y
> @@ -33,6 +34,7 @@ CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_AB_SELECT=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index a6f6dd0a7a..da6adf6c41 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -12,6 +12,21 @@
>  #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
>  #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
>  
> +#if defined(CONFIG_CMD_AB_SELECT)
> +#define PARTS_DEFAULT \
> +	"uuid_disk=${uuid_gpt_disk};" \
> +	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
> +	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
> +	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
> +	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
> +	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
> +	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
> +	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
> +	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
> +	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
> +	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
> +	"name=rootfs,size=-,uuid=" ROOT_UUID
> +#else
>  #define PARTS_DEFAULT \
>  	"uuid_disk=${uuid_gpt_disk};" \
>  	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
> @@ -24,6 +39,7 @@
>  	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
>  	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
> +#endif
>  
>  #define EXTRA_ANDROID_ENV_SETTINGS \
>  	"board=vim3\0" \
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index 7affc3e448..b1768e2d82 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -12,6 +12,21 @@
>  #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
>  #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
>  
> +#if defined(CONFIG_CMD_AB_SELECT)
> +#define PARTS_DEFAULT \
> +	"uuid_disk=${uuid_gpt_disk};" \
> +	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
> +	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
> +	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
> +	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
> +	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
> +	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
> +	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
> +	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
> +	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
> +	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
> +	"name=rootfs,size=-,uuid=" ROOT_UUID
> +#else
>  #define PARTS_DEFAULT \
>  	"uuid_disk=${uuid_gpt_disk};" \
>  	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
> @@ -24,6 +39,7 @@
>  	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
>  	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
> +#endif
>  
>  #define EXTRA_ANDROID_ENV_SETTINGS \
>  	"board=vim3l\0" \
> 


You should move this khadas-vim3l_android.h change adding AB support before adding defconfig for AB,
move this patch in position 4 and add CONFIG_*AB*=y in the XXXXX_android_ab_defconfig configs
you add.

Neil
