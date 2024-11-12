Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2ED42B9C
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:18 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.86297.1731416340627511901
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Nov 2024 04:59:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=hiaH4Kud;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1EA03120011;
	Tue, 12 Nov 2024 15:58:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1EA03120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731416339;
	bh=7KjkdWFgVu7pzBm9KTclWnOcjavyo1stakH0JNdY2pk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=hiaH4KudE370XB9vdDJSwfLrU4AM4qY43bM3oO7JAHNkqGxReYliUoQMFNOuFozpZ
	 UuZ0tkq2Zfb6gdPybcD8y2batIR27A0YHceIbkuS6CZXIxG8Aj2/lv4Zi3DrlBGO8v
	 0NiYPS1QQxa3U7PV4PbzzJEG98h8aawOe5NGzcpLKxekJqrHhMtdc4eb+DHS9kPM1z
	 0qu6qr76JdJJdDT1NkVfBGqM6+xKVAwmPFEx/zLTNo6zsZGTM24eAIRbosh8bkVhu9
	 tG27NpPBBLYm8lzAPU0GblbUfby7lzxP0BXlIdQaW19oSBwVX6OJc302U/VMVvahI2
	 3QV9mCRM9C5XA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 12 Nov 2024 15:58:58 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <trini@konsulko.com>, <neil.armstrong@linaro.org>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 4/4] dt-bindings: interrupt-controller: remove arm-gic.h from include/
Date: Tue, 12 Nov 2024 15:58:36 +0300
Message-ID: <20241112125836.3239832-5-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112125836.3239832-1-avromanov@salutedevices.com>
References: <20241112125836.3239832-1-avromanov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [172.28.130.77]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189115 [Nov 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/12 09:54:00 #26847665
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 12 Nov 2024 15:08:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2546

We have exactly the same in upstream bindings.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 .../interrupt-controller/arm-gic.h            | 23 -------------------
 1 file changed, 23 deletions(-)
 delete mode 100644 include/dt-bindings/interrupt-controller/arm-gic.h

diff --git a/include/dt-bindings/interrupt-controller/arm-gic.h b/include/d=
t-bindings/interrupt-controller/arm-gic.h
deleted file mode 100644
index 35b6f69b7d..0000000000
--- a/include/dt-bindings/interrupt-controller/arm-gic.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR MIT */
-/*
- * This header provides constants for the ARM GIC.
- */
-
-#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ARM_GIC_H
-#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ARM_GIC_H
-
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/* interrupt specifier cell 0 */
-
-#define GIC_SPI 0
-#define GIC_PPI 1
-
-/*
- * Interrupt specifier cell 2.
- * The flags in irq.h are valid, plus those below.
- */
-#define GIC_CPU_MASK_RAW(x) ((x) << 8)
-#define GIC_CPU_MASK_SIMPLE(num) GIC_CPU_MASK_RAW((1 << (num)) - 1)
-
-#endif
--=20
2.34.1


