Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65935C46CD2
	for <webhook@archiver.kernel.org>; Wed, 24 Jan 2024 12:49:08 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mx.groups.io with SMTP id smtpd.web10.17574.1706028140647712541
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Jan 2024 08:42:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=Xr5atbMq;
 spf=pass (domain: kernel.org, ip: 145.40.73.55, mailfrom: robh+dt@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9E590CE2F98
	for <u-boot-amlogic@groups.io>; Tue, 23 Jan 2024 16:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAA2C433A6
	for <u-boot-amlogic@groups.io>; Tue, 23 Jan 2024 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028136;
	bh=yH1uuCzUiU/1B9PhsPmw/wF2HgavGtBVha2NbfoLW7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xr5atbMqB4Fl/9cCTz0qDb2d4WK4d9o0XpojLJWIF+G1LcQ87aPslCX+LpAsrn5k6
	 kMZrKrTAZFyTSkFtmo0PiJAxBlpMClyUpw/hi6ZTZ3R3j4sHdQhDhyJVxdiYmHEQMd
	 zLd3Pzcd44PAoX6rM0wPbH1nnGq+OWFrZ9sFWXSbnFkkHukv9Lyp4n9P5Pwka79Suk
	 BR9P5ZlgrWMv25cIdNN30eM1PkasYqEiAydtP9gbVfiOeboKCe/68joCZ1AsjltDXY
	 lxY25aBkSI0FV6/tw92F+FtuYdDzSA1VF/fCzO9xbE+gej3ExAJ+PIgkJvqg0GHxT5
	 wQJ/Of3Q8OHPg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf15eea3c1so6652531fa.0
        for <u-boot-amlogic@groups.io>; Tue, 23 Jan 2024 08:42:16 -0800 (PST)
X-Gm-Message-State: AOJu0YzQmD73FsjPHAuPS70RpHGMi0SYq41sTZzqOItbkRxBhvf1cs5I
	hVYQfUEQe+1sx5epcKNcP2tjKhhxhUSZ5P4t2ByAM3Cc3L5fRjqERXmYguTOAbCCUsdkOftMPe6
	FFtVgqzu/DIiZA8Zn3UAPXh1K0A==
X-Google-Smtp-Source: AGHT+IHo/4zH0Zjk5iMrEJaPKPIJTagPw6LMJoTVMO01HF6UxBJCyzb5JGkxG5onXJWJYjT3EjdCjfB54LPjmLEgLOo=
X-Received: by 2002:a2e:3019:0:b0:2ce:fc69:47fd with SMTP id
 w25-20020a2e3019000000b002cefc6947fdmr35118ljw.16.1706028135002; Tue, 23 Jan
 2024 08:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240122114515.760e9cd3@donnerap.manchester.arm.com> <20240122164959.GN3652023@bill-the-cat>
 <20240123005834.4ab47bf5@minigeek.lan>
In-Reply-To: <20240123005834.4ab47bf5@minigeek.lan>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 23 Jan 2024 10:42:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1azgskDucTVkF0u_bKJUtNhhiufGdN6OOYicxwHW2_Q@mail.gmail.com>
Message-ID: <CAL_JsqJ1azgskDucTVkF0u_bKJUtNhhiufGdN6OOYicxwHW2_Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
	mark.kettenis@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 12:49:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2080

On Mon, Jan 22, 2024 at 6:59=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Mon, 22 Jan 2024 11:49:59 -0500
> Tom Rini <trini@konsulko.com> wrote:
>
> Hi Tom,
>
> > On Mon, Jan 22, 2024 at 11:45:15AM +0000, Andre Przywara wrote:
> > > On Wed, 10 Jan 2024 16:05:36 +0530
> > > Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > I certainly welcome this more automatic synchronisation of the DTs,
> > > however have one comment about the upcoming sync process:
> > >
> > > > ...
> > > > However, Linux kernel DT maintainers proposed [2] for U-Boot to rat=
her
> > > > use devicetree-rebasing repo [3] which is a forked copy from Linux
> > > > kernel for DT source files as well as bindings. It is tagged at eve=
ry
> > > > Linux kernel major release or intermideate release candidates. So h=
ere I
> > > > have tried to reuse that to bring DT bingings compliance as well as=
 a
> > > > standard way to maintain a regular sync of DT source files with Lin=
ux
> > > > kernel.
> > > >
> > > > In order to maintain devicetree files sync, U-Boot will maintains a=
 Git
> > > > subtree for devicetee-rebasing repo as `dts/upstream` sub-directory=
.
> > > > U-Boot will regularly sync `dts/upstream/` subtree whenever the nex=
t window
> > > > opens with the next available kernel major release.
> > >
> > > I hope this doesn't need to stay that restricted? Can we either sync =
more
> > > often, or at least on the kernel's -rc1, and not only on a "full" rel=
ease?
> > >
> > > The reason I ask is that we have a chicken-egg problem here: without =
a DT
> > > merged into the kernel tree, no U-Boot board support can be merged. A=
nd
> > > without U-Boot support, we cannot boot a kernel, at least not in the
> > > canonical way.
> > >
> > > Since the U-Boot and kernel merge windows are not in phase, for sunxi=
 I try
> > > to sync the kernel DTs either as early as possible (-rc1, sometimes e=
ven
> > > before, when the maintainers have merged them into their tree), or
> > > sometimes "out of season", if a board defconfig patch is coming up.
> > >
> > > Otherwise new board support, which typically has a very low regressio=
n risk
> > > for the rest of the code base, would need to be delayed until the nex=
t
> > > release. In the worst case the U-Boot merge windows opens one week be=
fore
> > > a kernel release, then new boards need to wait three months?
> >
> > Would it be to bad to bring in board X with OF_UPSTREAM=3Dn for one U-B=
oot
> > release, and then with the next one switch to OF_UPSTREAM=3Dy (and dele=
te
> > the dts from arch/) for the next release, when we would have gotten bac=
k
> > in sync?
>
> Ah, I didn't look into the actual patches, but if this provision is
> there, that sounds surely acceptable. It might still be good to sync
> earlier than the .0 kernel release: if it appears in Linus' tree, it
> had already seen a good share of review and testing. And with the
> U-Boot releases being always further away than the next kernel release,
> we could pull fixes still in time. So we could pick the latest -rc (or
> .0 release, whichever is more recent) when the U-Boot merge window
> opens?

That should be mostly fine IMO, but there are the occasional "oops,
let's change/fix the binding before it's released".

Couldn't you pull in the latest rc in the merge window, but only if
the .0 release will happen before the next u-boot release. And then
update from rc to .0 before the u-boot release.

Also, from a quick look at the dts changes during rc releases, they
tend to come in the later rc releases. Probably that's just the
latency of going to sub-arch maintainer->SoC->Linus.

Rob

