Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.11172.1628180480085314203
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:20 -0700
Received: by mail-wm1-f49.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso6757741wmg.4
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5hbYcNq4Yrjj7eyNHUZNHsE8J5AsqQkZnNfPmij0LI=;
        b=zPHWpDaU4OK6Cx+WXg2PhKWdOqmEQmV7GmS2Pm/+7yhVVxvpPfSHYVFHMmV59bE0qZ
         nN2sj7DXZUYwjZ3hhKgg5ILgIELOhNwdFqLyXvtKHi/xLJN+KEOj3d6ODgkQSUPalN72
         GDB3uAvrRDlyGevkM7yoCk4Cch9/V8OULkN98/pbEdC5xXimzDUDkTLlAjUFJNa6Yfov
         UuwJQVZojDFR+CplH8m4C5hPhDM3q50RIU6a+j/GxcHfJx+qm/6gKj5O8TB7xOihXhqz
         DS29QQAwKgSVdcLmh1GiF5mjExJBrJbVOB+EOmxRnd/4gGAHd9YVQ+U/PrR5mzna85ep
         0mPA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 6/9] configs: meson64_android: boot android via abootimg
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-7-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <448f032d-787f-0926-92e5-b096cc4f1274@baylibre.com>
Date: Thu, 5 Aug 2021 18:21:07 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-7-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> From: Guillaume La Roque <glaroque@baylibre.com>
> 
> Since Android 10, we are required to use a "dtbo" partition which
> includes the various device-tree overlays [1].
> It's also possible to provide a "dtb" partition.
> 
> This is supported via the "abootimg" command.
> 
> On Yukawa, the assumption is that we have only a "dtbo" partition, which
> includes all board dtbs and their dtbos [2]
> 
> [1] https://source.android.com/devices/architecture/dto/partitions
> [2] https://android.googlesource.com/device/amlogic/yukawa/+/refs/heads/master/build/tasks/dtimages.mk#16
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 57 ++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 0ce616c17e..358e0a5c71 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -81,7 +81,59 @@
>  #define RECOVERY_PARTITION "recovery"
>  #endif
>  
> +#if defined(CONFIG_CMD_ABOOTIMG)
> +/*
> + * Prepares complete device tree blob for current board (for Android boot).
> + *
> + * Boot image or recovery image should be loaded into $loadaddr prior to running
> + * these commands. The logic of these commnads is next:
> + *
> + *   1. Read correct DTB for current SoC/board from boot image in $loadaddr
> + *      to $fdtaddr
> + *   2. Merge all needed DTBO for current board from 'dtbo' partition into read
> + *      DTB
> + *   3. User should provide $fdtaddr as 3rd argument to 'bootm'
> + */
> +#define PREPARE_FDT \
> +	"echo Preparing FDT...; " \
> +	"if test $board_name = sei510; then " \
> +		"echo \"  Reading DTB for sei510...\"; " \
> +		"setenv dtb_index 0;" \
> +	"elif test $board_name = sei610; then " \
> +		"echo \"  Reading DTB for sei610...\"; " \
> +		"setenv dtb_index 1;" \
> +	"else " \
> +		"echo Error: Android boot is not supported for $board_name; " \
> +		"exit; " \
> +	"fi; " \
> +	"abootimg get dtb --index=$dtb_index dtb_start dtb_size; " \
> +	"cp.b $dtb_start $fdt_addr_r $dtb_size; " \
> +	"fdt addr $fdt_addr_r  0x80000; " \
> +	"if test $board_name = sei510; then " \
> +		"echo \"  Reading DTBO for sei510...\"; " \
> +		"setenv dtbo_index 0;" \
> +	"elif test $board_name = sei610; then " \
> +		"echo \"  Reading DTBO for sei610...\"; " \
> +		"setenv dtbo_index 1;" \
> +	"else " \
> +		"echo Error: Android boot is not supported for $board_name; " \
> +		"exit; " \
> +	"fi; " \
> +	"part start mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_start; " \
> +	"part size mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_size; " \
> +	"mmc read ${dtboaddr} ${p_dtbo_start} ${p_dtbo_size}; " \
> +	"echo \"  Applying DTBOs...\"; " \
> +	"adtimg addr $dtboaddr; " \
> +	"adtimg get dt --index=$dtbo_index dtbo0_addr; " \
> +	"fdt apply $dtbo0_addr;" \
> +	"setenv bootargs \"$bootargs androidboot.dtbo_idx=$dtbo_index \";"\
> +
> +#define BOOT_CMD "bootm ${loadaddr} ${loadaddr} ${fdt_addr_r};"
> +
> +#else
> +#define PREPARE_FDT " "
>  #define BOOT_CMD "bootm ${loadaddr};"
> +#endif
>  
>  #define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
>  	"bootcmd_fastboot=" \
> @@ -153,6 +205,7 @@
>  			"part start mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_start;" \
>  			"part size mmc ${mmcdev} " RECOVERY_PARTITION "${slot_suffix} boot_size;" \
>  			"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
> +				PREPARE_FDT \
>  				"echo Running Android Recovery...;" \
>  				BOOT_CMD \
>  			"fi;" \
> @@ -174,6 +227,7 @@
>  		"part start mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_start;" \
>  		"part size mmc ${mmcdev} " BOOT_PARTITION "${slot_suffix} boot_size;" \
>  		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
> +			PREPARE_FDT \
>  			"setenv bootargs \"${bootargs} " AB_BOOTARGS "\"  ; " \
>  			"echo Running Android...;" \
>  			BOOT_CMD \
> @@ -212,7 +266,8 @@
>  	"stdin=" STDIN_CFG "\0"                                       \
>  	"stdout=" STDOUT_CFG "\0"                                     \
>  	"stderr=" STDOUT_CFG "\0"                                     \
> -	"loadaddr=0x01000000\0"                                       \
> +	"dtboaddr=0x08200000\0"                                       \
> +	"loadaddr=0x01080000\0"                                       \
>  	"fdt_addr_r=0x01000000\0"                                     \
>  	"scriptaddr=0x08000000\0"                                     \
>  	"kernel_addr_r=0x01080000\0"                                  \
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
