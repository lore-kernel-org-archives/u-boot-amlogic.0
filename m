Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACBC47DB7
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:32 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.web11.21414.1704453516869597250
 for <u-boot-amlogic@groups.io>;
 Fri, 05 Jan 2024 03:18:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=kVm4IAI8;
 spf=pass (domain: linaro.org, ip: 209.85.217.49, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-46771fc85cdso358279137.2
        for <u-boot-amlogic@groups.io>; Fri, 05 Jan 2024 03:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704453516; x=1705058316; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR2/86ohsC+/DLK8tMj5rk3yIJWc7K4P6u4PuXAFeFw=;
        b=kVm4IAI8VGy8zAVIJODO904ueUObkrrkg3uzUhEAUfkSHbzHwTA/h2/G48FYK5qPQH
         8OkoHlil8gifgZDBxIWXycxuPsWY0J4unhMWyDTMG+pvShRWWdSUKWqwUUQil2AqtqRd
         zkjr2kSNFP/15j4BwqeC+AYWaysfhcn923qWnqqjjTGr5j7ILmhMbdHT/bpXW6rgKggD
         FHBTFTHfVQQtmJC5yPgYB1qn1TuinZ67PwulIFOlTY5SI5ADtJCGER6KGlWdoWYcal5m
         9nZCnqwMJiNWf87W7A+A9HPLlVRbESU+auRMBwYlG+pprIZINagm7iZhmX1KEPRNS1Qe
         sa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704453516; x=1705058316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR2/86ohsC+/DLK8tMj5rk3yIJWc7K4P6u4PuXAFeFw=;
        b=bSlktTkG7z3wMY0+kl2uq9knXkh9SGUe905XmxLTG/+hrRSfTHuXSEW+Mroeggk2fC
         OGnNIRTMG5gLQFayFXWaznE5QIUqSgtIt8bWf0yghE+bfXduxrFcfVfc3OvJBWGF7Cop
         uhYH77FgVza6uuZAHGAKkYvvAYoWWABBtoaT5rN5TWZe13Nvc5YC74qYJHt7xbmuHnpb
         KvvNKCBo32Zs7C7ivkrV68ZZd2G+R4kN0icyxe6QfCz/Kfb1nDWF7jMFELzsxV0Nl4YS
         OzRVXSIBCTmHzczSjQT584Lzr9f0NR8eUl1K+pIxkWriC/oH5PUrHKzPVmxsHcbECW5X
         5f7A==
X-Gm-Message-State: AOJu0YwUc8KScSS3zbBbMAXhY45ICcevJ8lBWIOJU7A2FgiW/maUt5mx
	lKEzT/P1YuL6IwCsg3cj3SNy08XtgHCiCIwjcx9SW36T046qWA==
X-Google-Smtp-Source: AGHT+IHKN+Md38WKP8zcC8geBmw6wbXFo0RTeSoig5gCDMGrhLrrQlr+NMLe9qy4mEzA0Wf8IwHUUcWTsP8DidfS+dU=
X-Received: by 2002:a05:6102:570f:b0:466:f130:9d0d with SMTP id
 dg15-20020a056102570f00b00466f1309d0dmr1363587vsb.32.1704453515659; Fri, 05
 Jan 2024 03:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org> <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat> <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
 <CAFA6WYP6p=eVtmnS=Qd8xv+nCSFvzREMnRHFkLzEzENnvTxv+A@mail.gmail.com>
 <20240104135008.GQ1610741@bill-the-cat> <cb0ee2fb-2753-421e-9623-3cd74e6bef03@amd.com>
 <20240104153029.GT1610741@bill-the-cat> <785175cd-a2b8-4d5c-8f2c-326125465ed6@amd.com>
 <20240104180336.GU1610741@bill-the-cat> <93ad60d2-a2fa-43e6-9ab1-928b12de96e4@amd.com>
In-Reply-To: <93ad60d2-a2fa-43e6-9ab1-928b12de96e4@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 5 Jan 2024 16:48:23 +0530
Message-ID: <CAFA6WYOEkjbhBtsGcD86M1SVyPyDmY2weVFVxE5OAb8_Qe2-TQ@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2045

On Fri, 5 Jan 2024 at 13:46, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 1/4/24 19:03, Tom Rini wrote:
> > On Thu, Jan 04, 2024 at 04:50:14PM +0100, Michal Simek wrote:
> >>
> >>
> >> On 1/4/24 16:30, Tom Rini wrote:
> >>> On Thu, Jan 04, 2024 at 03:45:10PM +0100, Michal Simek wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On 1/4/24 14:50, Tom Rini wrote:
> >>>>> On Thu, Jan 04, 2024 at 06:52:32PM +0530, Sumit Garg wrote:
> >>>>>> Hi Michal,
> >>>>>>
> >>>>>> On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> w=
rote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 1/3/24 17:32, Tom Rini wrote:
> >>>>>>>> On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> >>>>>>>>> On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@=
linaro.org> wrote:
> >>>>>>>> [snip]
> >>>>>>>>>> +In order to maintain devicetree files sync, U-Boot maintains =
a Git subtree for
> >>>>>>>>>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-director=
y. It is regularly
> >>>>>>>>>> +kept updated with every new kernel major release via subtree =
pull as follows::
> >>>>>>>>>
> >>>>>>>>> I would suggest dropping "-rebasing" in the u-boot tree. (I wis=
h we
> >>>>>>>>> had in the original repo). I don't think it's relevant.
> >>>>>>>>>
> >>>>>>>>> We're not likely to regenerate the tree, but any clue what 'git
> >>>>>>>>> subtree pull' would do in this case? It could happen if we swit=
ched to
> >>>>>>>>> git-filter-repo.
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>> +    git subtree pull --prefix devicetree-rebasing \
> >>>>>>>>>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicet=
ree/devicetree-rebasing.git \
> >>>>>>>>>> +        <release-tag> --squash
> >>>>>>>>>
> >>>>>>>>> I'd put this in a script to run. Documentation tends to be not =
quite
> >>>>>>>>> correct. A script could also be smarter and figure out <release=
-tag>.
> >>>>>>>>
> >>>>>>>> Since you had mentioned elsewhere moving the kernel scripts/dtc/=
 to
> >>>>>>>> something using subtree, I do hope to learn some lessons from wh=
at you
> >>>>>>>> do there. The first thing is that given the size/nature of the c=
ommits,
> >>>>>>>> I had figured I'd be the one doing this as a subtree pull+squash=
 then
> >>>>>>>> push, rather than posting to the ML since it'll be huge and
> >>>>>>>> un-reviewable, but with a note sent off to the ML that people sh=
ould be
> >>>>>>>> aware the next sync has been done and retest as needed. But Sumi=
t, were
> >>>>>>>> you planning to do some of this instead?  The second thing is th=
at if we
> >>>>>>>> move the subtree part in to dts/ instead (where we will still ha=
ve the
> >>>>>>>> Makefile/Kconfig we have today and then our Makefiles within the
> >>>>>>>> directories, this might get more complex and so really require a=
 script
> >>>>>>>> to keep it from getting error prone?
> >>>>>>>
> >>>>>>> I played with this series and didn't really have time to dig into=
 subtree
> >>>>>>> mechanics but one thing I see is that when squash and merge happe=
ns you can't do
> >>>>>>> simple rebase anymore which is time to time very useful.
> >>>>>>> I see some different rebase strategies and --rebase-merges option=
 but if this is
> >>>>>>> adopted it should be properly described how to rebase u-boot tree=
 which contains
> >>>>>>> some subtrees.
> >>>>>>
> >>>>>> Did you observe any specific difference with respect to subtree me=
rge
> >>>>>> commits (Tom will likely do those in the beginning of next release
> >>>>>> cycle) when compared with normal merge commits when Tom pulls in c=
ode
> >>>>>> from different custodians like one example below? The same rebasin=
g
> >>>>>> rules should apply to both types of merge commits.
> >>>>>>
> >>>>>> commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
> >>>>>> Merge: 2b28c3b871c e266d273114
> >>>>>> Author: Tom Rini <trini@konsulko.com>
> >>>>>> Date:   Mon Jan 1 12:38:15 2024 -0500
> >>>>>>
> >>>>>>        Merge tag 'dm-next-1124' of
> >>>>>> https://source.denx.de/u-boot/custodians/u-boot-dm into next
> >>>>>>
> >>>>>>        support propagating supernode properties with bootph schema
> >>>>>>        align bloblist with v0.9 of Firmware Handoff spec
> >>>>>
> >>>>> There's two cases. The first and uncommon case is that if you want =
to do
> >>>>> something like:
> >>>>> - Branch next
> >>>>> - Add this subtree, do a few subtree updates on it (like my experim=
ent
> >>>>>      of starting with v6.1-dts and merging up to v6.6-dts)
> >>>>> - Wait a while, have changes happen in next
> >>>>> - Rebase on to current next
> >>>>>
> >>>>> It gets painful and odd, but I don't know that this will ever reall=
y
> >>>>> happen.
> >>>>>
> >>>>> The second, common case is:
> >>>>> - Assume "next" already has this subtree + some merge commits in it=
.
> >>>>> - Make a new local branch.
> >>>>> - Make change in your new local branch.
> >>>>> - This hypothetical "next" branch moves forward with changes
> >>>>> - Rebase your local branch on to this "next" branch
> >>>>>
> >>>>> In this case things work as expected. Even if  "next" in that case =
gets
> >>>>> a new subtree merge that you need to rebase in.
> >>>>>
> >>>>> A third case that I'm not sure if really will happen or is a case w=
here
> >>>>> the custodian should rework their tree instead (to drop the subtree
> >>>>> merge) is:
> >>>>> - Assume "next" already has this subtree + some merge commits in it=
.
> >>>>> - Make a new local branch.
> >>>>> - Make a subtree merge+squash in your local branch.
> >>>>> - This hypothetical "next" branch moves forward with changes
> >>>>> - Rebase your local branch on to this "next" branch.
> >>>>>
> >>>>> This will then make you try and resolve some conflicts from that su=
btree
> >>>>> merge.  But is this a valid use case? Yes, I can see wanting to get=
 a
> >>>>> start on testing a dts merge before it happens, but is this a tree =
which
> >>>>> needs to be rebased, or just re-created as needed, if the parent br=
anch
> >>>>> moves forward?
> >>>>>
> >>>>> Can you explain a bit more your case Michal since it sounded to me =
like
> >>>>> you had a problem that happened rather than a worry about what migh=
t
> >>>>> happen?
> >>>>
> >>>> I remember couple of bisects which I was doing and it works fine on =
the tree
> >>>> till the point you have 2 issues to deal with. It means pretty much =
you have
> >>>> config change/fix which has to be applied to see second issue.
> >>>>
> >>>> The normal way what I have done was simply find major version apply =
that fix
> >>>> and then take the latest tree and rebase latest on the top of it. Th=
ere were
> >>>> normally not so many conflicts to resolved (or easy to resolve/ignor=
e). Then
> >>>> because the first fix is present all the time bisect is able to help=
 me to
> >>>> find second issue.
> >>>>
> >>>> If there is subtree update the whole rebase will horribly fail.
> >>>>
> >>>> I see that Rob and you in DTC case just simply do c&p and create reg=
ular
> >>>> commit with all changes inside. From my perspective this is more
> >>>> straightforward to deal with which will handle all cases and it is a=
lso
> >>>> proven over that years.
> >>>
> >>> Ah, bisecting.  Maybe the (annoying) answer is to turn that merge com=
mit
> >>> in to a regular commit in the bisect branch?  This is a good point, a=
nd
> >>> I need to go and construct a bigger example tree and check around at
> >>> what happens.
> >>
> >> Sure you can do whatever you like. But I expect that at the end if thi=
s
> >> started to be used you will have subtree for devicetree, dtc, lwip and=
 maybe
> >> something else. It means you have to start to keep track where that su=
btree
> >> are and what version is used at what time.
> >
> > Yes, lwip would be a subtree too, dtc is trickier but I see and agree
> > with your point.
> >
> >> Because dt binding is extending often likely you will need to merge it=
 every
> >> Linux release. It means you would have to do it multiple times depends=
 on
> >> how many releases you are going over.
> >
> > Yes, the plan is to re-sync every time our next opens with the kernel
> > release at the time (which maybe needs to be clearer in the docs).

I will clarify this further in the docs.

-Sumit

> >
> >> I know that Qemu is using gitmodules that's definitely another option =
but
> >> not sure if better or worse.
> >
> > Yeah, submodules is harder and we're not going that path.
> >
> >> I can also imagine that companies with SR IR certified firmware would =
keep
> >> downstream version where they want to just take code fixes, DT fixes a=
nd
> >> devicetree-rebasing tree to make sure that they are still aligned with=
 DT
> >> schema. Can you simply just cherry pick that merged commit without any=
 side
> >> effect?
> >
> > Life downstream is always fun. Personally, I would re-run the "git
> > subtree" command rather than cherry-pick from U-Boot itself in that
> > case, but it should be no different than any other commit.
> >
> >>
> >> Back to my point. At the end what we need to is to document it properl=
y how
> >> to deal with it.
> >
> > So, here's the test I did. I went back to v2023.10, then added v6.1-dts
> > as a subtree.  I rebased v2024.01-rc1 on top of that, added a fake bad
> > commit, synced up subtrees to v6.6, and then rebased the tags along the
> > way to v2024.01-rc6.  I then went for a bisect back to the fake bad
> > commit.  Everything went fine, git didn't have troubles rebasing things
> > as it went.
> >
> > But to re-iterate, yes, the policy around when dts and bindings will be
> > resynced needs to be clear and documented. Does that cover it?
>
> I am fine with it when we have documentation around.
>
> Thanks,
> Michal

