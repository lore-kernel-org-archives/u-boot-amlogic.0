Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E52CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 21:32:42 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.268334.1697578351196276719
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 14:32:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=ZZDWSDAk;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E4E81100005;
	Wed, 18 Oct 2023 00:32:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E4E81100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697578347;
	bh=xeFXirU7Euf/DHfyJxS2ypqqcH3aLEy/x2vL/aMxcs8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ZZDWSDAkVFczKas996Dh2eqJLIU1NggnkuUiS/NmUR9ul+ZS28xODvc2/CObCNkVB
	 2x6l+ddpmqEgEClkQLYH6d05aNGStEf0MVN1JP9AC/56MYkuob1T/LogriGOhNoJYU
	 1l0VBvxPSVmEPFQOcf9YRGxER8ql3OjqUl4gGT1bzR9E1CacJq6j8LPDFEUpCF+rgT
	 POxcDWajL2mlRuHsqxQqgyTC1VPZfu8iFx35b7IU85HhoFfNe+uVj3eetahck5hfmG
	 fpmSHHhJoABk+pCuXPqtD3/Vr6Qew7+rYfsqMjc4zdszpsGj5M8mVoLGG6uxjdVKma
	 G5oyj955JeeYA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 18 Oct 2023 00:32:27 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 00:32:27 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@salutedevices.com>, <u-boot-amlogic@groups.io>,
	<u-boot@lists.denx.de>
Subject: [PATCH v1 0/2] arm: dts: meson-a1 Sync DT with Linux
Date: Wed, 18 Oct 2023 00:32:09 +0300
Message-ID: <20231017213211.121550-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180688 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/17 19:51:00 #22214563
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 21:32:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1774

This series syncs Device Tree for Amlogic A1 with Linux. Currently
DTS in Linix has different compatible string for serial devices, which
is not recognized by serial_meson driver, so new compatible is added to
driver as well. Additional driver changes are not required because new
compatible only differentiates between ttyAML and ttyS names for serial
console devices.

Igor Prusov (2):
  serial: amlogic: Add UART compatible for A1 board
  arm: meson-a1: dts: Sync DT with Linux

 arch/arm/dts/meson-a1.dtsi    | 356 +++++++++++++++++++++++++++++++++-
 drivers/serial/serial_meson.c |   1 +
 2 files changed, 352 insertions(+), 5 deletions(-)

--=20
2.34.1


