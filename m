Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web11.9057.1592491244361574221
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Jun 2020 07:40:44 -0700
Received: by mail-wr1-f65.google.com with SMTP id l11so6353873wru.0
        for <u-boot-amlogic@groups.io>; Thu, 18 Jun 2020 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MBZQhWY9QYuPOI13VuSlWNDpNn8l6ZkZ9KForLNtfM=;
        b=wmADG28f1Pbe/l2WIZcOGeWMCUrUzX0vatKqXNoOoDsqIUdiKlH14RUnmOqVyJhkyr
         bvzH7gCPP+7JumQcWlZ+XqT7A4ST03f6j0ph7rwUv+wBqYSrTx9PRF/PW+njTo35Syc9
         ZTiHiuFEicm4qdqtszoiyeK41I2zO+3mqPrJ71rYhb4HqJHQdtMyulTfuY+NW+NWdKOD
         Pv0I8xr2iqOBfT1kIo1OXBHuqHGLtd3kw6pdxr4V2Nu0t4/dmthBvTcUHlKDBK/WjImN
         Zvb1cCsGAm8rx5KKLsOMp9aJokMO4IkIngVH0Gg4NRsfRhpshOtvKt5nDOqt5GwAJ9tM
         ZX8Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] board: amlogic: Add Odroid-N2 board support
Date: Thu, 18 Jun 2020 16:40:37 +0200
Message-Id: <20200618144037.23392-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Pascal Vizeli <pvizeli@syshack.ch>, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Pascal Vizeli <pvizeli@syshack.ch>

Add a proper Odroid-N2 board support to handle the Ethernet MAC
address stored in the in-SoC eFuses.

Signed-off-by: Pascal Vizeli <pvizeli@syshack.ch>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/odroid-n2/MAINTAINERS |  7 +++++
 board/amlogic/odroid-n2/Makefile    |  6 ++++
 board/amlogic/odroid-n2/odroid-n2.c | 49 +++++++++++++++++++++++++++++
 board/amlogic/w400/MAINTAINERS      |  2 --
 configs/odroid-n2_defconfig         |  2 +-
 5 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 board/amlogic/odroid-n2/MAINTAINERS
 create mode 100644 board/amlogic/odroid-n2/Makefile
 create mode 100644 board/amlogic/odroid-n2/odroid-n2.c

diff --git a/board/amlogic/odroid-n2/MAINTAINERS b/board/amlogic/odroid-n2/MAINTAINERS
new file mode 100644
index 0000000000..5627e54058
--- /dev/null
+++ b/board/amlogic/odroid-n2/MAINTAINERS
@@ -0,0 +1,7 @@
+ODROID-N2
+M:	Neil Armstrong <narmstrong@baylibre.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/odroid-n2/
+F:	configs/odroid-n2_defconfig
+F:	doc/board/amlogic/odroid-n2.rst
diff --git a/board/amlogic/odroid-n2/Makefile b/board/amlogic/odroid-n2/Makefile
new file mode 100644
index 0000000000..68e4e2a828
--- /dev/null
+++ b/board/amlogic/odroid-n2/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2020 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= odroid-n2.o
diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
new file mode 100644
index 0000000000..caf7fd6810
--- /dev/null
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <env.h>
+#include <init.h>
+#include <net.h>
+#include <asm/io.h>
+#include <asm/arch/sm.h>
+#include <asm/arch/eth.h>
+
+#define EFUSE_MAC_OFFSET	20
+#define EFUSE_MAC_SIZE		12
+#define MAC_ADDR_LEN		6
+
+int misc_init_r(void)
+{
+	u8 mac_addr[MAC_ADDR_LEN];
+	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
+	ssize_t len;
+
+	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
+
+	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
+		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
+					  efuse_mac_addr, EFUSE_MAC_SIZE);
+		if (len != EFUSE_MAC_SIZE)
+			return 0;
+
+		/* MAC is stored in ASCII format, 1bytes = 2characters */
+		for (int i = 0; i < 6; i++) {
+			tmp[0] = efuse_mac_addr[i * 2];
+			tmp[1] = efuse_mac_addr[i * 2 + 1];
+			tmp[2] = '\0';
+			mac_addr[i] = simple_strtoul(tmp, NULL, 16);
+		}
+
+		if (is_valid_ethaddr(mac_addr))
+			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
+	}
+
+	return 0;
+}
diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
index 5e837cfaef..a1b0ac8636 100644
--- a/board/amlogic/w400/MAINTAINERS
+++ b/board/amlogic/w400/MAINTAINERS
@@ -5,8 +5,6 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/w400/
 F:	configs/khadas-vim3_defconfig
 F:	configs/khadas-vim3l_defconfig
-F:	configs/odroid-n2_defconfig
 F:	doc/board/amlogic/w400.rst
 F:	doc/board/amlogic/khadas-vim3.rst
 F:	doc/board/amlogic/khadas-vim3l.rst
-F:	doc/board/amlogic/odroid-n2.rst
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index e0cc6e3729..063809416e 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -1,5 +1,5 @@
 CONFIG_ARM=y
-CONFIG_SYS_BOARD="w400"
+CONFIG_SYS_BOARD="odroid-n2"
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_ENV_SIZE=0x2000
-- 
2.22.0

