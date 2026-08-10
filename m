Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66025C5AD7B
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 08:13:49 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25209.1786349623475132683
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Aug 2026 01:13:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=PcaZr10a;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so4819665e9.2
        for <u-boot-amlogic@groups.io>; Mon, 10 Aug 2026 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786349622; x=1786954422; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6CcsBmE9d8AZRmH1oxEjtohI7GsrsRp4pHHWd8oXNs=;
        b=PcaZr10aZSfbfNOoomPbvd0GIZGSue2IQI1xqxLnUwcwsOX2OCJMyjtr+26bG0VLVE
         mj9DxF2XWbuJS31E14Df14Oz5knqRE0wLVpArcDk+apa4nnsh5OSBAxxM7a+Bn96MLS9
         s502nBsU19dMnXMrDeYrcVrfP7j0OlboaB6dID06ljmDb+9sygtXk1ipF9GmONgqnYfH
         AZS911n4JT9qQJKCqsT4mTSvgeE0AFDFWe0Zuldt8kLqHx80dUATYDXOIt4X329SO59x
         +zZdPaJ9WeYBPW3qesC6x/2P0C8XhQg67hjvQk0usyGODqmO85bzXmQ2MFqYIZduf3/K
         Z0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786349622; x=1786954422;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6CcsBmE9d8AZRmH1oxEjtohI7GsrsRp4pHHWd8oXNs=;
        b=kATk897K5kplXEGgHq+QqzdqvEzmnlkctWphFIur4FgUVHqj6hvDp/8msu66pyrPiD
         MLV+h8Jxf1zsG9qyxEHecHF/CWIhn53cf1tFt4DOVN/C+hjubTGDFPdkuXw0366en/7J
         yxpqc1Oik+GwTgiDps1srYEcOV043PZiKKZ27ILPV9pJAxeLMcn/0k5vBLqKHAudF24q
         YCjPdA4oNiuMtPmAoniEf4n4VmdiI2VMfqqXATly7+Dg0X0r/sukyRMkYxX2u7LTpV6X
         MwA+Lahh/b5hRV9LzkDyHXGt5hQpUPvel2ed4rCQfaTDK+wwVGMemf3Ltz2rmNeJwHrJ
         +Oyw==
X-Forwarded-Encrypted: i=1; AHgh+RrRJVRWmV+VPrtkke7qTLkDHddio5hJ9FG7j5M1jsrPNoW7pFEpMKaZQfFBIIQPuSP0mlqnyt76bIRD3osRlw==@groups.io
X-Gm-Message-State: AOJu0YwG8zgzbomu1u5TNJLuHiyg22mCx+yfG4JSMCE/5/aYu3T2H4rc
	vt2DhG+SpiSy+U5ybo4MSb9XlAR0S8OTSZAxg1wGDW7nWrbH4nrKWwocwk8z71q7csvUqz1N0Y6
	Clon8G4k=
X-Gm-Gg: AR+sD13gwNyJKToDDMuJyVgmgqhbfzzHhbqbOLDAQozjBijaNK0EKe8BuB5tiGky2s/
	4ch1iXHt5rrS9zzy062rsgJq2JvWvs9YV5O2yoYCxskA11rSYY/DDSye0F9SVZ2b6xUrv5QnCEm
	IJvWHMKvOZWlCs/UFQwVdFrLgHLr/s1rk0ZVTnSkFyKgfH0yYfQLUyUvuqcMkzg+Yn7IugvKs03
	OEcKHWJUyDSWTBSl0egkSXc0gFWicJPMs3ANtCfck290BZ/NaJtKLnFSwacT100ujgaDwRgNfIc
	Fy2aXW0Te7J0csZWDBI8OhhGl1sKb4iTNVajZZYXiWK8caMB9/1/gbWFvVGjY0nv9mziIKteM+J
	DmE917mw1bGYFTePOM+GSfUeHv6+l2hfCEmkXeJx08RpZwSXQHCdxeKg/020HagjanFFt/8pp22
	qj9SGU7g+zIOrCnKp25SSDz6juUKxIVmGmdQAVixMY/G/EvIhrblOLdvi2ORhcnVgXvp41/yan+
	uo5VUA5b4IB2MHN5IPhGQi5p50u9OwYoxnmnF/Jfw==
X-Received: by 2002:a05:600c:310f:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4994e7432ecmr511736155e9.4.1786349621614;
        Mon, 10 Aug 2026 01:13:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32? ([2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800215078asm31207435f8f.12.2026.08.10.01.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 01:13:41 -0700 (PDT)
Message-ID: <22f08266-216d-4554-ab1c-5a93ffffc37d@linaro.org>
Date: Mon, 10 Aug 2026 10:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] Add Amlogic T7 (A311D2) and Khadas VIM4 support
To: Lucas Tanure <tanure@linux.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io
References: <20260806101809.72526-1-tanure@linux.com>
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
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 10 Aug 2026 08:13:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3019

Hi Lucas,

On 8/6/26 12:18, Lucas Tanure wrote:
> This series adds initial mainline support for the Amlogic T7 SoC
> family and the Khadas VIM4 board (A311D2):
>   - S4-generation UART support
>   - the T7 platform code
>   - VIM4 board and defconfig
>   - VIM4 documentation
> 
> Tested on a Khadas VIM4 board, both chainloaded from the vendor U-Boot
> (tftpboot) and cold-booted from an SD card.
> 
> Lucas Tanure (4):
>    serial: meson: add Amlogic S4 UART support
>    arm: meson: add Amlogic T7 SoC family support
>    board: amlogic: add Khadas VIM4 support
>    doc: board: amlogic: add Khadas VIM4 documentation

Overall this looks good, I'll review all the changes closely,

Neil

> 
>   .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi |  22 ++++
>   arch/arm/include/asm/arch-meson/boot0.h       |  18 +++
>   arch/arm/mach-meson/Kconfig                   |  10 ++
>   arch/arm/mach-meson/Makefile                  |   1 +
>   arch/arm/mach-meson/board-t7.c                |  97 ++++++++++++++
>   board/amlogic/vim4/MAINTAINERS                |   8 ++
>   board/amlogic/vim4/Makefile                   |   4 +
>   board/amlogic/vim4/vim4.c                     |  14 ++
>   configs/khadas-vim4_defconfig                 |  27 ++++
>   doc/board/amlogic/index.rst                   | 119 ++++++++---------
>   doc/board/amlogic/khadas-vim4.rst             | 122 ++++++++++++++++++
>   drivers/serial/serial_meson.c                 |  51 ++++++--
>   12 files changed, 421 insertions(+), 72 deletions(-)
>   create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
>   create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
>   create mode 100644 arch/arm/mach-meson/board-t7.c
>   create mode 100644 board/amlogic/vim4/MAINTAINERS
>   create mode 100644 board/amlogic/vim4/Makefile
>   create mode 100644 board/amlogic/vim4/vim4.c
>   create mode 100644 configs/khadas-vim4_defconfig
>   create mode 100644 doc/board/amlogic/khadas-vim4.rst
> 


