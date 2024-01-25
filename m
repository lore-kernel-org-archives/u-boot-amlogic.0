Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4702DC48285
	for <webhook@archiver.kernel.org>; Thu, 25 Jan 2024 13:22:05 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
 by mx.groups.io with SMTP id smtpd.web10.11731.1706167474392689367
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Jan 2024 23:24:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iDd8axIW;
 spf=pass (domain: linaro.org, ip: 209.85.217.54, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-46b0b5ae324so338625137.1
        for <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 23:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706167473; x=1706772273; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iN21WrMtUYkRqaQ8ZNuCFFZhmIui9MC0Ig/SSeZ/cn4=;
        b=iDd8axIW08mt1bqnYm0h221d0KiopB8F2V40OxUvk8RblOp2mTzJlMhq/Eouy9iAj9
         nAo4ZRhqQRO22LFI257Mf1sTC5OeGBDHLEwDs3nO3HgdWFE8OnX0S7fXKdZFw05I3IsZ
         99j2CfVlKE+fv/0ECy/ToPGt6K//p1/I1FmOmTJQfS4Ju7MJ3LOULg3GfgGtls0cZeWh
         myxkgVJeqLeqmVNfxFY1jtAuvPS1U1v53YCISbkUedB/aC6ayHXMv++72IIVaQkeaPum
         40FE1py3Kpqf6YVEVmL8PnqykWLH+r1xi/Ng/LGmPsQpBYwO01eWxk3zjFf3kJy7W3Et
         ccEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706167473; x=1706772273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iN21WrMtUYkRqaQ8ZNuCFFZhmIui9MC0Ig/SSeZ/cn4=;
        b=mYAPmMUulyYu5o5z/NYoxDUc9YVOCwGW0wCskB15b3Lr0dK2nKmBXIWry9F0RjigDD
         Qbxwdyq2oV8hIIHjnJUkWCX44O3iLRWB5eibrdwxcy/XY9qdBMPn5/T/t5hAbzfJOyDs
         FWRIblFNPAmXctKWitHDkOLEEa4fGH2A9QtT6destjgZRWyeR9RQhvIXrUKihuRMTd0i
         ZmwZGFAuqX+uDFTs2OoXlaj8fjdgQpmXrmy0H5ziHF2sv1U/HxgBGSM+Nk2nZVISGjoi
         knPY3JZENaXpAJVdaq991VJ9VeEAtAonq9lI9Y542ZiiaklcDFDGUqyQNXMpPm9HW4EO
         wlOA==
X-Gm-Message-State: AOJu0YzC0QABsGbPZeNswp/7vf1G4FQoQ9rs29U+HR6erNncufAUTsL4
	ryDddhPof4TMe7c06Ogam/M3bUkAdYU4jtj7C5Sb8zLj7jm0/h+YcaYfNi+DVWW/JZopDZcIjaX
	q/WGeu6o0kO8weevyR+9ZcpHnWuChtixbkBVcbw==
X-Google-Smtp-Source: AGHT+IGZ9ClGDc7gM4sBNqFErzmGniytRb4nT5jUMplOQfewIAzBOrSskQWwLKASTlmKV7LAbop4e0qc1lVYwfxMnB4=
X-Received: by 2002:a05:6102:2908:b0:46a:cc14:bba2 with SMTP id
 cz8-20020a056102290800b0046acc14bba2mr446666vsb.4.1706167473372; Wed, 24 Jan
 2024 23:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de> <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de> <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
In-Reply-To: <48125705-e78e-438f-90ac-2816432cd747@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 25 Jan 2024 12:54:22 +0530
Message-ID: <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Thu, 25 Jan 2024 13:22:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2086

On Thu, 25 Jan 2024 at 07:36, Marek Vasut <marex@denx.de> wrote:
>
> On 1/24/24 09:16, Sumit Garg wrote:
>
> Hi,
>
> >>>> How do you propose to handle fixes to DTs which are applied to
> >>>> linux-stable releases ? For example, if Linux 6.6(.0) ships a DT which
> >>>> has some defect that is fixed in 6.6.1, how will that fix get into
> >>>> U-Boot DTs ?
> >>>
> >>> This fix would also be in the latest Linux tags, so I think it would
> >>> find its way here - as I understand it patches aren't accepted into
> >>> Linux stable unless they land in torvalds tree.
> >>
> >> See the devicetree-rebasing.git:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/refs/
> >>
> >> That only contains refs for release versions (v6.6-dts, v6.7-dts etc),
> >> not any follow-up updates from linux-stable (like current 6.6.13 etc).
> >>
> >
> > Here we should only consider fixes which are critical to U-Boot. I
> > think -u-boot.dtsi files would be suitable to carry those fixes until
> > next uprev. However, if there is a fix affecting many platforms than
> > we can consider pulling that standalone too.
>
> That would mean extra duplicate work -- the critical fixes have already
> been selected into linux-stable, that work is already done, I don't
> think it makes sense to re-do it again.
>
> Furthermore, I do not like the new necessity to start porting those
> fixes from linux-stable and converting them to adjustments to
> *-u-boot.dtsi files, this is tedious and error prone, so it would have
> to be automated.
>
> But I still think it is much better to simply take the fixes directly
> from linux-stable as-is instead.

That's fair, it would essentially be a DT ABI breakage for U-Boot for
which a fix has to be taken in U-Boot from Linux stable release. So I
am fine with that.

But at this point we have to move away from apprehensions about DT ABI
breakages and provide real examples of the DT ABI breakages in the
past. Are you aware of any DT ABI breaking change backported to Linux
stable releases? This is the sort of information we would like to make
DT bindings maintainers aware about.

>
> >> Would this require syncing in -rc versions of Linux DTs to get the
> >> latest fixes in ?
> >
> > Syncing -rc versions makes U-Boot more prone to DT ABI breakages. So
> > its a chicken and egg problem as per your comments below. However, we
> > can revisit our syncing strategy based on how the current one pans
> > out.
> >
> >>
> >>>> Assume that there is some large breaking change in Linux 6.(n+1),
> >>>> something which would be problematic for specific U-Boot platform
> >>>> (e.g. i.MX) or would require a lot of work to sort out, will there be
> >>>> a way to temporarily pin DTs for specific platform to older DT version
> >>>> until that is resolved (e.g. pin to 6.n) ?
> >>>
> >>> (Upstream) devicetree has to be forwards and backwards compatible, were
> >>> such a breaking change to get merged without prior discussion with DT
> >>> users (i.e. U-Boot) then I think the correct course of action would be
> >>> to revert it.
> >>
> >> Not really, this could be a perfectly valid change, and would work for
> >> Linux just fine, it might simply be pulling in something which is not
> >> supported by U-Boot just yet and therefore syncing the DTs into U-Boot
> >> would break U-Boot on that platform . Using older version of DTs for a
> >> platform could work as a stopgap measure until the functionality is
> >> implemented. Is this possible ?
> >
> > For this particular reason we want to pull once during beginning on
> > U-Boot next window and allow sufficient time for platform maintainers
> > to adapt to it. However, OF_UPSTREAM=n can be an alternative for a
> > stopgap solution.
>
> That pull would break other peoples platforms. It would be no different
> than adding broken patch into the code base.

The platforms which get converted to OF_UPSTREAM=y are the ones which
would be compliant with upstream DT bindings. So any DT ABI change
among major Linux .0 releases would be the reason for that breakage.
And we are happy to accept a revert for that change and feed that
information back to Linux DT bindings maintainers.

Also as above, are you aware of any past DT ABI breakages for U-Boot
since people have already been doing DT syncing from Linux manually.
This series allows to reduce that pain and try to bring DT bindings
compliance in U-Boot.

> What I think would be an
> option is that there is a pull (as in patch) and people should be able
> to test it before it is applied.

We can't modify that pull but rather accept changes on top of it. IMO,
it will get widely tested in U-Boot next branch.

> If one platform is severely affected
> while other platforms are fine, the one platform should be able to use
> the current working version of DTs, while the other platforms should not
> be blocked by it. Is that what OF_UPSTREAM=n does ?
>
> As far as I understand OF_UPSTREAM=n, it would require re-importing DTs
> into the codebase ?

No you don't have to re-import everything but rather import a board
DTS file to the arch/ folder and reuse all the DT includes from
dts/upstream subtree as per this [1] patch.

[1] https://lore.kernel.org/all/20240110103547.719757-5-sumit.garg@linaro.org/

>
> >>> On a tangential note: as I understand it, DTs built from dt-rebasing are
> >>> still subject to U-Boot customisations via the "-u-boot.dtsi" include
> >>> files, this allows for dealing with incompatibilities due to missing
> >>> features in U-Boot.
> >>
> >> Would it be possible to auto-update those -u-boot.dtsi files during
> >> sync, to minimize the resulting DT blob delta before/after update, and
> >> thus also minimize the likelihood of causing breakage ?
> >
> > In the long run the DT community would like to avoid any DT ABI
> > breakages at all. Rob is already working on a DT ABI check tool and
> > seeking inputs for what could be an ABI break [1] from U-Boot
> > perspective too. Feel free to provide your inputs.
> >
> > Along with that we wouldn't need -u-boot.dtsi files once we make
> > U-Boot fully compliant with DT bindings. Until that point U-Boot
> > platform maintainers have to keep their -u-boot.dtsi files updated
> > corresponding to latest DT rebasing releases.
>
> I think upstreaming the bootph* properties would still take a while, but
> is not relevant to the aforementioned question.
>
> Assume there is a sync, would the current in-tree -u-boot.dtsi files get
> updated to work correctly with the newly synced DTs ?

As long as they contain nodes/properties (eg. bootph* etc.) which are
compliant with upstream DT bindings then yes they should work
correctly with the newly synced DTs.

-Sumit

