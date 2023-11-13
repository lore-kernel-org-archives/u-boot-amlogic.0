Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D9BC4167D
	for <webhook@archiver.kernel.org>; Mon, 13 Nov 2023 08:01:38 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.32523.1699862491999794404
 for <u-boot-amlogic@groups.io>;
 Mon, 13 Nov 2023 00:01:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qnt53GBZ;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5079f6efd64so5371305e87.2
        for <u-boot-amlogic@groups.io>; Mon, 13 Nov 2023 00:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699862490; x=1700467290; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGwVVIf4OlriBWwNKMokuzSiY5LMsuYLfmWJyxfC844=;
        b=qnt53GBZVU6q7ClnIc3hZdKrWGfwZN3n2Oid63uUHB4gytkKbx1dBzsIXwOjDz94DS
         YbUsuZ2PgJniyYDQ7srAtmvcGxnuJc24iUpN97b8bNNi1keaX9ZTzkcDsfKDzMOn+kj8
         yZXONcMd7wRq/X59bHBj8AOTHw8uXvMIXlbbYt1aAZmsoubjlEFSrQNmZN2m4HhC5wyd
         ukZ/yEaD6mp2vnhIz2kD/KJ0vsfr8k1S8tQAURDO+6oXIU7UklSJVhEQUAwwiemm+N4Z
         L6/XayhBquGGi9YAur66sfr1ehxLIyUifhU9gsBUhQJH37qNQuaMe+vFMJ9WXGKDa30Q
         gfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699862490; x=1700467290;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FGwVVIf4OlriBWwNKMokuzSiY5LMsuYLfmWJyxfC844=;
        b=Z0SyjfdIuC3J6ny2oJAI3493ZAXsg6GZGpOvi/DIqKj094mslHvpmCwx3HB53QfC3p
         9YjiToBb2/OEVZI6megcZG4pYThl/iXrgHmdoTduuelIrtiHfA9wMHW6Hskv2weMhzC4
         2J/LOqB3WHanIEGMzKCWMQsQTvoJF8h6gNXZAJkZn0wgsYBUAUb2XF6DvZQmAY1FElZY
         /UjQHPwoh1k7UsyyCmIrLMzQJqY1PjB0n+FaxeScPm7GBscS9v3ortSnP5BzagLtcVYN
         naqx5JtHAzBEDdPmVucKIrMwMgJHfxW/A+VIPoglE5Z6KOsYUJQIjr6oHOncMAi4Vy+9
         nftg==
X-Gm-Message-State: AOJu0Yxh27TD8sCRYKG8nJ8KDz2JyfYTOvNDaPPHLQ73F1vFiQbglwOx
	V0nArkG7z7iTgMQBIlCMtmijlg==
X-Google-Smtp-Source: AGHT+IHUFCX3JJIk/J9rRF+IfczEfnQAOfIgGfV9pGlesIPqLOOuvWVPiEgOumdShY4lDqGWH6ZC8A==
X-Received: by 2002:a05:6512:31c8:b0:4fe:279b:8a02 with SMTP id j8-20020a05651231c800b004fe279b8a02mr4217575lfe.67.1699862489839;
        Mon, 13 Nov 2023 00:01:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1bb7:80e:7bf2:f66c? ([2a01:e0a:982:cbb0:1bb7:80e:7bf2:f66c])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b004094d4292aesm7123754wmq.18.2023.11.13.00.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:01:29 -0800 (PST)
Message-ID: <7ef8c47d-d0d2-4655-95dd-8ddf4bb7c63b@linaro.org>
Date: Mon, 13 Nov 2023 09:01:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/9] meson: Use checkboard() instead of show_board_info()
Content-Language: en-US, fr
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: u-boot-amlogic@groups.io
References: <20231113030001.240020-1-sjg@chromium.org>
 <20231113030001.240020-3-sjg@chromium.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231113030001.240020-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 13 Nov 2023 08:01:37 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1867

On 13/11/2023 03:58, Simon Glass wrote:
> Boards can use a sysinfo driver if a particular model name is needed.
> Update this board to use checkboard() directly, rather than having a
> weak function laid on top of a weak function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/arm/mach-meson/board-info.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> index 2421acd817e4..95a29da07229 100644
> --- a/arch/arm/mach-meson/board-info.c
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -168,7 +168,7 @@ static unsigned int get_socinfo(void)
>   	return socinfo;
>   }
>   
> -int show_board_info(void)
> +int checkboard(void)
>   {
>   	unsigned int socinfo;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

