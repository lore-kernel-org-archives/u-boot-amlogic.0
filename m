Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538BFD206BA
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 07:57:55 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.2908.1728939991621035240
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 14:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=VeYqR12W;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9581A10000D;
	Tue, 15 Oct 2024 00:06:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9581A10000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728939989;
	bh=qXFDNTaj+lR/tNGaYS2aNpSICkXv1bwPtbyZsWe8//s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=VeYqR12WzAi4tAxF+9+5LpHrOtZVTF3X7uHrzVHEA1Z5ofG/wb/QuG+rN32bzCFri
	 G78NjN54Zi21spCur7MEV8Ez/H4Iok6IjoobQuTgOHXY5Lp0t1VpOVM4jY+lqeb1jn
	 dSDS9Sj9dMFQgICFU0QphhmYpanueVjrnTWTwEDH7GGwhif52i3KxqOTp6o6H2jNcy
	 vITjc3mMZY1VZtMKFBrPxnt+JdPmUIYMsTlBvsws1wYYwT6r4UCVbmUwi9MmIBRdf9
	 DRpV1itM49WGW46jjdUPJTc1jWh/3ZEkkq9ZsxHJzuA0EX6QUFJgWs0ly4Vp5LefY7
	 ecpCzYn1dyPAQ==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 00:06:29 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Tue, 15 Oct 2024 00:06:15 +0300
Subject: [PATCH v4 3/5] cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
MIME-Version: 1.0
Message-ID: <20241015-android_ab_master-v4-3-a91cca9513c4@salutedevices.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728939988; l=972;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=8eqJalS2zQLzpfjMM4b8wkNNCz3EQyYFjdBHrlYyhqw=;
 b=AckodtbYIgHFEa/ZvrBruO2SEHUKcvg4s5rk/OpmQ/rZTb59E4VUUvAemgjY9EKM2dtdMTqxH
 1U9FOoY3ZAUAjzC7pG28x9hMwXpwwJlck57pYEXtBXs39rsPcJ+49w+
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
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/14 19:21:00 #26753819
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 16 Oct 2024 07:57:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2490

In the entire cmd/bcb.c file, the return value of strcmp() is not
directly compared to 0. Therefore, it would be better to maintain this
style in the new do_bcb_ab_select() function as well.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 cmd/bcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bcb.c b/cmd/bcb.c
index bf28726da91134fa287ca8aada884ed74ecc8f2b..3935b7f8d535e87593020b91a6b37d7c5ef02a83 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -439,7 +439,7 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
 	bool dec_tries = true;
 
 	for (int i = 4; i < argc; i++) {
-		if (strcmp(argv[i], "--no-dec") == 0)
+		if (!strcmp(argv[i], "--no-dec"))
 			dec_tries = false;
 		else
 			return CMD_RET_USAGE;

-- 
2.43.0


