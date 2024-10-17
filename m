Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2CD2C542
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:31 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.49566.1729174338711306506
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 07:12:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=aXGXOfPF;
 spf=temperror, err=temporary DNS error (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BF438100017;
	Thu, 17 Oct 2024 17:12:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BF438100017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729174336;
	bh=QOQJxDWZyXcx/NmAN9SpffqWixgGWVwpvVHWhDKUF4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=aXGXOfPFSI/xpzMY9K9O+yj+egdLj7eoxOuxWou4XbOTsHgjBaWNouTG8aenLGijZ
	 8OTI/TUFjx4lS8YReVDGlkZUYdq0El+e4VzkKNuw+iZOB/GZTE/Xr35rYWjoSw5tN9
	 JJ/41dZ4Uc6qH+WRDL2+4yby8X2Sb9C1DuWJjTGVtgkWQikCv08QObRf6Jzb4IFUGb
	 OpphJugcH8DLT+WuKzdXEs5rlXCuvUdoYI26TbZnBe71C9qnBnx8yr56TtJGJc/0Td
	 k1seqfX2GThZw7eZ3apzJWs3LVKVtZFFs6Rhk9/xVepqvghM+qzZok7cyRIeEzeRGL
	 G9eD/EIldt2FQ==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 17 Oct 2024 17:12:16 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Thu, 17 Oct 2024 17:12:10 +0300
Subject: [PATCH v5 5/6] cmd: bcb: introduce 'ab_dump' command to print BCB block content
MIME-Version: 1.0
Message-ID: <20241017-android_ab_master-v5-5-43bfcc096d95@salutedevices.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729174334; l=8376;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=gvBsihyaXdS5fgq0Qw1ZfoiWHyl/iHOypq81YbrjQr8=;
 b=+f9S4HFlLmtpO5mbulQpHCK1sHQ8HH+gDvLUM8VXddjIA7BUp6mYLwjD2E2KKp3UA7+fe8xHQ
 mS5litDkONJCTgNDhuwT/NfGBhxDvs0nczrB0nnPmNxJXEL93gXzOir
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
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2526

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

The ab_dump command allows you to display ABC data directly on the
U-Boot console. During an A/B test execution, this test verifies the
accuracy of each field within the ABC data.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c                     | 68 +++++++++++++++++++++++++++++++++++
 cmd/bcb.c                             | 31 ++++++++++++++++
 include/android_ab.h                  | 10 ++++++
 test/py/tests/test_android/test_ab.py | 23 ++++++++++++
 4 files changed, 132 insertions(+)

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
index b33c046af0385a112fd40634ab7f48e05542ca48..16eabfe00f5a443f710e5084d187e374f89f6d3a 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -419,6 +419,32 @@ __maybe_unused static int do_bcb_ab_select(struct cmd_tbl *cmdtp,
 	return CMD_RET_SUCCESS;
 }
 
+__maybe_unused static int do_bcb_ab_dump(struct cmd_tbl *cmdtp,
+					 int flag, int argc,
+					 char *const argv[])
+{
+	int ret;
+	struct blk_desc *dev_desc;
+	struct disk_partition part_info;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
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
 U_BOOT_LONGHELP(bcb,
 	"load <interface> <dev> <part>  - load  BCB from <interface> <dev>:<part>\n"
 	"load <dev> <part>              - load  BCB from mmc <dev>:<part>\n"
@@ -444,6 +470,10 @@ U_BOOT_LONGHELP(bcb,
 	"    - If '--no-dec' is set, the number of tries remaining will not\n"
 	"      decremented for the selected boot slot\n"
 	"\n"
+	"bcb ab_dump -\n"
+	"    Dump boot_control information from specific partition.\n"
+	"    <interface> <dev[:part|#part_name]>\n"
+	"\n"
 #endif
 	"Legend:\n"
 	"<interface> - storage device interface (virtio, mmc, etc)\n"
@@ -468,5 +498,6 @@ U_BOOT_CMD_WITH_SUBCMDS(bcb,
 	U_BOOT_SUBCMD_MKENT(store, 1, 1, do_bcb_store),
 #if IS_ENABLED(CONFIG_ANDROID_AB)
 	U_BOOT_SUBCMD_MKENT(ab_select, 5, 1, do_bcb_ab_select),
+	U_BOOT_SUBCMD_MKENT(ab_dump, 3, 1, do_bcb_ab_dump),
 #endif
 );
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
diff --git a/test/py/tests/test_android/test_ab.py b/test/py/tests/test_android/test_ab.py
index 0d7b7995a9fab6e3daad748721818b9e4cfac452..9bf1a0eb00a6ae1edebf62f07fd162b9c8c02e49 100644
--- a/test/py/tests/test_android/test_ab.py
+++ b/test/py/tests/test_android/test_ab.py
@@ -54,6 +54,27 @@ def ab_disk_image(u_boot_console):
         di = ABTestDiskImage(u_boot_console)
     return di
 
+def ab_dump(u_boot_console, slot_num, crc):
+    output = u_boot_console.run_command('bcb ab_dump host 0#misc')
+    header, slot0, slot1 = output.split('\r\r\n\r\r\n')
+    slots = [slot0, slot1]
+    slot_suffixes = ['_a', '_b']
+
+    header = dict(map(lambda x: map(str.strip, x.split(':')), header.split('\r\r\n')))
+    assert header['Bootloader Control'] == '[misc]'
+    assert header['Active Slot'] == slot_suffixes[slot_num]
+    assert header['Magic Number'] == '0x42414342'
+    assert header['Version'] == '1'
+    assert header['Number of Slots'] == '2'
+    assert header['Recovery Tries Remaining'] == '0'
+    assert header['CRC'] == '{} (Valid)'.format(crc)
+
+    slot = dict(map(lambda x: map(str.strip, x.split(':')), slots[slot_num].split('\r\r\n\t- ')[1:]))
+    assert slot['Priority'] == '15'
+    assert slot['Tries Remaining'] == '6'
+    assert slot['Successful Boot'] == '0'
+    assert slot['Verity Corrupted'] == '0'
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('android_ab')
 @pytest.mark.buildconfigspec('cmd_bcb')
@@ -68,8 +89,10 @@ def test_ab(ab_disk_image, u_boot_console):
     assert 'Attempting slot a, tries remaining 7' in output
     output = u_boot_console.run_command('printenv slot_name')
     assert 'slot_name=a' in output
+    ab_dump(u_boot_console, 0, '0xd438d1b9')
 
     output = u_boot_console.run_command('bcb ab_select slot_name host 0:1')
     assert 'Attempting slot b, tries remaining 7' in output
     output = u_boot_console.run_command('printenv slot_name')
     assert 'slot_name=b' in output
+    ab_dump(u_boot_console, 1, '0x011ec016')

-- 
2.43.0


