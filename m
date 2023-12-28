Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A9C47DCF
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.121677.1703764739913206512
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 03:58:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=TRxw0cr6;
 spf=pass (domain: linaro.org, ip: 209.85.216.41, mailfrom: sumit.garg@linaro.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28c179bf45cso3580007a91.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 03:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703764739; x=1704369539; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDY4LuoQYDY5N67u0lAxETqq9+/+EJV+L03/SvHFfXg=;
        b=TRxw0cr6u+wOlPCeHa++UP8+QBczBGd0kYRfcW8RVLmWqVoxWAGNVmM52Npd1BalRZ
         FiIXUDQi9kQyZZIceiZtElzL2v1HA4gp1nB3LDLDEUD1mkidM35Fu3u9oRV92PFzn+by
         7nDfRWWtWmooF4AoGo3QdWCNEg/SgikjttixftQRDBNw/8gBx62bP5GYmQ7zxAM30tet
         PDU30mlPxoFg26ckbJM21VQGL+29jpr6DsLzcvsxiGcKfZNyp1cAH6Wq13QUiMyza5BP
         N/z5ksVWNv5N0D8OC+Ox+qd7z8u079+5jqsl7q9WWwX4QS1rJjS83g4LXfL5XJfCuMI5
         LfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764739; x=1704369539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDY4LuoQYDY5N67u0lAxETqq9+/+EJV+L03/SvHFfXg=;
        b=nuXC4AHtM7kOQMAagjwI8PxanoFDnLJ9l4FSd6AFAicQ8Wr/j/kb2sE+2mRTZBoRse
         mYnk4KWzUGtRSLqqxDKahbSaRgXYED0m7Zkq6F5Q3ylXWvdl0aP5pY/DPzqjjKsl7O3f
         9HLH0vGuEnWgNZ/irovU6NrwDtmfnvbCK85nETdk1+uUvZ5fuO+9qFiq0Ag/ef1SiJzi
         +sDcuJpXWYR6VghwXwUxReuh0mmrhHlZLQdb8kbvEYzyD1Dvp6i3noZTab4lalMhEqpz
         qDaZTri+vcdLGu8PLRG77IB0iLpE0u5bDuxViEVJRik4Nx0e8a7AD7X6SncT6Usa2oRc
         Ccbw==
X-Gm-Message-State: AOJu0YwO/1F129nmAIJ77JMwfsuLayZzmz87O/6V8xMFWsVAe5PXibXZ
	maJanVVUeALLGQNhZWCtjz+tbk2hbXbW0A==
X-Google-Smtp-Source: AGHT+IEsbjJaFAIUXLFFmQoH5Dxurq/NSEyK2fddLKJ4sXkhSOVPvpPsHKF+r3IbisCnm2Pmqy1q+w==
X-Received: by 2002:a17:902:e750:b0:1d4:59ab:36b0 with SMTP id p16-20020a170902e75000b001d459ab36b0mr5095698plf.75.1703764739371;
        Thu, 28 Dec 2023 03:58:59 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:58:59 -0800 (PST)
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
Subject: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
Date: Thu, 28 Dec 2023 17:28:00 +0530
Message-Id: <20231228115804.3626579-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1984

Allow platform owners to mirror devicetree files from devitree-rebasing
directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
directory. Also add a new Makefile for arm64.

This will help easy migration for platforms which currently are compliant
with upstream Linux kernel devicetree files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- Minor commit message update

Changes in v2:
--------------
- s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/

 dts/Kconfig             | 11 +++++++++++
 dts/Makefile            | 17 ++++++++++++++---
 dts/arch/arm64/Makefile | 14 ++++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 dts/arch/arm64/Makefile

diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff893..e58c1c6f2ab 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -85,6 +85,17 @@ config OF_LIVE
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
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
diff --git a/dts/Makefile b/dts/Makefile
index 3437e54033d..68daaf45ec7 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
 DEVICE_TREE := unset
 endif
 
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/arch/arm64
+else
+dt_dir := dts/arch/$(ARCH)
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
+	   ./arch/arm64 ./arch/$(ARCH)
diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
new file mode 100644
index 00000000000..16e9fea622d
--- /dev/null
+++ b/dts/arch/arm64/Makefile
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
+clean-files := */*.dtb */*.dtbo */*_HS
-- 
2.34.1


