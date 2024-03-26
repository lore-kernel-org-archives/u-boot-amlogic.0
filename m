Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8EBCD11DF
	for <webhook@archiver.kernel.org>; Tue, 26 Mar 2024 10:21:18 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.5413.1711448475651614932
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Mar 2024 03:21:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=JnrzI+nb;
 spf=pass (domain: linaro.org, ip: 209.85.167.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515b3077d09so878115e87.1
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2024 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711448474; x=1712053274; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZqfRGRSliLghS0rphzp8Xt9mme2q+JhQpqs3+sUNcE=;
        b=JnrzI+nbVe7J40EaJWpgCPiry8fGK1n4B4r3bmyoB6ZaIHCYC3VCBoCaHbNVp20mmD
         Ct/ajsq60076Irk6m2rT1pZxO1/jj6Te9FF4xaNiMD+qYXrd/0Cl/6XKnvjJEmn7C4Hf
         Ob+UdjKQImEm6KZji2EW4mzpCpNAt1RfWMNjzbpiKSpR929P3+H29e+8vm2DaUxVxLiC
         Jk/47bLDWfvJTvH5u0O/nF/E6CP55IE+2KqBUCG27Z3la3OcovsDWvL6BOqibPcQgREY
         Nmjxh0pjTSIyMAcsfxCC0To6YAGWa+sqNuMFpPLJHh1AwZdBDp1XKRs/XVfzHuZ2hWZI
         1q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448474; x=1712053274;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qZqfRGRSliLghS0rphzp8Xt9mme2q+JhQpqs3+sUNcE=;
        b=pJiPfyoC0AxMkhFzZ11BkM6Ac/AQ9b5BFvxz1uH+lxOkrvyXMK0tL4iMvFkfQvhvHh
         xCHGmWKwPu3Of16K5Zy5ktQ6jAsgO4tK6OCWZrWe5UKjjD06+uaQtgiuPw/wpBB567W8
         mKLXGQ+sDxnIqjrZmeTYT3eiFQXEgFYFoD267jhfriMFe7qVP79ldMML0jx0dybVtA6U
         F8muI1UZu4zeF2h1Ac5rCg03E2ZViEDKUh2V98H6eO3REEGHipianzqVZ4qZ8WCnez9P
         scrQ6EOfthsMwXZ/l8sCA1/HyaDTRilREcWlHtqiJ4P7PqO923wIvnKcbtaDzTDRyzNX
         Zlxg==
X-Forwarded-Encrypted: i=1; AJvYcCVakKHwUBzp1a9YsnINX3nhtW+znP8d4yfLbsad1zPc0Q5fZPyE5U7MgxCX5Wb8nz4VwuOkrV+zK2ZWiN0Nv5n2TfOhYuDnQSU=
X-Gm-Message-State: AOJu0YxLDNSXejYILmy19e11j48wrN1vQ/yVoyRLpCQxG0eiSea/qSAU
	aws65CG7sP37avaaqLQ/NcVJ4O5kMCUkIFRg4Q9jTy812wlagCIO4HMjrthfOO0=
X-Google-Smtp-Source: AGHT+IEQOs4QMwGIiOvKAb7bOjNp1zhplN4N2rROAEGmEHhy5fpC8QzSmDvt+CTrA2NjC/J2H4BirQ==
X-Received: by 2002:ac2:47e2:0:b0:512:e220:d3ab with SMTP id b2-20020ac247e2000000b00512e220d3abmr6381472lfp.65.1711448473541;
        Tue, 26 Mar 2024 03:21:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f220:43f0:cd6d:7275? ([2a01:e0a:982:cbb0:f220:43f0:cd6d:7275])
        by smtp.gmail.com with ESMTPSA id s18-20020a197712000000b00513e24c304fsm1507975lfc.193.2024.03.26.03.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 03:21:13 -0700 (PDT)
Message-ID: <791d5926-7541-4c5b-9fbf-03be90364c03@linaro.org>
Date: Tue, 26 Mar 2024 11:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] board: amlogic: jethubj100: fix update docs
To: Viacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240326082004.1651782-1-adeep@lexina.in>
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
In-Reply-To: <20240326082004.1651782-1-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Mar 2024 10:21:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2249

On 26/03/2024 09:19, Viacheslav Bocharov wrote:
> Fix linter errors
> 
> Fixes: 2fc5e3c1668cffdb4b894986e98c1ee10f6e9955
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>   doc/board/amlogic/jethub-j100.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
> index 80bed6e919e..cbf1ea76107 100644
> --- a/doc/board/amlogic/jethub-j100.rst
> +++ b/doc/board/amlogic/jethub-j100.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0+
>   
>   U-Boot for JetHub J100/J110 (A113X)
> -==============================
> +===================================
>   
>   JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automation controller device
>   manufactured by JetHome with the following specifications:

Thanks, squashed!

Neil

