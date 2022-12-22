Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.44651.1671713862914333771
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Dec 2022 04:57:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1671713860;
	bh=WtSDHsNChT8X6edGpoAVO+xSmvHx6XVq8Qh9OcR6pi8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=GyLUQZc5B5ICEXBjlS6ahskL1JrluaYDiTWQ0jnXtMCdzZA+Qo2dCKAV/73qO4RHe
	 trrlqOIKMhP384Vz02csLezbxt7RahB2sSmLBB3QmByHOq5a9mhnfpvYy7mGosVqSa
	 WDzM6DgJPs6v3GlNjtjryMOuySEpeWu/6I4JaxEbtSPfWeVOhu6P9Z/BaZGdMlJUj6
	 vXRr6a8xSuj7gDb5grCD12/qQNg1zOP5wmeDpQTczfXf+rzldcEfHIsMXnVYuyEsrQ
	 dC7Ce42EcTtAhz5hK7wrjJ5RcL1gsjDakNBncj/NJSi26we7pKwWG1gipocVsPf2GC
	 bjK4ezyp38NbA==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v3 2/5] arm/mach-meson: move smc commands in cmd/meson
Date: Thu, 22 Dec 2022 15:57:24 +0300
Message-ID: <20221222125727.47893-3-avromanov@sberdevices.ru>
In-Reply-To: <20221222125727.47893-1-avromanov@sberdevices.ru>
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

It is incorrect to keep commands in the arch/ folder.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS              |   1 +
 arch/arm/mach-meson/sm.c | 144 ------------------------------------
 cmd/Kconfig              |   7 ++
 cmd/Makefile             |   3 +
 cmd/meson/Makefile       |   5 ++
 cmd/meson/sm.c           | 156 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 172 insertions(+), 144 deletions(-)
 create mode 100644 cmd/meson/Makefile
 create mode 100644 cmd/meson/sm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f27ff4c20f..7a5460d4922 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -149,6 +149,7 @@ L:	u-boot-amlogic@groups.io
 T:	git https://source.denx.de/u-boot/custodians/u-boot-amlogic.git
 F:	arch/arm/mach-meson/
 F:	arch/arm/include/asm/arch-meson/
+F:	cmd/meson/
 F:	drivers/clk/meson/
 F:	drivers/serial/serial_meson.c
 F:	drivers/reset/reset-meson.c
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index d6eb910689f..f2ca7e76932 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -6,8 +6,6 @@
  */
=20
 #include <common.h>
-#include <command.h>
-#include <env.h>
 #include <log.h>
 #include <asm/arch/sm.h>
 #include <asm/cache.h>
@@ -139,145 +137,3 @@ int meson_sm_get_reboot_reason(void)
 	/* The SMC call is not used, we directly use AO_SEC_SD_CFG15 */
 	return FIELD_GET(REBOOT_REASON_MASK, reason);
 }
-
-static int do_sm_serial(struct cmd_tbl *cmdtp, int flag, int argc,
-			char *const argv[])
-{
-	ulong address;
-	int ret;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	address =3D simple_strtoul(argv[1], NULL, 0);
-
-	ret =3D meson_sm_get_serial((void *)address, SM_CHIP_ID_SIZE);
-	if (ret)
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
-#define MAX_REBOOT_REASONS 14
-
-static const char *reboot_reasons[MAX_REBOOT_REASONS] =3D {
-	[REBOOT_REASON_COLD] =3D "cold_boot",
-	[REBOOT_REASON_NORMAL] =3D "normal",
-	[REBOOT_REASON_RECOVERY] =3D "recovery",
-	[REBOOT_REASON_UPDATE] =3D "update",
-	[REBOOT_REASON_FASTBOOT] =3D "fastboot",
-	[REBOOT_REASON_SUSPEND_OFF] =3D "suspend_off",
-	[REBOOT_REASON_HIBERNATE] =3D "hibernate",
-	[REBOOT_REASON_BOOTLOADER] =3D "bootloader",
-	[REBOOT_REASON_SHUTDOWN_REBOOT] =3D "shutdown_reboot",
-	[REBOOT_REASON_RPMBP] =3D "rpmbp",
-	[REBOOT_REASON_CRASH_DUMP] =3D "crash_dump",
-	[REBOOT_REASON_KERNEL_PANIC] =3D "kernel_panic",
-	[REBOOT_REASON_WATCHDOG_REBOOT] =3D "watchdog_reboot",
-};
-
-static int do_sm_reboot_reason(struct cmd_tbl *cmdtp, int flag, int argc,
-			       char *const argv[])
-{
-	const char *reason_str;
-	char *destarg =3D NULL;
-	int reason;
-
-	if (argc > 1)
-		destarg =3D argv[1];
-
-	reason =3D meson_sm_get_reboot_reason();
-	if (reason < 0)
-		return CMD_RET_FAILURE;
-
-	if (reason >=3D MAX_REBOOT_REASONS ||
-	    !reboot_reasons[reason])
-		reason_str =3D "unknown";
-	else
-		reason_str =3D reboot_reasons[reason];
-
-	if (destarg)
-		env_set(destarg, reason_str);
-	else
-		printf("reboot reason: %s (%x)\n", reason_str, reason);
-
-	return CMD_RET_SUCCESS;
-}
-
-static int do_efuse_read(struct cmd_tbl *cmdtp, int flag, int argc,
-			char *const argv[])
-{
-	ulong address, offset, size;
-	int ret;
-
-	if (argc < 4)
-		return CMD_RET_USAGE;
-
-        offset =3D simple_strtoul(argv[1], NULL, 0);
-        size =3D simple_strtoul(argv[2], NULL, 0);
-
-        address =3D simple_strtoul(argv[3], NULL, 0);
-
-	ret =3D meson_sm_read_efuse(offset, (void *)address, size);
-	if (ret !=3D size)
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
-static int do_efuse_write(struct cmd_tbl *cmdtp, int flag, int argc,
-			char *const argv[])
-{
-	ulong address, offset, size;
-	int ret;
-
-	if (argc < 4)
-		return CMD_RET_USAGE;
-
-        offset =3D simple_strtoul(argv[1], NULL, 0);
-        size =3D simple_strtoul(argv[2], NULL, 0);
-
-        address =3D simple_strtoul(argv[3], NULL, 0);
-
-	ret =3D meson_sm_write_efuse(offset, (void *)address, size);
-	if (ret !=3D size)
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
-static struct cmd_tbl cmd_sm_sub[] =3D {
-	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
-	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
-	U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
-	U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
-};
-
-static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
-		 char *const argv[])
-{
-	struct cmd_tbl *c;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	/* Strip off leading 'sm' command argument */
-	argc--;
-	argv++;
-
-	c =3D find_cmd_tbl(argv[0], &cmd_sm_sub[0], ARRAY_SIZE(cmd_sm_sub));
-
-	if (c)
-		return c->cmd(cmdtp, flag, argc, argv);
-	else
-		return CMD_RET_USAGE;
-}
-
-U_BOOT_CMD(
-	sm, 5, 0, do_sm,
-	"Secure Monitor Control",
-	"serial <address> - read chip unique id to memory address\n"
-	"sm reboot_reason [name] - get reboot reason and store to to environment\=
n"
-	"sm efuseread <offset> <size> <address> - read efuse to memory address\n"
-	"sm efusewrite <offset> <size> <address> - write into efuse from memory a=
ddress"
-);
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 09193b61b95..07833f958e7 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2565,4 +2565,11 @@ config MMC_SPEED_MODE_SET
 	  and is indicated using the index from enum bus_mode in
 	  include/mmc.h. A speed mode can be set only if it has already
 	  been enabled in the device tree.
+
+config CMD_MESON
+	bool "Amlogic Meson commands"
+	depends on ARCH_MESON
+	default y
+	help
+	  Enable useful commands for the Meson Soc family developed by Amlogic In=
c.
 endmenu
diff --git a/cmd/Makefile b/cmd/Makefile
index 5e43a1e022e..146c5ebb227 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -210,6 +210,9 @@ obj-$(CONFIG_RISCV) +=3D riscv/
 obj-$(CONFIG_SANDBOX) +=3D sandbox/
 obj-$(CONFIG_X86) +=3D x86/
=20
+# Meson
+obj-$(CONFIG_CMD_MESON) +=3D meson/
+
 obj-$(CONFIG_ARCH_MVEBU) +=3D mvebu/
 endif # !CONFIG_SPL_BUILD
=20
diff --git a/cmd/meson/Makefile b/cmd/meson/Makefile
new file mode 100644
index 00000000000..ee26c175cfe
--- /dev/null
+++ b/cmd/meson/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2022, SberDevices. All rights reserved.
+
+obj-y +=3D sm.o
diff --git a/cmd/meson/sm.c b/cmd/meson/sm.c
new file mode 100644
index 00000000000..c2b57707258
--- /dev/null
+++ b/cmd/meson/sm.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2016 Beniamino Galvani
+ *
+ * Author: Beniamino Galvani <b.galvani@gmail.com>
+ * Author: Vyacheslav Bocharov <adeep@lexina.in>
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <command.h>
+#include <common.h>
+#include <env.h>
+#include <asm/arch/sm.h>
+#include <stdlib.h>
+
+static int do_sm_serial(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	ulong address;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	address =3D simple_strtoul(argv[1], NULL, 0);
+
+	ret =3D meson_sm_get_serial((void *)address, SM_SERIAL_SIZE);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+#define MAX_REBOOT_REASONS 14
+
+static const char *reboot_reasons[MAX_REBOOT_REASONS] =3D {
+	[REBOOT_REASON_COLD] =3D "cold_boot",
+	[REBOOT_REASON_NORMAL] =3D "normal",
+	[REBOOT_REASON_RECOVERY] =3D "recovery",
+	[REBOOT_REASON_UPDATE] =3D "update",
+	[REBOOT_REASON_FASTBOOT] =3D "fastboot",
+	[REBOOT_REASON_SUSPEND_OFF] =3D "suspend_off",
+	[REBOOT_REASON_HIBERNATE] =3D "hibernate",
+	[REBOOT_REASON_BOOTLOADER] =3D "bootloader",
+	[REBOOT_REASON_SHUTDOWN_REBOOT] =3D "shutdown_reboot",
+	[REBOOT_REASON_RPMBP] =3D "rpmbp",
+	[REBOOT_REASON_CRASH_DUMP] =3D "crash_dump",
+	[REBOOT_REASON_KERNEL_PANIC] =3D "kernel_panic",
+	[REBOOT_REASON_WATCHDOG_REBOOT] =3D "watchdog_reboot",
+};
+
+static int do_sm_reboot_reason(struct cmd_tbl *cmdtp, int flag, int argc,
+			       char *const argv[])
+{
+	const char *reason_str;
+	char *destarg =3D NULL;
+	int reason;
+
+	if (argc > 1)
+		destarg =3D argv[1];
+
+	reason =3D meson_sm_get_reboot_reason();
+	if (reason < 0)
+		return CMD_RET_FAILURE;
+
+	if (reason >=3D MAX_REBOOT_REASONS ||
+	    !reboot_reasons[reason])
+		reason_str =3D "unknown";
+	else
+		reason_str =3D reboot_reasons[reason];
+
+	if (destarg)
+		env_set(destarg, reason_str);
+	else
+		printf("reboot reason: %s (%x)\n", reason_str, reason);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_efuse_read(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	ulong address, offset, size;
+	int ret;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+
+	offset =3D simple_strtoul(argv[1], NULL, 0);
+	size =3D simple_strtoul(argv[2], NULL, 0);
+
+	address =3D simple_strtoul(argv[3], NULL, 0);
+
+	ret =3D meson_sm_read_efuse(offset, (void *)address, size);
+	if (ret !=3D size)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_efuse_write(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	ulong address, offset, size;
+	int ret;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+
+	offset =3D simple_strtoul(argv[1], NULL, 0);
+	size =3D simple_strtoul(argv[2], NULL, 0);
+
+	address =3D simple_strtoul(argv[3], NULL, 0);
+
+	ret =3D meson_sm_write_efuse(offset, (void *)address, size);
+	if (ret !=3D size)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static struct cmd_tbl cmd_sm_sub[] =3D {
+	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
+	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
+	U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
+	U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
+};
+
+static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	struct cmd_tbl *c;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	/* Strip off leading 'sm' command argument */
+	argc--;
+	argv++;
+
+	c =3D find_cmd_tbl(argv[0], &cmd_sm_sub[0], ARRAY_SIZE(cmd_sm_sub));
+
+	if (c)
+		return c->cmd(cmdtp, flag, argc, argv);
+	else
+		return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(
+	sm, 5, 0, do_sm,
+	"Secure Monitor Control",
+	"serial <address> - read chip unique id to memory address\n"
+	"sm reboot_reason [name] - get reboot reason and store to environment\n"
+	"sm efuseread <offset> <size> <address> - read efuse to memory address\n"
+	"sm efusewrite <offset> <size> <address> - write into efuse from memory a=
ddress"
+);
--=20
2.25.1

