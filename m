Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F2C54E67
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:38 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
 by mx.groups.io with SMTP id smtpd.web11.25049.1709304840422203641
 for <u-boot-amlogic@groups.io>;
 Fri, 01 Mar 2024 06:54:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=BGleraEc;
 spf=pass (domain: linaro.org, ip: 209.85.222.42, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7dad2d1c9edso994689241.1
        for <u-boot-amlogic@groups.io>; Fri, 01 Mar 2024 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709304839; x=1709909639; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8a6gwz+4kECklsxG9tY4ZGKIuUUT3fCgDi4EGSlyEcc=;
        b=BGleraEcD8Scy8un93IUbWcoMsdqQsdxnD2XcMISB1vx80pDmVmpHyilJNQXtoFNPS
         GBFF131tX9ihEUhhAPOzpaTSrJh34y5cF/yo3zOFBETCYFNZKu4TY2HrQoxkcx9AeGgk
         UOJ/XrTdgWonQif1HBCw1uZDXW73mXmXPRA4qiCfbkOmxldhdXLMFV93nft9mTMcdhU3
         Gi65nPGEetVDEm14coi40Pnva6CJ8nqCzYW0M4/hw3GiqtvjkqnWuYZB/HxieF2jsc+l
         QAeJzyZdDCwREM+s/Ebb9R0W+5lL7FZmG01uKabVH35jOS5hkJjkjNSJuNqs0ey/OuKk
         LdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709304839; x=1709909639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8a6gwz+4kECklsxG9tY4ZGKIuUUT3fCgDi4EGSlyEcc=;
        b=ZC54LBOSf5fML1VxDjuCwFI7v4m75gTTSnL5iTR2ZJNQWfXG6kBfHs3YjCV8afbfRa
         XU2aV+jCJWZTZMZLzGWyWtVihWYRxQv7whXFGOA0wuvxYEK4m7cJWOqKGVKEjCVea/0+
         /prInhzStCBuE5ozlR0U7L3pkR7FsGP0+cFYH5ZT+kiu7pyfTw+03PLDzjAgiVpocgGm
         OI91hMruYCpEDKe7o8q63TexwIlsxwZNLWiEQ7MoiCe8jUT5YwiByasPOFmEwwR8kUWu
         r/er3uNhpR9WnA+EdsyguT/B/w6G8AM1elayr/txT2BD6JR1+OY2poVNU/b8++06ZUe8
         o31Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnRjLrAMGVLfVgR9zb34yNAZgXZKKoYqFfoq0fYemvQ14ua+yXSSw44Gt3dOr7CIoCmaei24C5GfsTAXFYobWmj1KyPQ5CX+c=
X-Gm-Message-State: AOJu0Ywi/shbXGbToad5wQkQZCJTrA4ktumQbb1gjlmeZDBZ6sECMvkG
	VsmHwdse8gnTTKIr1jVJTtNlR+4be8UaR8y0LExCLxQUoYFxtsKdAoCd0StNUjtAP8BVxFjTeMV
	n6piknm2crPx7pwNV1q4Q1LvMGsmhH0R/0PKXPA==
X-Google-Smtp-Source: AGHT+IF9KjM5YPdbhw8JwwBKAju62yFFF+HvTtJ+ArTAhyqnA9ei87OXd9thQUazPbonvMBSlpwniskBzu7Bj+m68vk=
X-Received: by 2002:a05:6102:2758:b0:472:69ab:f7bf with SMTP id
 p24-20020a056102275800b0047269abf7bfmr1390880vsu.9.1709304839441; Fri, 01 Mar
 2024 06:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAFA6WYMBMQH10cHnsfmC5efkkohfzftz=6u0N4RMXrVrByZzOw@mail.gmail.com> <0ef45d67-1428-4d8a-b157-2ee65a3c9948@linaro.org>
In-Reply-To: <0ef45d67-1428-4d8a-b157-2ee65a3c9948@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Mar 2024 20:23:48 +0530
Message-ID: <CAFA6WYOb3B6unesNLMJrqQihJK7ydwUkJPO3Aa6kn0+SC6T2oA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within U-Boot
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
	dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com, 
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com, 
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
	nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk, 
	paul.barker.ct@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2154

On Fri, 1 Mar 2024 at 19:18, <neil.armstrong@linaro.org> wrote:
>
> On 01/03/2024 14:30, Sumit Garg wrote:
> > On Fri, 1 Mar 2024 at 18:27, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:
> >>
> >>> Changes in v6:
> >>> --------------
> >>> - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> >>> - Patch #3: Incorporate fix for sandbox CI failure.
> >>> - Patch #6: Incorporate shell script comments from Marek.
> >>> - Patch #8: Incorporate documentation review comments from Paul.
> >>>
> >>> [...]
> >>
> >> Applied to u-boot/next, thanks!
> >>
> >
> > Thanks Tom and everyone involved with the reviews. I hope we can carry
> > forward from this effort towards a healthy devicetree story for
> > U-Boot.
>
> Thanks Sumit!
>
> I'll try to submit patches for Amlogic GXL & G12A to switch to this!
>

Thanks Neil for your support to be the first volunteer for this
OF_UPSTREAM switch.

-Sumit

> Neil
>
> >
> > -Sumit
> >
> >> --
> >> Tom
> >>
> >>
>

