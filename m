Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A86C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 15:37:06 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.145.1787845017403031966
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 08:36:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=S5Fm/uiv;
 spf=pass (domain: linaro.org, ip: 209.85.221.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f96c5b722so519124f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787845016; x=1788449816; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgmBYgNTHV2qD/YA7OW3WVfArDuUrCr7tLp8EXmTfdc=;
        b=S5Fm/uivsw29OWhe9zYzmS6mK16j7dPKbmT6Q/TBFBpHl+DXddZJlZg6t5S5Lm386N
         IajnG7xkhuUK/NwIkVgm2mUVeh/tIddsHZnidr7FZqplW1AajoOA5568ZtQr6NLu95A9
         SjfS2UdlT7I2wk8YqMNGvZ/nzirzU0PGF5XyY1yf3CdT4KduY/S2AlygmF/iNVGfSVKw
         S+PgMwghWyr6yblsO5nryaHPDfhJjNR5CGOf8J/mgHGc21jhyd2es/d2TTK8k0tKYjaj
         lT2iCUD+ZAu/VVoT6j2jJDcz3cN5YlyYdVmGyLkr8DAsruuhQFzTDAAv++8wPYI6hfBt
         oVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845016; x=1788449816;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgmBYgNTHV2qD/YA7OW3WVfArDuUrCr7tLp8EXmTfdc=;
        b=XGjEACjmptkhHj/nw9MKbVlZkaJCzDrj+twMDyTsDUIvxHhvj9YQPb/1ombyjrQ1Bt
         b9XEaxjHw1UWv9kNs9ZkkIVaKvD9nWkSvSKssbau7lAmmrrkex/S387EWEMmYeqoQMAe
         C9ciigeOZHEWVJ/Gpka1KXCe4GFM77j7XwlQTWR5URyOA1v0KO0j472S1U00rIKduv/L
         7Zcmf22wLEKSkFzE3riqxUoz6tP09wgXNGXKR64gyf22w735s1gs53fHZsxs9FIsYNQ3
         H5gJM18l2h0xngd2cilb94OmMuW2m2MXcBFuAgoanXFetKDtxrCHHlkTCSAiSG2VKWxf
         lrDQ==
X-Gm-Message-State: AFuF++ktLQWpesFAFcC2NfHmQChn91KTo9xGFLJyZ+Q/h2d6HpJSnGEx
	o4HWDJUGfseYSvfHBdO5jMNLM+jo1pEhYs8ZBuBy5ta59ePVMUYobkb+rR2QjZuP3Jo=
X-Gm-Gg: AR+sD10TuVjU4YiRRe3tkAfKYOBbpGjK8aQWpnn/VkW/XxWLgBaKiP1UwvUq2/D+4DD
	AWbbRMIpz5Qi+Asq5Kg1hZlSetv0m+qmIrJXq3qtR+imaeOXi+nIy3Nxy+iqlO+m5TEsh9owav6
	oVdtRpsgBHOHrXIzmNMxbBtFD462FGTcw9Zkars5YQ8Pew5zXsTBiDcx2fE/cS4SBcjK9fcI+3q
	xV5dXuUz04W8ku3k7s/jaJw0U3asOQZufxDLNczOIFFMFs9YFzKW2IALj21+D6cReKputXf/BZi
	r2jfMNFEcusxRwJWesRXom1Qkj69B896GZJMMmCT0UvN23l4KOwF9HC98jbG0OSKOxcRhguQq7r
	YvTnpYGTbI7axAOMRDlllx5kJ1KoKKbkzMa0h//pi3cp5ZPd18xoIIaD4+gDJVEweky1NZrVNzq
	GMraf1dSvUAdSfsqqrOqnI0pS8SyR/qbfLUn4jhjPDaEdyhUjJnNNdIgg00L/I0Cn3OD39KWcWt
	ECKckBQjUsSbZG/9u+9Cp8uSnZXvmviPpy1qz+beGMZlg==
X-Received: by 2002:adf:e009:0:20b0:47f:eb22:4d9a with SMTP id ffacd0b85a97d-482e26e47ddmr17032012f8f.22.1787845015450;
        Thu, 27 Aug 2026 08:36:55 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18? ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27ab569sm9658077f8f.16.2026.08.27.08.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:36:55 -0700 (PDT)
Message-ID: <a05aabf7-9ef2-48a7-be9f-626c49c21a26@linaro.org>
Date: Thu, 27 Aug 2026 17:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/9] arm64: meson: Add s4 SoC support
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-2-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-2-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 15:37:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3073

On 8/17/26 19:15, Sean Anderson wrote:
> Add support for amlogic s4 (S805X2/S905W2/S905Y4) SoCs. These are very
> similar to other recent SoCs, with the exception of a workaround for
> some BL2 (mis)behavior.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   arch/arm/include/asm/arch-meson/boot0.h | 14 +++++++
>   arch/arm/mach-meson/Kconfig             |  7 ++++
>   arch/arm/mach-meson/Makefile            |  1 +
>   arch/arm/mach-meson/board-s4.c          | 50 +++++++++++++++++++++++++
>   4 files changed, 72 insertions(+)
>   create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
>   create mode 100644 arch/arm/mach-meson/board-s4.c
> 
> diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
> new file mode 100644
> index 00000000000..7338171be15
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-meson/boot0.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2026 Brivo Systems LLC
> + */
> +b reset
> +#if IS_ENABLED(CONFIG_MESON_S4)
> +/*
> + * BL2 copies some keys to the start of DRAM, clobbering anything in the first
> + * 2k aside from the initial instruction. I measured the actual data clobbered
> + * as 1076 bytes, but I suspect the amount depends on the configuration, so
> + * just go with what amlogic does.
> + */
> +.skip 2048
> +#endif

How different is this boot0 with the one posted for T7 at [1] ?

https://lore.kernel.org/all/20260821084603.25974-3-tanure@linux.com/

> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index c687ef822a2..91d1e8342e0 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -67,6 +67,13 @@ config MESON_A1
>   	help
>   	  Select this if your SoC is an A113L
>   
> +config MESON_S4
> +	bool "S4"
> +	select MESON64_COMMON
> +	select ENABLE_ARM_SOC_BOOT0_HOOK
> +	help
> +	  Select this if your SoC is an S905Y4/S905W2/S805X2
> +
>   endchoice
>   
>   config SYS_SOC
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> index 08a24d4b24f..2157c35c2d5 100644
> --- a/arch/arm/mach-meson/Makefile
> +++ b/arch/arm/mach-meson/Makefile
> @@ -17,3 +17,4 @@ endif
>   obj-$(CONFIG_MESON_AXG) += board-axg.o
>   obj-$(CONFIG_MESON_G12A) += board-g12a.o
>   obj-$(CONFIG_MESON_A1) += board-a1.o
> +obj-$(CONFIG_MESON_S4) += board-s4.o
> diff --git a/arch/arm/mach-meson/board-s4.c b/arch/arm/mach-meson/board-s4.c
> new file mode 100644
> index 00000000000..7d0bea9924f
> --- /dev/null
> +++ b/arch/arm/mach-meson/board-s4.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2023 SberDevices, Inc.
> + */
> +
> +#include <asm/armv8/mmu.h>
> +#include <asm/io.h>
> +#include <linux/compiler.h>
> +#include <linux/errno.h>
> +
> +void meson_init_reserved_memory(__maybe_unused void *fdt)
> +{
> +}

No reserved memory at all on S4 ?

> +
> +int meson_get_boot_device(void)
> +{
> +	return -ENOSYS;
> +}
> +
> +static struct mm_region s4_mem_map[] = {
> +	{
> +		.virt = 0x00000000UL,
> +		.phys = 0x00000000UL,
> +		.size = 0x80000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x80000000UL,
> +		.phys = 0x80000000UL,
> +		.size = 0x7FE00000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			PTE_BLOCK_NON_SHARE |
> +			PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/*
> +		 * This mem region contains in/out shared memory with bl31,
> +		 * hence it's marked as NORMAL memory type
> +		 */
> +		.virt = 0xFFE00000UL,
> +		.phys = 0xFFE00000UL,
> +		.size = 0x00200000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			PTE_BLOCK_INNER_SHARE
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};
> +
> +struct mm_region *mem_map = s4_mem_map;


