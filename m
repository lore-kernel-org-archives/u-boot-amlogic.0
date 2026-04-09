Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE9E9DE61
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 08:00:53 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.127518.1775721648657344370
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Apr 2026 01:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ws0JJa5h;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so6757275e9.0
        for <u-boot-amlogic@groups.io>; Thu, 09 Apr 2026 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775721647; x=1776326447; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Om2xywcxI3fHwkTpaTy/n/Yzf0/yCJWYXd+MLwqqrf8=;
        b=ws0JJa5h/S+bsldiGWypF3iCMhZzc9W1IK7Km8inn5UsQX1YkCX6xuZlZyVAZn4uhS
         NC2bSR6rfHd9fp99D3Ic9vTRALEJWajwSpf+wogOBTYqLDPIrrFtuwAedl1z+RVE+csI
         ZevdUQvYzX87ejgKldnSeGwmgo7zj3TtSm6GwYN0l/VYWprMqXAqcVZo09PIVSrzhgBr
         7Q/HYrxDtCvEPwyZw6OCjV94kDM5Ph+dQcxXrX6AGcztPaiUO12KFvNfHn3MH09G6uJm
         6/0TetEg9faQPcT8xBSjgXxDeRkCbdT7quMiINA7Xc0ZTKzVcTVgfD6qVDuzWcdIw3sO
         1l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775721647; x=1776326447;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om2xywcxI3fHwkTpaTy/n/Yzf0/yCJWYXd+MLwqqrf8=;
        b=jndmMTyFpqt9RiXpfpQyrNlzby9Sax3X+vo1xSFPzsSPO0pv1v0algZW4xRitUom52
         RC+LNDFJh+S+YpXqyWPE7haj8XZbhYJ+MwHYSfS/a33H0afRos1YKjWBu5gGh+Bzcrur
         hZur17dRI/N+uZ4Ec57jM+7ismMC7tRZGZpOnb0Z1iEumA7xHJz1iVzGX2zo6vpFn7+q
         bERoQop0OhMyYofymuEpzD5ukOrYl8fu6cYgv1EulQU/x5gyrDjl9DmpTWTecZHX0GEV
         dQzbWHRzXFkVGd8u87k+KBD7bXCpb522JxobHD9xFitAIZ6BzovgqFlfJXOFhwrxsycm
         rEkg==
X-Forwarded-Encrypted: i=1; AJvYcCXHjYEwRwYW5DB9HRxmwPOgh8DYuEy49dsIO4mWETytXuJdfrgyHY7kYUVxiYeQwvybtGTke1vXBCLRn1pOEg==@groups.io
X-Gm-Message-State: AOJu0YxAEFzS094/VA7TqQOQTsdC1p/RMh6P/i8HnRHJb42WfpqJxtw2
	O0/DQOsMvpnzW/KAKqz6JqaU6aoqqDDKGFUJo5DPa8hXmGRqGK9ZzToubdgcCSNckMM=
X-Gm-Gg: AeBDieugezQ1fNIcZRyWX4N1P8R67eoSXlubkJ461gmUtkGKQBJQJK8XVReow1Z3SGt
	U3+gFJnYJVk13Cu1WOz/6XI7TjHy82AKEoTvElKnDKWE9N3xpHZhilkmybR3wDDNqownesBsM9K
	OwvBDwUKgUmCwk87aEfpKV3JZlb6TaPbvP2q6kDiIUDPtrfsWit7LnbMq140G6NOTwB8TuRWsSV
	HvL8OLVPQ5I1c8taZXNt/O5K92jjqK6SKdxcQoeVKIlna12XfIsLLbBa0GQPc1GqN+Nx0yYqMVA
	83rBdDMyiNavj1TudvF95hxrymSMzQ4hSP+OomX0MKG/E28xSO59FVhOfjr1wWxOUFDd+279pJx
	e8TdG7iOcU7mAgpNnVCVbn1DnxG1axfWKY7K/W3DEJrK+FrIkoWLPzbToESUgsl5ZHh/RyI53fZ
	YVePCH/waGCz9g5vLPo6QrOio/PaGciyYhpeyKMYA81mqmTYkO9zxh8pk9jSL043fSbVFPQxwry
	CVrito=
X-Received: by 2002:a05:600c:a47:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48899781357mr356705255e9.19.1775721646839;
        Thu, 09 Apr 2026 01:00:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:70d5:8219:5bd4:e213? ([2a01:e0a:106d:1080:70d5:8219:5bd4:e213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm58880667f8f.9.2026.04.09.01.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:00:46 -0700 (PDT)
Message-ID: <3ecb2179-64e6-4937-9c43-11caaa03a1b0@linaro.org>
Date: Thu, 9 Apr 2026 10:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] arm: mach-meson: move reset_cpu to spl only
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <20260408-b4-amlogic-sysreset-capsules-v1-1-6f3386eb5124@postmarketos.org>
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
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-1-6f3386eb5124@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Apr 2026 08:00:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2957

On 4/8/26 22:30, Ferass El Hafidi wrote:
> This is in preparation of enabling SYSRESET across all Amlogic boards by
> default. SYSRESET brings its own reset_cpu implementation which will
> conflict with the one defined in board-common.c. SPL however will not
> have SYSRESET enabled (due to overhead in the final image, as we have
> very little space to work with), and thus will still need that reset_cpu
> to be defined, so move it to spl.c so it is only built for SPL.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/mach-meson/board-common.c | 14 --------------
>   arch/arm/mach-meson/spl.c          | 10 ++++++++++
>   2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index a5afc2d75c0..24dcafd30ac 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -154,17 +154,3 @@ int board_late_init(void)
>   
>   	return meson_board_late_init();
>   }
> -
> -void reset_cpu(void)
> -{
> -#if CONFIG_SPL_BUILD
> -	/*
> -	 * We do not have BL31 running yet, so no PSCI.
> -	 * Instead, let the watchdog reset the board.
> -	 */
> -	for (;;)
> -		;
> -#else
> -	psci_system_reset();
> -#endif
> -}
> diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
> index 28a63f39d36..ec566849667 100644
> --- a/arch/arm/mach-meson/spl.c
> +++ b/arch/arm/mach-meson/spl.c
> @@ -121,3 +121,13 @@ void board_init_f(ulong dummy)
>   	clrbits_32(GX_WDT_CTRL_REG, (1 << 18) | (1 << 25));
>   #endif
>   }
> +
> +void reset_cpu(void)
> +{
> +	/*
> +	 * We do not have BL31 running yet, so no PSCI.
> +	 * Instead, let the watchdog reset the board.
> +	 */
> +	for (;;)
> +		;
> +}
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

