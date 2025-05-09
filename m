Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745BFC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:58:02 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.9199.1746777473036703776
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:57:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=HGXV7MGX;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0ebf39427so1042919f8f.3
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746777471; x=1747382271; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=537ApYJVvV/ApCFtMd8qXCBRmZIJTadbfBAhKdv2Gk0=;
        b=HGXV7MGXTRC4u1nJ2Qyb5LOxD0ugDiA3UfSKU/kU1i7rVcM7+JnNCkIVkJxOMkY1YH
         NcxW7rwWoSpw0hPeMIoAqeu+VX4ACjRp614xcjh6Ki7nwoXWKTvjW6u1+7boyJo4H4x4
         ANONaTI1OT3PVmX5B+VYze6hiXACilh5Wqwx65WsPf/7M7ALkA7oH5lrKiLjjYud32u4
         oUhadRq/3gnaZaAfYj4yoS5H0GawppfJiB2zHAMc4WWU4MSdmL9C3tQHaMA8bZCG5i/O
         WX4JuU+pElDRFE+J3s/iOttP2cq3FK7EEMkq6gmBxtY2XsAT5XeMDt3mnFFAEGdxHuML
         fYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777471; x=1747382271;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=537ApYJVvV/ApCFtMd8qXCBRmZIJTadbfBAhKdv2Gk0=;
        b=JiktsPOJzgNONI5EznHFjHE1kh8SPslrBW5EOVUapMj9GUCHbJMlAr+uWlTOAkxsMV
         y8O35YqqWF9OU0u5gitFzzk5d11UAHrtE+Qq4eMUv0tOvi+AIdV4IxvS2Y8UDFx2xOlR
         8wtV0XNrSfiJyvA9s2A5qdV6LQsE3V5V0bpRbY0Q80SWs3B5E+uPn9WWNgaSJK99kPwF
         z9j9Dzvk+QOpsKuy/uL3qMS/iPnrh2UIx+X9FaGrdx17/aUJguhS45zo9aThE/n+4oEG
         PPfnYgjmvgWB7BE5QdMSisL96IOOwZplwNLzcAX4/9n6JqG7iSvfgwvAvPxgJswtc5K3
         yaPw==
X-Forwarded-Encrypted: i=1; AJvYcCXa8D+XhJRctZqCxxTGcPTNbOCbfi4L4bfPHK+ZK8l8mk4NWYqrdVA7lfFyBl07+JosnAgICYW2Gt9ueos5Jg==@groups.io
X-Gm-Message-State: AOJu0YwcWNfoU1qrQAGrMMtnQBZmmqakvzxP/IjcPuvvPFvqCSwm/4uy
	trVquS7+DgQMvuRr6U4YW0NljpuWBOA0YHudlA4tlziQJwinNnozMCZEryVCStk=
X-Gm-Gg: ASbGncsDozciAkVeeq0yN1RbcrqPyUBHWRE3wM6g4ygXyBRayDPlhnZJt89nRkePsyJ
	349jbNOh7qRdROqcWwXvIZs/1KkUadCZwU26SMB1UuN20cYQmvxCwdNTeTg4zNeQvSf8pIEQXbr
	MEyQDTpzdyT65UVmEotpbnCjj6PwFfertaQea0qchDu+WJyCPeL948XIc83InaetQ11EnmSUT8+
	ZRMMm39Rhsp/Ad7BoHK7XyjiOiVOFy9haJITxeVbBjygwSOglwyVSsgo/ksrlcOtMKdOZuxtHET
	6Un+Av/eImnuA4IJe4DemCX+td5WsjwgQzD48OPvpLqglksi2Z7xmLsb7AP7xpRjSaY52ytcFMj
	9dSD9ig2PKTRRlTA=
X-Google-Smtp-Source: AGHT+IFcOSl4QAzwGHLN9jbf65X64/698U4qW5z8/bNcsYnOW7udUGohajwmigOlYVOg5BmZXnoKhQ==
X-Received: by 2002:a05:6000:420f:b0:39e:e438:8e4b with SMTP id ffacd0b85a97d-3a1f64ae792mr1985191f8f.50.1746777471458;
        Fri, 09 May 2025 00:57:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a1dsm2383872f8f.43.2025.05.09.00.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:57:51 -0700 (PDT)
Message-ID: <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
Date: Fri, 9 May 2025 09:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>,
 "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-8-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:58:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2688

On 09/05/2025 09:02, Anand Moon wrote:
> Add conditional compilation for the usb5744_i2c_init() function based
> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> 
>    CC      net/net-common.o
>    AR      net/built-in.o
>    LDS     u-boot.lds
>    LD      u-boot
> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function `usb5744_i2c_init':
> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined reference to `i2c_get_chip'
> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0): undefined reference to `dm_i2c_write'
> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8): undefined reference to `dm_i2c_write'
> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0): undefined reference to `dm_i2c_write'
> Segmentation fault (core dumped)
> make: *** [Makefile:1824: u-boot] Error 139
> make: *** Deleting file 'u-boot'
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   common/usb_onboard_hub.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 1242513c631..92e3f3a92c9 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>   	int (*init)(struct udevice *dev);
>   };
>   
> +#if CONFIG_IS_ENABLED(DM_I2C)
>   static int usb5744_i2c_init(struct udevice *dev)
>   {
>   	/*
> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>   
>   	return 0;
>   }
> +#endif
>   
>   int usb_onboard_hub_reset(struct udevice *dev)
>   {
> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
>   };
>   
>   static const struct onboard_hub_data usb5744_data = {
> +#if CONFIG_IS_ENABLED(DM_I2C)
>   	.init = usb5744_i2c_init,
> +#endif
>   	.power_on_delay_us = 1000,
>   	.reset_us = 5,
>   };

I think you should completely disable usb5744_data in this case

Neil

