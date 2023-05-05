Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.21117.1683269584538119925
 for <u-boot-amlogic@groups.io>;
 Thu, 04 May 2023 23:53:04 -0700
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f4000ec74aso9492835e9.3
        for <u-boot-amlogic@groups.io>; Thu, 04 May 2023 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269583; x=1685861583;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ttm8qG5BZV4GkxXFxbxzHlwBiqvXJ0Kk/d+52XlmXdk=;
        b=rt78swdCUti2iNju4zA+rkGX0xOrQHVuXnrGviyfkRExnPSkIu8zZCHRJuqUg/YF4g
         gspvX/DObHNLxxqCQhwOvRXFPtNc3tKDoYlSlNrQ46YZA4OeTVtSDi8OX4AqIxd/Mf1r
         f3o09HIQf2qLYPIXeYnwP/giNRrcnmc8SHOgjVxfDN5uW7S9Fl3++6d+ODxPo7w6+Eq5
         vkJkUtJIi7PNHi1K/Pjq+6RItuxK8gGIYFLyzEt/odqX2UVgJa/DimRiHEdd4qDEPnmU
         vfWaWqz8dgP/ESbNNQdlr6UjWDAvVPqsL0lhlQ0V239qQuP5KEOyrvCJg4t+VFmU8vRg
         hmUA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <69b1de6c-f1b8-67b6-e681-c9115d4c9dc0@linaro.org>
Date: Fri, 5 May 2023 08:53:02 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v1 3/5] ARM: meson: add A1 support
References: <20230424180151.9524-1-ivprusov@sberdevices.ru>
 <20230424180151.9524-4-ivprusov@sberdevices.ru>
In-Reply-To: <20230424180151.9524-4-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Igor Prusov <ivprusov@sberdevices.ru>
Cc: kernel@sberdevices.ru, prusovigor@gmail.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/04/2023 20:01, Igor Prusov wrote:
> Add support for Amlogic A1 SoC family.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Signed-off-by: Evgeny Bachinin <eabachinin@sberdevices.ru>
> ---
>   arch/arm/include/asm/arch-meson/a1.h | 20 ++++++++++
>   arch/arm/mach-meson/Kconfig          |  6 +++
>   arch/arm/mach-meson/Makefile         |  1 +
>   arch/arm/mach-meson/board-a1.c       | 59 ++++++++++++++++++++++++++++
>   include/configs/meson64.h            |  3 ++
>   5 files changed, 89 insertions(+)
>   create mode 100644 arch/arm/include/asm/arch-meson/a1.h
>   create mode 100644 arch/arm/mach-meson/board-a1.c
> 
> diff --git a/arch/arm/include/asm/arch-meson/a1.h b/arch/arm/include/asm/arch-meson/a1.h
> new file mode 100644
> index 0000000000..86d1a68de8
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-meson/a1.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2023 SberDevices, Inc.
> + * Author: Igor Prusov <ivprusov@sberdevices.ru>
> + */
> +
> +#ifndef __MESON_A1_H__
> +#define __MESON_A1_H__
> +
> +#define A1_SYSCTRL_BASE			0xfe005800
> +
> +/* SYSCTRL registers */
> +#define A1_SYSCTRL_ADDR(off)		(A1_SYSCTRL_BASE + ((off) << 2))
> +
> +#define A1_SYSCTRL_SEC_STATUS_REG4	A1_SYSCTRL_ADDR(0xc4)
> +
> +#define A1_SYSCTRL_MEM_SIZE_MASK	0xFFFF0000
> +#define A1_SYSCTRL_MEM_SIZE_SHIFT	16
> +
> +#endif /* __MESON_A1_H__ */
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index 6cba2c40dd..519ed563c0 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -51,6 +51,12 @@ config MESON_G12A
>   	help
>   	  Select this if your SoC is an S905X/D2
>   
> +config MESON_A1
> +	bool "A1"
> +	select MESON64_COMMON
> +	help
> +	  Select this if your SoC is an A113L
> +
>   endchoice
>   
>   config SYS_SOC
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> index a9e4046f80..535b0878b9 100644
> --- a/arch/arm/mach-meson/Makefile
> +++ b/arch/arm/mach-meson/Makefile
> @@ -6,3 +6,4 @@ obj-y += board-common.o sm.o board-info.o
>   obj-$(CONFIG_MESON_GX) += board-gx.o
>   obj-$(CONFIG_MESON_AXG) += board-axg.o
>   obj-$(CONFIG_MESON_G12A) += board-g12a.o
> +obj-$(CONFIG_MESON_A1) += board-a1.o
> diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.c
> new file mode 100644
> index 0000000000..967bb67182
> --- /dev/null
> +++ b/arch/arm/mach-meson/board-a1.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2023 SberDevices, Inc.
> + */
> +
> +#include <common.h>
> +#include <asm/arch/a1.h>
> +#include <asm/arch/boot.h>
> +#include <asm/armv8/mmu.h>
> +#include <asm/io.h>
> +#include <linux/compiler.h>
> +#include <linux/sizes.h>
> +
> +phys_size_t get_effective_memsize(void)
> +{
> +	return ((readl(A1_SYSCTRL_SEC_STATUS_REG4) & A1_SYSCTRL_MEM_SIZE_MASK)
> +		>> A1_SYSCTRL_MEM_SIZE_SHIFT) * SZ_1M;
> +}
> +
> +void meson_init_reserved_memory(__maybe_unused void *fdt)
> +{
> +}
> +
> +int meson_get_boot_device(void)
> +{
> +	return -ENOSYS;
> +}
> +
> +static struct mm_region a1_mem_map[] = {
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
> +struct mm_region *mem_map = a1_mem_map;
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index 9244601284..801cdae470 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -11,6 +11,9 @@
>   #if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
>   #define GICD_BASE			0xffc01000
>   #define GICC_BASE			0xffc02000
> +#elif defined(CONFIG_MESON_A1)
> +#define GICD_BASE			0xff901000
> +#define GICC_BASE			0xff902000
>   #else /* MESON GXL and GXBB */
>   #define GICD_BASE			0xc4301000
>   #define GICC_BASE			0xc4302000

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
