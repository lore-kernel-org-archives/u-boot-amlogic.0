Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F5C3601A
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:31:17 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.41392.1744011075053825616
 for <u-boot-amlogic@groups.io>;
 Mon, 07 Apr 2025 00:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wTsjLK0b;
 spf=pass (domain: linaro.org, ip: 209.85.128.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so37264955e9.0
        for <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744011073; x=1744615873; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgnzGwMFqik1SgYBiNQCjGEuVxTfpGngc2l6gVfiw6g=;
        b=wTsjLK0bgRn0u/rd/BmRAokeMd7y0LMf19/nZ3V7GoCEziH09RBI3aFxCZzwXwsGAE
         LTkfuTm+/DmI3/G0+dGNFnbXTPUGSpznEP+oKL67Pi2AvybmuAS0bOANdQ7fJaQj+HMi
         NwWz2bZiuJx7dNQW2Kg+OX/Hl7nQT2PAqlEWSovXtjd1Zbqi2OuOpU0WGT6xuVS8FNyW
         EooITEHQINC3sLeoLXNPBVPPKgniPl3bAtfIY3LPAOvjkr02nLWFtPeWOncBiwJ5Z3gq
         o7Jgyr/2l29W8tznMT+Dq7vA2fLDMnPuwHpyzLL+SAB7rFbpZnPYPgop7i9mFfaB7wpa
         exnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744011073; x=1744615873;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DgnzGwMFqik1SgYBiNQCjGEuVxTfpGngc2l6gVfiw6g=;
        b=X80D6LTtGtYoKt7uebAkuX6wZHYFlT4Mj7KX8iB4CvJas83/Iy6yNG3FFkUMD0JXb7
         MZW6+8Q8QLbo1yzhOlgqAxjjalJ6StyYfnRImJ4pMdpQz11ST963lIebhDpH9TD6zO2T
         jgb2r3T4J+qGwwPxoDlMSmEYOpUKdFTt68VhgWjMxcxSYcEN9jKhnr23MCbndGdx5vTq
         wvxghLY5JGoUMyBXfAKpWLEkwfyGBePtj9Htx3ZTgQDrH9HmEuhAJgER1rTwdDJFzNl/
         ohyYMNqrtHouDncxURT9BZGG3Uz5YgpHD2JEQnHpNuHRYpecfRP/57OOwVicW730eEeF
         J4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1iK6EV42Kw8MajZRn/B4xSW2b+0i514SYJXVa+BGcqMA5/06wRHNf5kdRj3iCa3hMFJnO23y7WF0Qu+o4/Q==@groups.io
X-Gm-Message-State: AOJu0YxDBX3hME6nEVOrqBJTQGvMIpLLqZtEW9Cmw/a1pHC+NWd9gjQO
	Q4vigoZtyLsjy2sJMW1y5Ylwjjy3mGDi+Ji4L7s40HlkDZKGeskd24jV1xgPXDw=
X-Gm-Gg: ASbGncu+/wTsk82w3hYaoCjK7CRMh03c9fQrxu8362aIN92gLIoBxWPVwH0aODA77TG
	ZfK6iurK/pSf3LSkSDVGH+2OFVMjFkdsH8arYpwp/ZIEgxhyve6u/pJo73CwyP/C48QqYW/xAkq
	SBYNMGjyUfC4pkKvXJcz48xxZtJqeQ8ckkavtKWLaEfw1Nea3XKsxMx6Pr/r5UKLr9ZDPc5W85I
	qSpxq9dewOVRP2jVRlLLDJFJMhkzzBGJILc8kLOZk76afGO3vGbnzv+EEyXfwT9FmOQgqjfqPzg
	Uoiahn3P3fkkd2clO/OBnzCOPe6nn3mMYwmD4EdyJrqudyLc2rpTUY1HpGhRCPCOCvhhLPGYUrP
	HICpz1SOaHRp5cNXZQFtYaLL1UU+EoAaZ
X-Google-Smtp-Source: AGHT+IGKouIVklPCbGrSKaug/gqd+EHqloSYS9rQkTIIgWb44V8eeNca05mOMdTCp+6vP4Bk0eV0lg==
X-Received: by 2002:a05:600c:1ca4:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43ecf842872mr94418695e9.7.1744011073425;
        Mon, 07 Apr 2025 00:31:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605? ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bbd9csm120195355e9.20.2025.04.07.00.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 00:31:13 -0700 (PDT)
Message-ID: <65a0b534-cd01-4fb9-a4b9-f135a6ca0fe8@linaro.org>
Date: Mon, 7 Apr 2025 09:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/4] net: designware: Mark drivers as having active DMA
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jim Liu <jim.t90615@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-3-sjg@chromium.org>
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
In-Reply-To: <20250407013513.638110-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:31:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2651

On 07/04/2025 03:35, Simon Glass wrote:
> Network devices which use this driver have DMA running while receiving
> packages. Add the required flag to driver model so that they will be
> removed before starting the OS.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Add a new patch to mark drivers as having active DMA
> 
>   drivers/net/designware.c    | 2 +-
>   drivers/net/dwmac_meson8b.c | 2 +-
>   drivers/net/dwmac_s700.c    | 2 +-
>   drivers/net/dwmac_socfpga.c | 2 +-
>   drivers/net/gmac_rockchip.c | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 5385849ea6b..9b2b0a5d602 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -885,7 +885,7 @@ U_BOOT_DRIVER(eth_designware) = {
>   	.ops	= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dw_eth_pdata),
> -	.flags = DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };
>   
>   static struct pci_device_id supported[] = {
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index bf94e50842d..95a99a98e99 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -162,5 +162,5 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
> -	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags		= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };
> diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> index e78193f3376..21df8e3ce81 100644
> --- a/drivers/net/dwmac_s700.c
> +++ b/drivers/net/dwmac_s700.c
> @@ -64,5 +64,5 @@ U_BOOT_DRIVER(dwmac_s700) = {
>   	.ops    = &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct eth_pdata),
> -	.flags = DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };
> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> index dda33f90d65..9f262aaee60 100644
> --- a/drivers/net/dwmac_socfpga.c
> +++ b/drivers/net/dwmac_socfpga.c
> @@ -145,5 +145,5 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
> -	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags		= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 5c542d62bd8..52be3a5687f 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -760,5 +760,5 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
>   	.ops	= &gmac_rockchip_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct gmac_rockchip_plat),
> -	.flags = DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

