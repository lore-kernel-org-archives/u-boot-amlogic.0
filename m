Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73004C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:57:12 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.9190.1746777423246732921
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:57:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=BGxd+txs;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a1fb18420aso84577f8f.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746777422; x=1747382222; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efmHCeBgTnRYS40xzMd46bnQ79NApzG9AwWl8mFsRHQ=;
        b=BGxd+txsBud34HLm0ddsHKQqpwpr9sF7OKnwd1BDdLB6++RUcchHiKx7f8tcUhXXG4
         mVkHxR0pPxV51IRtFxFA5zyBG7+xuia/tzvwXcExwkIknoL6Pa2pWK1XCke5NbuMfjHP
         1a01XUp47zgGWDQu566pej1FIl2vqWbnbDK5yr2GS3QbhBxFvldz6glWVJrXCSKKrttd
         5tmN2V/KwMJqf0MAM5W5B1uKPEYF1+jio3qxDy87Q1RqgLbjUI7jKPbilOiXgu7Cs8NM
         mg0RpQ3xW0aDc6guWQmALGK6bgkrzXBWOQgffHge7aWp6+iOKlTlOK8Zj/wkyZA7GZBy
         9Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777422; x=1747382222;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=efmHCeBgTnRYS40xzMd46bnQ79NApzG9AwWl8mFsRHQ=;
        b=CKNpu6NcsWzXzF/nxgvgWCNPiFWLVMjEkFuOd228h6sC8A6PSziBs7X75IR/VHr7A6
         z3AkRAuOpuDF3euNp2qRr06vr0FiXnrAoCHLgqmYQVkrPFi2O1ouc1eAjGuqi7JPpGom
         TWmcbLdDflY5EvCU/1+WGPhWUdAP73S06Ikmihci/bu0bwGvUNiMAZ+CvInlgmlh3qEc
         YNATfCYU/Vk0yoLdvPTMr9trQwd81ZMUMpuXAIxC7sDyGQqZlKb4W8SSle/6nPsTCkkN
         84BFk/lpVpX5Jz5f9mYxBVlfJIY437TDiD6L0X0/a06iP5WlRP/AR5sY9HJh2JrbYToz
         k7kA==
X-Forwarded-Encrypted: i=1; AJvYcCWF7NrUziE3UvVOxtNWUUtJoEGeobXm5/rR3SXe/qTsu8Pvx6xXsTxzS2/S6arsV3G1YAafbD6AyddEgXCTmQ==@groups.io
X-Gm-Message-State: AOJu0YyqQFXHTOqSyBk7boi5o2BHOlmd+tidOXOyCUwwA6RPxmJ4S6pD
	ZKkhFps+RasQr3q99BTPT9iNKHtq3Fm339tvRSqd20grMVZDA4Zlbwjui/fjD5E=
X-Gm-Gg: ASbGncsyeb+xyIsUL97/knKSwZKUEkGjzZUfhNdGiPqFTr439SFpcPHcMiAXbjlTJNE
	pW7oVipMHbqub9Bt8McppyYNE6g5Mj/3AoUJ4O56O5lDqqgJSx8N66xxHsfGsaS7QSVV0ShEw5q
	PCThqRM8giN/2cAqGYDy25VUuhfKY1Cn+wAFZpbKqxN7V0MrmiA3Z00QNd4fKD3FEKdERw+gjqL
	kZdNIY9Cc+6LlAgizK5X1jQl6blJsV021QpRkFS+IvgVoY8+EjDB4+xTjmfp/qilhgOujs0EYFM
	jdKgflXinMRWIk1oqBNPpUi7SLMgNKqXMyY2Wg4ISQOLZmy+1zmlMZuz9Xa3Kvupul9xlnOQy1l
	9EI2hrmwjnsKk54qqeZcBo3zGzA==
X-Google-Smtp-Source: AGHT+IHxMLKpcJspff1fQ+F7Z5n2uc9edRCypRUuWDy9YHmNaHGAj3wg0csJTx22YfeP+Cnyzaw4zg==
X-Received: by 2002:a05:6000:a91:b0:3a1:f5c6:2bd with SMTP id ffacd0b85a97d-3a1f645f228mr1773158f8f.31.1746777421662;
        Fri, 09 May 2025 00:57:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ec98dsm2408874f8f.25.2025.05.09.00.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:57:01 -0700 (PDT)
Message-ID: <6ca82786-94d0-4df2-a2dd-62b21fffb8b5@linaro.org>
Date: Fri, 9 May 2025 09:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 4/7] configs: odorid-n2: Enable Oboard HUB driver
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-5-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-5-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:57:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2686

On 09/05/2025 09:02, Anand Moon wrote:
> Enable the onboard USB HUB driver to power the
> USB_HUB_GL853G-OHG on the Odroid N2 and Odroid N2-pluss.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   configs/odroid-n2_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
> index a8cbaee3c96..1bf687c1e6d 100644
> --- a/configs/odroid-n2_defconfig
> +++ b/configs/odroid-n2_defconfig
> @@ -64,6 +64,7 @@ CONFIG_USB_DWC3=y
>   # CONFIG_USB_DWC3_GADGET is not set
>   CONFIG_USB_DWC3_MESON_G12A=y
>   CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_ONBOARD_HUB=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
>   CONFIG_USB_GADGET_PRODUCT_NUM=0xfada

Same as patch 2, with that fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

