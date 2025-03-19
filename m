Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75596C3600A
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.4462.1742415661647423639
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=PhkH2gMc;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 07FEB120012;
	Wed, 19 Mar 2025 23:21:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 07FEB120012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415660;
	bh=Oaz9kK497lphS7IZ2pMXR0Imi4OVRcRz+na1ZPtEt9c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PhkH2gMcMaZ//sjak2bVu254mb92xG4Z4zS3tFfDMdaTJ2WJtFx0wNF8cA60RzNKs
	 3seMFansTvl8ty6H544C5dToxprbalw+wQHLlaveeP9sECTgrjQfl2JVz9RAk/+h89
	 1S6DRw9RZFl0XT5iFnJArwyeoQxQvKWu2pcBfR0HMyzpi+6qZ0hbN7+CtCmKo+ok+x
	 EWXg6wZz7muuxkf5/sDwQRkLlWEZtfugAcUsEBPMljsHn60azV0RfYOhOW/Br0DEBl
	 71KRNje0+I2IPBj0V0jRd13tCt5SI6la4xyCsr4b183P6hsl8WeSCxwoHFQxIazXrR
	 Si4dOXOF3MuUQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 19 Mar 2025 23:20:59 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
	Viacheslav Bocharov <adeep@lexina.in>, Sumit Garg <sumit.garg@linaro.org>,
	Simon Glass <sjg@chromium.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jerome Forissier
	<jerome.forissier@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, <oxffffaa@gmail.com>,
	<avkrasnov@salutedevices.com>
Subject: [PATCH v1 06/11] arch: arm: meson: bootloader write support
Date: Wed, 19 Mar 2025 23:20:40 +0300
Message-ID: <20250319202045.1407-7-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319202045.1407-1-avkrasnov@salutedevices.com>
References: <20250319202045.1407-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [172.28.65.111]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191951 [Mar 19 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/19 19:45:00 #27804052
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Mar 2025 14:56:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2644

BootROM of Amlogic SoCs that use ADNL/Optimus protocols needs
special layout of "bootloader" partition. So let's implement
functions that support bootloader writing on such SoCs. This is
prerequisite for ADNL/Optimus implementation.

We place such functions to 'arch/arm/mach-meson', because this
code is also needed by 'fastboot' protocol which can also write
"bootloader" partition.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/include/asm/arch-meson/nand.h    |  34 +++
 arch/arm/include/asm/arch-meson/spinand.h |  43 ++++
 arch/arm/mach-meson/Kconfig               |  31 +++
 arch/arm/mach-meson/Makefile              |   4 +-
 arch/arm/mach-meson/rawnand.c             | 291 ++++++++++++++++++++++
 arch/arm/mach-meson/spinand.c             | 158 ++++++++++++
 6 files changed, 559 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-meson/nand.h
 create mode 100644 arch/arm/include/asm/arch-meson/spinand.h
 create mode 100644 arch/arm/mach-meson/rawnand.c
 create mode 100644 arch/arm/mach-meson/spinand.c

diff --git a/arch/arm/include/asm/arch-meson/nand.h b/arch/arm/include/asm/=
arch-meson/nand.h
new file mode 100644
index 00000000000..1f5a20d237b
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/nand.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2023-2024 SaluteDevices, Inc.
+ */
+
+#ifndef __MESON_NAND_H__
+#define __MESON_NAND_H__
+
+#define BOOT_LOADER     "bootloader"
+#define BOOT_BL2        "bl2"
+#define BOOT_SPL        "spl"
+#define BOOT_TPL        "tpl"
+#define BOOT_FIP        "fip"
+
+#define BL2_COPY_NUM            (CONFIG_MESON_BL2_COPY_NUM)
+#define BL2_IMAGE_SIZE_PER_COPY (CONFIG_MESON_BL2_IMAGE_SIZE)
+#define BL2_TOTAL_PAGES         1024
+
+#define TPL_COPY_NUM            (CONFIG_MESON_TPL_COPY_NUM)
+#define TPL_SIZE_PER_COPY       0x200000
+
+#define NAND_RSV_BLOCK_NUM      48
+
+/**
+ * meson_bootloader_write - write 'bootloader' partition to NAND
+ *                          according to the required layout. It will
+ *                          write BL2, TPL and info pages.
+ *
+ * @buf: buffer with BL2 and TPL
+ * @length: buffer length
+ * @return: 0 on success, -errno otherwise.
+ */
+int meson_bootloader_write(unsigned char *buf, size_t length);
+#endif
diff --git a/arch/arm/include/asm/arch-meson/spinand.h b/arch/arm/include/a=
sm/arch-meson/spinand.h
new file mode 100644
index 00000000000..1628c8bd4e0
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/spinand.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2024 SaluteDevices, Inc.
+ */
+
+#ifndef __MESON_SPINAND_H__
+#define __MESON_SPINAND_H__
+
+#include <stdint.h>
+#include <string.h>
+#include <asm/types.h>
+#include <asm/arch-meson/nand.h>
+#include <linux/compiler_attributes.h>
+#include <linux/mtd/mtd.h>
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
+			u8 rd_max;		/* spi nand max read io. */
+			u8 oob_offset;		/* User bytes offset. */
+			u8 planes_per_lun;	/* number of planes per LUN. */
+			u8 rsv;			/* Reserved gap. */
+			u32 fip_start;		/* Start pages. */
+			u32 fip_pages;		/* Pages per fip. */
+			u32 page_size;		/* spi nand page size (bytes). */
+			u32 page_per_blk;	/* Page number per block. */
+			u32 oob_size;		/* Valid oob size (bytes). */
+			u32 bbt_start;		/* BBT start pages. */
+			u32 bbt_valid;		/* BBT valid offset pages. */
+			u32 bbt_size;		/* BBT occupied bytes. */
+		} __packed spinand;		/* spi nand. */
+		struct {
+			u32 reserved;
+		} emmc;
+	} dev;
+} __packed;
+#endif
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 7570f48e25f..883ee78f49b 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -93,4 +93,35 @@ config SYS_BOARD
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD> will
 	  be used.
=20
+config MESON_BL2_COPY_NUM
+	depends on ADNL || FASTBOOT_FLASH
+	int "Number of BL2 copies written to storage"
+	default 8
+	help
+		The ADNL / Optimus / fastboot protocol writes several copies of BL2
+		bootloader during firmware update process.
+
+config MESON_TPL_COPY_NUM
+	depends on ADNL || FASTBOOT_FLASH
+	int "Number of TPL copies written to storage"
+	default 4
+	help
+		The ADNL / Optimus / fastboot protocol writes several copies of TPL
+		bootloader during firmware update process.
+
+config MESON_BL2_IMAGE_SIZE
+	depends on ADNL || FASTBOOT_FLASH
+	hex "Size of BL2 image"
+	default 0x10000
+	help
+		Size of BL2 image, passed by ADNL / Optimus / fastboot protocols.
+
+config MESON_BL2_IMAGE_OFFSET
+	depends on ADNL || FASTBOOT_FLASH
+	hex "Offset from info page to BL2 image"
+	default 0x800
+	help
+		For each copy of BL2, this is offset from info page to BL2 image. Used
+		by Optimus and fastboot protocols.
+
 endif
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 535b0878b91..f63f91dde35 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -4,6 +4,6 @@
=20
 obj-y +=3D board-common.o sm.o board-info.o
 obj-$(CONFIG_MESON_GX) +=3D board-gx.o
-obj-$(CONFIG_MESON_AXG) +=3D board-axg.o
+obj-$(CONFIG_MESON_AXG) +=3D board-axg.o rawnand.o
 obj-$(CONFIG_MESON_G12A) +=3D board-g12a.o
-obj-$(CONFIG_MESON_A1) +=3D board-a1.o
+obj-$(CONFIG_MESON_A1) +=3D board-a1.o spinand.o
diff --git a/arch/arm/mach-meson/rawnand.c b/arch/arm/mach-meson/rawnand.c
new file mode 100644
index 00000000000..6b91674200e
--- /dev/null
+++ b/arch/arm/mach-meson/rawnand.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 SaluteDevices, Inc.
+ */
+
+#include <nand.h>
+#include <asm/types.h>
+#include <asm/arch/rawnand.h>
+#include <linux/compiler_attributes.h>
+#include <linux/mtd/mtd.h>
+#include <linux/sizes.h>
+
+struct raw_nand_setup {
+	union {
+		u32 d32;
+		struct {
+			unsigned cmd:22;	/* NAND controller cmd to read. */
+			unsigned large_page:1;	/* Page is large. */
+			unsigned no_rb:1;	/* No RB. */
+			unsigned a2:1;		/* A2 cmd enable flag. */
+			unsigned reserved25:1;	/* Gap. */
+			unsigned page_list:1;	/* Page list is enabled. */
+			unsigned sync_mode:2;	/* Always 0 according vendor doc. */
+			unsigned size:2;	/* Always 0 according vendor doc. */
+			unsigned active:1;	/* Always 0 according vendor doc. */
+		} b;
+	} cfg;
+	u16 id;
+	u16 max;
+} __packed;
+
+struct raw_nand_cmd {
+	unsigned char type;
+	unsigned char val;
+} __packed;
+
+struct raw_ext_info {
+	u32 read_info;
+	u32 new_type;
+	u32 page_per_blk;
+	u32 xlc;
+	u32 ce_mask;
+	u32 boot_num;
+	u32 each_boot_pages;
+	/* for compatible reason */
+	u32 bbt_occupy_pages;
+	u32 bbt_start_block;
+} __packed;
+
+struct raw_fip_info {
+	u16 version;
+	u16 mode;
+	u32 fip_start;
+} __packed;
+
+struct raw_nand_info_page {
+	struct raw_nand_setup nand_setup;
+	unsigned char page_list[16];
+	struct raw_nand_cmd retry_usr[32];
+	struct raw_ext_info ext_info;
+	struct raw_fip_info fip_info;
+	u32 ddrp_start_page;
+} __packed;
+
+static void meson_raw_fill_oobbuf_with_magic(u8 *oobbuf, size_t oobavail)
+{
+	for (size_t j =3D 0; j < oobavail; j +=3D 2) {
+		oobbuf[j] =3D 0x55;
+		oobbuf[j + 1] =3D 0xaa;
+	}
+}
+
+static int meson_raw_raw_nand_info_page_prepare(struct mtd_info *mtd, void=
 *oobbuf)
+{
+	struct nand_chip *nand_chip =3D mtd_to_nand(mtd->parent);
+	struct raw_nand_info_page *p_nand_page0;
+	struct raw_ext_info *ext_info;
+	struct raw_nand_setup *nand_setup;
+	struct raw_fip_info *fip_info;
+	u32 config_data;
+
+	p_nand_page0 =3D oobbuf;
+	memset(p_nand_page0, 0x0, sizeof(struct raw_nand_info_page));
+	nand_setup =3D &p_nand_page0->nand_setup;
+	ext_info   =3D &p_nand_page0->ext_info;
+
+	config_data =3D CMDRWGEN(NFC_CMD_N2M, 0, 1, 0, nand_chip->ecc.size >> 3,
+			       nand_chip->ecc.steps);
+
+	config_data =3D config_data | BIT(23) | BIT(22) | BIT(21);
+	nand_setup->cfg.d32 =3D config_data;
+	nand_setup->id =3D 0;
+	nand_setup->max =3D 0;
+
+	ext_info->read_info =3D 1;
+	ext_info->page_per_blk =3D mtd->erasesize / mtd->writesize;
+	ext_info->ce_mask =3D 0x01;
+	ext_info->xlc =3D 1;
+	ext_info->boot_num =3D TPL_COPY_NUM;
+	ext_info->each_boot_pages =3D TPL_SIZE_PER_COPY / mtd->writesize;
+	ext_info->bbt_occupy_pages =3D 0x1;
+	ext_info->bbt_start_block =3D 0x14; /* Amlogic keeps BBT in hardcoded off=
set. */
+
+	p_nand_page0->ddrp_start_page =3D 0xb00;
+
+	fip_info =3D &p_nand_page0->fip_info;
+	fip_info->version =3D 1;
+	fip_info->mode =3D 1; /* Discrete mode. */
+	fip_info->fip_start =3D BL2_TOTAL_PAGES +
+		(NAND_RSV_BLOCK_NUM * ext_info->page_per_blk);
+
+	return 0;
+}
+
+static int meson_raw_write_info_page(struct mtd_info *mtd, loff_t offset, =
size_t *actual)
+{
+	int ret;
+	struct mtd_oob_ops ops;
+	u8 *datbuf =3D (u8 *)calloc(mtd->writesize, sizeof(u8));
+
+	if (!datbuf) {
+		pr_err("Failed to allocate data buf for info page\n");
+		return -ENOMEM;
+	}
+
+	meson_raw_raw_nand_info_page_prepare(mtd, datbuf);
+
+	memset(&ops, 0, sizeof(struct mtd_oob_ops));
+	ops.len =3D mtd->writesize;
+	ops.datbuf =3D datbuf;
+	ops.ooblen =3D mtd->oobavail;
+	ops.mode =3D MTD_OPS_AUTO_OOB;
+	ops.oobbuf =3D calloc(mtd->oobavail, sizeof(u8));
+
+	if (!ops.oobbuf) {
+		pr_err("Failed to allocate OOB buf for info page\n");
+		free(datbuf);
+		return -ENOMEM;
+	}
+
+	meson_raw_fill_oobbuf_with_magic(ops.oobbuf, mtd->oobavail);
+
+	ret =3D mtd_write_oob(mtd, offset, &ops);
+	*actual =3D ops.retlen;
+
+	free(ops.oobbuf);
+	free(datbuf);
+
+	return ret;
+}
+
+static int meson_raw_write_bl2(unsigned char *src_data)
+{
+	int ret;
+	size_t i;
+	nand_erase_options_t opts;
+	struct mtd_info *mtd;
+	size_t bl2_copy_limit;
+	struct nand_chip *nand;
+	size_t oobbuff_size;
+	struct mtd_oob_ops ops;
+	size_t src_size =3D BL2_IMAGE_SIZE_PER_COPY;
+	loff_t dest =3D 0;
+	size_t copy_num =3D BL2_COPY_NUM;
+
+	pr_info("Writing BL2\n");
+
+	mtd =3D get_mtd_device_nm(BOOT_LOADER);
+	if (IS_ERR_OR_NULL(mtd)) {
+		pr_err("Failed to get mtd device \"bootloader\" ret: %ld\n", PTR_ERR(mtd=
));
+		return PTR_ERR(mtd);
+	}
+
+	if (mtd->oobavail & 1) {
+		pr_err("Invalid OOB available bytes: %u\n", mtd->oobavail);
+		return -ENODEV;
+	}
+
+	memset(&opts, 0, sizeof(opts));
+	opts.offset =3D dest;
+	opts.length =3D mtd->size;
+	if (nand_erase_opts(mtd, &opts)) {
+		pr_err("Failed to erase \"bootloader\"\n");
+		return -EIO;
+	}
+
+	bl2_copy_limit =3D mtd->size / BL2_COPY_NUM;
+
+	memset(&ops, 0, sizeof(struct mtd_oob_ops));
+	ops.len =3D src_size;
+	ops.datbuf =3D src_data;
+	ops.ooblen =3D mtd->oobavail * (src_size / mtd->writesize + 1);
+	ops.mode =3D MTD_OPS_AUTO_OOB;
+
+	nand =3D mtd_to_nand(mtd->parent);
+	oobbuff_size =3D (mtd->writesize / nand->ecc.size) * ops.ooblen;
+
+	ops.oobbuf =3D calloc(oobbuff_size, sizeof(u8));
+
+	if (!ops.oobbuf) {
+		pr_err("Failed to allocate OOB buf for BL2\n");
+		return -ENOMEM;
+	}
+
+	meson_raw_fill_oobbuf_with_magic(ops.oobbuf, ops.ooblen);
+
+	for (i =3D 0; i < copy_num; i++) {
+		size_t actual =3D 0;
+		loff_t offset_in_partition =3D dest + i * bl2_copy_limit;
+
+		if (mtd_block_isbad(mtd, offset_in_partition)) {
+			pr_info("Skip badblock at %llx\n", offset_in_partition);
+			continue;
+		}
+
+		ret =3D meson_raw_write_info_page(mtd, offset_in_partition, &actual);
+		if (ret)
+			goto free_oobbuf;
+
+		offset_in_partition +=3D CONFIG_MESON_BL2_IMAGE_OFFSET +
+				       (actual - mtd->writesize);
+		ret =3D mtd_write_oob(mtd, offset_in_partition, &ops);
+		if (ret)
+			goto free_oobbuf;
+	}
+
+free_oobbuf:
+	free(ops.oobbuf);
+
+	return ret;
+}
+
+static int meson_raw_write_tpl(unsigned char *src_data, size_t src_size)
+{
+	int ret;
+	size_t i;
+	struct mtd_info *mtd;
+	nand_erase_options_t opts;
+	loff_t dest =3D 0;
+	size_t copy_num =3D TPL_COPY_NUM;
+
+	pr_info("Writing TPL\n");
+	mtd =3D get_mtd_device_nm(BOOT_TPL);
+
+	if (IS_ERR_OR_NULL(mtd)) {
+		pr_err("Failed to get mtd device \"tpl\" ret: %ld\n", PTR_ERR(mtd));
+		return PTR_ERR(mtd);
+	}
+
+	memset(&opts, 0, sizeof(nand_erase_options_t));
+	opts.offset =3D dest;
+	opts.length =3D mtd->size;
+	if (nand_erase_opts(mtd, &opts)) {
+		pr_err("Failed to erase \"tpl\"\n");
+		return -EIO;
+	}
+
+	for (i =3D 0; i < copy_num; i++) {
+		loff_t offset_in_partition =3D dest + i * TPL_SIZE_PER_COPY;
+
+		ret =3D nand_write_skip_bad(mtd, offset_in_partition, &src_size,
+					  NULL, mtd->size / TPL_COPY_NUM, src_data, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int meson_bootloader_write(unsigned char *buf, size_t length)
+{
+	int ret;
+
+	if (!buf) {
+		pr_err("Empty buffer is received\n");
+		return -EINVAL;
+	}
+
+	ret =3D meson_raw_write_bl2(buf);
+	if (ret)
+		return ret;
+
+	/* Write FIP. FIP is also called TPL */
+	ret =3D meson_raw_write_tpl(buf + BL2_IMAGE_SIZE_PER_COPY,
+				  length - BL2_IMAGE_SIZE_PER_COPY);
+	if (ret)
+		return ret;
+
+	pr_info("\"Bootloader (BL2+TPL)\" is written\n");
+	return 0;
+}
diff --git a/arch/arm/mach-meson/spinand.c b/arch/arm/mach-meson/spinand.c
new file mode 100644
index 00000000000..dbad4ba0e9f
--- /dev/null
+++ b/arch/arm/mach-meson/spinand.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SaluteDevices, Inc.
+ */
+
+#include <nand.h>
+#include <asm/arch/spinand.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/sizes.h>
+
+#define SPINAND_MAGIC		"AMLIFPG"
+#define SPINAND_INFO_VER	1
+
+static void meson_bootloader_setup_info_page(struct meson_spi_nand_info_pa=
ge *info_page,
+					     struct mtd_info *mtd)
+{
+	struct nand_device *nand_dev;
+	u32 page_per_blk;
+
+	nand_dev =3D mtd_to_nanddev(mtd->parent);
+	page_per_blk =3D mtd->erasesize / mtd->writesize;
+	info_page->version =3D SPINAND_INFO_VER;
+	/* DISCRETE only */
+	info_page->mode =3D 1;
+	info_page->bl2_num =3D BL2_COPY_NUM;
+	info_page->fip_num =3D TPL_COPY_NUM;
+	info_page->dev.spinand.rd_max =3D 2;
+	info_page->dev.spinand.fip_start =3D BL2_TOTAL_PAGES + NAND_RSV_BLOCK_NUM=
 * page_per_blk;
+	info_page->dev.spinand.fip_pages =3D TPL_SIZE_PER_COPY / mtd->writesize;
+	info_page->dev.spinand.page_size =3D mtd->writesize;
+	info_page->dev.spinand.page_per_blk =3D page_per_blk;
+	info_page->dev.spinand.oob_size =3D mtd->oobsize;
+	info_page->dev.spinand.oob_offset =3D 0;
+	info_page->dev.spinand.bbt_start =3D 0;
+	info_page->dev.spinand.bbt_valid =3D 0;
+	info_page->dev.spinand.bbt_size =3D 0;
+	info_page->dev.spinand.planes_per_lun =3D nand_dev->memorg.planes_per_lun=
;
+}
+
+static int meson_store_boot_write_bl2(struct mtd_info *mtd, void *buf, uns=
igned int copy_idx,
+				      struct meson_spi_nand_info_page *info_page)
+{
+        unsigned int size_per_copy;
+	loff_t offset;
+	size_t retlen;
+	int ret;
+
+	size_per_copy =3D mtd->writesize * (BL2_TOTAL_PAGES / BL2_COPY_NUM);
+	offset =3D mtd->offset + (copy_idx * size_per_copy);
+	ret =3D mtd_write(mtd, offset, BL2_IMAGE_SIZE_PER_COPY, &retlen, buf);
+	if (ret)
+		return ret;
+
+	/*
+	 * Info page is written directly after each BL2 image. For
+	 * example let:
+	 * BL2_TOTAL_PAGES =3D 1024
+	 * BL2_COPY_NUM =3D 8
+	 * BL2_IMAGE_SIZE_PER_COPY =3D 65536 =3D 0x10000
+	 * size_per_copy =3D 2048 * (1024 / 8) =3D 0x40000
+	 *
+	 * BL2 image will be written to BL2_COPY_NUM
+	 * locations:
+	 * 0x00000
+	 * 0x40000
+	 * 0x80000
+	 * 0xc0000
+	 * 0x100000
+	 * 0x140000
+	 * 0x180000
+	 * 0x1c0000
+	 *
+	 * Info pages will be written to BL2_COPY_NUM
+	 * locations:
+	 * 0x10000
+	 * 0x50000
+	 * 0x90000
+	 * 0xd0000
+	 * 0x110000
+	 * 0x150000
+	 * 0x190000
+	 * 0x1d0000
+	 *
+	 * Here is the same, in picture:
+	 *
+	 *          BL2_TOTAL_PAGES =3D=3D 1024
+	 *             BL2_COPY_NUM =3D=3D 8
+	 *  /---------------------------------------\
+	 *  |                                       |
+	 *
+	 *  |AB  |AB  |AB  |AB  |AB  |AB  |AB  |AB  |
+	 *  |____|____|____|____|____|____|____|____|
+	 *  ^    ^
+	 *  |    |
+	 *  |____|__ size_per_copy =3D=3D 0x40000
+	 *
+	 *  A - is BL2 image. It is BL2_IMAGE_SIZE_PER_COPY =3D=3D 0x10000 bytes.
+	 *  B - is info page.
+	 */
+	offset +=3D BL2_IMAGE_SIZE_PER_COPY;
+
+	return mtd_write(mtd, offset, sizeof(*info_page),
+			 &retlen, (u8 *)info_page);
+}
+
+static int meson_store_boot_write_tpl(void *buf, size_t size, unsigned int=
 copy_idx)
+{
+	loff_t offset;
+	struct mtd_info *mtd;
+	loff_t limit;
+	size_t retlen =3D 0;
+
+	mtd =3D get_mtd_device_nm(BOOT_TPL);
+	if (IS_ERR_OR_NULL(mtd))
+		return -ENODEV;
+
+	offset =3D mtd->offset + (copy_idx * TPL_SIZE_PER_COPY);
+	limit =3D offset + TPL_SIZE_PER_COPY;
+
+	return nand_write_skip_bad(mtd->parent, offset, &size, &retlen,
+				   limit, buf, 0);
+}
+
+int meson_bootloader_write(unsigned char *buf, size_t length)
+{
+	struct meson_spi_nand_info_page info_page;
+	unsigned int copy_idx;
+	struct mtd_info *mtd;
+	int ret;
+
+	/* 'buf' contains BL2 and TPL. If there is only BL2 or
+	 * even less - input data is invalid.
+	 */
+	if (length <=3D BL2_IMAGE_SIZE_PER_COPY)
+		return -EINVAL;
+
+	mtd =3D get_mtd_device_nm(BOOT_LOADER);
+	if (IS_ERR_OR_NULL(mtd))
+		return -ENODEV;
+
+	meson_bootloader_setup_info_page(&info_page, mtd);
+
+	for (copy_idx =3D 0; copy_idx < BL2_COPY_NUM; copy_idx++) {
+		ret =3D meson_store_boot_write_bl2(mtd, buf, copy_idx, &info_page);
+		if (ret)
+			return ret;
+	}
+
+	for (copy_idx =3D 0; copy_idx < TPL_COPY_NUM; copy_idx++) {
+		ret =3D meson_store_boot_write_tpl(buf + BL2_IMAGE_SIZE_PER_COPY,
+						 length - BL2_IMAGE_SIZE_PER_COPY, copy_idx);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
--=20
2.30.1


