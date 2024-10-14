Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845FCD1AD22
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 07:57:55 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.2997.1728939991999533232
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 14:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=ooq9ypMR;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 76205120010;
	Tue, 15 Oct 2024 00:06:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 76205120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728939989;
	bh=Es+/iUePd+xmVMFO4i90g09hwS2bu200EU967AUJ77M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=ooq9ypMRZSHEDXFh7jEsgAwj/l5n4yBe3BbDI9bokmWGxaqw6LLaobaNw8RWDCPpH
	 CLnlTao5DT+pRy6qUYMSPYjwNQ1ixPWMfg64CmLhH8R6m/+iB2F7vDHSTT/OkIUQ1O
	 340BjsSBjjCaDaaMYelTt4M2FcdFG7zpTR5adAyI+R/N21M0QYGjLdfsZdoTvYRHvc
	 G3pU1qFtPacLsVJryolHdQutjfgenPIxOY6hx+YQlx/GYXf1c1llBcHg5ybEw9MLGI
	 KGN1LSNvDUA34fO+evBt6tPDeDvcgx9TuewHr/GvKwONrk2M9fYeTegNKZCYKoJVmj
	 6sUyM3eDDv+Hw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 00:06:29 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Tue, 15 Oct 2024 00:06:14 +0300
Subject: [PATCH v4 2/5] treewide: bcb: move ab_select command to bcb subcommands
MIME-Version: 1.0
Message-ID: <20241015-android_ab_master-v4-2-a91cca9513c4@salutedevices.com>
References: <20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com>
In-Reply-To: <20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728939988; l=19421;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=4RDcRO/M/EOgca3E6mzeiEHmFv/BTX9BorzpmJZtlZI=;
 b=FvQrHXzlJ3zF3a8203ftp9/CDW6bGcL5ZoXS+sXXQfeIa3TYp7QV6UkrPK+wTsRwMF8skTweN
 eynv8/I0KyzCZHSyNxNAGpMeTHOQ/1PvLfdCUUsPiO/bgQQmubMmyAb
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.129.94]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188429 [Oct 14 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;source.denx.de:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/14 18:42:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/14 18:42:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/14 19:21:00 #26753819
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 16 Oct 2024 07:57:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2499

To enhance code organization, it is beneficial to consolidate all A/B
BCB management routines into a single super-command.
The 'bcb' command is an excellent candidate for this purpose.

This patch integrates the separate 'ab_select' command into the 'bcb'
group as the 'ab_select' subcommand, maintaining the same parameter list
for consistency.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 MAINTAINERS                               |  1 -
 cmd/Kconfig                               | 14 ------
 cmd/Makefile                              |  1 -
 cmd/ab_select.c                           | 66 ---------------------------
 cmd/bcb.c                                 | 75 +++++++++++++++++++++++++++++++
 configs/am57xx_evm_defconfig              |  1 -
 configs/am57xx_hs_evm_defconfig           |  1 -
 configs/am57xx_hs_evm_usb_defconfig       |  1 -
 configs/khadas-vim3_android_ab_defconfig  |  1 -
 configs/khadas-vim3l_android_ab_defconfig |  1 -
 configs/sandbox64_defconfig               |  2 +
 configs/sandbox_defconfig                 |  1 -
 doc/android/ab.rst                        | 12 ++---
 include/configs/khadas-vim3_android.h     |  2 +-
 include/configs/khadas-vim3l_android.h    |  2 +-
 include/configs/meson64_android.h         |  4 +-
 include/configs/ti_omap5_common.h         |  4 +-
 test/py/tests/test_android/test_ab.py     |  8 ++--
 18 files changed, 93 insertions(+), 104 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7aefda93d017f07d616f0f6d191129914fbeb484..668ccec9ae6df47192b1af668e3fdbeb1dfa15ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -65,7 +65,6 @@ R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	boot/android_ab.c
-F:	cmd/ab_select.c
 F:	doc/android/ab.rst
 F:	include/android_ab.h
 F:	test/py/tests/test_android/test_ab.py
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 37894eb80d66f98bb5a3b3745d207ddbf7af088d..e1a4a97b042db2491d55398ea1e879ce5a83930e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1774,20 +1774,6 @@ config CMD_XXD
 
 endmenu
 
-menu "Android support commands"
-
-config CMD_AB_SELECT
-	bool "ab_select"
-	depends on ANDROID_AB
-	help
-	  On Android devices with more than one boot slot (multiple copies of
-	  the kernel and system images) this provides a command to select which
-	  slot should be used to boot from and register the boot attempt. This
-	  is used by the new A/B update model where one slot is updated in the
-	  background while running from the other slot.
-
-endmenu
-
 if NET
 
 menuconfig CMD_NET
diff --git a/cmd/Makefile b/cmd/Makefile
index 91227f1249cbda5f7b383e8865c8cc23f3ad5f44..0fd7da3c0de91822c4299cc7034193c497d622b1 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_CMD_2048) += 2048.o
 obj-$(CONFIG_CMD_ACPI) += acpi.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_AES) += aes.o
-obj-$(CONFIG_CMD_AB_SELECT) += ab_select.o
 obj-$(CONFIG_CMD_ADC) += adc.o
 obj-$(CONFIG_CMD_ARMFLASH) += armflash.o
 obj-$(CONFIG_BLK) += blk_common.o
diff --git a/cmd/ab_select.c b/cmd/ab_select.c
deleted file mode 100644
index 7c178c728ca4c8b5bcba02a04eef2d6a7c86afb6..0000000000000000000000000000000000000000
--- a/cmd/ab_select.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: BSD-2-Clause
-/*
- * Copyright (C) 2017 The Android Open Source Project
- */
-
-#include <android_ab.h>
-#include <command.h>
-#include <env.h>
-#include <part.h>
-
-static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
-			char *const argv[])
-{
-	int ret;
-	struct blk_desc *dev_desc;
-	struct disk_partition part_info;
-	char slot[2];
-	bool dec_tries = true;
-
-	if (argc < 4)
-		return CMD_RET_USAGE;
-
-	for (int i = 4; i < argc; i++) {
-		if (strcmp(argv[i], "--no-dec") == 0) {
-			dec_tries = false;
-		} else {
-			return CMD_RET_USAGE;
-		}
-	}
-
-	/* Lookup the "misc" partition from argv[2] and argv[3] */
-	if (part_get_info_by_dev_and_name_or_num(argv[2], argv[3],
-						 &dev_desc, &part_info,
-						 false) < 0) {
-		return CMD_RET_FAILURE;
-	}
-
-	ret = ab_select_slot(dev_desc, &part_info, dec_tries);
-	if (ret < 0) {
-		printf("Android boot failed, error %d.\n", ret);
-		return CMD_RET_FAILURE;
-	}
-
-	/* Android standard slot names are 'a', 'b', ... */
-	slot[0] = BOOT_SLOT_NAME(ret);
-	slot[1] = '\0';
-	env_set(argv[1], slot);
-	printf("ANDROID: Booting slot: %s\n", slot);
-	return CMD_RET_SUCCESS;
-}
-
-U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
-	   "Select the slot used to boot from and register the boot attempt.",
-	   "<slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
-	   "    - Load the slot metadata from the partition 'part' on\n"
-	   "      device type 'interface' instance 'dev' and store the active\n"
-	   "      slot in the 'slot_var_name' variable. This also updates the\n"
-	   "      Android slot metadata with a boot attempt, which can cause\n"
-	   "      successive calls to this function to return a different result\n"
-	   "      if the returned slot runs out of boot attempts.\n"
-	   "    - If 'part_name' is passed, preceded with a # instead of :, the\n"
-	   "      partition name whose label is 'part_name' will be looked up in\n"
-	   "      the partition table. This is commonly the \"misc\" partition.\n"
-           "    - If '--no-dec' is set, the number of tries remaining will not\n"
-           "      decremented for the selected boot slot\n"
-);
diff --git a/cmd/bcb.c b/cmd/bcb.c
index 97a96c009641cc094645607ef833575f3c03fe4b..bf28726da91134fa287ca8aada884ed74ecc8f2b 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -8,6 +8,7 @@
 #include <android_bootloader_message.h>
 #include <bcb.h>
 #include <command.h>
+#include <android_ab.h>
 #include <display_options.h>
 #include <log.h>
 #include <part.h>
@@ -23,6 +24,9 @@ enum bcb_cmd {
 	BCB_CMD_FIELD_TEST,
 	BCB_CMD_FIELD_DUMP,
 	BCB_CMD_STORE,
+#ifdef CONFIG_ANDROID_AB
+	BCB_CMD_AB_SELECT,
+#endif
 };
 
 static const char * const fields[] = {
@@ -52,6 +56,10 @@ static int bcb_cmd_get(char *cmd)
 		return BCB_CMD_STORE;
 	if (!strcmp(cmd, "dump"))
 		return BCB_CMD_FIELD_DUMP;
+#ifdef CONFIG_ANDROID_AB
+	if (!strcmp(cmd, "ab_select"))
+		return BCB_CMD_AB_SELECT;
+#endif
 	else
 		return -1;
 }
@@ -85,6 +93,12 @@ static int bcb_is_misused(int argc, char *const argv[])
 		if (argc != 2)
 			goto err;
 		break;
+#ifdef CONFIG_ANDROID_AB
+	case BCB_CMD_AB_SELECT:
+		if (argc != 4 && argc != 5)
+			goto err;
+		return 0;
+#endif
 	default:
 		printf("Error: 'bcb %s' not supported\n", argv[0]);
 		return -1;
@@ -414,6 +428,46 @@ void bcb_reset(void)
 	__bcb_reset();
 }
 
+#ifdef CONFIG_ANDROID_AB
+static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char * const argv[])
+{
+	int ret;
+	struct blk_desc *dev_desc;
+	struct disk_partition part_info;
+	char slot[2];
+	bool dec_tries = true;
+
+	for (int i = 4; i < argc; i++) {
+		if (strcmp(argv[i], "--no-dec") == 0)
+			dec_tries = false;
+		else
+			return CMD_RET_USAGE;
+	}
+
+	/* Lookup the "misc" partition from argv[2] and argv[3] */
+	if (part_get_info_by_dev_and_name_or_num(argv[2], argv[3],
+						 &dev_desc, &part_info,
+						 false) < 0) {
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ab_select_slot(dev_desc, &part_info, dec_tries);
+	if (ret < 0) {
+		printf("Android boot failed, error %d.\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	/* Android standard slot names are 'a', 'b', ... */
+	slot[0] = BOOT_SLOT_NAME(ret);
+	slot[1] = '\0';
+	env_set(argv[1], slot);
+	printf("ANDROID: Booting slot: %s\n", slot);
+
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static struct cmd_tbl cmd_bcb_sub[] = {
 	U_BOOT_CMD_MKENT(load, CONFIG_SYS_MAXARGS, 1, do_bcb_load, "", ""),
 	U_BOOT_CMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bcb_set, "", ""),
@@ -421,6 +475,10 @@ static struct cmd_tbl cmd_bcb_sub[] = {
 	U_BOOT_CMD_MKENT(test, CONFIG_SYS_MAXARGS, 1, do_bcb_test, "", ""),
 	U_BOOT_CMD_MKENT(dump, CONFIG_SYS_MAXARGS, 1, do_bcb_dump, "", ""),
 	U_BOOT_CMD_MKENT(store, CONFIG_SYS_MAXARGS, 1, do_bcb_store, "", ""),
+#ifdef CONFIG_ANDROID_AB
+	U_BOOT_CMD_MKENT(ab_select, CONFIG_SYS_MAXARGS, 1,
+			 do_bcb_ab_select, "", ""),
+#endif
 };
 
 static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -460,6 +518,23 @@ U_BOOT_CMD(
 	"bcb dump  <field>              - dump  BCB <field>\n"
 	"bcb store                      - store BCB back to <interface>\n"
 	"\n"
+#ifdef CONFIG_ANDROID_AB
+	"bcb ab_select -\n"
+	"    Select the slot used to boot from and register the boot attempt.\n"
+	"    <slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
+	"    - Load the slot metadata from the partition 'part' on\n"
+	"      device type 'interface' instance 'dev' and store the active\n"
+	"      slot in the 'slot_var_name' variable. This also updates the\n"
+	"      Android slot metadata with a boot attempt, which can cause\n"
+	"      successive calls to this function to return a different result\n"
+	"      if the returned slot runs out of boot attempts.\n"
+	"    - If 'part_name' is passed, preceded with a # instead of :, the\n"
+	"      partition name whose label is 'part_name' will be looked up in\n"
+	"      the partition table. This is commonly the \"misc\" partition.\n"
+	"    - If '--no-dec' is set, the number of tries remaining will not\n"
+	"      decremented for the selected boot slot\n"
+	"\n"
+#endif
 	"Legend:\n"
 	"<interface> - storage device interface (virtio, mmc, etc)\n"
 	"<dev>       - storage device index containing the BCB partition\n"
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index efc154eda043ff3ea08194288e33792ce48282f9..b793f00babe474ea3f15292fb4015a7120401238 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -48,7 +48,6 @@ CONFIG_CMD_SPL=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_BCB=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_AB_SELECT=y
 CONFIG_BOOTP_DNS2=y
 # CONFIG_CMD_PMIC is not set
 CONFIG_CMD_AVB=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 0f8533e15dbd7c0186a513b27b46a0407b6f79f1..5cacd7f9cc53d338d52120186b16684add93fd21 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -44,7 +44,6 @@ CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_BCB=y
-CONFIG_CMD_AB_SELECT=y
 CONFIG_BOOTP_DNS2=y
 # CONFIG_CMD_PMIC is not set
 CONFIG_CMD_AVB=y
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 81a938339d5934605cb7defa04ea92f76468b21a..2d8068ecdc79c01c1281ab3873fc892aa4c96be7 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -46,7 +46,6 @@ CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_BCB=y
-CONFIG_CMD_AB_SELECT=y
 CONFIG_BOOTP_DNS2=y
 # CONFIG_CMD_PMIC is not set
 CONFIG_CMD_AVB=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index 510fe4f8928fe39a040a615636fa550b3e0dc5db..de5357c45cbfe4742d9491a29386850570acc235 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index d2da8ff2a69b209b8fb22a48be537bd4dd17a3bb..4d7b90f23002e464d7dc40516bcd3161b0f59439 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1b3b8c6e788cd6845b61e62a06b730da28831edc..b5f80b8572ad32b2a92d4fe82c9068c453c11dfd 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -27,6 +27,7 @@ CONFIG_CONSOLE_RECORD=y
 CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_ANDROID_AB=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
 CONFIG_CMD_BOOTZ=y
@@ -46,6 +47,7 @@ CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_BCB=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f31ecef4f58ee201f93c61cd072d6f688b091c3b..749f53559f708ee52fb7c9c638aedcbcb2f23b72 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -103,7 +103,6 @@ CONFIG_CMD_AXI=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_SETEXPR_FMT=y
 CONFIG_CMD_XXD=y
-CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_DHCP6=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_PCAP=y
diff --git a/doc/android/ab.rst b/doc/android/ab.rst
index 2adf88781d60b61d1b3c74efe976a684b590c813..7fd4aeb6a724b839de9be5e9a8843ade2ad3667e 100644
--- a/doc/android/ab.rst
+++ b/doc/android/ab.rst
@@ -18,7 +18,7 @@ The A/B updates support can be activated by specifying next options in
 your board configuration file::
 
     CONFIG_ANDROID_AB=y
-    CONFIG_CMD_AB_SELECT=y
+    CONFIG_CMD_BCB=y
 
 The disk space on target device must be partitioned in a way so that each
 partition which needs to be updated has two or more instances. The name of
@@ -26,8 +26,8 @@ each instance must be formed by adding suffixes: ``_a``, ``_b``, ``_c``, etc.
 For example: ``boot_a``, ``boot_b``, ``system_a``, ``system_b``, ``vendor_a``,
 ``vendor_b``.
 
-As a result you can use ``ab_select`` command to ensure A/B boot process in your
-boot script. This command analyzes and processes A/B metadata stored on a
+As a result you can use ``bcb ab_select`` command to ensure A/B boot process in
+your boot script. This command analyzes and processes A/B metadata stored on a
 special partition (e.g. ``misc``) and determines which slot should be used for
 booting up.
 
@@ -42,15 +42,15 @@ Command usage
 
 .. code-block:: none
 
-    ab_select <slot_var_name> <interface> <dev[:part_number|#part_name]>
+    bcb ab_select <slot_var_name> <interface> <dev[:part_number|#part_name]>
 
 for example::
 
-    => ab_select slot_name mmc 1:4
+    => bcb ab_select slot_name mmc 1:4
 
 or::
 
-    => ab_select slot_name mmc 1#misc
+    => bcb ab_select slot_name mmc 1#misc
 
 Result::
 
diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index da6adf6c413add03413f40987959a24ad0d41e62..5468ac5878b34b82a70db84c209bab9f3a9dd79f 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -12,7 +12,7 @@
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#if defined(CONFIG_CMD_AB_SELECT)
+#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index b1768e2d821176452254fb07f2e3747402b9b4fd..32821b942109feae5ade9f7fd02924bca34cf58b 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -12,7 +12,7 @@
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#if defined(CONFIG_CMD_AB_SELECT)
+#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index c0e977abb01fb9efb7a462906a0073c84c800897..cc626dbf02418a49b367c8386797ce6ffc28c85b 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -47,13 +47,13 @@
 #define AVB_VERIFY_CMD ""
 #endif
 
-#if defined(CONFIG_CMD_AB_SELECT)
+#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
 #define ANDROIDBOOT_GET_CURRENT_SLOT_CMD "get_current_slot=" \
 	"if part number mmc ${mmcdev} " CONTROL_PARTITION " control_part_number; " \
 	"then " \
 		"echo " CONTROL_PARTITION \
 			" partition number:${control_part_number};" \
-		"ab_select current_slot mmc ${mmcdev}:${control_part_number};" \
+		"bcb ab_select current_slot mmc ${mmcdev}:${control_part_number};" \
 	"else " \
 		"echo " CONTROL_PARTITION " partition not found;" \
 	"fi;\0"
diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index 26494ae980108ad84eb173a0deaa7b701a5309d4..26b6c1cd188c05371c6455cd6247f07a1773d885 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -93,13 +93,13 @@
 
 #define CONTROL_PARTITION "misc"
 
-#if defined(CONFIG_CMD_AB_SELECT)
+#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
 #define AB_SELECT_SLOT \
 	"if part number mmc 1 " CONTROL_PARTITION " control_part_number; " \
 	"then " \
 		"echo " CONTROL_PARTITION \
 			" partition number:${control_part_number};" \
-		"ab_select slot_name mmc ${mmcdev}:${control_part_number};" \
+		"bcb ab_select slot_name mmc ${mmcdev}:${control_part_number};" \
 	"else " \
 		"echo " CONTROL_PARTITION " partition not found;" \
 		"exit;" \
diff --git a/test/py/tests/test_android/test_ab.py b/test/py/tests/test_android/test_ab.py
index c79cb07fda35dfeb608ac7345cd3f22744e2e491..0d7b7995a9fab6e3daad748721818b9e4cfac452 100644
--- a/test/py/tests/test_android/test_ab.py
+++ b/test/py/tests/test_android/test_ab.py
@@ -56,20 +56,20 @@ def ab_disk_image(u_boot_console):
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('android_ab')
-@pytest.mark.buildconfigspec('cmd_ab_select')
+@pytest.mark.buildconfigspec('cmd_bcb')
 @pytest.mark.requiredtool('sgdisk')
 def test_ab(ab_disk_image, u_boot_console):
-    """Test the 'ab_select' command."""
+    """Test the 'bcb ab_select' command."""
 
     u_boot_console.run_command('host bind 0 ' + ab_disk_image.path)
 
-    output = u_boot_console.run_command('ab_select slot_name host 0#misc')
+    output = u_boot_console.run_command('bcb ab_select slot_name host 0#misc')
     assert 're-initializing A/B metadata' in output
     assert 'Attempting slot a, tries remaining 7' in output
     output = u_boot_console.run_command('printenv slot_name')
     assert 'slot_name=a' in output
 
-    output = u_boot_console.run_command('ab_select slot_name host 0:1')
+    output = u_boot_console.run_command('bcb ab_select slot_name host 0:1')
     assert 'Attempting slot b, tries remaining 7' in output
     output = u_boot_console.run_command('printenv slot_name')
     assert 'slot_name=b' in output

-- 
2.43.0


