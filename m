Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F550D1A45A
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.5723.1728418708223733940
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 13:18:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=DsIsF0jD;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E5F15100008;
	Tue,  8 Oct 2024 23:18:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E5F15100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728418704;
	bh=xvCNYDOt7bkNJlCvGjE0DnRCwyi1iy7IXkDx3hTqiIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=DsIsF0jDSdgIuWSLDImi9R3psqPm1Lh4qW2zPd9cPTE2iHINTvHnLqg0gkUJ7J+Kl
	 jP8bBSt4lKA8kOZzsufOaLku+xnbxLA7VBBinkEObEbWQt5oZyIg7AI0TTvYhmGwAn
	 jneR2WckNd8FPVn9g9mf96MfkZ7JcB8qNOzWb82fRWt0FlkFNfccDLBptg90DXAX97
	 yVNo1dsgl5liz7kXwbcau3XJMy+zPnCbW8M+GAfofa3X8RnhIr5rzJAnunaFPR536v
	 p+PXGSZqsQJCxDFBQo3B0s0ZAcFKPP3UDB8DppsRRywmubtnxAcJCqnmBjDnh0qKIn
	 nVXo/cHSdvKrw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 23:18:24 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Tue, 8 Oct 2024 23:18:04 +0300
Subject: [PATCH v3 1/6] include/android_ab: move ab_select_slot() documentation to @ notation
MIME-Version: 1.0
Message-ID: <20241008-android_ab_master-v3-1-f292c45a33e4@salutedevices.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728418703; l=5778;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=hakh7FlSOyijBR2x3swZ7TSCfY2c3naOzKoKmxp26Z0=;
 b=FYEKVB9m0i/GSa2ewxzqh2//VXZCjzlkaXL0nERN3fgV49aDkG46Wq7VF+r380oy7eXmZ3Mhm
 pUAVaYmHDzMAR8LbsN3N8OL3PRaF+z99XKsWJdyZn4UI4Nt55u7vZXv
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
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2472

There are new function documentation requirements in U-Boot, so apply
these changes for android_ab.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c    | 43 ++++++++++++++++++++++++-------------------
 include/android_ab.h |  7 ++++---
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 1196a189ed5349ca5c088e3b6ef1796b11c69a84..0045c8133a8e164f1fdd4c0f9b683de0f13f26e0 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -13,13 +13,13 @@
 #include <u-boot/crc.h>
 
 /**
- * Compute the CRC-32 of the bootloader control struct.
+ * ab_control_compute_crc() - Compute the CRC32 of the bootloader control.
+ *
+ * @abc: Bootloader control block
  *
  * Only the bytes up to the crc32_le field are considered for the CRC-32
  * calculation.
  *
- * @param[in] abc bootloader control block
- *
  * Return: crc32 sum
  */
 static uint32_t ab_control_compute_crc(struct bootloader_control *abc)
@@ -28,14 +28,14 @@ static uint32_t ab_control_compute_crc(struct bootloader_control *abc)
 }
 
 /**
- * Initialize bootloader_control to the default value.
+ * ab_control_default() - Initialize bootloader_control to the default value.
+ *
+ * @abc: Bootloader control block
  *
  * It allows us to boot all slots in order from the first one. This value
  * should be used when the bootloader message is corrupted, but not when
  * a valid message indicates that all slots are unbootable.
  *
- * @param[in] abc bootloader control block
- *
  * Return: 0 on success and a negative on error
  */
 static int ab_control_default(struct bootloader_control *abc)
@@ -67,7 +67,13 @@ static int ab_control_default(struct bootloader_control *abc)
 }
 
 /**
- * Load the boot_control struct from disk into newly allocated memory.
+ * ab_control_create_from_disk() - Load the boot_control from disk into memory.
+ *
+ * @dev_desc: Device where to read the boot_control struct from
+ * @part_info: Partition in 'dev_desc' where to read from, normally
+ *             the "misc" partition should be used
+ * @abc: pointer to pointer to bootloader_control data
+ * @offset: boot_control struct offset
  *
  * This function allocates and returns an integer number of disk blocks,
  * based on the block size of the passed device to help performing a
@@ -75,10 +81,6 @@ static int ab_control_default(struct bootloader_control *abc)
  * The boot_control struct offset (2 KiB) must be a multiple of the device
  * block size, for simplicity.
  *
- * @param[in] dev_desc Device where to read the boot_control struct from
- * @param[in] part_info Partition in 'dev_desc' where to read from, normally
- *			the "misc" partition should be used
- * @param[out] pointer to pointer to bootloader_control data
  * Return: 0 on success and a negative on error
  */
 static int ab_control_create_from_disk(struct blk_desc *dev_desc,
@@ -122,15 +124,17 @@ static int ab_control_create_from_disk(struct blk_desc *dev_desc,
 }
 
 /**
- * Store the loaded boot_control block.
+ * ab_control_store() - Store the loaded boot_control block.
+ *
+ * @dev_desc: Device where we should write the boot_control struct
+ * @part_info: Partition on the 'dev_desc' where to write
+ * @abc Pointer to the boot control struct and the extra bytes after
+ *      it up to the nearest block boundary
+ * @offset: boot_control struct offset
  *
  * Store back to the same location it was read from with
  * ab_control_create_from_misc().
  *
- * @param[in] dev_desc Device where we should write the boot_control struct
- * @param[in] part_info Partition on the 'dev_desc' where to write
- * @param[in] abc Pointer to the boot control struct and the extra bytes after
- *                it up to the nearest block boundary
  * Return: 0 on success and a negative on error
  */
 static int ab_control_store(struct blk_desc *dev_desc,
@@ -160,12 +164,13 @@ static int ab_control_store(struct blk_desc *dev_desc,
 }
 
 /**
- * Compare two slots.
+ * ab_compare_slots() - Compare two slots.
+ *
+ * @a: The first bootable slot metadata
+ * @b: The second bootable slot metadata
  *
  * The function determines slot which is should we boot from among the two.
  *
- * @param[in] a The first bootable slot metadata
- * @param[in] b The second bootable slot metadata
  * Return: Negative if the slot "a" is better, positive of the slot "b" is
  *         better or 0 if they are equally good.
  */
diff --git a/include/android_ab.h b/include/android_ab.h
index dbf20343da62447a237ec845e216517d34455ad3..1e53879a25f145a9d18ac0a6553d8c217123aa6f 100644
--- a/include/android_ab.h
+++ b/include/android_ab.h
@@ -18,7 +18,10 @@ struct disk_partition;
 #define NUM_SLOTS 2
 
 /**
- * Select the slot where to boot from.
+ * ab_select_slot() - Select the slot where to boot from.
+ *
+ * @dev_desc: Place to store the device description pointer
+ * @part_info: Place to store the partition information
  *
  * On Android devices with more than one boot slot (multiple copies of the
  * kernel and system images) selects which slot should be used to boot from and
@@ -28,8 +31,6 @@ struct disk_partition;
  * registered before returning from this function so it isn't selected
  * indefinitely.
  *
- * @param[in] dev_desc Place to store the device description pointer
- * @param[in] part_info Place to store the partition information
  * Return: The slot number (>= 0) on success, or a negative on error
  */
 int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,

-- 
2.43.0


