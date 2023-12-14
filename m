Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00387C3DA79
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:41:39 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.22504.1702561896691218696
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 05:51:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CA0e9DAH;
 spf=pass (domain: linaro.org, ip: 209.85.214.177, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d03bcf27e9so49031065ad.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561896; x=1703166696; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSRp992uEKRTdE3iAiCwlXXfx/j4PoIqabsWhwv1P/E=;
        b=CA0e9DAH5D4rLV49J8gLXh87+D4rLDsgN1/US89Zr3IgkFEs7nPvDcwiVtv/abREPP
         fK3P7ScjPneV1ZtrD9feAl8C4DlohD9Y6LfGKEFgcYS2EgQr7MTyAenw8eBbQJViJUOv
         xdYeXy2bSf+zuuOyApMsDyFtmR0DVTpX2XwyL8keTokohbL+0o5zrl6T+ocBrIWDlPnU
         dMst9VshApDOH0HD4WYNOvkP3/MQtOHxXmIF1pzd+Hnp0t2RYSjoSwpxoAsJaskqPkzz
         GCSlDBeDiWXnIorGnHviZB5yKeNlmMLxX+5H+Ga1nJvA9TGMtLeBIITlH3oroY2ned77
         6eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561896; x=1703166696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSRp992uEKRTdE3iAiCwlXXfx/j4PoIqabsWhwv1P/E=;
        b=CPRpVOmwTTZSxQfBYeYKEUn3T2Y4c7mdvAgJDFNH9VkGvHU8oWLBmUFCUzCwHh9gaG
         qHvbHXznUbdJCo3G4Qlhfy9czWusUtyZTG4+ni465Qvu8Iv7Qg69K7i85lrTKEEoNKZm
         WMeEBwACwhG3/IpmLvLUDhkxDntEs0NOovGBa/iiHMHBi1PLiORUdxnUKERYQngT1PAz
         LpXuGv4oTd6zKfNUp1UihiKhm5NyG8eDfGo1zmvaARS9JEb2Vdgf9umUDE7mGDdWQsCb
         SOcCbjrVLQlALR9lBguIYu5tTZ/NeI/ur8PEFgp3INefg75v5b6tzy9J4fMZZkZdrder
         K6Cg==
X-Gm-Message-State: AOJu0YxjyMrrPrWsK1pZy4nUtlt3rsPX0m7IqXXJmOmVPFTrxDWHSOgo
	A8qfQ/3MRRIThUe+yJGUbEN5ow==
X-Google-Smtp-Source: AGHT+IGwTASEDOulN+vZTSaZHaRaHYzhJKhxkNWJJmpLKlIa640HpeMMy1G8uu3n8XdQc9QWedKHzg==
X-Received: by 2002:a17:902:8d91:b0:1d0:94ed:f843 with SMTP id v17-20020a1709028d9100b001d094edf843mr4589945plo.17.1702561895902;
        Thu, 14 Dec 2023 05:51:35 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:51:35 -0800 (PST)
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
Date: Thu, 14 Dec 2023 19:20:55 +0530
Message-Id: <20231214135103.1606605-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:41:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1916

Prerquisite
-----------

This patch series requires devicetree-rebasing git repo to be added as a
subtree to the main U-boot repo via:

$ git subtree add --prefix devicetree-rebasing \
      git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
      v6.6-dts --squash

Background
----------

This effort started while I was reviewing patch series corresponding to
Qcom platforms [1] which was about to import modified devicetree source
files from Linux kernel. I suppose keeping devicetree files sync with
Linux kernel without any DT bindings schema validation has been a pain
for U-boot SoC/platform maintainers. There has been past discussions
about a single DT repo but that hasn't come up and Linux kernel remained
the place where DT source files as well as bindings are placed and
maintained.

However, Linux kernel DT maintainers proposed [2] for U-boot to rather
use devicetree-rebasing repo [3] which is a forked copy from Linux
kernel for DT source files as well as bindings. It is tagged at every
Linux kernel major release or intermideate release candidates. So here I
have tried to reuse that to bring DT bingings compliance as well as a
standard way to maintain a regular sync of DT source files with Linux
kernel.

In order to maintain devicetree files sync, U-boot will maintains a Git
subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
It will be regularly updated with every new kernel major release via
subtree pull as follows::

$ git subtree pull --prefix devicetree-rebasing \
      git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
      <release-tag> --squash

The RFC/prototype for this series has been discussed with Linux DT
maintainers as well as U-boot maintainers here [4]. Now we would like to
reach out to wider U-boot community to seek feedback.

[1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
[2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
[4] https://github.com/u-boot/u-boot/pull/451

Changes
-------

Traditionally, U-boot placed copies of devicetree source files from Linux
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
sub-directory. This allows U-boot to run devicetree bindings schema checks
which will bring compliance to U-boot core/drivers regarding usage of
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
  Azure CI: Exclude devicetree-rebasing subtree for CONFIG checks
  Makefile: Add support for DT bindings schema checks
  scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
  dts: Add alternative location for upstream DTB builds
  doc: devicetree: Updates for devicetree-rebasing subtree
  MAINTAINERS: Add myself as devicetree-rebasing maintainer
  dts: meson-gxbb: Switch to using upstream DT
  dts: meson-gxbb: Drop redundant devicetree files

 .azure-pipelines.yml                    |   3 +-
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
 configs/nanopi-k2_defconfig             |   3 +-
 configs/odroid-c2_defconfig             |   3 +-
 configs/p200_defconfig                  |   3 +-
 configs/p201_defconfig                  |   3 +-
 configs/videostrong-kii-pro_defconfig   |   3 +-
 configs/wetek-hub_defconfig             |   3 +-
 configs/wetek-play2_defconfig           |   3 +-
 doc/develop/devicetree/control.rst      | 108 ++-
 dts/Kconfig                             |  11 +
 dts/Makefile                            |  17 +-
 dts/arch/arm64/Makefile                 |  23 +
 dts/arch/arm64/amlogic                  |   1 +
 scripts/Makefile.lib                    |  42 +-
 27 files changed, 204 insertions(+), 2730 deletions(-)
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


