Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7994C2BD09
	for <webhook@archiver.kernel.org>; Mon, 24 Jun 2024 09:11:50 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.136197.1719220301713142216
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Jun 2024 02:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=jn84SeHk;
 spf=pass (domain: linaro.org, ip: 209.85.221.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-362bc731810so3639830f8f.1
        for <u-boot-amlogic@groups.io>; Mon, 24 Jun 2024 02:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719220300; x=1719825100; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWfhviN6WvgKfhx96EfYzMuoJiygBnbMqdG7kCwyd8k=;
        b=jn84SeHkm8ItJgSX281JQX2U8/yeqs9JWKKeumdu5+jJabzyqY3E9VnIG2IWhwL+aw
         jQBwtY5Jst4IUAPZbkOm6nf26C5KVW9xDf7EtYZ+QSO6jG2r5o7TNEpRuoAEGu5QlDGI
         Y0t0Fq3iToMAJjZjsEON07IyuBbAHNu7EnOiN6Pv8maMAbZjjkDzzBXTu5loG4h4bF9U
         mXXSkphOXvWuYQ88gKTLfWkSsIp9WW4WohhtiZYhVzUIdxq6dHm29c4pWSEz8BBwHeG9
         8D3OszrBfVcmMgaKEN5EzG8YtCPSgFcADe6xAOZjQrzq3W9oMUABjUX71uPVQ/1GVgp9
         FxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719220300; x=1719825100;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EWfhviN6WvgKfhx96EfYzMuoJiygBnbMqdG7kCwyd8k=;
        b=WwzAx5wlYd5CmDX+rmL5XPS0hj2jOVZnPmIJamJaJZmxWpU8LJokYPXa0FvxP8UA8B
         OtDn8GRODjz8u8pEG5G+6BwP8ssd+/VtkMgle/b35NEpzg8l6onT4PTJ/FeQUozHGUfx
         JhhjEC01zuy/9NdbSUJdis4pDDfaWknNmOawde+VsysGn0aKJcRdF3eIEN1S9lsVa2NF
         Lgb0jmNTsgMb7pXDrJn9TmEsKJ+NoA4VshfYa+HAbyWOXwSd06Iobl7LCSFtItw2hJ6m
         UOL0VfwTqSVj3806Ph7oa36HlzLlq1WQZALmyhDqTUrY86N0YScJdnhYJKmWF0WZxaEK
         N8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVGYeC4c2qgbK90bwoTJdEy1fdgtjC7TvmZjNCu9S4hIfXj901qlAnciRe5Dg6uECvjSJVmSPMNojn/JQkzkTdRaPnNUzhPfHo=
X-Gm-Message-State: AOJu0Yxk8+x/qSp3aAkFUFPT4d0FZpmtsigdzx0Vw+FvjNUDE+GCQnci
	wezkBTwhBYc+VhKCAGXZzDvxOarGYg4zcWjurOOJHkGvuTLYvRfIdMW+tElcNvE=
X-Google-Smtp-Source: AGHT+IHHEGvrSpkT7vZyvxUlqb8JH9M17UnxmZe46d3dA5fdljndtupG4Fjj4xRpS4gB4DOyygq0FQ==
X-Received: by 2002:adf:f782:0:b0:363:7816:7567 with SMTP id ffacd0b85a97d-366e949a5e5mr2941656f8f.26.1719220299765;
        Mon, 24 Jun 2024 02:11:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9975sm125572475e9.14.2024.06.24.02.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 02:11:39 -0700 (PDT)
Message-ID: <857a61e1-a586-43e5-be07-0321340e21e3@linaro.org>
Date: Mon, 24 Jun 2024 11:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/5] usb: meson: switch to set_mode callback and other
 cleanup
To: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
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
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Jun 2024 09:11:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2319

Hi Marek,

On 20/06/2024 09:42, Neil Armstrong wrote:
> Switch to set_mode callback now it's available and in the same
> time make public functions static and drop useless mach-meson
> headers that are no more needed.

Thanks for the review, is it ok to apply it via my tree ?

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Update commit message in patch 1 to specify why we use _ in the set_mode callback
> - Link to v1: https://lore.kernel.org/r/20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org
> 
> ---
> Neil Armstrong (5):
>        phy: meson-gxl-usb2: add set_mode callback
>        usb: dwc3: meson-gxl: switch to generic_phy_set_mode
>        phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
>        usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
>        usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static
> 
>   arch/arm/include/asm/arch-meson/usb-gx.h | 17 -----------------
>   arch/arm/include/asm/arch-meson/usb.h    | 12 ------------
>   drivers/phy/meson-gxl-usb2.c             | 30 ++++++++++++++++++------------
>   drivers/usb/dwc3/dwc3-meson-g12a.c       |  2 +-
>   drivers/usb/dwc3/dwc3-meson-gxl.c        | 18 ++++++++++--------
>   5 files changed, 29 insertions(+), 50 deletions(-)
> ---
> base-commit: f1de28e67aa9b66bfca0fad3dc18446a6ec0b504
> change-id: 20240618-u-boot-usb-gxl-phy-set-mode-c3991c5f1da2
> 
> Best regards,


