Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8E3C47DB3
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.8909.1704882992885663608
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:36:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Yc9OfGiI;
 spf=pass (domain: linaro.org, ip: 209.85.214.174, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d542701796so18841715ad.1
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882992; x=1705487792; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnrWsmumWdWqbos15AFnT70rACmbaMyZSLSmWekGnk8=;
        b=Yc9OfGiIj+1cIL1aipk8DYRWPZ+J0piC3bR5vjfyaCY9aZ+qadwzz8oeWwj6IKnS5D
         T4lRzKBlW1l4xNXgYUX4KRRqeCzHtFZVvfPO8ObfX4lWNmQ33iFWzFGQDmXhyHSssZMx
         Vvnrh0VgVoCp7igzEXp3ALQLXvOATWEuTZOVsX8+6r++vpwrV6Ttl+HJOhbg5eg8/BYL
         T/YNMYmqcW9Sf51bbrdzslBuY137B0ZiMG/N+6M2jeSDxLMy9TRo57FR7fTqgkxfJJ1c
         rtZq+61D4C10sMeci0RhiimNfey/iTZyJ+9rJzU26RITiYKMSTspUi1he7LRzjY1o4d9
         /1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882992; x=1705487792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnrWsmumWdWqbos15AFnT70rACmbaMyZSLSmWekGnk8=;
        b=HLp9CdwDjt0Q3sNSHci73tr3rlagi7/uEy8fPv3CTYk+JcYPf7w9fNk0JtJz4Jod4t
         C3H71+Vjf/rGZUeTmD+hOMvBMuk06LLPK8LKnD6XO98TUieOS2/r9MawRqf5lv3Ad/Xt
         zPDjdxrseVfCzbOTtusHEQtB7jCD6olxfczU2WrYlt2D0u0y4HYyEKmZ1iQPB7tNmHoQ
         m3KDdoRGK2321e0NLt0ec5eiflVViAooJNCKiW0OraRXu9ykedpxRWG+G+6opPyEWDY9
         jBd5Z21/wmqZVuHK54HsT6A65YfhqZ3hxfInbGDR1rjONzG1ZJ6nKQdYRnA5cAYs4Ep0
         7V8w==
X-Gm-Message-State: AOJu0YzSA9ORRSkJgKdlFOjWqRjEdckdeg0/sc8vvbKT+n/xJJCVZBFy
	R2Mv2ZpXM0U44xjgE/I7i9S9EArAkCeKkg==
X-Google-Smtp-Source: AGHT+IEAb7E6cYgneKf36cQsKMUATDa5u6EX4B/Mpy0fyzMP2+AHR/0TrdJ+nn+p+EsZaRxi9U/ENw==
X-Received: by 2002:a17:903:41c6:b0:1d4:ac33:10bd with SMTP id u6-20020a17090341c600b001d4ac3310bdmr678576ple.104.1704882992422;
        Wed, 10 Jan 2024 02:36:32 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:36:32 -0800 (PST)
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
Subject: [PATCH v4 03/11] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
Date: Wed, 10 Jan 2024 16:05:39 +0530
Message-Id: <20240110103547.719757-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2060

Allow u-boot to build DTB from a different directory tree such that
*-u-boot.dtsi files can be included from a common location. Currently
that location is arch/$(ARCH)/dts/, so statically define that common
location.

This is needed for platform owners to start building DTB files from
devicetree-rebasing directory but still being able to include
*-u-boot.dtsi files.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Incorporate fix to resolve rk3399 migration issue reported by Simon.

Changes in v3:
- Picked up review tags

Changes in v2:
- s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/

 scripts/Makefile.lib | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f82b3169e87..fe2a0aadc41 100644
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
+u_boot_dtsi_loc = $(srctree)/arch/$(ARCH)/dts/
+
+u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
 
 u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
-	$(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
-	$(dir $<)u-boot.dtsi ... \
+	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)u-boot.dtsi ... \
 	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
 
 # Uncomment for debugging
@@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
+		 -I$(u_boot_dtsi_loc)                                     \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
 		 -D__ASSEMBLY__                                          \
@@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
-		-i $(dir $<) $(DTC_FLAGS) \
+		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
 		; \
@@ -354,7 +357,7 @@ ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
 dtsi_include_list += $(capsule_esl_dtsi)
 endif
 
-dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
+dtsi_include_list_deps = $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
 
 ifneq ($(CHECK_DTBS),)
 DT_CHECKER ?= dt-validate
-- 
2.34.1


