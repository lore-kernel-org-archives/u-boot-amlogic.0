Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.9031.1600421356219251277
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Sep 2020 02:29:16 -0700
Received: by mail-wr1-f66.google.com with SMTP id w5so4888374wrp.8
        for <u-boot-amlogic@groups.io>; Fri, 18 Sep 2020 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/6Y4DDLOtHxqlJgZSUeGpsOpSYzE7SglRW3ojmiskA=;
        b=zbrBFc2z4msadZ/xmtGRgVB/g8akGKDV+mc8uBomWAFWmdOIIZQBOP2qQB4L/zeybQ
         tS52Ti9vreBOBEXQfXjk6MYKebd7H2G7e4quJ7vDCiAs3S+20KEyPvzKRRCwixPx+kG8
         4ALWtrgQDxn3+v/S3IASyfjQwiuN92U88dXSipnw42rFeQPMrpHU4H1Y1rwO/kQzrgZC
         CSVVSmNt5FaKFB4dYm0UvvpXrkwipcqUBSxYNVPC/a0q8XH5lndnAXIaELNTRNqIwHjq
         K8+EMsasPOg+G1K1+8OjCnUZVPOxY9CZrZpGVz3vJIRKCRz75li6J5ewNw52xMH9Y9rZ
         bdXw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/4] board: amlogic: add a vim3 specific board support
Date: Fri, 18 Sep 2020 11:29:00 +0200
Message-Id: <20200918092902.28028-3-narmstrong@baylibre.com>
In-Reply-To: <20200918092902.28028-1-narmstrong@baylibre.com>
References: <20200918092902.28028-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, khilman@baylibre.com, nick@khadas.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The VIM3 will need a specific code to enable PCIe if enabled in the MCU,
thus add a specific board support for VIM3 & VIM3L.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/vim3/MAINTAINERS |  9 +++++++++
 board/amlogic/vim3/Makefile    |  6 ++++++
 board/amlogic/vim3/vim3.c      | 20 ++++++++++++++++++++
 board/amlogic/w400/MAINTAINERS |  4 ----
 4 files changed, 35 insertions(+), 4 deletions(-)
 create mode 100644 board/amlogic/vim3/MAINTAINERS
 create mode 100644 board/amlogic/vim3/Makefile
 create mode 100644 board/amlogic/vim3/vim3.c

diff --git a/board/amlogic/vim3/MAINTAINERS b/board/amlogic/vim3/MAINTAINERS
new file mode 100644
index 0000000000..92b426f66d
--- /dev/null
+++ b/board/amlogic/vim3/MAINTAINERS
@@ -0,0 +1,9 @@
+VIM3
+M:	Neil Armstrong <narmstrong@baylibre.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/vim3/
+F:	configs/khadas-vim3_defconfig
+F:	configs/khadas-vim3l_defconfig
+F:	doc/board/amlogic/khadas-vim3.rst
+F:	doc/board/amlogic/khadas-vim3l.rst
diff --git a/board/amlogic/vim3/Makefile b/board/amlogic/vim3/Makefile
new file mode 100644
index 0000000000..c515077302
--- /dev/null
+++ b/board/amlogic/vim3/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2020 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= vim3.o
diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
new file mode 100644
index 0000000000..02d8cd0ce0
--- /dev/null
+++ b/board/amlogic/vim3/vim3.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <env_internal.h>
+#include <init.h>
+#include <net.h>
+#include <asm/io.h>
+#include <asm/arch/eth.h>
+
+int misc_init_r(void)
+{
+	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
+
+	return 0;
+}
diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
index a1b0ac8636..991590d9f2 100644
--- a/board/amlogic/w400/MAINTAINERS
+++ b/board/amlogic/w400/MAINTAINERS
@@ -3,8 +3,4 @@ M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/w400/
-F:	configs/khadas-vim3_defconfig
-F:	configs/khadas-vim3l_defconfig
 F:	doc/board/amlogic/w400.rst
-F:	doc/board/amlogic/khadas-vim3.rst
-F:	doc/board/amlogic/khadas-vim3l.rst
-- 
2.22.0

