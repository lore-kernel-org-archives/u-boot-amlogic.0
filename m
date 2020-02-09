Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
 by mx.groups.io with SMTP id smtpd.web11.9759.1581268949203135886
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 09:22:29 -0800
Received: by mail-io1-f67.google.com with SMTP id z193so5014448iof.1
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 09:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NHnIwzjo41+uriJIdzaqQNCfGBsYAAWbTvSAfibn5mM=;
        b=iRS3pskRKBCttGwUSpH6oreDDez8Ojmki/kpIJNogsdq2yjSok4JkDyHU/uVdvIZ8m
         FKLrG3Yc0kX+R8DbmFM/y55kEQ6cwTrieLjTOQB9XDmjxtQbwmwyeb5iMc/mzYhQ1lKc
         kwbCbg/UQQzhgOVEx+MSSfUUOrB9TKIZ8103JNf3Kjndtsef3wPAtvszzwmHZI49YEGd
         C0RCzYPKsdSgFAZIFooJCJ8aq7r5zsaxAfYOj4R+peeIZ6lt5YKgT3dCD1fIeXBzKmFE
         xiQqEbab6DdX+kEq6vXcLnez+NTi8bnZ9COTvNgkCWbCnSqzVXynJWygd2h7Fl/NHBlS
         SjiQ==
MIME-Version: 1.0
References: <20200209110557.1996-1-linux.amoon@gmail.com> <20200209110557.1996-2-linux.amoon@gmail.com>
 <61096502-4817-a095-4d11-b487781202b0@baylibre.com>
In-Reply-To: <61096502-4817-a095-4d11-b487781202b0@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 9 Feb 2020 22:52:19 +0530
Message-ID: <CANAwSgT7SyqgwWE9SEvLYasW-qzfCYHSJrFfeCNt2dv0XxVsiA@mail.gmail.com>
Subject: Re: [PATCHv6 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

Thanks for you review comments.

On Sun, 9 Feb 2020 at 18:38, Neil Armstrong <narmstrong@baylibre.com> wrote=
:
>
> Hi,
>
> Le 09/02/2020 =C3=A0 12:05, Anand Moon a =C3=A9crit :
> > As per mainline line kernel fix the clk tuning phase for mmc,
> > set Core=3D180, Tx=3D0, Rx=3D0 clk phase for mmc initialization.
> > As per S905, S905X, AGX and S922X datasheet set the default
> > values for clk tuning.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes from previous
> > v5  Fix the commit message, configure as per mainline kernel.
> >     drop the RX_DELAY_MASK and TX_DELAY_MASK as they are not used.
> >
> > v4  Fix the update mask value using FIELD_PREP macro.
> >
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
> >  arch/arm/include/asm/arch-meson/sd_emmc.h | 24 +++++++++++--------
> >  drivers/mmc/meson_gx_mmc.c                | 28 +++++++++++++++++++----
> >  2 files changed, 38 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/inclu=
de/asm/arch-meson/sd_emmc.h
> > index e3a72c8b66..f4299485dc 100644
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
> > @@ -19,15 +20,20 @@
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
> > +#define   CLK_V2_ALWAYS_ON           BIT(24)
> > +
> > +#define   CLK_V3_ALWAYS_ON           BIT(28)
> >
> >  #define MESON_SD_EMMC_CFG            0x44
> >  #define   CFG_BUS_WIDTH_MASK         GENMASK(1, 0)
> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> > index 86c1a7164a..b013c7c5fb 100644
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
> >       struct meson_mmc_platdata *pdata =3D mmc->priv;
> > @@ -51,11 +55,25 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >       }
> >       clk_div =3D DIV_ROUND_UP(clk, mmc->clock);
> >
> > -     /* 180 phase core clock */
> > -     meson_mmc_clk |=3D CLK_CO_PHASE_180;
> > -
> > -     /* 180 phase tx clock */
> > -     meson_mmc_clk |=3D CLK_TX_PHASE_000;
> > +     /* Clock divider */
> > +     meson_mmc_clk |=3D CLK_DIV_MASK;
>
> This will set the max divider, whatever the value of clk_div, so the foll=
owing statement:
> meson_mmc_clk |=3D clk_div;
> will have no effect.

As per the datasheet S905 and S922X max divider is 63.
CLK_DIV_MASK[0-5]      Cfg_div: Clock divider
                                        Frequency =3D clock source/cfg_div
                                        Clock off: cfg_div=3D=3D0, the
clock is disabled
                                        Divider bypass: cfg_div=3D=3D1,
clock source is used as core clock without divider
                                        Maximum divider 63

So here is the log of clk_div and clk_freq at my end.

MMC Device 0 not found
no mmc device at slot 0
clock is disabled (0Hz)
clock is enabled (380953Hz)
......clk_div : 63
Card did not respond to voltage select!
clock is disabled (0Hz)
clock is enabled (380953Hz)
......clk_div : 63
clock is enabled (25000000Hz)
......clk_div : 40
......clk_div : 40
clock is enabled (52000000Hz)
......clk_div : 20
switch to partitions #0, OK
mmc2(part 0) is current device
Scanning mmc 2:1...
Found U-Boot script /boot/boot.scr

>
>
> > +     /* Clock source : Crystal 24MHz */
> > +     meson_mmc_clk |=3D FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
>
> You set CRYSTAL_24MHZ here, but the src is selected in clk_src and set wi=
th:
> meson_mmc_clk |=3D clk_src;
>
> In conclusion your change forces the 24MHz crystal and max divider whatev=
er the
> freq asked by the mmc core !
>
As per the datasheet S905 and S922X
Cfg_src:             Clock source
                          0: Crystal 24MHz or other frequencies
selected by clock reset test control register.
                          1: Fix PLL, 1000MHz
                          Recommended value: 1

Note: *setting cfg_src value to I       i.e; Fix PLL 1000 Mhz *
some how break the clk_freq tuning setting in my testing,
see the logs below.

MMC Device 0 not found
no mmc device at slot 0
clock is disabled (0Hz)
clock is enabled (380953Hz)
......clk_div : 63
Card did not respond to voltage select!
clock is disabled (0Hz)
clock is enabled (380953Hz)
......clk_div : 63
starting USB...

No emmc will get discovered,
*This is the real issue I faced for failure of eMMC not getting detected.*

> > +     /* Core clock phase 2:180 */
> > +     meson_mmc_clk |=3D FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180)=
;
> > +     /* TX clock phase 0:180 */
> > +     meson_mmc_clk |=3D FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
> > +     /* RX clock phase 0:180 */
> > +     meson_mmc_clk |=3D FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
>
> These are ok, but it's exactly the same as before with a different style.
>
> > +
> > +#ifdef CONFIG_MESON_GX
> > +     /* clk always on */
> > +     meson_mmc_clk |=3D CLK_V2_ALWAYS_ON;
> > +#endif
> > +#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
> > +     /* clk always on */
> > +     meson_mmc_clk |=3D CLK_V3_ALWAYS_ON;
> > +#endif
>
> Why not, not sure about the effect.

Ok, I will changes these to  FIELD_PREP for consultancy.

>
> >
> >       /* clock settings */
> >       meson_mmc_clk |=3D clk_src;
> >
>
> Neil

-Anand
