Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB6C83F1A
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 08:30:12 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.7740.1753345809168720223
 for <u-boot-amlogic@groups.io>;
 Thu, 24 Jul 2025 01:30:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=oHV6iD6z;
 spf=pass (domain: linaro.org, ip: 209.85.128.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45617887276so4267695e9.2
        for <u-boot-amlogic@groups.io>; Thu, 24 Jul 2025 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753345807; x=1753950607; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzKrSLaq1ZTyVT4LnrRBse8XQg0JW5ygybJqV/kfD6Q=;
        b=oHV6iD6zydpfnDgN/Bopee/qrEwimGlipG4T4FKrKsfcz1+UpXrj/BM/mtp7zz5mlq
         ZTEbycbIMtK/IYTFyqTPXot/KfjfZx+7nZNBgVO+XdBdXZCiLiD1M9kXI7qE8yq7KKzB
         h1NzRFKroNjIxTtVkcsQi8uLe/M4V2uiy+FW2zIn3Z+RWKJSfO6nm4B0IERUnzL7O7jD
         ppttrG3qHltFTAfZutYXvyYKluK2JLV0yyOB1PTilBcDFpwwbMIAHZmwsNkc3UWxbgOt
         DT392LVPa95+gr2j3hx19xflLMDZt7sHzwZKez6iqxYmSWPWcV1v3QiAbdQY/Vzuxk3H
         BRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345807; x=1753950607;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gzKrSLaq1ZTyVT4LnrRBse8XQg0JW5ygybJqV/kfD6Q=;
        b=uutVsupmbbOd/wc4xgBBDRiXDqDPRt5RI9nPm3xhjj5CwI4bl6lSr+ZYl9xQy7W5vm
         KdFsaLvXc0es2rjZrZGhWujklOYnGSbAUr1AHdgVXOMaH3Zygkle6otXNpRsudKEu5NT
         QoRCeRdvLFE9F5tiPTI0RnkVfVNbVeMC462od+C87jn+dvOwwtZ+/EZq99aTXP+lsPv3
         b92C9gZkKxRYyZyk6t3YpECAMRCKAtqfAMLlRrGscZ1mwTdNjt3t5uoxVFevKAgABQXy
         a8ZNLCYpyoOqsVTPlH12P4kAs3pAxzvWFPDfEU4bi/jjI5XLxAEgDed5SFhy2oGMfrwG
         ybRA==
X-Gm-Message-State: AOJu0YxbBfMPbGOYksD3WSLn8uTaat0qJUyGUA73AtBhKV7sbfAZV3xP
	X78nKsu/UcM3RX9DU4w+ojeR3nfKFUKp3KJGcgpSHMsg2uwqoMMj1aF5viA7z6KQGqI=
X-Gm-Gg: ASbGncspnAbJfsxB/OXHbwxvXCsKH1lcrr7th59JIm9PPGxXEW+xAjtkiJOcbDDOc3J
	ZT1sb2XKn/o1tRcL/wmK1YfoOfzGB9zzhBXBs/govnAOJHm/xDBKZIzIq521qh1dKynGd6RsW7l
	GFTpYct0azLXWx/HAFJ54Osj4vpvOUlpTCaqJ7TOI2UCA4hFCuOxbBzBD1nq1+3b1a791i9zI4F
	raPaAjnJZiLnh34rPsfhEwFjjvFQZ3Lk/jSyJwwDwHmOqZr4eS0PFgeVBUwomOi1QEI0qtWo9ZA
	kNt/9rHS0qCCDeXe8OfiSKRjadcWGbvD5kvresBa4W8LP+VoN/TIHulLEHaCkD8XgwTZHH9GvZ1
	uYliCxFgfrl/VspGZBzxH8gSvZQZ7BqH+
X-Google-Smtp-Source: AGHT+IEqRSm8F4M5nLtj2/YydnIn92cdGu3S4AJXdauwCewfuZ9IdIZEFnNotTyxDLOfaXOq1fK3lw==
X-Received: by 2002:a05:600c:8211:b0:445:1984:247d with SMTP id 5b1f17b1804b1-4586f5f5cfemr12318335e9.7.1753345807467;
        Thu, 24 Jul 2025 01:30:07 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcb96sm11522485e9.21.2025.07.24.01.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:30:07 -0700 (PDT)
Message-ID: <64196c27-1df7-4ab9-bf59-b00621362bf0@linaro.org>
Date: Thu, 24 Jul 2025 10:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] clk: meson: Remove unreachable code
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
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
In-Reply-To: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 24 Jul 2025 08:30:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2729

On 23/07/2025 18:37, Andrew Goodbody wrote:
> A second return following the first return is unreachable code so remove
> it.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/meson/g12a.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 5d7faaa3eab..a7a42b2edb6 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -916,8 +916,6 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>   			return -EINVAL;
>   	case CLKID_PCIE_PLL:
>   		return meson_pcie_pll_set_rate(clk, rate);
> -
> -		return 0;
>   	case CLKID_VPU:
>   		return meson_clk_set_rate_by_id(clk,
>   				meson_mux_get_parent(clk, CLKID_VPU), rate,
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-clk_meson-3d90bc29f8dc
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

