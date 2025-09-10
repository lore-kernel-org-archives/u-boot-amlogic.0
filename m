Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8927BCA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 07:02:18 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.11350.1757487736347245770
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 00:02:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=G6VqF91t;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e5190bca95so2491324f8f.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757487735; x=1758092535; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXFQa/A4Z2njAqlDfQQqJbyo9i5R92JyPVXXf1NnNmY=;
        b=G6VqF91t3jp0/AKKlJBiVImusKyPWAvga83Z/4dydNw3RUgOz9ruYnnPlnrfZ5iJQ6
         DiTp2ZaI3C7w49ubxiHNujCZqYWXV6s83sfsv6w9Ttkz0REURC705IPzu6OnL6ntp7HO
         lL+OcI8B4e8MvHG80k1Ia9tHyyTm0vFIO9QXqVAY08QIOPchjdfSCpHsDeHnWuWoph/h
         RBa2y1N929imlU5XwlOnHAXYaL+/KrzE064/amuQgXW2CSGEaflbi507gKKRtCpA8hXj
         ADsCGJGHvKu4Fa0HXJCfCtlhxYEV9EBzT7Xrfq0IxpzjgPk0QBwTfjVxuTLxLhwEjy2S
         Zijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757487735; x=1758092535;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uXFQa/A4Z2njAqlDfQQqJbyo9i5R92JyPVXXf1NnNmY=;
        b=MyMvuZDiWcUgQEIiBzbSgWt/mqGUB0Makl/irWifjz+hD/krk+DkBvdAeRNaZK5TKJ
         KqzbK6e+x7+Y//EngIr1Yq0POeAq91KO9a4fdJ/Sj6eHb8HnByPsuD720fR8W0qjwjg0
         zlXTp7r+aOqESlgg4ZKNjLkbngFovVMviIfHl387IqEtuwlIzbkmfHHGnlDBiW7Eojf9
         YHbW3AmmKePr3SQI9zghRStsNx38wqX4BdEPzA0LIaaS9iJqbFadUqE4tEMwynhTvDLq
         gmiKjK3EAIWMLHRW8g0Nyf6kD7HIYX1oOhSzC/78LcSZ9HDcCA69sw+m957PzhHqGFNm
         F+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpKzlSdliKUtKSjzm1xT5+21Q1TNbBwoTou/fseIcTGB6YkH65Hf1LKfNNOjL2FvWCHs3l5H8XLVB5WQBdfQ==@groups.io
X-Gm-Message-State: AOJu0YxQp8pVJzIcUTojgVTyJZb6DJ6+Trz96LXBP/X79CwLreY3czgh
	QWU59gneTKS0z+/0Z1/NjOeqDc5F6XO4YYPrble/5eScktI9305UfmtYzXr1DqpUhqc=
X-Gm-Gg: ASbGnctBvJWjDZjYIJn2WnRYkLZfpbd3Y0VrNq97eta5hhQGY+eRHiIWqBjYAoAOcCM
	byPK7WnpDZBrlKZVgA5GTkbypKBHxWpA35Fmej4zbzJ103lP1EVGzfZ7qkbI02k0x5443E+Mr7P
	ukgcvHPZnELBAAv94THhrcW03R18+nYPIInu61bft8uoM0+ep3PKkatszP9RKLoGFTrIqt+VLFU
	YBHeyLx1e3eR/n5JSaBtqS12uxAuQFyvtAQJyiQVD83n1fypKSrj5xzD1xNJH+iGlG+3JGLrF76
	8orZadVdwl/Uarmfg1qaMlbiuINXp5XVphMSl4GLSByyPu3m3PVqEdtsFwkuodA1UGCj351tGvz
	gqeFuQ42KXR/jjIRSasXS4FQzqg0m+M4QuzK/zWnhftLxX6J1SB9WDqPE0lcyOC2+PbNmRJH+xH
	8=
X-Google-Smtp-Source: AGHT+IE9ZavL/ztBraMd1QoIIpu3iaoc10nfyD+No9Yd2V9KFFWzsT/zLBMjFTulOS0v/bH9zvoOtA==
X-Received: by 2002:a5d:5f48:0:b0:3de:78c8:1223 with SMTP id ffacd0b85a97d-3e6440ef6cemr11833256f8f.31.1757487733841;
        Wed, 10 Sep 2025 00:02:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2? ([2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfdc6sm5544336f8f.8.2025.09.10.00.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 00:02:13 -0700 (PDT)
Message-ID: <c1012805-6f06-4855-be4e-6167409c80a0@linaro.org>
Date: Wed, 10 Sep 2025 09:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 5/9] arm: meson: initial u-boot SPL support for GX
 SoCs
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-5-37395d9ff5af@postmarketos.org>
 <b6d9c116-f37d-4793-ba53-f94ed95130dd@linaro.org>
 <DCNKQM04PWE0.35QSN1T1Z5CEZ@postmarketos.org>
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
In-Reply-To: <DCNKQM04PWE0.35QSN1T1Z5CEZ@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 07:02:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2761

On 08/09/2025 18:53, Ferass El Hafidi wrote:
> On Mon Sep 8, 2025 at 8:24 AM UTC, Neil Armstrong via groups.io wrote:
>> On 07/09/2025 16:36, Ferass El Hafidi wrote:
>>> Add initial boilerplate for U-Boot SPL support on Amlogic.
>>>
>>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>>> ---
>>>    arch/arm/include/asm/arch-meson/clock-gx.h |   1 +
>>>    arch/arm/include/asm/arch-meson/gx.h       |  36 ++++
>>>    arch/arm/mach-meson/Kconfig                |  42 ++++-
>>>    arch/arm/mach-meson/Makefile               |   5 +
>>>    arch/arm/mach-meson/board-common.c         |  11 ++
>>>    arch/arm/mach-meson/spl-gx.c               | 278 +++++++++++++++++++++++++++++
>>>    arch/arm/mach-meson/spl.c                  | 123 +++++++++++++
>>>    7 files changed, 495 insertions(+), 1 deletion(-)
>>>
>> <...>
>>> diff --git a/arch/arm/mach-meson/spl-gx.c b/arch/arm/mach-meson/spl-gx.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..65b301bc9ed89b7ca2156b7fa672ed4ef3f8633b
>>> --- /dev/null
>>> +++ b/arch/arm/mach-meson/spl-gx.c
>>> @@ -0,0 +1,278 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
>>> + * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
>>> + */
>>> +#include <hang.h>
>>> +#include <image.h>
>>> +#include <spl.h>
>>> +#include <vsprintf.h>
>>> +#include <asm/io.h>
>>> +#include <asm/arch/boot.h>
>>> +#include <asm/arch/clock-gx.h>
>>> +#include <asm/arch/gx.h>
>>> +#include <linux/delay.h>
>>> +
>>> +/* Meson GX SPL code */
>>> +
>>> +#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
>>> +#if defined(CONFIG_MESON_GXBB)
>>
>> I think you should indicate why it's only needed for GXBB
>>
> 
> Sure!  I will also explain here to clarify.
> Basically this is sending the SCP firmware (aka. bl30/bl301) to the SCP.
> Historically (in GXBB) this was done by bl2.bin, but (to save space?) it
> was moved to BL31 in GXL:
> 
> - https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a/+/refs/heads/master/plat/amlogic/gxl/gxl_bl31_setup.c#129
> 
> and BL2 would give image info for bl30/bl301 to BL31.  I patched this
> upstream so we don't have to do that in SPL:
> 
> - https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a/+/refs/heads/master/plat/amlogic/gxl/gxl_bl31_setup.c#105
> 
> Whether we can move SCP fw loading to BL31 on GXBB is .. an interesting
> thing that could be considered.  That way we could possibly also save
> some space in U-Boot SPL.
> 

Would be nice, but keep it as-is for now!

>>> +void meson_power_init(void)
>>> +{
>>> +	/* TODO: Support more voltages */
>>> +
>>> +	/* Init PWM B */
>>> +	clrsetbits_32(GX_PWM_MISC_REG_AB, 0x7f << 16, (1 << 23) | (1 << 1));
>>> +
>>> +	/* Set voltage */
>>> +	if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1120MV))
>>> +		writel(0x02001a, GX_PWM_PWM_B);
>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1100MV))
>>> +		writel(0x040018, GX_PWM_PWM_B);
>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1000MV))
>>> +		writel(0x0e000e, GX_PWM_PWM_B);
>>> +
>>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>>> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 22);
>>> +		clrsetbits_32(GX_PIN_MUX_REG3, 1 << 22, 1 << 21);
>>> +	} else {
>>> +		clrbits_32(GX_PIN_MUX_REG1, 1 << 10);
>>> +		clrsetbits_32(GX_PIN_MUX_REG2, 1 << 5, 1 << 11);
>>> +	}
>>> +
>>> +	/* Init PWM D */
>>> +	clrsetbits_32(GX_PWM_MISC_REG_CD, 0x7f << 16, (1 << 23) | (1 << 1));
>>> +
>>> +	/* Set voltage */
>>> +	if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1100MV))
>>> +		writel(0x040018, GX_PWM_PWM_B);
>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1000MV))
>>> +		writel(0x0e000e, GX_PWM_PWM_B);
>>> +
>>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>>> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 23);
>>> +		setbits_32(GX_PIN_MUX_REG3, 1 << 20);
>>> +	} else {
>>> +		clrbits_32(GX_PIN_MUX_REG1, (1 << 9) | (1 << 11));
>>> +		setbits_32(GX_PIN_MUX_REG2, 1 << 12);
>>> +	}
>>> +}
>>
>> Seems much of the code is duplicated between GXBB and GXL, so I wonder if it would'nt
>> be cleaner to have spl-gxbb an spl-gxl ?
>>
> 
> You mean separate power init functions (meson_power_init_gxbb/gxl)?  Should be doable.


I mean even separate files, it would avoid any #ifdef stuff

Neil

> 
>> <...>
>>
>> Anyway it's really clean !
>>
>> Thanks!
>> Neil
>>
> 
> Thank you!
> 
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#2757): https://groups.io/g/u-boot-amlogic/message/2757
>> Mute This Topic: https://groups.io/mt/115113902/8399868
>> Group Owner: u-boot-amlogic+owner@groups.io
>> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [funderscore@postmarketos.org]
>> -=-=-=-=-=-=-=-=-=-=-=-
> 


