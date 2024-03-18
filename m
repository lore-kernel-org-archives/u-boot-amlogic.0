Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE97C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 08:50:03 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.38517.1710751802099093250
 for <u-boot-amlogic@groups.io>;
 Mon, 18 Mar 2024 01:50:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=luoUeCW5;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e1d327595so2372792f8f.2
        for <u-boot-amlogic@groups.io>; Mon, 18 Mar 2024 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710751800; x=1711356600; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEmbO0hfg4t6Va4sobnHhk3Do5ZSP52QFaOChTFVAnk=;
        b=luoUeCW5tk+9tRmQhVxqaDtFKu+BrhUeXlnltSLZriKjnyy1WTDKTSQv7d5GlTTybS
         lBRVH1LTt+vd7KEXkMmzR0OmEKGhXOFIQt8ko18CCh1kRYALdvafJ8cpBnjiRj0YEERK
         jTDoAUbFFkSnCwSYJSpRU3a9fuDWOWH7QdzUnUE0HZ6XKKUQvT831vHo+tJ1v4jbCjZ0
         jE+QwbqHlz0vCfXjUE/YEPtGi5RAsrOQKhAwj+QCHT/+5pI3aQuJGHy0KclMnUiUUEUC
         VXZ94vE1KkDEw1ZlBxzqv+onqZzTIJdIYqkSgxZ1LBKDtY474oyJGOK7Xq126OraqAMf
         6/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710751800; x=1711356600;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PEmbO0hfg4t6Va4sobnHhk3Do5ZSP52QFaOChTFVAnk=;
        b=MZfhYjTstfE0JhkCRAJ5EoiPnl1kz85YlxqKMjtdk7o16yOTJi5CtBg+zlSYkTM1ph
         lfTjq6dDHYJsWGaI0pzWIPeZKqkWWelUxN4Ik2aLb05SRQRh3p8W5FqT68ow+NBipo7o
         311lKEO/zlrhhlu8NDqMtV7C/uRN4LDBFKVFr4wvUc0Xl3AoPIRMA4P5ZEw8jEBEs31m
         AoBQ2+8N7UvPWv3v8ISZhlEOqfSt2FI3cUDCMMIAQLFUp1XErnFXdkHuRKkopyKLuG+F
         PxzpmysUeYMcTvJCsJoRF/RTcJPi6drH17EHxJLhBr4txyDuFjM+rh9w0ZWKBfYLaIXE
         fkQg==
X-Gm-Message-State: AOJu0Yyp4BzNyLOD0O0YyQro3YL2rTocNLcOSRTHYiNJPFSpo4P7YnYf
	0jRx6fdqwY5uU6sF3lfCir0bvyRiXgZwcPJdzGbWR6M6+xt4e0JgNC8onzD26LS7HH/sz2xe1sE
	x03Y=
X-Google-Smtp-Source: AGHT+IHQEN87wPE/3GAp0yBZNmyZ4J2FeHIoRE4dfSDBJWMxRyCBVtACSHp5HBbW/wRzNgp+flvXrA==
X-Received: by 2002:a05:6000:e43:b0:33e:8171:3f0f with SMTP id dy3-20020a0560000e4300b0033e81713f0fmr4255865wrb.70.1710751800375;
        Mon, 18 Mar 2024 01:50:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc? ([2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc])
        by smtp.gmail.com with ESMTPSA id y13-20020a056000108d00b0033d202abf01sm9236451wrw.28.2024.03.18.01.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 01:50:00 -0700 (PDT)
Message-ID: <86162fbc-856a-4e95-92ec-be6647f71d7c@linaro.org>
Date: Mon, 18 Mar 2024 09:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] configs: amlogic: set board family to avoid random
 MAC on WeTek Hub/Play2
Content-Language: en-US, fr
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com,
 u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
References: <20240316135430.826898-1-christianshewitt@gmail.com>
 <20240316135430.826898-4-christianshewitt@gmail.com>
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
In-Reply-To: <20240316135430.826898-4-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 18 Mar 2024 08:50:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2198

Hi,

On 16/03/2024 14:54, Christian Hewitt wrote:
> Add CONFIG_SYS_BOARD="p200" to the Hub/Play2 board configs to ensure the
> factory programmed MAC is correctly read from efuse.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   configs/wetek-hub_defconfig   | 1 +
>   configs/wetek-play2_defconfig | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
> index fd92b041e73..413bbfe9ab7 100644
> --- a/configs/wetek-hub_defconfig
> +++ b/configs/wetek-hub_defconfig
> @@ -1,5 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_ARCH_MESON=y
> +CONFIG_SYS_BOARD="p200"
>   CONFIG_TEXT_BASE=0x01000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
> index b887419a6ba..dd98929444c 100644
> --- a/configs/wetek-play2_defconfig
> +++ b/configs/wetek-play2_defconfig
> @@ -1,5 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_ARCH_MESON=y
> +CONFIG_SYS_BOARD="p200"
>   CONFIG_TEXT_BASE=0x01000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y


CONFIG_SYS_BOARD="p200" is already the default value for MESON_GXBB, see arch/arm/mach-meson/Kconfig

Neil

