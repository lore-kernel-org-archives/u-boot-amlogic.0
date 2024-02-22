Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FA4C54E56
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:58 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web11.9354.1708594679099579543
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Feb 2024 01:37:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ye26wBzV;
 spf=pass (domain: linaro.org, ip: 209.85.167.171, mailfrom: sumit.garg@linaro.org)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c031c24fbeso1093207b6e.3
        for <u-boot-amlogic@groups.io>; Thu, 22 Feb 2024 01:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594678; x=1709199478; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpI+QWYX3hWaVGsYN5+nU+Q+Aptv0+e/nDtrRo/nhwY=;
        b=ye26wBzV+GtQeSRZOxlHfiVRzi1vtU2mkFRatP56TEV+8NA9DjDGqd+Co3kntUaryZ
         Gp4fp34ax9h/qM8RjuX0/xSABHx1PxHCOunQtCWBwzTmdDYmMQ311jTi3w1GkenxR59X
         QX7jZnf6laG8mSIMX7GNRttU5ITdKlpe576pU2Meqw0iikJf5H6FrydiDyQ19V+9sJOg
         943rTb+0mqgC2mUyIH5g0yI54fIUK2dA+RYi45NipTU1+YVnjyzNkbPikoQyb+NhZnfO
         pEckAQQ2q78J2ChClZqccUivZFutw3RXj/2L8gUdremQBgNEDB8Xj2wDVvia/NWK3YF+
         6sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594678; x=1709199478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpI+QWYX3hWaVGsYN5+nU+Q+Aptv0+e/nDtrRo/nhwY=;
        b=GaopCzqQ1RQVJau3S8HDSlNaMVaFdbxNkU23ZSRd1rzChs6tWMYANBXc0zaw9Lme/M
         OW62oF/cPaJVmtNkKB+EuF/pQQsZI4HrS7CD72lAVrhyjmN32xZKSiO5/GYG1zu+VG03
         y04b92g539qdLA/QKjSBdYQz6o1mZnYE8Crrv/ph8atOIWKvOQVhRaoGecwZ0OySPmTT
         utVonihHaRIzWhpBet62qSZy16r5w4wyrGwafPofWNBhgh7pvk8eDHQ1LogRrXkcpPNF
         NvYdN/5bQY8HsrY/ipPTEX4VGolk5XjKi5v19VTMBNPFZjGbCfEGgKCxiqzjAnWd4Lbe
         yAKw==
X-Forwarded-Encrypted: i=1; AJvYcCX9KLfMuiNoiBnG3TEkT56CRLf9q4QeQ+ytVQ0utGzRiJ1ls6K+ZaDqTczeQ/jnUKWNtM0wfGM3AZL2YPPgX3SCcbSUzTf26Sw=
X-Gm-Message-State: AOJu0YxxS1wCp7YubtSji1SjB8m2StGvGMnAQXQuTlOFJvhvg5/gXqs/
	PgvkBv2TCvZpUbgGLRMs4q7zTLj0O3CbJYhkeO0XExTmLemZmmvLX/0crd78lRk=
X-Google-Smtp-Source: AGHT+IHP+r3oGD66/mO+wlMbTHKVpnW5sVpvT05yZ1KDb6VKyqPryURiHTUw2AbcFHck1Ut+VYeLsw==
X-Received: by 2002:aca:1e0c:0:b0:3c0:38d7:e06f with SMTP id m12-20020aca1e0c000000b003c038d7e06fmr16517695oic.59.1708594678392;
        Thu, 22 Feb 2024 01:37:58 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:37:58 -0800 (PST)
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
Subject: [PATCH v6 10/11] dts: meson-gxbb: Switch to using upstream DT
Date: Thu, 22 Feb 2024 15:06:06 +0530
Message-Id: <20240222093607.3085545-11-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 26 Feb 2024 08:49:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2141

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

Changes in v6:
- None

Changes in v5:
- None

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
index d6c890580617..8ddb59161a0d 100644
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
index 41dbf7981f8b..2e1c756bf7a8 100644
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
index 5f9f323e06ea..ce5eaec3cd2a 100644
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
index cd579ef5f142..b69460347954 100644
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
index b2f0a0ccdb4a..dcc1454be16c 100644
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
index 3eda8f14a21b..7a5af234471f 100644
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
index fd92b041e739..85cff73f50f7 100644
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
index b887419a6bab..efdf820165b5 100644
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


