Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13CC4707C
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.124441.1703776478455812129
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 07:14:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=s3nEU3Dg;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6B5F112000D;
	Thu, 28 Dec 2023 18:14:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6B5F112000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1703776473;
	bh=pT3HNGKddxA+QzKGUjlf5uuQdpgBAh8hlAzPQJ11Vi8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=s3nEU3Dgq4AUAfMzH2MFpbRcJHUOmlPZyYoPlVGhvzcpbIH+vM3WCOrabKn9IjctK
	 CJya5Ob3iCgMp8Pl8FbbhAPQpfRAx5B6xjMX8gFg/caFFlTELuPes9Flezq7P+baJf
	 XfGXhPF56NRHPnDp1RRfWrzqPlJ4Q4Sq72VxYym5zsfkj9h4YNUDbAPjEUMkCH1CnN
	 YxYRdODQVoNjJ7byea6LvzINwfzvt8wrdrpy+0GCylFzU5LlYZaim+yVDfY9njvq8k
	 6GAKzsfY8lvs44tGvltwEMY16dD/uOj9MOVdQNDVEgg2xyUtt8QH3RJxUsA8unY5fP
	 D76QlbrIZzpRQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Dec 2023 18:14:33 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:14:32 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1] arch: meson: add helper for boot partitition flashing
Date: Thu, 28 Dec 2023 18:14:18 +0300
Message-ID: <20231228151421.82746-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182415 [Dec 28 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/28 11:18:00 #22863388
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2004

Amlogic uses its own scheme for flashing bootloader
partition. This patch adds helper function that can
be used by Amlogic BootROM and custom protocols.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/include/asm/arch-meson/nand.h |  88 ++++++++++++++++
 arch/arm/mach-meson/Kconfig            |  16 +++
 arch/arm/mach-meson/Makefile           |   2 +-
 arch/arm/mach-meson/nand.c             | 133 +++++++++++++++++++++++++
 4 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/arch-meson/nand.h
 create mode 100644 arch/arm/mach-meson/nand.c

diff --git a/arch/arm/include/asm/arch-meson/nand.h b/arch/arm/include/asm/=
arch-meson/nand.h
new file mode 100644
index 0000000000..5297d79dd6
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/nand.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2023 SaluteDevices, Inc.
+ */
+
+#ifndef __MESON_NAND_H__
+#define __MESON_NAND_H__
+
+#include <linux/mtd/mtd.h>
+
+#define BOOT_LOADER     "bootloader"
+#define BOOT_BL2        "bl2"
+#define BOOT_SPL        "spl"
+#define BOOT_TPL        "tpl"
+#define BOOT_FIP        "fip"
+
+#define BL2_COPY_NUM            (CONFIG_MESON_BL2_COPY_NUM)
+#define TPL_COPY_NUM            (CONFIG_MESON_TPL_COPY_NUM)
+#define BOOT_TOTAL_PAGES        1024
+#define TPL_SIZE_PER_COPY       0x200000
+#define BL2_SIZE                (64 * 1024)
+
+struct meson_spi_nand_info_page {
+	char magic[8];  /* Magic header of info page. */
+	/* Info page version, +1 when you update this struct. */
+	u8 version;     /* 1 for now. */
+	u8 mode;        /* 1 discrete, 0 compact. */
+	u8 bl2_num;     /* bl2 copy number. */
+	u8 fip_num;     /* fip copy number. */
+	union {
+		struct {
+			u8 rd_max;          /* spi nand max read io. */
+			u8 oob_offset;      /* User bytes offset. */
+			u8 planes_per_lun;
+			u8 rsv;
+			u32 fip_start;      /* Start pages. */
+			u32 fip_pages;      /* Pages per fip. */
+			u32 page_size;      /* spi nand page size (bytes). */
+			u32 page_per_blk;   /* Page number per block. */
+			u32 oob_size;       /* Valid oob size (bytes). */
+			u32 bbt_start;      /* BBT start pages. */
+			u32 bbt_valid;      /* BBT valid offset pages. */
+			u32 bbt_size;       /* BBT occupied bytes. */
+		} __packed spinand;     /* spi nand. */
+		struct {
+			u32 reserved;
+		} emmc;
+	} dev;
+} __packed;
+
+/**
+ * meson_bootloader_copy_num - get bootloader numbers of copies
+ *
+ * @part_name: partition name
+ * @return: number of copies of the specified bootloader partition
+ */
+int meson_bootloader_copy_num(const char *part_name);
+
+/**
+ * meson_bootloader_copy_size - get bootloader copy size in bytes
+ *
+ * @mtd: nand mtd instance
+ * @part_name: partition name
+ * @return: bootloader partition (fox example, BL2) copy size in bytes
+ */
+int meson_bootloader_copy_size(struct mtd_info *mtd, const char *part_name=
);
+
+/**
+ * meson_bootloader_write_info_pages - write bootloader metadata to nand
+ *
+ * @return: zero on success or error code on failure.
+ */
+int meson_bootloader_write_info_pages(void);
+
+/**
+ * meson_bootloader_write_bl2 - write bl2 to nand
+ *
+ * @mtd: nand mtd instance
+ * @buff: buffer to read from
+ * @offset: offset in flash
+ * @size: buffer length
+ * @flags: flags modifying the behaviour of the write to NAND
+ * @return: zero on success or error code on failure
+ */
+int meson_bootloader_write_bl2(struct mtd_info *mtd, void *buff, u32 offse=
t,
+			       size_t size, int flags);
+
+#endif
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index d6c8905806..7b75ed9a2b 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -96,4 +96,20 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
=20
+config MESON_BL2_COPY_NUM
+	depends on ADNL || FASTBOOT_FLASH
+	int "Number of BL2 copies written to storage"
+	default 0
+	help
+		The ADNL / fastboot protocol writes several copies of BL2 bootloader
+		during firmware update process.
+
+config MESON_TPL_COPY_NUM
+	depends on ADNL || FASTBOOT_FLASH
+	int "Number of TPL copies written to storage"
+	default 0
+	help
+		The ADNL / fastboot protocol writes several copies of TPL bootloader
+		during firmware update process.
+
 endif
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 535b0878b9..460626bca9 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
=20
-obj-y +=3D board-common.o sm.o board-info.o
+obj-y +=3D board-common.o sm.o board-info.o nand.o
 obj-$(CONFIG_MESON_GX) +=3D board-gx.o
 obj-$(CONFIG_MESON_AXG) +=3D board-axg.o
 obj-$(CONFIG_MESON_G12A) +=3D board-g12a.o
diff --git a/arch/arm/mach-meson/nand.c b/arch/arm/mach-meson/nand.c
new file mode 100644
index 0000000000..29c10438a1
--- /dev/null
+++ b/arch/arm/mach-meson/nand.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SaluteDevices, Inc.
+ */
+
+#include <nand.h>
+#include <asm/arch/nand.h>
+#include <linux/mtd/nand.h>
+#include <linux/sizes.h>
+
+#define SPINAND_MAGIC		"AMLIFPG"
+#define SPINAND_INFO_VER	1
+#define NAND_RSV_BLOCK_NUM	48
+
+int meson_bootloader_copy_num(const char *part_name)
+{
+	if (!strcmp(part_name, BOOT_BL2) ||
+	    !strcmp(part_name, BOOT_SPL))
+		return BL2_COPY_NUM;
+
+	if (!strcmp(part_name, BOOT_TPL) ||
+	    !strcmp(part_name, BOOT_FIP))
+		return TPL_COPY_NUM;
+
+	return -EINVAL;
+}
+
+int meson_bootloader_copy_size(struct mtd_info *mtd, const char *part_name=
)
+{
+	if (!strcmp(part_name, BOOT_BL2) ||
+	    !strcmp(part_name, BOOT_SPL))
+		return mtd->writesize * (BOOT_TOTAL_PAGES / BL2_COPY_NUM);
+
+	if (!strcmp(part_name, BOOT_TPL) ||
+	    !strcmp(part_name, BOOT_FIP))
+		return TPL_SIZE_PER_COPY;
+
+	return -EINVAL;
+}
+
+int meson_bootloader_write_info_pages(void)
+{
+	struct meson_spi_nand_info_page info_page;
+	struct nand_device *nand_dev;
+	struct mtd_info *mtd;
+	u32 page_per_blk;
+	size_t retlen;
+	int ret, page;
+
+	mtd =3D get_mtd_device_nm(BOOT_LOADER);
+	if (IS_ERR_OR_NULL(mtd))
+		return -ENODEV;
+
+	if (mtd->writesize !=3D SZ_2K) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	if (!mtd->parent) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	nand_dev =3D mtd_to_nanddev(mtd->parent);
+	if (!nand_dev) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	page_per_blk =3D mtd->erasesize / mtd->writesize;
+	memset(&info_page, 0, sizeof(info_page));
+	memcpy(info_page.magic, SPINAND_MAGIC, sizeof(info_page.magic));
+	info_page.version =3D SPINAND_INFO_VER;
+	/* DISCRETE only */
+	info_page.mode =3D 1;
+	info_page.bl2_num =3D BL2_COPY_NUM;
+	info_page.fip_num =3D TPL_COPY_NUM;
+	info_page.dev.spinand.rd_max =3D 2;
+	info_page.dev.spinand.fip_start =3D BOOT_TOTAL_PAGES + NAND_RSV_BLOCK_NUM=
 * page_per_blk;
+	info_page.dev.spinand.fip_pages =3D TPL_SIZE_PER_COPY / mtd->writesize;
+	info_page.dev.spinand.page_size =3D mtd->writesize;
+	info_page.dev.spinand.page_per_blk =3D page_per_blk;
+	info_page.dev.spinand.oob_size =3D mtd->oobsize;
+	info_page.dev.spinand.oob_offset =3D 0;
+	info_page.dev.spinand.bbt_start =3D 0;
+	info_page.dev.spinand.bbt_valid =3D 0;
+	info_page.dev.spinand.bbt_size =3D 0;
+	info_page.dev.spinand.planes_per_lun =3D nand_dev->memorg.planes_per_lun;
+
+	for (page =3D 0; page < BOOT_TOTAL_PAGES; page++) {
+		if (page % 128 !=3D ((BL2_SIZE / mtd->writesize) - 1))
+			continue;
+
+		ret =3D mtd_write(mtd, (page + 1) * mtd->writesize,
+				sizeof(info_page), &retlen,
+				(u8 *)&info_page);
+		if (ret)
+			goto out;
+	}
+
+out:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+
+int meson_bootloader_write_bl2(struct mtd_info *mtd, void *buff, u32 offse=
t,
+			       size_t size, int flags)
+{
+	loff_t off =3D offset;
+	size_t retlen;
+	size_t sz_write =3D SZ_2K;
+	int write_cnt =3D DIV_ROUND_UP(size, sz_write);
+	u64 size_per_copy =3D meson_bootloader_copy_size(mtd, BOOT_BL2);
+	int i;
+
+	for (i =3D 0; i < write_cnt; i++) {
+		int ret;
+		size_t len =3D min(sz_write, (size - i * sz_write));
+
+		ret =3D nand_write_skip_bad(mtd, off, &len, &retlen,
+					  offset + size_per_copy,
+					  (buff + i * sz_write), flags);
+		if (ret)
+			return ret;
+
+		off +=3D mtd->writesize;
+		if (retlen > len)
+			off +=3D (retlen - len);
+	}
+
+	return 0;
+}
--=20
2.30.1


