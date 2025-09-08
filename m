Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB6FCA1013
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 08:10:22 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.7580.1757319017627314296
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Sep 2025 01:10:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fa6mArdo;
 spf=pass (domain: linaro.org, ip: 209.85.128.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so23834745e9.0
        for <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757319016; x=1757923816; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DyBnEDJm/cOK871iR7+touhMmlUnmvLtw8TC0gBp7c=;
        b=fa6mArdohf8uAVJnYqdwo6t0o1n2lDPi6TCVtVBRg7bdWOI0M+m6z0oMlJsNyw3xxS
         EGZaFR3NBz2Csk7vA2lPV63MDLaEVwwGUuYTfxLpHJtvDZIoypD/T3TBlUhC2lmQLvHL
         Sy/CyO/gtpK89T/srljecuX/gpH8Ntvpvji4kLoTn0g21DE9zMege2XFL4FOuPhh9DZ/
         VmS6JgsVYXGZ18gniOCTaecE0bMnwCqU0L3ahG31UjVziDDLj9SXkYIxNJaMVxhBm5J0
         /6PbXu9958OJjgKhb6dZSxu0itvgLTtIob+WDs45Ub+hB9Y6wMrZfSHBGn8LR/vpX1r9
         rBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319016; x=1757923816;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2DyBnEDJm/cOK871iR7+touhMmlUnmvLtw8TC0gBp7c=;
        b=OvsaaEgbF/k3+AT4G8rzoHq9Yf4CPeTn9Rx3iheNA+5ieTDtyUBD55pOVUn7wY04/u
         W/+mBB0dpN0ppEc7ZZdOCpf2A94w/WojpyeHcBAUsl954nMjuzEHOvTlQ+U/CnrJBuiP
         u3f+It4On6jCvAlfzWgC5pLBj+pT0995QGnEO/QqYyI3Uo5oU3NZCRv0Yks3agHMBAy9
         xzj6jRlBfcPz7JzSgk93HeWI1cnJybyfy0B54qsPnVAZIygEIIyzHA8Zl+y0CdQSCJ2+
         LZxwDf+z7xrAbK24/NCqfZVkPPku1vDkhXN3G4jaxlAeeZN+4OqcS9urWknyijDm5FCf
         jSYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFUCK5p2wAHbKFP3cquviFTEUIWzyLVaCJixbCuFXJs/NCejOfh38B9YpIbjWKxlMgd6e6e0TMrskIFcFfEw==@groups.io
X-Gm-Message-State: AOJu0YzffmhRv+mekoxu/AivQ5iBbmo72572ewY+ARYSj5weEEMtZnO2
	5VsMPf0iYcIXGCDRg4VRfXGo4njRr19fGb7mXtO4a7GaiEfZng+4h8EoEH2su8W/B48=
X-Gm-Gg: ASbGnctSyRxn9k/M/LfbgWgX3FddSwGCLxbPrpv0i9++K6TENv0yhi0Fy+0WIXTafbF
	sJ6ewVdQKB0lUCM9S0hcnYVFPopX8z4bm70URdzb9l72pXjPBZi/3zeax13MuLhGPgsvN4sXZeN
	HoTf/vc8b7FPZjgp3o0jcoOIbppfupP0kxzC1vlL1OsgiZH9ApFlSLoacnU+SGjyuzggWnn7NHn
	OnOwPJ6qswA4o0Er5DmLkMfzXSOH75EL94/NZJQHJtZKvFZGDdcb/pEH1B9mQkQU0ScxSEuFGfy
	0cXwDXgr0HFhhyHjCBzClEupo5rNc81JodoAtqKSOQpcMOrFzMb6qTujuL8pf7z1LqRrlkaC+5V
	6FMawd6j/3DT3NlXZWixWicyT8WeFBXs7Hi/Gbk9amCTf5UrJLobZGZyB1N3QXnTpGHcf5vkdqb
	uiNIzBJUez1w==
X-Google-Smtp-Source: AGHT+IHh7sZvWhs6RE3omVCSRw5onP4gN8+ySacRF1tTchMHgRPz735tdNkjcYaE7qV3DrILtcscaQ==
X-Received: by 2002:a05:600c:1d22:b0:45d:d202:77f0 with SMTP id 5b1f17b1804b1-45dde1b14f0mr51278165e9.5.1757319015906;
        Mon, 08 Sep 2025 01:10:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm434452465e9.12.2025.09.08.01.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:10:15 -0700 (PDT)
Message-ID: <7dd0f481-3e43-48f1-8549-49918d6facea@linaro.org>
Date: Mon, 8 Sep 2025 10:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 3/9] mmc: meson_gx_mmc: don't bail if there is no
 clock driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-3-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-3-37395d9ff5af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 08:10:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2753

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> The clock driver is too big for U-Boot SPL at the moment.  In the
> meantime, continue mmc init even if it is not present.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   drivers/mmc/meson_gx_mmc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index a4338f1e29c1da07acb0333be9b75a318cba1334..d83a79fa0894fc6a32c40642ebce5f845120efaf 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -332,11 +332,11 @@ static int meson_mmc_probe(struct udevice *dev)
>   
>   	/* Enable the clocks feeding the MMC controller */
>   	ret = clk_get_bulk(dev, &clocks);
> -	if (ret)
> +	if (ret && ret != -ENOSYS)
>   		return ret;
>   
>   	ret = clk_enable_bulk(&clocks);
> -	if (ret)
> +	if (ret && ret != -ENOSYS)
>   		return ret;
>   
>   	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
> 

Can you only not bail out in SPL ? I would like to keep the current behavior on non-SPL.

Neil

