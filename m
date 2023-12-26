Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F05C47DD9
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web11.79532.1703585207880138876
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 02:06:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Td13WbYf;
 spf=pass (domain: linaro.org, ip: 209.85.210.44, mailfrom: sumit.garg@linaro.org)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbaf9b1674so2517744a34.2
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 02:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703585205; x=1704190005; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwYqrVss4rx/3369ml/cHpUW6C+437xQ56QfarLX3/w=;
        b=Td13WbYfmKMoMFcihwtVY9lpKKstbSgiWQpEzJFqeOB+OXt6cg0Y2SmJFYJbjkhuki
         B/uwrq2SNvgO0Qf9QO8tCZ5wXxLYl7lwTI3RNGMrqFCCtt/d4b4zjPogG4kwDkHNJcFS
         iMYUR1uFOyt4UsPO1UKggmmXxsMCEYk2/0vJGCJiptRvFMu2qIjojZQMbvRizHf6ZJnn
         LhHvYCstRtyOrCF+KsCN9v7i52nh4LywtZ8zbhLu49ierjuJ34/JA3X3Fy04O06pEjDN
         OOaKMmrYdUHJBwSHxlaBNdx6Ef+JlsQHGW/tSukKevwf2cbX9py4pZB08AQ1I+AY4BWq
         ToUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703585205; x=1704190005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwYqrVss4rx/3369ml/cHpUW6C+437xQ56QfarLX3/w=;
        b=tgwoPyrSItjkZnLgpHvNJNeiodhIVv4kDOBrwiLpcwQiVDxdQFPY7zO1hSzSQ07FH4
         trSUggj9Vw903wVKeHfLomEmWd3Mw30KxDuNldTFt3dw8MSXU7BUj6QB2irzuNzaX1Uy
         OokkPqyIOQJ9esaFNOupTIBZWeJNGzUr+GLxzR08/ziIwP6gXBEGsYWKZpqM2t5t1OHp
         fVUO8LunQJUlynm8o8DdBrnGcq/wmxGJg+1jUQk2v0axOH8ov9qOu1+nAvurQjSOMPwA
         Q7Bd+BP9HsaQwk8+uJrJR8+vobJhhS7eQagjQpjyNLucGNG6wtOEBj6BsjdJY2qHYgcg
         3cgg==
X-Gm-Message-State: AOJu0Yx+2/Ki0v6fF/xvHDC9x5FiBfeDY2gGdehPh4h5Ccx6Je/RJAR+
	wQp933M5A/c8S5xyEjVCBGdKwNpI3BndYrBJeHy0enz59B48jQ==
X-Google-Smtp-Source: AGHT+IGOCf6iyH9qDtCqhWkpbB2M9jH/KxGduWqYgcJv571IVFUd8od9vAceH2rervnApikYLj5wPxqv0jTgaXgIWVo=
X-Received: by 2002:a9d:66c1:0:b0:6db:9eda:f989 with SMTP id
 t1-20020a9d66c1000000b006db9edaf989mr3484283otm.25.1703585205084; Tue, 26 Dec
 2023 02:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat> <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com> <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
In-Reply-To: <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:36:33 +0530
Message-ID: <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1971

Hi Simon,

On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > > >
> > > > > Prerquisite
> > > > > -----------
> > > > >
> > > > > This patch series requires devicetree-rebasing git repo to be add=
ed as a
> > > > > subtree to the main U-boot repo via:
> > > > >
> > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/de=
vicetree-rebasing.git \
> > > > >       v6.6-dts --squash
> > > >
> > > > So, I've played with subtree a little and I think this is the right=
 way
> > > > forward in these cases. If anyone wants to take a look at how this =
works
> > > > in practice, take a look at:
> > > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-devi=
cetree-rebasing-since-v6.1/?ref_type=3Dheads
> > > > In that tree I started with the v6.1-dts tag, sync'd all the config=
s (to
> > > > have an example of a normal commit) and then did a merge of each ta=
g
> > > > until v6.6-dts, so provide some history. And git log looks like wha=
t I
> > > > want to see, the squash commit has clear references to what we are
> > > > getting and I make a merge commit that says what I did. If you pull=
 the
> > > > tree and checkout the branch, all the code is right there already,
> > > > nothing further to do. Same with tarball releases. The only thing I
> > > > don't like is the size growth there, but we'll reclaim some of it w=
hen
> > > > we delete our obsolete bindings, and then obsolete dts files.
> > >
> > > I spent a bit of time with subtree as well, as part of reviewing this
> > > series, using the instructions Sumit provided. It seems OK to me. We
> > > have to accept that it adds code and there will be changes/churn, but
> > > it is not too different to accepting patches on those files within
> > > U-Boot. We will bring in files which U-Boot doesn't use, but U-Boot
> > > does support a good proportion of the boards supported by Linux, so I
> > > don't see that as a big cost.
> > >
> > > From my experimentation, subtrees seem to have no impact on buildman,
> > > which is great. Am I missing anything?
> >
> > No it shouldn't cause any regression on existing tools/CI/build
> > systems. It is just a version controlled way of importing third party
> > source code as a tarball.
> >
> > >
> > > I still worry about the board-level 'switch' between U-Boot DT and
> > > upstream ones. I believe that should be at the SoC level instead.
> > >
> >
> > Probably I wasn't clear enough in my earlier replies but this series
> > motivates for a SoC level switch only. Patch #7 is essentially a
> > switch for Amlogic meson-gxbb SoC and its derived boards.
>
> OK good...but that's not quite what I mean. You have a fragment like
> this in multiple defconfig files:
>
> +CONFIG_OF_UPSTREAM=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"
>
> instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in the
> Kconfig.

Okay I got your point. It makes sense to me. I will do that for v3.

> We should not have to specify the filename like this. It is
> laborious and error-prone.

The only differentiation in naming here is just silicon vendor prefix
addition (amlogic/ in this case). The reason for this being that I
just want to mirror the whole silicon vendor directory from DT
rebasing rather than mirroring individual DT files. Given this do you
have any better alternatives?

-Sumit

