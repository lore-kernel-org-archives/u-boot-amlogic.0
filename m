Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85806C47DA9
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.8921.1704883049146382927
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:37:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Tg6WyUYO;
 spf=pass (domain: linaro.org, ip: 209.85.214.175, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso31850795ad.3
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883048; x=1705487848; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4d7fzUJlqniGeCnJ6QurzpG1gFkRj1dkkJC15SbKnQ=;
        b=Tg6WyUYOcBYdXeKA/cSwmEkafFwf/ljtCGCn9P04iSG6kiBsR/WPBuhPqC0Y9CjwEh
         +kSOtiz5fLV/DmRGJx6RDeedE2l2lbhF+AHYFdAV4PT2oHa46CkrNlVF/2Z7YE+mTryT
         mVWI4c9bWEGaC7CSwPK0M5+W3ANSSSxlmHH3/yAIfFJI1BrAb9x/3N3e6OSxrhZWJIjz
         bG7q25kLDT58HOFribSMggKTWj0GZ4rUHP3j3NbeqJvo+NduzYasfliQcdi5B90Qichw
         ybfLT0M5iXZcErdssnAMas9i2rhlRxRkvLJRdemcnx+vrZodZWrvYLSTUykXc9Ucmght
         rEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883048; x=1705487848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4d7fzUJlqniGeCnJ6QurzpG1gFkRj1dkkJC15SbKnQ=;
        b=mA4jCwfY/2EogG3P1Igglh4yV9Rp0CcPEP0v1GUi5TKDRYUPtPBwwAwaLsFsDZQL84
         ySLMnQUg6P80NhVLZodujEEi0xPyxmAy+EmUP8lHLA8s0IM8HAzpCeXE0KlExtDG+HLs
         D5o/8mXJ7PeB24V3LbxbTS+7GdqTdYRUkJg4M+gk77pl8FkxwCAS9N7miD4Ts7ezednr
         JuUwJbPzHv0P0ddRZJcUCR09YaFYhRaHsI3clQMTaZE8rhCh4MWq1RQtH1nI2UNter6Y
         8N9VCx6tIGa0wOTlOZTIr37sC8hRelLp0GBht9axvTHqR3AmbrO7Us4uq31ZLHYoKAAK
         5smA==
X-Gm-Message-State: AOJu0Yw8rlB8TVqQzuY8XOzkIvAd0Sb+nbwNOcLygrXl5too1BQCe5l8
	Yv/Kz8TiRJp5+V/bTuZ2MAdOnPWqU7PY4Q==
X-Google-Smtp-Source: AGHT+IHg+0wEEC91lYzFbGvPoXbafkrIHUNcorxba6/DPZgGgnqUM6HPJCpm73B6hCREMJAziTqwCQ==
X-Received: by 2002:a17:902:eb88:b0:1d2:fa04:7cb7 with SMTP id q8-20020a170902eb8800b001d2fa047cb7mr924025plg.5.1704883048686;
        Wed, 10 Jan 2024 02:37:28 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:37:28 -0800 (PST)
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
Subject: [PATCH v4 10/11] dts: meson-gxbb: Switch to using upstream DT
Date: Wed, 10 Jan 2024 16:05:46 +0530
Message-Id: <20240110103547.719757-11-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2067

Although there were still some variations in board DTS files based on
meson-gxbb SoC but I think those were minor differences from upstream
and shouldn't impact boot on these devices.

So enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Picked up review tag

Changes in v3:
- Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.

Changes in v2:
- Picked up review tag

 arch/arm/mach-meson/Kconfig           | 1 +
 configs/nanopi-k2_defconfig           | 2 +-
 configs/odroid-c2_defconfig           | 2 +-
 configs/p200_defconfig                | 2 +-
 configs/p201_defconfig                | 2 +-
 configs/videostrong-kii-pro_defconfig | 2 +-
 configs/wetek-hub_defconfig           | 2 +-
 configs/wetek-play2_defconfig         | 2 +-
 8 files changed, 8 insertions(+), 7 deletions(-)

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
-- 
2.34.1


