Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E518E9DE63
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 08:01:13 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.127522.1775721669847164043
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Apr 2026 01:01:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=OOsKmXMO;
 spf=pass (domain: linaro.org, ip: 209.85.128.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a041eae5so3986785e9.1
        for <u-boot-amlogic@groups.io>; Thu, 09 Apr 2026 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775721668; x=1776326468; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW2gugJkyZ22WphGeCYCMqovQKZmR9g7NH0G6lciFP0=;
        b=OOsKmXMOUiLHLZirVEmPOx2FBZMeVwC9YF2gMJ5MUvJNttorsEKhle+J/XbIKMI3Rk
         xZvFDvJE6i8jc93D0v4pSXgm9VBZ0WBk1Ign7Iqy0V0K/m7heSO7KEq0kwstOT/TAlaV
         K65IALnpVk+SPwEcM90Vizy4H2IjzYcpCP3T+Mo4yeBE+NCiADeyCUpDvb3o4q0wPe2c
         4IMH7vSePZyS4d6XHK8Q4jeFfCXxgU1x0+yi21WZ16G7GldtXBGdfKkXZbFnDgfZrYJc
         52ZUE+JL3wLn3duJNXWBWMy8mB9J/31lHztXSL24+XiA725RtO8f+GyRIgJsGCFLRHG9
         DQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775721668; x=1776326468;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW2gugJkyZ22WphGeCYCMqovQKZmR9g7NH0G6lciFP0=;
        b=W4EvcHpL3jkY6+YHo/ABC9W7i/P1hJB1Ie7iNU7dwyCjxKfszyfhubEAnmTvGp7dCJ
         66wdAdztolBrwWD+0Wv7ZekT6dkLXVSw/Me1DtCPYYEM46Xfr4th1qnyE4W3DejH30Fb
         KDmluvDgM+QBZ2uBoGJN+DV9al2sIbBp4k+qH/M7R9Fevjz+NO4z2yVDTWjTKgZYFz5B
         KqbKcikF1u5KVePXBgBE0W19pU+QfFnyYeZZXOer8Fz/udHkVLPWbmPPXxo5RSzg7NAM
         0cqX31RE1lK/NdQEG263cIpzXuhVsTK78GE3QEuS8+nMvZTjOENxEipbvH7j3R0vqYZU
         XvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6yBO4ZjunlAcg0HqNo0m4pV5UNZqeGCtoa95fhFurOSdwkw/Ohe1XQo4S0zi+xEzTxtUVto2GH134g2+yEA==@groups.io
X-Gm-Message-State: AOJu0Yw3w7Y/XdniZy5hitb5tcxigeyHEDy9+J8UfVP5GrEygBbi4ogW
	zsC9brQ6HEUpNzKjI/NwM2BqQmVkkiLbmE8yq9c+bYuml2HIN2/eUQVJ2TqiaZgqu2E=
X-Gm-Gg: AeBDiesWK4dnGnTIgBWrlyP8D9PiVEXgjOCBqplhG2i1tUiHEI+w1KhItFQDSRfWL61
	YHNiNVD+ixTkQ3OxDsKxY8WKSYY1lZ8w5gx0fJra0ok58Y67bThrk8RTCOcpOd980/zdpKFjPpx
	GkYc8d5qMzNMcS0MElqRlF9rGHi/Z5CMyLZ8iaSltilXAmOLOuhLL0RGiQNPBUDeVIdQFdTBZeY
	lJURv5WD0u06ReIkZoA3NK2X5q38t1lbAnUZQsO+12jKxSx1IAlwwNOsP0bclceP6lPCzeA32Hu
	5eZnjJxjjVfRt6IQhfUEF68vra/g6cHKzIjPtmSCRJB+++nXJQC2tvwW7PJLr2UviLGUsw01tz0
	e7y5RZm4UO2OrWscHUbjG8bQMUZIxafeaYUex4oQ6cCWTHPFfsiU4rib2QS0GdSgSgS5GpW55rw
	OftHYDOTC8HbnqhYeDrCWsFWCZdtiMqTmJOVk2KIbXxWzLYlSfJVBG42d4fxAQp6vB3i3ZuyP9W
	myeBAg=
X-Received: by 2002:a05:600c:8012:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-4889974a416mr339869645e9.11.1775721668044;
        Thu, 09 Apr 2026 01:01:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:70d5:8219:5bd4:e213? ([2a01:e0a:106d:1080:70d5:8219:5bd4:e213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cf9f350asm36818435e9.8.2026.04.09.01.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:01:07 -0700 (PDT)
Message-ID: <aea62a67-6634-4ca5-bd41-5a5de7c639be@linaro.org>
Date: Thu, 9 Apr 2026 10:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] configs: libretech-ac_defconfig: enable EFI Capsule
 on Disk
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <20260408-b4-amlogic-sysreset-capsules-v1-3-6f3386eb5124@postmarketos.org>
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
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-3-6f3386eb5124@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Apr 2026 08:01:13 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2959

On 4/8/26 22:30, Ferass El Hafidi wrote:
> Everything is already in place for EFI capsule updates, so enabling
> Capsule on Disk is fairly trivial. This allows updating U-Boot on SPI
> flash from Linux using fwupd's Capsule support.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   configs/libretech-ac_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
> index 1a67ca734b8..17d54655017 100644
> --- a/configs/libretech-ac_defconfig
> +++ b/configs/libretech-ac_defconfig
> @@ -23,6 +23,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_REMAKE_ELF=y
>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_FIT=y
>   CONFIG_FIT_SIGNATURE=y
>   CONFIG_FIT_VERBOSE=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

