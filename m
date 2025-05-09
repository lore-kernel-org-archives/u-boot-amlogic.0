Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337BC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:56:32 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.9233.1746777390388390353
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:56:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=nCGoGADw;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso13642865e9.2
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746777389; x=1747382189; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6d5OttQ2yXQra1+rh5D/qH1+rbl79e3GdoLmqSd8Rvc=;
        b=nCGoGADw3S6Cj4cpqSZuun517XmLKJKtXPZ7WLrkDpRSwJ5kXhVWlhzR0EwW5WyhrK
         BtuEuZ6Je9+ZaLsDuejsHpl6WhST5wnfkesex5Pcym1xT0HO+FRdMGh39nqAw7Y/ugS3
         TF9nzj5d59GNms+CgaUzzmtXeh5WqJdKd8Yp3S+jgfeLvLaNAeHlFVcFnsS/GxuoPAsf
         YUFomVodcSYxEodwE3ZXIkv8PtmaWqIvDPPPMoXMVgtrgNZvEDnGVJGCvnYTs1ODo0Hi
         6sjUKebOOJMHISbhMyvLGrPl+bG+KF5rf1fsu/rg7HovcVxiukl4UAjheuYTP1oi9M9J
         EHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777389; x=1747382189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6d5OttQ2yXQra1+rh5D/qH1+rbl79e3GdoLmqSd8Rvc=;
        b=O2oEZKiG0Z5JOAg3IfNi1knNbUh6ScoFvsYpsQAEnZ0h2E7MNbIXmnyvcgF9sEjjzo
         HrEbaw/a9sCy7kXklfObDjUKhsUdbQ7FqShD6PGppwxyI00aw1ZcWjczK3Zq0S/zhdvh
         faDJU5qqvC9DV1K56LolQdwTYpoTht1cYQwwKtaoJJ6NFOSghX/YeIzznPeSALjcmIIP
         /g7qxKGmaQMnh1P0Kx//b6ICAFjkcPa0S6EuR6NSgz0Gfq/yAG5iNRsB8S7RxyyOFUdw
         oMn3xTS2+Jg86hm2IDAyxJN+cXBs7d9j9rNRuTuY/mC+C773NRLZMxjXIPmAwVEET9RT
         bjLA==
X-Forwarded-Encrypted: i=1; AJvYcCVxluDkEqT8/uxJoXNgf0uA+m76ugbhVZp55Bh97h+Y2W7Sj0I/T0MVB9WjUsJ2ILrm8oqCwZjfbmHok675rw==@groups.io
X-Gm-Message-State: AOJu0YzLrRL3Tf8d/d9uLkwPmCLq6JKz89Hqr/YYVEZ/X7ONvRdY5vAU
	6OTpkUYXoeAbfxjBe+g7N6jkfNthMS5TTxd+pQe54BtOzhp/tNAZwySJk8uYvp4=
X-Gm-Gg: ASbGncsdNYg8dBBKcc+Ixoo/ldXtVoe9SWYg3AEGDsjL51NbK5x7EU+THUtvuSjPWib
	lR8uy+rUYu+fNXieuwE56QEfQMIS8SQPyomvLSnmx+oxKIVb7+dlmUcK+kiT4IoZDCLGroIeTsN
	dbykSJHm/U3QsyNX+0QDO3B419266CHFGIQGpDbPkcjrI7ccGRWI38P8wPhRbhY1cbV2D1y+yHY
	+Lwk0263B3JatN8Ep+rEVyMFImozVHczz+52bU7ef8IVBvOH4gJIKSfudBJqO6y+HLe9ndo+rXQ
	J3k1cmWRyUY4FO9duFiMVaYIrkOdu1HFQo1t27uHK3P0q+k3zgbXrd/lTN+M8sT584CFqIXHYEi
	ChW8022gtxEARn1IMjHZ4aFcCSw==
X-Google-Smtp-Source: AGHT+IE4r787EqeWN5hkVggL9Owkxa7wQTIrh+SRwwXQ6XYsAl8aa896gImLteC7wftHff8sUwjhYg==
X-Received: by 2002:a05:600c:4454:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-442d6d44aa7mr22221275e9.10.1746777388825;
        Fri, 09 May 2025 00:56:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ed0a5sm2401350f8f.21.2025.05.09.00.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:56:28 -0700 (PDT)
Message-ID: <5c3f5474-5b5e-4e73-baf7-b211c482badc@linaro.org>
Date: Fri, 9 May 2025 09:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 2/7] configs: odorid-c2: Enable Onboard HUB driver
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-3-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:56:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2685

s/odorid-c2/odroid-c2/ in the subject

On 09/05/2025 09:02, Anand Moon wrote:
> Enable the onboard USB HUB driver to power the
> USB_HUB_GL852G-OHG on the Odroid C2.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   configs/odroid-c2_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index bcaab46f8bc..f8a66a923c9 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -59,6 +59,7 @@ CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_USB=y
>   CONFIG_USB_DWC2=y
>   CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_ONBOARD_HUB=y
>   CONFIG_VIDEO=y
>   # CONFIG_VIDEO_BPP8 is not set
>   # CONFIG_VIDEO_BPP16 is not set

With that fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

