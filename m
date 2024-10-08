Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D019CCFC505
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.5721.1728418708105464224
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 13:18:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=jmTJQQax;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C5A6B120014;
	Tue,  8 Oct 2024 23:18:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C5A6B120014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728418705;
	bh=Uxeb14KzVHf4bXeyG8wQH306MEmWmcGkNnkUVcG2MnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=jmTJQQaxl4p0pk2yyuZbwZqyWZc7VNshOtn52sHTHnfWeR1pqUD1FByzvfQwX6xHc
	 F2kpbgkatxj62dNPs4qPX/Wvqr0C5mVfQXCpWhww5t9pX+6saypreqsDuaZ5Ayt06L
	 bHxqAzXs7NdzfyFaG7xQWOhl/NICNHA8iy/U65Ys/3VydhvPRTaYdpxKCSrPkWOxSH
	 deyphdZmQRQdv3RvY97Oj4Sc+MPtB6qXoUULatkzpMugEZll9z8cZcUyR6TzHiIbTn
	 ULBnClCFZKXpu1iZ6vtYBjxEZ/WQgfna1EwcLyD67ZMrxEIEsrGUVOjQO+mkWDCEQi
	 3vpFnI3tCKSyw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 23:18:25 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Tue, 8 Oct 2024 23:18:09 +0300
Subject: [PATCH v3 6/6] test/py: introduce test for ab_dump command
MIME-Version: 1.0
Message-ID: <20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728418704; l=2539;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=gnXPohTsELR4usVQxe45m2HrxlHCFkJKUB+piq83xbU=;
 b=t78LZ15TEzsIYHzWYYAmtkd5iKw2TgfGkLDpiBSB2K+OVocu2CAkYyMyMkslgI/z30SRVc5yu
 ogoDm1Ttag1Cbt3hoGXIFZg7BMBAuW5IUFqJ1gYIlGR7FqBIYsn7Vnn
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2465

The ab_dump command allows you to display ABC data directly on the
U-Boot console. During an A/B test execution, this test verifies the
accuracy of each field within the ABC data.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 test/py/tests/test_android/test_ab.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

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


