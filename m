Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C0BC47DD0
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.121672.1703764731882205810
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 03:58:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FOlq3HQ2;
 spf=pass (domain: linaro.org, ip: 209.85.214.178, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d4751dcb56so8760695ad.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703764731; x=1704369531; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTn3lEgWvkPzpoWGXtAVVa9kdn3+sVlfns5CTBdgKPs=;
        b=FOlq3HQ2C+LbQr3cMxa+n4oCs8oshklPRQXg4p8DPNxFBbVDxqOIuGtaUDDfyEXhqL
         BMZvUeFQoDiNlX/n0JDIiPaAem80NgYwwn3XbJw5SVhrytuxWzIZFJFYgYgkGQUGlupj
         8QriqQamROcRnOlbTlq4Xj70JdAcH3tvTRMQySwBgVSqEAPDo5kVu8sVwjjEjI9D8RC4
         P8YM20OKip7mZXF7xDXPhhQQEfOJ9tFnsQlZhWHfQfybJwV62s7IR5tfxXc7BBbEQK+Y
         YatL+oU6D0eFzK/acqqU9oE5m9g820ylsD5qEbyhCVfFxFpdSKpyrLrte9ljRat2GpUJ
         zXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764731; x=1704369531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTn3lEgWvkPzpoWGXtAVVa9kdn3+sVlfns5CTBdgKPs=;
        b=vZp9cfKvSltis9xGlUH35OlrVyzAVz0cLA+oOX5VHGzcLhN8CagiP0mTdB9EbRWP1m
         BPMhXVsc+ladYcAFzUBckhE5t6DaFn+s4koJ3uO1LMVwDTeT6STmeBKYeXMgSh4chob6
         dsS3wNGvO1yq5mLE2U5BvGqqXqsOlmvg1gYAvl8RcBxpXxGJCdagAMLN/b5Km54OmWVt
         eqOA7QehRdW9nUqTep24HhZnPhp7pmPzuh93LF+ywSNJbJBjq9Bba+dZdKugwxkkzHwF
         xC/er0xDy7fS4Dpf/MnYw64DRo8bJ0C6S8eJe1J7AE17ESYf4BtYvRSWnOC3pxuhj1Vq
         xwmg==
X-Gm-Message-State: AOJu0YxVobfIQuq6abslOLjuYMFsZRv6mn2eVlIi3rWOVoewCY3praLE
	+y7pdR1OdflhViC9X7dyQRHtZncK3OOerw==
X-Google-Smtp-Source: AGHT+IFwB/MyfVD86ZFnAtY9v1ON7OVFrcbCn8p4ydVaO8awQmN65X7/QpDYKBFN6Jybozh90nFWzg==
X-Received: by 2002:a17:903:184:b0:1d3:c8cb:4000 with SMTP id z4-20020a170903018400b001d3c8cb4000mr6430196plg.26.1703764731301;
        Thu, 28 Dec 2023 03:58:51 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:58:50 -0800 (PST)
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
Subject: [PATCH v3 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
Date: Thu, 28 Dec 2023 17:27:59 +0530
Message-Id: <20231228115804.3626579-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1983

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

Changes in v3:
--------------
- Picked up review tags

Changes in v2:
--------------
- s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/

 scripts/Makefile.lib | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 27b9437027c..09330421856 100644
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
-- 
2.34.1


