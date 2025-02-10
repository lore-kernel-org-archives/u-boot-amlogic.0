Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3811BC0219D
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 12:30:10 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.58490.1739209839923652815
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2025 09:50:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=d9kxtGNj;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: eabachinin@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2C65B10000D;
	Mon, 10 Feb 2025 20:50:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2C65B10000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739209837;
	bh=/VqItYJTaM6pUHgIX7rYhgvJhXuoSTnY37AMQJD3/BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=d9kxtGNjlIS5GsD7XEBUdchBFjyxcFnNgChA7WacSMfI88uQOIYKiLTp8xZBSUpzU
	 i5OiwRzQbYb/0YWGMDbTM6rd4KSXhH34WZLCeAUDGq2HewSkRgVH+HVCPDOnW/3KrT
	 on/Uwb4NF9RZystBYicxJvU6C9uTDkLLHPi+36gjYEAQ1KmxgOvgDJDlI7Us+3NKzY
	 2KAimdY+mZLNhn99WHFrpMKffGqgJnpn05JRHWasUWAviypsCHeQL/QRLKYYiZfCTb
	 SIQr/I1iqPGCD8ySVqhNjCQDhIXMrccBTj1fA6vajcw+FvGf7Up2ymPkAlvnHQ8/29
	 Ph1dA6+8/9oAw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Feb 2025 20:50:37 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Date: Mon, 10 Feb 2025 20:50:14 +0300
Subject: [PATCH 1/3] arm: meson: unify type being used for socinfo
MIME-Version: 1.0
Message-ID: <20250210-meson_chip_id_all_vers-v1-1-b98f8b6880b8@salutedevices.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2622

socinfo_ API uses u32 type, hence let's use it everywhere
for consistency.

Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 arch/arm/mach-meson/board-info.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index b4058f593234e940fc2c00b82cdf9bd758cef567..94b066170c43019b379f05ab8d1e6d426592a1e1 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -7,6 +7,7 @@
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/types.h>
 #include <dm.h>
 #include <linux/bitfield.h>
 #include <regmap.h>
@@ -125,12 +126,12 @@ static const char *socinfo_to_soc_id(u32 socinfo)
 	return "Unknown";
 }
 
-static unsigned int get_socinfo(void)
+static u32 get_socinfo(void)
 {
 	struct regmap *regmap;
 	int nodeoffset, ret;
 	ofnode node;
-	unsigned int socinfo;
+	u32 socinfo;
 
 	/* find the offset of compatible node */
 	nodeoffset = fdt_node_offset_by_compatible(gd->fdt_blob, -1,
@@ -162,7 +163,7 @@ static unsigned int get_socinfo(void)
 
 int checkboard(void)
 {
-	unsigned int socinfo;
+	u32 socinfo;
 
 	socinfo = get_socinfo();
 	if (!socinfo)
@@ -181,7 +182,7 @@ int checkboard(void)
 
 int meson_get_soc_rev(char *buff, size_t buff_len)
 {
-	unsigned int socinfo;
+	u32 socinfo;
 
 	socinfo = get_socinfo();
 	if (!socinfo)

-- 
2.34.1


