Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63613CF2590
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:00:52 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web11.13802.1727967814376450590
 for <u-boot-amlogic@groups.io>;
 Thu, 03 Oct 2024 08:03:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=VsUkFn1h;
 spf=pass (domain: chromium.org, ip: 209.85.219.42, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb54eef205so9589896d6.2
        for <u-boot-amlogic@groups.io>; Thu, 03 Oct 2024 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727967813; x=1728572613; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xck8TEVEakZw6XXAH4TtRZLZvmFsSi/9xxxJWDIcIoc=;
        b=VsUkFn1hpEhL+HdOIFi7R05qV0r2QkvWo9b0etuKBZn5Kt4LlC0Vj7OJ7Tyhs/whXH
         xd1bLKFH4/lkKbifYjRN6cuw3deuAS4zA3yd6nswcz60UV2mlT7pCCgZhKPvyZgjVaKI
         0EH2gIbDhLObZRbogwppECwbAEATXYHGXOpiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967813; x=1728572613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xck8TEVEakZw6XXAH4TtRZLZvmFsSi/9xxxJWDIcIoc=;
        b=f1bZSUCVxjm4LMsgh8f0ic+LE5txdjtrCfUKNX+RWWuKTnI1VOe3tvdyXtOP6d2QIT
         oaGr8BWJJkuPl2UZGnTUToZaRUUXhTPYOaZPkEu38+9Kb6o0YtoDYKCuTbLNsPDj4Xve
         Ww6KtaLd5CU3ICqGLGpgKnG8QcZlwUMMOmyqPjKYLTmTzZdSBmfMENq6ZBdKAWSEFlvF
         DS1ozERM6bh48L1iIe7gEJOjyjMh+gqzfWpemY+K4C//7uZ/QCRDqZkNmMllfgDaQvGj
         R/EG35qEpuy6gnqnQQk7Nz4ugl8RQS4ut3TtxysfCtOsVrWqSgGHlRa3V/W6dv49H5Fx
         w2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDoIhw5nclIGz9JzyTTe8ilCB3fgt9SU31ydM5kGHu1aRuyGlZ0+jGAEu/h2pJaK7evTo8MSGPAzsJG6ekig==@groups.io
X-Gm-Message-State: AOJu0YynI46GyBjwtdPpiefq4PaQZtqXbJV0xYCGkFpD5ufIN4AD10Tm
	nF72Wh83uNijUrFnZRUfsyMr6O7srDKsdbHX5v8TAD4vCncmFIe9GGwKfMILwniKfH1343jpJQ5
	/3uJzlr9DpxwpTuTKT1mPtL/3/Z+V0mWQeZzQ
X-Google-Smtp-Source: AGHT+IE+QRyARsoRaCYB6tQNlecqHjTlfcP+Kyk2IVOCMvrFm2dsTBn0aeztCGJwaKxtmnUs1c3RSifNTFmc7W2Smm4=
X-Received: by 2002:a05:6214:4890:b0:6b5:e2d9:cfb9 with SMTP id
 6a1803df08f44-6cb81b990bfmr103600146d6.39.1727967813377; Thu, 03 Oct 2024
 08:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240926231457.2933914-1-marex@denx.de> <20240926231457.2933914-2-marex@denx.de>
 <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com> <20241003014042.GS4737@bill-the-cat>
In-Reply-To: <20241003014042.GS4737@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 09:03:22 -0600
Message-ID: <CAFLszTiawdOfoMx-ZmMLW77dBS11WWVpWHNF-KfPi86xEJB+rQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] power: regulator: Convert regulators_enable_boot_on/off() to regulator_post_probe
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
	Ben Wolsieffer <benwolsieffer@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	Eugen Hristev <eugen.hristev@collabora.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
	Matteo Lisi <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
	Max Krummenacher <max.krummenacher@toradex.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Thierry Reding <treding@nvidia.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
	u-boot-amlogic@groups.io, u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
	uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:00:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2454

Hi Tom,

On Wed, 2 Oct 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 02, 2024 at 04:55:39PM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Thu, 26 Sept 2024 at 17:15, Marek Vasut <marex@denx.de> wrote:
> > >
> > > Turn regulators_enable_boot_on() and regulators_enable_boot_off() into
> > > empty functions. Implement matching functionality in regulator_post_probe()
> > > instead. The regulator_post_probe() is called for all regulators after they
> > > probe, and regulators that have regulator-always-on or regulator-boot-on DT
> > > properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being set on
> > > such regulators in regulator_post_bind().
> > >
> > > Finally, fold regulator_unset() functionality into regulator_autoset().
> > >
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> > > Cc: Caleb Connolly <caleb.connolly@linaro.org>
> > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > Cc: Dragan Simic <dsimic@manjaro.org>
> > > Cc: Eugen Hristev <eugen.hristev@collabora.com>
> > > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > > Cc: Jagan Teki <jagan@amarulasolutions.com>
> > > Cc: Jonas Karlman <jonas@kwiboo.se>
> > > Cc: Kever Yang <kever.yang@rock-chips.com>
> > > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > > Cc: Max Krummenacher <max.krummenacher@toradex.com>
> > > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > > Cc: Sam Day <me@samcday.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Cc: Thierry Reding <treding@nvidia.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> > > Cc: u-boot-amlogic@groups.io
> > > Cc: u-boot-qcom@groups.io
> > > Cc: u-boot@dh-electronics.com
> > > Cc: u-boot@lists.denx.de
> > > Cc: uboot-stm32@st-md-mailman.stormreply.com
> > > ---
> > > V2: Rebase on current u-boot/next
> > > V3: No change
> > > ---
> > >  drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
> > >  1 file changed, 19 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> > > index 1a970004540..9fcc4bd85b9 100644
> > > --- a/drivers/power/regulator/regulator-uclass.c
> > > +++ b/drivers/power/regulator/regulator-uclass.c
> > > @@ -314,6 +314,11 @@ int regulator_autoset(struct udevice *dev)
> > >                         return ret;
> > >         }
> > >
> > > +       if (uc_pdata->force_off) {
> > > +               ret = regulator_set_enable(dev, false);
> > > +               goto out;
> > > +       }
> > > +
> > >         if (!uc_pdata->always_on && !uc_pdata->boot_on) {
> > >                 ret = -EMEDIUMTYPE;
> > >                 goto out;
> > > @@ -518,56 +523,28 @@ static int regulator_pre_probe(struct udevice *dev)
> > >         return 0;
> > >  }
> > >
> > > -int regulators_enable_boot_on(bool verbose)
> > > +static int regulator_post_probe(struct udevice *dev)
> > >  {
> > > -       struct udevice *dev;
> > > -       struct uclass *uc;
> > >         int ret;
> > >
> > > -       ret = uclass_get(UCLASS_REGULATOR, &uc);
> > > -       if (ret)
> > > +       ret = regulator_autoset(dev);
> > > +       if (ret && ret != -EMEDIUMTYPE && ret != -EALREADY && ret != ENOSYS)
> > >                 return ret;
> > > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > > -            dev;
> > > -            uclass_next_device(&dev)) {
> > > -               ret = regulator_autoset(dev);
> > > -               if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
> > > -                       ret = 0;
> > > -                       continue;
> > > -               }
> > > -               if (verbose)
> > > -                       regulator_show(dev, ret);
> > > -               if (ret == -ENOSYS)
> > > -                       ret = 0;
> > > -       }
> > >
> > > -       return ret;
> > > +       if (_DEBUG)
> > > +               regulator_show(dev, ret);
> > > +
> > > +       return 0;
> > >  }
> > >
> > > -int regulators_enable_boot_off(bool verbose)
> > > +int regulators_enable_boot_on(bool verbose)
> > >  {
> > > -       struct udevice *dev;
> > > -       struct uclass *uc;
> > > -       int ret;
> > > -
> > > -       ret = uclass_get(UCLASS_REGULATOR, &uc);
> > > -       if (ret)
> > > -               return ret;
> > > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > > -            dev;
> > > -            uclass_next_device(&dev)) {
> > > -               ret = regulator_unset(dev);
> > > -               if (ret == -EMEDIUMTYPE) {
> > > -                       ret = 0;
> > > -                       continue;
> > > -               }
> > > -               if (verbose)
> > > -                       regulator_show(dev, ret);
> > > -               if (ret == -ENOSYS)
> > > -                       ret = 0;
> > > -       }
> > > +       return 0;
> > > +}
> > >
> > > -       return ret;
> > > +int regulators_enable_boot_off(bool verbose)
> > > +{
> > > +       return 0;
> > >  }
> > >
> > >  UCLASS_DRIVER(regulator) = {
> > > @@ -575,5 +552,6 @@ UCLASS_DRIVER(regulator) = {
> > >         .name           = "regulator",
> > >         .post_bind      = regulator_post_bind,
> > >         .pre_probe      = regulator_pre_probe,
> > > +       .post_probe     = regulator_post_probe,
> > >         .per_device_plat_auto   = sizeof(struct dm_regulator_uclass_plat),
> > >  };
> > > --
> > > 2.45.2
> > >
> >
> > I thought I objected to this patch, but it seems to be in -next? Does
> > anyone know what has happened here?
>
> Yes, you missed me noting that this fixes real problems and has been
> needing to be fixed for a while. I said you should provide your
> alternative approach and we'll get this sorted out in -next and I took
> the work-around for master so the release wouldn't be broken.

OK ta. So long as we can revert/change that is fine.

>
> > I am seeing these errors now when running sandbox 'u-boot -D':
> >
> >        i2c_emul_find() No emulators for device 'sandbox_pmic'
> >   sandbox_pmic_write() write error to device: 0000000018c49db0 register: 0x0!
> >        out_set_value() PMIC write failed: -5
> >        i2c_emul_find() No emulators for device 'sandbox_pmic'
> >   sandbox_pmic_write() write error to device: 0000000018c49db0 register: 0x0!
> >        out_set_value() PMIC write failed: -5
>
> I suppose the good news is that perhaps this is also related to the
> problem that Svyatoslav was reporting.

OK, I actually never fully understood the problem, but yes, sandbox is
supposed to work similarly.

Regards,
Simon

