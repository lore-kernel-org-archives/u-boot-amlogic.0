Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDACEC71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:33:49 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.13720.1750149226885299026
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jun 2025 01:33:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=drdtkjX7;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442fda876a6so47642855e9.0
        for <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750149225; x=1750754025; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1X6D0CmZFKuhKIucaXsHS1PW0QXBMviPNG+2skzn+Fs=;
        b=drdtkjX7zgqEK/HNyg/h9Tq8qsFldfT3V2Y+HcU/MmZFetU8UWaLEL6JKSLII2wy/k
         B6vxAvejDSWeNi+qYh3EEvD/ZZixkwlvK0BlxHcV6wDvwhs7bvzIU7wgHLP0op7D1sJe
         EG+WD0tKHyv4Ft1hTj8vygFDlKqltMD/tjkTxZJfWK6rTAdLmgsYLbNyCaXyd10va3Hq
         2XIBqSSoHnZNrVkaSzx+DeDgvtD9FcRehdLkXcBaNzH1g7usef0DzBZwUT6ZfODt7yw2
         QmIk4s8xp85hAVhmgRdBDyxCcFr3Q3xCMqx5nNIFFWiV4Iip98PyqJ2eICkA3Q+kAqDn
         O/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750149225; x=1750754025;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1X6D0CmZFKuhKIucaXsHS1PW0QXBMviPNG+2skzn+Fs=;
        b=lbigVgFst/D4zEGAZeeW5um+PHs63yDxZLYLXmc7k2ZULcFokmbDpD8jBFko5TQfr7
         nU2S9ZHsAOMm7rGQweVIBx+mSbC9CUyRXwMp0XO8jy78ZthHUkoIi4Wr4afiHyVuyYif
         N8E9VQ5ocbwDC5Ehyug4KLz3/A6bwTuNKhcbFfpT/kVRgzQG2r6y1VZUWVI1ZzyPSQbT
         UGeC0SMlB0HODBtrR7ngKmofyIYEfTdPsjGoBCWJc8W+ccKPoHqKd66AkCmMiVbJ24gg
         sNsrwBsCTKthMoHIFLtG5agEOj62w24ednNzD9tNBxjgvN3wr1TKMiNt5EuHyjDULL2p
         h3Tg==
X-Gm-Message-State: AOJu0Yyf8o2rlN1yK8gtN96jCoRNPvSspVobuMNjxzP4/QvK1ucfaXUn
	rJPlTkit/0AwCDqK/vOQ3OzvnJh6b38DrmNPk7kav4zhYwqDW6K+GvrILrA2o568LBM=
X-Gm-Gg: ASbGnctlVTM/JVHHOF0+6VGc9VQoSslR7zA65zKm0iSJG5oxsBOVnnT+B0ME0hQz6xB
	rufAdsCJ+r2Z2EbZTjYWYbQHwJZcg3kQy1Q6dJIBD7bpjo99fPZtvNQ70f/kVSizAwnGAh4R0ns
	+j2p/6K6v+E5Jixz2e28B+t6a2c84CQdijnlmnzarMgJNwxjTwN0tjERzd2xHU0CULoRpVW16bu
	zCtR85z8dRHtBgfnnOOVvm5KN3/YJVVmVSSFe+c408+MOBnRDpw1x5JTJiiR8rvvO6s9IjWtULI
	Xy2Djir2nTu+GDSxtR7YLEVNHa1D/eKjp3DH5bKf00c13at2pFBo8nLl+eo3wkNEcxfVRY5z2qX
	ng/T//rZJN7+DDP/LZ6GZozI8KtXZfyL84acD/x4=
X-Google-Smtp-Source: AGHT+IFdrRUimj6V0XE0nSEu1tYMp0HmMwO+Uls5v2hph97JboMPH6lltzRQ4skSOM8/kVLyx2G0KA==
X-Received: by 2002:a05:600c:3587:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-4533cad1aa0mr125155075e9.31.1750149225312;
        Tue, 17 Jun 2025 01:33:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3819:3250:4f73:db31? ([2a01:e0a:3d9:2080:3819:3250:4f73:db31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6389esm13083320f8f.27.2025.06.17.01.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 01:33:44 -0700 (PDT)
Message-ID: <9a5abd7c-e4f1-41fb-9622-57f10092421f@linaro.org>
Date: Tue, 17 Jun 2025 10:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] pinctrl: meson: support gpio toggle command
To: forbidden405@outlook.com, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250617-meson_ppinctrl-v3-1-218d9321a8d2@outlook.com>
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
In-Reply-To: <20250617-meson_ppinctrl-v3-1-218d9321a8d2@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:33:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2712

On 16/06/2025 19:01, Yang Xiwen via B4 Relay wrote:
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
> Changes in v3:
> - remove unused reg_type assignment.
> - Link to v2: https://lore.kernel.org/r/20250617-meson_ppinctrl-v2-1-16d1cb294ef4@outlook.com
> 
> Changes in v2:
> - return -EINVAL directly in case of error. (Neil Armstrong <neil.armstrong@linaro.org>)
> - Link to v1: https://lore.kernel.org/r/20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com
> ---
>   drivers/pinctrl/meson/pinctrl-meson.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index babf1bccc969..7dbaf966f93f 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -117,8 +117,26 @@ int meson_gpio_get(struct udevice *dev, unsigned int offset)
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
> +		dev_warn(dev, "Failed to get current direction of Pin %u\n", offset);
> +		return -EINVAL;
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

