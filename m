Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448EAC48285
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web11.21295.1704298799947010173
 for <u-boot-amlogic@groups.io>;
 Wed, 03 Jan 2024 08:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=j98qIRCI;
 spf=pass (domain: kernel.org, ip: 145.40.68.75, mailfrom: robh+dt@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 645CDB811FF
	for <u-boot-amlogic@groups.io>; Wed,  3 Jan 2024 16:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F331BC433A9
	for <u-boot-amlogic@groups.io>; Wed,  3 Jan 2024 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704298796;
	bh=DCaFhJgle4/m0G19+ppuMD3zW79+uCyzpzSRkwdVRww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j98qIRCIHLEDG1Gdw/D1VOE6YwNQWZNf0aZibEJSjavxTkljkLZtuFFDXMDURbG7M
	 hhK318mE7nLySOODnm/YwZMcfaAMGeNFkQ9t8IEwC1TwT0czIedTm5Exe3RzvId00M
	 qR4wehPBJp8/A2vuJULS+ItKeJPijNNkhIBtCO2nxbTL+I40A9SinlaT98Qvmrgx0F
	 8LwHOL8Mgnp4GsMSRloDQoRIVP97xbCBTXOnMiPRV0eZ8yG5wy7In87spSRw/uSF7S
	 2tgSSjMqBEwYTRt4pkLGCdxlIc7X82sPAfAwnvETPSh1LgXIH4qZ3HLjJEbz6R/t+z
	 wp6LDVkQYGciA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so136066021fa.1
        for <u-boot-amlogic@groups.io>; Wed, 03 Jan 2024 08:19:55 -0800 (PST)
X-Gm-Message-State: AOJu0YzEJC67PnRdzquE8CL6+EK4iHfuu8VKJqgIhbEkFzYNb3sgSTa3
	FiFdKBeaCyZAzhSjX2zJieJKjIkQOJwi6iPN0g==
X-Google-Smtp-Source: AGHT+IEwozjtIEFQxMtHQ/2bodFL2B52VdQpxwR9TA1TLZFL5N/2Cz8EqBD5VjDZKbOSGrigghwiAMUR1ciKMqBDhW8=
X-Received: by 2002:a2e:a585:0:b0:2cc:da6a:6285 with SMTP id
 m5-20020a2ea585000000b002ccda6a6285mr7683560ljp.33.1704298793932; Wed, 03 Jan
 2024 08:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org> <20231228115804.3626579-6-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-6-sumit.garg@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2024 09:19:40 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
Message-ID: <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2030

On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> subtree and maintain a regular sync with Linux kernel devicetree files
> and bindings.
>
> Along with that add documentation regarding how to run DT bindings
> schema checks.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Replace CONFIG_* with Kconfig options
>
> Changes in v2:
> --------------
> - s/U-boot/U-Boot/
>
>  doc/develop/devicetree/control.rst | 131 +++++++++++++++++++++--------
>  1 file changed, 96 insertions(+), 35 deletions(-)
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/=
control.rst
> index cbb65c9b177..65180d33e8d 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -1,5 +1,6 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  .. sectionauthor:: Copyright 2011 The Chromium OS Authors
> +.. Copyright 2023 Linaro Ltd.
>
>  Devicetree Control in U-Boot
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> @@ -22,14 +23,13 @@ for three reasons:
>    hierarchical format
>  - It is fairly efficient to read incrementally
>
> -The arch/<arch>/dts directories contains a Makefile for building the dev=
icetree
> -blob and embedding it in the U-Boot image. This is useful since it allow=
s
> -U-Boot to configure itself according to what it finds there. If you have
> -a number of similar boards with different peripherals, you can describe
> -the features of each board in the devicetree file, and have a single
> -generic source base.
> +The U-Boot Makefile infrastructure allows for building the devicetree bl=
ob
> +and embedding it in the U-Boot image. This is useful since it allows U-B=
oot
> +to configure itself according to what it finds there. If you have a numb=
er
> +of similar boards with different peripherals, you can describe the featu=
res
> +of each board in the devicetree file, and have a single generic source b=
ase.
>
> -To enable this feature, add CONFIG_OF_CONTROL to your board config file.
> +To enable this feature, select `OF_CONTROL` via Kconfig.
>
>
>  What is a Flattened Devicetree?
> @@ -68,8 +68,21 @@ a binary file. U-Boot adds its own `fdtgrep` for creat=
ing subsets of the file.
>  Where do I get a devicetree file for my board?
>  ----------------------------------------------
>
> -You may find that the Linux kernel has a suitable file. Look in the
> -kernel source in arch/<arch>/boot/dts.
> +Linux kernel Git repository has been the place where devicetree files al=
ong
> +with devicetree bindings are stored and maintained. There is devicetee-r=
ebasing
> +(dtrepo_) which maintains a forked copy of devicetree files along with b=
indings
> +at every Linux kernel major release or intermideate release candidates.

Typo.

> +
> +In order to maintain devicetree files sync, U-Boot maintains a Git subtr=
ee for
> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is re=
gularly
> +kept updated with every new kernel major release via subtree pull as fol=
lows::

I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
had in the original repo). I don't think it's relevant.

We're not likely to regenerate the tree, but any clue what 'git
subtree pull' would do in this case? It could happen if we switched to
git-filter-repo.

> +
> +    git subtree pull --prefix devicetree-rebasing \
> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicet=
ree-rebasing.git \
> +        <release-tag> --squash

I'd put this in a script to run. Documentation tends to be not quite
correct. A script could also be smarter and figure out <release-tag>.

> +
> +You may find that the `devicetee-rebasing/` sub-directory has a suitable
> +devicetree file for your board. Look in `devicetree-rebasing/src/<arch>/=
`.

