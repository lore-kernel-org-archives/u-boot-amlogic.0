Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
 by mx.groups.io with SMTP id smtpd.web10.19316.1577352653319564770
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Dec 2019 01:30:53 -0800
Received: by mail-il1-f193.google.com with SMTP id v15so19862049iln.0
        for <u-boot-amlogic@groups.io>; Thu, 26 Dec 2019 01:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYdZS13AIjIaYVKTSaUUGL+ymdB/qRdB8PkmT5jOXbs=;
        b=EyxIsl8nM9FzeSgy974x5uAjUjGu3KYhr0T1HfCSAAiBwm5IwnX1ozz0yTzJxt+hbO
         CWeNpAU2dranWx1LExcotCAdh9CRMRBiGgRpF638wUhkXGQRvPx7ztp+6SjhGPVDtHkS
         f2IRuxrWScClcxYnYENvO/hEshsYFmCnWVecYtxc73hZqO4qb2CsMzKOomcJIlnhr735
         M8L+Q0D7Bz79IqTdncfPFERIIhIoE0dId2rAolZbTFzSFOWNMIToGGIL7WOEJchnikA/
         2bruDzJpEgVyGcIVvYmyU2oHbaYvJGdrya3t00iLoobhGmNXyi4eghAeA3exqdTO3Zx6
         8D4w==
MIME-Version: 1.0
References: <20191224132551.1427-1-linux.amoon@gmail.com> <20191224132551.1427-2-linux.amoon@gmail.com>
 <1jh81npi4k.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jh81npi4k.fsf@starbuckisacylon.baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Dec 2019 15:00:40 +0530
Message-ID: <CANAwSgTGqt5e6dEe4f4G_isuSBZ9kcv8JSSKV4U5d+wThXngYA@mail.gmail.com>
Subject: Re: [U-Boot] [PATCHv2 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
Content-Type: text/plain; charset="UTF-8"
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Jerome,

On Thu, 26 Dec 2019 at 14:40, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Tue 24 Dec 2019 at 14:25, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > As per mainline line kernel fix the clk tunnig phase for
> > mmc, set Core=180, Tx=0, Rx=0 clk phase for mmc initialization.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes from previous
> > use the mainline kernel tuning for clk tuning.
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
> >  arch/arm/include/asm/arch-meson/sd_emmc.h | 14 ++++++--------
> >  drivers/mmc/meson_gx_mmc.c                |  9 +++++----
> >  2 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
> > index e3a72c8b66..d70fe4f03e 100644
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
> > @@ -19,14 +20,11 @@
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
> > +
> > +#define   CLK_CORE_PHASE_MASK                GENMASK(9, 8)
> > +#define   CLK_TX_PHASE_MASK          GENMASK(11, 10)
> > +#define   CLK_RX_PHASE_MASK          GENMASK(13, 12)
> > +
> >  #define   CLK_ALWAYS_ON                      BIT(24)
> >
> >  #define MESON_SD_EMMC_CFG            0x44
> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> > index 86c1a7164a..402981c3bb 100644
> > --- a/drivers/mmc/meson_gx_mmc.c
> > +++ b/drivers/mmc/meson_gx_mmc.c
> > @@ -52,10 +52,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >       clk_div = DIV_ROUND_UP(clk, mmc->clock);
> >
> >       /* 180 phase core clock */
> > -     meson_mmc_clk |= CLK_CO_PHASE_180;
> > -
> > -     /* 180 phase tx clock */
> > -     meson_mmc_clk |= CLK_TX_PHASE_000;
> > +     meson_mmc_clk |= CLK_CORE_PHASE_MASK;
> > +     /* 000 phase rx clock */
> > +     meson_mmc_clk |= CLK_RX_PHASE_MASK;
> > +     /* 000 phase tx clock */
> > +     meson_mmc_clk |= CLK_TX_PHASE_MASK;
> >
>
> I'm not sure how this acheive what is descibed in the commit
> description.
>
> It looks more that it would set a 270 degree phase on all clocks, which
> is not desirable.
>
Oops thanks for spotting my mistake, you are correct, it should be as below.

clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
I will resend with correct configuration.

-Anand
