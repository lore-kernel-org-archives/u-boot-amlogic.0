Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web09.3747.1578391260932597299
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jan 2020 02:01:01 -0800
Received: by mail-wr1-f67.google.com with SMTP id w15so40597540wru.4
        for <u-boot-amlogic@groups.io>; Tue, 07 Jan 2020 02:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=Mi4RK4QlhVhYXFDwEFKMqfFJ/Bd6/UJnlGvS/Yl7Z90=;
        b=aHgXZrHAQHsrcWv2poHhby2kr5GbLJi+2cP4K+En0Wam0nX97a52L33FTqetMX6UiA
         2bYVELxNPDt97yGH6k6MoZw5ZQqg3JYRnmVGupHEIVQ7zcsA1AgcXGdc3H4ld1642Hn+
         ReWEmxu9g2e/I1Ndl286VmSVa7vfQAvYOk2uX8+TySkLtJlgNZNYx++/n3Emgn/1YQyV
         W+K0g/CP+B7uv+iRpjVM3AKPEtfmPGvnqKsQd78KZP18M7mwE89+MPyXZ0mV29rJlLQn
         JA8Qq3V5cKoO5aIVMoyjhfpG5zrBt78HhXYjLZ9lSO+Z10KN1xI7gr0ZLpTl7fwhBdeV
         LTsg==
Return-Path: <jbrunet@baylibre.com>
References: <20191226113353.1757-1-linux.amoon@gmail.com> <20191226113353.1757-2-linux.amoon@gmail.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCHv3 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
In-reply-to: <20191226113353.1757-2-linux.amoon@gmail.com>
Date: Tue, 07 Jan 2020 11:00:57 +0100
Message-ID: <1j8smjsi06.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Anand Moon <linux.amoon@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


On Thu 26 Dec 2019 at 12:33, Anand Moon <linux.amoon@gmail.com> wrote:

> As per mainline line kernel fix the clk tunnig phase for
> mmc, set Core=180, Tx=0, Rx=0 clk phase for mmc initialization.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes from previous
> v2: Fix the clk phase macro to support PHASE_180
>     drop the wrong CLK_CORE_PHASE_MASK macro.
>
> v1: use the mainline kernel tuning for clk tuning.
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
> index e3a72c8b66..ee20c009e2 100644
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
> +#define   CLK_PHASE_180 		2
> +#define   CLK_TX_PHASE_MASK		GENMASK(11, 10)
> +#define   CLK_RX_PHASE_MASK		GENMASK(13, 12)
> +
>  #define   CLK_ALWAYS_ON			BIT(24)
>  
>  #define MESON_SD_EMMC_CFG		0x44
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 86c1a7164a..ad697d3a5e 100644
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
> +	meson_mmc_clk |= CLK_PHASE_180;
> +	/* 000 phase rx clock */
> +	meson_mmc_clk |= CLK_RX_PHASE_MASK;
> +	/* 000 phase tx clock */
> +	meson_mmc_clk |= CLK_TX_PHASE_MASK;

The comment on your previous version seemed correct but I think what you
have implemented here is still not doing what you expect.

>  
>  	/* clock settings */
>  	meson_mmc_clk |= clk_src;

