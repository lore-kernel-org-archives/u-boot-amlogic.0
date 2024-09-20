Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C547CF64A8
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:31 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web10.23262.1726850943210476142
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Sep 2024 09:49:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CvxSN8qF;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9ae0e116cso225638285a.1
        for <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1726850942; x=1727455742; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5mnlKp0YXkkmN8wV6HNdGcFRI0bd/y2EXv4WFH0iwo=;
        b=CvxSN8qF4XORcDyQEVP5Y3y9yfw6KHBeofrBVqk4eweFlIs0BuNbhRk/yj0azduPc9
         gBlOB5caqBD1Ti4BKs6Qv3QP4gLvYb2GR6Jpm9eZsD1L24tmAWnLTJN3jfDUystG8eS5
         EY5Xrwxo9r71ch17QiYlHTQg2QSshzc8bSHXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850942; x=1727455742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5mnlKp0YXkkmN8wV6HNdGcFRI0bd/y2EXv4WFH0iwo=;
        b=V2YaGAQi8Rfdogk0WoBpvLj+CdSgp6kuUUSKIO+gLOnpusgV23aeB+7U1RWwBZZC8m
         7EO1t55cakViNQYCNJec4GRc6+CI1Zgy70UG8EmjxIxXo1z7AiU9KgwLS05QDKvYAQUc
         ABmRKH5PhfsuIht9yryKp+SPYZcBHJs3lHRDCa8k0fbvpWNRwm3DjgjDo1foXQZEz+43
         QBcS/gh1iYfNheZn9K40G8Sl9AztHDHz7ugZXJpViPT+if8lGK+t9gq+GiT02kYt1Mja
         z1WnFSz1dzYycQpidWPIg07rgw6qQ7gtQBK7Z5xIY7TFakMlhPpxE+j+cH9kwhyJvscW
         rt2A==
X-Forwarded-Encrypted: i=1; AJvYcCVs0rDPQZr8S6gp8VwcCZtsB5FPLBxoQ08wnIW1C2Y0UleQPPY4/g9bBXxorEbuBnhYZh5J+V7H+7pxygjVbQ==@groups.io
X-Gm-Message-State: AOJu0YzvBFgm9yHkxPT1Qvis3ZPoxTYcu342HhEM3npbpzgdxvinLDDj
	6xXegF8vPh6WHOwoTQxm7ksgoKUYNAoPDuJFIrejl1nhRfpX4jvmj+GZic6e9iA=
X-Google-Smtp-Source: AGHT+IGkcRRBUMv8IFlMMi/L5HW0d/LCyTD9yZAxI7oF9GA5uAAdbpB8A22XGp4tAjzmlyo7apfyig==
X-Received: by 2002:a05:6214:3293:b0:6c7:c753:d2d8 with SMTP id 6a1803df08f44-6c7c753d4bcmr8147636d6.42.1726850942066;
        Fri, 20 Sep 2024 09:49:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e586d10sm19445536d6.141.2024.09.20.09.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:49:01 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:48:56 -0600
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
Message-ID: <20240920164856.GI4252@bill-the-cat>
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat>
 <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=47gIfiqOP4d2Y86qY0ev"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2407

--Groupsio=47gIfiqOP4d2Y86qY0ev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 07:40:35PM +0300, Svyatoslav Ryhel wrote:
> =D0=BF=D0=BD, 16 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 19:28 To=
m Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Sep 11, 2024 at 07:00:56PM -0600, Simon Glass wrote:
> > > Hi Marek,
> > >
> > > On Fri, 28 Jun 2024 at 07:26, Marek Vasut <marex@denx.de> wrote:
> > > >
> > > > On 6/28/24 9:32 AM, Simon Glass wrote:
> > > > > Hi Marek,
> > > >
> > > > Hi,
> > > >
> > > > [...]
> > > >
> > > > >>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udev=
ice *dev)
> > > > >>>>                                                   -ENODATA);
> > > > >>>>           uc_pdata->max_uA =3D dev_read_u32_default(dev, "regu=
lator-max-microamp",
> > > > >>>>                                                   -ENODATA);
> > > > >>>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-=
always-on");
> > > > >>>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-bo=
ot-on");
> > > > >>>>           uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "=
regulator-ramp-delay",
> > > > >>>>                                                       0);
> > > > >>>>           uc_pdata->force_off =3D dev_read_bool(dev, "regulato=
r-force-boot-off");
> > > > >>>> --
> > > > >>>> 2.43.0
> > > > >>>>
> > > > >>>
> > > > >>> This is reading a lot of DT stuff very early, which may be slow=
. It is
> > > > >>> also reading from the DT in the bind() step which we sometimes =
have to
> > > > >>> do, but try to avoid.
> > > > >>
> > > > >> Actually, it is reading only the bare minimum very early in bind=
, the
> > > > >> always-on and boot-on, the rest is in pre_probe, i.e. later.
> > > > >
> > > > > Yes, I see that. Also it is inevitable that these properties need=
 to
> > > > > be read before probe(), since they control whether to probe().
> > > > >
> > > > >>
> > > > >>> Also this seems to happen in SPL and again pre-reloc and again =
in
> > > > >>> U-Boot post-reloc?
> > > > >>
> > > > >> What does, the uclass post_bind ?
> > > > >
> > > > > I mean that this code will be called in SPL (if the regulators ar=
e in
> > > > > the DT there), U-Boot pre-reloc and post-reloc, each time turning=
 on
> > > > > the regulators. We need a way to control that, don't we?
> > > >
> > > > I would assume that if those regulators are turned on once in the
> > > > earliest stage , turning them on again in the follow up stage would=
 be a
> > > > noop ? This is the point of regulator-*-on, to keep the regulators =
on.
> > >
> > > No, there is sometimes a particular sequence needed.
> > >
> > > >
> > > > >>> Should we have a step in the init sequence where we set up the
> > > > >>> regulators, by calling regulators_enable_boot_on() ?
> > > > >>
> > > > >> Let's not do this , the entire point of this series is to get ri=
d of
> > > > >> those functions and do the regulator configuration the same way =
LED
> > > > >> subsystem does it -- by probing always-on/boot-on regulators and
> > > > >> configuring them correctly on probe.
> > > > >>
> > > > >> To me regulators_enable_boot_on() and the like was always an
> > > > >> inconsistently applied workaround for missing DM_FLAG_PROBE_AFTE=
R_BIND ,
> > > > >> which is now implemented, so such workarounds can be removed.
> > > > >
> > > > > That patch seemed to slip under the radar, sent and applied on th=
e
> > > > > same day! We really need to add a test for it, BTW.
> > > >
> > > > Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was that =
it
> > > > took a while to get in.
> > >
> > > [1]
> > >
> > > >
> > > > > My concern is that this might cause us ordering problems. We perh=
aps
> > > > > want the regulators to be done first. If drivers are probed which=
 use
> > > > > regulators, then presumably they will enable them. Consider this:
> > > > >
> > > > > - LED driver auto-probes
> > > > >     - probes I2C bus 2
> > > > >     - probes LDO1 which is autoset so turns on
> > > > > - LDO1 probes, but is already running
> > > > > - LDO2 probes, which is autoset so turns on
> > > > >
> > > > > So long as it is OK to enable the regulators in any order, then t=
his
> > > > > seems fine. But is it? How do we handle the case where are partic=
ular
> > > > > sequence is needed?
> > > >
> > > > Did we finally arrive at the point where we need -EPROBE_DEFER alik=
e
> > > > mechanism ?
> > >
> > > Nope. But I am concerned that this patch is leading us there. bind()
> > > really needs to be as clean as possible. It is one of the design
> > > elements of driver model which Linux should adopt.
> > >
> > > There is always a race to be the first to init something, move the
> > > init earlier, etc... I don't see any general need to init the
> > > regulators right at the start. It should be done in a separate
> > > function and be optional. I am happy to send a patch if you like.
> >
> > Since we're currently stuck on the point where Marek has patches that
> > fix a real problem, and Svyatoslav has a problem with them, but isn't
> > currently able to debug it, yes, please put forward your patch that
> > might address both sets of problems so we can all figure out how to
> > resolve the problems, thanks!
>=20
> With patches from Marek there is no i2c chip probe of PMIC, while
> without i2c chip probe is called (probe_chip function). How this is
> even possible?

Yes, it's very puzzling. Do you have the ability to get some debug
console type information out so you can sprinkle in some prints and
figure it out?

--=20
Tom

--Groupsio=47gIfiqOP4d2Y86qY0ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbtp3gACgkQFHw5/5Y0
tywr6Av/XI9hPV+8aqFzHxVis9rqKhD8iGfdD7dHTHckrlHyLh+JPPda2flYbKMS
EIH6lPxHAsNhVwZ0BS/1qLDlicaUoI4Dg6bi1ffkux0gCk0GOg0K1SLUUHczOjPE
8p7OygaFVS08w0AiLE25LP8B6d+HKBITMWOgGiOdY5ZP9uMOfLWFT98MVJDfna1R
h2bGW/u9JwXqK2eCsyrt5uGZ5o+nbyqmLGHmu0SCzNEKvfkoJSVGI7lEfho5Ljwv
2i/cvUyNBSXFaCdKUBhIKFPPu0sF22GXjwF1q50582bkJ08QxprpxpxHDvPGGCiD
mp5FmlbxuAfkmNMZ+VLKitvHOhsD35oxq4jfwgJ1FDewDRKCpipo+WsG3StHirau
q9H71Z7l+JR0FRyAYSS1mvRASiHDEgVjuEAkajmc2r4lCrxPWke5vSjr0d/8Zr7Q
Jw88u2J+n8iSfm8+r7ShCxbV2OHzzijb2JwQviEQP9tXBF7IIXmYXI+a2s9J1k4s
PuhveSmr
=LQhm
-----END PGP SIGNATURE-----

--Groupsio=47gIfiqOP4d2Y86qY0ev--

