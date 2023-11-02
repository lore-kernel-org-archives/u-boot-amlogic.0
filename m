Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D00AC41535
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 12:20:47 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.29245.1698927639894583958
 for <u-boot-amlogic@groups.io>;
 Thu, 02 Nov 2023 05:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=c8vsISZt;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 688D4120038;
	Thu,  2 Nov 2023 15:20:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 688D4120038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1698927638;
	bh=RL5hqS1sElFkg6RJw8t39U/suakMvWx1nkQfKO8rqB4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=c8vsISZtdpOr6pLW2GcB3l9DETQxPMzrxAgbrI85MpqLBK8AEe+bsNqDH2bLK3t04
	 FV6jP202DT88mNBI3ukynd7rex0lCkykB03yeK2SPcAWxDGYN7bzQcVr4XzCASzq2z
	 FP/WvVutacwG0BCxJgT5+Owu/wmTf5yFOBxnvWLydNfpnjtAkH6i86pEDHas5uQyed
	 K7EiY+fYXoG5BuN/uo2uuIT3ZLRfDSNCOYr/YqJHMPfwoly1zdZLxqnXO35BOuSjHE
	 Ld+C5PDPqsVcnV4oi/lbqPshQ7rsVbAuYi2GG0GeJGZW334FA3zsWzZcd9TSCXzyj1
	 60ETbqb9dgGpg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  2 Nov 2023 15:20:38 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 2 Nov 2023 15:20:37 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: Michal Simek <michal.simek@amd.com>, Daniel Schwierzeck
	<daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei
 Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 8/8] cmd: clk: Make soc_clk_dump static
Date: Thu, 2 Nov 2023 15:20:17 +0300
Message-ID: <20231102122017.56995-9-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102122017.56995-1-ivprusov@sberdevices.ru>
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181076 [Nov 02 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/02 06:57:00 #22385341
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 02 Nov 2023 12:20:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1816

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
index d91285235f..bf0d9c9d7f 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -674,8 +674,6 @@ static inline bool clk_valid(struct clk *clk)
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


