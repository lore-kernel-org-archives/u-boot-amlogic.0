Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85ECC10F13
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:41:38 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.22519.1702561928120193125
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 05:52:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=S7Ot40Zm;
 spf=pass (domain: linaro.org, ip: 209.85.214.179, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d36a6cec69so1529895ad.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 05:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561927; x=1703166727; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TnzdH67t338vIUJxhhWpafn7v8Et2UIYp9pfQ6QVcw=;
        b=S7Ot40ZmbVBddnGL97NKNEwGpNHQniN3cMXEg+T3Cok5yFVWEEREVsw33GeHK/BCmu
         ii/umt0INWZHgj0Sh2Khwz6R/R/h4c8B/JDZ4H51yXGn+dvibTxgYk+R+4Dw2u53Hj7C
         47g/18FclKCta7Gf68YuGF5L+/EaJ05TUyav/rQtk20ZSlaCRD78/kuSFvlfOz38JLfD
         0TpWETesq04DgcCdv2M4N0nM5PQgh67piSXm5rPvXZ5aNdvQxQTDvSl/+E4bSbZtrneZ
         nl1aF/K/XMQ4NccyxvSl47SY6ClEOLc1OCibMMK3X6u9bqqkQM7sVm5PMxlHUHMUw9h2
         8jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561927; x=1703166727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TnzdH67t338vIUJxhhWpafn7v8Et2UIYp9pfQ6QVcw=;
        b=uBSG7D8y6BJQgM5NNCj1qCjUeVwRp3CpDWNMqPEj1BMxaTnhO5x6tfQOfvqUA5QRsM
         KauWQNJq8MD+dhK+p4m86UWk/a2Lb3vNP4+D91UbNPSWQzHRKHHkv1R5mEFo0mnEDS06
         80Psl4MkTdEn/nEcXd5RyduqXMh9vBJnOEcCZwPHCpgcP8FzquU2ToXzxUKBfERoun9J
         PfcGFT0JRF4yHkenkPFOK/Nr/mIkmPCneuyvi8XemxKuF7eS8fOsO7PjXbnoJ6GrSBqt
         fZKH6DumQglEdGljKJFtIJPkyI29b4AKhzLIcrwuyFOPwCKM04dgIU8Uvarc2VSIluii
         889Q==
X-Gm-Message-State: AOJu0Ywjo4PJSfVZs9rV/J2oZvu3jP8QHv9yJWz6WmK0EqAXzZrDXTyL
	TJ7qg4MSGpPoTRIb6tgYp8wWEIfYL6EulgpwgXFvJQ==
X-Google-Smtp-Source: AGHT+IEp1+U5D/9ja566fAuIiB5r0f1xEv86WfXVgdQsd5FTHsuFlzaiJqitblDdHWHkcgOdkC9f9w==
X-Received: by 2002:a17:902:bb16:b0:1d3:51d3:f8c7 with SMTP id im22-20020a170902bb1600b001d351d3f8c7mr1148141plb.3.1702561927575;
        Thu, 14 Dec 2023 05:52:07 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:52:07 -0800 (PST)
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
Subject: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
Date: Thu, 14 Dec 2023 19:20:59 +0530
Message-Id: <20231214135103.1606605-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:41:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1920

Allow platform owners to mirror devicetree files from devitree-rebasing
directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
directory.

This will help easy migration for platforms which currently are compliant
with upstream Linux kernel devicetree files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 dts/Kconfig             | 11 +++++++++++
 dts/Makefile            | 17 ++++++++++++++---
 dts/arch/arm64/Makefile | 14 ++++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 dts/arch/arm64/Makefile

diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff893..96396f12b67 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -85,6 +85,17 @@ config OF_LIVE
 	  enables a live tree which is available after relocation,
 	  and can be adjusted as needed.
 
+config OF_UPSTREAM
+	bool "Enable use of devicetree imported from Linux kernel release"
+	help
+	  Traditionally, U-boot platforms used to have their custom devicetree
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
index 3437e54033d..8098bf8191a 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
 DEVICE_TREE := unset
 endif
 
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+DEVICE_TREE_LOC := dts/arch/arm64
+else
+DEVICE_TREE_LOC := dts/arch/$(ARCH)
+endif
+else
+DEVICE_TREE_LOC := arch/$(ARCH)/dts
+endif
+
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
 else
-DTB := arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
+DTB := $(DEVICE_TREE_LOC)/$(DEVICE_TREE).dtb
 endif
 
 $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
@@ -41,7 +51,7 @@ $(DTB): arch-dtbs
 
 PHONY += arch-dtbs
 arch-dtbs:
-	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbs
+	$(Q)$(MAKE) $(build)=$(DEVICE_TREE_LOC) dtbs
 
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


