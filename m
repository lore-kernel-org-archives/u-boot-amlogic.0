Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE4C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 10:42:08 +0000 (UTC)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web11.7910.1737110520094217635
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Jan 2025 02:42:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@lexina.in header.s=dkim header.b=DudGZCUt;
 spf=pass (domain: lexina.in, ip: 185.250.0.168, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE92E6762E;
	Fri, 17 Jan 2025 13:41:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1737110515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SZ/VmcvO8emmPak1eqXWMmtVbndzdMrX/yhhyhX4e7c=;
	b=DudGZCUtRPh6LYTsNxNCs6CIrLrkkgyDL+CzgG5+sYIIvnkz8Pdv9ha2c+sIloLZ45cIK4
	VQx0LZ629+noNkY+rM6kS785h9U6HNL3bQZ6sW4w1Bp0s+3Yfi/MYaSWGdLqVGBRUxlD5C
	0kLKOGdVOqZ7KN7ZAHaSxDy4yFjgVYQYC61qURXn0uHTUe/ovDyt/M5N5FFPjIKhcwRNBe
	Tnblkqv7B7H6ICetqWmxc3sYUqCKKGp2m4YaZhnS90z5bDgcp7hca0XoIwbnNQfdh0Wag6
	Z8k8QbwitRKocmG+xa1MQvDw4F4NiXoa3W+AYcxx5/+tz7hSQ5Kc3T0nV6/Tdg==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Cc: Nikita Maslo <nam@jethome.ru>
Subject: [PATCH v1] arch: meson: sm: add retrieve SoC chipid
Date: Fri, 17 Jan 2025 13:41:35 +0300
Message-ID: <20250117104141.90348-1-adeep@lexina.in>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 17 Jan 2025 10:42:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2614

From: Nikita Maslo <nam@jethome.ru>

The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
unique SoC ID starting from the GX Family and all new families.
But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.

Add new subcommand "chipid" to Amlogic specific "sm" cmd to write the SoC
chip ID to memory.

Signed-off-by: Nikita Maslo <nam@jethome.ru>
Co-developed-by: Viacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 arch/arm/include/asm/arch-meson/sm.h | 12 ++++++++++-
 arch/arm/mach-meson/sm.c             | 32 +++++++++++++++++++++++++++-
 cmd/meson/sm.c                       | 22 ++++++++++++++++++-
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/=
arch-meson/sm.h
index 4b1d564bc48..812c5ed020a 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -27,9 +27,10 @@ ssize_t meson_sm_read_efuse(uintptr_t offset, void *bu=
ffer, size_t size);
 ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size=
);
=20
 #define SM_SERIAL_SIZE	12
+#define SM_CHIP_ID_SIZE	16
=20
 /**
- * meson_sm_get_serial - read chip unique id into buffer
+ * meson_sm_get_serial - read chip unique serial into buffer
  *
  * @buffer: pointer to buffer
  * @size: buffer size.
@@ -37,6 +38,15 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *b=
uffer, size_t size);
  */
 int meson_sm_get_serial(void *buffer, size_t size);
=20
+/**
+ * meson_sm_get_chip_id - read unique chip ID into buffer
+ *
+ * @buffer: pointer to buffer
+ * @size: buffer size.
+ * @return: zero on success or -errno on failure
+ */
+int meson_sm_get_chip_id(void *buffer, size_t size);
+
 enum {
 	REBOOT_REASON_COLD =3D 0,
 	REBOOT_REASON_NORMAL =3D 1,
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 4d9f83d3b38..05d92f878d9 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -78,7 +78,6 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *bu=
ffer, size_t size)
=20
 #define SM_CHIP_ID_LENGTH	119
 #define SM_CHIP_ID_OFFSET	4
-#define SM_CHIP_ID_SIZE		12
=20
 int meson_sm_get_serial(void *buffer, size_t size)
 {
@@ -101,6 +100,37 @@ int meson_sm_get_serial(void *buffer, size_t size)
 	return 0;
 }
=20
+int meson_sm_get_chip_id(void *buffer, size_t size)
+{
+	struct udevice *dev;
+	struct pt_regs regs =3D { 0 };
+	u8 id_buffer[SM_CHIP_ID_LENGTH];
+	int err;
+
+	dev =3D meson_get_sm_device();
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	regs.regs[1] =3D 2;
+	err =3D sm_call_read(dev, id_buffer, SM_CHIP_ID_LENGTH,
+			   MESON_SMC_CMD_CHIP_ID_GET, &regs);
+
+	if (err < 0) {
+		pr_err("Failed to read chipid (%d)\n", err);
+		return err;
+	}
+
+	if (((u32 *)id_buffer)[0] !=3D 2) {
+		pr_err("Failed to read chipid: invalid chipid call version\n");
+		return -EINVAL;
+	}
+
+	memcpy(buffer, id_buffer + SM_CHIP_ID_OFFSET,
+	       size > SM_CHIP_ID_LENGTH ? SM_CHIP_ID_LENGTH : size);
+
+	return 0;
+}
+
 #define AO_SEC_SD_CFG15		0xfc
 #define REBOOT_REASON_MASK	GENMASK(15, 12)
=20
diff --git a/cmd/meson/sm.c b/cmd/meson/sm.c
index b69f8123ee2..21bfa58e507 100644
--- a/cmd/meson/sm.c
+++ b/cmd/meson/sm.c
@@ -33,6 +33,24 @@ static int do_sm_serial(struct cmd_tbl *cmdtp, int fla=
g, int argc,
 	return CMD_RET_SUCCESS;
 }
=20
+static int do_sm_chip_id(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	ulong address;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	address =3D simple_strtoul(argv[1], NULL, 0);
+
+	ret =3D meson_sm_get_chip_id((void *)address, SM_CHIP_ID_SIZE);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
 #define MAX_REBOOT_REASONS 14
=20
 static const char *reboot_reasons[MAX_REBOOT_REASONS] =3D {
@@ -154,6 +172,7 @@ free_buffer:
=20
 static struct cmd_tbl cmd_sm_sub[] =3D {
 	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
+	U_BOOT_CMD_MKENT(chipid, 2, 1, do_sm_chip_id, "", ""),
 	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
 	U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
 	U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
@@ -183,7 +202,8 @@ static int do_sm(struct cmd_tbl *cmdtp, int flag, int=
 argc,
 U_BOOT_CMD(
 	sm, 5, 0, do_sm,
 	"Secure Monitor Control",
-	"serial <address> - read chip unique id to memory address\n"
+	"serial <address> - read chip unique serial to memory address\n"
+	"sm chipid <address> - read unique chip id to memory address\n"
 	"sm reboot_reason [name] - get reboot reason and store to environment\n=
"
 	"sm efuseread <offset> <size> <address> - read efuse to memory address\=
n"
 	"sm efusewrite <offset> <size> <address> - write into efuse from memory=
 address\n"
--=20
2.48.1


