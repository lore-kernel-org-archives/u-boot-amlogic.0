Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC0C5478C
	for <webhook@archiver.kernel.org>; Wed, 28 Feb 2024 15:28:25 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
 by mx.groups.io with SMTP id smtpd.web11.9516.1709112044672721362
 for <u-boot-amlogic@groups.io>;
 Wed, 28 Feb 2024 01:20:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QhrCf/pe;
 spf=pass (domain: linaro.org, ip: 209.85.221.173, mailfrom: sumit.garg@linaro.org)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4d34144d710so79463e0c.1
        for <u-boot-amlogic@groups.io>; Wed, 28 Feb 2024 01:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709112043; x=1709716843; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qVg7Ubi+CPqNxzouCdordqgYcNrP9Y52NUiBgRZmcDE=;
        b=QhrCf/pedNVHG75A7AJVLYj3MtsfEkbe66BIvkPLH2XANAihxGUCpfNH1Aw7Xt4qeB
         Bq4svlUqNGzzG6c4EjOUpJu0e/1NSYK2LYR7GR/aO2FVOm3CT5AdEVY52Cnqy4YSeB1a
         2m+SYFc+ocLXhDtWd0zCdue7Q/DbLNXanBZNq2d4ZYJVKjS9MZSqIcsvAHAezdsiEpTt
         3VoqLobTCJ+r0jNRaFodvv4XwbbjnbfP3hdGx5llQnKahETkeEC2sPz8tennCQd2UBAI
         eWBr/55thDbrceuwg5BuCxdiIw//WnZmrms+sLJ7dI33opBvreG4o4gloLFU3csFQWj6
         9sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112043; x=1709716843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVg7Ubi+CPqNxzouCdordqgYcNrP9Y52NUiBgRZmcDE=;
        b=Rn/3rRuQU8tG4gT8OjJ2b/Fcp8udt85+p5Se8jOaCTfZlnTIBWltrfmVUD2Osdb8F2
         tdGtkX/82sM8fAyYNVU/0oGo7INNw4xlp6STG2Jt0URsoqT3J237S+IsdvbzXO4g1c4f
         JLqvdN3Ft9by/lMGOnq72BWNaf/uTOQwpe4xGLzZiBYXjCciKQAaLDN6WvZohyB85znO
         7G9BafK4zw881DA58c4vi/VR1xO/b0gG5WWIHl1mR16QNAvOoXf5S7xt9jrnKRJBVdKd
         1gPS8RE+8uUWQxIAxWjZ4AeD9DdK/5ht5K4a0lJiJSv3iNknol5P5pRqA39cp2avGsGJ
         KpWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHSawTXLU4x8ZpjEfPsEqrXanHV5vguN+QlJc2M41sOXmTDpiCM2h4fBp3/xdeC1HMEBo/oBFQuWaJcxOFmYkSi/pm7+uOTk4=
X-Gm-Message-State: AOJu0YxsQKWCJBV6S7UrMoCvxY8HRb68OPGNUvwLYlncD7+BFLRb5z+o
	7aZY1aqkGdjkTThVLjI9yxNXZGUBsha+SA4UiOoaaU7kc/v5aNxY/8PS0cN6E7trFOmlOtwUmfE
	rmYbCZinNvISMt3zjXvMDJmLcDuuOF8EJGCz5yA==
X-Google-Smtp-Source: AGHT+IHk8OTDKKDmAwhyvP6XFWyjY9wkr4KXwFmy3ToLZud9nD+yMy4au1mFE2tUsqHwpXVAgRIXmBchpKRsS7n6D8U=
X-Received: by 2002:a05:6122:1b0c:b0:4d3:3414:e15c with SMTP id
 er12-20020a0561221b0c00b004d33414e15cmr1356967vkb.4.1709112043644; Wed, 28
 Feb 2024 01:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <20240222093607.3085545-9-sumit.garg@linaro.org> <2776f554-c19f-4974-aa9e-87279a6dfbfc@bp.renesas.com>
In-Reply-To: <2776f554-c19f-4974-aa9e-87279a6dfbfc@bp.renesas.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 28 Feb 2024 14:50:32 +0530
Message-ID: <CAFA6WYM6En8N_dpJaJ=YD+kmGXF+xwcT1We18iW4wuk0jvRFiQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] doc: devicetree: Updates for devicetree-rebasing subtree
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
	nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Feb 2024 15:28:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2149

Hi Paul,

On Wed, 28 Feb 2024 at 03:08, Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>
> Hi Sumit,
>
> On 22/02/2024 09:36, Sumit Garg wrote:
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
> > Changes in v6:
> > - Incorporate documentation review comments from Paul.
> >
>
> I have just a couple of tidy up suggestions for the links in this
> document - these let us avoid short reference names like `dtrepo` or
> `dttweaks` appearing in the document itself where they interrupt the
> flow of the text.

Although these are following the same pattern as `dtspec` and `dtlist`
, your suggestion sounds reasonable. However, I would just like to
avoid sending a newer version just for these since this patch-set is
already a dependency for others [1] [2].

If you agree then I can send a follow up patch to get rid of all the
short reference names in this document.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=396399
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=396742

-Sumit

> For each one I've just wrote out what I think the line
> above should be, I hope that makes sense.
>
> [...]
>
> > +Resyncing with devicetree-rebasing
> > +----------------------------------
> > +
> > +The devicetee-rebasing repository (dtrepo_) maintains a fork cum mirror copy of
>
> The `devicetree-rebasing repository`_ maintains a fork cum mirror copy of
>
> > +devicetree files along with the bindings synced at every Linux kernel major
> > +release or intermediate release candidates. The U-Boot maintainers regularly
> > +sync the `dts/upstream/` subtree from the devicetree-rebasing repo whenever
> > +the next branch opens (refer: :doc:`../release_cycle`) with the latest mainline
> > +Linux kernel release. To sync the `dts/upstream/` subtree, run::
> > +
> > +    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
> > +
> > +If required it is also possible to cherry-pick fixes from the
> > +devicetree-rebasing repository prior to next sync, usage::
> > +
> > +    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
> > +
> > +
> >  Configuration
> >  -------------
> >
> > -Set up "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig. Then put
> > -your devicetree file into::
> > +SoC/board maintainers are encouraged to migrate to use synced copies from
> > +`dts/upstream/src/<arch>/<vendor>`. To do that add `imply OF_UPSTREAM` for the
> > +SoC being used via Kconfig and set `DEFAULT_DEVICE_TREE=<vendor>/<name>` when
> > +prompted by Kconfig.
> >
> > -   arch/<arch>/dts/<name>.dts
> > +However, if `dts/upstream/` hasn't yet received devicetree source file for your
> > +newly added board support then you can add corresponding devicetree source file
> > +as `arch/<arch>/dts/<name>.dts`. To select that add `# CONFIG_OF_UPSTREAM is not
> > +set` and set `DEFAULT_DEVICE_TREE=<name>` when prompted by Kconfig.
> >
> > -This should include your CPU or SOC's devicetree file, placed in
> > -`arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
> > -file for your board.
> > +This should include your CPU or SoC's devicetree file. On top of that any U-Boot
> > +specific tweaks (see: dttweaks_) can be made for your board.
>
> specific tweaks (see: :ref:`dttweaks`) can be made for your board.
>
> >
> >  If `OF_EMBED` is selected by Kconfig, then it will be picked up and built into
> >  the U-Boot image (including u-boot.bin). This is suitable for debugging
> > @@ -155,8 +185,9 @@ ways:
> >  Adding tweaks for U-Boot
> >  ------------------------
> >
> > -It is strongly recommended that devicetree files in U-Boot are an exact copy of
> > -those in Linux, so that it is easy to sync them up from time to time.
> > +With `dts/upstream` Git subtree, it is ensured that devicetree files in U-Boot
> > +are an exact copy of those in Linux kernel available under
> > +`dts/upstream/src/<arch>/<vendor>`.
> >
> >  U-Boot is of course a very different project from Linux, e.g. it operates under
> >  much more restrictive memory and code-size constraints. Where Linux may use a
> > @@ -169,8 +200,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
> >  unwanted nodes, or even turned into C code to avoid access overhead.
> >
> >  U-Boot automatically looks for and includes a file with updates to the standard
> > -devicetree for your board, searching for them in the same directory as the
> > -main file, in this order::
> > +devicetree for your board, searching for them in `arch/<arch>/dts/` in this
> > +order::
> >
> >     <orig_filename>-u-boot.dtsi
> >     <CONFIG_SYS_SOC>-u-boot.dtsi
> > @@ -199,6 +230,48 @@ option to specify a list of .dtsi files that will also be included when
> >  building .dtb files.
> >
> >
> > +Devicetree bindings schema checks
> > +---------------------------------
> > +
> > +With devicetee-rebasing Git subtree, the devicetree bindings are also regularly
> > +synced with Linux kernel as `dts/upstream/Bindings/` sub-directory. This
> > +allows U-Boot to run devicetree bindings schema checks which will bring
> > +compliance to U-Boot core/drivers regarding usage of devicetree.
> > +
> > +Dependencies
> > +~~~~~~~~~~~~
> > +
> > +The DT schema project must be installed in order to validate the DT schema
> > +binding documents and validate DTS files using the DT schema. For installation
> > +instructions, refer to the DT schema project page (dtschema_).
>
> instructions, refer to the `DT schema project page`_.
>
> > +
> > +Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> > +installed. Ensure they are in your PATH (~/.local/bin by default).
> > +
> > +You should also install yamllint (used by dtschema when present). On Debian/
> > +Ubuntu systems::
> > +
> > +    apt install yamllint
> > +
> > +Running checks
> > +~~~~~~~~~~~~~~
> > +
> > +In order to perform validation of DTB files, use the ``dtbs_check`` target::
> > +
> > +    make dtbs_check
> > +
> > +It is also possible to run checks with a subset of matching schema files by
> > +setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files or
> > +patterns (partial match of a fixed string). Each file or pattern should be
> > +separated by ':'.
> > +
> > +::
> > +
> > +    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> > +    make dtbs_check DT_SCHEMA_FILES=/gpio/
> > +    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
> > +
> > +
> >  Relocation, SPL and TPL
> >  -----------------------
> >
> > @@ -260,8 +333,10 @@ used it before Linux (e.g. snow). The two projects developed in parallel
> >  and there are still some differences in the bindings for certain boards.
> >  While there has been discussion of having a separate repository for devicetree
> >  files, in practice the Linux kernel Git repository has become the place where
> > -these are stored, with U-Boot taking copies and adding tweaks with u-boot.dtsi
> > -files.
> > +these are stored, with U-Boot taking copies via devicetree-rebasing repo
>
> these are stored, with U-Boot taking copies via the `devicetree-rebasing repository`_
>
> > +(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
>
> and adding tweaks with u-boot.dtsi files.
>
> >
> >  .. _dtspec: https://www.devicetree.org/specifications/
> >  .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
> > +.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
>
> .. _devicetree-rebasing repository: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
>
> > +.. _dtschema: https://github.com/devicetree-org/dt-schema/tree/main
>
> .. _DT schema project page: https://github.com/devicetree-org/dt-schema/tree/main
>
> Thanks,
>
> --
> Paul Barker

