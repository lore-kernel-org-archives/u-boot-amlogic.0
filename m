Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6021BC47258
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.8903.1704882969130522139
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:36:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ZW+8INHV;
 spf=pass (domain: linaro.org, ip: 209.85.214.179, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4ba539f6cso36057485ad.3
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882968; x=1705487768; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZxNzg5aBJZO2W0gAe8SFiVBufVY2+HM0fJnTFfujyE=;
        b=ZW+8INHVgF822GraUxe8TJGKx38UIu24tiW91l7msLUtL9TspCWfuqo/wUICca3PNQ
         Fwj5tHzl0eFuz9YFS0SFQLOpG2fYJHyla5GfDcF+IVhqEozAGD6RiBpeoQwUnscKHIAf
         YCzaAmxxJIrU3rsO0Kg99jPDNf5mXmBb7C1lBOwDqWUL8xHQjpIgenBVF0ztzASjMho5
         CE2yquAYrsDfyIrjlNf5Pz9H+soQnykVpjYdAn51F2WbsUK7x5kyxHvC+kJ3haprsJzB
         6Qemivv1mY3Bhj8OY3hOgQjYZZpXRvIss5HDD99nziI4qKU1qOHtk0o980ZBl+4foyuA
         8fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882968; x=1705487768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZxNzg5aBJZO2W0gAe8SFiVBufVY2+HM0fJnTFfujyE=;
        b=CNJbeLXy/UK688h9E0yhCbk1aCttI0ziH/VfN9J0UH6pIKfSsednXAODqnAAxlDlNP
         2UhZ9DZjAUUTTSMKxEqx1ksM5ab2/ZSlQC/qkqEOiqWLDYYOlOjvmMJ2QwXLECKWKqIU
         3BZvXyy13o0XLGzbJUHoDBG7m/9Hsbbfn3N+DbuhSdX+8aMiyYuLNNiiJRiA3DK4i8QE
         LR15aD4RblpL+nSJGsnItUqQV+eOJyYgqqamXTCM9pJb8dI4Cr41jdRDm8UBuU/cR+ws
         Ic/WVP2Nq0kc4yCIT9aiU/Jemb8bHgPuEIbptDwXiBiwnX5N0572M6Xz9wnGi+QY6ZCO
         IEdQ==
X-Gm-Message-State: AOJu0YydB56o/kh4afqRp2n5lkhQ8TzGZv3u6H/vY4YEQFkYnOl4fbBz
	nmJW1KdwLIq91S5p6yI0CelDh9fbG8IMVQ==
X-Google-Smtp-Source: AGHT+IEHPAs61Nduid1Ig/SgvSsDgusCU5odruj87f7TzB7yN87dIIGSPXxf7cgADycE9Bxlgmox8Q==
X-Received: by 2002:a17:903:4c2:b0:1d4:e011:789e with SMTP id jm2-20020a17090304c200b001d4e011789emr800937plb.78.1704882968410;
        Wed, 10 Jan 2024 02:36:08 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:36:07 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	neil.armstrong@linaro.org,
	caleb.connolly@linaro.org,
	ff@shokubai.tech,
	daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org,
	pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org,
	b.galvani@gmail.com,
	xypron.glpk@gmx.de,
	michal.simek@amd.com,
	seanga2@gmail.com,
	rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com,
	jh80.chung@samsung.com,
	rfried.dev@gmail.com,
	marex@denx.de,
	mibodhi@gmail.com,
	bb@ti.com,
	mark.kettenis@xs4all.nl,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
Date: Wed, 10 Jan 2024 16:05:36 +0530
Message-Id: <20240110103547.719757-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2057

Changes in v4:
--------------
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Since we now have v6.7-dts tag available now, so switch subtree to
  that from its beginning.
- Patch #2: Incorporate build fix to adjust Bindings Makefile rules to
  old U-Boot Kbuild infrastructure.
- Patch #3: Incorporate fix to resolve rk3399 migration issue reported
  by Simon.
- Patch #4: New patch to reuse upstream DT includes by U-Boot as per
  Brian's use-case for TI K3 SoCs.
- Patch #5: Added a note to OF_UPSTREAM Kconfig option.
- Patch #6: New patch to add script dts/update-dts-subtree.sh as per
  Rob's comments.
- Patch #7: Separate patch to align documentation to use Kconfig symbols
  instead.
- Patch #8: Clarify subtree uprev schedule as a separate documentation
  section. Also, fixed documentation typos.
- Patch #9: Added commit description.

Changes in v3:
--------------
- Patch #4: Minor commit message update
- Patch #5: Replace CONFIG_* with Kconfig options
- Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
  instead.
- Patch #1, #3, #6 and #8: Picked up review tags

Changes in v2:
--------------
- Patch #1: excluded gitab CI config check and added commit description.
- Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
- Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
- Patch #5: s/U-boot/U-Boot/
- Patch #6 and #7: Picked up review tags

Prerequisite
------------

This patch series requires devicetree-rebasing git repo to be added as a
subtree to the main U-Boot repo via:

$ git subtree add --prefix dts/upstream \
      git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
      v6.7-dts --squash

Background
----------

This effort started while I was reviewing patch series corresponding to
Qcom platforms [1] which was about to import modified devicetree source
files from Linux kernel. I suppose keeping devicetree files sync with
Linux kernel without any DT bindings schema validation has been a pain
for U-Boot SoC/platform maintainers. There has been past discussions
about a single DT repo but that hasn't come up and Linux kernel remained
the place where DT source files as well as bindings are placed and
maintained.

However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
use devicetree-rebasing repo [3] which is a forked copy from Linux
kernel for DT source files as well as bindings. It is tagged at every
Linux kernel major release or intermideate release candidates. So here I
have tried to reuse that to bring DT bingings compliance as well as a
standard way to maintain a regular sync of DT source files with Linux
kernel.

In order to maintain devicetree files sync, U-Boot will maintains a Git
subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
U-Boot will regularly sync `dts/upstream/` subtree whenever the next window
opens with the next available kernel major release.
`dts/update-dts-subtree.sh` script provides a wrapper around git subtree
pull command, usage from the top level U-Boot source tree, run:

$ ./dts/update-dts-subtree.sh <devicetree-rebasing-release-tag>

The RFC/prototype for this series has been discussed with Linux DT
maintainers as well as U-Boot maintainers here [4]. Now we would like to
reach out to wider U-Boot community to seek feedback.

[1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
[2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
[4] https://github.com/u-boot/u-boot/pull/451

Changes
-------

Traditionally, U-Boot placed copies of devicetree source files from Linux
kernel into `arch/<arch>/dts/<name>.dts` which can be selected via setting
"<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.

SoC/board maintainers are encouraged to migrate to use synced copies from
`dts/upstream/src/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` for the
SoC being used via Kconfig and set up "<vendor>/<name>" when prompted for
`DEFAULT_DEVICE_TREE` by Kconfig.

An example have been shown for Amlogic meson-gxbb SoC and corresponding
derived boards via patch #10 and #11.

Devicetree bindings schema checks
---------------------------------

With devicetee-rebasing Git subtree, the devicetree bindings are also
regularly synced with Linux kernel as `dts/upstream/Bindings/`
sub-directory. This allows U-Boot to run devicetree bindings schema checks
which will bring compliance to U-Boot core/drivers regarding usage of
devicetree.

Dependencies
------------

The DT schema project must be installed in order to validate the DT schema
binding documents and validate DTS files using the DT schema. The DT schema
project can be installed with pip:

$ pip3 install dtschema

Note that 'dtschema' installation requires 'swig' and Python development
files installed first. On Debian/Ubuntu systems:

$ apt install swig python3-dev

Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
installed. Ensure they are in your PATH (~/.local/bin by default).

Recommended is also to install yamllint (used by dtschema when present).

$ apt install yamllint

Running checks
--------------

In order to perform validation of DTB files, use the ``dtbs_check`` target:

$ make dtbs_check

It is also possible to run checks with a subset of matching schema files by
setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
or patterns (partial match of a fixed string). Each file or pattern should
be separated by ':'.

$ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
$ make dtbs_check DT_SCHEMA_FILES=/gpio/
$ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml

Sumit Garg (11):
  CI: Exclude devicetree-rebasing subtree for CONFIG checks
  Makefile: Add support for DT bindings schema checks
  scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
  Makefile: Allow upstream DT subtree to provide DT includes
  dts: Add alternative location for upstream DTB builds
  dts: Add script to uprev dts/upstream subtree
  doc: devicetree: Align documentation to use Kconfig options
  doc: devicetree: Updates for devicetree-rebasing subtree
  MAINTAINERS: Add myself as devicetree-rebasing maintainer
  dts: meson-gxbb: Switch to using upstream DT
  dts: meson-gxbb: Drop redundant devicetree files

 .azure-pipelines.yml                    |   3 +-
 .gitlab-ci.yml                          |   3 +-
 MAINTAINERS                             |   5 +
 Makefile                                |  23 +-
 arch/arm/dts/Makefile                   |   8 -
 arch/arm/dts/meson-gxbb-kii-pro.dts     | 140 ----
 arch/arm/dts/meson-gxbb-nanopi-k2.dts   | 426 ------------
 arch/arm/dts/meson-gxbb-odroidc2.dts    | 414 -----------
 arch/arm/dts/meson-gxbb-p200.dts        | 100 ---
 arch/arm/dts/meson-gxbb-p201.dts        |  26 -
 arch/arm/dts/meson-gxbb-p20x.dtsi       | 250 -------
 arch/arm/dts/meson-gxbb-wetek-hub.dts   |  58 --
 arch/arm/dts/meson-gxbb-wetek-play2.dts | 119 ----
 arch/arm/dts/meson-gxbb-wetek.dtsi      | 292 --------
 arch/arm/dts/meson-gxbb.dtsi            | 870 ------------------------
 arch/arm/mach-meson/Kconfig             |   1 +
 configs/nanopi-k2_defconfig             |   2 +-
 configs/odroid-c2_defconfig             |   2 +-
 configs/p200_defconfig                  |   2 +-
 configs/p201_defconfig                  |   2 +-
 configs/videostrong-kii-pro_defconfig   |   2 +-
 configs/wetek-hub_defconfig             |   2 +-
 configs/wetek-play2_defconfig           |   2 +-
 doc/develop/devicetree/control.rst      | 158 +++--
 dts/Kconfig                             |  16 +
 dts/Makefile                            |  17 +-
 dts/update-dts-subtree.sh               |  24 +
 dts/upstream/Bindings/Makefile          |   6 +-
 dts/upstream/src/arm64/Makefile         |  14 +
 scripts/Makefile.lib                    |  49 +-
 30 files changed, 256 insertions(+), 2780 deletions(-)
 delete mode 100644 arch/arm/dts/meson-gxbb-kii-pro.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-nanopi-k2.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-odroidc2.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-p200.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-p201.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
 delete mode 100644 arch/arm/dts/meson-gxbb-wetek-hub.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-wetek-play2.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-wetek.dtsi
 delete mode 100644 arch/arm/dts/meson-gxbb.dtsi
 create mode 100755 dts/update-dts-subtree.sh
 create mode 100644 dts/upstream/src/arm64/Makefile

-- 
2.34.1


