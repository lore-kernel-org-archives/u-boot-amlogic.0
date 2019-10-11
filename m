Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.1860.1570808050069012088
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 08:34:10 -0700
Received: by mail-wm1-f66.google.com with SMTP id v17so10643987wml.4
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8dZo15N2ql1ll8n9iQ6E6Jxrgj6eYJDnK1m8zH1HAlE=;
        b=oqUn9hWqP5a6wB3qAV124x7GvLH3iI57khrekrPpQpRqnZ6MUuiY/HJFgtYtZwKeIn
         4c8CuaBpHb5wb3lT6jvgI6jRTHEJw8CI6asEe4RyZHSVWmXyI5jZBNlENy6il2PvGmmm
         rZbQKyM7rVTEdWLamjz2WLMW53BX95+SFlKNfIQbXaivs1Npku5uSxKnsa0FQQrqLjL5
         GTSGE+ynwiVv3HqCoFCVvyQxULPuq16nZ0nRDnsfTZSZhPaIiERt4MzQHHCDeb9UIGlV
         4KzPmNls/ifCvNn9TqJWB0V3FcmLGVyTk0lYMwPrH3J1WpvMNX/HVOh74LDke3VM1hWJ
         L0iQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 8/8] configs: sei610: Add config file to fix userdata size
Date: Fri, 11 Oct 2019 17:33:58 +0200
Message-Id: <20191011153358.29739-9-narmstrong@baylibre.com>
In-Reply-To: <20191011153358.29739-1-narmstrong@baylibre.com>
References: <20191011153358.29739-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Guillaume La Roque <glaroque@baylibre.com>

Add separate config file to handle the different eMMC size on
the sei610 board.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/sei610/MAINTAINERS |  1 +
 configs/sei610_defconfig         |  2 +-
 include/configs/sei610.h         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 include/configs/sei610.h

diff --git a/board/amlogic/sei610/MAINTAINERS b/board/amlogic/sei610/MAINTAINERS
index 20f12334e9..da77aafa41 100644
--- a/board/amlogic/sei610/MAINTAINERS
+++ b/board/amlogic/sei610/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei610/
 F:	configs/sei610_defconfig
+F:	include/configs/sei610.h
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 89e7bd7bab..520a683d2e 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="sei610"
-CONFIG_SYS_CONFIG_NAME="sei510"
+CONFIG_SYS_CONFIG_NAME="sei610"
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_MESON_G12A=y
diff --git a/include/configs/sei610.h b/include/configs/sei610.h
new file mode 100644
index 0000000000..6d093161c9
--- /dev/null
+++ b/include/configs/sei610.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration for the SEI510
+ *
+ * Copyright (C) 2019 Baylibre, SAS
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
+#define CACHE_UUID "99207ae6-5207-11e9-999e-6f77a3612069;"
+#define SYSTEM_UUID "99f9b7ac-5207-11e9-8507-c3c037e393f3;"
+#define VENDOR_UUID "9d082802-5207-11e9-954c-cbbce08ba108;"
+#define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
+#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
+
+#define PARTS_DEFAULT                                        \
+	"uuid_disk=${uuid_gpt_disk};"  			\
+	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=logo,size=2M,uuid=" LOGO_UUID             \
+	"name=cache,size=256M,uuid=" CACHE_UUID             \
+	"name=system,size=1536M,uuid=" SYSTEM_UUID           \
+	"name=vendor,size=256M,uuid=" VENDOR_UUID            \
+	"name=userdata,size=12795M,uuid=" USERDATA_UUID	\
+	"name=rootfs,size=-,uuid=" ROOT_UUID
+
+#include <configs/meson64_android.h>
+
+#endif /* __CONFIG_H */
-- 
2.22.0

