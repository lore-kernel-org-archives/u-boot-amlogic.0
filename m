Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60554C3065E
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:15 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.5238.1719485576537609319
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Jun 2024 03:52:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=SBsTSbvp;
 spf=pass (domain: chromium.org, ip: 209.85.219.46, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b4fe2c79fdso32773186d6.0
        for <u-boot-amlogic@groups.io>; Thu, 27 Jun 2024 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719485575; x=1720090375; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY84K82fkGTAVmr5h4lYCawi3o86p4wLkfu1ffHu034=;
        b=SBsTSbvpZP60EQKIqu+BwDoswl7kCUJKA6wPDxL3N7PORhj2jd8rrclKUUp6YF1+8m
         AWMkUcPXUqsvTLH6H4sez/Rp0FaOoIE2v4y4qHD0Z0eit7yugjF/uC8cE91/b8fdap5z
         mnNu5hzyl1Vk+caMydvkmmJGMmCLAnLV6YKLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485575; x=1720090375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY84K82fkGTAVmr5h4lYCawi3o86p4wLkfu1ffHu034=;
        b=VdjsPwv8H4jgLZrC6YXmgBR9fW18KZwRr9oklEny8C1qU0qlMizE5XIbo7NuPF8td5
         413wwHzmXpMh+WR0FYL9Ay1b8gUjwl1F++DJUjcJOjeoBgkJtsDc2FJtFP6eTyw/qfQB
         ybNq7oE2s4dwAawJHztNTZpyjyTjPCkJnJAX+ZOvYlJuNNNSDk+pkKxBQeoftKDDc6Uc
         wbyo2lLbMTu9+8W3bT5/Aw5uodZqFJyEDgzvi0JTI1xtHKbb9IJAtBSx/l5CRi4q70rL
         7FjaLEZowtlkAZ3v49J6SfxQW+nknyQpYy/tnlW2Ui6+HrAtnJeqsPHbxMqdOQ6Md8k6
         t+OA==
X-Forwarded-Encrypted: i=1; AJvYcCUthjX6HcGBwnZkBxJWTnfenVBypkyKjxSS1LK8bMS6HoKo4YAoc4ucpVkiV4qiXHR9mZiUPZYNTE2TzqO1ayHGGEl2voCYnqo=
X-Gm-Message-State: AOJu0Yx4OZqOZxihybhAChdnNXv8lvQIJRZdo2zY45mjoE9Z+2MEkfm3
	dqTkVu+ZHy5qhvNWmGYpUP/YrXqR3e0x/IcKvtEE/3UZm1Q95XarryKij3zgrtFAj/nuaeG653f
	+xuHIx6+JNESatApErfXZ/JCpNtBvZmYcfz+F
X-Google-Smtp-Source: AGHT+IGYeT6b4Yx8ko/Y1+YqUIHhM2ryJjAEE2ncLfVl5cwyKVEStDiPyZPGtwkPBT7R00MbD6dgx45zZrRaB0L9/i8=
X-Received: by 2002:a0c:ca0a:0:b0:6b2:cf90:8b7 with SMTP id
 6a1803df08f44-6b53bcd223emr135416436d6.23.1719485575607; Thu, 27 Jun 2024
 03:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org> <96AEFD59-B8D3-4298-8867-E94D474E16BE@gmail.com>
 <CAFLszTgvEkunWE8apORsK0+PU7wjrWCVCR0F1qij=yo8nDLUNg@mail.gmail.com> <CAPVz0n0ySK1YrE_Y_jSMm5WxG_b6Kc9PiXp2mMC0i7pwSWkFRQ@mail.gmail.com>
In-Reply-To: <CAPVz0n0ySK1YrE_Y_jSMm5WxG_b6Kc9PiXp2mMC0i7pwSWkFRQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 11:52:44 +0100
Message-ID: <CAFLszTgzdbjv8nDHjSYvquU2sEf-C5DUoZxmJ06xy9EsDhwYyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2338

Hi Svyatoslav,

On Thu, 27 Jun 2024 at 11:34, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D1=87=D1=82, 27 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE 12=
:26 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > On Thu, 27 Jun 2024 at 10:09, Svyatoslav <clamor95@gmail.com> wrote:
> > >
> > >
> > >
> > > 27 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 11:48:46=
 GMT+03:00, Caleb Connolly <caleb.connolly@linaro.org> =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> > > >
> > > >
> > > >On 27/06/2024 10:37, Simon Glass wrote:
> > > >> Hi Marek,
> > > >>
> > > >> On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
> > > >>>
> > > >>> In case a regulator DT node contains regulator-always-on or regul=
ator-boot-on
> > > >>> property, make sure the regulator gets correctly configured by U-=
Boot on start
> > > >>> up. Unconditionally probe such regulator drivers. This is a prepa=
ratory patch
> > > >>> for introduction of .regulator_post_probe() which would trigger t=
he regulator
> > > >>> configuration.
> > > >>>
> > > >>> Parsing of regulator-always-on and regulator-boot-on DT property =
has been
> > > >>> moved to regulator_post_bind() as the information is required ear=
ly, the
> > > >>> rest of the DT parsing has been kept in regulator_pre_probe() to =
avoid
> > > >>> slowing down the boot process.
> > > >>>
> > > >>> Signed-off-by: Marek Vasut <marex@denx.de>
> > > >>> ---
> > > >>> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> > > >>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> > > >>> Cc: Chris Morgan <macromorgan@hotmail.com>
> > > >>> Cc: Dragan Simic <dsimic@manjaro.org>
> > > >>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> > > >>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > >>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > >>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > > >>> Cc: Jagan Teki <jagan@amarulasolutions.com>
> > > >>> Cc: Jonas Karlman <jonas@kwiboo.se>
> > > >>> Cc: Kever Yang <kever.yang@rock-chips.com>
> > > >>> Cc: Kostya Porotchkin <kostap@marvell.com>
> > > >>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > > >>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > > >>> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> > > >>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > > >>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > >>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > >>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > > >>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > > >>> Cc: Sam Day <me@samcday.com>
> > > >>> Cc: Simon Glass <sjg@chromium.org>
> > > >>> Cc: Sumit Garg <sumit.garg@linaro.org>
> > > >>> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > > >>> Cc: Thierry Reding <treding@nvidia.com>
> > > >>> Cc: Tom Rini <trini@konsulko.com>
> > > >>> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> > > >>> Cc: u-boot-amlogic@groups.io
> > > >>> Cc: u-boot-qcom@groups.io
> > > >>> Cc: u-boot@dh-electronics.com
> > > >>> Cc: u-boot@lists.denx.de
> > > >>> Cc: uboot-stm32@st-md-mailman.stormreply.com
> > > >>> ---
> > > >>>   drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++=
-------
> > > >>>   1 file changed, 15 insertions(+), 7 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers=
/power/regulator/regulator-uclass.c
> > > >>> index 66fd531da04..ccc4ef33d83 100644
> > > >>> --- a/drivers/power/regulator/regulator-uclass.c
> > > >>> +++ b/drivers/power/regulator/regulator-uclass.c
> > > >>> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice=
 *dev)
> > > >>>          const char *property =3D "regulator-name";
> > > >>>
> > > >>>          uc_pdata =3D dev_get_uclass_plat(dev);
> > > >>> +       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-alw=
ays-on");
> > > >>> +       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-=
on");
> > > >>>
> > > >>>          /* Regulator's mandatory constraint */
> > > >>>          uc_pdata->name =3D dev_read_string(dev, property);
> > > >>> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevi=
ce *dev)
> > > >>>                          return -EINVAL;
> > > >>>          }
> > > >>>
> > > >>> -       if (regulator_name_is_unique(dev, uc_pdata->name))
> > > >>> -               return 0;
> > > >>> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> > > >>> +               debug("'%s' of dev: '%s', has nonunique value: '%=
s\n",
> > > >>> +                     property, dev->name, uc_pdata->name);
> > > >>> +               return -EINVAL;
> > > >>> +       }
> > > >>>
> > > >>> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> > > >>> -             property, dev->name, uc_pdata->name);
> > > >>> +       /*
> > > >>> +        * In case the regulator has regulator-always-on or
> > > >>> +        * regulator-boot-on DT property, trigger probe() to
> > > >>> +        * configure its default state during startup.
> > > >>> +        */
> > > >>> +       if (uc_pdata->always_on && uc_pdata->boot_on)
> > > >>> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> > > >>>
> > > >>> -       return -EINVAL;
> > > >>> +       return 0;
> > > >>>   }
> > > >>>
> > > >>>   static int regulator_pre_probe(struct udevice *dev)
> > > >>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice=
 *dev)
> > > >>>                                                  -ENODATA);
> > > >>>          uc_pdata->max_uA =3D dev_read_u32_default(dev, "regulato=
r-max-microamp",
> > > >>>                                                  -ENODATA);
> > > >>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-alw=
ays-on");
> > > >>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-=
on");
> > > >>>          uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "regu=
lator-ramp-delay",
> > > >>>                                                      0);
> > > >>>          uc_pdata->force_off =3D dev_read_bool(dev, "regulator-fo=
rce-boot-off");
> > > >>> --
> > > >>> 2.43.0
> > > >>>
> > > >>
> > > >> This is reading a lot of DT stuff very early, which may be slow. I=
t is
> > > >> also reading from the DT in the bind() step which we sometimes hav=
e to
> > > >> do, but try to avoid.
> > > >
> > > >Could we set up the livetree pre-bind? What about MMU? On armv8 at l=
east this would have a huge impact on performance. I've done some measureme=
nts and there is at least 1 order of magnitude difference between parsing F=
DT with no caches vs parsing livetree with, it's huge.
> > > >>
> > > >> Also this seems to happen in SPL and again pre-reloc and again in
> > > >> U-Boot post-reloc?
> > >
> > > Not so long ago I proposed a similar patchset with the same goal
> > > and I have discovered massive issues with SPL and relocation
> > > interfering with driver loading.
> > >
> > > The issue which I have personally encountered was i2c driver failure
> > > due to double probing. This behavior was triggered by
> > > always-on/boot-on regulators provided by pmic which in most
> > > cases is an i2c device.
> > >
> > > At that time everyone just ignored me, so idk if tegra i2c is the onl=
y
> > > driver which has this response or there are more, but be aware that
> > > this patch set may cause cascade failure on many devices.
> >
> > I'm not sure if I remember this, but I can certainly see some problems
> > with it. Did we have drivers that probed in the bind() function,
> > perhaps?
> >
>
> It is expected not to remember all patchsets sent, not an issue. As for
> drivers probed after bind there are several, but they are quite essential=
.
> Core GPIO and pinmux drivers are probed as early as possible but in most
> cases they have no dependencies among complex subsystems (like i2c).

OK, well I suppose that you managed to find a solution.

From my side I just want to avoid doing too much such stuff
'automatically' in driver model. As you say, it can lead to difficult
race conditions / bugs.

Regards,
Simon

