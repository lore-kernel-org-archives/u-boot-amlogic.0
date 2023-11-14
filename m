Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB8CC4167D
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 11:03:40 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.10267.1699959814748588292
 for <u-boot-amlogic@groups.io>;
 Tue, 14 Nov 2023 03:03:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=CqPx/+Gr;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C97F3100026;
	Tue, 14 Nov 2023 14:03:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C97F3100026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699959812;
	bh=yZ/9FVY+9NdqcfvqkLHVI1EsDpSNi5RMzUWEAo/yHiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=CqPx/+GrxO7Bil8VNUnVn53RuZLp9xYnwyUoJj4e/8O9kJLWI4eYwPJTUWNjjvehN
	 NPHc6qmO4ugAuxVwH8r42anAKkcUBR+Khxt+int/QyBd/L+rqX1caRI6l7x505waj/
	 jdnqT3C8wqY6RhUiKIvbdXlf55OJWzX+8iZsHoVFeziPZIU9bmlWCitrrQARQqlpQm
	 ExH0DFvWCYe5n7NzK/XJgDpWbyVfnCM+tEy1cG7XDRpzjTsip30PkYPSQI5kAVYqjb
	 Zy2ikR2aX1QGaUL+pWg5GNNtRzbGx3drlBRjXhKcQf4T5mNpc4eTn57E5VO/ZUfe9Q
	 eNJmWHr0QdEpQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 14 Nov 2023 14:03:32 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:32 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
	<kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>, Jagan Teki
	<jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
	<u-boot-amlogic@groups.io>
Subject: [PATCH 12/13] treewide: Include linux/io.h instead of asm-generic/io.h
Date: Tue, 14 Nov 2023 14:02:56 +0300
Message-ID: <20231114110257.2488-13-ivprusov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1876

Directly including asm-generic/io.h may break build because it will
cause redefenition of generic io macros if linux/io.h gets included
later, hence replace it with direct include of linux/io.h

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 drivers/spi/cadence_qspi.c         | 2 +-
 drivers/usb/cdns3/cdns3-ti.c       | 1 -
 drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c  | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index cc3a54f295..23240c1302 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -7,7 +7,6 @@
 #include <common.h>
 #include <clk.h>
 #include <log.h>
-#include <asm-generic/io.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <malloc.h>
@@ -17,6 +16,7 @@
 #include <dm/device_compat.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/io.h>
 #include <linux/sizes.h>
 #include <zynqmp_firmware.h>
 #include "cadence_qspi.h"
diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 92a7941ed1..2e44aadea4 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -6,7 +6,6 @@
  */
=20
 #include <common.h>
-#include <asm-generic/io.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-m=
eson-g12a.c
index e0356e653f..196035215a 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -8,13 +8,13 @@
=20
 #include <common.h>
 #include <log.h>
-#include <asm-generic/io.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dwc3-uboot.h>
 #include <generic-phy.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-me=
son-gxl.c
index d56f2747b6..cbe8aaa005 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -8,12 +8,12 @@
=20
 #define DEBUG
 #include <common.h>
-#include <asm-generic/io.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dwc3-uboot.h>
 #include <generic-phy.h>
+#include <linux/io.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <malloc.h>
--=20
2.34.1


