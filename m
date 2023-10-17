Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0E4CDB483
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 17:18:00 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.224678.1697563077519481481
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 10:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=ivVz8u70;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 59023120008;
	Tue, 17 Oct 2023 20:17:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 59023120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697563075;
	bh=BIVcjYEKyj7vDJ7qis/08LMbHfMP9l3p23k1sqnFmMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ivVz8u70dlnbC6K4e+DeMNyIjqIINAY0cd4MeGGKulsNNQlqUTk+fhp6aGYnADZH4
	 xJdNNS2+/+BucUSropSOhu8pDxDUcwkaStQFf7CFJZGashRuhURkacod42J5LtU+lb
	 Rsb1tDivHBKxTJjkqTCXoZsx6jbFDJIL4+G7mt/4s28hMIwtl3WYw6GHGN9WztQxdE
	 C2FaGj4KrRlTLg6bHwTEerNzvPV9OMB5qivvHY5ACTmzIHo1Ih7gGnYGvDPMWd3aaL
	 1AjdzXYul3K9ahnngopV0KPdnJFZBtFeP0dyCa1+Ojogho4C8V812LznfPrxjU+yqq
	 jelIVkDpLsBBA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 20:17:55 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 20:17:54 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki
	<jagan@amarulasolutions.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>
Subject: [RESEND PATCH v1 2/2] ARM: amlogic: ad401: enable SPIFC
Date: Tue, 17 Oct 2023 20:17:33 +0300
Message-ID: <20231017171733.3989-3-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017171733.3989-1-ivprusov@salutedevices.com>
References: <20231017171733.3989-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180685 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/17 16:23:00 #22212691
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 17:18:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1771

From: Igor Prusov <ivprusov@sberdevices.ru>

Enable Amlogic A1 SPI FLash Controller support.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/ad401_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
index b9aca3ab0d..b44b9c63e8 100644
--- a/configs/ad401_defconfig
+++ b/configs/ad401_defconfig
@@ -51,6 +51,7 @@ CONFIG_DEBUG_UART_SKIP_INIT=3Dy
 CONFIG_MESON_SERIAL=3Dy
 CONFIG_SPI=3Dy
 CONFIG_DM_SPI=3Dy
+CONFIG_MESON_SPIFC_A1=3Dy
 CONFIG_USB=3Dy
 CONFIG_DM_USB_GADGET=3Dy
 CONFIG_USB_GADGET=3Dy
--=20
2.34.1


