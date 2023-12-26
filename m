Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F4C47DDE
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.web11.79640.1703586037336881239
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 02:20:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=EeVlFGsK;
 spf=pass (domain: linaro.org, ip: 209.85.217.49, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-466fe71b2c2so161224137.3
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 02:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703586036; x=1704190836; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwDh/R1uZbwZ2lOFQdSFxIywPwY7KDMNpmc4GOsCeVM=;
        b=EeVlFGsKma5bT5HP0FGWJp2dlXRuWhOgI2GEmpTdC8nMZAlPLp8099G0B+Xjm6R/TC
         UydP6+c5MDT/BuAmx6oK36fOL4VP/6pREGJ98a4OO+t1COmfGbsrj1vWckQBQN54o03T
         VEVhIXBepYtfQgpUTqAPEN4MzQoTK2846t4RlUIae6s2DfEuhazKCpInjcdi3mhgip2J
         Yd6zXezYW29klvjLPU7WcxuQO56yWuArOe9wzHmD5Vdx4HI9vDoUY3Ry76JjqQdYDrna
         Mxeg9PzLD/NqvP5zoGic2FutGORf/cEkiuJLVLaa65UFAp11q+Soc7p4nZJINuKizavg
         gz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703586036; x=1704190836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwDh/R1uZbwZ2lOFQdSFxIywPwY7KDMNpmc4GOsCeVM=;
        b=gDPT7wVOWJ3do3FNqrANw4ceskpqZKKHKKlPM8VHGUfWzQREvPGfRkS/VIoWp9ksr/
         jStU9cIgipQqQZe/JPHrLdnPPAG30QU0KOFnTH0e2ygy1KOlf1kTAEdR8/b/QtJS2mzr
         8D7FsMVIprfVZb6udyOybjfHkLCvzlrrXDRlXkHwKt5q22ALMkiHYyjf2eaRc7jDA1NF
         y8WawjhB6WlpgUvDn+UvYZlo7GbpCCW0WITJtZ7BJu1Jz1VbJnw9/qQTY2CDuPPhMvVf
         hJXzwnWd9620AB7X2qWKsaHTr73eTkCVyhiLQIT45lEoFYP+Mu4aqVsrEEmYdHpOCdY7
         3e6w==
X-Gm-Message-State: AOJu0YxDpJC+U/G3vdF2GzK1VCaoWvHin6qT9fEdfo8hgswUTMoPsWjP
	5QAfFc4b/VlmZSbzDmR8TQ7oYP/NPkXzn4B0NaqwxY9LNmjmcg==
X-Google-Smtp-Source: AGHT+IES95DXy7hQgwJRNGe0pyPLqExEonzw5FpjBcQ1aTbx/LQJBoPsoXTNR/EF+DMDG+XLWaASBJbBg0tgFW7BfQk=
X-Received: by 2002:a05:6102:e13:b0:465:ddb9:79f2 with SMTP id
 o19-20020a0561020e1300b00465ddb979f2mr2355985vst.24.1703586035721; Tue, 26
 Dec 2023 02:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-5-sumit.garg@linaro.org> <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
 <CAFA6WYMeLoD_z1W+iK3C6yj44dO_pdM71bhd6gK14gB==75gxw@mail.gmail.com> <CAFLszTgnOHQJGin-=32syDVPAkLXAni7QFd3WV_xtW0a2D84Bg@mail.gmail.com>
In-Reply-To: <CAFLszTgnOHQJGin-=32syDVPAkLXAni7QFd3WV_xtW0a2D84Bg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:50:23 +0530
Message-ID: <CAFA6WYO6Q9s0x+-N0XV+Hyw-07nuwR8ib9-p4=P15JHccb5avw@mail.gmail.com>
Subject: Re: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1973

On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Wed, Dec 20, 2023 at 12:01=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > Hi Simon,
> >
> > On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > > >
> > > > Allow platform owners to mirror devicetree files from devitree-reba=
sing
> > > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). =
Then
> > > > build then along with any *-u-boot.dtsi file present in arch/$(ARCH=
)/dts
> > > > directory.
> > >
> > > Also add a new Makefile for arm64.
> >
> > I suppose you are referring to dts/arch/arm64/Makefile which has been
> > added by this patch.
>
> Yes, I just mean that you should mention this in the commit message
>

Okay, I will append the commit message.

> >
> > >
> > > >
> > > > This will help easy migration for platforms which currently are com=
pliant
> > > > with upstream Linux kernel devicetree files.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  dts/Kconfig             | 11 +++++++++++
> > > >  dts/Makefile            | 17 ++++++++++++++---
> > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > >  create mode 100644 dts/arch/arm64/Makefile
> > > >
> > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > index 00c0aeff893..96396f12b67 100644
> > > > --- a/dts/Kconfig
> > > > +++ b/dts/Kconfig
> > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > >           enables a live tree which is available after relocation,
> > > >           and can be adjusted as needed.
> > > >
> > > > +config OF_UPSTREAM
> > > > +       bool "Enable use of devicetree imported from Linux kernel r=
elease"
> > > > +       help
> > > > +         Traditionally, U-boot platforms used to have their custom=
 devicetree
> > >
> > > U-Boot
> > >
> > > (I think I mentioned this, but you thought I said U-boot...but it
> > > really is U-Boot). Perhaps grep your patches next time.
> >
> > Ah, I see. It looks like I missed that bit, and will take care of it
> > in the next revision.
> >
> > >
> > > > +         files or copy devicetree files from Linux kernel which ar=
e hard to
> > > > +         maintain and can usually get out-of-sync from Linux kerne=
l. This
> > > > +         option enables platforms to migrate to devicetree-rebasin=
g repo where
> > > > +         a regular sync will be maintained every major Linux kerne=
l release
> > > > +         cycle. However, platforms can still have some custom u-bo=
ot specific
> > > > +         bits maintained as part of *-u-boot.dtsi files.
> > >
> > > I'm a bit nervous about this. It means that boards chose between this
> > > dir of the local files. It means there is some effort to switch.
> > >
> > > I wonder if we could default to using the rebasing thing, with boards
> > > having to 'opt out'? So this should be 'default y' ?
> >
> > Ideally that should be our migration path going forward once we get
> > enough boards migrated to use rebasing repo. But at this initial stage
> > we have to put some effort on migrating boards to use rebasing
> > subtree, although effort should be just adding (given DT bindings
> > compliance) following to defconfig (see patch #7):
> >
> > CONFIG_OF_UPSTREAM=3Dy
> > CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> >
> > and create a mirrored copy of:
> > ../../../devicetree-rebasing/src/arm64/amlogic/ into
> > dts/arch/arm64/amlogic/ with modifications to add targets to
> > dts/arch/arm64/Makefile.
> >
> > I am happy to put in that effort but certainly for new board support
> > that would like to import DT from Linux it should be the default. That
> > stands true for the Qcom platform series for which Caleb is currently
> > working on.
>
> The problem I see is that this is board-by-board, so will never
> happen. Changing one board (e.g. rockpro64-rk3399) typically involves
> changing the .dtsi files it includes (e.g. rk3399.dtsi) so it is
> hard/impossible to do one board without doing all.
>
> So this is why I believe the setting should be on an SoC basis, not on
> a board basis.

Sure, I will enable OF_UPSTREAM on a per SoC basis.

>
> >
> > >
> > >
> > > > +
> > > >  choice
> > > >         prompt "Provider of DTB for DT control"
> > > >         depends on OF_CONTROL
> > > > diff --git a/dts/Makefile b/dts/Makefile
> > > > index 3437e54033d..8098bf8191a 100644
> > > > --- a/dts/Makefile
> > > > +++ b/dts/Makefile
> > > > @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
> > > >  DEVICE_TREE :=3D unset
> > > >  endif
> > > >
> > > > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > > > +ifeq ($(CONFIG_ARM64),y)
> > > > +DEVICE_TREE_LOC :=3D dts/arch/arm64
> > >
> > > dt_dir ?
> >
> > Okay I will rename it.
> >
> > >
> > > Should we move the arm64 DTs to arch/arm64 ?
> >
> > IMO, the migration path should be to use rebasing subtree via
> > dts/arch/arm64/ and dropping DTs except *-u-boot.dtsi from
> > arch/$(ARCH)/dts. So moving DTs from arch/arm/ to arch/arm64/ seems
> > like a redundant change to me.
>
> I can see that argument, but having two different directory structures
> would be confusing.

I can see your point but U-Boot arch arm64 code is also contained in
arch/arm/. However, I would suggest first migrating to DT rebasing and
then we can do a move for the leftovers (*-u-boot.dtsi and such). A
double move won't add much value.

-Sumit

>
> >
> > >
> > > What about the subdirs used in Linux?
> >
> > I hope I have described above regarding how subdirs are mirrored.
> > However, have a look at patch #7 for the amlogic/ subdir example.
>
> OK
>
> Regards,
> Simon

