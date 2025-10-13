Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A9ECCD183
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 15:19:40 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.46669.1760368771769758821
 for <u-boot-amlogic@groups.io>;
 Mon, 13 Oct 2025 08:19:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FbZCUd5M;
 spf=pass (domain: linaro.org, ip: 209.85.128.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso24963165e9.0
        for <u-boot-amlogic@groups.io>; Mon, 13 Oct 2025 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760368770; x=1760973570; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyDQibH3GP02Qld7r/g/yjwGFwxvaPZIL4OlSKFyeHk=;
        b=FbZCUd5Mkfw77y1YmejmuQzmjN/YJI4DokkbpSEkrmKoNetqphK5Hp4GVn+deC3zMr
         Mo/lYtVTunayOhLamRDgdRxY330fDA7VIoLVA1saKwyMZ0P3yx20ke2ypt6d1JWgI3b4
         FjH0G0R1gxBuXm6ROOfPBsnoXW3NEsQXSQyq8v+JB8zq9QsHvlD9/1i8+elq9JuXEqL+
         9fV3p04r5U3JqQ9LC8ILwl3OodMXQxMFHBgrvS7jQgSc4Dx6M+IUPXBiDHKPOV/ukQqM
         +3Yuzhuk4eGKsPIfDassw5tzGLOIh6y85G9XmC22h0BeZMq1xRKgTQQQVO+MAwpq4e7P
         f1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368770; x=1760973570;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qyDQibH3GP02Qld7r/g/yjwGFwxvaPZIL4OlSKFyeHk=;
        b=p2vl6sDQyKm95GeVxFePXz5Wcr0s0SsuNUMT4svQBuQaLMUW0ASG3lxLoBLf5YFx+J
         Mk3wNoWlmm8c33UwK6WwAsi3TvKRnY33jjm1p1v6zzQV/7GT/JDRDg8aSQ0YQ7efFgR7
         F/Vv8Vs/pLLJ4zrUsPYw5AR1QwITAcgZsWBjORXhcW027lwKoE1PSIufEzxxrmIqWd6h
         EiSjVXn/KoOLCzKxqGCkoOng9n5haqT6ilYXkWVZS4sOOZY8Z5iUsBsKXcS77vmtq1xs
         3UTC/JAGpLtchiIzY89xRS3dlAYi2E07PU0/Tl/Y74YKHxaOG0hS5p7c1egrg3fiObKV
         SNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3ui/Bj/VqEe5Pg4uMFkq8G1biugUsBygDGV+ITBQuu0c41sKjPbZY7/V3Cp5eQ7wJxOwzqCjjf+7tz/ma4Q==@groups.io
X-Gm-Message-State: AOJu0YwHxPDyhfYXleCYpO3D/Dtzvh9qzUVGryNnNG7zokP73DogQd0Z
	8ewA7uah1fYBHOfcR/Mb9pazhzxx/yYP7FfW8fkbeZ0DJro4UGzFsNUmcSJ7JWrL5y8=
X-Gm-Gg: ASbGncuZVcSRGpOkjUzhJmhcHOkYOgK+ma3QIj8/OMskd4kHJHM+cYtJHrPEY9h0Ms2
	mvfQSKkPIF8JG4oWzo+RMCn6oC47evlfSMI/rdYChYrKLHVQxIR4VzVU48TxPJb0sXF1M9Nea0/
	qJ1uIBI/F0qCRD04TE5gQBYb9twWsOdqvb93LBYIKNhSd+YaabusUfV9XZV+Fw7QADeDfzMfXFy
	rS9rZ8FJajaQPPynAo8/XTptaZ5uBZybBzlaLF3RCACmhQiRqykCvfOJ77C4tsCKzCwrHT4eKOE
	jnLypDEF3uuMo7qrS07p2hJ3Rm3EZJFvHyqiuPK53U6uNOAyDRHD7HNgo0NsIe27FRWONcqw93m
	qm15q3yzTsYLDmSE/4OlTvjS8VvFyloHKnFaj+BikU+UDXs6wgul8/ANYi7ypUTEnVVthlfcpAQ
	SBVVWCUkyclRrcgPRPekPQFgA4b3MyBEhHSJIL+zchw14=
X-Google-Smtp-Source: AGHT+IHbjvXCpyeaQgq0b72GdntppyngaiZxgYqoIPBNCOZIW4AU2SjimyQu5qm1FYnw4VdQhXTKPA==
X-Received: by 2002:a05:600c:888d:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-46fa9b939e4mr105853285e9.0.1760368769869;
        Mon, 13 Oct 2025 08:19:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4087:80b7:cd5a:8def? ([2a01:e0a:3d9:2080:4087:80b7:cd5a:8def])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5833dcsm18698881f8f.19.2025.10.13.08.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:19:29 -0700 (PDT)
Message-ID: <e00f5976-ab51-481c-8460-07a7a945acd6@linaro.org>
Date: Mon, 13 Oct 2025 17:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] arm: meson: add support for EFI capsule updates
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ferass El Hafidi <funderscore@tauchgang.dev>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
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
In-Reply-To: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 13 Oct 2025 15:19:40 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2808

On 10/11/25 20:16, Ferass El Hafidi wrote:
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
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
> Currently EFI capsule updates are only supported on the following
> Amlogic-based boards:
> 
>   - Libre Computer AML-S805X-AC
>   - Libre Computer AML-A311D-CC
>   - Libre Computer AML-S905D3-CC
> 
> This is done with board-specific configuration in board/libre-computer/.
> 
> With this patch, EFI capsule updates can now work on most of the other
> Amlogic boards supported by u-boot, such as the Libre Computer
> AML-S905X-CC, without the need for board-specific configuration
> beforehand.
> 
> Please note that flashing to the eMMC bootX partitions is not yet
> supported.
> ---
> Changes in v2:
>   - Don't run meson_setup_capsule unless CONFIG_DFU and CONFIG_EFI_LOADER
>     are enabled
>   - Coding style fixes
>   - Return when boot device is unsupported
>   - Link to v1: https://lore.kernel.org/r/20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org
> ---
>   arch/arm/include/asm/arch-meson/boot.h |  2 ++
>   arch/arm/mach-meson/Makefile           |  2 +-
>   arch/arm/mach-meson/board-common.c     |  5 +++
>   arch/arm/mach-meson/capsule.c          | 61 ++++++++++++++++++++++++++++++++++
>   4 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
> index a11dfde719e3e48e10bcb1f6b1b84eb8586ca9e7..e66b45983fe2f5d81f83642c01502a72773213b2 100644
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
> index 535b0878b9105e7a83729bea65fa4cd70cd4beac..640921e2b8e9b4777f0b212991edea26de2987d4 100644
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
> index 39774c43049a40ed11578086603717571bedd23b..e8012604c33376ee031b89bbfcf16ef34d6dec73 100644
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
> index 0000000000000000000000000000000000000000..6e968a59c2cf26db179e11caac1eb6c3f76b2d2c
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
> ---
> base-commit: 072264c4b3406aee50dad08355588577a547ab48
> change-id: 20251007-meson-capsule-a19539e0a54e
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

