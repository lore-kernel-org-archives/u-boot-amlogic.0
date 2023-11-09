Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49E7C0018C
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 10:55:44 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.119025.1699527338869524010
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Nov 2023 02:55:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=VuPOgJpC;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5BFE5120041;
	Thu,  9 Nov 2023 13:55:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5BFE5120041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1699527337;
	bh=+KzMk6UDaUeqPEx2Njw40E1PXgC6eESva0VQNNEiq34=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VuPOgJpCkaYrO2FDeiJQSi6xkvgxhiwS7Fm++rEXUaOCQTnz2gOdpxP/xDUl7vrQ4
	 +0mVoc2NRPkmNVhU1UdU8AEQObH87Jkq3ji3eeMSob/pPc+Do/cL2Hc9Zsdkno+A3o
	 R3Ja2U1wAt+lqQ/7qeL1toFStcRMoCOHvrQcbgAupsDNq6+6LdGiNexfP/UAkT2aLd
	 paupJiqV36D35xz8vs8d55gbNiH6cUYOMMigZffVmobHnFuzWGumqWu8qVJFeJGifZ
	 v3KVMhxQcZGqqyEQU8UqNC6JR1smIopYMyw4JXoF8aElfSdEtGXPftdhteWMaTbpWj
	 GULGUNDjrIOmQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  9 Nov 2023 13:55:37 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 13:55:36 +0300
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
Subject: [PATCH v7 6/8] cmd: clk: Use dump function from clk_ops
Date: Thu, 9 Nov 2023 13:55:14 +0300
Message-ID: <20231109105516.24892-7-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109105516.24892-1-ivprusov@sberdevices.ru>
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181238 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/09 07:10:00 #22435383
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Nov 2023 10:55:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1852

Add another loop to dump additional info from clock providers that
implement dump operation.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
---
 cmd/clk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/cmd/clk.c b/cmd/clk.c
index c7c379d7a6..4b9709d3ff 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -62,6 +62,7 @@ static void show_clks(struct udevice *dev, int depth, i=
nt last_flag)
 int __weak soc_clk_dump(void)
 {
 	struct udevice *dev;
+	const struct clk_ops *ops;
=20
 	printf(" Rate               Usecnt      Name\n");
 	printf("------------------------------------------\n");
@@ -69,6 +70,14 @@ int __weak soc_clk_dump(void)
 	uclass_foreach_dev_probe(UCLASS_CLK, dev)
 		show_clks(dev, -1, 0);
=20
+	uclass_foreach_dev_probe(UCLASS_CLK, dev) {
+		ops =3D dev_get_driver_ops(dev);
+		if (ops && ops->dump) {
+			printf("\n%s %s:\n", dev->driver->name, dev->name);
+			ops->dump(dev);
+		}
+	}
+
 	return 0;
 }
 #else
--=20
2.34.1


