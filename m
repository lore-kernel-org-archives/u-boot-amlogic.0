Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD86E83F03
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13832.1770115629468438734
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=FA+wotUf;
 spf=pass (domain: oss.nxp.com, ip: 52.101.83.41, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdO1aXXXSqP99okcz7KlO6/63BwGJt6MT5vh6AXMXn0UGId5ZppB8mtiv2dONSQPhqZf9jyK2oTtHMrAk+ZF+hAWs8bHW8y0TaYkeAbo/1PXW5PczrjFmjlxcctFnX65BryFK3MslK+Qzs6EkW5VAJ7iNCUCWU37ain3aKJNe+ngF554QvlFOkBdwSoecBOT2K4zIVQ/7EnQZ4zjbNyc0Grpfet1hkASo5sOAeJKLznCID0UksTvcPzfrvbW7Pd8Y6SNSRHOJKQ/A42JdEUAa95Q4+KnAL/zGzNtaSJ7FaO+9pViTOt5meSoO9m+QLAUw8ZS+uP3TDHBKfoVA1oi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v0xNatn2VRaEqixmv6b6Y0wkMotCYfBmo97xeZd3uw=;
 b=XNsXYKNdHfBDwbuUShQVSae/nJDzo0UyTJazOHknnweunPh7EdHvr954qKmWCGnJRaJFM7bb2BOYnOieQKoeUktegKM56h9ty3QCP7zYlQ5SltNyfA0adBf0ArFrT6GP3vxryu7eIwYd8ZfaSM2x/TYIKbjx9cBCRHb3iFwpGpqhz73oiS4TbU77NNtgZJoCmAOWZlkOAidUWRb2GlvVB93Rvc2Jrcj3g211PhEl97ptn08N04t+gymARurlK7TPcpqBYMiw04uMk8WNQKnbL8LFU/cELuMKtfqFgVWhDjPViE7D1CAt6779YP27QsiBCF5Rg98XRw88wT42KBtnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v0xNatn2VRaEqixmv6b6Y0wkMotCYfBmo97xeZd3uw=;
 b=FA+wotUfW4YAH02sBxzlT++c4VO1dpSIWQz3rVuMMvH6/uBTqJNxjhhFgxEtWMnGx6JKoec8gIXTQ5P2mWBrr7WYbhgqVUvoi4yz2h8ndaVFSvrc5mt0intdKc/hPDgqjrlbhj/WO26nlnZyBOPTeniwG2C6of3cy2OxHIgePJDYsvzizn+g9SE2KS9wKhjYbBgA6A3nHrLysV9xW7fk2Q1DlJ37MbwiUKijQEG7GOjHWZZR7OVml+Wk/QiqRXMGCBwjl21BvyEh2PeNKyOnWV51QhFMAWzZ/Xzvor/gmlLlC9h+YY/V1u+O/DpVn26U2skfMttS3CfCTj02H2CKQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6908.eurprd04.prod.outlook.com (2603:10a6:10:116::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 10:47:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:47:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:39 +0800
Subject: [PATCH 08/14] tegra: pmc: Cleanup headers
Message-Id: <20260203-cleanup-v1-8-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 17bd99d3-b0a7-4620-1f3a-08de63118fac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?R043WEhNV0RSTys0V2JvdjVEaUdxZWl2WlpkdGd0YWJoanYrV0Z0cmFHaG1D?=
 =?utf-8?B?RGhLMlFQdXhSdVcyVGZWM0RZT2kyVzBJTTZhTllDRCtFTDYzR0RETEZ0ZkpM?=
 =?utf-8?B?Z2NrYzZNRVo0NE5lN3htTHNSK0FQMWt4bWFSenBybUZwMGhCMTk0ZWFuSXdh?=
 =?utf-8?B?dXhGbWVIMnQwVWlVb1RDamczUkI0ZGN3L3pIVDNZLytoa0NFU3Vmb2NKMi8x?=
 =?utf-8?B?QTdHR3JEdmxleHd6QlJETkswVXhOQkJleGYyZEdNU0l5WUo3OXJ4MVd6UFpz?=
 =?utf-8?B?dVVpS0xZVm95a3F5YlZIc1ZUQURPSE1qVkxuOWUyWm9HYWozaTBJTzhSK01Y?=
 =?utf-8?B?Z1RTWDRLL2kvWWRSVzZEM2FVbzV3bzhPbkhYYUpyQ0sxWjJwbkRPRndZbm5S?=
 =?utf-8?B?b0FJdndFajE2amxQOXhOZm10K0hwYnhDUnBPaEZYUjN3UFVwUHIxcXp2VGY4?=
 =?utf-8?B?YzRPZ3JGU2ZzaVEzZVdHVkxWQmhMeE5uUzZNNkxzQnZqNjJXeU53cDZzS3F1?=
 =?utf-8?B?aDU4MForbk1vTTlvdTdsK3VtUUphMHVKWUtKdkJvczdBMFh4dmN1cVZEUmlw?=
 =?utf-8?B?RzhVcmdVMUFWUlFJUHoydlluYzFwSFVYZnN2RXJrWHMvUC9iN3lJeWRmWWpX?=
 =?utf-8?B?a2ZkZkxMRzczclZwWnM4ekxoeXZ3Uy9IN1hFRmI0VGtsSGdBUDdpSGJtYmlp?=
 =?utf-8?B?Z3hsa1NMaDA3L1J1Z0JCMWdFcVljRmwvSmZGcVFzeEh5ZnNQcXVGalFHcjR0?=
 =?utf-8?B?STBGNjYxV2FjUkJmd29jVlBudGZaMGFkaGp3dXZwMW85VmJCbHVKS0VSaHN4?=
 =?utf-8?B?NXNLUUNlbXJxTlVVZHZMU2tRT0t3Qm9ZRFdRdzN2T1hXWUFFWGxoT2M5TWVJ?=
 =?utf-8?B?YlBWaHgzUExGMGF3WWErS2RsaUswVzhxZ0ZOSWZMbGxxL1JSaWhKRGliUGxT?=
 =?utf-8?B?bEJJeXpjYUFrTm45Q1p6SG4wYVdSL0hrNE16YmRVazRvKzhFSmNReGhXaGFH?=
 =?utf-8?B?eVBYRktFb1daeU5qeHRHdjdoWTVtbjZzOVNUczJJQ24rQlMyenBzMWd0cjhI?=
 =?utf-8?B?Q0xCYm1yYW56R1ZpeTBKR2t2SmJZNUtkb095TDZDVEZzazBnRlZqUmRYMnVk?=
 =?utf-8?B?cG45VGZIc0FReXJBK0QyTzExM0xVaER1QXZiZG01ZzhGK3FLRDlvbDVhZ2Vh?=
 =?utf-8?B?a0ZrZXVTMlExaTJqUkVyUHlSZ1gzalBMaHVsL01kU0Z2Y3Zvb3RXY0xabmpt?=
 =?utf-8?B?cVE1SFpYOExIalVMNTdxdU1GYVBScFFYWWFiRkFqdmFtOFNJc0t3K1hJS3VZ?=
 =?utf-8?B?U3lTQVprSVlvaFdiMTR4cjhrdHoxSDhmL2ZKa1M2cVo5SFphZjF4SXc5NHZ1?=
 =?utf-8?B?VFdKZ2lWUzVYcEtTcmhNUFB4Q243bjd6RUM2M3cxUytYZ3VoSzliWDNQWHhQ?=
 =?utf-8?B?L0NSRGxaZThyalRwTmxYa2U1ZWxOSlZXMmY4TlJwWFNWUTNCdCt4TUQ3YUJm?=
 =?utf-8?B?MlhhZnc5cnMxRWZpV0xSK1ZxN3lQVGI4TkxtNmw4VGY0Mm00U3BDeFY4TURv?=
 =?utf-8?B?VHpPdkJGUElYMkNVVE8rVFUxK2ZLQ0I1enVrSE40OThOQ0JLcWtkcjhhWHNs?=
 =?utf-8?B?RUVnTFIxbGRld2tPanVqbnZkRUQyZDBWbWwzNkRaYkE3VWsrRXdyVUpPVjFP?=
 =?utf-8?B?YjhOUnU0c1Bucmx4VHhiYTRHQjF6OGt4VWFGZDRidzdKNjlJK2NwRHEvZnVk?=
 =?utf-8?B?QWtlTURNVnVvRFlZOGZyVDJYNzdMbGF3NW5iN3lHWmxTdDJHMEJLSzlhV0Vn?=
 =?utf-8?B?MFp3cTBGdFMyUnJCYnVSZkIvRXRPVjVIU256TWY3WjBWU01UeGFRaGJybWxo?=
 =?utf-8?B?UUpWL1FRdVdJMmJOZkthdSs1UGpQM1Y4ODVHSjdLSWZGNlA5a1FEQzdhMzRG?=
 =?utf-8?B?Vm8yQ3pXU3hYQ1cxd3MySXdVR2VDRnp0TVg4eUt3bzhPTE5ydHJDOEFQT2Jo?=
 =?utf-8?B?VzZ5elgwVTVMMU1EdGpLQURoSkFEMG05WW1LcFBRckNjdytFWDh5d2g0aWpS?=
 =?utf-8?B?Y1lMSDRuU1IxUml2S2tSNDZHK3VjQzQ4d3Z2TVIwS0hyNTlUSFNyTG0vRW82?=
 =?utf-8?B?aUI4c1R4UlltYmlENHY4cE1OZGM5YnNHOTA2QWpibkhoL01lTnVicVBtQWFT?=
 =?utf-8?Q?CvTgdYvDXkeuqCgUmL+XFhPmrfX43MHgI4k6LIZdXOnL?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?SmpOdHlOSnpZUTlNWDJsZkg1NDBKUjJMdkNSem0vbTRtL2pYdUxMRUpQS3J3?=
 =?utf-8?B?dmpTRm1Xd05yOTIwU0NMMHpvelkzcWl2THZuajg4VUxJajJHSEU2YlVtTWNl?=
 =?utf-8?B?eG1SSlNtZXFzRWFFVnAwcENmQmxQOTRBei9QeWRDckFVWXVkY3pXak1zempu?=
 =?utf-8?B?SXc3aXdqeUplQzRjMERnMThtTU01YkE2dk02ZXB0ejVnOXhzR0dxTjc0WGhU?=
 =?utf-8?B?bEZua0tsZGdZMGppUFdQQkdMNkRmOHh6VGQ4dVBSTlJuemdydGxxRzBKZjFU?=
 =?utf-8?B?Z2ZkU3piR3V2QmpiYkNPeUpmUjlkbXlNdnkrTW9DOVROZkc5QUM2cDQ0NElI?=
 =?utf-8?B?UWhIcHhOZzRYb1lRczF4cmIzc052RUpwQkRHbzVVY1UrK056S1JIbVFVY0w1?=
 =?utf-8?B?R0lETkZPdDVuak5paGxoOHJ5SlRxeEpsK2hPdU1BK2ZSV1duclBuUkYrUnR1?=
 =?utf-8?B?aUFpMFJJTC9FTTZiUEVxOFpicGQ0eTNGblRJdXVxZDNJR0krMjc4N1ZKeStj?=
 =?utf-8?B?SXhKbmdMSnRKTGIxclk0TVc3TUQ3WlJyUUFXVUlHMERDN3ZXODhzWlU0ZFJI?=
 =?utf-8?B?UThkd00xdGQzMm1YcE9mZXQwUXl0WStyb3BzQ0NkTHFUa2RhQ25IZVRsaUZX?=
 =?utf-8?B?V3dvODhpODJ2TUNOMHlFWkpPMUlZS2FlTnFCdndaak5KUUw3dTBGTkZwNmtW?=
 =?utf-8?B?YmsycDZQREJmenkrT0VBeHNhWHdOVGdsdFptekpCTHNIeGEwSGhrRHVMS051?=
 =?utf-8?B?cWV1YmNDZndVYXA1QUVxNUFPaVJzcXh3eldWZmZFSCtEMDdYbHA1MDZKT0ov?=
 =?utf-8?B?eTd5N2FQZytONlgrQzYzaEdJZmxrdFpsNHluWVRZSzlKUndrYVk5cnFQVGJ1?=
 =?utf-8?B?d2l2M0lhMThoVmsyRUNnalp3ZzFCL3kvT1RXWERMR04wYUdMR2pwbGV3a28z?=
 =?utf-8?B?Rkp5eWdYOXYzbkloWmZYTGJuS0xnOG53RjZLUkFmTEhkcXpsSkJ4SVhRY1RC?=
 =?utf-8?B?blVSQUZ4SXQ2Q3pleUhIUkFqVFZNVDMyZFVvcUNCSVB2eHdWMjZtREc4TGRz?=
 =?utf-8?B?eFlqWmhnOUZ0SXcyUk91aVVhNmFTQmFiRzFWTlROYjNObUJPVnlaMksxZ051?=
 =?utf-8?B?SWlmV2JDblY4eHB2MVVCNDFyZHFTWUd6YVJBb1lTL3JWdGVSTHRTblBHVWh5?=
 =?utf-8?B?eXhHakNoRVhxc1U4NFFoZExITEt0VFh6MVJMK1ZSTjVVeUs2cGh6QkY3Sklu?=
 =?utf-8?B?bDVKZHlwTTVmUXlCRnBBUGowWVI2Q0ViQzJ1c09VSlJBQmdkbCt5c1lnQnBU?=
 =?utf-8?B?QWNPMGQ1eThpTHpPVFNiVmxMcmgxbUtWbVBiamkvem5uaWE5UVlQZ0d3VUFR?=
 =?utf-8?B?M2I3dzlIdGlERmJPQWx0cFJZamxvZkIzVlJlRHhlaGNlZ1VsZkVOQVBJdXRJ?=
 =?utf-8?B?R1ZLcVJmOVJKbjZBcnNCRE9JV1dvN04rdmY4K1I5SlF2V3ZoZkU5MmdCU1Qr?=
 =?utf-8?B?QU5ZK0tCamxXMDNBdWo2TVVQZzBvR2hqNkhRZG9udklYZEE4cURBR0YvMHg2?=
 =?utf-8?B?bFpPa1lTckhGTWJ4aThhWGlOZ1JrenlnSVJLeFFQVmJKcTBsMEt4V3hZYUgz?=
 =?utf-8?B?YzdrL1R4M21TMGFuV0Z0WDFza0JGQzIvcnNyeFIwclY4Mi8rZlJTaHQwdnJJ?=
 =?utf-8?B?UVpEUWtCK3k3VllMc1YxeVJPdVJ3SFg0RlM5ZWxnY2planVpUkdyZFVZVm8z?=
 =?utf-8?B?RGhTUjhlODBKVjl1MGxGTDM2ZXlXL0w5L0F0MVU5Z2tvamFvRUxhY1N3SEdJ?=
 =?utf-8?B?a2FJaFRTcWc5ZmhXc0VvZi82YjVub0N0YXNmWnVKL3BSZ2o5NzJkbE9EUnBP?=
 =?utf-8?B?WnZ2LzlEVHJmQnhrWEZ1TXFWbGlpam1yM2poRGViRTh0czBrMlVJenRpUkQ1?=
 =?utf-8?B?VXBIUk83WHF5blFBYTF6UjRBWVFiUUliS3hFdFllaDZKNWVTK0FXMkpka3c5?=
 =?utf-8?B?b2hyajlMQ1h2Y0dTYStQNjA4YTEzemlzOXVVME0xSW1JUTdwM2thNGsvMFR4?=
 =?utf-8?B?SllHckdoUHhlUGRabTZ3bUJhNEo4ckhaYng1K2dLSFh2VGx1bHhWQmhYNGYy?=
 =?utf-8?B?MHVSL1MvQUVNcFhQUVNZVmJpQ2RyUXZKcDErTkNaTm5wZGlReXVoZnRkUUdP?=
 =?utf-8?B?ZWtONG4vd2RVLzVyOGJRUmV4WjlBMkV6NXZuN3BYZHRDSTRGSHVZT2xucFE4?=
 =?utf-8?B?UmNKN0NFWGdxYTJiU0J4STNPZlJ1NEpQNytXMDVXbEJpaDVJUUF4QkFtMlpB?=
 =?utf-8?B?dTlKaUVSNGFKQ2ZjOFhrV0VxaElvYzRHOG5GUVVFTElORUphbnVVZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bd99d3-b0a7-4620-1f3a-08de63118fac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:47:01.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wf+PYHNqd6W79bJ5cYcm1mVGQZZU9n41v/icsZc+vjoQog0edZJ6z645oJhIQAJryQ5uOVkIbVAhooOpPkFaQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6908
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2891

From: Peng Fan <peng.fan@nxp.com>

No gd users, so remove DECLARE_GLOBAL_DATA_PTR and the including of
"asm/global_data.h". And include "asm/arch-tegra/tegra.h" to avoid
build error.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-tegra/pmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 3f968d4aeae862053dc4e7f26335ebbe1bbb9aa5..019c4b0b21f3b6712d2f577181fd6815ad826e09 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -5,14 +5,12 @@
 
 #include <cpu_func.h>
 #include <log.h>
-#include <asm/global_data.h>
 
 #include <linux/arm-smccc.h>
 
 #include <asm/io.h>
 #include <asm/arch-tegra/pmc.h>
-
-DECLARE_GLOBAL_DATA_PTR;
+#include <asm/arch-tegra/tegra.h>
 
 #if IS_ENABLED(CONFIG_TEGRA_PMC_SECURE)
 static bool tegra_pmc_detect_tz_only(void)

-- 
2.37.1


