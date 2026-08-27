Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A979C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 15:38:06 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.172.1787845082214091330
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 08:38:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=rlxj+ejq;
 spf=pass (domain: linaro.org, ip: 209.85.221.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fecbb7000so1120065f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787845080; x=1788449880; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5qoEqPvqec5Ad6mEHbkA2yhpsPUw/R11eOmhq+5F+8=;
        b=rlxj+ejqnmuEuQYYyp1ZOwvyA5g2QzS/NJPqr7BBzCgOxSf6UouCd0KrlJnzKjjCRL
         oUwX96jQrp+dsC6jHCz9DbdUK4NW79y5hQ2c2hQ7c7aNrOr7kmR/Uah0PMPa3I4Kq6bo
         iXDLa9zySXf8Wht7LyRGe1Aqf2f+g1oS7O8fsG2bsxBFk+CkPBDLQFo7S6ktK+a7RWV+
         j+xAyaYNbptR8q60e8tjboo9llI++0/vQUytROf+hu4qj7uOuq6Eg2/nLNhkJgtcmlnD
         uyi/SXIwwxUGpbZa69kYBZJcoD/2/yFdbB1uBLXTSKB5RFTUE7s/SasZLK0lZBZzRVsM
         bJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845080; x=1788449880;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5qoEqPvqec5Ad6mEHbkA2yhpsPUw/R11eOmhq+5F+8=;
        b=fJVa+dzBdmrSNimRlWFqGPi9WBsLW4SHjM/X7jxeP2+x0Cidts1uL7Ahxse0VwN373
         shtcTem8HX1AciLvaPMq0mHFoiwZ2cFNqmCu6ReANR46lI3dzfN2u8GjewFrzxK/5AEQ
         WUdVtU/bglHtzoMosaCvhrvjdP+7vtWJu8s/6UfJsY9SbyC0FWsmUueOEzF5AI86fN3t
         DY8r5kKReI31KqNM8YkPA/QUrdoPHIPhiguVRouAK+opsn8FMEHFEQB4yGGMbFKN3XdG
         4YH7FTmCPjDOMsEqCZey/xlFt5wIWlaRnX9bHLwCNqFWB+6M5DToXBQki1f0ca940aiW
         BWJg==
X-Gm-Message-State: AFuF++kPWhovx1eFdfjrF1CJMTORLzSeAGOjoaP5l4HtXGWN2B+4Sh+j
	ISfFCQDzFJ+24xzYxwuOdHSA4ku2jZDHZdTGhGnu3lmHxxU9bYHjHBwgp0uV2mq3D5oXNHLOqIc
	EJT0Qk+w=
X-Gm-Gg: AR+sD13OPh8B5mw0dIsAL2j0C8dssRid7tbm3uTePpMcZx+tnlXu2lR4BAlJI8UgVbg
	CMzgadxJM6TLiLl/ettM5nWZwbJoukrXW7Oi81L2tHZd3ttLFEUJp4u15wDewu7oDsUzARHs11L
	gDWrLm3JSK/B/nsKxcRTmhb8Y89SVB2zbOMgk4o7vB6vyU1pmMpoIDWJloCh+7JRTrXMGkhdL5Y
	auT+5JpVH7cuzCW3zr6IUaiaCwTabctdCQ+BqNV7S1AIZhNP3sjqlZ4VPEJIP5f78DKmVEktXrf
	U6oNURcilpuw460aU/JV2pqdqgJRxlNOqPi4KgZjmTNp7bf4oZo0+5/PKUcNsj9VtkEQovh9oZr
	/+FYU1RzX52kupRq5NzCxjHCUZfrSApg+JYfPVQHT1WDYyIg6arG2vPy29yTcBzOEoja3ziFiy7
	aeMlw/lAjk4WotQuHWaRc6ge5lh/yUeLnKnI484JwDkoGW6luB2izDTEmLZSZRhLn3aBWivHAzV
	ru92Q2GV58dJFCaJJDT8/cUIbdA/j6Wv3fzHHxpdaKazg==
X-Received: by 2002:a05:600c:c4ab:b0:499:a8bd:1930 with SMTP id 5b1f17b1804b1-499dc6ef59dmr176721805e9.5.1787845080211;
        Thu, 27 Aug 2026 08:38:00 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18? ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49610170sm131134735e9.6.2026.08.27.08.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:37:59 -0700 (PDT)
Message-ID: <7c78ba1a-f191-4e13-b741-24ba3166dcb2@linaro.org>
Date: Thu, 27 Aug 2026 17:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/9] clk: meson: Use soc-specific naming for common
 functions
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-5-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-5-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 15:38:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3076

On 8/17/26 19:15, Sean Anderson wrote:
> In preparation for moving a1 versions of several common functions into a
> shared file, rename all the conflicting functions to have a soc-specific
> component.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/axg-ao.c  |  8 ++++----
>   drivers/clk/meson/axg.c     | 12 ++++++------
>   drivers/clk/meson/g12a-ao.c |  8 ++++----
>   drivers/clk/meson/g12a.c    | 20 ++++++++++----------
>   drivers/clk/meson/gxbb.c    | 20 ++++++++++----------
>   5 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
> index 6ccf52127b0..3215391006e 100644
> --- a/drivers/clk/meson/axg-ao.c
> +++ b/drivers/clk/meson/axg-ao.c
> @@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_axg_ao_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_axg_ao_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, false);
>   }
> @@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> +	.disable	= meson_axg_ao_clk_disable,
> +	.enable		= meson_axg_ao_clk_enable,
>   	.request	= meson_clk_request,
>   };
>   
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index c421a622a58..e20d3feaade 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -69,12 +69,12 @@ static int meson_set_gate(struct clk *clk, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_axg_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_axg_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, false);
>   }
> @@ -279,7 +279,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
>   	return rate;
>   }
>   
> -static ulong meson_clk_get_rate(struct clk *clk)
> +static ulong meson_axg_clk_get_rate(struct clk *clk)
>   {
>   	return meson_clk_get_rate_by_id(clk, clk->id);
>   }
> @@ -305,9 +305,9 @@ static int meson_clk_probe(struct udevice *dev)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> -	.get_rate	= meson_clk_get_rate,
> +	.disable	= meson_axg_clk_disable,
> +	.enable		= meson_axg_clk_enable,
> +	.get_rate	= meson_axg_clk_get_rate,
>   };
>   
>   static const struct udevice_id meson_clk_ids[] = {
> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
> index 61d489c6e1c..e89638d65b5 100644
> --- a/drivers/clk/meson/g12a-ao.c
> +++ b/drivers/clk/meson/g12a-ao.c
> @@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_g12a_ao_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_g12a_ao_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate(clk, false);
>   }
> @@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> +	.disable	= meson_g12a_ao_clk_disable,
> +	.enable		= meson_g12a_ao_clk_enable,
>   	.request	= meson_clk_request,
>   };
>   
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index f33938e1419..cc7bfe9e2a2 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -194,12 +194,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_g12a_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate_by_id(clk, clk->id, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_g12a_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate_by_id(clk, clk->id, false);
>   }
> @@ -858,7 +858,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
>   	return rate;
>   }
>   
> -static ulong meson_clk_get_rate(struct clk *clk)
> +static ulong meson_g12a_clk_get_rate(struct clk *clk)
>   {
>   	return meson_clk_get_rate_by_id(clk, clk->id);
>   }
> @@ -888,7 +888,7 @@ static ulong meson_pcie_pll_set_rate(struct clk *clk, ulong rate)
>   	return 100000000;
>   }
>   
> -static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
> +static int meson_g12a_clk_set_parent(struct clk *clk, struct clk *parent)
>   {
>   	return meson_mux_set_parent(clk, clk->id, parent->id);
>   }
> @@ -958,7 +958,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>   	return -EINVAL;
>   }
>   
> -static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
> +static ulong meson_g12a_clk_set_rate(struct clk *clk, ulong rate)
>   {
>   	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
>   	int ret;
> @@ -1000,11 +1000,11 @@ static int meson_clk_probe(struct udevice *dev)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> -	.get_rate	= meson_clk_get_rate,
> -	.set_parent	= meson_clk_set_parent,
> -	.set_rate	= meson_clk_set_rate,
> +	.disable	= meson_g12a_clk_disable,
> +	.enable		= meson_g12a_clk_enable,
> +	.get_rate	= meson_g12a_clk_get_rate,
> +	.set_parent	= meson_g12a_clk_set_parent,
> +	.set_rate	= meson_g12a_clk_set_rate,
>   };
>   
>   static const struct udevice_id meson_clk_ids[] = {
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index bf46f4d50bc..24b5f9b5d40 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -236,12 +236,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
>   	return 0;
>   }
>   
> -static int meson_clk_enable(struct clk *clk)
> +static int meson_gxbb_clk_enable(struct clk *clk)
>   {
>   	return meson_set_gate_by_id(clk, clk->id, true);
>   }
>   
> -static int meson_clk_disable(struct clk *clk)
> +static int meson_gxbb_clk_disable(struct clk *clk)
>   {
>   	return meson_set_gate_by_id(clk, clk->id, false);
>   }
> @@ -840,12 +840,12 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
>   	return rate;
>   }
>   
> -static ulong meson_clk_get_rate(struct clk *clk)
> +static ulong meson_gxbb_clk_get_rate(struct clk *clk)
>   {
>   	return meson_clk_get_rate_by_id(clk, clk->id);
>   }
>   
> -static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
> +static int meson_gxbb_clk_set_parent(struct clk *clk, struct clk *parent)
>   {
>   	return meson_mux_set_parent(clk, clk->id, parent->id);
>   }
> @@ -912,7 +912,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>   	return -EINVAL;
>   }
>   
> -static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
> +static ulong meson_gxbb_clk_set_rate(struct clk *clk, ulong rate)
>   {
>   	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
>   	int ret;
> @@ -954,11 +954,11 @@ static int meson_clk_probe(struct udevice *dev)
>   }
>   
>   static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> -	.get_rate	= meson_clk_get_rate,
> -	.set_parent	= meson_clk_set_parent,
> -	.set_rate	= meson_clk_set_rate,
> +	.disable	= meson_gxbb_clk_disable,
> +	.enable		= meson_gxbb_clk_enable,
> +	.get_rate	= meson_gxbb_clk_get_rate,
> +	.set_parent	= meson_gxbb_clk_set_parent,
> +	.set_rate	= meson_gxbb_clk_set_rate,
>   };
>   
>   static const struct udevice_id meson_clk_ids[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

