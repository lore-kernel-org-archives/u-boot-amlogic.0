Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74524D10F44
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 13:09:56 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12329.1764162593177141543
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Nov 2025 05:09:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=IniER322;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso2668893f8f.0
        for <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 05:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764162591; x=1764767391; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+TSOKUbs/ywh/8+S3+0H8wLddAtAOyOvWfNgwrKgIk=;
        b=IniER322qd3r8w/4gc3LnQJIfI+AlPZ0AtOHSB7qpULl2wY2Dg+oIH6oN1WoGrX7uw
         lB308ar1Q0i1xwYdLdgQXSn24KpqU4YHoJ+XUSsfwWfk4Blgd8DzKSmtMZxs8RbLDMRV
         ZBPq0vw9DvA7OzOg4XLVs0D8+f1T5rto4fXHvzgK/R15UJi4bAcVhnNg2jg+qSwojvwc
         eoEVsZF4sncJw9Y7X1HRDMsMMEFbrMesNqpqK3JCB+/n6c2Xkvj2sHbqvLj8QEx50OoN
         tZIxqn/+Iwytn1PcCJLDxY+K8yHnTO4zv9Xq64Kw0S3tAu0PfGz24gdcDg2NaGEjZV54
         /R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162591; x=1764767391;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+TSOKUbs/ywh/8+S3+0H8wLddAtAOyOvWfNgwrKgIk=;
        b=mRwBAaRun1eHztAjWYdmtPCP892jCdo0OXt901zV+B7+J4XPDsldPP6tBndricSaW2
         M5ajxuX2nOSeDmHWv9eQ0pXM8tcyA/Q4iNlNFSr+prZnKs0DeraohztqOYtekVpvV0OJ
         sC4kgYwcRlMHrTBJhqBUseChFm/kbuYnL3fAB4SZ2Jb2SKVPte0xkzthi5JhE5HqZoDv
         kodbE+0EudmG7LYkDRLBr8K/oIS4nf49Y2A9O3fAWD80TUo7yTLLJgplOdv6TwP9Nipn
         fCpPZx0VlgRcwtGl6hcx3cKGl8Pwh4ud29qlAMsb/IufxddVMGQlJjzmXION4EApUoqP
         dTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXretXEhWXbDmkk8AKsN5H+xnG9n8TqkJy5sver1RYPW7gOFOQlVo2c2+AoIvjOGQjFBZU0SthZ8muGYgW11g==@groups.io
X-Gm-Message-State: AOJu0Yxu/Jxg10SNvxPRc40kIKWnHo4VhtjKE1lNwzuT/hcGGcj4emn1
	ZKs6VzDfSdsy5x5jjtCcrFxUbPTN3GO+chfelr754d/dloUfR9CO/2jAsfXfCRkxRRA=
X-Gm-Gg: ASbGncuOq5O56Oi8XdO5WrhkW1x0Y1+flPCP59vgfHeTHkVcjaLfXqtkgmeTqzFeARQ
	+uR7Z1sWbzhUijdFl9cqy43GwXjks0tpwJfR5K8RgsC/9DgxiGqtqIM2fRGzLZYXpfnULDFeEj4
	ZXmQYU3sMjo28S+vQxSLyFMbLWwneoXvpKBv1q9CNcBGjJ7crR1pnB+6EdMvhnhyizt7b2D3+QL
	9je/3PQM9jd2hWEETIVKFxzKqmJiC0GHKzdkidfDriwxUBb2LuzSCqifR9H6twwhcPInMYboKKe
	IGQGym5VabnI1P7HU+8J+Hk5rDPOybNzDJnZmBCyWvtt2GW2TWWAQNl6WcX93H++bAWpxzqO5X+
	KQdLVxJqtXVGsNRtLSXzlH0qrrW+8xe8Wjwd7m2jywWOFCw0R1kIdCJA704irCo1xo8u+0hCfyT
	Ar2zhLYdkay6FoOFUhzvwx2Yo9K9qFLnAg6qzv0gcFzGg1uLQO4xIg2I2aAbNA
X-Google-Smtp-Source: AGHT+IGLQUgxyvQbu50j9qMZ5iXTGmPY4K3J6uINh0s7pvdNUrUyw5C/1i0O+uJUFPJjz0YI6695bw==
X-Received: by 2002:a05:6000:2c0b:b0:42b:2fc8:186 with SMTP id ffacd0b85a97d-42cc1d19a48mr20218255f8f.46.1764162591242;
        Wed, 26 Nov 2025 05:09:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:91ba:3a5e:334:4534? ([2a01:e0a:3d9:2080:91ba:3a5e:334:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f49a7bsm40235656f8f.19.2025.11.26.05.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 05:09:49 -0800 (PST)
Message-ID: <d88ea750-fb4f-447e-8e2c-48706176b482@linaro.org>
Date: Wed, 26 Nov 2025 14:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 06/10] arm: dts: meson: add meson-gxbb-u-boot.dtsi
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
 <20251126-spl-gx-v5-6-6cbffb2451ca@postmarketos.org>
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
In-Reply-To: <20251126-spl-gx-v5-6-6cbffb2451ca@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 13:09:56 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2862

On 11/26/25 13:17, Ferass El Hafidi wrote:
> Add a common GXBB DTSI, similar to the meson-gxl-u-boot.dtsi file,
> which GXBB devicetrees can include.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi     | 2 +-
>   arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi   | 2 +-
>   arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi    | 2 +-
>   arch/arm/dts/meson-gxbb-p200-u-boot.dtsi        | 2 +-
>   arch/arm/dts/meson-gxbb-p201-u-boot.dtsi        | 2 +-
>   arch/arm/dts/meson-gxbb-u-boot.dtsi             | 7 +++++++
>   arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi   | 2 +-
>   arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi | 2 +-
>   8 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi b/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
> index 191c5192c68..4a027b9022b 100644
> --- a/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
> index 2a245bbe7f2..53d5c0113fc 100644
> --- a/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> diff --git a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> index 5a2be8171e1..1bd000eaa86 100644
> --- a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   / {
>   	smbios {
> diff --git a/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
> index c35158d7e9e..1bef64dc01d 100644
> --- a/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
> @@ -4,4 +4,4 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
> index c35158d7e9e..1bef64dc01d 100644
> --- a/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
> @@ -4,4 +4,4 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxbb-u-boot.dtsi b/arch/arm/dts/meson-gxbb-u-boot.dtsi
> new file mode 100644
> index 00000000000..c35158d7e9e
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxbb-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
> index 3743053eb9c..cd2e9b5099e 100644
> --- a/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> diff --git a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> index 3743053eb9c..cd2e9b5099e 100644
> --- a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxbb-u-boot.dtsi"
>   
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

