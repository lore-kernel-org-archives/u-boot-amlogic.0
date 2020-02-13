Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
 by mx.groups.io with SMTP id smtpd.web12.5358.1581595131116809451
 for <u-boot-amlogic@groups.io>;
 Thu, 13 Feb 2020 03:58:51 -0800
Received: by mail-io1-f67.google.com with SMTP id d15so6160116iog.3
        for <u-boot-amlogic@groups.io>; Thu, 13 Feb 2020 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lHkivRY4j5bKkDpwooNKeuWmtD5nM9aNIE9tCcAW1jY=;
        b=IxpaxD9ZPbNx8C6fXwfKMQ5olP55ftu46XhQj41u+ggIv56bcKaQlB2FChbKKqBKSB
         3Wd2Vbg2SLied58bZYlEyYkAlr9hP+P+AyOJAHd/Omx8RBv3P6kqB0iHrpGdNFliUpi3
         IkRmh9bsoymQ4/3UZgfkwKzuSuMzW/kg5w6oq9cYDXH7mR+9QZ/1DX/9laHhqk6ccjse
         1BS623uLHFWKyHmr8h4bftsmCpWFgqVuF7jlGsf5oJB8md9hqpEZsCNizum4ATH+U/TK
         cOdSiVreccq45yzIDggpdAiLO8hT27LkC4kzMefVAsy5qD/69F2HbkaKkzoWvE9vfkfx
         6Lbw==
MIME-Version: 1.0
References: <20200209110557.1996-1-linux.amoon@gmail.com> <20200209110557.1996-2-linux.amoon@gmail.com>
 <61096502-4817-a095-4d11-b487781202b0@baylibre.com> <CANAwSgT7SyqgwWE9SEvLYasW-qzfCYHSJrFfeCNt2dv0XxVsiA@mail.gmail.com>
 <62098468-c490-6dfc-c627-02de6084c50c@baylibre.com>
In-Reply-To: <62098468-c490-6dfc-c627-02de6084c50c@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 13 Feb 2020 17:28:32 +0530
Message-ID: <CANAwSgQsqSm7pqLtcXZkkRHqZ1sFpv2kKj1u30yGw4w0aHukeA@mail.gmail.com>
Subject: Re: [PATCHv6 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

hi Niel / Jerome,

Thanks for your review comments and debug output
Sorry for late reply.

On Mon, 10 Feb 2020 at 14:33, Neil Armstrong <narmstrong@baylibre.com> wrot=
e:
>
> On 09/02/2020 18:22, Anand Moon wrote:
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
> >>> As per mainline line kernel fix the clk tuning phase for mmc,
> >>> set Core=3D180, Tx=3D0, Rx=3D0 clk phase for mmc initialization.
> >>> As per S905, S905X, AGX and S922X datasheet set the default
> >>> values for clk tuning.
> >>>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>> Changes from previous
> >>> v5  Fix the commit message, configure as per mainline kernel.
> >>>     drop the RX_DELAY_MASK and TX_DELAY_MASK as they are not used.
> >>>
> >>> v4  Fix the update mask value using FIELD_PREP macro.
> >>>
> >>> v3  Fix the initialization of core clk tunning phase as per datasheet=
.
> >>>     Fix the commit message.
> >>>
> >>> v2: Fix the clk phase macro to support PHASE_180
> >>>     drop the wrong CLK_CORE_PHASE_MASK macro.
> >>>
> >>> v1: use the mainline kernel tuning for clk tuning.
> >>>
> >>> Fixed the commmit messages.
> >>> Patch v1:
> >>> https://patchwork.ozlabs.org/patch/1201208/
> >>>
> >>> Before these changes.
> >>>     clock is enabled (380953Hz)
> >>>     clock is enabled (25000000Hz)
> >>> After these changes
> >>>     clock is enabled (380953Hz)
> >>>     clock is enabled (25000000Hz)
> >>>     clock is enabled (52000000Hz)
> >>> Test on Odroid N2 and Odroid C2 with eMMC and microSD cards
> >>> ---
> >>>  arch/arm/include/asm/arch-meson/sd_emmc.h | 24 +++++++++++--------
> >>>  drivers/mmc/meson_gx_mmc.c                | 28 +++++++++++++++++++--=
--
> >>>  2 files changed, 38 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/inc=
lude/asm/arch-meson/sd_emmc.h
> >>> index e3a72c8b66..f4299485dc 100644
> >>> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> >>> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> >>> @@ -7,6 +7,7 @@
> >>>  #define __SD_EMMC_H__
> >>>
> >>>  #include <mmc.h>
> >>> +#include <linux/bitops.h>
> >>>
> >>>  #define SDIO_PORT_A                  0
> >>>  #define SDIO_PORT_B                  1
> >>> @@ -19,15 +20,20 @@
> >>>  #define   CLK_MAX_DIV                        63
> >>>  #define   CLK_SRC_24M                        (0 << 6)
> >>>  #define   CLK_SRC_DIV2                       (1 << 6)
> >>> -#define   CLK_CO_PHASE_000           (0 << 8)
> >>> -#define   CLK_CO_PHASE_090           (1 << 8)
> >>> -#define   CLK_CO_PHASE_180           (2 << 8)
> >>> -#define   CLK_CO_PHASE_270           (3 << 8)
> >>> -#define   CLK_TX_PHASE_000           (0 << 10)
> >>> -#define   CLK_TX_PHASE_090           (1 << 10)
> >>> -#define   CLK_TX_PHASE_180           (2 << 10)
> >>> -#define   CLK_TX_PHASE_270           (3 << 10)
> >>> -#define   CLK_ALWAYS_ON                      BIT(24)
> >>> +
> >>> +#define   CRYSTAL_24MHZ                      0
> >>> +#define   CLK_PHASE_0                        0
> >>> +#define   CLK_PHASE_180                      2
> >>> +
> >>> +#define   CLK_DIV_MASK                       GENMASK(5, 0)
> >>> +#define   CLK_SRC_MASK                       GENMASK(7, 6)
> >>> +#define   CLK_CORE_PHASE_MASK                GENMASK(9, 8)
> >>> +#define   CLK_TX_PHASE_MASK          GENMASK(11, 10)
> >>> +#define   CLK_RX_PHASE_MASK          GENMASK(13, 12)
> >>> +
> >>> +#define   CLK_V2_ALWAYS_ON           BIT(24)
> >>> +
> >>> +#define   CLK_V3_ALWAYS_ON           BIT(28)
> >>>
> >>>  #define MESON_SD_EMMC_CFG            0x44
> >>>  #define   CFG_BUS_WIDTH_MASK         GENMASK(1, 0)
> >>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> >>> index 86c1a7164a..b013c7c5fb 100644
> >>> --- a/drivers/mmc/meson_gx_mmc.c
> >>> +++ b/drivers/mmc/meson_gx_mmc.c
> >>> @@ -16,6 +16,10 @@
> >>>  #include <asm/arch/sd_emmc.h>
> >>>  #include <linux/log2.h>
> >>>
> >>> +#include <linux/bitops.h>
> >>> +#include <linux/compat.h>
> >>> +#include <linux/bitfield.h>
> >>> +
> >>>  static inline void *get_regbase(const struct mmc *mmc)
> >>>  {
> >>>       struct meson_mmc_platdata *pdata =3D mmc->priv;
> >>> @@ -51,11 +55,25 @@ static void meson_mmc_config_clock(struct mmc *mm=
c)
> >>>       }
> >>>       clk_div =3D DIV_ROUND_UP(clk, mmc->clock);
> >>>
> >>> -     /* 180 phase core clock */
> >>> -     meson_mmc_clk |=3D CLK_CO_PHASE_180;
> >>> -
> >>> -     /* 180 phase tx clock */
> >>> -     meson_mmc_clk |=3D CLK_TX_PHASE_000;
> >>> +     /* Clock divider */
> >>> +     meson_mmc_clk |=3D CLK_DIV_MASK;
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
>
>
> OK, seems you didn't see the issue.
>
> With the original code, let's say mmc->clock =3D 25000000
>
> clk =3D SD_EMMC_CLKSRC_DIV2
> clk_src =3D CLK_SRC_DIV2
> clk_div =3D 40
>
> meson_mmc_clk |=3D CLK_CO_PHASE_180;
> meson_mmc_clk |=3D CLK_TX_PHASE_000;
> meson_mmc_clk |=3D CLK_SRC_DIV2;
> meson_mmc_clk |=3D 40;
>
> =3D> meson_mmc_clk =3D (2 << 8) | (0 << 10) | (1 << 6) | 40
> =3D> meson_mmc_clk =3D 0x268
>
> With your code :
> meson_mmc_clk |=3D CLK_DIV_MASK;
> meson_mmc_clk |=3D FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
> meson_mmc_clk |=3D FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
> meson_mmc_clk |=3D FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
> meson_mmc_clk |=3D FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
> meson_mmc_clk |=3D CLK_SRC_DIV2;
> meson_mmc_clk |=3D 40;
>
> =3D> meson_mmc_clk =3D 0x3f | (0 << 6) | (2 << 8) | (0 << 11) | (0 << 13)=
 | (1 << 6) | 40
>
> -------------------/\---this---------makes-------this-----useless--------=
----------/\
>
> =3D> 0x27f
>
> It sets the clock to 15873015Hz instead of the 25000000Hz requested.

I did not observer this at my end, but any way thanks for the input.

>
> so this code sets max divider whatever mmc->clock value, but keeps the CR=
YSTAL_24MHZ/CLK_SRC_DIV2 selection.
>
> >
> >>
> >>
> >>> +     /* Clock source : Crystal 24MHz */
> >>> +     meson_mmc_clk |=3D FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
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
> > *This is the real issue I faced for failure of eMMC not getting detecte=
d.*
>
> This is the issue I get on SM1, but when I cap the max freq to 24MHz, it =
disappears.
>
> This issue is somewhere else, but I don't know where because the Linux dr=
iver behaves
> correctly with the same setup.
>
> My fix was to always use the 24MHz crystal input on non-GX until we find =
out why, and it still acceptable.

I have studied amlogic u-boot and it seen to use 24MHz crystal inputs.
I have following fix the issue with select  Fix PLL and CRYSTAL24MHz
       if (mmc->clock > 400000) {
               /* Clock source : Fix PLL, 1000MHz */
               meson_mmc_clk |=3D FIELD_PREP(CLK_SRC_MASK, FIXPLL_10000MHZ)=
;
       } else {
               /* Clock source : Crystal 24MHz */
               meson_mmc_clk |=3D FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
       }
>
> Could you post instead :
> - your patch 2 introducing the MMC_COMPATIBLE_* as patch 1

Ok I will change the order.

> - this patch but only forcing 24MHz for MMC_COMPATIBLE_AXG as patch 2

I propose the dynamically select 24MHz and Fix PLL, as above code.

> - redude patches 3,4 & 5 to only add mmc* aliases into meson-gx-u-boot.dt=
si/meson-g12-common-u-boot.dtsi
>

Ok I will make these changes

> If you have a issue, please chat with me on #linux-amlogic on freenode.

I could not connect to freenode or register my self to this chat
group. sorry about that.

>
> Thanks,
> Neil
>

-Anand
