Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509EAC36002
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.4617.1742415662814211925
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=UHp+1XqF;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 51178100016;
	Wed, 19 Mar 2025 23:21:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 51178100016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415661;
	bh=8bFxN2lzYZUQCS/aScPWZo+WE9xH+qLuSWGgA/o5ITk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=UHp+1XqFmfPU+WKpSJ9WEvi3NxZvZz1r7KHGmczhsBEQ2Yf+tUiiY4vwUOLMrAXih
	 tXLwf8C24tBmSLkcQiTTrBdleiSmPSuytPycoF0gXVY9cF+rJ27jr8WIR+5MHATkt3
	 EgoaR9KkTn64pYiEmYLVqiQIRogOUEJO71z5Z+SyXC6CCHNyZvYHY7VlrlQqkbwAeb
	 Ztl5dv+2ra78r/HMqVXhTZz1cVBMQE1qvD4hhjEv2C0qw1O9q61dY3o8hU9wH7Ijvo
	 148YJt4DoO7WnJ7xV7TPzEzP9HbH3P0IvVHuhwJ4EFzWexR7GHZhhTE9cfZ0OXdrW1
	 DsVC4Z7aMXkBA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 19 Mar 2025 23:21:01 +0300 (MSK)
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
	<avkrasnov@salutedevices.com>, Vladimir Mitrofanov
	<vvmitrofanov@salutedevices.com>
Subject: [PATCH v1 10/11] usb: gadget: amlogic: implement Optimus protocol
Date: Wed, 19 Mar 2025 23:20:44 +0300
Message-ID: <20250319202045.1407-11-avkrasnov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/19 17:18:00 #27803216
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Mar 2025 14:56:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2639

From: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>

Add Amlogic's Optimus protocol support for USB transport.

Signed-off-by: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 cmd/Kconfig                                   |   7 +
 cmd/meson/Makefile                            |   1 +
 cmd/meson/optimus.c                           |  21 +
 drivers/usb/gadget/Makefile                   |   1 +
 drivers/usb/gadget/amlogic/Kconfig            |   1 +
 drivers/usb/gadget/amlogic/optimus/Kconfig    |  12 +
 drivers/usb/gadget/amlogic/optimus/Makefile   |   7 +
 .../usb/gadget/amlogic/optimus/f_optimus.c    | 687 ++++++++++++++++++
 .../gadget/amlogic/optimus/optimus_download.c | 188 +++++
 .../gadget/amlogic/optimus/optimus_download.h |  86 +++
 10 files changed, 1011 insertions(+)
 create mode 100644 cmd/meson/optimus.c
 create mode 100644 drivers/usb/gadget/amlogic/optimus/Kconfig
 create mode 100644 drivers/usb/gadget/amlogic/optimus/Makefile
 create mode 100644 drivers/usb/gadget/amlogic/optimus/f_optimus.c
 create mode 100644 drivers/usb/gadget/amlogic/optimus/optimus_download.c
 create mode 100644 drivers/usb/gadget/amlogic/optimus/optimus_download.h

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 2f195d03848..159e52d5298 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1153,6 +1153,13 @@ config CMD_ADNL
           This command, "adnl", enables the ADNL listen mode, providing
 	  the ability to listen in ADNL mode.
=20
+config CMD_OPTIMUS
+	bool "OPTIMUS - Amlogic download protocol"
+	depends on OPTIMUS
+	help
+          This command, "optimus", enables the OPTIMUS listen mode, provid=
ing
+	  the ability to communicate with host by OPTIMUS protocol.
+
 config CMD_FLASH
 	bool "flinfo, erase, protect"
 	default y
diff --git a/cmd/meson/Makefile b/cmd/meson/Makefile
index 1cf984378a3..611d1549736 100644
--- a/cmd/meson/Makefile
+++ b/cmd/meson/Makefile
@@ -4,3 +4,4 @@
=20
 obj-y +=3D sm.o
 obj-$(CONFIG_CMD_ADNL) +=3D gadget.o adnl.o
+obj-$(CONFIG_CMD_OPTIMUS) +=3D gadget.o optimus.o
diff --git a/cmd/meson/optimus.c b/cmd/meson/optimus.c
new file mode 100644
index 00000000000..97a1435c0ab
--- /dev/null
+++ b/cmd/meson/optimus.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 SaluteDevices, Inc.
+ * Author: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
+ */
+
+#include <command.h>
+
+#include "gadget.h"
+
+static int do_optimus(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	return amlogic_gadget_run("usb_dnl_optimus", argc, argv);
+}
+
+U_BOOT_LONGHELP(optimus,
+		"- run as an OPTIMUS USB device\n\n");
+
+U_BOOT_CMD(optimus, 1, 1, do_optimus,
+	   "OPTIMUS protocol mode", optimus_help_text);
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 2b6705c52be..f5899a96221 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_USB_GADGET_DWC2_OTG) +=3D dwc2_udc_otg.o
 obj-$(CONFIG_USB_GADGET_DWC2_OTG_PHY) +=3D dwc2_udc_otg_phy.o
 obj-$(CONFIG_USB_GADGET_MAX3420) +=3D max3420_udc.o
 obj-$(CONFIG_USB_RENESAS_USBHS) +=3D rcar/
+obj-$(CONFIG_OPTIMUS) +=3D f_fastboot_common.o amlogic/optimus/
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_USB_GADGET_DOWNLOAD) +=3D g_dnl.o
 obj-$(CONFIG_USB_FUNCTION_THOR) +=3D f_thor.o
diff --git a/drivers/usb/gadget/amlogic/Kconfig b/drivers/usb/gadget/amlogi=
c/Kconfig
index 460dc6fe235..5a16fb25998 100644
--- a/drivers/usb/gadget/amlogic/Kconfig
+++ b/drivers/usb/gadget/amlogic/Kconfig
@@ -7,5 +7,6 @@ choice
 	optional
=20
 source "drivers/usb/gadget/amlogic/adnl/Kconfig"
+source "drivers/usb/gadget/amlogic/optimus/Kconfig"
=20
 endchoice
diff --git a/drivers/usb/gadget/amlogic/optimus/Kconfig b/drivers/usb/gadge=
t/amlogic/optimus/Kconfig
new file mode 100644
index 00000000000..6a730670d34
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/optimus/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2024 SaluteDevices, Inc.
+
+config OPTIMUS
+	bool "Enable OPTIMUS protocol"
+	depends on USB_GADGET
+	depends on MESON_AXG
+	help
+	  This enables usb optimus function protocol
+	  "Optimus" protocol is used to flash Amlogic devices
+	  from bootRom or from U-Boot mode
diff --git a/drivers/usb/gadget/amlogic/optimus/Makefile b/drivers/usb/gadg=
et/amlogic/optimus/Makefile
new file mode 100644
index 00000000000..f48806414aa
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/optimus/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y +=3D f_optimus_cb.o
+
+subdir-ccflags-y +=3D -I$(src)/../ -I$(src)/../../
+f_optimus_cb-y +=3D f_optimus.o
+f_optimus_cb-y +=3D optimus_download.o
diff --git a/drivers/usb/gadget/amlogic/optimus/f_optimus.c b/drivers/usb/g=
adget/amlogic/optimus/f_optimus.c
new file mode 100644
index 00000000000..9912a691301
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/optimus/f_optimus.c
@@ -0,0 +1,687 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 SaluteDevices, Inc.
+ * Author: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
+ */
+/*
+ * OPTIMUS - is Amlogic protocol for updating firmware.
+ * This protocol is used for flashing devices based on Amlogic SoC.
+ * Optimus uses specific image format. In this implementation USB
+ * is used for data transfer.
+ *
+ * There are two ways to switch device to flashing mode:
+ * 1. Enter bootROM flashing mode (how this should be done depends on devi=
ce)
+ * 2. Run from TPL (ex. from U-boot)
+ *
+ * Flashing steps
+ *  1. Device has to be switched to Optimus mode (as described earlier).
+ *  2. Host detects it as "Amlogic DNL" device, by sending identify reques=
t.
+ *  3. Host sends u-boot. BootROM loads it to RAM and executes u-boot.
+ *     Finally u-boot detects that we are in Optimus update process, so it=
 enters
+ *     Optimus mode to continue fw update.
+ *  4. Now host starts to send protocol commands.
+ *     First host sends some preparation commands like "low_power", "echo =
1234" etc.
+ *     The order of this commands depends on host software.
+ *     Host may start flashing from any partition of the image (depends on=
 host)
+ *  5. Host sends "bootloader_is_old" and "erase_bootloader". Device is pr=
eparing
+ *     buffers and storage to receive "bootloader". "Bootloader" consists =
of two
+ *     parts "bl2" and "tpl". As "tpl" could be used u-boot.
+ *  6. Host sends "download" command that contains information about full =
size of
+ *     partition that will be sent. Partition is sending by chunks. Every =
chunk
+ *     writes to permanent memory.
+ *     "Bootloader" is exception. It should be fully received before writi=
ng to storage.
+ *     After getting full "bootloader" device starts flashing it in to per=
manent memory.
+ *  7. After sending each partition of firmware Host sends "download get_s=
tatus".
+ *  8. For every success operation Device respond with "success" status.
+ *  9. Host repeats steps form 6 - 8 with other partitions (A, B, ...).
+ *     This partitions are sending by chunks, but in contrast ("bootloader=
") they
+ *     are transmitting and writing to permanent memory by block of 64KiB =
(the size
+ *     depends on host software).
+ * 10. After all partitions are received Host sends "save_setting" to rest=
ore
+ *     environment to default state.
+ *
+ * NOTES#1:
+ * Current implementation has limited set of OPTIMUS features and commands=
.
+ * It was tested only on A113 SoC with one image of specific layout/conten=
t
+ * (BL2, TPL, etc.).
+ *
+ * NOTES#2:
+ * "bootloader" partition has special layout: BL2 and TPL are saved as
+ * several copies of each other with specific alignment.
+ *
+ * NOTES#3:
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
+#include <log.h>
+#include <asm/arch-meson/sm.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/mtd/mtd.h>
+#include <u-boot/sha1.h>
+
+#include "f_fastboot_common.h"
+#include "optimus_download.h"
+
+#define CMD_DOWNLOAD      "download"
+#define CMD_LOWPOWER      "low_power"
+#define CMD_BL_IS_OLD     "bootloader_is_old"
+#define CMD_ERASE_BL      "erase_bootloader"
+#define CMD_RESET         "reset"
+#define CMD_UPLOAD        "upload"
+#define CMD_VERIFY        "verify"
+#define CMD_DISK_INITIAL  "disk_initial"
+#define CMD_SAVE_SET      "save_setting"
+#define CMD_BURN_COMPL    "burn_complete"
+#define CMD_ECHO_1234     "echo"
+#define CMD_SETENV        "setenv"
+#define CMD_SAVE          "save"
+#define CMD_RPMB_RESET    "rpmb_reset"
+#define CMD_AMLMMC        "amlmmc"
+#define CMD_NAND          "nand"
+#define CMD_SUB_GETSTATUS "get_status"
+#define CMD_SUB_STORE     "store"
+
+#define MAX_RESPONSE_LEN  512
+#define MAX_CMD_LEN       60
+#define SPACE_IN_HEX      0x20
+
+#define REQ_WRITE_MEM     0x01
+#define REQ_READ_MEM      0x02
+#define REQ_RUN_IN_ADDR   0x05
+#define REQ_WR_LARGE_MEM  0x11
+#define REQ_RD_LARGE_MEM  0x12
+#define REQ_IDENTIFY_HOST 0x20
+#define REQ_TPL_CMD       0x30
+#define REQ_TPL_STAT      0x31
+#define REQ_BULKCMD       0x34
+#define REQ_WRITE_MEDIA   0x32
+#define REQ_READ_MEDIA    0x33
+
+typedef void (*cmd_handler) (const struct usb_request *req);
+
+static cmd_handler get_handler(const char *cmd);
+
+static const char opti_name[] =3D "WorldCup Device";
+static const char resp_success[] =3D "success";
+/* Pay attention \":\" is in the end. Protocol specific. */
+static const char resp_failed[] =3D "failed:";
+
+static struct usb_os_desc_ext_prop opti_ext_prop =3D {
+	.type =3D 1,		/* NULL-terminated Unicode String (REG_SZ) */
+	.name =3D "DeviceInterfaceGUID",
+	.data =3D "{4866319A-F4D6-4374-93B9-DC2DEB361BA9}",
+};
+
+/* 16 bytes of "Compatible ID" and "Subcompatible ID" */
+static char opti_cid[16] =3D {'W', 'I', 'N', 'U', 'S', 'B'};
+static struct usb_os_desc opti_os_desc =3D {
+	.ext_compat_id =3D opti_cid,
+};
+
+static struct usb_os_desc_table opti_os_desc_table =3D {
+	.os_desc =3D &opti_os_desc,
+};
+
+static struct fastboot_funcs *opti_func;
+
+static struct usb_string opti_string_defs[] =3D {
+	[0].s =3D opti_name,
+	{  } /* end of list */
+};
+
+static struct usb_gadget_strings stringtab_opti =3D {
+	.language	=3D 0x0409,	/* en-us */
+	.strings	=3D opti_string_defs,
+};
+
+static struct usb_gadget_strings *opti_strings[] =3D {
+	&stringtab_opti,
+	NULL,
+};
+
+/* This function is oriented to send string response of desired size endin=
g by zero bytes */
+static int opti_tx_write(const char *buffer, size_t buffer_size)
+{
+	int ret;
+	struct usb_request *in_req =3D opti_func->in_req;
+	size_t resp_len =3D strnlen(buffer, MAX_RESPONSE_LEN);
+
+	if (!buffer_size || buffer_size > MAX_RESPONSE_LEN)
+		buffer_size =3D MAX_RESPONSE_LEN;
+
+	resp_len =3D min_t(size_t, resp_len, buffer_size);
+	memset(in_req->buf, 0, MAX_RESPONSE_LEN);
+	memcpy(in_req->buf, buffer, resp_len);
+
+	in_req->length =3D buffer_size;
+
+	ret =3D usb_ep_queue(opti_func->in_ep, in_req, 0);
+	if (ret)
+		OPTI_ERR("Response with size %zu failed: %d", buffer_size, ret);
+
+	return ret;
+}
+
+static void opti_rx_handler_command(struct usb_ep *ep, struct usb_request =
*req);
+
+static int opti_bind(struct usb_configuration *c, struct usb_function *f)
+{
+	return fastboot_common_bind(c, f, &opti_os_desc_table,
+				    &opti_os_desc, (struct usb_string **)&opti_string_defs,
+				    &opti_ext_prop);
+}
+
+static void opti_unbind(struct usb_configuration *c, struct usb_function *=
f)
+{
+	fastboot_common_unbind(c, f, &opti_os_desc);
+	memset(opti_func, 0, sizeof(*opti_func));
+}
+
+static void opti_disable(struct usb_function *f)
+{
+	fastboot_common_disable(f);
+}
+
+static int opti_set_alt(struct usb_function *f,
+			unsigned int interface, unsigned int alt)
+{
+	int ret;
+	struct usb_configuration *c;
+
+	if (interface)
+		return 0;
+
+	ret =3D fastboot_common_set_alt(f, interface, alt, opti_rx_handler_comman=
d);
+
+	c =3D f->config;
+
+	if (!c->interface[0])
+		return ret;
+
+	for (size_t i =3D 1; i < MAX_CONFIG_INTERFACES; i++) {
+		if (!c->interface[i])
+			c->interface[i] =3D c->interface[0];
+	}
+
+	return ret;
+}
+
+void complete_tpl_cmd(struct usb_ep *ep, struct usb_request *req)
+{
+	cmd_handler cb;
+
+	((char *)req->buf)[req->actual] =3D '\0';
+	cb =3D get_handler(req->buf);
+
+	if (!cb) {
+		OPTI_ERR("Unknown command: %.*s", MAX_CMD_LEN, (char *)req->buf);
+		return;
+	}
+
+	cb(req);
+}
+
+void complete_write_media(struct usb_ep *ep, struct usb_request *req)
+{
+	struct optimus_chunk in;
+	struct optimus_img *img;
+
+	in =3D *((struct optimus_chunk *)req->buf);
+
+	img =3D optimus_get_img();
+
+	img->cur_chunk_meta =3D in;
+
+	if (optimus_chunk_alloc_buf(img->fsize))
+		return;
+
+	opti_func->out_req->length =3D min_t(u32, in.data_length, EP_BUFFER_SIZE)=
;
+	opti_func->out_req->complete =3D opti_rx_handler_command;
+
+	OPTI_MSG_ERASE("Image %s received:%*zd%%%c", img->name,
+		       4, img->dsize * 100 / img->fsize, SPACE_IN_HEX);
+
+	usb_ep_queue(opti_func->out_ep, opti_func->out_req, 0);
+}
+
+static int optimus_setup(struct usb_function *f, const struct usb_ctrlrequ=
est *ctrl)
+{
+	struct usb_gadget *gadget =3D f->config->cdev->gadget;
+	struct usb_request *req =3D f->config->cdev->req;
+	u16 len =3D le16_to_cpu(ctrl->wLength);
+	u16 w_value =3D le16_to_cpu(ctrl->wValue);
+	int value;
+
+	u8 resp_buf[MAX_RESPONSE_LEN];
+	u8 host_identity[] =3D {0, 7, 0, 16, 0, 0, 0, 0};
+
+	switch (ctrl->bRequest) {
+	case REQ_IDENTIFY_HOST:
+		value =3D min_t(u16, len, MAX_RESPONSE_LEN);
+		memcpy(req->buf, host_identity, value);
+		break;
+	case REQ_TPL_CMD:
+		value =3D len;
+		req->complete =3D complete_tpl_cmd;
+		break;
+	case REQ_TPL_STAT:
+		value =3D (!len) ? 0 : len - 1;
+		memset(req->buf, 0, len);
+		memcpy(req->buf, resp_success, sizeof(resp_success) - 1);
+		break;
+	case REQ_BULKCMD:
+		value =3D len;
+		req->complete =3D complete_tpl_cmd;
+		break;
+	case REQ_READ_MEDIA:
+		value =3D len;
+		memset(resp_buf, 0, sizeof(resp_buf));
+		opti_tx_write(resp_buf, w_value);
+		break;
+	case REQ_WRITE_MEDIA:
+		/* This is main request to receive image chunks of data */
+		value =3D len;
+		req->complete =3D complete_write_media;
+		break;
+	case REQ_WRITE_MEM:
+	case REQ_READ_MEM:
+	case REQ_WR_LARGE_MEM:
+	case REQ_RUN_IN_ADDR:
+		value =3D len;
+		memset(req->buf, 0, len);
+		break;
+	default:
+		value =3D 0;
+		OPTI_ERR("\nUnknown request: bRequest %#x", ctrl->bRequest);
+	}
+
+	req->length =3D value;
+	req->zero =3D 0;
+
+	value =3D usb_ep_queue(gadget->ep0, req, GFP_KERNEL);
+	if (value < 0) {
+		OPTI_ERR("Response \"ep0\" failed (%d)", value);
+		req->status =3D 0;
+	}
+
+	return value;
+}
+
+int opti_add(struct usb_configuration *c)
+{
+	struct fastboot_funcs *f_opti =3D opti_func;
+	int status;
+
+	OPTI_MSG("Start usb \"optimus\"");
+	if (!f_opti) {
+		f_opti =3D memalign(CONFIG_SYS_CACHELINE_SIZE, sizeof(*f_opti));
+		if (!f_opti)
+			return -ENOMEM;
+
+		opti_func =3D f_opti;
+		memset(f_opti, 0, sizeof(*f_opti));
+	}
+
+	g_dnl_set_product("DNL");
+	f_opti->usb_function.name =3D "f_opti";
+	f_opti->usb_function.bind =3D opti_bind;
+	f_opti->usb_function.unbind =3D opti_unbind;
+	f_opti->usb_function.set_alt =3D opti_set_alt;
+	f_opti->usb_function.disable =3D opti_disable;
+	f_opti->usb_function.strings =3D opti_strings;
+	f_opti->usb_function.setup =3D optimus_setup;
+
+	status =3D usb_add_function(c, &f_opti->usb_function);
+	if (status) {
+		free(f_opti);
+		opti_func =3D NULL;
+	}
+
+	return status;
+}
+
+DECLARE_GADGET_BIND_CALLBACK(usb_dnl_optimus, opti_add);
+
+static void cb_download(const struct usb_request *req)
+{
+	char *cmd[10];
+	char *token;
+	u16 i;
+	unsigned int img_size;
+	const char delim[] =3D {SPACE_IN_HEX, '\x00'};
+	struct optimus_img *img;
+
+	/* Finalizing received buffer by \x00 */
+	token =3D req->buf;
+	token[req->actual] =3D '\x00';
+
+	i =3D 0;
+	token =3D strtok(req->buf, delim);
+	while (token && i < ARRAY_SIZE(cmd)) {
+		cmd[i] =3D token;
+		token =3D strtok(NULL, delim);
+		i++;
+	}
+
+	img =3D optimus_get_img();
+
+	if (i >=3D 1 && !strncmp(cmd[1], CMD_SUB_GETSTATUS, sizeof(CMD_SUB_GETSTA=
TUS) - 1)) {
+		if (img->dsize =3D=3D img->fsize) {
+			opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+			OPTI_MSG("Partition \'%s\' is fully received", img->name);
+		} else {
+			opti_tx_write(resp_failed, img->cur_chunk_meta.ack_len);
+			OPTI_MSG("Partition \'%s\' receiving failed", img->name);
+		}
+	} else if (i >=3D 4 && !strcmp(cmd[1], CMD_SUB_STORE)) {
+		img_size =3D simple_strtoul(cmd[4], NULL, 10);
+		/* Init first image chunk by full image name and full image size. */
+		optimus_chunk_init(cmd[2], img_size);
+	}
+}
+
+static void cb_lowpower(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_bl_is_old(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_erase_bl(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_reset(const struct usb_request *req)
+{
+	meson_sm_set_usb_boot_mode(FORCE_USB_BOOT);
+	meson_sm_reboot(REBOOT_REASON_NORMAL);
+}
+
+static void cb_upload(const struct usb_request *req)
+{
+	const char **param_list;
+	size_t resp_len =3D 0;
+	char *req_buf_ch;
+
+	req_buf_ch =3D (char *)req->buf;
+	req_buf_ch[MAX_RESPONSE_LEN - 1] =3D '\0';
+	param_list =3D str_to_list(req_buf_ch);
+
+	if (param_list) {
+		size_t param_count =3D 0;
+
+		while (param_list[param_count])
+			param_count++;
+
+		if (param_count > 4)
+			resp_len =3D simple_strtoul(param_list[4], NULL, 0);
+	} else {
+		resp_len =3D 0x4;
+	}
+
+	str_free_list(param_list);
+
+	opti_tx_write(resp_success, resp_len);
+}
+
+static void cb_verify(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static bool opti_must_skip_block(struct mtd_info *mtd, off_t offset)
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
+static void cb_disk_initial(const struct usb_request *req)
+{
+	struct optimus_img *img;
+	struct mtd_info *mtd;
+	off_t offset;
+
+	mtd =3D get_mtd_device_nm("bootloader");
+	if (!mtd || !mtd->parent)
+		return;
+
+	mtd =3D mtd->parent;
+
+	for (offset =3D 0; offset < mtd->size; offset +=3D mtd->erasesize) {
+		struct erase_info erase_op =3D {};
+		int ret;
+
+		if (opti_must_skip_block(mtd, offset))
+			continue;
+
+		erase_op.mtd =3D mtd;
+		erase_op.addr =3D offset;
+		erase_op.len =3D mtd->erasesize;
+
+		ret =3D mtd_erase(mtd, &erase_op);
+		if (ret) {
+			OPTI_ERR("Can't erase block at %lx\n",
+				  offset);
+			return;
+		}
+	}
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_save_setting(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_burn_complete(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_echo_1234(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_setenv(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	env_set("firstboot", "1");
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_save(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	env_save();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_rpmb_reset(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_amlmmc(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void cb_nand(const struct usb_request *req)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+	opti_tx_write(resp_success, img->cur_chunk_meta.ack_len);
+}
+
+static void opti_rx_handler_command(struct usb_ep *ep, struct usb_request =
*req)
+{
+	enum optimus_chunk_state ret =3D optimus_chunk_process(req->buf, req->len=
gth);
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+
+	switch (ret) {
+	case OPTI_CHUNK_STATE_COMPLETE:
+		req->complete =3D NULL;
+		opti_tx_write("OK!!", img->cur_chunk_meta.ack_len);
+		break;
+	case OPTI_CHUNK_STATE_IN_PROGRESS:
+		req->length =3D img->req_length;
+		req->complete =3D opti_rx_handler_command;
+		if (!usb_ep_queue(ep, req, 0))
+			break;
+	case OPTI_CHUNK_STATE_ERROR:
+		req->complete =3D NULL;
+		opti_tx_write("FALSE!!", img->cur_chunk_meta.ack_len);
+		break;
+	case OPTI_CHUNK_STATE_NEED_INIT:
+		break;
+	}
+}
+
+struct cmd_dispatch_info {
+	const char *cmd;
+	cmd_handler cb;
+};
+
+static const struct cmd_dispatch_info cmd_dispatch_info[] =3D {
+	{
+		.cmd =3D CMD_RESET,
+		.cb  =3D cb_reset,
+	},
+	{
+		.cmd =3D CMD_DOWNLOAD,
+		.cb =3D cb_download,
+	},
+	{
+		.cmd =3D CMD_LOWPOWER,
+		.cb =3D cb_lowpower,
+	},
+	{
+		.cmd =3D CMD_BL_IS_OLD,
+		.cb =3D cb_bl_is_old,
+	},
+	{
+		.cmd =3D CMD_ERASE_BL,
+		.cb =3D cb_erase_bl,
+	},
+	{
+		.cmd =3D CMD_UPLOAD,
+		.cb =3D cb_upload,
+	},
+	{
+		.cmd =3D CMD_VERIFY,
+		.cb =3D cb_verify,
+	},
+	{
+		.cmd =3D CMD_DISK_INITIAL,
+		.cb =3D cb_disk_initial,
+	},
+	{
+		.cmd =3D CMD_SAVE_SET,
+		.cb =3D cb_save_setting,
+	},
+	{
+		.cmd =3D CMD_BURN_COMPL,
+		.cb =3D cb_burn_complete,
+	},
+	{
+		.cmd =3D CMD_ECHO_1234,
+		.cb =3D cb_echo_1234,
+	},
+	{
+		.cmd =3D CMD_SETENV,
+		.cb =3D cb_setenv,
+	},
+	{
+		.cmd =3D CMD_SAVE,
+		.cb =3D cb_save,
+	},
+	{
+		.cmd =3D CMD_RPMB_RESET,
+		.cb =3D cb_rpmb_reset,
+	},
+	{
+		.cmd =3D CMD_AMLMMC,
+		.cb =3D cb_amlmmc,
+	},
+	{
+		.cmd =3D CMD_NAND,
+		.cb =3D cb_nand,
+	},
+};
+
+static cmd_handler get_handler(const char *cmd)
+{
+	u32 i;
+	const char *str_ptr;
+
+	if (!cmd)
+		return NULL;
+
+	str_ptr =3D skip_spaces(cmd);
+
+	for (i =3D 0; i < ARRAY_SIZE(cmd_dispatch_info); i++) {
+		int ret;
+
+		ret =3D strncmp(str_ptr, cmd_dispatch_info[i].cmd, strlen(cmd_dispatch_i=
nfo[i].cmd));
+		if (!ret) {
+			OPTI_MSG("In cmd: '%s'", cmd_dispatch_info[i].cmd);
+			return cmd_dispatch_info[i].cb;
+		}
+	}
+
+	return NULL;
+}
diff --git a/drivers/usb/gadget/amlogic/optimus/optimus_download.c b/driver=
s/usb/gadget/amlogic/optimus/optimus_download.c
new file mode 100644
index 00000000000..c78e39ed23e
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/optimus/optimus_download.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 SaluteDevices, Inc.
+ * Author: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
+ */
+
+#include <command.h>
+#include <log.h>
+#include <mtd.h>
+#include <nand.h>
+#include <asm/arch/rawnand.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/libfdt.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
+
+#include "f_fastboot_common.h"
+#include "optimus_download.h"
+
+static struct optimus_img flash_img =3D { .ptr =3D NULL };
+
+struct optimus_img *optimus_get_img(void)
+{
+	return &flash_img;
+}
+
+static int optimus_write_normal_image(u32 data_sz, u8 *data)
+{
+	struct optimus_img *img;
+	size_t written_length;
+	size_t length;
+	struct mtd_info *mtd;
+	int ret;
+
+	if (!data_sz)
+		return 0;
+
+	img =3D optimus_get_img();
+
+	mtd =3D get_mtd_device_nm(img->name);
+
+	if (IS_ERR_OR_NULL(mtd)) {
+		OPTI_ERR("Failed to get mtd device \"%s\" ret: %ld", img->name, PTR_ERR(=
mtd));
+		return PTR_ERR(mtd);
+	}
+
+	/* Need use intermediate storage to write conversion of types pointers */
+	length =3D data_sz;
+
+	written_length =3D 0;
+	ret =3D nand_write_skip_bad(mtd, img->media_offset, &length,
+				  &written_length, mtd->size, data, 0);
+	img->media_offset +=3D written_length;
+
+	return ret;
+}
+
+void optimus_chunk_init(const char *name, unsigned int size)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+
+	img->fsize =3D size;
+
+	memset(img->name, 0, sizeof(img->name));
+	strncpy(img->name, name, sizeof(img->name) - 1);
+
+	img->dsize =3D 0;
+	img->media_offset =3D 0;
+}
+
+int optimus_chunk_alloc_buf(unsigned int size)
+{
+	struct optimus_img *img;
+	size_t full_size;
+
+	img =3D optimus_get_img();
+
+	img->fsize =3D size;
+	img->cur_chunk_data_len =3D 0;
+
+	if (!strcmp(img->name, BOOT_LOADER)) {
+		img->type =3D OPTI_IMG_TYPE_BOOTLOADER;
+		full_size =3D img->fsize;
+	} else {
+		img->type =3D OPTI_IMG_TYPE_NORMAL;
+		full_size =3D img->cur_chunk_meta.data_length;
+	}
+
+	if (!img->ptr)
+		img->ptr =3D (u8 *)malloc(full_size);
+
+	if (!img->ptr) {
+		OPTI_ERR("No memory for data chunk");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void optimus_chunk_free(void)
+{
+	struct optimus_img *img;
+
+	img =3D optimus_get_img();
+
+	free(img->ptr);
+	img->ptr =3D NULL;
+}
+
+static unsigned int optimus_csum_special(const void *p_buf, const unsigned=
 int size)
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
+enum optimus_chunk_state optimus_chunk_process(const void *data, unsigned =
int size)
+{
+	struct optimus_img *img;
+	int rw_ret;
+	u32 len_diff;
+	u32 check_sum;
+	u32 pos;
+
+	img =3D optimus_get_img();
+
+	if (!img->ptr)
+		return OPTI_CHUNK_STATE_NEED_INIT;
+
+	if (img->type =3D=3D OPTI_IMG_TYPE_BOOTLOADER)
+		pos =3D img->dsize;
+	else
+		pos =3D img->cur_chunk_data_len;
+
+	if (img->ptr + pos + size <=3D img->ptr + img->fsize)
+		memcpy(img->ptr + pos, data, size);
+	else
+		return OPTI_CHUNK_STATE_ERROR;
+
+	img->dsize +=3D size;
+	img->cur_chunk_data_len +=3D size;
+	if (img->cur_chunk_data_len < img->cur_chunk_meta.data_length) {
+		len_diff =3D img->cur_chunk_meta.data_length - img->cur_chunk_data_len;
+		img->req_length =3D min_t(u32, len_diff, EP_BUFFER_SIZE);
+		return OPTI_CHUNK_STATE_IN_PROGRESS;
+	}
+
+	/* All chunk data received. */
+	if (img->type =3D=3D OPTI_IMG_TYPE_BOOTLOADER)
+		pos =3D img->dsize - img->cur_chunk_data_len;
+	else
+		pos =3D 0;
+
+	check_sum =3D optimus_csum_special(img->ptr + pos, img->cur_chunk_data_le=
n);
+	if (check_sum !=3D img->cur_chunk_meta.chksum)
+		return OPTI_CHUNK_STATE_ERROR;
+
+	if (img->type =3D=3D OPTI_IMG_TYPE_BOOTLOADER && size) {
+		/* Not full bootloader image. Chunk is only part. */
+		if (img->dsize < img->fsize)
+			return OPTI_CHUNK_STATE_COMPLETE;
+
+		/* We write bootloader after getting full image */
+		rw_ret =3D meson_bootloader_write(img->ptr, img->fsize);
+		optimus_chunk_free();
+		if (rw_ret)
+			return OPTI_CHUNK_STATE_ERROR;
+	} else {
+		rw_ret =3D optimus_write_normal_image((u32)img->cur_chunk_data_len, img-=
>ptr);
+		optimus_chunk_free();
+		if (rw_ret)
+			return OPTI_CHUNK_STATE_ERROR;
+	}
+
+	return OPTI_CHUNK_STATE_COMPLETE;
+}
diff --git a/drivers/usb/gadget/amlogic/optimus/optimus_download.h b/driver=
s/usb/gadget/amlogic/optimus/optimus_download.h
new file mode 100644
index 00000000000..3a8682df045
--- /dev/null
+++ b/drivers/usb/gadget/amlogic/optimus/optimus_download.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 SaluteDevices, Inc. All rights reserved.
+ * Author: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
+ */
+
+#ifndef __OPTIMUS_DOWNLOAD_H__
+#define __OPTIMUS_DOWNLOAD_H__
+
+#define OPTI_PREF          "[OPTI][MSG] "
+#define ERASE_SEQ          "\x1B[2K\r"
+#define __OPTI_MSG(prefix, fmt, ...) printf(prefix fmt, ##__VA_ARGS__)
+
+#define OPTI_MSG(fmt, ...) __OPTI_MSG("\n" OPTI_PREF, fmt, ##__VA_ARGS__)
+#define OPTI_MSG_ERASE(fmt, ...) __OPTI_MSG(ERASE_SEQ "" OPTI_PREF, fmt, #=
#__VA_ARGS__)
+#define OPTI_ERR(fmt, ...) pr_err("\n[OPTI][ERR]: " fmt, ##__VA_ARGS__)
+
+enum optimus_img_type {
+	OPTI_IMG_TYPE_BOOTLOADER,
+	OPTI_IMG_TYPE_NORMAL,
+};
+
+enum optimus_chunk_state {
+	OPTI_CHUNK_STATE_COMPLETE,
+	OPTI_CHUNK_STATE_IN_PROGRESS,
+	OPTI_CHUNK_STATE_NEED_INIT,
+	OPTI_CHUNK_STATE_ERROR,
+};
+
+struct optimus_chunk {
+	u32	retry_times;	/* Unused in this version. */
+	u32	data_length;	/* Length of data in this chunk. */
+	u32	seq_num;	/* Unused in this version. */
+	u32	chksum;		/* Checksum (see 'optimus_csum_special()'. */
+	u16	chksum_alg;	/* Unused in this version. */
+	u16	ack_len;	/* ACK packet length, expected by sender. */
+} __packed;
+
+struct optimus_img {
+	u8	*ptr;			/* Data buffer. */
+	size_t	dsize;			/* Downloaded size. */
+	size_t	fsize;			/* Image full size. */
+	char	name[256];		/* Current partition name. */
+	enum	optimus_img_type type;	/* Current partition type. */
+
+	struct	optimus_chunk cur_chunk_meta;	/* Current chunk. */
+	u32	cur_chunk_data_len;		/* Downloaded size for current chunk. */
+	u32	req_length;			/* Rest to download, limited by EP buffer. */
+	loff_t	media_offset;			/* Current offset to write this image. */
+};
+
+/**
+ * optimus_get_img() - Get current Optimus image (context).
+ *
+ * @return: pointer to Optimus image (context).
+ */
+struct optimus_img *optimus_get_img(void);
+
+/**
+ * optimus_chunk_init() - Initialize "chunk" to receive data.
+ *
+ * @name: "chunk" name.
+ * @size: full size of data to receive.
+ */
+void optimus_chunk_init(const char *name, unsigned int size);
+
+/**
+ * optimus_chunk_alloc_buf() - Alloc buffer inside "chunk" for data.
+ *
+ * @size: full size of data.
+ *
+ * @return: 0 on success, -errno otherwise.
+ */
+int optimus_chunk_alloc_buf(unsigned int size);
+
+/**
+ * optimus_chunk_process() - Pass new portion of data to "chunk".
+ *
+ * @data: new portion of data.
+ * @size: size of data.
+ *
+ * @return: new state of "chunk".
+ */
+enum optimus_chunk_state optimus_chunk_process(const void *data, unsigned =
int size);
+
+#endif /* __OPTIMUS_DOWNLOAD_H__ */
--=20
2.30.1


