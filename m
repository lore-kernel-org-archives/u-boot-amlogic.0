Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE6C4829E
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.22157.1706879193989286869
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Feb 2024 05:06:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CwlaFMpo;
 spf=pass (domain: linaro.org, ip: 209.85.214.175, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d93f2c3701so12406835ad.3
        for <u-boot-amlogic@groups.io>; Fri, 02 Feb 2024 05:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706879193; x=1707483993; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZyRiozEVbTqo9oMcq8lbIwXjVNaeje4ktcNZtXFrQE=;
        b=CwlaFMpoI0u1RBHsQZMi+a7bzABm+OwpmEDEfw1h+aPpTYICU/22sfcG8EY2ZWaq++
         kkBezzAM/m/0Pv3dEVgY6z6Hk8l5H/9tLEmOUy3qKiPRRtcoXZLLrz4Z6iiTAK0RNRxa
         JUuGgSeunYBSmKfMFszJP2RDPINUK07zxP+b2kXQ8Sfd+0Y+t95JUUgGff39dAxUOiHO
         gtBo9fDAb0z+EVO7Wf0JXk3LN737VbGv/Lnd43jlCXL+SYm8O6yp/2BlZnWhhfbQ+Wrl
         3TjIz8HkHAO1JHq8JRfXbZx+FqdehBT2d+GkmZj6pFaItoteBVe01r6mMuUcM1PZnu0b
         0d9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879193; x=1707483993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZyRiozEVbTqo9oMcq8lbIwXjVNaeje4ktcNZtXFrQE=;
        b=ktGrUw2hCQgiGMb8/HxkHjapRm849g2EW571GQwV+7CgWDLCcodB5Y8WE51LrLxJVr
         i/7d7LdIDNkWzMOuiu9f/7dkyssLu4oS+WhS8vGGNdJWq2NC9VoiRZ0BVduP4fH7uBhK
         2IE64WjfZKx0uLpBvz9qOOS0Pxi/qZuN2VLW2eo657YumVSAoNqbwNmq3I57Jp9XhdWl
         ZuSrV/uUNPlldZ84ydNIrdkLrywiWoUOIS1wFAXA/4b1Xjba70slcJEySyKubjD/CmpW
         lue4geOIbk4tpqC84bAIeZQB+TqkHeTACBU8MJO/P1iHv42j2BRidDg9Fk8eHusSiwyh
         w+Gg==
X-Gm-Message-State: AOJu0YzuBYRvvmQ6BpVD53PqxFL0Gok/N9BXrD57GhUpWMlUILRLRiKK
	o3kObkvwm6qc+jPjqYHThxte7i+lkvRjJxcYCyuawGstgcyVO+Nirt5Oymh685w=
X-Google-Smtp-Source: AGHT+IFDpffcil8J9/ZtT9GVdE/vF7HfGZrRnrcfg150z1qhn3zODJq3F0l6axgXbVsRA7/qj3vNIA==
X-Received: by 2002:a17:903:192:b0:1d9:46a4:117d with SMTP id z18-20020a170903019200b001d946a4117dmr8192321plg.30.1706879193494;
        Fri, 02 Feb 2024 05:06:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXi0fm+FqzHl3LFcHTWX0TP7Z2vJCxh+u4cCKtgSOWuVDpQz+vsMKvCc+YzitlbQG3YiTwivsje1lVqfpURyyPbVrXXPkmIkIcP9aLu30OHpHyRceBOOCtDc/83UdJU0CqDKzlv7LwF1VvEP637OIMJUvAW3yV540Fz112nrgmRWJFZfuuOMsvQt0kSYFCmizOgdi9bM1pis2VSTLjCcRrvIn4+xiOxE10avcikXu6cth7hTiaxetAB0U3GI9V3ZLvfUiK4aEkAswJtlWakDY1w2PCuyDWaEFfC9wgW8IW8Ebr0IJvHTTYc/G6zZLTte48o3UpiDfnub1Jzah1t3N9grwbJr7YHAnuBTNfJAnRzQF9QC2i4a3JnSjbdBaOUyqTRB0Al4JE3pnJrXnJ2DHH1A1d6+5jamUKiAQFrEw9n62MB8en9TeQrIjJvOnlMXu3K+olu1+4kRDX8bgmFxLW0nwOR6zoXNE5oJ3NECHCGJWgkB4CMe9pll7BR2VGaTe7RGmWV+BSLhblyowByEcLtZ1Zk+aKIhtqIpfQC3ZCLhy9HJizWuDeVeJ5/ED2iUEz3bpLDvf0ELlut39aFNcTCHcgVNc/uE4y6aLg68BrhBFRZf+Y6TVUIgLwo5bG76Lv+9iP9d7ZkybokpcdTOwHmAx898etUxgXCE02PmdB+d3h+cHcEBJWoOD0WUWcZ0NEuMdyYNacsJ5KZEU1TflfHA1/lVfJoKTNt3NYemdKpWqUPyY+WjnQbwtrR7XfKL0hsYOdG+c+j7C2koRs5xmqZS3DT1TzuRM7zQT5SeaF4Ygksa6ZG9E+HwHJBCaDuzwa1w9vtq8muctlgo83LR0eq2hVysrgsdrbzPk23Nvjf0cgUI57MA/sPTpRlEk9f9yL7G4d0IjW3wjglDOHPYsRQxKeOS94bws/G
Received: from sumit-X1.. ([223.178.213.44])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:06:33 -0800 (PST)
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
Subject: [PATCH v5 04/11] Makefile: Allow upstream DT subtree to provide DT includes
Date: Fri,  2 Feb 2024 18:35:27 +0530
Message-Id: <20240202130534.1051438-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2103

Allow platforms to reuse DT headers and dtsi includes directly form
upstream DT subtree which will be frequently synced with Linux kernel.
This will further allow us to drop corresponding DT includes copy from
U-Boot tree.

Also, since the DT includes from upstream DT subtree are done after DT
includes from U-Boot tree, so it shouldn't cause any conflicts.

Tested-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v5:
- None

Changes in v4:
- New patch to reuse upstream DT includes by U-Boot as per Brian's use-case
  for TI K3 SoCs.

 Makefile             | 3 ++-
 scripts/Makefile.lib | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c7e5e0384af3..996a43c8624a 100644
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
index fe2a0aadc417..fbcaf335f9aa 100644
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


