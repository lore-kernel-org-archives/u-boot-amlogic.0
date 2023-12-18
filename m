Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FD0C46CD4
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 08:39:44 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
 by mx.groups.io with SMTP id smtpd.web10.38826.1702881983262200476
 for <u-boot-amlogic@groups.io>;
 Sun, 17 Dec 2023 22:46:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=HgPd5LbW;
 spf=pass (domain: linaro.org, ip: 209.85.222.52, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7cbc56a8023so445939241.1
        for <u-boot-amlogic@groups.io>; Sun, 17 Dec 2023 22:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702881982; x=1703486782; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXuyzRtg4+Ai+dDAvgnTTx5D8olQjGvQjtsLS+JC/fU=;
        b=HgPd5LbW+Kz+jtED4rXI2lG8g40x5V8niYmBISBP0L+DVtlpgv6dNEbGPjnBgDLgnT
         66DMVBqArgtLPlbgF6f0VRmXA6ZvxA0x7BcEahdTW5b6nxou+EUkzOeVoSdMY+pPfdh8
         ereRahe6FmkBcoi8hbi4DmSCJJVQ9Jm6HG32he8WUZBS0dkbhTCWQ727arPwBG3Apj0W
         Ri1jgEFcL45GH8uLafw0a1F3go6Xkpvd8f1wocjs3Xba1SPDyg0o+QWPBzDvzIgZphyD
         /CvSMvWxiJ29vxeaQez0nBhzqmJ5WcRB2fGPFlWLhWw2XjAUt4R6BMsJ/AjFBpepQAed
         1p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702881982; x=1703486782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXuyzRtg4+Ai+dDAvgnTTx5D8olQjGvQjtsLS+JC/fU=;
        b=EajdwFz7/HTQ9AhewnlWMZsjs27z0+bGfIaXdO8sF5ymHA/EyiXPHLLWvgWuLj2LHp
         WTnE5NtKEQEHNvU5xkOziPHO3q6tRG2k6Ou/qhRvyxRNkNZvOnEq2Yzh5c8lppQ2H/K/
         mgiE2tiIGBFDdU0Arc5LdLQw72mjd0N2VHUUhkgT3Z6PsvfwOIMKiA+4i42kJbc0yjLB
         BVLPG/EwP09eOMZSOxker7UCKV7Jrt+lsRbaegwiLNXTM93u7TF/xyZqObniLqDWO52p
         dCUkEBO4wcUQcIOSksf1QpSUwFBxFX88sk8tirqS/9bPNy11z7XBN85Tu6RAtILBnDRn
         t9ZQ==
X-Gm-Message-State: AOJu0YwE17VV6fi+ln+pXLyrv0Iiju6hdScAYI22lqg42ENKm2fAgZx9
	aqeSJrCCEZgwJCf/X1mzZDUDLBaObSmhXi2gpn115Q==
X-Google-Smtp-Source: AGHT+IEh0f2Zh5kMNzCsOrQWJz4RFNvVZQNLBS0NxnrIt7AOZJC9udA0Ui3v+UDSH0yMmcaWvaY6pAle2Bl7vt2/+8E=
X-Received: by 2002:a67:fdcf:0:b0:466:88e5:c563 with SMTP id
 l15-20020a67fdcf000000b0046688e5c563mr1427365vsq.0.1702881982104; Sun, 17 Dec
 2023 22:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org> <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
 <0a143e84-5379-4455-b3c8-dc97beb9514c@linaro.org> <20231215133743.GV2513409@bill-the-cat>
 <20231215-sputter-puzzle-128dc9f85d73@spud> <20231215191954.GA2513409@bill-the-cat>
In-Reply-To: <20231215191954.GA2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 18 Dec 2023 12:16:10 +0530
Message-ID: <CAFA6WYM3mybKOm_F_J4knCDJ5bn7gwL8=vQPYXL_AhtEmRwL=g@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, neil.armstrong@linaro.org, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, caleb.connolly@linaro.org, 
	ff@shokubai.tech, daniel.thompson@linaro.org, dgilmore@fedoraproject.org, 
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, 
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com, 
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com, 
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 18 Dec 2023 08:39:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1943

On Sat, 16 Dec 2023 at 00:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 15, 2023 at 02:45:11PM +0000, Conor Dooley wrote:
> > On Fri, Dec 15, 2023 at 08:37:43AM -0500, Tom Rini wrote:
> > > On Fri, Dec 15, 2023 at 08:50:51AM +0100, Krzysztof Kozlowski wrote:
> > > > On 14/12/2023 20:48, Rob Herring wrote:
> > > > >>
> > > > >> I think some of the important questions to ask are, how often / likely
> > > > >> are the breakages to occur? It seems like these days it's either:
> > > > >> - U-Boot had an early version of the binding and we already state we
> > > > >>   don't support backwards compatibility here. It should be on the
> > > > >>   maintainer to be proactive in this case.
> > > > >> - It's a "the DT was wrong about the hardware, sorry not sorry it's an
> > > > >>   incompatible DTS change now". This too is hopefully the kind of thing
> > > > >>   that at least board maintainers will be more actively aware of needing
> > > > >>   to deal with in U-Boot, if it's really a problem.
> > > > >
> > > > > A common issue in the kernel is with forward compatibility when
> > > > > platforms add new resources from a new provider. Then the kernel
> > > > > expects a driver for the provider and waits for the dependency. Of
> > > > > course, older kernels don't have that provider driver and so the
> > > > > dependency is never met. Not sure if u-boot will have similar issues?
> > > > > At least you should/could know if the provider driver exists or not.
> > > > > (The kernel doesn't because modules.)
> > > >
> > > > If some U-Boot platform decides to aggressively sync with kernel DTS,
> > > > then probably the kernel subarch maintainer should be aware of it.
> > > > Mentioned forward compatibility issue is a result of assumption that
> > > > there are no out-of-tree upstream consumers of our DTS. I am certainly
> > > > not aware of any such consumer for Samsung. If someone told me (me
> > > > wearing Samsung hat), hey U-Boot now cares, I would start caring as well.
> > > >
> > > > The usual argument of contributors wanting to break the backward and
> > > > forward compatibility, is "there is no other OS depending on this"
> > > > (recent discussion with Johan about order of interrupts:
> > > > https://lore.kernel.org/all/ZWcPZPX-eT-xHAOv@hovoldconsulting.com/ ).
> > > > You need to tell the maintainers of that platform, that now they have
> > > > other OS/firmware/bootloader depending on DTS compatibility.
> > >
> > > I think this hints at one of the bigger impacts this might have.
> > > Reminding everyone that other projects do use the device trees and have
> > > for years.
> >
> > TBF, we do try to ask these questions as much as possible, usually (for
> > me at least) citing U-Boot or the BSDs as users. It largely seems to me
> > like we are all bark and no bite though, so a project like U-Boot having
> > a defined "schedule" as you suggest below would add more meaning to our
> > questioning.
> >
> > > Without rehashing history, BSD does use the trees as-is and
> > > for platforms U-Boot supports they are supposed to be re-synced
> > > periodically.
> >
> > I know this is the theory, but I also know that how well this is
> > implemented varies wildly per-platform. I generally don't pay all
> > that much attention to the various arm platforms, but I do pay
> > attention to what's going on for RISC-V and there appear to be no
> > active maintainers of individual platforms and the architecture
> > maintainers are not aware of the status of the equivalent patches
> > for Linux when they apply patches.
> >
> > In recent memory, this has lead to the clock indices in the DT
> > differing between U-Boot and Linux for one such platform, which, IMO,
> > is an insidious difference that is hard to spot during review and highly
> > unlikely to crop up while comparing dts files, since the defines were named
> > identically. To be clear, I am not expecting the architecture code
> > maintainers to be aware of the minutiae of the various RISC-V platforms,
> > but rather suggesting they might have an easier time reviewing if both
> > projects' dts files and binding headers were tied together.
> >
> > That said, automatically synced devicetrees will, as has been pointed out,
> > require the platform maintainers in Linux to be more aware of the affect of
> > what they accept on other users, but it will also require the equivalent
> > maintainers on the U-Boot side to engage too, so that the "upstream" dts
> > files do not change in a way that screws the usecase in U-Boot.
>
> Yeah, it will hopefully lead to better coordination between maintainers
> in some places. There are SoCs where the kernel DTS people are the
> U-Boot DTS people too. All in all, I should probably CC more people than
> I usually do on these resync patches just to try and head off any
> tricky changes like you've mentioned above.

Makes sense.

>
> > Also, if people send fixes to the U-Boot copies of these devicetrees,
> > would the plan be to request that these are sent to Linux and the fixes
> > pulled in via a resync after each -rc release of Linux (or similar, just
> > throwing some example schedule out there)?
>
> The way we've always tried to operate is that changes should be pushed
> to Linux and resynced down, or at least submitted simultaneously. If
> there's some specific bugfixes that need to come in out of cycle I
> _think_ subtree handles cherry picked commits in a reasonable fashion.
>

Agree.

-Sumit

> --
> Tom

