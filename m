Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B46C47DAF
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.8931.1704883033300389760
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:37:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Q6yWQtHr;
 spf=pass (domain: linaro.org, ip: 209.85.214.176, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d480c6342dso31648155ad.2
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883033; x=1705487833; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItGKytOu0pREVXvRcyIJk/dLNpJNwelGAbHY1//1MTE=;
        b=Q6yWQtHru/tWBP6dhdg7/ETarFqSqUU8uSZ5EcMqLZjgc4zr4uqlgioIdxftLVjpIH
         ewhpcUBj+5ld5ryhE8OpJRg42RWMhpyRlZ49ULpY4Sy/atXbgYO1QNt4tYe1giXn1mCA
         qHAaZyrNpD8aUrzHP2ArhsuDqZjhpJ5HnIb/MFeJnZgz1xCYcdPw+MJRm/yW+Eqjwfts
         qufiCTkp5kJzbS0a5cg6RdkUGjgJnU7kuRsuE6vtSMg1Gpdod5GVC1MX/7dwXECNQxTV
         pEOe5ncycLxdYibcCMcnxMohG7vInSZhNzlrSYqhxOYItN7RPeaALCI3hqXKNlqAXtbB
         2qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883033; x=1705487833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItGKytOu0pREVXvRcyIJk/dLNpJNwelGAbHY1//1MTE=;
        b=uonXEpLagijRY0W2QOwy4KphWEA/iQUCloRamrLfPDEwe1EHGF9Me88F0peP3iMw3J
         g+Bc47xS+/PgHUhLUc6a0s4IoIlD52J+xgAve5VP83Hztu89sy/TvELYb6jKZsNk9s/I
         8A3LLuq744DrlQxetBFgmWdP/iV5Kl/TUEyCOz+R0QgTp4E2LYKxqgX+QTFt6Z/M0UN1
         BE/Lgh1rgFIg9ZCsMfEGCqIt0Gv+lZmVKU2LLcAJkz8xO0SRY6M1gYtLbfA3D0uy7EUA
         piFzU8NtF8skfAsA1VKkjWNqUKPDR5kSLEfEcsuEcNT0JIkWFHCF/sI/ASSR8BR7+NJw
         QpdA==
X-Gm-Message-State: AOJu0YxAFR7KS4yy5Z72Qfp4IhWUizp1AudQASvFnG3oOFBBjLw3X++k
	2IizLSI+HWZKiRvKiw4iEDwbHa0zSc8T3w==
X-Google-Smtp-Source: AGHT+IGiiht3omSlijEJjhqkMPjVVCnZKElLnhYJZ3W2D3qW2Z06XBDG13ABgrtZMTo7fr2n6hE3PA==
X-Received: by 2002:a17:902:8646:b0:1d4:e208:9b0 with SMTP id y6-20020a170902864600b001d4e20809b0mr806137plt.44.1704883032690;
        Wed, 10 Jan 2024 02:37:12 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:37:12 -0800 (PST)
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
Subject: [PATCH v4 08/11] doc: devicetree: Updates for devicetree-rebasing subtree
Date: Wed, 10 Jan 2024 16:05:44 +0530
Message-Id: <20240110103547.719757-9-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2065

Encourage SoC/board maintainers to migrate to using devicetree-rebasing
subtree and maintain a regular sync with Linux kernel devicetree files
and bindings.

Along with that add documentation regarding how to run DT bindings
schema checks.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Since we now have v6.7-dts tag available now, so switch subtree to
  that from its beginning.
- Clarify subtree uprev schedule as a separate documentation section.
  Also, fixed documentation typos.

Changes in v3:
- Replace CONFIG_* with Kconfig options

Changes in v2:
- s/U-boot/U-Boot/

 doc/develop/devicetree/control.rst | 112 +++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 20 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 75d5e02aaec..c8789ef7209 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. sectionauthor:: Copyright 2011 The Chromium OS Authors
+.. Copyright 2023-2024 Linaro Ltd.
 
 Devicetree Control in U-Boot
 ============================
@@ -22,12 +23,11 @@ for three reasons:
   hierarchical format
 - It is fairly efficient to read incrementally
 
-The arch/<arch>/dts directories contains a Makefile for building the devicetree
-blob and embedding it in the U-Boot image. This is useful since it allows
-U-Boot to configure itself according to what it finds there. If you have
-a number of similar boards with different peripherals, you can describe
-the features of each board in the devicetree file, and have a single
-generic source base.
+The U-Boot Makefile infrastructure allows for building the devicetree blob
+and embedding it in the U-Boot image. This is useful since it allows U-Boot
+to configure itself according to what it finds there. If you have a number
+of similar boards with different peripherals, you can describe the features
+of each board in the devicetree file, and have a single generic source base.
 
 To enable this feature, select `OF_CONTROL` via Kconfig.
 
@@ -68,8 +68,14 @@ a binary file. U-Boot adds its own `fdtgrep` for creating subsets of the file.
 Where do I get a devicetree file for my board?
 ----------------------------------------------
 
-You may find that the Linux kernel has a suitable file. Look in the
-kernel source in arch/<arch>/boot/dts.
+Linux kernel Git repository has been the place where devicetree files along
+with devicetree bindings are stored and maintained. There is devicetee-rebasing
+(dtrepo_) which maintains a forked copy of devicetree files along with bindings
+at every Linux kernel major release or intermediate release candidates.
+
+U-Boot maintains a Git subtree for devicetee-rebasing repo as `dts/upstream/`
+sub-directory. You may find that the `dts/upstream/` sub-directory has a
+suitable devicetree file for your board. Look in `dts/upstream/src/<arch>/`.
 
 If not you might find other boards with suitable files that you can
 modify to your needs. Look in the board directories for files with a
@@ -78,17 +84,33 @@ modify to your needs. Look in the board directories for files with a
 Failing that, you could write one from scratch yourself!
 
 
+Resyncing with devicetree-rebasing
+----------------------------------
+
+U-Boot regularly sync `dts/upstream/` subtree whenever the next window opens
+with the next available kernel major release. `dts/update-dts-subtree.sh` script
+provides a wrapper around git subtree pull command, usage from the top level
+U-Boot source tree, run::
+
+    ./dts/update-dts-subtree.sh <devicetree-rebasing-release-tag>
+
+
 Configuration
 -------------
 
-Set up "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig. Then put
-your devicetree file into::
+Traditionally, U-Boot placed copies of devicetree source files from Linux
+kernel into `arch/<arch>/dts/<name>.dts` which can be selected via setting
+"<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
 
-   arch/<arch>/dts/<name>.dts
+However, it has become cumbersome over time for each SoC/board maintainer to
+keep devicetree files in sync with Linux kernel. Therefore, SoC/board
+maintainers are encouraged to migrate to use synced copies from
+`dts/upstream/src/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` for the
+SoC being used via Kconfig and set up "<vendor>/<name>" when prompted for
+`DEFAULT_DEVICE_TREE` by Kconfig.
 
-This should include your CPU or SOC's devicetree file, placed in
-`arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
-file for your board.
+This should include your CPU or SOC's devicetree file. On top of that any U-Boot
+specific tweaks (see: dttweaks_) can be made for your board.
 
 If `OF_EMBED` is selected by Kconfig, then it will be picked up and built into
 the U-Boot image (including u-boot.bin). This is suitable for debugging
@@ -155,8 +177,9 @@ ways:
 Adding tweaks for U-Boot
 ------------------------
 
-It is strongly recommended that devicetree files in U-Boot are an exact copy of
-those in Linux, so that it is easy to sync them up from time to time.
+With `dts/upstream` Git subtree, it is ensured that devicetree files in U-Boot
+are an exact copy of those in Linux kernel available under
+`dts/upstream/src/<arch>/<vendor>`.
 
 U-Boot is of course a very different project from Linux, e.g. it operates under
 much more restrictive memory and code-size constraints. Where Linux may use a
@@ -169,8 +192,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
 unwanted nodes, or even turned into C code to avoid access overhead.
 
 U-Boot automatically looks for and includes a file with updates to the standard
-devicetree for your board, searching for them in the same directory as the
-main file, in this order::
+devicetree for your board, searching for them in `arch/<arch>/dts/` in this
+order::
 
    <orig_filename>-u-boot.dtsi
    <CONFIG_SYS_SOC>-u-boot.dtsi
@@ -199,6 +222,54 @@ option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
 
+Devicetree bindings schema checks
+---------------------------------
+
+With devicetee-rebasing Git subtree, the devicetree bindings are also regularly
+synced with Linux kernel as `dts/upstream/Bindings/` sub-directory. This
+allows U-Boot to run devicetree bindings schema checks which will bring
+compliance to U-Boot core/drivers regarding usage of devicetree.
+
+Dependencies
+~~~~~~~~~~~~
+
+The DT schema project must be installed in order to validate the DT schema
+binding documents and validate DTS files using the DT schema. The DT schema
+project can be installed with pip::
+
+    pip3 install dtschema
+
+Note that 'dtschema' installation requires 'swig' and Python development files
+installed first. Please, refer to the GCC build documentation for installation
+instructions :doc:`../../build/gcc`.
+
+Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
+installed. Ensure they are in your PATH (~/.local/bin by default).
+
+Recommended is also to install yamllint (used by dtschema when present). On
+Debian/Ubuntu systems::
+
+    apt install yamllint
+
+Running checks
+~~~~~~~~~~~~~~
+
+In order to perform validation of DTB files, use the ``dtbs_check`` target::
+
+    make dtbs_check
+
+It is also possible to run checks with a subset of matching schema files by
+setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files or
+patterns (partial match of a fixed string). Each file or pattern should be
+separated by ':'.
+
+::
+
+    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
+    make dtbs_check DT_SCHEMA_FILES=/gpio/
+    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
+
+
 Relocation, SPL and TPL
 -----------------------
 
@@ -260,8 +331,9 @@ used it before Linux (e.g. snow). The two projects developed in parallel
 and there are still some differences in the bindings for certain boards.
 While there has been discussion of having a separate repository for devicetree
 files, in practice the Linux kernel Git repository has become the place where
-these are stored, with U-Boot taking copies and adding tweaks with u-boot.dtsi
-files.
+these are stored, with U-Boot taking copies via devicetree-rebasing repo
+(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
 
 .. _dtspec: https://www.devicetree.org/specifications/
 .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
+.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
-- 
2.34.1


