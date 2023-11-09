Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC424C4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:10:33 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.926.1699549824760050476
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Nov 2023 09:10:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=tJ/y1FKo;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3E8FB12004C;
	Thu,  9 Nov 2023 20:10:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3E8FB12004C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699549822;
	bh=jymvqmq6LT2zhbWW70zvBC6Ze5BqpPxUEa9E8+sbmQY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=tJ/y1FKoDWhmiGYkrin8P7dzRU+DoRofH2YHMKwMNZ4xqBPfTYJnU/zC7/4zLuzmI
	 peRBEclld28SvYv8u+F8u+cZMQli3rg9RZboGjMuvmHrsLI+iA7OGZNAxSbZRL1i5K
	 eusFQbchqrfZ3CVt1L7IHG1wenM8XoZ/1HuF/LYsjCdGDAm7Z6Dztm+XMDeA//XDTg
	 X7uOPDUzEv8Tpro5TstLvuersbO9HGaoHWU5u+oqal7sZu2hIqHXMXURZVJ+iaKmv2
	 jSzXnmP22uLyBZWpC6yvfCVc7rTplJ94HT7BKtBInT/Eo6gVM6g8tgBKl6zWD8O/lG
	 ALD/A8ScEsdeA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  9 Nov 2023 20:10:22 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 20:10:21 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <kernel@sberdevices.ru>, <prusovigor@gmail.com>, Igor Prusov
	<ivprusov@salutedevices.com>, Jagan Teki <jagan@amarulasolutions.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, <u-boot-amlogic@groups.io>
Subject: [PATCH 2/3] spi: meson_spifc_a1: Use define for time interval
Date: Thu, 9 Nov 2023 20:10:03 +0300
Message-ID: <20231109200943.2.I02c5c81c1a5a06b51600672691f448909af473ea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109171004.193521-1-ivprusov@salutedevices.com>
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181258 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/09 11:05:00 #22436988
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Nov 2023 17:10:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1858

Use USEC_PER_MSEC define for timeout to sync code with Linux version.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 drivers/spi/meson_spifc_a1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/meson_spifc_a1.c b/drivers/spi/meson_spifc_a1.c
index 099c4c037d..418d4d5e10 100644
--- a/drivers/spi/meson_spifc_a1.c
+++ b/drivers/spi/meson_spifc_a1.c
@@ -16,6 +16,7 @@
 #include <spi-mem.h>
 #include <asm/io.h>
 #include <linux/log2.h>
+#include <linux/time.h>
 #include <linux/iopoll.h>
 #include <linux/bitfield.h>
=20
@@ -117,7 +118,7 @@ static int amlogic_spifc_a1_request(struct amlogic_sp=
ifc_a1 *spifc, bool read)
=20
 	return readl_poll_timeout(spifc->base + SPIFC_A1_USER_CTRL0_REG,
 				  val, (val & mask) =3D=3D mask,
-				  200 * 1000);
+				  200 * USEC_PER_MSEC);
 }
=20
 static void amlogic_spifc_a1_drain_buffer(struct amlogic_spifc_a1 *spifc=
,
--=20
2.34.1


