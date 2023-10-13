Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82134CDB47E
	for <webhook@archiver.kernel.org>; Fri, 13 Oct 2023 16:40:41 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.37749.1697202272960620094
 for <u-boot-amlogic@groups.io>;
 Fri, 13 Oct 2023 06:04:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=Y1xjaPki;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0EEB3100004;
	Fri, 13 Oct 2023 16:04:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0EEB3100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697202267;
	bh=M+uca6A3XS8cmTCBFBNTYRBGkgwnSIoUtkdIDbyV3bA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Y1xjaPkiuZLuQb3hAfVL2lhEMYrL1JajHBX7ffHMy/3/PVLZKx5MgcvrplBJWmSGx
	 I3f9jcpcjCCQ7BjH5nhWBJr39JPzbMsZyc68j0yk+DhtkYn2Q07cOBfCmtbCrfJAu6
	 2yyTQcheTW2YN3GadLpAYKc2DlEh4W5ckO3qHIrhmc0YRch09W2s6goj0JqTr0sFqN
	 qnmjW+3Ly1aE+ceTsihj8QJgZhilm7t3/qf5YOCbg5eOuMbdvk2bLkLJE0wy9FKFJW
	 8rkFi1B7qg/7akjGZ0KVbXSkXLqJ6YygTYxeZls8eaGpm/GenqOw54Qrb9ddEHBUay
	 37aKXt3H4kRnQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 13 Oct 2023 16:04:26 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 13 Oct 2023 16:04:26 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1] drivers: don't compile Secure Monitor UCLASS unconditionally
Date: Fri, 13 Oct 2023 16:04:09 +0300
Message-ID: <20231013130411.46569-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180607 [Oct 13 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 539 539 807534d9021bfe9ca369c363d15ac993cd93d4d9, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/13 12:24:00 #22181924
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 13 Oct 2023 16:40:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1754

It makes no sense to compile Secure Monitor unconditionally.
For example, this break the SPL build on boards with a small
allowed SPL image size.

Fixes: 126fbbefd89e ("drivers: introduce Secure Monitor uclass")

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index b7bd3633b1..1a768fed2b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_$(SPL_TPL_)VIRTIO) +=3D virtio/
 obj-$(CONFIG_$(SPL_)DM_MAILBOX) +=3D mailbox/
 obj-$(CONFIG_$(SPL_)REMOTEPROC) +=3D remoteproc/
 obj-$(CONFIG_$(SPL_)SYSINFO) +=3D sysinfo/
+obj-$(CONFIG_$(SPL_TPL_)SM) +=3D sm/
 obj-$(CONFIG_$(SPL_TPL_)TPM) +=3D tpm/
 obj-$(CONFIG_XEN) +=3D xen/
 obj-$(CONFIG_$(SPL_)FPGA) +=3D fpga/
@@ -124,4 +125,3 @@ obj-$(CONFIG_DM_RNG) +=3D rng/
 endif
=20
 obj-y +=3D soc/
-obj-y +=3D sm/
--=20
2.25.1


