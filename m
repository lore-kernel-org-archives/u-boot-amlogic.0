Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E60C47DD7
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.121385.1703764707767490693
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 03:58:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=bzyQZcoe;
 spf=pass (domain: linaro.org, ip: 209.85.214.172, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3eb299e2eso28137065ad.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 03:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703764707; x=1704369507; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GxMXClwD9vUmpuV83YCdcBGWcfgC711sy1kH6OqMoaM=;
        b=bzyQZcoemZxWnA3y1VNBul6qfdjyR636A803Osgkbj0ug64Szt2mKsg4gHnlFGngsr
         ZXzexEL5V0WOJJMWmi4Elxati/QJW96AbOL5QipqI28AgiHgvfShDoav62r/STzzCKrd
         i4+D3RHpyrJGxYopUf19D0vb0xUcmfbhIoav9xS2Tw01gsobtHlAZ+0RUcd+Nh8paLfN
         G5jjRTIXlRHPsBrLQ7/k8HLNXO6MW9knNIgykIJHivG2a3IIQxjCoyuqUh1glMS4rd69
         2qrgg97stNk+vE6e6oVeLONge7/w88wQ5jbwFYyQpqifXnfGzZuMqZ1zCgSgYeae0FNN
         SCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764707; x=1704369507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxMXClwD9vUmpuV83YCdcBGWcfgC711sy1kH6OqMoaM=;
        b=o8RRHKOdtfA+N5/TFQJabT95DrRz41FUl956XuGKtubBdUP/eosHbzuIln+rJYJhCU
         pjlDV+WWzzWqMXbymkJk5h/NDRj7iJuuNA/UoKUzXLGpLzbnvXQdE+ga+X7suAyHbhnr
         APiFZlE7m53gULnXW0tde+aEHpZFdnVx7bM6MMMCdSPgIWuridfhT62kwCQFIlW1cT1O
         fsXyuBZEsFGgboRqh/LpZAqPwF8sj1+p/x9g90IQ93wLVICFsnZkS8wkXI08BqhlIM1K
         s5PtklVozU3Tl8Gdc4aujxMPTJJZB//7LEVSt5w7falFnJJO6IeuHMZYa3sv+5DYp2SK
         Rvaw==
X-Gm-Message-State: AOJu0Yz1zO79oUuApM1RJl9kbBBh0ZMsHin5BKeG0fiPaXGxmip1A76u
	JnpWWpZ+fAqy7VXOUHyppg+HYVI0+Bh2T/l9THqF8Ok+CXp7PQ==
X-Google-Smtp-Source: AGHT+IG0lp3hgLaDMnlNqdMBZERyvpdgRXZZpRUygA0Zn2dBjUAmeMT6uXldD1OEUeCR2L3N701d7A==
X-Received: by 2002:a17:902:f689:b0:1d4:87c8:1cfa with SMTP id l9-20020a170902f68900b001d487c81cfamr1465825plg.35.1703764707076;
        Thu, 28 Dec 2023 03:58:27 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:58:26 -0800 (PST)
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/8] An effort to bring DT bindings compliance within U-Boot
Date: Thu, 28 Dec 2023 17:27:56 +0530
Message-Id: <20231228115804.3626579-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1980

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

$ git subtree add --prefix devicetree-rebasing \
      git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
      v6.6-dts --squash

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
subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
It will be regularly updated with every new kernel major release via
subtree pull as follows:

$ git subtree pull --prefix devicetree-rebasing \
      git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
      <release-tag> --squash

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
kernel into `arch/<arch>/dts/<name>.dts`, which can be selected via:
 
CONFIG_DEFAULT_DEVICE_TREE "<name>"
 
SoC/board maintainers are encouraged to migrate to using mirrored copies
from `devicetree-rebasing/` into `dts/arch/<arch>/<vendor>` via:
 
CONFIG_OF_UPSTREAM=y
CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"

An example have been shown for Amlogic meson-gxbb SoC and corresponding
derived boards via patch #7 and #8.

Devicetree bindings schema checks
---------------------------------

With devicetee-rebasing Git subtree, the devicetree bindings are also
regularly synced with Linux kernel as `devicetree-rebasing/Bindings/`
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

Sumit Garg (8):
  CI: Exclude devicetree-rebasing subtree for CONFIG checks
  Makefile: Add support for DT bindings schema checks
  scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
  dts: Add alternative location for upstream DTB builds
  doc: devicetree: Updates for devicetree-rebasing subtree
  MAINTAINERS: Add myself as devicetree-rebasing maintainer
  dts: meson-gxbb: Switch to using upstream DT
  dts: meson-gxbb: Drop redundant devicetree files

 .azure-pipelines.yml                    |   3 +-
 .gitlab-ci.yml                          |   3 +-
 MAINTAINERS                             |   6 +
 Makefile                                |  20 +-
 arch/arm/dts/Makefile                   |   8 -
 arch/arm/dts/meson-gxbb-kii-pro.dts     | 140 ----
 arch/arm/dts/meson-gxbb-nanopi-k2.dts   | 415 ------------
 arch/arm/dts/meson-gxbb-odroidc2.dts    | 418 ------------
 arch/arm/dts/meson-gxbb-p200.dts        | 100 ---
 arch/arm/dts/meson-gxbb-p201.dts        |  26 -
 arch/arm/dts/meson-gxbb-p20x.dtsi       | 250 -------
 arch/arm/dts/meson-gxbb-wetek-hub.dts   |  58 --
 arch/arm/dts/meson-gxbb-wetek-play2.dts | 119 ----
 arch/arm/dts/meson-gxbb-wetek.dtsi      | 292 --------
 arch/arm/dts/meson-gxbb.dtsi            | 856 ------------------------
 arch/arm/mach-meson/Kconfig             |   1 +
 configs/nanopi-k2_defconfig             |   2 +-
 configs/odroid-c2_defconfig             |   2 +-
 configs/p200_defconfig                  |   2 +-
 configs/p201_defconfig                  |   2 +-
 configs/videostrong-kii-pro_defconfig   |   2 +-
 configs/wetek-hub_defconfig             |   2 +-
 configs/wetek-play2_defconfig           |   2 +-
 doc/develop/devicetree/control.rst      | 131 +++-
 dts/Kconfig                             |  11 +
 dts/Makefile                            |  17 +-
 dts/arch/arm64/Makefile                 |  14 +
 dts/arch/arm64/amlogic                  |   1 +
 scripts/Makefile.lib                    |  42 +-
 29 files changed, 201 insertions(+), 2744 deletions(-)
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
 create mode 100644 dts/arch/arm64/Makefile
 create mode 120000 dts/arch/arm64/amlogic

-- 
2.34.1


