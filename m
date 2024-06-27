Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C668C3271E
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:15 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web10.3966.1719480399810475712
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Jun 2024 02:26:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=Pjp2S0TJ;
 spf=pass (domain: chromium.org, ip: 209.85.219.43, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5253ffd24so23910016d6.2
        for <u-boot-amlogic@groups.io>; Thu, 27 Jun 2024 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719480399; x=1720085199; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9HCQkxbz7QGTuVs+o2YIyzQ/LTHw4GzWIaZg3+8jgw0=;
        b=Pjp2S0TJXM+Ck31AQDglDGOh0D323yt5Z4ep2vCT9PgFh48xfJvzDGze2aSX+BHfcw
         uRfOqwERFaZj/tDaC1+zmA5DsFYJhunMKjebqXpUuunaf1DgHCC/Ot/XpufATusrJH+f
         fU9cHjq5hF8BoZb5lkUEHbeUYcz6KrOITRD7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719480399; x=1720085199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HCQkxbz7QGTuVs+o2YIyzQ/LTHw4GzWIaZg3+8jgw0=;
        b=X0nkbumZmpy8zfBeMFHvwp1KWBrLZDD0Vje7qI8FXg2G2i4OVra5dEWiw1Qusm8iTt
         E/qFECwDpffufOS+w+oiAvDY9V7XFR1W5yWzkOtgEI7c76jn/MiWyZXGJeLC37Q9m2bs
         8G9W9EblE2RJE41/SKygHdHj8tk9880sznrVAFDoOs63XE2Y/ny650TBs0nRpsSlZomw
         QMPffAnWvbJkIYQKah5SnnNDtzNipluvbmUxciZw/u2mXixTvwHfsGTRzp/1q+gTZziD
         q1/x22ns/vJ0k9DcEHM1NFXIKvBrcJbQV6KWSm18mWIand5pCzez2rL7UfMBvcENZxrC
         dRQA==
X-Forwarded-Encrypted: i=1; AJvYcCXaA/2VeHzydyeBacniit7plWKn+xNk0juVjXnl8nn1I5ltor+p5/Q+1PQxCOSteE15JkNmH7Dwpiogy3l3vJNhWague0uJpZ4=
X-Gm-Message-State: AOJu0Yw6nCOpSlsFs/u8wnRkIDU6yDmyPqwPpaqgcOhrVDOrbWiQLS1p
	ddcPCui+/Rr/WZERSlHGnJFVhcZd+fgYWkwMCTVqegI7imzaSRaU+CuDOkXoH0u/Tk0/KHgJRXW
	UJya0Ch04NTq4BJsPS7Co4dWwKmuveHXRdb2m
X-Google-Smtp-Source: AGHT+IHjx8SlRRp5BuJIRV9LstlKWiXSSP60Vh8E7gab5ZtYSS89FtvFekbEHCF0KzVqKnCyoEl60+T6MbaZsk28Bfw=
X-Received: by 2002:a05:6214:5ed4:b0:6b2:d51c:f5b3 with SMTP id
 6a1803df08f44-6b58d36d1eamr23880166d6.18.1719480398847; Thu, 27 Jun 2024
 02:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
In-Reply-To: <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 10:26:28 +0100
Message-ID: <CAFLszTijRhB1dRraPBQSTU3ypJ_wJU7yghJ9c9Rk-XcbcfvkFg@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
	Ben Wolsieffer <benwolsieffer@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Eugen Hristev <eugen.hristev@collabora.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
	Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, Max Krummenacher <max.krummenacher@toradex.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
	u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
	uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 11:57:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2340

Hi Caleb,

On Thu, 27 Jun 2024 at 09:48, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 27/06/2024 10:37, Simon Glass wrote:
> > Hi Marek,
> >
> > On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
> >>
> >> In case a regulator DT node contains regulator-always-on or regulator-boot-on
> >> property, make sure the regulator gets correctly configured by U-Boot on start
> >> up. Unconditionally probe such regulator drivers. This is a preparatory patch
> >> for introduction of .regulator_post_probe() which would trigger the regulator
> >> configuration.
> >>
> >> Parsing of regulator-always-on and regulator-boot-on DT property has been
> >> moved to regulator_post_bind() as the information is required early, the
> >> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
> >> slowing down the boot process.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> ---
> >> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> >> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> >> Cc: Chris Morgan <macromorgan@hotmail.com>
> >> Cc: Dragan Simic <dsimic@manjaro.org>
> >> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> >> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >> Cc: Jagan Teki <jagan@amarulasolutions.com>
> >> Cc: Jonas Karlman <jonas@kwiboo.se>
> >> Cc: Kever Yang <kever.yang@rock-chips.com>
> >> Cc: Kostya Porotchkin <kostap@marvell.com>
> >> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> >> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> >> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> >> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >> Cc: Sam Day <me@samcday.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Sumit Garg <sumit.garg@linaro.org>
> >> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> >> Cc: Thierry Reding <treding@nvidia.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> >> Cc: u-boot-amlogic@groups.io
> >> Cc: u-boot-qcom@groups.io
> >> Cc: u-boot@dh-electronics.com
> >> Cc: u-boot@lists.denx.de
> >> Cc: uboot-stm32@st-md-mailman.stormreply.com
> >> ---
> >>   drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
> >>   1 file changed, 15 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> >> index 66fd531da04..ccc4ef33d83 100644
> >> --- a/drivers/power/regulator/regulator-uclass.c
> >> +++ b/drivers/power/regulator/regulator-uclass.c
> >> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
> >>          const char *property = "regulator-name";
> >>
> >>          uc_pdata = dev_get_uclass_plat(dev);
> >> +       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> >> +       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
> >>
> >>          /* Regulator's mandatory constraint */
> >>          uc_pdata->name = dev_read_string(dev, property);
> >> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
> >>                          return -EINVAL;
> >>          }
> >>
> >> -       if (regulator_name_is_unique(dev, uc_pdata->name))
> >> -               return 0;
> >> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> >> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> >> +                     property, dev->name, uc_pdata->name);
> >> +               return -EINVAL;
> >> +       }
> >>
> >> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> >> -             property, dev->name, uc_pdata->name);
> >> +       /*
> >> +        * In case the regulator has regulator-always-on or
> >> +        * regulator-boot-on DT property, trigger probe() to
> >> +        * configure its default state during startup.
> >> +        */
> >> +       if (uc_pdata->always_on && uc_pdata->boot_on)
> >> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> >>
> >> -       return -EINVAL;
> >> +       return 0;
> >>   }
> >>
> >>   static int regulator_pre_probe(struct udevice *dev)
> >> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
> >>                                                  -ENODATA);
> >>          uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
> >>                                                  -ENODATA);
> >> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> >> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
> >>          uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
> >>                                                      0);
> >>          uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
> >> --
> >> 2.43.0
> >>
> >
> > This is reading a lot of DT stuff very early, which may be slow. It is
> > also reading from the DT in the bind() step which we sometimes have to
> > do, but try to avoid.
>
> Could we set up the livetree pre-bind? What about MMU? On armv8 at least
> this would have a huge impact on performance. I've done some
> measurements and there is at least 1 order of magnitude difference
> between parsing FDT with no caches vs parsing livetree with, it's huge.

That seems like a great idea to me, in general. The fact that SPL sets
up the MMU on armv8 makes it more practical.

But for this series I believe we are going to have to define what
happens in what phase. We have power_init_board() which is the old way
of doing this...but perhaps we could use that as a way to start up
regulators which are needed.

As to my question about whether this happens in SPL / pre-reloc /
proper, I forgot that we have the bootph tags for that, so it should
be fine. The main issue is that in U-Boot proper we will re-init the
regulators even though that has already been done. Probably that can
be handled by Kconfig or a flag in SPL handoff.


> >
> > Also this seems to happen in SPL and again pre-reloc and again in
> > U-Boot post-reloc?
> >
> > Should we have a step in the init sequence where we set up the
> > regulators, by calling regulators_enable_boot_on() ?

Regards,
Simon

