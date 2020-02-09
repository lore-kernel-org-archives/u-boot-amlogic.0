Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.6921.1581253280212939065
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 05:01:20 -0800
Received: by mail-wr1-f67.google.com with SMTP id g3so3119809wrs.12
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 05:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=KEw7SU6mH3ZXUoiUB4QNipkuxIMpzXLazQ8jjob8iQU=;
        b=rUZLOUwvQ0xj4WTILzw7t8KvNL9ENVqM2XylAGvj8JYGVNbEr7V7Ly8RC8Ft6hlwJU
         Mr7MWO7AlO15KO97Ja3Yy0zHhgXq4wUk8wopRWjXmu5TpZ8SDCgPgA54FbNHKBdvTFY0
         r7yh2o6vTAbgXmcwaKVdnKmXGzqcLoRclOZRCiBn1AZPnAZC3IK1hBKysW7tFaadOovK
         Y/Ju++1IkUSLHcjECUaYSpRfgRq8r0VJ1PKGn4RBEEDril+61aM418JHvRVpYWGID4QK
         YbqiOa1z/u1WCBkr0Q0DkH0ZxbFjoC4ABaXWncy2jog/CwoV13TgFyvNqZU4aW5izQd7
         KB6Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv6 2/5] mmc: meson-gx: Use proper compatible string as per the dts
References: <20200209110557.1996-1-linux.amoon@gmail.com>
 <20200209110557.1996-3-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <420ac33a-7b49-40b9-aa41-aee8f83e49f3@baylibre.com>
Date: Sun, 9 Feb 2020 14:01:16 +0100
MIME-Version: 1.0
In-Reply-To: <20200209110557.1996-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Anand Moon <linux.amoon@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 09/02/2020 =E0 12:05, Anand Moon a =E9crit :
> Use proper compatible string as per the dts so that mmc driver
> could be tuned properly. SoC family S905, S905X have common clk
> tuning parameters setting, while AGX and G12 have common clk tuning
> parameters setting for mmc driver.
>=20
> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> No changes.
> ---
>  arch/arm/include/asm/arch-meson/sd_emmc.h |  7 ++++
>  drivers/mmc/meson_gx_mmc.c                | 46 +++++++++++++++++------
>  2 files changed, 41 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include=
/asm/arch-meson/sd_emmc.h
> index f4299485dc..83142d5d3f 100644
> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> @@ -13,6 +13,12 @@
>  #define SDIO_PORT_B			1
>  #define SDIO_PORT_C			2
> =20
> +enum mmc_compatible {
> +        MMC_COMPATIBLE_GXBB,
> +        MMC_COMPATIBLE_GX,
> +        MMC_COMPATIBLE_AXG,
> +};
> +
>  #define SD_EMMC_CLKSRC_24M		24000000	/* 24 MHz */
>  #define SD_EMMC_CLKSRC_DIV2		1000000000	/* 1 GHz */
> =20
> @@ -87,6 +93,7 @@
>  struct meson_mmc_platdata {
>  	struct mmc_config cfg;
>  	struct mmc mmc;
> +	int compat;
>  	void *regbase;
>  	void *w_buf;
>  };
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index b013c7c5fb..1aefe360c4 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -37,7 +37,8 @@ static inline void meson_write(struct mmc *mmc, uint32_=
t val, int offset)
>  	writel(val, get_regbase(mmc) + offset);
>  }
> =20
> -static void meson_mmc_config_clock(struct mmc *mmc)
> +static void meson_mmc_config_clock(struct mmc *mmc,
> +				   struct meson_mmc_platdata *pdata)
>  {
>  	uint32_t meson_mmc_clk =3D 0;
>  	unsigned int clk, clk_src, clk_div;
> @@ -66,14 +67,20 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  	/* RX clock phase 0:180 */
>  	meson_mmc_clk |=3D FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> =20
> -#ifdef CONFIG_MESON_GX
> -	/* clk always on */
> -	meson_mmc_clk |=3D CLK_V2_ALWAYS_ON;
> -#endif
> -#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
> -	/* clk always on */
> -	meson_mmc_clk |=3D CLK_V3_ALWAYS_ON;
> -#endif
> +	switch (pdata->compat) {
> +	case MMC_COMPATIBLE_GXBB:
> +	case MMC_COMPATIBLE_GX:
> +		/* clk always on */
> +		meson_mmc_clk |=3D CLK_V2_ALWAYS_ON;
> +		break;
> +	case MMC_COMPATIBLE_AXG:
> +		/* clk always on */
> +		meson_mmc_clk |=3D CLK_V3_ALWAYS_ON;
> +		break;
> +	default:
> +		debug("no compatible supported");
> +		break;
> +	}
> =20
>  	/* clock settings */
>  	meson_mmc_clk |=3D clk_src;
> @@ -85,9 +92,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>  static int meson_dm_mmc_set_ios(struct udevice *dev)
>  {
>  	struct mmc *mmc =3D mmc_get_mmc_dev(dev);
> +	struct meson_mmc_platdata *pdata =3D
> +		(struct meson_mmc_platdata *)dev_get_driver_data(dev);
>  	uint32_t meson_mmc_cfg;
> =20
> -	meson_mmc_config_clock(mmc);
> +	meson_mmc_config_clock(mmc, pdata);
> =20
>  	meson_mmc_cfg =3D meson_read(mmc, MESON_SD_EMMC_CFG);
> =20
> @@ -324,9 +333,22 @@ int meson_mmc_bind(struct udevice *dev)
>  	return mmc_bind(dev, &pdata->mmc, &pdata->cfg);
>  }
> =20
> +static const struct meson_mmc_platdata gxbb_data =3D {
> +        .compat =3D MMC_COMPATIBLE_GXBB,
> +};
> +
> +static const struct meson_mmc_platdata gx_data =3D {
> +        .compat =3D MMC_COMPATIBLE_GX,
> +};
> +
> +static const struct meson_mmc_platdata axg_data =3D {
> +        .compat =3D MMC_COMPATIBLE_AXG,
> +};
> +
>  static const struct udevice_id meson_mmc_match[] =3D {
> -	{ .compatible =3D "amlogic,meson-gx-mmc" },
> -	{ .compatible =3D "amlogic,meson-axg-mmc" },
> +	{ .compatible =3D "amlogic,meson-gxbb-mmc", .data =3D (ulong)&gxbb_data=
 },
> +	{ .compatible =3D "amlogic,meson-gx-mmc",	.data =3D (ulong)&gx_data },
> +	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D (ulong)&axg_data },
>  	{ /* sentinel */ }
>  };
> =20
>=20


It's fine but you should do that before patch 1, and introduce the clk setu=
p directly with the MMC_COMPATIBLE_*.

If you move it before, then:

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
