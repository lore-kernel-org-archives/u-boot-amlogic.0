Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1792CDD578
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 09:27:38 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web11.13209.1726504087189876251
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Sep 2024 09:28:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=H0qob2/F;
 spf=pass (domain: konsulko.com, ip: 209.85.210.53, mailfrom: trini@konsulko.com)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71100987d1cso2088741a34.2
        for <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1726504086; x=1727108886; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EF0G2jQNMJy6viIsTcTH6P2KkptSEkkmUDZfppdy6k4=;
        b=H0qob2/Fr5nsdbvnOxdXLN4opkDkiR9PEd7Oc+cSTqMpr/6QZzgeoQwu8TPpKcW7HN
         sS+Qao6Wsks/qojs6UQdRvzDb5oe6/H64UXQFJiNvCVl2R/266rOO4BB+Gtxj3vsQIvd
         Jvi8Yd87+KQ/l8k2pLNbBVurma30m16yUOdLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726504086; x=1727108886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF0G2jQNMJy6viIsTcTH6P2KkptSEkkmUDZfppdy6k4=;
        b=rpcgqrkWC8XIkUfeiga73anqsYH5xSVQmDzUV/hy8oYq/E2wwCZ9zGn0UTUkD8QgzD
         /c/uXxI57ulbXrJnxdrbDdpYs02SELUUoU9aY6zVylhak/vUHRMtC7z7hVT8eJrCA+Mp
         Lxu+fRuGzC2f9oNbOdFXZDVTPzVsb+8sqs1bAcH8PkfuOIpgu27+N/vdgZuTAeD9lx7A
         aL65d2QsVjVvVmVTnSb3mX959ZEYxqag/xg2h0onJgc3niW5NNQXXYSEbDkZr/VfAHDj
         NKwzdvS8QsPpR9jy7wFYXFCYKSZtYGfQBMW5q2vMNrM/LBpF5AOoW9auMpOM06NcTxyD
         zyGg==
X-Forwarded-Encrypted: i=1; AJvYcCXfnEgZ/AjKe3foI6SacPdebA/vbnYyLYx1/Z6o3GYYxa7pzPPY32d423CnzGWXfHEJnUtZeptCdYb6uBH87A==@groups.io
X-Gm-Message-State: AOJu0YxwfwhNgJ5lFcAaKC80BQIa+R/uzvHfUHhPtWOaBz9jbKu8+83q
	zyafuvzDcezifJ1+vFmL1aYcM20Cgo5oWKvvQF6QOolkoVPvI1ZW9EsSLzIzcB8=
X-Google-Smtp-Source: AGHT+IEGGoKrkeYZTDx6+y8aLlMeNnu3/sLcIrs3HtPAPlkPWVWoTR7nkC5JxQreu3BBrQ0Jr7LRIg==
X-Received: by 2002:a05:6358:430c:b0:1b8:33b2:1482 with SMTP id e5c5f4694b2df-1bc3941ab52mr261652355d.1.1726504085991;
        Mon, 16 Sep 2024 09:28:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac61237sm28776961cf.16.2024.09.16.09.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:28:04 -0700 (PDT)
Date: Mon, 16 Sep 2024 10:27:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
	Ben Wolsieffer <benwolsieffer@gmail.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Kever Yang <kever.yang@rock-chips.com>,
	Kostya Porotchkin <kostap@marvell.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	u-boot-amlogic@groups.io, u-boot-qcom@groups.io,
	u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
Message-ID: <20240916162758.GE4252@bill-the-cat>
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=0i2kLBA72K0hRiP1iAHl"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 09:27:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2399

--Groupsio=0i2kLBA72K0hRiP1iAHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 07:00:56PM -0600, Simon Glass wrote:
> Hi Marek,
>=20
> On Fri, 28 Jun 2024 at 07:26, Marek Vasut <marex@denx.de> wrote:
> >
> > On 6/28/24 9:32 AM, Simon Glass wrote:
> > > Hi Marek,
> >
> > Hi,
> >
> > [...]
> >
> > >>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice =
*dev)
> > >>>>                                                   -ENODATA);
> > >>>>           uc_pdata->max_uA =3D dev_read_u32_default(dev, "regulato=
r-max-microamp",
> > >>>>                                                   -ENODATA);
> > >>>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-alwa=
ys-on");
> > >>>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-o=
n");
> > >>>>           uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "regu=
lator-ramp-delay",
> > >>>>                                                       0);
> > >>>>           uc_pdata->force_off =3D dev_read_bool(dev, "regulator-fo=
rce-boot-off");
> > >>>> --
> > >>>> 2.43.0
> > >>>>
> > >>>
> > >>> This is reading a lot of DT stuff very early, which may be slow. It=
 is
> > >>> also reading from the DT in the bind() step which we sometimes have=
 to
> > >>> do, but try to avoid.
> > >>
> > >> Actually, it is reading only the bare minimum very early in bind, th=
e
> > >> always-on and boot-on, the rest is in pre_probe, i.e. later.
> > >
> > > Yes, I see that. Also it is inevitable that these properties need to
> > > be read before probe(), since they control whether to probe().
> > >
> > >>
> > >>> Also this seems to happen in SPL and again pre-reloc and again in
> > >>> U-Boot post-reloc?
> > >>
> > >> What does, the uclass post_bind ?
> > >
> > > I mean that this code will be called in SPL (if the regulators are in
> > > the DT there), U-Boot pre-reloc and post-reloc, each time turning on
> > > the regulators. We need a way to control that, don't we?
> >
> > I would assume that if those regulators are turned on once in the
> > earliest stage , turning them on again in the follow up stage would be =
a
> > noop ? This is the point of regulator-*-on, to keep the regulators on.
>=20
> No, there is sometimes a particular sequence needed.
>=20
> >
> > >>> Should we have a step in the init sequence where we set up the
> > >>> regulators, by calling regulators_enable_boot_on() ?
> > >>
> > >> Let's not do this , the entire point of this series is to get rid of
> > >> those functions and do the regulator configuration the same way LED
> > >> subsystem does it -- by probing always-on/boot-on regulators and
> > >> configuring them correctly on probe.
> > >>
> > >> To me regulators_enable_boot_on() and the like was always an
> > >> inconsistently applied workaround for missing DM_FLAG_PROBE_AFTER_BI=
ND ,
> > >> which is now implemented, so such workarounds can be removed.
> > >
> > > That patch seemed to slip under the radar, sent and applied on the
> > > same day! We really need to add a test for it, BTW.
> >
> > Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was that it
> > took a while to get in.
>=20
> [1]
>=20
> >
> > > My concern is that this might cause us ordering problems. We perhaps
> > > want the regulators to be done first. If drivers are probed which use
> > > regulators, then presumably they will enable them. Consider this:
> > >
> > > - LED driver auto-probes
> > >     - probes I2C bus 2
> > >     - probes LDO1 which is autoset so turns on
> > > - LDO1 probes, but is already running
> > > - LDO2 probes, which is autoset so turns on
> > >
> > > So long as it is OK to enable the regulators in any order, then this
> > > seems fine. But is it? How do we handle the case where are particular
> > > sequence is needed?
> >
> > Did we finally arrive at the point where we need -EPROBE_DEFER alike
> > mechanism ?
>=20
> Nope. But I am concerned that this patch is leading us there. bind()
> really needs to be as clean as possible. It is one of the design
> elements of driver model which Linux should adopt.
>=20
> There is always a race to be the first to init something, move the
> init earlier, etc... I don't see any general need to init the
> regulators right at the start. It should be done in a separate
> function and be optional. I am happy to send a patch if you like.

Since we're currently stuck on the point where Marek has patches that
fix a real problem, and Svyatoslav has a problem with them, but isn't
currently able to debug it, yes, please put forward your patch that
might address both sets of problems so we can all figure out how to
resolve the problems, thanks!

--=20
Tom

--Groupsio=0i2kLBA72K0hRiP1iAHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmboXIsACgkQFHw5/5Y0
tyxNjQv+MMGXX9xIKCbeFdYltaw7eLEqMQFyig/4VOgf1x82FcxpYrfFMa4gopjM
j3I111hWh4tO69F8O+j2guT2Sr08pa0rO7JL+vaJY1iukXFHMtNJrL3WgIL3EpS9
cqgRLEe7e5YbPibKqXPKconEfjXwcjXVOSwwFXFfNFnJJ+0IWLUUxd/pgWXpTziK
2CwoDLICFx/OE2EXTWIC9gQZPrIeK24jOjMJbKur953KBIYOxNcYFLJML7k78kQc
swjPNXeQZMq4PwmUZpsvO9Aq0O1iBAx8ly9rMQYtCYD9/dx2N0qplie0M/IHI0O1
IO0WtlHPNpOTdJzcgEYpDqLUE2rced+GjE6piuxkr/zepocm4MXm03fFc5Kh3Ltf
cfryRrBotyqYLH5ldXbtrKSSSSps0NeDO4e9uDCN1vEq4QSMdXGSEhKFD0jIa5f6
LgUcniXI4IzWxHPCfCCmcIKtN6wF7o7xEXA/HCHv8T+sJmxZDi6SdVWOBgtfxAlq
z2sx3b6p
=JwHe
-----END PGP SIGNATURE-----

--Groupsio=0i2kLBA72K0hRiP1iAHl--

