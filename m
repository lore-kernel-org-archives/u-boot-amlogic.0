Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FDC47DB3
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.122624.1703770656097980932
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 05:37:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=PMicOQzC;
 spf=pass (domain: chromium.org, ip: 209.85.215.170, mailfrom: sjg@chromium.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cda24a77e0so2159400a12.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 05:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703770655; x=1704375455; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ENGVDTflU/DKfO5ZTkIokNGqLKpQaRZg3/48qkXgKM=;
        b=PMicOQzCVF3MVl3OzxOQUFv64qlPODqJSj5qnV8CXnf4sbqz9EG9WsOg+kJvrwT+jI
         4bi7V8im0rxpBKM2JqbO2t76QVnqP28ShgoRigfZ54hO+7L2jXIY/7tywMz07hyRLllr
         MUZ0SslUfNshMUfwjpInapyHQA27wsttscM94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770655; x=1704375455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ENGVDTflU/DKfO5ZTkIokNGqLKpQaRZg3/48qkXgKM=;
        b=l3KY4Vk5oXTrxLxoI2GQ0h7vgeErsi8ZRLPEz6M7rEqaFdAlAGcRRf3co8v6wJ6TBO
         mzuc0e1eOkmmN8TOMWDtBEI3djiCnxNqrzXAlKRgyzwEHX8huptIkcqmCA7CZfMGwLaQ
         m9qyuRcpp8Je+zDwyCLh5L5UXs8Ya8LndYwtuoCaC5jTm20JxePZVCtJUMb3LMJyMTqc
         T2yupJ2oCok5KvfXykiyrMr9fOCbNjW55VMj5lTX0j6fXvw3WCIwvrm8umRuYYh3X4kq
         TKDRq4l6sV18szZOUSYueXF5oPofKQ3o/ZmRQvnJGWNZZElatAp8yuw5WdBVU/75YdnA
         HvNQ==
X-Gm-Message-State: AOJu0YyP7SZb7rywplkXbwpmRLZ5YP06/cfDJZrtmBRyqL2d2eD3GC/2
	/8vM80exW8RLgJo2rJx+wEpXGa+K4rL90kAsKn0oJgo2uzDn
X-Google-Smtp-Source: AGHT+IGS6LeeOd1bBV2eH7SmlBnlx0188IwriKBgUWYRFwDWOY9yw6W/2p2m9HFrgqNdC9VQw3gKzR0M4TGrk8/hZ18=
X-Received: by 2002:a17:90b:4c4c:b0:28c:aac9:3c7f with SMTP id
 np12-20020a17090b4c4c00b0028caac93c7fmr89897pjb.71.1703770655517; Thu, 28 Dec
 2023 05:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat> <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
 <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
 <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
 <CAFLszTja0nvhZz3b--TWXS4ABNPpJDPxUvY=9YsvbCN-DFgjbQ@mail.gmail.com> <20231227133754.GS2652760@bill-the-cat>
In-Reply-To: <20231227133754.GS2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:19 +0000
Message-ID: <CAFLszTjkHDPyOmt44qxsgjAap4ie=K9DeuyzAbd3zifS1pJCLg@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de, 
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1992

Hi Tom,

On Wed, Dec 27, 2023 at 1:37=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Dec 27, 2023 at 07:56:26AM +0000, Simon Glass wrote:
> > Hi Sumit,
> >
> > On Tue, Dec 26, 2023 at 10:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > >
> > > > > On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > > > > > >
> > > > > > > > Prerquisite
> > > > > > > > -----------
> > > > > > > >
> > > > > > > > This patch series requires devicetree-rebasing git repo to =
be added as a
> > > > > > > > subtree to the main U-boot repo via:
> > > > > > > >
> > > > > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicet=
ree/devicetree-rebasing.git \
> > > > > > > >       v6.6-dts --squash
> > > > > > >
> > > > > > > So, I've played with subtree a little and I think this is the=
 right way
> > > > > > > forward in these cases. If anyone wants to take a look at how=
 this works
> > > > > > > in practice, take a look at:
> > > > > > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-wit=
h-devicetree-rebasing-since-v6.1/?ref_type=3Dheads
> > > > > > > In that tree I started with the v6.1-dts tag, sync'd all the =
configs (to
> > > > > > > have an example of a normal commit) and then did a merge of e=
ach tag
> > > > > > > until v6.6-dts, so provide some history. And git log looks li=
ke what I
> > > > > > > want to see, the squash commit has clear references to what w=
e are
> > > > > > > getting and I make a merge commit that says what I did. If yo=
u pull the
> > > > > > > tree and checkout the branch, all the code is right there alr=
eady,
> > > > > > > nothing further to do. Same with tarball releases. The only t=
hing I
> > > > > > > don't like is the size growth there, but we'll reclaim some o=
f it when
> > > > > > > we delete our obsolete bindings, and then obsolete dts files.
> > > > > >
> > > > > > I spent a bit of time with subtree as well, as part of reviewin=
g this
> > > > > > series, using the instructions Sumit provided. It seems OK to m=
e. We
> > > > > > have to accept that it adds code and there will be changes/chur=
n, but
> > > > > > it is not too different to accepting patches on those files wit=
hin
> > > > > > U-Boot. We will bring in files which U-Boot doesn't use, but U-=
Boot
> > > > > > does support a good proportion of the boards supported by Linux=
, so I
> > > > > > don't see that as a big cost.
> > > > > >
> > > > > > From my experimentation, subtrees seem to have no impact on bui=
ldman,
> > > > > > which is great. Am I missing anything?
> > > > >
> > > > > No it shouldn't cause any regression on existing tools/CI/build
> > > > > systems. It is just a version controlled way of importing third p=
arty
> > > > > source code as a tarball.
> > > > >
> > > > > >
> > > > > > I still worry about the board-level 'switch' between U-Boot DT =
and
> > > > > > upstream ones. I believe that should be at the SoC level instea=
d.
> > > > > >
> > > > >
> > > > > Probably I wasn't clear enough in my earlier replies but this ser=
ies
> > > > > motivates for a SoC level switch only. Patch #7 is essentially a
> > > > > switch for Amlogic meson-gxbb SoC and its derived boards.
> > > >
> > > > OK good...but that's not quite what I mean. You have a fragment lik=
e
> > > > this in multiple defconfig files:
> > > >
> > > > +CONFIG_OF_UPSTREAM=3Dy
> > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"
> > > >
> > > > instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in =
the
> > > > Kconfig.
> > >
> > > Okay I got your point. It makes sense to me. I will do that for v3.
> > >
> > > > We should not have to specify the filename like this. It is
> > > > laborious and error-prone.
> > >
> > > The only differentiation in naming here is just silicon vendor prefix
> > > addition (amlogic/ in this case). The reason for this being that I
> > > just want to mirror the whole silicon vendor directory from DT
> > > rebasing rather than mirroring individual DT files. Given this do you
> > > have any better alternatives?
> >
> > My current opinion is that a better approach would be to move the
> > files first (in the U-Boot tree). That would be easier if we could
> > just copy the Linux arch/xxx/boot/dts Makefiles but for now that is
> > not possible. The Kconfig options for each SoC are similar but there
> > are various differences.
> >
> > Having a different layout is just a pain and it will get worse, as
> > people add new boards, since they need to know to add the correct
> > directory.
> >
> > I will see if I can devise a small series to point this in what I
> > consider to be the right direction, in line with Linux, and the U-Boot
> > commit 3284c8b8 ("dts: generate multiple device tree blobs").
>
> I think we should just go with the approach Sumit has already taken, and
> encourage SoC maintainers to migrate sooner rather than later. There's
> also nothing stopping people from adding vendor directories under arch/
> at that point, and will likely have to happen anyhow for the case of
> platforms that aren't yet in the devicetree-rebasing tree. I am hopeful
> it won't be as much of an issue as my general feedback will change from
> "what kernel release is this dts in?" to "why didn't you set
> OF_UPSTREAM and use the existing tree?"

OK.

But I do want to see a move to using the same dir structure as Linux.

Regards,
Simon

