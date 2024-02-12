Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E3C48297
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 08:46:57 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.2643.1707727617196602579
 for <u-boot-amlogic@groups.io>;
 Mon, 12 Feb 2024 00:46:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CPt5hSi/;
 spf=pass (domain: linaro.org, ip: 209.85.128.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410e676c677so1538215e9.1
        for <u-boot-amlogic@groups.io>; Mon, 12 Feb 2024 00:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707727615; x=1708332415; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsyfvOGKjV4oLHBSUmJZVuMWe1FDn1/3xhvUTM0kBfQ=;
        b=CPt5hSi/Ek5OoKTWKwyp//Pn+sz4aA+4CYm7Kt5vM4AxuFP1X3D0LW+8Ftxuv0dVEK
         P6Czl3w2W4AI/c/EUQW+Pb7PKPvHzuMA04wGeLaD13M+q7lyI8w4AV7hwDm4/9Lkqt1I
         DDOp7moVKDGkQdZRA0phBWKKUVT/yi3pxd8uPfAwSlDIdbeHu+6pbnXPgixTPT2J7oVh
         4t7XgTV2X19/tuJt52jM1Eb/xSk4aH8rEhzfHXZonHMDOKxDnrVTvPdnBEtQWh+3ArJJ
         Fs/dbatkX4KzYgQJUQ9NwHeNaLhbnw4V4GOJTDjyGIVWNghzE/hIk0+QIqivySRViuGu
         E2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707727615; x=1708332415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FsyfvOGKjV4oLHBSUmJZVuMWe1FDn1/3xhvUTM0kBfQ=;
        b=V//5+pHL4ES6b+F77egJ0MkQxZ1y4StD8GPebBavq6GpO1IGj9um9wtEk8/YZO7fnr
         ZtB9tPJTTU4PkfMwB1J6cdNW0ZhxRs/Ieow/i9LLyvCtLzj7bVV7/sej5CmcUPn6Wnsn
         uWI7ZObNiGKB6wNkpFRCGQm7KqIoo/6H9dg46TledWVB3PjkdHa7m3mQeQAk2hP4tbZP
         6HKtj52988mOBJ7HymdAAYunwd0bDUZa5G+wnb3AfnK+dVMbU2ASpsYysLh4XZ805eU8
         pjbRS+5vu7btY1q72FOGCW/IzYi9uqmvH64aenUR3qKX/kjcfy5DSxKp4kTHT8hhib0v
         98pg==
X-Gm-Message-State: AOJu0YwGUG6nbfyi6iRp6RcGlUN6eTeDTdnemKuy5zS+IZbNOBMzH1qV
	22vxNpDowqDNr6bsJwELdI8UC7snw+3OfBTXREdDFVhLQyX50fMMHh/R2KQJiVg=
X-Google-Smtp-Source: AGHT+IETvwUR3iD6rRYOSRrznHvQGfa6Gnb8c34M0LLNxpwNc9wTi+FX+JKO42/NoMFwc+j8jWo06w==
X-Received: by 2002:a05:600c:4f42:b0:410:709e:f223 with SMTP id m2-20020a05600c4f4200b00410709ef223mr5030670wmq.9.1707727615513;
        Mon, 12 Feb 2024 00:46:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWc9CVFU9s1iK5bjVgn202CiRILRD1oPR2dLqIbQV1rLk3Xf5olG3VidJV3u0leqhrkCjeTqq2X3eiMBeYsrgAcZ9JgissrPbOQ7oEXS+mLIE8jnwHYuwDt+KMspPAL
Received: from [192.168.7.190] (212-114-21-58.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id jx6-20020a05600c578600b0040ffd94cd27sm7816237wmb.45.2024.02.12.00.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 00:46:55 -0800 (PST)
Message-ID: <0aed6601-145e-4645-9fcd-efaae6eaacb4@linaro.org>
Date: Mon, 12 Feb 2024 09:46:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix AVB oom error
Content-Language: en-US, fr
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
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
In-Reply-To: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 Feb 2024 08:46:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2116

On 09/02/2024 09:58, Mattijs Korpershoek wrote:
> When booting Android with AVB enabled, an OOM is observed:
> 
>    => avb init ${mmcdev}
>    => avb verify _a
>    ## Android Verified Boot 2.0 version 1.1.0
>    read_is_device_unlocked not supported yet
>    read_rollback_index not supported yet
>    avb_util.c:182: ERROR: Failed to allocate memory.
>    OOM error occurred during verification
> 
> A custom malloc length of 128MB is required as documented in
> commit 285a83b12bdf ("configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB")
> 
> However, this 128M custom malloc length was not ported to Kconfig in
> commit 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
> 
> Add it back to fix AVB verification on VIM3/VIM3L.
> 
> Fixes: 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
> Co-developed-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   configs/khadas-vim3_android_ab_defconfig  | 1 +
>   configs/khadas-vim3_android_defconfig     | 1 +
>   configs/khadas-vim3l_android_ab_defconfig | 1 +
>   configs/khadas-vim3l_android_defconfig    | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index b41c2660fff0..ee62fe36d414 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
>   CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
>   CONFIG_ARCH_MESON=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index 88197f5f5e99..cecbe5061793 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
>   CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
>   CONFIG_ARCH_MESON=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 3381d2e92701..ec4e0dc72e22 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
>   CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
>   CONFIG_ARCH_MESON=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 3fa587ef1db5..206f8defca6b 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
>   CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
>   CONFIG_ARCH_MESON=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> 
> ---
> base-commit: 076529725f16f07a5cb2d5feba25d62b5f5a5872
> change-id: 20240209-vim3-avb-malloc-aa3de534d6a0
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

