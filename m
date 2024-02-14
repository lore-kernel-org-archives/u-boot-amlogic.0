Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20000C54766
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 11:16:41 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web11.41529.1707917565438559986
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Feb 2024 05:32:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=IfB8V4GM;
 spf=pass (domain: linaro.org, ip: 209.85.210.50, mailfrom: sumit.garg@linaro.org)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e2d8a21b79so1715665a34.2
        for <u-boot-amlogic@groups.io>; Wed, 14 Feb 2024 05:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707917564; x=1708522364; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCRzPTqirvt7k1chFAmxnOnbw9Vm+6hj1p05+1qzCGE=;
        b=IfB8V4GM5ibuAkmC7jY8WAmbAN3thSyfmma6H4j+1Gt8jJeFvwx98YgULU0bep0Dbo
         VAtpK6hh2ozld8w3XUup9bH+08B6fNAqWzEqH6ahb8vbNqG8OlAyOQYzI/UqmxfAziEj
         pKjkf5CnUSfRp8Rfw5rsGwd3rLShZEm/TFZIc9MjkNWrKMj6HjRP7TuYQuEZc5NaBo9j
         tdJblANNNLnqnGvgwWuS59S0oQhKEpkgU6r3MYny41MMMtDfoYNSeeuGUrzt0aUIUtOE
         5d5e2Gz23btvf9KloF7BcvIiGUpMGtA//HJLZ7ttDNBFbAhAEbskA8UtyQvWYY7Gq1wi
         THuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707917564; x=1708522364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCRzPTqirvt7k1chFAmxnOnbw9Vm+6hj1p05+1qzCGE=;
        b=jnznTy+NloG84q/uAxpUQmWN1+Wxqc3zmRWmUiKh9Vh+nN9jiZ9jrEpaO4Q1YMyM1Z
         +flDnX2yTUwYexqb712Y2rSKQoLWNrTVRayQypgf2AroC/DHRRyt9TZgBJlT4absvUV7
         OknMBcggM19TwaOT+KY6EiHMOiltlzTr25mA5qrvJW/yYaWA9uUQwrcvlwhd60R4vkOy
         fDFB6THex+tQfpq1DKXiAozDgxnwnDqUhwtJmj6gJPGQH5U168UTGkN9FJwAmNjetRWC
         kqqQXkaSC2OTfyC+mqArliB1QDskNivRRqg9VaLe5vDkbArWH6mU+GpnH51BftZLg5Z5
         gy2g==
X-Forwarded-Encrypted: i=1; AJvYcCVT+/Vgv/qCBQJKIg2fbOSy7wL5iJomDudmRT19UY3+A469wM20Z+p689sH+Pk0ganfLKkz9MRchJIG4hWJwipEJxtseNDAaYc=
X-Gm-Message-State: AOJu0YzpMc9xpjNKAl9gEc5rjL6JmtY/BMdCaGPz+TFLXqonxJAFeM/l
	A8gJD4nHbwah8wTEGfiIbOjA0Y/I8iKNlUSMgBKXAzdLLBUfSmCuP7HXjLrpRxg69F+nCTOnspl
	ehbmEAXCPCJh+zo9nMOPo9ZkOAzOJoK686IAeHg==
X-Google-Smtp-Source: AGHT+IFT7mo0ptD/bnF8rlgzxgou/r5aEHE2GV3o7sFOa9bViuoA3CiCsQkF9DXxIJ7wTIJKQe77QUshliMq8VTOPBw=
X-Received: by 2002:a05:6870:d1ce:b0:21a:2e98:7739 with SMTP id
 b14-20020a056870d1ce00b0021a2e987739mr2708435oac.18.1707917564437; Wed, 14
 Feb 2024 05:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-9-sumit.garg@linaro.org> <518d87fc-457e-4d77-ba66-9e3a5aa15279@bp.renesas.com>
In-Reply-To: <518d87fc-457e-4d77-ba66-9e3a5aa15279@bp.renesas.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 14 Feb 2024 19:02:33 +0530
Message-ID: <CAFA6WYOdYK4vAibGEQ9SnNCGMv00AKYkzZu+capfW9E4y=cFHA@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] doc: devicetree: Updates for devicetree-rebasing subtree
To: Paul Barker <paul.barker.ct@bp.renesas.com>, ijc@hellion.org.uk
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
	nm@ti.com, andre.przywara@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 19 Feb 2024 11:16:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2127

+ Ian Campbell (Maintainer for devicetree-rebasing tree)

Hi Paul,

Thanks for your nice documentation review.

On Wed, 14 Feb 2024 at 03:01, Paul Barker <paul.barker.ct@bp.renesas.com> w=
rote:
>
> On 02/02/2024 13:05, Sumit Garg wrote:
> > Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> > subtree and maintain a regular sync with Linux kernel devicetree files
> > and bindings.
> >
> > Along with that add documentation regarding how to run DT bindings
> > schema checks.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v5:
> > - Document how to cherry-pick fixes from devicetree-rebasing tree.
> >
> > Changes in v4:
> > - Switched subtree to be imported as dts/upstream sub-directory rather
> >   than devicetree-rebasing sub-directory to better suite U-Boot
> >   directory structure.
> > - Since we now have v6.7-dts tag available now, so switch subtree to
> >   that from its beginning.
> > - Clarify subtree uprev schedule as a separate documentation section.
> >   Also, fixed documentation typos.
> >
> > Changes in v3:
> > - Replace CONFIG_* with Kconfig options
> >
> > Changes in v2:
> > - s/U-boot/U-Boot/
> >
> >  doc/develop/devicetree/control.rst | 117 ++++++++++++++++++++++++-----
> >  1 file changed, 97 insertions(+), 20 deletions(-)
> >
> > diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetre=
e/control.rst
> > index 9a0cb90336df..4440d4b82c6a 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -1,5 +1,6 @@
> >  .. SPDX-License-Identifier: GPL-2.0+
> >  .. sectionauthor:: Copyright 2011 The Chromium OS Authors
> > +.. Copyright 2023-2024 Linaro Ltd.
> >
> >  Devicetree Control in U-Boot
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > @@ -22,12 +23,11 @@ for three reasons:
> >    hierarchical format
> >  - It is fairly efficient to read incrementally
> >
> > -The arch/<arch>/dts directories contains a Makefile for building the d=
evicetree
> > -blob and embedding it in the U-Boot image. This is useful since it all=
ows
> > -U-Boot to configure itself according to what it finds there. If you ha=
ve
> > -a number of similar boards with different peripherals, you can describ=
e
> > -the features of each board in the devicetree file, and have a single
> > -generic source base.
> > +The U-Boot Makefile infrastructure allows for building the devicetree =
blob
> > +and embedding it in the U-Boot image. This is useful since it allows U=
-Boot
> > +to configure itself according to what it finds there. If you have a nu=
mber
> > +of similar boards with different peripherals, you can describe the fea=
tures
> > +of each board in the devicetree file, and have a single generic source=
 base.
> >
> >  To enable this feature, select `OF_CONTROL` via Kconfig.
> >
> > @@ -68,8 +68,14 @@ a binary file. U-Boot adds its own `fdtgrep` for cre=
ating subsets of the file.
> >  Where do I get a devicetree file for my board?
> >  ----------------------------------------------
> >
> > -You may find that the Linux kernel has a suitable file. Look in the
> > -kernel source in arch/<arch>/boot/dts.
> > +Linux kernel Git repository has been the place where devicetree files =
along
> > +with devicetree bindings are stored and maintained. There is devicetee=
-rebasing
> > +(dtrepo_) which maintains a forked copy of devicetree files along with=
 bindings
> > +at every Linux kernel major release or intermediate release candidates=
.
>
> This can be written more clearly, we can steal what you wrote later and
> expand it to say what was wrong with the previous situation:
>
> "The devicetree files and devicetree bindings are maintained as part of
> the Linux kernel git repository. Traditionally, U-Boot placed copies of
> devicetree source files from the Linux kernel into
> `arch/<arch>/dts/<name>.dts`. However, this required each board
> maintainer to manually keep their device tree in sync with Linux and
> often led to divergence between these copies."
>
> We can then introduce the `dts/upstream` directory and tell developers
> why it is a better solution.

Ack, I will try to reorganize the contents as per your suggestion.

>
> I think the docs should talk about the `dts/upstream` directory first,
> then the devicetree-rebasing repository afterwards. The directory in the
> u-boot source tree is what most developers will see and interact with,
> use of the devicetree-rebasing repository is an implementation detail of
> how that subtree is sync'd with Linux. I don't think we need to mention
> the devicetree-rebasing repository until the "Resyncing with
> devicetree-rebasing" section below.

Ack.

>
> Also, is devicetree-rebasing a "forked copy"? A fork would imply some
> difference from upstream. I would guess this is more like a mirror.

AFAIK, it's a mirror from upstream with a different directory
(Makefile) structure. Ian may clarify further as to how this mirror is
kept updated.

>
> > +
> > +U-Boot maintains a Git subtree for devicetee-rebasing repo as `dts/ups=
tream/`
> > +sub-directory. You may find that the `dts/upstream/` sub-directory has=
 a
> > +suitable devicetree file for your board. Look in `dts/upstream/src/<ar=
ch>/`.
> >
> >  If not you might find other boards with suitable files that you can
> >  modify to your needs. Look in the board directories for files with a
> > @@ -78,17 +84,38 @@ modify to your needs. Look in the board directories=
 for files with a
> >  Failing that, you could write one from scratch yourself!
> >
> >
> > +Resyncing with devicetree-rebasing
> > +----------------------------------
> > +
> > +U-Boot regularly sync `dts/upstream/` subtree whenever the next window=
 opens
>
> "The U-Boot maintainers regularly sync the..."
>
> What's the "next window" here? Is this the merge window? Or the period
> after the merge window when the next branch is open?

It's when the next branch is open. I will correct it.

> There should be a
> link here to relevant section of the U-Boot Development Cycle page in
> case the reader isn't familiar with the development process.

Ack, I will add that.

>
> > +with the next available kernel major release. `dts/update-dts-subtree.=
sh` script
>
> I think this should be "with the latest mainline kernel release."

Ack.

>
> > +provides a wrapper around git subtree pull command, usage from the top=
 level> +U-Boot source tree, run::
>
> The use of `git subtree pull` is an implementation detail. I think the
> docs need to focus on what the script does, not how it does it.
>
> Maybe replace this sentence with something like:
>
> "To sync the `dts/upstream/` subtree, run the following command::"
>

Ack.

> > +
> > +    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
> > +
> > +If required it is also possible to cherry-pick fixes from devicetree-r=
ebasing
>
> "the devicetree-rebasing repository" here and each time it is referenced.

Ack.

>
> > +tree prior to next sync, usage::
> > +
> > +    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
> > +
> > +
> >  Configuration
> >  -------------
> >
> > -Set up "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig. Th=
en put
> > -your devicetree file into::
> > +Traditionally, U-Boot placed copies of devicetree source files from Li=
nux
>
> "the Linux kernel", here and each time "Linux kernel" is used.

Ack.

>
> > +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via set=
ting
> > +"<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
> >
> > -   arch/<arch>/dts/<name>.dts
> > +However, it has become cumbersome over time for each SoC/board maintai=
ner to
> > +keep devicetree files in sync with Linux kernel. Therefore, SoC/board
> > +maintainers are encouraged to migrate to use synced copies from
> > +`dts/upstream/src/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` fo=
r the
> > +SoC being used via Kconfig and set up "<vendor>/<name>" when prompted =
for
> > +`DEFAULT_DEVICE_TREE` by Kconfig.
>
> I'd prefer "set `OF_UPSTREAM=3Dy`"

As discussed earlier OF_UPSTREAM is a SoC specific config option, so
this can be more explicit via: "... add `imply OF_UPSTREAM` for the
SoC ...".

> and "set `DEFAULT_DEVICE_TREE=3D<vendor>/<name>`".

Ack.

>
> >
> > -This should include your CPU or SOC's devicetree file, placed in
> > -`arch/<arch>/dts`, and then make any adjustments required using a u-bo=
ot-dtsi
> > -file for your board.
> > +This should include your CPU or SOC's devicetree file. On top of that =
any U-Boot
>
> Change "SOC" to "SoC" while this is being modified.

Ack.

>
> > +specific tweaks (see: dttweaks_) can be made for your board.
> >
> >  If `OF_EMBED` is selected by Kconfig, then it will be picked up and bu=
ilt into
> >  the U-Boot image (including u-boot.bin). This is suitable for debuggin=
g
> > @@ -155,8 +182,9 @@ ways:
> >  Adding tweaks for U-Boot
> >  ------------------------
> >
> > -It is strongly recommended that devicetree files in U-Boot are an exac=
t copy of
> > -those in Linux, so that it is easy to sync them up from time to time.
> > +With `dts/upstream` Git subtree, it is ensured that devicetree files i=
n U-Boot
> > +are an exact copy of those in Linux kernel available under
> > +`dts/upstream/src/<arch>/<vendor>`.
> >
> >  U-Boot is of course a very different project from Linux, e.g. it opera=
tes under
> >  much more restrictive memory and code-size constraints. Where Linux ma=
y use a
> > @@ -169,8 +197,8 @@ constraints are even more extreme and the devicetre=
e is shrunk to remove
> >  unwanted nodes, or even turned into C code to avoid access overhead.
> >
> >  U-Boot automatically looks for and includes a file with updates to the=
 standard
> > -devicetree for your board, searching for them in the same directory as=
 the
> > -main file, in this order::
> > +devicetree for your board, searching for them in `arch/<arch>/dts/` in=
 this
> > +order::
> >
> >     <orig_filename>-u-boot.dtsi
> >     <CONFIG_SYS_SOC>-u-boot.dtsi
> > @@ -199,6 +227,54 @@ option to specify a list of .dtsi files that will =
also be included when
> >  building .dtb files.
> >
> >
> > +Devicetree bindings schema checks
> > +---------------------------------
> > +
> > +With devicetee-rebasing Git subtree, the devicetree bindings are also =
regularly
> > +synced with Linux kernel as `dts/upstream/Bindings/` sub-directory. Th=
is
> > +allows U-Boot to run devicetree bindings schema checks which will brin=
g
> > +compliance to U-Boot core/drivers regarding usage of devicetree.
> > +
> > +Dependencies
> > +~~~~~~~~~~~~
> > +
> > +The DT schema project must be installed in order to validate the DT sc=
hema
> > +binding documents and validate DTS files using the DT schema. The DT s=
chema
> > +project can be installed with pip::
> > +
> > +    pip3 install dtschema
>
> Unfortunately this won't work on recent distro versions, e.g. on Debian
> 12 I get:
>
>     error: externally-managed-environment
>
>     =C3=97 This environment is externally managed
>     =E2=95=B0=E2=94=80> To install Python packages system-wide, try apt i=
nstall
>         python3-xyz, where xyz is the package you are trying to
>         install.
>
>         If you wish to install a non-Debian-packaged Python package,
>         create a virtual environment using python3 -m venv path/to/venv.
>         Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
>         sure you have python3-full installed.
>
>         If you wish to install a non-Debian packaged Python application,
>         it may be easiest to use pipx install xyz, which will manage a
>         virtual environment for you. Make sure you have pipx installed.
>
>         See /usr/share/doc/python3.11/README.venv for more information.
>
>     note: If you believe this is a mistake, please contact your Python
>     installation or OS distribution provider. You can override this, at t=
he
>     risk of breaking your Python installation or OS, by passing
>     --break-system-packages.
>     hint: See PEP 668 for the detailed specification.
>
> I don't have a good solution to recommend here - there's no consensus on
> how to install Python tools for use in development. You could use
> `pipx`, you could create a virtualenv, and I'm sure there are other
> options as well. Perhaps we just need to leave it up to the reader to
> find out how to install dtschema on their system.

I suppose you haven't installed python3-pip package [1] on your Debian
12. BTW, `pip3` is being used as the common way to install dtschema
[2]. Also, every user may not be aware about python virtual
environments. So it's better to provide the commonly used pip3 option
for installation.

[1] https://packages.debian.org/bookworm/python3-pip
[2] https://github.com/devicetree-org/dt-schema/tree/main?tab=3Dreadme-ov-f=
ile#installing

>
> > +
> > +Note that 'dtschema' installation requires 'swig' and Python developme=
nt files
> > +installed first. Please, refer to the GCC build documentation for inst=
allation
> > +instructions :doc:`../../build/gcc`.
> > +
> > +Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will =
be
> > +installed. Ensure they are in your PATH (~/.local/bin by default).
> > +
> > +Recommended is also to install yamllint (used by dtschema when present=
). On
>
> "You should also install yamllint"

Ack.

-Sumit

