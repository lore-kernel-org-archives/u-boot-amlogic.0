Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
 by mx.groups.io with SMTP id smtpd.web09.659.1580747928987719218
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Feb 2020 08:38:49 -0800
Received: by mail-io1-f65.google.com with SMTP id s6so7044334iol.9
        for <u-boot-amlogic@groups.io>; Mon, 03 Feb 2020 08:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDAVCBhE7VrGEhRhMe/On4NmGFWbyUWc20UK+80g7yM=;
        b=QWcXcJbqv5dZx2TFJ9xEE2y+i7nbeotiC8W2TS2glg4DIav+DBUK1jvlOeqcGRf5R8
         1vsEXSvYUfmv0KjSCKNFZf0iuTZobkdIiE1iSSNui8uzUe+PPaKur476dEXe94bxQ7Sq
         I/ci5bYpSsC58m3dlM/9fc48KMdjBAutyybC1g6eNdFuHtq3OiIJbcQ04d94PBJuJyni
         oivR55QNhFfH0snK9CVKVw1rA9JGKP+csXmsEF3Cwf3ujqASaFtALEDStr/Ev53spIKp
         CU6YTesHR4XtY59SbYP0GqiX3faQ+aehhjHRC1cdzwyjUhIDCWSRBP/tufyUXpuJJsAF
         reCA==
MIME-Version: 1.0
References: <20200203151323.4615-1-linux.amoon@gmail.com> <20200203151323.4615-2-linux.amoon@gmail.com>
 <1jimkn7k5b.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jimkn7k5b.fsf@starbuckisacylon.baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 3 Feb 2020 22:08:33 +0530
Message-ID: <CANAwSgQOaCi1eZipXu8Bu7AjRPMLX6hPAAdZt8q-CcgmZnAzPw@mail.gmail.com>
Subject: Re: [PATCHv5 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
Content-Type: text/plain; charset="UTF-8"
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Jerome,

Thanks for your review,

On Mon, 3 Feb 2020 at 21:11, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 03 Feb 2020 at 16:13, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > As per mainline line kernel fix the clk tuning phase for mmc,
> > set Core=180, Tx=180, Rx=0 clk phase for mmc initialization.
> > As per S905, S905X, AGX and S922X datasheet set the default
> > values for clk tuning.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm/include/asm/arch-meson/sd_emmc.h | 28 ++++++++++++------
> >  drivers/mmc/meson_gx_mmc.c                | 36 +++++++++++++++++++----
> >  2 files changed, 50 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
> > index e3a72c8b66..b7a99947b3 100644
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
> > @@ -19,15 +20,24 @@
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
> > -#define   CLK_ALWAYS_ON                      BIT(24)
> > +
> > +#define   CRYSTAL_24MHZ                      0
> > +#define   CLK_PHASE_0                        0
> > +#define   CLK_PHASE_180                      2
> > +
> > +#define   CLK_DIV_MASK                       GENMASK(5, 0)
> > +#define   CLK_SRC_MASK                       GENMASK(7, 6)
> > +#define   CLK_CORE_PHASE_MASK                GENMASK(9, 8)
> > +#define   CLK_TX_PHASE_MASK          GENMASK(11, 10)
> > +#define   CLK_RX_PHASE_MASK          GENMASK(13, 12)
> > +
> > +#define   CLK_V2_TX_DELAY_MASK               GENMASK(19, 16)
> > +#define   CLK_V2_RX_DELAY_MASK               GENMASK(23, 20)
> > +#define   CLK_V2_ALWAYS_ON           BIT(24)
> > +
> > +#define   CLK_V3_TX_DELAY_MASK               GENMASK(21, 16)
> > +#define   CLK_V3_RX_DELAY_MASK               GENMASK(27, 22)
> > +#define   CLK_V3_ALWAYS_ON           BIT(28)
> >
> >  #define MESON_SD_EMMC_CFG            0x44
> >  #define   CFG_BUS_WIDTH_MASK         GENMASK(1, 0)
> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> > index 86c1a7164a..03fb70e717 100644
> > --- a/drivers/mmc/meson_gx_mmc.c
> > +++ b/drivers/mmc/meson_gx_mmc.c
> > @@ -16,6 +16,10 @@
> >  #include <asm/arch/sd_emmc.h>
> >  #include <linux/log2.h>
> >
> > +#include <linux/bitops.h>
> > +#include <linux/compat.h>
> > +#include <linux/bitfield.h>
> > +
> >  static inline void *get_regbase(const struct mmc *mmc)
> >  {
> >       struct meson_mmc_platdata *pdata = mmc->priv;
> > @@ -51,11 +55,33 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >       }
> >       clk_div = DIV_ROUND_UP(clk, mmc->clock);
> >
> > -     /* 180 phase core clock */
> > -     meson_mmc_clk |= CLK_CO_PHASE_180;
> > -
> > -     /* 180 phase tx clock */
> > -     meson_mmc_clk |= CLK_TX_PHASE_000;
> > +     /* Clock divider */
> > +     meson_mmc_clk |= CLK_DIV_MASK;
> > +     /* Clock source : Crystal 24MHz */
> > +     meson_mmc_clk |= FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
> > +     /* Core clock phase 2:180 */
> > +     meson_mmc_clk |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
> > +     /* TX clock phase 2:180 */
> > +     meson_mmc_clk |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_180);
>
> I think I mentionned already but this is not aligned with the setting
> used by the linux driver. If you have problems with these, please report
> it to the linux mailing list

Yes I will try to send this changes to linux driver since these are
the recommend
default values as per the datasheets, see below.
Cfg_tx_phase: TX clock phase 0: 0 phase, 1: 90 phase, 2: 180 phase, 3:
270 phase. Recommended value: 2

>
> > +     /* RX clock phase 0:180 */
> > +     meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> > +
> > +#ifdef CONFIG_MESON_GX
> > +     /* TX clock delay line */
> > +     meson_mmc_clk |= CLK_V2_TX_DELAY_MASK;
> > +     /* RX clock delay line */
> > +     meson_mmc_clk |= CLK_V2_RX_DELAY_MASK;
>
> Why do you need to this ?

As these are part of the linux driver, I added these,
I will check if this changes are needed in u-boot.
>
> > +     /* clk always on */
> > +     meson_mmc_clk |= CLK_V2_ALWAYS_ON;
> > +#endif
> > +#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
> > +     /* TX clock delay line */
> > +     meson_mmc_clk |= CLK_V3_TX_DELAY_MASK;
> > +     /* RX clock delay line */
> > +     meson_mmc_clk |= CLK_V3_RX_DELAY_MASK;
> > +     /* clk always on */
> > +     meson_mmc_clk |= CLK_V3_ALWAYS_ON;
> > +#endif
> >
> >       /* clock settings */
> >       meson_mmc_clk |= clk_src;
>

-Anand
