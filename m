Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8DEC5475B
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:38 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
 by mx.groups.io with SMTP id smtpd.web10.22619.1709299856546478091
 for <u-boot-amlogic@groups.io>;
 Fri, 01 Mar 2024 05:30:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QGnun/T4;
 spf=pass (domain: linaro.org, ip: 209.85.217.54, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-47277f4db4bso551472137.0
        for <u-boot-amlogic@groups.io>; Fri, 01 Mar 2024 05:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709299855; x=1709904655; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fmW+Gom+bQZQ9DAn5I4HIlirJESHqzEAWADW2X4dBGQ=;
        b=QGnun/T4npbSccyOGfH3i9ZrTQ3nbO+de0KvWReZOYgTmTDS1Xwph3OIpCyJBOnXRW
         jaGL3s2Xo/ssbgUx2oykCNa2+zDfAGeBnUNJFiY140OIEfqfAEH2rjiG8FRh+KHv8dzH
         zO0z5cCaaUxEBjF6FrCS37xerO8j/Mquk5FZkPuMtEnN/O7NHZdwG/YzDyoYdlx9lX1q
         hzyBWqmzcbHIS9d56DnaHh3wRGoXy23C8vH58s1bVyQ+4zLsrWZFo6mpecY5G000N7FE
         hCjPctOESRtRvgMximBrpCraA1ovmd+v1IDtwucI0lYmkPvUiBhBkGziI6OxD/zAaQni
         H8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299855; x=1709904655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmW+Gom+bQZQ9DAn5I4HIlirJESHqzEAWADW2X4dBGQ=;
        b=rPXG7HjDM5Bw9LuddQTUn1OQqmQamkSAS6rpAfbLsQUinhst3VPnSXIwji2rWffZRR
         sqs1FUzRniJpnc8r0p8Sspzh8FDBoG2oZWNYVn02ay4MbZANeD5p3F3ZcfbegjvcxiFa
         KisRAI2wkuH6jDxgi0IhQjyimIcuUj+411RdMOTwxs926NPYb0WMYz4xzNRAd3aN/7tt
         ZZSYoyho10TMuxcO9I3guHTOrmR/glX0jwgquV54fbPCJ3+NoWiSX23UGbHbFh+wEzE9
         PIDMe+LuMJGTATWcErUh/Ch4S6YwTPEvgmVm+XXdobXJnqebvQ8H3igDHkSD6QStM2Qq
         7b6A==
X-Forwarded-Encrypted: i=1; AJvYcCXFIp+Qk09JVIE4jGOh5dvG/zjBgY4pze0KjNqiF9k6XIfDcTJooHCgltVwF+s1yFZw38+KX7MmIwSuG3GCTDXaeExqdxUadRM=
X-Gm-Message-State: AOJu0YwTJyvy7fiyEAmcfFQfPZB6/qx7Ou0q7jLM2TE9SVU/YKnOUO4H
	7IFfpMmgJOfyezazZc+8O0wkjdWE++uUrz6AQ9n9GtZVNdf5p/7ff55MZFEI3lgZXDZmc7c09rP
	wCqYXz21agEZ2IUHdH66Y5aLQ78MUJTVIRYRimw==
X-Google-Smtp-Source: AGHT+IERYN6FD+ce26rlSrhxwegOZictuCUZmOkr0vsqMniZ6brEcuJ3cqv+Fr4oghr0FA+r7sP5efET26N5AfxoigI=
X-Received: by 2002:a67:f8c3:0:b0:472:9ce3:dccb with SMTP id
 c3-20020a67f8c3000000b004729ce3dccbmr1122941vsp.30.1709299855481; Fri, 01 Mar
 2024 05:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org> <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
In-Reply-To: <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Mar 2024 19:00:44 +0530
Message-ID: <CAFA6WYMBMQH10cHnsfmC5efkkohfzftz=6u0N4RMXrVrByZzOw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
	nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk, 
	paul.barker.ct@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2153

On Fri, 1 Mar 2024 at 18:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:
>
> > Changes in v6:
> > --------------
> > - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> > - Patch #3: Incorporate fix for sandbox CI failure.
> > - Patch #6: Incorporate shell script comments from Marek.
> > - Patch #8: Incorporate documentation review comments from Paul.
> >
> > [...]
>
> Applied to u-boot/next, thanks!
>

Thanks Tom and everyone involved with the reviews. I hope we can carry
forward from this effort towards a healthy devicetree story for
U-Boot.

-Sumit

> --
> Tom
>
>

