Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832DAC47DAC
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.8907.1704882985020723971
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:36:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=PbXmPE3K;
 spf=pass (domain: linaro.org, ip: 209.85.214.169, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d4a2526a7eso20999065ad.3
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882984; x=1705487784; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0Y8Nm6SxspwtBtpuDp0RvA2ZrL2DZZ90fWjbGeTz88=;
        b=PbXmPE3KbHzVw1PU+P021QsKYMWOaVh4+9M2EH56nI7SKpL+Ayy86jdP6Zhhm4oJlY
         WiFc7IgM/n9C9DYJQlwGOBMUNlOwomWGa6rzDJQH1dGnWYJxYuBmPXD6Xvr7EGU2wZ3M
         8lbMWH4qoCtKNUeLFbFSM5xdoxn9Lo7nDQoWlcWmQr/5tZeC5jxWlbrGdxqDdMRN7p7b
         p9mQ570/0YYZ0k+lUqKqUtHPUgtOD5N3WE3th6SehxB4j/6TQRAN9cECEtT6g8GOVxZC
         gCk1ZXAOyHvOPnRMFKuMsRx2tYyDONaDr+j7qMueJ62P815OyoNEsDZ7prxRJFk4xmMI
         sChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882984; x=1705487784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0Y8Nm6SxspwtBtpuDp0RvA2ZrL2DZZ90fWjbGeTz88=;
        b=mFRoLCyGeWvp+JgrA63Nw6x1R8z5qGz+GtIm2RQq4FbgySgT6LhXJdN1DuEq4o7rat
         D7nqHxaaBYEzGo+2RmB/ZChi8K5GnEH4CsMFEgFVgRLrP2eXb05NhbGA1xk+Hk7fUUtn
         SWBdk6WqHg1ocGn0hnqYzYUlx5Jkqe7IIymnSWBNWMzoXrg66RG3S9kOR2XHUsXYj+MU
         uUeWNuVFq6iZvyls9SR5mSiaLykuTjwXQtKA1l0NSTxcKoqwC+FoApuuqlMsUTNvOSpp
         2//DRqAXSVGoP9dCxr4e/SihuMHmDBiSztYcX9MlIwOgxubdpdpnQ0cppGKURkf0OR6f
         DWKA==
X-Gm-Message-State: AOJu0YwSmN3PQHkLFPsMmLruwC40Aq7fwMCLRR8U6/CXwZomDeOinV3N
	ZY7sglftkvzJrbsVPa9aXL1kzvNb8TeyKw==
X-Google-Smtp-Source: AGHT+IE+5J47W5lZfE7xWqj1qlgRhJ1PZVfoUK5zUxAWxst7LRSQz2eqoV+Z/kXlGgSFIh+s+4bn3w==
X-Received: by 2002:a17:902:7c8f:b0:1d4:3872:30a2 with SMTP id y15-20020a1709027c8f00b001d4387230a2mr575449pll.57.1704882984435;
        Wed, 10 Jan 2024 02:36:24 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:36:24 -0800 (PST)
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
Subject: [PATCH v4 02/11] Makefile: Add support for DT bindings schema checks
Date: Wed, 10 Jan 2024 16:05:38 +0530
Message-Id: <20240110103547.719757-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2059

This adds the build infrastructure for checking DT binding schema
documents and validating dtb files using the binding schema. Here we use
devicetree-rebasing subtree to provide the DT bindings. Along with that
adapt dts/upstream/Bindings/Makefile to align with old U-Boot Kbuild
infrastructure.

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

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Incorporate build fix to adjust Bindings Makefile rules to old U-Boot
  Kbuild infrastructure.

Changes in v3:
- None

Changes in v2:
- None

 Makefile                       | 20 ++++++++++++++++++--
 dts/upstream/Bindings/Makefile |  6 +++---
 scripts/Makefile.lib           | 17 +++++++++++++++--
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index a519397ef71..69cffb16ee2 100644
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
+DT_BINDING_DIR := dts/upstream/Bindings
+dt_binding_check: scripts_dtc
+	$(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) $(DT_BINDING_DIR)/processed-schema.json
+
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
diff --git a/dts/upstream/Bindings/Makefile b/dts/upstream/Bindings/Makefile
index 3e886194b04..e799963a599 100644
--- a/dts/upstream/Bindings/Makefile
+++ b/dts/upstream/Bindings/Makefile
@@ -47,9 +47,9 @@ quiet_cmd_mk_schema = SCHEMA  $@
 		      rm -f $$f
 
 define rule_chkdt
-	$(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
-	$(call cmd,chk_bindings)
-	$(call cmd,mk_schema)
+	$(if $(DT_SCHEMA_LINT),$(call echo-cmd,yamllint) $(cmd_yamllint),); \
+	$(call echo-cmd,chk_bindings) $(cmd_chk_bindings); \
+	$(call echo-cmd,mk_schema) $(cmd_mk_schema)
 endef
 
 DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1ca84195c99..f82b3169e87 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -356,8 +356,21 @@ endif
 
 dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
 
-$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
-	$(call if_changed_dep,dtc)
+ifneq ($(CHECK_DTBS),)
+DT_CHECKER ?= dt-validate
+DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
+DT_BINDING_DIR := dts/upstream/Bindings
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


