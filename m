Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.82032.1670956303140527543
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Dec 2022 10:31:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1670956301;
	bh=tLm27VyIA8ZhNSuVaspyghP/8YOy2MOVqVStDG6PylM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=nfqKwFL+SO4zURIXHTHZj0BGjBBHdoJ1nz72U5zOAOj5D+Ndhrzy0xz7D3rbAMkDO
	 Qhy06DJUVe37hTbAdRE570oJ2Q/i/YXZdiAbhPstw0iIrM9UI69qecMGFcrT5zQDap
	 +uHYo6YEEyt8JEizJkExbx22U83O/8cUFg8QeNVyz+iqiL4fevBAGS6reIEbcJZl2X
	 p+3c3SKGgfD3Zxdc0DuxBMdYbNf3wYiWI+WuaNNPL8SDtfL7sobTruh8SxJr+WqPiN
	 cUpDawwIqMSzq8w0iwpRQ/JKr4ilnwr0Okqo94vky9UZbwxE4/8lOL1ZXm6+9oOMon
	 248Fz/FJ6iXqA==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v2 3/3] cmd/arm: meson: sm: introduce efusedump command
Date: Tue, 13 Dec 2022 21:31:29 +0300
Message-ID: <20221213183129.75915-4-avromanov@sberdevices.ru>
In-Reply-To: <20221213183129.75915-1-avromanov@sberdevices.ru>
References: <20221213183129.75915-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Using this command user can print efuse memory:

$ sm efusedump 0 10
  00000000: ff 00 31 00 00 ff 66 00 00 00      ..1...f...

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 cmd/meson/sm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/cmd/meson/sm.c b/cmd/meson/sm.c
index 1a3a2c7920a..9493f4fd846 100644
--- a/cmd/meson/sm.c
+++ b/cmd/meson/sm.c
@@ -117,11 +117,43 @@ static int do_efuse_write(struct cmd_tbl *cmdtp, int =
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
@@ -150,5 +182,6 @@ U_BOOT_CMD(
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

