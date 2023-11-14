Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BFCC4332F
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 11:03:40 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.10203.1699959813697166687
 for <u-boot-amlogic@groups.io>;
 Tue, 14 Nov 2023 03:03:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=QaeJ5tsb;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 08F3212000D;
	Tue, 14 Nov 2023 14:03:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 08F3212000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699959812;
	bh=NsmekJvSNog7lfTBW+bu062IEARi7O/TwWj5MdrT/tY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QaeJ5tsbbk7TVsAeVaV/sx2N4ff7Sggsm2V55eOsbFKimc3JOYI5hDCEUw/VrNijH
	 rkyP1p9dJ1rSyKJy5GG8XBs3vXItCR4y08OjlYEAH6M5gjebJd97eXGDy1BpHjtPLP
	 fJClYJePjzOCUGKZnOhmUoYSt9DBwvzQSWkJ+0DqQcQb9qJKXAdAhi2KOz/eQC5Eqk
	 As1jvkU8VaSRpHv2wq76saQKXLPpEV4g7kp1WYFQz8Eh9MKOXy6J7jpB/4b/caUPsr
	 utyJj+7RGIhG1FMeiTZsXbA/RdZLiDS3dLNcZlD+MRKl/6fMaM7GJDCZGP/ZvgeG2m
	 iWKese2xvaNxg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 14 Nov 2023 14:03:31 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:31 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
	<kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Jagan Teki
	<jagan@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	<u-boot-amlogic@groups.io>
Subject: [PATCH 11/13] spi: meson_spifc_a1: Switch to io{read,write}32_rep()
Date: Tue, 14 Nov 2023 14:02:55 +0300
Message-ID: <20231114110257.2488-12-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114110257.2488-1-ivprusov@salutedevices.com>
References: <20231114110257.2488-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181340 [Nov 14 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/14 07:58:00 #22462416
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 14 Nov 2023 11:03:40 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1875

Use io{read,write}32_rep() functions to sync code with Linux version.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 drivers/spi/meson_spifc_a1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/meson_spifc_a1.c b/drivers/spi/meson_spifc_a1.c
index 099c4c037d..a33b1a3879 100644
--- a/drivers/spi/meson_spifc_a1.c
+++ b/drivers/spi/meson_spifc_a1.c
@@ -129,7 +129,7 @@ static void amlogic_spifc_a1_drain_buffer(struct amlo=
gic_spifc_a1 *spifc,
=20
 	writel(SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
 	       spifc->base + SPIFC_A1_DBUF_CTRL_REG);
-	readsl(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
+	ioread32_rep(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
=20
 	if (pad) {
 		data =3D readl(spifc->base + SPIFC_A1_DBUF_DATA_REG);
@@ -146,7 +146,7 @@ static void amlogic_spifc_a1_fill_buffer(struct amlog=
ic_spifc_a1 *spifc,
=20
 	writel(SPIFC_A1_DBUF_DIR | SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
 	       spifc->base + SPIFC_A1_DBUF_CTRL_REG);
-	writesl(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
+	iowrite32_rep(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
=20
 	if (pad) {
 		memcpy(&data, buf + len - pad, pad);
--=20
2.34.1


