Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C2C4167D
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 15:46:15 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.8160.1698847516643649541
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Nov 2023 07:05:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=iv5vz+e/;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 43BBA120034;
	Wed,  1 Nov 2023 17:05:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 43BBA120034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1698847513;
	bh=Ra/K8iM75xmnuwdIZzEfRD0GVNWAJOQNhaxbSdo82H8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iv5vz+e/7ufTlk46z9DgjLgYYoMthqGaWvadQZHn8Tpze1BgyicPJx/iU2cT1YO0M
	 lWAmWYeFxUB36bc2STr+ZUOSNOcvS9vbxTbDx3kSG47znCQyYY8SkuQAOfJ71qWSAt
	 ZMSAGowHoRWF+FZlMDwiHPzR+Oi+tKZChC5p9V4Ei5/SgXP/TFJdIIbBkYjmCWZCQT
	 FbQd/uzhmiyLjWDhceG6lx12sBCg6PmY46HtsHBlcl/jZlJgQcicUkaTpJPojitNcx
	 VLR3XLlsSTYarzZ52d9W3AOHye/Vi2sSRbyAeP0LBGVAb5Fq7ISlO0szS/N1sue1lH
	 eJ4iTcPbZ6vAA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  1 Nov 2023 17:05:13 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 1 Nov 2023 17:05:12 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 0/2] Meson A1: fix USB and NAND stack
Date: Wed, 1 Nov 2023 17:04:55 +0300
Message-ID: <20231101140500.9025-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181052 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1821

Hello!

After a recent sync device tree with the Linux Kernel,
some drivers broke. These patchset will fix that.

Alexey Romanov (1):
  clk: a1: add new clocks for USB stack

Dmitry Rokosov (1):
  drivers: sm: bind child sm devices in the device tree

 drivers/clk/meson/a1.c | 6 ++++++
 drivers/sm/meson-sm.c  | 1 +
 2 files changed, 7 insertions(+)

--=20
2.25.1


