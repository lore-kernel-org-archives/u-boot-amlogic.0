Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37BDC4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 09:38:35 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.71101.1701347730622227260
 for <u-boot-amlogic@groups.io>;
 Thu, 30 Nov 2023 04:35:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=vvaB4c/j;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7982F120008;
	Thu, 30 Nov 2023 15:35:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7982F120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1701347726;
	bh=p5h2HOkApI0PODxodRe0tPnWrKOz37J7AZ/kMjGxtS4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=vvaB4c/jXA3YBbZyflkmjcKOkmm1MOe18ayXRP5bQIFJy32IBxFuEZplguJwuhQ71
	 L/SKBZAXWQN/IhFey0Q7TQgiZEAlzdZraLeIx8yqcVBr/6wylUIlvYF6G2Rryvti/t
	 74XOdhkO/W4Yh1H2B6t8K4An7qN2NMDlYXjLija+H7XpqA3WDNoJ9Zv2JMmiztKZp7
	 XmVJVpWIramswACEU5Rsgj4B6aIfPTXLi71ZZLNz4XmtVudptLWwfItQhWikJ/bV+s
	 vVUn40CUr5qplMLSRaGwUDFNFBsnkPrbkZJ6mjPsx/j2BhvGmCtUfkcnRWJWT0MhFo
	 CvEsfhKhS/P0A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 30 Nov 2023 15:35:26 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 Nov 2023 15:35:26 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v1] arm: dts: meson: add NAND controller node for AXG
Date: Thu, 30 Nov 2023 15:27:12 +0300
Message-ID: <20231130122712.189700-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181735 [Nov 30 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/30 11:05:00 #22583687
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 01 Dec 2023 09:38:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1894

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/dts/meson-axg.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
index 3f5254eeb4..c01ace3ff1 100644
--- a/arch/arm/dts/meson-axg.dtsi
+++ b/arch/arm/dts/meson-axg.dtsi
@@ -430,6 +430,27 @@
 					};
 				};
=20
+				nand_all_pins: nand_all_pins {
+					mux {
+						groups =3D "emmc_nand_d0",
+							 "emmc_nand_d1",
+							 "emmc_nand_d2",
+							 "emmc_nand_d3",
+							 "emmc_nand_d4",
+							 "emmc_nand_d5",
+							 "emmc_nand_d6",
+							 "emmc_nand_d7",
+							 "nand_ce0",
+							 "nand_ale",
+							 "nand_cle",
+							 "nand_wen_clk",
+							 "nand_ren_wr";
+						function =3D "nand";
+						input-enable;
+						bias-pull-up;
+					};
+				};
+
 				emmc_ds_pins: emmc_ds {
 					mux {
 						groups =3D "emmc_ds";
@@ -1906,6 +1927,20 @@
 				resets =3D <&reset RESET_SD_EMMC_C>;
 			};
=20
+			nfc: nand-controller@7800 {
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				pinctrl-0 =3D <&nand_all_pins>;
+				pinctrl-names =3D "default";
+				compatible =3D "amlogic,meson-axg-nfc";
+				status =3D "okay";
+				reg =3D <0x0 0x7800 0x0 0x100>,
+				      <0x0 0x7000 0x0 0x800>;
+				clocks =3D <&clkc CLKID_SD_EMMC_C>,
+					 <&clkc CLKID_FCLK_DIV2>;
+				clock-names =3D "core", "device";
+			};
+
 			usb2_phy1: phy@9020 {
 				compatible =3D "amlogic,meson-gxl-usb2-phy";
 				#phy-cells =3D <0>;
--=20
2.35.0


