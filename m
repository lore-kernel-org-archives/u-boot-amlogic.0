Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F3AC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.22128.1706879158550495319
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Feb 2024 05:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FP6s4AsW;
 spf=pass (domain: linaro.org, ip: 209.85.214.172, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d780a392fdso17301575ad.3
        for <u-boot-amlogic@groups.io>; Fri, 02 Feb 2024 05:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706879158; x=1707483958; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjyWqoSy/p+CQEN7+LMGYLXxq5Zw38O9mz3NzzsVpa4=;
        b=FP6s4AsWKO9LZzwsOSC1H+mdfrziH7nqFJJu8HcqHj77wO2jgOg0QfHeywCnUIad5s
         04zzPvI8doaN3Aol/thNrb7EqmuuU4vlNfynLe7Qm83e1EefQy1yQvv/U7hZNtWNKz5/
         VK9DoEOrOSodmQ/HyxjRag/lyNRVyr9VAjKKb6NABfwH242uPtdEF6D4H2AtO4ZQHqKl
         yk4WlIO/1y2kLtX6WNz/hYUit8ofRbR2nQWH/pGLwk4GJxmAibxqP1/YywZmJx9iAxqS
         8NC2MrPV/yMFRaifGtSkqZpxHrpprVviezNNvzfhRHcxRB3HCtbs0xmQSqxGYpjgXPru
         eWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879158; x=1707483958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjyWqoSy/p+CQEN7+LMGYLXxq5Zw38O9mz3NzzsVpa4=;
        b=J2R2kO4xHR+gN0kKCDbKodi+41F8uN/rQ3T9VPC5Y7MXoeGV/+uAnzTR6DgRi78oqi
         xi5ZWf7YP0X4eHUnabce9O7JJHR1mfV6KXH53yywjxAu4iHDH3SVtNZUSSLjnHrm2Fm2
         0zZcaP9Wx5xEoxQLp+7+C3NJ6KtBxc6Gg9mBokIJZaIj8bH9XxCmqjSbvFly+m7TzzZS
         nrKu9M0ofv0cTK99dwilib3R9FQZ2viDSMXxpbrOe2Ra3hKEXc5U6qKQvz1IjVizS/Lw
         ZuRqbuH823XGB/5VGYoy6hjM9NacTOAu/OzZY2BFZ2jnN4JVPYdOy7SZqIP/mhg+SCk5
         W0zg==
X-Gm-Message-State: AOJu0YwUsery9hliEbz7h4pFziTJu8KaFWbUoLfJVvUv5ZrXPDTQLgXo
	ZS5Ol9GFY78YDeq8gke/KYcQsq7AA0R+rU6wkYEVgxQS3bfQBwljCnI0x2NNGQ8=
X-Google-Smtp-Source: AGHT+IFNyk5W27zskgy9X7P2LM1GiTcTVjzItA1UWQ4rBfZvkz+fjUUcqzGxqVkDkoBYI8GAtPqmOA==
X-Received: by 2002:a17:902:fc8f:b0:1d9:742b:fedd with SMTP id mf15-20020a170902fc8f00b001d9742bfeddmr1693909plb.34.1706879157848;
        Fri, 02 Feb 2024 05:05:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVNK2YPlXlLDkgxCyqFjlRr/Qty6onwkMCs4y3D3h4955nU7Pgsg5DmoObBLMlHxHXeSTCtFuolQFS5JVLKk7cyciEZPGPr2fwLuje02eFfjhb7Dd6zBr2vKsy0g5Ix/GwiurLAwG/tudVGb8ys7ve0aURj6MI1jBgsmgMBdS/0LNukiy1mAqPTyhOJ7R942BwMboI4n7ojNIEGP/hMXcS83gbUSTU3lemDvNtNo0AHuvP15HPCKfctskDorDiy7jl3uW7Hi7XJbypqv4wGqbguj8wyGAqZHumXTysNo5x81S3YnB3xnYbyGDMNMoekJK4AYefB34yvhC9D5uygKB5J0mNgyozZGUtnnSzIgQkKqdBQin2s+aSEl5pF5fUbQRqg3S4FITP6f/eLGszg4ptbC8JzSCQIWHeFP8X4uLyGiJb9+5jd6jo/Cy9voqfZV4ozdCv/Lpc6gdhmcyqCeq65sAuAI0iTZUcKShAo4vjGK6DZd6GQk1FZ1U5wnXQl3RWW0S2HFZJ5fDx4Yb0t4GsVRSan8noF9BhFvM2g1c4I8+hpN82fq//YqYFSQybxoSm3R8/9ggRLM9OWneWmfR2JnMjEZTFyrqKlM6QB1901/KD8Mc1l7r1rNOJYZy/F2SuYwTLlB876Zgg0zFMDvdzWL0AVlzIYVDM8BjY3WDu3K9bmiXI9aQpVnGwvk5/lHcb+XjVjlvxjd5w3udSUsZkvoHSveUwVQdbDPRYviloFVQLyirhSSSrdMeUBd36hjfhxZ/8GpunNTmlIr9wRbUbn9vkylpK30yexosns8xC28uB1RQolBvnMBe40LiTOCPmL8sD4AP8/SqSlhJV50+0JiHtJk245lcW3fE/T1mjTpUJmBiMk9Fvhx3NE/kxOtQZnKdMdP8r2iXiWjNJXZwkWpbNvLv2m0g5+
Received: from sumit-X1.. ([223.178.213.44])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:05:57 -0800 (PST)
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
	festevam@gmail.com,
	nm@ti.com,
	andre.przywara@arm.com,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 00/11] An effort to bring DT bindings compliance within U-Boot
Date: Fri,  2 Feb 2024 18:35:23 +0530
Message-Id: <20240202130534.1051438-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2099

Changes in v5:
--------------
- Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
- Created v5_dt branch for testing purposes:
  https://github.com/b49020/u-boot/tree/v5_dt
- Patch #6: Added support to cherry-pick fixes in subtree update script.
  Also, used https:// instead of git://.
- Patch #7: Fixed inappropriate documentation update.
- Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
  tree.

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
      https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
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

$ ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>

If required it is also possible to cherry-pick fixes from
devicetree-rebasing tree prior to next sync, usage:

$ ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>

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
 doc/develop/devicetree/control.rst      | 161 +++--
 dts/Kconfig                             |  16 +
 dts/Makefile                            |  17 +-
 dts/update-dts-subtree.sh               |  45 ++
 dts/upstream/Bindings/Makefile          |   6 +-
 dts/upstream/src/arm64/Makefile         |  14 +
 scripts/Makefile.lib                    |  49 +-
 30 files changed, 281 insertions(+), 2779 deletions(-)
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


