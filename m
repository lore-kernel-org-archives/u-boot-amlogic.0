Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9598C25B6B
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 22:52:03 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.31984.1698187920316713168
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Oct 2023 15:52:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=dUq/BLtk;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1D4BB120046;
	Wed, 25 Oct 2023 01:51:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1D4BB120046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1698187917;
	bh=C2JkD4QwB8F5PNLeDFErGB+TVHOv8kolEqxnXgkhrlU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dUq/BLtkgDKfebpwReBsQjeyutanBY43Bk9Gv2HU2e553WkccgA08sTxGr9a78hgw
	 9CKFu+YsXDbpRXjm9lHDVe922OwfTnzWZOcrQKKwszA0RVnUfbP6Qr5XOea1WV8iaQ
	 i0xuRO/L+/4OZQ+fYqAWdFGgg6/kqC17hATVCFRyS+rjIOd5BvdDsNarmkGNGRZpJJ
	 H2ubXRnL9iCykP5J/YLO+sBY0fpexMMf7V0r/TeHLgbhK5Sl9HCjz5zTUv3obhE6qU
	 nVxoYvdfD+TlzXsYdxa3664SKzbvWw2LpqVxq7z7lEXUnK9OzPZmBuiXAVc1ssGU0a
	 NzE0bAjivygQw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Oct 2023 01:51:56 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 25 Oct 2023 01:51:56 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki
	<jagan@amarulasolutions.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, <u-boot-amlogic@groups.io>,
	<u-boot@lists.denx.de>, <sjg@chromium.org>
Subject: [PATCH v2 2/2] ARM: amlogic: ad401: enable SPIFC
Date: Wed, 25 Oct 2023 01:51:40 +0300
Message-ID: <20231024225140.366571-3-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024225140.366571-1-ivprusov@sberdevices.ru>
References: <20231024225140.366571-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180852 [Oct 25 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/24 20:53:00 #22289793
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 24 Oct 2023 22:52:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1798

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


