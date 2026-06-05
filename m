Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FBBCD6E74
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:18 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7655.1780664949188743406
 for <u-boot-amlogic@groups.io>;
 Fri, 05 Jun 2026 06:09:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=tRU7JThO;
 spf=pass (domain: linaro.org, ip: 209.85.221.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso1013888f8f.2
        for <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780664947; x=1781269747; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvZYXD9rPkBpjc/aJT5ht0N9UM5B0t9y9qPRvHjiQ80=;
        b=tRU7JThONWuOrKgIsVE6JDuOAQWIlWLn8rmo8UHrSAJ2u1bMOUi6SNsWGm9x5ACiUJ
         XXgfHaj4LkJmqUWQDvDM8o5qVTM1k+eadiHhkOVPZN3KBD6jV0g9eeHF8g6/Dau/rsmv
         5UE1vuX0TzupZdWv45drde8pxLqWQr/j6ATbs0UklQ1gE1AQvJrHjCmIMqEETKQeIKWe
         PAyrkVwu+V/lqcj5MO/2eTHIdvfzzqfkU+2lVmiY3O/JW1Wi6lA1l6Xh0AmqekMEJmFH
         7BfnJkPefQ1umTN1F+ecagE3grOGOz6xOIFnCTZNU5uMwcyVsRiXCj4g3C77mPPsp426
         si2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664947; x=1781269747;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvZYXD9rPkBpjc/aJT5ht0N9UM5B0t9y9qPRvHjiQ80=;
        b=WPv0wHS8z/KX5cs68RKrYTA05QEJB10hRPxn9fH7JRqC4G/EffnfTbpBTE+tmm1+zr
         alDahnBfzHjq0cKK2x2C4Tsna3nPtjFEuAq3rOSDZyXn1f6xDYxLoXffVZif2MZQ3a/t
         U7b2aNjwqcDDdhtm8hBUz2IbV8mcC0YwqM6Fxe0V636vgWj5ia0j54Z3aOwu4a0bqP/K
         urXEimRO4XXCg092Nt+7wzz/l7h/M1U67qmRVsjf+7cGuYk+Odx0twKIx9yjFgM1O2L6
         xrcXvkd0QwRJwEyobYArYLeNMnS/uJ7XES0at88UlJBJahClMmViz+mER22CwcrkHCNr
         Lpwg==
X-Forwarded-Encrypted: i=1; AFNElJ+l+H6XWHylbXmQgbDUjpZsZ/J2zYSjES/kCVTWwLvHMWLgVjLgDOJC9CwN3XBCj9gv3Nz2y7SSoqILvYxj4Q==@groups.io
X-Gm-Message-State: AOJu0Yxi05eIMO3Xz/qZN6XsgqKwjS2fyXh6njChKSWJ+OBsqsDCjU3h
	xIHu5ezIVP2UP3zoXAOTDMKKpVTdkZ38VrJcc+Hi3gnutwnxR9SNMdiqKHAozJnv4EM=
X-Gm-Gg: Acq92OEbCgFRfB0RA9osG5WauvBkv9ZxL9p19y2X92BP+aJJbvlBlaHqdJ/3d1hUFnJ
	AOkd9tjW8FxUyKZ7/4PCsAGGPuvHhgWmO/wl1mBmNWXQwqmMgEmxKGyqATPe28zwlEZpQHjmjvr
	pQLLFOqvUWRLawkZGbMvO/ME4/kLMvRdmjSajs7ZEBd9vZnXkEs7N9P/nbGFynlkKy5lVip+6XY
	Z5bgBHKzrrqBFEge1e1xbSExP3ua9W1ATcS1CF+dcKfnqCk69MHrxRClqq7HcnHDAFi/n88G3QY
	8+9nGKwB1Yi0U47uGtLiCDC0tB4mLyTMnFZ3wahroz9uqruxOdps/aVkXrxMViFAYwZuYwzEpPE
	3kUvQgdTB2pQjT/Wa276Bv5x15NaDDoIJXmlnYbwT5ug9bgAFTnCBKRLPecMUqX4rLWjFZ+3uQp
	+THrZN2XwUD+UhS4q+TO9LFe08dp7RpsqykLwmGVBOL5/0eceuxCElTW3X6QHdWHdUBbxOPJi1/
	xw8wbMsQmohb4XZOA==
X-Received: by 2002:a05:6000:46c7:b0:460:e0f:8d19 with SMTP id ffacd0b85a97d-460302e3193mr3876807f8f.9.1780664947398;
        Fri, 05 Jun 2026 06:09:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668? ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm24799532f8f.8.2026.06.05.06.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 06:09:07 -0700 (PDT)
Message-ID: <3ffc6bff-1732-466f-9e8a-0a57606c39dc@linaro.org>
Date: Fri, 5 Jun 2026 15:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 07/14] power: domain: meson-ee-pwrc: Staticize and
 constify driver ops
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-7-marek.vasut+renesas@mailbox.org>
Content-Language: en-US, fr
In-Reply-To: <20260508122247.512862-7-marek.vasut+renesas@mailbox.org>
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
 <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 13:09:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3006

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
>   drivers/power/domain/meson-ee-pwrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
> index 4d9f3bba644..6361f3a6c59 100644
> --- a/drivers/power/domain/meson-ee-pwrc.c
> +++ b/drivers/power/domain/meson-ee-pwrc.c
> @@ -386,7 +386,7 @@ static int meson_ee_pwrc_of_xlate(struct power_domain *power_domain,
>   	return 0;
>   }
>   
> -struct power_domain_ops meson_ee_pwrc_ops = {
> +static const struct power_domain_ops meson_ee_pwrc_ops = {
>   	.off = meson_ee_pwrc_off,
>   	.on = meson_ee_pwrc_on,
>   	.of_xlate = meson_ee_pwrc_of_xlate,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil


