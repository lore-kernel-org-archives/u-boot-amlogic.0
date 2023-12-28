Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90BC47DA2
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web11.122632.1703770681605598757
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 05:38:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=BYfHGhYk;
 spf=pass (domain: chromium.org, ip: 209.85.167.181, mailfrom: sjg@chromium.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba14203a34so6035380b6e.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 05:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703770681; x=1704375481; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQtCsqMYWNhLmZCCSOn1+AU9PNr9mnMfTew2howZvsc=;
        b=BYfHGhYkbAym7LaZcl305Cv400dPL1idCBjHxiEx/Rc/NXLejEUjAvov1u+bEQwz3V
         ActAtjEP7gZOApWuZmiKlnhu73yGPOpV4gV81U9cBdwODoLEDba7ZKfwD7jJtPQAKOaC
         yYBroTbaqjQGGeo+JWzNSO/UyYHO8hoB8CTBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770681; x=1704375481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQtCsqMYWNhLmZCCSOn1+AU9PNr9mnMfTew2howZvsc=;
        b=PrEOCiRi8HKId7ADe5rBUlWo2QOslJbvwuWHYOSFqtxEC8txL4U5zDxSVnJPAqE7yG
         N0IAXe7lf32X7Tv7IsCm9rKvZxMnun4L01vsFsN44dsClEtvmA6z8vW8CnfTB3Q9AnDW
         jvG+LBDG6lQjPCcaAZtz0+tRlxyf7pd6Oywe27kbpR+9OdL5uq+K6ZGetKg7Fwx6Tppi
         xGcAv0C5MqLf819i3jcHyezev0QhB2cEvIVHSsPhxBslUuSdAwRVrFap97WG5hzBvbzL
         TdLqr/t7GossYBdnl8w6XLmKmLmnBXtaiZx3hUKibBfhNYB29RyIBKCUAGwVIWfo2cA+
         TRhQ==
X-Gm-Message-State: AOJu0Yz9M7WMx15SM1VhPEeKyjMZyyWaEUJ5lKgHhJDSujKygTc00h6x
	Xfo7zANaX8mH9uY7/ev2iyfWOjbkHcMylmecflgQdjx4q0tc
X-Google-Smtp-Source: AGHT+IE935eWL+t1OsZX16ZtC5imFyK7447/gir4Iqevi07nvRnrrLhnd1oYizDSwylqOYRWJkf44HcisIattEmNKbI=
X-Received: by 2002:a05:6808:1211:b0:3bb:9761:7f7d with SMTP id
 a17-20020a056808121100b003bb97617f7dmr11000425oil.68.1703770680853; Thu, 28
 Dec 2023 05:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org> <20231228115804.3626579-6-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-6-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:09 +0000
Message-ID: <CAFLszTjW8FBYtcb-kiZ-8rUdgMd96KgZWufh1ig+mQ6wq-sGgg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
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
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1998

Hi Sumit,

On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
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

These changes to remove CONFIG_ are good, but I think they should be
in a separate, prior patch.
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
> +
> +In order to maintain devicetree files sync, U-Boot maintains a Git subtr=
ee for
> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is re=
gularly
> +kept updated with every new kernel major release via subtree pull as fol=
lows::
> +
> +    git subtree pull --prefix devicetree-rebasing \
> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicet=
ree-rebasing.git \
> +        <release-tag> --squash
> +

This is an internal detail and I believe it will confuse people. Can
you put this in a section like 'Resyncing with devicetree-rebasing'
and explain when this might be needed?...almost enver, right?

> +You may find that the `devicetee-rebasing/` sub-directory has a suitable
> +devicetree file for your board. Look in `devicetree-rebasing/src/<arch>/=
`.
>
>  If not you might find other boards with suitable files that you can
>  modify to your needs. Look in the board directories for files with a
> @@ -81,34 +94,34 @@ Failing that, you could write one from scratch yourse=
lf!
>  Configuration
>  -------------
>
> -Use::
> +Traditionally, U-Boot placed copies of devicetree source files from Linu=
x
> +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via setti=
ng
> +"<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
>
> -   #define CONFIG_DEFAULT_DEVICE_TREE  "<name>"
> +However, it has become combersome over time for each SoC/board maintaine=
r to

spelling

> +keep devicetree files in sync with Linux kernel. Thereby, SoC/board main=
tainers

s/Thereby/Therefore/

> +are encouraged to migrate to use mirrored copies from `devicetree-rebasi=
ng/`
> +into `dts/arch/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` via Kco=
nfig

for the SoC being used

> and
> +set up "<vendor>/<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kcon=
fig.
>
> -to set the filename of the devicetree source. Then put your devicetree
> -file into::
> +This should include your CPU or SOC's devicetree file. On top of that an=
y U-Boot
> +specific tweaks (see: dttweaks_) can be made for your board.
>
> -   arch/<arch>/dts/<name>.dts
> -
> -This should include your CPU or SOC's devicetree file, placed in
> -`arch/<arch>/dts`, and then make any adjustments required using a u-boot=
-dtsi
> -file for your board.
> -
> -If CONFIG_OF_EMBED is defined, then it will be picked up and built into
> +If `OF_EMBED` is selected by Kconfig, then it will be picked up and buil=
t into
>  the U-Boot image (including u-boot.bin). This is suitable for debugging
>  and development only and is not recommended for production devices.
>
> -If CONFIG_OF_SEPARATE is defined, then it will be built and placed in
> +If `OF_SEPARATE` is selected by Kconfig, then it will be built and place=
d in
>  a u-boot.dtb file alongside u-boot-nodtb.bin with the combined result pl=
aced
> -in u-boot.bin so you can still just flash u-boot.bin onto your board. If=
 you are
> -using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the=
 device
> -tree binary.
> +in u-boot.bin so you can still just flash u-boot.bin onto your board. If=
 Kconfig
> +option `SPL_FRAMEWORK` is enabled, then u-boot.img will be built to incl=
ude the
> +device tree binary.
>
> -If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
> +If `OF_BOARD` is selected by Kconfig, a board-specific routine will prov=
ide the
>  devicetree at runtime, for example if an earlier bootloader stage create=
s
>  it and passes it to U-Boot.
>
> -If CONFIG_SANDBOX is defined, then it will be read from a file on
> +If `SANDBOX` is selected by Kconfig, then it will be read from a file on
>  startup. Use the -d flag to U-Boot to specify the file to read, -D for t=
he
>  default and -T for the test devicetree, used to run sandbox unit tests.

As above, please move the CONFIG changes into a prior patch.

>
> @@ -142,7 +155,7 @@ Build:
>  After the board configuration is done, fdt supported u-boot can be built=
 in two
>  ways:
>
> -#  build the default dts which is defined from CONFIG_DEFAULT_DEVICE_TRE=
E::
> +#  build the default dts which is selected by DEFAULT_DEVICE_TREE Kconfi=
g::
>
>      $ make
>
> @@ -156,8 +169,9 @@ ways:
>  Adding tweaks for U-Boot
>  ------------------------
>
> -It is strongly recommended that devicetree files in U-Boot are an exact =
copy of
> -those in Linux, so that it is easy to sync them up from time to time.
> +With devicetee-rebasing Git subtree, it is ensured that devicetree files=
 in
> +U-Boot are an exact copy of those in Linux kernel via mirroring into
> +`dts/arch/<arch>/<vendor>`.
>
>  U-Boot is of course a very different project from Linux, e.g. it operate=
s under
>  much more restrictive memory and code-size constraints. Where Linux may =
use a
> @@ -170,8 +184,8 @@ constraints are even more extreme and the devicetree =
is shrunk to remove
>  unwanted nodes, or even turned into C code to avoid access overhead.
>
>  U-Boot automatically looks for and includes a file with updates to the s=
tandard
> -devicetree for your board, searching for them in the same directory as t=
he
> -main file, in this order::
> +devicetree for your board, searching for them in `arch/<arch>/dts/` in t=
his
> +order::
>
>     <orig_filename>-u-boot.dtsi
>     <CONFIG_SYS_SOC>-u-boot.dtsi
> @@ -195,11 +209,57 @@ As mentioned above, the U-Boot build system automat=
ically includes a
>  `*-u-boot.dtsi` file, if found, containing U-Boot specific
>  quirks. However, some data, such as the mentioned public keys, are not
>  appropriate for upstream U-Boot but are better kept and maintained
> -outside the U-Boot repository. You can use CONFIG_DEVICE_TREE_INCLUDES
> -to specify a list of .dtsi files that will also be included when
> +outside the U-Boot repository. You can use `DEVICE_TREE_INCLUDES` Kconfi=
g
> +option to specify a list of .dtsi files that will also be included when
>  building .dtb files.
>
>
> +Devicetree bindings schema checks
> +---------------------------------
> +
> +With devicetee-rebasing Git subtree, the devicetree bindings are also re=
gularly
> +synced with Linux kernel as `devicetree-rebasing/Bindings/` sub-director=
y. This
> +allows U-Boot to run devicetree bindings schema checks which will bring
> +compliance to U-Boot core/drivers regarding usage of devicetree.
> +
> +Dependencies
> +~~~~~~~~~~~~
> +
> +The DT schema project must be installed in order to validate the DT sche=
ma
> +binding documents and validate DTS files using the DT schema. The DT sch=
ema
> +project can be installed with pip::
> +
> +    pip3 install dtschema
> +
> +Note that 'dtschema' installation requires 'swig' and Python development=
 files
> +installed first. On Debian/Ubuntu systems::
> +
> +    apt install swig python3-dev

These two are already in doc/build/gcc.rst so please reference that
here, rather than repeating it.

> +
> +Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> +installed. Ensure they are in your PATH (~/.local/bin by default).
> +
> +Recommended is also to install yamllint (used by dtschema when present).

How?

> +
> +Running checks
> +~~~~~~~~~~~~~~
> +
> +In order to perform validation of DTB files, use the ``dtbs_check`` targ=
et::
> +
> +    make dtbs_check
> +
> +It is also possible to run checks with a subset of matching schema files=
 by
> +setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema fi=
les or
> +patterns (partial match of a fixed string). Each file or pattern should =
be
> +separated by ':'.
> +
> +::
> +
> +    make dtbs_check DT_SCHEMA_FILES=3Dtrivial-devices.yaml:rtc.yaml
> +    make dtbs_check DT_SCHEMA_FILES=3D/gpio/
> +    make dtbs_check DT_SCHEMA_FILES=3Dtrivial-devices.yaml
> +
> +
>  Relocation, SPL and TPL
>  -----------------------
>
> @@ -261,8 +321,9 @@ used it before Linux (e.g. snow). The two projects de=
veloped in parallel
>  and there are still some differences in the bindings for certain boards.
>  While there has been discussion of having a separate repository for devi=
cetree
>  files, in practice the Linux kernel Git repository has become the place =
where
> -these are stored, with U-Boot taking copies and adding tweaks with u-boo=
t.dtsi
> -files.
> +these are stored, with U-Boot taking copies via devicetree-rebasing repo
> +(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
>
>  .. _dtspec: https://www.devicetree.org/specifications/
>  .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
> +.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/d=
evicetree-rebasing.git
> --
> 2.34.1
>

Regards,
Simon

