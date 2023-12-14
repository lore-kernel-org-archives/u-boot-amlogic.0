Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003ACC46CD2
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:41:39 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.22570.1702561951532409240
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 05:52:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=gSf8JIxf;
 spf=pass (domain: linaro.org, ip: 209.85.214.169, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d36a6cec69so1531045ad.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 05:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561951; x=1703166751; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmsHndC6oc2FsYxMykcqQqeyLL2RBBp2X/qx9cpH09c=;
        b=gSf8JIxf3j5WxNCS5ubKyVY0PBmV21ebtXNYx7MUBEdynb0jMr6ddoZderQRQEYB3a
         LkGBkZBpdiypNqRZNJkEFOLyTvq2nwv5kCRn0IWvA4d3LQ8Q5Sv3/VitSLSwWqJcKV37
         xHq059Z9XUMjfZRL/gIDiW+Qr/Rj7a3s3jMAH/bYYOvZyxZbGjwrC0HK2TyLXlQMruIq
         5ZbDGovyCqfn9Um7yoDGaFpXi7DQDv2bIfS0dgQD8lSfPRt1fqm3jNYcUeCH4R3rLgR/
         b3bClc7jinZG9i4jcQ6ahAbkTIHupOu3WunMSgjMjx2XgiGsUTEHtncB1Ap3HUpECwfE
         82hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561951; x=1703166751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmsHndC6oc2FsYxMykcqQqeyLL2RBBp2X/qx9cpH09c=;
        b=nSq5YF/rvdzC0V4VxQKVG/U7jS88cpMZv2r04B3H6Y6WVDhvrZEhOUlPujOxtoA1Z8
         jX47oy6nT/JPQLu9+5ouD/N15xZxlqwOrgpxbLQIcdKNjHVfwOEgQI0PIXVG3aZ3VpES
         deaeweA9diHLHEyhDubEzyenM8aZjBFr1yfDsjRJFQmQpgH81J/ICPWJYVYjo0XHYfj2
         d+5Q9EkgLfgxKcswdxTKZAmLV17GTvf1Yi0MVH1e48d+fmBLz48WNzWX3tbWaJs80DLp
         oFvF+NiBvU7AeW8djKUvKAsIQ02zS3KoMEtBEN08luQkWd0UXNEPQBmIhWLskfvMjRwJ
         s84w==
X-Gm-Message-State: AOJu0Yw8AVnW/8YQlWo3+dgX6ficewRGb5O6MuBw5h1BaSVNTkEI8mKA
	8ZAYOc1xBQG0vKH5N3SJEKP+cQ==
X-Google-Smtp-Source: AGHT+IEMCrqGonUZ4acPUktD2yTVN4EF+chGH/YJBCsLrIpXuguJ9NzBne3tAzws31xs/YvoVOBh7w==
X-Received: by 2002:a17:903:2344:b0:1d0:76f4:e41b with SMTP id c4-20020a170903234400b001d076f4e41bmr5316154plh.45.1702561951052;
        Thu, 14 Dec 2023 05:52:31 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:52:30 -0800 (PST)
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
Subject: [PATCH 7/8] dts: meson-gxbb: Switch to using upstream DT
Date: Thu, 14 Dec 2023 19:21:02 +0530
Message-Id: <20231214135103.1606605-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:41:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1923

Although there were still some variations in board DTS files based on
meson-gxbb SoC but I think those were minor differences from upstream
and shouldn't impact boot on these devices.

So switch to upstream DT via mirroring amlogic/ directory from
devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
building DTB from there including *-u-boot.dtsi files from
arch/$(ARCH)/dts/ directory.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/nanopi-k2_defconfig           | 3 ++-
 configs/odroid-c2_defconfig           | 3 ++-
 configs/p200_defconfig                | 3 ++-
 configs/p201_defconfig                | 3 ++-
 configs/videostrong-kii-pro_defconfig | 3 ++-
 configs/wetek-hub_defconfig           | 3 ++-
 configs/wetek-play2_defconfig         | 3 ++-
 dts/arch/arm64/Makefile               | 9 +++++++++
 dts/arch/arm64/amlogic                | 1 +
 9 files changed, 24 insertions(+), 7 deletions(-)
 create mode 120000 dts/arch/arm64/amlogic

diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index 41dbf7981f8..3db296916e9 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-nanopi-k2"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 5f9f323e06e..65857ff478c 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-odroidc2"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-odroidc2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
index cd579ef5f14..c1792db51fd 100644
--- a/configs/p200_defconfig
+++ b/configs/p200_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p200"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/p201_defconfig b/configs/p201_defconfig
index b2f0a0ccdb4..202e1da5bcc 100644
--- a/configs/p201_defconfig
+++ b/configs/p201_defconfig
@@ -7,7 +7,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p201"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p201"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
index 3eda8f14a21..d09333d3b96 100644
--- a/configs/videostrong-kii-pro_defconfig
+++ b/configs/videostrong-kii-pro_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-kii-pro"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-kii-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index fd92b041e73..73f3d4aad5d 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-hub"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index b887419a6ba..26f57b4214a 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-play2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
index 16e9fea622d..d548584cf5c 100644
--- a/dts/arch/arm64/Makefile
+++ b/dts/arch/arm64/Makefile
@@ -1,5 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+dtb-$(CONFIG_ARCH_MESON) += \
+	amlogic/meson-gxbb-kii-pro.dtb \
+	amlogic/meson-gxbb-nanopi-k2.dtb \
+	amlogic/meson-gxbb-odroidc2.dtb \
+	amlogic/meson-gxbb-p200.dtb \
+	amlogic/meson-gxbb-p201.dtb \
+	amlogic/meson-gxbb-wetek-hub.dtb \
+	amlogic/meson-gxbb-wetek-play2.dtb
+
 include $(srctree)/scripts/Makefile.dts
 
 targets += $(dtb-y)
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


