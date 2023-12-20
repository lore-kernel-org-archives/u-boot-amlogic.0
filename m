Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6680BC46CD3
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.15138.1703047652730198296
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Dec 2023 20:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=kf7xsejg;
 spf=pass (domain: google.com, ip: 209.85.218.53, mailfrom: sjg@google.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a268836254aso93305966b.1
        for <u-boot-amlogic@groups.io>; Tue, 19 Dec 2023 20:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703047651; x=1703652451; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MGBwOuSzTgvJ564O2l/POGSwftHo++A8lNWRav5U1qY=;
        b=kf7xsejgCuxE/ZJ9iU8I85vyEyl1BU/ql74jX+WolwxhvZhhOr+lhYPVTfE2/hSwab
         BITpgOCRXSVEb+uL/CPJKJdw9HYYZQgX7RnwCz4g0K/rK2f5vrL49BYpWrzoBUWE7nNu
         eDy1hx1Z2dcZLX27VPw36sI4iCYusmuvTemU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703047651; x=1703652451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGBwOuSzTgvJ564O2l/POGSwftHo++A8lNWRav5U1qY=;
        b=V44B2NKDuu4CHv9p3UxurtavfBnJA87MCZbqdq0esDi9O6Gv/kLbEVCEjzH2cmmf7Q
         yForhC/F6MY1FlSEmbmbAAynpdCj4Lrlz500CUX+yllWCQRpo7e8a5c1fgUO3fciexHr
         O6qdyQgwDQ91qDen9P3iAZPMT+8fVwlugmS7lskCMur6mmhmBDOWr4AZ7/sJNLLe3ZI6
         aqG89EFDFT86QkbtfbYF3gs/w9g4hWRAM6jTwHEn5KY5YFEScY2PifsEESby61pl1nq6
         DwYTSqUQ8jBLlnKATPgtnP+G0+N4GNHnoSvXcg+nSGEyfvMG2TIBM2irN2z7fj64K5Y3
         R7Pw==
X-Gm-Message-State: AOJu0YzilDC0grFchmCVZBhKS6iZmuOkMy40u+JR7y4SKzBiyj7PlsBH
	05/cukvu4vSDOg6LQjSZqnA6sDO2kWdKcYhvWotAUw==
X-Google-Smtp-Source: AGHT+IHbjHcRfRJu/ZrWR1Hgxpw6NDtClFIZVJjHkzGFgEVcdEeXYka8IgZBxf2DVdDRxMHXHjY1nCGSAK3APRmIxd0=
X-Received: by 2002:a17:906:1447:b0:a23:65de:419c with SMTP id
 q7-20020a170906144700b00a2365de419cmr1808741ejc.144.1703047650886; Tue, 19
 Dec 2023 20:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org> <20231214135103.1606605-6-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-6-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:19 -0700
Message-ID: <CAPnjgZ38rEbOH-nPktG=O2iD3RKpzoEX1BrmF9TnGyFWPKgppw@mail.gmail.com>
Subject: Re: [PATCH 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1951

Hi Sumit,

On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
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
>  doc/develop/devicetree/control.rst | 108 +++++++++++++++++++++++------
>  1 file changed, 86 insertions(+), 22 deletions(-)
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index cbb65c9b177..12ef55ed368 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -1,5 +1,6 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  .. sectionauthor:: Copyright 2011 The Chromium OS Authors
> +.. Copyright 2023 Linaro Ltd.
>
>  Devicetree Control in U-Boot
>  ============================
> @@ -22,12 +23,11 @@ for three reasons:
>    hierarchical format
>  - It is fairly efficient to read incrementally
>
> -The arch/<arch>/dts directories contains a Makefile for building the devicetree
> -blob and embedding it in the U-Boot image. This is useful since it allows
> -U-Boot to configure itself according to what it finds there. If you have
> -a number of similar boards with different peripherals, you can describe
> -the features of each board in the devicetree file, and have a single
> -generic source base.
> +The U-boot Makefile infrastructure allows for building the devicetree blob
> +and embedding it in the U-Boot image. This is useful since it allows U-Boot
> +to configure itself according to what it finds there. If you have a number
> +of similar boards with different peripherals, you can describe the features
> +of each board in the devicetree file, and have a single generic source base.
>
>  To enable this feature, add CONFIG_OF_CONTROL to your board config file.
>
> @@ -68,8 +68,21 @@ a binary file. U-Boot adds its own `fdtgrep` for creating subsets of the file.
>  Where do I get a devicetree file for my board?
>  ----------------------------------------------
>
> -You may find that the Linux kernel has a suitable file. Look in the
> -kernel source in arch/<arch>/boot/dts.
> +Linux kernel Git repository has been the place where devicetree files along
> +with devicetree bindings are stored and maintained. There is devicetee-rebasing
> +(dtrepo_) which maintains a forked copy of devicetree files along with bindings
> +at every Linux kernel major release or intermideate release candidates.
> +
> +In order to maintain devicetree files sync, U-boot maintains a Git subtree for
> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is regularly
> +kept updated with every new kernel major release via subtree pull as follows::
> +
> +    git subtree pull --prefix devicetree-rebasing \
> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> +        <release-tag> --squash
> +
> +You may find that the `devicetee-rebasing/` sub-directory has a suitable
> +devicetree file for your board. Look in `devicetree-rebasing/src/<arch>/`.
>
>  If not you might find other boards with suitable files that you can
>  modify to your needs. Look in the board directories for files with a
> @@ -81,18 +94,21 @@ Failing that, you could write one from scratch yourself!
>  Configuration
>  -------------
>
> -Use::
> +Traditionally, U-boot placed copies of devicetree source files from Linux
> +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via::
>
> -   #define CONFIG_DEFAULT_DEVICE_TREE  "<name>"
> +    #define CONFIG_DEFAULT_DEVICE_TREE "<name>"
>
> -to set the filename of the devicetree source. Then put your devicetree
> -file into::
> +However, it has become combersome over time for each SoC/board maintainer to
> +keep devicetree files in sync with Linux kernel. Thereby, SoC/board maintainers
> +are encouraged to migrate to use mirrored copies from `devicetree-rebasing/`
> +into `dts/arch/<arch>/<vendor>` via::
>
> -   arch/<arch>/dts/<name>.dts
> +    #define CONFIG_OF_UPSTREAM=y
> +    #define CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
>
> -This should include your CPU or SOC's devicetree file, placed in
> -`arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
> -file for your board.
> +This should include your CPU or SOC's devicetree file. On top of that any U-boot
> +specific tweaks (see: dttweaks_) can be made for your board.
>
>  If CONFIG_OF_EMBED is defined, then it will be picked up and built into
>  the U-Boot image (including u-boot.bin). This is suitable for debugging
> @@ -156,8 +172,9 @@ ways:
>  Adding tweaks for U-Boot
>  ------------------------
>
> -It is strongly recommended that devicetree files in U-Boot are an exact copy of
> -those in Linux, so that it is easy to sync them up from time to time.
> +With devicetee-rebasing Git subtree, it is ensured that devicetree files in
> +U-Boot are an exact copy of those in Linux kernel via mirroring into
> +`dts/arch/<arch>/<vendor>`.
>
>  U-Boot is of course a very different project from Linux, e.g. it operates under
>  much more restrictive memory and code-size constraints. Where Linux may use a
> @@ -170,8 +187,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
>  unwanted nodes, or even turned into C code to avoid access overhead.
>
>  U-Boot automatically looks for and includes a file with updates to the standard
> -devicetree for your board, searching for them in the same directory as the
> -main file, in this order::
> +devicetree for your board, searching for them in `arch/<arch>/dts/` in this
> +order::
>
>     <orig_filename>-u-boot.dtsi
>     <CONFIG_SYS_SOC>-u-boot.dtsi
> @@ -200,6 +217,52 @@ to specify a list of .dtsi files that will also be included when
>  building .dtb files.
>
>
> +Devicetree bindings schema checks
> +---------------------------------
> +
> +With devicetee-rebasing Git subtree, the devicetree bindings are also regularly
> +synced with Linux kernel as `devicetree-rebasing/Bindings/` sub-directory. This
> +allows U-boot to run devicetree bindings schema checks which will bring
> +compliance to U-boot core/drivers regarding usage of devicetree.
> +
> +Dependencies
> +~~~~~~~~~~~~
> +
> +The DT schema project must be installed in order to validate the DT schema
> +binding documents and validate DTS files using the DT schema. The DT schema
> +project can be installed with pip::
> +
> +    pip3 install dtschema
> +
> +Note that 'dtschema' installation requires 'swig' and Python development files
> +installed first. On Debian/Ubuntu systems::
> +
> +    apt install swig python3-dev
> +
> +Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> +installed. Ensure they are in your PATH (~/.local/bin by default).
> +
> +Recommended is also to install yamllint (used by dtschema when present).
> +
> +Running checks
> +~~~~~~~~~~~~~~
> +
> +In order to perform validation of DTB files, use the ``dtbs_check`` target::
> +
> +    make dtbs_check
> +
> +It is also possible to run checks with a subset of matching schema files by
> +setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files or
> +patterns (partial match of a fixed string). Each file or pattern should be
> +separated by ':'.
> +
> +::
> +
> +    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> +    make dtbs_check DT_SCHEMA_FILES=/gpio/
> +    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
> +
> +
>  Relocation, SPL and TPL
>  -----------------------
>
> @@ -261,8 +324,9 @@ used it before Linux (e.g. snow). The two projects developed in parallel
>  and there are still some differences in the bindings for certain boards.
>  While there has been discussion of having a separate repository for devicetree
>  files, in practice the Linux kernel Git repository has become the place where
> -these are stored, with U-Boot taking copies and adding tweaks with u-boot.dtsi
> -files.
> +these are stored, with U-Boot taking copies via devicetree-rebasing repo
> +(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
>
>  .. _dtspec: https://www.devicetree.org/specifications/
>  .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
> +.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> --
> 2.34.1
>

OK, ignore my comment about docs.

Regards,
Simon

