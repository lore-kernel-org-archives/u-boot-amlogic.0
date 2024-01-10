Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA42AC47DBA
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.8914.1704883009326392550
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:36:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=kQ93SCXa;
 spf=pass (domain: linaro.org, ip: 209.85.214.177, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso32132255ad.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883009; x=1705487809; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsiA+O12iJkpNew60z2Ss9cRy01PCvnIz5NjHTdND8w=;
        b=kQ93SCXawSSnUJA2O6YKwGeIP/F3Jq9m4V7ZSaQG8ZIV0+eEb/Lf0+jR1UiOWjFJwA
         YkJmzfo7zwxosa3hTskdnrs7rhx2vC4sE9UNuQ2OfCv9ejPt9etShvTK/pjN2n64lgwf
         dLHrqAC1GvKiGfEt2PAJatpWi3gcUTWMeporI8D36VrYndr1+gvNfgTixetZTt3mplqb
         MIBUzXnAAavamuMY8Dd+5Li9ofekEWONxESi9+lzGDkF/eB9tJ1XL1ePR1+GRRYMjmVw
         AN18DVWuN5Il3gFsP0ykQ/IEYZBWYS4MbgKANqv6IXvKH/b8rTwFLR9EzU06QJhyETsH
         2XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883009; x=1705487809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsiA+O12iJkpNew60z2Ss9cRy01PCvnIz5NjHTdND8w=;
        b=sLjEG4co0jnAWqWQ8s+2IpG96G6/Q6DQmLOe5WKKb08Y2C/kkUseVvNUlngqzyyMAA
         h0XA+HVLZjWU33LLOGiKZNiOXmvbfRnoKZOFrkE/Sf8TaOUm5JR4iaVt9TMPy/wN8Pbe
         1hT92sRyuFh6ayeW47Vif/+LqiR65DPCQbbtYlMAvm80iDPGjB0MqKdfRXtZhKk67nCy
         ZBHDfNQtc1MfLoO2ERQ2OuJ00ovVSbaCOzjOK787EJlYVVw+p3nMQv8lhBJKX+h5xSoh
         31ZGZ6j1tX7hlMoAf623r7S5vFQM6Ivv0W85RKph70bUdx0rA3pQgdtLFW6siX7iRh21
         De7Q==
X-Gm-Message-State: AOJu0YytCLiLUbqVc1qR6/7TEP0l1M5x3qz2oNGL7lr7ylqRlhjw5wFE
	uOOG129lky7O2LwyeoKdJLVyKhwley+OTQ==
X-Google-Smtp-Source: AGHT+IFb+flFOMi8jhEI84jn3b6jKNoBFO+35tkGAWNhdslOrWzI48A5tpPQY3KKPv+JkviI4c1cLg==
X-Received: by 2002:a17:902:ca11:b0:1d5:6b6c:1ace with SMTP id w17-20020a170902ca1100b001d56b6c1acemr1096120pld.18.1704883008643;
        Wed, 10 Jan 2024 02:36:48 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:36:48 -0800 (PST)
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
Subject: [PATCH v4 05/11] dts: Add alternative location for upstream DTB builds
Date: Wed, 10 Jan 2024 16:05:41 +0530
Message-Id: <20240110103547.719757-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2062

Allow platform owners to mirror devicetree files from devitree-rebasing
directory into dts/upstream/src/$(ARCH) (special case for arm64). Then
build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
directory. Also add a new Makefile for arm64.

This will help easy migration for platforms which currently are compliant
with upstream Linux kernel devicetree files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Added a note to OF_UPSTREAM Kconfig option.

Changes in v3:
- Minor commit message update

Changes in v2:
- s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/

 dts/Kconfig                     | 16 ++++++++++++++++
 dts/Makefile                    | 17 ++++++++++++++---
 dts/upstream/src/arm64/Makefile | 14 ++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 dts/upstream/src/arm64/Makefile

diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff893..09789d3e18b 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -85,6 +85,22 @@ config OF_LIVE
 	  enables a live tree which is available after relocation,
 	  and can be adjusted as needed.
 
+config OF_UPSTREAM
+	bool "Enable use of devicetree imported from Linux kernel release"
+	help
+	  Traditionally, U-Boot platforms used to have their custom devicetree
+	  files or copy devicetree files from Linux kernel which are hard to
+	  maintain and can usually get out-of-sync from Linux kernel. This
+	  option enables platforms to migrate to devicetree-rebasing repo where
+	  a regular sync will be maintained every major Linux kernel release
+	  cycle. However, platforms can still have some custom u-boot specific
+	  bits maintained as part of *-u-boot.dtsi files.
+
+	  Note: This option should be set in Kconfig, for the SoC as a whole.
+	  However, newer boards whose devicetree source files haven't landed in
+	  the dts/upstream subtree, they can override this option to have the
+	  DT build from existing U-Boot tree location instead.
+
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
diff --git a/dts/Makefile b/dts/Makefile
index 3437e54033d..d6c2c9daf31 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
 DEVICE_TREE := unset
 endif
 
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/upstream/src/arm64
+else
+dt_dir := dts/upstream/src/$(ARCH)
+endif
+else
+dt_dir := arch/$(ARCH)/dts
+endif
+
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
 else
-DTB := arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
+DTB := $(dt_dir)/$(DEVICE_TREE).dtb
 endif
 
 $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
@@ -41,7 +51,7 @@ $(DTB): arch-dtbs
 
 PHONY += arch-dtbs
 arch-dtbs:
-	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbs
+	$(Q)$(MAKE) $(build)=$(dt_dir) dtbs
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
@@ -65,4 +75,5 @@ clean-files := dt.dtb.S
 # Let clean descend into dts directories
 subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/dts	\
 	   ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch/riscv/dts	\
-	   ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts
+	   ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts	\
+	   ./upstream/src/arm64 ./upstream/src/$(ARCH)
diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
new file mode 100644
index 00000000000..9a8f6aa3584
--- /dev/null
+++ b/dts/upstream/src/arm64/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -a 0x8
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := */*.dtb */*.dtbo
-- 
2.34.1


