Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219E8C48BC3
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 11:16:41 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
 by mx.groups.io with SMTP id smtpd.web10.39968.1707913585753609789
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Feb 2024 04:26:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=tUTJcpql;
 spf=pass (domain: linaro.org, ip: 209.85.222.43, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d130979108so2124832241.1
        for <u-boot-amlogic@groups.io>; Wed, 14 Feb 2024 04:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707913585; x=1708518385; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QeAh2Bxzf6Q03BdVMBH7AQRiMTnWi9uc5rSvT3XmW2E=;
        b=tUTJcpqlBMtk0aItC6VdPoSHG1NqTFHHvXJyPiERVyA2lXarkPPjaAmfDwEOyK4Sgf
         YNTI/qtz6PhU0/TloPoaT6pFsA75KyUA1+dfdhlvNLexYSu+I9bYn3YBjwVmlKKEm/fZ
         jsmPhcFH4c6kY0NA68jnDnPyneNy51KyjG8GozGTSe2dRWGGvqXz7nzwqf3dmkGp9Bif
         fLsZKg5nXs2MDf5mjSmt/4U8wDmxpe375mneB8Y4CIOt9y8yoLbifeNcTMF/SOsu3pJ2
         ZFTdaKUFgjV9gMcfQwFGXP8QLdgvYeHnOi8Vh/m88sh2QUXIiWVEOsIEedB6zheT6XPO
         WxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707913585; x=1708518385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeAh2Bxzf6Q03BdVMBH7AQRiMTnWi9uc5rSvT3XmW2E=;
        b=DPP0hkX2gkyyTGTUbDec+gdQjmvZtklpWpqHq8uPHEDTWL0rBRlnzIGEVAXX8XEqqB
         vKfOPJWFYuuTfzC+oDpDvZxC5nk1fLYbq5balFZbFUEVbr5caAL4xxFqAEvknFeIL8VV
         8aeiq9scB2Rkqz+Sm+kCeResnKBUBw9xaTEG1mKfUDjWNozjKO/2ATyRWHexPm3cgjaK
         vUmo9O4ERaaW1P3kuS/uFmzBefbqxjmbNQw/y/eSJKU0rjFK3DW0mJrakcOEDtcKIskK
         M24V3zj9HxuXATF6gSsB6apFr/JW+FJgMFnOfEpYGq25yasv86O1RhJw3HI4LOFec737
         MoaA==
X-Forwarded-Encrypted: i=1; AJvYcCWsK+mzdntDOejWnyJnudHlmSO6kj4oOHx3r0e1gNe1NSpR7k/oxQBc7IH7sjKT7RQ1TASflJJ6NvvBza47iGZFEjSY0mWRb2I=
X-Gm-Message-State: AOJu0Yx0SkyKUOJJxHHDNledU7v6z69du8I7Eq14Ik6U6xyiZ1h+Yurj
	h8Fzw9++JjbdVq6lrk85pislLNc8hY7qlMy03i2tWqisdUCEb09zaHUCHaSrnLvTBwwa0tdm53V
	KIyahjKm8DmQqJFUk4udyeHKMrLYyhHUGtQp3Tw==
X-Google-Smtp-Source: AGHT+IEyy4jD25PfDOYEll0F/6Sd8Gx4ugkGcfR44laO53Vb1eh0+AhVfpeEYgvgEBmtBJVz1dTI6wz0nDv21O1QUgU=
X-Received: by 2002:a67:f885:0:b0:46d:2f42:2601 with SMTP id
 h5-20020a67f885000000b0046d2f422601mr2347707vso.11.1707913584776; Wed, 14 Feb
 2024 04:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-7-sumit.garg@linaro.org> <ae946009-64a6-44bd-9034-b035684341a6@denx.de>
 <CAFA6WYPgRM8xPQcoJLemXcKvxekgZMRWkc7XG2hH5MFmUmhMZw@mail.gmail.com>
In-Reply-To: <CAFA6WYPgRM8xPQcoJLemXcKvxekgZMRWkc7XG2hH5MFmUmhMZw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 14 Feb 2024 17:56:13 +0530
Message-ID: <CAFA6WYM4puvz-Az5dpms98SDS44xhV7rJrSXq9jgCmEkGX9LDQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] dts: Add script to uprev dts/upstream subtree
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, 
	mibodhi@gmail.com, bb@ti.com, festevam@gmail.com, nm@ti.com, 
	andre.przywara@arm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 19 Feb 2024 11:16:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2126

Hi Marek,

On Tue, 6 Feb 2024 at 11:50, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Marek,
>
> On Tue, 6 Feb 2024 at 05:51, Marek Vasut <marex@denx.de> wrote:
> >
> > On 2/2/24 14:05, Sumit Garg wrote:
> > > dts/update-dts-subtree.sh is just a wrapper around git subtree commands.
> > > Usage from the top level U-Boot source tree, run:
> > >
> > > $ ./dts/update-dts-subtree.sh pull <release-tag>
> > > $ ./dts/update-dts-subtree.sh pick <commit-id>
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > How are the fixes which land in linux-stable handled now ?
>
> Firstly, all the fixes land in the Linux mainline tree, then at every
> rc* release those would be mirrored into devicetree-rebasing repo. And
> then if there is a critical fix to address DT ABI breakage for U-Boot
> (for at least a single board) then they just need to notify us with
> the fix commit ID to be picked up. Or if people are willing to use the
> dts/update-dts-subtree.sh script themselves then we are happy to
> accept patches too.
>
> BTW, we will also work with Linux DT maintainers to improve DT ABI
> maintenance towards U-Boot.
>
> >
> > Do I have to duplicate the work which is already being done by the
> > linux-stable maintainers ?
>
> No, we don't have to backport all the fixes as they will make their
> way automatically via the next subtree pull. As above we are only
> concerned about fixes which are required to maintain DT ABI towards
> U-Boot.
>

Gentle ping. I hope my comments above address your concerns.

-Sumit

