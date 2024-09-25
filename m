Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB8DCF64A9
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:31 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.12397.1727259552048181687
 for <u-boot-amlogic@groups.io>;
 Wed, 25 Sep 2024 03:19:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GEn5ICXF;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: clamor95@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so61164565e9.3;
        Wed, 25 Sep 2024 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727259550; x=1727864350; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pA5toJNQNJuuGd/24/pddJUq7vLn7UArYhmC2gfKFA=;
        b=GEn5ICXF8SjnFf2iQ0HIAMlMesq27cSAvumsv9fST0mj/Rdc5k700xmk+c9nq+kb9V
         xnyohXysxd6CMB9r4xV3SpO64C/wAzbiJLKgtwJnb9a0pCtLWYHpG4jpgVvNMNhPShQX
         aWG6d62cQOLax6nzxBj4FXMmLbNPp43mtvWw47Qw786aDGbf2SHLvN5MwKGL1T8NdO1H
         6VETMnlWzuyBGKzHCoSMsHGnQxBg5ldAiouRvLFS985hphAWZw57Ua7apUXtYjvCXvXZ
         DKRV1eOkR4wOF5gzbQ5b00xBUAZSiMCJeV0DC19HObGQcwBLl+bT7HE0hb0kAJNXCc6h
         +5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727259550; x=1727864350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pA5toJNQNJuuGd/24/pddJUq7vLn7UArYhmC2gfKFA=;
        b=tVNHyiCWfLDF4Y7Ae0in9LDG9pYYBlFCzGMFHa2p51MiKBF4wHHu/2HRvPxzv7+jW0
         ocpAUsvxJZmO7g2WR2wDXOKzT+G08ZXlCUReM2Bp0OBeJmnBtYRZBeYDndTnMqftCpDb
         rNCbwD7pZPz3TXz1B87UHPaLqKOfkOZv9StZyOxYiNz5eOSS3RTD3dH/pmny55UH080l
         pJEUZxYDOPqTrD3uOxr3bgHIQeUyxuATDw9zk4VyyofquvP4k/OVxzi9y258xQb1lnee
         AVQdr70dTqAQrJWJ9JJuwC9CAjmg3U0qlx7EojLBz1T+3a1ERiYrvk9NEl4IeNbXdmBS
         rLhg==
X-Forwarded-Encrypted: i=1; AJvYcCVIgNva5+aFXqJEvqzdSUnr/pbX512AyWc+4UpZsUv+GlbnXLOO8anicLaM32E3HRr7CafgEJNSn61bNH4=@groups.io, AJvYcCXqCM2Zx8aYySvxXccMUQNbD3lFdJRct+10YJ/xwg/sNIyGd2eXb3J7mCfvjAtbgQniv7iOrW35zpPR4y8OMg==@groups.io
X-Gm-Message-State: AOJu0YyYpxynwpuQoI7T7NnMyKLtz1TVbCmtQOYtuOXCBqcd6YG6Sov2
	08p5oQhlNHwkMzzxhJ0j8oXwAYS+lr9pMgwrsogb/Qbt2MlFYnJzI5SM3uXEeKhlOOTZixAG4oD
	hJDxrRiumGMzjVsNzbtEgCVbrTv4=
X-Google-Smtp-Source: AGHT+IHbyGfTNKPntYM4HqagP6cKcV+xcoxCkim61wL4RPaiNfyr3kXHYNgshVf9TXwbsZDmyS11XMqhxwZ44FlShpA=
X-Received: by 2002:adf:c083:0:b0:371:8319:4dcc with SMTP id
 ffacd0b85a97d-37cc2462b44mr1579305f8f.2.1727259549772; Wed, 25 Sep 2024
 03:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de> <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de> <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat> <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
 <20240920164856.GI4252@bill-the-cat> <20240924234406.GX4252@bill-the-cat>
In-Reply-To: <20240924234406.GX4252@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 25 Sep 2024 13:18:58 +0300
Message-ID: <CAPVz0n09xf42O1X7QBO8nraDV86EEUOdw+S7qZdr327v0gcQ1A@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
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
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2405

=D1=81=D1=80, 25 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 02:44 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Sep 20, 2024 at 10:48:56AM -0600, Tom Rini wrote:
> > On Fri, Sep 20, 2024 at 07:40:35PM +0300, Svyatoslav Ryhel wrote:
> > > =D0=BF=D0=BD, 16 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 19:2=
8 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Wed, Sep 11, 2024 at 07:00:56PM -0600, Simon Glass wrote:
> > > > > Hi Marek,
> > > > >
> > > > > On Fri, 28 Jun 2024 at 07:26, Marek Vasut <marex@denx.de> wrote:
> > > > > >
> > > > > > On 6/28/24 9:32 AM, Simon Glass wrote:
> > > > > > > Hi Marek,
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > >>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct =
udevice *dev)
> > > > > > >>>>                                                   -ENODATA=
);
> > > > > > >>>>           uc_pdata->max_uA =3D dev_read_u32_default(dev, "=
regulator-max-microamp",
> > > > > > >>>>                                                   -ENODATA=
);
> > > > > > >>>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regula=
tor-always-on");
> > > > > > >>>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulato=
r-boot-on");
> > > > > > >>>>           uc_pdata->ramp_delay =3D dev_read_u32_default(de=
v, "regulator-ramp-delay",
> > > > > > >>>>                                                       0);
> > > > > > >>>>           uc_pdata->force_off =3D dev_read_bool(dev, "regu=
lator-force-boot-off");
> > > > > > >>>> --
> > > > > > >>>> 2.43.0
> > > > > > >>>>
> > > > > > >>>
> > > > > > >>> This is reading a lot of DT stuff very early, which may be =
slow. It is
> > > > > > >>> also reading from the DT in the bind() step which we someti=
mes have to
> > > > > > >>> do, but try to avoid.
> > > > > > >>
> > > > > > >> Actually, it is reading only the bare minimum very early in =
bind, the
> > > > > > >> always-on and boot-on, the rest is in pre_probe, i.e. later.
> > > > > > >
> > > > > > > Yes, I see that. Also it is inevitable that these properties =
need to
> > > > > > > be read before probe(), since they control whether to probe()=
.
> > > > > > >
> > > > > > >>
> > > > > > >>> Also this seems to happen in SPL and again pre-reloc and ag=
ain in
> > > > > > >>> U-Boot post-reloc?
> > > > > > >>
> > > > > > >> What does, the uclass post_bind ?
> > > > > > >
> > > > > > > I mean that this code will be called in SPL (if the regulator=
s are in
> > > > > > > the DT there), U-Boot pre-reloc and post-reloc, each time tur=
ning on
> > > > > > > the regulators. We need a way to control that, don't we?
> > > > > >
> > > > > > I would assume that if those regulators are turned on once in t=
he
> > > > > > earliest stage , turning them on again in the follow up stage w=
ould be a
> > > > > > noop ? This is the point of regulator-*-on, to keep the regulat=
ors on.
> > > > >
> > > > > No, there is sometimes a particular sequence needed.
> > > > >
> > > > > >
> > > > > > >>> Should we have a step in the init sequence where we set up =
the
> > > > > > >>> regulators, by calling regulators_enable_boot_on() ?
> > > > > > >>
> > > > > > >> Let's not do this , the entire point of this series is to ge=
t rid of
> > > > > > >> those functions and do the regulator configuration the same =
way LED
> > > > > > >> subsystem does it -- by probing always-on/boot-on regulators=
 and
> > > > > > >> configuring them correctly on probe.
> > > > > > >>
> > > > > > >> To me regulators_enable_boot_on() and the like was always an
> > > > > > >> inconsistently applied workaround for missing DM_FLAG_PROBE_=
AFTER_BIND ,
> > > > > > >> which is now implemented, so such workarounds can be removed=
.
> > > > > > >
> > > > > > > That patch seemed to slip under the radar, sent and applied o=
n the
> > > > > > > same day! We really need to add a test for it, BTW.
> > > > > >
> > > > > > Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was t=
hat it
> > > > > > took a while to get in.
> > > > >
> > > > > [1]
> > > > >
> > > > > >
> > > > > > > My concern is that this might cause us ordering problems. We =
perhaps
> > > > > > > want the regulators to be done first. If drivers are probed w=
hich use
> > > > > > > regulators, then presumably they will enable them. Consider t=
his:
> > > > > > >
> > > > > > > - LED driver auto-probes
> > > > > > >     - probes I2C bus 2
> > > > > > >     - probes LDO1 which is autoset so turns on
> > > > > > > - LDO1 probes, but is already running
> > > > > > > - LDO2 probes, which is autoset so turns on
> > > > > > >
> > > > > > > So long as it is OK to enable the regulators in any order, th=
en this
> > > > > > > seems fine. But is it? How do we handle the case where are pa=
rticular
> > > > > > > sequence is needed?
> > > > > >
> > > > > > Did we finally arrive at the point where we need -EPROBE_DEFER =
alike
> > > > > > mechanism ?
> > > > >
> > > > > Nope. But I am concerned that this patch is leading us there. bin=
d()
> > > > > really needs to be as clean as possible. It is one of the design
> > > > > elements of driver model which Linux should adopt.
> > > > >
> > > > > There is always a race to be the first to init something, move th=
e
> > > > > init earlier, etc... I don't see any general need to init the
> > > > > regulators right at the start. It should be done in a separate
> > > > > function and be optional. I am happy to send a patch if you like.
> > > >
> > > > Since we're currently stuck on the point where Marek has patches th=
at
> > > > fix a real problem, and Svyatoslav has a problem with them, but isn=
't
> > > > currently able to debug it, yes, please put forward your patch that
> > > > might address both sets of problems so we can all figure out how to
> > > > resolve the problems, thanks!
> > >
> > > With patches from Marek there is no i2c chip probe of PMIC, while
> > > without i2c chip probe is called (probe_chip function). How this is
> > > even possible?
> >
> > Yes, it's very puzzling. Do you have the ability to get some debug
> > console type information out so you can sprinkle in some prints and
> > figure it out?
>
> So, here's my plan. Marek posted
> https://patchwork.ozlabs.org/project/uboot/patch/20240924220905.514122-1-=
marex@denx.de/
> which is a work-around, so that v2024.10 can work. I'm going to take
> that for master tomorrow. I'm also going to take _this_ series to -next
> tomorrow, as this is the best approach we currently have to solving the
> overall problem. The Tegra platforms that are now very oddly broken need
> to get debugged to see where their problem is, and if there's an
> entirely alternate approach, Simon can post patches for that instead on
> top of next.
>
> --
> Tom

Hello there!
I was digging this when I had some free time and found that with
patches from Marek the only difference is that function
i2c_get_chip_for_busnum is not called for PMIC's main i2c address
which results in issues with i2c you have seen in logs before. I
assume this is not a tegra specific issue and not even related to
these regulator patches itself.

To verify my suspicions, Tom and Marek my you please dump u-boot log
with and without patches and with enabled debug logging from
i2c-uclass and i2c driver of your SoC.

Here are logs from my device (Tegra SoC)

Not working
(bootloader) i2c: controller bus 0 at 7000d000, speed 0:
i2c_init_controller: speed=3D400000
(bootloader) i2c_init_controller: CLK_DIV_STD_FAST_MODE setting =3D 25
(bootloader) i2c_get_chip: Searching bus 'i2c@7000d000' for address 59:
(bootloader) not found
(bootloader) pmic_reg_read: reg=3D37 priv->trans_len:1i2c_xfer: 2 messages
(bootloader)
(bootloader) i2c_xfer: chip=3D0x58, len=3D0x1
(bootloader) i2c_write_data: chip=3D0x58, len=3D0x1
(bootloader) write_data:  0x37
(bootloader) pkt header 1 sent (0x10010)
(bootloader) pkt header 2 sent (0x0)
(bootloader) pkt header 3 sent (0x100b0)
(bootloader) pkt data sent (0x37)
(bootloader) tegra_i2c_write_data: Error (-1) !!!

Working
(bootloader) i2c: controller bus 0 at 7000d000, speed 0:
i2c_init_controller: speed=3D400000
(bootloader) i2c_init_controller: CLK_DIV_STD_FAST_MODE setting =3D 25
(bootloader) pkt header 1 sent (0x10010)
(bootloader) pkt header 2 sent (0x0)
(bootloader) pkt header 3 sent (0xb0)
(bootloader) pkt data sent (0x0)
(bootloader) i2c_get_chip: Searching bus 'i2c@7000d000' for address 58:
(bootloader) i2c_get_chip: Searching bus 'i2c@7000d000' for address 59:
(bootloader) not found
(bootloader) found, ret=3D0
(bootloader) i2c_xfer: 2 messages
(bootloader) i2c_xfer: chip=3D0x58, len=3D0x1
(bootloader) i2c_write_data: chip=3D0x58, len=3D0x1
(bootloader) write_data:  0xfb
(bootloader) pkt header 1 sent (0x10010)
(bootloader) pkt header 2 sent (0x0)
(bootloader) pkt header 3 sent (0x100b0)
(bootloader) pkt data sent (0xfb)
(bootloader) i2c_xfer: chip=3D0x58, len=3D0x1

As you can see this part

(bootloader) pkt header 1 sent (0x10010)
(bootloader) pkt header 2 sent (0x0)
(bootloader) pkt header 3 sent (0xb0)
(bootloader) pkt data sent (0x0)
(bootloader) i2c_get_chip: Searching bus 'i2c@7000d000' for address 58:

is missing in log from u-boot where Marek's patches are applied and
this log fragment co-responds to i2c_get_chip_for_busnum call

