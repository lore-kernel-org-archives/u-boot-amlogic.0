Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A80C46CD2
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 14:23:04 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web10.38035.1702583338066398490
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 11:48:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=CMY1g64V;
 spf=pass (domain: kernel.org, ip: 139.178.84.217, mailfrom: robh+dt@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 79DFC623A9
	for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 19:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E64C433AB
	for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702583336;
	bh=2OHNBL0KPKCfkJjy/Jh3e6xj+lfQm31QP6cU9Jahnqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CMY1g64VE6ez+YShb+N2VYfddocbcAetaHpcpNt+wc0ZjpnLNzO7TYaIpK4NqhA3Z
	 FKkkt0ovfVFplW72yyKyB7lgy+BvhYdhjXYhHxQRkRuYMgCG/+7DwgYvnwA75eCavK
	 KlrqPSQzO+YGb4V4QU10XjsjG2FAV2wPN0WTFWYLVoKvawRfE88VErI+8lVMI3ponT
	 FiWdoxT844uhe1qMOZ/B1+zclM7SDAT/w5TWgpFwyhWen4jscmSG67IlqpagrQSDQh
	 TPyqmfOVloDWmxgC2bFJYLb+I1O+QlNIoes0n1lNZwP90sFDMTsL5s+SS47hkB5fY4
	 iUafBYzQLveJg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50c05ea5805so10069659e87.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 11:48:56 -0800 (PST)
X-Gm-Message-State: AOJu0YzmB/bKI6v0wfelHaz6ACRsMQQU2p+5GOW/o4Dhx2+Zf31SBu0e
	WJOzXemBczRM9u150J2MsFC3uscQBA7WkObnJg==
X-Google-Smtp-Source: AGHT+IGk07Ll7sLz9WnkpCtX+HV6f64vblwuyIyU6K4TjKkXDQdZBNh/F5RYnaKdXOWBgyvItMS+weZZ4ez9LWYf/TY=
X-Received: by 2002:a05:6512:3094:b0:50e:16c9:180e with SMTP id
 z20-20020a056512309400b0050e16c9180emr1080975lfd.34.1702583334706; Thu, 14
 Dec 2023 11:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org> <20231214182328.GQ2513409@bill-the-cat>
In-Reply-To: <20231214182328.GQ2513409@bill-the-cat>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 14 Dec 2023 13:48:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
Message-ID: <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, 
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1930

On Thu, Dec 14, 2023 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org wrote=
:
> > Hi,
> >
> > On 14/12/2023 14:50, Sumit Garg wrote:
> > > Prerquisite
> >
> > s/Prerquisite/Prerequisite/
> >
> > > -----------
> > >
> > > This patch series requires devicetree-rebasing git repo to be added a=
s a
> > > subtree to the main U-boot repo via:
> > >
> > > $ git subtree add --prefix devicetree-rebasing \
> > >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devic=
etree-rebasing.git \
> > >        v6.6-dts --squash
> >
> > So I think the big question is: when should the subtree be updated ?
> >
> > Because as we discussed in the previous GH pull request, if a bindings =
changes
> > was made in the upstream Linux DT, then the subtree update should wait =
until
> > the u-boot support is merged before updating. This could cause a lot of=
 frustration.
> >
> > And this could cause a lot of regressions, even more if both Linux and =
U-boot are
> > not maintained by the same people.
>
> I think some of the important questions to ask are, how often / likely
> are the breakages to occur? It seems like these days it's either:
> - U-Boot had an early version of the binding and we already state we
>   don't support backwards compatibility here. It should be on the
>   maintainer to be proactive in this case.
> - It's a "the DT was wrong about the hardware, sorry not sorry it's an
>   incompatible DTS change now". This too is hopefully the kind of thing
>   that at least board maintainers will be more actively aware of needing
>   to deal with in U-Boot, if it's really a problem.

A common issue in the kernel is with forward compatibility when
platforms add new resources from a new provider. Then the kernel
expects a driver for the provider and waits for the dependency. Of
course, older kernels don't have that provider driver and so the
dependency is never met. Not sure if u-boot will have similar issues?
At least you should/could know if the provider driver exists or not.
(The kernel doesn't because modules.)

Rob

