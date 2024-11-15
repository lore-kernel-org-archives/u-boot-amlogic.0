Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC3CD637DD
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 14:04:22 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.21581.1731679453521560018
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Nov 2024 06:04:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wNsMNeBH;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so6083925e9.0
        for <u-boot-amlogic@groups.io>; Fri, 15 Nov 2024 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731679452; x=1732284252; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpB0qu0GSGHrXDcJf/fV0re+V5hcE5UctaQ+JRYlOx4=;
        b=wNsMNeBHD72vHDxSJg6dhI4fccJgs6AdjzkB55fL9c7nuthmIH1Mnd0Utb9C/a9Td3
         ZSmZQ/yirZ889XZ+CqVf48lIPh49SHAGxsExfwnzTHIrEn3VDd6TkxfifS+XzUP7NtZD
         fTurUWefvOV1O7K6i7RHndkoENar5vvnI13SFmJcdcQCPb3GJT7QzAokI5KxhtvSNAZ6
         NefxiCoeQZV2g0juDp6+bZk2XQ1LtpA65mczqv0le9YRs7ctp5+O97Cph1iQk0VtvCmQ
         hCLgqKQ0K0noCu2cfEFwixrlw74jmCLjMEVyt+UWuqjXufosUTSZDGhMb6n0ZyknUqdJ
         tO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679452; x=1732284252;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpB0qu0GSGHrXDcJf/fV0re+V5hcE5UctaQ+JRYlOx4=;
        b=laFHCf21Tocp8Y2kSqqfIN0YNEvVeEMV7HXZANoOvDaiNkXcVeCazIBJFoI3ikPBJN
         AHXFFigl1zzF+CWzjyUS+YoGb8gRDs6WjB9mKFY/Kxw7icsnOnTg10vY9WaKvcVAvm9q
         R6sUybJI0qaMUIk5aAAudey1I4AXfz1b9cUkpeNMm0w9ZBXI3osDXtnNEQiR9RVEeRaA
         ZKVnfNtiy1rHOBBrpns0PXwWVqnCFex8L/Ly8VFuxuwJiXp291OZ49W2HIjWD9D3hj5J
         0QXD+VUlNmuuRSPGOepJAWu7sniESDJeDgL2Jh2bqWs8oUoPEa8OONWinq+Uu9iSJ0lu
         SLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpmiVrGywgxiR7VsUwjPTdUZVeFW+/xdGZyg7tu8ACMH/NzTtYs/4DxwGAjzbekvHhaCVl4PwoSdCw9oEMVQ==@groups.io
X-Gm-Message-State: AOJu0YzCQxM0EsHkn4dEws5tSuEp4szVtJcxuWBirLIEeOp/M/TyIQU5
	+3sZCTGttTkTyZI6aSL7OgNvWGPcoHdBmf2fTJnyQMKz7jeUJq23L0tkykYWr4w=
X-Google-Smtp-Source: AGHT+IG/H2rXaPEypfg/arEShsMb6iIyTSAfnBTzdySY3ga6aUWt8W9nQa+lW4X+PT5nMK8QNeoe2Q==
X-Received: by 2002:a05:600c:138f:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-432df7179d4mr23188545e9.4.1731679450111;
        Fri, 15 Nov 2024 06:04:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8512:42be:302f:f436? ([2a01:e0a:982:cbb0:8512:42be:302f:f436])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d478511dsm80500835e9.0.2024.11.15.06.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:04:09 -0800 (PST)
Message-ID: <6f0f015b-e5b2-4ea6-be6a-bddd945fdcf7@linaro.org>
Date: Fri, 15 Nov 2024 15:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
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
In-Reply-To: <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Nov 2024 14:04:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2559

On 14/11/2024 22:29, Guillaume La Roque wrote:
> Actually khadas vim3l use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3l android.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>   configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
>   configs/khadas-vim3l_android_defconfig    |  7 ++++++-
>   include/configs/khadas-vim3l_android.h    | 26 ++++++++++++++++++++++----
>   include/configs/meson64_android.h         |  3 ---
>   4 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 4d7b90f23002..43db61056baf 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
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
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 4ec27262cdc7..32d57a5b9090 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
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
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index f39a3782d663..31068c59d5ed 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -41,10 +41,28 @@
>   	"name=rootfs,size=-,uuid=" ROOT_UUID
>   #endif
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
> index 77364bbf9cf0..37ef8b8f7a7e 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -104,9 +104,6 @@
>   	"elif test $board_name = sei610; then " \
>   		"echo \"  Reading DTB for sei610...\"; " \
>   		"setenv dtb_index 1;" \
> -	"elif test $board_name = vim3l; then " \
> -		"echo \"  Reading DTB for vim3l...\"; " \
> -		"setenv dtb_index 2;" \
>   	"elif test $board_name = vim3; then " \
>   		"echo \"  Reading DTB for vim3...\"; " \
>   		"setenv dtb_index 3;" \
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

