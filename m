Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD80CF64B0
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:41 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.13646.1727264276016064436
 for <u-boot-amlogic@groups.io>;
 Wed, 25 Sep 2024 04:37:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=HM6GwhyZ;
 spf=pass (domain: chromium.org, ip: 209.85.219.51, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c54a5fbceeso49928456d6.2
        for <u-boot-amlogic@groups.io>; Wed, 25 Sep 2024 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727264275; x=1727869075; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hFEMNur252euyH5KLeLMgv3HkxBPIqpVpertN5ufXY=;
        b=HM6GwhyZ+1qPtRLFbmgg71imOxenTLYPJ4dz95g7/fvQS1Ag2vAcDHyG3pegmuq8xa
         2uy65n3ijBNN2TgBWXbYZ891LNvfPcc0fzd7wRoCKX7Bn0ca6reABS2+df1/kGv5C6dc
         TYHvkUXXhUvNY94qpIgJ5Gja2f3ucvFF2r5K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727264275; x=1727869075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hFEMNur252euyH5KLeLMgv3HkxBPIqpVpertN5ufXY=;
        b=AIMxTfmBU7nw9V1lWk+IaAqzCYE0L2/yy9jg91Xvm0k6EKUV0wiojvslHsZoFPawPc
         uaM/JgNISjdbz/D1j6mSHl4xgbrMX9ozq8NdqEpDUvN883ozawMR09zluDbp5oqazqcb
         OQoz7Q5bleRF9XHbhCJvoCPi0uwQ/Wxl5tVr71i8Dw3BvePIeBix9/nSEtHOOCLLACbN
         HOFR1qwUjJRVmKFkc8m0ayG97No1bMEUMTMjrXegiTZ83vTSDCopUWPFFT/V9N+ZkED0
         jchE40GvA284UQSqvpBakOPL7oUadw6XmdTXBXXkSyU+TCiWgtsAFeNGnSGR8SnE8zON
         VTlw==
X-Forwarded-Encrypted: i=1; AJvYcCWu535SmCFAGDTvin2K3yNu3BSva1rU727H5I7bP0NmsSfScsdkNoNwQqX09vIdQCsxF8PvwJcRKs/ZWV43+A==@groups.io
X-Gm-Message-State: AOJu0YwrQtBFcAio4NdWj+XMRXhGccea+P+AJEKtwN0Cck+utMp9w15T
	LQ+JoRKOD6D5SIMdLQ+DAZ2eCMlRU5CuY9OlaSYY+Fo4JKNc0ahhHZ7Q9Wso1Mr4zQk1+Ata8Oe
	2HByo4Ew+l+HcudqZfnG9jA5gmCxQg8GWaUul
X-Google-Smtp-Source: AGHT+IERT/uHerpGeNcyKnkhtSSlndfTw9TRWtaxXp1Vi6Estl+jw/DRqoCHoqqtttjfL2aUl8gMKIjZLNh3UHi+3/4=
X-Received: by 2002:a05:6214:54c6:b0:6c5:52c9:950c with SMTP id
 6a1803df08f44-6cb1dd6f0e8mr35811796d6.25.1727264274928; Wed, 25 Sep 2024
 04:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de> <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de> <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat> <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
 <20240920164856.GI4252@bill-the-cat>
In-Reply-To: <20240920164856.GI4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 13:37:41 +0200
Message-ID: <CAFLszTiAqmYUVhC4K4KXBkzwj_kWQqYSPfSmnu0higN2_9+-Hw@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
	Ben Wolsieffer <benwolsieffer@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	Eugen Hristev <eugen.hristev@collabora.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
	Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, Max Krummenacher <max.krummenacher@toradex.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
	u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
	uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2422

Hi,

On Fri, 20 Sept 2024 at 18:49, Tom Rini <trini@konsulko.com> wrote:
>
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
> >
> > With patches from Marek there is no i2c chip probe of PMIC, while
> > without i2c chip probe is called (probe_chip function). How this is
> > even possible?
>
> Yes, it's very puzzling. Do you have the ability to get some debug
> console type information out so you can sprinkle in some prints and
> figure it out?

We did have a pmic maintainer for a while, but perhaps has gone quiet?

I am OK with a call to regulators_enable_boot_on(), but where should
it go? Should it happen in SPL? Should it happen before relocation?
How is that decided and controlled?

I actually don't like DM_FLAG_PROBE_AFTER_BIND since it makes bind =3D=3D
probe, something which I believe U-Boot should really try to avoid. I
would even rather have an explicit call in initf_dm() - or perhaps
better initr_dm()? My favourite option would be a new line in the
board_r init sequence instead of power_init_board(), which predates
driver model.

Regards,
Simon

