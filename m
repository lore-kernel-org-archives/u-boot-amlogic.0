Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A0C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:59:35 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16113.1787576365739046007
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 05:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FHwjv/Ya;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4998590d392so12359065e9.0
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787576364; x=1788181164; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ynp3uKxwvh4vNZ+6+UdCIWBJLz+gdvZ5Owh6ad2YRsc=;
        b=FHwjv/YatS+XqiA3U2ZKb7Zhfcgq47bL9o2JVbit8zRinAny+eB9kKj3xg7XB0DFF4
         jP0MIv+lwy5o42h2rW2XbXUpVzy7YpY69jWFppNgRWWnwFDNeBjsfhirhKauCRzIZfM3
         vbD9AReO9h0sGEXM4J3gcjLe/ZhuY9W30QDyOwaFcOwWHorg47+D47v8Ojpse/SU3FhB
         AFyfpH35sTeTbSvXvWODgW5Nekmi1SVK8P7IQ2p28OyR0BCxGDIwb+K6FRbmA3skGp0B
         1gkBIgfgxFN25lwybU0kwLTWiR+EiTxJbN1ijAOxDXDEHKxn/bMdI4lnI87uoNBBHQvi
         xTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576364; x=1788181164;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ynp3uKxwvh4vNZ+6+UdCIWBJLz+gdvZ5Owh6ad2YRsc=;
        b=j1TJe0Fk7RhJIRPD/lT3mLcAtoxc/B+WEdHEJN/aDlM/k/qghEQeOJudmD/pIjJG2h
         XV4sI0+JAEMDwl+x8J43xMG2d2cWl7z6XLFheYPUtYja5KfVSlI5poZnEuonlVTRL1SF
         yGnairmP7sbgd+dD0zMVD1DiVR8VzlsqXiTbP1jyrWRYBi2/pbTohPvPpN965EE0gWrs
         NlAjMS9nmw5d2gY5Zv6MPWub1W4C2l8ubcDQyxrTnUQSN5zLBntSFss6GchK+eCIu/F3
         bYJaVrUKsuNtiLsgzJeXnxt0FqbpUjqOsT2Ix0XzaSPRme1uzJ4yjb/V4f4YbTM98XIm
         x7Bg==
X-Gm-Message-State: AFuF++niUNxRE/6eMwL97CyMbvMyGh2rVzWITXVcCZqE0ZQDfEpsHX+6
	oTeQbs5t48lSk9uwoWzSqvrK9Kt7XqUUpUgGYCKOdCTSiATjtn5rd1I3R/30GRtBDRMcKVuuyUa
	i8XUC
X-Gm-Gg: AR+sD10d18C9m0NEDVGnUWRELqaET0V8aOxpocC3qNG5+FNATU0UFNI8P47MadgqiiK
	l0DBsgcGawHSDNzO1zsCxNUE9RTO2gsqNZN2L3wjatuJHSMetYN+ZmVbReyaZLjqTNW/fEGhiKw
	nHWYQ77eHAY8ZKMKOkDcmjq06BrzmHdAYUIiLKmyHJY2Di/3jmMQft4iA0oOvBnTEXEwscN4txg
	W9oDooEvsUrzicySZ1L+ipEwZhwqVVvfdpqW4BfxejpoFzQfulttkgOTE4qkt5OoiPvsPZrPUKm
	a57FNH/PjEBRk1K6uKNKwD0WwNcwY/pDUvdxOMMuTkYvy2VS3jl9aqHkYJB8gCiGx+GIXaHMjIR
	hCk5KpAkI6ijRzgkCRcN6uyzytru+6oZBwu3gvSDdTc18DAlN3zrTa+IbgpF/30n4e01TukmrXE
	2Ivx5nQ7N/0iHB0YZA3PtGPtyV4Eyi2tuQLgRrHn7PpCw2KzINGHBLZeWNm3akH2FWfgaZpu7dt
	Luoswjsp1XdmPbeW4Qn54YwGk79wQqAIljjvQ91Xg==
X-Received: by 2002:a05:600c:3e1b:b0:499:a685:c10 with SMTP id 5b1f17b1804b1-499b82e5427mr343146935e9.4.1787576363857;
        Mon, 24 Aug 2026 05:59:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273? ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d560f66csm241245e9.1.2026.08.24.05.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 05:59:23 -0700 (PDT)
Message-ID: <082abc17-d8bf-4083-80b4-8caae9c5bad1@linaro.org>
Date: Mon, 24 Aug 2026 14:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] watchdog: meson_gxbb: Add support for s4/t7 SoCs
To: u-boot-amlogic@groups.io, sanderson@brivo.com,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>
References: <20260817163048.1892107-1-sanderson@brivo.com>
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
In-Reply-To: <20260817163048.1892107-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:59:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3056

On 8/24/26 14:53, Sean Anderson via groups.io wrote:
> These SoCs have an almost identical watchdog to other meson SoCs, except
> the reset bit has moved. Add a new compatible and driver data.
> 
> This commit is based off of Linux commits 55908e388b5da ("watchdog: Add
> a new struct for Amlogic-GXBB driver") and 8c776a0401f1d ("watchdog: Add
> support for Amlogic-T7 SoCs")
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/watchdog/meson_gxbb_wdt.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index fced8f3686b..30694936c93 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -18,7 +18,6 @@
>   #define GXBB_WDT_CTRL_SYS_RESET_NOW		BIT(26)
>   #define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
>   #define GXBB_WDT_CTRL_CLK_EN			BIT(24)
> -#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
>   #define GXBB_WDT_CTRL_EN			BIT(18)
>   
>   #define GXBB_WDT_CTRL_DIV_MASK			GENMASK(17, 0)
> @@ -28,6 +27,10 @@ struct amlogic_wdt_priv {
>   	void __iomem *reg_base;
>   };
>   
> +struct wdt_params {
> +	u32 rst;
> +};
> +
>   static int amlogic_wdt_set_timeout(struct udevice *dev, u64 timeout_ms)
>   {
>   	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> @@ -84,14 +87,14 @@ static int amlogic_wdt_expire_now(struct udevice *dev, ulong flags)
>   static int amlogic_wdt_probe(struct udevice *dev)
>   {
>   	struct amlogic_wdt_priv *data = dev_get_priv(dev);
> +	struct wdt_params *params = (void *)dev_get_driver_data(dev);
> +	struct clk clk;
>   	int ret;
>   
>   	data->reg_base = dev_remap_addr(dev);
>   	if (!data->reg_base)
>   		return -EINVAL;
>   
> -	struct clk clk;
> -
>   	ret = clk_get_by_index(dev, 0, &clk);
>   	if (ret)
>   		return ret;
> @@ -102,7 +105,7 @@ static int amlogic_wdt_probe(struct udevice *dev)
>   
>   	/* Setup with 1ms timebase */
>   	writel(((clk_get_rate(&clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
> -	       GXBB_WDT_CTRL_EE_RESET |
> +	       params->rst |
>   	       GXBB_WDT_CTRL_CLK_EN |
>   	       GXBB_WDT_CTRL_CLKDIV_EN,
>   	       data->reg_base + GXBB_WDT_CTRL_REG);
> @@ -117,8 +120,17 @@ static const struct wdt_ops amlogic_wdt_ops = {
>   	.expire_now = amlogic_wdt_expire_now,
>   };
>   
> +static const struct wdt_params gxbb_params = {
> +	.rst = BIT(21),
> +};
> +
> +static const struct wdt_params t7_params = {
> +	.rst = BIT(22),
> +};
> +
>   static const struct udevice_id amlogic_wdt_ids[] = {
> -	{ .compatible = "amlogic,meson-gxbb-wdt" },
> +	{ .compatible = "amlogic,meson-gxbb-wdt", .data = (ulong)&gxbb_params, },
> +	{ .compatible = "amlogic,t7-wdt", .data = (ulong)&t7_params, },
>   	{}
>   };
>   
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: s4_wdt
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

