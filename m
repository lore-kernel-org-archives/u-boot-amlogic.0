Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16304C4167B
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 13:36:18 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.31252.1698932176245471981
 for <u-boot-amlogic@groups.io>;
 Thu, 02 Nov 2023 06:36:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ig1yjJvy;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso8371925e9.2
        for <u-boot-amlogic@groups.io>; Thu, 02 Nov 2023 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932174; x=1699536974; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCu/9mdBE8wLWf4btfBI0Fm0TobSOgpLzQFVgw/jaEE=;
        b=ig1yjJvyrh7p6aukGuPDrYjpsjWxNqBujpHnhPduVFDI5DyWS2HpNItiFtdZgH1S+H
         7rC2NKmm+tPZ0AkBzhf3liCBKuZO1GBBDIYYg/nmsKrQzO49eLWPaNj8rILrD3ubomte
         6v2nDR48aBdS+o7IHC220aDTDxv73v+rNU9KbixJDW8I6vgz0pCz25TQLzvms97OkCRY
         RI8bjk4lNcKKKNQVm+4QGBLIURVVOe6oEyXANS+/PX8IGlBJ5sFph6euYTJ7Uu0G2IF6
         4oqYcAi08IUslYDh9v1xkVeag8RjV5XfHmQN1SKglHZJ2wAa2OX6Uy7qRXmZr+xl2Bcg
         p06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932174; x=1699536974;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rCu/9mdBE8wLWf4btfBI0Fm0TobSOgpLzQFVgw/jaEE=;
        b=BcYmbP7c/Qcsg5xYZunjC13yHtHGou+1Lawu62eUS2/SjoSEQpnvvc3yDfZT19vlN8
         LA8Qk0q3FmGDo8z5c8XBINVal5s79BSmz5zYjm/HNBnDwawt4EXVt5ddkeu1IBnWCCiw
         9EobBphwFXV7vsV2bs+rBIfGMDOveh5hxA4uOaB4zoj8ZP/oZYWV8Ug6sUGNnUAkxDWo
         ZEkCFFHF6i9jkP2CM1BtSQHYP6jbjtlD8njsDHU/Pjue3DuS0cc4C9PyN3i+uPt/ljPw
         3uVPHccfdncu/ir3krNjBeIkqSkeSDc5mMmTBkiFYZVdiNzuP+pzz0INge4nRJuUcKmO
         lsNg==
X-Gm-Message-State: AOJu0YzR1B0O18R1Wz4jlYeNVunt1DKWdpjn8cubmObWTHXas1qNXeHk
	fRpTJLOLjRIKq58yuRAtNnk5Dg==
X-Google-Smtp-Source: AGHT+IEKc/z7hZ5xiuGrNkJpct/9o+BKV/Mdaaca0VkWtgwnMOAGFvXAt1MXK5oF2PWnjYQDlCBIQA==
X-Received: by 2002:a05:600c:20c:b0:409:4823:57d7 with SMTP id 12-20020a05600c020c00b00409482357d7mr8451967wmi.14.1698932174424;
        Thu, 02 Nov 2023 06:36:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4ac1:f109:811c:51be? ([2a01:e0a:982:cbb0:4ac1:f109:811c:51be])
        by smtp.gmail.com with ESMTPSA id g9-20020adff409000000b0032dbf26e7aesm2508168wro.65.2023.11.02.06.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:36:13 -0700 (PDT)
Message-ID: <74b52686-aed8-4a5f-bd35-bb286d27a937@linaro.org>
Date: Thu, 2 Nov 2023 14:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] clk: a1: add new clocks for USB stack
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231101140500.9025-1-avromanov@salutedevices.com>
 <20231101140500.9025-2-avromanov@salutedevices.com>
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
In-Reply-To: <20231101140500.9025-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 02 Nov 2023 13:36:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1817

On 01/11/2023 15:04, Alexey Romanov wrote:
> Since we sync device tree with Linux, we have to add this
> clock definition for USB stack.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/clk/meson/a1.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 1075ba7333..d0f5bb3753 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -241,6 +241,12 @@ static const struct meson_clk_info *meson_clocks[] = {
>   	[CLKID_USB_PHY_IN] = CLK_GATE("usb_phy_in", A1_SYS_OSCIN_CTRL, 2,
>   		EXTERNAL_XTAL
>   	),
> +	[CLKID_USB_CTRL_IN] = CLK_GATE("usb_ctrl_in", A1_SYS_OSCIN_CTRL, 3,
> +		EXTERNAL_XTAL
> +	),
> +	[CLKID_USB_CTRL] = CLK_GATE("usb_ctrl", A1_SYS_CLK_EN0, 28,
> +		CLKID_SYS
> +	),
>   	[CLKID_USB_PHY] = CLK_GATE("usb_phy", A1_SYS_CLK_EN0, 27,
>   		CLKID_SYS
>   	),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

