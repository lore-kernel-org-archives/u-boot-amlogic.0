Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72066C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:57:12 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.9247.1746777430663463778
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:57:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wHV9vrfa;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so13407525e9.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746777429; x=1747382229; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBjTLfQ4AhJpzJkA5Qo6kqbiHyIan+7HgHTbezLqgaM=;
        b=wHV9vrfa0BIVfs2wZQ3SFMN7+Djb5VzZs0guernV9tm6eTub1XS7Lrr0HlmU6dt8f0
         EVg3aCsk6C7i0j3kPRGD5iHwS7T4W+hraM6MWMgPzTKen6kaFAhp5bSx9RCgvwWvr0ha
         KSs9FobVrMLO7uO2Pkcolwf2Xn5oRtehxOopXnC6hNnp6waxY3gLgTLQe+Flml7wywcd
         OnpGs7WY83wtkS6op8VfXkiLvvgpGNgc4YHtqF0G8mJjbyxFrI8hHbodY60m+QNLWCdM
         pJ9StNGuHA+q105gZqDY2D6THmwoQQlZJkHCny2amngO+73YTRr/tDVRYpGIJ3auV+pd
         UUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777429; x=1747382229;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FBjTLfQ4AhJpzJkA5Qo6kqbiHyIan+7HgHTbezLqgaM=;
        b=U8XbuwSpo4Ibu9f5SBKFGEPmjLb7b2txHvyftzDb6RNBEMsmk/ZVgJE5+iOEYk+enF
         SYkH1Iu1iaRLASB2SPrNKPVLSShlabXRKma+ZqKMc5CZNqhASqTE077SUxna55/h8F2J
         9aG2XGqpQIY4khzR98iYU9/j6k0ZJasXpXlpfmf628d6SuvEGZ/Yn+ba13JuhSgV9rkW
         jesyid8AFdGzZTSmEosPJHo5iLx/mP49N0m5EKTeNI+S3HM2EYFzAT/zSbJhEQH4i+7V
         0eFOzpvZVzE6izNzxopTT2PCwZtkg+IVQPQjsVfsiZkegvCt6r1QBVjft0/EhST0Mq4N
         rJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXY5axCRi5j+8FV5gHt2v5kDU4YDYpegOaxaIDOk8oq+w2dAVlVx+DSI8qcmBYzt8pWzZwaBsWIfDewWYjvDA==@groups.io
X-Gm-Message-State: AOJu0YzBwVhJ95iSufNbFje40WIiPbbhamYriUfj5ntED2w3zvnnY63Z
	A6SvaoGrnPAmJzb73wWN+w+7y0adqSNugrHWt0ZQIynmYolHA/YRNbzZHJEGC3U=
X-Gm-Gg: ASbGncvx3DugIVpwduacnVqaLifbdoFOnvW3AuUAGp6WHAIro4zjTPSaEs1Km+OMN5L
	yrTxyI+62ZbBE5//BzXldNQ56OdqhMvmL/+C/LixB5+tN00O83PT/mnFQCdxendx4ZnIxMkvhL3
	QaTYLtSwQlYQGNka7Q/swpX2MkNBhunsGiP2UPt8Nf6ln06rQq28kTPJ2rANrdFc1xPuyFFjm02
	quBOX6oPMyAmb05IgdKyveKaUyrNDZFoJp2NpJk9XTuDiMTtHW7f+bTFOJhI78th8Cc9L+UzAvE
	Hh948HpcnrxuxbpzWrNyEQ11f0HUkTAh3vHY9lO6Mf5bKZoV5+mQ3seKpbOQp302O6q8U2f/EdF
	Bw1nUxaHMaLfOttHFiTYXMI3AFw==
X-Google-Smtp-Source: AGHT+IFluptaWC2Si9dtFIGgSWzThEXrDpBy61T+VHt4xpRZ4zIXhNmx67A/Kv6G9dvGgW9MtJ3d/Q==
X-Received: by 2002:a5d:59a8:0:b0:3a0:831c:dff6 with SMTP id ffacd0b85a97d-3a1f643115bmr1952428f8f.18.1746777429029;
        Fri, 09 May 2025 00:57:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddde0sm2485222f8f.14.2025.05.09.00.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:57:08 -0700 (PDT)
Message-ID: <8a57e0d5-bc7e-47a4-a901-1e16ff686ce9@linaro.org>
Date: Fri, 9 May 2025 09:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 6/7] configs: odorid-c4: Enable Oboard HUB driver
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>,
 "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-7-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-7-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:57:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2687

On 09/05/2025 09:02, Anand Moon wrote:
> Enable the onboard USB HUB driver to power the
> Via labs VL817 USB 3.1 hub on the Odroid C4.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   configs/odroid-c4_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
> index cc3d7fc7484..3c5e53828a1 100644
> --- a/configs/odroid-c4_defconfig
> +++ b/configs/odroid-c4_defconfig
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

