Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web11.2231.1635491310365887093
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Oct 2021 00:08:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1635491306; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CGgXzIYlCkWB4k1Y0lqCRFcLqVy9j+dYMQ82Pg38S0E=;
	b=DpqLVwPOkJNxWanioeFYyIpFZetoBhC7Rm/wj+HCe9cJywVaLgMq7iq9rOdIGcKy8t7XNh
	W+4bDn4KYZvuZfbfB8Gqw7bq5MC3nCWu6m9Q3wm/WBUdYnsHeEYYgsZI7Th/jZj39qDSCU
	9s6R1w0Uaaag3LuaaDITEJCFtNXzP0IsQ+yV+6G7iWkmjPtiZKn9AxFxQ0Q9MQHhgdNBgO
	NKI/aLQz786ivCO7w5DSEDyM3BZU51ZgrCmr7em1j0wu3YvLAhmzN8uTHMQ1p31lc904Yt
	mU/OQAU4uqyImFHkr7vuKdYO65sJVTVvpXbJMqGoL2TZJahKO7Cd6x+gqLalfA==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH] ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI
Date: Fri, 29 Oct 2021 10:08:20 +0300
Message-Id: <20211029070820.3607994-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

JetHome has own MAC OUI. Add jethub-j100 board file. Update config.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 board/amlogic/jethub-j100/MAINTAINERS   |  8 +++++
 board/amlogic/jethub-j100/Makefile      |  6 ++++
 board/amlogic/jethub-j100/jethub-j100.c | 41 +++++++++++++++++++++++++
 board/amlogic/jethub-j80/MAINTAINERS    |  3 +-
 configs/jethub_j100_defconfig           |  1 +
 5 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 board/amlogic/jethub-j100/MAINTAINERS
 create mode 100644 board/amlogic/jethub-j100/Makefile
 create mode 100644 board/amlogic/jethub-j100/jethub-j100.c

diff --git a/board/amlogic/jethub-j100/MAINTAINERS b/board/amlogic/jethub=
-j100/MAINTAINERS
new file mode 100644
index 0000000000..43f6a5fc86
--- /dev/null
+++ b/board/amlogic/jethub-j100/MAINTAINERS
@@ -0,0 +1,8 @@
+JetHome JetHub
+M:	Vyacheslav Bocharov <adeep@lexina.in>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/jethub-j100/
+F:	configs/jethub_j100_defconfig
+F:	doc/board/amlogic/jethub-j100.rst
+F:	include/configs/jethub.h
diff --git a/board/amlogic/jethub-j100/Makefile b/board/amlogic/jethub-j1=
00/Makefile
new file mode 100644
index 0000000000..4d935af984
--- /dev/null
+++ b/board/amlogic/jethub-j100/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2021 Vyacheslav Bocharov
+# Author: Vyacheslav Bocharov <adeep@lexina.in>
+
+obj-y	:=3D jethub-j100.o
diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jeth=
ub-j100/jethub-j100.c
new file mode 100644
index 0000000000..575bb31573
--- /dev/null
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Vyacheslav Bocharov
+ * Author: Vyacheslav Bocharov <adeep@lexina.in>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <init.h>
+#include <net.h>
+#include <asm/io.h>
+#include <asm/arch/axg.h>
+#include <asm/arch/sm.h>
+#include <asm/arch/eth.h>
+#include <asm/arch/mem.h>
+
+int misc_init_r(void)
+{
+	u8 mac_addr[ARP_HLEN];
+	char serial[SM_SERIAL_SIZE];
+	u32 sid;
+
+	if (!meson_sm_get_serial(serial, SM_SERIAL_SIZE)) {
+		sid =3D crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE);
+		/* Ensure the NIC specific bytes of the mac are not all 0 */
+		if ((sid & 0xffff) =3D=3D 0)
+			sid |=3D 0x800000;
+
+		/* OUI registered MAC address */
+		mac_addr[0] =3D 0x10;
+		mac_addr[1] =3D 0x27;
+		mac_addr[2] =3D 0xBE;
+		mac_addr[3] =3D (sid >> 16) & 0xff;
+		mac_addr[4] =3D (sid >>  8) & 0xff;
+		mac_addr[5] =3D (sid >>  0) & 0xff;
+
+		eth_env_set_enetaddr("ethaddr", mac_addr);
+	}
+
+	return 0;
+}
diff --git a/board/amlogic/jethub-j80/MAINTAINERS b/board/amlogic/jethub-=
j80/MAINTAINERS
index 459e9f89da..a899153117 100644
--- a/board/amlogic/jethub-j80/MAINTAINERS
+++ b/board/amlogic/jethub-j80/MAINTAINERS
@@ -4,6 +4,5 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/jethub-j80/
 F:	configs/jethub_j80_defconfig
-F:	configs/jethub_j100_defconfig
 F:	doc/board/amlogic/jethub-j80.rst
-F:	doc/board/amlogic/jethub-j100.rst
+F:	include/configs/jethub.h
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfi=
g
index 290ce4db85..ad026a89e0 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=3Dy
+CONFIG_SYS_BOARD=3D"jethub-j100"
 CONFIG_SYS_CONFIG_NAME=3D"jethub"
 CONFIG_ARCH_MESON=3Dy
 CONFIG_SYS_TEXT_BASE=3D0x01000000
--=20
2.30.2

