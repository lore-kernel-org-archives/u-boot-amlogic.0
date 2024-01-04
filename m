Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCD1C47E49
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
 by mx.groups.io with SMTP id smtpd.web11.50597.1704361631791607557
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jan 2024 01:47:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=XlG6yGLH;
 spf=pass (domain: linaro.org, ip: 209.85.217.45, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-46781bd40f8so62395137.1
        for <u-boot-amlogic@groups.io>; Thu, 04 Jan 2024 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704361631; x=1704966431; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHZwDYoNMFPVA25b7NOqeSAKVTxxSc+i2wmwXPEeZT0=;
        b=XlG6yGLH/dYIHvXJ65XEaYvCnLu0sHpkY++gboHdbh4R2w6QSCPE/Jqq0OhReATQmG
         S0ZdhQRQnHLu/o3DTSIyYVIGufoAYGA+YEc8bBp6ezwdV1DfrcH+VNPUezfxsdmCUpUI
         luHrfsLJDj5rbW1KG0JN0UAO5x4qwSR5ZJA1glQ6uzJy2Zh7R9Fv3jgEMwi8c55TyyIz
         +1Kgv34VwA3YcCT4mypD3hU2w3BMVv1SdFOFwoew9NeWSGmMLPbePDiFk4rWHlOncydw
         18FUr0gVk4UWuI0cDbwyRXV7JT9xzBQGn0WEpGhqwd6mCzIYrBZq7z5zbOeBHEjZwzVX
         8IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704361631; x=1704966431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHZwDYoNMFPVA25b7NOqeSAKVTxxSc+i2wmwXPEeZT0=;
        b=wLo+bdboqdoCln8WrCuIowaK12m2zBE6J7NE7GuS9DM2Laa0BXyU7Q29mFTbW65jhy
         XfkQ95YFBqVeuarTWGIaJCoUioI8A9zUzfRT1sg9PMJdosCkMoGSWoEsRQ1U8g8GtoRZ
         zbgHro/EZzdb2pyp6O2M0hiZoOFHXTvdanlGehYRpe3dBLPS5h1ymvOSXEjSx29bqRLB
         5NFIlltvnpq9qfrrxg7z2u1l5hbRuQe3S809dcEtGJroXPU6TSgL0b13LX7XKyh90jZB
         40vCeT+4uLM8owP4YKu2yVAXYtiRBGgPQ2eYUAJo/O/sPZj4/YP9H4e6yW+iScCtvM2/
         I7gA==
X-Gm-Message-State: AOJu0YxizzQ++xaB6lNNk0g+FuJ63cwRH0lxSK0pM9zV2Asjw++3OVct
	1ooVRY9fjH7gZJYYjpKtBitDns42nTKgGAMIvuBOOvBNe1GvEw==
X-Google-Smtp-Source: AGHT+IHsJ4CzNzuWTNQdpodd65d/UMi85rNeRQobF5UzndKFXN2h2BPyXNlG8sJU/m1Z1Bcgv/043M7G7PqzkXVKfk8=
X-Received: by 2002:a05:6102:50a5:b0:467:ab62:cb43 with SMTP id
 bl37-20020a05610250a500b00467ab62cb43mr147932vsb.13.1704361630740; Thu, 04
 Jan 2024 01:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org> <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat>
In-Reply-To: <20240103163201.GL1610741@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Jan 2024 15:16:59 +0530
Message-ID: <CAFA6WYOhbnOsAFQCTNZT-6_Xb_G7cxWOmCDoo+c5aKkxSWxOvg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
To: Tom Rini <trini@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2034

On Wed, 3 Jan 2024 at 22:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> > On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> [snip]
> > > +In order to maintain devicetree files sync, U-Boot maintains a Git s=
ubtree for
> > > +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It i=
s regularly
> > > +kept updated with every new kernel major release via subtree pull as=
 follows::
> >
> > I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
> > had in the original repo). I don't think it's relevant.

Sure, as Tom pointed out below that we would shift to put subtree as
dts/upstream for v4. Does that make sense to you?

> >
> > We're not likely to regenerate the tree, but any clue what 'git
> > subtree pull' would do in this case? It could happen if we switched to
> > git-filter-repo.

Yeah we just need to modify the prefix as:

git subtree pull --prefix dts/upstream \
       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-=
rebasing.git
\
       <release-tag> --squash

> >
> > > +
> > > +    git subtree pull --prefix devicetree-rebasing \
> > > +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/dev=
icetree-rebasing.git \
> > > +        <release-tag> --squash
> >
> > I'd put this in a script to run. Documentation tends to be not quite
> > correct. A script could also be smarter and figure out <release-tag>.

Sure, I will do that for v4.

>
> Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
> something using subtree, I do hope to learn some lessons from what you
> do there. The first thing is that given the size/nature of the commits,
> I had figured I'd be the one doing this as a subtree pull+squash then
> push, rather than posting to the ML since it'll be huge and
> un-reviewable, but with a note sent off to the ML that people should be
> aware the next sync has been done and retest as needed. But Sumit, were
> you planning to do some of this instead?

I am happy for you to do that. I am happy to assist in case any conflicts o=
ccur.

> The second thing is that if we
> move the subtree part in to dts/ instead (where we will still have the
> Makefile/Kconfig we have today and then our Makefiles within the
> directories, this might get more complex and so really require a script
> to keep it from getting error prone?

IMO, we should give subtree a try and later if it becomes complex to
manage then we can switch to a custom script as well. It is
essentially a sub-directory which we start initially to manage via a
subtree approach but later we can switch to a custom script to sync
that subdirectory if there is a need.

-Sumit

>
> --
> Tom

