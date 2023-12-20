Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9CDC47072
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.web11.19398.1703071592992475210
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 03:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=yLE9FmOA;
 spf=pass (domain: linaro.org, ip: 209.85.217.49, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-466871ed570so774158137.2
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071592; x=1703676392; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LilU9MTXpQFvcRtIxC4+1nN1E0nnvpiW3FEndOqTiVk=;
        b=yLE9FmOAuphK2MnoURcI+ZmHOf/Ez16kgwPCSrDQSsgrMBYDIbF3mS6CDRe6RC8G6A
         +8Yy3b7lmzNGYE7SMx6E3mOPChRHlmzIqAjlPBhbJn9cEa29XZfjbdx9RRVJJrn2CRKH
         K/GlnJ0FMVbiALe+1AGQMC+UrpwY1bf2DFk78zEV+LX50v/d1X42l3THvAu2X1pUDDR0
         WsyrCrM3vlHfMyZ5ljTw0brbZ2zfu9lIgP/MmcXg73X4qEEfgn8+2N6KzGX6I7ExMk3b
         rr5Nh/m+wYvKGqYc0wgWAsubivcZ2Mx6fqEgnYsrJ/hRPEBTbDWQ0wuxuQSIZsMyGjh+
         EDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071592; x=1703676392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LilU9MTXpQFvcRtIxC4+1nN1E0nnvpiW3FEndOqTiVk=;
        b=MQH6E5ncapzsx1Y2Mcl4d5q1Uyv9gbp0hr3mlAzw/yDp2U2EYEkN5BM19tVZo/Dtbp
         vJj07wGM6KMxGiF2C5iR3QxV3gJYT0fYJHLjggCocRLCM28N+BYbYARewl4SYe/QEgOu
         m8gV0AYettg3MKmGMPyseJJi7YH+XXJz7/vV2rzGERZ8GU5yB7ArqjM4EARyFlNjqzi3
         72RL35Hvst4kv0fX3sQD8BR0RYcWJ7EEmzqIOau3IdzRMeOMs5zB62LA6EhbQiunqIDL
         n4M7dvDAgUvoKV7vz9SKAi5BO5+e1r4/ff8JJv/H6zh6p0hpBJIAmic6vt2Q87AsFcYY
         wWcg==
X-Gm-Message-State: AOJu0YwLOS9jUdNq7HbDA5bX9wMDs5kBob39Ln1fcAzcmL2qcmynhZsM
	27lG2INQ38P9fZCVc+a7vDl3WE7gio8sKH53ioanXzwd7dfVKxkNkhE=
X-Google-Smtp-Source: AGHT+IEQD5Mzukt5P428mdL46BkVUeHxSkiIXEnGI6LEgACV3Aw9rXHqG/BSxrCcNEj9wRanZzV+mnRsjrtZxtV8GF0=
X-Received: by 2002:a05:6102:3706:b0:464:89f2:801e with SMTP id
 s6-20020a056102370600b0046489f2801emr16409275vst.29.1703071592006; Wed, 20
 Dec 2023 03:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-2-sumit.garg@linaro.org> <20231214142713.GZ2513409@bill-the-cat>
 <CAFA6WYNNpTeaPkrZiHHYChQ2EnFByH6DyeqfCn5=c0+C452Shg@mail.gmail.com> <CAPnjgZ0jzaNUmvUEQVAGdtv1_UKO=_VHJ8HtkofJXu6gFBVXXA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0jzaNUmvUEQVAGdtv1_UKO=_VHJ8HtkofJXu6gFBVXXA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 16:56:20 +0530
Message-ID: <CAFA6WYOA7umuYv08aqVSS_PgXA7t+hGB7TaH=xLQrm8-s-Gv4g@mail.gmail.com>
Subject: Re: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for CONFIG checks
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1955

On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Thu, 14 Dec 2023 at 07:46, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 14 Dec 2023 at 19:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 14, 2023 at 07:20:56PM +0530, Sumit Garg wrote:
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  .azure-pipelines.yml | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > index d6f3fa423c6..f100c4493e6 100644
> > > > --- a/.azure-pipelines.yml
> > > > +++ b/.azure-pipelines.yml
> > > > @@ -65,7 +65,8 @@ stages:
> > > >        # have no matches.
> > > >        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
> > > >                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> > > > -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> > > > +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> > > > +                  exit 1 || exit 0
> > > >
> > > >    - job: docs
> > > >      displayName: 'Build documentation'
> > >
> > > The GitLab tests needs an equivalent change.
> > >
> >
> > Sure I will do that in the next spin of this patch-set, thanks for catching it.
>
> Also, please add a commit message with that :-)
>

Ack.

-Sumit

> Regards,
> Simon

