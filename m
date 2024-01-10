Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA299C47DB4
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.8926.1704883001155287452
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:36:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=T8zAbylc;
 spf=pass (domain: linaro.org, ip: 209.85.214.177, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e416f303so14543955ad.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883000; x=1705487800; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jjrQStR8mg01rea7SGpxXhx6+KLoAYg0dAdhNzxz5w=;
        b=T8zAbylcp7gn+M388FdrV+rG/CgDjyduOX4wMIzEJsXuZKdnEze/vKpgjhFtyftypB
         1NFLdljuRXwjVaYCqp6BdlmdqmhRPosNSy0J7+o6i87qA/v98b8bk35FrUzKoZcv2T3P
         rLFDX6wM8yqXSqlWVKlCtEVlBcE09nB3sL6ullcgSqeiNvpwfpdpVDNdbfR1VVxgNe6V
         gwM8WR2RN9lUgqjefcdD9eul/Sno4KOqYKdlaB5BOmqtRxZ7BS6LEoIICtMU7MXkkKxb
         U7nXwe5JTtav/1hVuyd4i2XFEGF+aPBqNvek/m2IuRzHEERIhXnNhNcvelLZdOto1W4/
         7Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883000; x=1705487800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jjrQStR8mg01rea7SGpxXhx6+KLoAYg0dAdhNzxz5w=;
        b=fFwcUUj3Tw4GGYDQKjV/FTkx980TG1Uc6xEffcYrEz/rS1IxvnlYFIhXvls3geMwRb
         cH8S9qR2NF9iar6cF+TP+L+T+7uEcYuV3ZguETIQStHBGAJZ3WGpJ3AkdpQSfRvGbG6Y
         SCxoFPNMetQCamW5CL+sQbAHEqy4bLZ2PszynPyUMOfMWLX6d8VsGDTPkXE/oZVdeZCE
         8hWKa2JwtUGeEtKAQ2V6HcGjbpQNHNTS/aXa+ihZwMhGJFCIJI7OvxW8Nyk0No0QByxc
         u/P04NQ3Hgv0o/fjYAj09ON8E5BkXrSVatDdOkCPxAgvo3JPSQQ2ei4cSPaboVycHjMP
         nSlg==
X-Gm-Message-State: AOJu0YwSCrBUMZIn9R6EREyvb9QMkIvEJiiXUfmx/rxM8eje2QtJVVzW
	CKd6PbnxNZ04/WtR5DBWJo5SFvCCdUgk2g==
X-Google-Smtp-Source: AGHT+IFw0b4WpWns2ugIjhso7Di59KjpROnkAbXw5gptrKmYqPMluvHhA46Hz6yGGD7hCRf79adAIw==
X-Received: by 2002:a17:902:7841:b0:1d4:ebbc:227f with SMTP id e1-20020a170902784100b001d4ebbc227fmr438033pln.134.1704883000645;
        Wed, 10 Jan 2024 02:36:40 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:36:40 -0800 (PST)
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
Subject: [PATCH v4 04/11] Makefile: Allow upstream DT subtree to provide DT includes
Date: Wed, 10 Jan 2024 16:05:40 +0530
Message-Id: <20240110103547.719757-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2061

Allow platforms to reuse DT headers and dtsi includes directly form
upstream DT subtree which will be frequently synced with Linux kernel.
This will further allow us to drop corresponding DT includes copy from
U-Boot tree.

Also, since the DT includes from upstream DT subtree are done after DT
includes from U-Boot tree, so it shouldn't cause any conflicts.

Tested-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- New patch to reuse upstream DT includes by U-Boot as per Brian's use-case
  for TI K3 SoCs.

 Makefile             | 3 ++-
 scripts/Makefile.lib | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 69cffb16ee2..d4e65ffe49f 100644
--- a/Makefile
+++ b/Makefile
@@ -835,7 +835,8 @@ UBOOTINCLUDE    := \
 				-I$(srctree)/arch/arm/thumb1/include), \
 			-I$(srctree)/arch/arm/thumb1/include)) \
 	-I$(srctree)/arch/$(ARCH)/include \
-	-include $(srctree)/include/linux/kconfig.h
+	-include $(srctree)/include/linux/kconfig.h \
+	-I$(srctree)/dts/upstream/include
 
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index fe2a0aadc41..fbcaf335f9a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -189,12 +189,17 @@ dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
 
 # Modified for U-Boot
+upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
+	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
+	$(if (CONFIG_ARM64), \
+		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*)))))
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
 		 -I$(u_boot_dtsi_loc)                                     \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
+		 $(upstream_dtsi_include)                                \
 		 -D__ASSEMBLY__                                          \
 		 -undef -D__DTS__
 
-- 
2.34.1


