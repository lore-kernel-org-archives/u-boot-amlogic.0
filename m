Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91632C54E66
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:38 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
 by mx.groups.io with SMTP id smtpd.web10.16574.1709273845709855739
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Feb 2024 22:17:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=deml81vX;
 spf=pass (domain: linaro.org, ip: 209.85.217.42, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-472754e41e7so438298137.3
        for <u-boot-amlogic@groups.io>; Thu, 29 Feb 2024 22:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709273845; x=1709878645; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KgYXkM45W5rzcrzJJuCIwT2/uUlNuR58rM2M1XihuTg=;
        b=deml81vXOFGyihC5BIIeDoBYM4nkg3HcNQ79VfIVd/hBm1pzmCQ6u13ePwjVjzQCqY
         MgTdPfzZQZIsqOc1eFXX0lpFEYbpGeHgfDRJIp0hVhvSTslO8ZdkzNlsghw4M7ftFXoh
         HqK8aWyfeNqOGNupOXltPbA5heT6Fni/7J5EXk7v6iFwHoGjg4KKxiwuPXJZ76bw7Uol
         TY22uyPqVDS17oaLdB/jDfHi9zIOcYTRnePaSavW8WzGbk7ZKi2fF8uzho2kbgtae5Hh
         KLwM5ktaUpq4e3MuSR898DhCtTYLVbcDFm9F8YAOA0jqG3MkNO5WUuESBi38mD1SFr3n
         Vu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709273845; x=1709878645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgYXkM45W5rzcrzJJuCIwT2/uUlNuR58rM2M1XihuTg=;
        b=PLdguWINhATenw2myYiuXK1GbwtVUKn29kejUBrqFfDjLd2pzf0hGyw2dz0XfHast5
         FA7gb1mqvk4M8lyXsXXUywadSBJgF4ZX9Dsbir6hbGxm6y3XqvJ77znjOUozfa4Xl05C
         nybPbjXpfyokeoM8e/xL1T+l7gsRU7i97pdA3crXz8EXUJ6AqkZ1BU8GBjLFd4QxRmk8
         Wm8K4ucSo17kH4r1dXCc05DDOBC4++PIpto2qawHial++FtKrcSAr71jLwWdxAGzTsAH
         K2q/Tc2Uex0ZFZjWRW0fYMuKafSiB29Gi68m9ipxdPc4o7FNEwQi+/9IcXZXdQsNJETW
         nGCw==
X-Forwarded-Encrypted: i=1; AJvYcCV2dlbgfPEF1OBmKLFQFGsYO2/B5RUDsQfYcnHfsp5yt8G6Ng2jtBuaIThW1Sa7hcXsplxgPs2OZ7GcwfYSN6yDushjA1rIFr4=
X-Gm-Message-State: AOJu0YxtkC+ouCeVsNzzYCc1Rzy6De+8WMMlafJKHPLgHjDtFQ0xT4S7
	bnVyjzc4VpQc5LTJ8bafP3RuqBbFnbdzKh2pbgsHXn3g5CE3sNqCjBHQp0ueBz08tQZp76iSQ8A
	JeS8XLOUuAqFOzzjl7KwowquoUTYQ7wOjYWXO/w==
X-Google-Smtp-Source: AGHT+IEhH1bj/C/FBamHXdsY+gOYj43LkQIRIeeh2OVX7IP4ckHlUj0BTAZEcm3JBjJMVHVLtxQjvLwAoJ//P1XCC1E=
X-Received: by 2002:a67:b408:0:b0:472:7227:b1f8 with SMTP id
 x8-20020a67b408000000b004727227b1f8mr457347vsl.19.1709273844663; Thu, 29 Feb
 2024 22:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Mar 2024 11:47:13 +0530
Message-ID: <CAFA6WYP4ioYxdY+3EQz-FT_eO5gOmAME+7BcXD4vWuqhLV2uAQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within U-Boot
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
	nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk, 
	paul.barker.ct@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2151

Hi Tom,

On Thu, 22 Feb 2024 at 15:06, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Changes in v6:
> --------------
> - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> - Patch #3: Incorporate fix for sandbox CI failure.
> - Patch #6: Incorporate shell script comments from Marek.
> - Patch #8: Incorporate documentation review comments from Paul.
>

I haven't heard any major feedback/comments for v6. So can you pick up
this series for the U-Boot -next branch? As you may already be aware
that it is a dependency for [1] [2] [3]. Also, we would like to move
all new Qcom platforms to use upstream DT too.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=396399
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=396742
[3] https://patchwork.ozlabs.org/project/uboot/list/?series=396992&state=*

-Sumit

> Changes in v5:
> --------------
> - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> - Created v5_dt branch for testing purposes:
>   https://github.com/b49020/u-boot/tree/v5_dt
> - Patch #6: Added support to cherry-pick fixes in subtree update script.
>   Also, used https:// instead of git://.
> - Patch #7: Fixed inappropriate documentation update.
> - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
>   tree.
>
> Changes in v4:
> --------------
> - Switched subtree to be imported as dts/upstream sub-directory rather
>   than devicetree-rebasing sub-directory to better suite U-Boot
>   directory structure.
> - Since we now have v6.7-dts tag available now, so switch subtree to
>   that from its beginning.
> - Patch #2: Incorporate build fix to adjust Bindings Makefile rules to
>   old U-Boot Kbuild infrastructure.
> - Patch #3: Incorporate fix to resolve rk3399 migration issue reported
>   by Simon.
> - Patch #4: New patch to reuse upstream DT includes by U-Boot as per
>   Brian's use-case for TI K3 SoCs.
> - Patch #5: Added a note to OF_UPSTREAM Kconfig option.
> - Patch #6: New patch to add script dts/update-dts-subtree.sh as per
>   Rob's comments.
> - Patch #7: Separate patch to align documentation to use Kconfig symbols
>   instead.
> - Patch #8: Clarify subtree uprev schedule as a separate documentation
>   section. Also, fixed documentation typos.
> - Patch #9: Added commit description.
>
> Changes in v3:
> --------------
> - Patch #4: Minor commit message update
> - Patch #5: Replace CONFIG_* with Kconfig options
> - Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
>   instead.
> - Patch #1, #3, #6 and #8: Picked up review tags
>
> Changes in v2:
> --------------
> - Patch #1: excluded gitab CI config check and added commit description.
> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> - Patch #5: s/U-boot/U-Boot/
> - Patch #6 and #7: Picked up review tags
>
> Prerequisite
> ------------
>
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-Boot repo via:
>
> $ git subtree add --prefix dts/upstream \
>       https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>       v6.7-dts --squash
>
> Background
> ----------
>
> This effort started while I was reviewing patch series corresponding to
> Qcom platforms [1] which was about to import modified devicetree source
> files from Linux kernel. I suppose keeping devicetree files sync with
> Linux kernel without any DT bindings schema validation has been a pain
> for U-Boot SoC/platform maintainers. There has been past discussions
> about a single DT repo but that hasn't come up and Linux kernel remained
> the place where DT source files as well as bindings are placed and
> maintained.
>
> However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> use devicetree-rebasing repo [3] which is a forked copy from Linux
> kernel for DT source files as well as bindings. It is tagged at every
> Linux kernel major release or intermideate release candidates. So here I
> have tried to reuse that to bring DT bingings compliance as well as a
> standard way to maintain a regular sync of DT source files with Linux
> kernel.
>
> In order to maintain devicetree files sync, U-Boot will maintains a Git
> subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
> U-Boot will regularly sync `dts/upstream/` subtree whenever the next window
> opens with the next available kernel major release.
> `dts/update-dts-subtree.sh` script provides a wrapper around git subtree
> pull command, usage from the top level U-Boot source tree, run:
>
> $ ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
>
> If required it is also possible to cherry-pick fixes from
> devicetree-rebasing tree prior to next sync, usage:
>
> $ ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
>
> The RFC/prototype for this series has been discussed with Linux DT
> maintainers as well as U-Boot maintainers here [4]. Now we would like to
> reach out to wider U-Boot community to seek feedback.
>
> [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> [4] https://github.com/u-boot/u-boot/pull/451
>
> Changes
> -------
>
> Traditionally, U-Boot placed copies of devicetree source files from Linux
> kernel into `arch/<arch>/dts/<name>.dts` which can be selected via setting
> "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
>
> SoC/board maintainers are encouraged to migrate to use synced copies from
> `dts/upstream/src/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` for the
> SoC being used via Kconfig and set up "<vendor>/<name>" when prompted for
> `DEFAULT_DEVICE_TREE` by Kconfig.
>
> An example have been shown for Amlogic meson-gxbb SoC and corresponding
> derived boards via patch #10 and #11.
>
> Devicetree bindings schema checks
> ---------------------------------
>
> With devicetee-rebasing Git subtree, the devicetree bindings are also
> regularly synced with Linux kernel as `dts/upstream/Bindings/`
> sub-directory. This allows U-Boot to run devicetree bindings schema checks
> which will bring compliance to U-Boot core/drivers regarding usage of
> devicetree.
>
> Dependencies
> ------------
>
> The DT schema project must be installed in order to validate the DT schema
> binding documents and validate DTS files using the DT schema. The DT schema
> project can be installed with pip:
>
> $ pip3 install dtschema
>
> Note that 'dtschema' installation requires 'swig' and Python development
> files installed first. On Debian/Ubuntu systems:
>
> $ apt install swig python3-dev
>
> Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> installed. Ensure they are in your PATH (~/.local/bin by default).
>
> Recommended is also to install yamllint (used by dtschema when present).
>
> $ apt install yamllint
>
> Running checks
> --------------
>
> In order to perform validation of DTB files, use the ``dtbs_check`` target:
>
> $ make dtbs_check
>
> It is also possible to run checks with a subset of matching schema files by
> setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
> or patterns (partial match of a fixed string). Each file or pattern should
> be separated by ':'.
>
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> $ make dtbs_check DT_SCHEMA_FILES=/gpio/
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
>
> Sumit Garg (11):
>   CI: Exclude devicetree-rebasing subtree for CONFIG checks
>   Makefile: Add support for DT bindings schema checks
>   scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
>   Makefile: Allow upstream DT subtree to provide DT includes
>   dts: Add alternative location for upstream DTB builds
>   dts: Add script to uprev dts/upstream subtree
>   doc: devicetree: Align documentation to use Kconfig options
>   doc: devicetree: Updates for devicetree-rebasing subtree
>   MAINTAINERS: Add myself as devicetree-rebasing maintainer
>   dts: meson-gxbb: Switch to using upstream DT
>   dts: meson-gxbb: Drop redundant devicetree files
>
>  .azure-pipelines.yml                    |   3 +-
>  .gitlab-ci.yml                          |   3 +-
>  MAINTAINERS                             |   5 +
>  Makefile                                |  23 +-
>  arch/arm/dts/Makefile                   |   8 -
>  arch/arm/dts/meson-gxbb-kii-pro.dts     | 140 ----
>  arch/arm/dts/meson-gxbb-nanopi-k2.dts   | 426 ------------
>  arch/arm/dts/meson-gxbb-odroidc2.dts    | 414 -----------
>  arch/arm/dts/meson-gxbb-p200.dts        | 100 ---
>  arch/arm/dts/meson-gxbb-p201.dts        |  26 -
>  arch/arm/dts/meson-gxbb-p20x.dtsi       | 250 -------
>  arch/arm/dts/meson-gxbb-wetek-hub.dts   |  58 --
>  arch/arm/dts/meson-gxbb-wetek-play2.dts | 119 ----
>  arch/arm/dts/meson-gxbb-wetek.dtsi      | 292 --------
>  arch/arm/dts/meson-gxbb.dtsi            | 870 ------------------------
>  arch/arm/mach-meson/Kconfig             |   1 +
>  configs/nanopi-k2_defconfig             |   2 +-
>  configs/odroid-c2_defconfig             |   2 +-
>  configs/p200_defconfig                  |   2 +-
>  configs/p201_defconfig                  |   2 +-
>  configs/videostrong-kii-pro_defconfig   |   2 +-
>  configs/wetek-hub_defconfig             |   2 +-
>  configs/wetek-play2_defconfig           |   2 +-
>  doc/develop/devicetree/control.rst      | 159 +++--
>  dts/Kconfig                             |  16 +
>  dts/Makefile                            |  17 +-
>  dts/update-dts-subtree.sh               |  48 ++
>  dts/upstream/Bindings/Makefile          |   6 +-
>  dts/upstream/src/arm64/Makefile         |  14 +
>  scripts/Makefile.lib                    |  50 +-
>  30 files changed, 283 insertions(+), 2779 deletions(-)
>  delete mode 100644 arch/arm/dts/meson-gxbb-kii-pro.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-nanopi-k2.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-odroidc2.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-p200.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-p201.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
>  delete mode 100644 arch/arm/dts/meson-gxbb-wetek-hub.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-wetek-play2.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-wetek.dtsi
>  delete mode 100644 arch/arm/dts/meson-gxbb.dtsi
>  create mode 100755 dts/update-dts-subtree.sh
>  create mode 100644 dts/upstream/src/arm64/Makefile
>
> --
> 2.34.1
>

