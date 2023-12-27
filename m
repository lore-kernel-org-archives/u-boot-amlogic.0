Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB3C48260
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web11.101145.1703684278622723815
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Dec 2023 05:37:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qVm4XTWU;
 spf=pass (domain: konsulko.com, ip: 209.85.128.171, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e734251f48so38729847b3.1
        for <u-boot-amlogic@groups.io>; Wed, 27 Dec 2023 05:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703684278; x=1704289078; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJxtPdAIexAKqnZUDNv1NF7+9Y2tH5Zo11MJE0C+IB0=;
        b=qVm4XTWU0CHT7cBvsLhw6zx4jLtubm5Po3ad66ex3zPoRL847yz2eIn/XDvrHnbeWo
         xo61n2B+OaPMKryaahePcRaYVlDBOluzd+aZ2NeyJ0JhL+wXj/NEEb4EQ/ixnFDk8dbk
         joxvJCu0FCw/kW1CwRqOYk1W5mYXQ1XXDVzSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703684278; x=1704289078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJxtPdAIexAKqnZUDNv1NF7+9Y2tH5Zo11MJE0C+IB0=;
        b=uhvZoEBGR180Eh9fWRYmBmfeliCDqQxlDSqDR0XKvB8wM1xSO7RreL3TZYnR6ZDX5b
         eCuiGJ4Q/m6p0zsPD44fL+tA/JjsoPKljfO+5NNjbZ+/1/l9zhKpCC7V+CQKiV5U3CoC
         IUpPV54JzKnhU7GkvN6xUWf5Si5MSP8bpe1B1lsuAi6WzVnYacSdEG1Yq7CKKt/ReyCD
         xWV03hxN7iwUdLqynV7EMp18GmIAtmdBekTPasEVHJyNxPDtwnXWNdCEugVvA60PGyHd
         +TUNLdUR8CIh/EK/1LvBDfueWbyJQ1dzOff2Y1snpybH58TsxlIPNuYhNEj+GEnq4dDO
         hknQ==
X-Gm-Message-State: AOJu0YyRLENVUiZvJjZ8XuIz9mUw6gRqDq+wHJEMhvRF6JTkMJd0+/oz
	ghthVs3cgdpF5cRgBLgjLMNZooms4AJX5g==
X-Google-Smtp-Source: AGHT+IFtdkgHH6h7I/Od2S6DPC0fXHuRXv9nwI5diXqSpMvHGWXqvT0aoQqwnmmNU0Rn9ME2yTa9zg==
X-Received: by 2002:a0d:f487:0:b0:5e9:e423:8f2a with SMTP id d129-20020a0df487000000b005e9e4238f2amr5456017ywf.49.1703684277754;
        Wed, 27 Dec 2023 05:37:57 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id o4-20020a81ef04000000b005ea1eb81c8csm5230104ywm.116.2023.12.27.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 05:37:57 -0800 (PST)
Date: Wed, 27 Dec 2023 08:37:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>,
	Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
Message-ID: <20231227133754.GS2652760@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
 <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
 <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
 <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
 <CAFLszTja0nvhZz3b--TWXS4ABNPpJDPxUvY=9YsvbCN-DFgjbQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszTja0nvhZz3b--TWXS4ABNPpJDPxUvY=9YsvbCN-DFgjbQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=hdTAszuxNH5RpuyTuUB2"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1979

--Groupsio=hdTAszuxNH5RpuyTuUB2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 07:56:26AM +0000, Simon Glass wrote:
> Hi Sumit,
>=20
> On Tue, Dec 26, 2023 at 10:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > > > > >
> > > > > > > Prerquisite
> > > > > > > -----------
> > > > > > >
> > > > > > > This patch series requires devicetree-rebasing git repo to be=
 added as a
> > > > > > > subtree to the main U-boot repo via:
> > > > > > >
> > > > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetre=
e/devicetree-rebasing.git \
> > > > > > >       v6.6-dts --squash
> > > > > >
> > > > > > So, I've played with subtree a little and I think this is the r=
ight way
> > > > > > forward in these cases. If anyone wants to take a look at how t=
his works
> > > > > > in practice, take a look at:
> > > > > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-=
devicetree-rebasing-since-v6.1/?ref_type=3Dheads
> > > > > > In that tree I started with the v6.1-dts tag, sync'd all the co=
nfigs (to
> > > > > > have an example of a normal commit) and then did a merge of eac=
h tag
> > > > > > until v6.6-dts, so provide some history. And git log looks like=
 what I
> > > > > > want to see, the squash commit has clear references to what we =
are
> > > > > > getting and I make a merge commit that says what I did. If you =
pull the
> > > > > > tree and checkout the branch, all the code is right there alrea=
dy,
> > > > > > nothing further to do. Same with tarball releases. The only thi=
ng I
> > > > > > don't like is the size growth there, but we'll reclaim some of =
it when
> > > > > > we delete our obsolete bindings, and then obsolete dts files.
> > > > >
> > > > > I spent a bit of time with subtree as well, as part of reviewing =
this
> > > > > series, using the instructions Sumit provided. It seems OK to me.=
 We
> > > > > have to accept that it adds code and there will be changes/churn,=
 but
> > > > > it is not too different to accepting patches on those files withi=
n
> > > > > U-Boot. We will bring in files which U-Boot doesn't use, but U-Bo=
ot
> > > > > does support a good proportion of the boards supported by Linux, =
so I
> > > > > don't see that as a big cost.
> > > > >
> > > > > From my experimentation, subtrees seem to have no impact on build=
man,
> > > > > which is great. Am I missing anything?
> > > >
> > > > No it shouldn't cause any regression on existing tools/CI/build
> > > > systems. It is just a version controlled way of importing third par=
ty
> > > > source code as a tarball.
> > > >
> > > > >
> > > > > I still worry about the board-level 'switch' between U-Boot DT an=
d
> > > > > upstream ones. I believe that should be at the SoC level instead.
> > > > >
> > > >
> > > > Probably I wasn't clear enough in my earlier replies but this serie=
s
> > > > motivates for a SoC level switch only. Patch #7 is essentially a
> > > > switch for Amlogic meson-gxbb SoC and its derived boards.
> > >
> > > OK good...but that's not quite what I mean. You have a fragment like
> > > this in multiple defconfig files:
> > >
> > > +CONFIG_OF_UPSTREAM=3Dy
> > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"
> > >
> > > instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in th=
e
> > > Kconfig.
> >
> > Okay I got your point. It makes sense to me. I will do that for v3.
> >
> > > We should not have to specify the filename like this. It is
> > > laborious and error-prone.
> >
> > The only differentiation in naming here is just silicon vendor prefix
> > addition (amlogic/ in this case). The reason for this being that I
> > just want to mirror the whole silicon vendor directory from DT
> > rebasing rather than mirroring individual DT files. Given this do you
> > have any better alternatives?
>=20
> My current opinion is that a better approach would be to move the
> files first (in the U-Boot tree). That would be easier if we could
> just copy the Linux arch/xxx/boot/dts Makefiles but for now that is
> not possible. The Kconfig options for each SoC are similar but there
> are various differences.
>=20
> Having a different layout is just a pain and it will get worse, as
> people add new boards, since they need to know to add the correct
> directory.
>=20
> I will see if I can devise a small series to point this in what I
> consider to be the right direction, in line with Linux, and the U-Boot
> commit 3284c8b8 ("dts: generate multiple device tree blobs").

I think we should just go with the approach Sumit has already taken, and
encourage SoC maintainers to migrate sooner rather than later. There's
also nothing stopping people from adding vendor directories under arch/
at that point, and will likely have to happen anyhow for the case of
platforms that aren't yet in the devicetree-rebasing tree. I am hopeful
it won't be as much of an issue as my general feedback will change from
"what kernel release is this dts in?" to "why didn't you set
OF_UPSTREAM and use the existing tree?"

--=20
Tom

--Groupsio=hdTAszuxNH5RpuyTuUB2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWMKLIACgkQFHw5/5Y0
tyyATwv+LL4KES22fM+EkTw7HxD8j08r0M0nIId0bSIukvobtTPOSWvw0wOkurx1
DgPVdpT/4HvyloBq7d2X4ZqSuZNwsVRXM3i8Ou+wHlZ0elcu3ufJSKw20ccc8tjL
QGOk97cCDDsztYkjj5DARD0aIr8QETYCXSfJ+nLsv4Km22L0u61U78m8sK7GWd4g
GO12q6AO5gzPfMM++KC9Kyt8oCoVo2wJDQ/AHJmRG2eW0SDmlyF6oKLmJ5LJAwHG
a+N6wYh3EucXCrg4hHrtd8AfU3GR8PY6hWoEib+UJ7a14eGRhsKA+dODXCUWwk7w
zxtjneYVICqRiVxgNWO8XvJcmtb9ACNHIKKC9C8kPsQybyoMpbOCQLw0Gi+hQcWj
xDDqrMO/EqGkXAaJNhwqrejjPDEULdXljUkwZc6uSH5419P/Wgfcivg2VJ0ZD3o+
Ec44hM5OzbBRTFPGn1Km7Cyf3eydVoiBSUGt2DwzhPcy5NxIPMtlJg/NdCGLYaUu
LvCXN9Cq
=ymzN
-----END PGP SIGNATURE-----

--Groupsio=hdTAszuxNH5RpuyTuUB2--

