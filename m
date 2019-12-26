Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.19237.1577351422236826412
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Dec 2019 01:10:23 -0800
Received: by mail-wr1-f68.google.com with SMTP id y17so23202797wrh.5
        for <u-boot-amlogic@groups.io>; Thu, 26 Dec 2019 01:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=D3qwS7OR2eKI8I1hT9yFKrBLlXrzlRCxS2Ze7Pae6XM=;
        b=NvWHI14dSwPkMFmru6s+fMyGd/nYluop7et1eXF+CknD89EBa6TvUED8HHfHSTlWa0
         5y49RLCBiotFjhOxlCNdcPc56buX4K2zHvz8G3NpCVV7LyDP+uCcaUuzI5ReAe/mJKZT
         5PFR13FqGI6STJkitvv31PN4jvgk85qWUVd5MIS9dlpUc2WuCyg4tpqKNeI7j8iHpcwp
         9PNQRYvf5x2CSb+lyzbX6DywsoVGWc3ALeuuZKF5AN8yCMOWwpYJRrLPApZHNjT3gFd+
         fTIdHjCEzzVcGCCp3UIHVAZC5DbXRsjkxa/bZu53kG0Kjcu6sxJLDaottCSOJiRGxuNL
         /jHA==
Return-Path: <jbrunet@baylibre.com>
References: <20191224132551.1427-1-linux.amoon@gmail.com> <20191224132551.1427-2-linux.amoon@gmail.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [U-Boot] [PATCHv2 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
In-reply-to: <20191224132551.1427-2-linux.amoon@gmail.com>
Date: Thu, 26 Dec 2019 10:10:19 +0100
Message-ID: <1jh81npi4k.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Anand Moon <linux.amoon@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


On Tue 24 Dec 2019 at 14:25, Anand Moon <linux.amoon@gmail.com> wrote:

> As per mainline line kernel fix the clk tunnig phase for
> mmc, set Core=180, Tx=0, Rx=0 clk phase for mmc initialization.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes from previous
> use the mainline kernel tuning for clk tuning.
> Fixed the commmit messages.
> Patch v1:
> https://patchwork.ozlabs.org/patch/1201208/
>
> Before these changes.
>     clock is enabled (380953Hz)
>     clock is enabled (25000000Hz)
> After these changes
>     clock is enabled (380953Hz)
>     clock is enabled (25000000Hz)
>     clock is enabled (52000000Hz)
> Test on Odroid N2 and Odroid C2 with eMMC and microSD cards
> ---
>  arch/arm/include/asm/arch-meson/sd_emmc.h | 14 ++++++--------
>  drivers/mmc/meson_gx_mmc.c                |  9 +++++----
>  2 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
> index e3a72c8b66..d70fe4f03e 100644
> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> @@ -7,6 +7,7 @@
>  #define __SD_EMMC_H__
>  
>  #include <mmc.h>
> +#include <linux/bitops.h>
>  
>  #define SDIO_PORT_A			0
>  #define SDIO_PORT_B			1
> @@ -19,14 +20,11 @@
>  #define   CLK_MAX_DIV			63
>  #define   CLK_SRC_24M			(0 << 6)
>  #define   CLK_SRC_DIV2			(1 << 6)
> -#define   CLK_CO_PHASE_000		(0 << 8)
> -#define   CLK_CO_PHASE_090		(1 << 8)
> -#define   CLK_CO_PHASE_180		(2 << 8)
> -#define   CLK_CO_PHASE_270		(3 << 8)
> -#define   CLK_TX_PHASE_000		(0 << 10)
> -#define   CLK_TX_PHASE_090		(1 << 10)
> -#define   CLK_TX_PHASE_180		(2 << 10)
> -#define   CLK_TX_PHASE_270		(3 << 10)
> +
> +#define   CLK_CORE_PHASE_MASK		GENMASK(9, 8)
> +#define   CLK_TX_PHASE_MASK		GENMASK(11, 10)
> +#define   CLK_RX_PHASE_MASK		GENMASK(13, 12)
> +
>  #define   CLK_ALWAYS_ON			BIT(24)
>  
>  #define MESON_SD_EMMC_CFG		0x44
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 86c1a7164a..402981c3bb 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -52,10 +52,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  	clk_div = DIV_ROUND_UP(clk, mmc->clock);
>  
>  	/* 180 phase core clock */
> -	meson_mmc_clk |= CLK_CO_PHASE_180;
> -
> -	/* 180 phase tx clock */
> -	meson_mmc_clk |= CLK_TX_PHASE_000;
> +	meson_mmc_clk |= CLK_CORE_PHASE_MASK;
> +	/* 000 phase rx clock */
> +	meson_mmc_clk |= CLK_RX_PHASE_MASK;
> +	/* 000 phase tx clock */
> +	meson_mmc_clk |= CLK_TX_PHASE_MASK;
>

I'm not sure how this acheive what is descibed in the commit
description.

It looks more that it would set a 270 degree phase on all clocks, which
is not desirable.

>  	/* clock settings */
>  	meson_mmc_clk |= clk_src;

