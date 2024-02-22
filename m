Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1445EC54E58
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:58 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.web10.9326.1708594660648383817
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Feb 2024 01:37:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ftpdSp+e;
 spf=pass (domain: linaro.org, ip: 209.85.161.44, mailfrom: sumit.garg@linaro.org)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-599f5e71d85so4694401eaf.3
        for <u-boot-amlogic@groups.io>; Thu, 22 Feb 2024 01:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594660; x=1709199460; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCMW6inCistmn4UV2mKDD7w4woL/VrgQDL/2zD+HqfQ=;
        b=ftpdSp+e3ZlCQ9M66EPLrEpdgFoaJa//RAl3l4zocCT/45dxZ0I9E0MbdQ8hjhEEoi
         AaIFhdWwjt0MNBP4ZmTc8HgWokTrHRgGSW3HvtXZcFaLJkpjWXnMvSZoWOCsGfj1Cxjs
         k6K72j/kW8bNebTLCXlY+33Pq+DUXk7QOJ8stxmol9kE204u759T5UMM6uW0Hhh4Z4ZO
         0osuP9NGLdJFQ1mHwnmXk8tUhOYoVDDo+feemkeMsqNOWBiB/HARi7xcKyGQPXx8R64Q
         5w0kW7VLwhKcUCAWW40jqz/lVNSOpPrfF7K0UzG6UawJepMt4ps7bCtb5EkcdSToHOCK
         0CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594660; x=1709199460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCMW6inCistmn4UV2mKDD7w4woL/VrgQDL/2zD+HqfQ=;
        b=Jqu5a8GnNynyBp4sLKVpIsX7u+CnYXpUbPmKKvS9TuWNAdza3jzPXGE/nOacxpqp2r
         8Ba7Q/tUPB5H5x0kgbZN1v4lEQ+2iRxvCjdswlZyO4LbZxcLJ7EFIOsMTgd9K7kQLaD/
         B7k/Ojr0fTRZ4DXk9+D5sk5mcqBFrRtawF7afSCd5ceGIj4fvAxCQx7CqWRCtvjHUQ4s
         du6+kgX+PpY3gPnW+4QlfaHfGgTpRoI4Oqsl6QowBgfEaGgjHl5npqtEgagf7ykCgeQP
         mx23Egp39Z8gY7YEZWdpKAIhjhVUZTHWT1jFil1eQtd/qpuHVsHVABT3x4pb3oUfaFkK
         tdwA==
X-Forwarded-Encrypted: i=1; AJvYcCVjlhdarMdVvkW3WY9ta0MKDKd+InxcvDo9hdj3ickbcZPtNylQV+08XB6TWRPB3scQyM+QJ8dh/9dwAT1lVZbipc8tw5/ZQI4=
X-Gm-Message-State: AOJu0YxEjNaMfuqnWaXyBJAJ0sqa67NIDrlD0YG/csq+QIHgmQQoC+qq
	Kh1TI7QNIDAjKn/YGvOX9Vd0sU6qh9G8D8vP9wM6Valpu4ISSWrUCCNO2isHJ44=
X-Google-Smtp-Source: AGHT+IG2176q2PLa/zYEZSjyiKYD6CqUZEkn7e9Pz1tq5mEawfSXfr5KDQu/5SbH1shQifk66pj7Mw==
X-Received: by 2002:a05:6358:1298:b0:17b:5820:61a with SMTP id e24-20020a056358129800b0017b5820061amr5791791rwi.4.1708594659769;
        Thu, 22 Feb 2024 01:37:39 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:37:39 -0800 (PST)
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
	ijc@hellion.org.uk,
	paul.barker.ct@bp.renesas.com,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 08/11] doc: devicetree: Updates for devicetree-rebasing subtree
Date: Thu, 22 Feb 2024 15:06:04 +0530
Message-Id: <20240222093607.3085545-9-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 26 Feb 2024 08:49:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2139

Encourage SoC/board maintainers to migrate to using devicetree-rebasing
subtree and maintain a regular sync with Linux kernel devicetree files
and bindings.

Along with that add documentation regarding how to run DT bindings
schema checks.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- Incorporate documentation review comments from Paul.

Changes in v5:
- Document how to cherry-pick fixes from devicetree-rebasing tree.

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

 doc/develop/devicetree/control.rst | 115 ++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 20 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 9a0cb90336df..c94d84192b71 100644
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
 
@@ -68,8 +68,16 @@ a binary file. U-Boot adds its own `fdtgrep` for creating subsets of the file.
 Where do I get a devicetree file for my board?
 ----------------------------------------------
 
-You may find that the Linux kernel has a suitable file. Look in the
-kernel source in arch/<arch>/boot/dts.
+The devicetree files and devicetree bindings are maintained as part of the Linux
+kernel git repository. Traditionally, U-Boot placed copies of devicetree source
+files from the Linux kernel into `arch/<arch>/dts/<name>.dts`. However, this
+required each board maintainer to manually keep their devicetree in sync with
+the Linux kernel and often led to divergence between these copies.
+
+U-Boot rather maintains a Git subtree as `dts/upstream/` sub-directory. It is
+regularly synced with the Linux kernel and hence no need for manual devicetree
+sync. You may find that the `dts/upstream/` already has a suitable devicetree
+file for your board. Look in `dts/upstream/src/<arch>/<vendor>`.
 
 If not you might find other boards with suitable files that you can
 modify to your needs. Look in the board directories for files with a
@@ -78,17 +86,39 @@ modify to your needs. Look in the board directories for files with a
 Failing that, you could write one from scratch yourself!
 
 
+Resyncing with devicetree-rebasing
+----------------------------------
+
+The devicetee-rebasing repository (dtrepo_) maintains a fork cum mirror copy of
+devicetree files along with the bindings synced at every Linux kernel major
+release or intermediate release candidates. The U-Boot maintainers regularly
+sync the `dts/upstream/` subtree from the devicetree-rebasing repo whenever
+the next branch opens (refer: :doc:`../release_cycle`) with the latest mainline
+Linux kernel release. To sync the `dts/upstream/` subtree, run::
+
+    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
+
+If required it is also possible to cherry-pick fixes from the
+devicetree-rebasing repository prior to next sync, usage::
+
+    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
+
+
 Configuration
 -------------
 
-Set up "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig. Then put
-your devicetree file into::
+SoC/board maintainers are encouraged to migrate to use synced copies from
+`dts/upstream/src/<arch>/<vendor>`. To do that add `imply OF_UPSTREAM` for the
+SoC being used via Kconfig and set `DEFAULT_DEVICE_TREE=<vendor>/<name>` when
+prompted by Kconfig.
 
-   arch/<arch>/dts/<name>.dts
+However, if `dts/upstream/` hasn't yet received devicetree source file for your
+newly added board support then you can add corresponding devicetree source file
+as `arch/<arch>/dts/<name>.dts`. To select that add `# CONFIG_OF_UPSTREAM is not
+set` and set `DEFAULT_DEVICE_TREE=<name>` when prompted by Kconfig.
 
-This should include your CPU or SOC's devicetree file, placed in
-`arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
-file for your board.
+This should include your CPU or SoC's devicetree file. On top of that any U-Boot
+specific tweaks (see: dttweaks_) can be made for your board.
 
 If `OF_EMBED` is selected by Kconfig, then it will be picked up and built into
 the U-Boot image (including u-boot.bin). This is suitable for debugging
@@ -155,8 +185,9 @@ ways:
 Adding tweaks for U-Boot
 ------------------------
 
-It is strongly recommended that devicetree files in U-Boot are an exact copy of
-those in Linux, so that it is easy to sync them up from time to time.
+With `dts/upstream` Git subtree, it is ensured that devicetree files in U-Boot
+are an exact copy of those in Linux kernel available under
+`dts/upstream/src/<arch>/<vendor>`.
 
 U-Boot is of course a very different project from Linux, e.g. it operates under
 much more restrictive memory and code-size constraints. Where Linux may use a
@@ -169,8 +200,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
 unwanted nodes, or even turned into C code to avoid access overhead.
 
 U-Boot automatically looks for and includes a file with updates to the standard
-devicetree for your board, searching for them in the same directory as the
-main file, in this order::
+devicetree for your board, searching for them in `arch/<arch>/dts/` in this
+order::
 
    <orig_filename>-u-boot.dtsi
    <CONFIG_SYS_SOC>-u-boot.dtsi
@@ -199,6 +230,48 @@ option to specify a list of .dtsi files that will also be included when
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
+binding documents and validate DTS files using the DT schema. For installation
+instructions, refer to the DT schema project page (dtschema_).
+
+Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
+installed. Ensure they are in your PATH (~/.local/bin by default).
+
+You should also install yamllint (used by dtschema when present). On Debian/
+Ubuntu systems::
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
 
@@ -260,8 +333,10 @@ used it before Linux (e.g. snow). The two projects developed in parallel
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
+.. _dtschema: https://github.com/devicetree-org/dt-schema/tree/main
-- 
2.34.1


