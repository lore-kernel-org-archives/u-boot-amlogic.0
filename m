Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2685E83EFB
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13631.1770115538898915014
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:45:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=oPXYsOor;
 spf=pass (domain: oss.nxp.com, ip: 52.101.84.53, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEvJW3Tf2CqHQW3LJcNBgjp1OVOqZ2AvbPDXfl7GSFYEeCV2K+yqZKNo9idqfSKRmZ1sdbgrGtCEjhYxQtPOUe7nTYawIUVPo0lp1PCNtKunkg4kSFtEITbUfDA7COUX4KHykPuxcOgxWVo2vZlNVxDelKab1Z4kQWZGbRo3/62JP5YPsqJkW/mGfkll20hhd/vxew3XzO4oPQokHxBrYzF2RPN5DWAGUSU3b0Ve+kZRsdFVm3mjTQx58texeWR0+kvievh/VVpjWqJrPb+WIhN4noSrTbsACxLL+zOgYRvrQCNBW2rsBU/oIFnFdaHEmXVD3uKVd9GF905b5x1y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VssyrbsKhy/hzCHFhqpCm15ufXmqdTZQ6a9TAby6Zcs=;
 b=kZGpT0LtlQfqJB/Ll94L21VASKWJAiMhSpl3yVgN6mGR4Cpt7FpM9dXQVXzkVtbEnSyslEjvuR5GP4znvI+SZyuoGgtEBL0sCZJWse4Wk7WV3DTq12NNZelwNewH8w1ajYqg9XKS68MMNV5YJ5Jbjvrbnr+6YBE5Wk5AL2iUFd79m8ZQTFOdf1/Ne8h+rU4tfAAa/KriLd991qI9oxF4iUwC4D6FjdFzk1uNa4tcWFYmvoKBgweSwfh7VpPVj0iW2Oj7QfVi41DZkoC+ovtsoksXEh1wsGNWEiTp1K60Ci8fDbp2g0yauH5f1MG5ieXxw3TO/DPvvINjpH96fyznNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VssyrbsKhy/hzCHFhqpCm15ufXmqdTZQ6a9TAby6Zcs=;
 b=oPXYsOoreXpXVIrpgGO2zLhEhxmDlF4jYsKqQrbE6iLE/RmmYGg6CoMX3KXh4wNq12O+DcabuqDNcjriBMyx2vKMn/aa2xsr4+nBzUB/Fjb2R9bxZSQ2LA50/3dxc64McTZGJ1/gjfh08+gZJoO5ZieLS5+NXmJwoj39I5LedZMICg2mEMeOtauX41Il9N+Q6Cc9Lk6IAbzF791eLoMzTnZgHwmdMKypJwPh2DWHfh3C1rQa9m8vgohY1A0FXTsqh29hX1HnO++8HUb/g2PHL2/HNidu3kAZqA/u/Ra5j4BtLEl0V8USlAgQQ6SrLd2pnWFJaK25rCSxLhDo+UbjMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7147.eurprd04.prod.outlook.com (2603:10a6:10:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:45:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:45:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:37 +0800
Subject: [PATCH 06/14] xtensa: relocate: Add missing headers
Message-Id: <20260203-cleanup-v1-6-4221c13e7558@nxp.com>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
In-Reply-To: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Christoph Stoidner <c.stoidner@phytec.de>, kernel@puri.sm, 
 Sam Day <me@samcday.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, uboot-snps-arc@synopsys.com, 
 u-boot-amlogic@groups.io, u-boot@dh-electronics.com, 
 upstream@lists.phytec.de, u-boot-qcom@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, adsp-linux@analog.com
Cc: Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome@forissier.org>, Simon Glass <sjg@chromium.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Stefano Babic <sbabic@nabladev.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Stefan Bosch <stefan_b@posteo.net>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Aaron Williams <awilliams@marvell.com>, Thomas Chou <thomas@wytron.com.tw>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Yao Zi <me@ziyao.cc>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Bin Meng <bmeng.cn@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Oliver Graute <oliver.graute@kococonnector.com>, 
 Randolph <randolph@andestech.com>, David Feng <fenghua@phytium.com.cn>, 
 Linus Walleij <linusw@kernel.org>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Gilles Talis <gilles.talis@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Mario Six <mario.six@gdsys.cc>, Marco Franchi <marcofrk@gmail.com>, 
 Alifer Moraes <alifer.wsdm@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heiko Thiery <heiko.thiery@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Ian Ray <ian.ray@gehealthcare.com>, Teresa Remmet <t.remmet@phytec.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Angus Ainslie <angus@akkea.ca>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Kamil Lulko <kamil.lulko@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dillon Min <dillon.minfei@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Anastasiia Lukianenko <vicooodin@gmail.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Brian Sune <briansune@gmail.com>, Tingting Meng <tingting.meng@altera.com>, 
 Mahesh Rao <mahesh.rao@altera.com>, Ye Li <ye.li@nxp.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Debbie Horsfall <debbie.horsfall@arm.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Anshul Dalal <anshuld@ti.com>, Francesco Valla <francesco@valla.it>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Primoz Fiser <primoz.fiser@norik.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Keerthy <j-keerthy@ti.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Adriano Cordova <adrianox@gmail.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Sky Huang <SkyLake.Huang@mediatek.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Christoph Fritz <chf.fritz@googlemail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>, 
 E Shattow <e@freeshell.de>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 David Zang <davidzangcs@gmail.com>, 
 Brian Ruley <brian.ruley@gehealthcare.com>, Swamil Jain <s-jain1@ti.com>, 
 Zixun LI <admin@hifiphile.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Leonard Anderweit <l.anderweit@phytec.de>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a352d4a-c96c-40b1-a1ce-08de63115988
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?MzhBbmFkR25NMjIwakpsek1JV09seHdaOGxJekYxbXJmd1RwcEpQVlRoK01E?=
 =?utf-8?B?Nllwd3FhQ1lwcjFPK1RVL2d1OU4vOVNTcjJEM2U3QVR5RDRHdm5hcXg5d0h1?=
 =?utf-8?B?VEtiRU41UURoWXRuM3ZKWGI2VDVUZXQyRmNGcjhXNEFSV2p0eWNGcG11U0hZ?=
 =?utf-8?B?VUN2MmFHeUFjOEpVWnFnUno0VXRDVWtPSUphaXAzYmNJaUxZSWF6b212Z2o4?=
 =?utf-8?B?Q0R0SURiUkxBaWcwa09BT1BCRllyOHV2aGU4YkxTNjkwcmllcldQVnA0Yy9v?=
 =?utf-8?B?UU5raU4wRnlzN3VvdDNCc1dQeTAvV2hCNDRDeURmZnhCUHY2d2tNa0JkNmYx?=
 =?utf-8?B?L0hsM2dqTGZ6QUVINDhTR3d0TTJCWDhGNktmcEM2RU9mR1c4ZWpkdHVxUjlE?=
 =?utf-8?B?RzB3RVJhNUZSUkVNZjVMeFNlK21Dd2lhcktvbDkwYXpBVmdnU3dQVHRlcFRC?=
 =?utf-8?B?OExlZVVrRUNYZCtrVGxFb3YrMHJjdGo4c00ybm1lcUp6c1VxcnczMmQ3Zkd0?=
 =?utf-8?B?alJFaSt4U0N3Z0diUGVCdHdOdHBJR1JXR0oyVmhwRVlTb3ZIUWZabmpwNE9r?=
 =?utf-8?B?QTJTVnkxbFpYWjc0RzJUZkhydG5iVUR4b0thVlRhZ1RFc2VUZkR5RmJmTm5P?=
 =?utf-8?B?SHk4TWg4c3pQWGlxNTN1TjFpMG1MaisraWlhNmhIcFlEeDBSaC90ZnU2b2pG?=
 =?utf-8?B?ZkIzTmJjOVhSSjFGRm5BdXFXSEpwM1JqL3VZUEFEMGdwa1h2YUE5WTVpTFFp?=
 =?utf-8?B?VFI5SXh2dDc3bHN2T1ZDYVJvSXhLSVNseEs3SWVFcVRuTXppQ245a05vK0RR?=
 =?utf-8?B?cllQUTJJaFB0cnBOd3RmcHFOVVBYcnBTdXVHblB6T3FJNTlWNVUzQ3J1VDZh?=
 =?utf-8?B?TitOaFkyYlNJcHlqNGwxaVV4aTNwM0p2VWlsLyt5cmVvTHJXMjFhNi83ZlpM?=
 =?utf-8?B?ckwyYkh5VDExaEMvYmhnUVRweGdDSnpCYmxEaG1Xdm5qc1E5OUNrQ0Y1dVdj?=
 =?utf-8?B?b3ZHNHJHek5SL1JrZ2dSTXRYdnBFWFVMR284RUtoQUJjak01bWIxQ3EwODd2?=
 =?utf-8?B?MjhXUEcxRXhTL0NIbkRHQjBZTUw4Sm5YK3VNdi9qaTQ4VXMrMHBUWTBSNHJx?=
 =?utf-8?B?QUtiNGhlQWJ4T1ZHampsUmlEYS96NGluL0x4dnpURUxMUXM0SXQ4cW5vRXVM?=
 =?utf-8?B?VUZWSEtKd2ZRaldzUlMwM0hXVE5mWStkaVNLWnpuUzBobzgvakcxeWFDd1J4?=
 =?utf-8?B?NE0vZjR0ZTRyNUs3SFc5c1VwV1dhQzFJWi82bm1ldFhvQUhpVzVhZFRCaEpE?=
 =?utf-8?B?OEZhc0cydmkvUVRTV2M1ankreTN5ZUJoWXVZdTVHV2dDcE81bDNjWnZpOVR4?=
 =?utf-8?B?M29kb0huanRJNGN2S2lLelVjWEQ1KzZaNnJwSjZ3dThsQ2liR0o2N3ZJV210?=
 =?utf-8?B?c2o5MlJMMXVSWHFiSzRXM1RiUFh5NVIvY3kremVzWUdEdHF6ZDluU0dhb1h4?=
 =?utf-8?B?aHhDVzFxUjhEM0lIVkcwNWNZamlzekhhNjFWMXJySmZiRVlLM3pzdTk4Ly8z?=
 =?utf-8?B?Sk84Q295eWpOVFNTSk5KNVdqTmNDMUV2dC9ZSEtnTVV0OFJ5Szc0ZFJveU1l?=
 =?utf-8?B?R2pVLzdjamFwT2RyQ05SbjJVYldDcjlPYktHcXM0UTk4SGxGbkw1Z2hVL2NJ?=
 =?utf-8?B?STl6bUVtMXZXS1VIYUl6aVVZeTY2NmJKZW9OOG5PVENZRlg0YjdxaG5nbFRI?=
 =?utf-8?B?alV4aGNBS2VpM1ROaFBWZWpVRXphNkdzei9iTDhhYWlvTjV4ak8zUlNGWEJY?=
 =?utf-8?B?ejhaR3o2eFJKeUhMRWUzM3NWZTlBczllSGFiZjB4L1oxZVA2ZkwwUEI1bEJm?=
 =?utf-8?B?Qms5SFEySGRIMlk1QUdHU0gzcEltK0ZFd3FGQlJrTGJQcVJ4SW1QaE4wUHZK?=
 =?utf-8?B?eDA3bVBQRkJvTVlBemRZbUpSejc3TDQ3MkQraHNxUGFpSE1LU0hyNmJ0MUhY?=
 =?utf-8?B?ZlR3end4ZE1BRHhLMUZySzkwand0MGNJazcwYTBiTXZUWDRwMWZhZU1lYWdL?=
 =?utf-8?B?N3RCNHZid2xlWVJDaDB6L0ZiL3Yva3ZHN1RGMHE2TnZzMVZIQW04WDI1cVB6?=
 =?utf-8?B?TWdOc2UwUW01NFN6MERzMWNKN0FBSVBBa1pJT0ZpSVF2OStVNDZhOEd1Ym8r?=
 =?utf-8?Q?IsPofahDxuTy80cWCoJy0snUG7SmQLjqlV3xvSaCwwQC?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?WG1OM0tsYnFHTkd0UjF6UjN4VktHc0o4OWxoR1huOGsrYVVuYURSbGxFdVk3?=
 =?utf-8?B?eGRzQWZIelE2REc1VGVvcUhpNGJkWGxUeWt0cFBBczU3dmlLV2R6dElFMC9a?=
 =?utf-8?B?aXp6WHhSNzh6Uk1SSGlUdVN0SkpoQWRGSGdQdTJxUG1nTUYxUU0wK3NYZE1C?=
 =?utf-8?B?RmN5MUpIdVdRKzdiZ2JuVm1raGdJYlZER2lQMndMTzNHaklVN0Y0VkFwaXIv?=
 =?utf-8?B?akZ1UDRFN3FMaTcrc1pDbFFYaDF2cmVyUFdIeHM5TWtRTmxNSGdFeCszN3lK?=
 =?utf-8?B?eFh6ZUhmVTNDTEd5am1kTzlmWGxEdFUxNnppY0lsTklXRlBxV2w5aWRPS0d6?=
 =?utf-8?B?NndBelRWenpTR2NsTGtraXdLa1NoWU5LcmloWGlnRndIVDRCRjIrWkttbFZo?=
 =?utf-8?B?YWZVd1BOQkFGNDVmSjgwNUY0OTFEaFZrV2JDRnJnS2ZlWll2SnJFajV0bDBH?=
 =?utf-8?B?aFNWak5ybFVMNGJueVYyMFhEMWtLRUlXK0lxNTNVc0RJaDg2NVhjancvSzhK?=
 =?utf-8?B?aXlBNWxvY1NjR1VYU0VNanFJS1N5REhhN1JvM3NkMVd0YlJtTS85WDd6T1Ix?=
 =?utf-8?B?VXZzZ3NlemxyRitnY3REMkgzOGZJMFZuMGU0NmdMR0RXeW5qSS9pM2pTYTdS?=
 =?utf-8?B?a0trdDY3bU51ZXhhRXR2d1JMN0paQXZ4MzFORVlrUW5SUm5aN0czeU1Bblh4?=
 =?utf-8?B?SEpNSDhqZ2kyZDgzS01TY3RFK0FPcDBydElLMjR6UXBSdVZ3Tms2dzRKKzhr?=
 =?utf-8?B?dHlRSm53RnE2RWk2SkNJOWUzOHVhdVhZNlRLUVNXbm9OYjFadFViMVFpck9K?=
 =?utf-8?B?RVVYSWtPTTZkQXpGRlRSUHdSRS85bVlaQzlOMjFUQmVLR0RUY3NiMW16Z0Rq?=
 =?utf-8?B?a043UTl2cjl4RUtjVXlURWtraFdDNGpaTG9ESFBVWmJRWmxvQjNtV29wRGJI?=
 =?utf-8?B?YlJPdjhpaGpvYXZrNDd2L0M5S25LVHN0cEcxaEw1U3pWaFVmWmFodi8yQUs0?=
 =?utf-8?B?NDRTSHJaam5scW5HRlpobFpEWkVKZDRWTkYxNldaaDQzQUROZk1wMHJseS9G?=
 =?utf-8?B?WGNia0lmdVd6V0hzWlhLQ0RCMEJrN3NyUjEvMjZTQWtKalVUb1hzelNVQWVn?=
 =?utf-8?B?UmVySVVZT0NLVHRJWHZDWXF4aUJ3TndrNTRnTlFrTEx5MUo1T2IzbVlvdy8r?=
 =?utf-8?B?MnNPM0lYYjJTR2lGV2x1d09GTFlIa2txaytUMDF3Z2UrcXdhTnNLbXFWSWVk?=
 =?utf-8?B?bzhvNUNrTWMyd3ByWFpkeG5ueVlTMWdDQzRoWWs1UytLbG5DM3IvbDBCQzdG?=
 =?utf-8?B?Y2luMkUvZEtWTTQ2MW5GYzV3djZLeTZDWlBkWDZ1VVBEcjA4R2haeXgvVlJk?=
 =?utf-8?B?S3lkbExCbnBOb2p2YkNvcnlENGVYRWFKelEwRjBYcWdYS1JXNjZJYzFudTVL?=
 =?utf-8?B?N29GMlIwWHRUUUdZY0lBZnFvViszaUVOc1pDcHZxTnZWVEI0UTM1anVGWVBO?=
 =?utf-8?B?aVloUi93TkJ6QkN0VXZxR0JPc2lHZ0p3ZjBZOGIwN1V6Ym11V25ZNzlDc05k?=
 =?utf-8?B?RERyNWtQT0h6bUpIVDFKTkFpZFZIT0w4OWtYK2tTdzZvZ1pqN1l2cCtqc3Ey?=
 =?utf-8?B?MXBWcmduZng5cy9MbURzL0lONzIzdEtmRDhGUml0SEY0Qm5GVWxlS21NZ2JC?=
 =?utf-8?B?WWJ5YmRNRlNlcXF6cXRmUm1INVloaG83S1o2aEVqZndyNVluNlZMZEFQQTJy?=
 =?utf-8?B?V0djOUJabjZJSWpVWTFXODdnYm0zUGh5YitFZ2IzeFhWT0xyeTc0a1hUdHFS?=
 =?utf-8?B?bXJaQXV2WXRrR1lXcE42YWY4b2RzTHRuMGVDeVB2N2U2SW1EQWdFRDhCRHlL?=
 =?utf-8?B?WEl1OUtLcmZIUjdta0ZoR3hhc0NqL0IwM1BrNHVIRXlrNEcvNUk2OUVIV2xa?=
 =?utf-8?B?Q0ljUEpwbFhrWGlsbXNXUWczUU02eVdzd0VPN0NWb2UvTTJ1YnpGSUFWNXpo?=
 =?utf-8?B?KzYwYkZTTnU1MEgvWkNaNXQzN0lHZ0JiSVZncHhlSURkaFNxSUxqMGpOS0gw?=
 =?utf-8?B?L1ZNazdNTEplTEUvVHg3Ung0UGNJREJZYVN6M0hTU2dOL29MVWZVL0Z1bGtp?=
 =?utf-8?B?cXJTNzBRem1HSXp6VUpVNTZjeGIvZUNYVFkwSjcxMzhxeGdEVWQ4SU9sTEhr?=
 =?utf-8?B?bUVTaEs3SmhKR0h4T3BPVHl4c2x1dTE5NC9FaVpFTTgzVHVnWUlJeExENElE?=
 =?utf-8?B?b2NzMy9nQjFaWHlSZWpkdUNFWm1Ucm85c2sxclBjN3lhRVhXRDloaTZtUHZj?=
 =?utf-8?B?Q1hldGVTOEw5azZub0NkNzNBYWxwbk84a2ZvNEdtMTltZlF1VFBSUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a352d4a-c96c-40b1-a1ce-08de63115988
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:45:30.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgAk7aII63CROwE+x2xW/KfGI7mwnEpAp3NxGFiEhKceiN2/qJYK3WEvVZ9XrEUBkQp2+/+aZu2DmR43ydHDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7147
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2893

From: Peng Fan <peng.fan@nxp.com>

memset and size_t are used in this file, so add missing headers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/xtensa/lib/relocate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/lib/relocate.c b/arch/xtensa/lib/relocate.c
index a499590c75bc5f143ef9dd008b36262b63e027de..d3d317edf88fe433908ffb2300f8f8733415d1fc 100644
--- a/arch/xtensa/lib/relocate.c
+++ b/arch/xtensa/lib/relocate.c
@@ -4,6 +4,8 @@
  */
 
 #include <relocate.h>
+#include <linux/string.h>
+#include <linux/types.h>
 #include <asm/sections.h>
 #include <asm/string.h>
 

-- 
2.37.1


