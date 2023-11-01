Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9891CC41535
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 15:46:15 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.7997.1698847516950427692
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Nov 2023 07:05:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=iYerkKsU;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2837E100024;
	Wed,  1 Nov 2023 17:05:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2837E100024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1698847515;
	bh=yFZ5X6oU0nBWWN0p3IFNYnE3fJI9f0SRKMvP6nyzEUE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iYerkKsUGkiUfRlA5nAwTZ1G6oU4z08+aO/LxwuIPyVMX/rQtqRT9nokk2iOfFwI2
	 yUg4NCwsauu28Oj2w25klfmCGm+dpG3yAf5CWCOBCzWVSn8JhzrEge+euevY2feaw5
	 bTJFQyVoPHtrPa5cjFmAgdoFjohq83iThQUA2R33kQ5PM+5UL/garUS/nFNKS9fBph
	 GniC8Yj+qxYbzLGjZj59tWUrO0zwwSd7q3EqWyu6h7lJUZeVAdwnW4HUGpXivWvxiP
	 ThkEOcJlBjG36zekZBZToudOhLwf6gHx0K9QZUImR4ndraOSR2BzvU51oWlw7cmA1t
	 veIXjMOeyyd0w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  1 Nov 2023 17:05:15 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 1 Nov 2023 17:05:14 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@sberdevices.ru>, Dmitry Rokosov <ddrokosov@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 2/2] drivers: sm: bind child sm devices in the device tree
Date: Wed, 1 Nov 2023 17:04:57 +0300
Message-ID: <20231101140500.9025-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101140500.9025-1-avromanov@salutedevices.com>
References: <20231101140500.9025-1-avromanov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181050 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 13:00:00 #22378131
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 15:46:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1822

From: Dmitry Rokosov <ddrokosov@salutedevices.com>

One well-known sm child device that provides secure power control is the
Secure Power Controller. This device utilizes SMC calls to communicate
with power domains on the secure monitor side.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/sm/meson-sm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sm/meson-sm.c b/drivers/sm/meson-sm.c
index faef369f35..1dd1584855 100644
--- a/drivers/sm/meson-sm.c
+++ b/drivers/sm/meson-sm.c
@@ -194,6 +194,7 @@ U_BOOT_DRIVER(meson_sm) =3D {
 	.id =3D UCLASS_SM,
 	.of_match =3D meson_sm_ids,
 	.probe =3D meson_sm_probe,
+	.bind =3D dm_scan_fdt_dev,
 	.priv_auto =3D sizeof(struct meson_sm_priv),
 	.ops =3D &sm_ops,
 };
--=20
2.25.1


