Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D336C0018A
	for <webhook@archiver.kernel.org>; Sun,  5 Nov 2023 08:38:41 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.26845.1699173513434080526
 for <u-boot-amlogic@groups.io>;
 Sun, 05 Nov 2023 01:38:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=XQcW2ifC;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C99E212000C;
	Sun,  5 Nov 2023 11:38:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C99E212000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1699173511;
	bh=fsnPjLvRt18ExMQSD2xbZ3j/SqrCBtTjrEDwf2fGYQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=XQcW2ifCwCj20q286ZtR6a/szeLATur561dGyXixkhsV3f3Ww6SqNtYlAi+ULdo6e
	 hfdZl93LNEhtlZnB6sOedUwmnf914OgpSl3AKMpRkzgCXLJ/jFoGSAhGOWtrJJlWUb
	 QF4p5ZJV38Lk+912ljs1dznSps2CbH0e/j7+d+MKvY1LiQKI67Xa1752hy5Mx+kz9M
	 0zX5MfWTtDbbsyjCcyK5MUK7zw9bbVHAhDsgL36P4LOxyQsY+w/e3jCo91RuRYDC/Y
	 LxfaQQdZ8kPqvJfrc23wp3mZCiOCD0kYhIm6W7S7GFjZ9ah9Ui17JjV7C531vPHmZJ
	 f5iluHHyqhJrw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  5 Nov 2023 11:38:31 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 5 Nov 2023 11:38:31 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: <u-boot@lists.denx.de>, Michal Simek <michal.simek@amd.com>, Daniel
 Schwierzeck <daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot-amlogic@groups.io>,
	<uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v6 8/8] cmd: clk: Make soc_clk_dump static
Date: Sun, 5 Nov 2023 11:38:09 +0300
Message-ID: <20231105083809.3293-9-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105083809.3293-1-ivprusov@sberdevices.ru>
References: <20231105083809.3293-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181122 [Nov 03 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/05 03:40:00 #22405617
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 05 Nov 2023 08:38:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1841

After introducing dump to clk_ops there is no need to override or expose
this symbol anymore.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---
 cmd/clk.c     | 4 ++--
 include/clk.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/cmd/clk.c b/cmd/clk.c
index 4b9709d3ff..7bbcbfeda3 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -59,7 +59,7 @@ static void show_clks(struct udevice *dev, int depth, i=
nt last_flag)
 	}
 }
=20
-int __weak soc_clk_dump(void)
+static int soc_clk_dump(void)
 {
 	struct udevice *dev;
 	const struct clk_ops *ops;
@@ -81,7 +81,7 @@ int __weak soc_clk_dump(void)
 	return 0;
 }
 #else
-int __weak soc_clk_dump(void)
+static int soc_clk_dump(void)
 {
 	puts("Not implemented\n");
 	return 1;
diff --git a/include/clk.h b/include/clk.h
index 249c0e0ab4..3d6394477b 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -676,8 +676,6 @@ static inline bool clk_valid(struct clk *clk)
 	return clk && !!clk->dev;
 }
=20
-int soc_clk_dump(void);
-
 #endif
=20
 #define clk_prepare_enable(clk) clk_enable(clk)
--=20
2.34.1


