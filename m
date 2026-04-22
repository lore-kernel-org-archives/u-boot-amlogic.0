Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447BFA1FD5
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 16:26:43 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.86863.1776875196566399149
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 09:26:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=WjLDcqgj;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4890098abbaso40877345e9.0
        for <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776875195; x=1777479995; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuCeYogGpkN/LhhedCGAUq7c/dseD6cXD/qn9VdqF2U=;
        b=WjLDcqgjcB2X+7qkj7ZIEC6pkeB7SXn1+NBa5jTtQ73VuGENzlLPzhZYRMJEXCYL2b
         /1PQMYra7ql1hZVyMz7My7Wge+NIndHGj8jAqtu9Rr//qxj8RVsEsr8Uzh68xXsvMowb
         smJNuCCQIsyrby2pHCiZ66C9AUi9ZbWcvPAQN9MFO0temRl8WDv4JslMxi4uFOROITbI
         tNmas5H9qapYqx8+qo5waOPGqukkF+9+R8K3I5Y6f4pryv3OSiB/MkBqNXgf2Upl/NZU
         R2b1zE7qvzK2MK+ryl7+3n+MiXo4not3+Xh/FBYTfYPH3Wx9TP9mlab3ENmqwmQOjYEL
         8zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875195; x=1777479995;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuCeYogGpkN/LhhedCGAUq7c/dseD6cXD/qn9VdqF2U=;
        b=fdtUA0u2Mu6RxB9tCIfzOFPpt5d7zxWG51RyUyqDILNQjAF9f4fXLo/djROoBZN/AA
         y8Rdoq2f3C7vgFX1org46xmfE/txh2IK+a25M0vsJ3aATA4o5k2RWrTUaWN8JK7dtxEv
         jvFArhmiHFJ8oe/c1UnCMwcV7wJhbDBdFNBUkZtuynNGjQYlVi2olIl8SwJUAUHJUalO
         ULXFaBgHnvY0JGFdmVxWr+i76MA3rrzLJ34Plp1QCd4mAn+iKxSaTPxJ9OkPRlJPpG0Z
         OF6rQHXMThz7xYL4nc9WHkHt/8t7HIEm91u0N1B2Bp8zLDYdXcmS1sTMSWcoMBzErhMV
         udpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KMKOkXCOO4BSKptuzHmJ1l3aUsooZ42TfQ2tlgkh22F11GQXxvcqgBib11BGwZ9Ht3KiMxOJX4bPzRBU+KA==@groups.io
X-Gm-Message-State: AOJu0YwfJwf2eZcZ0C/JtFC5Dxk9N069gFwLz5vqQn2ioNIjyWuXOJ5k
	W2LAjXvC4+u5p0BRZFUngdu/yf0/W+NUTCudz9tljMT78lR55pCeRi6CeCOy8iBGLgfovJLjNPw
	f44olBAQ=
X-Gm-Gg: AeBDietH6F8DfPw1JmrwEXYZprsmbrLMjscvErtL8GxWTXDQ9+C4bcgcFsGWeSxwSDn
	UkvOcu/ZMAQPSCWGk3S6Lqf3303fPjps9ow9afQu9cETkYeiuxbxx33kAFLHsf7r4pUZMFtolba
	wfUjhIy3jtoY22S5lwYvHUVlfxS7bx/s0lTBAGz64+l5Bv+Y5R60glZmgPZ5qD9Tml6VW3ECmka
	mfadDSJbz8QxOdkwOf+oMsmsokbm7WRQsL5v1Mdjotub8Kd7UiW0Tzh+GNUEdJ9mcti3BZH4zo1
	kxYzQZYvL0Vx18xwidcAKdcLnaTNW18jXo7JkWtVKKKJkkp3YfkjudOs+9Q2Ypwt3SZ8pNLCiiL
	z7bUEzX10nFtwaMDj2vJL4iR+kIzirRdVOn5cZ99Bm9lMF8v3dy2OTB/1Gi5nIoqvhOZkzHuqrU
	ifq+dGJDSNhUHjipT+ATztlRV3hwaCAWU1DJ5lFRFUuzV4ldTBOv+O+3ApVyYct71TuezlEJMSp
	4YYo7WHQiIHnU0qrQ==
X-Received: by 2002:a05:600c:444a:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-488fb793580mr307763075e9.31.1776875194750;
        Wed, 22 Apr 2026 09:26:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:7d92:9cde:4eb2:46d7? ([2a01:e0a:106d:1080:7d92:9cde:4eb2:46d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5d27d6casm4330665e9.27.2026.04.22.09.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 09:26:34 -0700 (PDT)
Message-ID: <48d4b6e1-b150-42cb-9949-d99a08fcdbcf@linaro.org>
Date: Wed, 22 Apr 2026 18:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 1/4] arm: mach-meson: provide reset_cpu only when
 SYSRESET is disabled
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
 <20260422-b4-amlogic-sysreset-capsules-v3-1-07b5ccc8f552@postmarketos.org>
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
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-1-07b5ccc8f552@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 16:26:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2979

On 4/22/26 17:43, Ferass El Hafidi wrote:
> This is in preparation of enabling SYSRESET across all Amlogic boards by
> default. SYSRESET brings its own reset_cpu implementation which will
> conflict with the one defined in board-common.c.
> SPL however will not have SYSRESET enabled (due to overhead in the final
> image, as we have very little space to work with), and thus will still
> need that reset_cpu to be defined. Furthermore, some boards do not enable
> PSCI support in U-Boot, so they may still need this implementation.
> Guard reset_cpu inside #ifdef to only compile it in when SYSRESET is not
> enabled.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/mach-meson/board-common.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index a5afc2d75c0..c34b81e5e78 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -155,16 +155,14 @@ int board_late_init(void)
>   	return meson_board_late_init();
>   }
>   
> +#if defined(CONFIG_XPL) || !CONFIG_IS_ENABLED(SYSRESET)
>   void reset_cpu(void)
>   {
> -#if CONFIG_SPL_BUILD
>   	/*
>   	 * We do not have BL31 running yet, so no PSCI.
>   	 * Instead, let the watchdog reset the board.
>   	 */
>   	for (;;)
>   		;
> -#else
> -	psci_system_reset();
> -#endif
>   }
> +#endif
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

