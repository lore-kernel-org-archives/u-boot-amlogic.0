Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32582C48286
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.78496.1703584028203959769
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 01:47:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=DH0TQ242;
 spf=pass (domain: chromium.org, ip: 209.85.210.182, mailfrom: sjg@chromium.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9344f30caso2776342b3a.1
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 01:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703584027; x=1704188827; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTH8EyXnXsHReQFRovG9exBqhw9ukMNM3tZAlOEkNck=;
        b=DH0TQ242AwIOnkGBBcU9jj6Tuhb0+qW58PSBKdu+PbV9Js6OerZCYaC/8+NdgOdR1w
         3odcBD+tnbYAUyz4XemHOo6OboBu/65jeLUqibfs6752xsQV2Yuyr0vchLoHu2FlZfWX
         2NmMac/8oRShWIze5ZMuZ+7T0y8EfZs3ur/Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703584027; x=1704188827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTH8EyXnXsHReQFRovG9exBqhw9ukMNM3tZAlOEkNck=;
        b=uvBuW2hMuqTTbEr9wxKOeKwb6akTHTO1YfEGyuBCG1XcPHEELC15coKGwlID5qn7qX
         VnKl6OUaUab+aBKvGcNt9H2FeGdLVdqbYVn91V4sJ6Y1+ZIC398NhLCpWAJYA1MVPoAJ
         D3ILr2mUBR1OfP3TMKOmvP9DAWunPEXl5062b66rHWE3UqjQOdWMEactXpTeLFy/xs0N
         P0HfC6CaPjPThcHHVBQCxZ/uX+vYB20iDWWlHjm5NHPGTUMOUiIk9mRhE17rMJ5gGE6a
         l52KvX0fUme9upuIQ4ldCJ6WYGlS0Sk2ezpo+BtEpM4Y96iv9QH5OTu0MysJ+xiXn9bW
         2xHw==
X-Gm-Message-State: AOJu0Ywbq0qnNr67v3V+RmVfUzrES2L2SYBh+1dSDCB23pkUP+7k3Tkn
	rTB8hP+wuQURHtsoXMjwWM8qlFZ3+Fva1a0zRoCwrkBrw28X
X-Google-Smtp-Source: AGHT+IE8e241qiYb5ekPhs4E99Q2+MIyFseXCOzghzGZzt/jp8PH3esRtBAlkZsrPsraOaEiC6sMMTsp3EHlUC/T0Ik=
X-Received: by 2002:a05:6a00:928c:b0:6d9:aaf4:7e1f with SMTP id
 jw12-20020a056a00928c00b006d9aaf47e1fmr4811977pfb.30.1703584027571; Tue, 26
 Dec 2023 01:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat> <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
In-Reply-To: <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:55 +0000
Message-ID: <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1968

Hi Sumit,

On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > >
> > > > Prerquisite
> > > > -----------
> > > >
> > > > This patch series requires devicetree-rebasing git repo to be added=
 as a
> > > > subtree to the main U-boot repo via:
> > > >
> > > > $ git subtree add --prefix devicetree-rebasing \
> > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devi=
cetree-rebasing.git \
> > > >       v6.6-dts --squash
> > >
> > > So, I've played with subtree a little and I think this is the right w=
ay
> > > forward in these cases. If anyone wants to take a look at how this wo=
rks
> > > in practice, take a look at:
> > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-device=
tree-rebasing-since-v6.1/?ref_type=3Dheads
> > > In that tree I started with the v6.1-dts tag, sync'd all the configs =
(to
> > > have an example of a normal commit) and then did a merge of each tag
> > > until v6.6-dts, so provide some history. And git log looks like what =
I
> > > want to see, the squash commit has clear references to what we are
> > > getting and I make a merge commit that says what I did. If you pull t=
he
> > > tree and checkout the branch, all the code is right there already,
> > > nothing further to do. Same with tarball releases. The only thing I
> > > don't like is the size growth there, but we'll reclaim some of it whe=
n
> > > we delete our obsolete bindings, and then obsolete dts files.
> >
> > I spent a bit of time with subtree as well, as part of reviewing this
> > series, using the instructions Sumit provided. It seems OK to me. We
> > have to accept that it adds code and there will be changes/churn, but
> > it is not too different to accepting patches on those files within
> > U-Boot. We will bring in files which U-Boot doesn't use, but U-Boot
> > does support a good proportion of the boards supported by Linux, so I
> > don't see that as a big cost.
> >
> > From my experimentation, subtrees seem to have no impact on buildman,
> > which is great. Am I missing anything?
>
> No it shouldn't cause any regression on existing tools/CI/build
> systems. It is just a version controlled way of importing third party
> source code as a tarball.
>
> >
> > I still worry about the board-level 'switch' between U-Boot DT and
> > upstream ones. I believe that should be at the SoC level instead.
> >
>
> Probably I wasn't clear enough in my earlier replies but this series
> motivates for a SoC level switch only. Patch #7 is essentially a
> switch for Amlogic meson-gxbb SoC and its derived boards.

OK good...but that's not quite what I mean. You have a fragment like
this in multiple defconfig files:

+CONFIG_OF_UPSTREAM=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"

instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in the
Kconfig. We should not have to specify the filename like this. It is
laborious and error-prone.

Regards,
Simon

