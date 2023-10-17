Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C95CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 17:18:00 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.224675.1697563074602649436
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 10:17:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=IluzTUr/;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id F2F4F120004;
	Tue, 17 Oct 2023 20:17:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F2F4F120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697563071;
	bh=s6jeEFzjsBh+weEvalez4WeFgPIWUdsftv18ab+XHc8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IluzTUr/7dBYOsLNeMH6p5nVawlYg6A73IOFQBIX7uFQJam5ZN4WrHbjU4059/Y0d
	 rZ6Qq01VP8NaavEf5qgh7eMU2Rqup0gt3gY/JwhXzvUIAybz/uEi2LEnzeIIl7iS4m
	 H0h7lhU3ocloNSmVY5Q1Sk0iNbULBjPLgK3oPY/aH2yFvk4jtn0DcZGTpzMI3Ub7mM
	 oAStPXinPckcAXLm7+yIS58/rhZYgKxBwxBr+vcahbT9EicEjOIznZpScE2bn9U2ML
	 cNSMD3T1+eHOY/hD54G5nHrD55ixBY2Lz8C8AT1JdF+MpPt5JR7zQDM5Rr4uGlpHli
	 8rxOyUnJvQLCw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 20:17:51 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 20:17:51 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki
	<jagan@amarulasolutions.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@salutedevices.com>, <u-boot-amlogic@groups.io>,
	<u-boot@lists.denx.de>
Subject: [RESEND PATCH v1 0/2] ARM: amlogic: Add A1 SPIFC support
Date: Tue, 17 Oct 2023 20:17:31 +0300
Message-ID: <20231017171733.3989-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180685 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/17 16:23:00 #22212691
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 17:18:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1770

A1 family boards have new version of SPIFC controller, that is
incompatible with meson_spifc driver. This series ports A1 SPIFC driver
from Linux and enables it for ad401 board.

Igor Prusov (2):
  spi: add support for Amlogic A1 SPI Flash Controller
  ARM: amlogic: ad401: enable SPIFC

 configs/ad401_defconfig      |   1 +
 drivers/spi/Kconfig          |   8 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/meson_spifc_a1.c | 384 +++++++++++++++++++++++++++++++++++
 4 files changed, 394 insertions(+)
 create mode 100644 drivers/spi/meson_spifc_a1.c

--=20
2.34.1


