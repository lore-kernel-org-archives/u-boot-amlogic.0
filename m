Received: from sibelius.xs4all.nl (sibelius.xs4all.nl [83.163.83.176])
 by mx.groups.io with SMTP id smtpd.web11.11899.1604931026624241687
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 06:10:27 -0800
Date: Mon, 9 Nov 2020 15:10:22 +0100 (CET)
From: Mark Kettenis <mark.kettenis@xs4all.nl>
In-Reply-To: <15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com> (message from
	Neil Armstrong on Mon, 9 Nov 2020 14:37:09 +0100)
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
 <20201109031233.25320-1-jh80.chung@samsung.com> <15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
Message-ID: <e94a6abeb770b3bf@bloch.sibelius.xs4all.nl>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, peng.fan@nxp.com
List-ID: <u-boot-amlogic@groups.io>

> From: Neil Armstrong <narmstrong@baylibre.com>
> Date: Mon, 9 Nov 2020 14:37:09 +0100
> 
> Hi,
> 
> On 09/11/2020 04:12, Jaehoon Chung wrote:
> > Core clock phase value is changed from 180' to 270'.
> > It's more stable than before.
> > - Odroidn-N2/C4 : Working fine with 52MHz
> > - VIM3 : Working fine with 52MHz
> > 
> > Before this patch, Odroid-C4 doesn't work fine with 52MHz.
> > 
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> >  drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> > index 719dd1e5e570..7c60e0566560 100644
> > --- a/drivers/mmc/meson_gx_mmc.c
> > +++ b/drivers/mmc/meson_gx_mmc.c
> > @@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >  	}
> >  	clk_div = DIV_ROUND_UP(clk, mmc->clock);
> >  
> > -	/* 180 phase core clock */
> > -	meson_mmc_clk |= CLK_CO_PHASE_180;
> > -
> > -	/* 180 phase tx clock */
> > +	/*
> > +	 * Clock Phase needs to set a proper value.
> > +	 * It can be changed to other value.
> > +	 * Because CORE : 270' Phase and TX : 0' Phase are stable,
> > +	 * set to them by default.
> > +	 */
> > +	/* Core Clock Phase */
> > +	meson_mmc_clk |= CLK_CO_PHASE_270;
> > +
> > +	/* TX Clock Phase */
> >  	meson_mmc_clk |= CLK_TX_PHASE_000;
> >  
> >  	/* clock settings */
> > 
> 
> The previous values were aligned on the Linux driver, which is functional.

Actually the Linux driver isn't really functional; the 52 MHz
high-speed mode doesn't work.  But since HS200 does work in Linux,
probably nobody noticed this.

That said, I'm not confident a single clock phase setting will work
across all Amlogic SoCs and across different boards.  Maybe we need
something in the device tree such that we can control the values on a
per-board level.
