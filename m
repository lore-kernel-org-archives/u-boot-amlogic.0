Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83202CD6E74
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:38 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7851.1780664970628242766
 for <u-boot-amlogic@groups.io>;
 Fri, 05 Jun 2026 06:09:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QZ3Y32Fj;
 spf=pass (domain: linaro.org, ip: 209.85.128.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b9318997so14229655e9.2
        for <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780664969; x=1781269769; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ml6RUZLsybLtaNHChJJrlPVejcPlGSwv5i9HQEZLVXk=;
        b=QZ3Y32Fj/APygD0skqNDM8pcJZj6fd9WIexfClJ3yRrOrfj+CuHDUqU7B6yfnRT8Ii
         uCPSH5aHMakWcb/YyrNu0H7pa766eX22dS052OJqOwV0+Bfrw/Vr3/hXzTHO4UQuV/b7
         FTSmS33yC7KYG55RvHRzsw+Okg2na55aLk/lWSO6dgeOEHVQm3k2lNstnm2/KqDchZvU
         xlQwPwiM+hlkehQQ+V0OqR7Zp5uwsTwjGeot4vwFk23wXF/Q4P3rXIeqHqWP5jLd1n3J
         RusTvGKa/O5udLT60s6e299sJzUxdEb3yWe9ym6hJzS0OqfH4M0HLXjChA8maJ4aoKNb
         Qa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664969; x=1781269769;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ml6RUZLsybLtaNHChJJrlPVejcPlGSwv5i9HQEZLVXk=;
        b=ornljP1yVuLObeJRcC46Nf/NwvdLJQ+DTxaU9+i/+Zme0SAykxTzUDPHUuk1aKNLev
         vZYERzDGAyUuFOdg44m6NRMgGQnDKrtfk7sLELKR9QZqc4UojcM5gmgB9QppCAMDQdji
         nj3A7WRL+WmldMDfzUCpUsbUE5vAmrQ7LGfiPvRRLe3ML9XJ6IhKXA7salnMQ6eTOn0R
         tzhXhI+fU5TiYx3L0hcpJLLjrm+KZJ5BqK4sg0nt72xmtE2XQ1ntn6B836yLZebHkkdb
         nrrIG/dYUMcyBJ5S7LzNnZQkBISA0RiO+bqLagNL0T725ckGgDnRkFgiGlEzm1krgtdS
         BoWA==
X-Forwarded-Encrypted: i=1; AFNElJ+V9IyRJFq9FjonxOyzwv7yRtXTwSz1x1fmUJMKq1wBIJQDfLizz79jyBuRy+JIFGMegQBQ9mWnKJ70S+/pww==@groups.io
X-Gm-Message-State: AOJu0YwIqQhIo41c6qBcCtqQeLKWjvU5SEKx7sZam8jyHkN2ky9Iqg6N
	WzC559W/35WfWQRskdZU828dY87C5TT6e2jQtgJoL3/W2goZD1DdyCHlFcX4qKkwRwE=
X-Gm-Gg: Acq92OFc9o4KoDXDQZJbYez4+75qdceLLo8hLl0lHLO3QwoWVvqJkDmZiBAYCUyOZRi
	1SACOB/Tjw4Y2KxJ7o0B+akZj0PPfyHRSIqXgOZNTkoOj+FZKz72HJjXR5f+MUs5hRmLUCBJpPV
	qcDZ7vvAbBMYz+YIViC0/KxRJTK74oY/wR/QikQz6a28tryRTX8FbfWZbhpt7g1LIlTt1OxiFos
	H+rx8IXAX2PvDI9Gl01fFrIk79j5lOh15Hs5glMek6pFexCAH93zxSUVPmHRccJJA/oNHFZz8XW
	rnjwina4bcRdaBmZ+nncxBX65F74U2dAD8lm+kyjZ1DC9wf832LDzZ8zmPFg5Zz2CaT7QuKMEl6
	FUwt/cZeRKmFoZNgp5f7bmyUaRIe78VvYuFq0ErbryWt17GhPTX1sh6pdcBvZBYd8XZDkLFdnU2
	FoLbfyskDPEni0omESopOysikhpdS3PXzSj0FeNjY9T1cNDw4g3AXgn5qKuW5mWKhY1UdxH5ZJZ
	ydjf4RcW+2te0ysfQ==
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490c260f3cdmr52545135e9.27.1780664968853;
        Fri, 05 Jun 2026 06:09:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668? ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm15893188f8f.7.2026.06.05.06.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 06:09:28 -0700 (PDT)
Message-ID: <ff8193d7-d13a-468a-a78b-2fd20935101d@linaro.org>
Date: Fri, 5 Jun 2026 15:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 08/14] power: domain: meson-gx-pwrc: Staticize and
 constify driver ops
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-8-marek.vasut+renesas@mailbox.org>
Content-Language: en-US, fr
In-Reply-To: <20260508122247.512862-8-marek.vasut+renesas@mailbox.org>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 13:09:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3007

On 5/8/26 14:22, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/power/domain/meson-gx-pwrc-vpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
> index 1c56e8508c3..325296b0dd7 100644
> --- a/drivers/power/domain/meson-gx-pwrc-vpu.c
> +++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
> @@ -262,7 +262,7 @@ static int meson_pwrc_vpu_of_xlate(struct power_domain *power_domain,
>   	return 0;
>   }
>   
> -struct power_domain_ops meson_gx_pwrc_vpu_ops = {
> +static const struct power_domain_ops meson_gx_pwrc_vpu_ops = {
>   	.off = meson_pwrc_vpu_off,
>   	.on = meson_pwrc_vpu_on,
>   	.of_xlate = meson_pwrc_vpu_of_xlate,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil


