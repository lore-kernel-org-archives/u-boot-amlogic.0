Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FC1C36009
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.4461.1742415661215453655
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=nGqTHPNT;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A6C55100014;
	Wed, 19 Mar 2025 23:20:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A6C55100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415659;
	bh=/2cxCbxHsQ1eMmh7bRhWYOA84MGhtZATSCZoFu6239A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=nGqTHPNTDJ7omdBx6cHKokgA0EdbUhg8fOzqsov5I5BI5Hp79rLrguYzJahMTiz0u
	 mYeKeDyQ+gAQaavl7cRzq+VkU7GTWqxBFe4gdpQoOhKKJolwbXVBykzVBlLMUOILoa
	 lJOmKdohQFFFZ1hFqJUIa6pFI0Lhp8frAjgQpkejWqiE71bECiHiEVUA2aLP77r96k
	 oAD1f37ogV7Wrj4/d27MokVxxB6qiAOWvN7AjiM8E7wK7vUEf8rCTibuuW24A4cHVR
	 /4QwE/Kn8JqRgjJpQtkBTVpdSDvszngiI/FCRGOjvYiAnyrcNmlhZNHCOUPus5xWjK
	 FQZzNmFMcKOGg==
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
Subject: [PATCH v1 05/11] mtd: rawnand: meson: move some defines to dedicated header
Date: Wed, 19 Mar 2025 23:20:39 +0300
Message-ID: <20250319202045.1407-6-avkrasnov@salutedevices.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2637

We need these values and macro to correctly write "bootloader"
partition in Optimus protocol, so let's export them to arch-meson
header and also provide more detailed information about each
macro.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/include/asm/arch-meson/rawnand.h | 38 +++++++++++++++++++++++
 drivers/mtd/nand/raw/meson_nand.c         | 13 +-------
 2 files changed, 39 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-meson/rawnand.h

diff --git a/arch/arm/include/asm/arch-meson/rawnand.h b/arch/arm/include/a=
sm/arch-meson/rawnand.h
new file mode 100644
index 00000000000..81bf6ef7e37
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/rawnand.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2025 SaluteDevices, Inc.
+ */
+
+#ifndef __MESON_RAWNAND_H__
+#define __MESON_RAWNAND_H__
+
+#include <asm/arch/nand.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+
+/* M2N means 'memory to NAND', e.g. write. */
+#define NFC_CMD_M2N	((0 << 17) | BIT(21))
+/* N2M means 'NAND to memory', e.g. read. */
+#define NFC_CMD_N2M	((1 << 17) | BIT(21))
+
+/*
+ * Macro to create value for read/write command.
+ *
+ * 'cmd_dir' - direction, e.g. read or write.
+ * 'ran' - scrambler mode (enabled or not).
+ * 'bch' - ECC mode (strength and size).
+ * 'short_mode' - short mode (enabled or not).
+ * 'page_size' - size of page.
+ * 'pages' - number of pages to access.
+ */
+#define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)	\
+	(								\
+		(cmd_dir)		    	|			\
+		((ran))	        		|			\
+		((bch) << 14)			|			\
+		((short_mode) << 13)		|			\
+		(((page_size) & 0x7F) << 6)	|			\
+		((pages) & 0x3F)					\
+	)
+
+#endif
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson=
_nand.c
index 28c851f103b..81122315f45 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -11,6 +11,7 @@
=20
 #include <nand.h>
 #include <asm/io.h>
+#include <asm/arch/rawnand.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/ofnode.h>
@@ -34,8 +35,6 @@
 #define NFC_CMD_AIL			((2 << 16) | (3 << 20))
 #define NFC_CMD_AIH			((3 << 16) | (3 << 20))
 #define NFC_CMD_SEED			((8 << 16) | (3 << 20))
-#define NFC_CMD_M2N			((0 << 17) | (2 << 20))
-#define NFC_CMD_N2M			((1 << 17) | (2 << 20))
 #define NFC_CMD_RB			BIT(20)
 #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
 #define NFC_CMD_SCRAMBLER_DISABLE	0
@@ -61,16 +60,6 @@
 #define NFC_REG_PINS		0x30
 #define NFC_REG_VER		0x38
=20
-#define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)	\
-	(								\
-		(cmd_dir)			|			\
-		(ran)				|			\
-		((bch) << 14)			|			\
-		((short_mode) << 13)		|			\
-		(((page_size) & 0x7f) << 6)	|			\
-		((pages) & 0x3f)					\
-	)
-
 #define GENCMDDADDRL(adl, addr)		((adl) | ((addr) & 0xffff))
 #define GENCMDDADDRH(adh, addr)		((adh) | (((addr) >> 16) & 0xffff))
 #define GENCMDIADDRL(ail, addr)		((ail) | ((addr) & 0xffff))
--=20
2.30.1


