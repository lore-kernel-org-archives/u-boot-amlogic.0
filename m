Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA9C88E40
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 14:06:25 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15079.1789049183999329199
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2026 07:06:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=yQ532e0h;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso86636115e9.0
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789049182; x=1789653982; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGoMU+1qnIVIB1yfUUqQNP6GRKbZsieKJk/qc5M7A+A=;
        b=yQ532e0h2gJB+LLy6AX76qvXiPWTy61AVF+6WMblunuWvoALDNEE7xkAhCLfrrZTak
         EOvrtS7rtZ1iJ5RGjZSu6P3w0//g8ljLHzZfpqD+bYdH/WBX9Vgv5TtSutDd1W+779tX
         Vdw2+x+IsPrjRGhVCuphPXyiNDfqS7K9VpyeYwqlgQot8WkCC/DdLXK6TZQiCd3Zq+Gz
         5Jg+1+KGtcJjTY25g/sDy6FwHyOQbtr5v1yIGFdW1S2TnA23rdLRA5ie8oy7PWNVOeXK
         BFpdK1DFyUqaTgT0RcQv3bcInKj0cqj8RCASKo8lg37LZEUJMxLVjpb0hVwVMHTPOlLn
         9F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049182; x=1789653982;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGoMU+1qnIVIB1yfUUqQNP6GRKbZsieKJk/qc5M7A+A=;
        b=DhBHdZOivBHQiA53dEJ39bf9XBOaGdQd2es/buv0LjcoVYCqiWrOIVZp2AVQrdxQRi
         9AwXA/rpIS0lq7UmPFgjHm4y/hxFXhLORnmZv+jXi3qRnrwV2dIkU7PYE4EEpQabHDLO
         d/5tCElXrAEtsHcsW6aKv62mEPL6gMtoNfapeE8f27wrcINr7ql2K8nMI5K672p+KB/Z
         GNHqFRTnU0x1Eh/3ZO9xeZTGDudHwP41cVnNoq+q0GdaDRZB2f5PEqZCBXv1nWWdODnj
         gf5c4UscDXc1hjelZP/H7rKT96egQo68ESyThIRVwX6T6rNkuwF/QUJlUSEyZeOgkFYk
         VN+g==
X-Forwarded-Encrypted: i=1; AKwUvBwEYqcBOV0SBDtlNRHl0voVb0AiTro5dfrhMLDfvviP6a5yM7efrftBlZtCZuDKPgOdC9fhIl380+vtbmJROA==@groups.io
X-Gm-Message-State: AFuF++lEyzp/tHEtKn5/z3/QmrF3D6ubp8ewY59rTApDBRxRdGCbu8aU
	llHyR2cfettG57Q4UhMkW37THfrznSc0FSaBT8Dd2WNziqxewGqKLHreoCmYyBzi81w=
X-Gm-Gg: AYBFou1nvkirczD0g2QEBEQzRUMiUpTyB1mXsAP3dNmD2gOGy8sjXK+9pBypd+qFiHB
	OVc41Hgce4Kn5OLGse9TJklQglKN9uehoCneoSrnkyvYsuhQgCJQVn8E6DD1tuE3QewtF8yxNWL
	qIP941ctR5+qEDNQwA+tPKZxoKQ8ODQfatSG03mTaNTpinb7AINea3c8V4YcqgGurABOgNACm6d
	lfoEIIN6jCtSq2Nznp1nquzpTMQJr0tB5Ekp/CNGj/oPpYxP9pDH7TtaNQCAQZLqawonqQIzudX
	PzSexBhIDb67zIHH0aGqyDe9scNjmZFbgP2hLkHPgRYHMBZcdKU+Uf7n86y2GO/FKueNUYjcP/3
	LMd2yhY2cOX5BKnym/AhWvkL67sRk4izLRUzkzZ8YQm7jhkXLphcZhbbqvlCO4hhBS/SUSP1KE2
	yZ8mKFF7Kn2LOsRqWZGSqC5bdNidPrq5EaIy7SabqPwxvbTAwjjDznoFGBNK1Tt7phRcVr2Dnxb
	xt6JizpvyreEwfTCo7ZkBO6/dl4mIriDvVH99GUlcLHl3+vonzHVQ==
X-Received: by 2002:a05:600d:849b:20b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-49cf825d8c0mr305721045e9.9.1789049182127;
        Thu, 10 Sep 2026 07:06:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2? ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c39086sm68083635e9.10.2026.09.10.07.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 07:06:21 -0700 (PDT)
Message-ID: <56c6372a-667f-481d-b36b-970fc89d600c@linaro.org>
Date: Thu, 10 Sep 2026 16:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/3] configs: sei510/sei610: drop Android support
To: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
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
In-Reply-To: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 14:06:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3092

On 9/10/26 16:04, Guillaume La Roque wrote:
> Remove Android support from SEI510 and SEI610 while retaining generic
> board support. Both boards switch to meson64.h, leaving the shared
> meson64_android.h header unused, so remove it too.
> 
> Fastboot remains enabled, but "oem format" is removed along with the
> Android partition layout.
> 
> Build-tested sei510, sei610 and the four Khadas VIM3/VIM3L Android
> defconfigs. Both SEI defconfigs are unchanged by savedefconfig.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Guillaume La Roque (3):
>        configs: sei510: drop Android support
>        configs: sei610: drop Android support
>        configs: remove unused meson64_android.h
> 
>   MAINTAINERS                       |   1 -
>   board/amlogic/sei510/MAINTAINERS  |   1 -
>   board/amlogic/sei610/MAINTAINERS  |   1 -
>   configs/sei510_defconfig          |  10 --
>   configs/sei610_defconfig          |  10 --
>   include/configs/meson64_android.h | 279 --------------------------------------
>   include/configs/sei510.h          |  30 ----
>   include/configs/sei610.h          |  30 ----
>   8 files changed, 362 deletions(-)
> ---
> base-commit: d4152edb50356338af994d1c0483f65b717b4c15
> change-id: 20260909-remove_sei_android-44993a3f3353
> 
> Best regards,
> --
> Guillaume La Roque <glaroque@baylibre.com>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

