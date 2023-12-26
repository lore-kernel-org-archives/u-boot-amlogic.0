Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E1CC48285
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.78501.1703584049163788656
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 01:47:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=gD8/xqSt;
 spf=pass (domain: chromium.org, ip: 209.85.214.174, mailfrom: sjg@chromium.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d430bac207so12319055ad.0
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703584048; x=1704188848; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVdFE3W3MBYd4mKaAdFZWM5RmzLe/CpmdAfQz5IEfW8=;
        b=gD8/xqSt6OIW79j/6a8Jj4Ev0Kmh3YtUxZtEM3R/g40W+qcElgIijFETeQI6ShQrLk
         drBjbpAb99CalGQ6kVGdzMW/Ivm4q1XH9Xw9kgs8G8l0IL4oF0xMIFv4HId8N113Mupv
         awZwKW5Z8pzH3iYjaKI451hmh6l3l9/J17klY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703584048; x=1704188848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVdFE3W3MBYd4mKaAdFZWM5RmzLe/CpmdAfQz5IEfW8=;
        b=jQiYmw3OzD1UuWiRU7H6aENfuT+ToGC1WsVp70DNzEzpn4mwg65rgzQAQwcPB5QQ2w
         /GYWgUlC/ygQhGjuuDg0Nn56lY5HSgQrVboxPoT+qPC7rE0yKlg6z7XcDE8z5L1gqmqi
         l4Ydomnupfy8B4D1Xi+ThlAzlQW/LpdJfZkzSf0zYN6VxDfj9GCy1rK2jFQRseHLyigH
         zkC7MksNU59+9PNEcteN7c0Z05kWadaPB6Aj4zd+VS7OsARMAQf6Hou7zHIy1VESI2h+
         LF1CtE3SGrpDMvnoXL1CvG/81YtGEqKk+2oYIxfkLSxFwte1rogEMGuS8oNJL5S8FCEY
         cnMQ==
X-Gm-Message-State: AOJu0YwnrtyeElE7Shm+R1A8DBcPOYxqAWiG6fVlv+2ifecS5eOM30tI
	ktgD91UzmAqoECcuDKiLVNR1c10QTpxPYYQfxxzIC/zrc8F2
X-Google-Smtp-Source: AGHT+IEoi09fPfTMdd1g8MxDSvBkHAKyZbreFRQqYfqMacKOZ3Zs/biPZYkC6w0QNPyRzQyBxaXsY8KnEWpS7U7DDiY=
X-Received: by 2002:a17:90b:4a8b:b0:28b:e7fc:5060 with SMTP id
 lp11-20020a17090b4a8b00b0028be7fc5060mr7235307pjb.11.1703584048497; Tue, 26
 Dec 2023 01:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-5-sumit.garg@linaro.org> <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
 <CAFA6WYMeLoD_z1W+iK3C6yj44dO_pdM71bhd6gK14gB==75gxw@mail.gmail.com>
In-Reply-To: <CAFA6WYMeLoD_z1W+iK3C6yj44dO_pdM71bhd6gK14gB==75gxw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:54 +0000
Message-ID: <CAFLszTgnOHQJGin-=32syDVPAkLXAni7QFd3WV_xtW0a2D84Bg@mail.gmail.com>
Subject: Re: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
To: Sumit Garg <sumit.garg@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1970

Hi Sumit,

On Wed, Dec 20, 2023 at 12:01=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Hi Simon,
>
> On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Allow platform owners to mirror devicetree files from devitree-rebasi=
ng
> > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Th=
en
> > > build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/=
dts
> > > directory.
> >
> > Also add a new Makefile for arm64.
>
> I suppose you are referring to dts/arch/arm64/Makefile which has been
> added by this patch.

Yes, I just mean that you should mention this in the commit message

>
> >
> > >
> > > This will help easy migration for platforms which currently are compl=
iant
> > > with upstream Linux kernel devicetree files.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  dts/Kconfig             | 11 +++++++++++
> > >  dts/Makefile            | 17 ++++++++++++++---
> > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > >  create mode 100644 dts/arch/arm64/Makefile
> > >
> > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > index 00c0aeff893..96396f12b67 100644
> > > --- a/dts/Kconfig
> > > +++ b/dts/Kconfig
> > > @@ -85,6 +85,17 @@ config OF_LIVE
> > >           enables a live tree which is available after relocation,
> > >           and can be adjusted as needed.
> > >
> > > +config OF_UPSTREAM
> > > +       bool "Enable use of devicetree imported from Linux kernel rel=
ease"
> > > +       help
> > > +         Traditionally, U-boot platforms used to have their custom d=
evicetree
> >
> > U-Boot
> >
> > (I think I mentioned this, but you thought I said U-boot...but it
> > really is U-Boot). Perhaps grep your patches next time.
>
> Ah, I see. It looks like I missed that bit, and will take care of it
> in the next revision.
>
> >
> > > +         files or copy devicetree files from Linux kernel which are =
hard to
> > > +         maintain and can usually get out-of-sync from Linux kernel.=
 This
> > > +         option enables platforms to migrate to devicetree-rebasing =
repo where
> > > +         a regular sync will be maintained every major Linux kernel =
release
> > > +         cycle. However, platforms can still have some custom u-boot=
 specific
> > > +         bits maintained as part of *-u-boot.dtsi files.
> >
> > I'm a bit nervous about this. It means that boards chose between this
> > dir of the local files. It means there is some effort to switch.
> >
> > I wonder if we could default to using the rebasing thing, with boards
> > having to 'opt out'? So this should be 'default y' ?
>
> Ideally that should be our migration path going forward once we get
> enough boards migrated to use rebasing repo. But at this initial stage
> we have to put some effort on migrating boards to use rebasing
> subtree, although effort should be just adding (given DT bindings
> compliance) following to defconfig (see patch #7):
>
> CONFIG_OF_UPSTREAM=3Dy
> CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
>
> and create a mirrored copy of:
> ../../../devicetree-rebasing/src/arm64/amlogic/ into
> dts/arch/arm64/amlogic/ with modifications to add targets to
> dts/arch/arm64/Makefile.
>
> I am happy to put in that effort but certainly for new board support
> that would like to import DT from Linux it should be the default. That
> stands true for the Qcom platform series for which Caleb is currently
> working on.

The problem I see is that this is board-by-board, so will never
happen. Changing one board (e.g. rockpro64-rk3399) typically involves
changing the .dtsi files it includes (e.g. rk3399.dtsi) so it is
hard/impossible to do one board without doing all.

So this is why I believe the setting should be on an SoC basis, not on
a board basis.

>
> >
> >
> > > +
> > >  choice
> > >         prompt "Provider of DTB for DT control"
> > >         depends on OF_CONTROL
> > > diff --git a/dts/Makefile b/dts/Makefile
> > > index 3437e54033d..8098bf8191a 100644
> > > --- a/dts/Makefile
> > > +++ b/dts/Makefile
> > > @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
> > >  DEVICE_TREE :=3D unset
> > >  endif
> > >
> > > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > > +ifeq ($(CONFIG_ARM64),y)
> > > +DEVICE_TREE_LOC :=3D dts/arch/arm64
> >
> > dt_dir ?
>
> Okay I will rename it.
>
> >
> > Should we move the arm64 DTs to arch/arm64 ?
>
> IMO, the migration path should be to use rebasing subtree via
> dts/arch/arm64/ and dropping DTs except *-u-boot.dtsi from
> arch/$(ARCH)/dts. So moving DTs from arch/arm/ to arch/arm64/ seems
> like a redundant change to me.

I can see that argument, but having two different directory structures
would be confusing.

>
> >
> > What about the subdirs used in Linux?
>
> I hope I have described above regarding how subdirs are mirrored.
> However, have a look at patch #7 for the amlogic/ subdir example.

OK

Regards,
Simon

