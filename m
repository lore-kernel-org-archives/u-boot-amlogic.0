Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.40.1670590342011339383
 for <u-boot-amlogic@groups.io>;
 Fri, 09 Dec 2022 04:52:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1670590339;
	bh=a019PLUP1b3gAkADAfLjh39rpimKg1APKDQNTKTe+/k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=l8e1iWNYcJnpdVFwg2m0x9MtMvE9sFGCdV6ahHYRpoSuiMZ7x6MEAl5W/+IQcjcWu
	 jYOMd2mmysdCz1PZwa38nqwFhPZMLoA67P8SWbsqNd9VxlvwTt4x53ZJvgZJQWFhTE
	 PbBKSjoIBxjya7SByIAf/F2c+lKcUctBIscqDRWSDw498Y3iNvK1ddg5xhYzNxDuwW
	 UGlvE38xwD9lMYgsiv772irM7bmqXkLYdQczM3jl+J3wfJcIDadnPXzsHn74D2yjgJ
	 d8yG4DETpS4CW2J5RUXi5xPnJZa1HdeYSa0igFZhuqy343ZzzL7gVVlPaNDGBRvmYE
	 BEn+pzWo6j0jA==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1] arch/arm: sm: introduce efusedump command
Date: Fri, 9 Dec 2022 15:52:04 +0300
Message-ID: <20221209125204.62960-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Using this command user can print efuse memory:

$ sm efusedump 0 10
  00000000: ff 00 31 00 00 ff 66 00 00 00      ..1...f...

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 arch/arm/mach-meson/sm.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index d6eb910689f..87dff2b4c61 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -20,6 +20,7 @@
 #include <linux/bitfield.h>
 #include <regmap.h>
 #include <syscon.h>
+#include <hexdump.h>
=20
 #define FN_GET_SHARE_MEM_INPUT_BASE	0x82000020
 #define FN_GET_SHARE_MEM_OUTPUT_BASE	0x82000021
@@ -246,11 +247,43 @@ static int do_efuse_write(struct cmd_tbl *cmdtp, int =
flag, int argc,
 	return CMD_RET_SUCCESS;
 }
=20
+static int do_efuse_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	ulong offset, size;
+	u8 *buffer;
+	int ret;
+
+	if (argc !=3D 3)
+		return CMD_RET_USAGE;
+
+	offset =3D simple_strtoul(argv[1], NULL, 0);
+	size =3D simple_strtoul(argv[2], NULL, 0);
+	buffer =3D malloc(size);
+	if (!buffer) {
+		pr_err("Failed to allocate %lu bytes\n", size);
+		return CMD_RET_FAILURE;
+	}
+
+	ret =3D meson_sm_read_efuse(offset, (void *)buffer, size);
+	if (ret !=3D size) {
+		ret =3D CMD_RET_FAILURE;
+		goto free_buffer;
+	}
+
+	print_buffer(0, buffer, 1, size, 0);
+
+free_buffer:
+	free(buffer);
+	return ret;
+}
+
 static struct cmd_tbl cmd_sm_sub[] =3D {
 	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
 	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
 	U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
 	U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
+	U_BOOT_CMD_MKENT(efusedump, 3, 1, do_efuse_dump, "", ""),
 };
=20
 static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -279,5 +312,6 @@ U_BOOT_CMD(
 	"serial <address> - read chip unique id to memory address\n"
 	"sm reboot_reason [name] - get reboot reason and store to to environment\=
n"
 	"sm efuseread <offset> <size> <address> - read efuse to memory address\n"
-	"sm efusewrite <offset> <size> <address> - write into efuse from memory a=
ddress"
+	"sm efusewrite <offset> <size> <address> - write into efuse from memory a=
ddress\n"
+	"sm efusedump <offset> <size> - dump efuse data range to console"
 );
--=20
2.30.1

