Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9D0C47DD7
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:32 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web11.56571.1704382234065347163
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jan 2024 07:30:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WpTJ3gJs;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783045e88a6so28839585a.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Jan 2024 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704382233; x=1704987033; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgpI3BN8DdOAi4cB1SD5xEJrlz2OrnrHaeD2TOkxU2c=;
        b=WpTJ3gJsu9/81YnAgU4Tz1RARBS6mQ0IJW/mj+XD0qNlHwOr1pwhDKnu/aBsgNl5Wp
         NtVJ6yCDBI2bDfhiS+seBW9ljdeHUeL8Nw2toWK/lqJPdsChZprWWfGq3RwgYUY3MjYN
         zjBZjaPakc/DvKN1TWj9ucn1tJAw5Z3Gy1znA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382233; x=1704987033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgpI3BN8DdOAi4cB1SD5xEJrlz2OrnrHaeD2TOkxU2c=;
        b=BN7mJRpIqjrm528fcy0sgU46wP/NR18UMikFknJ56PtCsVqu080nJdM2doAXDHRF0q
         QypmaR1ipvuRIVpg44JYRJGg9oMbinBJLPYmL9iBrNZpL+kywHqT+f0UGyCMGQ6OFr4u
         DJVUUFBbAQEQsPXjCcYEXDhNkqUh3h4/Nvf8NLxnO6a/rCJih0vLbO6knepseWRe1ZSd
         pxOk5cz3FTYC8FDL2FyVmjZ0Ctg8DTaEAtK7EcPnWz2i7beDiYlErPs0sHkIEHNQrJyd
         Q5Cn7gJ3YysrFdtdjXVDlopgRhsXDldqidmXzOtBWo6WPlEz7hWiisblaOzEybLg53v3
         GULg==
X-Gm-Message-State: AOJu0YyB4fOStlmUZxVzilwmwXEoNAFtpkaJKm8vDQPLOpmNhh5hqE5o
	6PQh8YOHCRRs6kcgTDC0tmMetutHk3mkcg==
X-Google-Smtp-Source: AGHT+IEqettCHf2x64L2aBT1ApThQWX6e3zf6ecxq/HWLhRh1pOjoxiuMu3AUOaT1YcPoVRKzRTouw==
X-Received: by 2002:a05:620a:2b87:b0:783:5f5:3065 with SMTP id dz7-20020a05620a2b8700b0078305f53065mr174666qkb.16.1704382233109;
        Thu, 04 Jan 2024 07:30:33 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com. [2603:6081:7b00:3119::1005])
        by smtp.gmail.com with ESMTPSA id z19-20020ae9c113000000b00781598c5e9csm6961805qki.135.2024.01.04.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:30:32 -0800 (PST)
Date: Thu, 4 Jan 2024 10:30:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20240104153029.GT1610741@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat>
 <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
 <CAFA6WYP6p=eVtmnS=Qd8xv+nCSFvzREMnRHFkLzEzENnvTxv+A@mail.gmail.com>
 <20240104135008.GQ1610741@bill-the-cat>
 <cb0ee2fb-2753-421e-9623-3cd74e6bef03@amd.com>
MIME-Version: 1.0
In-Reply-To: <cb0ee2fb-2753-421e-9623-3cd74e6bef03@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=xsmxmWAHsebbloYkNmM8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2041

--Groupsio=xsmxmWAHsebbloYkNmM8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 03:45:10PM +0100, Michal Simek wrote:
> Hi Tom,
>=20
> On 1/4/24 14:50, Tom Rini wrote:
> > On Thu, Jan 04, 2024 at 06:52:32PM +0530, Sumit Garg wrote:
> > > Hi Michal,
> > >=20
> > > On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> wrot=
e:
> > > >=20
> > > >=20
> > > >=20
> > > > On 1/3/24 17:32, Tom Rini wrote:
> > > > > On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> > > > > > On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@=
linaro.org> wrote:
> > > > > [snip]
> > > > > > > +In order to maintain devicetree files sync, U-Boot maintains=
 a Git subtree for
> > > > > > > +devicetee-rebasing repo as `devicetee-rebasing/` sub-directo=
ry. It is regularly
> > > > > > > +kept updated with every new kernel major release via subtree=
 pull as follows::
> > > > > >=20
> > > > > > I would suggest dropping "-rebasing" in the u-boot tree. (I wis=
h we
> > > > > > had in the original repo). I don't think it's relevant.
> > > > > >=20
> > > > > > We're not likely to regenerate the tree, but any clue what 'git
> > > > > > subtree pull' would do in this case? It could happen if we swit=
ched to
> > > > > > git-filter-repo.
> > > > > >=20
> > > > > > > +
> > > > > > > +    git subtree pull --prefix devicetree-rebasing \
> > > > > > > +        git://git.kernel.org/pub/scm/linux/kernel/git/device=
tree/devicetree-rebasing.git \
> > > > > > > +        <release-tag> --squash
> > > > > >=20
> > > > > > I'd put this in a script to run. Documentation tends to be not =
quite
> > > > > > correct. A script could also be smarter and figure out <release=
-tag>.
> > > > >=20
> > > > > Since you had mentioned elsewhere moving the kernel scripts/dtc/ =
to
> > > > > something using subtree, I do hope to learn some lessons from wha=
t you
> > > > > do there. The first thing is that given the size/nature of the co=
mmits,
> > > > > I had figured I'd be the one doing this as a subtree pull+squash =
then
> > > > > push, rather than posting to the ML since it'll be huge and
> > > > > un-reviewable, but with a note sent off to the ML that people sho=
uld be
> > > > > aware the next sync has been done and retest as needed. But Sumit=
, were
> > > > > you planning to do some of this instead?  The second thing is tha=
t if we
> > > > > move the subtree part in to dts/ instead (where we will still hav=
e the
> > > > > Makefile/Kconfig we have today and then our Makefiles within the
> > > > > directories, this might get more complex and so really require a =
script
> > > > > to keep it from getting error prone?
> > > >=20
> > > > I played with this series and didn't really have time to dig into s=
ubtree
> > > > mechanics but one thing I see is that when squash and merge happens=
 you can't do
> > > > simple rebase anymore which is time to time very useful.
> > > > I see some different rebase strategies and --rebase-merges option b=
ut if this is
> > > > adopted it should be properly described how to rebase u-boot tree w=
hich contains
> > > > some subtrees.
> > >=20
> > > Did you observe any specific difference with respect to subtree merge
> > > commits (Tom will likely do those in the beginning of next release
> > > cycle) when compared with normal merge commits when Tom pulls in code
> > > from different custodians like one example below? The same rebasing
> > > rules should apply to both types of merge commits.
> > >=20
> > > commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
> > > Merge: 2b28c3b871c e266d273114
> > > Author: Tom Rini <trini@konsulko.com>
> > > Date:   Mon Jan 1 12:38:15 2024 -0500
> > >=20
> > >      Merge tag 'dm-next-1124' of
> > > https://source.denx.de/u-boot/custodians/u-boot-dm into next
> > >=20
> > >      support propagating supernode properties with bootph schema
> > >      align bloblist with v0.9 of Firmware Handoff spec
> >=20
> > There's two cases. The first and uncommon case is that if you want to d=
o
> > something like:
> > - Branch next
> > - Add this subtree, do a few subtree updates on it (like my experiment
> >    of starting with v6.1-dts and merging up to v6.6-dts)
> > - Wait a while, have changes happen in next
> > - Rebase on to current next
> >=20
> > It gets painful and odd, but I don't know that this will ever really
> > happen.
> >=20
> > The second, common case is:
> > - Assume "next" already has this subtree + some merge commits in it.
> > - Make a new local branch.
> > - Make change in your new local branch.
> > - This hypothetical "next" branch moves forward with changes
> > - Rebase your local branch on to this "next" branch
> >=20
> > In this case things work as expected. Even if  "next" in that case gets
> > a new subtree merge that you need to rebase in.
> >=20
> > A third case that I'm not sure if really will happen or is a case where
> > the custodian should rework their tree instead (to drop the subtree
> > merge) is:
> > - Assume "next" already has this subtree + some merge commits in it.
> > - Make a new local branch.
> > - Make a subtree merge+squash in your local branch.
> > - This hypothetical "next" branch moves forward with changes
> > - Rebase your local branch on to this "next" branch.
> >=20
> > This will then make you try and resolve some conflicts from that subtre=
e
> > merge.  But is this a valid use case? Yes, I can see wanting to get a
> > start on testing a dts merge before it happens, but is this a tree whic=
h
> > needs to be rebased, or just re-created as needed, if the parent branch
> > moves forward?
> >=20
> > Can you explain a bit more your case Michal since it sounded to me like
> > you had a problem that happened rather than a worry about what might
> > happen?
>=20
> I remember couple of bisects which I was doing and it works fine on the t=
ree
> till the point you have 2 issues to deal with. It means pretty much you h=
ave
> config change/fix which has to be applied to see second issue.
>=20
> The normal way what I have done was simply find major version apply that =
fix
> and then take the latest tree and rebase latest on the top of it. There w=
ere
> normally not so many conflicts to resolved (or easy to resolve/ignore). T=
hen
> because the first fix is present all the time bisect is able to help me t=
o
> find second issue.
>=20
> If there is subtree update the whole rebase will horribly fail.
>=20
> I see that Rob and you in DTC case just simply do c&p and create regular
> commit with all changes inside. From my perspective this is more
> straightforward to deal with which will handle all cases and it is also
> proven over that years.

Ah, bisecting.  Maybe the (annoying) answer is to turn that merge commit
in to a regular commit in the bisect branch?  This is a good point, and
I need to go and construct a bigger example tree and check around at
what happens.

--=20
Tom

--Groupsio=xsmxmWAHsebbloYkNmM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWWzxIACgkQFHw5/5Y0
tywzdQv/VzC8Ss1oiVy3P8eA7QgrwQ6RXVQva0yvq1dhzrqM0LEpGFgxYEdmO2u6
adQcKYsonskSzu9rK54uQXKUUuRmHyafHKsYd60pVG+0Uhp88v0gTLSqZHkA9VqF
BvkYOdi3zXPxeTkVk2Wjx5IQyjBkfemPAJyBTACv5QwDAy+dscIhAhtWdFoAHgGB
z77u8HWcbLNuEqTpMf9jfaMNs+kTwwegYYYcRmDhro6F62w9heMX8ApG53nFQpUx
wjW6QqaYxsPGW2imGte/h9bwAq+qBjsCIgPomBYBRm9J6TT2ot1PTz9vhXS6MJ8O
InSe9mcqNeraBBa6UUL+fVad5ekKx9Ve1GRppmPf/xn2o00iUYLc1aoLZUrfhqhg
HwhD2U6iePoQniGSSq/KMyh11NHs12AiUwXvys5EGQUGr13+5tV8YChXZvgBBz0J
ugo+vH1Ey0j+vJUVNDoBGMJhSSbrI/WYHXNJo12FEbweqsAq+ev68ZGK/vkOahWz
YwWIGLZO
=Sv7/
-----END PGP SIGNATURE-----

--Groupsio=xsmxmWAHsebbloYkNmM8--

