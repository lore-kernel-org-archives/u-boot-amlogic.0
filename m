Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6435C48BC3
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 12:04:31 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
 by mx.groups.io with SMTP id smtpd.web10.10652.1707828940599171143
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Feb 2024 04:55:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=JkYGQ34b;
 spf=pass (domain: linaro.org, ip: 209.85.222.48, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso1506542241.3
        for <u-boot-amlogic@groups.io>; Tue, 13 Feb 2024 04:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707828939; x=1708433739; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKAqb5BB4ThicEtIXQ2hB7H/qkuXbuPPr1DUJLEmmM0=;
        b=JkYGQ34b4/f4FENauTpJbmAeK6i15Di1J3kG9LeJF2DakOitaSD5oC5OfaS9JrauoZ
         Bv38eXzb340hheXdPpNVe0MZiq8YQPe5Zwu8gT7R+lKxsr/xCUt7takcjIt/Z5NYAAE/
         1LCmusmq+oD8fV2u0IQsi0gksvnGvm6mdxqLqaXBKNT0exHpMWexSQOiOnK0xoPYp7j2
         qJB6eIHiSA5Ip662ojun1jiCEeqNND8OETE4roJwJjRDZFTOhkO/XdJ/UJn64sqhIsit
         5rvPK2CGIv4WDdJIQpoxNmwQWZSeglG46c3Ms0+WWoFgLkC10TWnoFfGb6T5kg5pFSs1
         aUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828939; x=1708433739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKAqb5BB4ThicEtIXQ2hB7H/qkuXbuPPr1DUJLEmmM0=;
        b=uXUeecz/ywVw4m6mukFqEVIVZezwrQUjR62FDCU8cHtft6Q1MoWZ7TBSHOMXRos2qD
         a9vCXUComG1eGhwklpGoui1tRB+J4bOWbxB71RMYwYZPuIR/Q+GJWzKp4H9YLNnDparK
         Zk1fhucnhNMx8kF63TT1VPjmG57zG8nH+s0iQxyh0qFXoX6a9I8DfQYiDrgQ2BVB3lfI
         ctjyVmMbqsqvbzL/mIaCCRO4Uny7Vap7/0u8SeWR3VHNwUvVsKr3db6fA6DmNG8xPFid
         Md/pQZyibusDP3ZyG1pxNgYEGDxk/V9qU8jTgiotdnAuyaPSz7mbNpM9sChTckQmO6TB
         hkww==
X-Forwarded-Encrypted: i=1; AJvYcCVj6WuIP/PmdTLiFKP8nmgVIvWQM47OSMG30HtzPsfDyhAJ1G6aoDIRqLyOVzT1rAcepCc5C7RtJUPZnEenNpca1q5BI6+KAi0=
X-Gm-Message-State: AOJu0YxaI0p8duTldNI4+FzhvIcfYViWoHjA2/qL6DphENorXwDkdVj8
	1bzGSqGPRo5/SZ8sB2LQeTfutxM6uPRk6w4gKYEt9dtCTGxdxRjvWbHjO42iWa6RhkfxrYLUJC1
	fq9t/VM76SEKETjMDd1Qp153KWM9i7+k3Lm6bSg==
X-Google-Smtp-Source: AGHT+IHWKOhjF275RalgVa0+g7kD4n88jlZyyM5pb99xK+mNXT5Hri5z7e9jyvf2Rt24Wk6jz0JCkL/zhcVxRsVwaYA=
X-Received: by 2002:a67:fe86:0:b0:46d:2f8b:d7 with SMTP id b6-20020a67fe86000000b0046d2f8b00d7mr6848813vsr.22.1707828939594;
 Tue, 13 Feb 2024 04:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202180226.GF1152441@bill-the-cat> <CAFA6WYMSvu0rL+et1Q7xVuOnyWMDbJYQj9TeC6c2ALNNFGhRCA@mail.gmail.com>
 <20240206130040.GO1152441@bill-the-cat>
In-Reply-To: <20240206130040.GO1152441@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 13 Feb 2024 18:25:28 +0530
Message-ID: <CAFA6WYNFrazifArec7+NS_exU77TFfCWcJk7Oy26tkeX6Q2a+w@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] An effort to bring DT bindings compliance within U-Boot
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
	nm@ti.com, andre.przywara@arm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 14 Feb 2024 12:04:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2125

On Tue, 6 Feb 2024 at 18:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 06, 2024 at 10:57:12AM +0530, Sumit Garg wrote:
> > Hi Tom,
> >
> > On Fri, 2 Feb 2024 at 23:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Feb 02, 2024 at 06:35:23PM +0530, Sumit Garg wrote:
> > >
> > > > Changes in v5:
> > > > --------------
> > > > - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> > > > - Created v5_dt branch for testing purposes:
> > > >   https://github.com/b49020/u-boot/tree/v5_dt
> > > > - Patch #6: Added support to cherry-pick fixes in subtree update script.
> > > >   Also, used https:// instead of git://.
> > > > - Patch #7: Fixed inappropriate documentation update.
> > > > - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
> > > >   tree.
> > >
> > > OK, for v6 please push this through CI. I've started a run now to check
> > > other things, but just sandbox currently fails to build right now.
> >
> > Yeah it looks like patch#3 rework in v4 has broken EFI capsule .dtsi
> > file generation logic which should be fixed by add-on fix [1] for
> > patch#3. The github CI passes [2] with that included. I suppose the
> > gitlab CI should be fine too. If its fine for your testing as well
> > then I will incorporate it in v6.
> >
> > [1] https://github.com/u-boot/u-boot/pull/484/commits/d796c34307cd363674e0d0d2e31618643ac8e76c
> > [2] https://github.com/u-boot/u-boot/pull/484
>
> Yup, if Azure passes GitLab should pass too. I think you should wait to
> repost v6 until you and Marek agree about how we are (and perhaps
> aren't) handling fixes to dts files.
>

Although I haven't received any further feedback/comments but will
wait for a few more days before posting v6.

-Sumit

> --
> Tom

