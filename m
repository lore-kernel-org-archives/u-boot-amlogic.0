Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCD2C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 15:40:06 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.229.1787845205673191968
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 08:40:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=GiXjtQ5t;
 spf=pass (domain: linaro.org, ip: 209.85.221.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so492443f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787845204; x=1788450004; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3eppP1bAeYI3er5PDG2w5xyWhTejhPpjnaoonlP92w=;
        b=GiXjtQ5tkEfGif7uiqpasJKE+Zw9ZzPInWz91A055zvuSPGboKDEbew5k/J1/xWQct
         5nw6EIr0n7GqYVMGFHWJM8OCwNhohqhKJAbgSK1fFlHZm+WNYrd0crjdTtpG6hsL0xXc
         tU+GLTQVkChFomGNDxjgjHREF3BaQyh6PMzHxBrODVcuhNThB/5omfdYGt8kI+MWSODg
         9w+D1u2tS1ufVWRL1WNjlRGElNogO55pwvYU6s9r8ADcjwoLIYQT/HZBQk51kqCJ963N
         HUQAP1Ua4Yc4ExPZCBxUk2mqfzguwQx2nm0mu/NpWxwLFYWeoQc/srn+a5P5KEEBMLFZ
         61gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845204; x=1788450004;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V3eppP1bAeYI3er5PDG2w5xyWhTejhPpjnaoonlP92w=;
        b=co4vp2gdTL479nd83FxEBFIetY8SV4Eim2SDEsfXYhzJ0UBD/n7hayO1WS0k3v95vu
         QabZbm6eFMJXyLdRlo7yaOG10dgkrz4syNwkFaqfyTgstOS2hTCv42IEmQWRxp38EiHp
         s7qdZECwOq+2NfRkCHqedXmDYxwGJfmjjLWxmpArGaLcHb17rGA/nJPRU6HUs2GtjIJB
         IWhGNnXBQn8J30pnE0ev2L7ZvpenWo5Yv68uoaKTEjIZINNIJ7zsUD0fQuG0la/kd/Nw
         MYKs/FoT18jeDW0goY3/DC4m2qjWrLnQWx+rTn04pe+vJNp3nl7uf55Da5jWMdEfasMy
         kcow==
X-Gm-Message-State: AFuF++mbef+3eKco/vVHJthW5QvuLU5P3SKNFSJy7ok6dJgLsHI71vTy
	3x3Yl62Mk4lZ+lqRwDRAPHgtVgp3TNdyfkZQFwne+HlNoijQFqMo1h1cKMxNkuoBdcU=
X-Gm-Gg: AR+sD11u0PJkpL7OQ+9CEmrhLQecMFIn8VUIwkvm6h+N7dnWzcDOCwSYw8m+tEqOp9u
	Ck9wqe1k8jHtcX0rSMciuKaCK5MifFyRyUj7jjUDZx8fFx3uTkIc1eCaD3AAYaSErSaAgIirsvW
	Suk/kctXWc/W/Us9WYZhlXDthU2q2yvdApwsdnNdJ+KDrpBs9LhC/s7MoqLbSzQeHDV5JZk46c7
	7Rs/8FW81r/QW21fTNsk0pSr+0P3lEsmFL50zal9aiyksOuP3LMBsXV2Ul84hXTKkKB8Zb9MFIq
	4L6fqZ56Dyg8hgTxHbbR2dVk7KK7hAQqvMxSgOdDf818cDYgraIYVJj3Ub1zKGLZBwoc3NZz3Bj
	0g6chY2dQKNkK7YPTC0Sy6dNkLbsk3og7FvEL4bXvvpVooPD2vZgGnUw9EA690iBMzqNIUCnwCE
	6DB3d95ToxJvAN2GeWOpcOCq6iiz5n86f/8MlVPQ3s5Pcj2bdp3JKx57FpRu30TAFaiv+rZ4hIq
	F3KYyOm/UcMZ32F2XuCzy4mcZWzQ2MyvwMsyZtEn0+I9g==
X-Received: by 2002:a5d:64e9:0:b0:482:ea47:4484 with SMTP id ffacd0b85a97d-482ea4744b7mr14726624f8f.8.1787845203799;
        Thu, 27 Aug 2026 08:40:03 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18? ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dbe1dsm10542093f8f.22.2026.08.27.08.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:40:03 -0700 (PDT)
Message-ID: <0b21b9f3-bffd-4051-8c88-49dce2c8a86e@linaro.org>
Date: Thu, 27 Aug 2026 17:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 7/9] clk: meson: Support power-of-two dividers
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-8-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-8-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 15:40:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3079

On 8/17/26 19:15, Sean Anderson wrote:
> Several s4 clocks use power-of-two dividers. Add support for them.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/clk_meson.c | 49 ++++++++++++++++++++++++++---------
>   drivers/clk/meson/clk_meson.h | 44 +++++++++++++++----------------
>   2 files changed, 59 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
> index 29615fdae77..50c72276457 100644
> --- a/drivers/clk/meson/clk_meson.c
> +++ b/drivers/clk/meson/clk_meson.c
> @@ -55,26 +55,49 @@ int meson_clk_disable(struct clk *clk)
>   	return meson_set_gate(clk, false);
>   }
>   
> +static ulong meson_div_get_rate_common(struct clk *clk,
> +				       enum meson_clk_type type, u16 *n,
> +				       ulong *rate)
> +{
> +	struct meson_clk *priv = dev_get_priv(clk->dev);
> +	const struct meson_clk_info *info;
> +	struct clk parent;
> +
> +	info = meson_clk_get_info(clk, type);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	*n = GET_PARM_VALUE(priv, info->parm);
> +
> +	parent.dev = clk->dev;
> +	parent.id = info->parents[0];
> +	*rate = meson_clk_get_rate(&parent);
> +	return 0;
> +}
> +
>   static ulong meson_div_get_rate(struct clk *clk)
>   {
> -	struct meson_clk *priv = dev_get_priv(clk->dev);
> +	ulong rate, err;
>   	u16 n;
> -	ulong rate;
> -	const struct meson_clk_info *info;
> -	struct clk parent;
>   
> -	info = meson_clk_get_info(clk, MESON_CLK_DIV);
> -	if (IS_ERR(info))
> -		return PTR_ERR(info);
> +	err = meson_div_get_rate_common(clk, MESON_CLK_DIV, &n, &rate);
> +	if (err)
> +		return err;
>   
>   	/* Actual divider value is (field value + 1), hence the increment */
> -	n = GET_PARM_VALUE(priv, info->parm) + 1;
> +	return rate / (n + 1);
> +}
>   
> -	parent.dev = clk->dev;
> -	parent.id = info->parents[0];
> -	rate = meson_clk_get_rate(&parent);
> +static ulong meson_div2_get_rate(struct clk *clk)
> +{
> +	ulong rate, err;
> +	u16 n;
>   
> -	return rate / n;
> +	err = meson_div_get_rate_common(clk, MESON_CLK_DIV2, &n, &rate);
> +	if (err)
> +		return err;
> +
> +	return rate >> n;
>   }
>   
>   int meson_clk_get_parent(struct clk *clk)
> @@ -150,6 +173,8 @@ ulong meson_clk_get_rate(struct clk *clk)
>   		return meson_clk_get_rate(&parent);
>   	case MESON_CLK_DIV:
>   		return meson_div_get_rate(clk);
> +	case MESON_CLK_DIV2:
> +		return meson_div2_get_rate(clk);
>   	case MESON_CLK_FIXED_DIV:
>   		parent.dev = clk->dev;
>   		parent.id = meson_clk_get_parent(clk);
> diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
> index 86b272985ab..46ee5519410 100644
> --- a/drivers/clk/meson/clk_meson.h
> +++ b/drivers/clk/meson/clk_meson.h
> @@ -61,6 +61,7 @@ struct meson_clk {
>    * @MESON_CLK_GATE: This clock is a gate
>    * @MESON_CLK_MUX: This clock is a multiplexer
>    * @MESON_CLK_DIV: This clock is a configurable divider
> + * @MESON_CLK_DIV2: This clock is a configurable power-of-two divider
>    * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
>    * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
>    * @MESON_CLK_PLL: This is a PLL
> @@ -70,6 +71,7 @@ enum meson_clk_type {
>   	MESON_CLK_GATE,
>   	MESON_CLK_MUX,
>   	MESON_CLK_DIV,
> +	MESON_CLK_DIV2,
>   	MESON_CLK_FIXED_DIV,
>   	MESON_CLK_EXTERNAL,
>   	MESON_CLK_PLL,
> @@ -122,18 +124,25 @@ struct meson_clk_data {
>   		.type = MESON_CLK_MUX,					\
>   	})
>   
> +#define _CLK_REG(_type, _name, _reg, _shift, _width, _parent)		\
> +	(&(struct meson_clk_info){					\
> +		.parents = (const unsigned int[]) { (_parent) },	\
> +		.parm = &(struct parm) {				\
> +			.reg_off = (_reg),				\
> +			.shift = (_shift),				\
> +			.width = (_width),				\
> +		},							\
> +		.name = (_name),					\
> +		.type = _type,						\
> +	})
> +
>   /* A divider with an integral divisor */
> -#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
> -	(&(struct meson_clk_info){					\
> -		.parents = (const unsigned int[]) { (_parent) },	\
> -		.parm = &(struct parm) {				\
> -			.reg_off = (_reg),				\
> -			.shift = (_shift),				\
> -			.width = (_width),				\
> -		},							\
> -		.name = (_name),					\
> -		.type = MESON_CLK_DIV,					\
> -	})
> +#define CLK_DIV(name, reg, shift, width, parent)			\
> +	_CLK_REG(MESON_CLK_DIV, name, reg, shift, width, parent)
> +
> +/* A divider with a power-of-two divisor */
> +#define CLK_DIV2(name, reg, shift, width, parent)			\
> +	_CLK_REG(MESON_CLK_DIV2, name, reg, shift, width, parent)
>   
>   /* A fixed divider */
>   #define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
> @@ -156,17 +165,8 @@ struct meson_clk_data {
>   	})
>   
>   /* A clock gate */
> -#define CLK_GATE(_name, _reg, _shift, _parent)				\
> -	(&(struct meson_clk_info){					\
> -		.parents = (const unsigned int[]) { (_parent) },	\
> -		.parm = &(struct parm) {				\
> -			.reg_off = (_reg),				\
> -			.shift = (_shift),				\
> -			.width = 1,					\
> -		},							\
> -		.name = (_name),					\
> -		.type = MESON_CLK_GATE,					\
> -	})
> +#define CLK_GATE(name, reg, shift, parent)				\
> +	_CLK_REG(MESON_CLK_GATE, name, reg, shift, 1, parent)
>   
>   /* A PLL clock */
>   #define CLK_PLL(_name, _parent, ...)					\

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

