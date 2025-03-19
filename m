Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3EC36001
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.4466.1742415663375139538
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=I67JCPKU;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8430B120015;
	Wed, 19 Mar 2025 23:21:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8430B120015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415661;
	bh=f4w9RmMeHgiQaN14upAA5pVyCE17/cNa1SQ+rwvBpUA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=I67JCPKU+Tqvbfp95+phKIqsbjUD8HBBTFEA/mA8goe7/LX6bH6dVkN0tvNFvtRWX
	 MfQB8cl8FiCkLVv+geGdkxZSX5lPp0MYmwe53+rZ2najd1uHUKnmNuXUtwojbT0j9A
	 50ZTPWr9LHdTLF6fEg7ahn7Em8XjC+K+0hfAgJPEXn7O0OlzBen9JfaN2KNx5H5ykJ
	 R+6fc+J8Km8MryI7K/qgxDFkxkIr4tHsH5iC8aabbWxTcihjlmHUAdB3q1cpKV4lVx
	 pzIcMRI2+SQgHCFs8QEQrezcRh8kaknv++YofaHJf+06gsOaCV01lA6QWRkDN77RPl
	 8mAxm+7AyeXGg==
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
Subject: [PATCH v1 11/11] arch: arm: axg: Optimus protocol support
Date: Wed, 19 Mar 2025 23:20:45 +0300
Message-ID: <20250319202045.1407-12-avkrasnov@salutedevices.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2640

From: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>

During Optimus protocol operations, BootROM may request to enter
Optimus mode after boot. So to support this, let's check for values
in sticky registers after boot (such registers could be updated
earlier by boot ROM, telling U-boot to enter Optimus mode).

Signed-off-by: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/include/asm/arch-meson/axg.h | 12 ++++++++++++
 arch/arm/mach-meson/board-axg.c       | 12 ++++++++++++
 arch/arm/mach-meson/board-common.c    | 15 +++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/axg.h b/arch/arm/include/asm/a=
rch-meson/axg.h
index 12042de9359..e99cd3aa780 100644
--- a/arch/arm/include/asm/arch-meson/axg.h
+++ b/arch/arm/include/asm/arch-meson/axg.h
@@ -23,6 +23,7 @@
 #define AXG_AO_SEC_GP_CFG3	AXG_AO_ADDR(0x93)
 #define AXG_AO_SEC_GP_CFG4	AXG_AO_ADDR(0x94)
 #define AXG_AO_SEC_GP_CFG5	AXG_AO_ADDR(0x95)
+#define AXG_AO_SEC_GP_CFG7	AXG_AO_ADDR(0x97)
=20
 #define AXG_AO_BOOT_DEVICE	0xF
 #define AXG_AO_MEM_SIZE_MASK	0xFFFF0000
@@ -31,4 +32,15 @@
 #define AXG_AO_BL31_RSVMEM_SIZE_SHIFT	16
 #define AXG_AO_BL32_RSVMEM_SIZE_MASK	0xFFFF
=20
+#if CONFIG_IS_ENABLED(CMD_OPTIMUS)
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
 #endif /* __AXG_H__ */
diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-ax=
g.c
index 6535539184c..13eb66dfc21 100644
--- a/arch/arm/mach-meson/board-axg.c
+++ b/arch/arm/mach-meson/board-axg.c
@@ -4,12 +4,14 @@
  * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
  */
=20
+#include <command.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/boot.h>
 #include <asm/arch/eth.h>
 #include <asm/arch/axg.h>
 #include <asm/arch/mem.h>
+#include <asm/arch-meson/sm.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
@@ -62,6 +64,16 @@ phys_size_t get_effective_memsize(void)
 			>> AXG_AO_MEM_SIZE_SHIFT) * SZ_1M;
 }
=20
+#if CONFIG_IS_ENABLED(CMD_OPTIMUS)
+int is_tpl_loaded_from_usb(void)
+{
+	const int boot_id =3D meson_get_boot_device();
+	const unsigned int force_usb_boot =3D readl(AXG_AO_SEC_GP_CFG7);
+
+	return (boot_id =3D=3D BOOT_DEVICE_USB || (force_usb_boot & BIT(31)));
+}
+#endif
+
 static struct mm_region axg_mem_map[] =3D {
 	{
 		.virt =3D 0x0UL,
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board=
-common.c
index 0624d557e40..639c7a64507 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -16,6 +16,7 @@
 #include <linux/libfdt.h>
 #include <linux/err.h>
 #include <asm/arch/a1.h>
+#include <asm/arch/axg.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/sm.h>
 #include <asm/armv8/mmu.h>
@@ -144,6 +145,18 @@ __weak int meson_board_late_init(void)
 	return 0;
 }
=20
+static void meson_board_try_enter_optimus(void)
+{
+#if (IS_ENABLED(CONFIG_CMD_OPTIMUS))
+	if (!is_tpl_loaded_from_usb())
+		return;
+
+	meson_sm_set_usb_boot_mode(CLEAR_USB_BOOT);
+
+	run_command("optimus", 0);
+#endif
+}
+
 static void meson_board_try_enter_adnl(void)
 {
 #if (IS_ENABLED(CONFIG_CMD_ADNL))
@@ -162,6 +175,8 @@ int board_late_init(void)
=20
 	meson_board_try_enter_adnl();
=20
+	meson_board_try_enter_optimus();
+
 	return meson_board_late_init();
 }
=20
--=20
2.30.1


