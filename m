Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881A6C47074
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.web10.20623.1703075902445058889
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 04:38:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=bqgfBFha;
 spf=pass (domain: linaro.org, ip: 209.85.222.41, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7c5cb5eeab1so1678109241.3
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703075901; x=1703680701; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d4W4dRnaBM3bam+j1uKaaszxZ/SRpPy2rmw/wXgnbA8=;
        b=bqgfBFha7sRzSO3uVfLqxrWpccXUoVZYkORg0CtZaeKdDqkedYhDSdpFpYWUVjY7G5
         qI8sQEhD3IbgfM1f2wZgl1GKJQgaO2tvcJPGxTJ9KhQWLiAUJDAHVO2vlgjNHfwPB6mn
         +RDJDR6NoAv+6HX+Z5AcBF/AM5uVog77o20Oo4w5DoXVpD7nzM5mra12GA5qHSAVQzR3
         e4WYDlUyc/ZABX/GVkUJdrSMxqjsLJwWpl+XV0dy+pbJik+2fSqGkr/gfberv6XEdXpg
         Nr6EZEC2oSVmKQlp2086MBwjkiJaXQM2LuCB+h0PcOM2VlpNxTCpcHb8N9sUs2D4p8uF
         2DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703075901; x=1703680701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4W4dRnaBM3bam+j1uKaaszxZ/SRpPy2rmw/wXgnbA8=;
        b=osl1KeipQ7rVEMY7cSlzDdFYLK/GteS+IYMStdslL//kvu+NgjqOz6lRtfXCH9xpUg
         0HJ0bncUen9KMJXPISyuPZMaHG+xpJKf6NtbOpEMGoY30XRl0oNDFtwGdzyqNktFbWo+
         HnDjTz5vY6aMmlY3h0jVbZsAtz4HBoV5L58BVvOVZVHCXqCjjvw4bLu2OkQS+B5D0T+T
         UQ1z8lOCmGN8fD3QoPsdHod6sxy/IY0mv/EW+7wt9aHbCVKuOxIP0xIIT6/vXXStKjbo
         9jsKcPuuDnCUGxxiMKLsEqZOCnOf2I3O+pbxJ2DkMmPu8A7kfmFaU+GtCgIzePWoHTvq
         nYNg==
X-Gm-Message-State: AOJu0YwxElfgWc7YGHl+xUykeqzEyNr/u0VYtRm2loRVHDoM0SxGTFtW
	wcBsx/Fjm9VY33ZZPOc+wmJKgBqBOQId024+QFFPWg==
X-Google-Smtp-Source: AGHT+IHkZ9Jn1MCpM7OYAnIaJtCWgB4wzhWhhY3duN+JAPZarPQSbQxpaK0bneJzb2YOlpfOV1sM+zy44ZAsKVmd0xo=
X-Received: by 2002:a05:6102:3a0d:b0:464:4f99:67cd with SMTP id
 b13-20020a0561023a0d00b004644f9967cdmr15297776vsu.25.1703075901497; Wed, 20
 Dec 2023 04:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org> <9d01918f-a27b-4f52-87d3-674c52547d57@amd.com>
In-Reply-To: <9d01918f-a27b-4f52-87d3-674c52547d57@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 18:08:10 +0530
Message-ID: <CAFA6WYPBnh99je9HyNLx=p6ezCVfs9=atzwL9t1JzVBANSnq1Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Michal Simek <michal.simek@amd.com>, robh+dt@kernel.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1959

Hi Michal,

On Wed, 20 Dec 2023 at 16:14, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Sumit,
>
> On 12/14/23 14:50, Sumit Garg wrote:
> > Prerquisite
> > -----------
> >
> > This patch series requires devicetree-rebasing git repo to be added as a
> > subtree to the main U-boot repo via:
> >
> > $ git subtree add --prefix devicetree-rebasing \
> >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> >        v6.6-dts --squash
> >
> > Background
> > ----------
> >
> > This effort started while I was reviewing patch series corresponding to
> > Qcom platforms [1] which was about to import modified devicetree source
> > files from Linux kernel. I suppose keeping devicetree files sync with
> > Linux kernel without any DT bindings schema validation has been a pain
> > for U-boot SoC/platform maintainers. There has been past discussions
> > about a single DT repo but that hasn't come up and Linux kernel remained
> > the place where DT source files as well as bindings are placed and
> > maintained.
> >
> > However, Linux kernel DT maintainers proposed [2] for U-boot to rather
> > use devicetree-rebasing repo [3] which is a forked copy from Linux
> > kernel for DT source files as well as bindings. It is tagged at every
> > Linux kernel major release or intermideate release candidates. So here I
> > have tried to reuse that to bring DT bingings compliance as well as a
> > standard way to maintain a regular sync of DT source files with Linux
> > kernel.
> >
> > In order to maintain devicetree files sync, U-boot will maintains a Git
> > subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
> > It will be regularly updated with every new kernel major release via
> > subtree pull as follows::
> >
> > $ git subtree pull --prefix devicetree-rebasing \
> >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> >        <release-tag> --squash
> >
> > The RFC/prototype for this series has been discussed with Linux DT
> > maintainers as well as U-boot maintainers here [4]. Now we would like to
> > reach out to wider U-boot community to seek feedback.
> >
> > [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> > [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> > [4] https://github.com/u-boot/u-boot/pull/451
> >
> > Changes
> > -------
> >
> > Traditionally, U-boot placed copies of devicetree source files from Linux
> > kernel into `arch/<arch>/dts/<name>.dts`, which can be selected via:
> >
> > CONFIG_DEFAULT_DEVICE_TREE "<name>"
> >
> > SoC/board maintainers are encouraged to migrate to using mirrored copies
> > from `devicetree-rebasing/` into `dts/arch/<arch>/<vendor>` via:
> >
> > CONFIG_OF_UPSTREAM=y
> > CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
> >
> > An example have been shown for Amlogic meson-gxbb SoC and corresponding
> > derived boards via patch #7 and #8.
> >
> > Devicetree bindings schema checks
> > ---------------------------------
> >
> > With devicetee-rebasing Git subtree, the devicetree bindings are also
> > regularly synced with Linux kernel as `devicetree-rebasing/Bindings/`
> > sub-directory. This allows U-boot to run devicetree bindings schema checks
> > which will bring compliance to U-boot core/drivers regarding usage of
> > devicetree.
> >
> > Dependencies
> > ------------
> >
> > The DT schema project must be installed in order to validate the DT schema
> > binding documents and validate DTS files using the DT schema. The DT schema
> > project can be installed with pip:
> >
> > $ pip3 install dtschema
> >
> > Note that 'dtschema' installation requires 'swig' and Python development
> > files installed first. On Debian/Ubuntu systems:
> >
> > $ apt install swig python3-dev
> >
> > Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> > installed. Ensure they are in your PATH (~/.local/bin by default).
> >
> > Recommended is also to install yamllint (used by dtschema when present).
> >
> > Running checks
> > --------------
> >
> > In order to perform validation of DTB files, use the ``dtbs_check`` target:
> >
> > $ make dtbs_check
> >
> > It is also possible to run checks with a subset of matching schema files by
> > setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
> > or patterns (partial match of a fixed string). Each file or pattern should
> > be separated by ':'.
> >
> > $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> > $ make dtbs_check DT_SCHEMA_FILES=/gpio/
> > $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
>
> Do you also plan to extend this to cover dt overlay + dt base generation and
> check it against DT schema.

I suppose here you are referring to DT schema checks for *.dtso ->
*.dtbo generation. I don't see corresponding checks enabled in Linux
kernel [1]. Probably Rob can share plans over there.

U-Boot tries to follow Linux kernel kbuild framework. However, if
needed we can add checks for *.dtbo generation too as a follow up
patch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/scripts/Makefile.lib#n421

-Sumit

>
> Thanks,
> Michal
>

