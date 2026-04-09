Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE60E9DE62
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 08:01:03 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.127152.1775721655068578355
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Apr 2026 01:00:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=DJqP2qpi;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfd832155so324214f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 09 Apr 2026 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775721653; x=1776326453; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0pkEPfVJHYQa0fWxiLYSX8oYgr1zh/pt7pLDfKBF7Q=;
        b=DJqP2qpim4qPfAvgV78iKywIQWFCIrcxLwf3SOKVS+kW6ZSyFFb+sLPUOVGHXVdXpZ
         g1vEmyLOeh8TsGQ7Jn58UhHSZKu5K7mULfiQ/F+yOkeghmzWABhXCbyZNdfQC5sDYO07
         VZzrugnp/zjBHUzoUVr4iEIQcFFvEfudlk4+BFWzz6rXYS6UluW6J2PyZ0T7x3L/cwKO
         UDaI5Vhe7/OY9mjV9jOVxzXoEn6jYDfoCR9e3dQQtrM7SfhweuSeymxVFiCzM3Zk2MCe
         ZKhNN8R4G5VJmhxTMnsZlVc73qowhMJ1Vp8kP9n/LoE/PvGlXbMtm+ulomPCz+PJslpa
         ZJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775721653; x=1776326453;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0pkEPfVJHYQa0fWxiLYSX8oYgr1zh/pt7pLDfKBF7Q=;
        b=HYGTw0pqBdJdizQLosgTaBDoYXoJyrowlb+SgAgR6JU7ezs+ddCCy4ITFl56Y3CM0A
         X1N1MDinyn6G+q9WUL037HXkdTje8ZAfjZ3iYpFuan644l6MTnXitG8KN9BhXE8709e8
         uYABqqgXY6PwmCBH6tsT6atuIVLniJ9h/qhxRq2EIJ5EVKMRnjnPf1ahNiBwFfW7ejZc
         p5D+7wCh8gjuuQ5BznC8x6ZUB8B8lrTGoB71w8+QpT7K8nH4oOhwPGcdDJkfBVDrWoeb
         lsepYuqsONV3De5s0PUwrGSXbXcL3+Txc3nNd9Ivovs4DuB0BbaQcXDaV6IkBZxnyGYV
         O7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVL0PBPxNAV9sE+hF0B2TkTptWWvkeosdv6CouF50mLm4xL9A6OY0CpYRG7u7vnh7a0B7TJ8ctbD1jziYAFQA==@groups.io
X-Gm-Message-State: AOJu0Yyxyp5lP+n7C1DEeN2eXVU0Zcyn0sFlVj8WxwD5ghSDw6laUpsr
	KgZw7o4snQBlMPk+vnptpHwEg+8CsYxdrQSKUYredEaLCCLO2KW8AB07cSmRrzK5zJ0=
X-Gm-Gg: AeBDieuSeao1pARxrrS4X2ouC5rNMMuCJTTzk+IfX9xYhZLIW5hgRITam2iJPdAh7Hr
	TmxH5uruIvNfoqxNCnx4PY+MV6VzVht+STW0LIxVtrViep07szi6xfF1jPX5uUTCryJqv8HLcM5
	tcGEaUYTHQ+sL4HwFaOOpp6mNeUuAkkpF6LQCHejntq9BW0J8mYJHaN2LVX9FDP5Ceqz5W9o+Kp
	4AA67oYg3+i3irYr92WGcFV/o07YiSN3OjRfw7KiV9dLvFWIEP2NNvNNDXYg4ePztAQ3alUGYWQ
	EuL0itRpwJmqX6pFq6uGu4s8AsVnW11THfL3gVaMA97hIMRX5jxupL/6VrBZB77XEPjsu3oQIrR
	fOXsG97AxcZax/Z223AnK84N3eujjIavbuEV6t2eX+8ulpbp8xYzOen8mgMNH3wQNzunGsLxSq6
	pghAH+1yzdJLBhgzxwZF5Ze2oAYEmnQpzBxu+EmgkiuCa8BVo+sOV3ziLaR7YLlgAHrKbcREc5/
	auS4kM=
X-Received: by 2002:a05:6000:4313:b0:439:c040:cc8a with SMTP id ffacd0b85a97d-43d292e43d7mr36776743f8f.32.1775721653242;
        Thu, 09 Apr 2026 01:00:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:70d5:8219:5bd4:e213? ([2a01:e0a:106d:1080:70d5:8219:5bd4:e213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm58880667f8f.9.2026.04.09.01.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:00:52 -0700 (PDT)
Message-ID: <14d1214a-f787-44eb-b66e-2f6d26deba42@linaro.org>
Date: Thu, 9 Apr 2026 10:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] arm: meson: enable SYSRESET_PSCI
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <20260408-b4-amlogic-sysreset-capsules-v1-2-6f3386eb5124@postmarketos.org>
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
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-2-6f3386eb5124@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Apr 2026 08:01:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2958

On 4/8/26 22:30, Ferass El Hafidi wrote:
> Previously, Amlogic SoCs defined their own reset_cpu() implementation
> that essentially just did what the sysreset PSCI driver already
> supports. To reduce duplication (and allow for EFI Capsule on Disk
> support), make use of it instead of a board-specific reset_cpu.
> 
> This does not affect SPL, as in that stage we do not actually have PSCI
> (BL31 is not loaded yet at that point).
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/mach-meson/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index ef86129b535..a615d871095 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -7,6 +7,8 @@ config MESON64_COMMON
>   	select DM
>   	select DM_SERIAL
>   	select SYSCON
> +	select SYSRESET
> +	select SYSRESET_PSCI
>   	select REGMAP
>   	select PWRSEQ
>   	select MMC_PWRSEQ
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

