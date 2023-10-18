Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04081CDB47E
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 07:44:15 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.276853.1697615049123175197
 for <u-boot-amlogic@groups.io>;
 Wed, 18 Oct 2023 00:44:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=V370DGid;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso11532315e9.2
        for <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697615047; x=1698219847; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNOvWPRV6pmbjAX1pkDJTzjN7uuSereKfEEJLGMZ94Y=;
        b=V370DGidKiAq7fH6mq60L1mxr5rRN6z4D0fwTITeUGIEihb5vV7O34NIXkitCJSfBb
         vfOLleW/XMiFN2l97Sn1um1GY0B0L1spI6TvxjE3bE7Hd0mX490s+GETftji8mazqT2l
         7YLurTJgmJ6Sr6emgIguBIaKdxw95XeWCkhXqlzrlFDBozhLDrBaapQ+ZkxSwzYud6A2
         olk3Z24+lZ350BNWiGSusteI+n3xo7p0psBWC1AiTWTFTiSceWAvSz5jU9Dkc0eBeIph
         ccinCpocgJ6RHymYrC5TEBF/kUEp3dOEewMf/aSDw2nhQl3NI1/i0F66nFc+cMukVD/N
         MydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615047; x=1698219847;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LNOvWPRV6pmbjAX1pkDJTzjN7uuSereKfEEJLGMZ94Y=;
        b=N7rmZiawRJc24hec+9fej8+AWFA6Q9UaZTP4d02HKUm3ur8maEN/eJESuZtZcjdrD+
         kn4AqKnt634VFzAooXUW2Nvba+NDcVHBvGY9rNYPJZJDjsu47C7Bg4vi8Ylfv/lGSuou
         utKZ09SBsk9Rm9F7gwl4rTzc6VVHWOHGhYbHVGhbEohFTuDXoPbAT+hdH/K/WaBYme5a
         gzSUrzoCqj86tSE+a+7JRKXWCPz2dyyY3gXZO6CynODMj3EeeJr9u9A6z6KC72UAdmAK
         Ocb43UigDgfq7sGz0uGyrNTFrepolqRPpYCmmrKLPvf99/9ramapiuakBMloE6b5X120
         6UeA==
X-Gm-Message-State: AOJu0YzgnTlwdDW/zPLpiRBMR/O2OCMHybTvgHKE1vGIjhNVEkstX9mT
	XvflYOOM7sPpEVQP7mmWi1CuKA==
X-Google-Smtp-Source: AGHT+IHzR471B1spJojJ/fG/dkn2/Ni1qTZ1cBlcX4SSodBhd3k+tiblkLMFjGBXeI7M+ve30xt9/Q==
X-Received: by 2002:adf:f447:0:b0:32d:a910:6c2a with SMTP id f7-20020adff447000000b0032da9106c2amr3261846wrp.30.1697615047559;
        Wed, 18 Oct 2023 00:44:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d8f:701:423:3d05? ([2a01:e0a:982:cbb0:5d8f:701:423:3d05])
        by smtp.gmail.com with ESMTPSA id f4-20020a056000128400b0031c5e9c2ed7sm1457010wrx.92.2023.10.18.00.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 00:44:07 -0700 (PDT)
Message-ID: <448dca4f-324e-492b-8fc9-c35059eb5042@linaro.org>
Date: Wed, 18 Oct 2023 09:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] phy: meson-g12a-usb2: fix ret check on power_domain_get
Content-Language: en-US, fr
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 avromanov@salutedevices.com
References: <20231017185725.809524-1-glaroque@baylibre.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231017185725.809524-1-glaroque@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 07:44:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1782

On 17/10/2023 20:57, Guillaume La Roque wrote:
> Patch which add A1 SoC support create a regression on khadas vim3/vim3l
> boards when we try to use fastboot command:
> 
>    => fastboot usb 0
>    failed to get power domain
>    failed to get power domain
>    No USB device found
>    USB init failed: -19
> 
> Add ENOENT check on ret in probe function.
> 
> Fixes: 5533c883ce10 ("phy: support Amlogic A1 family")
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>   drivers/phy/meson-g12a-usb2.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 4ba3992bda70..3958d2404b85 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -328,12 +328,12 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   
>   #if CONFIG_IS_ENABLED(POWER_DOMAIN)
>   	ret = power_domain_get(dev, &priv->pwrdm);
> -	if (ret < 0 && ret != -ENODEV) {
> -		pr_err("failed to get power domain\n");
> +	if (ret < 0 && ret != -ENODEV && ret != -ENOENT) {
> +		pr_err("failed to get power domain : %d\n", ret);
>   		return ret;
>   	}
>   
> -	if (ret != -ENODEV) {
> +	if (ret != -ENODEV && ret != -ENOENT) {
>   		ret = power_domain_on(&priv->pwrdm);
>   		if (ret < 0) {
>   			pr_err("failed to enable power domain\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

