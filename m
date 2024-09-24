Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39068CF649C
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:31 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web11.3436.1727221453503357795
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Sep 2024 16:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LuWyGWvn;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-457e153cbdcso48994231cf.2
        for <u-boot-amlogic@groups.io>; Tue, 24 Sep 2024 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1727221452; x=1727826252; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P03mn90oLN4ug+q7R4E64HXeFlP3z7hnM7oy8hVHK7I=;
        b=LuWyGWvnE+AJdncu7GVSFbSYWss4QhJL/7JpgsOeH6OzZYKyUGRyFLE7nmbobRFjph
         Kilr47UwgYppcshBsKxVI1K/iBw4JdNrJUAev4cyHGYHUNTlke8VS1iHUJ9MAUnLwzy6
         F2m6NmEuJOPKw6I+bx9YT8V2tQoZXFkXioAWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727221452; x=1727826252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P03mn90oLN4ug+q7R4E64HXeFlP3z7hnM7oy8hVHK7I=;
        b=Txk8fA8LE2my6bi6ftfzfLh/gow2xnLiKPDa2EQrXiaAUaOnuffjgmkCuIq60cO5G4
         BRK6MyVVNAkPs8snd5vYk4d8Kjk5IItJMjSwxQiIQpeHZZNexi7OytqG5Vo9JsPy7fn+
         2QY036JJxUj+Itt3yaZr1W2YB3CZ3COE+2+XOMuRhRVKU+Ks4ZKipWwcH5cUj2xzvyEx
         QJJUPIzq0KXYpUDMsWbF+hV4cnZqkq/IOSQwe+BP1Td6ZNWsOH0kAu8ILFKaQNJYUchV
         ACTRNHcxPtcEFwH2gNaaK9qfgknSZskHveaQiYcliOISPmm5wv/SMAoB0KultQVOtgJu
         +wXg==
X-Forwarded-Encrypted: i=1; AJvYcCXtQQpKYXAFP+r4Oss3uunoJr10rHRkjJwgtnFcb8V4ERfthI3iUDrRXQ2zMPzlYyToxpZTQ7GWB/mPbsLR+w==@groups.io
X-Gm-Message-State: AOJu0YwVvhHoyhoTT6HL7wySHP88Ak9Kb2eYLYf+fAu/7bBUjS/pAH2N
	iNZRXtV0okQ4wIfPrWa/vIZ03NmlxIOlVLpBfERnZCGM+qeXoUfYhzomoIG8xL0=
X-Google-Smtp-Source: AGHT+IGSAFeMFVNn5GSTRrF0hFNNzmimoS2rcZA438DfRWz3dg2u0UpaXzO4eqppWn2v+qw9nVGnhg==
X-Received: by 2002:a05:622a:1104:b0:453:5f05:2ba3 with SMTP id d75a77b69052e-45b5dec7c50mr22656091cf.8.1727221452293;
        Tue, 24 Sep 2024 16:44:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b526924d7sm11083921cf.87.2024.09.24.16.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:44:11 -0700 (PDT)
Date: Tue, 24 Sep 2024 17:44:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
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
	Thierry Reding <treding@nvidia.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	u-boot-amlogic@groups.io, u-boot-qcom@groups.io,
	u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
Message-ID: <20240924234406.GX4252@bill-the-cat>
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat>
 <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
 <20240920164856.GI4252@bill-the-cat>
MIME-Version: 1.0
In-Reply-To: <20240920164856.GI4252@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=cOGPlvlsq7esBySJnRRZ"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2412

--Groupsio=cOGPlvlsq7esBySJnRRZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 10:48:56AM -0600, Tom Rini wrote:
> On Fri, Sep 20, 2024 at 07:40:35PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 16 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 19:28 =
Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Sep 11, 2024 at 07:00:56PM -0600, Simon Glass wrote:
> > > > Hi Marek,
> > > >
> > > > On Fri, 28 Jun 2024 at 07:26, Marek Vasut <marex@denx.de> wrote:
> > > > >
> > > > > On 6/28/24 9:32 AM, Simon Glass wrote:
> > > > > > Hi Marek,
> > > > >
> > > > > Hi,
> > > > >
> > > > > [...]
> > > > >
> > > > > >>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct ud=
evice *dev)
> > > > > >>>>                                                   -ENODATA);
> > > > > >>>>           uc_pdata->max_uA =3D dev_read_u32_default(dev, "re=
gulator-max-microamp",
> > > > > >>>>                                                   -ENODATA);
> > > > > >>>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulato=
r-always-on");
> > > > > >>>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-=
boot-on");
> > > > > >>>>           uc_pdata->ramp_delay =3D dev_read_u32_default(dev,=
 "regulator-ramp-delay",
> > > > > >>>>                                                       0);
> > > > > >>>>           uc_pdata->force_off =3D dev_read_bool(dev, "regula=
tor-force-boot-off");
> > > > > >>>> --
> > > > > >>>> 2.43.0
> > > > > >>>>
> > > > > >>>
> > > > > >>> This is reading a lot of DT stuff very early, which may be sl=
ow. It is
> > > > > >>> also reading from the DT in the bind() step which we sometime=
s have to
> > > > > >>> do, but try to avoid.
> > > > > >>
> > > > > >> Actually, it is reading only the bare minimum very early in bi=
nd, the
> > > > > >> always-on and boot-on, the rest is in pre_probe, i.e. later.
> > > > > >
> > > > > > Yes, I see that. Also it is inevitable that these properties ne=
ed to
> > > > > > be read before probe(), since they control whether to probe().
> > > > > >
> > > > > >>
> > > > > >>> Also this seems to happen in SPL and again pre-reloc and agai=
n in
> > > > > >>> U-Boot post-reloc?
> > > > > >>
> > > > > >> What does, the uclass post_bind ?
> > > > > >
> > > > > > I mean that this code will be called in SPL (if the regulators =
are in
> > > > > > the DT there), U-Boot pre-reloc and post-reloc, each time turni=
ng on
> > > > > > the regulators. We need a way to control that, don't we?
> > > > >
> > > > > I would assume that if those regulators are turned on once in the
> > > > > earliest stage , turning them on again in the follow up stage wou=
ld be a
> > > > > noop ? This is the point of regulator-*-on, to keep the regulator=
s on.
> > > >
> > > > No, there is sometimes a particular sequence needed.
> > > >
> > > > >
> > > > > >>> Should we have a step in the init sequence where we set up th=
e
> > > > > >>> regulators, by calling regulators_enable_boot_on() ?
> > > > > >>
> > > > > >> Let's not do this , the entire point of this series is to get =
rid of
> > > > > >> those functions and do the regulator configuration the same wa=
y LED
> > > > > >> subsystem does it -- by probing always-on/boot-on regulators a=
nd
> > > > > >> configuring them correctly on probe.
> > > > > >>
> > > > > >> To me regulators_enable_boot_on() and the like was always an
> > > > > >> inconsistently applied workaround for missing DM_FLAG_PROBE_AF=
TER_BIND ,
> > > > > >> which is now implemented, so such workarounds can be removed.
> > > > > >
> > > > > > That patch seemed to slip under the radar, sent and applied on =
the
> > > > > > same day! We really need to add a test for it, BTW.
> > > > >
> > > > > Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was tha=
t it
> > > > > took a while to get in.
> > > >
> > > > [1]
> > > >
> > > > >
> > > > > > My concern is that this might cause us ordering problems. We pe=
rhaps
> > > > > > want the regulators to be done first. If drivers are probed whi=
ch use
> > > > > > regulators, then presumably they will enable them. Consider thi=
s:
> > > > > >
> > > > > > - LED driver auto-probes
> > > > > >     - probes I2C bus 2
> > > > > >     - probes LDO1 which is autoset so turns on
> > > > > > - LDO1 probes, but is already running
> > > > > > - LDO2 probes, which is autoset so turns on
> > > > > >
> > > > > > So long as it is OK to enable the regulators in any order, then=
 this
> > > > > > seems fine. But is it? How do we handle the case where are part=
icular
> > > > > > sequence is needed?
> > > > >
> > > > > Did we finally arrive at the point where we need -EPROBE_DEFER al=
ike
> > > > > mechanism ?
> > > >
> > > > Nope. But I am concerned that this patch is leading us there. bind(=
)
> > > > really needs to be as clean as possible. It is one of the design
> > > > elements of driver model which Linux should adopt.
> > > >
> > > > There is always a race to be the first to init something, move the
> > > > init earlier, etc... I don't see any general need to init the
> > > > regulators right at the start. It should be done in a separate
> > > > function and be optional. I am happy to send a patch if you like.
> > >
> > > Since we're currently stuck on the point where Marek has patches that
> > > fix a real problem, and Svyatoslav has a problem with them, but isn't
> > > currently able to debug it, yes, please put forward your patch that
> > > might address both sets of problems so we can all figure out how to
> > > resolve the problems, thanks!
> >=20
> > With patches from Marek there is no i2c chip probe of PMIC, while
> > without i2c chip probe is called (probe_chip function). How this is
> > even possible?
>=20
> Yes, it's very puzzling. Do you have the ability to get some debug
> console type information out so you can sprinkle in some prints and
> figure it out?

So, here's my plan. Marek posted
https://patchwork.ozlabs.org/project/uboot/patch/20240924220905.514122-1-ma=
rex@denx.de/
which is a work-around, so that v2024.10 can work. I'm going to take
that for master tomorrow. I'm also going to take _this_ series to -next
tomorrow, as this is the best approach we currently have to solving the
overall problem. The Tegra platforms that are now very oddly broken need
to get debugged to see where their problem is, and if there's an
entirely alternate approach, Simon can post patches for that instead on
top of next.

--=20
Tom

--Groupsio=cOGPlvlsq7esBySJnRRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbzTsIACgkQFHw5/5Y0
tyzDhgv2LJ+bMV4zsPkePu4u+aBk1VuRHfL7pr/t8xQ3gfvPQzwyVWLn9rnBN0al
h1xtcFmw1Bw1WuxU53m08b8Rb9xFzjr/Dd2+mWFMx/07s1w+MQownm7AmwVGAre/
29Hor5HwDyd0MBIM8vCq7KI3xoAiTdei1wZQRPcK2fENfkasSY5LUuOC0fznRIZK
ZKFB9zgDp+43rMocm38caXuW2GTds7nNkr0o+uHVore0Teinb75bCKgFvdichQ+2
s2+rK6w8+XGYnpnIzaddAsoVR7HpCT44MlkX+KLV4RPlSTqrpE2LMNIbJUpK5SWx
hRXixBu6zepyweaWhPPHcuFIDWRYMx4eYNrRVupa2Dzo3YdodE+f2hXZcAu9KLtX
+vt1b4V+kWt7TUBLBUMMLJq3jFrbP4XVgqqKxpYQSYJwKdNz1h06B0G6s80esQ5p
cFbESD3Q7S8yT8V/AUWAVY/HthGSPN1qi/TrsTe5ydeLNCkMhQA6ZYPjgrhXNHyd
JYR1DIw=
=PgjZ
-----END PGP SIGNATURE-----

--Groupsio=cOGPlvlsq7esBySJnRRZ--

