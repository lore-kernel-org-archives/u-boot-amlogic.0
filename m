Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7421C46CC6
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 14:23:04 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web10.53937.1702620104205465419
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 22:01:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=uKnJ1nq8;
 spf=pass (domain: linaro.org, ip: 209.85.222.54, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7c495bec2f7so5492241.2
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 22:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702620103; x=1703224903; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcJQblX2tRhsjBQ/rNWBpIs3gF9ltfyBAlIHwqklz6U=;
        b=uKnJ1nq80bdEs1B6pHRGmoVNxllmDUfUYXd4z9o6Tg+BgpP174geQsLyjHFeJSlJaf
         H16gMRjToEvOEkW3ObWdgl03Hl2bsAGq75oGq7I1ESEfsv7Q0T0pOz03GcC7cJAaXMfO
         ZOmwkmPfg5ZaQNcU7pNYEVQkl7b/0ceJ2kkDvc3nfx3qq2ThATgrxESsP/jo6XqBPqb9
         XcBkV8FeYuTn/phrzQZI6BcYGq3HZZ0tyZLxoFN34hCAcPlEIHwNJW+D8gur9fEjxbjE
         KP4Aojv/Wd3MA64RB3neWpli0ZF1F2i9t0y1aALEl6QEGfaE2IZMFGRrVPxrQQUc9vvo
         g/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702620103; x=1703224903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcJQblX2tRhsjBQ/rNWBpIs3gF9ltfyBAlIHwqklz6U=;
        b=JWgDkQzVmGQ0p3Ei+bql09yDfgcxQFR890HZ+/7vihrp4YhvPVomd+CKDuM1CCCrk/
         Wly5f1dgOm+T75tMq83frqHfln3kQmDwOTTjvXap/nKOjWJ7XneuRaSfj2diXJXhB7Qi
         qn9fmM1Emwhs0rAhqcEOtdaOMkP9mwl8qbOvAzREUAyD964EZ5x65buWSbEAAwTtW5l+
         tn+rGiviYj3/Jd35lPFL+xEz8f4uzOkpGuLe9MGB686RTLmO9KZpT1TFTPZM/2PrUHRN
         fN8iHBB3gSzm+boR7E4O4nP0/XbLSfk+3Yc+tYCCPxqhvhpvMnH1iqlDsij6YTWIfmPy
         9vWw==
X-Gm-Message-State: AOJu0Yyjs8bmxzBsomhEfV8Kaz+rOEL0hkYHXagzrnPPoUj0PE5tMair
	3Gr31pm3qjrWWwHioCrAOrz+D+WZhdNyU/Fmb5yH6g==
X-Google-Smtp-Source: AGHT+IHHKVxY1ej0g59hmYXDCTJ+VKs3sGjwAjRtrimfYboEQVTcnzPUcOa5NYaxNiApZcJsxf5EVMtj/poQOzXCDaY=
X-Received: by 2002:a05:6102:94d:b0:464:959f:4e82 with SMTP id
 a13-20020a056102094d00b00464959f4e82mr4321802vsi.4.1702620103119; Thu, 14 Dec
 2023 22:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org> <20231214182328.GQ2513409@bill-the-cat>
In-Reply-To: <20231214182328.GQ2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Dec 2023 11:31:31 +0530
Message-ID: <CAFA6WYPvKnAEKkJM1rTQkYwA0zRKNy7rHDtRw2J_Ld7AKYXO4g@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Tom Rini <trini@konsulko.com>, neil.armstrong@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, sjg@chromium.org, caleb.connolly@linaro.org, 
	ff@shokubai.tech, daniel.thompson@linaro.org, dgilmore@fedoraproject.org, 
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, 
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com, 
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com, 
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 14:23:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1932

On Thu, 14 Dec 2023 at 23:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org wrote:
> > Hi,
> >
> > On 14/12/2023 14:50, Sumit Garg wrote:
> > > Prerquisite
> >
> > s/Prerquisite/Prerequisite/
> >

Ack.

> > > -----------
> > >
> > > This patch series requires devicetree-rebasing git repo to be added as a
> > > subtree to the main U-boot repo via:
> > >
> > > $ git subtree add --prefix devicetree-rebasing \
> > >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> > >        v6.6-dts --squash
> >
> > So I think the big question is: when should the subtree be updated ?
> >
> > Because as we discussed in the previous GH pull request, if a bindings changes
> > was made in the upstream Linux DT, then the subtree update should wait until
> > the u-boot support is merged before updating. This could cause a lot of frustration.
> >
> > And this could cause a lot of regressions, even more if both Linux and U-boot are
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

Agree, also per discussion with Linux DT maintainers, they do care for
DT backwards and forward compatibility. I expect the ABI changes to be
rare. In case there is an ABI change then it will be great if Linux DT
maintainers can ask contributors to CC corresponding U-boot platform
maintainers too.

BTW, Rob is already working on a tool to detect ABI changes as he
described here [1]. If U-boot platform maintainers have any ideas
regarding what would constitute an ABI change then feel free to share
those.

[1] https://lore.kernel.org/all/CAL_JsqLo4nXrJ93dDsfp3UYLs08V02aMnbCCnsDj0MBBomc35w@mail.gmail.com/

>
> So I would plan on grabbing only full kernel releases and in to -next as
> soon as possible. Our cadences don't match up exactly, but I think do
> fairly well enough.

I suppose that would give ample time to the U-boot platform/board
maintainer to fix any ABI change regression found in the -next branch.
That being said we aren't completely immune to changes to
devicetree-rebasing subtree. If there is an DT ABI change that will
take significant effort to fix in U-boot then we are open to accepting
a revert given that it will be fixed before next uprev.

-Sumit

>
> --
> Tom

