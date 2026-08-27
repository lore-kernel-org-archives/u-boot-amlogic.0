Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2E6C61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 15:37:36 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.167.1787845052412680554
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 08:37:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=oPrr7dVY;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4815bce4652so1535022f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787845051; x=1788449851; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3dtr/8nC4AcZhZInDBZ2D54svj1H71wrRTX4RSWe/0=;
        b=oPrr7dVYZEwdbm8RYXvN04maSK8oPzJkUbNuDmbH1jAl+CbA5sxkSrSQMiKn/yviI2
         5T+R8ReJhWDtv2KFlaKmGTN6HHZRrdoAAPm04Wafqr51b67dUzLLJB/iuqqArxKEQJ+K
         gKW/fCp64zXAZt4soCqR4SxlGuno+c7zjVfSuq0jwtsrbKMKzY3EfOgLDiaA+AGqNCtA
         fzeKWPk57LjbP/3nXyoQSj9+9pp1wCkWWnTxKPhwNhAkzrMAXMe/Ir4fVdSRmgrWBuke
         9jt6iqjEcTKo45FVmkf3pWf02RyKwio56XHX5ZsYsdhffn9cnDj4id284B2cKabWXIPF
         Ia1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845051; x=1788449851;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V3dtr/8nC4AcZhZInDBZ2D54svj1H71wrRTX4RSWe/0=;
        b=MrVIcW6mfGXAbkc1wXcNjb9ecZPvBXlJ5lxtvp/k7mgyvI//CT/GEGo0CuViaPi0x4
         rd9uwx6K6hW7eymaBKSxB1ymeD8R5osxCSpd/kOiz7hFsRHDX0Me6IrKf2PkKyIMZJPV
         /LQT+Gk5gzBk81wQ3df9286/RVX8t08If+oHGolMo3wBYOEwiwNr3COdGx/0XR/2RVcG
         MkdqxOt4QnDv2Ngzpya9GrHTF3SbhQ28wqcR+/MOby2wvnILBCxvSBFBbsI2fOvDpVi4
         v71BZ+O34IAqe+YalQO1XC1XpcpU20AnbIeHluBmgh0kibazXTcTNTLMrdV8FqDhnqhX
         d5Lw==
X-Gm-Message-State: AFuF++lzBAOrlQKEuuX0VvXg0aclvmAi3+cpScVepUu0I3o/xfHK1ds5
	kDE7OBzYhTUXp2CPMZawxa5+hkrKnQvs4aho1P5qwMRUPhr+2GOX5X/3G3Fx1UQzowU=
X-Gm-Gg: AR+sD13QWnYptFtvL5K3HBXqM/LGZNGnJ3db16OvijGhUL1+MNURWjjzruI6T7ebnRO
	eV22yyYi5tBV4QQ9a1kjFqaV5OTHRqWQdBO+q0tSVe2uNdUgrlB+5+dRca68qsLLN/ue82BZMkZ
	E8fwSg48ydTwokCzBRVZvi/0g9RB+3Q/tGkc+D99QFK2fXpKMWPg6AdPuLxP7T7hG5vTkeaShor
	Lr8xGyKUq8VhEPe8usjVoNBWB07Y/Twp20nz0o0W9qmj2zg2LMAzv+MZ1rYBXLmHLCs8hzzh9W/
	QtDnMRVoIfJ6oy6EGzbmFsTExznnjp4pTr72kstPCgrlExtal0ite720aHbT81WmpQvbxekA6eO
	4uMRkpBaQQLY9NYEPV8uJtI9vWKJsth2KeBUEWllxTqmkPNjhr1nAmLRkVQVCpHAX5imTYaFe5f
	Vfi98hFMrQ4L0fdf+R1wQrUhOuK8TQ5djtymMgdINOT9slGreQ3IvAoURPnWX5ZxIY3C4pBenWK
	UqEKcdcSidVkaoIXGxJoqqtHxKV36xAXYafRpXDcXAwBw==
X-Received: by 2002:a05:6000:46c8:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-482e26add2amr18268966f8f.11.1787845050395;
        Thu, 27 Aug 2026 08:37:30 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18? ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e4f0c8f7sm9739333f8f.27.2026.08.27.08.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:37:30 -0700 (PDT)
Message-ID: <78a4acdf-ed5e-4f0f-a9f6-3139ff599f85@linaro.org>
Date: Thu, 27 Aug 2026 17:37:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/9] clk: meson: a1: Eliminate separate id parameter
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-3-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-3-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 15:37:36 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3074

On 8/17/26 19:15, Sean Anderson wrote:
> Instead of passing a struct clk (containing the device and an unrelated
> id) and a separate id parameter to most functions, just pass a single
> struct clk with the correct id. This is in preparation for converting
> some instances of meson_clk_* functions to clk_* functions to allow for
> greater extensibility.
> 
> In general, this transformation requires constructing a synthetic
> struct clk wherever we used to call a function with an id different from
> clk->id. We don't bother to call clk_request since we don't implement it
> ourselves.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/a1.c | 150 ++++++++++++++++++++---------------------
>   1 file changed, 74 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 669247a9a09..d0376663069 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -302,17 +302,16 @@ static const struct meson_clk_info *meson_pll_clocks[] = {
>   	),
>   };
>   
> -static const struct meson_clk_info *meson_clk_get_info(struct clk *clk, ulong id,
> +static const struct meson_clk_info *meson_clk_get_info(struct clk *clk,
>   						       enum meson_clk_type type)
>   {
> -	struct meson_clk_data *data;
> +	struct meson_clk_data *data = (void *)dev_get_driver_data(clk->dev);
>   	const struct meson_clk_info *info;
>   
> -	data = (struct meson_clk_data *)dev_get_driver_data(clk->dev);
> -	if (id >= data->num_clocks)
> +	if (clk->id >= data->num_clocks)
>   		return ERR_PTR(-EINVAL);
>   
> -	info = data->clocks[id];
> +	info = data->clocks[clk->id];
>   	if (!info)
>   		return ERR_PTR(-ENOENT);
>   
> @@ -322,7 +321,7 @@ static const struct meson_clk_info *meson_clk_get_info(struct clk *clk, ulong id
>   	return info;
>   }
>   
> -static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
> +static ulong meson_clk_get_rate(struct clk *clk);
>   
>   static int meson_set_gate(struct clk *clk, bool on)
>   {
> @@ -331,7 +330,7 @@ static int meson_set_gate(struct clk *clk, bool on)
>   
>   	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
>   
> -	info = meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
> +	info = meson_clk_get_info(clk, MESON_CLK_ANY);
>   	if (IS_ERR(info))
>   		return PTR_ERR(info);
>   
> @@ -350,32 +349,35 @@ static int meson_clk_disable(struct clk *clk)
>   	return meson_set_gate(clk, false);
>   }
>   
> -static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
> +static ulong meson_div_get_rate(struct clk *clk)
>   {
>   	struct meson_clk *priv = dev_get_priv(clk->dev);
>   	u16 n;
>   	ulong rate;
>   	const struct meson_clk_info *info;
> +	struct clk parent;
>   
> -	info = meson_clk_get_info(clk, id, MESON_CLK_DIV);
> +	info = meson_clk_get_info(clk, MESON_CLK_DIV);
>   	if (IS_ERR(info))
>   		return PTR_ERR(info);
>   
>   	/* Actual divider value is (field value + 1), hence the increment */
>   	n = GET_PARM_VALUE(priv, info->parm) + 1;
>   
> -	rate = meson_clk_get_rate_by_id(clk, info->parents[0]);
> +	parent.dev = clk->dev;
> +	parent.id = info->parents[0];
> +	rate = meson_clk_get_rate(&parent);
>   
>   	return rate / n;
>   }
>   
> -static int meson_clk_get_parent(struct clk *clk, unsigned long id)
> +static int meson_clk_get_parent(struct clk *clk)
>   {
>   	uint reg = 0;
>   	struct meson_clk *priv = dev_get_priv(clk->dev);
>   	const struct meson_clk_info *info;
>   
> -	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
> +	info = meson_clk_get_info(clk, MESON_CLK_ANY);
>   	if (IS_ERR(info))
>   		return PTR_ERR(info);
>   
> @@ -391,16 +393,16 @@ static int meson_clk_get_parent(struct clk *clk, unsigned long id)
>   	return info->parents[reg];
>   }
>   
> -static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
> +static ulong meson_pll_get_rate(struct clk *clk)
>   {
>   	struct meson_clk *priv = dev_get_priv(clk->dev);
>   	const struct meson_clk_info *info;
>   	const struct parm *pm, *pn;
>   	ulong parent_rate_mhz;
> -	unsigned int parent;
> +	struct clk parent;
>   	u16 n, m;
>   
> -	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
> +	info = meson_clk_get_info(clk, MESON_CLK_ANY);
>   	if (IS_ERR(info))
>   		return PTR_ERR(info);
>   
> @@ -413,40 +415,39 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
>   	if (n == 0)
>   		return -EINVAL;
>   
> -	parent = info->parents[0];
> -	parent_rate_mhz = meson_clk_get_rate_by_id(clk, parent) / 1000000;
> +	parent.dev = clk->dev;
> +	parent.id = info->parents[0];
> +	parent_rate_mhz = meson_clk_get_rate(&parent) / 1000000;
>   
>   	return parent_rate_mhz * m / n * 1000000;
>   }
>   
> -static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
> +static ulong meson_clk_get_rate(struct clk *clk)
>   {
> -	ulong rate, parent;
> +	struct clk parent;
>   	const struct meson_clk_info *info;
>   
> -	if (IS_ERR_VALUE(id))
> -		return id;
> +	if (IS_ERR_VALUE(clk->id))
> +		return clk->id;
>   
> -	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
> +	info = meson_clk_get_info(clk, MESON_CLK_ANY);
>   	if (IS_ERR(info))
>   		return PTR_ERR(info);
>   
>   	switch (info->type) {
>   	case MESON_CLK_PLL:
> -		rate = meson_pll_get_rate(clk, id);
> -		break;
> +		return meson_pll_get_rate(clk);
>   	case MESON_CLK_GATE:
>   	case MESON_CLK_MUX:
> -		parent = meson_clk_get_parent(clk, id);
> -		rate = meson_clk_get_rate_by_id(clk, parent);
> -		break;
> +		parent.dev = clk->dev;
> +		parent.id = meson_clk_get_parent(clk);
> +		return meson_clk_get_rate(&parent);
>   	case MESON_CLK_DIV:
> -		rate = meson_div_get_rate(clk, id);
> -		break;
> +		return meson_div_get_rate(clk);
>   	case MESON_CLK_FIXED_DIV:
> -		parent = meson_clk_get_parent(clk, id);
> -		rate = meson_clk_get_rate_by_id(clk, parent) / info->div;
> -		break;
> +		parent.dev = clk->dev;
> +		parent.id = meson_clk_get_parent(clk);
> +		return meson_clk_get_rate(&parent) / info->div;
>   	case MESON_CLK_EXTERNAL: {
>   		int ret;
>   		struct clk external_clk;
> @@ -455,20 +456,11 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
>   		if (ret)
>   			return ret;
>   
> -		rate = clk_get_rate(&external_clk);
> -		break;
> +		return clk_get_rate(&external_clk);
>   	}
>   	default:
> -		rate = -EINVAL;
> -		break;
> +		return -EINVAL;
>   	}
> -
> -	return rate;
> -}
> -
> -static ulong meson_clk_get_rate(struct clk *clk)
> -{
> -	return meson_clk_get_rate_by_id(clk, clk->id);
>   }
>   
>   /* This implements rate propagation for dividers placed after multiplexer:
> @@ -476,19 +468,22 @@ static ulong meson_clk_get_rate(struct clk *clk)
>    *     ..... | |---DIV--
>    *  ---------|/
>    */
> -static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
> +static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
>   {
>   	unsigned int i, best_div_val;
>   	unsigned long best_delta, best_parent;
>   	const struct meson_clk_info *div;
>   	const struct meson_clk_info *mux;
>   	struct meson_clk *priv = dev_get_priv(clk->dev);
> +	struct clk mux_clk;
>   
> -	div = meson_clk_get_info(clk, id, MESON_CLK_DIV);
> +	div = meson_clk_get_info(clk, MESON_CLK_DIV);
>   	if (IS_ERR(div))
>   		return PTR_ERR(div);
>   
> -	mux = meson_clk_get_info(clk, div->parents[0], MESON_CLK_MUX);
> +	mux_clk.dev = clk->dev;
> +	mux_clk.id = div->parents[0];
> +	mux = meson_clk_get_info(&mux_clk, MESON_CLK_MUX);
>   	if (IS_ERR(mux))
>   		return PTR_ERR(mux);
>   
> @@ -497,8 +492,12 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
>   	for (i = 0; i < (1 << mux->parm->width); i++) {
>   		unsigned long parent_rate, delta;
>   		unsigned int div_val;
> +		struct clk parent = {
> +			.dev = clk->dev,
> +			.id =  mux->parents[i],
> +		};
>   
> -		parent_rate = meson_clk_get_rate_by_id(clk, mux->parents[i]);
> +		parent_rate = meson_clk_get_rate(&parent);
>   		if (IS_ERR_VALUE(parent_rate))
>   			continue;
>   
> @@ -524,21 +523,26 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
>   	return 0;
>   }
>   
> -static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate);
> +static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
>   
> -static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
> +static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
>   {
>   	int i;
>   	ulong ret = -EINVAL;
>   	struct meson_clk *priv = dev_get_priv(clk->dev);
>   	const struct meson_clk_info *info;
>   
> -	info = meson_clk_get_info(clk, id, MESON_CLK_MUX);
> +	info = meson_clk_get_info(clk, MESON_CLK_MUX);
>   	if (IS_ERR(info))
>   		return PTR_ERR(info);
>   
>   	for (i = 0; i < (1 << info->parm->width); i++) {
> -		ret = meson_clk_set_rate_by_id(clk, info->parents[i], rate);
> +		struct clk parent = {
> +			.dev = clk->dev,
> +			.id = info->parents[i],
> +		};
> +
> +		ret = meson_clk_set_rate(&parent, rate);
>   		if (!ret) {
>   			SET_PARM_VALUE(priv, info->parm, i);
>   			break;
> @@ -551,43 +555,41 @@ static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
>   /* Rate propagation is implemented for a subcection of a clock tree, that is
>    * required at boot stage.
>    */
> -static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate)
> +static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
>   {
> -	switch (id) {
> +	switch (clk->id) {
>   	case CLKID_SPIFC_DIV:
>   	case CLKID_USB_BUS_DIV:
> -		return meson_composite_set_rate(clk, id, rate);
> +		return meson_composite_set_rate(clk, rate);
>   	case CLKID_SPIFC:
>   	case CLKID_USB_BUS: {
> -		unsigned long parent = meson_clk_get_parent(clk, id);
> +		struct clk parent = {
> +			.dev = clk->dev,
> +			.id = meson_clk_get_parent(clk),
> +		};
>   
> -		return meson_clk_set_rate_by_id(clk, parent, rate);
> +		return meson_clk_set_rate(&parent, rate);
>   	}
>   	case CLKID_SPIFC_SEL2:
> -		return meson_mux_set_rate(clk, id, rate);
> +		return meson_mux_set_rate(clk, rate);
>   	}
>   
>   	return -EINVAL;
>   }
>   
> -static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
> -{
> -	return meson_clk_set_rate_by_id(clk, clk->id, rate);
> -}
> -
> -static int meson_mux_set_parent_by_id(struct clk *clk, unsigned int parent_id)
> +static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
>   {
>   	unsigned int i, parent_index;
>   	struct meson_clk *priv = dev_get_priv(clk->dev);
>   	const struct meson_clk_info *info;
>   
> -	info = meson_clk_get_info(clk, clk->id, MESON_CLK_MUX);
> +	info = meson_clk_get_info(clk, MESON_CLK_MUX);
>   	if (IS_ERR(info))
>   		return PTR_ERR(info);
>   
>   	parent_index = -EINVAL;
>   	for (i = 0; i < (1 << info->parm->width); i++) {
> -		if (parent_id == info->parents[i]) {
> +		if (parent->id == info->parents[i]) {
>   			parent_index = i;
>   			break;
>   		}
> @@ -601,11 +603,6 @@ static int meson_mux_set_parent_by_id(struct clk *clk, unsigned int parent_id)
>   	return 0;
>   }
>   
> -static int meson_clk_set_parent(struct clk *clk, struct clk *parent_clk)
> -{
> -	return meson_mux_set_parent_by_id(clk, parent_clk->id);
> -}
> -
>   static int meson_clk_probe(struct udevice *dev)
>   {
>   	struct meson_clk *priv = dev_get_priv(dev);
> @@ -636,11 +633,11 @@ static const struct udevice_id meson_clk_ids[] = {
>   };
>   
>   #if IS_ENABLED(CONFIG_CMD_CLK)
> -static const char *meson_clk_get_name(struct clk *clk, int id)
> +static const char *meson_clk_get_name(struct clk *clk)
>   {
>   	const struct meson_clk_info *info;
>   
> -	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
> +	info = meson_clk_get_info(clk, MESON_CLK_ANY);
>   
>   	return IS_ERR(info) ? "unknown" : info->name;
>   }
> @@ -651,11 +648,11 @@ static int meson_clk_dump_single(struct clk *clk)
>   	struct meson_clk *priv;
>   	unsigned long rate;
>   	char *state, frequency[80];
> -	int parent;
> +	struct clk parent;
>   
>   	priv = dev_get_priv(clk->dev);
>   
> -	info = meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
> +	info = meson_clk_get_info(clk, MESON_CLK_ANY);
>   	if (IS_ERR(info) || !info->name)
>   		return -EINVAL;
>   
> @@ -670,11 +667,12 @@ static int meson_clk_dump_single(struct clk *clk)
>   	else
>   		state = "N/A";
>   
> -	parent = meson_clk_get_parent(clk, clk->id);
> +	parent.dev = clk->dev;
> +	parent.id = meson_clk_get_parent(clk);
>   	printf("%15s%20s%20s%15s\n",
>   	       info->name,
>   	       frequency,
> -	       meson_clk_get_name(clk, parent),
> +	       meson_clk_get_name(&parent),
>   	       state);
>   
>   	return 0;

Looks good


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

