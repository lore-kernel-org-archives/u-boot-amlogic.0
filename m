Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A4FD65C7C
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 14:12:02 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.21542.1731679915891016413
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Nov 2024 06:11:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Znoqf9hN;
 spf=pass (domain: linaro.org, ip: 209.85.208.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so2583088a12.3
        for <u-boot-amlogic@groups.io>; Fri, 15 Nov 2024 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731679914; x=1732284714; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYQzkHHEBgkrCxvU3hEQ1QMq6ajHyt0vlJYF4e8RfcI=;
        b=Znoqf9hNJQ+Homu/N5aw08NGpVv6kt0uxN65eM7yc6L5mWHfdxRrxYSomcL4GMG6GG
         UVlWuGJcBrnlz/3V4oO84SgXH4zDHDPtylU/zF4XRzJDjc39Oey2R7vmd6i3DE7arEFN
         EWCoBmcg47V1UKsphsV3LWsJgBT10xqDA4BloxEDokbPOksH3nonyOVncRxEO+MB/NCa
         Ja27gtrYIBenJdO7DYnVSoc1or6c1y9m9slucbEgKp1B0poGgAwOLaA98c7dBPtZmKJO
         TSfSIig3CinnExTsZFAmrWfA934X0p3Skgm3TiP2AiNZKJG69PnQuGt3CYK1NEucBwXz
         rfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679914; x=1732284714;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gYQzkHHEBgkrCxvU3hEQ1QMq6ajHyt0vlJYF4e8RfcI=;
        b=CuGusFadSBJJHkTFDNXOpB/rTsB2BVlj8SvSipnM0UXoBaPn9K96gPvsWRed49iKzs
         53/f+2IAQCYGTFCSHKnzjZPTGoSHZnnwbv7CVCI01F68mTrnkwvy1Tbi+hSPEhxWt4nc
         kNHpEeyvVtUYfY6+TWuBnomlf8cQ4Kc6pb9YvONQOwL2jzufzUzdd38NlucHToX+bsdb
         2ajYPZPwOVA7cEBWW8hSU63P2v9q2lgiRnSKwEQoJ7A0dxZtEsdEp+vbfSk893hutwwj
         EXYOgApMyipSvyWqrBH0NuCqVekvbcebSiCfsmfMcGoYr2fMqZCEF6Z4LOtMoB+xaSQU
         F82w==
X-Forwarded-Encrypted: i=1; AJvYcCVnHMP2x2IvWAGK6ns7YRIWnuACB4llsMvnpcXbEPhETkK6N6yaQBt01DsjiuMNruHKAdP2TVIH8W74lqjqbQ==@groups.io
X-Gm-Message-State: AOJu0YzpXMjdTaBG3nk2hNv+h13QQMBmrpodzTKwpue2nycW7WNyqbcc
	g9nO8QUW1oKjiATBiSH4yffApJIfiFtZ2BAq6QsGE23ZcCFUhlc4My4SVD6DrI8l6G2zyPBvVYL
	3
X-Google-Smtp-Source: AGHT+IHbi85f9k78amp/H+s9oKvz6yJkk2LCsgQbJmYehreD2BQifuK0HNd5uId21Q+nov2ffitZ4A==
X-Received: by 2002:a05:6000:1863:b0:382:1c00:d47a with SMTP id ffacd0b85a97d-38225a91de7mr2367663f8f.36.1731679461984;
        Fri, 15 Nov 2024 06:04:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8512:42be:302f:f436? ([2a01:e0a:982:cbb0:8512:42be:302f:f436])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382247849b0sm2490795f8f.97.2024.11.15.06.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:04:21 -0800 (PST)
Message-ID: <95aa89c1-f0f0-4c2c-93b7-d3f77f0d60b8@linaro.org>
Date: Fri, 15 Nov 2024 15:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/5] configs: khadas-vim3_android{_ab}: move on
 bootmeth android
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-4-015bffb1373a@baylibre.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241114-adnroidv2-v2-4-015bffb1373a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Nov 2024 14:12:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2560

On 14/11/2024 22:29, Guillaume La Roque wrote:
> Actually khadas vim3 use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3 android.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>   configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
>   configs/khadas-vim3_android_defconfig    |  7 ++++++-
>   include/configs/khadas-vim3_android.h    | 26 ++++++++++++++++++++++----
>   include/configs/meson64_android.h        |  3 ---
>   4 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index de5357c45cbf..a078c5d363ae 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>   CONFIG_FIT=y
>   CONFIG_FIT_SIGNATURE=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
> +# CONFIG_BOOTMETH_EXTLINUX is not set
> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
> +# CONFIG_BOOTMETH_EFILOADER is not set
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +# CONFIG_BOOTMETH_VBE is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_OF_BOARD_SETUP=y
>   # CONFIG_DISPLAY_CPUINFO is not set
> @@ -35,7 +41,6 @@ CONFIG_SYS_MAXARGS=32
>   CONFIG_CMD_ADTIMG=y
>   CONFIG_CMD_ABOOTIMG=y
>   # CONFIG_CMD_IMI is not set
> -CONFIG_CMD_BCB=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index a0d9c423c3c3..b77a44ce859b 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>   CONFIG_FIT=y
>   CONFIG_FIT_SIGNATURE=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
> +# CONFIG_BOOTMETH_EXTLINUX is not set
> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
> +# CONFIG_BOOTMETH_EFILOADER is not set
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +# CONFIG_BOOTMETH_VBE is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_OF_BOARD_SETUP=y
>   # CONFIG_DISPLAY_CPUINFO is not set
> @@ -34,7 +40,6 @@ CONFIG_SYS_MAXARGS=32
>   CONFIG_CMD_ADTIMG=y
>   CONFIG_CMD_ABOOTIMG=y
>   # CONFIG_CMD_IMI is not set
> -CONFIG_CMD_BCB=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index 0e2953fe71b3..096ab4e5fb1f 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -41,10 +41,28 @@
>   	"name=rootfs,size=-,uuid=" ROOT_UUID
>   #endif
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
>   #endif /* __CONFIG_H */
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 37ef8b8f7a7e..d6ef0a83a686 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -104,9 +104,6 @@
>   	"elif test $board_name = sei610; then " \
>   		"echo \"  Reading DTB for sei610...\"; " \
>   		"setenv dtb_index 1;" \
> -	"elif test $board_name = vim3; then " \
> -		"echo \"  Reading DTB for vim3...\"; " \
> -		"setenv dtb_index 3;" \
>   	"else " \
>   		"echo Error: Android boot is not supported for $board_name; " \
>   		"exit; " \
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

