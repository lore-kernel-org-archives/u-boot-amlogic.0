Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D9C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 19:56:38 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.99975.1740426995872128489
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Feb 2025 11:56:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=aEnpA1PR;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso3843543f8f.1
        for <u-boot-amlogic@groups.io>; Mon, 24 Feb 2025 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740426994; x=1741031794; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwvUk1RWrm4erN25UD64pYDI3YDfF3MLkVkls2sIwEI=;
        b=aEnpA1PRAC8DOun0LVJ85WrwpfPMm378nFdfAfjylTzJ3YufeH2N+ixlAnqngPwcbV
         enSezM7bSAKceKAT01c5F8sDM5P1CqpxG++EH4XhqLNOflmgaW4a9Nt27DRvUYvw3sn9
         E3SVXqQUaqnuY4n5y39jKuSVzaza0aB+1oMolo32eQ+zirxFz1aN6z8dCPfRelknGDJ4
         TEJyn1GGNbwp+rGYzCQTgqTHRFPe+Em7Ortcl6iV8wuwjjjz50lxf41pZGZpOIxFLtEs
         fgjQObVgUqagRMeUp8HHOwyLFX/nNGNPDzFuFICPwojtB4qciTpuKOoJlgdxKHxACOfy
         xFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426994; x=1741031794;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bwvUk1RWrm4erN25UD64pYDI3YDfF3MLkVkls2sIwEI=;
        b=woEWwhaMJdhbQfGrJr08+MBCi9wis5CeHeZ0xPv5+7uWvEhpUIWd5zsGvuw1cMyV/a
         H+DhD7YYLHp2fLtQxhJIUju+4w03n/XSn0kwYy7vizQhxblUdseLluofVxJzObTCXor9
         2bWJr3h9wQxnrkMF4SUs749hHm79GzK5hgeCTa0fEqQXF8qglVmMvD+36lBfeNEsJuqI
         9Pq+Swpsr/vLA8LoW6FOSu1xuYnpolO4RJDGUa9oNlKM1R/DlxjoduLG222G2U/9kFYn
         cx6RpUcUPFYX6ZOJbm/+D0TqRYtIkvLA/86vHc68wXJblddcRFXYGfGJEVK3IWVuBu7D
         aB9A==
X-Forwarded-Encrypted: i=1; AJvYcCWPLeOkbrU2oNsy9FMAW0s6SF/iLqPBqO6IOdoBilAfDYK2XegWs84KH6F2NOr1WuSYHTuGQXTnCTf4V9T1eA==@groups.io
X-Gm-Message-State: AOJu0YzLn5+3UN4ql+XonR+6EK2j+njEq8e1Ey2a7PnoG1noS1/GD5HX
	2J6JHEOO/Ox3b/QMvLWD8NM+6ip17p2CMw5O2JLQFjzvxO6xWGwaAMZkumo8Hh0t7d8rjqNiZT5
	g
X-Gm-Gg: ASbGncuATZua+6J6yGAGejRNav5ZJAWpWyTpBGb+ZJE3ytemVmv3OAJwUOBI325CHoA
	vNUE00DTswZYbOs2Hl2L5nWCRS7/Qbsr1a9A9l8LcUYKdcBppfqW8/UTNJ9pgGS8l0gjLHx0WIt
	pMf11qkbTNVxTSZUvhoTJLP0AMj6Kf2dEDcs8uFjJmkcbOx1kfljRy+TMM7bgrokUw12lKtQsOy
	4YuA7tjO40YWY+14puYLOwI/KI/YtS1nd1ynnD2IfJGxKofe6GFW486/9rual0KFFwnvtAfXxAy
	7J5VANyfyZlew27OP6cTlbmuDy8fdF2xFGsT3Y2Yo5v8TA3P1SHSpd/Wb4FGKjaqB3jnkMhSR13
	EDJY=
X-Google-Smtp-Source: AGHT+IE6MFbjryKVqt6zCs+qur7im8vi2dNaPZ6wftqBwuCDCpH2IDT7TKwO0DyMxAaVrO90VAbQmQ==
X-Received: by 2002:a5d:464a:0:b0:38d:c364:d516 with SMTP id ffacd0b85a97d-38f6f0dccfemr10377936f8f.54.1740426994260;
        Mon, 24 Feb 2025 11:56:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:825b:5392:ef70:cc0b? ([2a01:e0a:982:cbb0:825b:5392:ef70:cc0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce60asm117880235e9.7.2025.02.24.11.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 11:56:33 -0800 (PST)
Message-ID: <b251b3a1-8bd5-4814-b3b9-64b8d23dc682@linaro.org>
Date: Mon, 24 Feb 2025 20:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] tools: mkimage: Add Amlogic Boot Image type
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250103215904.2590769-1-jonas@kwiboo.se>
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
In-Reply-To: <20250103215904.2590769-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Feb 2025 19:56:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2627

Jonas, f_,

On 03/01/2025 22:58, Jonas Karlman wrote:
> Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
> Amlogic AArch64 SoCs.
> 
> The first patch add the new amlimage type. The second patch add a eMMC
> relocation workaround that can be used to generate a boot image that can
> be booted from both eMMC and SD-card on GXBB.
> 
> The amlimage type and the eMMC relocation workaround is loosely based on
> my prior work, aml_chksum, a small tool that can write boot image
> headers with updated offsets and checksums, see [1].
> 
> This has been tested booting a very limited U-Boot SPL on boards with
> e.g. S905, S922X, S905X3 and A311D SoCs.
> 
> [1] https://github.com/Kwiboo/u-boot/commit/6d0a17632922077a2e64b13ae1a6bdf0024b718f

Is this serie ready to be taken ? what's missing ?

Neil

> 
> Jonas Karlman (2):
>    tools: mkimage: Add Amlogic Boot Image type
>    tools: amlimage: Add support for GXBB eMMC header
> 
>   MAINTAINERS                    |   1 +
>   boot/image.c                   |   1 +
>   include/image.h                |   1 +
>   tools/Makefile                 |   1 +
>   tools/amlimage-gxbb-relocate.c |  79 +++++++++
>   tools/amlimage.c               | 283 +++++++++++++++++++++++++++++++++
>   6 files changed, 366 insertions(+)
>   create mode 100644 tools/amlimage-gxbb-relocate.c
>   create mode 100644 tools/amlimage.c
> 


