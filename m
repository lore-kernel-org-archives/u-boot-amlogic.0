Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.7294.1627550559182986952
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 02:22:39 -0700
Received: by mail-wr1-f45.google.com with SMTP id b7so6039206wri.8
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8EK84UTVgr0D7nMyUp31RjSD3kEftHQLqfOa3V0NOY=;
        b=FaoxHqwu5XZb8IUOrTf21IyvwMmBL3lLYIZT365zLfug6PpfOZanLjy5/etrNixtIQ
         bGrAYqD3XYm36ovYv5AK6T0+Ts5c3ByI8sldC5SpbT93Z6xOV+glLXGEzE8A4sQLfthe
         yX4z/nHgRqrXrkX5OCNO1HasiYrcdt0TC024e40hF7dI/j6E+BT/lGtprqxe9L7rXqlC
         XtQDrsrBCmUZXbdmR9ykekjPr5rAQLv/RZt2M4ChE37STGQZkSt0wI4s/uxmR3j0uTpM
         5BMfoCqwraXEtWnkgpLohU27arOgJzP8sr9e7zOBtuQlxFGUYhl8V/+veFLs/hT6efw4
         /9zg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/6] configs: meson64_android: use boot part label instead of index
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
 <20210729072113.208099-5-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <519c9f93-58fd-1d9d-013a-10821e6c5aa4@baylibre.com>
Date: Thu, 29 Jul 2021 11:22:37 +0200
MIME-Version: 1.0
In-Reply-To: <20210729072113.208099-5-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2021 09:21, Mattijs Korpershoek wrote:
> To boot Android, we read the gpt and assume that the partition with
> index "1" will be the "boot" partition.
> 
> This might not always be the case, as there are no requirements from
> Android on the partition order.
> 
> However, Android does seem to use the "boot" label quite a lot on their
> public documentation [1]
> 
> Load the boot partition by label instead of by index
> 
> [1] https://source.android.com/devices/bootloader/partitions
> Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 4027a7fe0d..e22f05c889 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -9,6 +9,9 @@
>  #ifndef __MESON64_ANDROID_CONFIG_H
>  #define __MESON64_ANDROID_CONFIG_H
>  
> +#ifndef BOOT_PARTITION
> +#define BOOT_PARTITION "boot"
> +#endif
>  
>  #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
>  	"bootcmd_fastboot=" \
> @@ -77,11 +80,11 @@
>  
>  #define BOOTENV_DEV_SYSTEM(devtypeu, devtypel, instance) \
>  	"bootcmd_system=" \
> -		"echo Loading Android boot partition...;" \
> +		"echo Loading Android " BOOT_PARTITION " partition...;" \
>  		"mmc dev ${mmcdev};" \
>  		"setenv bootargs ${bootargs} console=${console} androidboot.serialno=${serial#};" \
> -		"part start mmc ${mmcdev} ${bootpart} boot_start;" \
> -		"part size mmc ${mmcdev} ${bootpart} boot_size;" \
> +		"part start mmc ${mmcdev} " BOOT_PARTITION " boot_start;" \
> +		"part size mmc ${mmcdev} " BOOT_PARTITION " boot_size;" \
>  		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
>  			"echo Running Android...;" \
>  			"bootm ${loadaddr};" \
> @@ -111,7 +114,6 @@
>  #define CONFIG_EXTRA_ENV_SETTINGS                                     \
>  	"partitions=" PARTS_DEFAULT "\0"                              \
>  	"mmcdev=2\0"                                                  \
> -	"bootpart=1\0"                                                \
>  	"logopart=2\0"                                                \
>  	"gpio_recovery=88\0"                                          \
>  	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
> 


Acked-by: Neil Armstrong <narmstrong@baylibre.com>
