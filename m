Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E1C47DB7
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.121683.1703764764243833769
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 03:59:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ec4SOaQc;
 spf=pass (domain: linaro.org, ip: 209.85.215.176, mailfrom: sumit.garg@linaro.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so1675803a12.3
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 03:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703764763; x=1704369563; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRa24nieggPUU/gxVv7l19ecxHbCFdXumOWZ0Q+D7RI=;
        b=ec4SOaQcyTCQIpTYP2TR8M+eXypcytIWitqZnHK2Oy1t/pOQbZt3ZZJqNDvPgAmakC
         prQEwAdWwnxbYVOT6Pm4iBKxuZZ+HK7z2NgkvNcZGDSGDSwBF6dYmHetBSI9S75prtID
         tsa5/+ubCAI1bSU98RmVo8OjWENP5COT+ahLoBbDXTosqi/sD/A0p2XwCCArv1IOY0um
         p7F+ATATYmgXqIypzlqTEj2mMLO8kTaAivZXwWuvP0mrYpZwYT9ebx3TNo+ELhm63V2P
         gVF7P5Mdy44yexjaUkwAKP+0lb8sSaD/Ay+iY2KTPmvi36dKNL1KgtIt1AsByNhzd4nK
         M9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764763; x=1704369563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRa24nieggPUU/gxVv7l19ecxHbCFdXumOWZ0Q+D7RI=;
        b=T8oq+gyTHvkYi+sRNTQicgZsGWsLjeVQmJavHBVwCdAiuP1wF7GTfH7y5J/TYw4PgC
         lPdU2FbeXvAXDA9eD8p+KDgYEx+LMydK68cMrFjxzyEFBv554TSYLiHMP8nr4+Q5NZqM
         fJtnYJTNJI76fPKAlkyZkCNse+OoIQcitgxTa3nNiNHvmi8bT5EasWwI/ETSAG2LAISy
         xNLexJ1HqErHvhBM3f55eH8nMohCl9cRMJKbdMVa3MBOiB3FJf3ihyQ4M19dE4LbSLm6
         mDTxUNlMMqHEThsgOASECvT5QLtHUJPsYgazXuBff3ht3PVgaykpkPvfnaOUtP6QUL3y
         VICQ==
X-Gm-Message-State: AOJu0Yz7Vei+mcQn2RWHVGk+rC6pSeDJ9y2BdaUNC/ln3kRHeeamujTl
	EEEboBKpKumOVzYz/o+1boW1xTxNtTSKzg==
X-Google-Smtp-Source: AGHT+IFoj9Tz8c1MeGJJaAJxbFs9PUAvg7SjbF8ojRZ//Fj/cD2r6pq4R72l70FurlRyZGXfD4bXhw==
X-Received: by 2002:a17:902:c406:b0:1d3:fa3f:668a with SMTP id k6-20020a170902c40600b001d3fa3f668amr6012928plk.58.1703764763708;
        Thu, 28 Dec 2023 03:59:23 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:59:23 -0800 (PST)
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
Subject: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
Date: Thu, 28 Dec 2023 17:28:03 +0530
Message-Id: <20231228115804.3626579-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1987

Although there were still some variations in board DTS files based on
meson-gxbb SoC but I think those were minor differences from upstream
and shouldn't impact boot on these devices.

So switch to upstream DT via mirroring amlogic/ directory from
devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
building DTB from there including *-u-boot.dtsi files from
arch/$(ARCH)/dts/ directory.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.

Changes in v2:
--------------
- Picked up review tag

 arch/arm/mach-meson/Kconfig           | 1 +
 configs/nanopi-k2_defconfig           | 2 +-
 configs/odroid-c2_defconfig           | 2 +-
 configs/p200_defconfig                | 2 +-
 configs/p201_defconfig                | 2 +-
 configs/videostrong-kii-pro_defconfig | 2 +-
 configs/wetek-hub_defconfig           | 2 +-
 configs/wetek-play2_defconfig         | 2 +-
 dts/arch/arm64/amlogic                | 1 +
 9 files changed, 9 insertions(+), 7 deletions(-)
 create mode 120000 dts/arch/arm64/amlogic

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index d6c89058061..8ddb59161a0 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -25,6 +25,7 @@ choice
 config MESON_GXBB
 	bool "GXBB"
 	select MESON_GX
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S905
 
diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index 41dbf7981f8..2e1c756bf7a 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-nanopi-k2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 5f9f323e06e..ce5eaec3cd2 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-odroidc2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-odroidc2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
index cd579ef5f14..b6946034795 100644
--- a/configs/p200_defconfig
+++ b/configs/p200_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p200"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/p201_defconfig b/configs/p201_defconfig
index b2f0a0ccdb4..dcc1454be16 100644
--- a/configs/p201_defconfig
+++ b/configs/p201_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p201"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p201"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
index 3eda8f14a21..7a5af234471 100644
--- a/configs/videostrong-kii-pro_defconfig
+++ b/configs/videostrong-kii-pro_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-kii-pro"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-kii-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index fd92b041e73..85cff73f50f 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-hub"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index b887419a6ba..efdf820165b 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-play2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/dts/arch/arm64/amlogic b/dts/arch/arm64/amlogic
new file mode 120000
index 00000000000..73f7c3e7bd0
--- /dev/null
+++ b/dts/arch/arm64/amlogic
@@ -0,0 +1 @@
+../../../devicetree-rebasing/src/arm64/amlogic/
\ No newline at end of file
-- 
2.34.1


