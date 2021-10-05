Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web08.24467.1633435243733816590
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Oct 2021 05:00:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1633435241; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=eDaQEQBOeV+AjuJ30BUhxKO+dEUn+nohBuLkZlBKmdU=;
	b=oj7LQqHNa02de2EJr8AXjfEKsyf/8mGR/jE8IdNAS7BUja18Q6/lrd15VVEoIojhVT7jmu
	TYD42FMmq1qWaG9W+tUaZQPo41rCRpEXSBnzKPMPvqTAnJkrH0nBjGDkGbvvqiA7+hqHNv
	0KIHzjpoFzBYpJuUZsGtg5i49AsQU+i5HWE9xdtIwMMLpXCBsY+68CaQwTRrSw7YpnYjvj
	Xq8q822/vgck0rH0S3ww8AwgFTeUW0HZdBjWUT6SExPnKrigqIG2Yp/82G6TYuHyy2T2Wh
	g4+2duTvLJdQWb1nGDz4qnT/6wy+aR7dcLDU3beKFBmhcFMbynqERUC5+1FWTg==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH] ARM: amlogic: add sm efuse write support and cmd for read/write efuse
Date: Tue,  5 Oct 2021 15:00:03 +0300
Message-Id: <20211005120002.1147482-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This adds support for amlogic efuse write and provides two subcommands
of "sm" command: "efuseread" and "efusewrite" to read/write bytes between
memory and efuse.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 arch/arm/mach-meson/sm.c | 68 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 1a8f23cb1fa..fb437b94d14 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -68,6 +68,26 @@ ssize_t meson_sm_read_efuse(uintptr_t offset, void *bu=
ffer, size_t size)
 	return regs.regs[0];
 }
=20
+ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size=
)
+{
+	struct pt_regs regs;
+
+	meson_init_shmem();
+
+        memcpy(shmem_input, buffer, size);
+
+	regs.regs[0] =3D FN_EFUSE_WRITE;
+	regs.regs[1] =3D offset;
+	regs.regs[2] =3D size;
+
+	smc_call(&regs);
+
+	if (regs.regs[0] =3D=3D 0)
+		return -1;
+
+	return 0;
+}
+
 #define SM_CHIP_ID_LENGTH	119
 #define SM_CHIP_ID_OFFSET	4
 #define SM_CHIP_ID_SIZE		12
@@ -187,9 +207,53 @@ static int do_sm_reboot_reason(struct cmd_tbl *cmdtp=
, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
=20
+static int do_efuse_read(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	ulong address, offset, size;
+	int ret;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+
+        offset =3D simple_strtoul(argv[1], NULL, 0);
+        size =3D simple_strtoul(argv[2], NULL, 0);
+
+        address =3D simple_strtoul(argv[3], NULL, 0);
+
+	ret =3D meson_sm_read_efuse(offset, (void *)address, size);
+	if (ret)
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
+        offset =3D simple_strtoul(argv[1], NULL, 0);
+        size =3D simple_strtoul(argv[2], NULL, 0);
+
+        address =3D simple_strtoul(argv[3], NULL, 0);
+
+	ret =3D meson_sm_write_efuse(offset, (void *)address, size);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_sm_sub[] =3D {
 	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
 	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
+        U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
+        U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
 };
=20
 static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -216,5 +280,7 @@ U_BOOT_CMD(
 	sm, 5, 0, do_sm,
 	"Secure Monitor Control",
 	"serial <address> - read chip unique id to memory address\n"
-	"sm reboot_reason [name] - get reboot reason and store to to environmen=
t"
+	"sm reboot_reason [name] - get reboot reason and store to to environmen=
t\n"
+        "sm efuseread <offset> <size> <address> - read efuse to memory a=
ddress\n"
+        "sm efusewrite <offset> <size> <address> - write into efuse from=
 memory address"
 );
--=20
2.30.2

