Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7240FC47E49
	for <webhook@archiver.kernel.org>; Wed, 24 Jan 2024 12:49:08 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web11.17244.1706080513083709726
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Jan 2024 23:15:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ek2UIXfB;
 spf=pass (domain: linaro.org, ip: 209.85.222.54, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d130979108so1584199241.1
        for <u-boot-amlogic@groups.io>; Tue, 23 Jan 2024 23:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706080512; x=1706685312; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w9UUJ1jEIAu/OEb/uio8LthOlPcYqa+BWrMdRR8AkBs=;
        b=ek2UIXfBswDAHTJJJsFMbIMv6cpEJjBbQhtf+0Q458KOByEZK9DlH47Todow8VBOHx
         RzVt/mmcR6Ot8bfv5dMEi/3GnF1/AncKF7kxHB9WnGmdOLswq11GfyeFzp2KN42PxKpM
         PSgUsehrfoooZXJMvQRNbDp0PIAWD0xc66TVa93DnRquef9dXr689BHJNtlCo73JBnRI
         z8Gto81PoOHVexlPNd5GnTVWCF/Qfdw8TgY8gQPEWvGrDOp7/JBsIm77VfZldyMvUxpa
         1uG4CSmQ++Yz4uLAb1qi+hPILZm6ZzygfNcqS2w4C6FXATUCqMECbv+5BpQpu5awqC0/
         vimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706080512; x=1706685312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9UUJ1jEIAu/OEb/uio8LthOlPcYqa+BWrMdRR8AkBs=;
        b=Cas/HsCWWic/8US8ereloApZAidKE7S4GpErFcJWl458GwZwymelVB1lOte5lUL+Uc
         e25pXEmDraUNuQmotB7+cbGwRUyGXQYKHMJV4tLLWVuJZyMbHpjuA++RPBxsldvnQz8e
         joE/xwqKiNH+YlhkSBDnRZEZ86wK+oOkPDotxAhjGCbvHqu+V5MJqPZMcMben14w9BIn
         Df/qKlvUoq5Px3p/5RkHgksAkYVtxpyb6WBPevDBT82XDgdpAEEO2IizBQtf5nQjWAS+
         9vV4rAR3Wq5ipTaV77GWNT+38sCKbLZ8EkTiUIV/D50QfnOmKD7PI5frNXPHu1D+vWa5
         BUvg==
X-Gm-Message-State: AOJu0YxgymsWahrciOGOZcf6CE/QqdQC0kcAA1xu/SwL9LSG9rYQ00RI
	BB/Cqz59kHVckmuU8HAK5c7tPt8JJ+RbvOhnVH9PDq1CpUR2q00K9fpt4wSkp+dR29SA5+zPoid
	W8YcsCV8zxhyl9x5m8rLaPdHfiKNqqJ5lYrALcQ==
X-Google-Smtp-Source: AGHT+IFi3m9l3xzzoRFMwQTyK/1YmdgMta/UHyv7EC8M43XBFOV5580wzNYt4ga1l11FjlYWKFDqRwIgXPvU9Jb1ewE=
X-Received: by 2002:a67:edd3:0:b0:469:a64e:9748 with SMTP id
 e19-20020a67edd3000000b00469a64e9748mr3775148vsp.21.1706080512179; Tue, 23
 Jan 2024 23:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org> <20240119155646.qq7bvgmha6cyftkv@nullify>
In-Reply-To: <20240119155646.qq7bvgmha6cyftkv@nullify>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jan 2024 12:45:00 +0530
Message-ID: <CAFA6WYOkySPKN0JLgSOZrnDAFvGq92h4fwM2c81b8m2g1gVV3g@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
	mark.kettenis@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 12:49:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2081

Hi Nishanth,

Apologies for the delayed response as I was on a long weekend vacation.

On Fri, 19 Jan 2024 at 21:27, Nishanth Menon <nm@ti.com> wrote:
>
> On 16:05-20240110, Sumit Garg wrote:
> [...]
> > Prerequisite
> > ------------
> >
> > This patch series requires devicetree-rebasing git repo to be added as a
> > subtree to the main U-Boot repo via:
> >
> > $ git subtree add --prefix dts/upstream \
> >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>
> Please use https://

Okay I can do that given the widespread use of https://

>
> also what is the baseline? didn't seem to apply on (fails at patch #2):
> next f28a77589e75 Merge tag 'dm-next-7jan23' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
> master f7cca7ccc511 Revert "test: hush: dollar: fix bugous behavior"

Okay looks like recent merges caused conflicts, needs a rebase.
However, for v4 you can use this branch [1] for testing.

[1] https://github.com/b49020/u-boot/tree/v4_dt

-Sumit

>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

