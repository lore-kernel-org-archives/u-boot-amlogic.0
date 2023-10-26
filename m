Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0218BC25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 15:37:08 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.74074.1698334623664685071
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Oct 2023 08:37:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AKAAU9QI;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40853c639abso8417545e9.0
        for <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698334622; x=1698939422; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfViyEpUZt6CJrymvsSheWE2uchD9c00WcrztQfVUwA=;
        b=AKAAU9QIWP0I86G6dnMLv/kkxmkJSQLFkXw/M+BirBh3V0jxR2eYJ8TKE/LCdGI7GN
         6/Cp2mTNLSStxiuJbLYADgEgcgXxkvRlXEo0Sdl3c+WVYtBG9qp3eezw4J9R1naYES0v
         8WiJBO4gOr2tEwS1yrFq+75P0XHayxfLoan2hVrH+aea7hhbh5vPcuYzgggrQBkV2ysK
         0WYEDh/+hqFf2CX07IFe6Qo51KtCbPPp+qB8LfscRmUMsviNqQYjQWUt8Vn8GUYplbY9
         nPulo2PE43Tfa6a/m6aNm+GSm1ZPet/Wj5jn7z3yhTgbtP9rf4PJi1ncsNZCu9PHXpEK
         jZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698334622; x=1698939422;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CfViyEpUZt6CJrymvsSheWE2uchD9c00WcrztQfVUwA=;
        b=P0/Hi56AyQIeRo3rvHjK9zuR10HiPoRfREmE27znlkYGs4Igm9UccMo7F9kkPwBoDK
         6JIvu/qn1B0BV20UHcm9qd/5w/q3s+lMSoufn126Vh5sOVJwmFmRvxQLSrSbjWrNGhp/
         tIpwxZNICV2cRCSKb8n/7LJFWBEIxgHSvYsB1VgQfQCWiK1003mpuqJcYFLY3Z+x12HV
         hCEdyC26+Kn21s5QvY9e9IMqBdpuLnZCIgOGXssk7/E1gH/OBuo2ZuYLO87GXId/yCt/
         hu/kvyThC3fkbF2X/2raljjBVTGRQHZYB2JrQYFwG2983OSyXof2qEyuva4maQGXq12T
         aCkA==
X-Gm-Message-State: AOJu0Yyb0/YUsgfuqv/liaUrzWrRqUZ0DR/b3McPxVQaS9M3OyYb9qt7
	jMY6Hit7ug1PApGdx4xpyc1qSF0Gyh6K29+8AVpDYbK+
X-Google-Smtp-Source: AGHT+IF5MVGEcPwuFl8w9SFV2+J4gd6J/1JCKBlnf7vekjxTv5mLC9UEAOHd7HnzaP5mNHio2UrTHQ==
X-Received: by 2002:a05:600c:4fc2:b0:406:177e:5df7 with SMTP id o2-20020a05600c4fc200b00406177e5df7mr121210wmq.29.1698334621646;
        Thu, 26 Oct 2023 08:37:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f57f:eb08:d29b:8c9c? ([2a01:e0a:982:cbb0:f57f:eb08:d29b:8c9c])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d5609000000b0032da7454ebesm14475858wrv.79.2023.10.26.08.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 08:37:01 -0700 (PDT)
Message-ID: <8e3c3c31-6f42-4d62-8778-d91a525b05d6@linaro.org>
Date: Thu, 26 Oct 2023 17:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix environment saving
Content-Language: en-US, fr
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 15:37:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1801

On 26/10/2023 15:41, Mattijs Korpershoek wrote:
> The environment is used to configure some additional boot features such as:
> * extra boot arguments
> * enable AVB (Android Verified Boot) verification
> 
> Right now, we cannot store it in eMMC:
> 
>    Loading Environment from nowhere... OK
> 
> Fix it by enabling the appropriate options in the defconfig
> 
> Fixes: b749d5ecdc06 ("configs: meson64_android: define raw parts for bootloader")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   configs/khadas-vim3_android_ab_defconfig  | 4 ++++
>   configs/khadas-vim3_android_defconfig     | 4 ++++
>   configs/khadas-vim3l_android_ab_defconfig | 4 ++++
>   configs/khadas-vim3l_android_defconfig    | 4 ++++
>   4 files changed, 16 insertions(+)
> 
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index ccd6f6f8a075..0abccb64ee15 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x0
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -45,7 +46,10 @@ CONFIG_CMD_AB_SELECT=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_AVB=y
>   CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=2
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ADC=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index 5c3d565971d6..33ede5262295 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x0
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -43,7 +44,10 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_AVB=y
>   CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=2
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ADC=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 0d6de8001382..8f32f8e8ad5b 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x0
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -45,7 +46,10 @@ CONFIG_CMD_AB_SELECT=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_AVB=y
>   CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=2
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ADC=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 827752f24373..443c10aee3d0 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x0
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -43,7 +44,10 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_AVB=y
>   CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=2
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ADC=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_BUTTON=y
> 
> ---
> base-commit: 14a21f1a80afc58d52dc72e35f27d3a47d36c082
> change-id: 20231026-fix-saveenv-eb5484622282
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

