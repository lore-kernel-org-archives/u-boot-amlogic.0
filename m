Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D25CDDE7D
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:31 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.50154.1729174339177118958
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 07:12:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=hMXI/FYv;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 79796100016;
	Thu, 17 Oct 2024 17:12:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 79796100016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729174336;
	bh=IuEuIj1t02rLDW2Nwn3gMvwNPtsNRBYug0I7lrCYtss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=hMXI/FYvBBIih9g42nj/GkeJUXyHJjSpnubYd+g2eudo85uP3+2XerDoTepvSJfL/
	 rAUyCC/suhhtro7cn3y9aJwpl1EpPfquH1JJP20GUxhyZQvuJibf6aa9lMAlkk02ZL
	 GtaFOjAdOrvFHXRngoGn/hZSIZwM9BT06kCtxpDXp3iJSBWlo4ZTyLHZCQT3EOg8OM
	 Bh4ZdwUNQENAgztyNs5nsMmR8uenwvoU8cm6nkWzqb/kpWTzqSGsr3WnM5Ii+MvZaz
	 VudlrTJgKiVaUS2UjFM/l0zIy7SnZuV8B7aObIJew8np6t+zUqi+o9/5zpmAaNxB4/
	 NyJFg1TwXeMLw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 17 Oct 2024 17:12:16 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Thu, 17 Oct 2024 17:12:09 +0300
Subject: [PATCH v5 4/6] cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
MIME-Version: 1.0
Message-ID: <20241017-android_ab_master-v5-4-43bfcc096d95@salutedevices.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
In-Reply-To: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>,
	Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729174334; l=967;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=VK5iG2fSRlyo1r56wPsrow15PEDp4txWFTRXVwa5sPs=;
 b=hwMwCIMse0IBNT6sc8aAU1Ddz8F4kihPn3002zIlCzzcpjKtcnZdB/G77bekMDAvmEJKL6FcJ
 jkh6lRNbHc8CwkTXp5tp7y2OxA7TSsJifS/Linq8ewdMTbpz9jPtmoR
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2524

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
index 2854408e5669b0d7d2a06073fa81158b21834b99..b33c046af0385a112fd40634ab7f48e05542ca48 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -391,7 +391,7 @@ __maybe_unused static int do_bcb_ab_select(struct cmd_tbl *cmdtp,
 		return CMD_RET_USAGE;
 
 	for (int i = 4; i < argc; i++) {
-		if (strcmp(argv[i], "--no-dec") == 0)
+		if (!strcmp(argv[i], "--no-dec"))
 			dec_tries = false;
 		else
 			return CMD_RET_USAGE;

-- 
2.43.0


