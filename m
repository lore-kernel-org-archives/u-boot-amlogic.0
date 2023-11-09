Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA1C4167D
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:10:33 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.925.1699549824436134179
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Nov 2023 09:10:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=QCwZZ9Lw;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 979A212004A;
	Thu,  9 Nov 2023 20:10:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 979A212004A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699549819;
	bh=0xHlqgHvskjCuT90liCKvxlVM0BSW5in6SvVJfh8d0k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QCwZZ9LweFGh6jRBAgCEIIQWmdMUirhDlDA59Y12ZCpJZ168txnrVPatm5LcvE7Xs
	 yuoUVZ+oPMRwstrTejGkUPfnNpng5DUezijeFdRiaOFv0+F1bxB8YwUm5Ll7w2txda
	 l+jH+dLmhyi/rVPNOimRi2TTcYSDjEIRwfMPh9MXRCVnotR9Nx6nUXE1LA2ijhQOPy
	 eBEWQ6suVpo2Kn9Ii1T7lE+OFgQNDBBYBbfTjK2C4CqSaHel4wrCt4VD0IfXRQSihI
	 iGTwT0mdmnz94YcRGWhErhpG8fUYv66qi2nHW2LPi9exuBArUsKrY2Z5jtmv04PYVR
	 pL+dxc7RHh0Fg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  9 Nov 2023 20:10:19 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 20:10:19 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <kernel@sberdevices.ru>, <prusovigor@gmail.com>, Igor Prusov
	<ivprusov@salutedevices.com>, Alexander Dahl <ada@thorsis.com>, Anatolij
 Gustschin <agust@denx.de>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Balaji
 Prakash J <bjagadee@codeaurora.org>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, Baruch Siach <baruch@tkos.co.il>,
	Bhupesh Sharma <bhupesh.linux@gmail.com>, Caleb Connolly
	<caleb.connolly@linaro.org>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Chris Morgan <macromorgan@hotmail.com>, Dario Binacchi
	<dario.binacchi@amarulasolutions.com>, Eugen Hristev
	<eugen.hristev@collabora.com>, Heiko Schocher <hs@denx.de>, Jaehoon Chung
	<jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Joel
 Stanley <joel@jms.id.au>, Kever Yang <kever.yang@rock-chips.com>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Michael Trimarchi
	<michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Neha
 Malcom Francis <n-francis@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
	<sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>, Stefan Roese
	<sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel
	<clamor95@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
	<u-boot-amlogic@groups.io>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/3] Add time conversion defines from Linux.
Date: Thu, 9 Nov 2023 20:10:01 +0300
Message-ID: <20231109171004.193521-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181258 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/09 11:05:00 #22436988
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Nov 2023 17:10:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1857

This series imports time conversion defines from Linux, that are
currently located in include/vdso/time64.h file. Those defines are
almost always used by including linux/time.h so it seems the proper
place in U-Boot to place them.

Various places where same or similar defines were added on per-driver
basis are replaced with time.h include.



Igor Prusov (3):
  linux/time.h: Add Linux time conversion defines
  spi: meson_spifc_a1: Use define for time interval
  treewide: use linux/time.h for time conversion defines

 board/friendlyarm/nanopi2/onewire.c              |  5 +----
 drivers/clk/at91/clk-main.c                      |  2 +-
 drivers/i2c/stm32f7_i2c.c                        | 11 +++++------
 drivers/memory/stm32-fmc2-ebi.c                  |  5 ++---
 drivers/mmc/octeontx_hsmmc.h                     |  2 --
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  3 +--
 drivers/mtd/nand/raw/mxs_nand.c                  |  3 +--
 drivers/mtd/nand/raw/octeontx_nand.c             |  2 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c           |  5 ++---
 drivers/phy/meson-axg-mipi-dphy.c                |  3 +--
 drivers/phy/phy-core-mipi-dphy.c                 |  3 +--
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c |  3 +--
 drivers/pwm/pwm-aspeed.c                         |  3 +--
 drivers/pwm/pwm-at91.c                           |  2 +-
 drivers/pwm/pwm-cadence-ttc.c                    |  3 +--
 drivers/pwm/pwm-meson.c                          |  3 +--
 drivers/pwm/pwm-mtk.c                            |  3 +--
 drivers/pwm/pwm-ti-ehrpwm.c                      |  3 +--
 drivers/serial/serial_msm_geni.c                 |  3 +--
 drivers/spi/cadence_qspi.c                       |  3 +--
 drivers/spi/fsl_dspi.c                           |  4 +---
 drivers/spi/meson_spifc_a1.c                     |  3 ++-
 drivers/ufs/cdns-platform.c                      |  3 +--
 drivers/usb/dwc3/core.c                          |  3 +--
 drivers/video/dw_mipi_dsi.c                      |  3 +--
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c    |  3 +--
 drivers/video/tegra20/tegra-dsi.c                |  4 +---
 drivers/watchdog/sunxi_wdt.c                     |  3 +--
 fs/ubifs/ubifs.h                                 |  1 -
 include/linux/time.h                             |  9 +++++++++
 30 files changed, 43 insertions(+), 63 deletions(-)

--=20
2.34.1


