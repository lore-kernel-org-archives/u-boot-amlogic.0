Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED101CA1016
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 08:27:42 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.7888.1757320061075581531
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Sep 2025 01:27:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=nb55BmIQ;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso16710965e9.2
        for <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757320059; x=1757924859; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSgbfDczpUZliVEKI4UxTLO05IQHi+fn5BpPacoFubs=;
        b=nb55BmIQYCyjyP7MszNt9BW/Q/5inxw6SuR7fFs+UG99onkRCJf52YuDwZ2rptRIAn
         5FFSKGp3K2wKedwLps7x/X47OEckxlmcqnw3Xtn1bZM5G6owIY4sYYoSAoAHXG3qpLJf
         GtWQbJaPl8r45EP4+XrstyTDyhWQUJEf2O7IRMhP3YX4ixB4ifotoc1ktU4iKOgdzOaG
         4DOhsBh+oPeuHGWrRFHK460l5mP5TI9CiDOiJ8vUzUpsomlG6iIFPEOS13qlzeqmGYqF
         1XG5y6hDdLOJj24sBS4379eOPuHs1eQK5AJpe/0SaNnDogNJzux89wwNHghSlaw/3ZVv
         gthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320059; x=1757924859;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tSgbfDczpUZliVEKI4UxTLO05IQHi+fn5BpPacoFubs=;
        b=h/hIzqrhgmkN4b/yaM/fcsOk38t9CEeQ5RveVBAhM4wRkTaMTLY/zD71prwYB1xDXQ
         gXU/S0uGmqRdjjfY8vy/gYEqRtNGnhuWfaN2EJOJBCY0D/DeSxh+uksMIs5vIqA5ZP3G
         wDuVtuWyAI9eES+Q/ykI1yQaTKeiMwL/4NtmXQfVBBrOJ8XfxpTStKBhSd37v7zrJV1c
         yvIVyajKWxrkgwfr5B0gPa2PLEDGrmVGX8yveE9HgWsecaSW9GSzAKC2DQD191JYzBqV
         2pAZddomBCwqjF/AEE6ifQ9LCwLW5VpPvdIwnGYBJYTEPGk0mdheFvGwNRA1vDjstNNL
         Im5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRT3xRLiK0wWgS9+hcFjenhfmzAgxVIUtmzGbJ6VsLbtSJZi6r40Z3mEAsDc1Rq9AFgSaD7YpbG0MRd4EHEg==@groups.io
X-Gm-Message-State: AOJu0YzlPwEr8bGgyDHDlDxAhvoFjv8yJ9f1m46THZu2DNMVxKI+ZYR3
	JZVHSx1hNqae/IqJi0FslL0i47kEA3yyr9d4YouT5hOicxHiCEHDlcJ6na/Hyj20PEM=
X-Gm-Gg: ASbGncuc8lCT8dRC8wGNzsgyD2NT13UuMyRpn7ARPwh9g44iWlphrxfXDilZWz1usKz
	HiCxlRosU8Fe/8WFmz11hkAnvge6zrSfm6rrM49Tb0VfyIiIfwUB6mq2s6kvGwy+RQGv47aJhRT
	Roy+RSGgjqEn2eHfuJA53SJRfpQOQSBJGT2cZJSoUSj5xBXGPFu9yM9ohSGeXvPKaTKujFvaxxk
	WzMC5k0Ux6rpQhFc3bL9X5lrRpJ7l5p1n29cicETnBqhpebCucSPmgI6ZeelqWGS0zZzqEYejNR
	bnF6/bxx1F+EDjIVkivpd7Z2IxPiAJz2dzh2w7oZP9xzffoQNyk0WXOX2oRRWpGBWlcQLR4oZ5+
	MrHsC/wnaONTgUrw8dWFVwqHNhVOYkT2+f0mG8zBnTRDFYQKoAAZFDdtJYJm1Wh+0WLvfk+MCf3
	QsHdbgfGGhUw==
X-Google-Smtp-Source: AGHT+IE2hnLZJFivOD+VB+wS+KOE6Fc7znNaQiXaeN6vTMwzAJG1Dom96Hs/i0IhZD1lcf+JT2bDvg==
X-Received: by 2002:a05:600c:5247:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-45de2028b99mr50125275e9.8.1757320059307;
        Mon, 08 Sep 2025 01:27:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm129519405e9.7.2025.09.08.01.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:27:39 -0700 (PDT)
Message-ID: <6643e388-2d96-4cbf-871b-e8838af73f6f@linaro.org>
Date: Mon, 8 Sep 2025 10:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 6/9] arm: meson: spl: add support for SPL DRAM init
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-6-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-6-37395d9ff5af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 08:27:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2758

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> Supports both GXBB and GXL SoCs.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/include/asm/arch-meson/dram-gx.h          | 341 +++++++++++++++++
>   arch/arm/include/asm/arch-meson/dram-gxbb.h        | 168 +++++++++
>   arch/arm/include/asm/arch-meson/dram-gxl.h         | 193 ++++++++++
>   arch/arm/include/asm/arch-meson/dram-settings-gx.h | 296 +++++++++++++++
>   arch/arm/include/asm/arch-meson/dram-timings-gx.h  | 117 ++++++
>   arch/arm/mach-meson/Kconfig                        |  70 ++++
>   arch/arm/mach-meson/Makefile                       |   3 +
>   arch/arm/mach-meson/dram-gx.c                      | 419 +++++++++++++++++++++
>   arch/arm/mach-meson/dram-gxbb.c                    | 174 +++++++++
>   arch/arm/mach-meson/dram-gxl.c                     | 167 ++++++++
>   10 files changed, 1948 insertions(+)
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I guess we can't do better for now, Amlogic BL2 has more logic to detect the memory banks but those could be added later on.

Neil

