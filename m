Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05560C47DD6
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web11.54049.1704376213276953039
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jan 2024 05:50:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZKjpM1Ww;
 spf=pass (domain: konsulko.com, ip: 209.85.167.170, mailfrom: trini@konsulko.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbd6e377ceso356787b6e.1
        for <u-boot-amlogic@groups.io>; Thu, 04 Jan 2024 05:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704376212; x=1704981012; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1D9SoKIIbZNKHGpQK/DlUwkQJZSFCEd6+WzwRuXoYa4=;
        b=ZKjpM1WwByeTBeFhDUSOwvF9k6xRRbT1/pVVeILC1/dOp/L+rLCSTXQetBSlc7Q9/l
         SdZ5iJep9AkGXkxUak/RHGN8RmY322muHroDE8zji3J9Dm4i1Kw2kkVXbszRRR0HM4as
         xhslPfW/XxN+Evc+tyul2Vqw81sYoYd9hKLag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376212; x=1704981012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D9SoKIIbZNKHGpQK/DlUwkQJZSFCEd6+WzwRuXoYa4=;
        b=vkxzfS8J+ZUObIrm1aF8S2Ab4KO0nATYMxxUU9nfBK2mpWiP7MRdnP2qg9qmurGv8I
         Y8TYA5GcRT9HjWDWg3+a0GZzx13tYPHiOWGI8j7or25XmTkVbl7M2/sJs0ZbVxJ86vqK
         SGTKofxtmxs+Arx2INo/T5OWcd6G7eW1tjbZt+2CNGxvEz8kOkdZ/sD52cYRCY/1r00I
         CAA1rYiM8Qqra+zkIhBQUFjI+c1PZ88eKwsGDNVRUv+15fBZaZKRxexdGkBNpmGxf2uZ
         voDmzzXv5+svpyv/XVutNOBSeNXB7CtzCTJ7KCqCSpzRsdKydLJtR9AI0j1jzMtPfTTs
         lQxw==
X-Gm-Message-State: AOJu0Yx4MATGTlZMRYWXgniCildLQ+ApzL0lpGmV25pB4RlNZ3FhkVdP
	wvh/mIO9cW3wiUb/sLDe8tMW/AfQBcKAPja1ICJYBfkCvLY=
X-Google-Smtp-Source: AGHT+IH/NC5ZvpZzZqSmrHa5Q4m/bONRwrO0uB3eKtEV5/Tn+5wawG8rK+nCUXuruihcE5u+mmnoXA==
X-Received: by 2002:a05:6808:f94:b0:3bc:30d0:b17c with SMTP id o20-20020a0568080f9400b003bc30d0b17cmr772936oiw.6.1704376212550;
        Thu, 04 Jan 2024 05:50:12 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com. [2603:6081:7b00:3119::1005])
        by smtp.gmail.com with ESMTPSA id v3-20020a0cc603000000b00680cb3fd476sm1412728qvi.43.2024.01.04.05.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:50:12 -0800 (PST)
Date: Thu, 4 Jan 2024 08:50:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, Rob Herring <robh+dt@kernel.org>,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, sjg@chromium.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	neil.armstrong@linaro.org, caleb.connolly@linaro.org,
	ff@shokubai.tech, daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org, pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
	b.galvani@gmail.com, xypron.glpk@gmx.de, seanga2@gmail.com,
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
	mibodhi@gmail.com
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
Message-ID: <20240104135008.GQ1610741@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat>
 <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
 <CAFA6WYP6p=eVtmnS=Qd8xv+nCSFvzREMnRHFkLzEzENnvTxv+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFA6WYP6p=eVtmnS=Qd8xv+nCSFvzREMnRHFkLzEzENnvTxv+A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=OykMffhAINcORAz6P2vs"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2039

--Groupsio=OykMffhAINcORAz6P2vs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 06:52:32PM +0530, Sumit Garg wrote:
> Hi Michal,
>=20
> On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> wrote:
> >
> >
> >
> > On 1/3/24 17:32, Tom Rini wrote:
> > > On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> > >> On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > [snip]
> > >>> +In order to maintain devicetree files sync, U-Boot maintains a Git=
 subtree for
> > >>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It=
 is regularly
> > >>> +kept updated with every new kernel major release via subtree pull =
as follows::
> > >>
> > >> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
> > >> had in the original repo). I don't think it's relevant.
> > >>
> > >> We're not likely to regenerate the tree, but any clue what 'git
> > >> subtree pull' would do in this case? It could happen if we switched =
to
> > >> git-filter-repo.
> > >>
> > >>> +
> > >>> +    git subtree pull --prefix devicetree-rebasing \
> > >>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/d=
evicetree-rebasing.git \
> > >>> +        <release-tag> --squash
> > >>
> > >> I'd put this in a script to run. Documentation tends to be not quite
> > >> correct. A script could also be smarter and figure out <release-tag>=
.
> > >
> > > Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
> > > something using subtree, I do hope to learn some lessons from what yo=
u
> > > do there. The first thing is that given the size/nature of the commit=
s,
> > > I had figured I'd be the one doing this as a subtree pull+squash then
> > > push, rather than posting to the ML since it'll be huge and
> > > un-reviewable, but with a note sent off to the ML that people should =
be
> > > aware the next sync has been done and retest as needed. But Sumit, we=
re
> > > you planning to do some of this instead?  The second thing is that if=
 we
> > > move the subtree part in to dts/ instead (where we will still have th=
e
> > > Makefile/Kconfig we have today and then our Makefiles within the
> > > directories, this might get more complex and so really require a scri=
pt
> > > to keep it from getting error prone?
> >
> > I played with this series and didn't really have time to dig into subtr=
ee
> > mechanics but one thing I see is that when squash and merge happens you=
 can't do
> > simple rebase anymore which is time to time very useful.
> > I see some different rebase strategies and --rebase-merges option but i=
f this is
> > adopted it should be properly described how to rebase u-boot tree which=
 contains
> > some subtrees.
>=20
> Did you observe any specific difference with respect to subtree merge
> commits (Tom will likely do those in the beginning of next release
> cycle) when compared with normal merge commits when Tom pulls in code
> from different custodians like one example below? The same rebasing
> rules should apply to both types of merge commits.
>=20
> commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
> Merge: 2b28c3b871c e266d273114
> Author: Tom Rini <trini@konsulko.com>
> Date:   Mon Jan 1 12:38:15 2024 -0500
>=20
>     Merge tag 'dm-next-1124' of
> https://source.denx.de/u-boot/custodians/u-boot-dm into next
>=20
>     support propagating supernode properties with bootph schema
>     align bloblist with v0.9 of Firmware Handoff spec

There's two cases. The first and uncommon case is that if you want to do
something like:
- Branch next
- Add this subtree, do a few subtree updates on it (like my experiment
  of starting with v6.1-dts and merging up to v6.6-dts)
- Wait a while, have changes happen in next
- Rebase on to current next

It gets painful and odd, but I don't know that this will ever really
happen.

The second, common case is:
- Assume "next" already has this subtree + some merge commits in it.
- Make a new local branch.
- Make change in your new local branch.
- This hypothetical "next" branch moves forward with changes
- Rebase your local branch on to this "next" branch

In this case things work as expected. Even if  "next" in that case gets
a new subtree merge that you need to rebase in.

A third case that I'm not sure if really will happen or is a case where
the custodian should rework their tree instead (to drop the subtree
merge) is:
- Assume "next" already has this subtree + some merge commits in it.
- Make a new local branch.
- Make a subtree merge+squash in your local branch.
- This hypothetical "next" branch moves forward with changes
- Rebase your local branch on to this "next" branch.

This will then make you try and resolve some conflicts from that subtree
merge.  But is this a valid use case? Yes, I can see wanting to get a
start on testing a dts merge before it happens, but is this a tree which
needs to be rebased, or just re-created as needed, if the parent branch
moves forward?

Can you explain a bit more your case Michal since it sounded to me like
you had a problem that happened rather than a worry about what might
happen?

--=20
Tom

--Groupsio=OykMffhAINcORAz6P2vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWWt4wACgkQFHw5/5Y0
tyymagv/WWzFqPWfq+iilK4lDeTbjSNmw1uu0lGxJgPB5Q3U6LTivXY39C9dRxuU
CI9eMeCNYJ87JxR7kmm1zPF7/bwfNEcxOcvjNBhHUC/4/n/fBKOCG1RIrHO+JNRC
4Hdp0P1OrvJr8L4TxfS9bPsYZKD1bd81bsrRs2cP/HizR39XjsBGm68IEmXqvpBF
FYZ82kbmKsthjgfGcHUs/89KvWo5qSt2rHLhhTh7thH/hXJJz/ggUObzWrDo+B2v
s0KSj+g/1Ii+Sj18eGfqTqFNe3jXFSWMDbnmz7RhACFhvv53ZlTrOq117Se6CzAC
btUsz7Wlt6AHHc6ktaVe3ThsqgGfLa6V5hL+bwaJUeY89CxXMoD57cIdDsylM40d
Ym8vzm4Q64s6KBZxCacAHkSi53sqRPxhLb9ABrCVTRasCxDcKZfIqBroL1xkLYP1
dctnxWXpW7Bki0xTgGiB9ikET9+Ujc5iL/a3NQj+921/4rKzShZC4wS8lJNVy9eH
/+Rip+ne
=69aP
-----END PGP SIGNATURE-----

--Groupsio=OykMffhAINcORAz6P2vs--

