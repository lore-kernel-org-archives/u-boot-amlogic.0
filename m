Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD18C41535
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 14:23:04 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
 by mx.groups.io with SMTP id smtpd.web11.54390.1702620389532968810
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 22:06:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=zE9hcilk;
 spf=pass (domain: linaro.org, ip: 209.85.222.44, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7cb3f1d1ff4so830604241.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 22:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702620388; x=1703225188; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgQDb2dMpB2gLncYNtzo5iKnhAw3wUiPEOkXIqBOgMU=;
        b=zE9hcilkLdZI0eV8QI4DpG90+QkqX3x/+ApHqARrOtuHCtRGI3fXzPpYGc5uNwYXEh
         VVwl23lWC/72JiR0jJlIozEwRKZmDXEE8MFxCyTpCvV5BVb4h74TBaknx1xFia1hORCZ
         F9pbuw70BYITRu7XycNkLh8PBYk/+57WUFDAYgYZE/LdBE8XGy2WSiun6DbfajYixx8M
         TejwfuUN4xzp8ZkaAm16Pb4evWeGvLdd2C4oMlSPKbccK6E2ZDmVN1hlJEUH15XEYXDa
         lvdS1X/5+mfzAaYzbh2ZuUnBy6W6PNaRDxcqll32PI/vlqFYFn+gtWMoKaz06i3Ccfky
         stPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702620388; x=1703225188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgQDb2dMpB2gLncYNtzo5iKnhAw3wUiPEOkXIqBOgMU=;
        b=RtG8BMO7cLeUNFMs4V0efhrHcP1JAwvVEMO48Sam8qhj0JojqQSs4Ko5fH13NPjhm3
         kBii00cI7A3oIFhFWoRiurU9t2nx/fKES92OwK/7J7zMKhnR1u/8QxDoZ28BK4zy+ab0
         xyuTeqm9jGJrxPXqCi6JzbzaLFNjXnsA5Lw7TaYMVpJfpjFRkqFQGIck7VCtClNaE74k
         N0W5QUoslr4rx6noHkgNNk3eMcNEHHtZp8Y5pHp51+wp07KL7/Tw1vWRUoUjY0RFIV1S
         3hCqR7gLzmaEITPIN/qihG03e/u4AMZD+rHlV/5/nKiecrCfXhOxWHolx1arVA7FXjEz
         vy4A==
X-Gm-Message-State: AOJu0YyUWoi8cWfc9Pw2UYIXkWO7Elv7hfjfDAJq/YipJj+559JC2lwG
	2aCKi7iLNZ+6COBciQLAJQ1STK7J3qFN76dijj4Rgg==
X-Google-Smtp-Source: AGHT+IEaunAA8hpa6RM0FTyIE62dqupY6k0Ik8ie4irRPZ/LVR0m+5aZijZfz+Q6hyOhN2dAxWTxXFiPsXGV6gPGlrc=
X-Received: by 2002:a67:be02:0:b0:464:7ad2:2dc with SMTP id
 x2-20020a67be02000000b004647ad202dcmr9915243vsq.28.1702620388476; Thu, 14 Dec
 2023 22:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org> <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com> <20231214201511.GR2513409@bill-the-cat>
In-Reply-To: <20231214201511.GR2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Dec 2023 11:36:17 +0530
Message-ID: <CAFA6WYME3EGnedt=1ASm_mTzp+--OTjPSKvQG-Pj=9RbxgeYtQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Tom Rini <trini@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, neil.armstrong@linaro.org, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
	dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 14:23:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1933

On Fri, 15 Dec 2023 at 01:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 14, 2023 at 01:48:42PM -0600, Rob Herring wrote:
> > On Thu, Dec 14, 2023 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org w=
rote:
> > > > Hi,
> > > >
> > > > On 14/12/2023 14:50, Sumit Garg wrote:
> > > > > Prerquisite
> > > >
> > > > s/Prerquisite/Prerequisite/
> > > >
> > > > > -----------
> > > > >
> > > > > This patch series requires devicetree-rebasing git repo to be add=
ed as a
> > > > > subtree to the main U-boot repo via:
> > > > >
> > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/d=
evicetree-rebasing.git \
> > > > >        v6.6-dts --squash
> > > >
> > > > So I think the big question is: when should the subtree be updated =
?
> > > >
> > > > Because as we discussed in the previous GH pull request, if a bindi=
ngs changes
> > > > was made in the upstream Linux DT, then the subtree update should w=
ait until
> > > > the u-boot support is merged before updating. This could cause a lo=
t of frustration.
> > > >
> > > > And this could cause a lot of regressions, even more if both Linux =
and U-boot are
> > > > not maintained by the same people.
> > >
> > > I think some of the important questions to ask are, how often / likel=
y
> > > are the breakages to occur? It seems like these days it's either:
> > > - U-Boot had an early version of the binding and we already state we
> > >   don't support backwards compatibility here. It should be on the
> > >   maintainer to be proactive in this case.
> > > - It's a "the DT was wrong about the hardware, sorry not sorry it's a=
n
> > >   incompatible DTS change now". This too is hopefully the kind of thi=
ng
> > >   that at least board maintainers will be more actively aware of need=
ing
> > >   to deal with in U-Boot, if it's really a problem.
> >
> > A common issue in the kernel is with forward compatibility when
> > platforms add new resources from a new provider. Then the kernel
> > expects a driver for the provider and waits for the dependency. Of
> > course, older kernels don't have that provider driver and so the
> > dependency is never met. Not sure if u-boot will have similar issues?
> > At least you should/could know if the provider driver exists or not.
> > (The kernel doesn't because modules.)
>
> I think we'll be fine, but time will tell. And perhaps the more frequent
> re-syncing will make any sort of corner cases show up more quickly and
> be something we can figure out how to resolve going forward really.
>

Agree, frequent re-syncing is something we should aim for. However, if
required then we can always revisit our approach.

-Sumit

> --
> Tom

