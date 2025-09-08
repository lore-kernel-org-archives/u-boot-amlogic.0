Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC6CA1016
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 08:24:42 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.7826.1757319876429926362
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Sep 2025 01:24:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=laK8bz6q;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de5f4a06aso5670905e9.3
        for <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757319875; x=1757924675; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnzenqS4E6o+VFXzQWOSQ5nOZLI1HnEZPe6TYWpqvvg=;
        b=laK8bz6qfu8IBvd9j3lVi4YxhDhrhQ2qrFYpqlr/4HaX6vzDVKWzKzc86hLZNZ8AZy
         UCpJ5FBpGz4Re7dHOqJWOtnZEW0iXptgqqTeVMxAp4PAGonf49LJZQaRhC8eGlf0qPoy
         if2JZ4ZVZY/RwdiMgOwhjnIG1fly+IUR/lnppBu0zmGvf60aEszQ70bB16AIu1XWzLPD
         RQrtD30e4AlwzPEroauQMD/PRWjO9xytWosGoHBZMC7nhGocy6OTn/jvMxNkbnRXEHy9
         e+B7KPVM07HmCXnrs+4vKKJ21qeq3+QXI9EbRU6+S2HeVfo1xefjgZL14k7kuPGUANJ0
         CwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319875; x=1757924675;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CnzenqS4E6o+VFXzQWOSQ5nOZLI1HnEZPe6TYWpqvvg=;
        b=kWJs0FUEiEGeBFrnA43dk3SgSlK4IWlkUdi7VYztxc4OnQwPd+OuRR45JNu9bNjlhD
         a6EI06loUCyi52IK5urSTtdb0Ns2wh4IsuxFythcmN4FdOrmAeuJ8rdsS11sQOAc40gN
         ybYvxDXlj27C2Txo+fx5s+pRKj1L/wF80ySN/fEDgLBTZMb/lRJ+XKu8A62w3T5zJY2V
         i/LlHsKz79JTzyEqwrCowTgqnQb06+XpsV/USPGBQkGPY69OVTjcOxNwYWiEKd4GYeu9
         Qh5P371sezvqvUdjiepL+45AkM1ox02BPdqb901lMFXk5B1LTWUr2rMwMNboq1k5Uk3m
         8gdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwdcdkorKXQNmLB1ZSFnvei/3purI8pgfDVBLz1/JhWiriqvRUpNYwWbqBWJkNB7zaxh2ItgCoA/heh58uTQ==@groups.io
X-Gm-Message-State: AOJu0YyV38A4ZE4nQ/PPqjtfZnSgA05z88DPGvVFiFIZarE3Um9EpW25
	eXGzZqAeIWumhsOMaaEEd09qZk9yhgr+IdWrQ3Fj3M5bvm46lOEZ8TYXQhLe2tmGfTdmUaQ2hIW
	CxXj9Yk0=
X-Gm-Gg: ASbGnctszoRFA4JBx25ovakHsVqTTR5e3ybFkM+6EHHiH+/3s7XKMmOA4+3ZyxcDig+
	IMQh4L+rA511U3QajN5noKm0mFoyHYQ5q6qCSBeZZDXuIFrLVdcWK1kOEmLK5zLLHyTtILQRQZD
	fp7EODvKM/Omy2AmWeNQ3KSoLwQdjT1BtNHXFKV9c6YbZi91PyepA3av/7C6tJYedGw757mK/3m
	ZXv9RvnAY+qMyFcpnVlRl09sLlZFzP+QJck3MDBAEH9WeSE7TqAo9yLQRdrUUv9SFZZv2fvnba3
	tMhiptMs7y5qNHIaAq3Yr9PR5XJw8CohKTtc1FILGlA3hdefvJiHql708lTd1nQbFWkoxPEc7yD
	corqbsEhy0B5Rv8XYQ6B4MfEfc4i4nFSARA1j0VKu84hkVT6JoiA3Ju7THfiSO7BHVipaqIy/Ks
	5mFoVuh8bTTA==
X-Google-Smtp-Source: AGHT+IHeO417sBMTk0Z6CG8kzHZcR/JaL615xXI/kqCvuvg99g2RWB60qff7cNEnDyQH7UBDb4Gd1Q==
X-Received: by 2002:a05:600c:34cb:b0:45d:e0cf:41c9 with SMTP id 5b1f17b1804b1-45de0cf447fmr48285585e9.22.1757319874459;
        Mon, 08 Sep 2025 01:24:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcff67787sm183183005e9.16.2025.09.08.01.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:24:34 -0700 (PDT)
Message-ID: <b6d9c116-f37d-4793-ba53-f94ed95130dd@linaro.org>
Date: Mon, 8 Sep 2025 10:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 5/9] arm: meson: initial u-boot SPL support for GX
 SoCs
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-5-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-5-37395d9ff5af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 08:24:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2757

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> Add initial boilerplate for U-Boot SPL support on Amlogic.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/include/asm/arch-meson/clock-gx.h |   1 +
>   arch/arm/include/asm/arch-meson/gx.h       |  36 ++++
>   arch/arm/mach-meson/Kconfig                |  42 ++++-
>   arch/arm/mach-meson/Makefile               |   5 +
>   arch/arm/mach-meson/board-common.c         |  11 ++
>   arch/arm/mach-meson/spl-gx.c               | 278 +++++++++++++++++++++++++++++
>   arch/arm/mach-meson/spl.c                  | 123 +++++++++++++
>   7 files changed, 495 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/clock-gx.h b/arch/arm/include/asm/arch-meson/clock-gx.h
> index 13a2e7688fc569d8a217b424306570514ab011f4..23678230242be15476f6330ffd4e4658941b8330 100644
> --- a/arch/arm/include/asm/arch-meson/clock-gx.h
> +++ b/arch/arm/include/asm/arch-meson/clock-gx.h
> @@ -87,6 +87,7 @@
>   #define HHI_VDAC_CNTL0			0x2F4 /* 0xbd offset in data sheet */
>   #define HHI_VDAC_CNTL1			0x2F8 /* 0xbe offset in data sheet */
>   
> +#define HHI_SYS_PLL_CNTL1		0x2fc /* 0xbf offset in data sheet */
>   #define HHI_SYS_PLL_CNTL		0x300 /* 0xc0 offset in data sheet */
>   #define HHI_SYS_PLL_CNTL2		0x304 /* 0xc1 offset in data sheet */
>   #define HHI_SYS_PLL_CNTL3		0x308 /* 0xc2 offset in data sheet */
> diff --git a/arch/arm/include/asm/arch-meson/gx.h b/arch/arm/include/asm/arch-meson/gx.h
> index 8cfc6b00329f252bbf452dba00f8ad56b480c707..b4cb2a5ddbc9cef5d9133339c12aaa5bb62b4721 100644
> --- a/arch/arm/include/asm/arch-meson/gx.h
> +++ b/arch/arm/include/asm/arch-meson/gx.h
> @@ -12,7 +12,10 @@
>   
>   #define GX_FIRMWARE_MEM_SIZE	0x1000000
>   
> +#define GX_MB_SRAM_BASE		0xd9013800
>   #define GX_AOBUS_BASE		0xc8100000
> +#define GX_SEC_HIU_MB_BASE	0xda83c400
> +#define GX_SEC_AOBUS_BASE	0xda100000
>   #define GX_PERIPHS_BASE	0xc8834400
>   #define GX_HIU_BASE		0xc883c000
>   #define GX_ETH_BASE		0xc9410000
> @@ -24,6 +27,10 @@
>   #define GX_AO_SEC_GP_CFG3	GX_AO_ADDR(0x93)
>   #define GX_AO_SEC_GP_CFG4	GX_AO_ADDR(0x94)
>   #define GX_AO_SEC_GP_CFG5	GX_AO_ADDR(0x95)
> +#define GX_AO_SEC_SD_CFG15	GX_AO_ADDR(0x8f)
> +
> +#define GX_SEC_AO_ADDR(off)	(GX_SEC_AOBUS_BASE + ((off) << 2))
> +#define GX_SEC_AO_SEC_GP_CFG0	GX_SEC_AO_ADDR(0x90)
>   
>   #define GX_AO_BOOT_DEVICE	0xF
>   #define GX_AO_MEM_SIZE_MASK	0xFFFF0000
> @@ -41,9 +48,38 @@
>   #define GX_GPIO_IN(n)		GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 1)
>   #define GX_GPIO_OUT(n)	GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 2)
>   
> +/* Mailbox registers */
> +#define GX_SEC_HIU_MB_ADDR(off)	(GX_SEC_HIU_MB_BASE + ((off) << 2))
> +#define GX_SEC_HIU_MAILBOX_SET_0	GX_SEC_HIU_MB_ADDR(0x01)
> +#define GX_SEC_HIU_MAILBOX_STAT_0	GX_SEC_HIU_MB_ADDR(0x02)
> +#define GX_SEC_HIU_MAILBOX_CLR_0	GX_SEC_HIU_MB_ADDR(0x03)
> +
> +/* Mailbox commands */
> +#define GX_MB_CMD_SHA	0xc0de0001
> +#define GX_MB_CMD_DATA	0xc0dec0de
> +#define GX_MB_CMD_END	0xe00de00d
> +#define GX_MB_CMD_OP_SHA	0xc0de0002
> +#define GX_MB_CMD_DATA_LEN	0xc0dec0d0
> +
> +/* PIN_MUX registers */
> +#define GX_PIN_MUX_REG1		(0xda834400 + (0x2d << 2))
> +#define GX_PIN_MUX_REG2		(0xda834400 + (0x2e << 2))
> +#define GX_PIN_MUX_REG3		(0xda834400 + (0x2f << 2))
> +#define GX_PIN_MUX_REG7		(0xda834400 + (0x33 << 2))
> +
> +/* PWM registers */
> +#define GX_PWM_PWM_B	(0xc1100000 + (0x2155 << 2))
> +#define GX_PWM_PWM_D	(0xc1100000 + (0x2195 << 2))
> +#define GX_PWM_MISC_REG_CD	(0xc1100000 + (0x2196 << 2))
> +#define GX_PWM_MISC_REG_AB	(0xc1100000 + (0x2156 << 2))
> +
>   /* Non-DM MMC init */
>   #if CONFIG_IS_ENABLED(MMC) && !CONFIG_IS_ENABLED(DM_MMC)
>   struct mmc *meson_mmc_init(int mmc_no);
>   #endif
>   
> +#if !CONFIG_IS_ENABLED(WDT_MESON_GXBB) && defined(CONFIG_SPL_BUILD)
> +#define GX_WDT_CTRL_REG		0xc11098d0
> +#endif
> +
>   #endif /* __GX_H__ */
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index 7570f48e25fe477ce4dfb1eb608ed07b3a83d27f..8d1bf91e98b49822d036f10b5737a73247bc83c6 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -17,6 +17,8 @@ config MESON64_COMMON
>   config MESON_GX
>   	bool
>   	select MESON64_COMMON
> +	select SUPPORT_SPL
> +	select BINMAN if SPL
>   
>   choice
>   	prompt "Platform select"
> @@ -69,7 +71,7 @@ config SYS_SOC
>   	default "meson"
>   
>   config SYS_MALLOC_F_LEN
> -	default 0x1000
> +	default 0x2000
>   
>   config SYS_VENDOR
>   	string "Vendor name"
> @@ -93,4 +95,42 @@ config SYS_BOARD
>   	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD> will
>   	  be used.
>   
> +if MESON_GX && SPL
> +config SPL_SYS_MALLOC_F_LEN
> +	default 0x2000
> +
> +choice
> +	prompt "Set VDDEE init voltage"
> +	default SPL_MESON_GX_VDDEE_1000MV
> +	help
> +	  This option is used to set the VDDEE voltage on boot up.
> +	  If unsure, leave it to the board default.
> +
> +config SPL_MESON_GX_VDDEE_1000MV
> +	bool "Set VDDEE to 1000 mv"
> +
> +config SPL_MESON_GX_VDDEE_1100MV
> +	bool "Set VDDEE to 1100 mv"
> +
> +endchoice
> +
> +choice
> +	prompt "Set VCCK init voltage"
> +	default SPL_MESON_GX_VCCK_1100MV
> +	help
> +	  This option is used to set the VCCK voltage on boot up.
> +	  If unsure, leave it to the board default.
> +
> +config SPL_MESON_GX_VCCK_1000MV
> +	bool "Set VCCK to 1000 mv"
> +
> +config SPL_MESON_GX_VCCK_1100MV
> +	bool "Set VCCK to 1100 mv"
> +
> +config SPL_MESON_GX_VCCK_1120MV
> +	bool "Set VCCK to 1120 mv"
> +
> +endchoice
> +
> +endif
>   endif
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> index 535b0878b9105e7a83729bea65fa4cd70cd4beac..7dc8ec08cfc5fe6e79fc59fc4db745ca3dd2cd93 100644
> --- a/arch/arm/mach-meson/Makefile
> +++ b/arch/arm/mach-meson/Makefile
> @@ -4,6 +4,11 @@
>   
>   obj-y += board-common.o sm.o board-info.o
>   obj-$(CONFIG_MESON_GX) += board-gx.o
> +ifeq ($(CONFIG_SPL_BUILD),y)
> +obj-$(CONFIG_MESON_GX) += spl-gx.o
> +obj-$(CONFIG_MESON_GX) += spl.o
> +endif
> +
>   obj-$(CONFIG_MESON_AXG) += board-axg.o
>   obj-$(CONFIG_MESON_G12A) += board-g12a.o
>   obj-$(CONFIG_MESON_A1) += board-a1.o
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index 39774c43049a40ed11578086603717571bedd23b..c243c46c0fc14e1f0910a50ed65ce46a36b8e9db 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -30,6 +30,7 @@ __weak int board_init(void)
>   	return 0;
>   }
>   
> +#ifndef CONFIG_SPL_BUILD
>   int dram_init(void)
>   {
>   	const fdt64_t *val;
> @@ -49,6 +50,7 @@ int dram_init(void)
>   
>   	return 0;
>   }
> +#endif
>   
>   __weak int meson_ft_board_setup(void *blob, struct bd_info *bd)
>   {
> @@ -150,5 +152,14 @@ int board_late_init(void)
>   
>   void reset_cpu(void)
>   {
> +#if CONFIG_SPL_BUILD
> +	/*
> +	 * We do not have BL31 running yet, so no PSCI.
> +	 * Instead, let the watchdog reset the board.
> +	 */
> +	for (;;)
> +		;
> +#else
>   	psci_system_reset();
> +#endif
>   }
> diff --git a/arch/arm/mach-meson/spl-gx.c b/arch/arm/mach-meson/spl-gx.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..65b301bc9ed89b7ca2156b7fa672ed4ef3f8633b
> --- /dev/null
> +++ b/arch/arm/mach-meson/spl-gx.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
> + * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
> + */
> +#include <hang.h>
> +#include <image.h>
> +#include <spl.h>
> +#include <vsprintf.h>
> +#include <asm/io.h>
> +#include <asm/arch/boot.h>
> +#include <asm/arch/clock-gx.h>
> +#include <asm/arch/gx.h>
> +#include <linux/delay.h>
> +
> +/* Meson GX SPL code */
> +
> +#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
> +#if defined(CONFIG_MESON_GXBB)

I think you should indicate why it's only needed for GXBB

> +inline void send_scp(void *addr, size_t size, const uint8_t *sha2,
> +	uint32_t sha2_length)
> +{
> +	int i;
> +
> +	puts("Trying to send the SCP firmware\n");
> +	writel(size, GX_MB_SRAM_BASE);
> +
> +	udelay(500);
> +
> +	writel(GX_MB_CMD_DATA_LEN, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
> +	while (readl(GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4))
> +		;
> +	udelay(500);
> +
> +	memcpy((void *)GX_MB_SRAM_BASE, (const void *)sha2, sha2_length);
> +	writel(GX_MB_CMD_SHA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
> +	while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
> +		;
> +	udelay(500);
> +
> +	for (i = 0; i < size; i += 1024) {
> +		if (size >= i + 1024)
> +			memcpy((void *)GX_MB_SRAM_BASE,
> +			       (const void *)(unsigned long)(addr + i), 1024);
> +		else if (size > i)
> +			memcpy((void *)GX_MB_SRAM_BASE,
> +			       (const void *)(unsigned long)(addr + i), (size - i));
> +
> +		writel(GX_MB_CMD_DATA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
> +		while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
> +			;
> +	}
> +	writel(GX_MB_CMD_OP_SHA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
> +
> +	while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
> +		;
> +	udelay(500);
> +
> +	/* We transferred all of the SCP firmware. Running it */
> +	writel(GX_MB_CMD_END, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
> +}
> +#endif
> +
> +void board_fit_image_post_process(const void *fit, int node, void **p_image, size_t *p_size)
> +{
> +#if defined(CONFIG_MESON_GXBB)
> +	const char *name = fit_get_name(fit, node, NULL);
> +	int noffset = 0, value_len;
> +	u8 *value;
> +
> +	if (strcmp("scp", name) && strcmp("bl301", name))
> +		return;
> +
> +	fdt_for_each_subnode(noffset, fit, node) {
> +		if (strncmp(fit_get_name(fit, noffset, NULL),
> +			    FIT_HASH_NODENAME, strlen(FIT_HASH_NODENAME)))
> +			continue;
> +
> +		if (fit_image_hash_get_value(fit, noffset, &value, &value_len))
> +			continue;
> +
> +		/* Send the SCP firmware to the SCP */
> +		send_scp(*p_image, *p_size, value, value_len);
> +		break;
> +	}
> +#endif
> +}
> +#endif
> +
> +inline void cpu_pll_switch_to(int mode)
> +{
> +	u32 reg;
> +
> +	reg = readl(GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
> +
> +	while (reg & (1 << 28))
> +		reg = readl(GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
> +
> +	reg |= (1 << 26);
> +
> +	if (mode == 1) {
> +		/* Switch to System PLL */
> +		reg |= (1 << 11);
> +	} else {
> +		if (reg & (1 << 10)) {
> +			reg = (reg & ~((1 << 10) | (0x3f << 4) | (1 << 2) |
> +				(0x3 << 0)));
> +		} else {
> +			reg = (reg & ~((1 << 10) | (0x3f << 20) |
> +				(1 << 18) | (0x3 << 16))) | (1 << 10);
> +		}
> +		/* Select dynamic mux */
> +		reg = reg & ~(1 << 11);
> +	}
> +	writel(reg, GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);

I know it's a lot, but it would nbe mush better if you had defines
for all those PLL register bits.

Or perhaps you can use the `struct parm` & PARM_GET/PARM_SET from
drivers/clk/meson/clk_meson.h to define and set all the PLL parameters

> +}
> +
> +int meson_pll_init(void)
> +{
> +	clrbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL, 1 << 8);
> +	cpu_pll_switch_to(0);
> +
> +	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL6, 1 << 26);
> +	udelay(100);
> +
> +	while (!((readl(GX_HIU_BASE + HHI_SYS_PLL_CNTL) >> 31) & 1)) {
> +		if (IS_ENABLED(CONFIG_MESON_GXBB)) {
> +			setbits_32(GX_HIU_BASE + HHI_SYS_PLL_CNTL, 1 << 29);
> +			writel(0x5ac80000, GX_HIU_BASE + HHI_SYS_PLL_CNTL2);
> +			writel(0x8e452015, GX_HIU_BASE + HHI_SYS_PLL_CNTL3);
> +			writel(0x401d40c, GX_HIU_BASE + HHI_SYS_PLL_CNTL4);
> +			writel(0x870, GX_HIU_BASE + HHI_SYS_PLL_CNTL5);
> +			writel((1 << 30) | (1 << 29) |
> +				((0 << 16) | (1 << 9) |
> +				(1536 / 24)), /* 1.5 GHz */
> +				GX_HIU_BASE + HHI_SYS_PLL_CNTL);
> +			clrbits_32(GX_HIU_BASE + HHI_SYS_PLL_CNTL, 1 << 29);
> +		} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
> +			writel(0xc4258100, GX_HIU_BASE + HHI_SYS_PLL_CNTL1);
> +			writel(0xb7400000, GX_HIU_BASE + HHI_SYS_PLL_CNTL2);
> +			writel(0xa59a288, GX_HIU_BASE + HHI_SYS_PLL_CNTL3);
> +			writel(0x40002d, GX_HIU_BASE + HHI_SYS_PLL_CNTL4);
> +			writel(0x7c700007, GX_HIU_BASE + HHI_SYS_PLL_CNTL5);
> +			writel((1 << 30) | ((1 << 9) |
> +				(1200 / 24)), /* 1.2 GHz */
> +				GX_HIU_BASE + HHI_SYS_PLL_CNTL);
> +		}
> +		udelay(20);
> +	}
> +	cpu_pll_switch_to(1); /* Hook the CPU to the PLL divider output */
> +
> +	if (IS_ENABLED(CONFIG_MESON_GXBB))
> +		writel(0x10007, GX_HIU_BASE + HHI_MPLL_CNTL4);
> +	else if (IS_ENABLED(CONFIG_MESON_GXL))
> +		writel(0x10006, GX_HIU_BASE + HHI_MPLL_CNTL4);
> +
> +	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
> +	udelay(200);
> +
> +	writel(0x59C80000, GX_HIU_BASE + HHI_MPLL_CNTL2);
> +	writel(0xCA45B822, GX_HIU_BASE + HHI_MPLL_CNTL3);
> +
> +	if (IS_ENABLED(CONFIG_MESON_GXBB))
> +		writel(0xB5500E1A, GX_HIU_BASE + HHI_MPLL_CNTL5);
> +	else if (IS_ENABLED(CONFIG_MESON_GXL))
> +		writel(0x95520E1A, GX_HIU_BASE + HHI_MPLL_CNTL5);
> +
> +	writel(0xFC454545, GX_HIU_BASE + HHI_MPLL_CNTL6);
> +
> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
> +		writel((1 << 30) | (1 << 29) | (3 << 9) | (250 << 0), GX_HIU_BASE + HHI_MPLL_CNTL);
> +		clrbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
> +	} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
> +		writel((1 << 30) | (3 << 9) | (250 << 0), GX_HIU_BASE + HHI_MPLL_CNTL);
> +	}
> +	udelay(800);
> +
> +	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL4, 1 << 14);
> +
> +	while (!((readl(GX_HIU_BASE + HHI_MPLL_CNTL) >> 31) & 1)) {
> +		if ((readl(GX_HIU_BASE + HHI_MPLL_CNTL) & (1 << 31)) != 0)
> +			break;
> +		setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
> +		udelay(1000);
> +		clrbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
> +		udelay(1000);
> +	}
> +
> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
> +		writel(0xFFF << 16, GX_HIU_BASE + HHI_MPLL_CNTL10);
> +		writel(((7 << 16) | (1 << 15) | (1 << 14) | (4681 << 0)),
> +		       GX_HIU_BASE + HHI_MPLL_CNTL7);
> +		writel(((readl(GX_HIU_BASE + HHI_MPEG_CLK_CNTL) & (~((0x7 << 12) | (1 << 7) |
> +			(0x7F << 0)))) | ((5 << 12) | (1 << 7)	| (2 << 0))),
> +			GX_HIU_BASE + HHI_MPEG_CLK_CNTL);
> +		setbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL, 1 << 8);
> +		writel(((5 << 16) | (1 << 15) | (1 << 14) | (12524 << 0)),
> +		       GX_HIU_BASE + HHI_MPLL_CNTL8);
> +	} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
> +		writel((1 << 12) | 3, GX_HIU_BASE + HHI_MPLL_CNTL10);
> +		writel(0x5edb7, GX_HIU_BASE + HHI_MPLL_CNTL7);
> +		clrbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL,
> +			   (3 << 13) | (1 << 12) | (15 << 4) | 15);
> +		setbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL,
> +			   (1 << 14) | (1 << 12) | (1 << 8) | (2 << 6) | (1 << 1));
> +		writel((4 << 16) | (7 << 13) | (1 << 8) | (5 << 4) | 10,
> +		       GX_HIU_BASE + HHI_MPLL_CNTL8);
> +	}
> +
> +	udelay(200);
> +
> +	/* TODO: Some error handling and timeouts... */
> +	return 0;
> +}
> +
> +#if CONFIG_IS_ENABLED(MMC) && !CONFIG_IS_ENABLED(DM_MMC)
> +int board_mmc_init(struct bd_info *bis)
> +{
> +	int mmc_device;
> +
> +	switch (meson_get_boot_device()) {
> +	case BOOT_DEVICE_SD:
> +		mmc_device = 0;
> +		break;
> +	case BOOT_DEVICE_EMMC:
> +		mmc_device = 1;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	if (!meson_mmc_init(mmc_device))
> +		return -1;
> +
> +	return 0;
> +}
> +#endif
> +
> +void meson_power_init(void)
> +{
> +	/* TODO: Support more voltages */
> +
> +	/* Init PWM B */
> +	clrsetbits_32(GX_PWM_MISC_REG_AB, 0x7f << 16, (1 << 23) | (1 << 1));
> +
> +	/* Set voltage */
> +	if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1120MV))
> +		writel(0x02001a, GX_PWM_PWM_B);
> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1100MV))
> +		writel(0x040018, GX_PWM_PWM_B);
> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1000MV))
> +		writel(0x0e000e, GX_PWM_PWM_B);
> +
> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 22);
> +		clrsetbits_32(GX_PIN_MUX_REG3, 1 << 22, 1 << 21);
> +	} else {
> +		clrbits_32(GX_PIN_MUX_REG1, 1 << 10);
> +		clrsetbits_32(GX_PIN_MUX_REG2, 1 << 5, 1 << 11);
> +	}
> +
> +	/* Init PWM D */
> +	clrsetbits_32(GX_PWM_MISC_REG_CD, 0x7f << 16, (1 << 23) | (1 << 1));
> +
> +	/* Set voltage */
> +	if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1100MV))
> +		writel(0x040018, GX_PWM_PWM_B);
> +	else if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1000MV))
> +		writel(0x0e000e, GX_PWM_PWM_B);
> +
> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 23);
> +		setbits_32(GX_PIN_MUX_REG3, 1 << 20);
> +	} else {
> +		clrbits_32(GX_PIN_MUX_REG1, (1 << 9) | (1 << 11));
> +		setbits_32(GX_PIN_MUX_REG2, 1 << 12);
> +	}
> +}

Seems much of the code is duplicated between GXBB and GXL, so I wonder if it would'nt
be cleaner to have spl-gxbb an spl-gxl ?

> diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b3565402972f81c3cfd5824ba49cd713c1329a9d
> --- /dev/null
> +++ b/arch/arm/mach-meson/spl.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
> + * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
> + */
> +#include <spl.h>
> +#include <hang.h>
> +#include <asm/io.h>
> +#include <asm/spl.h>
> +#include <asm/arch/boot.h>
> +#include <vsprintf.h>
> +#include <asm/ptrace.h>
> +#include <asm/system.h>
> +#include <atf_common.h>
> +#include <image.h>
> +#include <asm/arch/gx.h>
> +#include <linux/delay.h>
> +#include <asm/arch/clock-gx.h>
> +
> +u32 spl_boot_device(void)
> +{
> +	int boot_device = meson_get_boot_device();
> +
> +	switch (boot_device) {
> +	case BOOT_DEVICE_EMMC:
> +		return BOOT_DEVICE_MMC2;
> +	case BOOT_DEVICE_SD:
> +		return BOOT_DEVICE_MMC1;
> +	/*
> +	 * TODO: Get USB DFU to work
> +	 * Right now we just panic when booted from USB.
> +	 */
> +	case BOOT_DEVICE_USB:
> +		if (CONFIG_IS_ENABLED(YMODEM))
> +			return BOOT_DEVICE_UART;
> +		else
> +			return BOOT_DEVICE_DFU;
> +	}
> +
> +	panic("Unknown device %d\n", boot_device);
> +	return BOOT_DEVICE_NONE; /* Never reached */
> +}
> +
> +__weak struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
> +{
> +	return (void *)CONFIG_TEXT_BASE + 0x4000000;
> +}
> +
> +__weak void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> +{
> +	/* HACK: use same fit load buffer address as for mmc raw */
> +	return spl_get_load_buffer(0, fit_size);
> +}
> +
> +__weak bool spl_load_simple_fit_skip_processing(void)
> +{
> +	return false;
> +}
> +
> +/* To be defined in dram-${GENERATION}.c */
> +__weak int dram_init(void)
> +{
> +	return 0;
> +}
> +
> +/* Placeholder functions to be defined in SoC-specific spl-... file */
> +__weak void meson_power_init(void)
> +{
> +}
> +
> +__weak int meson_pll_init(void)
> +{
> +	return 0;
> +}
> +
> +void board_init_f(ulong dummy)
> +{
> +	int ret;
> +
> +	/* Restart execution at EL3 */
> +	if (current_el() != 3) {
> +		struct pt_regs regs = {0};
> +		static struct entry_point_info spl_ep_info;
> +
> +		SET_PARAM_HEAD(&spl_ep_info, ATF_PARAM_BL31, ATF_VERSION_1, 0);
> +		spl_ep_info.pc = CONFIG_SPL_TEXT_BASE;
> +		spl_ep_info.spsr = SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXECPTIONS);
> +
> +		regs.regs[0] = 0xc0000000;
> +		regs.regs[1] = (unsigned long)&spl_ep_info;
> +		smc_call(&regs);
> +	}
> +
> +	meson_power_init();
> +	ret = meson_pll_init();
> +	if (ret) {
> +		debug("meson_pll_init() failed: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = dram_init();
> +	if (ret) {
> +		debug("dram_init() failed: %d\n", ret);
> +		hang();
> +	}
> +
> +	if (CONFIG_IS_ENABLED(OF_CONTROL)) {
> +		ret = spl_early_init();
> +		if (ret) {
> +			debug("spl_early_init() failed: %d\n", ret);
> +			hang();
> +		}
> +	}
> +
> +	spl_init();
> +	icache_enable();
> +	preloader_console_init();
> +
> +#if !CONFIG_IS_ENABLED(WDT_MESON_GXBB)
> +	/* Disable watchdog */
> +	clrbits_32(GX_WDT_CTRL_REG, (1 << 18) | (1 << 25));
> +#endif
> +}
> 

Anyway it's really clean !

Thanks!
Neil

