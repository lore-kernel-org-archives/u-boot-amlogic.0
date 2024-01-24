Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D9BC48260
	for <webhook@archiver.kernel.org>; Wed, 24 Jan 2024 12:49:08 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
 by mx.groups.io with SMTP id smtpd.web10.17954.1706084219314611875
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Jan 2024 00:16:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=RUVAgWuK;
 spf=pass (domain: linaro.org, ip: 209.85.221.182, mailfrom: sumit.garg@linaro.org)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4bd45397c17so288418e0c.2
        for <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 00:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706084218; x=1706689018; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kcu2qB5NydoTUxTRUtIRMPtVzR48LuxFWR1j3xm7f9o=;
        b=RUVAgWuKaSFUQVTSWTkxrs/bkXHZsmIBXLw2OwE+6raKnHHYOFhusVtF/5sqC8y0B5
         0cA46T0JzZ1ZQVv6LebwsZizAAb9lwNxB0twNKyHqHAgYlfkZ6HCvvV34wsBtPMg70rm
         kbyZ5eFCWMcmj8eRksJvp7OY4fVtAHGlw8BZ+A41+CGwGVb/ZV1J553AfOL2V9letGXd
         kdETdlAfhXAk5d3rz1Yrbojt1wTewjlZTyoLgEF5ABYKyAeeyNEzZqNmVfpxtUoPBYnx
         +6/8+0jy1DNk5sqOfJVvqAoOrQsECY13i0x9lQuQEsRD+72ioEbRjtF6sA+Nm6k9vvYM
         LbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706084218; x=1706689018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kcu2qB5NydoTUxTRUtIRMPtVzR48LuxFWR1j3xm7f9o=;
        b=LEmx2BOe2b5PBbRP0jWwAQeOz2jsXj+b/sbZ4IUHKX0+sCYeeQP2fionVQlF0k3kRI
         P9CW7lcvAKJ5G/4ABksQ250GRhHed0VUetE2xpkXkqEFeZYbjKtnAJ79T3uKrL/ydkv5
         QdI3bZtHxk6xl/jcGW5aXXP4R8DFyWI1kogreOKRjw3R79lGyWdsHbB8eqjQNfxryIFk
         9KEhpOdonbMzKstyr5WHU38BfvMZB7VCeNgBZJeHykivyBemkEzc1oP6f66M8tvlR4pO
         s8t/j4m4xb3j5ytFT4PRAD8D3Z+rBWHkiutxOpeOGNM+vyblCok9IKwVX2XcvCqFsLqo
         rqfg==
X-Gm-Message-State: AOJu0YwXyM7MfGZm+I1nKIOolw68yRdbHVcPvnBaLWTbbsj1spXdp0RH
	G9+0ijw/MdCa7dn/y22o7Q+U5I77tC847lK7YbMtufmq/9xZhYEHnYtKIFb5QeKH5q2JDtbyKeG
	7aEW+TYEDWXqDK7J7mjn83Fn03g0ib85yyzXUmg==
X-Google-Smtp-Source: AGHT+IEhYOR1QLdRCSuB6qqXqIl3m2xLIv+DZnR7s6FI5/rS9odFQ/SiLTTuZw83MelpqTowOf6wb1qZjroB7kki5Rw=
X-Received: by 2002:a05:6122:4499:b0:4bb:3b81:d21 with SMTP id
 cz25-20020a056122449900b004bb3b810d21mr3055698vkb.21.1706084218361; Wed, 24
 Jan 2024 00:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de> <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
In-Reply-To: <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jan 2024 13:46:47 +0530
Message-ID: <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Marek Vasut <marex@denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, trini@konsulko.com, 
	sjg@chromium.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor@kernel.org, neil.armstrong@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 12:49:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2083

Hi Marek,

On Mon, 22 Jan 2024 at 05:47, Marek Vasut <marex@denx.de> wrote:
>
> On 1/21/24 23:41, Caleb Connolly wrote:
>
> Hi,
>
> [...]
>
> >> How do you propose to handle fixes to DTs which are applied to
> >> linux-stable releases ? For example, if Linux 6.6(.0) ships a DT which
> >> has some defect that is fixed in 6.6.1, how will that fix get into
> >> U-Boot DTs ?
> >
> > This fix would also be in the latest Linux tags, so I think it would
> > find its way here - as I understand it patches aren't accepted into
> > Linux stable unless they land in torvalds tree.
>
> See the devicetree-rebasing.git:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/refs/
>
> That only contains refs for release versions (v6.6-dts, v6.7-dts etc),
> not any follow-up updates from linux-stable (like current 6.6.13 etc).
>

Here we should only consider fixes which are critical to U-Boot. I
think -u-boot.dtsi files would be suitable to carry those fixes until
next uprev. However, if there is a fix affecting many platforms than
we can consider pulling that standalone too.

> Would this require syncing in -rc versions of Linux DTs to get the
> latest fixes in ?

Syncing -rc versions makes U-Boot more prone to DT ABI breakages. So
its a chicken and egg problem as per your comments below. However, we
can revisit our syncing strategy based on how the current one pans
out.

>
> >> Assume that there is some large breaking change in Linux 6.(n+1),
> >> something which would be problematic for specific U-Boot platform
> >> (e.g. i.MX) or would require a lot of work to sort out, will there be
> >> a way to temporarily pin DTs for specific platform to older DT version
> >> until that is resolved (e.g. pin to 6.n) ?
> >
> > (Upstream) devicetree has to be forwards and backwards compatible, were
> > such a breaking change to get merged without prior discussion with DT
> > users (i.e. U-Boot) then I think the correct course of action would be
> > to revert it.
>
> Not really, this could be a perfectly valid change, and would work for
> Linux just fine, it might simply be pulling in something which is not
> supported by U-Boot just yet and therefore syncing the DTs into U-Boot
> would break U-Boot on that platform . Using older version of DTs for a
> platform could work as a stopgap measure until the functionality is
> implemented. Is this possible ?

For this particular reason we want to pull once during beginning on
U-Boot next window and allow sufficient time for platform maintainers
to adapt to it. However, OF_UPSTREAM=n can be an alternative for a
stopgap solution.

>
> > On a tangential note: as I understand it, DTs built from dt-rebasing are
> > still subject to U-Boot customisations via the "-u-boot.dtsi" include
> > files, this allows for dealing with incompatibilities due to missing
> > features in U-Boot.
>
> Would it be possible to auto-update those -u-boot.dtsi files during
> sync, to minimize the resulting DT blob delta before/after update, and
> thus also minimize the likelihood of causing breakage ?

In the long run the DT community would like to avoid any DT ABI
breakages at all. Rob is already working on a DT ABI check tool and
seeking inputs for what could be an ABI break [1] from U-Boot
perspective too. Feel free to provide your inputs.

Along with that we wouldn't need -u-boot.dtsi files once we make
U-Boot fully compliant with DT bindings. Until that point U-Boot
platform maintainers have to keep their -u-boot.dtsi files updated
corresponding to latest DT rebasing releases.

[1] https://lore.kernel.org/all/CAL_JsqLo4nXrJ93dDsfp3UYLs08V02aMnbCCnsDj0MBBomc35w@mail.gmail.com/

-Sumit

