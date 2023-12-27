Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C227C47DDC
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.97399.1703663798171005871
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 23:56:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=NO8nJekx;
 spf=pass (domain: chromium.org, ip: 209.85.222.174, mailfrom: sjg@chromium.org)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78104f6f692so383332385a.1
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 23:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703663797; x=1704268597; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=908n8smTq7NiCgOaDnozfw9wemBndKn7Bo7vptgt5mk=;
        b=NO8nJekxNdy3xMhHoWEjOd/y8BJX7nABSWf+t0q39BcLtd4o9bSNptl+51X/4Ssyjr
         sKkIQHSLYd0iNmeeoMW0QKx73I39l9wKEDbKMEpojifuZi7pNjBK4HwCsd0u20Bh8wpM
         cota4KSLNcDtA0LtT+8v6wtkX0SSjpsi1+mvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703663797; x=1704268597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=908n8smTq7NiCgOaDnozfw9wemBndKn7Bo7vptgt5mk=;
        b=RKhQ8i5lVG4NNdY8vQR86lOeE3OSvrtbV1fwN8Kuo0R4PGx/GQ3GdOhyslCTxcZze3
         5Z5snbg6M/PyTfH/9fOIOyqzMIvQzDhK5X9aDjoQIF6++cXj9CIIwMl74H6dFtGtIZcF
         slePHP5lS8y+4mv/lLWRxx3UferWGeXByotAKwwgdVLPRnrBV7zq5wiATootYf/Hoqdh
         6eKdMOHKFRzolIrfSQoDKJcQe3LxloPf4OmekDe0tcP+59Ltm3CB+pknkjgWFWFpHH+y
         jNOjHAwPcQlwpXoAdyh29EbUabOvxaJ+UPMTFjO4KhiO7ii8M9JW8w5wiLujWmPys+ta
         aBbQ==
X-Gm-Message-State: AOJu0YyhBYolgw6GIBJ15J09yepB9tF0oy4KNwgpFqA0UZM0szH1Cpq2
	jiMqpoKXLqN0xsKS0Xj8a/FhY+W1HY8r8cYzhj9FIgbefGG/
X-Google-Smtp-Source: AGHT+IHvRboulb3rKLuWj9QYeyYRX5MKfLHo4Qu1wlkxJ2bMptuU/WSxipC2jGOKPLoIh6pl38XBrsUJ5xUSdrb7l2U=
X-Received: by 2002:a05:620a:24d5:b0:781:1c15:6992 with SMTP id
 m21-20020a05620a24d500b007811c156992mr14908170qkn.26.1703663797210; Tue, 26
 Dec 2023 23:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat> <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
 <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com> <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
In-Reply-To: <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 07:56:26 +0000
Message-ID: <CAFLszTja0nvhZz3b--TWXS4ABNPpJDPxUvY=9YsvbCN-DFgjbQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Sumit Garg <sumit.garg@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1977

Hi Sumit,

On Tue, Dec 26, 2023 at 10:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Hi Simon,
>
> On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > > > >
> > > > > > Prerquisite
> > > > > > -----------
> > > > > >
> > > > > > This patch series requires devicetree-rebasing git repo to be a=
dded as a
> > > > > > subtree to the main U-boot repo via:
> > > > > >
> > > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/=
devicetree-rebasing.git \
> > > > > >       v6.6-dts --squash
> > > > >
> > > > > So, I've played with subtree a little and I think this is the rig=
ht way
> > > > > forward in these cases. If anyone wants to take a look at how thi=
s works
> > > > > in practice, take a look at:
> > > > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-de=
vicetree-rebasing-since-v6.1/?ref_type=3Dheads
> > > > > In that tree I started with the v6.1-dts tag, sync'd all the conf=
igs (to
> > > > > have an example of a normal commit) and then did a merge of each =
tag
> > > > > until v6.6-dts, so provide some history. And git log looks like w=
hat I
> > > > > want to see, the squash commit has clear references to what we ar=
e
> > > > > getting and I make a merge commit that says what I did. If you pu=
ll the
> > > > > tree and checkout the branch, all the code is right there already=
,
> > > > > nothing further to do. Same with tarball releases. The only thing=
 I
> > > > > don't like is the size growth there, but we'll reclaim some of it=
 when
> > > > > we delete our obsolete bindings, and then obsolete dts files.
> > > >
> > > > I spent a bit of time with subtree as well, as part of reviewing th=
is
> > > > series, using the instructions Sumit provided. It seems OK to me. W=
e
> > > > have to accept that it adds code and there will be changes/churn, b=
ut
> > > > it is not too different to accepting patches on those files within
> > > > U-Boot. We will bring in files which U-Boot doesn't use, but U-Boot
> > > > does support a good proportion of the boards supported by Linux, so=
 I
> > > > don't see that as a big cost.
> > > >
> > > > From my experimentation, subtrees seem to have no impact on buildma=
n,
> > > > which is great. Am I missing anything?
> > >
> > > No it shouldn't cause any regression on existing tools/CI/build
> > > systems. It is just a version controlled way of importing third party
> > > source code as a tarball.
> > >
> > > >
> > > > I still worry about the board-level 'switch' between U-Boot DT and
> > > > upstream ones. I believe that should be at the SoC level instead.
> > > >
> > >
> > > Probably I wasn't clear enough in my earlier replies but this series
> > > motivates for a SoC level switch only. Patch #7 is essentially a
> > > switch for Amlogic meson-gxbb SoC and its derived boards.
> >
> > OK good...but that's not quite what I mean. You have a fragment like
> > this in multiple defconfig files:
> >
> > +CONFIG_OF_UPSTREAM=3Dy
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"
> >
> > instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in the
> > Kconfig.
>
> Okay I got your point. It makes sense to me. I will do that for v3.
>
> > We should not have to specify the filename like this. It is
> > laborious and error-prone.
>
> The only differentiation in naming here is just silicon vendor prefix
> addition (amlogic/ in this case). The reason for this being that I
> just want to mirror the whole silicon vendor directory from DT
> rebasing rather than mirroring individual DT files. Given this do you
> have any better alternatives?

My current opinion is that a better approach would be to move the
files first (in the U-Boot tree). That would be easier if we could
just copy the Linux arch/xxx/boot/dts Makefiles but for now that is
not possible. The Kconfig options for each SoC are similar but there
are various differences.

Having a different layout is just a pain and it will get worse, as
people add new boards, since they need to know to add the correct
directory.

I will see if I can devise a small series to point this in what I
consider to be the right direction, in line with Linux, and the U-Boot
commit 3284c8b8 ("dts: generate multiple device tree blobs").

Regards,
Simon

