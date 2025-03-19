Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6060FC3DA4A
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.4459.1742415660497086887
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=jqdNn4ex;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BE65D12000F;
	Wed, 19 Mar 2025 23:20:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BE65D12000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415658;
	bh=OQyPAOK2ADmMl55epTEU3v6mVEbLzjkaxe9Gd/aD0NM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jqdNn4exNta+f17o3AHYiT8TpWwcIse/RwUifTCXk8ArBWblIiozYU+JvSzCh7M89
	 oXXS/Hb8uXgA78llcZxdWDtvjksTUhNETVJbfF3OJPVJsPbB8G/jB6jDJl2t429v6/
	 C0mz0rret5EZRLxTuZYSGdOdtAFv3Q8mGgrp+LGcO1F8OT7NC2SJNqHwpn0V8Ptzpy
	 mNC0U3SKmCmhPTfb1ImO8b2LgYW4WSE4NEkeyXZ4OA3AgAOIKmVBCg/xLwZUIuqimc
	 BkI/644/ApqOCEuu2Uc6HYHjEFOJunk9IGAxxy4S21Z5KgpnxCHSYwuJAVH7M3o4Fx
	 xDm3ikUENxZ2Q==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 19 Mar 2025 23:20:58 +0300 (MSK)
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
Subject: [PATCH v1 02/11] arch: arm: meson: use 'meson_sm_call()' in 'meson_sm_pwrdm_set()'
Date: Wed, 19 Mar 2025 23:20:36 +0300
Message-ID: <20250319202045.1407-3-avkrasnov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/19 19:45:00 #27804052
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Mar 2025 14:56:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2642

Use more generic function in 'meson_sm_pwrdm_set()'.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/mach-meson/sm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 53b07e1dfe9..0a781e9c47b 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -249,22 +249,16 @@ static int meson_sm_call(u32 smc, struct pt_regs *reg=
s, s32 *retval)
=20
 int meson_sm_pwrdm_set(size_t index, int cmd)
 {
-	struct udevice *dev;
 	struct pt_regs regs =3D { 0 };
 	int err;
=20
-	dev =3D meson_get_sm_device();
-	if (IS_ERR(dev))
-		return PTR_ERR(dev);
-
 	regs.regs[1] =3D index;
 	regs.regs[2] =3D cmd;
=20
-	err =3D sm_call(dev, MESON_SMC_CMD_PWRDM_SET, NULL, &regs);
+	err =3D meson_sm_call(MESON_SMC_CMD_PWRDM_SET, &regs, NULL);
 	if (err)
 		pr_err("Failed to %s power domain ind=3D%zu (%d)\n", cmd =3D=3D PWRDM_ON=
 ?
 				"enable" : "disable", index, err);
-
 	return err;
 }
=20
--=20
2.30.1


