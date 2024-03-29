Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F4C6FD1F
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 17:51:59 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.2100.1711734717496172341
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Mar 2024 10:51:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Ehn0afeV;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so1445032f8f.2
        for <u-boot-amlogic@groups.io>; Fri, 29 Mar 2024 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711734716; x=1712339516; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwDnz3uGjyYlBYlamZRBwQc/JTUwMVWzF3SrjvDvefY=;
        b=Ehn0afeV6bi/SzaUWJM+yXMvsNCoRF/o0MsmIctw7DoFb2so9/gf8LF2Xbp838pyCw
         97eJ1KZ9FvYxaz1hVyZbcLKcfhLIG9XI2YPr9Pq0MgYXd2has7Gu1w7VOO0XyAWqx6/O
         Td2bNOgS4RrGV+kcyyS/zMPMOQNMyLIsSYpel2qYUsjf1zLCClWtEH/w2I5mbmMhXa+T
         5SSkeHuADLzc8o4XvRQe3B4jO9deVjJdkHwA8sYGesnO5t9SiX/buF18ocarNuI7vSlG
         AAdlRUlxbgpLkaiCoAhVLfw8qipuDB/kvkW+/QjgttcLvHyjdH7MCo2vTdSKWe7GrC+T
         HFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734716; x=1712339516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwDnz3uGjyYlBYlamZRBwQc/JTUwMVWzF3SrjvDvefY=;
        b=uxoVtRiqtdwbmxT0/2i7CSEpXhMpkZhNdv1dZHSB4QaySE4G0O6qOphrbqrPO3zQRN
         C5C0TbpqLoFgldOH5wG2F3pagAFKGQeHqk+1WUCV625z0PGyFV2nvc6hEceI1RD11qFB
         sHPY8oUeldOVK549UuZiNhxelGmrq2bgcB7HqIWfgFPsNlBrMs7ayePQFFSRTloOuJYJ
         OSMY1l9VSOTouikBEZCCIPGlF15+dDZYg6+nFYTgqMyQVpTXcakP0VSLG3x2KT7SZb4K
         vEgmdmw2jPhmbl/gkJnSs9bUIB77b7S/ugXxTHlncWA18E2naFAW5JqBw0hH4N0JZ2U6
         6qEQ==
X-Gm-Message-State: AOJu0YyKFjs2n7nkbu1foE5i+PsKXBM/Gpl006MfaQ/28If8v2i9mjOS
	FW0Ad0Gfa+YeyxwRovwa3Tsnz4VTfn/NxO6ORsIb0y0OTv3g7aZPVKPYLKDqPQo=
X-Google-Smtp-Source: AGHT+IH9IlS+z+dGqbcD3ez3KSnN/vsMe9IxoACe08DSlzrmDZs2tjofoGWcXspmvJXSreZx/A9zjw==
X-Received: by 2002:adf:ca90:0:b0:341:66c2:3dbb with SMTP id r16-20020adfca90000000b0034166c23dbbmr1906035wrh.30.1711734715710;
        Fri, 29 Mar 2024 10:51:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b00415509b33c0sm2127781wms.10.2024.03.29.10.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:51:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 Mar 2024 18:51:49 +0100
Subject: [PATCH v2 2/5] dts: meson: Switch GXL, GXM & AXG to using upstream
 DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-u-boot-of-upstream-v2-2-2512ad3eb63d@linaro.org>
References: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
In-Reply-To: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8517;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=j5oJHz601sXvM1gYK9vJjT8ZFX0wEUBNB+5X+Ml0XUs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmBv+2w7E0awpITAtzHq/8epajXEKOhKuYHaF7YWSr
 aMIeGD+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgb/tgAKCRB33NvayMhJ0SCcEA
 DDZpogwH/mY47qFyvXRKJSlOxxyNvDjAUWdO4LTr5w/r5VHLHCtYxR50T6ZIG3SzpD6cObtK9k5vCW
 ZB/s4S2qLLcb2mBkqbXcycAF1uFS9++Yv6Wshxay99T6gnWqGit6Z86k5ox4iUjQNpdVynkNHUe1Nl
 Rp/em6OOp2eCdrLI18qqtqYTV6kGBPsxmOEfXfcJlTttHI1ragWYdN0KvfNnkNS2upFLJIqn6WlGQh
 62/kNLU6YUQK4miIWb9MoV6625mUWbOOjcF4YOA1xwPvuvh+wcdFLd05QyUpB+29rRmmaY/WNwjY+6
 Q82FkXqSdTtSLTJCGAaYlOhvD/vZSQu05P7iH4cXhuVBDcyG2qa4hurovEgrgXHWipfA5fEQNi3lXY
 8/xCJwBd9vEuRkFu+6Zbz2gMBUf3y6n2sJkuDyMGQ5YXKExC4dpM92e3sTVuwGCIil9TOZNEuim/1O
 sDf3F+M9Mk9u1HLAgw1ooL5cH+bP7cBeBm/Do8tK0GBzo96cZRH45zEjTuDhNGtMCQeNRpADj52gU0
 MXpA3sf9raXtI25v2JAElbZTD6bGoY3+mBDJVn5NohTwp4m7OpMo38aoDlaYGgFsMRKt70MlLgOK7s
 +ZZiTSlx2/T8f+Wy+TGb5oWkPPTMtHNbvEqDR5lWjiUjvh6lSt2ib867yFpw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 29 Mar 2024 17:51:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2258

Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

Cc: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Viacheslav Bocharov <adeep@lexina.in>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/Kconfig            | 3 +++
 configs/beelink-gt1-ultimate_defconfig | 2 +-
 configs/jethub_j100_defconfig          | 2 +-
 configs/jethub_j80_defconfig           | 2 +-
 configs/khadas-vim2_defconfig          | 2 +-
 configs/khadas-vim_defconfig           | 2 +-
 configs/libretech-ac_defconfig         | 2 +-
 configs/libretech-cc_defconfig         | 2 +-
 configs/libretech-cc_v2_defconfig      | 2 +-
 configs/libretech-s905d-pc_defconfig   | 2 +-
 configs/libretech-s912-pc_defconfig    | 2 +-
 configs/p212_defconfig                 | 2 +-
 configs/s400_defconfig                 | 2 +-
 configs/wetek-core2_defconfig          | 2 +-
 14 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 95e7b019ce..1d837ae0f3 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -32,18 +32,21 @@ config MESON_GXBB
 config MESON_GXL
 	bool "GXL"
 	select MESON_GX
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S905X/D or S805X
 
 config MESON_GXM
 	bool "GXM"
 	select MESON_GX
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S912
 
 config MESON_AXG
 	bool "AXG"
 	select MESON64_COMMON
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an A113X/D
 
diff --git a/configs/beelink-gt1-ultimate_defconfig b/configs/beelink-gt1-ultimate_defconfig
index 00fdad8544..0e30e13c82 100644
--- a/configs/beelink-gt1-ultimate_defconfig
+++ b/configs/beelink-gt1-ultimate_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-gt1-ultimate"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxm-gt1-ultimate"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXM=y
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
index 863245430a..9de6b4b44d 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -8,7 +8,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-axg-jethome-jethub-j100"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-axg-jethome-jethub-j100"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_AXG=y
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index ca0808f712..85306872f9 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -8,7 +8,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905w-jethome-jethub-j80"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905w-jethome-jethub-j80"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 59ef33723e..50f8b30650 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-khadas-vim2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxm-khadas-vim2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXM=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 5ed7c1a408..ac00e8975e 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-khadas-vim"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905x-khadas-vim"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index f0ab19580c..6ad0457002 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s805x-libretech-ac"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s805x-libretech-ac"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index bb1a37a0cd..beb919ca6e 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-libretech-cc"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905x-libretech-cc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index 8949e240c9..784a269fd5 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-libretech-cc-v2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905x-libretech-cc-v2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index a5dc3115fc..0adc0afdf3 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905d-libretech-pc"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905d-libretech-pc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index 68f462eeff..cbce0cf400 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-s912-libretech-pc"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxm-s912-libretech-pc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXM=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index 6b73607d64..9cf22ca4db 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905x-p212"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905x-p212"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXL=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index 8e22c95f88..d75d296fa0 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-axg-s400"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-axg-s400"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_AXG=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index 01ffb8bbd7..c4b126c2b7 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-wetek-core2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxm-wetek-core2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_GXM=y

-- 
2.34.1


