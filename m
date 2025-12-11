Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D0BD41D64
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 15:44:43 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12312.1765467875552293614
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 07:44:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fp5gbVol;
 spf=pass (domain: linaro.org, ip: 209.85.221.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so168206f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765467874; x=1766072674; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSmP6L2iOHNaoyVL/LzA2LcpYgdz6B9ort77RDUjaB8=;
        b=fp5gbVolbxSdmrHw5vk85XsdPfkUECaExWo4ZpZXrAEt1PgVdNZi/FHOMb/xj3FsRM
         TMFAorDlFVVLY+5elfULpcroreLNHnqgPMb4025ibsk5LUyBRinCGgpsmtpHb+YCx9fH
         BcTmWJLQ53HYDl4SSGIp3prm4hz6urvRfE5iRpS+MrDD0jWlKV7P0EMQiorUJLMC+06m
         8Uhd3Xnoc996f3p5k35lpxFYqjsy+0DhW9VN7W4KB9bvzuvBgvm7loWwl3QNM0LLZk12
         JsUuiqunpDV6NNdUf34k5a1Irg1RDWB8EBWsjA/V+WPU/LShgYntUOmgdC96AThdRKj2
         PXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765467874; x=1766072674;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSmP6L2iOHNaoyVL/LzA2LcpYgdz6B9ort77RDUjaB8=;
        b=H7aD4X+glBJCYF3/MpSUknoP/VLUzk8ypiL3SSD9oWR2hEaz1g2yE95T8AkOFnyc3q
         9SpiUWlgyayWr/VboPLUE+utLjnfD6+4tNMicXvmH4s4YDgjpP2uRPoTPGqu+/xLxU70
         /o3e5uH9LWHhnvQ6AdfHAhqsW8EhS3tXjYP4l7WlIe9WZDW0RVdORmqeennjlPQf15g8
         juM2Y1+qdY/Y9Vhx1X9/u22GCIvtBKjOaHGKGe+WMp/pRkcITrAigYGVlOvWkXfxfCP4
         MYkAhRGb8VnLA8Ft64G3rahaKRRauwPZVDEb+FW0sDx48WpgVNATYZnRdYuyoLhtQn4q
         wFOA==
X-Forwarded-Encrypted: i=1; AJvYcCWIDiAOPBQeVaR7S17yuNu2/stfCtxl6jxvRolrrH05LSq/1BEv9YJjJG6owf0aEZtZPegqGdBsLVz5zgYYWQ==@groups.io
X-Gm-Message-State: AOJu0YzT/xMP3Qe2+BOwVSqYEX+FLPrSvperAgjtkQ3moGfvONGWFf0w
	32GSWqKnM6z91RwSO2fWUFk3kbGmTIeT9mRBjblfBwkQtRFxceRgUAPwAb7i8I9ysUc=
X-Gm-Gg: AY/fxX6KjEb6YygzkH+bUC8U6Z6RbfE6bV/tsQxrX38QlXyXe2/lgtA+ueT3DWoMEL9
	H6ZoCGK8r4r+lK7AOr12zHoJA1p7hpxncw8PhQbLeecZpAi/Sj5Fy09eFdgPBWyktJOrf1lP4FX
	U/rFQqdzqnvxwu4yx0CskdqNwn2Lxmv1IjQ7jI47+sUgp0urgEZH2HmS/UWSuP+hOCo46SBLwi4
	RbsPMKBUFhWVC1tK/DksP018w3l2vuY7msdaiixje6342n6UXuINI0QDt3NJw3K+WMmFjTCDPO7
	F28hEFRBE30zftaKK05yamgs3XVeo2fjqGNvtR6gEzV3xbtx4Xi2HvNl5YrAuXAzvimIEmavv/S
	jxD26/LZbzBc/0j60nuhT+gFOu//mrJo9wddneVJ4alnHmp0gL61s3H0LrfYWWzkblMAaJIj9Zy
	W9ziGtsO2EU6aXnQHPsu06VWGa2ZAAx44zxpYVDc5v5AB83oUwSHbKl4EfRHbh
X-Google-Smtp-Source: AGHT+IGguGZ4yBGf4wrdpXTHxWWYAILOYd/nnhWz9ZZDopBy2rKc11tgve2pYoY7VE4gKZXezkfS5w==
X-Received: by 2002:a05:6000:2586:b0:42b:32d1:28ae with SMTP id ffacd0b85a97d-42fab276f4dmr2825763f8f.22.1765467873648;
        Thu, 11 Dec 2025 07:44:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6? ([2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b96c70sm6290268f8f.37.2025.12.11.07.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 07:44:33 -0800 (PST)
Message-ID: <7a30f8de-c87b-46e3-83e9-6d61484b2ecb@linaro.org>
Date: Thu, 11 Dec 2025 16:44:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/2] arm: meson: add support for EFI capsule updates
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ferass El Hafidi <funderscore@tauchgang.dev>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
 <20251211-meson-capsule-v4-1-59f126ba4115@postmarketos.org>
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
In-Reply-To: <20251211-meson-capsule-v4-1-59f126ba4115@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 15:44:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2876

On 12/11/25 16:37, Ferass El Hafidi wrote:
> Previously, few Amlogic devices supported EFI capsule updates.
> Generally only the Libre Computer ones with SPI flash supported it,
> thanks to board-specific code.
> 
> This commit commonises capsule update support across supported
> Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
> and firmware name is automatically generated at runtime depending on
> which device we are booted from.  Right now this supports flashing to
> the eMMC/SD and SPI flash.
> 
> As usual, the capsule UUID is automatically generated.  You can get it
> by enabling CONFIG_CMD_EFIDEBUG and running:
> 
> 	=> efidebug capsule esrt
> 	========================================
> 	ESRT: fw_resource_count=1
> 	ESRT: fw_resource_count_max=1
> 	ESRT: fw_resource_version=1
> 	[entry 0]==============================
> 	ESRT: fw_class=796180D4-AAB2-50F1-B16A-53DFF9CA89B2
> 	ESRT: fw_type=unknown
> 	ESRT: fw_version=0
> 	ESRT: lowest_supported_fw_version=0
> 	ESRT: capsule_flags=0
> 	ESRT: last_attempt_version=0
> 	ESRT: last_attempt_status=success
> 	========================================
> 
> Reviewed-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/include/asm/arch-meson/boot.h |  2 ++
>   arch/arm/mach-meson/Makefile           |  2 +-
>   arch/arm/mach-meson/board-common.c     |  5 +++
>   arch/arm/mach-meson/capsule.c          | 61 ++++++++++++++++++++++++++++++++++
>   4 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
> index a11dfde719e..e66b45983fe 100644
> --- a/arch/arm/include/asm/arch-meson/boot.h
> +++ b/arch/arm/include/asm/arch-meson/boot.h
> @@ -21,6 +21,8 @@ int meson_get_boot_device(void);
>   
>   int meson_get_soc_rev(char *buff, size_t buff_len);
>   
> +void meson_setup_capsule(void);
> +
>   /**
>    * meson_get_socinfo - retrieve cpu_id of the Amlogic SoC
>    *
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> index 535b0878b91..640921e2b8e 100644
> --- a/arch/arm/mach-meson/Makefile
> +++ b/arch/arm/mach-meson/Makefile
> @@ -2,7 +2,7 @@
>   #
>   # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
>   
> -obj-y += board-common.o sm.o board-info.o
> +obj-y += board-common.o sm.o board-info.o capsule.o
>   obj-$(CONFIG_MESON_GX) += board-gx.o
>   obj-$(CONFIG_MESON_AXG) += board-axg.o
>   obj-$(CONFIG_MESON_G12A) += board-g12a.o
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index 39774c43049..e8012604c33 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -145,6 +145,11 @@ int board_late_init(void)
>   {
>   	meson_set_boot_source();
>   
> +	if (CONFIG_IS_ENABLED(DFU) && CONFIG_IS_ENABLED(EFI_LOADER)) {
> +		/* Generate dfu_string for EFI capsule updates */
> +		meson_setup_capsule();
> +	}
> +
>   	return meson_board_late_init();
>   }
>   
> diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule.c
> new file mode 100644
> index 00000000000..6e968a59c2c
> --- /dev/null
> +++ b/arch/arm/mach-meson/capsule.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
> + */
> +
> +#include <asm/arch/boot.h>
> +#include <dm.h>
> +#include <efi_loader.h>
> +#include <mmc.h>
> +
> +/*
> + * To be able to support multiple devices and flash to the correct one we need
> + * to automatically generate the dfu_string and fw_name to match the device we
> + * are booted from. This is done by meson_setup_capsule() which is then called
> + * in board_late_init(). Right now we support EFI capsule updates on SPI flash,
> + * eMMC and SD cards.
> + */
> +struct efi_fw_image fw_images[] = {
> +	{
> +		.image_index = 1,
> +	},
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +	.dfu_string = NULL, /* to be set in meson_capsule_setup */
> +	.num_images = ARRAY_SIZE(fw_images),
> +	.images = fw_images,
> +};
> +
> +/*
> + * TODO: Support usecase e.g. FIT image on eMMC + SPL on SD.
> + */
> +void meson_setup_capsule(void)
> +{
> +	static char dfu_string[32] = { 0 };
> +	int mmc_devnum = 0; /* mmc0 => SD card */
> +	u32 max_size = 0x2000; /* 4 MB (MMC sectors are 512 bytes each) */
> +	u32 offset = 0x1; /* offset for flashing to eMMC/SD */
> +	int boot_device = meson_get_boot_device();
> +
> +	switch (boot_device) {
> +	case BOOT_DEVICE_EMMC:
> +		mmc_devnum = 1; /* mmc1 is always eMMC */
> +		fallthrough;
> +	case BOOT_DEVICE_SD:
> +		snprintf(dfu_string, 32, "mmc %d=u-boot.bin raw %d %d", mmc_devnum, offset, max_size);
> +		fw_images[0].fw_name = u"U_BOOT_MESON_MMC";
> +		break;
> +	case BOOT_DEVICE_SPI:
> +		/* We assume there's only one SPI flash */
> +		fw_images[0].fw_name = u"U_BOOT_MESON_SPI";
> +		snprintf(dfu_string, 32, "sf 0:0=u-boot.bin raw 0 %d", max_size);
> +		break;
> +	default:
> +		debug("setup_capsule: Boot device %d unsupported\n", boot_device);
> +		return;
> +	}
> +	debug("EFI Capsule DFU string: %s", dfu_string);
> +
> +	update_info.dfu_string = dfu_string;
> +}
> 

Wait this means all boards uses the same GUID ?

Neil

