Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.36992.1600673665496943947
 for <u-boot-amlogic@groups.io>;
 Mon, 21 Sep 2020 00:34:25 -0700
Received: by mail-wr1-f67.google.com with SMTP id o5so11565084wrn.13
        for <u-boot-amlogic@groups.io>; Mon, 21 Sep 2020 00:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AFlJUVzfZZoSJnva3bxHcSZ0N6rFWxCWTu2Qt2ogQhY=;
        b=rOpRJ+uxmwJFeRQiJv5sw39M+PmL5KmPNhgfkTAAaVAvfE5SbedDj/xxBHcG4QqUmA
         qGePZ+MCtaiFd3Uo1frs4FhlQP4zxAOfymIF314p+H2W7n/jfvQI4DjVbHhGIKESIlHb
         pdntl3L0dwUfXE6HQk3QiE/zga86spQBT7XGonc9e/mcwM1fGlHhcCCBpsB67C23+0aG
         wDqzUVg2Ud5hhDudvLehzo/qYt3Y3bOnGrYMtxfnvVsJnIHeboAwK2QoRsf0Pmtq8f43
         PTjKGKQgNisQHIV16GJ0g18W2Rc8pkJB/URe2ZaVcb9QbbkZl2aL+tQZbt2kxPyli1eN
         uKxQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 2/4] board: amlogic: add a vim3 specific board support
Date: Mon, 21 Sep 2020 09:34:13 +0200
Message-Id: <20200921073415.24211-3-narmstrong@baylibre.com>
In-Reply-To: <20200921073415.24211-1-narmstrong@baylibre.com>
References: <20200921073415.24211-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, khilman@baylibre.com, nick@khadas.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The VIM3 will need a specific code to enable PCIe if enabled in the MCU,
thus add a specific board support for VIM3 & VIM3L.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
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

