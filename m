Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4D9CA1013
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 08:24:38 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.34398.1756974272484263449
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Sep 2025 01:24:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=lgb3+75r;
 spf=pass (domain: linaro.org, ip: 209.85.128.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso12967805e9.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756974271; x=1757579071; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=855dvf+m6LlLZUCzphgMGLGpOjBOmYtl1dWdsnVL824=;
        b=lgb3+75rE3imx5rVP4/fEBAcEpLJMAXaLTsEvopk/0+zYcr3ssrFbQGH87G1GzkhUk
         KFVZBUcQtebn6puFEeqDerNLilBN4goWxIk8s8BudBreSblG8U4B7VzA19sJkxt61ppV
         SvqDQWyg0suHE2Az6yx0Hyntz+T5/57NlHL1cbtQV8eglU47ARg9EJwpW8wbC5BosUcL
         iUkP0/97pAn3oDIn9AH7kJOjOf7dGybCbU+TR2EurFsopuFCuHzvy4MyVa7qPe8BaNjP
         DEjrpJsXTl8+p69CxfJ5zpuNDzw6N/ZS7a+xqclnu/BuwE9wxVd3bIOFYCFloNUqiH9f
         hSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756974271; x=1757579071;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=855dvf+m6LlLZUCzphgMGLGpOjBOmYtl1dWdsnVL824=;
        b=lYxNevoCMbe5uCydXrZVcFaR81yugyuN9VNNn5N7O0vAWX34+Ecb2oza82GKBswFgO
         /7ooUAqWp3k5EnWhuKTVpPzmvrWEO5OUdJK+OF5gDoXSGoc7iWyO1bpP6WK35GlstD8Y
         +P1j5A5zYYLuVrtr/8udRKgA2cgnIZvnBnExxTevS0IBuYIVTPmTJM5jn08mLwa7KCZj
         bRBAWsJ+Ke8wsV5/qEdQ9j3AgaWTAzyZEAVzlKhkSA7kze2aFW2+AfUy3mDSCheCuDWq
         adep4ltD/y/n4tkAvaiQFCeU2O3s/7QiMqqWik/ErdwpCa6AdnkWzg1mLHM7mFT5eu1b
         uwMQ==
X-Gm-Message-State: AOJu0Yzg9VPEbI9I1GNJ0P0jwcwvW+3k/sOHs/TzRrkPIHM+A4ho0Bym
	o//i38Vc2E9ceIB/pOtI9ft1LCS6JABb0i/Zjj40lfzJjpfKbWrTa7OISmNCyiNnaYY=
X-Gm-Gg: ASbGncuwI8huXJ+mtBPF8Pwcbq7CahVnNKLiPunfvPKlOkea3wyxx/MB00vJTL7Yux4
	Yru5QKJ27muNvmDoUIRYIIYm9Do+qFV0eV0C2ObQWaUGx+wceKP8srZJddoUf9QRr1yzg37gU8G
	w6GleYiT7qDRpzGlOMMOvOEm38YhyL0w6OSCmPY/a/Iz7Y9krIBZnaeQJqmR2rxEjmxb7QU6yae
	7H4IcxqKizokkB+yiPbTwgrm6JZ3hX0HS0arzLrA0B4bMwl3MHMwkVwZxUZPpIPgCp4F0f1QQJf
	eFRRu9Nr3Q6LN9ez6mwY7pAT25FT+sKBEMc1Sb6qexFvcFv1jPED8B4J9dLgm6ioWKzP4Z7quw0
	qMqNJ8+ERPD46MhevcDdrExf/OjAci1xDqy9D1YEPSYhQkDkX7C3a8tsnGTBK8DJQ6JRkFTItS7
	lVxhu8JnU76Q==
X-Google-Smtp-Source: AGHT+IFgEwQyCgQzqt+K4cIRfzBuCKv21soEJS4bZD6Ek1wFz7ba/6VUdsDE1XWZ3Jk1x31thTaw9A==
X-Received: by 2002:a05:600c:8b64:b0:45d:d295:fddc with SMTP id 5b1f17b1804b1-45dd2960194mr7095185e9.4.1756974270824;
        Thu, 04 Sep 2025 01:24:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:8c14:335d:24b1:fa98? ([2a01:e0a:3d9:2080:8c14:335d:24b1:fa98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e177488999sm1189281f8f.36.2025.09.04.01.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:24:30 -0700 (PDT)
Message-ID: <16deff09-13d8-4ad1-8a1c-c1d9988a9c51@linaro.org>
Date: Thu, 4 Sep 2025 10:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pwm: meson: Stop premature exit from for loop
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
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
In-Reply-To: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 08:24:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2737

On 08/08/2025 11:34, Andrew Goodbody wrote:
> In meson_pwm_probe the for loop attempts to get the name of a clock but
> the following if..else statements only perform useful work if -ENODATA
> is returned from clk_get_by_name. If clk_get_by_name simply succeeds
> then this results in a premature exit from the for loop and the
> following code can never be reached. Make the else clause only apply for
> an error return from clk_get_by_name.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/pwm/pwm-meson.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index c2597d8b669..caa7af085fa 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -359,8 +359,9 @@ static int meson_pwm_probe(struct udevice *dev)
>   
>   			/* We have our source clock, do not alter HW clock mux */
>   			continue;
> -		} else
> +		} else if (err) {
>   			return err;
> +		}
>   
>   		/* Get id in list */
>   		for (p = 0 ; p < data->num_parents ; ++p) {
> 
> ---
> base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
> change-id: 20250808-pwm_meson-65549e7d24ab
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

