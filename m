Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.44653.1671713866519105425
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Dec 2022 04:57:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1671713864;
	bh=5rLOuhoEQhgrqpyfDI+xBhoFlhhONODVpGzo+D9uNWw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=CQudraSu9DUsT9rtImDAEmU21PdQKnO++mI0ZFagZ1BCTigmpcrQv/0Ga6ICoZKIF
	 Im4UOMamHHGxETjfV5wJWWhdOHEpuqkJN33B+L/BuDTgtDSH/msTx0JaBZ7xHlBat4
	 VG0XVQdeddK7S6mOur2BKNMElshiqOo/cwmjdYfc5Tvf3UKY+YVA+pcFtzcQsi0CrQ
	 uA3GOtAbWpZb+TBYng5/7wZkqZ9PhmODZQ40x5mIP1R5rAl3X4t21Tm6FYUi7H8MEH
	 ElmCs+E+XEaoJ8gHY7RG2IV7FX+u0qCGqPxGkIwa01wKDltvuDWyQAG6lu4lCR+Qvj
	 254JXOdgoB4tQ==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v3 4/5] cmd/arm: meson: sm: introduce efusedump command
Date: Thu, 22 Dec 2022 15:57:26 +0300
Message-ID: <20221222125727.47893-5-avromanov@sberdevices.ru>
In-Reply-To: <20221222125727.47893-1-avromanov@sberdevices.ru>
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Using this command user can print efuse memory:

$ sm efusedump 0 10
  00000000: ff 00 31 00 00 ff 66 00 00 00      ..1...f...

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 cmd/meson/sm.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/cmd/meson/sm.c b/cmd/meson/sm.c
index c2b57707258..d5eb1d6c084 100644
--- a/cmd/meson/sm.c
+++ b/cmd/meson/sm.c
@@ -5,6 +5,7 @@
  * Author: Beniamino Galvani <b.galvani@gmail.com>
  * Author: Vyacheslav Bocharov <adeep@lexina.in>
  * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Author: Alexey Romanov <avromanov@sberdevices.ru>
  */
=20
 #include <command.h>
@@ -119,11 +120,43 @@ static int do_efuse_write(struct cmd_tbl *cmdtp, int =
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
@@ -152,5 +185,6 @@ U_BOOT_CMD(
 	"serial <address> - read chip unique id to memory address\n"
 	"sm reboot_reason [name] - get reboot reason and store to environment\n"
 	"sm efuseread <offset> <size> <address> - read efuse to memory address\n"
-	"sm efusewrite <offset> <size> <address> - write into efuse from memory a=
ddress"
+	"sm efusewrite <offset> <size> <address> - write into efuse from memory a=
ddress\n"
+	"sm efusedump <offset> <size> - dump efuse data range to console"
 );
--=20
2.25.1

