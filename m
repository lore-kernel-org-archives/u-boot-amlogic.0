Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AFEC48260
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
 by mx.groups.io with SMTP id smtpd.web11.53516.1704374564654551443
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jan 2024 05:22:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=VivVAwfZ;
 spf=pass (domain: linaro.org, ip: 209.85.217.46, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-466fb179334so88108137.1
        for <u-boot-amlogic@groups.io>; Thu, 04 Jan 2024 05:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704374563; x=1704979363; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asv8qeswAKq7BKnD8orOSDPcF1sohzHxrXvdZv0mnJc=;
        b=VivVAwfZGE78OvUy27ts/QxfmUGLqcUdlGnGJE/aPVHuXJX0OxK+PrFPkiXA9eJAIF
         LcbrMqzxkYCrVdnOp/Tupp7zL8uA7+SBgEbNqMJduOeR91AplHN4E+mPKjdh62df8V6l
         tmzyrPD8SexrefqlUIzvJKCF/C2VE1E4kJoDZNWrY7+5LYphH7AUjeVE4HRi3fXKKLXo
         SnCROiw+hqGtzAU1SRy0nuYqO7zTDVubrTrjOYMiDgO2JyVSYrJZrcR/0gJSOF5NlJ8K
         IeNXqCj/uCH1SOxhz0M/c/ST0qnJYT4s8rxX9t5lmbten6hHkdUNnbeo6imiAx/eK9pd
         9SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704374564; x=1704979364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Asv8qeswAKq7BKnD8orOSDPcF1sohzHxrXvdZv0mnJc=;
        b=Kj39elpusdmydU8pYcUv0PWYwSGxxolasllHWD/H1/iVSbxHcpIOAmNCVY5yNqQBXz
         KEi/qc7QueUEVL9jM0itCOABP7iwEFZxmMwamCYZUJIsHsRvcNjqvN6vnJ2bBnknGhiJ
         FeHwIDAEDX4KNyrs0pWHxEJBjKuTiBO0er2vWsW/+c0FCjwa0iwKrQGyLRZRCuu6H5ar
         wlZfTSe0VvgQ0ULBNj3v2SHuQ2rPQRMh6OzESiL5Kae4HHQoqMI33BfriUU8E/wg51Dq
         PtDVBhaKO0Cj/CjMzSkED8kk5EFCq9dvpYCF66iiMF51u9/XVa2kbWhWjXuIGi5eZqN5
         pl0A==
X-Gm-Message-State: AOJu0YyJwkVIDcFuOzAlTjeyxMtw9MA+DLzHob+A69Oizi0//pKWnIJv
	TiLF4g4fc/SE91fOQjmT4RFEwOtMJFu3fsjW7lDOOHj5RpZJPA==
X-Google-Smtp-Source: AGHT+IGdwk0pHmNwzwuC7yddW7jwpIUi756aoUoeTp0g3JBbUqOrpeHlcKuiLbYu4H4nRUy7jrmpdz1S0Ahnh8BflF0=
X-Received: by 2002:a05:6102:cd0:b0:467:504:a19e with SMTP id
 g16-20020a0561020cd000b004670504a19emr362819vst.32.1704374563696; Thu, 04 Jan
 2024 05:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org> <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat> <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
In-Reply-To: <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Jan 2024 18:52:32 +0530
Message-ID: <CAFA6WYP6p=eVtmnS=Qd8xv+nCSFvzREMnRHFkLzEzENnvTxv+A@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2038

Hi Michal,

On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 1/3/24 17:32, Tom Rini wrote:
> > On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> >> On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > [snip]
> >>> +In order to maintain devicetree files sync, U-Boot maintains a Git s=
ubtree for
> >>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It i=
s regularly
> >>> +kept updated with every new kernel major release via subtree pull as=
 follows::
> >>
> >> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
> >> had in the original repo). I don't think it's relevant.
> >>
> >> We're not likely to regenerate the tree, but any clue what 'git
> >> subtree pull' would do in this case? It could happen if we switched to
> >> git-filter-repo.
> >>
> >>> +
> >>> +    git subtree pull --prefix devicetree-rebasing \
> >>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/dev=
icetree-rebasing.git \
> >>> +        <release-tag> --squash
> >>
> >> I'd put this in a script to run. Documentation tends to be not quite
> >> correct. A script could also be smarter and figure out <release-tag>.
> >
> > Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
> > something using subtree, I do hope to learn some lessons from what you
> > do there. The first thing is that given the size/nature of the commits,
> > I had figured I'd be the one doing this as a subtree pull+squash then
> > push, rather than posting to the ML since it'll be huge and
> > un-reviewable, but with a note sent off to the ML that people should be
> > aware the next sync has been done and retest as needed. But Sumit, were
> > you planning to do some of this instead?  The second thing is that if w=
e
> > move the subtree part in to dts/ instead (where we will still have the
> > Makefile/Kconfig we have today and then our Makefiles within the
> > directories, this might get more complex and so really require a script
> > to keep it from getting error prone?
>
> I played with this series and didn't really have time to dig into subtree
> mechanics but one thing I see is that when squash and merge happens you c=
an't do
> simple rebase anymore which is time to time very useful.
> I see some different rebase strategies and --rebase-merges option but if =
this is
> adopted it should be properly described how to rebase u-boot tree which c=
ontains
> some subtrees.

Did you observe any specific difference with respect to subtree merge
commits (Tom will likely do those in the beginning of next release
cycle) when compared with normal merge commits when Tom pulls in code
from different custodians like one example below? The same rebasing
rules should apply to both types of merge commits.

commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
Merge: 2b28c3b871c e266d273114
Author: Tom Rini <trini@konsulko.com>
Date:   Mon Jan 1 12:38:15 2024 -0500

    Merge tag 'dm-next-1124' of
https://source.denx.de/u-boot/custodians/u-boot-dm into next

    support propagating supernode properties with bootph schema
    align bloblist with v0.9 of Firmware Handoff spec

-Sumit

>
> Thanks,
> Michal

