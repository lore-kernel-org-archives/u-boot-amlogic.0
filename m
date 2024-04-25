Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C100C04FFE
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 13:01:45 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.23952.1714068132201486986
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Apr 2024 11:02:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=RX9OJ1s5;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5C680120009;
	Thu, 25 Apr 2024 21:02:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5C680120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1714068129;
	bh=8bhjZ75C4yUBvce7iaxKSL1rccesey4qMeHyYqrG3vw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=RX9OJ1s5IQufKko7BMPwzKsMfsD1r/tZKW9pLoHkJW/469hMgRuacsdBMNC1iYtlO
	 x+k9KibgVvDZpSF0NwK06W4c/3aj62y8eK1NC7AOIHgoalrkSYs/LpezXOwrU8ulu0
	 QIezv+5KDxzPeYWWL9nvyI1cC0MCSycwwP4ceLK7oIPH28UZtDorUJcE2fTeJ3sOrM
	 YU6rAcw3iXM84/qCx/7wNruyLDHLmFjsuyH/RvZijUxUbFfBITvDlDaiu4yfJqGITZ
	 w8BVkDQLvrGsr/FMA9fVdcY4+3h1lW/Vg0OSlpD1Y7HP2btzZWuqIidUTBrvShlxgm
	 mMo5JpeahYO8w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 25 Apr 2024 21:02:09 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Apr 2024 21:02:08 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v1] arm: dts: meson-axg: add NAND controller node for AXG
Date: Thu, 25 Apr 2024 20:50:52 +0300
Message-ID: <20240425175052.2650301-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184931 [Apr 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/25 14:02:00 #24969020
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 26 Apr 2024 13:01:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2281

nfc: Synced from Linux commit 7ca2ef33179f ("Linux 6.6-rc1")
nand_all_pins: Synced from Linux commit be18d53c32b2 ("Linux 6.7-rc3")

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm/dts/meson-axg.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
index 3f5254eeb4..4f6fdd5523 100644
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
@@ -1906,6 +1927,21 @@
 				resets =3D <&reset RESET_SD_EMMC_C>;
 			};
=20
+			nfc: nand-controller@7800 {
+				compatible =3D "amlogic,meson-axg-nfc";
+				reg =3D <0x0 0x7800 0x0 0x100>,
+				      <0x0 0x7000 0x0 0x800>;
+				reg-names =3D "nfc", "emmc";
+				pinctrl-0 =3D <&nand_all_pins>;
+				pinctrl-names =3D "default";
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				interrupts =3D <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
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


