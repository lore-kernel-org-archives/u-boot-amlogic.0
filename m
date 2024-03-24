Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0704CD11DB
	for <webhook@archiver.kernel.org>; Sun, 24 Mar 2024 15:19:15 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.31248.1711293553218859487
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Mar 2024 08:19:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZhJ1bbrR;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: christianshewitt@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so4129475a12.2
        for <u-boot-amlogic@groups.io>; Sun, 24 Mar 2024 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711293551; x=1711898351; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze781fdYMJC8X6yPwfz4FQS/isO5gR11eLckzIKPCfI=;
        b=ZhJ1bbrRIgnCSZx9wy5fsyzJgiixG76sgxLf4o5yBNX7sSaVTjwftHUIuMc1C1VL7D
         WZTlVXufd7wC7l/08gjfaCxxWHLfwvgVY1r104jzL8j9b0xWZsZULz5jivwYs4Gm+YKI
         l1bzMH/f3Fkd63ff/FL1ivge44vE2JrrdudhPYqvRzrW0RCnfzMkTqhKYyPDA3lgIC2n
         Wmr47pSZPi6rtBA8LDJtBQ2ZjuZClWkDCyScPOhoZPUKfmrSuadpUBP0RplW6qtOH9tn
         nLKdbyTyiOwAYUp5g/rmK13aKtKq5bzJTdNQ1dudFgIqvsPmn6xTmQ8B/26dK+Evs5OV
         08hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711293551; x=1711898351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze781fdYMJC8X6yPwfz4FQS/isO5gR11eLckzIKPCfI=;
        b=GIMoz8+mGzU/dgAljGLvlTIyuOKpllyNVwBWqvURi78gjWHytQ+G8hV86fVZcdKToy
         6kSu85qcpSbufwr3Mnbnih0o8ADSMjkHz9n2i571/3Fjg/WeV4BrDoBMCwGITgV5NiK8
         f+IYuNoRC4UAVSEohSY6xh9Zmv8Xm664jDrErOr/yDi1TUUzyfFPL1J+76DOdwtsKGPu
         VCA6YzgedN7cglMGyMOaph/ypm2u8MepNMklS1cMgcMHJOJzPiGtfWYyHHLata9QuymR
         S0aOhzGNSjRBWSFrBmf9HO5/1AE0qVIKKgjItGRDjWchaGNcVJ8CgAWN3Bb79NEYIgvx
         JNHA==
X-Forwarded-Encrypted: i=1; AJvYcCXkiIBO/PBQw47rGWqHgiujnbK8AjqmSsdMiEYOtv/ZPRyQ0aaI8aeqO/M6Npc+BcCmJhJSC3RMlDb1CHQJujkz0tXPOLqe78I=
X-Gm-Message-State: AOJu0Yx507mhTjzZtNvzhbTOgj+oGMA9803RhCyOG+4kxpZH3TpBd5e4
	neJhMogRU3TVqZ9FpEBr5OdM5kz5ETVxvYPRg6O79BSHY0ITl8CA
X-Google-Smtp-Source: AGHT+IGWop+tRdvatwhyMLUo6vB2OpRCupGJ56dqduh0sfpCfS2PruM3icraWlMqlzpjp74V6KKbQQ==
X-Received: by 2002:a50:d594:0:b0:56b:902e:b144 with SMTP id v20-20020a50d594000000b0056b902eb144mr2966510edi.12.1711293551532;
        Sun, 24 Mar 2024 08:19:11 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7c7da000000b0056bf34d656dsm1996114eds.29.2024.03.24.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 08:19:11 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/2] ARM: dts: fix Ethernet on WeTek Hub/Play2
Date: Sun, 24 Mar 2024 15:19:04 +0000
Message-Id: <20240324151905.3817732-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324151905.3817732-1-christianshewitt@gmail.com>
References: <20240324151905.3817732-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 24 Mar 2024 15:19:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2240

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


