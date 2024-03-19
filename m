Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C0DC54F7C
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 14:43:10 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.17358.1710859387882693615
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Mar 2024 07:43:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=sCPWFzz9;
 spf=pass (domain: linaro.org, ip: 209.85.221.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34005b5927eso2008489f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 19 Mar 2024 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710859386; x=1711464186; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCEjeORdZrGPyygMQQ7rEIOwx/u2XgJDOvlmELopfjs=;
        b=sCPWFzz9wgZatf8gAz/4cObpOr4pvnkVcTdAmsAmoKZtUEcuAeN64qdTTmT/kdc/M3
         1Y7KpKgjyIKQ/OTUEk7T+Jj0idCXC1cH/+edVnWpul7QtM+3p6SRkLpEBS1wVevHpVUb
         Hstk1coedsccEbjRHLJmcn1ow65gV1Wg8lIXaWXl5/0/7JAqOeM/VY63Kwl7owPCwc8h
         62uvsZ7nrejdGov+pLfTx56xn57Efnamt85nwsptPu1NcSJn6AAENwXxLvnsXABoN8Lo
         T/mGtJ5jYVGHtYj5vPtnsyKQKoMnLfSXeP78PDJoIL+L7nRQlMvviZjbD0P1ixXWWg9R
         CQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710859386; x=1711464186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCEjeORdZrGPyygMQQ7rEIOwx/u2XgJDOvlmELopfjs=;
        b=P0UfC7ZKaES7isTZvzFVl8O5lT5ya1srUxvTkcjI5FgG830qLklNw9XEQn9c8S4DVf
         0U59eTRBAt1z8Qjf/U7JM3+khrClG3rhtaphiiNvERfdI7/RVPrFfeVKVPR1Ex1hTEJr
         O5n/QPzdTvf6XywM1YxSn6FsuBd3iXzo/sSfp4LWRaybooxEAsGmcwHpsjXRgSIGGbpv
         wD8O5WmaCldiiYP3PdCl0/CjWacWLhS4O5y/Gpzg0G6Gu496TaKtWkjqLhYuNXbsdowU
         1RtcC9qoblOXK23AMnZFny8XHx0b1coD/qWGLrHaNf8iT+zDxO9uTYKSmq3+/SoCQyxU
         9/Bg==
X-Gm-Message-State: AOJu0Ywk9bGHG8nCyl5bo8MTYsbS5GgvdjYISSfjPTDJFJE8oCA/xbxG
	RaRyiEXRlaQGfYd49mQiiCKhJe+wr2TOaA3lutgZKjMcuSlxGmt88/y4pHZak+8=
X-Google-Smtp-Source: AGHT+IGi3WdwktqxPA6R9AVH8RATCZXAPtMHOXLPNCcUEYhnJ//LGoDwpm3ZybxxMq+54YxXEzdO/A==
X-Received: by 2002:a5d:4147:0:b0:33e:8c7e:608c with SMTP id c7-20020a5d4147000000b0033e8c7e608cmr10613104wrq.13.1710859386221;
        Tue, 19 Mar 2024 07:43:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033e18421618sm9029036wrb.17.2024.03.19.07.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:43:05 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Mar 2024 15:43:00 +0100
Subject: [PATCH 1/4] dts: meson: Switch GXL, GXM & AXG to using upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-u-boot-of-upstream-v1-1-f82bc9fe69c0@linaro.org>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
In-Reply-To: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8419;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GEYqtt9Thu6VH8wcbXkftdQtC59Uu8TMsWvsstEdmYc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+aR2eA72ZQ6R5Nc1uH9iYmvEbCLBuSr1cNVwJF5s
 fcEydXuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfmkdgAKCRB33NvayMhJ0fvuD/
 46VmLk64gm1tF6WjoOy1CN2rHmnHSGTjnYKJewVQ/R6eLjPsDphajeoERjVuvL+nJl7Y1RHtBYh4Ih
 wiPvx33WNDXyjVJtVAjsczKEUP0I/g9iT7HDwEEcs6IQACHIKJ2FmCeHFA07ob/XcLlgPsDi7hmdND
 3Q3HrzK487xt3YahdTo/fSNYfQXMhIAWCM1td2j7tRgOZUsjHsKJemfolyfJGc2yKfzl1jCbQVt72A
 Gcjzfer2XudUpUAJQqTgAwCekB7p+3+XRB8+9oCjjSVlsFhQM44zQiM4lcyqDeda2dK8bcziCNgfWx
 pStmeKstM4bC0VbHCOf4bGCGAlXxeZ0O71Wq+waExDC4q8CxOvM4nmjppPh1WMS6k7fhk0DBsu/Q2B
 eID6g7SytRbHY9DT3mRlr+ZUrygQ+Z+V8yJlUe9E6nx1a9By807Mc8Itxp1NsNlp7si5ZOYmN90h9X
 MQYXar4IUZ2Apw2hu1/vc2Y7XrW9VCF5huRA6iJktPiwPlniQYOQON1E4AqxOsBVFcPneUMKWLvKeQ
 IKtrlqRd0K14Fgb87lP+0qY+7YUHSz6tcyTA2IL/Mr5KX0DW43QN6N1QXpPrjPr5nHE+iHeCUgdhJd
 f1q3eIQBItZt8pBxUXAN/lFK8DpCCMDamBYPNNDbIJ2CfywhkFLtmZUpED2A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Mar 2024 14:43:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2200

Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

Cc: Sumit Garg <sumit.garg@linaro.org>
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


