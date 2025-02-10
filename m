Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D562C021A2
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 12:30:10 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.58751.1739209839712057399
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2025 09:50:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=rmdVFIvH;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: eabachinin@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5442E10000E;
	Mon, 10 Feb 2025 20:50:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5442E10000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739209837;
	bh=tNvKOIR+HZX9t/Yoy0oTfT/QavuSFhmDylsrc87LCRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=rmdVFIvH61dnT9ayFv+6TQCvIXh00KPJ7amd8uPydlI4UIy3WbC/8XwrqLMHZwe5h
	 m06RZyLjPkwyvh3xORBbRLlh3MFgvHY5CmWd8M2LPQgikbCCPPIzjQ6naIMFCp7Fn/
	 +7qOzNQWmrAIQ88zEmG/eSRATE8zQopgoF/5Rta4H2kHjMMwrrj2mFGmLHp24zyett
	 c3kMXFclkPo28qBCXREXKY6gyoNk3CHUvpQK2BwcOJ7NSZWYwjFvaaPdbz8nG8Wqdz
	 OVjuz838CXZqu1sJ9cGgl5U6Kk2S4up24AmgvXB0ggBy4jU/jpkNtqtD47f1mxgWJi
	 hTSksX0XpUkSg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Feb 2025 20:50:37 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Date: Mon, 10 Feb 2025 20:50:15 +0300
Subject: [PATCH 2/3] arm: meson: sm: get rid of SM_CHIP_ID_SIZE
MIME-Version: 1.0
Message-ID: <20250210-meson_chip_id_all_vers-v1-2-b98f8b6880b8@salutedevices.com>
References: <20250210-meson_chip_id_all_vers-v1-0-b98f8b6880b8@salutedevices.com>
In-Reply-To: <20250210-meson_chip_id_all_vers-v1-0-b98f8b6880b8@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Viacheslav Bocharov <adeep@lexina.in>, Arseniy Krasnov
	<avkrasnov@salutedevices.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
	<u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>, Evgeny Bachinin
	<EABachinin@salutedevices.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.162.21]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190910 [Feb 10 2025]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/02/10 15:43:00 #27153787
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 11 Feb 2025 12:30:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2621

SM_CHIP_ID_SIZE is used nowhere. Moreover, it specifies wrong
chip_id size: Amlogic chip_id v1 and v2 is always 16 bytes long.

Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 arch/arm/mach-meson/sm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 4d9f83d3b38d54e20d7d2bec997793cca5d7f0e4..43a259d695b058361445d7ef7047353b3afd5419 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -78,7 +78,6 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
 
 #define SM_CHIP_ID_LENGTH	119
 #define SM_CHIP_ID_OFFSET	4
-#define SM_CHIP_ID_SIZE		12
 
 int meson_sm_get_serial(void *buffer, size_t size)
 {

-- 
2.34.1


