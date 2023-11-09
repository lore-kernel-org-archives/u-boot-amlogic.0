Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BDEC4167B
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 10:55:44 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.119020.1699527333759470155
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Nov 2023 02:55:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=VMM+6vH2;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0BB3710003B;
	Thu,  9 Nov 2023 13:55:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0BB3710003B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1699527331;
	bh=WZTE2yJHGTg4xPb/w/zuRZKGM4cTcUjatPZtIl0Bvv8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VMM+6vH2M1L6mFOFEz9EPEMEl+0m6AApmotFMrgjTdnvKt5eWrPgSNCz2EEOHe4BB
	 3DksSMRWkviJ6QuoYlwxSb2NqXT1Z08onAwvOZ7gy5dWO4Vz8kf1nvG0be6HCa+V03
	 y0seB3vJJuBaDYuLIvh4fb6Sst8bOlDeNpmhqmafY9YFwirAWaK9aLUG2QzwCSiADF
	 ZX7usTsM3CJ7F2Ogxq0HBSHdo2uR8ez8WEYqypmOIA92HmM1n7w1Rda2/gWrWaH6tx
	 hULfGszthp0eWAX/hoSfQdLVi8HWI8vR8SMqLYPaeSb+PduSMWNrmVKWOgBzx0wSTE
	 U3toPNg7JQNpQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  9 Nov 2023 13:55:30 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 13:55:29 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: <u-boot@lists.denx.de>, Michal Simek <michal.simek@amd.com>, Daniel
 Schwierzeck <daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot-amlogic@groups.io>,
	<uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v7 0/8] clk: Switch from soc_clk_dump to clk_ops function
Date: Thu, 9 Nov 2023 13:55:08 +0300
Message-ID: <20231109105516.24892-1-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181239 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/09 07:10:00 #22435383
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Nov 2023 10:55:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1846

Currently clock providers may override default implementation of
soc_clk_dump function to replace clk dump command output. This causes
confusing behaviour when u-boot is built with one of such drivers
enabled but still has clocks defined using CCF. For example, enabling
CMD_CLK and using clk dump on sandbox target will not show CCF clocks
because k210 driver overrides common soc_clk_dump.

Changelog:
 v1 -> v2:
 - Add missing static to dump functions

 v2 -> v3:
 - Make soc_clk_dump in cmd/clk.c static instead of removing __weak

 v3 -> v4:
 - Rebase and refactor dump for new Amlogic A1 clock controller driver

 v4 -> v5:
 - Add docs for dump() function in clk_ops
 - Print driver and device names before calling corresponding dump()

 v5 -> v6:
 - dump() return type changed to void
 - meson_clk_dump() and helper functions moved under CONFIG_CMD_CLK to
   fix unused-function diagnostic

v6 -> v7:
 - fix return type of k210_clk_dump()
 - fix clk_ops dump() docs since it returns void now

Igor Prusov (8):
  clk: zynq: Move soc_clk_dump to Zynq clock driver
  clk: ast2600: Move soc_clk_dump function
  clk: k210: Move soc_clk_dump function
  clk: amlogic: Move driver and ops structs
  clk: Add dump operation to clk_ops
  cmd: clk: Use dump function from clk_ops
  clk: treewide: switch to clock dump from clk_ops
  cmd: clk: Make soc_clk_dump static

 arch/arm/mach-zynq/clk.c               |  57 --------------
 arch/mips/mach-pic32/cpu.c             |  23 ------
 cmd/clk.c                              |  13 +++-
 drivers/clk/aspeed/clk_ast2600.c       |  83 ++++++++++----------
 drivers/clk/clk_k210.c                 | 104 ++++++++++++-------------
 drivers/clk/clk_pic32.c                |  37 +++++++++
 drivers/clk/clk_versal.c               |   9 ++-
 drivers/clk/clk_zynq.c                 |  52 +++++++++++++
 drivers/clk/clk_zynqmp.c               |  22 +++---
 drivers/clk/imx/clk-imx8.c             |  13 +---
 drivers/clk/meson/a1.c                 |  58 ++++++--------
 drivers/clk/mvebu/armada-37xx-periph.c |  20 +++--
 drivers/clk/stm32/clk-stm32mp1.c       |  31 ++------
 include/clk-uclass.h                   |  13 ++++
 include/clk.h                          |   2 -
 15 files changed, 269 insertions(+), 268 deletions(-)

--=20
2.34.1


