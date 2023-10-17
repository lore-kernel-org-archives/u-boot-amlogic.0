Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36827C46CA1
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 16:57:10 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.224817.1697561828792156445
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 09:57:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=WUfc9JUG;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CBEB1100005;
	Tue, 17 Oct 2023 19:57:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CBEB1100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1697561824;
	bh=H9vgNEIQKKRwgCv/vanqO91ndyd1olHRBgPQWnAJGRA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=WUfc9JUGbWMRQvdDejpUlnmTIOPv8KbpWacTRfl77PBGMMnbItb0deyjy63rIrRR1
	 343fVrm5GBozgrAIIrLKAKp5dDm0QyGuoBej9NbDPvUlSn0erVYRi0PvX8D0Lo7/iW
	 9o9RNi6vbpMqEHvq4n/49w2Z95lqY1buEwNG68B6nwIz4ieGRSzhI9ueRK4ti19vSr
	 wqUMeUKwEIH4lDWHMWfvlGukhlQihMk4cYndhZwMzRFcIzsLHjPpT8aAnPTTje0wk7
	 jDk4sHYM3fOzr4Iw/YDPKoyEOo1eO6eb2MvfZIpafocHZrX5UqgD10yl5jGqYYnVjH
	 pSTe17UZnXd9Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 19:57:03 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 19:57:02 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: Michal Simek <michal.simek@amd.com>, Daniel Schwierzeck
	<daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei
 Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v4 0/8] clk: Switch from soc_clk_dump to clk_ops function
Date: Tue, 17 Oct 2023 19:56:41 +0300
Message-ID: <20231017165649.1492-1-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180684 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/17 15:08:00 #22212325
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 16:57:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1761

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
 drivers/clk/clk_k210.c                 | 103 ++++++++++++-------------
 drivers/clk/clk_pic32.c                |  39 ++++++++++
 drivers/clk/clk_versal.c               |   7 +-
 drivers/clk/clk_zynq.c                 |  51 ++++++++++++
 drivers/clk/clk_zynqmp.c               |  13 ++--
 drivers/clk/imx/clk-imx8.c             |  11 +--
 drivers/clk/meson/a1.c                 |  54 +++++--------
 drivers/clk/mvebu/armada-37xx-periph.c |   5 +-
 drivers/clk/stm32/clk-stm32mp1.c       |  29 ++-----
 include/clk-uclass.h                   |   3 +
 include/clk.h                          |   2 -
 15 files changed, 244 insertions(+), 249 deletions(-)

--=20
2.34.1


