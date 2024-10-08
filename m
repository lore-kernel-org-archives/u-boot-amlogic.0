Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAC5CF259D
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.5724.1728418709215021369
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 13:18:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=skHEpLav;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 766F912000B;
	Tue,  8 Oct 2024 23:18:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 766F912000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728418705;
	bh=ajM9WPiCz/IFxcyycHUKpCHQpO/bhGKCOfDgJSraFAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=skHEpLavkWAojpJImm22EFgKKgsSDjcdyXJsRgTcqTPbFbHyjm8hwtxMpSp38G+AK
	 d//BaWUZdIEwiPQ38Ys+9SbxQRXiJwGCCpOYPXsDREDWlK1cF2p+sVvWV6ziE872KU
	 z1bq11pkfw6V7VRKOU74ZofYsN6nVWV6NbwK4d5JuOmXXJIGjt4AbFtBHdWhw/SxM8
	 tYRaTSd3nsOuDxffip1uI4UdTspxQNrkfOl/4/4uGt1qmmSlq5n+E8oTVDV4DYlc33
	 inp1TcbbVdaSCk1g+24c/2U7f0y6sDoe7Ar1Mc+i5AxMDkcjNnBYda1nXOQH+jnvm/
	 occFJeQl2nj8Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 23:18:25 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Tue, 8 Oct 2024 23:18:07 +0300
Subject: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print BCB block content
MIME-Version: 1.0
Message-ID: <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
In-Reply-To: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728418703; l=6871;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=6SCGMYoahpbkvTyZicTsTcFAcZBl1LVyZu/SzMuqP40=;
 b=y8Dg5sQIIIARwFzWT1LzmWEZJxQnXSFEhADNKHvxZkNz0Xqij8offN0vbpcQwqUTgqoQaUIx+
 6UHV/90Oa0lAObiYTn1im1Bq84l30+tGHXLV0ArpmDE2uirQu9pk1da
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.129.94]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188309 [Oct 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/08 14:43:00 #26717371
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2461

It's really helpful to have the ability to dump BCB block for debugging
A/B logic on the board supported this partition schema.

Command 'bcb ab_dump' prints all fields of bootloader_control struct
including slot_metadata for all presented slots.

Output example:
=====
> board# bcb ab_dump ubi 0#misc
> Read 512 bytes from volume misc to 000000000bf07580
> Read 512 bytes from volume misc to 000000000bf42f40
> Bootloader Control:       [misc]
> Active Slot:              _a
> Magic Number:             0x42414342
> Version:                  1
> Number of Slots:          2
> Recovery Tries Remaining: 0
> CRC:                      0x2c8b50bc (Valid)
>
> Slot[0] Metadata:
> 	- Priority:         15
> 	- Tries Remaining:  0
> 	- Successful Boot:  1
> 	- Verity Corrupted: 0
>
> Slot[1] Metadata:
> 	- Priority:         14
> 	- Tries Remaining:  7
> 	- Successful Boot:  0
> 	- Verity Corrupted: 0
====

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 cmd/bcb.c            | 35 +++++++++++++++++++++++++++
 include/android_ab.h | 10 ++++++++
 3 files changed, 113 insertions(+)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 0045c8133a8e164f1fdd4c0f9b683de0f13f26e0..c93e51541019d0fe793303c4b3d5286df061906f 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -372,3 +372,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 
 	return slot;
 }
+
+int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
+{
+	struct bootloader_control *abc;
+	u32 crc32_le;
+	int i, ret;
+	struct slot_metadata *slot;
+
+	if (!dev_desc || !part_info) {
+		log_err("ANDROID: Empty device descriptor or partition info\n");
+		return -EINVAL;
+	}
+
+	ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
+	if (ret < 0) {
+		log_err("ANDROID: Cannot create bcb from disk %d\n", ret);
+		return ret;
+	}
+
+	if (abc->magic != BOOT_CTRL_MAGIC) {
+		log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
+		ret = -ENODATA;
+		goto error;
+	}
+
+	if (abc->version > BOOT_CTRL_VERSION) {
+		log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
+			abc->version);
+		ret = -ENODATA;
+		goto error;
+	}
+
+	if (abc->nb_slot > ARRAY_SIZE(abc->slot_info)) {
+		log_err("ANDROID: Wrong number of slots %u, expected %zu\n",
+			abc->nb_slot, ARRAY_SIZE(abc->slot_info));
+		ret = -ENODATA;
+		goto error;
+	}
+
+	printf("Bootloader Control:       [%s]\n", part_info->name);
+	printf("Active Slot:              %s\n", abc->slot_suffix);
+	printf("Magic Number:             0x%x\n", abc->magic);
+	printf("Version:                  %u\n", abc->version);
+	printf("Number of Slots:          %u\n", abc->nb_slot);
+	printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
+
+	printf("CRC:                      0x%.8x", abc->crc32_le);
+
+	crc32_le = ab_control_compute_crc(abc);
+	if (abc->crc32_le != crc32_le)
+		printf(" (Invalid, Expected: 0x%.8x)\n", crc32_le);
+	else
+		printf(" (Valid)\n");
+
+	for (i = 0; i < abc->nb_slot; ++i) {
+		slot = &abc->slot_info[i];
+		printf("\nSlot[%d] Metadata:\n", i);
+		printf("\t- Priority:         %u\n", slot->priority);
+		printf("\t- Tries Remaining:  %u\n", slot->tries_remaining);
+		printf("\t- Successful Boot:  %u\n", slot->successful_boot);
+		printf("\t- Verity Corrupted: %u\n", slot->verity_corrupted);
+	}
+
+error:
+	free(abc);
+
+	return ret;
+}
diff --git a/cmd/bcb.c b/cmd/bcb.c
index 970c58e56cba0e1bdff21b7cd099f69151f0c5b8..4fd32186ae654915b5a42c26d755e5727c211c63 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -25,6 +25,7 @@ enum bcb_cmd {
 	BCB_CMD_FIELD_DUMP,
 	BCB_CMD_STORE,
 	BCB_CMD_AB_SELECT,
+	BCB_CMD_AB_DUMP,
 };
 
 static const char * const fields[] = {
@@ -56,6 +57,8 @@ static int bcb_cmd_get(char *cmd)
 		return BCB_CMD_FIELD_DUMP;
 	if (!strcmp(cmd, "ab_select"))
 		return BCB_CMD_AB_SELECT;
+	if (!strcmp(cmd, "ab_dump"))
+		return BCB_CMD_AB_DUMP;
 	else
 		return -1;
 }
@@ -93,6 +96,10 @@ static int bcb_is_misused(int argc, char *const argv[])
 		if (argc != 4 && argc != 5)
 			goto err;
 		return 0;
+	case BCB_CMD_AB_DUMP:
+		if (argc != 3)
+			goto err;
+		return 0;
 	default:
 		printf("Error: 'bcb %s' not supported\n", argv[0]);
 		return -1;
@@ -460,6 +467,28 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_bcb_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	int ret;
+	struct blk_desc *dev_desc;
+	struct disk_partition part_info;
+
+	if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
+						 &dev_desc, &part_info,
+						 false) < 0) {
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ab_dump_abc(dev_desc, &part_info);
+	if (ret < 0) {
+		printf("Cannot dump ABC data, error %d.\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_bcb_sub[] = {
 	U_BOOT_CMD_MKENT(load, CONFIG_SYS_MAXARGS, 1, do_bcb_load, "", ""),
 	U_BOOT_CMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bcb_set, "", ""),
@@ -469,6 +498,8 @@ static struct cmd_tbl cmd_bcb_sub[] = {
 	U_BOOT_CMD_MKENT(store, CONFIG_SYS_MAXARGS, 1, do_bcb_store, "", ""),
 	U_BOOT_CMD_MKENT(ab_select, CONFIG_SYS_MAXARGS, 1,
 			 do_bcb_ab_select, "", ""),
+	U_BOOT_CMD_MKENT(ab_dump, CONFIG_SYS_MAXARGS, 1,
+			 do_bcb_ab_dump, "", ""),
 };
 
 static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -523,6 +554,10 @@ U_BOOT_CMD(
 	"    - If '--no-dec' is set, the number of tries remaining will not\n"
 	"      decremented for the selected boot slot\n"
 	"\n"
+	"bcb ab_dump -\n"
+	"    Dump boot_control information from specific partition.\n"
+	"    <interface> <dev[:part|#part_name]>\n"
+	"\n"
 	"Legend:\n"
 	"<interface> - storage device interface (virtio, mmc, etc)\n"
 	"<dev>       - storage device index containing the BCB partition\n"
diff --git a/include/android_ab.h b/include/android_ab.h
index 1e53879a25f145a9d18ac0a6553d8c217123aa6f..838230e06f8cbf7a5d79d9d84d9ebe9f96aca10d 100644
--- a/include/android_ab.h
+++ b/include/android_ab.h
@@ -36,4 +36,14 @@ struct disk_partition;
 int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
                    bool dec_tries);
 
+/**
+ * ab_dump_abc() - Dump ABC information for specific partition.
+ *
+ * @dev_desc: Device description pointer
+ * @part_info: Partition information
+ *
+ * Return: 0 on success, or a negative on error
+ */
+int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
+
 #endif /* __ANDROID_AB_H */

-- 
2.43.0


