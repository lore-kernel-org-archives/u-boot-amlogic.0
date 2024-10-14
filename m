Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F110BCFC500
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:04:42 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.48844.1728889479396712474
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 00:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=HnNQEx+x;
 spf=pass (domain: linaro.org, ip: 209.85.167.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso401604e87.1
        for <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728889477; x=1729494277; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LB0NjvVliXVy3j/E/5uxvWytto9G9Ym5xsN5Cx/p2ec=;
        b=HnNQEx+xJH6fgbss0NI2a1Qtk+TlO1JW3YPzzu9jHuPUda0+DLdVDR5PQxkg6lVgpQ
         6fSfnd8iUSCV7DBMTYb5LpnM/zpk1/HiyBe0ottndp4KaIjvzVD0JUssBt9Tw+A5wasz
         9XxQVjVGhRmuv2Q62QFPT0I3aVJWPyanCVYZLAWUDbovYHA7ZFtig7dc+EeHqOrFNk9J
         LQZlzkLAGOHKO/53sBghWQSWvxx5is2CV2/FywoaagQ9wwZFxHXY4tJicqBXDa8FMorE
         hkXaqBlZqdYFqcaCKsbbp0+6H50aldFBSnomhwu3kFxJGeuV2rYJDriulOvTw0PYbYwu
         RxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889477; x=1729494277;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LB0NjvVliXVy3j/E/5uxvWytto9G9Ym5xsN5Cx/p2ec=;
        b=dVi4A7JDPqINkp0072eqJVGmferEXcAq9c9BUP4i9pJNq9bX4JiDml7qfE0t+G+D0X
         t50NRgtIK0NJli9Fc4LeLxquuESSXpsKplBRrNUoe/L/vQzsZ4su7xhe5sCPicFxhFcc
         KJA8jqCpagJaIPyDBhGjeIO7ys1ehUuJpPA7F1pAf5iQCGjy4K8AMkEoq9830dz6wWs4
         Mk2DwJRNdjPRCeQacJvyB9x5CikQiD8Su0cH9h/MzYVdiEzML/yuVbiPhqQXYVE7wBXX
         5TMZ1S51IINaLqbE1MeEKwFBKzJVS3NHjGZKx0AzvGCHQ6C8BTx5FoQDKJ7+O/QCcyFK
         J4mQ==
X-Gm-Message-State: AOJu0YwuVNPXZQ+u/eCe+zGAS0XAFDeFUG/b/VQHOS4DbN5EvEACPVRD
	LdQVzHl9r5T5hN4PffKjpspDzbkZWDsWBft1/9CeNH0Mpjuj0wywAC2g6k+q8kwkTXcCETGrvkY
	Xy7I=
X-Google-Smtp-Source: AGHT+IHVps2wYaLYBptWAsLdL7rUgVrcuocoSTyEpKZvk77lXDs1X3lrHiJJy2YfD3vANr7S82YfUQ==
X-Received: by 2002:a05:6512:1252:b0:539:e3a5:4fc7 with SMTP id 2adb3069b0e04-539e3a55072mr3144741e87.59.1728889477080;
        Mon, 14 Oct 2024 00:04:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bf3:bb7:467:a56f? ([2a01:e0a:982:cbb0:6bf3:bb7:467:a56f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183567c8sm111904635e9.38.2024.10.14.00.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 00:04:36 -0700 (PDT)
Message-ID: <c69ead35-fec6-461a-b889-fd353857b4cd@linaro.org>
Date: Mon, 14 Oct 2024 09:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] configs: meson64: Ensure commands for boot targets are
 available
To: u-boot-amlogic@groups.io, callum@neoninteger.au
References: <20241012080340.2596-1-callum@neoninteger.au>
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
In-Reply-To: <20241012080340.2596-1-callum@neoninteger.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:04:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2479

On 12/10/2024 10:03, Callum Parsey via groups.io wrote:
> When populating BOOT_TARGET_DEVICES on Amlogic Meson platforms, verify
> that the shell commands for accessing the relevant media have been
> enabled in the build configuration.
> 
> This was already being done for USB, NVME and SCSI devices, but not
> for MMC devices or network boot. This meant that configuring U-Boot
> without the networking or MMC subsystems/drivers would cause an error
> to be thrown during preprocessing.
> 
> Signed-off-by: Callum Parsey <callum@neoninteger.au>
> ---
>   include/configs/meson64.h | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index ccb8ea2e71..f3275b37a5 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -77,6 +77,15 @@
>   	#define BOOTENV_DEV_NAME_USB_DFU(devtypeu, devtypel, instance)
>   #endif
>   
> +#ifdef CONFIG_CMD_MMC
> +	#define BOOT_TARGET_MMC(func) \
> +		func(MMC, mmc, 0) \
> +		func(MMC, mmc, 1) \
> +		func(MMC, mmc, 2)
> +#else
> +	#define BOOT_TARGET_MMC(func)
> +#endif
> +
>   #ifdef CONFIG_CMD_USB
>   #define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
>   #else
> @@ -95,18 +104,27 @@
>   	#define BOOT_TARGET_SCSI(func)
>   #endif
>   
> +#if defined(CONFIG_CMD_DHCP) && defined(CONFIG_CMD_PXE)
> +	#define BOOT_TARGET_PXE(func) func(PXE, pxe, na)
> +	#define BOOT_TARGET_DHCP(func) func(DHCP, dhcp, na)
> +#elif defined(CONFIG_CMD_DHCP)
> +	#define BOOT_TARGET_PXE(func)
> +	#define BOOT_TARGET_DHCP(func) func(DHCP, dhcp, na)
> +#else
> +	#define BOOT_TARGET_PXE(func)
> +	#define BOOT_TARGET_DHCP(func)
> +#endif
> +
>   #ifndef BOOT_TARGET_DEVICES
>   #define BOOT_TARGET_DEVICES(func) \
>   	func(ROMUSB, romusb, na)  \
>   	func(USB_DFU, usbdfu, na)  \
> -	func(MMC, mmc, 0) \
> -	func(MMC, mmc, 1) \
> -	func(MMC, mmc, 2) \
> +	BOOT_TARGET_MMC(func) \
>   	BOOT_TARGET_DEVICES_USB(func) \
>   	BOOT_TARGET_NVME(func) \
>   	BOOT_TARGET_SCSI(func) \
> -	func(PXE, pxe, na) \
> -	func(DHCP, dhcp, na)
> +	BOOT_TARGET_PXE(func) \
> +	BOOT_TARGET_DHCP(func)
>   #endif
>   
>   #define BOOTM_SIZE		__stringify(0x1700000)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

