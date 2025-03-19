Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D77DC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.4619.1742415663377067477
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=Mpl82KTc;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 06D8D120014;
	Wed, 19 Mar 2025 23:21:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 06D8D120014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415661;
	bh=beN8T1cB4+EB2MZsbBmqpWowbJ9IKNEn0swDpJ8PUP0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Mpl82KTcakZYx9B/Dz8CBBJZIQCuljuAJj7zFhBGCTilr+n21WqmAD51M/rszAugC
	 VttrqNtvzHtFbjtPhGYS5WGqCeqhr4gYxmGaZLjEGfTALOnv5GqHOaIIqhF9Uf37OK
	 H7CH6BTa9HjWZDnoHKwn3PeJKOSToFGiLhB7tK46Z4kr2rVW7zXtWZWzFUU/qEOmMs
	 /siDvnZVWhlhX8smd8d7XXK6axPGADJh9deYp49F7OWZEqfqf7V3Sd92ojBwp9GF63
	 Fa7nbEYNRSAd2qpkKYsPYrW8fsRU7MJMaWVwfHjUSbQdPDibww/sZpuwRgh+ELFaoZ
	 93wcjKdBwVcKA==
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
Subject: [PATCH v1 09/11] arm: meson: a1: ADNL protocol support
Date: Wed, 19 Mar 2025 23:20:43 +0300
Message-ID: <20250319202045.1407-10-avkrasnov@salutedevices.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2634

During ADNL protocol operations, BootROM may request to enter
ADNL mode after boot. So to support this, let's check for values
in sticky registers after boot (such registers could be updated
earlier by boot ROM, telling U-boot to enter ADNL mode.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/include/asm/arch-meson/a1.h | 13 +++++++++++
 arch/arm/mach-meson/board-a1.c       | 32 +++++++++++++++++++++++++++-
 arch/arm/mach-meson/board-common.c   | 17 +++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/a1.h b/arch/arm/include/asm/ar=
ch-meson/a1.h
index 16e209ed932..4a22aaf5627 100644
--- a/arch/arm/include/asm/arch-meson/a1.h
+++ b/arch/arm/include/asm/arch-meson/a1.h
@@ -12,6 +12,7 @@
 /* SYSCTRL registers */
 #define A1_SYSCTRL_ADDR(off)		(A1_SYSCTRL_BASE + ((off) << 2))
=20
+#define A1_SYSCTRL_SEC_STATUS_REG1	A1_SYSCTRL_ADDR(0xc1)
 #define A1_SYSCTRL_SEC_STATUS_REG4	A1_SYSCTRL_ADDR(0xc4)
 /*
  * Checked during boot. Tells, that previous code, e.g.
@@ -20,7 +21,19 @@
  */
 #define A1_SYSCTRL_SEC_STICKY_REG2	A1_SYSCTRL_ADDR(0xe2)
=20
+#define A1_AO_BOOT_DEVICE		0xF
 #define A1_SYSCTRL_MEM_SIZE_MASK	0xFFFF0000
 #define A1_SYSCTRL_MEM_SIZE_SHIFT	16
=20
+#if CONFIG_IS_ENABLED(ADNL)
+/**
+ * is_tpl_loaded_from_usb - Checks, that this instance of U-boot was
+ *                          loaded from USB during firmware update
+ *                          process.
+ *
+ * returns: true, if so.
+ */
+int is_tpl_loaded_from_usb(void);
+#endif
+
 #endif /* __MESON_A1_H__ */
diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.=
c
index f848c0f068e..9cc410f1e57 100644
--- a/arch/arm/mach-meson/board-a1.c
+++ b/arch/arm/mach-meson/board-a1.c
@@ -3,6 +3,7 @@
  * (C) Copyright 2023 SberDevices, Inc.
  */
=20
+#include <command.h>
 #include <asm/arch/a1.h>
 #include <asm/arch/boot.h>
 #include <asm/armv8/mmu.h>
@@ -23,9 +24,38 @@ void meson_init_reserved_memory(__maybe_unused void *fdt=
)
=20
 int meson_get_boot_device(void)
 {
-	return -ENOSYS;
+	return readl(A1_SYSCTRL_SEC_STATUS_REG4) & A1_AO_BOOT_DEVICE;
 }
=20
+#if CONFIG_IS_ENABLED(ADNL)
+
+static bool is_boot_device_usb(void)
+{
+	return meson_get_boot_device() =3D=3D BOOT_DEVICE_USB;
+}
+
+#define MESON_ADNL_BL1_USB_PROTO_DNL_BIT	BIT(12)
+
+static bool is_bl1_usb_protocol_DNL(void)
+{
+	u32 val =3D readl(A1_SYSCTRL_SEC_STATUS_REG1);
+
+	return !(val & MESON_ADNL_BL1_USB_PROTO_DNL_BIT);
+}
+
+int is_tpl_loaded_from_usb(void)
+{
+	if (!is_boot_device_usb())
+		return false;
+
+	if (!is_bl1_usb_protocol_DNL())
+		return false;
+
+	return true;
+}
+
+#endif
+
 static struct mm_region a1_mem_map[] =3D {
 	{
 		.virt =3D 0x00000000UL,
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board=
-common.c
index 39774c43049..0624d557e40 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -3,6 +3,7 @@
  * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
  */
=20
+#include <command.h>
 #include <cpu_func.h>
 #include <fastboot.h>
 #include <init.h>
@@ -14,9 +15,11 @@
 #include <asm/ptrace.h>
 #include <linux/libfdt.h>
 #include <linux/err.h>
+#include <asm/arch/a1.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/sm.h>
 #include <asm/armv8/mmu.h>
+#include <asm/io.h>
 #include <asm/unaligned.h>
 #include <efi_loader.h>
 #include <u-boot/crc.h>
@@ -141,10 +144,24 @@ __weak int meson_board_late_init(void)
 	return 0;
 }
=20
+static void meson_board_try_enter_adnl(void)
+{
+#if (IS_ENABLED(CONFIG_CMD_ADNL))
+	if (!is_tpl_loaded_from_usb())
+		return;
+
+	meson_sm_set_bl1_first_boot_source(SCPI_CMD_CLEAR_BOOT);
+
+	run_command("adnl", 0);
+#endif
+}
+
 int board_late_init(void)
 {
 	meson_set_boot_source();
=20
+	meson_board_try_enter_adnl();
+
 	return meson_board_late_init();
 }
=20
--=20
2.30.1


