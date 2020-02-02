Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
 by mx.groups.io with SMTP id smtpd.web10.6983.1580615559109379415
 for <u-boot-amlogic@groups.io>;
 Sat, 01 Feb 2020 19:52:39 -0800
Received: by mail-il1-f193.google.com with SMTP id f5so9737418ilq.5
        for <u-boot-amlogic@groups.io>; Sat, 01 Feb 2020 19:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eWBXrb71hVb/XZupAAjYD+QPBEB8V+XEbfTiVJxUCnk=;
        b=i6K26J/ZLHGPo9gWH7wAJG8BuKAGSCz1VOmvIywqE811DSeWhMTNkfzpnanILPz2JQ
         hSgTVmZMVW1kn1x7rxkAKwSn+k9wTbtAfi3k8argI0w0M5CxtU0Z5YWmaF+9+NGA0toh
         uI5P9Atyo5CDcvd3I/XnVeSt+D2yMkoZ/mrUu8S3h5Pui/6qG7GeeTaqVBJxW2HFe0mG
         sqZI1WTwXbD6fG+rsPoTequK3qDPneZ1CrTCjwm84ouWDqUt3UsbbPY4rz0XjR/Qo/9P
         nt3DcezeG1AArqZbSVSG+1ofllEKe1jnA5Z9cEheiM2vW/fNtNypqg4cLeI0nyEBk5ij
         DJ5Q==
MIME-Version: 1.0
References: <20200122120620.8699-1-linux.amoon@gmail.com> <20200122120620.8699-2-linux.amoon@gmail.com>
 <22609d3d-61c4-acae-72ab-0afd8e9cbb6e@baylibre.com>
In-Reply-To: <22609d3d-61c4-acae-72ab-0afd8e9cbb6e@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 2 Feb 2020 09:22:27 +0530
Message-ID: <CANAwSgRm=swd9ET2T6uFDyGMU5DxFYrO0+BX-_8nVzD0+gLwJQ@mail.gmail.com>
Subject: Re: [Patchv4 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Sat, 1 Feb 2020 at 12:54, Neil Armstrong <narmstrong@baylibre.com> wrote=
:
>
>
>
> Le 22/01/2020 =C3=A0 13:06, Anand Moon a =C3=A9crit :
> > As per mainline line kernel fix the clk tunig phase for
> > mmc, set Core=3D180, Tx=3D180, Rx=3D0 clk phase for mmc initialization.
> > As per S905X and S922X datasheet set the default values
> > for clk tuning.
>
> Please add you also add AXG/G12 setup.

Ok.

>
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes from previous
> > v3  Fix the initialization of core clk tunning phase as per datasheet.
> >     Fix the commit message.
> >
> > v2: Fix the clk phase macro to support PHASE_180
> >     drop the wrong CLK_CORE_PHASE_MASK macro.
> >
> > v1: use the mainline kernel tuning for clk tuning.
> >
> > Fixed the commmit messages.
> > Patch v1:
> > https://patchwork.ozlabs.org/patch/1201208/
> >
> > Before these changes.
> >     clock is enabled (380953Hz)
> >     clock is enabled (25000000Hz)
> > After these changes
> >     clock is enabled (380953Hz)
> >     clock is enabled (25000000Hz)
> >     clock is enabled (52000000Hz)
> > Test on Odroid N2 and Odroid C2 with eMMC and microSD cards
> > ---
> >  arch/arm/include/asm/arch-meson/sd_emmc.h | 11 ++-----
> >  drivers/mmc/meson_gx_mmc.c                | 38 +++++++++++++++++++----
> >  2 files changed, 35 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/inclu=
de/asm/arch-meson/sd_emmc.h
> > index e3a72c8b66..c193547aad 100644
> > --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> > +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> > @@ -7,6 +7,7 @@
> >  #define __SD_EMMC_H__
> >
> >  #include <mmc.h>
> > +#include <linux/bitops.h>
> >
> >  #define SDIO_PORT_A                  0
> >  #define SDIO_PORT_B                  1
> > @@ -19,14 +20,8 @@
> >  #define   CLK_MAX_DIV                        63
> >  #define   CLK_SRC_24M                        (0 << 6)
> >  #define   CLK_SRC_DIV2                       (1 << 6)
> > -#define   CLK_CO_PHASE_000           (0 << 8)
> > -#define   CLK_CO_PHASE_090           (1 << 8)
> > -#define   CLK_CO_PHASE_180           (2 << 8)
> > -#define   CLK_CO_PHASE_270           (3 << 8)
> > -#define   CLK_TX_PHASE_000           (0 << 10)
> > -#define   CLK_TX_PHASE_090           (1 << 10)
> > -#define   CLK_TX_PHASE_180           (2 << 10)
> > -#define   CLK_TX_PHASE_270           (3 << 10)
> > +#define        UPDATE(x, h, l)               (((x) << (l)) & GENMASK((=
h), (l)))
>
> A macro already exists for that: FIELD_PREP(), please use it with proper =
BIT and GENMASK defines.
>
Thanks for this input.
> > +
> >  #define   CLK_ALWAYS_ON                      BIT(24)
> >
> >  #define MESON_SD_EMMC_CFG            0x44
> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> > index 86c1a7164a..67b1b075ab 100644
> > --- a/drivers/mmc/meson_gx_mmc.c
> > +++ b/drivers/mmc/meson_gx_mmc.c
> > @@ -51,12 +51,38 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >       }
> >       clk_div =3D DIV_ROUND_UP(clk, mmc->clock);
> >
> > -     /* 180 phase core clock */
> > -     meson_mmc_clk |=3D CLK_CO_PHASE_180;
> > -
> > -     /* 180 phase tx clock */
> > -     meson_mmc_clk |=3D CLK_TX_PHASE_000;
> > -
> > +     /* Clock divider */
> > +     meson_mmc_clk =3D GENMASK(5, 0);
> > +     /* Clock source 1: Fix PLL, 1000MHz */
> > +     meson_mmc_clk |=3D UPDATE(1, 7, 6);
> > +     /* Core clock phase 2:180 */
> > +     meson_mmc_clk |=3D UPDATE(2, 9, 8);
> > +     /* TX clock phase 2:180 */
> > +     meson_mmc_clk |=3D UPDATE(2, 11, 10);
> > +     /* RX clock phase 0:180 */
> > +     meson_mmc_clk |=3D UPDATE(0, 13, 12);
> > +#ifdef CONFIG_MESON_GX
> > +     /* TX clock delay line */
> > +     meson_mmc_clk |=3D GENMASK(19, 16);
> > +     /* RX clock delay line */
> > +     meson_mmc_clk |=3D GENMASK(23, 20);
> > +     /* clk always on */
> > +     meson_mmc_clk |=3D BIT(20);
> > +     /* clk irq sdio sleep */
> > +     meson_mmc_clk |=3D BIT(25);
> > +#endif
> > +#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
> > +     /* TX clock delay line */
> > +     meson_mmc_clk |=3D  GENMASK(21, 16);
> > +     /* RX clock delay line */
> > +     meson_mmc_clk |=3D  GENMASK(27, 22);
> > +     /* clk always on */
> > +     meson_mmc_clk |=3D BIT(28);
> > +     /* clk irq sdio sleep */
> > +     meson_mmc_clk |=3D BIT(29);
> > +     /* clk irq sdio sleep_ds */
> > +     meson_mmc_clk |=3D BIT(30);
>
> As Jaehoon wrote, please define these MASKs and BITs
>
> > +#endif
>
> Instead of ifdef, please add a data in the compatible list and use thez
> fact we use amlogic,meson-axg-mmc on AXG & G12/SM1.
>
> Example: https://github.com/u-boot/u-boot/blob/master/drivers/video/meson=
/meson_vpu.c#L98
> and https://github.com/u-boot/u-boot/blob/master/drivers/video/meson/meso=
n_vpu.c#L37
>

Ok, Thanks for the input.

> >       /* clock settings */
> >       meson_mmc_clk |=3D clk_src;
> >       meson_mmc_clk |=3D clk_div;
> >
>
> Thanks,
> Neil

-Anand
