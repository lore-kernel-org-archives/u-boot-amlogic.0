Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606ADC3065F
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:15 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.4980.1719484486641523454
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Jun 2024 03:34:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Qq3DTItj;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: clamor95@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36743abace4so265641f8f.1;
        Thu, 27 Jun 2024 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719484485; x=1720089285; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exKZBDAzL2/IHylKbI/wFm52BBqsF7JL1d2PljSBYTo=;
        b=Qq3DTItjLvxTINDA+5KDz7W+Nz4qiy5yBwDZy/mbdXuZYGQGscn0NsyrRZzS3WCO9c
         mWiDHOvPhUP8qnOP4h+eQDl66UwrNYMhmCcK35wmZrEvtlMHaO/45N0f4j3rAw/cksTu
         MCHPp3Md8SE2cyUbRyriBGRRJjuz44nRAIlGlVyDkN7ZRWHgaqLoFNIwyJ/3oaktBZs6
         AeQqY85TKEYo/OWN6FWFA0U8SjUjS+bafozjupYlR+lbFD4OtZnZoZnmdMXrgdn1ByNt
         E7N8BpTa9noKn6Sx1Zmbz2Z84kYjnJz9ADhN8dtjnFSBMLhlf6AC58C5tgwOu+/AGd16
         kPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484485; x=1720089285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exKZBDAzL2/IHylKbI/wFm52BBqsF7JL1d2PljSBYTo=;
        b=HdS43XdzJ3OBYogl6Q6oAWnZY8KsSFOQCuiEvU8U9zLp4QTIB+vZaSCgdvR9Mc8B+/
         TUoOswkYExJtkkKfTBpjStrU6lMiWN/p6Ff/1WSRdbK8k+qipRfpERI9DeBrFo7wcWRD
         QpmGjuS/KwrIUM6luuiXd7bON8a/ne2WFs/E2Gq2kW1ucemVj9fDq2NyVH5/Y+l6A0Je
         8U5AC3IXTvE+03daZf7MNd9j4wY524p8w2aIYUgNvwmBHTaKrObvnDaLqCw9oc6IemQ8
         Hwr0ZkowK8cjmjzTrjUahAZFsi4sPJCjSfz2gWOYn8PuJRE14As7aNA0003Nb2X4IK4v
         1uBA==
X-Forwarded-Encrypted: i=1; AJvYcCUyhUztcfx5nMadR2xWR44W9Tocu614yF7QBmVVCP2jyJ2toCpqNL4sS/QIGb8+FyseMgczx8qqxm8nJd6ajFGYQMVmetMxDdxF6PMzuNfLYvH1Z4XGNU+gjMJSAy3t7A==
X-Gm-Message-State: AOJu0Yxgr8ylD0JX2kGQLjVz5mK30fJMfVAwHlgTcSnMGNaFxYsV05qO
	0FGDmlKSYrWeEBh5nFLpLToHBHPIK3oZ6wmhSq2UEAnm2ZE4gxdnyeSbjuj0ZvkNAsr+4HrPo7f
	wWLFSdXtNwAtD/fP+PnHBXnxiukg=
X-Google-Smtp-Source: AGHT+IFa71/vs9HXIetHiqdDWDIZVF0rzrXXEtQ7d1W/hMOHigi/3LR4FRoevGbXYNHTXRXYgfQjkoMUmIwAM1GI+O0=
X-Received: by 2002:a5d:4e0f:0:b0:367:409b:1d1e with SMTP id
 ffacd0b85a97d-36741789767mr1555664f8f.12.1719484484863; Thu, 27 Jun 2024
 03:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org> <96AEFD59-B8D3-4298-8867-E94D474E16BE@gmail.com>
 <CAFLszTgvEkunWE8apORsK0+PU7wjrWCVCR0F1qij=yo8nDLUNg@mail.gmail.com>
In-Reply-To: <CAFLszTgvEkunWE8apORsK0+PU7wjrWCVCR0F1qij=yo8nDLUNg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 27 Jun 2024 13:34:34 +0300
Message-ID: <CAPVz0n0ySK1YrE_Y_jSMm5WxG_b6Kc9PiXp2mMC0i7pwSWkFRQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
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
	Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Tom Rini <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
	u-boot-amlogic@groups.io, u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
	uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 11:57:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2341

=D1=87=D1=82, 27 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE 12:2=
6 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Thu, 27 Jun 2024 at 10:09, Svyatoslav <clamor95@gmail.com> wrote:
> >
> >
> >
> > 27 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 11:48:46 G=
MT+03:00, Caleb Connolly <caleb.connolly@linaro.org> =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> > >
> > >
> > >On 27/06/2024 10:37, Simon Glass wrote:
> > >> Hi Marek,
> > >>
> > >> On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
> > >>>
> > >>> In case a regulator DT node contains regulator-always-on or regulat=
or-boot-on
> > >>> property, make sure the regulator gets correctly configured by U-Bo=
ot on start
> > >>> up. Unconditionally probe such regulator drivers. This is a prepara=
tory patch
> > >>> for introduction of .regulator_post_probe() which would trigger the=
 regulator
> > >>> configuration.
> > >>>
> > >>> Parsing of regulator-always-on and regulator-boot-on DT property ha=
s been
> > >>> moved to regulator_post_bind() as the information is required early=
, the
> > >>> rest of the DT parsing has been kept in regulator_pre_probe() to av=
oid
> > >>> slowing down the boot process.
> > >>>
> > >>> Signed-off-by: Marek Vasut <marex@denx.de>
> > >>> ---
> > >>> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> > >>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> > >>> Cc: Chris Morgan <macromorgan@hotmail.com>
> > >>> Cc: Dragan Simic <dsimic@manjaro.org>
> > >>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> > >>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > >>> Cc: Jagan Teki <jagan@amarulasolutions.com>
> > >>> Cc: Jonas Karlman <jonas@kwiboo.se>
> > >>> Cc: Kever Yang <kever.yang@rock-chips.com>
> > >>> Cc: Kostya Porotchkin <kostap@marvell.com>
> > >>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > >>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > >>> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> > >>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > >>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > >>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > >>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > >>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > >>> Cc: Sam Day <me@samcday.com>
> > >>> Cc: Simon Glass <sjg@chromium.org>
> > >>> Cc: Sumit Garg <sumit.garg@linaro.org>
> > >>> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > >>> Cc: Thierry Reding <treding@nvidia.com>
> > >>> Cc: Tom Rini <trini@konsulko.com>
> > >>> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> > >>> Cc: u-boot-amlogic@groups.io
> > >>> Cc: u-boot-qcom@groups.io
> > >>> Cc: u-boot@dh-electronics.com
> > >>> Cc: u-boot@lists.denx.de
> > >>> Cc: uboot-stm32@st-md-mailman.stormreply.com
> > >>> ---
> > >>>   drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++--=
-----
> > >>>   1 file changed, 15 insertions(+), 7 deletions(-)
> > >>>
> > >>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/p=
ower/regulator/regulator-uclass.c
> > >>> index 66fd531da04..ccc4ef33d83 100644
> > >>> --- a/drivers/power/regulator/regulator-uclass.c
> > >>> +++ b/drivers/power/regulator/regulator-uclass.c
> > >>> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *=
dev)
> > >>>          const char *property =3D "regulator-name";
> > >>>
> > >>>          uc_pdata =3D dev_get_uclass_plat(dev);
> > >>> +       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-alway=
s-on");
> > >>> +       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on=
");
> > >>>
> > >>>          /* Regulator's mandatory constraint */
> > >>>          uc_pdata->name =3D dev_read_string(dev, property);
> > >>> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice=
 *dev)
> > >>>                          return -EINVAL;
> > >>>          }
> > >>>
> > >>> -       if (regulator_name_is_unique(dev, uc_pdata->name))
> > >>> -               return 0;
> > >>> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> > >>> +               debug("'%s' of dev: '%s', has nonunique value: '%s\=
n",
> > >>> +                     property, dev->name, uc_pdata->name);
> > >>> +               return -EINVAL;
> > >>> +       }
> > >>>
> > >>> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> > >>> -             property, dev->name, uc_pdata->name);
> > >>> +       /*
> > >>> +        * In case the regulator has regulator-always-on or
> > >>> +        * regulator-boot-on DT property, trigger probe() to
> > >>> +        * configure its default state during startup.
> > >>> +        */
> > >>> +       if (uc_pdata->always_on && uc_pdata->boot_on)
> > >>> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> > >>>
> > >>> -       return -EINVAL;
> > >>> +       return 0;
> > >>>   }
> > >>>
> > >>>   static int regulator_pre_probe(struct udevice *dev)
> > >>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *=
dev)
> > >>>                                                  -ENODATA);
> > >>>          uc_pdata->max_uA =3D dev_read_u32_default(dev, "regulator-=
max-microamp",
> > >>>                                                  -ENODATA);
> > >>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-alway=
s-on");
> > >>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on=
");
> > >>>          uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "regula=
tor-ramp-delay",
> > >>>                                                      0);
> > >>>          uc_pdata->force_off =3D dev_read_bool(dev, "regulator-forc=
e-boot-off");
> > >>> --
> > >>> 2.43.0
> > >>>
> > >>
> > >> This is reading a lot of DT stuff very early, which may be slow. It =
is
> > >> also reading from the DT in the bind() step which we sometimes have =
to
> > >> do, but try to avoid.
> > >
> > >Could we set up the livetree pre-bind? What about MMU? On armv8 at lea=
st this would have a huge impact on performance. I've done some measurement=
s and there is at least 1 order of magnitude difference between parsing FDT=
 with no caches vs parsing livetree with, it's huge.
> > >>
> > >> Also this seems to happen in SPL and again pre-reloc and again in
> > >> U-Boot post-reloc?
> >
> > Not so long ago I proposed a similar patchset with the same goal
> > and I have discovered massive issues with SPL and relocation
> > interfering with driver loading.
> >
> > The issue which I have personally encountered was i2c driver failure
> > due to double probing. This behavior was triggered by
> > always-on/boot-on regulators provided by pmic which in most
> > cases is an i2c device.
> >
> > At that time everyone just ignored me, so idk if tegra i2c is the only
> > driver which has this response or there are more, but be aware that
> > this patch set may cause cascade failure on many devices.
>
> I'm not sure if I remember this, but I can certainly see some problems
> with it. Did we have drivers that probed in the bind() function,
> perhaps?
>

It is expected not to remember all patchsets sent, not an issue. As for
drivers probed after bind there are several, but they are quite essential.
Core GPIO and pinmux drivers are probed as early as possible but in most
cases they have no dependencies among complex subsystems (like i2c).

> >
> > Best regards,
> > Svyatoslav R.
> >
> > >>
> > >> Should we have a step in the init sequence where we set up the
> > >> regulators, by calling regulators_enable_boot_on() ?
> > >>
> > >> Regards,
> > >> Simon
> > >

