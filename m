Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web09.7269.1608281154154950613
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 00:45:54 -0800
Received: by mail-wm1-f53.google.com with SMTP id v14so1523299wml.1
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 00:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kO0SEr0e7/YgXMDhjyfe6vSCO5fzXt1gZ/t1f3mLQV0=;
        b=WqxjakuK8YxhSR6hhosZmHP/lUbp5aYDaSrm0+tzK5U5DSfW+errtZts6RecKCfTr1
         yXBcwrc4EtFfKVUx6FukLfN+n/KDfVf1NRipWMukkLrXkQtzFh90KUCUFtdEWNf5yoWj
         vydYsXhYdlAX8VOt2X/HOVJ2F2ThGEAfjRC7kXpbr6ndpuw2BJBSFHTPFtfy2cIeKAfa
         ipn/pPln1kBM171rjCkSU6Sjduy/XEe3KcVWZwsGYmlSzEMdIFSnrWLuS53qZLMwcvbI
         7u1yvH2B8Pt++moCxqcfj1ATnlNZNzmrv7CMVEC4mA+YNq4FhVgPpExk3FVBhFg42KiX
         8QNQ==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/5] boards: amlogic: add Beelink S922X board family support
Date: Fri, 18 Dec 2020 08:45:42 +0000
Message-Id: <20201218084545.29135-3-christianshewitt@gmail.com>
In-Reply-To: <20201218084545.29135-1-christianshewitt@gmail.com>
References: <20201218084545.29135-1-christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Copied from Odroid N2. Add myself as maintainer.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/beelink-s922x/MAINTAINERS     |  9 ++++
 board/amlogic/beelink-s922x/Makefile        |  6 +++
 board/amlogic/beelink-s922x/beelink-s922x.c | 54 +++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 board/amlogic/beelink-s922x/MAINTAINERS
 create mode 100644 board/amlogic/beelink-s922x/Makefile
 create mode 100644 board/amlogic/beelink-s922x/beelink-s922x.c

diff --git a/board/amlogic/beelink-s922x/MAINTAINERS b/board/amlogic/beelink-s922x/MAINTAINERS
new file mode 100644
index 0000000000..7f223df4ae
--- /dev/null
+++ b/board/amlogic/beelink-s922x/MAINTAINERS
@@ -0,0 +1,9 @@
+BEELINK-S922X
+M:	Christian Hewitt <christianshewitt@gmail.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/beelink-s922x/
+F:	configs/beelink-gtking_defconfig
+F:	configs/beelink-gtkingpro_defconfig
+F:	doc/board/amlogic/beelink-gtking.rst
+F:	doc/board/amlogic/beelink-gtkingpro.rst
diff --git a/board/amlogic/beelink-s922x/Makefile b/board/amlogic/beelink-s922x/Makefile
new file mode 100644
index 0000000000..27b1a74105
--- /dev/null
+++ b/board/amlogic/beelink-s922x/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2020 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= beelink-s922x.o
diff --git a/board/amlogic/beelink-s922x/beelink-s922x.c b/board/amlogic/beelink-s922x/beelink-s922x.c
new file mode 100644
index 0000000000..dc0d933a39
--- /dev/null
+++ b/board/amlogic/beelink-s922x/beelink-s922x.c
@@ -0,0 +1,54 @@
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
+#include <asm/arch/boot.h>
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
+	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG) &&
+	    meson_get_soc_rev(tmp, sizeof(tmp)) > 0)
+		env_set("soc_rev", tmp);
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
-- 
2.17.1

