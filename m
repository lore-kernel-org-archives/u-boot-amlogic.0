Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
 by mx.groups.io with SMTP id smtpd.web12.9918.1581269046933647953
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 09:24:07 -0800
Received: by mail-il1-f195.google.com with SMTP id b15so3790027iln.3
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 09:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MZYb+NBeaPA37tx8WjApfZqBvHBPtWzkY3gsFusf0no=;
        b=lupzeutZ90z/hDiy5uKqJgNwy9W4vOsRlN0QlwtkfzMJeDAn34Khv2GqSWNL2GP+xk
         qfOJk6XZsGlyoa+L4InVVOs0mPvatd0gjUfSrEtlZ2hGdgc+qh+9yJkgCqpElnATXscP
         VTBE8mWhUgY9TOUN+tbDzzHPnCcBZRBYYH2Dc+7R7iNNjhJkhGzgy2/4xQah2Tamgyp/
         V5U2RSNbb5DLZik2L3Lih9uZM8HXGOp/YNSb11ahJ4cE1zxDgMxbdOQuCbK6PcrAQUty
         87xhnUYF8dJtgHcBZFYX2zyxd7KDwXNUUYacEHTlRKp7svd6QDjiAnbs96rzNtM6Lw4t
         0bXw==
MIME-Version: 1.0
References: <20200209110557.1996-1-linux.amoon@gmail.com> <20200209110557.1996-3-linux.amoon@gmail.com>
 <420ac33a-7b49-40b9-aa41-aee8f83e49f3@baylibre.com>
In-Reply-To: <420ac33a-7b49-40b9-aa41-aee8f83e49f3@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 9 Feb 2020 22:53:57 +0530
Message-ID: <CANAwSgSFDLdSdW8Dys3wGziMQzw=Rg8jc7uCq129reAQeXhkpQ@mail.gmail.com>
Subject: Re: [PATCHv6 2/5] mmc: meson-gx: Use proper compatible string as per the dts
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil

Thanks for your review comments.

On Sun, 9 Feb 2020 at 18:31, Neil Armstrong <narmstrong@baylibre.com> wrote=
:
>
> Hi,
>
> Le 09/02/2020 =C3=A0 12:05, Anand Moon a =C3=A9crit :
> > Use proper compatible string as per the dts so that mmc driver
> > could be tuned properly. SoC family S905, S905X have common clk
> > tuning parameters setting, while AGX and G12 have common clk tuning
> > parameters setting for mmc driver.
> >
> > Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > No changes.
> > ---
> >  arch/arm/include/asm/arch-meson/sd_emmc.h |  7 ++++
> >  drivers/mmc/meson_gx_mmc.c                | 46 +++++++++++++++++------
> >  2 files changed, 41 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/inclu=
de/asm/arch-meson/sd_emmc.h
> > index f4299485dc..83142d5d3f 100644
> > --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> > +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> > @@ -13,6 +13,12 @@
> >  #define SDIO_PORT_B                  1
> >  #define SDIO_PORT_C                  2
> >
> > +enum mmc_compatible {
> > +        MMC_COMPATIBLE_GXBB,
> > +        MMC_COMPATIBLE_GX,
> > +        MMC_COMPATIBLE_AXG,
> > +};
> > +
> >  #define SD_EMMC_CLKSRC_24M           24000000        /* 24 MHz */
> >  #define SD_EMMC_CLKSRC_DIV2          1000000000      /* 1 GHz */
> >
> > @@ -87,6 +93,7 @@
> >  struct meson_mmc_platdata {
> >       struct mmc_config cfg;
> >       struct mmc mmc;
> > +     int compat;
> >       void *regbase;
> >       void *w_buf;
> >  };
> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> > index b013c7c5fb..1aefe360c4 100644
> > --- a/drivers/mmc/meson_gx_mmc.c
> > +++ b/drivers/mmc/meson_gx_mmc.c
> > @@ -37,7 +37,8 @@ static inline void meson_write(struct mmc *mmc, uint3=
2_t val, int offset)
> >       writel(val, get_regbase(mmc) + offset);
> >  }
> >
> > -static void meson_mmc_config_clock(struct mmc *mmc)
> > +static void meson_mmc_config_clock(struct mmc *mmc,
> > +                                struct meson_mmc_platdata *pdata)
> >  {
> >       uint32_t meson_mmc_clk =3D 0;
> >       unsigned int clk, clk_src, clk_div;
> > @@ -66,14 +67,20 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >       /* RX clock phase 0:180 */
> >       meson_mmc_clk |=3D FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> >
> > -#ifdef CONFIG_MESON_GX
> > -     /* clk always on */
> > -     meson_mmc_clk |=3D CLK_V2_ALWAYS_ON;
> > -#endif
> > -#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
> > -     /* clk always on */
> > -     meson_mmc_clk |=3D CLK_V3_ALWAYS_ON;
> > -#endif
> > +     switch (pdata->compat) {
> > +     case MMC_COMPATIBLE_GXBB:
> > +     case MMC_COMPATIBLE_GX:
> > +             /* clk always on */
> > +             meson_mmc_clk |=3D CLK_V2_ALWAYS_ON;
> > +             break;
> > +     case MMC_COMPATIBLE_AXG:
> > +             /* clk always on */
> > +             meson_mmc_clk |=3D CLK_V3_ALWAYS_ON;
> > +             break;
> > +     default:
> > +             debug("no compatible supported");
> > +             break;
> > +     }
> >
> >       /* clock settings */
> >       meson_mmc_clk |=3D clk_src;
> > @@ -85,9 +92,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >  static int meson_dm_mmc_set_ios(struct udevice *dev)
> >  {
> >       struct mmc *mmc =3D mmc_get_mmc_dev(dev);
> > +     struct meson_mmc_platdata *pdata =3D
> > +             (struct meson_mmc_platdata *)dev_get_driver_data(dev);
> >       uint32_t meson_mmc_cfg;
> >
> > -     meson_mmc_config_clock(mmc);
> > +     meson_mmc_config_clock(mmc, pdata);
> >
> >       meson_mmc_cfg =3D meson_read(mmc, MESON_SD_EMMC_CFG);
> >
> > @@ -324,9 +333,22 @@ int meson_mmc_bind(struct udevice *dev)
> >       return mmc_bind(dev, &pdata->mmc, &pdata->cfg);
> >  }
> >
> > +static const struct meson_mmc_platdata gxbb_data =3D {
> > +        .compat =3D MMC_COMPATIBLE_GXBB,
> > +};
> > +
> > +static const struct meson_mmc_platdata gx_data =3D {
> > +        .compat =3D MMC_COMPATIBLE_GX,
> > +};
> > +
> > +static const struct meson_mmc_platdata axg_data =3D {
> > +        .compat =3D MMC_COMPATIBLE_AXG,
> > +};
> > +
> >  static const struct udevice_id meson_mmc_match[] =3D {
> > -     { .compatible =3D "amlogic,meson-gx-mmc" },
> > -     { .compatible =3D "amlogic,meson-axg-mmc" },
> > +     { .compatible =3D "amlogic,meson-gxbb-mmc", .data =3D (ulong)&gxb=
b_data },
> > +     { .compatible =3D "amlogic,meson-gx-mmc", .data =3D (ulong)&gx_da=
ta },
> > +     { .compatible =3D "amlogic,meson-axg-mmc", .data =3D (ulong)&axg_=
data },
> >       { /* sentinel */ }
> >  };
> >
> >
>
>
> It's fine but you should do that before patch 1, and introduce the clk se=
tup directly with the MMC_COMPATIBLE_*.
>

Only GXBB and GLX have  CLK_ALWAYS_ON(24) bit set
and AXG and G12X  have CLK_ALWAYS_ON(28) bit set
for clk enable rest of the configuration is all most common for all the SoC=
.
let keep this simple as of now.


> If you move it before, then:
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Neil

-Anand
