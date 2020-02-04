Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
 by mx.groups.io with SMTP id smtpd.web12.1232.1580785777814639063
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Feb 2020 19:09:37 -0800
Received: by mail-io1-f66.google.com with SMTP id z16so14502269iod.11
        for <u-boot-amlogic@groups.io>; Mon, 03 Feb 2020 19:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Innr4Pd9sgnuWbuCoFM5f5lBh+2RuKsp3/GgCJUKJbM=;
        b=Xn6itc6WfyhLUe1rsb7Acbk+019igBj7Z2v6krg/khtehPnmu7Y6WgzlgJfT6fccE2
         hPb4TG0roGi3kZjXqL1o4IKnu9INnr0BdAjjZWqAnt60Q75SHl9HE/0BhSWyjohKRLNo
         Mb1ACpYCv4kxmVIG132SpdgrZW1eIwOTote0ppXduPxL2DCqfvVIPPg567TWdzvGGBVe
         HbYI1J00ekB414rXGEozt6X4SLYzn5x8y7sL80uS7YrhDDzQD9IAgkzSM7sflF+d+SL6
         33eS8TlZcvoMt94NVY3aGhQInE6I1AwMSq4tgsmRsF/vqJzMjGNIe3KPzoDqP8KcfyPQ
         K1RA==
MIME-Version: 1.0
References: <20200203151323.4615-1-linux.amoon@gmail.com> <20200203151323.4615-2-linux.amoon@gmail.com>
 <1jimkn7k5b.fsf@starbuckisacylon.baylibre.com> <CANAwSgQOaCi1eZipXu8Bu7AjRPMLX6hPAAdZt8q-CcgmZnAzPw@mail.gmail.com>
 <1jh8077eh6.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jh8077eh6.fsf@starbuckisacylon.baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 4 Feb 2020 08:39:26 +0530
Message-ID: <CANAwSgQ4VA9=tOzyTHMR3hOmhinGgxBXb_S3zXLF_SFAqeKvXA@mail.gmail.com>
Subject: Re: [PATCHv5 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
Content-Type: text/plain; charset="UTF-8"
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Jerome,

Thanks for your review comments,

On Mon, 3 Feb 2020 at 23:14, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 03 Feb 2020 at 17:38, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > Hi Jerome,
> >
> > Thanks for your review,
> >
> > On Mon, 3 Feb 2020 at 21:11, Jerome Brunet <jbrunet@baylibre.com> wrote:
> >>
> >>
> >> On Mon 03 Feb 2020 at 16:13, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> > As per mainline line kernel fix the clk tuning phase for mmc,
> >> > set Core=180, Tx=180, Rx=0 clk phase for mmc initialization.
>
> Which version ?
> I don't recall any version of mainline linux kernel which has used these
> default settings.

Ok typo, I was just referring the datasheet for the default values,

>
> >> > As per S905, S905X, AGX and S922X datasheet set the default
> >> > values for clk tuning.
> >> >
> >> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >> > ---
> >> >  arch/arm/include/asm/arch-meson/sd_emmc.h | 28 ++++++++++++------
> >> >  drivers/mmc/meson_gx_mmc.c                | 36 +++++++++++++++++++----
> >> >  2 files changed, 50 insertions(+), 14 deletions(-)
> >> >
> >> > diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
> >> > index e3a72c8b66..b7a99947b3 100644
> >> > --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> >> > +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> >> > @@ -7,6 +7,7 @@
> >> >  #define __SD_EMMC_H__
> >> >
> >> >  #include <mmc.h>
> >> > +#include <linux/bitops.h>
> >> >
> >> >  #define SDIO_PORT_A                  0
> >> >  #define SDIO_PORT_B                  1
> >> > @@ -19,15 +20,24 @@
> >> >  #define   CLK_MAX_DIV                        63
> >> >  #define   CLK_SRC_24M                        (0 << 6)
> >> >  #define   CLK_SRC_DIV2                       (1 << 6)
> >> > -#define   CLK_CO_PHASE_000           (0 << 8)
> >> > -#define   CLK_CO_PHASE_090           (1 << 8)
> >> > -#define   CLK_CO_PHASE_180           (2 << 8)
> >> > -#define   CLK_CO_PHASE_270           (3 << 8)
> >> > -#define   CLK_TX_PHASE_000           (0 << 10)
> >> > -#define   CLK_TX_PHASE_090           (1 << 10)
> >> > -#define   CLK_TX_PHASE_180           (2 << 10)
> >> > -#define   CLK_TX_PHASE_270           (3 << 10)
> >> > -#define   CLK_ALWAYS_ON                      BIT(24)
> >> > +
> >> > +#define   CRYSTAL_24MHZ                      0
> >> > +#define   CLK_PHASE_0                        0
> >> > +#define   CLK_PHASE_180                      2
> >> > +
> >> > +#define   CLK_DIV_MASK                       GENMASK(5, 0)
> >> > +#define   CLK_SRC_MASK                       GENMASK(7, 6)
> >> > +#define   CLK_CORE_PHASE_MASK                GENMASK(9, 8)
> >> > +#define   CLK_TX_PHASE_MASK          GENMASK(11, 10)
> >> > +#define   CLK_RX_PHASE_MASK          GENMASK(13, 12)
> >> > +
> >> > +#define   CLK_V2_TX_DELAY_MASK               GENMASK(19, 16)
> >> > +#define   CLK_V2_RX_DELAY_MASK               GENMASK(23, 20)
> >> > +#define   CLK_V2_ALWAYS_ON           BIT(24)
> >> > +
> >> > +#define   CLK_V3_TX_DELAY_MASK               GENMASK(21, 16)
> >> > +#define   CLK_V3_RX_DELAY_MASK               GENMASK(27, 22)
> >> > +#define   CLK_V3_ALWAYS_ON           BIT(28)
> >> >
> >> >  #define MESON_SD_EMMC_CFG            0x44
> >> >  #define   CFG_BUS_WIDTH_MASK         GENMASK(1, 0)
> >> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> >> > index 86c1a7164a..03fb70e717 100644
> >> > --- a/drivers/mmc/meson_gx_mmc.c
> >> > +++ b/drivers/mmc/meson_gx_mmc.c
> >> > @@ -16,6 +16,10 @@
> >> >  #include <asm/arch/sd_emmc.h>
> >> >  #include <linux/log2.h>
> >> >
> >> > +#include <linux/bitops.h>
> >> > +#include <linux/compat.h>
> >> > +#include <linux/bitfield.h>
> >> > +
> >> >  static inline void *get_regbase(const struct mmc *mmc)
> >> >  {
> >> >       struct meson_mmc_platdata *pdata = mmc->priv;
> >> > @@ -51,11 +55,33 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >> >       }
> >> >       clk_div = DIV_ROUND_UP(clk, mmc->clock);
> >> >
> >> > -     /* 180 phase core clock */
> >> > -     meson_mmc_clk |= CLK_CO_PHASE_180;
> >> > -
> >> > -     /* 180 phase tx clock */
> >> > -     meson_mmc_clk |= CLK_TX_PHASE_000;
> >> > +     /* Clock divider */
> >> > +     meson_mmc_clk |= CLK_DIV_MASK;
> >> > +     /* Clock source : Crystal 24MHz */
> >> > +     meson_mmc_clk |= FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
> >> > +     /* Core clock phase 2:180 */
> >> > +     meson_mmc_clk |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
> >> > +     /* TX clock phase 2:180 */
> >> > +     meson_mmc_clk |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_180);
> >>
> >> I think I mentionned already but this is not aligned with the setting
> >> used by the linux driver. If you have problems with these, please report
> >> it to the linux mailing list
> >
> > Yes I will try to send this changes to linux driver since these are
> > the recommend
> > default values as per the datasheets, see below.
> > Cfg_tx_phase: TX clock phase 0: 0 phase, 1: 90 phase, 2: 180 phase, 3:
> > 270 phase. Recommended value: 2
>
> Well we already had that discussion 2 years ago regarding the
> recommended setting. The fact is that it did not work that well.
>
> Please the try the setting implemented in the linux driver
> Core: 180, Tx: 0, Rx:0 and report issue to linux-ml. Thx
>
Ok I will used the linux-ml setting over here as well in u-boot.

> >
> >>
> >> > +     /* RX clock phase 0:180 */
> >> > +     meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> >> > +
> >> > +#ifdef CONFIG_MESON_GX
> >> > +     /* TX clock delay line */
> >> > +     meson_mmc_clk |= CLK_V2_TX_DELAY_MASK;
> >> > +     /* RX clock delay line */
> >> > +     meson_mmc_clk |= CLK_V2_RX_DELAY_MASK;
> >>
> >> Why do you need to this ?
> >
> > As these are part of the linux driver, I added these,
> > I will check if this changes are needed in u-boot.
>
> The linux driver never wrote the MASK value to register, which would set
> all the bits to 1. It does not make sense.
>
> The fact is that the linux kernel has not been using the rx and tx
> delays at all since v5.2
>
> It would better to just let these values alone.

Ok. I will drop this changes and stick to linux-ml changes for u-boot driver.

>
> >>
> >> > +     /* clk always on */
> >> > +     meson_mmc_clk |= CLK_V2_ALWAYS_ON;
> >> > +#endif
> >> > +#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
> >> > +     /* TX clock delay line */
> >> > +     meson_mmc_clk |= CLK_V3_TX_DELAY_MASK;
> >> > +     /* RX clock delay line */
> >> > +     meson_mmc_clk |= CLK_V3_RX_DELAY_MASK;
> >> > +     /* clk always on */
> >> > +     meson_mmc_clk |= CLK_V3_ALWAYS_ON;
> >> > +#endif
> >> >
> >> >       /* clock settings */
> >> >       meson_mmc_clk |= clk_src;
> >>
> >
> > -Anand
>

-Anand
