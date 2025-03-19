Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B8C35FFF
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.4615.1742415661769779531
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=W99Hder+;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 48A67100015;
	Wed, 19 Mar 2025 23:21:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 48A67100015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415660;
	bh=55VQToj4Te6FUgYKTvotsEqGDkJWFu0WJVhvD06nrh4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=W99Hder+2yTEcMDX/XOQ345qfgaRIdv8QTwop2DVRLtcuen107lfJ+f61XFjhvH6c
	 GY7TmueaNMZk7yd0EQJ7wHpBy4HAQp6QvhY8/MFEcOnbjeWF3m3tweL3MNHY7GdSqS
	 vFW0U2yhi5IsG8epDwYQpLZfr+e5GKxnD68dwTNzjQUfrb1LdLC3iwEbJMY8Eqr6ne
	 8h6KwsZasDBGYtLA2nZ0+J0ve8AmCYCPwQiLN7B2h174e08P1TakhuZLb4N48/31A+
	 9noSTuqH2wEEGDOA38lB7WEkFa+PimwEETCh2qACKxyA2x/N31xrvRGpzbGy34G5YI
	 XEtoISeQZxWzQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 19 Mar 2025 23:21:00 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
	Viacheslav Bocharov <adeep@lexina.in>, Sumit Garg <sumit.garg@linaro.org>,
	Simon Glass <sjg@chromium.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jerome Forissier
	<jerome.forissier@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, <oxffffaa@gmail.com>,
	<avkrasnov@salutedevices.com>
Subject: [PATCH v1 07/11] arm: meson: a1: add A1_SYSCTRL_SEC_STICKY_REG2
Date: Wed, 19 Mar 2025 23:20:41 +0300
Message-ID: <20250319202045.1407-8-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319202045.1407-1-avkrasnov@salutedevices.com>
References: <20250319202045.1407-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [172.28.65.111]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191951 [Mar 19 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/19 17:18:00 #27803216
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Mar 2025 14:56:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2645

This register is used by ADNL protocol, to check boot source
of current U-boot instance.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/include/asm/arch-meson/a1.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/a1.h b/arch/arm/include/asm/ar=
ch-meson/a1.h
index 86d1a68de8c..16e209ed932 100644
--- a/arch/arm/include/asm/arch-meson/a1.h
+++ b/arch/arm/include/asm/arch-meson/a1.h
@@ -13,6 +13,12 @@
 #define A1_SYSCTRL_ADDR(off)		(A1_SYSCTRL_BASE + ((off) << 2))
=20
 #define A1_SYSCTRL_SEC_STATUS_REG4	A1_SYSCTRL_ADDR(0xc4)
+/*
+ * Checked during boot. Tells, that previous code, e.g.
+ * executed before reboot requested to continue boot
+ * from USB. Used by ADNL protocol.
+ */
+#define A1_SYSCTRL_SEC_STICKY_REG2	A1_SYSCTRL_ADDR(0xe2)
=20
 #define A1_SYSCTRL_MEM_SIZE_MASK	0xFFFF0000
 #define A1_SYSCTRL_MEM_SIZE_SHIFT	16
--=20
2.30.1


