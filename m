Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F365AC4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 13:36:37 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web10.31263.1698932195114238197
 for <u-boot-amlogic@groups.io>;
 Thu, 02 Nov 2023 06:36:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Ahbhexa8;
 spf=pass (domain: linaro.org, ip: 209.85.167.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-507c5249d55so1142558e87.3
        for <u-boot-amlogic@groups.io>; Thu, 02 Nov 2023 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932193; x=1699536993; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7I/2CWZ3akEX1BMyg2Naxgpst6GvEWhgqlYh7GaknSU=;
        b=Ahbhexa8H4kGsBor1rN+F0uCY7E0YHp+Km0MrFX1fVvbnZwM1k3E5ZtwBCK/qK3U6e
         rZ4MsJ+Qby3RlN/b7KJ9KzSlwcJOQL9Ih6yWvcRiTsugQVjhTW87+LX7rrUFEPfwhn+u
         WgZ+vye53HXi1Ao0vlpqe/q5FWQxQwv6b3Ei5EKapRGN2fLor3uXpp47JMjqtzA/9dHQ
         UiKz8l6TCLrT9PjMXmAeCHquxXW7ADgvRCJy95uYXEIl8JpShpNIiY3TEiQJzi0wnLwy
         ifHdIaKs+d3uKyXK51/bCgukt1tm5y3hT2w+jwiw1bWZhDkdE57yPqmkmWwFEoGoP1pO
         lX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932193; x=1699536993;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7I/2CWZ3akEX1BMyg2Naxgpst6GvEWhgqlYh7GaknSU=;
        b=m5Ljg89kKUk/EcWF78mcLHbsQ1mfvAo9Fr8lu//SlyA/yDUPqJI6GOpDdzZTVs0UQr
         RpDkiE9P4qyEZXMLr6AHV5h+V1OM40p8UYPjuc+lrPuS58HtZo/yq65dqaFU4AZB/+S1
         1sM5extu2PXYvaTG52lQgl0U2UlJLb1SJggTftOMQZ4pxYqkrGHsTL0yWeYZ1odlga/J
         jWHfBfxeJ58JbsAM7j+dW1gornG5b+gppkIuZgU+DvIP6efZ3maeEftjTuGcDj5Z6ydY
         PTAW2PJNCTmVOwSOrtjvVPEdNv8fWB8BycP+sqN9rdMFzcq8vC+X/cJkSD+6cYcXCgca
         Sqjg==
X-Gm-Message-State: AOJu0YzhNrL9dR4Kpoz8T+AMY3S4Gp2tq7rh9W/Q0MUUjJC/l9FvDPHG
	XnFBOW7lPjDJnqjloT7gS1pwowTVAeW+/dbeAQkKUQ==
X-Google-Smtp-Source: AGHT+IE+W4jm3q0J88C1Zx2eUpzoepR8nN0U07m8TI60dIUqlNfDyEBaTLfipZYrr+7jxTZnes6Prw==
X-Received: by 2002:a05:6512:3481:b0:507:9618:dc1f with SMTP id v1-20020a056512348100b005079618dc1fmr13011405lfr.69.1698932193239;
        Thu, 02 Nov 2023 06:36:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4ac1:f109:811c:51be? ([2a01:e0a:982:cbb0:4ac1:f109:811c:51be])
        by smtp.gmail.com with ESMTPSA id g9-20020adff409000000b0032dbf26e7aesm2508168wro.65.2023.11.02.06.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:36:32 -0700 (PDT)
Message-ID: <764768fd-c67d-4681-ac4b-e9d0a8bc4fba@linaro.org>
Date: Thu, 2 Nov 2023 14:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/2] drivers: sm: bind child sm devices in the device
 tree
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
References: <20231101140500.9025-1-avromanov@salutedevices.com>
 <20231101140500.9025-3-avromanov@salutedevices.com>
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
In-Reply-To: <20231101140500.9025-3-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 02 Nov 2023 13:36:37 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1818

On 01/11/2023 15:04, Alexey Romanov wrote:
> From: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> One well-known sm child device that provides secure power control is the
> Secure Power Controller. This device utilizes SMC calls to communicate
> with power domains on the secure monitor side.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/sm/meson-sm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/sm/meson-sm.c b/drivers/sm/meson-sm.c
> index faef369f35..1dd1584855 100644
> --- a/drivers/sm/meson-sm.c
> +++ b/drivers/sm/meson-sm.c
> @@ -194,6 +194,7 @@ U_BOOT_DRIVER(meson_sm) = {
>   	.id = UCLASS_SM,
>   	.of_match = meson_sm_ids,
>   	.probe = meson_sm_probe,
> +	.bind = dm_scan_fdt_dev,
>   	.priv_auto = sizeof(struct meson_sm_priv),
>   	.ops = &sm_ops,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

