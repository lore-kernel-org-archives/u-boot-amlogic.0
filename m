Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2870DC47DDC
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
 by mx.groups.io with SMTP id smtpd.web10.49886.1704356352237586802
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jan 2024 00:19:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AgSRVSEU;
 spf=pass (domain: linaro.org, ip: 209.85.217.43, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-466de67f0d6so125023137.1
        for <u-boot-amlogic@groups.io>; Thu, 04 Jan 2024 00:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704356351; x=1704961151; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UO5DwziMROSBF5JJMhyVc2R3+UJvQpROvonbnYACnks=;
        b=AgSRVSEUBmZ6RI3ABjykEJwek3ORmwf1w/9FBFllcMVed4vgW8K6jihw1CMTBf87cw
         aqg+ayugW6gyBx8eMwSzdErvb1gDtZ0zrQ+9YJPa0fa0W442c08upbNOvmdNTUuB1826
         gmnvgVSC/cB8w7U+EVdD/XpfGboZ7TJCiWCVquqK7Oz/BDC1knvv2ufvhqk4qj5d7DtM
         BXhNOAT5M2JASSEtc5aHOx8pK87gtWOZOMVXRbV1tCcDZuzsBVO1vkDWw+ScjsrEJvr+
         pSuBOZcE/1jU/66P6Z216WN3i/2e0/9Y3k5Vka+ER9wVPq7l4uviejcsGc9DKU66ZHxA
         ED4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704356351; x=1704961151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UO5DwziMROSBF5JJMhyVc2R3+UJvQpROvonbnYACnks=;
        b=UgWOttHmbF08qZ5Q1PfDoYmejwdQ36HXlE3E2GQ4QUDDW9UG3AfHg+YYldyrtsYMJR
         ES71c5a8rOY923BCKJfw6JOBansiWOXS5KD18B4TnuFvWuKm/6/luuWc39gmt6/0Qu8i
         1nz0c3I6t94nPkLQqQEGN2nKP9zYQmR4GTrnwaJz3WZjG9ocGIRTM52n3LDCmCKzpp3/
         KToAKbFYz0XO7Ivtcj6wKglHm3QuvS7br+8aoz6R2Au4WMtjUBixZk0nJXjbFp8q1uxc
         jtzGsA+PRKy942qYro5gpjXrSGPDBGsKZeBf9DZTHdsgTOy4taLfQ7RmntSzzQC9lT59
         ByUw==
X-Gm-Message-State: AOJu0Yw2ClQjC/Vo8cQo7Yhk0PdiWXVxfaMVAdKklftS2hK6bhOj6CYI
	ESXVLULCSqwb2i4vqxRRbYAEA+HN3zuAdTjTHz6S7VCksk4LAA==
X-Google-Smtp-Source: AGHT+IG1DZl6hNTwiB9EwnWnCaTBuxo9OIISjjaSRlyQ70lOkSZKysiQTsn7hbcTBqtR1IXG1KPs3TUoNxRznj0Z+Jw=
X-Received: by 2002:a05:6102:440a:b0:467:85d1:2732 with SMTP id
 df10-20020a056102440a00b0046785d12732mr75513vsb.3.1704356350933; Thu, 04 Jan
 2024 00:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org> <5602ebb2-25c9-4f0e-88b7-64662874d0f4@amd.com>
In-Reply-To: <5602ebb2-25c9-4f0e-88b7-64662874d0f4@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Jan 2024 13:48:59 +0530
Message-ID: <CAFA6WYNeVq9pM9Uau6bQdUMNw40-1sMHOGuYs4mfa3bX6Ob2TA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] An effort to bring DT bindings compliance within U-Boot
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2033

Hi Michal,

On Wed, 3 Jan 2024 at 18:24, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 12/28/23 12:57, Sumit Garg wrote:
> > Changes in v3:
> > --------------
> > - Patch #4: Minor commit message update
> > - Patch #5: Replace CONFIG_* with Kconfig options
> > - Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
> >    instead.
> > - Patch #1, #3, #6 and #8: Picked up review tags
> >
> > Changes in v2:
> > --------------
> > - Patch #1: excluded gitab CI config check and added commit description.
> > - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> > - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > - Patch #5: s/U-boot/U-Boot/
> > - Patch #6 and #7: Picked up review tags
> >
> > Prerequisite
> > ------------
> >
> > This patch series requires devicetree-rebasing git repo to be added as a
> > subtree to the main U-Boot repo via:
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
> > for U-Boot SoC/platform maintainers. There has been past discussions
> > about a single DT repo but that hasn't come up and Linux kernel remained
> > the place where DT source files as well as bindings are placed and
> > maintained.
> >
> > However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> > use devicetree-rebasing repo [3] which is a forked copy from Linux
> > kernel for DT source files as well as bindings. It is tagged at every
> > Linux kernel major release or intermideate release candidates. So here I
> > have tried to reuse that to bring DT bingings compliance as well as a
> > standard way to maintain a regular sync of DT source files with Linux
> > kernel.
> >
> > In order to maintain devicetree files sync, U-Boot will maintains a Git
> > subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
> > It will be regularly updated with every new kernel major release via
> > subtree pull as follows:
> >
> > $ git subtree pull --prefix devicetree-rebasing \
> >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> >        <release-tag> --squash
> >
> > The RFC/prototype for this series has been discussed with Linux DT
> > maintainers as well as U-Boot maintainers here [4]. Now we would like to
> > reach out to wider U-Boot community to seek feedback.
> >
> > [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> > [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> > [4] https://github.com/u-boot/u-boot/pull/451
> >
> > Changes
> > -------
> >
> > Traditionally, U-Boot placed copies of devicetree source files from Linux
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
> > sub-directory. This allows U-Boot to run devicetree bindings schema checks
> > which will bring compliance to U-Boot core/drivers regarding usage of
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
>
> I have been following your guidance here and I have also seen it to work but not
> sure why. Anyway I have strong suspicious that any Makefile rule is not right.
>

Thanks for taking time to test DT schema checks. It looks like your
suspicion is correct.

> I am getting this issue.
>
> /bin/sh: line 1: @: command not found
> make[1]: *** [devicetree-rebasing/Bindings/Makefile:68:
> devicetree-rebasing/Bindings/processed-schema.json] Error 127
> make: *** [Makefile:1181: dt_binding_check] Error 2
>

I was able to reproduce this issue once I installed yamllint on my
Ubuntu machine.

>
> devicetree-rebasing/Bindings/processed-schema.json is not generated properly
>
> I am using the latest dt schema
> $ dt-validate -V
> 2023.12.dev6+gfb80ec43c204
>
> and no issue to run it from Linux source code that's why I expect it is not
> issue with my PC in general.
> Do you know what can be wrong?

The issue here is basically due to old U-Boot Kbuild infrastructure
which isn't in sync with Linux kernel. This Kbuild commit [1] changes
aren't present in U-Boot leading to this issue.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a2429e1faf40b2aaa481aa4b001a74d222c7e8b

Following change to adapt bindings Makefile to old U-Boot Kbuild
expectation should resolve this issue:

diff --git a/devicetree-rebasing/Bindings/Makefile
b/devicetree-rebasing/Bindings/Makefile
index 8b395893bd8..7d08372691c 100644
--- a/devicetree-rebasing/Bindings/Makefile
+++ b/devicetree-rebasing/Bindings/Makefile
@@ -47,9 +47,9 @@ quiet_cmd_mk_schema = SCHEMA  $@
                      rm -f $$f

 define rule_chkdt
-       $(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
-       $(call cmd,chk_bindings)
-       $(call cmd,mk_schema)
+       $(if $(DT_SCHEMA_LINT),$(call echo-cmd,yamllint) $(cmd_yamllint),); \
+       $(call echo-cmd,chk_bindings) $(cmd_chk_bindings); \
+       $(call echo-cmd,mk_schema) $(cmd_mk_schema)
 endef

 DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))

If this works for you then I will include it as a separate patch for v4.

-Sumit

>
> Thanks,
> Michal
>

