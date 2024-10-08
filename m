Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C938D1A42C
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.5722.1728418708105579387
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 13:18:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=jjslcRn+;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 798B1100013;
	Tue,  8 Oct 2024 23:18:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 798B1100013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728418705;
	bh=Q8t+j2ImEu1l0VQnQqDN2atqoMuI7W3eb1NvxwsYrlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=jjslcRn+jU0Qmy/fofWD5vUBg4VgVhKZUXMotERIiQ9xO9OhNRS9QZEa9WTJwLv4/
	 1YuLrX2rGO2J9rMHEkkfnyLUjko1SlY6F0yDs2v8OEF1F9uI1pun0NNPcsnGaT3+ep
	 Yl0JR5qIMcy/QFjbQwkQ2AN9yBmIIR74qKFYk5ksXMCFlcEI30HR4HnrthndN0paSP
	 YnMJGfdV8/6JP5k5OpFROyzn/b6nhrWV1mdr0XDQ2ks8y51/dNXozPeswxFxTBffz8
	 movmQWF2o/d6JgbJr32wEtSDNFQr3CfowiaAWJ/cyKXJMzLsnp1YzWxxgHTCLmlI7E
	 yOS5oUku08jWw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 23:18:25 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Tue, 8 Oct 2024 23:18:06 +0300
Subject: [PATCH v3 3/6] cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
MIME-Version: 1.0
Message-ID: <20241008-android_ab_master-v3-3-f292c45a33e4@salutedevices.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728418703; l=917;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=YDkSDNc9p3/O+I6YFFH7EWCHTszEURA4R42ZkQluIk8=;
 b=IipKCNnhkAEE7KJbQfgforBZf7z9nfFiplv3l/4TuGswemD1A5clfsV54SfgCPcvIhhbCHVlK
 TZzqCQdtYMyBFzSw467El+4aiv+FNignmnKnIz8roKGkMwP75Y4Yvpi
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2476

In the entire cmd/bcb.c file, the return value of strcmp() is not
directly compared to 0. Therefore, it would be better to maintain this
style in the new do_bcb_ab_select() function as well.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 cmd/bcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bcb.c b/cmd/bcb.c
index 4f3b8a1538a1f05b8b4a1a51c8962c422981166a..970c58e56cba0e1bdff21b7cd099f69151f0c5b8 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -432,7 +432,7 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
 	bool dec_tries = true;
 
 	for (int i = 4; i < argc; i++) {
-		if (strcmp(argv[i], "--no-dec") == 0)
+		if (!strcmp(argv[i], "--no-dec"))
 			dec_tries = false;
 		else
 			return CMD_RET_USAGE;

-- 
2.43.0


