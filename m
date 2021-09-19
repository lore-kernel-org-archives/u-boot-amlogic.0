Received: from mx.msync.work (mx.msync.work [95.217.65.204])
 by mx.groups.io with SMTP id smtpd.web08.8380.1632039524130468567
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Sep 2021 01:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1632039521; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eOHikEe42LiTmJhB+KM0t2SCQzkCQ6F02GC5aTqn+Cg=;
	b=FXKx9WLY+n5VnqlGvqfp7VYiMLkpEyKFNqbhNAV6ERxMwBxcLFRYlZgZfdm95D4oFMWju+
	uHDRt1H43ZWO4boH1En+yJ2RUmA3s/ytUKuuzdoPN47cuQEHFQ/0nx88Wbvfztr8VnVldq
	q06PZ+qMEJrVSdLwAwfzsXnWB4kMVi/Za88ZA2GZS3kLxY0jUppkOWKt/WhxiSOxBOA8Su
	5JD5HhtUpWQYiMk2y0AQ4zYr4yW+1qINXr6+Tt7idpsyCUFQsC1yzhOhNHcrXhzrr5HZXV
	gtlz/52Lr2iLFqr1SEY1L/YFaTYLAcYHa8fDUPQoFAyq/rsNkDCPlZbvgP0AnQ==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH 1/3] ARM: amlogic: add JetHub common config header
Date: Sun, 19 Sep 2021 11:18:21 +0300
Message-Id: <20210919081823.2413970-2-adeep@lexina.in>
In-Reply-To: <20210919081823.2413970-1-adeep@lexina.in>
References: <20210919081823.2413970-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

JetHub devices uses its own boot sequence with "rescue" button.
Add custom config header file that corrects boot order.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 include/configs/jethub.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/configs/jethub.h

diff --git a/include/configs/jethub.h b/include/configs/jethub.h
new file mode 100644
index 0000000000..09264f91a5
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
+	func(RESCUE, mmc, 1) \
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

