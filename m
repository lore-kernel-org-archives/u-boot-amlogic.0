Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FFFC36005
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.4465.1742415662245289869
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=cyBfPY38;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BE049120013;
	Wed, 19 Mar 2025 23:21:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BE049120013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415660;
	bh=57i8ekdB7P3lnVk1tSjHBteB8noW7VQup4RjT34jVaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=cyBfPY381jsCVC4cLrbyWh9eVLAbMas4E8D/TB1oPuOwnHAvdGBojAxr1A1IDpsnz
	 R+vkg+Re0OZZcPKXTGLgupz8ARSuEr0HlrUP042XIrwqgUii63fOK/h+9Pl7jc/c65
	 fKEnpjUUVjKze3J4tM1qU0TyP/kRdfjoGERxtopinrr/OzAThoANu1A0rYuhobw7kq
	 f5GodUZs83skCobMRiuhYpB5VkNlXq6DdbCL2hvS9Z2yxKdFB1XZOIWmhQQoaWfUQB
	 4SGkzl4damiSha0A2gDXhYH5gnsEAUjXxVwtUu8cxtxB1XqxyUhInK1mEitOt6o4ew
	 F6H7a6HBuBoGQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 19 Mar 2025 23:21:00 +0300 (MSK)
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
Subject: [PATCH v1 08/11] usb: gadget: amlogic: implement ADNL protocol
Date: Wed, 19 Mar 2025 23:20:42 +0300
Message-ID: <20250319202045.1407-9-avkrasnov@salutedevices.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Mar 2025 14:56:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2638

This adds support for ADNL (Amlogic DowNLoad) protocol. This protocol
is supported by some Amlogic SoCs (a1, s4, c1, =D1=812, sc2, t7, etc) in
BootRom code (e.g. it is already supported in "out of the box" mode).
It has similar goals as fastboot - upload and update firmware images
on the device. Difference is that, it is specific for Amlogic SoCs,
and for example it allows to upload and run image starting from ROM
boot stage, it also uses SoC specific registers and SMC commands.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 cmd/Kconfig                                   |   7 +
 cmd/meson/Makefile                            |   1 +
 cmd/meson/adnl.c                              |  27 +
 drivers/usb/gadget/Kconfig                    |   2 +
 drivers/usb/gadget/Makefile                   |   1 +
 drivers/usb/gadget/amlogic/Kconfig            |  11 +
 drivers/usb/gadget/amlogic/adnl/Kconfig       |  29 +
 drivers/usb/gadget/amlogic/adnl/Makefile      |   4 +
 drivers/usb/gadget/amlogic/adnl/adnl.h        | 124 +++
 .../gadget/amlogic/adnl/adnl_buff_manager.c   | 316 +++++++
 drivers/usb/gadget/amlogic/adnl/adnl_media.c  | 235 +++++
 .../usb/gadget/amlogic/adnl/adnl_storage.c    | 140 +++
 drivers/usb/gadget/amlogic/adnl/f_adnl.c      | 835 ++++++++++++++++++
 13 files changed, 1732 insertions(+)
 create mode 100644 cmd/meson/adnl.c
 create mode 100644 drivers/usb/gadget/amlogic/Kconfig
 create mode 100644 drivers/usb/gadget/amlogic/adnl/Kconfig
 create mode 100644 drivers/usb/gadget/amlogic/adnl/Makefile
 create mode 100644 drivers/usb/gadget/amlogic/adnl/adnl.h
 create mode 100644 drivers/usb/gadget/amlogic/adnl/adnl_buff_manager.c
 create mode 100644 drivers/usb/gadget/amlogic/adnl/adnl_media.c
 create mode 100644 drivers/usb/gadget/amlogic/adnl/adnl_storage.c
 create mode 100644 drivers/usb/gadget/amlogic/adnl/f_adnl.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 9e8a9c3cb3a..2f195d03848 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1146,6 +1146,13 @@ config CMD_FASTBOOT
=20
 	  See doc/android/fastboot.rst for more information.
=20
+config CMD_ADNL
+	bool "ADNL - Amlogic download protocol"
+	depends on ADNL
+	help
+          This command, "adnl", enables the ADNL listen mode, providing
+	  the ability to listen in ADNL mode.
+
 config CMD_FLASH
 	bool "flinfo, erase, protect"
 	default y
diff --git a/cmd/meson/Makefile b/cmd/meson/Makefile
index ee26c175cfe..1cf984378a3 100644
--- a/cmd/meson/Makefile
+++ b/cmd/meson/Makefile
@@ -3,3 +3,4 @@
 # Copyright (c) 2022, SberDevices. All rights reserved.
=20
 obj-y +=3D sm.o
+obj-$(CONFIG_CMD_ADNL) +=3D gadget.o adnl.o
diff --git a/cmd/meson/adnl.c b/cmd/meson/adnl.c
new file mode 100644
index 00000000000..13aa1f2113e
--- /dev/null
+++ b/cmd/meson/adnl.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#include <command.h>
+
+#include "gadget.h"
+
+static int do_adnl(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	return amlogic_gadget_run("usb_dnl_adnl", argc, argv);
+}
+
+U_BOOT_LONGHELP(adnl,
+	"- run as an ADNL USB device\n\n"
+	"With:\n"
+	"\t[init timeout]: time between command start and moment when\n"
+	"\t                device enters gadget mode, in ms\n"
+	"\t[identify timeout]: time between moment when device enters gadget\n"
+	"\t                    mode and first 'identify' command from PC, in ms\n=
");
+
+U_BOOT_CMD(adnl, 3, 1, do_adnl,
+	   "ADNL protocol mode",
+	   adnl_help_text);
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index c815764c2bc..6391ceb9cfa 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -289,6 +289,8 @@ config USBNET_HOST_ADDR
=20
 endif # USB_ETHER
=20
+source "drivers/usb/gadget/amlogic/Kconfig"
+
 endif # USB_GADGET
=20
 if SPL_USB_GADGET
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 6c16ad83f6e..2b6705c52be 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_USB_FUNCTION_THOR) +=3D f_thor.o
 obj-$(CONFIG_DFU_OVER_USB) +=3D f_dfu.o
 obj-$(CONFIG_USB_FUNCTION_MASS_STORAGE) +=3D f_mass_storage.o
 obj-$(CONFIG_USB_FUNCTION_FASTBOOT) +=3D f_fastboot.o f_fastboot_common.o
+obj-$(CONFIG_ADNL) +=3D f_fastboot_common.o amlogic/adnl/
 obj-$(CONFIG_USB_FUNCTION_SDP) +=3D f_sdp.o
 obj-$(CONFIG_USB_FUNCTION_ROCKUSB) +=3D f_rockusb.o
 obj-$(CONFIG_USB_FUNCTION_ACM)	+=3D f_acm.o
diff --git a/drivers/usb/gadget/amlogic/Kconfig b/drivers/usb/gadget/amlogi=
c/Kconfig
new file mode 100644
index 00000000000..460dc6fe235
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2024 SaluteDevices, Inc.
+
+choice
+	prompt "Amlogic burning protocols"
+	optional
+
+source "drivers/usb/gadget/amlogic/adnl/Kconfig"
+
+endchoice
diff --git a/drivers/usb/gadget/amlogic/adnl/Kconfig b/drivers/usb/gadget/a=
mlogic/adnl/Kconfig
new file mode 100644
index 00000000000..21438b716ef
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/adnl/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 SaluteDevices, Inc.
+
+config ADNL
+	bool "Enable ADNL protocol"
+	depends on USB_GADGET
+	depends on MESON_A1
+	depends on MTD_SPI_NAND
+	help
+	  This enables ADNL protocol.
+
+if ADNL
+
+config ADNL_BUF_ADDR
+	hex "Define ADNL buffer address"
+	help
+	  The ADNL protocol requires a large memory buffer for
+	  downloads. Define this to the starting RAM address to use for
+	  downloaded images.
+
+config ADNL_BUF_SIZE
+	hex "Define ADNL buffer size"
+	help
+	  The ADNL protocol requires a large memory buffer for
+	  downloads. This buffer should be as large as possible for a
+	  platform. Define this to the size of available RAM for ADNL.
+
+endif
diff --git a/drivers/usb/gadget/amlogic/adnl/Makefile b/drivers/usb/gadget/=
amlogic/adnl/Makefile
new file mode 100644
index 00000000000..2b8c933a35d
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/adnl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+subdir-ccflags-y +=3D -I$(src)/../ -I$(src)/../../ -I$(src)/../../../../..=
/
+obj-y +=3D adnl_buff_manager.o adnl_media.o adnl_storage.o f_adnl.o
diff --git a/drivers/usb/gadget/amlogic/adnl/adnl.h b/drivers/usb/gadget/am=
logic/adnl/adnl.h
new file mode 100644
index 00000000000..38d57282d31
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/adnl/adnl.h
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#ifndef _ADNL_H_
+#define _ADNL_H_
+
+#include <stdarg.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+#include <linux/mtd/mtd.h>
+#include <u-boot/sha1.h>
+
+#define ADNL_FAIL_STR	"FAIL"
+
+/**
+ * adnl_store_logic_write() - Write non-boot partition.
+ *
+ * Write requested partition. This is kind of wrapper over
+ * 'nand_write_skip_bad()'.
+ *
+ * @name: partition name.
+ * @off: offset to write data.
+ * @size: size of buffer.
+ * @buf: buffer with data to write.
+ *
+ * @return: 0 on success, -errno otherwise.
+ */
+int adnl_store_logic_write(const char *name, loff_t off, size_t size, void=
 *buf);
+
+/**
+ * adnl_store_logic_read() - Read non-boot partition.
+ *
+ * Read requested partition. This is kind of wrapper over
+ * 'nand_read_skip_bad()'.
+ *
+ * @name: partition name.
+ * @off: offset to read data from.
+ * @size: size of buffer.
+ * @buf: buffer to read to.
+ *
+ * @return: 0 on success, -errno otherwise.
+ */
+int adnl_store_logic_read(const char *name, loff_t off, size_t size, void =
*buf);
+
+extern char *fb_response_str;
+
+#define ADNL_ERR(fmt, ...) pr_err("[ADNL][ERR]: " fmt, ##__VA_ARGS__)
+#define ADNL_WARN(fmt, ...) pr_warn("[ADNL][WARN] " fmt, ##__VA_ARGS__)
+#define ADNL_DBG(fmt, ...) pr_debug("[ADNL][DBG] " fmt, ##__VA_ARGS__)
+
+/* This output macro doesn't depend on CONFIG_LOGLEVEL. */
+#define ADNL_MSG(fmt, ...) printf("[ADNL][MSG] " fmt, ##__VA_ARGS__)
+
+#define RESPONSE_LEN	128
+
+#define ADNL_DOWNLOAD_MEM_BASE	CONFIG_ADNL_BUF_ADDR
+#define ADNL_DOWNLOAD_MEM_SIZE	CONFIG_ADNL_BUF_SIZE
+#define ADNL_DOWNLOAD_SPARE_SZ	(8UL << 10)
+
+#define ADNL_PART_IMG_FMT_RAW	0xabcd
+
+#define ADNL_PART_NAME_LEN	32
+
+struct adnl_img_common_param {
+	char	part_name[ADNL_PART_NAME_LEN];
+	s64	img_sz_total;
+	s64	part_start_off;
+};
+
+struct adnl_img_dw_param {
+	struct adnl_img_common_param	common_inf;
+	int	img_fmt;
+};
+
+union adnl_img_trans_param {
+	struct adnl_img_common_param	common_inf;
+	struct adnl_img_dw_param	download;
+};
+
+struct adnl_usb_dw_info {
+	int	data_size;
+	s64	file_offset;
+	char	*data_buf;
+};
+
+int adnl_buffman_img_init(union adnl_img_trans_param *img_param);
+int adnl_buffman_fill_download_info(struct adnl_usb_dw_info **download_inf=
);
+int adnl_buffman_data_complete_download(const struct adnl_usb_dw_info *dow=
nload_inf);
+int adnl_verify_partition_img(const char *verify_alg, const char *origsum_=
str,
+			      char *ack);
+
+#define BULK_EP_MPS		512
+#define DWC_BLK_MAX_LEN		(8 * BULK_EP_MPS)
+
+/**
+ * adnl_bootloader_read_n_verify() - Read boot partition.
+ *
+ * Read boot partition. This also checks, that all copies
+ * of both BL2 and TPL are valid (e.g. same).
+ *
+ * @buf: buffer to read to.
+ * @buf_len: size of buffer. Must be at least 'bootloader_len * 2'.
+ * @bootloader_len: size of BL2 + TPL images.
+ *
+ * @return: 0 on success, -errno otherwise.
+ */
+int adnl_bootloader_read_n_verify(u8 *buf, size_t buf_len, size_t bootload=
er_len);
+int adnl_media_check_image_size(s64 img_sz, const char *part_name);
+
+int adnl_mwrite_cmd_parser(unsigned long img_size, unsigned long part_off,
+			   const char *img_format, const char *media,
+			   const char *part_name, char *ack);
+
+#define ADNL_ERASE_NOTHING 	0
+#define ADNL_ERASE_NORMAL 	1
+#define ADNL_ERASE_ALL		3
+int adnl_erase_storage(int erase_mode);
+
+#endif /* _ADNL_H_ */
diff --git a/drivers/usb/gadget/amlogic/adnl/adnl_buff_manager.c b/drivers/=
usb/gadget/amlogic/adnl/adnl_buff_manager.c
new file mode 100644
index 00000000000..9e7a26ceb8e
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/adnl/adnl_buff_manager.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#include <fastboot.h>
+#include <hexdump.h>
+#include <mtd.h>
+#include <nand.h>
+#include <string.h>
+#include <time.h>
+#include <vsprintf.h>
+#include <asm/arch/spinand.h>
+#include <linux/errno.h>
+#include <linux/mtd/mtd.h>
+#include <u-boot/sha1.h>
+
+#include "adnl.h"
+
+#define RAW_IMG_TRANSFER_LEN	(128 << 10)
+#define KB			(1UL << 10)
+#define MB			(KB << 10)
+
+static struct {
+	union adnl_img_trans_param	img_trans_param;
+	int				data_buf_cap;
+	char				*data_buf;
+	int				inited;
+} img_transfer_info;
+
+static struct adnl_usb_dw_info adnl_usb_dw_info;
+static s64 raw_img_file_offset;
+
+static int adnl_img_verify_sha1sum_other(int img_fmt, sha1_context *ctx,
+					 s64 img_total_len,
+					 char *part, s64 part_base)
+{
+	unsigned char *verify_buff =3D (unsigned char *)ADNL_DOWNLOAD_MEM_BASE;
+
+	if (!strncmp(BOOT_LOADER, part, ADNL_PART_NAME_LEN)) {
+		int ret;
+
+		ret =3D adnl_bootloader_read_n_verify(verify_buff, ADNL_DOWNLOAD_MEM_SIZ=
E,
+						    img_total_len);
+		if (ret)
+			return ret;
+
+		sha1_update(ctx, verify_buff, img_total_len);
+		return 0;
+	} else {
+		size_t verify_buff_len;
+		size_t this_verify_len;
+		size_t verify_len;
+
+		if (img_fmt !=3D ADNL_PART_IMG_FMT_RAW) {
+			fastboot_response(ADNL_FAIL_STR, fb_response_str,
+					  "unknown image format %x\n", img_fmt);
+			return -EINVAL;
+		}
+
+		this_verify_len =3D 0;
+		verify_len =3D 0;
+		/* We use 2MB buffer for each SHA1 step.
+		 * Seems this is optimal value here. It
+		 * was taken from vendor's bootloader.
+		 */
+		verify_buff_len =3D 2 * MB;
+
+		/* Read partition part by part and update SHA1. */
+		for (; verify_len < img_total_len; verify_len +=3D this_verify_len) {
+			int ret;
+
+			this_verify_len =3D img_total_len - verify_len;
+			this_verify_len =3D (this_verify_len > verify_buff_len) ?
+					verify_buff_len : this_verify_len;
+
+			ret =3D adnl_store_logic_read(part, verify_len + part_base,
+						    this_verify_len, verify_buff);
+
+			if (ret) {
+				fastboot_response(ADNL_FAIL_STR, fb_response_str,
+						  "store logic read failed\n");
+				return ret;
+			}
+
+			sha1_update(ctx, verify_buff, this_verify_len);
+		}
+	}
+
+	return 0;
+}
+
+static int adnl_buffman_img_get_sha1sum(unsigned char *verify_sum)
+{
+	static sha1_context ctx;
+	struct adnl_img_common_param *img_common_param;
+	struct adnl_img_dw_param *img_down_param;
+	int ret;
+
+	img_down_param =3D &img_transfer_info.img_trans_param.download;
+	img_common_param =3D &img_down_param->common_inf;
+
+	sha1_starts(&ctx);
+
+	ret =3D adnl_img_verify_sha1sum_other(img_down_param->img_fmt, &ctx,
+					    img_common_param->img_sz_total,
+					    img_common_param->part_name,
+					    img_common_param->part_start_off);
+	if (ret)
+		return ret;
+
+	sha1_finish(&ctx, verify_sum);
+
+	return 0;
+}
+
+int adnl_verify_partition_img(const char *verify_alg, const char *origsum_=
str,
+			      char *ack)
+{
+	unsigned char gensum[SHA1_SUM_LEN] =3D { 0 };
+	char gensum_str[SHA1_SUM_LEN * 2 + 1];
+	int ret;
+
+	ret =3D strcmp(verify_alg, "sha1sum");
+	if (ret) {
+		fastboot_response(ADNL_FAIL_STR, ack,
+				  "algorithm '%s' unsupported\n", verify_alg);
+		return -EINVAL;
+	}
+
+	if (strlen(origsum_str) !=3D SHA1_SUM_LEN * 2) {
+		fastboot_response(ADNL_FAIL_STR, ack,
+				  "invalid hash len for algo %s\n", verify_alg);
+		return -EINVAL;
+	}
+
+	ret =3D adnl_buffman_img_get_sha1sum(gensum);
+	if (ret) {
+		ADNL_ERR("failed to check SHA1: %d", ret);
+		return ret;
+	}
+
+	bin2hex(gensum_str, gensum, SHA1_SUM_LEN);
+
+	ret =3D strncmp(gensum_str, origsum_str, SHA1_SUM_LEN * 2);
+	if (ret) {
+		fastboot_response(ADNL_FAIL_STR, ack, "checksum not match %s !=3D %s\n",
+				  gensum_str, origsum_str);
+		return -EINVAL;
+	}
+
+	ADNL_MSG("checksum is correct\n");
+	return 0;
+}
+
+static int adnl_nand_erase(const char *partition)
+{
+	struct erase_info ei =3D { 0 };
+	struct mtd_info *mtd;
+
+	mtd =3D get_mtd_device_nm(partition);
+	if (IS_ERR(mtd))
+		return -ENODEV;
+
+	ei.mtd =3D mtd;
+	ei.len =3D mtd->size;
+	ei.addr =3D 0;
+
+	return mtd_erase(mtd, &ei);
+}
+
+int adnl_buffman_img_init(union adnl_img_trans_param *img_param)
+{
+	struct adnl_img_common_param *common_inf;
+	char *part_name;
+	s64 img_size;
+	int ret;
+
+	common_inf =3D &img_param->common_inf;
+
+	memcpy(&img_transfer_info.img_trans_param, img_param,
+	       sizeof(union adnl_img_trans_param));
+	img_transfer_info.data_buf =3D (char *)ADNL_DOWNLOAD_MEM_BASE;
+	img_transfer_info.data_buf_cap =3D ADNL_DOWNLOAD_MEM_SIZE;
+	img_transfer_info.inited =3D 1;
+	img_size =3D common_inf->img_sz_total;
+	part_name =3D common_inf->part_name;
+
+	ret =3D adnl_media_check_image_size(img_size, part_name);
+	if (ret) {
+		ADNL_ERR("failed to check image size\n");
+		return ret;
+	}
+
+	ADNL_MSG("erasing MTD partition '%s'\n", part_name);
+
+	ret =3D adnl_nand_erase(part_name);
+	if (ret) {
+		ADNL_ERR("erasing MTD partition '%s' failed %i\n", part_name, ret);
+		return ret;
+	}
+
+	if (!strncmp(part_name, BOOT_LOADER, ADNL_PART_NAME_LEN)) {
+		/*
+		 * If passed partition name is "bootloader", then
+		 * erase "tpl" partition also. This is needed,
+		 * because image for "bootloader" partition also
+		 * contains image for "tpl".
+		 */
+		part_name =3D BOOT_TPL;
+		ret =3D adnl_nand_erase(part_name);
+		if (ret) {
+			ADNL_ERR("erasing MTD partition '%s' failed %i\n", part_name, ret);
+			return ret;
+		}
+	}
+
+	raw_img_file_offset =3D 0;
+
+	return 0;
+}
+
+static int adnl_buffman_fill_download_info_rawimg(struct adnl_img_dw_param=
 *img_param)
+{
+	struct adnl_img_common_param *cmn_inf =3D &img_param->common_inf;
+	s64 left_len;
+
+	adnl_usb_dw_info.file_offset =3D raw_img_file_offset;
+	left_len =3D cmn_inf->img_sz_total - raw_img_file_offset;
+
+	if (strncmp(BOOT_LOADER, cmn_inf->part_name, ADNL_PART_NAME_LEN))
+		/* For non "bootloader" partitions send data with
+		 * smaller blocks - such partitions are significantly
+		 * bigger.
+		 */
+		adnl_usb_dw_info.data_size =3D min_t(s64, left_len,
+						   RAW_IMG_TRANSFER_LEN);
+	else
+		adnl_usb_dw_info.data_size =3D left_len;
+
+	adnl_usb_dw_info.data_buf =3D (char *)ADNL_DOWNLOAD_MEM_BASE;
+
+	/* For next raw img download. */
+	raw_img_file_offset +=3D adnl_usb_dw_info.data_size;
+
+	return 0;
+}
+
+int adnl_buffman_fill_download_info(struct adnl_usb_dw_info **download_inf=
)
+{
+	struct adnl_img_dw_param *img_param;
+	int ret;
+
+	*download_inf =3D NULL;
+
+	if (!img_transfer_info.inited) {
+		fastboot_response(ADNL_FAIL_STR, fb_response_str,
+				  "invalid state %d\n",
+				  img_transfer_info.inited);
+		return -EINVAL;
+	}
+
+	img_param =3D &img_transfer_info.img_trans_param.download;
+
+	if (img_param->img_fmt !=3D ADNL_PART_IMG_FMT_RAW) {
+		fastboot_response(ADNL_FAIL_STR, fb_response_str,
+				  "unknown image format %x\n", img_param->img_fmt);
+		return -EINVAL;
+	}
+
+	ret =3D adnl_buffman_fill_download_info_rawimg(img_param);
+	if (ret)
+		return ret;
+
+	*download_inf =3D &adnl_usb_dw_info;
+
+	return ret;
+}
+
+static int adnl_buffman_complete_raw(const struct adnl_usb_dw_info *downlo=
ad_inf,
+				     const char *part_name,
+				     u8 *data_buf,
+				     int this_transfer_len)
+{
+	/* 'bootloader' partition has special layout on storage, so we
+	 * have special handler to work with this partition.
+	 */
+	if (!strncmp(BOOT_LOADER, part_name, ADNL_PART_NAME_LEN))
+		return meson_bootloader_write(data_buf, this_transfer_len);
+	else
+		return adnl_store_logic_write(part_name,
+					      download_inf->file_offset,
+					      this_transfer_len, data_buf);
+}
+
+int adnl_buffman_data_complete_download(const struct adnl_usb_dw_info *dow=
nload_inf)
+{
+	struct adnl_img_common_param *cmn_inf;
+	struct adnl_img_dw_param *down_inf;
+
+	down_inf =3D &img_transfer_info.img_trans_param.download;
+
+	if (down_inf->img_fmt !=3D ADNL_PART_IMG_FMT_RAW) {
+		fastboot_response(ADNL_FAIL_STR, fb_response_str,
+				  "unknown image format %x\n", down_inf->img_fmt);
+		return -EINVAL;
+	}
+
+	cmn_inf =3D &img_transfer_info.img_trans_param.common_inf;
+
+	return adnl_buffman_complete_raw(download_inf,
+					 cmn_inf->part_name,
+					 download_inf->data_buf,
+					 download_inf->data_size);
+}
diff --git a/drivers/usb/gadget/amlogic/adnl/adnl_media.c b/drivers/usb/gad=
get/amlogic/adnl/adnl_media.c
new file mode 100644
index 00000000000..ec8b8cd630a
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/adnl/adnl_media.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#include <fastboot.h>
+#include <nand.h>
+#include <stdio.h>
+#include <string.h>
+#include <vsprintf.h>
+#include <asm/arch/spinand.h>
+#include <linux/mtd/mtd.h>
+#include <linux/sizes.h>
+
+#include "adnl.h"
+
+static int adnl_store_boot_read_tpl(void *buf, size_t size, unsigned int c=
opy_idx)
+{
+	size_t retlen;
+	loff_t offset, limit;
+	struct mtd_info *mtd;
+
+	mtd =3D get_mtd_device_nm(BOOT_TPL);
+	if (IS_ERR_OR_NULL(mtd))
+		return -ENODEV;
+
+	offset =3D mtd->offset + (copy_idx * TPL_SIZE_PER_COPY);
+	limit =3D offset + TPL_SIZE_PER_COPY;
+
+	return nand_read_skip_bad(mtd->parent, offset, &size, &retlen, limit, buf=
);
+}
+
+static int adnl_store_boot_read_bl2(void *buf, unsigned int copy_idx)
+{
+	unsigned int size_per_copy;
+	struct mtd_info *mtd;
+	loff_t offset;
+	size_t length;
+
+	mtd =3D get_mtd_device_nm(BOOT_LOADER);
+	if (IS_ERR_OR_NULL(mtd))
+		return -ENODEV;
+
+	size_per_copy =3D mtd->writesize * (BL2_TOTAL_PAGES / BL2_COPY_NUM);
+	offset =3D mtd->offset + (copy_idx * size_per_copy);
+	length =3D BL2_IMAGE_SIZE_PER_COPY;
+
+	return nand_read(mtd->parent, offset, &length, buf);
+}
+
+int adnl_bootloader_read_n_verify(u8 *buf, size_t buf_len, size_t bootload=
er_len)
+{
+	unsigned int copy_idx;
+	int ret;
+
+	/* 'bootloader_len' consists of BL2 and TPL. This function
+	 * reads BL2 to 'buf' and then places TPL directly after it.
+	 * Also this function checks, that all copies of BL2 and TPL
+	 * are same. To do that, we need extra memory in 'buf': first
+	 * copy is read to the start of the buffer, then every next
+	 * copy is placed after the first one and compared to it.
+	 *
+	 * 'buf': |                                |
+	 *        |________________________________|
+	 *        ^                                ^
+	 *        |________________________________|
+	 *                    'buf_len'
+	 *
+	 *
+	 * 1) During BL2 read and checks:
+	 *
+	 * | BL2 1st |                         |
+	 * |_________|_________________________|
+	 *
+	 *
+	 * | BL2 1st | BL2 Nst |               |
+	 * |_________|_________|_______________|
+	 * ^         ^         ^
+	 * |_________|_________|
+	 *       'memcmp()'
+	 *
+	 * 2) During TPL read and checks:
+	 *
+	 * | BL2 1st | TPL 1st |               |
+	 * |_________|_________|_______________|
+	 *
+	 *
+	 * | BL2 1st | TPL 1st | TPL Nst |     |
+	 * |_________|_________|_________|_____|
+	 *           ^         ^         ^
+	 *           |_________|_________|
+	 *                 'memcmp()'
+	 *
+	 * 3) Final state of the buffer:
+	 *
+	 * | BL2 1st | TPL 1st |               |
+	 * |_________|_________|_______________|
+	 * ^                   ^
+	 * |___________________|
+	 *    'bootloader_len'
+	 *
+	 * For simple and rude check this is enough:
+	 */
+	if ((bootloader_len << 1) > buf_len)
+		return -EINVAL;
+
+	for (copy_idx =3D 0; copy_idx < BL2_COPY_NUM; copy_idx++) {
+		void *data_buf =3D buf + BL2_IMAGE_SIZE_PER_COPY * !!copy_idx;
+
+		ret =3D adnl_store_boot_read_bl2(data_buf, copy_idx);
+		if (ret) {
+			fastboot_response(ADNL_FAIL_STR, fb_response_str,
+					  "failed to read part BL2:'%u'\n", copy_idx);
+			return ret;
+		}
+
+		/* All copies must be valid. Otherwise - something goes wrong. */
+		if (copy_idx) {
+			if (memcmp(buf, data_buf, BL2_IMAGE_SIZE_PER_COPY)) {
+				fastboot_response(ADNL_FAIL_STR, fb_response_str,
+						  "boot part 'BL2':'%u' mismatch\n",
+						  copy_idx);
+				return -EIO;
+			}
+		}
+	}
+
+	/* Now we place TPL to 'buf'. 'bootloader_len' will be TPL length. */
+	buf +=3D BL2_IMAGE_SIZE_PER_COPY;
+	bootloader_len -=3D BL2_IMAGE_SIZE_PER_COPY;
+
+	for (copy_idx =3D 0; copy_idx < TPL_COPY_NUM; copy_idx++) {
+		void *data_buf =3D buf + bootloader_len * !!copy_idx;
+
+		ret =3D adnl_store_boot_read_tpl(data_buf, bootloader_len, copy_idx);
+		if (ret) {
+			fastboot_response(ADNL_FAIL_STR, fb_response_str,
+					  "failed to read part TPL:'%i'\n", copy_idx);
+			return ret;
+		}
+
+		/* All copies must be valid. Otherwise - something goes wrong. */
+		if (copy_idx) {
+			if (memcmp(buf, data_buf, bootloader_len)) {
+				fastboot_response(ADNL_FAIL_STR, fb_response_str,
+						  "boot part TPL:'%i' mismatch\n", copy_idx);
+				return -EIO;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static uint64_t adnl_store_part_size(const char *part_name)
+{
+	struct mtd_info *mtd;
+
+	if (!strcmp(part_name, BOOT_BL2) ||
+	    !strcmp(part_name, BOOT_SPL)) {
+		mtd =3D get_mtd_device_nm(BOOT_LOADER);
+	} else if (!strcmp(part_name, BOOT_TPL) ||
+		   !strcmp(part_name, BOOT_FIP)) {
+		mtd =3D get_mtd_device_nm(BOOT_TPL);
+	} else {
+		mtd =3D get_mtd_device_nm(part_name);
+	}
+
+	if (IS_ERR_OR_NULL(mtd))
+		return 0;
+
+	return mtd->size;
+}
+
+int adnl_media_check_image_size(s64 img_sz, const char *part_name)
+{
+	u64 part_cap;
+
+	if (!strcmp(BOOT_LOADER, part_name)) {
+		unsigned int boot_size =3D BL2_IMAGE_SIZE_PER_COPY + TPL_SIZE_PER_COPY;
+
+		if (img_sz > boot_size) {
+			fastboot_response(ADNL_FAIL_STR, fb_response_str,
+					  "image size %lld > boot size %u\n",
+					  img_sz, boot_size);
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	part_cap =3D adnl_store_part_size(part_name);
+	if (!part_cap) {
+		ADNL_ERR("failed to get size for part %s\n", part_name);
+		return -ENODEV;
+	}
+
+	if (img_sz > part_cap) {
+		ADNL_ERR("img size %lld > part size %llu\n", img_sz, part_cap);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int adnl_mwrite_cmd_parser(unsigned long img_size, unsigned long part_off,
+			   const char *img_format, const char *media,
+			   const char *part_name, char *ack)
+{
+	union adnl_img_trans_param img_trans_param =3D { 0 };
+	struct adnl_img_dw_param *img_download_param;
+	struct adnl_img_common_param *common_info;
+
+	if (strcmp(img_format, "normal")) {
+		fastboot_response(ADNL_FAIL_STR, ack,
+				  "unknown image format %s", img_format);
+		return -EINVAL;
+	}
+
+	if (strcmp(media, "store")) {
+		fastboot_response(ADNL_FAIL_STR, ack,
+				  "unknown media '%s'", media);
+		return -EINVAL;
+	}
+
+	img_download_param =3D &img_trans_param.download;
+	common_info =3D &img_download_param->common_inf;
+	common_info->img_sz_total =3D img_size;
+	common_info->part_start_off =3D part_off;
+
+	img_download_param->img_fmt =3D ADNL_PART_IMG_FMT_RAW;
+	strlcpy(common_info->part_name, part_name, ADNL_PART_NAME_LEN);
+
+	return adnl_buffman_img_init(&img_trans_param);
+}
diff --git a/drivers/usb/gadget/amlogic/adnl/adnl_storage.c b/drivers/usb/g=
adget/amlogic/adnl/adnl_storage.c
new file mode 100644
index 00000000000..99dc4af7627
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/adnl/adnl_storage.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#include <nand.h>
+#include <string.h>
+#include <asm/arch/spinand.h>
+#include <linux/printk.h>
+#include <linux/mtd/mtd.h>
+#include <linux/sizes.h>
+#include <linux/mtd/spinand.h>
+
+#include "adnl.h"
+
+static int adnl_store_get_offset(const char *partname,
+				 loff_t *retoff, loff_t off)
+{
+	struct mtd_info *mtd_info;
+
+	if (!strcmp(partname, BOOT_BL2))
+		mtd_info =3D get_mtd_device_nm(BOOT_LOADER);
+	else
+		mtd_info =3D get_mtd_device_nm(partname);
+
+	if (IS_ERR_OR_NULL(mtd_info))
+		return -ENODEV;
+
+	*retoff =3D off + mtd_info->offset;
+
+	return 0;
+}
+
+int adnl_store_logic_write(const char *name, loff_t off, size_t size, void=
 *buf)
+{
+	struct mtd_info *mtd;
+	size_t retlen;
+	loff_t offset;
+	int ret;
+
+	ret =3D adnl_store_get_offset(name, &offset, off);
+	if (ret)
+		return ret;
+
+	mtd =3D get_mtd_device_nm(name);
+	if (IS_ERR_OR_NULL(mtd))
+		return -ENODEV;
+
+	return nand_write_skip_bad(mtd, off, &size, &retlen, mtd->size, buf, 0);
+}
+
+int adnl_store_logic_read(const char *name, loff_t off, size_t size, void =
*buf)
+{
+	struct mtd_info *mtd;
+	size_t retlen;
+	loff_t offset;
+	int ret;
+
+	ret =3D adnl_store_get_offset(name, &offset, off);
+	if (ret)
+		return ret;
+
+	mtd =3D get_mtd_device_nm(name);
+	if (IS_ERR_OR_NULL(mtd))
+		return -ENODEV;
+
+	return nand_read_skip_bad(mtd, off, &size, &retlen, mtd->size, buf);
+}
+
+static bool adnl_must_skip_block(struct mtd_info *mtd, off_t offset)
+{
+	if (mtd_block_isbad(mtd, offset))
+		return true;
+
+	if (mtd_block_isreserved(mtd, offset))
+		return true;
+
+	return false;
+}
+
+int adnl_erase_storage(int erase_mode)
+{
+	switch (erase_mode) {
+	case ADNL_ERASE_NOTHING:
+		ADNL_MSG("Erase nothing...\n");
+		return 0;
+	case ADNL_ERASE_ALL:
+		/* Full erase includes erasing reserved areas:
+		 * 1) "key" area.
+		 * 2) Bad block table.
+		 * 3) Some other blocks, marked as "bad" or "reserved".
+		 *
+		 * Currently it is not supported.
+		 */
+		ADNL_MSG("Full erase is not supported, fallback to normal\n");
+		/* Fall through */
+	case ADNL_ERASE_NORMAL: {
+		struct mtd_info *mtd;
+		off_t offset;
+
+		ADNL_MSG("Erase normal...\n");
+		/*
+		 * "bootloader" is always present in ADNL, so use it to
+		 * get MTD device for the entire NAND chip.
+		 */
+		mtd =3D get_mtd_device_nm(BOOT_LOADER);
+		if (!mtd || !mtd->parent)
+			return -ENODEV;
+
+		mtd =3D mtd->parent;
+
+		for (offset =3D 0; offset < mtd->size; offset +=3D mtd->erasesize) {
+			struct erase_info erase_op =3D {};
+			int ret;
+
+			if (adnl_must_skip_block(mtd, offset))
+				continue;
+
+			erase_op.mtd =3D mtd;
+			erase_op.addr =3D offset;
+			erase_op.len =3D mtd->erasesize;
+
+			ret =3D mtd_erase(mtd, &erase_op);
+			if (ret) {
+				ADNL_ERR("Can't erase block at %lx\n",
+					  offset);
+				return ret;
+			}
+		}
+
+		ADNL_MSG("Erased ok\n");
+
+		return 0;
+	}
+	default:
+		ADNL_ERR("Unknown erase mode %d\n", erase_mode);
+		return -EINVAL;
+	}
+}
diff --git a/drivers/usb/gadget/amlogic/adnl/f_adnl.c b/drivers/usb/gadget/=
amlogic/adnl/f_adnl.c
new file mode 100644
index 00000000000..0b772acc4e4
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/adnl/f_adnl.c
@@ -0,0 +1,835 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+/*
+ * Implementation of ADNL protocol.
+ *
+ * ADNL is Amlogic protocol for updating firmware images. It
+ * looks like fastboot, but:
+ * 1) Works only on Amlogic boards, as it uses SoC specific features in
+ *    its commands (for example special registers, SMC calls, bootROM
+ *    behaviour).
+ * 2) It uses Amlogic specific image format to update firmware - such
+ *    image contains different images inside - BL2, U-boot and partitions.
+ * 3) It works only over USB transport.
+ * 4) Minimal part (to run BL2 and U-boot from memory) is implemented in
+ *    the bootROM code inside Amlogic boards, so this protocol is a good
+ *    tool to "resurrect" boards with for example corrupted bootloader.
+ *
+ * There are two possible operating modes for this protocol:
+ * * Updating from bootROM.
+ *   1) Device stops booting in the boot ROM and enters USB gadget mode
+ *      introducing itself as ADNL device.
+ *   2) PC adnl-client sends BL2 and U-boot to the board, which are
+ *      executed in memory and finally U-boot checks sticky registers
+ *      and when it detects that we in ADNL mode, it runs command 'adnl'
+ *      (e.g. without continue booting to the command line or autoboot
+ *      sequence).
+ *   3) Boards enters USB gadget mode again still introducing itself as
+ *      ADNL device.
+ *   4) PC application continue ADNL operations (see NOTES#1 for more
+ *      details).
+ *
+ * * Updating from U-boot command line.
+ *   1) U-boot runs 'adnl' command (run from script or entered by user).
+ *   2) ADNL logic in U-boot tells BL1 not to load BL2 and next loaders
+ *      from storage, but receive it by USB data path. This feature is
+ *      implemented by the special SMC call.
+ *   3) ADNL logic in U-boot reboots board.
+ *   4) BL1 receives BL2 and U-boot from USB. Now Goto 2) from list
+ *      above (e.g. 'Updating from bootROM').
+ *
+ * Protocol operation flow:
+ *
+ * To start protocol operations PC sends several commands:
+ * 'getvar identify' - tells PC some hardcoded fw version.
+ * 'oem setvar burnsteps' - performs writes to sticky registers.
+ * 'oem disk_initial' - this is suppressed in this implementation by
+ *                      always success wrapper.
+ * 'getvar secureboot' - this is suppressed in this implementation by
+ *                       always success wrapper.
+ *
+ * After this exchange, stage for data transmission and writing is
+ * started. Data is transmitted and written in 'per-partition' way.
+ *
+ * To send and write each partition the following commands sequence is
+ * executed:
+ *
+ * 1) PC sends 'oem mwrite <size> normal store <part name>'. This will
+ *    erase MTD partition and tells ADNL logic on the board to receive
+ *    specified number of bytes and later write all of them to the
+ *    <part name>. More, <size> here is size of the entire image.
+ *
+ * 2) Devices replies 'OKAY'.
+ *
+ * 3) PC sends 'mwrite verify=3Daddsum'.
+ *
+ * 4) Device replies 'DATAOUT:<size>:<offs>', where <size> is number
+ *    of bytes which device is ready to process and <offs> is offset in
+ *    image to send data from. Note, <size> here is size of entire image
+ *    only for "bootloader" image, for another images it is 128KB. See
+ *    RAW_IMG_TRANSFER_LEN.
+ *
+ * 5) PC sends data. There are no protocol commands in this type of
+ *    packet - just raw data. Size of packet is USB specific and is
+ *    not related to the <size> from 2).
+ *
+ * 6) Device replies with empty packet.
+ *
+ * 7) Device checks that requested amount of data (<size> from 4)) is
+ *    received. If no, goto 3) (e.g. continue receiving data from PC).
+ *    If so, device performs simple checksum verification using algorithm
+ *    from 'adnl_csum_special()' (because of parameter 'verify=3Daddsum') =
from
+ *    3). Original checksum is transferred in the tail bytes of the last
+ *    USB packet for the current portion of data. If verification is
+ *    successful, device write data to storage and replies 'OKAY'.
+ *
+ * 8) If not all bytes from 1) are processed, goto 3) (e.g. receive next
+ *    portion of data from PC starting from next offset in the image).
+ *
+ * 9) PC sends 'oem verify <algo> <hash>'. It means check partition from
+ *    1) with algorithm <algo>, it's hash must be equal to the <hash>.
+ *    Currently only 'sha1sum' is supported as <algo>. Note, in this step
+ *    device reads whole partition part by part (as verification algo
+ *    allows) from storage and calculates its hash. If hash verification
+ *    is successful, device replies 'OKAY'.
+ *
+ * NOTES#2:
+ * Current implementation has limited set of ADNL features and commands.
+ * It was tested only on A1 SoC with one image of specific layout/content
+ * (BL2, TPL, etc.).
+ *
+ * NOTES#3:
+ * "bootloader" partition has special layout: BL2 and TPL are saved as
+ * several copies of each other with specific alignment.
+ *
+ * NOTES#4:
+ * This implementation requires that data buffer address and size to be
+ * set in the config file. This buffers will be used for both IN and OUT
+ * USB data.
+ */
+
+#include <cli.h>
+#include <command.h>
+#include <env.h>
+#include <fastboot.h>
+#include <g_dnl.h>
+#include <asm/arch-meson/a1.h>
+#include <asm/arch-meson/sm.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <u-boot/sha1.h>
+
+#include "adnl.h"
+#include "f_fastboot_common.h"
+#include "cmd/meson/gadget.h"
+
+#define ADNL_CMD_GETVAR		"getvar:"
+#define ADNL_CMD_OEM		"oem"
+#define ADNL_CMD_DOWNLOAD	"download:"
+#define ADNL_CMD_UPDATE		"update"
+#define ADNL_CMD_REBOOT		"reboot"
+#define ADNL_CMD_MWRITE		"mwrite"
+
+static char adnl_ext_prop_name[] =3D "DeviceInterfaceGUID";
+static char adnl_ext_prop_data[] =3D "{4866319A-F4D6-4374-93B9-DC2DEB361BA=
9}";
+
+static struct usb_os_desc_ext_prop adnl_ext_prop =3D {
+	.type =3D 1,
+	.name =3D adnl_ext_prop_name, /* NUL-terminated Unicode String (REG_SZ) *=
/
+	.data =3D adnl_ext_prop_data,
+};
+
+/* 16 bytes of "Compatible ID" and "Subcompatible ID" */
+static char adnl_cid[16] =3D {'W', 'I', 'N', 'U', 'S', 'B'};
+static struct usb_os_desc adnl_os_desc =3D {
+	.ext_compat_id =3D adnl_cid,
+};
+
+static struct usb_os_desc_table adnl_os_desc_table =3D {
+	.os_desc =3D &adnl_os_desc,
+};
+
+static struct fastboot_funcs *adnl_func;
+static unsigned int download_size;
+static unsigned int download_bytes;
+
+static const char adnl_name[] =3D "Amlogic DNL";
+
+static struct usb_string adnl_string_defs[] =3D {
+	[0].s =3D adnl_name,
+	{  } /* end of list */
+};
+
+static struct usb_gadget_strings stringtab_adnl =3D {
+	.language	=3D 0x0409,	/* en-us */
+	.strings	=3D adnl_string_defs,
+};
+
+static struct usb_gadget_strings *adnl_strings[] =3D {
+	&stringtab_adnl,
+	NULL,
+};
+
+static char response_str[RESPONSE_LEN + 1];
+char *fb_response_str =3D &response_str[4];
+
+enum {
+	MWRITE_DATA_CHECK_ALG_NONE  =3D 0, /* Not need checksum. */
+	MWRITE_DATA_CHECK_ALG_ADDSUM,
+};
+
+struct adnl_mwrite_info {
+	unsigned int	total_bytes;
+	unsigned int	transferred_bytes;
+	unsigned int	data_check_alg;
+	void		*priv;
+};
+
+static struct adnl_mwrite_info adnl_mwrite_info;
+static struct adnl_usb_dw_info *adnl_usb_dw_info;
+
+static int adnl_tx_write(const char *buffer, unsigned int buffer_size)
+{
+	struct usb_request *in_req =3D adnl_func->in_req;
+	int ret;
+
+	memcpy(in_req->buf, buffer, buffer_size);
+	in_req->length =3D buffer_size;
+
+	ret =3D usb_ep_queue(adnl_func->in_ep, in_req, 0);
+	if (ret)
+		ADNL_ERR("error %d on queueing %u bytes from tx buf\n", ret,
+			 buffer_size);
+
+	return 0;
+}
+
+static int adnl_tx_write_str(const char *buffer)
+{
+	return adnl_tx_write(buffer, strlen(buffer));
+}
+
+static void adnl_rx_handler_command(struct usb_ep *ep, struct usb_request =
*req);
+
+static int dwc_blk_len(int left_sz)
+{
+	if (left_sz >=3D DWC_BLK_MAX_LEN)
+		return DWC_BLK_MAX_LEN;
+
+	if (left_sz >=3D BULK_EP_MPS)
+		return (left_sz / BULK_EP_MPS) * BULK_EP_MPS;
+
+	return left_sz;
+}
+
+static unsigned int adnl_csum_special(const void *p_buf, const unsigned in=
t size)
+{
+	const unsigned int *data =3D (const unsigned int *)p_buf;
+	unsigned int word_len =3D size >> 2;
+	unsigned int rest =3D size & 0x3;
+	unsigned int sum =3D 0;
+
+	while (word_len--)
+		sum +=3D *data++;
+
+	if (rest)
+		sum +=3D (*data) & GENMASK(rest * 8, 0);
+
+	return sum;
+}
+
+#define EP_CMD_LEN_MAX 256
+/* This is input handler for raw image data. */
+static void rx_handler_mwrite(struct usb_ep *ep, struct usb_request *req)
+{
+	unsigned int transfer_size =3D req->actual;
+	char *data_buf =3D adnl_usb_dw_info->data_buf;
+	int ret =3D 0;
+
+	if (req->status) {
+		ADNL_ERR("Bad status: %d\n", req->status);
+		return;
+	}
+
+	adnl_mwrite_info.transferred_bytes +=3D transfer_size;
+
+	/* Check if transfer is done */
+	if (adnl_mwrite_info.transferred_bytes =3D=3D adnl_mwrite_info.total_byte=
s &&
+	    adnl_mwrite_info.data_check_alg > MWRITE_DATA_CHECK_ALG_NONE) {
+		/* This is one before last packet with data. */
+		req->length =3D 4; /* For rx addsum. */
+		req->buf +=3D transfer_size;
+
+		req->buf =3D (char *)ALIGN((s64)req->buf, 8);
+	} else if (adnl_mwrite_info.transferred_bytes >=3D adnl_mwrite_info.total=
_bytes) {
+		fastboot_okay(NULL, response_str);
+		response_str[4] =3D 0;
+
+		/* Calculate checksum for just transferred part of data. */
+		if (adnl_mwrite_info.data_check_alg =3D=3D MWRITE_DATA_CHECK_ALG_ADDSUM)=
 {
+			unsigned int data_len =3D adnl_mwrite_info.total_bytes;
+			unsigned int gensum =3D adnl_csum_special(data_buf, data_len);
+			unsigned int origsum;
+
+			origsum =3D *(unsigned int *)ALIGN((s64)(data_buf + data_len), 8);
+
+			if (gensum !=3D origsum) {
+				ADNL_MSG("checksum not match %x !=3D %x\n", gensum, origsum);
+				fastboot_response(ADNL_FAIL_STR, response_str,
+						  "checksum not match %x !=3D %x\n",
+						  gensum, origsum);
+				ret =3D -EINVAL;
+			}
+		}
+
+		/* Checksum verification is done, write this part of image. */
+		if (!ret)
+			ret =3D adnl_buffman_data_complete_download(adnl_usb_dw_info);
+
+		if (ret)
+			fastboot_fail(NULL, response_str);
+		else
+			fastboot_okay(NULL, response_str);
+
+		adnl_tx_write_str(response_str);
+		ADNL_MSG("response[%d][%s]\n", ret, response_str);
+		ADNL_DBG("mwrite 0x%x bytes [%s]\n", adnl_mwrite_info.transferred_bytes,
+			 ret ? "FAILED" : "OK");
+		/* Set default receive callback for handling ADNL commands.
+		 * We are ready to receive next portion of data or image is
+		 * already transferred.
+		 */
+		req->complete =3D adnl_rx_handler_command;
+		req->length =3D EP_CMD_LEN_MAX;
+
+		if (adnl_mwrite_info.priv)
+			req->buf =3D (char *)adnl_mwrite_info.priv;
+	} else {
+		unsigned int left_len =3D adnl_mwrite_info.total_bytes -
+					adnl_mwrite_info.transferred_bytes;
+
+		/* Continue receiving data. */
+		req->length =3D dwc_blk_len(left_len);
+		req->buf +=3D transfer_size;
+	}
+
+	req->actual =3D 0;
+	usb_ep_queue(ep, req, 0);
+}
+
+static int adnl_bind(struct usb_configuration *c, struct usb_function *f)
+{
+	return fastboot_common_bind(c, f, &adnl_os_desc_table,
+				    &adnl_os_desc,
+				    (struct usb_string **)&adnl_string_defs,
+				    &adnl_ext_prop);
+}
+
+static void adnl_unbind(struct usb_configuration *c, struct usb_function *=
f)
+{
+	fastboot_common_unbind(c, f, &adnl_os_desc);
+	memset(adnl_func, 0, sizeof(*adnl_func));
+}
+
+static void adnl_disable(struct usb_function *f)
+{
+	fastboot_common_disable(f);
+}
+
+static int adnl_set_alt(struct usb_function *f,
+			unsigned int interface, unsigned int alt)
+{
+	amlogic_gadget_set_times(0, get_timer(0));
+	return fastboot_common_set_alt(f, interface, alt, adnl_rx_handler_command=
);
+}
+
+static int adnl_add(struct usb_configuration *c)
+{
+	struct fastboot_funcs *f_adnl =3D adnl_func;
+	int status;
+
+	if (!f_adnl) {
+		f_adnl =3D memalign(CONFIG_SYS_CACHELINE_SIZE, sizeof(*f_adnl));
+		if (!f_adnl)
+			return -ENOMEM;
+
+		adnl_func =3D f_adnl;
+		memset(f_adnl, 0, sizeof(*f_adnl));
+	}
+
+	g_dnl_set_product("DNL");
+	f_adnl->usb_function.name =3D "f_adnl";
+	f_adnl->usb_function.bind =3D adnl_bind;
+	f_adnl->usb_function.unbind =3D adnl_unbind;
+	f_adnl->usb_function.set_alt =3D adnl_set_alt;
+	f_adnl->usb_function.disable =3D adnl_disable;
+	f_adnl->usb_function.strings =3D adnl_strings;
+
+	status =3D usb_add_function(c, &f_adnl->usb_function);
+	if (status) {
+		free(f_adnl);
+		adnl_func =3D NULL;
+	}
+
+	return status;
+}
+
+DECLARE_GADGET_BIND_CALLBACK(usb_dnl_adnl, adnl_add);
+
+struct cmd_getvar_dispatch_info {
+	char *cmd;
+	void (*cb)(char *response, size_t *reply_len);
+};
+
+static void cb_getvar_identify(char *response, size_t *reply_len)
+{
+	const char adnl_ver[] =3D {5, 0, 0, 16, 0, 0, 0, 0};
+
+	ADNL_MSG("executing identify cmd\n");
+
+	memcpy(response, adnl_ver, sizeof(adnl_ver));
+	*reply_len =3D sizeof(adnl_ver);
+	amlogic_gadget_set_times(0, 0);
+}
+
+static int adnl_is_secureboot_enabled(void)
+{
+	/* TODO: support secureboot. */
+	return 0;
+}
+
+static void cb_getvar_secureboot(char *response, size_t *reply_len)
+{
+	unsigned int secureboot_enable;
+
+	secureboot_enable =3D adnl_is_secureboot_enabled();
+	memcpy(response, &secureboot_enable, sizeof(unsigned int));
+	*reply_len =3D sizeof(unsigned int);
+}
+
+static const struct cmd_getvar_dispatch_info cmd_getvar_dispatch_info[] =
=3D {
+	{
+		.cmd =3D "identify",
+		.cb =3D cb_getvar_identify,
+	},
+	{
+		.cmd =3D "secureboot",
+		.cb =3D cb_getvar_secureboot,
+	},
+};
+
+static void cb_getvar(struct usb_request *req)
+{
+	void (*func_cb)(char *response, size_t *reply_len);
+	char *cmd =3D req->buf;
+	char cmd_buf[RESPONSE_LEN];
+	char *response =3D response_str;
+	size_t chars_left;
+	size_t reply_len;
+	int i;
+
+	strcpy(response, "OKAY");
+	chars_left =3D sizeof(response_str) - strlen(response) - 1;
+
+	memcpy(cmd_buf, cmd, strnlen(cmd, RESPONSE_LEN - 1) + 1);
+	cmd =3D cmd_buf;
+	strsep(&cmd, ":");
+
+	if (!cmd || cmd[0] =3D=3D '\0') {
+		fastboot_response(ADNL_FAIL_STR, response, "missing var\n");
+		adnl_tx_write_str(response);
+		return;
+	}
+
+	func_cb =3D NULL;
+
+	for (i =3D 0; i < ARRAY_SIZE(cmd_getvar_dispatch_info); i++) {
+		if (!strncmp(cmd_getvar_dispatch_info[i].cmd, cmd,
+			     strlen(cmd_getvar_dispatch_info[i].cmd))) {
+			func_cb =3D cmd_getvar_dispatch_info[i].cb;
+			break;
+		}
+	}
+
+	reply_len =3D 0;
+
+	if (!func_cb) {
+		ADNL_ERR("unknown variable: %s\n", cmd);
+		adnl_tx_write_str(ADNL_FAIL_STR "unknown variable");
+	} else {
+		reply_len =3D chars_left;
+		func_cb(response_str + 4, &reply_len);
+		reply_len +=3D 4;
+	}
+
+	if (!reply_len)
+		reply_len =3D strlen(response) + 1;
+
+	adnl_tx_write(response, reply_len);
+}
+
+static int adnl_set_var(const char *name, const char *value)
+{
+	if (!strcmp("burnsteps", name)) {
+		unsigned int val =3D simple_strtoul(value, NULL, 0);
+
+		writel(val, A1_SYSCTRL_SEC_STICKY_REG2);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void cb_oem_cmd(struct usb_request *req)
+{
+	char *argv[CONFIG_SYS_MAXARGS + 1];
+	char tmp[RESPONSE_LEN + 1];
+	char *cmd =3D req->buf;
+	char *ack =3D response_str + 4;
+	char *cmd_buf =3D tmp;
+	int ret, argc;
+
+	ack[0] =3D '\0';
+	memcpy(cmd_buf, cmd, strnlen(cmd, RESPONSE_LEN) + 1);
+	strsep(&cmd_buf, " ");
+	response_str[4] =3D 0;
+
+	argc =3D cli_simple_parse_line(cmd_buf, argv);
+
+	if (!argc) {
+		fastboot_fail("oem no command at all", response_str);
+		ADNL_ERR("%s\n", response_str);
+		return;
+	}
+
+	if (!strcmp("mwrite", argv[0])) {
+		if (argc < 5) {
+			ret =3D -EINVAL;
+		} else {
+			unsigned long img_size;
+			unsigned long part_off;
+
+			img_size =3D simple_strtoul(argv[1], NULL, 0);
+			part_off =3D argc > 5 ? simple_strtoul(argv[5], NULL, 0) : 0;
+			ret =3D adnl_mwrite_cmd_parser(img_size, part_off, argv[2],
+						     argv[3], argv[4], ack);
+		}
+	} else if (!strcmp("verify", argv[0])) {
+		ret =3D adnl_verify_partition_img(argv[1], argv[2], ack);
+	} else if (!strcmp("disk_initial", argv[0])) {
+		int erase_mode =3D argc > 1 ? simple_strtoul(argv[1], NULL, 0) : 0;
+
+		ret =3D adnl_erase_storage(erase_mode);
+	} else if (!strcmp("save_setting", argv[0])) {
+		ADNL_MSG("saveenv not implemented\n");
+		ret =3D 0;
+	} else if (!strcmp("setvar", argv[0])) {
+		if (argc < 2)
+			ret =3D -EINVAL;
+		else
+			ret =3D adnl_set_var(argv[1], argv[2]);
+	} else {
+		strsep(&cmd, " ");
+		ret =3D run_command(cmd, 0);
+		if (ret)
+			fastboot_response(ADNL_FAIL_STR, ack,
+					  "fail in cmd[%s]", cmd);
+	}
+
+	if (ret)
+		fastboot_fail(NULL, response_str);
+	else
+		fastboot_okay(NULL, response_str);
+
+	adnl_tx_write_str(response_str);
+	ADNL_MSG("response[%d][%s]\n", ret, response_str);
+}
+
+static void cb_aml_media_write(struct usb_request *req)
+{
+	char *cmd =3D req->buf;
+	const char *field;
+	int ret;
+
+	ADNL_DBG("cmd cb_mwrite[%s]\n", cmd);
+
+	strsep(&cmd, ":");
+	field =3D cmd;
+	response_str[4] =3D 0;
+
+	adnl_mwrite_info.data_check_alg =3D MWRITE_DATA_CHECK_ALG_NONE;
+	adnl_mwrite_info.transferred_bytes =3D 0;
+
+	for (strsep(&cmd, "=3D"); cmd; ) {
+		if (!strcmp(field, "verify")) {
+			if (!strcmp("addsum", cmd)) {
+				adnl_mwrite_info.data_check_alg =3D MWRITE_DATA_CHECK_ALG_ADDSUM;
+			} else {
+				fastboot_response(ADNL_FAIL_STR, fb_response_str,
+						  "unknown data check algo '%s'\n", cmd);
+				fastboot_fail(NULL, response_str);
+				return;
+			}
+		} else {
+			snprintf(response_str, sizeof(response_str),
+				ADNL_FAIL_STR "unknown field '%s'\n", field);
+			ADNL_ERR("%s", response_str);
+			ret =3D -EINVAL;
+			goto _exit;
+		}
+
+		strsep(&cmd, ",");
+		strsep(&cmd, "=3D");
+	}
+
+	ret =3D adnl_buffman_fill_download_info(&adnl_usb_dw_info);
+	if (ret || !adnl_usb_dw_info) {
+		fastboot_response(ADNL_FAIL_STR, fb_response_str,
+				  "Fail in buffman get, ret %d", ret);
+		goto _exit;
+	}
+
+	adnl_mwrite_info.total_bytes =3D adnl_usb_dw_info->data_size;
+	ret =3D 0;
+
+_exit:
+	if (ret) {
+		fastboot_fail(NULL, response_str);
+	} else if (!adnl_usb_dw_info->data_size) {
+		fastboot_okay(NULL, response_str);
+		ADNL_MSG("OK in Partition Image\n");
+	} else {
+		unsigned int left_len;
+
+		snprintf(response_str, sizeof(response_str),
+			 "DATAOUT0x%x:0x%llx", adnl_usb_dw_info->data_size,
+			 adnl_usb_dw_info->file_offset);
+		req->complete =3D rx_handler_mwrite;
+		left_len =3D adnl_mwrite_info.total_bytes -
+			   adnl_mwrite_info.transferred_bytes;
+		req->length =3D dwc_blk_len(left_len);
+
+		if (!adnl_mwrite_info.priv)
+			adnl_mwrite_info.priv =3D req->buf;
+
+		req->buf =3D adnl_usb_dw_info->data_buf;
+	}
+
+	adnl_tx_write_str(response_str);
+}
+
+static unsigned int rx_bytes_expected(void)
+{
+	int rx_remain =3D download_size - download_bytes;
+
+	if (rx_remain < 0)
+		return 0;
+
+	if (rx_remain > EP_BUFFER_SIZE)
+		return EP_BUFFER_SIZE;
+
+	return rx_remain;
+}
+
+#define BYTES_PER_DOT   0x20000
+static void rx_handler_dl_image(struct usb_ep *ep, struct usb_request *req=
)
+{
+	unsigned int transfer_size =3D download_size - download_bytes;
+	unsigned char *buffer =3D req->buf;
+	unsigned int buffer_size =3D req->actual;
+	unsigned int pre_dot_num, now_dot_num;
+
+	if (req->status) {
+		ADNL_ERR("Bad status: %d\n", req->status);
+		return;
+	}
+
+	if (buffer_size < transfer_size)
+		transfer_size =3D buffer_size;
+
+	memcpy((u8 *)CONFIG_FASTBOOT_BUF_ADDR + download_bytes,
+	       buffer, transfer_size);
+
+	pre_dot_num =3D download_bytes / BYTES_PER_DOT;
+	download_bytes +=3D transfer_size;
+	now_dot_num =3D download_bytes / BYTES_PER_DOT;
+
+	if (pre_dot_num !=3D now_dot_num) {
+		putc('.');
+
+		/* 65 is progress bar size, same as in TFTP. */
+		if (!(now_dot_num % 65))
+			putc('\n');
+	}
+
+	/* Check if transfer is done */
+	if (download_bytes >=3D download_size) {
+		char response[RESPONSE_LEN];
+		static char EP_CMD_BUF[EP_CMD_LEN_MAX * 2];
+
+		/*
+		 * Reset global transfer variable, keep download_bytes because
+		 * it will be used in the next possible flashing command
+		 */
+		download_size =3D 0;
+		req->complete =3D adnl_rx_handler_command;
+		req->length =3D EP_CMD_LEN_MAX;
+		req->buf =3D &EP_CMD_BUF[0];
+
+		sprintf(response, "OKAY");
+		adnl_tx_write_str(response);
+
+		ADNL_MSG("\ndownloading of %u bytes finished\n", download_bytes);
+	} else {
+		req->length =3D rx_bytes_expected();
+
+		if (req->length < ep->maxpacket)
+			req->length =3D ep->maxpacket;
+	}
+
+	req->actual =3D 0;
+	usb_ep_queue(ep, req, 0);
+}
+
+static void cb_download(struct usb_request *req)
+{
+	char *cmd =3D req->buf;
+	char response[RESPONSE_LEN];
+
+	strsep(&cmd, ":");
+	download_size =3D simple_strtoul(cmd, NULL, 16);
+	download_bytes =3D 0;
+
+	if (!download_size) {
+		fastboot_fail(response, "data invalid size");
+	} else if (download_size > ADNL_DOWNLOAD_MEM_SIZE) {
+		download_size =3D 0;
+		fastboot_fail(response, "data too large");
+	} else {
+		sprintf(response, "DATA%08x", download_size);
+		req->complete =3D rx_handler_dl_image;
+		req->buf =3D (char *)CONFIG_ADNL_BUF_ADDR;
+		req->length =3D rx_bytes_expected();
+	}
+
+	adnl_tx_write_str(response);
+}
+
+static void adnl_complete_do_reboot(struct usb_ep *ep, struct usb_request =
*req)
+{
+	do_reset(NULL, 0, 0, NULL);
+}
+
+static void adnl_complete_do_reboot_bootloader(struct usb_ep *ep, struct u=
sb_request *req)
+{
+	run_command("reboot bootloader", 0);
+}
+
+static void adnl_complete_do_reboot_bl1usb(struct usb_ep *ep, struct usb_r=
equest *req)
+{
+	/*
+	 * Reboot into bootROM (BL1) with USB as first boot source,
+	 * awaiting forever the host connection.
+	 */
+	meson_sm_set_bl1_first_boot_source(SCPI_CMD_USB_UNBOOT);
+	do_reset(NULL, 0, 0, NULL);
+}
+
+static void cb_reboot(struct usb_request *req)
+{
+	char *cmd =3D req->buf;
+
+	ADNL_MSG("reboot '%s'\n", cmd);
+
+	strsep(&cmd, "-");
+
+	if (!cmd) {
+		adnl_func->in_req->complete =3D adnl_complete_do_reboot;
+	} else if (!strcmp("bootloader", cmd)) {
+		adnl_func->in_req->complete =3D adnl_complete_do_reboot_bootloader;
+	} else if (!strcmp("romusb", cmd)) {
+		adnl_func->in_req->complete =3D adnl_complete_do_reboot_bl1usb;
+	} else {
+		fastboot_fail("unsupported reboot cmd", response_str);
+		adnl_tx_write_str(response_str);
+		return;
+	}
+
+	adnl_tx_write_str("OKAY");
+}
+
+struct cmd_dispatch_info {
+	const char *cmd;
+	void (*const cb)(struct usb_request *req);
+};
+
+static const struct cmd_dispatch_info cmd_dispatch_info[] =3D {
+	{
+		.cmd =3D ADNL_CMD_GETVAR,
+		.cb =3D cb_getvar,
+	},
+	{
+		.cmd =3D ADNL_CMD_OEM,
+		.cb  =3D cb_oem_cmd,
+	},
+	{
+		.cmd =3D ADNL_CMD_DOWNLOAD,
+		.cb =3D cb_download,
+	},
+	{
+		.cmd =3D ADNL_CMD_UPDATE,
+		.cb =3D cb_download,
+	},
+	{
+		.cmd =3D ADNL_CMD_REBOOT,
+		.cb =3D cb_reboot,
+	},
+	{
+		.cmd =3D ADNL_CMD_MWRITE,
+		.cb =3D cb_aml_media_write,
+	},
+};
+
+static void adnl_rx_handler_command(struct usb_ep *ep, struct usb_request =
*req)
+{
+	void (*func_cb)(struct usb_request *req);
+	char *cmdbuf =3D req->buf;
+	int i;
+
+	cmdbuf[req->actual] =3D '\0';
+	func_cb =3D NULL;
+
+	for (i =3D 0; i < ARRAY_SIZE(cmd_dispatch_info); i++) {
+		if (!strncmp(cmd_dispatch_info[i].cmd, cmdbuf,
+			     strlen(cmd_dispatch_info[i].cmd))) {
+			ADNL_MSG("got cmd '%s'\n", cmd_dispatch_info[i].cmd);
+			func_cb =3D cmd_dispatch_info[i].cb;
+			break;
+		}
+	}
+
+	if (!func_cb) {
+		ADNL_ERR("unknown command: %s\n", cmdbuf);
+		adnl_tx_write_str(ADNL_FAIL_STR "unknown command");
+	} else {
+		if (req->actual < req->length) {
+			u8 *buf =3D (u8 *)req->buf;
+
+			buf[req->actual] =3D 0;
+			func_cb(req);
+		} else {
+			ADNL_ERR("buffer overflow\n");
+			adnl_tx_write_str(ADNL_FAIL_STR "buffer overflow");
+		}
+	}
+
+	if (!req->status) {
+		*cmdbuf =3D '\0';
+		req->actual =3D 0;
+		usb_ep_queue(ep, req, 0);
+	}
+}
--=20
2.30.1


