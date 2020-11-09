Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
 by mx.groups.io with SMTP id smtpd.web12.16477.1604948544468283891
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 11:02:24 -0800
Received: by mail-ed1-f66.google.com with SMTP id t11so9904394edj.13
        for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2020 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fju/jWHNA9xQVbrlvDjiS9nzpapcG0AuXM3zSlPncqo=;
        b=S2KG9Zgm4K4IfS+L2IW05NHo7rBpXHbcmYNW3pt2MZbZ7FTxMebWdZ4t/R2V/rheyU
         3D4x2I8/Ts1BikC+gnIThZ9RYDxR64QePGPcz0lRln75iXGsqAGicCx3nF1jIADdPrCR
         II1eTom57z16QNQemJkhDwHODLLqiYYMKtJygkxB0wRw9MHj+R7LjiB8jjBQlmt8EPFy
         UuKMcwGnHby8YSw3L13AeTMhTNJ2XSuaC/103pKrT7JNO+B1mv0V3tce8Jc7yifW9W55
         2rjdDhs+J5D/06EwBBQOk3xzRZNJK2uR18fpOHTASqHoY8zd/9wk7NLius63yjvPmDZt
         9L3g==
MIME-Version: 1.0
References: <CGME20201109031216epcas1p197a531d87ad92cb02aca01f4b9e2af3a@epcas1p1.samsung.com>
 <20201109031233.25320-1-jh80.chung@samsung.com> <15fa8495-b92f-1acc-038e-760df4fdf30f@baylibre.com>
 <e94a6abeb770b3bf@bloch.sibelius.xs4all.nl> <9bda4738-332d-a687-0d21-20eb42518d42@baylibre.com>
In-Reply-To: <9bda4738-332d-a687-0d21-20eb42518d42@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 10 Nov 2020 00:32:12 +0530
Message-ID: <CANAwSgRA-43AReFgP7D-5i=EA_XXV+wgQhHkGEFD5StGceXAeg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson_gx_mmc: change a clock phase to stable value
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Jaehoon Chung <jh80.chung@samsung.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Peng Fan <peng.fan@nxp.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Mon, 9 Nov 2020 at 19:56, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 09/11/2020 15:10, Mark Kettenis wrote:
> >> From: Neil Armstrong <narmstrong@baylibre.com>
> >> Date: Mon, 9 Nov 2020 14:37:09 +0100
> >>
> >> Hi,
> >>
> >> On 09/11/2020 04:12, Jaehoon Chung wrote:
> >>> Core clock phase value is changed from 180' to 270'.
> >>> It's more stable than before.
> >>> - Odroidn-N2/C4 : Working fine with 52MHz
> >>> - VIM3 : Working fine with 52MHz
> >>>
> >>> Before this patch, Odroid-C4 doesn't work fine with 52MHz.
> >>>
> >>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >>> ---
> >>>  drivers/mmc/meson_gx_mmc.c | 14 ++++++++++----
> >>>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> >>> index 719dd1e5e570..7c60e0566560 100644
> >>> --- a/drivers/mmc/meson_gx_mmc.c
> >>> +++ b/drivers/mmc/meson_gx_mmc.c
> >>> @@ -52,10 +52,16 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >>>     }
> >>>     clk_div = DIV_ROUND_UP(clk, mmc->clock);
> >>>
> >>> -   /* 180 phase core clock */
> >>> -   meson_mmc_clk |= CLK_CO_PHASE_180;
> >>> -
> >>> -   /* 180 phase tx clock */
> >>> +   /*
> >>> +    * Clock Phase needs to set a proper value.
> >>> +    * It can be changed to other value.
> >>> +    * Because CORE : 270' Phase and TX : 0' Phase are stable,
> >>> +    * set to them by default.
> >>> +    */
> >>> +   /* Core Clock Phase */
> >>> +   meson_mmc_clk |= CLK_CO_PHASE_270;
> >>> +
> >>> +   /* TX Clock Phase */
> >>>     meson_mmc_clk |= CLK_TX_PHASE_000;
> >>>
> >>>     /* clock settings */
> >>>
> >>
> >> The previous values were aligned on the Linux driver, which is functional.
> >
> > Actually the Linux driver isn't really functional; the 52 MHz
> > high-speed mode doesn't work.  But since HS200 does work in Linux,
> > probably nobody noticed this.
> >
> > That said, I'm not confident a single clock phase setting will work
> > across all Amlogic SoCs and across different boards.  Maybe we need
> > something in the device tree such that we can control the values on a
> > per-board level.
> >
>
> So this is specific to SM1 SoCs then, because others families doesn't have such issues
> at 52MHz.
>
> So the Linux must be fixes, including the bindings to introduce a new compatible, then
> ported to U-Boot.
>
> So in the meantime, it's right to limit to 26MHz on SM1 in U-boot until we have all this
> clarified.
>
> Neil

Earlier I had a similar approach for this FIX but somehow it did not get merged.

Please add my
Tested-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand
