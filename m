Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C154D2C548
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 12:44:15 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.17232.1729601045554757098
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Oct 2024 05:44:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=zrdjZwHg;
 spf=pass (domain: baylibre.com, ip: 209.85.128.51, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so51255465e9.1
        for <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729601044; x=1730205844; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnndWNwRsL1q8HvAW3FI4EMo0HeD8M4loMRst/Y8j+4=;
        b=zrdjZwHgJGrV3+In8K67nGazV62mDKjWnHJlGaUsuTWwuLLlNTs6rE8Q1AyH97ys5b
         pJ4KAprQOxKCQO2HLWCEtVblgfDUyAXjH/gbRNEEJZtQG825fQBQ48MmRiVE/7a+631I
         hJAY7S+q8p0abensVNcLU30pNNdiO8pOarJfc1evfZkwd06LDF2cLEIxyye1Py1fxW2l
         6h0HkbxvntKgBcDJw/WN5N3ug+DbqZk8SQSTq3BvD1erjFJ63FFG02YmsUHLeLnPmOwY
         /Ana2dnejuansPfgqd2LrQSutl7TjLYjcWNuF/5dO3Ht6R1sK1AYve7Q1iSzWVLKlopg
         Ka9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729601044; x=1730205844;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnndWNwRsL1q8HvAW3FI4EMo0HeD8M4loMRst/Y8j+4=;
        b=f3DH78iB5mUVoh0kHGXF+OBxLt4eBr+qInrNnL+Kn9382irV7sUhUu2EidmU8S2CcN
         AwhoBfzwH8/UgIKo1kUmXkADc1hDB0Ye2fmXXg9JvimzYhVAhM5k+cDTQPRYxcX3cjAc
         ZF3DQ3SZPpmaNgumNgklOkK8SmJj0gfCcsH4xd4DJOBXfecGoq4AmJYvroRW1Gh4dGk/
         mKDNN4Py6Ls6WzFywlzLldIj9XhpyFIKaid5ruLjTCvApP+DOLAN3dyJIyfVwJMKTxMz
         DdxDfJpXMh3DkFnTMqIMOlPTipRM76LlnLwzgbG3Ro3jujBnRm8LdBNcwsrR4aWSdLHl
         Ddyg==
X-Forwarded-Encrypted: i=1; AJvYcCWt+8QxH+MwaBQysu03y1TlF5zUCwnrUOzqnBe/TZKEmws8mbdnoG8OBSMomqM8QDHf5ke7JgOi3W7N77bIuQ==@groups.io
X-Gm-Message-State: AOJu0YxNPA6u9iUChTSsiAOHgzuV6A//SoECBbnTc4LDC1Jr+0/5RPNz
	cdqxgTdgt+e+MxSMTL7ZvtWclH7NY/6yYgAR+Bcar8tK9ZQUBKUINyZIfWuahjw=
X-Google-Smtp-Source: AGHT+IGOnkc82nBls6tNCvq1352Sfvcu1ltRgMwkAF/KKa8wz7+ZgfsWBJqpisVgm4M29jYoqiShmg==
X-Received: by 2002:a05:600c:674a:b0:42f:8229:a0a1 with SMTP id 5b1f17b1804b1-431616adba5mr108854245e9.33.1729601043935;
        Tue, 22 Oct 2024 05:44:03 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a58cc2sm6559144f8f.54.2024.10.22.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 05:44:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 4/6] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
In-Reply-To: <20241017-adnroidv2-v1-4-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-4-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 14:43:52 +0200
Message-ID: <871q08wbnb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 12:44:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2514

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Actually khadas vim3l use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3l android.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
>  configs/khadas-vim3l_android_defconfig    |  7 ++++++-
>  include/configs/khadas-vim3l_android.h    | 29 +++++++++++++++++++++++++----
>  3 files changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 4d7b90f23002..43db61056baf 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
> +# CONFIG_BOOTMETH_EXTLINUX is not set
> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
> +# CONFIG_BOOTMETH_EFILOADER is not set
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +# CONFIG_BOOTMETH_VBE is not set
>  CONFIG_LEGACY_IMAGE_FORMAT=y
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> @@ -35,7 +41,6 @@ CONFIG_SYS_MAXARGS=32
>  CONFIG_CMD_ADTIMG=y
>  CONFIG_CMD_ABOOTIMG=y
>  # CONFIG_CMD_IMI is not set
> -CONFIG_CMD_BCB=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 4ec27262cdc7..32d57a5b9090 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
> +# CONFIG_BOOTMETH_EXTLINUX is not set
> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
> +# CONFIG_BOOTMETH_EFILOADER is not set
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +# CONFIG_BOOTMETH_VBE is not set
>  CONFIG_LEGACY_IMAGE_FORMAT=y
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> @@ -34,7 +40,6 @@ CONFIG_SYS_MAXARGS=32
>  CONFIG_CMD_ADTIMG=y
>  CONFIG_CMD_ABOOTIMG=y
>  # CONFIG_CMD_IMI is not set
> -CONFIG_CMD_BCB=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index f39a3782d663..4455898b5262 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -26,6 +26,7 @@
>  	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
>  	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
> +

nit: un-necessary change here?

>  #else
>  #define PARTS_DEFAULT \
>  	"uuid_disk=${uuid_gpt_disk};" \
> @@ -39,12 +40,32 @@
>  	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
>  	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
> +

nit: un-necessary change here?

>  #endif
>  
> -#define EXTRA_ANDROID_ENV_SETTINGS \
> -	"board=vim3l\0" \
> -	"board_name=vim3l\0" \
> +#define CFG_EXTRA_ENV_SETTINGS                                    \
> +	"board=vim3l\0"                                               \
> +	"board_name=vim3l\0"                                          \
> +	"bootmeths=android\0"                                         \
> +	"bootcmd=bootflow scan\0"                                     \
> +	"adtb_idx=2\0"                                                \
> +	"partitions=" PARTS_DEFAULT "\0"                              \
> +	"mmcdev=2\0"                                                  \
> +	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
> +	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
> +	"gpio_recovery=88\0"                                          \
> +	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \

What is check_button needed for ?
It's used in include/configs/meson64_android.h to check if we should
boot recovery but since we no longer use that file here I think we can
safely remove this.

> +	"stdin=" STDIN_CFG "\0"                                       \
> +	"stdout=" STDOUT_CFG "\0"                                     \
> +	"stderr=" STDOUT_CFG "\0"                                     \
> +	"dtboaddr=0x08200000\0"                                       \
> +	"loadaddr=0x01080000\0"                                       \
> +	"fdt_addr_r=0x01000000\0"                                     \
> +	"scriptaddr=0x08000000\0"                                     \
> +	"kernel_addr_r=0x01080000\0"                                  \
> +	"pxefile_addr_r=0x01080000\0"                                 \
> +	"ramdisk_addr_r=0x13000000\0"                                 \
>  
> -#include <configs/meson64_android.h>

Should we also patch configs/meson64_android.h to remove everything
related to VIM3L? This way, we don't keep unused code in there.

> +#include <configs/meson64.h>
>  
>  #endif /* __CONFIG_H */
>
> -- 
> 2.34.1

