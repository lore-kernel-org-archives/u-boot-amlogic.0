Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24739C27C53
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 09:38:20 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7213.1718185090900773793
 for <u-boot-amlogic@groups.io>;
 Wed, 12 Jun 2024 02:38:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=DvM5opsC;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so32887195e9.2
        for <u-boot-amlogic@groups.io>; Wed, 12 Jun 2024 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718185089; x=1718789889; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzljB8jmpcEO9vcgAPg2Nspsl2b2Y8mmxAD2e8IXtG0=;
        b=DvM5opsCvmFGWyaLuroN06Eu42DAPiZvqmJkmJbX6GPnkQYcokg4SL/WkkddiHyIUD
         h7LAG45U3vP/35w2N4SzCrsPzmy5b+NFUobJ06/MPGnCHSRymr8BYTulmjpXDE7VgVzH
         65o2cxYWoB11Z4Htow5HPvlAUZ+3i5JNxSByf2jBLEP7szOsNAI6NWV8RvybiMplSF/6
         Kae8hZxZbPCc1yMtm+mNSlSV4UmAVbakbjNCk90XTMso9cfqTu//luIbZYKFmcVC67/a
         /UbDTTL7seB4wMsDMlTBCcC1inPKWKnayMV+t0r0pdq9OMR1AR06Q55LFp2XlclYPs47
         2XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718185089; x=1718789889;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VzljB8jmpcEO9vcgAPg2Nspsl2b2Y8mmxAD2e8IXtG0=;
        b=q2aBYA/NVcCFFsTc1hgb6sBCJisM09nKcn3dYXtlIw7qv8ygjJ3QMZX+xUaBP75G9A
         yrQnrUj74ICV0DM1BgpOdxfsvUvEBiTxBSz7esQJRFxT7ggkaPdAPBI3sIpKEg/x/0MA
         Vddm0Lt91GD4633Bl1CGrSKlQ9GdqKut6dCzGQh4rhDK+9839UJZwJwt0B0OZngsc27n
         XOLYItzJ6XP5/fJYb69QSLGL3gOhZtVjXVVuRILLtCjOflFscUV/AUmBwR1E+k2vFiPa
         UDAYQVOnzKI4NJai/nyC98nSa3EOMr9kFXMWhdzbijXSmTtynwM43oMeqVnh5CfgweyG
         J34w==
X-Forwarded-Encrypted: i=1; AJvYcCW1PbU7k2eQroN4CcHow9PO2GvO7ibE25NojVLUbJy2/E7UZcrswjGhWuMkJckRzfkUFgSBgXCuzR/ONPZOKybkFkpV90LuS+o=
X-Gm-Message-State: AOJu0YzJ7gayHsuEOiz1woM/ASbk1/8R+zVccqhTwsVYx2CcjzA/1va2
	lY9V1bBBkm6ILkOunbLkgUwi9GaCRIeh/EgFbYmK3+i9VvYUeAa93KAoMejntrA=
X-Google-Smtp-Source: AGHT+IEa9jduPgL5gzXIBcDAH5XUaC9iVf2SX3cjtGVpA/X0ZzyvVO2vj5hj7djYeBo/QKfuhbEV+A==
X-Received: by 2002:a05:600c:4587:b0:421:7983:f1c4 with SMTP id 5b1f17b1804b1-422863a85bcmr11697725e9.6.1718185089242;
        Wed, 12 Jun 2024 02:38:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb? ([2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe7629sm19043315e9.10.2024.06.12.02.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 02:38:08 -0700 (PDT)
Message-ID: <37218b15-80ec-4bb5-9c64-91b94f5c2679@linaro.org>
Date: Wed, 12 Jun 2024 11:38:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 18/42] meson: Correct driver declaration for
 meson_axg_gpio
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot-amlogic@groups.io
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-19-sjg@chromium.org>
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
In-Reply-To: <20240611200156.2245525-19-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 12 Jun 2024 09:38:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2290

On 11/06/2024 22:01, Simon Glass wrote:
> This should use the driver macros so that the driver appears in the
> linker list. Fix this.
> 
> Fixes: 8587839f19d ("pinctrl: meson: add axg support")
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 2 +-
>   drivers/pinctrl/meson/pinctrl-meson-axg.c     | 4 ++--
>   drivers/pinctrl/meson/pinctrl-meson-axg.h     | 2 +-
>   drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 4 ++--
>   4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> index 52c726cf038..15ebd574ef1 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> @@ -179,7 +179,7 @@ static const struct dm_gpio_ops meson_axg_gpio_ops = {
>   	.direction_output = meson_gpio_direction_output,
>   };
>   
> -const struct driver meson_axg_gpio_driver = {
> +U_BOOT_DRIVER(meson_axg_gpio) = {
>   	.name	= "meson-axg-gpio",
>   	.id	= UCLASS_GPIO,
>   	.probe	= meson_gpio_probe,
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> index 94e09cd3f8a..ed3f92b2d75 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> @@ -939,7 +939,7 @@ struct meson_pinctrl_data meson_axg_periphs_pinctrl_data = {
>   	.num_groups	= ARRAY_SIZE(meson_axg_periphs_groups),
>   	.num_funcs	= ARRAY_SIZE(meson_axg_periphs_functions),
>   	.num_banks	= ARRAY_SIZE(meson_axg_periphs_banks),
> -	.gpio_driver	= &meson_axg_gpio_driver,
> +	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
>   	.pmx_data	= &meson_axg_periphs_pmx_banks_data,
>   };
>   
> @@ -953,7 +953,7 @@ struct meson_pinctrl_data meson_axg_aobus_pinctrl_data = {
>   	.num_groups	= ARRAY_SIZE(meson_axg_aobus_groups),
>   	.num_funcs	= ARRAY_SIZE(meson_axg_aobus_functions),
>   	.num_banks	= ARRAY_SIZE(meson_axg_aobus_banks),
> -	.gpio_driver	= &meson_axg_gpio_driver,
> +	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
>   	.pmx_data	= &meson_axg_aobus_pmx_banks_data,
>   };
>   
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.h b/drivers/pinctrl/meson/pinctrl-meson-axg.h
> index c8d2b3af036..a6581bab500 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.h
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.h
> @@ -61,6 +61,6 @@ struct meson_pmx_axg_data {
>   	}
>   
>   extern const struct pinctrl_ops meson_axg_pinctrl_ops;
> -extern const struct driver meson_axg_gpio_driver;
> +extern U_BOOT_DRIVER(meson_axg_gpio);
>   
>   #endif /* __PINCTRL_MESON_AXG_H__ */
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> index 24f47f82558..67114df6824 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> @@ -1253,7 +1253,7 @@ static struct meson_pinctrl_data meson_g12a_periphs_pinctrl_data = {
>   	.num_groups	= ARRAY_SIZE(meson_g12a_periphs_groups),
>   	.num_funcs	= ARRAY_SIZE(meson_g12a_periphs_functions),
>   	.num_banks	= ARRAY_SIZE(meson_g12a_periphs_banks),
> -	.gpio_driver	= &meson_axg_gpio_driver,
> +	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
>   	.pmx_data	= &meson_g12a_periphs_pmx_banks_data,
>   };
>   
> @@ -1267,7 +1267,7 @@ static struct meson_pinctrl_data meson_g12a_aobus_pinctrl_data = {
>   	.num_groups	= ARRAY_SIZE(meson_g12a_aobus_groups),
>   	.num_funcs	= ARRAY_SIZE(meson_g12a_aobus_functions),
>   	.num_banks	= ARRAY_SIZE(meson_g12a_aobus_banks),
> -	.gpio_driver	= &meson_axg_gpio_driver,
> +	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
>   	.pmx_data	= &meson_g12a_aobus_pmx_banks_data,
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

