Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D86C25B10
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 07:50:04 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web11.15548.1714484183962787349
 for <u-boot-amlogic@groups.io>;
 Tue, 30 Apr 2024 06:36:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=O+nbq0Uz;
 spf=pass (domain: konsulko.com, ip: 209.85.219.52, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6a05f376effso44311346d6.0
        for <u-boot-amlogic@groups.io>; Tue, 30 Apr 2024 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1714484183; x=1715088983; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbX8GeaFiNipVI/fYWdsXyYLEA12+fFJYFLjDYUzlqQ=;
        b=O+nbq0UzhD7EzXwEFYZLpDTL1PiklTuINnSDPYpHOC82n7fJeqUBXG6cAte2Q3hHfR
         F4tsPcljlWPINuZmysxsCJKfKzbc7IdpoZKV3lr8WuJYcDzpgQiG/TbAxmZJdl97mOVl
         n8+4ohiUwZ9cB33UE7XPanG45IjLhqOMNKtmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714484183; x=1715088983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbX8GeaFiNipVI/fYWdsXyYLEA12+fFJYFLjDYUzlqQ=;
        b=pMrrIKA3OH2MR9Y5kLXaPMBonLhIcUxb+FYkEtsNqW5O/J1ZsKtXc9dNly7xwlomym
         ztoAlM3QCMa7VUiau4s5g9Gj5YYpJIVtSz/2gmGvUZ5qgiwE8LAkHne4PBaRCvMybx3U
         izBouzeHA07LuPzIex9rqgkFor/YtMJCIUCDsFzS54ZWPfwcpdDe7Tfl1B7wNqqcvisl
         Ci2PgorxT8yNxjEV+xWQixptUyQurU3kEHkTfbctm7QQ9TVUgD5BB5QTOAk/CixBg1PS
         kdEtiUpyFZjGWNubeI3hYFapDu8ng5Rkp7v8EQwYX3fkIYLao4D1VuqjucF5ftcQ1+9D
         Er4A==
X-Forwarded-Encrypted: i=1; AJvYcCUHkEF6GHySqf437lu9j9qVfBLbIQXmx8NwJzm55eFr0WZVb9bpwwZ4681sEb4H0KbUEbOgKBJ7d7Uq1Dbo1loWLt5xA0kjIpw=
X-Gm-Message-State: AOJu0YyDowgiAk98paki9Yn0sBDBwfifRoHU5ltm2Q0TQh4tCeAu4/wK
	b7HYC6rLZ2rJLXnSF5ifd10U8nIKUc1eWGFow4no6qXLYhvy08SRFDZ7Rm+T3IurKerFe1hF3Cd
	7ejFq6w==
X-Google-Smtp-Source: AGHT+IEA6oGyhT8GQXLPXKMnvXwRdPNApsCvvUkrzVG0Q9GQVFMXwR8dr9el8bPfGgfjSTi/yTLR4A==
X-Received: by 2002:a05:6214:5093:b0:6a0:d3ef:2a7e with SMTP id kk19-20020a056214509300b006a0d3ef2a7emr5949200qvb.61.1714484182982;
        Tue, 30 Apr 2024 06:36:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
        by smtp.gmail.com with ESMTPSA id f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:36:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io
Subject: [PATCH 19/33] arm: meson: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:45 -0600
Message-Id: <20240430133559.1836389-19-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 02 May 2024 07:50:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2284

Remove <common.h> from all mach-meson files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io
---
 arch/arm/mach-meson/board-a1.c     | 2 +-
 arch/arm/mach-meson/board-axg.c    | 1 -
 arch/arm/mach-meson/board-common.c | 1 -
 arch/arm/mach-meson/board-g12a.c   | 1 -
 arch/arm/mach-meson/board-gx.c     | 1 -
 arch/arm/mach-meson/board-info.c   | 1 -
 arch/arm/mach-meson/sm.c           | 1 -
 7 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.c
index 967bb671822e..f848c0f068ed 100644
--- a/arch/arm/mach-meson/board-a1.c
+++ b/arch/arm/mach-meson/board-a1.c
@@ -3,12 +3,12 @@
  * (C) Copyright 2023 SberDevices, Inc.
  */
 
-#include <common.h>
 #include <asm/arch/a1.h>
 #include <asm/arch/boot.h>
 #include <asm/armv8/mmu.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
+#include <linux/errno.h>
 #include <linux/sizes.h>
 
 phys_size_t get_effective_memsize(void)
diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
index fdf18752cdd0..6535539184cc 100644
--- a/arch/arm/mach-meson/board-axg.c
+++ b/arch/arm/mach-meson/board-axg.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/boot.h>
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 7ceba7cede85..39774c43049a 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <fastboot.h>
 #include <init.h>
diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index d5a830fb1db8..dc4abe1e1074 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <net.h>
diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index c3fbdfffeae8..0370ed57e205 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/boot.h>
diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index d51d9b8f0645..b4058f593234 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2019 Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 914fd11c9894..4d9f83d3b38d 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -5,7 +5,6 @@
  * Secure monitor calls.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <regmap.h>
-- 
2.34.1


