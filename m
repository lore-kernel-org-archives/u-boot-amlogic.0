Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C3C54E5D
	for <webhook@archiver.kernel.org>; Sat, 16 Mar 2024 13:54:39 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.7040.1710597278157357892
 for <u-boot-amlogic@groups.io>;
 Sat, 16 Mar 2024 06:54:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i+/YSqu/;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: christianshewitt@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4140a259a54so551705e9.0
        for <u-boot-amlogic@groups.io>; Sat, 16 Mar 2024 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710597276; x=1711202076; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze781fdYMJC8X6yPwfz4FQS/isO5gR11eLckzIKPCfI=;
        b=i+/YSqu/JYqAdYb1rxMv9X0QdL2Ef4sT765oZJYp8QsGCHpc3lBFUVs83jyJSUHrRA
         HdP+IhNNQr4otZkNfGoHqlo6Y26ruxXknrj2GWdxjkc6csuELeAHydf6DMlggGPi3VIv
         X+rS4YqWSGXOp664iERecnFF56GpAEOQL+wSDrDoniUt5M7U46lW2XsSfxOoHMTr891u
         40cfdDEn3sCC2C1+VvuaUTzcxKnhjLOYg27Ruq8mnaVIl4p63a8q9/S9r8PS5DDkKKj4
         0apR0VPN81ZNt/sfz6o3dY/KNAVnfcmKC2io6qgAZK6AcYuR2c9RxTTrAQdY9CCiUKC5
         ynlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710597276; x=1711202076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze781fdYMJC8X6yPwfz4FQS/isO5gR11eLckzIKPCfI=;
        b=UDN2IcsYdUbOmFyYO6yWxJJiWmt+mQMT8YJasBSjaZPooPjDbjZiXoIJPll/UDFOX5
         pC86eTYVFNDYphF3oBaBhfHuHPvRPZ2ROBVfyegCUtQNDIfJW7hnGcSHSYAxYkHP7dsU
         0b3xXk2UH7ZD3jfUZTaLuzdzd04I4jgguS5renFD6Gsn6zEAE8KlrFuTtR2AHYF5MJLl
         /dzpK87kmtE24IDvpIa6XoJHvpMg13VELmRQDwsFfK4+y8kX6bpvYISaLACIranJ8CFp
         C9jLvGG2B40OzjkUNYVUcw8jpG7pCnpsKL/zjy7ZM3bvh5CpkRo3xB/8J2pYCI1RrZwa
         fI+g==
X-Forwarded-Encrypted: i=1; AJvYcCWgOO918DIAATyl5yOUj1sFNgFj3X/coJg/HNfPLaFrcLmTEGOTuYDxsCZdicGYPCdiizcRP7mB7U9LJ5enWo0n2tIXS1Ayhio=
X-Gm-Message-State: AOJu0YzIvRYL7Oi7E8o5xpyQq9ZIyumeBZryfvjDH7yl4HLxwcOF0kem
	xahS12Dz1sa9mK6EvxUoxp6IX4TmCpjMjrKABBOapiljRtrWkHX7Xu6wJKDP24A=
X-Google-Smtp-Source: AGHT+IEBXJ+LDSb8yez8jw+oMX7DHpcrqiZApeJ2kmzGEWKJQ5sNvM+K+W2hgSajgULIqDUK/wrA+A==
X-Received: by 2002:a05:600c:1f8c:b0:413:f2c6:df3d with SMTP id je12-20020a05600c1f8c00b00413f2c6df3dmr4290047wmb.13.1710597276625;
        Sat, 16 Mar 2024 06:54:36 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041409fa57c4sm523963wmq.34.2024.03.16.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 06:54:36 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/3] ARM: dts: fix Ethernet on WeTek Hub/Play2
Date: Sat, 16 Mar 2024 13:54:28 +0000
Message-Id: <20240316135430.826898-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316135430.826898-1-christianshewitt@gmail.com>
References: <20240316135430.826898-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 16 Mar 2024 13:54:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2193

Placing the snps,reset content needed for Ethernet to probe in a common
uboot.dtsi results in the content not being used and broken Ethernet. Fix
this by creating two board specific dtsi files with the right content.

Fixes: 67d5128df950 ("ARM: dts: add support for WeTek Hub and WeTek Play2")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 ...u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} |  0
 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi     | 13 +++++++++++++
 2 files changed, 13 insertions(+)
 rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi

diff --git a/arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi
rename to arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
diff --git a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
new file mode 100644
index 00000000000..3743053eb9c
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
+
+&ethmac {
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
-- 
2.34.1


