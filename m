Received: from mx.msync.work (mx.msync.work [95.217.65.204])
 by mx.groups.io with SMTP id smtpd.web09.9059.1632127225743588779
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Sep 2021 01:40:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1632127222; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kKYp/Sw3quC7qKfu6cSExkEtEgOYCbEo/UTxedjpwOU=;
	b=XFRd56Ig6SS+0HRSqjMgtlluFGzIpcVnTrx9rJj579cgrAdUmIThSQQfVe06gbbO7OV+1d
	Ex0VIxyvhrXzd10EreinPxdgee8AntNGMsmRMkR1EUmsmfUHFIVl0cAAnyos84es9CmNmf
	pWG5wUI6ocPesI3PLqEqDI8ZV07dDdoQPM53gkLZUig7A3dRNasHWAuH2fcLyrpxMGN6Mk
	wnjnMAyQJZJVz6BubklRhuvxc/TUbC62XSOcF2A7p7OeHTRHT73SHIdRHQIu+nBT/666st
	PGH3rRca0k43wsV2igw8g5cqtSm2DasbqYsykfxjoLIyFms6PxT/D2pzal3Gig==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 1/3] ARM: amlogic: add JetHub common config header
Date: Mon, 20 Sep 2021 11:40:14 +0300
Message-Id: <20210920084016.2536084-2-adeep@lexina.in>
In-Reply-To: <20210920084016.2536084-1-adeep@lexina.in>
References: <20210920084016.2536084-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

JetHub devices uses its own boot sequence with "rescue" button

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 include/configs/jethub.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/configs/jethub.h

diff --git a/include/configs/jethub.h b/include/configs/jethub.h
new file mode 100644
index 0000000000..35f85095ac
--- /dev/null
+++ b/include/configs/jethub.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration for JetHome devices
+ * Copyright (C) 2021 Vyacheslav Bocharov
+ * Author: Vyacheslav Bocharov <adeep@lexina.in>
+ */
+
+#ifndef __JETHUB_CONFIG_H
+#define __JETHUB_CONFIG_H
+
+#if defined(CONFIG_MESON_AXG)
+#define BOOTENV_DEV_RESCUE(devtypeu, devtypel, instance) \
+	"bootcmd_rescue=3D" \
+		"if gpio input 10; then " \
+		"run bootcmd_usb0;" \
+		"fi;\0"
+#else
+#define BOOTENV_DEV_RESCUE(devtypeu, devtypel, instance) \
+	"bootcmd_rescue=3D" \
+		"if test \"${userbutton}\" =3D \"true\"; then " \
+		"run bootcmd_mmc0; " \
+		"fi;\0"
+#endif
+
+#define BOOTENV_DEV_NAME_RESCUE(devtypeu, devtypel, instance) \
+	"rescue "
+
+#ifndef BOOT_TARGET_DEVICES
+#define BOOT_TARGET_DEVICES(func) \
+	func(RESCUE, rescue, na) \
+	func(MMC, mmc, 1) \
+	func(MMC, mmc, 0) \
+	BOOT_TARGET_DEVICES_USB(func) \
+	func(PXE, pxe, na) \
+	func(DHCP, dhcp, na)
+#endif
+
+#include <configs/meson64.h>
+
+#endif /* __JETHUB_CONFIG_H */
--=20
2.30.2

