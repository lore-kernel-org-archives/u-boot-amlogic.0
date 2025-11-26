Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B12ED10F45
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 13:11:06 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12513.1764162657059909376
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Nov 2025 05:10:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Qj9BZDU2;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b379cd896so3733038f8f.3
        for <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 05:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764162655; x=1764767455; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrIoBFBz2wgdKcbz2c+A/gjGCkE3op5fxDQoX0ddYek=;
        b=Qj9BZDU2RC1rNOhKYmGiEb4JBF472nikhhtTD1TBLlzguTEb6NC817MWfHDdC8hdLz
         rDAcDgdzzWb0eIpQT0Z1CdEZuc3s1AwuM4onY23l3apz5ddyyMHbxa/dWcJ/bbqv+PUN
         0MiNt9PnHsJsKE7NZp5aJuz0pX9cCtWUYLiYcqZThzcTejL2Db8DAeho9KfHZJ9IyOI0
         hB2ewD58FDXOvhk6/+WDGURLpRWKvs1ghB14Ebih+8iI59Hr0Bkyd81VdMlhwENSWYH8
         WjleRj7BxS6VYeB4Uj9yKcr38BpGc4LiYRiGDihrODjdQaGTdBWJ3s0gbMssZ+8xpULY
         cVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162655; x=1764767455;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrIoBFBz2wgdKcbz2c+A/gjGCkE3op5fxDQoX0ddYek=;
        b=eWc/m1/PLYCNsw8+EtefW0d3hVl8H6vCDkoRUowlacCpk1Y79IgeHwhY6YbSKVf7Iw
         nz5WVKHwWC8BpJE5xWH1vL9OjuXYIx8WEQROPVyeGcUwTKO1RoQQELRWhw9Svu8BqtGV
         glNOckHU3aPjMBWpg+8C6YYK0r5DjDmcIDV+3eseqFMGxkT3qhkDoOvVgRXrQccsxhyr
         8v6wlE+5ULylPK8ymDvw3xRVYSH1J3MoPzHahCRhHGki4pXkNqZT1sQoGjbGgGQ8aFSv
         BPz/G3ZA6SPP+uqNA/E5ytbvszXE4jPqG5xKZ2PQfLt3F2k4+r5MOp83JhRabGyLNx2t
         4MeA==
X-Forwarded-Encrypted: i=1; AJvYcCXBgWe3WjhgZKu7ndrHQD96G0vAFgFHWbjgMZRH1E7O1k4wD0aJTyp44WdVOb8+atSJ+1dM7jDrA/OF8nP7yg==@groups.io
X-Gm-Message-State: AOJu0YweNye00xTPCYsSOZwhGPC8NsMzoI6Y5m4OZBhubxuA/cPeK2BF
	Ayj3IUFNcqw+nnPAfIWSpYZZ4voSolAwt35XtXuEuRLBdQxnja3HZN1lc/r8px8UIYI=
X-Gm-Gg: ASbGnctgyB4oSkWygnSqt4kXsRM6KrgdqUfQmYHHEcC7Mfs/bW7xcubmBdr+rIuFew1
	Nt79gxhgTxi47ZFkepfLcEw4H7tyPCI/cmlSp6lums6r0BajBIXBv0L4iAHwEqqaqlg+R9OMUHo
	2xUF8MXfuLtnDzEXG+yw/vApDeXw5+MkFdzO9edelGvUlt1ldW4VIOignl2JPyObh7Iww2AFUFI
	FNj2FPmCXATuvqaQjrykax1zIyY2zvstiYkQQkBRbek/3s8sqCbi+TpfovJPN5vrB6m0ibmFamK
	E0nk+dE/dDKNNEVwFim1fPiceKa7tvWIBRDOqsPTuqJT+Yl5rad4RDCftu/6Pqogm2XV5JbBP37
	QSsI1xlNbWusOsrsYVdCW5L8Lin2p/Pv1rhVAUuv8Bd2OP69MlCW3z+tRa6wk6S4NPqYERbxKYI
	YDDLfG1CPnpqx/UymheQ2kkX09WyhczCAQPQWwZ+xfZD0y0azFUlvHgLAohePF
X-Google-Smtp-Source: AGHT+IFHNz54TgWOUUVPb68Mxt5+k8eUSXq+l4G0w88Y7ghi6Oq9JQUWxGnslhA2eOHbkFl/WYV8cw==
X-Received: by 2002:a05:6000:228a:b0:42b:2eb3:c90f with SMTP id ffacd0b85a97d-42cc1ac98b4mr20719151f8f.10.1764162655306;
        Wed, 26 Nov 2025 05:10:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:91ba:3a5e:334:4534? ([2a01:e0a:3d9:2080:91ba:3a5e:334:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm40805651f8f.39.2025.11.26.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 05:10:54 -0800 (PST)
Message-ID: <4934bf6f-a667-4b29-885d-045fe68c7763@linaro.org>
Date: Wed, 26 Nov 2025 14:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 09/10] spl: meson: set SPL max size for GX SoCs
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
 <20251126-spl-gx-v5-9-6cbffb2451ca@postmarketos.org>
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
In-Reply-To: <20251126-spl-gx-v5-9-6cbffb2451ca@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 13:11:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2864

On 11/26/25 13:17, Ferass El Hafidi wrote:
> Enforce the max size for U-Boot SPL at the Kconfig level, to prevent the
> build system from producing an image too large for the bootROM to load.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   common/spl/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index f34b96efc02..bc233fa2ed9 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -41,6 +41,7 @@ config SPL_SIZE_LIMIT
>   	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
>   	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>   	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> +	default 0xb000 if ARCH_MESON && MESON_GX
>   	default 0x0
>   	help
>   	  Specifies the maximum length of the U-Boot SPL image.
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

