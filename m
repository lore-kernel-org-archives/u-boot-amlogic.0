Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443A7D206B4
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 07:57:55 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.2907.1728939991604789518
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 14:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=QydmlH05;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0D4FE100010;
	Tue, 15 Oct 2024 00:06:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0D4FE100010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728939990;
	bh=+j+IW8vxifHe6pyACzyRYsKbz5zLOTLdDa/ndo93de8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=QydmlH05sU50gqaDWpRnD1Thq0W5diBlLliLFB7Bec2P2LYgCgqOCKCa6ZNUIYGPp
	 WsdQJcpWEPDCVazsHWMIPrRoUn3vuh/6JAbDT+tO8sfLQOZyNI7ifYYq5ka66DlDE9
	 dFJv9m3gO+9VTUoiAcq0LRMrlUnIRYf7MEuXlMYeFa4abXG7TkxBKqc+YyL/3d3WjF
	 PRG/FRtNs8IviJcjQo7Lz3CTX2aL8y97ThxeN8f6t9M4HYy/4VlVrI96tVIQpuo7wV
	 tkkn6AUfFOn40Wg0Z2+igHxvwgqYrXTTYt4TuIh1pz1grVm3pVIRZKgrdBT72kf9CP
	 vXj6KBm/fvHRw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 00:06:29 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Tue, 15 Oct 2024 00:06:17 +0300
Subject: [PATCH v4 5/5] common: android_ab: fix slot suffix for abc block
MIME-Version: 1.0
Message-ID: <20241015-android_ab_master-v4-5-a91cca9513c4@salutedevices.com>
References: <20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com>
In-Reply-To: <20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>,
	Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728939988; l=1726;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=UUIcWLaYnMuzq03dG5cd2lwXHRzcgTzDwdC2h1czkVo=;
 b=OB4quftMFXdIQaJyCRoy4j07kuv0vJKMu7C9OG815DttnRDT/+tQ2yG5FSO6Retl78EOZvEA3
 I93KlBcZ5y3CqB8ifdxEQLQH9f53u/wf4GHuCXsYfDW96XVRQiRoLPD
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
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, android-review.googlesource.com:5.0.1,7.1.1;source.android.com:5.0.1,7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2498

To align with the official Android BCB (Bootloader Control Block)
specifications, it's important to note that the slot_suffix should start
with an underscore symbol.

For a comprehensive understanding of the expected slot_suffix format in
userspace, please refer to the provided reference [1].

Links:
[1] - https://source.android.com/docs/core/architecture/bootloader/updating#slots

Based-on: https://android-review.googlesource.com/c/platform/external/u-boot/+/1446439
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index c93e51541019d0fe793303c4b3d5286df061906f..a287eac04fe88ad08bdcf1b1b1d6e564d503d800 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -52,7 +52,7 @@ static int ab_control_default(struct bootloader_control *abc)
 	if (!abc)
 		return -EFAULT;
 
-	memcpy(abc->slot_suffix, "a\0\0\0", 4);
+	memcpy(abc->slot_suffix, "_a\0\0", 4);
 	abc->magic = BOOT_CTRL_MAGIC;
 	abc->version = BOOT_CTRL_VERSION;
 	abc->nb_slot = NUM_SLOTS;
@@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 		 * or the device tree.
 		 */
 		memset(slot_suffix, 0, sizeof(slot_suffix));
-		slot_suffix[0] = BOOT_SLOT_NAME(slot);
+		slot_suffix[0] = '_';
+		slot_suffix[1] = BOOT_SLOT_NAME(slot);
 		if (memcmp(abc->slot_suffix, slot_suffix,
 			   sizeof(slot_suffix))) {
 			memcpy(abc->slot_suffix, slot_suffix,

-- 
2.43.0


