Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
 by mx.groups.io with SMTP id smtpd.web09.5394.1581595452875273924
 for <u-boot-amlogic@groups.io>;
 Thu, 13 Feb 2020 04:04:12 -0800
Received: by mail-il1-f195.google.com with SMTP id o13so4736612ilg.10
        for <u-boot-amlogic@groups.io>; Thu, 13 Feb 2020 04:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZFOIgurO1wKKlNmQV0HvGZxSnPLK7XJpmUud9WaKJmo=;
        b=i3uGQQIPe+XeGKb24vknDAWEbScQhb6I3rz2cfcSo/SFTsHXJ0k+fP0V4/7SvtZ6GX
         yMzOKQP36f+YgsnK068V7T8q+ts2Ejs6QBF8P23pL14MOWVKiCrTASgaFaX05SdTwt3s
         wYEWjGz4Nx0VDbZAlKIDoiOuQAxDDGv5uGMHPijbzEaJ/PtyLxBJ49fHIu9TG5lvvSuZ
         hpCXd980oaaaLtmrsrgfXQrIBoTGkV9uEnQwS/Sa2QRPvr7peTycrjIjnjBQgjr0mTEf
         F3NQCHOCbLDWE5v/WDuJd5sBdimSIBSnwvS90cKKtIpQrd4LnpaCUCJa9tQRJqMLsAIA
         XOOw==
MIME-Version: 1.0
References: <20200209110557.1996-1-linux.amoon@gmail.com> <20200209110557.1996-2-linux.amoon@gmail.com>
 <61096502-4817-a095-4d11-b487781202b0@baylibre.com> <CANAwSgT7SyqgwWE9SEvLYasW-qzfCYHSJrFfeCNt2dv0XxVsiA@mail.gmail.com>
 <1jr1z2bx8s.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jr1z2bx8s.fsf@starbuckisacylon.baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 13 Feb 2020 17:34:00 +0530
Message-ID: <CANAwSgTwoJxfMpiV9E65sG7AX0Ap6U9oYxwfVb2rLtFV2jeOWQ@mail.gmail.com>
Subject: Re: [PATCHv6 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Jerome / Neil,

On Mon, 10 Feb 2020 at 15:05, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Sun 09 Feb 2020 at 18:22, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > Hi Neil,
> >
> > Thanks for you review comments.
> >
> > On Sun, 9 Feb 2020 at 18:38, Neil Armstrong <narmstrong@baylibre.com> w=
rote:
> >>
> >> Hi,
> >>
> >> Le 09/02/2020 =C3=A0 12:05, Anand Moon a =C3=A9crit :
> >> > As per mainline line kernel fix the clk tuning phase for mmc,
> >> > set Core=3D180, Tx=3D0, Rx=3D0 clk phase for mmc initialization.
> >> > As per S905, S905X, AGX and S922X datasheet set the default
> >> > values for clk tuning.
> >> >
> >> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >> > ---
> >> > Changes from previous
> >> > v5  Fix the commit message, configure as per mainline kernel.
> >> >     drop the RX_DELAY_MASK and TX_DELAY_MASK as they are not used.
> >> >
> >> > v4  Fix the update mask value using FIELD_PREP macro.
> >> >
> >> > v3  Fix the initialization of core clk tunning phase as per datashee=
t.
> >> >     Fix the commit message.
> >> >
> >> > v2: Fix the clk phase macro to support PHASE_180
> >> >     drop the wrong CLK_CORE_PHASE_MASK macro.
> >> >
> >> > v1: use the mainline kernel tuning for clk tuning.
> >> >
> >> > Fixed the commmit messages.
> >> > Patch v1:
> >> > https://patchwork.ozlabs.org/patch/1201208/
> >> >
> >> > Before these changes.
> >> >     clock is enabled (380953Hz)
> >> >     clock is enabled (25000000Hz)
> >> > After these changes
> >> >     clock is enabled (380953Hz)
> >> >     clock is enabled (25000000Hz)
> >> >     clock is enabled (52000000Hz)
> >> > Test on Odroid N2 and Odroid C2 with eMMC and microSD cards
> >> > ---
> >> >  arch/arm/include/asm/arch-meson/sd_emmc.h | 24 +++++++++++--------
> >> >  drivers/mmc/meson_gx_mmc.c                | 28 +++++++++++++++++++-=
---
> >> >  2 files changed, 38 insertions(+), 14 deletions(-)
> >> >
> >> > diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/in=
clude/asm/arch-meson/sd_emmc.h
> >> > index e3a72c8b66..f4299485dc 100644
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
> >> > @@ -19,15 +20,20 @@
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
> >> > +#define   CLK_V2_ALWAYS_ON           BIT(24)
> >> > +
> >> > +#define   CLK_V3_ALWAYS_ON           BIT(28)
> >> >
> >> >  #define MESON_SD_EMMC_CFG            0x44
> >> >  #define   CFG_BUS_WIDTH_MASK         GENMASK(1, 0)
> >> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> >> > index 86c1a7164a..b013c7c5fb 100644
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
> >> >       struct meson_mmc_platdata *pdata =3D mmc->priv;
> >> > @@ -51,11 +55,25 @@ static void meson_mmc_config_clock(struct mmc *m=
mc)
> >> >       }
> >> >       clk_div =3D DIV_ROUND_UP(clk, mmc->clock);
> >> >
> >> > -     /* 180 phase core clock */
> >> > -     meson_mmc_clk |=3D CLK_CO_PHASE_180;
> >> > -
> >> > -     /* 180 phase tx clock */
> >> > -     meson_mmc_clk |=3D CLK_TX_PHASE_000;
> >> > +     /* Clock divider */
> >> > +     meson_mmc_clk |=3D CLK_DIV_MASK;
> >>
> >> This will set the max divider, whatever the value of clk_div, so the f=
ollowing statement:
> >> meson_mmc_clk |=3D clk_div;
> >> will have no effect.
> >
> > As per the datasheet S905 and S922X max divider is 63.
> > CLK_DIV_MASK[0-5]      Cfg_div: Clock divider
> >                                         Frequency =3D clock source/cfg_=
div
> >                                         Clock off: cfg_div=3D=3D0, the
> > clock is disabled
> >                                         Divider bypass: cfg_div=3D=3D1,
> > clock source is used as core clock without divider
> >                                         Maximum divider 63
> >
> > So here is the log of clk_div and clk_freq at my end.
> >
> > MMC Device 0 not found
> > no mmc device at slot 0
> > clock is disabled (0Hz)
> > clock is enabled (380953Hz)
> > ......clk_div : 63
> > Card did not respond to voltage select!
> > clock is disabled (0Hz)
> > clock is enabled (380953Hz)
> > ......clk_div : 63
> > clock is enabled (25000000Hz)
> > ......clk_div : 40
> > ......clk_div : 40
> > clock is enabled (52000000Hz)
> > ......clk_div : 20
> > switch to partitions #0, OK
> > mmc2(part 0) is current device
> > Scanning mmc 2:1...
> > Found U-Boot script /boot/boot.scr
> >
> >>
> >>
> >> > +     /* Clock source : Crystal 24MHz */
> >> > +     meson_mmc_clk |=3D FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
> >>
> >> You set CRYSTAL_24MHZ here, but the src is selected in clk_src and set=
 with:
> >> meson_mmc_clk |=3D clk_src;
> >>
> >> In conclusion your change forces the 24MHz crystal and max divider wha=
tever the
> >> freq asked by the mmc core !
> >>
> > As per the datasheet S905 and S922X
> > Cfg_src:             Clock source
> >                           0: Crystal 24MHz or other frequencies
> > selected by clock reset test control register.
> >                           1: Fix PLL, 1000MHz
> >                           Recommended value: 1
> >
> > Note: *setting cfg_src value to I       i.e; Fix PLL 1000 Mhz *
> > some how break the clk_freq tuning setting in my testing,
> > see the logs below.
> >
> > MMC Device 0 not found
> > no mmc device at slot 0
> > clock is disabled (0Hz)
> > clock is enabled (380953Hz)
> > ......clk_div : 63
> > Card did not respond to voltage select!
> > clock is disabled (0Hz)
> > clock is enabled (380953Hz)
> > ......clk_div : 63
> > starting USB...
> >
> > No emmc will get discovered,
> > *This is the real issue I faced for failure of eMMC not getting
> > detected.*
>
> I don't think the reality of the issue reported has been questioned.
> What is being questioned is the proposed solution.
>
> The patch you sent forces clock input 0 with the maximum divider
> possible. This is an important comment for which an explanation is
> missing AFAICT.
>
> 1) The doc is not clear but input 0 is not always the oscillator. It is
> the MMC composite clock which can set to several different sources,
> especially when the ROM code boots from another device, such as SPI
> This is the topic of 2 patches I sent recently (not yet merged)
>
> 2) Let's assume that input 0 is indeed 24M, your patches forces this
> with a 63 divider =3D> 380kHz. With a clock that low, the phase does not
> matter much anymore
>
> IOW, you are the only one to report this issue on one specific case, the
> cause of the issue is not really identified and the work around would:
> * Add statements without effect in the code
> * Considerably slow down eMMC and SDCard on all amlogic platforms.
> * Provide no explanation about how it actually solves something
>
> This is problematic ...
>

Ok Thanks for your review comments.
I have tried to test these on all the device that I have with all the
emmc sdcards.
I have almost used the mainline code to resolve this issue.
but my approach to address this was not up to date.

-Anand
