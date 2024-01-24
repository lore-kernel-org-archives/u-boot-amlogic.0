Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A9C47DDF
	for <webhook@archiver.kernel.org>; Wed, 24 Jan 2024 12:49:08 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
 by mx.groups.io with SMTP id smtpd.web11.18523.1706087011608697258
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Jan 2024 01:03:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=aiTEOsBT;
 spf=pass (domain: linaro.org, ip: 209.85.222.53, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d2dfe840f2so1735807241.3
        for <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706087010; x=1706691810; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLICkG4ScVUzCgpGbPDyyuuRZpXtom25bWlwVUEPtVo=;
        b=aiTEOsBTGXIrXNTGbsekzFdXKWAU1oOduADE8tvXvo/W/iNKQc9bWfIzuxWcli8HAN
         uQM851YieTfjwQLHdDY3jpwSvXh2H3+gXTMcYqYOSLFSlXyXE/V2/nBM4A0WkLNIRGh2
         RT9X53ampcvidrb2ZeOKr/rHBoLfAS1ulw4PdSyz00F3VxPap+Oc5FmzPyNq1xyCfJMo
         pr8Ym5WNiJ8PbTlwT2CT5twrW7ekYh4CEUKm2S5iEHFF8DBVjzKPke0PMwv5yYKRNTA7
         GWN6iPrNDLtjlLnRCGlkP14Wpd9+2buPlBeE70Yf9zoIFgKryXcaNo2ZawsdLV+D7r9I
         tKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087010; x=1706691810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLICkG4ScVUzCgpGbPDyyuuRZpXtom25bWlwVUEPtVo=;
        b=V8fDUz7YiTQphaWtFChriE9eZe4NU84muPgv1PwgBfShP1aUJtJUNW9STW7ncK0Aqx
         ZRcpjLVWnphvg7ny4cuY3nalx4ZIDeRQUx9njdv8tEOvKPicOxlBSwdd+ZKseOCy5Vck
         UwGz8yKGC3K6J/qNMyStKG5fxRkpMfVfcggQkLIzzxAFeHOnOVqt79gZGKBWTxTMAvpU
         NxSD4hnbXTnlLb3TXDBGAqjtceCYYOPH6iwrjkiZdGzYBLrrIFaCj+EzQrVilavWnF3j
         UYxXPHFXCzh1no1HPsPPYlBvfOElhy+mwWC+QfvUthyVSKWw0hXiMLy9JfIYmTFAFgBQ
         QWOw==
X-Gm-Message-State: AOJu0YyEr7XaBq/5C7owQlBeR5B5yxAXz7w6gtpLpMXt+2mVzN9M2amu
	f8T8nb76466JCEsHdozL1SbfcGw/JSa9o8ldM4VRaDCh3hC73LyIM2PbMck6gMSYuh6AVdLCsXP
	OUj8WLehPYEnc9VHTfKSmQUiHnwjX/MYO+1i5fg==
X-Google-Smtp-Source: AGHT+IHnXbDydUuGIemATwvTpccwd4HLfBSJZjMup2RFfzA3cIe8lba/gUMkrRGMZdInOkTgssBqg1UxQhfU4DHu59c=
X-Received: by 2002:a05:6102:e10:b0:469:85df:dea4 with SMTP id
 o16-20020a0561020e1000b0046985dfdea4mr5040173vst.21.1706087010654; Wed, 24
 Jan 2024 01:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240122114515.760e9cd3@donnerap.manchester.arm.com> <20240122164959.GN3652023@bill-the-cat>
 <20240123005834.4ab47bf5@minigeek.lan> <CAL_JsqJ1azgskDucTVkF0u_bKJUtNhhiufGdN6OOYicxwHW2_Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJ1azgskDucTVkF0u_bKJUtNhhiufGdN6OOYicxwHW2_Q@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jan 2024 14:33:19 +0530
Message-ID: <CAFA6WYPAemm6cdWatTEesVJP6x7SyVQvnMkwaMO6Z8fWE3KF0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Rob Herring <robh+dt@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2084

Hi Rob, Andre,

On Tue, 23 Jan 2024 at 22:12, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jan 22, 2024 at 6:59=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
> >
> > On Mon, 22 Jan 2024 11:49:59 -0500
> > Tom Rini <trini@konsulko.com> wrote:
> >
> > Hi Tom,
> >
> > > On Mon, Jan 22, 2024 at 11:45:15AM +0000, Andre Przywara wrote:
> > > > On Wed, 10 Jan 2024 16:05:36 +0530
> > > > Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I certainly welcome this more automatic synchronisation of the DTs,
> > > > however have one comment about the upcoming sync process:
> > > >
> > > > > ...
> > > > > However, Linux kernel DT maintainers proposed [2] for U-Boot to r=
ather
> > > > > use devicetree-rebasing repo [3] which is a forked copy from Linu=
x
> > > > > kernel for DT source files as well as bindings. It is tagged at e=
very
> > > > > Linux kernel major release or intermideate release candidates. So=
 here I
> > > > > have tried to reuse that to bring DT bingings compliance as well =
as a
> > > > > standard way to maintain a regular sync of DT source files with L=
inux
> > > > > kernel.
> > > > >
> > > > > In order to maintain devicetree files sync, U-Boot will maintains=
 a Git
> > > > > subtree for devicetee-rebasing repo as `dts/upstream` sub-directo=
ry.
> > > > > U-Boot will regularly sync `dts/upstream/` subtree whenever the n=
ext window
> > > > > opens with the next available kernel major release.
> > > >
> > > > I hope this doesn't need to stay that restricted? Can we either syn=
c more
> > > > often, or at least on the kernel's -rc1, and not only on a "full" r=
elease?
> > > >
> > > > The reason I ask is that we have a chicken-egg problem here: withou=
t a DT
> > > > merged into the kernel tree, no U-Boot board support can be merged.=
 And
> > > > without U-Boot support, we cannot boot a kernel, at least not in th=
e
> > > > canonical way.
> > > >
> > > > Since the U-Boot and kernel merge windows are not in phase, for sun=
xi I try
> > > > to sync the kernel DTs either as early as possible (-rc1, sometimes=
 even
> > > > before, when the maintainers have merged them into their tree), or
> > > > sometimes "out of season", if a board defconfig patch is coming up.
> > > >
> > > > Otherwise new board support, which typically has a very low regress=
ion risk
> > > > for the rest of the code base, would need to be delayed until the n=
ext
> > > > release. In the worst case the U-Boot merge windows opens one week =
before
> > > > a kernel release, then new boards need to wait three months?
> > >
> > > Would it be to bad to bring in board X with OF_UPSTREAM=3Dn for one U=
-Boot
> > > release, and then with the next one switch to OF_UPSTREAM=3Dy (and de=
lete
> > > the dts from arch/) for the next release, when we would have gotten b=
ack
> > > in sync?
> >
> > Ah, I didn't look into the actual patches, but if this provision is
> > there, that sounds surely acceptable. It might still be good to sync
> > earlier than the .0 kernel release: if it appears in Linus' tree, it
> > had already seen a good share of review and testing. And with the
> > U-Boot releases being always further away than the next kernel release,
> > we could pull fixes still in time. So we could pick the latest -rc (or
> > .0 release, whichever is more recent) when the U-Boot merge window
> > opens?
>
> That should be mostly fine IMO, but there are the occasional "oops,
> let's change/fix the binding before it's released".
>
> Couldn't you pull in the latest rc in the merge window, but only if
> the .0 release will happen before the next u-boot release. And then
> update from rc to .0 before the u-boot release.
>
> Also, from a quick look at the dts changes during rc releases, they
> tend to come in the later rc releases. Probably that's just the
> latency of going to sub-arch maintainer->SoC->Linus.
>

I agree with your intent to keep U-Boot updated with the latest Linux
DT .0 releases. However, we would like to provide sufficient time (a
full U-Boot release cycle) for U-Boot developers/maintainers to adapt,
detect and fix problems for their platforms wrt. to a new Linux DT .0
release. We can always revisit the syncing strategy to be more
aggressive if everything pans out as per plan.

-Sumit

> Rob

