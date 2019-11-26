Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
 by mx.groups.io with SMTP id smtpd.web10.3584.1574802737748112169
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2019 13:12:17 -0800
Received: by mail-pg1-f193.google.com with SMTP id i5so1346956pgj.9
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2019 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9u6hfyFxBExH0vpMdVnVWr/5OqckcxU17J3z35GQGmQ=;
        b=SnR7wiWQyWZQlzzE6jQ3DtJ0kAiCMyMmV5AVei0LXBkrn3SKSkDWbm0NZIllWoovUY
         pSmf4rRIFr+SsbjS01M+f88yDdWckOQ0oSDzcfSFMs/je+VMNpD5HIAa7go1xCxnh1JJ
         HqCdbUiSFun24zDH6ljlY2jGN5HtIP+ucAOtnbLxmq9Xj3B4tfrDRYrQXkMpRocgpR3n
         zdFlOwXH7Srm1u2qRAh43eCWN1qAQEiNRlXeJ93+HA013xXjMhpJpiSyeTdY5QZc3qCG
         A8sBihyc+JT3NzaZL22oWGCi2nJ7JmzR9bisZXtxmtTZuVON9w5awleySLOw7qgLPF3Z
         WaRA==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCH 2/4] configs: meson64: enable GIC support for G12A/G12B
Date: Tue, 26 Nov 2019 21:12:04 +0000
Message-Id: <20191126211206.4537-3-linux.amoon@gmail.com>
In-Reply-To: <20191126211206.4537-1-linux.amoon@gmail.com>
References: <20191126211206.4537-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Enable GIC support for G12A/G12B platform.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 include/configs/meson64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 736081277d..50707a3197 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -8,7 +8,7 @@
 #define __MESON64_CONFIG_H
 
 /* Generic Interrupt Controller Definitions */
-#if defined(CONFIG_MESON_AXG)
+#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
 #define GICD_BASE			0xffc01000
 #define GICC_BASE			0xffc02000
 #else /* MESON GXL and GXBB */
-- 
2.24.0

