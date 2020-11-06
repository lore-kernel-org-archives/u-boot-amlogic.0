Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mx.groups.io with SMTP id smtpd.web12.9779.1604658419532424051
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:27:00 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201106102656epoutp030c76b30beb5dddb4dd4d220763c71dd4~E5FQC9UoY2151221512epoutp03e
	for <u-boot-amlogic@groups.io>; Fri,  6 Nov 2020 10:26:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201106102656epoutp030c76b30beb5dddb4dd4d220763c71dd4~E5FQC9UoY2151221512epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604658416;
	bh=RJPqdNtXWto9wLmapK8pujY7YhyE3wA3npWr565EZbs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=a6HBOASlqRD9yGwTSv/BUpw1+ryDpGEM53Fv47RDzIRDkxuloHV3iu0ytc36JUors
	 e0PQqoBc7IQJ3+cjtJEYqw4hXzm+EXL7MA/cEltr40foJSHddFAHxLBpcRTydYxxWQ
	 an5NMjxmJFpBo4cTFYqdOjzfntu0B4Sl/q0534OQ=
Subject: Re: [PATCH 1/3] mmc: meson-gx: move arch header to local header
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <c9712225-3ddb-a058-74b3-3121eb58b8e7@samsung.com>
Date: Fri, 6 Nov 2020 19:27:06 +0900
MIME-Version: 1.0
In-Reply-To: <20201106092755.2250773-2-narmstrong@baylibre.com>
References: <20201106092755.2250773-1-narmstrong@baylibre.com>
	<CGME20201106093044epcas1p1d135ac4920a18769398028054507ae34@epcas1p1.samsung.com>
	<20201106092755.2250773-2-narmstrong@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 11/6/20 6:27 PM, Neil Armstrong wrote:
> Move the asm/arch-meson/sd_emmc.h to a local meson_gx_mmc.h,
> remove the useless if/then and fix the meson_gx_mmc.c include.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mmc/meson_gx_mmc.c                                 | 4 ++--
>  .../asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h | 7 ++-----
>  2 files changed, 4 insertions(+), 7 deletions(-)
>  rename arch/arm/include/asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h (97%)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 719dd1e5e5..9350edf3fa 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -13,9 +13,9 @@
>  #include <mmc.h>
>  #include <asm/io.h>
>  #include <asm/gpio.h>
> -#include <asm/arch/sd_emmc.h>
>  #include <linux/delay.h>
>  #include <linux/log2.h>
> +#include "meson_gx_mmc.h"
>  
>  static inline void *get_regbase(const struct mmc *mmc)
>  {
> @@ -265,7 +265,7 @@ static int meson_mmc_probe(struct udevice *dev)
>  	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
>  			MMC_MODE_HS_52MHz | MMC_MODE_HS;
>  	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
> -	cfg->f_max = 100000000; /* 100 MHz */
> +	cfg->f_max = 100000000; /* 100 MHz */;

Don't need to touch. Remove ";"

>  	cfg->b_max = 511; /* max 512 - 1 blocks */
>  	cfg->name = dev->name;
>  
> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/drivers/mmc/meson_gx_mmc.h
> similarity index 97%
> rename from arch/arm/include/asm/arch-meson/sd_emmc.h
> rename to drivers/mmc/meson_gx_mmc.h
> index 1e9f8cf498..b4544b5562 100644
> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> +++ b/drivers/mmc/meson_gx_mmc.h
> @@ -3,14 +3,11 @@
>   * (C) Copyright 2016 Carlo Caione <carlo@caione.org>
>   */
>  
> -#ifndef __SD_EMMC_H__
> -#define __SD_EMMC_H__
> +#ifndef __MESON_GX_MMC_H__
> +#define __MESON_GX_MMC_H__
>  
>  #include <mmc.h>
> -#ifndef __ASSEMBLY__
>  #include <linux/bitops.h>
> -#endif
> -
>  
>  #define SDIO_PORT_A			0
>  #define SDIO_PORT_B			1
> 

