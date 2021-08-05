Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web08.11183.1628180503710273260
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 09:21:44 -0700
Received: by mail-wr1-f48.google.com with SMTP id z4so7303262wrv.11
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wIB75vnWqdaBOSMBHSUVMLEvvb5pX5jj8YUeyJgrX60=;
        b=IL7Gb4rvH+cDAo+IS7pdfDZAiR6sApFrMnGJsa66q5AzPIZ3cBKj9xtHWYzhMGcRzX
         8FrHE3Q5x8tJzqAju7cPtHdphNn/mNJoYl0tBOhtXT41wwjIQSu1XEPpimKSKNG5HtAk
         TybU0r45RM7mj1al5g60OickdVy1MYe19/WZUTPPZtAmO6tfrvQWLp+bMEPFC5plwzAY
         ZIkpJhOPLXkmd6gP1JxbFFJXg+pu4BROK6aA3xamYvj3cmXhoEy5BfZzR5dUa8bbHWbM
         X9F4jjPwSJXyO007cY+aCWPW6CcNyTmknTuCmb5+e4a2JmtxhK9RpWMOgVfRMOzFdb+B
         xdcA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 9/9] configs: sei510/610: android bootflow via abootimg
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
 <20210805151728.422329-10-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f52aeb6a-60ec-765d-64e1-788d4bd33098@baylibre.com>
Date: Thu, 5 Aug 2021 18:21:14 +0200
MIME-Version: 1.0
In-Reply-To: <20210805151728.422329-10-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/08/2021 17:17, Mattijs Korpershoek wrote:
> From: Guillaume La Roque <glaroque@baylibre.com>
> 
> Activate the following Kconfig options:
> * AVB       for Android Verified Boot support
> * ADTIMG    for merging DTBOs
> * ABOOTIMG  for extracting Android boot image
> 
> Also rework the partitioning tables:
> - add a misc partition to handle BCB messages
> - add a dtbo partition to store various DTBOs
> - add a vbmeta partition for AVB hashes
> - Merge vendor and system into the "super" partition
> 
> Note: avb support is disables by default. To activate it:
>  => setenv force_avb 1;
>  => saveenv;
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  configs/sei510_defconfig |  5 +++++
>  configs/sei610_defconfig |  5 +++++
>  include/configs/sei510.h | 11 +++++++----
>  include/configs/sei610.h | 13 ++++++++-----
>  4 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
> index 74328f2fd4..8099b40b55 100644
> --- a/configs/sei510_defconfig
> +++ b/configs/sei510_defconfig
> @@ -20,7 +20,10 @@ CONFIG_PREBOOT="run load_logo"
>  # CONFIG_CONSOLE_MUX is not set
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
> +CONFIG_AVB_VERIFY=y
>  # CONFIG_CMD_BDI is not set
> +CONFIG_CMD_ADTIMG=y
> +CONFIG_CMD_ABOOTIMG=y
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_BCB=y
>  CONFIG_CMD_GPIO=y
> @@ -32,6 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_BMP=y
>  CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> @@ -84,4 +88,5 @@ CONFIG_VIDEO_BMP_RLE8=y
>  CONFIG_BMP_16BPP=y
>  CONFIG_BMP_24BPP=y
>  CONFIG_BMP_32BPP=y
> +CONFIG_LIBAVB=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
> index 2a6d0e5995..e11f36ac79 100644
> --- a/configs/sei610_defconfig
> +++ b/configs/sei610_defconfig
> @@ -20,7 +20,10 @@ CONFIG_PREBOOT="run load_logo"
>  # CONFIG_CONSOLE_MUX is not set
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_MISC_INIT_R=y
> +CONFIG_AVB_VERIFY=y
>  # CONFIG_CMD_BDI is not set
> +CONFIG_CMD_ADTIMG=y
> +CONFIG_CMD_ABOOTIMG=y
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_BCB=y
>  CONFIG_CMD_GPIO=y
> @@ -32,6 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_BMP=y
>  CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_AVB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> @@ -84,4 +88,5 @@ CONFIG_VIDEO_BMP_RLE8=y
>  CONFIG_BMP_16BPP=y
>  CONFIG_BMP_24BPP=y
>  CONFIG_BMP_32BPP=y
> +CONFIG_LIBAVB=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/include/configs/sei510.h b/include/configs/sei510.h
> index 5bf2668803..ea91a06157 100644
> --- a/include/configs/sei510.h
> +++ b/include/configs/sei510.h
> @@ -14,12 +14,15 @@
>  
>  #define PARTS_DEFAULT \
>  	"uuid_disk=${uuid_gpt_disk};" \
> -	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
>  	"name=logo,size=2M,uuid=" LOGO_UUID \
> +	"name=misc,size=128K,uuid=${uuid_gpt_misc};" \
> +	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
> +	"name=vbmeta,size=64K,uuid=${uuid_gpt_vbmeta};" \
> +	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
> +	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
>  	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
> -	"name=system,size=1536M,uuid=${uuid_gpt_system};" \
> -	"name=vendor,size=256M,uuid=${uuid_gpt_vendor};" \
> -	"name=userdata,size=5341M,uuid={uuid_gpt_userdata};" \
> +	"name=super,size=2304M,uuid=${uuid_gpt_super};" \
> +	"name=userdata,size=4820M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  
>  
> diff --git a/include/configs/sei610.h b/include/configs/sei610.h
> index baace75a02..783eece271 100644
> --- a/include/configs/sei610.h
> +++ b/include/configs/sei610.h
> @@ -14,12 +14,15 @@
>  
>  #define PARTS_DEFAULT \
>  	"uuid_disk=${uuid_gpt_disk};" \
> -	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
> -	"name=logo,size=2M,uuid=" LOGO_UUID \
> +	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
> +	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
> +	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
> +	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
> +	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
> +	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
>  	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
> -	"name=system,size=1536M,uuid=${uuid_gpt_system};" \
> -	"name=vendor,size=256M,uuid=${uuid_gpt_vendor};" \
> -	"name=userdata,size=12795M,uuid=${uuid_gpt_userdata};" \
> +	"name=super,size=2304M,uuid=${uuid_gpt_super};" \
> +	"name=userdata,size=12274M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  
>  #include <configs/meson64_android.h>
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
