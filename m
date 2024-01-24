Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B7C48277
	for <webhook@archiver.kernel.org>; Wed, 24 Jan 2024 12:49:08 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
 by mx.groups.io with SMTP id smtpd.web11.17542.1706081781251729205
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Jan 2024 23:36:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=n/01holA;
 spf=pass (domain: linaro.org, ip: 209.85.221.181, mailfrom: sumit.garg@linaro.org)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4bd3dcee54eso653018e0c.0
        for <u-boot-amlogic@groups.io>; Tue, 23 Jan 2024 23:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081780; x=1706686580; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XwLkLXos8arye6Q9LT/d+K7t8p5sAS/biFkdo8KW8M4=;
        b=n/01holAHd4wTnARY0isUqLQUiiZL56yFh4r8mwDOuAbqKJyxfJdxjy84HDukJyJ5w
         ew+4/ZaHWyEEiEXVm4SEvzwa6ktUC6U/oa6oirH8cY95DuuXyYp57Gc1Mx6hdaFXEhAC
         P2D4QZZe1xea529HlRjNKiFjtWVP2YjbwVidlE/wxenHsU24ClqayYf/kg0uPlgtvqKK
         4ExGvj7JWSJDVr61T0NULRg0569TGQ09DWJHI6rjSMadLWjHwR5SDvZ12HLSHbp6tQGN
         CPFLvVsBSf/5ExRKH5F3qc9ZfZ4zlkX2oKp83LrgbzglLxhzXxG8Q/+v9N/ec6HP7Qzj
         Qsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081780; x=1706686580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwLkLXos8arye6Q9LT/d+K7t8p5sAS/biFkdo8KW8M4=;
        b=IqXzHYqhjLLdwJGEQtwJ482FXGo7qLpkuJlhYyfZnfIMG2TOH7RG/f6nC/JKz1kK0c
         bHkpZtTZqf5+JD/bPXW5aMFaR6Gy81nLSvG7Dn9P2SwBJHjGVdHMV7Zg1naWKd58dpoh
         /mk3CMlyPMyMSGs7MqCAKdlMmg9RCIMRTawg7H45s4ZplEejgi19G4RoCVVsfqo+WxlM
         fVjjegZ28Q7nRATe1ul85ERnpf0ncgPXAeqCdGChKjLkS5YvP78ty/8bFWJa2zdY8fc/
         uqBLs1FkjWF8W1vTMfDlWQmpXmAp++X/LoMrFLhgdudGAzSx7A/eVVibCXWAnI8nBbfV
         WBxA==
X-Gm-Message-State: AOJu0YwZl3w1XzRZVvmtNANhjjzJWeYWJuE0f1mQLGnkKIewR7Eun+vf
	s4hEzB/9s9U7EBpgElnhiUWTMelKe4NWGnavLJPFm9uukkorK/HMdErA5pow+6G6Q+XjeP1/UnD
	GAE9wWhc0enOsYLFD2xnuFY3Cu0PDRskaiiA1LQ==
X-Google-Smtp-Source: AGHT+IGMpWXZhSjESRfcE+CaD4uCOdOSqylccXv8iswNuKTUjyEslIwh2ZXnMpAp0s8lRGZU2tE+BL9seLIjNn44Qls=
X-Received: by 2002:a05:6122:3685:b0:4b7:2382:b4 with SMTP id
 ec5-20020a056122368500b004b7238200b4mr516576vkb.6.1706081780295; Tue, 23 Jan
 2024 23:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de> <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <20240122000103.GE3652023@bill-the-cat>
In-Reply-To: <20240122000103.GE3652023@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jan 2024 13:06:09 +0530
Message-ID: <CAFA6WYMB_vpBHacNUARNa8q7c8BYn65rNoQNMNLeQ18Vh8T6+Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
	dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, 
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 12:49:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2082

On Mon, 22 Jan 2024 at 05:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Jan 21, 2024 at 10:41:51PM +0000, Caleb Connolly wrote:
> >
> >
> > On 21/01/2024 15:33, Marek Vasut wrote:
> [snip]
> > > Assume that there is some large breaking change in Linux 6.(n+1),
> > > something which would be problematic for specific U-Boot platform (e.g.
> > > i.MX) or would require a lot of work to sort out, will there be a way to
> > > temporarily pin DTs for specific platform to older DT version until that
> > > is resolved (e.g. pin to 6.n) ?
> >
> > (Upstream) devicetree has to be forwards and backwards compatible, were such
> > a breaking change to get merged without prior discussion with DT users (i.e.
> > U-Boot) then I think the correct course of action would be to revert it.
>
> The caveat is "unless it was wrong before", which happens more often
> than is generally thought of I think. I'm not sure off-hand the best way
> to deal with that.

I think that's the reason we just want to pull DT at once in the
beginning of the next window and allow U-Boot developers/maintainers
to detect and fix problems during the full U-Boot release cycle.
However, we are open to discussions for a revert if there is a major
DT ABI break among Linux major (.0) releases affecting many U-Boot
platforms.

-Sumit

>
> --
> Tom

