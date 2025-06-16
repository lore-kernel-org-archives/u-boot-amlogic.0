Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43679C71136
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 16:40:42 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.1897.1750092039330484889
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Jun 2025 09:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=RFaUP9sO;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so3760910f8f.1
        for <u-boot-amlogic@groups.io>; Mon, 16 Jun 2025 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750092038; x=1750696838; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcKwZAiVPv4FcYz5W4+J5tCKzB1NjRbzOUmdxAIRS1g=;
        b=RFaUP9sON1VKR/n0IJ1x9gH0QIf4REFeoiXeIuvm5QT2JCMX94tI0Rg3kLvlwbtUPH
         N5x0QrjHFCuXScBiSz9Uf3kAsVwPBhzgPoPoiY//UcjOfnhiCMqR0qFhsqbyO+Bu2kQc
         zsm5pRQbvlsfdCvjUnQrkV8r2ffdvcWsBsD6YbWdiEqdteYwlrTzrIO2ezKqASZCpe/Y
         yaxilKcQlHaOxeE1+dKHyDQ1ho9XFwZRV7RGDEOv2bhcEnT8qv9r/63vxNSdTdbS/pEw
         5c8ZC1EeCF+wTb36gFU4x9DEov8wlkNLhL5VAkCCIWpYzpePme3n4uDI7+YeymeLUm+a
         6ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092038; x=1750696838;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hcKwZAiVPv4FcYz5W4+J5tCKzB1NjRbzOUmdxAIRS1g=;
        b=B6ubVx/OIiFhZEepJR5A9YmkcBWcxtyWcfvBJqkp3D7MLlsEEASAMJeAytUAFka/rA
         c60dWaEN0QHJqzbCrxfx32ovokqG+Rgy7J9xmVJxkr/2BZL+6hhMNcLPKNrGqR1cjHwr
         IU2bMjlzx2EeUlE/QfLIGM0nn4z0bDdecBAkzK8G+hPZtuv+gLVyA4y6Z8czm4KEjLOw
         TwqdphX3ctkTh2CO5CAwq6Ar/BrNbHLZah79QmcBhab6XBMGS4zcrPL4KVQhR+wQVPFd
         4+fOaLnjab4WwuPEflsAThAM2VlOWQYh94IQmcqExx92bByhbIZtPgpDRVl3TIxS896I
         8ARQ==
X-Gm-Message-State: AOJu0YwmnmGDr3+AJNTK5Yb54org1gS+hfZVNhbuHnr51TnIEEqr2AAr
	rZq7F0mvvIl4wqyRXNDWjqphusKt6tT3dMF3jWHBnT8T94MiCBDaOfCjRilRXWalyfZ0EUvqxVW
	duQmEx/E=
X-Gm-Gg: ASbGncsXbjkofUkrVO2ppOt6kW1AMvgP0fHXk5G9rytUx8OdgZHU00puqMHxCt0NxIZ
	gfw5ZqEc+wIrTgJ6QCJbyw0n/EpSGamR4svBH3d+Nj/2eJb9WqZUZ7OnbUX9PgM1+jKoNMc1NLk
	sf+5ekiLPOVxL+nmhku+a2bGCEqZZ9eDXWJvFyzmrq2OsVBFcjTzG6Dsf7z2fzcf3YfwaH9svyi
	vk3LJagfQuzozBbggl4qrnVxu2tQVbF443h3+xBsiPP/HoQ0cV8UPRnzmlLILpb7OkZ4WhYg9ln
	djigelgtqxzN6dO1Sl9UL3dlR+IJeI1ZjsgSCYYwCXGsZJnprq+p5JlBBRsUTcjHUdYJ0/Ws/xS
	94zFKXmm3q9OxUmTa00UQuaiywYfX3Dr3it75
X-Google-Smtp-Source: AGHT+IHg01366LdLrsnTbbnP4fKY+Xr83m8gzgp9G84snc6OJBUhOTfY4zl/WZhoVEwQS0nD+q/dIA==
X-Received: by 2002:a05:6000:461e:b0:3a5:300d:5e17 with SMTP id ffacd0b85a97d-3a572e79733mr6984547f8f.29.1750092037760;
        Mon, 16 Jun 2025 09:40:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6c7:97de:65a8:488a? ([2a01:e0a:3d9:2080:6c7:97de:65a8:488a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b28240sm11580556f8f.72.2025.06.16.09.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 09:40:37 -0700 (PDT)
Message-ID: <28b0f2cc-4403-4473-8258-c08f12b1bd5e@linaro.org>
Date: Mon, 16 Jun 2025 18:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pinctrl: meson: support gpio toggle command
To: forbidden405@outlook.com, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com>
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
In-Reply-To: <20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 16 Jun 2025 16:40:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2709

On 16/06/2025 18:23, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> meson_gpio_get() always assumes gpio is configured to input mode. This
> is incorrect and breaks `gpio toggle` command:
> 
> gpio: pin aobus-banks2 (gpio 2) value is 0
>     Warning: value of pin is still 1
> 
> Fix it by adding the logic to handle both input and output mode.
> 
> Fixes: 2009a8d03fe5 ("pinctrl: meson: add GPIO support")
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   drivers/pinctrl/meson/pinctrl-meson.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index babf1bccc969..a1f4afd11f94 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -117,8 +117,27 @@ int meson_gpio_get(struct udevice *dev, unsigned int offset)
>   	struct meson_pinctrl *priv = dev_get_priv(dev->parent);
>   	unsigned int reg, bit;
>   	int ret;
> +	enum gpio_func_t direction;
> +	enum meson_reg_type reg_type;
>   
> -	ret = meson_gpio_calc_reg_and_bit(dev->parent, offset, REG_IN, &reg,
> +	direction = meson_gpio_get_direction(dev, offset);
> +
> +	switch (direction) {
> +	case GPIOF_INPUT:
> +		reg_type = REG_IN;
> +		break;
> +
> +	case GPIOF_OUTPUT:
> +		reg_type = REG_OUT;
> +		break;
> +
> +	default:
> +		reg_type = REG_IN;
> +		dev_warn(dev, "Failed to get current direction of Pin %u\n", offset);
> +		break;

Just return -EINVAL here

Thanks,
Neil

> +	}
> +
> +	ret = meson_gpio_calc_reg_and_bit(dev->parent, offset, reg_type, &reg,
>   					  &bit);
>   	if (ret)
>   		return ret;
> 
> ---
> base-commit: c5afa1fef49f55146e78d6157470520391c40eca
> change-id: 20250617-meson_ppinctrl-5139ca06b828
> 
> Best regards,


