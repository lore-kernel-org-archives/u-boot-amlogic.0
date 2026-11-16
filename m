Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24288.1794824123992396396
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Nov 2026 02:15:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=t3EC4gMs;
 spf=pass (domain: linaro.org, ip: 209.85.128.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so15361595e9.1
        for <u-boot-amlogic@groups.io>; Mon, 16 Nov 2026 02:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794824122; x=1795428922; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KgdO6rAA9pcyAC0yng+bvoVOz731ea0ObolFrK+YFH4=;
        b=t3EC4gMsdKYVrCOpAZ+0rafwCISsTgAWyd8vqxafqfkLp7iMSQV27ij/Gg6GCsGWik
         6iLkLa3mGW0UdA2CY4lNV9zJwM8KYN+cJudoPOTRAiWkGG1RrkHEd/Q1xAY6DxpEgWn8
         07YJKDP9Xba6b4C+pYtuHW2syo+fFih3oHnBTkfdgD6YXWKZJ/AiAMx/9FX5uDwtidD9
         5a4iirqnJPAiwyuuio7omMn6ew8bcFwJPz/lNf+v4fonzKLdqsq258RLauSEXn5OywhF
         PcDi2isTYBW/hVFEgzzdk/38om4+pzxZehhedMkqyVqackE9uYQ4FZu6t8oZO+IQ85oq
         mY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824122; x=1795428922;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KgdO6rAA9pcyAC0yng+bvoVOz731ea0ObolFrK+YFH4=;
        b=1/vwH4yV5FlbhLF0UddYkLujI28C2GcMasSwzoulRw45uBr0GU5nJx4sp6XnA2NC4i
         z3I9sfit3kNur+l4Z2gm8uBo0Iqu1YLBH0vq5b6VjCI0rcQxD3f4I0qKrT31A8/+5tUN
         8waXrLcM05g0ULa0oHLF8WfB3JbqdxJ22JuWegSXKdi8KMFul5LAmYLewvaRzXSAuTfZ
         lMXCwPuHWS1F9vhih+oScDpTHrTrn3qEMSAAG7q14ojqMGNrSRvNVxn7Z7PDbs98csd1
         afrb+hxO6yb6xtX+uy8b6axxLpDG+o+W9OSo84AJl1qiKd9OP3a25ugZvKUVMcYuqKiL
         8l5Q==
X-Forwarded-Encrypted: i=1; AL+hErFOOvkO39eH2w8jm124HjUx7n6SHk/T7Z8VXc8gtfiOOwiF2bXkDF2VaVzkXOWoxa/qRYg4Nz3OwyVgyLU6tg==@groups.io
X-Gm-Message-State: APuU4Z8PO0PgxxyPU+bWeWJib4wqYXnCpDnjLpVcsZtE8MzqT7pN1w0A
	CsLcGIgLKJmu1nY4LLDrWF2NKE46e6sOUfRYX2h7oFQYjtWOKb91y92yP9DthOMsywZJ77QGWzt
	ePPjM5so=
X-Gm-Gg: AYBFou0RkfmyCT0lXxUT4H4qQepINghg9C/KtuFKfVdlyr1Zba6a4yS9Ag5zL11M3kv
	tNMqPcihYZcgGoLuB7x7gPfjUN3zBDu8fA1sAOZN+uKrJzeWKJXpic6EwvFMpXfkzWBIwMdm1hl
	RaD7Qoy3ejZviMxUWUgDvQV+3iK7jLAIQmhnWXrzXcKI93Zg61ZOCDFcgZ9HeTHow5OVvB6/Axg
	VY/SYtz59m4B5rbwbAVF1JfkX8hvpVt82Pa1MYnT110lmavunRPmw6ambek+LTl1RmTxnmhqfYW
	ML5aVQhR5lfxIYI6Imwaa8Cu5a1H2v2i1jfAsRwRzP5OtmuqDYIaZa5uHa7Z+AaKy8nROYMUVmo
	Mfqlxx2lcG8hs8xce/3Q7RgjwkbH945NuK+2YBGbVnhNLArv3CxTHfzlWSi1V9ebITaPYSwmUU5
	WE+u4FkAtH1kQdNOdSMwPVMjQ5vxxZiZbjSBWEtoR2w6vp9dMY+fsL3xyi+L/IXrT/yOuwr5SlB
	nzmg4umo1ZK6DZQrPRq025QHTU7FCZRwhyRB3emZlgpVd70Zv/HzaIbuAMIJywaFZf/QgLbKHw+
	yl9TF9ICKPjpqtbG9Q6xW4hD+h/rVy6ibkd+aMIuPmYnJvZ4SWW+0lWv9BP+ap4ElhsQZnHD+e2
	EIoF2ncAH
X-Received: by 2002:a05:600c:8b81:b0:4bb:5f45:c97f with SMTP id 5b1f17b1804b1-4bb5f4f93f3mr147628795e9.27.1794824121940;
        Mon, 16 Nov 2026 02:15:21 -0800 (PST)
Return-Path: <neil.armstrong@linaro.org>
Received: from ?IPV6:2a01:e0a:106d:1080:575d:8fcf:e30d:5aed? ([2a01:e0a:106d:1080:575d:8fcf:e30d:5aed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55a0ffcdsm253382895e9.0.2026.11.16.02.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 02:15:21 -0800 (PST)
Message-ID: <ae3ffaaa-2859-4857-bf16-8fe1072aa7e7@linaro.org>
Date: Mon, 16 Nov 2026 11:15:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/3] arm: meson: odroid-c4/hc4: Wake-on-LAN from suspend
To: iav@iav.lv, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
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
In-Reply-To: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Mon, 16 Nov 2026 10:15:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3150

On 11/15/26 04:50, Igor Velkov via B4 Relay wrote:
> The BL301 that Hardkernel builds for ODROID-C4/HC4 wakes the board on
> the Ethernet PHY only after the AP has sent SCPI SET_USR_DATA for client
> 7 with a non-zero value. Neither mainline U-Boot nor Linux sends it, so
> a magic packet does not wake these boards from deep suspend.
> 
> This series sends 0 or 1 from the DTB fixup, following wakeup-source on
> the PHY node of the DTB the OS boots with [1].
> 
> Tested on ODROID-HC4 (U-Boot chainloaded from SPI, BL301 built from
> Hardkernel's odroidg12-v2015.01 with unrelated RTC alarm changes, Linux
> 7.4-rc2): with wakeup-source a magic packet wakes the board from deep
> suspend 3/3; without it the packet does not and the RTC alarm does.
> fdt boardsetup sends the expected value with the property present,
> absent, and with the MAC disabled.
> 
> Client 7 is an extension of this BL301, so the option is enabled per
> board, for C4 and HC4. The N2 BL301 has the same client, but I could
> not test it, nor C4. The G12 device trees have no MHU node, hence a bare
> helper rather than a DM mailbox driver; I can rework it if preferred.
> 
> [1] https://lore.kernel.org/r/20261109-hc4-phy-wakeup-v1-1-d98784ecac88@iav.lv
> 
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Igor Velkov (3):
>        arm: meson: g12a: send SCPI user data to the SCP firmware
>        board: amlogic: odroid-n2: tell BL301 whether to wake on LAN
>        configs: odroid-c4, odroid-hc4: enable Wake-on-LAN from suspend
> 
>   arch/arm/include/asm/arch-meson/scpi.h | 17 +++++++++++
>   arch/arm/mach-meson/Kconfig            |  9 ++++++
>   arch/arm/mach-meson/Makefile           |  1 +
>   arch/arm/mach-meson/scpi-g12a.c        | 55 ++++++++++++++++++++++++++++++++++
>   board/amlogic/odroid-n2/odroid-n2.c    | 31 +++++++++++++++++++
>   configs/odroid-c4_defconfig            |  1 +
>   configs/odroid-hc4_defconfig           |  1 +
>   doc/board/amlogic/odroid-c4.rst        |  9 ++++++
>   doc/board/amlogic/odroid-hc4.rst       |  9 ++++++
>   9 files changed, 133 insertions(+)
> ---
> base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
> change-id: 20261115-b4-meson-scp-wol-a41de6a7e053
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
