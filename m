Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.3937.1637569124536035863
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 00:18:45 -0800
Received: by mail-wm1-f44.google.com with SMTP id o29so14433321wms.2
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 00:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XgX6l22LMNlc3tCDr9JTwg2CXvxCZ+OOjMFfDSEiyig=;
        b=WHvYFK4BaiH/mrtTdQRZRcAytMW82d4tnnmh9VVS/t/LsmW+XOA/8kvIa1yUuKMFDA
         fQhzy9GfHa2KMcKd5fTzovmx40GTttNI/KzbxTKalMQVZSuNzV4ObbhDhGMcdh/ggPyS
         hfkkhJ/8IQDWZ+P0ykDDmK2x0mdTpEzjiepYgjS+szoM8bEWnQBFp4UV26CU6J2+6ZtT
         UiXtkY9MVaSFry6AEcTPcn+75mK5TproPZT4+oL20GZvk70cj+fAF7anGW3MnYJKqlLm
         Lq28mFYzFFLDcMuzgaYEPf+7DohyuO/GyyJYbQHYFMxUSpoC+w+HoMiZvQTrjcWBA5n8
         2ArQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/5] boards: meson: add khadas vim3{l} android support
References: <20211119100829.843139-1-mkorpershoek@baylibre.com>
 <20211119100829.843139-4-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f6536b8b-08d9-2824-c437-7a3078701c29@baylibre.com>
Date: Mon, 22 Nov 2021 09:18:42 +0100
MIME-Version: 1.0
In-Reply-To: <20211119100829.843139-4-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 19/11/2021 11:08, Mattijs Korpershoek wrote:
> Add all the necessary bits to flash and boot Android for both Khadas
> VIM3 and VIM3L boards.
> 
> For Android instructions, refer to [1]
> 
> [1] https://source.android.com/setup/build/devices#vim3_and_vim3l_boards
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  configs/khadas-vim3_android_defconfig  | 16 ++++++++++--
>  configs/khadas-vim3l_android_defconfig | 16 ++++++++++--
>  include/configs/khadas-vim3_android.h  | 34 ++++++++++++++++++++++++++
>  include/configs/khadas-vim3l_android.h | 34 ++++++++++++++++++++++++++
>  include/configs/meson64_android.h      | 12 +++++++++
>  5 files changed, 108 insertions(+), 4 deletions(-)
>  create mode 100644 include/configs/khadas-vim3_android.h
>  create mode 100644 include/configs/khadas-vim3l_android.h
> 
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index a225a564b2..9305a54b1b 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -1,9 +1,10 @@
>  CONFIG_ARM=y
>  CONFIG_SYS_BOARD="vim3"
> +CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
>  CONFIG_ARCH_MESON=y
>  CONFIG_SYS_TEXT_BASE=0x01000000
>  CONFIG_NR_DRAM_BANKS=1
> -CONFIG_ENV_SIZE=0x2000
> +CONFIG_ENV_SIZE=0x10000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
>  CONFIG_MESON_G12A=y
> @@ -15,9 +16,14 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
> +CONFIG_AVB_VERIFY=y
>  # CONFIG_CMD_BDI is not set
> +CONFIG_CMD_ADTIMG=y
> +CONFIG_CMD_ABOOTIMG=y
>  # CONFIG_CMD_IMI is not set
> +CONFIG_CMD_BCB=y
>  CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
> @@ -28,6 +34,7 @@ CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_NET_RANDOM_ETHADDR=y
> @@ -35,6 +42,11 @@ CONFIG_ADC=y
>  CONFIG_SARADC_MESON=y
>  CONFIG_BUTTON=y
>  CONFIG_BUTTON_ADC=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x6000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=2
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_MESON=y
>  CONFIG_MMC_MESON_GX=y
> @@ -79,7 +91,6 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
>  CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
> -CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_DM_VIDEO=y
>  # CONFIG_VIDEO_BPP8 is not set
>  # CONFIG_VIDEO_BPP16 is not set
> @@ -92,4 +103,5 @@ CONFIG_VIDEO_BMP_RLE8=y
>  CONFIG_BMP_16BPP=y
>  CONFIG_BMP_24BPP=y
>  CONFIG_BMP_32BPP=y
> +CONFIG_LIBAVB=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 9d94c31891..5eed79b263 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -1,9 +1,10 @@
>  CONFIG_ARM=y
>  CONFIG_SYS_BOARD="vim3"
> +CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
>  CONFIG_ARCH_MESON=y
>  CONFIG_SYS_TEXT_BASE=0x01000000
>  CONFIG_NR_DRAM_BANKS=1
> -CONFIG_ENV_SIZE=0x2000
> +CONFIG_ENV_SIZE=0x10000
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
>  CONFIG_MESON_G12A=y
> @@ -15,9 +16,14 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
> +CONFIG_AVB_VERIFY=y
>  # CONFIG_CMD_BDI is not set
> +CONFIG_CMD_ADTIMG=y
> +CONFIG_CMD_ABOOTIMG=y
>  # CONFIG_CMD_IMI is not set
> +CONFIG_CMD_BCB=y
>  CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
> @@ -28,6 +34,7 @@ CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_NET_RANDOM_ETHADDR=y
> @@ -35,6 +42,11 @@ CONFIG_ADC=y
>  CONFIG_SARADC_MESON=y
>  CONFIG_BUTTON=y
>  CONFIG_BUTTON_ADC=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x6000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=2
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_MESON=y
>  CONFIG_MMC_MESON_GX=y
> @@ -79,7 +91,6 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
>  CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
> -CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_DM_VIDEO=y
>  # CONFIG_VIDEO_BPP8 is not set
>  # CONFIG_VIDEO_BPP16 is not set
> @@ -92,4 +103,5 @@ CONFIG_VIDEO_BMP_RLE8=y
>  CONFIG_BMP_16BPP=y
>  CONFIG_BMP_24BPP=y
>  CONFIG_BMP_32BPP=y
> +CONFIG_LIBAVB=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> new file mode 100644
> index 0000000000..a6f6dd0a7a
> --- /dev/null
> +++ b/include/configs/khadas-vim3_android.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Configuration for the khadas VIM3 Android
> + *
> + * Copyright (C) 2021 Baylibre, SAS
> + * Author: Guillaume LA ROQUE <glaroque@baylibre.com>
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
> +#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
> +
> +#define PARTS_DEFAULT \
> +	"uuid_disk=${uuid_gpt_disk};" \
> +	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
> +	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
> +	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
> +	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
> +	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
> +	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
> +	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
> +	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
> +	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
> +	"name=rootfs,size=-,uuid=" ROOT_UUID
> +
> +#define EXTRA_ANDROID_ENV_SETTINGS \
> +	"board=vim3\0" \
> +	"board_name=vim3\0" \
> +
> +#include <configs/meson64_android.h>
> +
> +#endif /* __CONFIG_H */
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> new file mode 100644
> index 0000000000..7affc3e448
> --- /dev/null
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Configuration for the khadas VIM3L Android
> + *
> + * Copyright (C) 2021 Baylibre, SAS
> + * Author: Guillaume LA ROQUE <glaroque@baylibre.com>
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
> +#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
> +
> +#define PARTS_DEFAULT \
> +	"uuid_disk=${uuid_gpt_disk};" \
> +	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
> +	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
> +	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
> +	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
> +	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
> +	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
> +	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
> +	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
> +	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
> +	"name=rootfs,size=-,uuid=" ROOT_UUID
> +
> +#define EXTRA_ANDROID_ENV_SETTINGS \
> +	"board=vim3l\0" \
> +	"board_name=vim3l\0" \
> +
> +#include <configs/meson64_android.h>
> +
> +#endif /* __CONFIG_H */
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 56dc9fcb07..0303d187de 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -104,6 +104,12 @@
>  	"elif test $board_name = sei610; then " \
>  		"echo \"  Reading DTB for sei610...\"; " \
>  		"setenv dtb_index 1;" \
> +	"elif test $board_name = vim3l; then " \
> +		"echo \"  Reading DTB for vim3l...\"; " \
> +		"setenv dtb_index 2;" \
> +	"elif test $board_name = vim3; then " \
> +		"echo \"  Reading DTB for vim3...\"; " \
> +		"setenv dtb_index 3;" \
>  	"else " \
>  		"echo Error: Android boot is not supported for $board_name; " \
>  		"exit; " \
> @@ -117,6 +123,12 @@
>  	"elif test $board_name = sei610; then " \
>  		"echo \"  Reading DTBO for sei610...\"; " \
>  		"setenv dtbo_index 1;" \
> +	"elif test $board_name = vim3l; then " \
> +		"echo \"  Reading DTBO for vim3l...\"; " \
> +		"setenv dtbo_index 2;" \
> +	"elif test $board_name = vim3; then " \
> +		"echo \"  Reading DTBO for vim3...\"; " \
> +		"setenv dtbo_index 3;" \
>  	"else " \
>  		"echo Error: Android boot is not supported for $board_name; " \
>  		"exit; " \
> 

I think you should squash this one with the previous one.

Neil
