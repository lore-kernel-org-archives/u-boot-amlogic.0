Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B0C54E55
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:58 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web10.9319.1708594623049957033
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Feb 2024 01:37:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=IGMSLu4f;
 spf=pass (domain: linaro.org, ip: 209.85.210.53, mailfrom: sumit.garg@linaro.org)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2d83d2568so1033010a34.3
        for <u-boot-amlogic@groups.io>; Thu, 22 Feb 2024 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594622; x=1709199422; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14AzahfzBnDkKxuiQC/TmfvLbJfEMKHj6tMXkEc2j6g=;
        b=IGMSLu4f0Z0igj3Nbkxjb7ZrW+UOauKYV1OFulMlr4z1FJ24snLSHrNRvw/HfjSRHH
         xj7a6P9wzIHdJVNA0DwFHA63Gp2BOIbkoRa09wmpnok7DgCpQPAUXVKOf7KRQFL1kM18
         9G4/JIjJuejLpOeL6zlRTpRy7LzbMANFl+AfWfSAXUs9kwlWnf95Fi4nKCUu5Ld6NcSJ
         6i7vjk6RYttaRPTcwcgLCITsIpF01GWNfkOID9cujDy/hLZK+mCMT6J3fMVYKM43JDo2
         sYHKlsUtrKLmCFgBt3K0K4HgDI7BXJQhr68o/wj6LCNI2/f8+i8W651359P+lsf0Zx1/
         SW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594622; x=1709199422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14AzahfzBnDkKxuiQC/TmfvLbJfEMKHj6tMXkEc2j6g=;
        b=TK41jUM0ybT5AyOpUaz767X6s1oEhDy4oKppYNhMiWnPVu0t7E7TEJYc8z4e+7YiXn
         LA3BldtEhO8WcWSJNSsQpDVUOO99D3CR8dh9Y8kJqBtcWtQVBmvQmfuS7pn1zCm4Y83U
         ShdDOyGgm2Y1OapX0jX9lXlst6xWx3nUKk3Plh5aEffvIEKWwRSI/hO6XUfF5EjsgUqL
         WvmKsvDEK7w3EETgUrBXx3oLzpJH9/PEA++Z7eRJJ5SAMLnA8iE57Sj9EX2tGwH8B2ie
         G4kLo9G0ZSYxzUvYDIToxObxQDBXaat4MPTycGUXSpSGxJcdGsaHOSlDN8IsnZOJ6R4R
         8pSA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMsA3Ok6eUkwkHh1gstlVilhSABOOT4zAh7e2QHcDXUO1FejnAYdd7HQPyGu95hHcXfNwIjKIuSnQ/r56SkZVj4it15qJ2ig=
X-Gm-Message-State: AOJu0YwZHeuQRMQo6de5guJma0sEQv/S9yEuQxE9vmnvQztqxVmtPYBa
	dg+KZgBpoEdrgtOHEC7HthMpvDdgw9urpvAFzHxeoP5FLb7zhE70OtmQaUqaAP4=
X-Google-Smtp-Source: AGHT+IG0SmZv7NSGy2mX8SZMvvZaqP5W1n//57ZRFkeAZdKC65AyM8S3MWpyFeenn+7xslenkXWrRw==
X-Received: by 2002:a05:6359:412a:b0:17b:5a19:5366 with SMTP id kh42-20020a056359412a00b0017b5a195366mr5219350rwc.4.1708594622323;
        Thu, 22 Feb 2024 01:37:02 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:37:01 -0800 (PST)
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
Subject: [PATCH v6 04/11] Makefile: Allow upstream DT subtree to provide DT includes
Date: Thu, 22 Feb 2024 15:06:00 +0530
Message-Id: <20240222093607.3085545-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 26 Feb 2024 08:49:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2135

Allow platforms to reuse DT headers and dtsi includes directly form
upstream DT subtree which will be frequently synced with Linux kernel.
This will further allow us to drop corresponding DT includes copy from
U-Boot tree.

Also, since the DT includes from upstream DT subtree are done after DT
includes from U-Boot tree, so it shouldn't cause any conflicts.

Tested-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- New patch to reuse upstream DT includes by U-Boot as per Brian's use-case
  for TI K3 SoCs.

 Makefile             | 3 ++-
 scripts/Makefile.lib | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9604a4c517e5..0f0c7f30d271 100644
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
index 9e38d75443c9..12857316c582 100644
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


