Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA430C48BC3
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.22159.1706879202861739468
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Feb 2024 05:06:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fd8KoJAw;
 spf=pass (domain: linaro.org, ip: 209.85.214.175, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d746ce7d13so17053125ad.0
        for <u-boot-amlogic@groups.io>; Fri, 02 Feb 2024 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706879202; x=1707484002; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qDjnivRKsvwROoQdnvXoqkuqFStziPIQgGfS9OTLn8=;
        b=fd8KoJAwYRdcWFTlBqyed5r2C2RwZiRWdvRZCZim7mv6A+/nb1VO7FwAoh7tHHh6A+
         ZD9T3Edz2BR+/Ifr4vsoUsQ0Hk/KC6oUZSH6yxe2550WlwwDtiWAK4ucCUix51/SzOe0
         DwVyGYp5054pNhSTE44opakcduPfX4O2LqPamG915vQniKuHwU+nlgDyMGAypLtF5ED+
         /GizLtm7LvvRpSkkjLOOkaGFvugDTqt1ZStpw4GwX98BFE4GRGvvyoreaXy0V3Y/wvU0
         zYRjDftMFFCMQMKlmTyl06Wd9UWOgsjHAutEfYq7Lgwqws7dqxeDCftZJfwougYb3Frp
         jytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879202; x=1707484002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qDjnivRKsvwROoQdnvXoqkuqFStziPIQgGfS9OTLn8=;
        b=HyoyB22LqAJWJOTCA4o0+QlXyDhJSY1hbyAH4x5bgw89Cc2X0KzhRQeeMTUnQ/wHXu
         +AIsnZ9i4Le98w/628A7bAxusznPr3A7krscGabfP+9Ft0vmBu/SiSshFv/cpe3Fesay
         1jtbuO+jOMa1pHp3ICERYddO07fKsfTfSDeX8iu8dTwhaGT2B8cwhMk2cf2+dFRKlWk0
         Q7syWgccRXKcQFUStnXCOamomL0OlzMYefgSAsyxi6dJEiLrD1eXH+G4rcQdtn9n34dY
         0sF4TBtnegyIhwgXC1rXhoR5mEkHn4XtubBfpCcSv8Dil6PbGGCVcuzTQdwvCb6YLGpj
         xAxw==
X-Gm-Message-State: AOJu0YyZAyv3NxvDuAQg2K5HfG3mqjFkUSIr60QRnix3uAYzxuzi83i3
	6AQUvkEVHjf5QypJwFBZneqW+efFVP5p9deoombiPJJqFXY/qJcZI4mtM+aMZ+Q=
X-Google-Smtp-Source: AGHT+IE38wglxcJVRzbPZcTqxmMr4X4cfjEm89WDP3DgsTATw9dmYm5vOoZ4vas5LhG8fIrwvHE7xw==
X-Received: by 2002:a17:902:6b8a:b0:1d8:e4b8:95dc with SMTP id p10-20020a1709026b8a00b001d8e4b895dcmr3939566plk.41.1706879202358;
        Fri, 02 Feb 2024 05:06:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhnbO/rYc72GUn/ukejTU+MFVRZQu1uAcNBgMxZa0ew1k/IA03LYq7PAJiWgFC6ZfjehveubYmL2vYN9EEB9hXb279cIPnaY0Uv3w9TbNUC1Gd15qhuJkGwBgoXqTBwNtMdhhYLKWRSCikK7v8IGS+Jxadr2At2NBQFcigsjRgpzdw+x5B8ZTI76byXZ2PsdxFywkzUKW3G24nuo4ej6UkUSVjqimPNJWn5ubRiiUlGQJ+tTXSTuTmkgaPKSYBJGJ5F6oslMi7HTVaiPGsKPBpicXYDEufcIJwycMay72QVzAqmXWZ2NG/5+OI5qqccsbsyBuAxTUHVKPTvvtCw3k1fQQz/VPVgLPjxhjuP04sHYrtD+dZCZ35GKXpzoGx+M8Rays+zuAuLrN27ptQ9CwRIBs81RNO2orFSvBAdB/MqqQAN8R/wszJAZjFUCno5dJ72QMKaf0uJXFjrkPn1dbBN1pKbAcj41RnWZH6GqKvIkVGwg57R2wdgiKnGxTdUPZ+igiFZQqNfJM+dBVaZsDDOWp70Emw/1Z984MKUjhI6MIvGiz1DnZ0bIQtSzk8nBAVfnG/EbS3r4gicq/7JQS0IM9hry7TS7d2fN/m44VOPdzMIcCMczI/4wzlMpXbf8LHqtpPSbM17+4ZRa9vGGR3A090o5OK9qFwEWtV/k2Z3Omehqy3Lkf3S+/1ku7KLJAd2y1rV21uxZm8htZsdpabzX5HXr9FKaRovCMCI4P4PjFZZ9oEBqY+RX0WvGA3GOyETQiMncnTyU7i0eQ6imjqvOCDCYdqUoXSy7DLyPDrTjbaMzxUudOM9WfAofSoK99gW2i/CZJ6e0yXpA7yqjcpB3Qvns0j7FV0H3mgfwdstIm3w8L5S2chD5Z/wqZwhbg6JVvAM5J9QkACvGbZtcVqG/rXw85SuUh2
Received: from sumit-X1.. ([223.178.213.44])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:06:42 -0800 (PST)
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
Subject: [PATCH v5 05/11] dts: Add alternative location for upstream DTB builds
Date: Fri,  2 Feb 2024 18:35:28 +0530
Message-Id: <20240202130534.1051438-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2104

Allow platform owners to mirror devicetree files from devitree-rebasing
directory into dts/upstream/src/$(ARCH) (special case for arm64). Then
build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
directory. Also add a new Makefile for arm64.

This will help easy migration for platforms which currently are compliant
with upstream Linux kernel devicetree files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v5:
- None

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
index 00c0aeff893b..09789d3e18b3 100644
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
index 3437e54033db..d6c2c9daf31d 100644
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
index 000000000000..9a8f6aa35846
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


