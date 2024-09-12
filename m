Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA9EED606
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 13:31:53 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.36907.1726102868240736835
 for <u-boot-amlogic@groups.io>;
 Wed, 11 Sep 2024 18:01:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=I/O138pR;
 spf=pass (domain: chromium.org, ip: 209.85.210.169, mailfrom: sjg@chromium.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71798661a52so290839b3a.0
        for <u-boot-amlogic@groups.io>; Wed, 11 Sep 2024 18:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726102868; x=1726707668; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5LnUs+3E25GlONNtCSTzMe04eZa+40fJGqgIpkNx7U=;
        b=I/O138pRjCXbYdcdTgBDt6jQKZR/naF0aBRstyoDSQXVJj7Mx9wNcTexsDQzVhe2rD
         shUMFrg0yiGthNzHGo0s70ReHVDXNUqM1BMMnSdxx1oWlh6MBFIBrAgOwQ1Tg99bTNkT
         9qfMnLauSSy3vpaUmtXxUzyv3lNhcpxyEzZ5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102868; x=1726707668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5LnUs+3E25GlONNtCSTzMe04eZa+40fJGqgIpkNx7U=;
        b=HpU3JUZRNcZAFbp5JTszbZUUeNz/MjcsVBKpfnJ6uiuGguax2M59ESpRQ4asKl3hH2
         7l4VWPqtlSxh+Vhm+nNbydsfnyOD7A1MFvIolrG6fEWKTii2PdnwyHxXm3zt8mWezCbS
         xBR0vt5Vmj3uDVRFlVS0cM3R9jOSPibmUVEgiULCXUoM47CPglKfvsoCDIYG/NLrXhq8
         uNjUieTSZDq9Vt6x56aR9UFFFHsTmCpEztkfOAupLm+ewhNgTJZoLrMWrGS7B7ntJCJ5
         mkxKc9E2qObLciqNpEsLvzt2s805MOSoHIhyi+kKU6ruPppBWpl6LZB67CCzJESRakng
         1Avg==
X-Forwarded-Encrypted: i=1; AJvYcCUwXdjf4FfrXq/tgiAQ2BSckWtCStlR8pYB6LrKlA5VTyN7cI+HRC9Voul/VL7VuR/8bRr7HI620BS4oIJzgw==@groups.io
X-Gm-Message-State: AOJu0YyqubK1GRnUIfZzJ996O98gDnJlGEPaUppR+BBgdl1T/CYDDhtr
	+eRzfQ0BKwjTYMXe2AdSU00dZPfUKKfyjpkgKpiFz2m1VTrE5FBU36j3mhfkjppuHUwl3TLgpVO
	Z9UJqC4BzQlm1C4tI095g8HKHEZ4zBuVmClei
X-Google-Smtp-Source: AGHT+IGayIgO2cDB67qAr/r9Qm3MVp5BQGGEHNZGej4dF4Fh8qVqB5M2/R/eJKiw84ELwE+iwxDn0k2KG+AheTH83/E=
X-Received: by 2002:a05:6a00:8985:b0:718:dda3:d7fe with SMTP id
 d2e1a72fcca58-71907f718c9mr11800099b3a.12.1726102867602; Wed, 11 Sep 2024
 18:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de> <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
In-Reply-To: <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:00:56 -0600
Message-ID: <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Thu, 12 Sep 2024 13:31:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2385

Hi Marek,

On Fri, 28 Jun 2024 at 07:26, Marek Vasut <marex@denx.de> wrote:
>
> On 6/28/24 9:32 AM, Simon Glass wrote:
> > Hi Marek,
>
> Hi,
>
> [...]
>
> >>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
> >>>>                                                   -ENODATA);
> >>>>           uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
> >>>>                                                   -ENODATA);
> >>>> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> >>>> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
> >>>>           uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
> >>>>                                                       0);
> >>>>           uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>> This is reading a lot of DT stuff very early, which may be slow. It is
> >>> also reading from the DT in the bind() step which we sometimes have to
> >>> do, but try to avoid.
> >>
> >> Actually, it is reading only the bare minimum very early in bind, the
> >> always-on and boot-on, the rest is in pre_probe, i.e. later.
> >
> > Yes, I see that. Also it is inevitable that these properties need to
> > be read before probe(), since they control whether to probe().
> >
> >>
> >>> Also this seems to happen in SPL and again pre-reloc and again in
> >>> U-Boot post-reloc?
> >>
> >> What does, the uclass post_bind ?
> >
> > I mean that this code will be called in SPL (if the regulators are in
> > the DT there), U-Boot pre-reloc and post-reloc, each time turning on
> > the regulators. We need a way to control that, don't we?
>
> I would assume that if those regulators are turned on once in the
> earliest stage , turning them on again in the follow up stage would be a
> noop ? This is the point of regulator-*-on, to keep the regulators on.

No, there is sometimes a particular sequence needed.

>
> >>> Should we have a step in the init sequence where we set up the
> >>> regulators, by calling regulators_enable_boot_on() ?
> >>
> >> Let's not do this , the entire point of this series is to get rid of
> >> those functions and do the regulator configuration the same way LED
> >> subsystem does it -- by probing always-on/boot-on regulators and
> >> configuring them correctly on probe.
> >>
> >> To me regulators_enable_boot_on() and the like was always an
> >> inconsistently applied workaround for missing DM_FLAG_PROBE_AFTER_BIND ,
> >> which is now implemented, so such workarounds can be removed.
> >
> > That patch seemed to slip under the radar, sent and applied on the
> > same day! We really need to add a test for it, BTW.
>
> Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was that it
> took a while to get in.

[1]

>
> > My concern is that this might cause us ordering problems. We perhaps
> > want the regulators to be done first. If drivers are probed which use
> > regulators, then presumably they will enable them. Consider this:
> >
> > - LED driver auto-probes
> >     - probes I2C bus 2
> >     - probes LDO1 which is autoset so turns on
> > - LDO1 probes, but is already running
> > - LDO2 probes, which is autoset so turns on
> >
> > So long as it is OK to enable the regulators in any order, then this
> > seems fine. But is it? How do we handle the case where are particular
> > sequence is needed?
>
> Did we finally arrive at the point where we need -EPROBE_DEFER alike
> mechanism ?

Nope. But I am concerned that this patch is leading us there. bind()
really needs to be as clean as possible. It is one of the design
elements of driver model which Linux should adopt.

There is always a race to be the first to init something, move the
init earlier, etc... I don't see any general need to init the
regulators right at the start. It should be done in a separate
function and be optional. I am happy to send a patch if you like.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20220422131555.123598-1-marex@denx.de/

