Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE21C4167B
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:41:38 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.22550.1702561912418323210
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 05:51:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ksu/pzqz;
 spf=pass (domain: linaro.org, ip: 209.85.216.48, mailfrom: sumit.garg@linaro.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28ad7a26f4aso2577381a91.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 05:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561912; x=1703166712; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1OsPqfGmFH05ZPKbNH4dIRe46agPWiUEln2hoUy/k4=;
        b=ksu/pzqzp/MY11wda0fTDZo/A12V4SieMg4isXfJYceIGo2wPZOKbnsDUTQLeeEts8
         g8EA+azfqd8bJP6FMlkG3WfTJSAwnSlMOO5Dqu+C4AgLoq+SlvKlWGPd+EHObo7dCCr/
         /xzpOZ8vCdE+Jgv7pqiOrVOd8rVM4a45Vd2B/st9l63jcomyaqj2dKLN4deeq/GP5QLr
         kesbLz3PSLiDbmpYa0GU1sXOnrS9QRHoeQmcsn2clwePASHLy5rUGq1BFpBC5PLxknkD
         vAZYOwccNanthWq41cbureIpGuRgKB8X156Z5WpzGB08Knyy28614Dg28Zh98DPxMVNs
         wN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561912; x=1703166712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1OsPqfGmFH05ZPKbNH4dIRe46agPWiUEln2hoUy/k4=;
        b=b7aqz2JDTORoUto9vyUPxtbV9ErPcXnkry0c3wxNRz4PdG1lJMOkwfEYTlTSR1jSKR
         Fa7zRZ8M2jyoBZFo5eqbBs6fX45krsrJKmItEzkmJf2G9mdRItDr7GEp7NsKtgW1fJeA
         Zta//6LoZmooWv3Ik4hVNWmoDbFKMLrisHIGe2VK7gKyuTAbuurHeSCCSgXRfv7ZIccq
         sD/6Ga/EZerJ0LNtOKSvu0igwWGMO3gnQYx1pinHNENcVIKA8ITLyTLaSj38mlHPgb+i
         olOieGpDPsYT4lUtcb4Nhxl+Qv3t/2JgtoaVMOIaCCOMbcIN4FVNwZa3bi1L1lcJB8EK
         OQrQ==
X-Gm-Message-State: AOJu0YxoXTz+E1j88W8iI5FPiPucjBaaGhhspgPMbbmEMbU38euL0JSs
	JNgTsiC7C8Hm3bK8+t2fl14MuA==
X-Google-Smtp-Source: AGHT+IHhR0YSkpu47XWJ+3DVJO3OWFHipEKj3+HBPuTpPgDq5wQAXDjoSp2jk/yLFOln1irbjXuueQ==
X-Received: by 2002:a17:903:2b0f:b0:1d3:44ad:2156 with SMTP id mc15-20020a1709032b0f00b001d344ad2156mr5126443plb.2.1702561911882;
        Thu, 14 Dec 2023 05:51:51 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:51:51 -0800 (PST)
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
Subject: [PATCH 2/8] Makefile: Add support for DT bindings schema checks
Date: Thu, 14 Dec 2023 19:20:57 +0530
Message-Id: <20231214135103.1606605-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:41:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1918

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


