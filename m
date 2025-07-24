Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBF8C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 08:30:52 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.7751.1753345844594447171
 for <u-boot-amlogic@groups.io>;
 Thu, 24 Jul 2025 01:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=zaiHgv92;
 spf=pass (domain: linaro.org, ip: 209.85.221.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1097512f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 24 Jul 2025 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753345843; x=1753950643; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuG6KVRHo2C+iB3ddTGNs6hYkbiFrpONss8PFjYLxrc=;
        b=zaiHgv92lyMwJD4+C8R8xX+pYc4vbsDTCv6Ep/7Nz7UoGdHQ+LaAxpRI6q/rqY6cmX
         LP8yR1BrII44oEO82yNRM7JfNZqx0aS7nJbz1F1EfI+m5J2DX4DzuyKL37vJH7ZDEyAS
         bV/piEj0Edn6t8rmvNopF3hCby0nSbETBYwFX5Ay7551PL9rQy1An1mSskzbycXk1vsT
         /ma2l6pXRReND8jR3guRlMYajy61t7zgTHHnGnCevaQxNsyNQSD7MHUBTHrkR+fsc3Vt
         TRT9j6iKzUxAmi6LX6QD2hho5XVqqx3VEK5kjSCWqFF8wRGC1tLz+l5LktX2lTtsHDWJ
         Qn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345843; x=1753950643;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XuG6KVRHo2C+iB3ddTGNs6hYkbiFrpONss8PFjYLxrc=;
        b=lwZaC0Rk3uWJ1zSP5IK5PncmnKYiGpi4SIvoF94A4H37Tm9Zo0TGsFITOvQUHhHmwD
         G9DVs48EWdPzFUH0f0pJYk7Ai0GvpRfzO3c8/cJK2D21yi8KgXOVoU0AJ59l8RIgVVff
         vdTef9I/FyLfYWWxOdrjVaaLjYlj0JCuw6Kc1oDsPvIn4A1U/XGX9CCi5YBM8vu1JOSZ
         CGAdyHasJVzShNQIa+Wc6T0L86i7DEE9S59j9G9gpbFO5OVEAITyLZDOJcFf+8uD2V53
         ciXsLIHYajQey9c6acS252miieCdu8PIqlKZfBgtdlbFMe0A7cRKaPvISoyfwfchqVqX
         bpkQ==
X-Gm-Message-State: AOJu0YzxHYJX0mEFkgoHlHu/yDDxBZGzMGQYyvvRsqRwJXzOrga7Ngpb
	yBmMo7DtiqLeclZ5E6V67VXxn5OK3POJJjKmIZuhyEEezO0HIIfxQ39MmByxet/Jggy1apf2QnP
	iv+zq
X-Gm-Gg: ASbGnct2u9IAmCvGwYPhcnwoLdhBPpkqMwPNuen+l0PNG2jU0Ml6IT4r+EOFkEu7Y2s
	BCbucW1LHwvEqqO6yMlkv5yuv7CKWIeB2Wt6irYRLA0gqVSYpCILBTaxcTz9dSJig0fuCudY41q
	FM02oLZXSuw+xNyAB6o5u9RS7hgp5Kl4GpmBy/S5w070y2CRqP21Rw+44njc4aqu4mjFJkXVfs6
	AM/ax291pF/T2nm2dBY/bAT6N7DzJvcz2yTv5XU4aamSNWMokL53kIn6OdGW9VqA92pM6JJqgfc
	Ru0JoXE/pZKLi7ppKAbjQucFuvTOVIbYeeGfVNt6C7Qo8MggmKzi/jyzDhdq40RC2fR5ls4qeoo
	wddkSBh+qjVnWOj0rGE1ZEzQ98Sj/9g8V
X-Google-Smtp-Source: AGHT+IHbaUWN3oGzht6uST0yjv6d2XtqP8SkqgbaYOQ/UYleZIrCKpQgnU7vJnYzUrRBpDEI6qYvsg==
X-Received: by 2002:a05:6000:4021:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3b77137beefmr801829f8f.26.1753345842862;
        Thu, 24 Jul 2025 01:30:42 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870532b38sm11641265e9.6.2025.07.24.01.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:30:42 -0700 (PDT)
Message-ID: <17e87341-745b-4f5e-af9c-4c9abe9a2e72@linaro.org>
Date: Thu, 24 Jul 2025 10:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] adc: meson-saradc: uint cannot be less than zero
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
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
In-Reply-To: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 24 Jul 2025 08:30:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2730

On 22/07/2025 16:06, Andrew Goodbody wrote:
> timeout is declared as a uint but then tested for being less than zero
> which must always fail. Change the while loop for a pre-decrement on
> timeout and test timeout for being zero.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/adc/meson-saradc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
> index 60e348968fb..0144ff828c5 100644
> --- a/drivers/adc/meson-saradc.c
> +++ b/drivers/adc/meson-saradc.c
> @@ -205,9 +205,9 @@ static int meson_saradc_lock(struct meson_saradc_priv *priv)
>   	do {
>   		udelay(1);
>   		regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
> -	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
> +	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && --timeout);
>   
> -	if (timeout < 0) {
> +	if (!timeout) {
>   		printf("Timeout while waiting for BL30 unlock\n");
>   		return -ETIMEDOUT;
>   	}
> @@ -256,9 +256,9 @@ static int meson_saradc_wait_busy_clear(struct meson_saradc_priv *priv)
>   	do {
>   		udelay(1);
>   		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
> -	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
> +	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && --timeout);
>   
> -	if (timeout < 0)
> +	if (!timeout)
>   		return -ETIMEDOUT;
>   
>   	return 0;
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250722-meson_saradc-4bba9dc18333
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

