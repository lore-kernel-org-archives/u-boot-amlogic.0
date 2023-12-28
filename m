Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBB3C47DD8
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.121392.1703764723707083647
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 03:58:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wo1zg06U;
 spf=pass (domain: linaro.org, ip: 209.85.215.176, mailfrom: sumit.garg@linaro.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce2aada130so676561a12.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 03:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703764723; x=1704369523; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDPS55DFd0c8Rb3rEcH+LRja5l5dvTmJa9ZgRbve2Rc=;
        b=wo1zg06UEjU7NIl1u5nUWm3JOGFn9YIosXiL0zXObBrIYrsKIiBxO4GWz2fXe6uOK6
         8/dkMglzWr7KJqg135XDZVdMtSKk/AhNVJ/qOLQ9MFuJ4Mtr4X4pA61JVK1oFlVWHWsp
         LgZs87BBLADP/oDkfUbkbixqtwHBWD1opBMbssWkqtS6PWQ9k5S4S5EmhXWFhZ2XWBBD
         oZzZgL1iWV4NWnw/CHy8OSYQw3xXV6DxhIJjyDxyg1tdhYe8G3ff++B6P7s38+Ras+T5
         aRl0CWM3HK5RdiaEH2duUNjdEo4qH+q9WgT3WCRJRBopfbZdf2bnYVK3f59R4xwKtafr
         Z/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764723; x=1704369523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDPS55DFd0c8Rb3rEcH+LRja5l5dvTmJa9ZgRbve2Rc=;
        b=YehSmusLBjMdn9EnvxH0VPjAcvOZ6q5IPz+v2KqUGxi33NAySzbRnPT5AAyCLuwkl7
         8sDNJ4KixweVzD7LTv2olRaSxENx5M+5hlir03u9A6cCT+5HD3TFSFuIKoQ3QXAcEfrI
         e4/qJKwZw/qkIYKekDUgfYoqSLG5PHUiVZN4yq5MuKqM+tywVJjHpAeIjvXRmdBrjt5G
         tvPsn81vlOWDPDmOjvfnI6Sy1CBerpHR+4Db7lW620n8zvL/Upq0WUVeViCBo8zFMmlv
         GX8FR8mLTdz20ap7f7L16ntJKOIYebyNMBN61QfrZKj/a9piZt/BIabjLVXHHCluhyhH
         orcQ==
X-Gm-Message-State: AOJu0YwzTBdaGcxVNbgUVG3ScIzgBtx00+vNbwXmJB/FLJUmHmahCl0m
	ctuemjWoHxLTJKUp+/7vocSf4BtizaKE2g==
X-Google-Smtp-Source: AGHT+IFknfFK4DxHGi4VZ9OBEQWoEqVOP3Ebnhx3FOf+JQd1uBV6f7pvdteVYwjCfYSK7aeEwn3R6A==
X-Received: by 2002:a05:6a21:a58c:b0:196:47b1:9a34 with SMTP id gd12-20020a056a21a58c00b0019647b19a34mr649619pzc.56.1703764723185;
        Thu, 28 Dec 2023 03:58:43 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:58:42 -0800 (PST)
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
Subject: [PATCH v3 2/8] Makefile: Add support for DT bindings schema checks
Date: Thu, 28 Dec 2023 17:27:58 +0530
Message-Id: <20231228115804.3626579-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1982

This adds the build infrastructure for checking DT binding schema
documents and validating dtb files using the binding schema. Here we use
devicetree-rebasing directory to provide the DT bindings.

Dependency:
-----------

The DT schema project must be installed in order to validate the DT schema
binding documents and validate DTS files using the DT schema. The DT schema
project can be installed with pip::

    pip3 install dtschema

Note that 'dtschema' installation requires 'swig' and Python development
files installed first. On Debian/Ubuntu systems::

    apt install swig python3-dev

Testing:
--------

Build dts files and check using DT binding schema:
$ make dtbs_check

Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
use for validation. This makes it easier to find and fix errors
generated by a specific schema.

Note, at this point dtbs_check is an optional build target as there are
many warnings generated due to custom DT properties used by many
platforms in u-boot. It is expected with these checks that compliance
with DT bindings to take place. Once that's done it can be added to CI
builds to remain compliant with DT bindings.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- None

Changes in v2:
--------------
- None

 Makefile             | 20 ++++++++++++++++++--
 scripts/Makefile.lib | 17 +++++++++++++++--
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 750bbdb1b71..d8d168cd4c3 100644
--- a/Makefile
+++ b/Makefile
@@ -1158,12 +1158,28 @@ endif
 	@# disabling OF_BOARD.
 	$(call cmd,ofcheck,$(KCONFIG_CONFIG))
 
-PHONY += dtbs
+PHONY += dtbs dtbs_check
 dtbs: dts/dt.dtb
 	@:
-dts/dt.dtb: u-boot
+dts/dt.dtb: dtbs_prepare u-boot
 	$(Q)$(MAKE) $(build)=dts dtbs
 
+dtbs_prepare: prepare3
+
+ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
+export CHECK_DTBS=y
+endif
+
+ifneq ($(CHECK_DTBS),)
+dtbs_prepare: dt_binding_check
+endif
+
+dtbs_check: dt_binding_check dtbs
+
+DT_BINDING_DIR := devicetree-rebasing/Bindings
+dt_binding_check: scripts_dtc
+	$(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) $(DT_BINDING_DIR)/processed-schema.json
+
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 16bbc277a9f..27b9437027c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -356,8 +356,21 @@ endif
 
 dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
 
-$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
-	$(call if_changed_dep,dtc)
+ifneq ($(CHECK_DTBS),)
+DT_CHECKER ?= dt-validate
+DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
+DT_BINDING_DIR := devicetree-rebasing/Bindings
+DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
+
+quiet_cmd_dtb = DTC_CHK $@
+      cmd_dtb = $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
+else
+quiet_cmd_dtb = $(quiet_cmd_dtc)
+      cmd_dtb = $(cmd_dtc)
+endif
+
+$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FORCE
+	$(call if_changed_dep,dtb)
 
 pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
-- 
2.34.1


