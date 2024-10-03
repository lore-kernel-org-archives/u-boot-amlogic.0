Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62324D1A42C
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:00:52 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.13690.1727967947809426403
 for <u-boot-amlogic@groups.io>;
 Thu, 03 Oct 2024 08:05:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xaej9fi4;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: clamor95@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cae102702so8904805e9.0;
        Thu, 03 Oct 2024 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727967946; x=1728572746; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoZRjAzyLV42dbmh6tTvJFMzFGmTF2YZ8Chn0i6KVXc=;
        b=Xaej9fi4XRKeknbJggzjVA0wKjHyE4k47RFG1wO2WSqdv8acm24go9MnqDT94HYghY
         8ztToFohs9+pyhMWjrHPmFLpZ0qPPow+DJkYMYxWjcB180P6ZSxRe5e6sS7w4SXa/h2x
         ncNNrq8PYGIt86eZA2oNM6fctaKgGtzghagCaJ1xoMOaCjwy51mkoV5i0/e7pNOnCDwG
         3TvdS/Ix6sh8PvM803H3NgQvbz9HdGrYDb7ONpzqW7VA1FzKTCAKELbG3yuENZ7zhIuz
         3T7PeiqRJRoGOQ/C+AgTxFlanPxJGvdDtekUk0hvrgrHKKL+YltGK3ftjihZUmGf4od6
         1mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967946; x=1728572746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoZRjAzyLV42dbmh6tTvJFMzFGmTF2YZ8Chn0i6KVXc=;
        b=kKB+KmaxLA5FVFaXJggP/SCaHqLyQnxwUCcNBa0Zvv7Gc2legA8IvZZZ7cQ1VBKW7S
         698Y77kv2OwX1pTKbKjWlNLYFtHUtMd0lIGAx9VBBE3X0jtADJ0R3dyjfXEmqUpoWBAr
         mF9+q2KRUeb6dPuXtoc+MPHHLnZGhDEFQAILXAc2pcovCs4X6y1G6o5K0jqyPgL5SbHJ
         9a6k3ByYN7O1GPlhBRK5IO/2R4x97ydU9xcFJtMFfBv6W9UTqD7BiaZssdnxDLji951Z
         BnFPEECRFq1Ff/sc3u1THOEHEPOV7GEtDGPnoRzKl1MGTaVaOYGCckfAlDg4nOeMifCb
         U0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1t7IgGNWKlspgmwkOx3xa4oM6s5znnzVAl3dLVpmywXXX9Af+88RDBatEbmjZOuTbFJ8u2FcDL0J2vQA=@groups.io, AJvYcCWC6o0wM9ZYbioLbWrZuDC8Iv1wAJyjAjB9QSLNGx903Ve6ucLbQvemndAq8JULYOWDo/Pm/pmh0CkyMkGSbA==@groups.io
X-Gm-Message-State: AOJu0YzOKxWUtpZw9wGdlfabPNRm8EPQw4BRgAJa9zx3ZZPoll5+8gi4
	6OFrfWlCSYc8VwIAeUEkOTm7MVab8HMtFoaAWGmukFFpCbwRoZ1NehR6v7GOa73D91qNs2tOUYt
	siTuC1BeKjIPKmfsSd2/9HNWfo1A=
X-Google-Smtp-Source: AGHT+IEcWJVWS1+erVM/jK6NIxwluKOTR0nUIOM/eO87CBIT8x35AE6ERRCWn2cnBAT1y7GDHEQycP6dPqqpTPLWIII=
X-Received: by 2002:a5d:5585:0:b0:374:ca16:e09b with SMTP id
 ffacd0b85a97d-37cfb8b5735mr3777463f8f.9.1727967945859; Thu, 03 Oct 2024
 08:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240926231457.2933914-1-marex@denx.de> <20240926231457.2933914-2-marex@denx.de>
 <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com>
 <20241003014042.GS4737@bill-the-cat> <CAFLszTiawdOfoMx-ZmMLW77dBS11WWVpWHNF-KfPi86xEJB+rQ@mail.gmail.com>
In-Reply-To: <CAFLszTiawdOfoMx-ZmMLW77dBS11WWVpWHNF-KfPi86xEJB+rQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 3 Oct 2024 18:05:34 +0300
Message-ID: <CAPVz0n0dYu7pbvEef6zEMrgKHyiRX-DYmD2bxuSVB3p+rrjJjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] power: regulator: Convert regulators_enable_boot_on/off() to regulator_post_probe
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
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
	Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
	u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
	uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:00:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2460

=D1=87=D1=82, 3 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 18:03=
 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Tom,
>
> On Wed, 2 Oct 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 02, 2024 at 04:55:39PM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On Thu, 26 Sept 2024 at 17:15, Marek Vasut <marex@denx.de> wrote:
> > > >
> > > > Turn regulators_enable_boot_on() and regulators_enable_boot_off() i=
nto
> > > > empty functions. Implement matching functionality in regulator_post=
_probe()
> > > > instead. The regulator_post_probe() is called for all regulators af=
ter they
> > > > probe, and regulators that have regulator-always-on or regulator-bo=
ot-on DT
> > > > properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being s=
et on
> > > > such regulators in regulator_post_bind().
> > > >
> > > > Finally, fold regulator_unset() functionality into regulator_autose=
t().
> > > >
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > ---
> > > > Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> > > > Cc: Caleb Connolly <caleb.connolly@linaro.org>
> > > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > > Cc: Dragan Simic <dsimic@manjaro.org>
> > > > Cc: Eugen Hristev <eugen.hristev@collabora.com>
> > > > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > > > Cc: Jagan Teki <jagan@amarulasolutions.com>
> > > > Cc: Jonas Karlman <jonas@kwiboo.se>
> > > > Cc: Kever Yang <kever.yang@rock-chips.com>
> > > > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > > > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > > > Cc: Max Krummenacher <max.krummenacher@toradex.com>
> > > > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > > Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > > > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > > > Cc: Sam Day <me@samcday.com>
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Cc: Thierry Reding <treding@nvidia.com>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> > > > Cc: u-boot-amlogic@groups.io
> > > > Cc: u-boot-qcom@groups.io
> > > > Cc: u-boot@dh-electronics.com
> > > > Cc: u-boot@lists.denx.de
> > > > Cc: uboot-stm32@st-md-mailman.stormreply.com
> > > > ---
> > > > V2: Rebase on current u-boot/next
> > > > V3: No change
> > > > ---
> > > >  drivers/power/regulator/regulator-uclass.c | 60 +++++++-----------=
----
> > > >  1 file changed, 19 insertions(+), 41 deletions(-)
> > > >
> > > > diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/p=
ower/regulator/regulator-uclass.c
> > > > index 1a970004540..9fcc4bd85b9 100644
> > > > --- a/drivers/power/regulator/regulator-uclass.c
> > > > +++ b/drivers/power/regulator/regulator-uclass.c
> > > > @@ -314,6 +314,11 @@ int regulator_autoset(struct udevice *dev)
> > > >                         return ret;
> > > >         }
> > > >
> > > > +       if (uc_pdata->force_off) {
> > > > +               ret =3D regulator_set_enable(dev, false);
> > > > +               goto out;
> > > > +       }
> > > > +
> > > >         if (!uc_pdata->always_on && !uc_pdata->boot_on) {
> > > >                 ret =3D -EMEDIUMTYPE;
> > > >                 goto out;
> > > > @@ -518,56 +523,28 @@ static int regulator_pre_probe(struct udevice=
 *dev)
> > > >         return 0;
> > > >  }
> > > >
> > > > -int regulators_enable_boot_on(bool verbose)
> > > > +static int regulator_post_probe(struct udevice *dev)
> > > >  {
> > > > -       struct udevice *dev;
> > > > -       struct uclass *uc;
> > > >         int ret;
> > > >
> > > > -       ret =3D uclass_get(UCLASS_REGULATOR, &uc);
> > > > -       if (ret)
> > > > +       ret =3D regulator_autoset(dev);
> > > > +       if (ret && ret !=3D -EMEDIUMTYPE && ret !=3D -EALREADY && r=
et !=3D ENOSYS)
> > > >                 return ret;
> > > > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > > > -            dev;
> > > > -            uclass_next_device(&dev)) {
> > > > -               ret =3D regulator_autoset(dev);
> > > > -               if (ret =3D=3D -EMEDIUMTYPE || ret =3D=3D -EALREADY=
) {
> > > > -                       ret =3D 0;
> > > > -                       continue;
> > > > -               }
> > > > -               if (verbose)
> > > > -                       regulator_show(dev, ret);
> > > > -               if (ret =3D=3D -ENOSYS)
> > > > -                       ret =3D 0;
> > > > -       }
> > > >
> > > > -       return ret;
> > > > +       if (_DEBUG)
> > > > +               regulator_show(dev, ret);
> > > > +
> > > > +       return 0;
> > > >  }
> > > >
> > > > -int regulators_enable_boot_off(bool verbose)
> > > > +int regulators_enable_boot_on(bool verbose)
> > > >  {
> > > > -       struct udevice *dev;
> > > > -       struct uclass *uc;
> > > > -       int ret;
> > > > -
> > > > -       ret =3D uclass_get(UCLASS_REGULATOR, &uc);
> > > > -       if (ret)
> > > > -               return ret;
> > > > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > > > -            dev;
> > > > -            uclass_next_device(&dev)) {
> > > > -               ret =3D regulator_unset(dev);
> > > > -               if (ret =3D=3D -EMEDIUMTYPE) {
> > > > -                       ret =3D 0;
> > > > -                       continue;
> > > > -               }
> > > > -               if (verbose)
> > > > -                       regulator_show(dev, ret);
> > > > -               if (ret =3D=3D -ENOSYS)
> > > > -                       ret =3D 0;
> > > > -       }
> > > > +       return 0;
> > > > +}
> > > >
> > > > -       return ret;
> > > > +int regulators_enable_boot_off(bool verbose)
> > > > +{
> > > > +       return 0;
> > > >  }
> > > >
> > > >  UCLASS_DRIVER(regulator) =3D {
> > > > @@ -575,5 +552,6 @@ UCLASS_DRIVER(regulator) =3D {
> > > >         .name           =3D "regulator",
> > > >         .post_bind      =3D regulator_post_bind,
> > > >         .pre_probe      =3D regulator_pre_probe,
> > > > +       .post_probe     =3D regulator_post_probe,
> > > >         .per_device_plat_auto   =3D sizeof(struct dm_regulator_ucla=
ss_plat),
> > > >  };
> > > > --
> > > > 2.45.2
> > > >
> > >
> > > I thought I objected to this patch, but it seems to be in -next? Does
> > > anyone know what has happened here?
> >
> > Yes, you missed me noting that this fixes real problems and has been
> > needing to be fixed for a while. I said you should provide your
> > alternative approach and we'll get this sorted out in -next and I took
> > the work-around for master so the release wouldn't be broken.
>
> OK ta. So long as we can revert/change that is fine.
>
> >
> > > I am seeing these errors now when running sandbox 'u-boot -D':
> > >
> > >        i2c_emul_find() No emulators for device 'sandbox_pmic'
> > >   sandbox_pmic_write() write error to device: 0000000018c49db0 regist=
er: 0x0!
> > >        out_set_value() PMIC write failed: -5
> > >        i2c_emul_find() No emulators for device 'sandbox_pmic'
> > >   sandbox_pmic_write() write error to device: 0000000018c49db0 regist=
er: 0x0!
> > >        out_set_value() PMIC write failed: -5
> >
> > I suppose the good news is that perhaps this is also related to the
> > problem that Svyatoslav was reporting.
>
> OK, I actually never fully understood the problem, but yes, sandbox is
> supposed to work similarly.
>
> Regards,
> Simon

Simon,

Please inform me when you come up with a solution, I would like to
test it. Thanks.

