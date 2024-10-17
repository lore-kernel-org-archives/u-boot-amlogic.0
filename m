Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228A6CDDE7F
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:31 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.49570.1729174339759114434
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 07:12:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=Pp0v4KCZ;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 219D512000C;
	Thu, 17 Oct 2024 17:12:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 219D512000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729174336;
	bh=tip4cqj+ZFXCQBmpVIVEZdnebpTCZBNomTy/zGXky9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=Pp0v4KCZWgjZ7dH8yaWdQtFRZEsYdHf5z2+mtPCqBmqdbIbBr8kkRN2wycbGI1Q0S
	 pn4lNRPzKSflOAJ1cB1KIs19cJAi7uxmDOHa+JXI7X7BWV+Z/J6mO2AMhy1U/AP+i+
	 H/nXDvZEhOitawji1ENOBCYZsKJsBgfRrYMnv4aQ//7eLz5C+rlhYOiWNgXPw+M1NT
	 BUkZzwN+yN3GKSQffR6RrmWqeViJAiCYxXGdOHTyn/LPaHhOU88jd6qyWK2QIayhNN
	 1BFAiVKpKDy24u4e95lpR3gUpBfZxIqajmQN/o1dB80N7itt+3cFKf9tGATLsHf22O
	 Hb6LVuVs74u4A==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 17 Oct 2024 17:12:15 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Thu, 17 Oct 2024 17:12:07 +0300
Subject: [PATCH v5 2/6] cmd: bcb: rework the command to U_BOOT_LONGHELP approach
MIME-Version: 1.0
Message-ID: <20241017-android_ab_master-v5-2-43bfcc096d95@salutedevices.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
In-Reply-To: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729174334; l=6299;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=yzLPKtRigdKL53kJ25P8BaIRdoD4e6OOC8vzL2hnex0=;
 b=LxcxvvHTyWfxCK5Wi7sfnuOwIKQlTUeeOpeAL7LLeGU532HFtYX+NIvRZgZgrxKtH89MZyHDW
 5KEh8q/ZBTPDFLsMiD/euDXYUC9L2S4Z73MJSPGjRP8O/XdVMv/3NYw
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.226.150]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188512 [Oct 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/17 12:16:00 #26766523
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 23 Oct 2024 12:18:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2525

U_BOOT_LONGHELP and U_BOOT_CMD_WITH_SUBCMDS offer numerous advantages,
including:
- common argument restrictions checking
- automatic subcommand matching
- improved usage and help handling

By utilizing the U_BOOT_LONGHELP approach, we can reduce the amount of
command management code and describe commands more succinctly.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 cmd/bcb.c | 151 ++++++++++++++++++--------------------------------------------
 1 file changed, 43 insertions(+), 108 deletions(-)

diff --git a/cmd/bcb.c b/cmd/bcb.c
index 97a96c009641cc094645607ef833575f3c03fe4b..98b2a71087a27b1721f4bed4160095d65ec75402 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -16,15 +16,6 @@
 #include <vsprintf.h>
 #include <linux/err.h>
 
-enum bcb_cmd {
-	BCB_CMD_LOAD,
-	BCB_CMD_FIELD_SET,
-	BCB_CMD_FIELD_CLEAR,
-	BCB_CMD_FIELD_TEST,
-	BCB_CMD_FIELD_DUMP,
-	BCB_CMD_STORE,
-};
-
 static const char * const fields[] = {
 	"command",
 	"status",
@@ -38,67 +29,9 @@ static struct disk_partition partition_data;
 static struct blk_desc *block;
 static struct disk_partition *partition = &partition_data;
 
-static int bcb_cmd_get(char *cmd)
-{
-	if (!strcmp(cmd, "load"))
-		return BCB_CMD_LOAD;
-	if (!strcmp(cmd, "set"))
-		return BCB_CMD_FIELD_SET;
-	if (!strcmp(cmd, "clear"))
-		return BCB_CMD_FIELD_CLEAR;
-	if (!strcmp(cmd, "test"))
-		return BCB_CMD_FIELD_TEST;
-	if (!strcmp(cmd, "store"))
-		return BCB_CMD_STORE;
-	if (!strcmp(cmd, "dump"))
-		return BCB_CMD_FIELD_DUMP;
-	else
-		return -1;
-}
-
-static int bcb_is_misused(int argc, char *const argv[])
+static int bcb_not_loaded(void)
 {
-	int cmd = bcb_cmd_get(argv[0]);
-
-	switch (cmd) {
-	case BCB_CMD_LOAD:
-		if (argc != 3 && argc != 4)
-			goto err;
-		break;
-	case BCB_CMD_FIELD_SET:
-		if (argc != 3)
-			goto err;
-		break;
-	case BCB_CMD_FIELD_TEST:
-		if (argc != 4)
-			goto err;
-		break;
-	case BCB_CMD_FIELD_CLEAR:
-		if (argc != 1 && argc != 2)
-			goto err;
-		break;
-	case BCB_CMD_STORE:
-		if (argc != 1)
-			goto err;
-		break;
-	case BCB_CMD_FIELD_DUMP:
-		if (argc != 2)
-			goto err;
-		break;
-	default:
-		printf("Error: 'bcb %s' not supported\n", argv[0]);
-		return -1;
-	}
-
-	if (cmd != BCB_CMD_LOAD && !block) {
-		printf("Error: Please, load BCB first!\n");
-		return -1;
-	}
-
-	return 0;
-err:
-	printf("Error: Bad usage of 'bcb %s'\n", argv[0]);
-
+	printf("Error: Please, load BCB first!\n");
 	return -1;
 }
 
@@ -216,6 +149,9 @@ static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
 	char *endp;
 	char *iface = "mmc";
 
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
 	if (argc == 4) {
 		iface = argv[1];
 		argc--;
@@ -270,6 +206,12 @@ static int __bcb_set(const char *fieldp, const char *valp)
 static int do_bcb_set(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char * const argv[])
 {
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	if (!block)
+		return bcb_not_loaded();
+
 	return __bcb_set(argv[1], argv[2]);
 }
 
@@ -279,6 +221,9 @@ static int do_bcb_clear(struct cmd_tbl *cmdtp, int flag, int argc,
 	int size;
 	char *field;
 
+	if (!block)
+		return bcb_not_loaded();
+
 	if (argc == 1) {
 		memset(&bcb, 0, sizeof(bcb));
 		return CMD_RET_SUCCESS;
@@ -297,7 +242,15 @@ static int do_bcb_test(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int size;
 	char *field;
-	char *op = argv[2];
+	char *op;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+
+	if (!block)
+		return bcb_not_loaded();
+
+	op = argv[2];
 
 	if (bcb_field_get(argv[1], &field, &size))
 		return CMD_RET_FAILURE;
@@ -325,6 +278,12 @@ static int do_bcb_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 	int size;
 	char *field;
 
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	if (!block)
+		return bcb_not_loaded();
+
 	if (bcb_field_get(argv[1], &field, &size))
 		return CMD_RET_FAILURE;
 
@@ -356,6 +315,9 @@ err:
 static int do_bcb_store(struct cmd_tbl *cmdtp, int flag, int argc,
 			char * const argv[])
 {
+	if (!block)
+		return bcb_not_loaded();
+
 	return __bcb_store();
 }
 
@@ -414,44 +376,7 @@ void bcb_reset(void)
 	__bcb_reset();
 }
 
-static struct cmd_tbl cmd_bcb_sub[] = {
-	U_BOOT_CMD_MKENT(load, CONFIG_SYS_MAXARGS, 1, do_bcb_load, "", ""),
-	U_BOOT_CMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bcb_set, "", ""),
-	U_BOOT_CMD_MKENT(clear, CONFIG_SYS_MAXARGS, 1, do_bcb_clear, "", ""),
-	U_BOOT_CMD_MKENT(test, CONFIG_SYS_MAXARGS, 1, do_bcb_test, "", ""),
-	U_BOOT_CMD_MKENT(dump, CONFIG_SYS_MAXARGS, 1, do_bcb_dump, "", ""),
-	U_BOOT_CMD_MKENT(store, CONFIG_SYS_MAXARGS, 1, do_bcb_store, "", ""),
-};
-
-static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct cmd_tbl *c;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	argc--;
-	argv++;
-
-	c = find_cmd_tbl(argv[0], cmd_bcb_sub, ARRAY_SIZE(cmd_bcb_sub));
-	if (!c)
-		return CMD_RET_USAGE;
-
-	if (bcb_is_misused(argc, argv)) {
-		/*
-		 * We try to improve the user experience by reporting the
-		 * root-cause of misusage, so don't return CMD_RET_USAGE,
-		 * since the latter prints out the full-blown help text
-		 */
-		return CMD_RET_FAILURE;
-	}
-
-	return c->cmd(cmdtp, flag, argc, argv);
-}
-
-U_BOOT_CMD(
-	bcb, CONFIG_SYS_MAXARGS, 1, do_bcb,
-	"Load/set/clear/test/dump/store Android BCB fields",
+U_BOOT_LONGHELP(bcb,
 	"load <interface> <dev> <part>  - load  BCB from <interface> <dev>:<part>\n"
 	"load <dev> <part>              - load  BCB from mmc <dev>:<part>\n"
 	"bcb set   <field> <val>        - set   BCB <field> to <val>\n"
@@ -472,3 +397,13 @@ U_BOOT_CMD(
 	"              NOTE: any ':' character in <val> will be replaced by line feed\n"
 	"              during 'bcb set' and used as separator by upper layers\n"
 );
+
+U_BOOT_CMD_WITH_SUBCMDS(bcb,
+	"Load/set/clear/test/dump/store Android BCB fields", bcb_help_text,
+	U_BOOT_SUBCMD_MKENT(load, 4, 1, do_bcb_load),
+	U_BOOT_SUBCMD_MKENT(set, 3, 1, do_bcb_set),
+	U_BOOT_SUBCMD_MKENT(clear, 2, 1, do_bcb_clear),
+	U_BOOT_SUBCMD_MKENT(test, 4, 1, do_bcb_test),
+	U_BOOT_SUBCMD_MKENT(dump, 2, 1, do_bcb_dump),
+	U_BOOT_SUBCMD_MKENT(store, 1, 1, do_bcb_store),
+);

-- 
2.43.0


