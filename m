Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41555D2C549
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 12:46:45 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.17278.1729601202414098078
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Oct 2024 05:46:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=xpR6onar;
 spf=pass (domain: baylibre.com, ip: 209.85.128.49, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43161c0068bso41788075e9.1
        for <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729601201; x=1730206001; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LBoyQ6YybvW2ed3USuSGHRo92Y/y9rMgOfXSEGyDSpo=;
        b=xpR6onarMdbqZRoHZdIlPBoGjPJy0eu/GWe6ADH4HcCSFjtM4n4uMuC0YurZKzS78b
         xSLOHBAn4EAYCo9VR3a87GMHPI+GA+8IkE08Wu06cOkwN+X1KRdIdcGP8jjKuXjhRI0t
         vUmh64bO7V6R8mHHzE/V/ueV77GKM8oQ7sjb7d6KIUgjUn62pZKaBmogU6DondALoaSM
         BZNkQ0qC0vIHorRHu9bL65ZdzixQgMiIHPUWE3We/Lx0Yb6m8qHVTeDp57m9+fnSMRir
         h794AJChk1oBaObhcIL9TRguNggDJywu5SN82syShH6LAF/408KozKia6zbQ/MkGV0/4
         vmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729601201; x=1730206001;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBoyQ6YybvW2ed3USuSGHRo92Y/y9rMgOfXSEGyDSpo=;
        b=tvUqAk8oslmFPSeSFO5MS3nxS3tTGlnybDQTYXRe4K2ttxyfIRe5XmyY5f/UpPOzZP
         7gMTnuGnFWV12xJgQFKdc+E7PIa1ZjnOud6KEGbBFGF3VDVnrjzvjelKOau7Lak8uBUJ
         y+BT63ZRkzPvXt5hOsLrV4jQCCMY6dY70XIM8zB+q7qS4ONtnuNnOR+i3AS9mAb5nyRe
         aJNc/+bwvaZ0u5YSRvvzRepq4GdNhQI1rH2XedAWhdEupXYR2Cp1JtuZwQjUi5RDa2dB
         431MmNMbJt8D+WL1lhlHI9huMIXgN0eMaiv1BsylCkRHhC8MTc6KcM4gnjzZapXyXq+l
         JKXw==
X-Forwarded-Encrypted: i=1; AJvYcCXAKWJBEx+O8XYELglPpAQKhksfu57p9ei7UKR1wCqxu0zna5QC9pd9C3iBIIe3tTim8Bac5g9AZxFvjj7qfw==@groups.io
X-Gm-Message-State: AOJu0YwxKwXwBMnHWNMR0zZWjOStQ9/vsh/TczxiOQcC2nj5e0J2MGU+
	i8EUAY50DAkMefxuqt78EbcQ6Okp38mOpo4575TLMoECTGHOGBAubYSeZUTQm4U=
X-Google-Smtp-Source: AGHT+IFjG3TtiRtXWrm7ap2tEgR9N1KoOC4+1geVpVD4SjcDnaJWpIDHrLmg0zJU+z3fKb4AmXWj7A==
X-Received: by 2002:a05:600c:4349:b0:431:5f1b:a7c6 with SMTP id 5b1f17b1804b1-4317744a9dfmr46642685e9.30.1729601200640;
        Tue, 22 Oct 2024 05:46:40 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2c8esm87883605e9.36.2024.10.22.05.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 05:46:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 5/6] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
In-Reply-To: <20241017-adnroidv2-v1-5-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-5-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 14:46:36 +0200
Message-ID: <87y12guwyb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 12:46:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2515

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Actually khadas vim3 use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3 android.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
>  configs/khadas-vim3_android_defconfig    |  7 ++++++-
>  include/configs/khadas-vim3_android.h    | 27 +++++++++++++++++++++++----
>  3 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index de5357c45cbf..a078c5d363ae 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
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
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index a0d9c423c3c3..b77a44ce859b 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
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
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index 0e2953fe71b3..498afd0287f4 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -41,10 +41,29 @@
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #endif
>  
> -#define EXTRA_ANDROID_ENV_SETTINGS \
> -	"board=vim3\0" \
> -	"board_name=vim3\0" \
> +#define CFG_EXTRA_ENV_SETTINGS                                    \
> +	"board=vim3\0"                                               \
> +	"board_name=vim3\0"                                          \
> +	"bootmeths=android\0"                                         \
> +	"bootcmd=bootflow scan\0"                                     \
> +	"adtb_idx=3\0"                                                \
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

