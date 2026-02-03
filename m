Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C5E83F0C
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:56 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13610.1770115405026426250
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:43:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=xdCaPgvX;
 spf=pass (domain: oss.nxp.com, ip: 52.101.84.66, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZb0jQiIVcPQ0l3QljFylTrTE4zWHtYcWyJv8j3HKGqmN81udrPlY7dl9YIxJySoJdNOwSyfG+ZgmlwaYiLXMhGKqb6fFIpk2pCxB069P230JTYfRsfLHAmxGZjtQKNhpcZCvbsv1QKHLjigZjy/eEdr0tBoA9FkP+aAB8T78o+qM1e5Cpc2EVfWRkRgvDG4N0ji6uG7ZAPEWPvZAEf5lCv6Oe+KUE3/3Zyusy0IxEBHZmKFu0wKT3EtHGLRi/+z3/8ssw2BSoQMTcl8ZBe0864aB5UW9WOP7+7ziUbqj2ipQmzUFk/QFWInd+YxqBF+XVBu1A+pEJMP/GsPDHxolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxbr7uyv8Xqm+u1OsX4NFT/MEzMSpSPFOaM6+KTG3SM=;
 b=UjYY7Fn+tHnKXYDDSMz9O48soXNElr8XxMKp+iw3pkDSNWwqfiSQ0G7zD+tqry8F9B330+ySPu6F131AhanA+eYkGaZfgif03TnoFM/UNN5h8OMwfB6lKT6bQMdDlDT5FG0dzsVgVhFo9nyy268jwX5sQHW00uBcbIQNRQ6DzyHCGQk05yDIvV1rKfxHUcdLAFXV9PTUj8C5nsd90kn7SxjAv7leZ85FMKiCaUcYEHf6qah9ZYapkXKHX1NPGJ5G1IrL+IIH7K7TkUgNxg+DWP6fd1uM+M3jhggP922cLS+hgrIaTkCchKk234yk8Cx1gjPNzAGlVEWMJL5mwfcsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxbr7uyv8Xqm+u1OsX4NFT/MEzMSpSPFOaM6+KTG3SM=;
 b=xdCaPgvXLYX8TWUtaVqN1zeQ6UKoxWT957eqvbxxBan2JXBLvBJ2HDZG4xd2IP+HUk4v9ItcGX4XsUfzpRMzrDMmEVPI5u+Iprp7F26kp34wQOLA3hQlQu5wHd0zGkAPkLWwE7z/KFQtMH3g0eOFN9tkJk6/XPjZ8ZgHe22m9YUesohimUxkAvji3LPn6Ea2r03l8EgzQdLoZypV0/9ZVRyj0uZxl5vDe7bMprBkyU97mhQAOzcgqRKWAQu4fHDFO3zbC5e8Q8JteaNJuU1hToAQ+hVGMPXrGhIm0LFZggEnil6YFw3NJYqfuQu21lNFQ8g+COAMnIpOVHNjdZPiEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by FRWPR04MB11197.eurprd04.prod.outlook.com (2603:10a6:d10:170::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 10:43:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:43:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:34 +0800
Subject: [PATCH 03/14] common: cli_hush: Include vsprintf.h
Message-Id: <20260203-cleanup-v1-3-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|FRWPR04MB11197:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a0375f-f246-4ce4-c147-08de631108b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?YllxWUdGL2QyOWJ5d2hnRldrTVM4UnFFMXZWcTdzVm9QbVpLallRdHhmOFEx?=
 =?utf-8?B?dEhYSVNGZnNyMXZ2a0FnZnZKMGZWQ0VOMVhIaXpiTFZNcmJnbUQ4R3RBbEw1?=
 =?utf-8?B?L1lIUzdQQUJndjJOenFyZXo2Yk9GNWNBRXNaS1NDbjBkVVp6TFhPT0Zkai9q?=
 =?utf-8?B?eVlUcDhSV2RYYkRLeHVpTEpsbzk0WHhPS2dQeTI4VU95UllVSkVZZW5JQ3BF?=
 =?utf-8?B?RzhYNU9FYk5BZHBoclI4d3RTTDRVNERaQkFxcm9SQ080a0xmcUl1K291eHVH?=
 =?utf-8?B?bXFXa0JtcU5Ja0RqU1pvREx2elF6c2dtZmtLV0ludE4vcUhaZzFWMzdsSk5k?=
 =?utf-8?B?S1hmV0NudjBxWE9GRkdzMzBDcENVRUF1V3pucmR1RS9UaWs5RldjQytZWFox?=
 =?utf-8?B?d0VDRXRtYUxTZ0EvRzNZZDhxMGJDN25ENlpyRDQ5UEhUcHFIaHJHbm0wSFBk?=
 =?utf-8?B?SmlRVjlpU1ZaUjFsK1VEN1VzVVU3dnFWVUVIV1BTL2RXRTNLcFdlSWpVbGw0?=
 =?utf-8?B?WnZhbGJheDFPVUI5SVlvaVhTM1ZrZGpRMGkrWlZLdWhzYmFCc2hPM3dIeGtG?=
 =?utf-8?B?dEZFWDcvNzBINnpZd0M0cFh0alNCSzRPdGM0TXZ6SGg1VlRFa00wdWFvNW9j?=
 =?utf-8?B?OTJjMUErcm5ZcnlKL1NuVGd5TkRaMXY5QWVHSGJLcWJLbFdYdng4OUlwdkw1?=
 =?utf-8?B?QWZQbjNLSWFncVJGdTRVb3lZQXVoWE9OaCthaFZHQTdKeE50T1JIeXdUMUhv?=
 =?utf-8?B?NlI5RUdVUVRjR2lDTjFUck04ak5EUnFkYmRlbHg4R1dDNXMwNzVaQXBOMCs1?=
 =?utf-8?B?YThuNHIydHhRZEVZL1pGb1BFdFZscklrQkhxMFBOSFdpSVBWTEw4a0hMYWcx?=
 =?utf-8?B?VzdzZU5KWWJ4VmRMdmtDU2xCeDFMTXdTcWxDbjVIMkdCYlNKWkpidHRZOGRY?=
 =?utf-8?B?R2tSNXd2UE1yNDBKRHoyZGorZWtJREF6MFNZK3pCSi9nWFFuRmhPeDcxSWQv?=
 =?utf-8?B?eUtucHlVdkUwcHhhaHNpWnlGUjdtaVhYVG1ncUQrS0lXQ3Q2ajlVdTFVYWx0?=
 =?utf-8?B?ellHZzhCZkRnL2Y1cW43ZThwOTd5L0hVNXExY25QVkdacUJRL3lTUDE1dWds?=
 =?utf-8?B?SU51bFluN3ZQeTdKaVJkdTc1VjgxVFdVZ08vR0lJMmY0bjJCUDhCUDRHTlAy?=
 =?utf-8?B?SXI5b0xjVzI3aVFidVVyNzN3TTNwd2gyQWVZeVJXRlB1RWh3c1dPMVJyNUJR?=
 =?utf-8?B?dXEvNXZva0dSZFJmRVVianZZVmg1cmt0Q05LU0NoR0c5azhZaDJ5TmY2YVht?=
 =?utf-8?B?WWdaeDJSNmZqZHM2SEUzcXZjVmRPUWhOTThNQTV2cjN1WTliTTlBOVNORXY1?=
 =?utf-8?B?c0N5b2h1RnlIODd4Tkd1Z1p3cHlnZmpDUk5LeXh2SENScnVITHpSdG55MDR4?=
 =?utf-8?B?WTMvVGw0MTZFNjNCQU5TcWw1UXp6ekV4VmN1OS90WjRIWU1NYktCRzhrc0s5?=
 =?utf-8?B?N1JPUVI2bDVlN1JtY21qNmVDRGFwS01JbUpheHNSZ1FWV3Y1dXVPWnJjQ3lm?=
 =?utf-8?B?SnU3Vm9MV05iK2pYeFEvZDQvQTU1b2s1dTROeU0xQ0toS09Ub3V6NktLVW8v?=
 =?utf-8?B?WVk0R1ByK1IrOVBYdkQ4endMMzJUOFBQU0lYTWQxUmVYckhxTUdlZEc1ZnJ3?=
 =?utf-8?B?U25PQkNKWjlmcmsxTlVKYmdHb2c1WW5LbmhiWWJibGVPRnh2M09sUTJEWm9r?=
 =?utf-8?B?Y2htVlFlTWV1dU13VVJzM2ErZ1lIRUNiL1ZPMEY2ai80b2lHLzkvRWlYbG5S?=
 =?utf-8?B?WDdCdDhpdkJvbFZUMEZWdWtPM05ieEN2V1ZHOUVwejd2c3dDSmpBVi9sK0tv?=
 =?utf-8?B?VFY4cDliRkpCRTBDZFRIaUxkU1hJWDRVRWxQVWxSVnIvRmxNZ0pLRUpCVEp1?=
 =?utf-8?B?ZXd6ZjBHTHpUQ1o0MkZ2OU5ibmgyN1VScjBPOG1INXFlay82ZGUwZjFEQUhX?=
 =?utf-8?B?NFJHd1hsRmpUdzR6UUJFYWNTZmVISk9VZmZjcGJWMXBONmg3cmQ2S01JRS9q?=
 =?utf-8?B?dmp1Z0ozdnJJc29SLzhNLzREUDZUWldjcDJza1VpMVdLSGlXSWtXbyt3RGRL?=
 =?utf-8?B?dFM3blZTZy9iN0VLMVZlM2lzQXNsL3A3c1BQbXk5dElRcVpwb1k1L0ZpbWk3?=
 =?utf-8?Q?/kTsH1O9gBd78DBq0Q9HADkFBS/LB0pJ3yr+voFUgSTg?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?MHdrWEszRzFYVG9CRnRTdGtHd3NjNkx3azhBT3pHdWR6YWF0VDltNzN5NlJh?=
 =?utf-8?B?bkMxMk8wS2Q3N1FoRG9aQzRZdHpMNXBkRlRFL3hmZThNN2k4YUNXWTBNZ290?=
 =?utf-8?B?TVc0SkR5WXpVdGQrcjFBbys2NnY1WTVqdURPbUpRc0JoSXdyQS9ONVpDSThm?=
 =?utf-8?B?N1VsMWZ3V3U1bDAvUU0wNjd5WlpGZWlUWEU1OU9raXR1STRYaDM4ZDdYTzV6?=
 =?utf-8?B?WHRLd1hOUnFHdFlpQUIzV3dmTGN5cUl2UkdtWE5YYjYwdjJHejdrNDVGZnlV?=
 =?utf-8?B?ajFNSDZnQUxUWjRaQ21TTWpVOUJCclFjVXk1WEJEOXFzSTFQK0RQUjhsMis4?=
 =?utf-8?B?OW5qc0RGa0crM2ptRzNaSDAwYlkxVHp4eWVrL0tsSk80ZXZWbW13eVhMYi92?=
 =?utf-8?B?UU5MSGpFVmxKUVk1S2xpam83dHRxLzlTemNXZGpObkdabkRwejVnckY3cWl0?=
 =?utf-8?B?U3Uwakhwbk5CT293RlJDNUJaaEo1WjhQcWVHWDVnNVBHNDN2b25BbTFzUFpl?=
 =?utf-8?B?dTJjQTgvY3hLMmt4SU5uRExoTnh6VVRvVTFOZGZSa1RmclBIMlJtR0paTWVB?=
 =?utf-8?B?aHlaYzBhUTgvNFF5Ri9KbERzMFpYTm80STFua2VIN215N29zcGU2VHJYekYz?=
 =?utf-8?B?RXBEWk1hSnR3Q3gxSXdwYmdSNTJ1clFUcHFIdi80T3JxWDM0eWEvMU1lblMv?=
 =?utf-8?B?ZXE4SEgzbjhVMmJiMzJIdHk3UDBNWHh5dUhEZi9wWXZxSERrU0l4ZmRRYUM4?=
 =?utf-8?B?Y3lFWnB6R0FYWUMzOUw3TElwa2RDcVlTNEFOQ3BDbkpPZkErYnowbURMVnBu?=
 =?utf-8?B?WXlUSDFxSmlqZHRZUHpoQXc4VE9hdEhzZjhnK3hNZ3BnRklMQnVUZVdoY21u?=
 =?utf-8?B?ZUMxOCs3c056ZTQzd3FSSlV6clhYTkJlOUU1OEtRenNXSWt4cENuQ09Qck1Y?=
 =?utf-8?B?ekExekh0aWlHa2xRNHMwWlZnRjJJL3k1eTdOajhubGpDMThaUG0xL3dlN0NS?=
 =?utf-8?B?VWdSQVdmL3IwbU12aHlPdTdyYUJBWjY0YkVReGR1TWR1YVlPa0p4Y0g5end3?=
 =?utf-8?B?NWlIQzFReUZUOS9iSjhDYzZKVVNIZ0wvSHJwU2h3eGR4TVRoYytpU0dPUXdn?=
 =?utf-8?B?QmMxWFNtbitRYmw0S1M2SE9GK1ZOWkJ3NGhyalh2bExOK3FQd0RTaEZLTlVG?=
 =?utf-8?B?SytwWDBFUFYyaWF5amdVOXJvQnRqUy9pYUp2aEZaVC9HQm5Pdmc1R2Q4UXZs?=
 =?utf-8?B?TEJoTVFORTFvVFFBTVNFRkdCNjdmSUx5bVRJanMrYjVGRVYweDdGQnRSM0Zs?=
 =?utf-8?B?UllMemxYSG8zRVMzM2RzeEhEQUkvNjZNMXpwcERLVGFBNklxWnZmRzVpcEl2?=
 =?utf-8?B?RXcvMEtTcHh0NnFTcUdsVHYxQWRxTUQ2cWdDeUR3T3FXVTE3OHdCcnBTYTZC?=
 =?utf-8?B?YTN1T1BhUlV1MUVmanJ6ejV0S3NQeGo5YStkMTBJTDBBcWpHUTJrMVJNbkxB?=
 =?utf-8?B?aXJnM2o5UE5acWR3blZHQ3RhdmNWQnAvaVNlU3NrQ2ladThwNGdvcGhja3Fh?=
 =?utf-8?B?L2wzbnRCNUwwOE96RXAzSWVmWE1vMEZjNnVaeWl2TkpTRlB1eTRHYzByZWND?=
 =?utf-8?B?TGdMempudFpScDRvWEpLaW10T1ZVNmdsLzNLUllWLzRZUzY3V1ZibVRLRnFz?=
 =?utf-8?B?ZVhveFFkUjZ6cmlBMi9GZXBQWEo3TlhTUlB1TGI1aEVTRmpHdzg2YUE2WWYz?=
 =?utf-8?B?UGNDc0lXalR1Y2dQRFc3Y1Y3Y2Z2TGRhUzdaWlIxVlAzdTNKMmxjd0VCZldv?=
 =?utf-8?B?U0JwTVhsMHJSNzIzTWZ5c0dBT0ZrbWNqYUlSM1QweVN4NktiV0lDam9qclUx?=
 =?utf-8?B?R2RsMElKVzlKWEM0V1lzSHg1aFdLemxyRWEyLzMzK0xXVmxVMWJIRVdNZndI?=
 =?utf-8?B?QzhOeW9Xa25ialFlelVreFFvak5tbWl1RVg3NXA0WUd2cU9XTUtFQk04TElD?=
 =?utf-8?B?YWc4Z21lM2dRMHdYbW9Wc1RNd1Y2YmVWRGo0VVIxc2tFQ2ZmSGU0MTN0NDRa?=
 =?utf-8?B?dUo3VTdETE11czBHMUhyMjVqSWUrdTBWYWlxS0IyaFVrOW8wYVo0NUlRUDNJ?=
 =?utf-8?B?c0JITnRqQTNtV1Y0Y1pNUExpVXVidmxLRkp1OVNNQVNqT2FDUmNscGJRVElL?=
 =?utf-8?B?NnU2WHlkcHpPMEVEMUVBNzRLVllqYUEyMWY3VjhpN2lSR1c3ZmxhQldZRktQ?=
 =?utf-8?B?R0ZWNGNGVmxOK2VQUUZLbE5Rblp2QUZXRkhESW9UTXVnbGY1a1FadU9mUTIy?=
 =?utf-8?B?RG9SWGQrUnNHSHFvY2UvSCtLaHFxeFJJVTZWU2V1RVpnVTBPWWV0dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a0375f-f246-4ce4-c147-08de631108b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:43:14.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYU6y+j6bfsETc430KZ1TlJcskyKXoatkEIMJFYQSABZve7kG8d1pGDo1ZtDyRivvAJ0bZumahM9voSdfadHog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11197
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:56 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2895

From: Peng Fan <peng.fan@nxp.com>

sprintf is used in this file, so include header vsprintf.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 common/cli_hush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index 7bd6943d3ed65bb24c709af0b195825a26d65f39..fb087960c9206b1e7fe4454bae53f6bc1cec1bdf 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -83,6 +83,7 @@
 #include <cli.h>
 #include <cli_hush.h>
 #include <command.h>        /* find_cmd */
+#include <vsprintf.h>
 #include <asm/global_data.h>
 #endif
 #ifndef __U_BOOT__

-- 
2.37.1


