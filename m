Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA541C46CA2
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:41:38 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.22556.1702561920344890127
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 05:52:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=vavquIr6;
 spf=pass (domain: linaro.org, ip: 209.85.210.174, mailfrom: sumit.garg@linaro.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so5161408b3a.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 05:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561920; x=1703166720; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJhXFrv8uHuP5uiECV7lR9faylLwkNArQN5KLLNNmik=;
        b=vavquIr6xDWNFHTTqg53QkFQwB5BJr1+wndT7th9oeVzj2jqxwhgG3KNRDNLUgWHMv
         afSV/yLPlvt3i3bYxU0HJ+5qV8A4JmP31/Y9EHXpWNfq5Nmdr/wATiCe3oxRGUqRPAao
         H3kn9STd89n5O5BDzyG5/djexczCljFyd/SH1NWwVl6WqoZaffpMfGJle9qpzD3gAnUk
         r2PNnBoGqMIWIMBiR7kGR18gpY86zH/KMlDxE2krvLKk8EGpLogNG70GCvzI4aLZtCNi
         +05PZ3YWL5v0UUZMod2PKH+NG7fPeL+PSeAjGW09wbkAf7CxEtPhOVSL8Qcb3xVR/trS
         cIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561920; x=1703166720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJhXFrv8uHuP5uiECV7lR9faylLwkNArQN5KLLNNmik=;
        b=Ps857vLM8doVQtOXOaR8UNfIrCzi6CF+FOn1Lb8whYY5hKsxSzxRi3aJhgZhQ1OVNn
         cNUPV4Hm04bfDuc/vjPF1et/U+2F5H8HgesPVt9G2CexL6BulPfNHZA0qxL59s5ZrDxE
         VgIK6f8ZceQKswU/pX8187j/mVBTK2YGiYsqc0RZ/UOyJKsnEcaxB5bD7OoArJO0GgYg
         euy/o0eX3K7Nq8pWZ1rwbLan7QSBV50vwOiSdtPeeEdV6g50f+8GyRAMsPtrlYvxEio6
         83oDuDkyolfFSkGben95ppI+UzwhhZuqJ1h9yljTdkQjsOFNI+MdYMcPBJEfSiSYiteX
         f1Qg==
X-Gm-Message-State: AOJu0YwatEKX15FQdctAFPhAIoy0ci/z70/JFClKnZqoE1AhVUqR3WYf
	s6HqRlyvUJd6J7jRK+fvClJKcA==
X-Google-Smtp-Source: AGHT+IEVp+TymXBW+Ef+yFfKdEgCKG+pW8pT9fVUog8dTTjR5053ODURKLiiiN8f0VPqRlDyCVF6eQ==
X-Received: by 2002:a05:6a20:daa0:b0:18b:6f9:dc22 with SMTP id iy32-20020a056a20daa000b0018b06f9dc22mr5676623pzb.41.1702561919810;
        Thu, 14 Dec 2023 05:51:59 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:51:59 -0800 (PST)
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
Subject: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
Date: Thu, 14 Dec 2023 19:20:58 +0530
Message-Id: <20231214135103.1606605-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:41:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1919

Allow u-boot to build DTB from a different directory tree such that
*-u-boot.dtsi files can be included from a common location. Currently
that location is arch/$(ARCH)/dts/, so statically define that common
location.

This is needed for platform owners to start building DTB files from
devicetree-rebasing directory but still being able to include
*-u-boot.dtsi files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 scripts/Makefile.lib | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 27b9437027c..4a002b0e0ca 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -159,18 +159,20 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
 ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
 # Try these files in order to find the U-Boot-specific .dtsi include file
-u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
-	$(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
-	$(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
-	$(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
-	$(wildcard $(dir $<)u-boot.dtsi))
+UBOOT_DTSI_LOC = $(srctree)/arch/$(ARCH)/dts/
+
+u_boot_dtsi_options = $(strip $(wildcard $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi) \
+	$(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
+	$(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
+	$(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
+	$(wildcard $(UBOOT_DTSI_LOC)u-boot.dtsi))
 
 u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
-	$(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
-	$(dir $<)u-boot.dtsi ... \
+	$(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi \
+	$(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
+	$(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
+	$(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
+	$(UBOOT_DTSI_LOC)u-boot.dtsi ... \
 	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
 
 # Uncomment for debugging
@@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
+		 -I$(UBOOT_DTSI_LOC)                                     \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
 		 -D__ASSEMBLY__                                          \
@@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
-		-i $(dir $<) $(DTC_FLAGS) \
+		-i $(dir $<) -i $(UBOOT_DTSI_LOC) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
 		; \
-- 
2.34.1


