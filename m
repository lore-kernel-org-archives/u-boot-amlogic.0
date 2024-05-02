Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A63C4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 07:39:24 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.373.1714635562673992760
 for <u-boot-amlogic@groups.io>;
 Thu, 02 May 2024 00:39:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=L2ka70gh;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso52938435e9.0
        for <u-boot-amlogic@groups.io>; Thu, 02 May 2024 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714635561; x=1715240361; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JTQNjccdYBM6/7Ss23ts6kd28ppsd2kA60yw50qhSA=;
        b=L2ka70ghMdla1KjD9WLtNZOoZQg0G71NADRbX5SvfV8Zo2SVq0Rj2xJaEUsH2mKWob
         FmTSKhNPFIlqOTz1qlg8ycZ315zaoI6rfwM4VDOGUkOpA8hDuJQaxrCTpvy9ifVObnuT
         eGccAHKeuSfHjFxzJHjqApgVBu5W8UnVH/x4YoZU+vEXMuzSm7gnT/yE8vRReBkSiLWX
         4ZXlAzWojlONjRYCR7j7ZRFattCTdfgL4mM5UxnGLbNSqbebewNFocj8QG/R0j6zc1ZC
         agK6Csje3vWXUd0/OIO3UiqPq6reGwhiKtK+JOiVkn6btyklzDqr3QB+QoqbH0MF4+Ne
         zWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714635561; x=1715240361;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7JTQNjccdYBM6/7Ss23ts6kd28ppsd2kA60yw50qhSA=;
        b=ArkN5IXAU1xt8EHTllBjiOEp7j4GZhJDpVfBd046re0kmQ8ES9lQkZNqcEvAOw3I8N
         XXAjyAKpd+a2qNLKfjzAEHE9mmetRFsZRgQ3AvgC+D6tH6JZ4pkJBmU9jqXCQWwYkT+o
         5/E7UAQ+XXIgRdPmuIng3pwpcl4mW9NtcMnR8V1XcinnCg/phkn8+4m09kIMWOx13veL
         joiAlS4qTIqdPoMQIqIpulZwP/t3oqmdEy8uhwhrXP7MgqO5SeKGUH/2xGl5ANqIIwuI
         bs4LHkTPJjI4emTpjlrCfI1K7hV0MTOUGDWs/ZLvdTYThzq1dUZGFlVQ62J3AKiZe4a6
         tHpA==
X-Gm-Message-State: AOJu0YxeOz8/E3OfbfDORIpUD0UzHfo0R7kt0d/iajD2IlJg9Xx/zRul
	N2cpIc2iKZw8tAVQ0AVXtxVv9xTS8v/BLKatYHdQf6BNynMmcOOOkldc46p42Jw=
X-Google-Smtp-Source: AGHT+IG8Iah7UVjLqp3wTURaAugeCujtgoJq8RA1OFQPO0+g4vnMKi8J8UmMXivBkRZgUqNQxr6AwQ==
X-Received: by 2002:a05:600c:4fce:b0:41c:2313:da92 with SMTP id o14-20020a05600c4fce00b0041c2313da92mr952735wmq.4.1714635560829;
        Thu, 02 May 2024 00:39:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:67e2:5e2:652b:4129? ([2a01:e0a:cad:2140:67e2:5e2:652b:4129])
        by smtp.gmail.com with ESMTPSA id c7-20020adfe707000000b0034d24477662sm562942wrm.8.2024.05.02.00.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:39:20 -0700 (PDT)
Message-ID: <cf027072-72af-41fa-9ecc-5f3c21b69519@linaro.org>
Date: Thu, 2 May 2024 09:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 19/33] arm: meson: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
References: <20240430133559.1836389-1-trini@konsulko.com>
 <20240430133559.1836389-19-trini@konsulko.com>
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
In-Reply-To: <20240430133559.1836389-19-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 02 May 2024 07:39:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2283

On 30/04/2024 15:35, Tom Rini wrote:
> Remove <common.h> from all mach-meson files and when needed add missing
> include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: u-boot-amlogic@groups.io
> ---
>   arch/arm/mach-meson/board-a1.c     | 2 +-
>   arch/arm/mach-meson/board-axg.c    | 1 -
>   arch/arm/mach-meson/board-common.c | 1 -
>   arch/arm/mach-meson/board-g12a.c   | 1 -
>   arch/arm/mach-meson/board-gx.c     | 1 -
>   arch/arm/mach-meson/board-info.c   | 1 -
>   arch/arm/mach-meson/sm.c           | 1 -
>   7 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.c
> index 967bb671822e..f848c0f068ed 100644
> --- a/arch/arm/mach-meson/board-a1.c
> +++ b/arch/arm/mach-meson/board-a1.c
> @@ -3,12 +3,12 @@
>    * (C) Copyright 2023 SberDevices, Inc.
>    */
>   
> -#include <common.h>
>   #include <asm/arch/a1.h>
>   #include <asm/arch/boot.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/io.h>
>   #include <linux/compiler.h>
> +#include <linux/errno.h>
>   #include <linux/sizes.h>
>   
>   phys_size_t get_effective_memsize(void)
> diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
> index fdf18752cdd0..6535539184cc 100644
> --- a/arch/arm/mach-meson/board-axg.c
> +++ b/arch/arm/mach-meson/board-axg.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <net.h>
>   #include <asm/arch/boot.h>
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index 7ceba7cede85..39774c43049a 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <fastboot.h>
>   #include <init.h>
> diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
> index d5a830fb1db8..dc4abe1e1074 100644
> --- a/arch/arm/mach-meson/board-g12a.c
> +++ b/arch/arm/mach-meson/board-g12a.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <log.h>
>   #include <net.h>
> diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
> index c3fbdfffeae8..0370ed57e205 100644
> --- a/arch/arm/mach-meson/board-gx.c
> +++ b/arch/arm/mach-meson/board-gx.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <net.h>
>   #include <asm/arch/boot.h>
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> index d51d9b8f0645..b4058f593234 100644
> --- a/arch/arm/mach-meson/board-info.c
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2019 Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index 914fd11c9894..4d9f83d3b38d 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -5,7 +5,6 @@
>    * Secure monitor calls.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <regmap.h>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

