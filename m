Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED3C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:58:25 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16081.1787576304106981954
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 05:58:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QON8U/Jk;
 spf=pass (domain: linaro.org, ip: 209.85.221.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-482c58a8683so1305940f8f.0
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787576302; x=1788181102; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tvYqAVJPkgLOZpglJZNbXWxMsUxPbAjEsvQW0SCKmKI=;
        b=QON8U/JkyxNgnqVAp1/GJSw67Xu6iySMMlvcmPg9Td2+P0Uivh+k8zWAMzqa4b+Pup
         qOmENgqsl2Fc3vEayimk2znrPQ9oJbD39DWMwm8y+GJHgOx8zolOoCKlMn/fTWrpSQkL
         fdka+EptGK03RcgIW5aA3XMk/FqRO8RZyVFvIASLIz1snHtyTM+QL0oajaGAviXhdR/Y
         IIoM7YB0aNW6C7ZUl61zKJ6UosEawcKSUwksBooqzuMIENF3zbSjHHR8LzPZ/qIMP/X9
         coNy1e4IU77GAIC3fgNVH5TGKaTzXR1YRQzUIV/HzSVOvGeg2i9ZjdYrx7wuzIiF9vtB
         2Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576302; x=1788181102;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tvYqAVJPkgLOZpglJZNbXWxMsUxPbAjEsvQW0SCKmKI=;
        b=Nj2PYQhfctdQ8Pd99vyjlIYkvvYj4dkQ01YnWLF65x4WY8tcbhyzDIza7P6WeVTxyS
         +SLPVBB5JJI6ZgELYhexH0D3cTxoZoUUgSXv+V990LRMREMSXfUeXzIeTLT9I4s7rJRu
         8IpjaUXyLd1XS/owr34ouiIQeoFlaEvAQyAQTuyYqc1n6NIZidXe34opUJxJ2vf6eJuO
         Np9UlWJunLRGc9xcsj9f7eYV+QGUM/wFF2Yu/QfDA8ZrqkcPsTluZXnabeGdr/c7YL1m
         yws19tV+g0rN1reEQbgeRgontRBnhqmK3bgYxwK0C+UCkeFJdhwbWMnOoCkFLXhkQG/K
         Tr4Q==
X-Gm-Message-State: AFuF++lTTCG8It+gj4KxpjF9NULP7jvn2VNT545fJXQYp7tYWPkePc64
	0+RKSzwuXzB5ZZVEiW4tqXyvIc2nQwPIXynwKmzzonQ24kPGjPVUlsw2cxihU87dOKFQfiRgi8W
	UykLX
X-Gm-Gg: AR+sD13qJdBYNbekyfZlNpeT/nvET0KXjoFmxbdEvjevG/s+qr1xu+D5hgL5HhiSbwm
	Znlw1DG0uw6HUR+i0jHemOcf2XNTNQYl8UvGWeNU5ujeHt2lH/LbQAVkDpBTzJa/UuhZyWEIjIW
	IScqMIoNvYHJm7purQzfsapI1rBAxnwUgEif9ldbxG/+U1Ri5O5IqcQYB4iuSytE1YViI/6V0M+
	xuM9IUO6ak5AatbX5cGJsnTCxGOIVp1G/WBmxSOoeXo+jYvFRRSWg3F5XUJVgiEulG2Pv1wIE7C
	+t6eSLSgnY8XShS94309lplrrC0BTYCy0sLQDSEIckh6KrG274DiYhcW/JYrR7c8GtMN2LIIXfw
	d3SjXYEyhx54gWsDjtpp8EptLa5IIk4dVB5FIsP/UBgEn+GsOxoaM3QGmVatevxGgfQpqX9pUCC
	B2CkwgbobfuszQ5tlG24Zdu6LATikCvFay8cV4b6UNEdaPD0Y4yqoyCEcF6FDqikGexUwsfxWG7
	5bONjBZtpCBHCIVBSkQGdK8tXVmbU9cdeCFYkMmReqXVid5u0a7
X-Received: by 2002:a05:600c:e549:20b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-499b8343decmr236567735e9.10.1787576302199;
        Mon, 24 Aug 2026 05:58:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273? ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b914baeesm124361275e9.10.2026.08.24.05.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 05:58:21 -0700 (PDT)
Message-ID: <ef009f96-675a-497e-ad49-be43f4871282@linaro.org>
Date: Mon, 24 Aug 2026 14:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] mmc: meson: Parse devicetree properties
To: u-boot-amlogic@groups.io, sanderson@brivo.com,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260817163652.1893650-1-sanderson@brivo.com>
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
In-Reply-To: <20260817163652.1893650-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:58:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3055

On 8/24/26 14:53, Sean Anderson via groups.io wrote:
> Parse devicetree properties so things like max-frequency are respected.
> 
> Upstream-Status: Pending

Please drop this tag

> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/mmc/meson_gx_mmc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 76af3873e15..b5b4e60d8ec 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -351,6 +351,9 @@ static int meson_mmc_probe(struct udevice *dev)
>   	cfg->f_max = 40000000; /* 40 MHz */
>   	cfg->b_max = 511; /* max 512 - 1 blocks */
>   	cfg->name = dev->name;
> +	ret = mmc_of_parse(dev, cfg);
> +	if (ret)
> +		return ret;
>   
>   	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
>   		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: meson_mmc_dt
> 

Otherwise:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

