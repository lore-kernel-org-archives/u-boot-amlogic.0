Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.9550.1580541875256880434
 for <u-boot-amlogic@groups.io>;
 Fri, 31 Jan 2020 23:24:36 -0800
Received: by mail-wr1-f67.google.com with SMTP id a6so11219477wrx.12
        for <u-boot-amlogic@groups.io>; Fri, 31 Jan 2020 23:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=UVOnnXAOiDeVcSlAwaezMpgniZ50oHZfOdXSFvz/hfQ=;
        b=Rm4gZRKyPcYGE4dFkFiiC+IPDd2Ec9ONKIppMuf45KsA58deqxWPZJuU1rSg96loVX
         1U5P5BQXLacTjhzOz4uS0KekAX3wA3WRFbIGE1BQBalnnXz3jMlYDdNXp0d0n5KZsva3
         uN68jRE7W9Lv8xi3RcpSTOQPp4tH27SLjjuX34SFaj8iGCwJxLQymIJB1b6vOuCRawlW
         emCgGPpJjydjNdIzHpM7yPNQfUsG9QrUMMmk0iird+4fR4WjXEJrxmQbic6i3+0oWY6k
         HNrqBEq5SZdBukv9UBh1A91YxfTovNIO6FL6EeUIMw3wopWet2v5l3V0NzMSwtBpRu9D
         w89w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [Patchv4 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
References: <20200122120620.8699-1-linux.amoon@gmail.com>
 <20200122120620.8699-2-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <22609d3d-61c4-acae-72ab-0afd8e9cbb6e@baylibre.com>
Date: Sat, 1 Feb 2020 08:24:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200122120620.8699-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Anand Moon <linux.amoon@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>



Le 22/01/2020 =E0 13:06, Anand Moon a =E9crit :
> As per mainline line kernel fix the clk tunig phase for
> mmc, set Core=3D180, Tx=3D180, Rx=3D0 clk phase for mmc initialization.
> As per S905X and S922X datasheet set the default values
> for clk tuning.

Please add you also add AXG/G12 setup.

>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes from previous
> v3  Fix the initialization of core clk tunning phase as per datasheet.
>     Fix the commit message.
>=20
> v2: Fix the clk phase macro to support PHASE_180
>     drop the wrong CLK_CORE_PHASE_MASK macro.
>=20
> v1: use the mainline kernel tuning for clk tuning.
>=20
> Fixed the commmit messages.
> Patch v1:
> https://patchwork.ozlabs.org/patch/1201208/
>=20
> Before these changes.
>     clock is enabled (380953Hz)
>     clock is enabled (25000000Hz)
> After these changes
>     clock is enabled (380953Hz)
>     clock is enabled (25000000Hz)
>     clock is enabled (52000000Hz)
> Test on Odroid N2 and Odroid C2 with eMMC and microSD cards
> ---
>  arch/arm/include/asm/arch-meson/sd_emmc.h | 11 ++-----
>  drivers/mmc/meson_gx_mmc.c                | 38 +++++++++++++++++++----
>  2 files changed, 35 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include=
/asm/arch-meson/sd_emmc.h
> index e3a72c8b66..c193547aad 100644
> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> @@ -7,6 +7,7 @@
>  #define __SD_EMMC_H__
> =20
>  #include <mmc.h>
> +#include <linux/bitops.h>
> =20
>  #define SDIO_PORT_A			0
>  #define SDIO_PORT_B			1
> @@ -19,14 +20,8 @@
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
> +#define	  UPDATE(x, h, l)		(((x) << (l)) & GENMASK((h), (l)))

A macro already exists for that: FIELD_PREP(), please use it with proper BI=
T and GENMASK defines.

> +
>  #define   CLK_ALWAYS_ON			BIT(24)
> =20
>  #define MESON_SD_EMMC_CFG		0x44
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 86c1a7164a..67b1b075ab 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -51,12 +51,38 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  	}
>  	clk_div =3D DIV_ROUND_UP(clk, mmc->clock);
> =20
> -	/* 180 phase core clock */
> -	meson_mmc_clk |=3D CLK_CO_PHASE_180;
> -
> -	/* 180 phase tx clock */
> -	meson_mmc_clk |=3D CLK_TX_PHASE_000;
> -
> +	/* Clock divider */
> +	meson_mmc_clk =3D GENMASK(5, 0);
> +	/* Clock source 1: Fix PLL, 1000MHz */
> +	meson_mmc_clk |=3D UPDATE(1, 7, 6);
> +	/* Core clock phase 2:180 */
> +	meson_mmc_clk |=3D UPDATE(2, 9, 8);
> +	/* TX clock phase 2:180 */
> +	meson_mmc_clk |=3D UPDATE(2, 11, 10);
> +	/* RX clock phase 0:180 */
> +	meson_mmc_clk |=3D UPDATE(0, 13, 12);
> +#ifdef CONFIG_MESON_GX
> +	/* TX clock delay line */
> +	meson_mmc_clk |=3D GENMASK(19, 16);
> +	/* RX clock delay line */
> +	meson_mmc_clk |=3D GENMASK(23, 20);
> +	/* clk always on */
> +	meson_mmc_clk |=3D BIT(20);
> +	/* clk irq sdio sleep */
> +	meson_mmc_clk |=3D BIT(25);
> +#endif
> +#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
> +	/* TX clock delay line */
> +	meson_mmc_clk |=3D  GENMASK(21, 16);
> +	/* RX clock delay line */
> +	meson_mmc_clk |=3D  GENMASK(27, 22);
> +	/* clk always on */
> +	meson_mmc_clk |=3D BIT(28);
> +	/* clk irq sdio sleep */
> +	meson_mmc_clk |=3D BIT(29);
> +	/* clk irq sdio sleep_ds */
> +	meson_mmc_clk |=3D BIT(30);

As Jaehoon wrote, please define these MASKs and BITs

> +#endif

Instead of ifdef, please add a data in the compatible list and use thez
fact we use amlogic,meson-axg-mmc on AXG & G12/SM1.

Example: https://github.com/u-boot/u-boot/blob/master/drivers/video/meson/m=
eson_vpu.c#L98
and https://github.com/u-boot/u-boot/blob/master/drivers/video/meson/meson_=
vpu.c#L37

>  	/* clock settings */
>  	meson_mmc_clk |=3D clk_src;
>  	meson_mmc_clk |=3D clk_div;
>=20

Thanks,
Neil
