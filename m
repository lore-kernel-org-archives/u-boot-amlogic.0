Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
 by mx.groups.io with SMTP id smtpd.web09.6803.1578745413976921233
 for <u-boot-amlogic@groups.io>;
 Sat, 11 Jan 2020 04:23:34 -0800
Received: by mail-io1-f68.google.com with SMTP id c16so4928974ioh.6
        for <u-boot-amlogic@groups.io>; Sat, 11 Jan 2020 04:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDQ51rKfms+EUy4+GX2DZhO9hGjqOXZdl/NjftRREU8=;
        b=dr8GsIELxuxYyY6+rxH93ufLFZzpYP708mnhPhVWFroZ5uCaJK4kiLYUOkLZffa4HT
         6VeQC56vJQVRQmuW82qeXRIA7NEBxwQKZY7bZvYWGNp8Ii0B6CktuRC1hhJfyuzUYow2
         sAlLI4/f5gU6aXyW1/fFaa0yJUcy/WIV7puRBccxeLXtXiZpPqNiSK5VbvESABUnws7+
         RyT2sXfN1xBTQOJmW5+xC/Xy2PZy7I2ZowAx2sKWPkbyPsH+bHylTjdfi6dst4w146m9
         7zQwpD1rG2Az9Rr7LpD0fIB7Dg53UMhu5j9wK5J2cS60hKYqsNbRiTfvDRKKigpdAqog
         ulmg==
MIME-Version: 1.0
References: <20191226113353.1757-1-linux.amoon@gmail.com> <20191226113353.1757-2-linux.amoon@gmail.com>
 <1j8smjsi06.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j8smjsi06.fsf@starbuckisacylon.baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 11 Jan 2020 17:53:24 +0530
Message-ID: <CANAwSgRTzRdS36hZ3DvuFGemazDCP3TofzBfBMkSjBJ5_i6CzA@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
Content-Type: text/plain; charset="UTF-8"
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Jerome,

On Tue, 7 Jan 2020 at 15:31, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Thu 26 Dec 2019 at 12:33, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > As per mainline line kernel fix the clk tunnig phase for
> > mmc, set Core=180, Tx=0, Rx=0 clk phase for mmc initialization.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes from previous
> > v2: Fix the clk phase macro to support PHASE_180
> >     drop the wrong CLK_CORE_PHASE_MASK macro.
> >
> > v1: use the mainline kernel tuning for clk tuning.
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
> > index e3a72c8b66..ee20c009e2 100644
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
> > +#define   CLK_PHASE_180              2
> > +#define   CLK_TX_PHASE_MASK          GENMASK(11, 10)
> > +#define   CLK_RX_PHASE_MASK          GENMASK(13, 12)
> > +
> >  #define   CLK_ALWAYS_ON                      BIT(24)
> >
> >  #define MESON_SD_EMMC_CFG            0x44
> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> > index 86c1a7164a..ad697d3a5e 100644
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
> > +     meson_mmc_clk |= CLK_PHASE_180;
> > +     /* 000 phase rx clock */
> > +     meson_mmc_clk |= CLK_RX_PHASE_MASK;
> > +     /* 000 phase tx clock */
> > +     meson_mmc_clk |= CLK_TX_PHASE_MASK;
>
> The comment on your previous version seemed correct but I think what you
> have implemented here is still not doing what you expect.

Thanks for your review. Ok I admit, I did not study the code correctly and
it's wrong to set this way. Plz discard this changes it's wrong.
It did not worked for some sdcards and emmc.

-Anand
