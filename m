Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4B1E9DE64
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 08:01:33 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.127531.1775721688254085488
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Apr 2026 01:01:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=oq+yKHrm;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488971db0fdso5757625e9.0
        for <u-boot-amlogic@groups.io>; Thu, 09 Apr 2026 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775721687; x=1776326487; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WovDVeh3PfdLfhBuKK3xsVS9Ihwbt34LuFpYycxeOsw=;
        b=oq+yKHrmzAuad/uegSmyWgLeqjlB7I8pn0oMEWTMB3S4rK+Q1OJO05sSb6BygZylOe
         3rAMhWM/nJ05fMmNYjS59aQXEa7EtobU90lhkAY6vIcK9bp2SDKByxlfbG1ZWzWzmx/f
         ywLSZ4Tk2X/mu3I6+KF71UT31qQW5+fHETPphGh+45X8gtQkSzDnkbcBlHCKNEhtBLNS
         MxPc5jejCERBWylBarVSPxFgf+sPoBS8mGHgZCYAg2X04HqGATsNtRMaArh/sozc2Zqb
         oxeju3VTKSm/Eoz0TbSaJvI1LsOizZKhrsdAUYk+KH5zFDxhEmPy2Zy/pe/6sOO9I0fS
         Uxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775721687; x=1776326487;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WovDVeh3PfdLfhBuKK3xsVS9Ihwbt34LuFpYycxeOsw=;
        b=tEWc6I6dXVnySxgNAynupbSlYD/DM93c+xyfJ73lvlJ2H3RGi9AmLslgJuXP1NLieN
         y7qlmdAkfvGqTGwUBrfSEevX578pK3FwcxBvN75Wo0kQiHELyOF/F3CsjaRmr3xf/V4J
         ws6ZGlOLRu8MSRZsHyCYti1kJZkjPX9PBumQC2h8iPUkmg0JTe/BXLRr5AKroCeyQOy3
         t84czDBnujxpoJsWcUn4cRvVZ+MPek6oit+RvpIlbSCmqNDrYtahVpexuq7u3eWMneIV
         +EXO0esmnZGGR7vc1dvA2KlKuxauOh5pRMqBQlMc+BxLvhtT8a5lZAmdlGj8ud4AFB7j
         +2rw==
X-Forwarded-Encrypted: i=1; AJvYcCVsaFN/WGttGrMN8VUaG+Ha8YFGKYl5KA5ZWFHip5rXHFFgZ5rrV5soQQa57H8mPKVIZezxFmYiSsYxbksgxw==@groups.io
X-Gm-Message-State: AOJu0YwCCwMmVPScW0AnmEWbbhe+jUiko6PXtS4P7ZvbxotaXjFbscYE
	Mqrf0GVlEe7unKrz7FV9QMdU5Jw/67njrvSCEanCMAeGbqp4PWInE9q6LaxDYzwPr88=
X-Gm-Gg: AeBDieskjYQJzuHOoGwkK08IjNnjanVTpUsMgN2RFPR6ViY5cz6RCq0HraBP06y0V5q
	gWhJZqegyc63ajJ6iQuL8RnZRVHNY/ZfMvDkzcdJt0UgVH6VFPtRtpAkEsV+vp49M4uZanDnv5B
	81ROyQ1k8Wms1e0pIxeOCK7buRMP8SDtuQ9d6On+pk6Jov/5vIWKvOgU7tK4hd5LQ3uTr+6ursG
	bzr6r4CsiNadVpIDmuR/rMRgy1+VnjU7aUkuK1FYA9WPLdSQ8fDQc3ydkidCKjtJy8HlvdjDYZ6
	QoxpKlTKz4nCIULtxTmaXf/RLspAGZhzG7k8PqexWy5XJ4qielLRFHOZV81xT9kDGMtwyT9uIcf
	7/IjPNM/08uYKBFrtx6ICNLR1odGXtxOegrWajgHMKEwPrS6wFyqx8tG1nEbIHUobVJJj3+z09q
	bWSIMeNlaqp7rF3zlgPT0KARpl4i+TDOLnJMhkIXpHklSfn2VRW+10BfM+gFTFY2Dp4xjril9Z4
	mWTfm8=
X-Received: by 2002:a05:600c:1e0f:b0:488:b1c7:b432 with SMTP id 5b1f17b1804b1-488cd059947mr34737285e9.24.1775721686450;
        Thu, 09 Apr 2026 01:01:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:70d5:8219:5bd4:e213? ([2a01:e0a:106d:1080:70d5:8219:5bd4:e213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd19ea6fsm53527035e9.2.2026.04.09.01.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:01:25 -0700 (PDT)
Message-ID: <65597f02-0d66-4bef-9cd1-05c0ff227eb9@linaro.org>
Date: Thu, 9 Apr 2026 10:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/4] configs: libretech-cc_defconfig: enable EFI Capsule
 on Disk
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <20260408-b4-amlogic-sysreset-capsules-v1-4-6f3386eb5124@postmarketos.org>
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
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-4-6f3386eb5124@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Apr 2026 08:01:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2960

On 4/8/26 22:30, Ferass El Hafidi wrote:
> Everything is in place to allow this board to support EFI Capsule updates.
> Enable everything needed to support Capsule updates, as well as Capsule
> on Disk. All this allows updating U-Boot on eMMC directly from linux using
> fwupd. Also enable DFU_MMC, which is a requirement for EFI Capsule flashing
> to eMMC/SD to work.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   configs/libretech-cc_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
> index d5878bdc431..622922e97ee 100644
> --- a/configs/libretech-cc_defconfig
> +++ b/configs/libretech-cc_defconfig
> @@ -16,6 +16,9 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_IDENT_STRING=" libretech-cc"
>   CONFIG_DEBUG_UART=y
>   CONFIG_REMAKE_ELF=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_FIT=y
>   CONFIG_FIT_SIGNATURE=y
>   CONFIG_FIT_VERBOSE=y
> @@ -38,6 +41,7 @@ CONFIG_OF_CONTROL=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_DFU_RAM=y
> +CONFIG_DFU_MMC=y
>   CONFIG_MMC_MESON_GX=y
>   CONFIG_PHY_MESON_GXL=y
>   CONFIG_DM_MDIO=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

