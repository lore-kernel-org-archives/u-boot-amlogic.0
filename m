Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mx.groups.io with SMTP id smtpd.web11.10081.1604658758845432259
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:32:39 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201106103236epoutp040282dc9617d75db89144fccf43fd05cf~E5KMCQV_t0820108201epoutp04K
	for <u-boot-amlogic@groups.io>; Fri,  6 Nov 2020 10:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201106103236epoutp040282dc9617d75db89144fccf43fd05cf~E5KMCQV_t0820108201epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604658756;
	bh=5sgQuoxr5FUa4r8GKrLLdFhcUEr0/B1lZ4dxmrhApFQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=UqTQ1ys26kOTC7poeALZNrhCMowwFaGN+lb4ov2okbk0Me5pfO/4owzoeLvcrkIHK
	 IGRhBqZ2Ywc6fPFpt1g0CbHH8P4JcUlCtHFr0fBqN+8ZUbSch7BFST7b9+uGkvOp1D
	 /ZTeirCPkg4ac8e/g8yNlbFLoH6V4IILBSyV/dAA=
Subject: Re: [PATCH 2/3] mmc: meson-gx: limit max frequency on SM1 SoCs
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <dd0d520d-c213-96eb-3301-fba2adbed187@samsung.com>
Date: Fri, 6 Nov 2020 19:32:49 +0900
MIME-Version: 1.0
In-Reply-To: <20201106092755.2250773-3-narmstrong@baylibre.com>
References: <20201106092755.2250773-1-narmstrong@baylibre.com>
	<CGME20201106093033epcas1p22f885b3691e135923c305f39e5d327e0@epcas1p2.samsung.com>
	<20201106092755.2250773-3-narmstrong@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 11/6/20 6:27 PM, Neil Armstrong wrote:
> Amlogic SM1 SoCs doesn't handle very well high clocks from the DIV2 input
> Thus we limit the max freq to 26MHz on SM1 SoCs until we handle higher
> frequencies via the first input from a composite clock.
> 
> Here 26MHz corresponds to MMC_HS clock speed.
> 
> We also add a u-boot only sm1 compatible to distinguish the controller.

Well, it's workaround for using eMMC.
I didn't check all SM1 SoCs..but odroid-c4 is supported hs200 mode (200MHz) on Kernel side.
It means that bootloader can also support its mode.

I'm checking this problem with odroid-c4 target. If i find how to fix, i will share.

Best Regards,
Jaehoon Chung


> 
> Finally a TOFIX is added to precise the clock management should use
> the clock controller instead of local management with fixed clock rates.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mmc/meson_gx_mmc.c | 26 +++++++++++++++++++++++---
>  drivers/mmc/meson_gx_mmc.h |  5 +++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 9350edf3fa..2c6b6cd15b 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -17,6 +17,14 @@
>  #include <linux/log2.h>
>  #include "meson_gx_mmc.h"
>  
> +bool meson_gx_mmc_is_compatible(struct udevice *dev,
> +				enum meson_gx_mmc_compatible family)
> +{
> +	enum meson_gx_mmc_compatible compat = dev_get_driver_data(dev);
> +
> +	return compat == family;
> +}
> +
>  static inline void *get_regbase(const struct mmc *mmc)
>  {
>  	struct meson_mmc_platdata *pdata = mmc->priv;
> @@ -42,6 +50,8 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  	if (!mmc->clock)
>  		return;
>  
> +	/* TOFIX This should use the proper clock taken from DT */
> +
>  	/* 1GHz / CLK_MAX_DIV = 15,9 MHz */
>  	if (mmc->clock > 16000000) {
>  		clk = SD_EMMC_CLKSRC_DIV2;
> @@ -265,7 +275,16 @@ static int meson_mmc_probe(struct udevice *dev)
>  	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
>  			MMC_MODE_HS_52MHz | MMC_MODE_HS;
>  	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
> -	cfg->f_max = 100000000; /* 100 MHz */;
> +	/*
> +	 * TOFIX SM1 SoCs doesn't handle very well high clocks from the DIV2 input
> +	 * Thus we limit the max freq to 26MHz on SM1 SoCs until we handle higher
> +	 * frequencies via the first input from a composite clock
> +	 * 26MHz corresponds to MMC_HS clock speed
> +	 */
> +	if (meson_gx_mmc_is_compatible(dev, MMC_COMPATIBLE_SM1))
> +		cfg->f_max = 26000000; /* 26 MHz */
> +	else
> +		cfg->f_max = 100000000; /* 100 MHz */
>  	cfg->b_max = 511; /* max 512 - 1 blocks */
>  	cfg->name = dev->name;
>  
> @@ -308,8 +327,9 @@ int meson_mmc_bind(struct udevice *dev)
>  }
>  
>  static const struct udevice_id meson_mmc_match[] = {
> -	{ .compatible = "amlogic,meson-gx-mmc" },
> -	{ .compatible = "amlogic,meson-axg-mmc" },
> +	{ .compatible = "amlogic,meson-gx-mmc", .data = MMC_COMPATIBLE_GX },
> +	{ .compatible = "amlogic,meson-axg-mmc", .data = MMC_COMPATIBLE_GX },
> +	{ .compatible = "amlogic,meson-sm1-mmc", .data = MMC_COMPATIBLE_SM1 },
>  	{ /* sentinel */ }
>  };
>  
> diff --git a/drivers/mmc/meson_gx_mmc.h b/drivers/mmc/meson_gx_mmc.h
> index b4544b5562..92aec5329f 100644
> --- a/drivers/mmc/meson_gx_mmc.h
> +++ b/drivers/mmc/meson_gx_mmc.h
> @@ -9,6 +9,11 @@
>  #include <mmc.h>
>  #include <linux/bitops.h>
>  
> +enum meson_gx_mmc_compatible {
> +	MMC_COMPATIBLE_GX,
> +	MMC_COMPATIBLE_SM1,
> +};
> +
>  #define SDIO_PORT_A			0
>  #define SDIO_PORT_B			1
>  #define SDIO_PORT_C			2
> 

