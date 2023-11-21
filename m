Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFCC54FB9
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 09:18:08 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.35969.1700558287392877908
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Nov 2023 01:18:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=BOchzGzm;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso3423560f8f.2
        for <u-boot-amlogic@groups.io>; Tue, 21 Nov 2023 01:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700558286; x=1701163086; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=In9SnW6V42J9lK1zUchnAXRX4VyoLJCwhg874RYUt90=;
        b=BOchzGzm7GgPltR/6pAnwAivKTZoZm/BMAS1jz278cKx7yxhVxSF6Lad6lufydPUAR
         npkwUaV3W5LFsJo9JPye7MwbT4+BbbLJIISS+xqzbPwaFWbzU0TlQw5vXrz7GOv5AYdB
         gCzRl0dZXBqrS4xO7weN46lLtPq5vTAUCQXogC5U8RIu4VBZvLH92YA7z7UrLJOMOymb
         tguZ+Bje4Td3YCMdLQcUHJePWELIZ0PYwbaSZNxjP0gVGl6oD86JX083uCGargYXHPIl
         E+7GK61nIlBYBTOX4aW0bbxd3oyrABq8m0FT4oUXi5luuj1ygXZ3wzOSs3c8U2ykMf9H
         MieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558286; x=1701163086;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=In9SnW6V42J9lK1zUchnAXRX4VyoLJCwhg874RYUt90=;
        b=WF0mAbToZLHI8zoUZPIJGQJ17pWZCrtY42Y7uq7oQBi9oNoS977h5e48ZuYHw/bt84
         8tTL6tVhwtwCdjtScq6XsrqxXLoC54XP5wCoSXn0dTtwy9AlBdKiyETBO/UpkC/b0g1L
         4rR1u63Lhlde1N0GPu1NLdSbsJhm2gD3MsytfFcbThuLJIvgbaKZfNgmhBM6rtTDlTUt
         7B0MU9iOfB6CLUzyNeeOlJIG6jRYsgvbvJcNdAY4esVssdRmZe0+2AdyLcj33RsiWimJ
         GdHqeBnUwv/3dITmOSLerXxs6PTdfVPRiBkNMRxVdGzCBln0FViDCmjdwMdgNotdlzwM
         IFpw==
X-Gm-Message-State: AOJu0YxmrsrIpu8CkzHIy0veNATkZA8hCrP2S1DJpr1XOV4zSK8DWhYp
	uoX6mABkKSY6KFsCgobGoVFAvTHIY3OlsPbiwrQolFws
X-Google-Smtp-Source: AGHT+IFh1j3TmFbCNxOBS+eQs3WV7FIaJmy/wpDmCZI8cRh0wpzDULN5/Nr/hxnnqnHg3m8ui1ojSQ==
X-Received: by 2002:a05:6000:178b:b0:332:cb20:ddc2 with SMTP id e11-20020a056000178b00b00332cb20ddc2mr2923477wrg.40.1700558285741;
        Tue, 21 Nov 2023 01:18:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a39:bc19:20b6:16a? ([2a01:e0a:982:cbb0:2a39:bc19:20b6:16a])
        by smtp.gmail.com with ESMTPSA id d1-20020adfe841000000b00332cfd83b8dsm122642wrn.96.2023.11.21.01.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 01:18:05 -0800 (PST)
Message-ID: <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
Date: Tue, 21 Nov 2023 10:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
Content-Language: en-US, fr
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
References: <20231120201609.619598-1-trini@konsulko.com>
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
In-Reply-To: <20231120201609.619598-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 21 Nov 2023 09:18:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1878

Hi Tom,

On 20/11/2023 21:16, Tom Rini wrote:
> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
> eventually display this information
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Posting this as this was the easiest platform for me to test some SMBIOS
> related patches on and I needed to populate the nodes so I could check
> things in dmidecode once Linux was up.

Sorry to be late a the party, but can't this be dynamically found from DT's compatible & model ?
Since I'll probably need to add this to all boards, it seems like a duplicate of what's already in the DT.

> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: u-boot-amlogic@groups.io
> ---
>   .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  | 23 +++++++++++++++++++
>   configs/libretech-cc_defconfig                |  2 ++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
> index 39270ea71c8b..e56cd67a9d91 100644
> --- a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
> @@ -5,3 +5,26 @@
>    */
>   
>   #include "meson-gxl-u-boot.dtsi"
> +
> +/ {
> +	smbios {
> +		compatible = "u-boot,sysinfo-smbios";
> +
> +		smbios {
> +			system {
> +				manufacturer = "libre.computer";
> +				product = "Le Potato";

I'll use the real product identifier here instead: AML-S905X-CC

Here's the downstream vendor change:
https://github.com/libre-computer-project/libretech-u-boot/commit/cb68b838f1b80ad201ec02f04d2841ee535b9818

> +			};
> +
> +			baseboard {
> +				manufacturer = "libre.computer";
> +				product = "Le Potato";
> +			};
> +
> +			chassis {
> +				manufacturer = "libre.computer";
> +				product = "Le Potato";
> +			};
> +		};
> +	};
> +};
> diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
> index baa9b1b3dbc5..24a46f50d0d9 100644
> --- a/configs/libretech-cc_defconfig
> +++ b/configs/libretech-cc_defconfig
> @@ -55,6 +55,8 @@ CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_MESON_SERIAL=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y

Thanks,
Neil


