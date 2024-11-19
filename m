Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60939D62072
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 10:35:29 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.17848.1732012519559912668
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 02:35:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=CtGwFRuO;
 spf=pass (domain: baylibre.com, ip: 209.85.128.51, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43163667f0eso26378425e9.0
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 02:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732012518; x=1732617318; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=65wVwdtPs6LhZxyrvkZHnkj1YhHrKuX21s0aS8DbkkE=;
        b=CtGwFRuOIpVbidqxv2+xTTv07aCJcwCaruMFhx6BmOdhZVeehyDvD6VIB9D2PtRKKz
         07aVlv92OMS+XPAlgZmIr5zs5HRe8Y3VoJnuy1NSVa+8G3RVRYDWZ6v6ha3OPk8Y5toS
         DnPx0LxfIdTMe80pWP2D8SzaE6WQmmQOAfbmHPt7ymnh/cf3yvauoIpmyTvUBQscBo3m
         m3Jvb3547Rj1k9k89VWb6as1QU0Qqc8Koue/jig1OsPQU2ZBsOWe5GislcMiwqCKj57j
         x/axhIfWK7Xg4v58Di9BEOhFo7ltdtaDEfpSnYc8I1c6jKtOfgEAE+Gv80mh/eDRJute
         7ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012518; x=1732617318;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65wVwdtPs6LhZxyrvkZHnkj1YhHrKuX21s0aS8DbkkE=;
        b=MLO43Z2gLXguocSinTHYMW5K0Ijk6wbb4ymr5FiZbQ8y5ECibi2tsODosF9u9SZfDz
         t5tA+ZREO7QRIFZ7r73CUJVFFrnQphXEJQtpYnAPPk/DB+UnL6NTpGeUZF+0E0zuQ+6r
         eWKFUIC0QJ/ETf936P3PvW65+G7Ywf7IfbhJr/ILjtq7Gu0fxvmRbgUpjOh6mh8f7h5i
         ueWKq/CVRkccr6fwZrIydgzU0MJwhYgNpGPNEjWoi15cGQrWEYtP3ge3oLNVhb5e+gw9
         gQuMs3bkHQcW/b+MNLaqCekSxakjv3BYYZMgk12wmo5zAjho+l+upFszYzXYoMrz0vZO
         gSSw==
X-Forwarded-Encrypted: i=1; AJvYcCUkTLWMLXv1t/XuDsP5BzczxLbcUrpu1H+983yQxYCCC6JxWQjAe3/Pw2VsGzZQoStRrMhE0pr8Xi7AQvDXMw==@groups.io
X-Gm-Message-State: AOJu0Yw0WhCQA00VhcXrXGsFofnPbX5SeMxqfyfMiGxxq7+H1oz1aGG+
	0GI0HlL/92WWbwaWJVgPlh8xJUtki/GDAQ0JP+AHftXQFOQKaBpdGtFzbUa7fXE=
X-Google-Smtp-Source: AGHT+IEsmUKV3xbztrNlPE6Zl3hJdojpHKuvPTJPR4tDFWx3QFpekF0QcYjxAwtqZ+4pATrfB2CuQw==
X-Received: by 2002:a05:600c:3d0b:b0:432:d735:cc85 with SMTP id 5b1f17b1804b1-432df74c923mr124923435e9.18.1732012517883;
        Tue, 19 Nov 2024 02:35:17 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28cb89sm190822695e9.34.2024.11.19.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:35:17 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v2 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
In-Reply-To: <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
Date: Tue, 19 Nov 2024 11:35:14 +0100
Message-ID: <87v7wjy0il.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 10:35:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2563

Hi Guillaume,

Thank you for the patch.

On jeu., nov. 14, 2024 at 22:29, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Actually khadas vim3l use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3l android.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
>  configs/khadas-vim3l_android_defconfig    |  7 ++++++-
>  include/configs/khadas-vim3l_android.h    | 26 ++++++++++++++++++++++----
>  include/configs/meson64_android.h         |  3 ---
>  4 files changed, 34 insertions(+), 9 deletions(-)

[...]

>
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index f39a3782d663..31068c59d5ed 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -41,10 +41,28 @@
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
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

gpio_recovery is not used anywhere. Can we please drop this?

With that addressed, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

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
> +#include <configs/meson64.h>
>  
>  #endif /* __CONFIG_H */
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 77364bbf9cf0..37ef8b8f7a7e 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -104,9 +104,6 @@
>  	"elif test $board_name = sei610; then " \
>  		"echo \"  Reading DTB for sei610...\"; " \
>  		"setenv dtb_index 1;" \
> -	"elif test $board_name = vim3l; then " \
> -		"echo \"  Reading DTB for vim3l...\"; " \
> -		"setenv dtb_index 2;" \
>  	"elif test $board_name = vim3; then " \
>  		"echo \"  Reading DTB for vim3...\"; " \
>  		"setenv dtb_index 3;" \
>
> -- 
> 2.34.1

