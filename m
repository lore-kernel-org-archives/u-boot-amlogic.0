Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C486C31D97
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:15 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.11891.1719559983055048298
 for <u-boot-amlogic@groups.io>;
 Fri, 28 Jun 2024 00:33:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=g0HYR9kJ;
 spf=pass (domain: chromium.org, ip: 209.85.219.46, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b56000f663so1564636d6.1
        for <u-boot-amlogic@groups.io>; Fri, 28 Jun 2024 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719559982; x=1720164782; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KRuwi8DrHNH9PM7BQRvaS+69U0hYrnjGzRWy+oNkAKQ=;
        b=g0HYR9kJsKX3Youko+5gVzWEe1qevCdpkA3tU+oMYLhrt6ivCbGjK5s8Do0zCwasjX
         KbJi0IFWbWvpVyLjZRP70Y3BdSmBf4uTvsVirn6L7DfPOeyQLinpfjYOqDkf/g50q+zt
         uxkRO+jTXeo1v7yr57rEbKNCB+t9Vl6hXqMf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719559982; x=1720164782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRuwi8DrHNH9PM7BQRvaS+69U0hYrnjGzRWy+oNkAKQ=;
        b=Jd4hpFxslskytiQo/AhdYDCt8sbaceaTXizn/Z9LsI87rco3jQ1z0SFc1XcmWeWL2R
         SjMXzICE3ykLoSqWM/fk9EuX2pJeAKHYr1O17qw68L9JxIAkiJnhpXDOhUJZdzrZFBkm
         OJa5io1MeCViGQGuN6RxqUEFLq9U+5gif19I7fpo3vemnAWf0eQBo4t7HvwRZ8zjRwFV
         vvtNT0sLZb1nAt5KmudMGnyKTYyM3rOUTuWZ7ATlzmoOsnsQWpGKH4Z39uTAf1azGqDs
         uWI2Fq7apFO0J4v27nNKWbau7hGiQPEZTvzyldffatgMgJMM8HoB+KmVVxdBXfKF9e3a
         tzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNyotI8Ch1hvKnQrgZd7V87F5SpbEwyU5gUnz7DyU/HRMXGLPeOfliACcxqMv8y0ocpWDdqNcpAxpvajJZtbE7UdmKaonYW5I=
X-Gm-Message-State: AOJu0YxsSqn9p0eGVk7biwPK3eVhnq3IJ22ADCX4Ab14pIRv+RE4Vn68
	F6dxrlcc7HpCx6g2c95tuof1DHq5Sb1tPrJonFBtQBo5vXeXk0IvSQDgvXGkd8lc+/YfeAqVCbY
	UvZBg4dGRPa4IDNHQObV0HhX0by/xIAgdeViF
X-Google-Smtp-Source: AGHT+IFvHS8F/jJHGPcQ4bZNB2icCP5fYXZEuEoijfxibR04ttx09THt4jWsZqzbSXConhwlFpuOZxRCLKW5++dpdpA=
X-Received: by 2002:a05:6214:2464:b0:6b5:88:7cc8 with SMTP id
 6a1803df08f44-6b54099e969mr225534066d6.7.1719559982078; Fri, 28 Jun 2024
 00:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
In-Reply-To: <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 08:32:50 +0100
Message-ID: <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Chris Morgan <macromorgan@hotmail.com>, 
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2342

Hi Marek,

On Thu, 27 Jun 2024 at 17:05, Marek Vasut <marex@denx.de> wrote:
>
> On 6/27/24 10:37 AM, Simon Glass wrote:
> > Hi Marek,
>
> Hi,
>
> [...]
>
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
> Actually, it is reading only the bare minimum very early in bind, the
> always-on and boot-on, the rest is in pre_probe, i.e. later.

Yes, I see that. Also it is inevitable that these properties need to
be read before probe(), since they control whether to probe().

>
> > Also this seems to happen in SPL and again pre-reloc and again in
> > U-Boot post-reloc?
>
> What does, the uclass post_bind ?

I mean that this code will be called in SPL (if the regulators are in
the DT there), U-Boot pre-reloc and post-reloc, each time turning on
the regulators. We need a way to control that, don't we?

>
> > Should we have a step in the init sequence where we set up the
> > regulators, by calling regulators_enable_boot_on() ?
>
> Let's not do this , the entire point of this series is to get rid of
> those functions and do the regulator configuration the same way LED
> subsystem does it -- by probing always-on/boot-on regulators and
> configuring them correctly on probe.
>
> To me regulators_enable_boot_on() and the like was always an
> inconsistently applied workaround for missing DM_FLAG_PROBE_AFTER_BIND ,
> which is now implemented, so such workarounds can be removed.

That patch seemed to slip under the radar, sent and applied on the
same day! We really need to add a test for it, BTW.

My concern is that this might cause us ordering problems. We perhaps
want the regulators to be done first. If drivers are probed which use
regulators, then presumably they will enable them. Consider this:

- LED driver auto-probes
   - probes I2C bus 2
   - probes LDO1 which is autoset so turns on
- LDO1 probes, but is already running
- LDO2 probes, which is autoset so turns on

So long as it is OK to enable the regulators in any order, then this
seems fine. But is it? How do we handle the case where are particular
sequence is needed?

Regards,
Simon

