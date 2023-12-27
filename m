Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DF3C47DDB
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web11.97386.1703663743715297895
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 23:55:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=mp/Hxfru;
 spf=pass (domain: chromium.org, ip: 209.85.219.47, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f7aa55bfeso43719766d6.2
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 23:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703663742; x=1704268542; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe02f8gts957zQmo3qHZ8/LkcgZ6iqzFKUr+psTGqHs=;
        b=mp/HxfruzC4DeSlDBgLsWpePWKN6yirf2uqS/ooGqB8xgAGX9XzvJpgQ/Ob1DgSHSj
         91hPPhLkwT7ja2Yjf5QvYfHA5u4D7tXKbHX2es5DirGKlyD7B46RUZ0ga7pYzo7DKcrL
         t6Wp6pz+siWjIWIPVJptkJUpaGIcL1jgGSpfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703663742; x=1704268542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe02f8gts957zQmo3qHZ8/LkcgZ6iqzFKUr+psTGqHs=;
        b=RQ7ha3Qz++dmZgWRdXHTD52zADxAwiX3eRE97E6md12fG7/weATGfboOtkoZ0sL+96
         84FS0ndTIlRWsidk9U0vd6WFbPAvkjucoylJLjw1qxNV9qjM5iGEAcPu6/UK25CmGiTu
         3UcJSa8MuAReDHEkqDdsbcvpjasNoxhZnQ6AsWNCUUHWb8UN/eajkW1x5M4f7P8+Y73q
         OMNQND0qIMbd+YQTJPiDQsHrxEhveVQWMoFMiR4Ev+8EaeqktTe+4ZpQq2cg51V05dmW
         gR00Tn3rx8HNYIPCANKDagXFSK+gXqSDuW6xG0swqGQgaV1JyfQlHTMK7EHSvpMIRa5T
         3uWA==
X-Gm-Message-State: AOJu0YxvwQr9jBuQIrrrVLvHYOywGZPtT+6EXGboGHbK4PM4xFe+raO8
	cKte/wJdep+Y5nNWTPm9wGQ/ltGWl4vfQtorATGfTIj4TdnL
X-Google-Smtp-Source: AGHT+IHSplKOn7j58iJ/D9umh9JsoR3PeRP1B8K/Ii0L//2a9Nnq/8C5jVEfdyOXsexdegjHzjZVYMcCGY4/E8b4bEI=
X-Received: by 2002:a05:6214:dc1:b0:67f:1f0c:b30e with SMTP id
 1-20020a0562140dc100b0067f1f0cb30emr13030206qvt.32.1703663742784; Tue, 26 Dec
 2023 23:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-4-sumit.garg@linaro.org> <CAFLszTiPbM-fofbNaTO3vtTWNTOee_pO7-_obKxmP=oChD-8oA@mail.gmail.com>
 <CAFA6WYO=2Ba7FsXh7=Eg_J77w=sVmxOC-_=XNQH4JaquQoBPSQ@mail.gmail.com>
In-Reply-To: <CAFA6WYO=2Ba7FsXh7=Eg_J77w=sVmxOC-_=XNQH4JaquQoBPSQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 07:55:32 +0000
Message-ID: <CAFLszTgeHGyVXs0HChZwRjtaJT8YBft11hs98vopQyR9f_YH4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1976

Hi Sumit,

On Tue, Dec 26, 2023 at 10:09=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Fri, Dec 22, 2023 at 6:12=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > Allow u-boot to build DTB from a different directory tree such that
> > > *-u-boot.dtsi files can be included from a common location. Currently
> > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > location.
> > >
> > > This is needed for platform owners to start building DTB files from
> > > devicetree-rebasing directory but still being able to include
> > > *-u-boot.dtsi files.
> > >
> >
> > This is a v2 patch but I don't see a change log?
>
> I usually prefer to keep change logs in the cover letter [1].
>
> [1] https://lore.kernel.org/all/20231222061208.3009970-1-sumit.garg@linar=
o.org/
>

As a reviewer I much prefer to see the changes with the patch. If you
use patman you can have both, I suppose.

> >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> > >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >

Regards,
Simon

