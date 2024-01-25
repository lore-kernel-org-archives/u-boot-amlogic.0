Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CDAC48286
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 08:59:10 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web11.1182.1706224777321143982
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Jan 2024 15:19:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gqQEtvIV;
 spf=pass (domain: konsulko.com, ip: 209.85.219.174, mailfrom: trini@konsulko.com)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3a09e96daso6499568276.3
        for <u-boot-amlogic@groups.io>; Thu, 25 Jan 2024 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1706224776; x=1706829576; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyB3+MFRc+CXevMRbIV5T1heUI7kjAxFRQH0VJ2CWW0=;
        b=gqQEtvIVvBS+8Sh3YmuoL3yRHeaf+bGV6Y0uEiEjIzCt+KaH1ZlRZaaWTLmdXs99Gy
         ct3DLnDfd033qwz1r41dYMlYVH9CRBseMPfWn39xeUHShXce8nfXPXdL5jvvAqI0fP0d
         /iXa2eQvehdnHxnlMBpI0ZnZ+LxEY898gX05g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706224776; x=1706829576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyB3+MFRc+CXevMRbIV5T1heUI7kjAxFRQH0VJ2CWW0=;
        b=GmdZ1sicLUqJ7FpKNtWa/f2XktD8Y+6rzo/FObVGCmHWUbBNSRnf4TahisLg+AUki3
         6Kzjen3SkLnths2l67xii97bRiNFw1UGzsV6H2ZMvooxMfs8i++VeShNrJaose4ULTOO
         InSm4tuD3400u3y7Gt6lUaSAUAGqs1MM1DDaSKB8vSluLdPAOvtZvNu6DVRFS383vQnh
         5zjX4t0Jj4D+rQqX1b0LuJj++q8jVGebijQ9cpF3L3Xtez2CmG6pQdgnUy7EZlCFCPnD
         3rFzv2l9eMOFyTBouRi6IKwghkpmPC/ru+ottiji87lkjtevHSqVPTLz1t5WGCUbcI+2
         NLKg==
X-Gm-Message-State: AOJu0YzzysTMsNGIL1GI07piVJACaBk7O1WRYgdYU5SbZMpp9rdF4VtF
	XZ5LTF3uJphCzfXlTFbwaZY8fjgUApdC+Y15NACWkF02aV4/8jWZlzrOgWayIEQ=
X-Google-Smtp-Source: AGHT+IFnV1Re2aoyI8LY5T3+HgIuxcnWMCo08BR7J6XzzRrMXTwjjT16cbm4q79QNSBSU1xWhFJu9Q==
X-Received: by 2002:a25:a108:0:b0:dc2:2666:efc6 with SMTP id z8-20020a25a108000000b00dc22666efc6mr498806ybh.11.1706224776488;
        Thu, 25 Jan 2024 15:19:36 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id s2-20020a25aa02000000b00dbf3dbedd69sm3785941ybi.53.2024.01.25.15.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 15:19:36 -0800 (PST)
Date: Thu, 25 Jan 2024 18:19:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	sjg@chromium.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	neil.armstrong@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
Message-ID: <20240125231933.GY3652023@bill-the-cat>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
 <20240125150400.GM3652023@bill-the-cat>
 <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
MIME-Version: 1.0
In-Reply-To: <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=BEGrlaph7CEFylS1qhoM"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 26 Jan 2024 08:59:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2089

--Groupsio=BEGrlaph7CEFylS1qhoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 05:38:23PM +0100, Marek Vasut wrote:
> On 1/25/24 16:04, Tom Rini wrote:
> > On Thu, Jan 25, 2024 at 12:54:22PM +0530, Sumit Garg wrote:
> >=20
> > [snip]
> > > But at this point we have to move away from apprehensions about DT AB=
I
> > > breakages and provide real examples of the DT ABI breakages in the
> > > past. Are you aware of any DT ABI breaking change backported to Linux
> > > stable releases? This is the sort of information we would like to mak=
e
> > > DT bindings maintainers aware about.
> >=20
> > Well, how far back are we going? There was a serial related one, but it
> > was probably closer than not to 10 years ago and lessons have been
> > learned from it already.
> >=20
> > The real breakage comes in the form of (from the Linux kernel):
> > commit 37685f6a63eeca2135d1f704e7638409a071b1f6
> > Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Date:   Tue Feb 19 08:46:33 2019 -0800
> >=20
> >      ARM: dts: am335x-evm: Fix PHY mode for ethernet
> >=20
> >      The PHY must add both tx and rx delay and not only on the tx clock=
.
> >      The board uses AR8031_AL1A PHY where the rx delay is enabled by de=
fault,
> >      the tx dealy is disabled.
> >=20
> >      The reason why rgmii-txid worked because the rx delay was not disa=
bled by
> >      the driver so essentially we ended up with rgmii-id PHY mode.
> >=20
> >      Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >      Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > And this is of the style "the DTS was wrong before so we can break it".
> > This is the specific example (as the board is in my lab) that comes mos=
t
> > clearly to mind but there have been similar examples in 2022/2023.
> >=20
> > The other just as painful examples I think may be where Marek is
> > concerned and it's around nodes being renamed for correctness. We've ha=
d
> > a number of cases where a - turned to _ (or vice versa?) and whoops,
> > platform stops booting. Down the line, tooling would catch that, and
> > it's a problem of not being able to use better tooling until we have th=
e
> > updates that might break the boards that need the better tooling.
> >=20
> > And really this gets to the crux of the problem, how much testing do we
> > insist happens prior to a re-sync being merged? Do we want to go with
> > the whole of the dts files are re-synced, or do we leave it per vendor?
>=20
> I'd much prefer to leave it per vendor, with the recommendation to use
> synced DTs. Eventually things will stabilize and vendors will start
> switching over.

To be clear, every SoC (or really, board) has to opt-in to OF_UPSTREAM
to start with. With that, I see switching to OF_UPSTREAM meaning that
there's a commitment to keeping up with dts change in upstream dts that
might lead to issues within U-Boot. Do you still feel it would be better
to have the re-sync _also_ be per custodian tree? That might be a bit
harder to handle.

--=20
Tom

--Groupsio=BEGrlaph7CEFylS1qhoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWy7H4ACgkQFHw5/5Y0
tyx4rwv+PJflPEzRznmjHsZwbLApxsJmQl4z10hMGt+h2V8F9aZZyD4fCnLavImt
cqccskA/sner+ZnQKVnPaKIL/p4GgWCWF4bkLyajEzYob9FjDaVA7LN+fMvuiLI9
ZtjkPoLcFFVXTKCSBRApQBZF0yz2l59jS8ncviad3qHGWDo6fKdz5nH+D+eSwtFS
v+QX0CwPoOacan3SdNERDcyRthuwETegrv9lvlpV26zDVSwsaWEyNP/qputwO/Gu
yqO3iwBkT1WFj2f/rSOWB1h/oT0Opt4WpxnYwxp7pc+M1YbgFvoI2TlWVYN7KMTt
FULLXAyNoJlsT6291HgqtNchxq234v/e6XrG+AswA2GOr1zwnfD4YwjJtMiojcYx
oqNc0hVj1Mu7vjcOagWHlxGfYWxUFmeU51ZazOqq/DJ0Um0U+NOqNZUjT3QocHU4
cak/+1x2PK6umgCnQ6Fzc7xG0lTycVYmmE6/Tn/lTT2Vjz9EwRjdKi30kTirHR8+
y2SkFfFc
=w+z7
-----END PGP SIGNATURE-----

--Groupsio=BEGrlaph7CEFylS1qhoM--

