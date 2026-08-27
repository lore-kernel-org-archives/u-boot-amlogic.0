Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CE4C61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 15:39:26 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.204.1787845157819209812
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 08:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=XB0SP/TA;
 spf=pass (domain: linaro.org, ip: 209.85.221.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4815bce4652so1536882f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787845156; x=1788449956; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/TDoCOeFu8rQWONGBSXDbZ2SYevidE23LIBWf3k3ts=;
        b=XB0SP/TA/yd6Ieo+HNR6GivLOf8bWCjN6MU6WzljtDTq4kygJB8dpTaCN+8xyL8Wm0
         cdUngvzoNbrXEZ+MAvDECbzFsX1t0pKIYgcCjWUHxHRUhuSUZo2CR9bsSQS09f9dnD++
         Xea+1AVW/3m07pKisKZ0ihcH2F8hCyw6W3dLXYrnHhh43lgMB1OrKDMBgY22n/5WngKU
         Ia2W6fFeIR0/BRke9PMTNVQYiKaUl6Laar239VZrgyvImKFq5ov7sTjKp0kOM2Dbkfn8
         yp4JWV7k4LD0f4pxadkF42e1iZ4zuCbuul/y99IKAnnSPSDLv/P+xjwLTdOfzJbxo9Qz
         88Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845156; x=1788449956;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/TDoCOeFu8rQWONGBSXDbZ2SYevidE23LIBWf3k3ts=;
        b=rs/ieFdAc6gL68mXBwJHlQn5+4fHkIdNiPE2tYLnMmGCPidCXJcbjpJXT3VLjpxu0Y
         EGSsccknEcpkVt/fmduKTc89yWAJIttw6hFJYZ5ycGrM0P2BUEuXfDViE51MJji0fH6Q
         imxvGPTAx99+6KPz+ESwVmAkpPe+FFWLCGrLCNh0Krs/W+yDANyXuxsX3u2XUELoZksN
         JcRqn6YC1EQjbecHTfJ/MQU5c2iXBf6WZ8S7D5U+pLLsoaCOTNs/PTxa6eBzIrxJ2Wv1
         BTXdUuOFZKGXMCZLkbQU2WRc9MNvlSGy8hNKHTaLm0NZ073PykCTS8uhwK484mTbOl3h
         CCUA==
X-Gm-Message-State: AFuF++nTIv2v1ENi3lfwgBzwDT/g9NIgKWBCy8rURibfX71rVj0rsTxH
	clfw+9Yh34fxYk2ssIgT3lwzJfwn0SiGSVQZ2RvLKdfuTNX6Z404fY0bxxYf+JwX5yut27GnRFS
	41C0cU24=
X-Gm-Gg: AR+sD12o0WPs1Be0d7nJhM81yD6G8yknuCUKLYbkO8MVg2rO+jnuQW6gK8kNYdu+r1S
	iWYclGDYhASVpkomwF0hr0AJiKOhglNuQ+p8wzO9sMhQncgF/Drdm2K5L+baruLdsXWqd9AJRwi
	wRwSFUw5oVFy4/UN2k7PPEO0v4+Spy0POcDiMQdjQOOAfzyvLPpR4E/Ft2HC7UL7bDa65k8BpQX
	3Pav1s2KWRkjjJl7aHwPbs9S+0ykAerMvQB7E3HGFP0guzEFpqdBD3IWuweZd57v3aLG/fpcugv
	VzrStHdvNifyc5WTv+mezOLLJ5GTOrv8MceQU12TGvERyTSRKhShjetnjXGkhtN9VD+bakDUfml
	ZlmQTcMaVj0ACA/AS78VO9MW4D8ah8sC1KTF8eDc6BZP6bUyFlG/nr6qjFrW6n5vr9XVTmISV7b
	LMdrLu7v/VxOF2ganLsRDeJOdgh2fviYQDZS4JUi+CXz2swDGWhkSTktmF/cIzbn1ang588+pSw
	3+RwDTgJPQNd0O3hiDhvAz5iSuHF/jSqoIeT5orXFKY2Si8eYW9eciD
X-Received: by 2002:adf:e004:0:20b0:47f:9662:85fe with SMTP id ffacd0b85a97d-482e26c3996mr16833784f8f.16.1787845155963;
        Thu, 27 Aug 2026 08:39:15 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18? ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dbe1dsm10542093f8f.22.2026.08.27.08.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:39:15 -0700 (PDT)
Message-ID: <7c0d0fef-08d5-4898-a18d-1880847d1356@linaro.org>
Date: Thu, 27 Aug 2026 17:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 6/9] clk: meson: Support fractional fixed-factor clocks
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-7-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-7-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 15:39:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3078

On 8/17/26 19:15, Sean Anderson wrote:
> One of the s4 clocks has a non-integer divisor (2.5). Add support for
> this.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/clk_meson.c |  3 ++-
>   drivers/clk/meson/clk_meson.h | 12 +++++++++---
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
> index de5aa5ae3c9..29615fdae77 100644
> --- a/drivers/clk/meson/clk_meson.c
> +++ b/drivers/clk/meson/clk_meson.c
> @@ -153,7 +153,8 @@ ulong meson_clk_get_rate(struct clk *clk)
>   	case MESON_CLK_FIXED_DIV:
>   		parent.dev = clk->dev;
>   		parent.id = meson_clk_get_parent(clk);
> -		return meson_clk_get_rate(&parent) / info->div;
> +		return mult_frac(meson_clk_get_rate(&parent), info->mult,
> +				 info->div);
>   	case MESON_CLK_EXTERNAL: {
>   		int ret;
>   		struct clk external_clk;
> diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
> index 990e9434126..86b272985ab 100644
> --- a/drivers/clk/meson/clk_meson.h
> +++ b/drivers/clk/meson/clk_meson.h
> @@ -61,7 +61,7 @@ struct meson_clk {
>    * @MESON_CLK_GATE: This clock is a gate
>    * @MESON_CLK_MUX: This clock is a multiplexer
>    * @MESON_CLK_DIV: This clock is a configurable divider
> - * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
> + * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
>    * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
>    * @MESON_CLK_PLL: This is a PLL
>    */
> @@ -87,7 +87,10 @@ struct meson_clk_info {
>   	const char *name;
>   	union {
>   		const struct parm *parm;
> -		u8 div;
> +		struct {
> +			u8 mult;
> +			u8 div;
> +		};
>   	};
>   	const unsigned int *parents;
>   	const enum meson_clk_type type;
> @@ -133,13 +136,16 @@ struct meson_clk_data {
>   	})
>   
>   /* A fixed divider */
> -#define CLK_DIV_FIXED(_name, _div, _parent)				\
> +#define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
>   	(&(struct meson_clk_info){					\
>   		.parents = (const unsigned int[]) { (_parent) },	\
> +		.mult = (_mult),					\
>   		.div = (_div),						\
>   		.name = (_name),					\
>   		.type = MESON_CLK_FIXED_DIV,				\
>   	})
> +#define CLK_DIV_FIXED(name, div, parent)				\
> +	CLK_DIV_FIXED_FULL(name, 1, div, parent)
>   
>   /* An external clock */
>   #define CLK_EXTERNAL(_name)						\

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

