Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F2DC61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 15:37:46 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.171.1787845064572010712
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 08:37:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=YGORFfke;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so6453095e9.1
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787845063; x=1788449863; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dh4OCjO04g0TKiHtMQq2+efsrwXqSSPP04CluYs+f+A=;
        b=YGORFfkeP8+/Can6RWRF12M2FkDGhvWyP4eXuKMm1CnU+mhWIYlEAf5+CuGHBYaDJo
         SJrgwJRgg9GlSTuJncAA7yyQ/IwaW8FGcFZeT2qr9FabTOttaqzX+UfpLyRS70P++MTF
         MdHFVdqJcVsJSotZJiAjlTfQHpD0F9nWvgnsEaU1GPSBsT6bo/Tp4wdzDL3bzxBKMiA3
         LKT4E8zBniRdVWhzcNhf/vmsQL3U7Kn7W955HhjDXLJ8vPSBrpUcXdhOtGac1d3dRSEd
         0EWsAN3k/L4NhansVDbt0DkWkXFSvFxAIhi62MdWiGvAY7obHmLi/Qs5Cm4bI0HDsLsu
         ewPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845063; x=1788449863;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dh4OCjO04g0TKiHtMQq2+efsrwXqSSPP04CluYs+f+A=;
        b=jLXQCT2+ArrCyvwxaaG4QH1Mhzf7hXkQ1vVOftGWpIuZRcPMp9I9PjvUauHlaN1X8n
         ywN5xYltz0jZZ5mT+9EvTtd8H0dyHCG3nNTIK+rHLjVRSkGhfWrnILnhCKV9kwhjIPvv
         Sri01dLdVnuQtegGI9jVjvoC7colKRIX6FAuFr1Lm9haRqgG1Vr3U7q6vFIbALXLkqV+
         kY36IuvT5ZvPGuMkdFggDG9BbuTmqBujn70hVyfQTUP9LqQrjaN2FbCej4zuIEo2AKoH
         49zhWlm3TAHpWIxcDInwLwgYcwqpsrq4h9/rEILV9XTRFdMNtVN9f3EHweHYtYEPctUX
         Tcng==
X-Gm-Message-State: AFuF++kINsajhG4O4ijvMyKSirXfDLnhwRXZmNihGf9U8wLxnfO16lXg
	gYUYt0CcG+R9Nom5wOLhmFx7/ea/cWV03Uwp9YEya5kFtMK1KroMclSopR8Cvx4FHDvHhSKNTOf
	1tqFAyBI=
X-Gm-Gg: AR+sD10zlGZCKJKNPYpLA7DCBGHf67WW+fsreuI6vV9m5Ilh/AaYv6pWC3gdrjF9i5f
	MJOtua0LbQlH66jUNV0urbcdGlFKa47isNGr+y2vsYNxE+6JRJMY9QY5wTF0ZwwOh+cOi+5Pfp3
	kbLF+3HMi9ANlBw/sUstsIn07qTfbchoWiNg4+t655MuhjTfaBZXY3h4NpRz+TYqN5wOzUDnn9U
	kDXmYOk15v1jkLeuGY7Maw7wEdbbbz6hvyfCDxJRlsxsY7fi8YF6/+MXt4fRkWvjY/HMJa3gi5H
	jt6eI9LS2jCtNfYr5KnWMzCNXgE8sJ7OcPz3NXDXUoXUm7JyJsacp4GmjCierwJocpfp0W7oU/r
	Ppb+4El9Os3v+1hwNiso5JDe9Nl/OHXAlDf8Vd+1jBbORDnk9yz7OXt9Xypt2zpyFFw/ckpj6Zs
	zc40wIWzBZ3vp6B4laZNC30StZabK53AMlamPEH610HGLQTp6Y+Wl1gs039uvSFGV3ojtXfV3Xw
	hrrwOZP9yAPFPc+RcNod5sQZdJ4UyVkcG1Z8YoGZe3c0g==
X-Received: by 2002:a05:600d:6413:10b0:49b:c8e:a211 with SMTP id 5b1f17b1804b1-49b0c8ea368mr109647145e9.5.1787845062725;
        Thu, 27 Aug 2026 08:37:42 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18? ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942366asm57217395e9.3.2026.08.27.08.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:37:42 -0700 (PDT)
Message-ID: <b0d1453b-3039-4cfd-a648-8263810e2443@linaro.org>
Date: Thu, 27 Aug 2026 17:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/9] clk: meson: a1: Use clk_set_rate from
 meson_mux_set_rate
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-4-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-4-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 15:37:46 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3075

On 8/17/26 19:15, Sean Anderson wrote:
> This function is useful for other drivers, but it's tied to the a1's
> meson_mux_set_rate implementation. Convert it to use clk_set_rate so
> the drivers's set_rate implementation will be used (no matter what it
> is).
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/a1.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index d0376663069..422cdf5f4d1 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -523,8 +523,6 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
>   	return 0;
>   }
>   
> -static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
> -
>   static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
>   {
>   	int i;
> @@ -542,7 +540,7 @@ static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
>   			.id = info->parents[i],
>   		};
>   
> -		ret = meson_clk_set_rate(&parent, rate);
> +		ret = clk_set_rate(&parent, rate);
>   		if (!ret) {
>   			SET_PARM_VALUE(priv, info->parm, i);
>   			break;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

