Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6737E83F03
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:05 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14660.1770118343089790956
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:32:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=HYSSU5Dq;
 spf=pass (domain: oss.nxp.com, ip: 52.101.66.8, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHvCfm6Ri4RLrkEiumEghIS+B8Lx+LD5+wZgaUwGgHTsOUHIWNw8lfWTuk8pt0UTqGO2Ek6eH4GPq39BqXG6HrawEL3cPJYlqe4/mUGZmAOyQlWSnCII4OrJDlvUbZKyToAmkqQ7gdYyxOmWSm0xF6lHqx3nyR9MVzEdr6GoCSt0qe+sVNfmOETWhus52so+z+YFW/Bdgu3Q0tIEjcEx0+mextJIw4TVrdrMf3aaYEvzJeJURUwuebul9yljyo3us7CbPBSs2l5l8V3YgcvY2HQMfaT6JkJQX7iwhzqsYeNMBp2n6C6/lPcTgPEs9IQ3UhM/fDM//6PmKQf0YJ1MVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXIalp749cy1dt2rrod5zpIWmAn2Ztur8mGaWhxYvzc=;
 b=FN+DiR1R69Krrq5sj+/ldjrvrBYYEXmInSbCm+DVJ6OXsrYyyfU9QfmDuQWirLmQPd7fKB+0BB6vXaS27OfYEWSzU2DSDwAUMoSCwYQo3JmMCxmH4uiOJciDk5B2I6ynn3IqFBJ151FaZt5MLwOrocXJA83AZkDX9ZVpr/vwOt7LNJak2lfm2UBvHpqmhN1apXjgj1K/eTVIE1ehGajlaIcSdZEMhJbgYTGjFd9LmcDAnp9WHBwELtUeno6RcTsH2FHSKnUsyiWs30d9ijQaG1jEgz2YHw0V9L2qCI9K1lJYPpqubt9ByZdXKySIrv3IzGMHjThXgbu3Rmm5K8DIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXIalp749cy1dt2rrod5zpIWmAn2Ztur8mGaWhxYvzc=;
 b=HYSSU5Dq3uxgDnKP09b/OnGFCRVXN34NglD4xBI6ueGOCmtS5aqDmZIso72jCGrSDFNDjvSec4f6ELfTKSX5IcH3m52aU818mxymQculmxV3Tj1FVz0R1TdiNxSouR8F6EA/QQS3YU82cVJcWtfVrAQyV2+Rc8r4NJPoFVS0bqxewHme4Pq6u5F/b/EM7M+d61LqPjmIcjfgMt1ytp6Ly/M3o4p3WWXb9ePga5zpOtbkO1ai6S1qAbZKjgLKQ982lrdCQ1QoE1ftSmkHlGLSNW0URUFKMlHWEuYKv9rb/Ln17Mfd6op5ZxaxFWnwlaOJH/GUv4Lvpz/iSPESVq1JBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 11:32:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:32:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:05 +0800
Subject: [PATCH RESEND 01/14] beacon: imx8mm/n: Drop useless files
Message-Id: <20260203-cleanup-v1-1-732e986039cd@nxp.com>
References: <20260203-cleanup-v1-0-732e986039cd@nxp.com>
In-Reply-To: <20260203-cleanup-v1-0-732e986039cd@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Christoph Stoidner <c.stoidner@phytec.de>, kernel@puri.sm, 
 Sam Day <me@samcday.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, uboot-snps-arc@synopsys.com, 
 u-boot-amlogic@groups.io, u-boot@dh-electronics.com, 
 upstream@lists.phytec.de, u-boot-qcom@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com
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
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aba120a-e4ef-493a-e529-08de6317df75
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?SmRvUEp2L2phd2Evd3RnNTg0dytKWi9hQ3YveENWTVJIL2p3aC9hR0xTUlRv?=
 =?utf-8?B?Wks3QkFHY3BqRkRpQ2Y1NEdtM2hlOThOREJFL0FaNXRrYWVVNUhJTDFIWWFu?=
 =?utf-8?B?YktwSHQ5QmRPMVBVaXFuZHhqMFpnRi9wYjFGYWxPdjFvSFNwQ3NUWHArMGxU?=
 =?utf-8?B?SjJINSticTZiZE8ySGtzSCtwYjFMdmhvVjNqa1ZkejNYY01sRC9IRGRRUWNn?=
 =?utf-8?B?WHFwaDQ2TC9sSjdtc2JGYmhzR3JVamtYWm1tV3ovK0lVbFZvL0UyRVF3Q2g5?=
 =?utf-8?B?d21ac2FWSk5wV2tuMDdIUWJQb3VkN3E3Z01mZVhHRVZmc3h3QnUvZWRVRldL?=
 =?utf-8?B?MmJHK1hVeW1IdllybDBxTnBmbHFNamZ3TjVtTnk2TWhScFZocitoR3U1RGVP?=
 =?utf-8?B?ZGdRS1V4clc5NEt1SXpoZG1NRWVkY0ptR1gzVUkwQ2ZGb1IzMGRFMGhlc3hT?=
 =?utf-8?B?U29mMnNCT3Z2a2VORlh2K0ZtZFpYVi85eFEvdDhFTFV4WTRpWlFFRjFxWEpx?=
 =?utf-8?B?bmVyQ3J2MmRWTExiUnl3SU1ZQlJDOTJTb0pPUHkzeUJuSmNaemk0UjRXaGxE?=
 =?utf-8?B?QVBqcTJkdkhDWVlCWjE4RTF2Q3N1SFpLelpycW9iMXVmVSt1RkJXY2ovdHRm?=
 =?utf-8?B?YUpId2tZVmM1RG4yeGtJek1NQmMrbHpBbldSa1crcSttbnIrdXBmblhmMGdm?=
 =?utf-8?B?b2VsMDlaYzR2N1JQMzhTUXV0Z2pHdXh6d0pCUjRRUXlvRWpjZWxUVTdud2Qz?=
 =?utf-8?B?NFBMRGMyUWNMTjZsU0JQMHJ5bzk0Z201Z2hjdmlqaUkvZE1ZY2VHSzBBdUI5?=
 =?utf-8?B?M3VOd0tUSzl0ZjBaL3E4WW5VODlLQjNpZ1dNaUluN2QzMmRZSUVQcUJPYzk1?=
 =?utf-8?B?VzZRcmcwRVZYRm9vaVpZcWNiZ2U1ZXJ4NWpBdGdROVNxTXBaLzV1OGJSb1BC?=
 =?utf-8?B?dUNrMmVjNnU5dzJBZ2szWjJiRUVvakt4aGN2VFhBbzJqQ3RuQ3BITlRZZFFk?=
 =?utf-8?B?UEV0TDEyeitxb2VGWktKSS9RcFRlVnRNZS9CdjROMVRLaXNLNXo5UGhUTjBT?=
 =?utf-8?B?dGxoRVRtZ0twMXJuZlF3K2NoV0lkUWhEdFBkQ01neVpPcGNUZ0lZajAvRS9Y?=
 =?utf-8?B?RmVwUHBkRjk2SUZCYnFkaGtyRjJ5bFVyZ0dnQTNnUmRUYnhLU3g2SmdrMHp6?=
 =?utf-8?B?SHlkWnI5ZHczbmpzQi9HclFHNjE5Wm5vUUExVGthZUJsb2paQ0pzYURqMHFJ?=
 =?utf-8?B?M3NJN2xkM2dNTXhnVFVKZ0oxWXdTbkhXb09KbWQ1NW1xb29ML3lnWnV1dWpG?=
 =?utf-8?B?V1R5OE16emtYYkV0MkE5RVhYZkZFRnBIOGttWE9GUmg2ZDBIK3F2aUtZa3Ez?=
 =?utf-8?B?WXRveFFCMk1GWENSTW9CWnpFdlNaQWRZSHFITGVjYWw5ZkQ1RHNFejdqTWE4?=
 =?utf-8?B?djJZdnNNOXI0T1FnUEVQYU01THY4VDBqb3pRM0dBeW1IK294YzFnaENkUFhu?=
 =?utf-8?B?K1hoN2o2d1g5L2VScmdld3hFenlwQnlRUitqQVJya2ZQSGROQUwvQStMdXkr?=
 =?utf-8?B?dXhHQzBnZk5OM1ZWRUVoV3RSMUtxVlFiYTNnLzk0dmZoNnA0cWJwV0ZOZzlU?=
 =?utf-8?B?ZU5LZzZJcUl0bWMxSzc1aGpWbVgwUC9pd0FGeHAvYUIwOHd1cis5bGhBaHFq?=
 =?utf-8?B?VnJNbklSOE0wWFhreHpOS3hMckk3U2hmQjdmRjZzcldwSmQ5VlptTkFKRStp?=
 =?utf-8?B?dDBlTU1ObHlUYk45N1RaNEhLNTlNZE5mcUhUREtlaVBYeHB4L003ZmNVejdW?=
 =?utf-8?B?ZnFqSW1QQXVyVUhFUkZIbE9YcXNrN1ZLQ0ZjckJhMXhJMVhaamFiUWMzUGFB?=
 =?utf-8?B?cHlJZThNSExZc1N1Sk5EYWNDVlFEaHNGYjRkeC8xTnNMUTE3THBHVTB2YmNi?=
 =?utf-8?B?bmdTazQwNjJMbVBJdzVtSEgrNG8xTXpPbmRZMC94aXc2NHN0R0Z1U0FJUHFN?=
 =?utf-8?B?b2g3cUUzWkJSaFc4TG02SjEzeDVTeHg5dG5KcTJNNzEwZU01cGJZTGZJS2VF?=
 =?utf-8?B?Nml3SFFSN2dUc3VpR3ZxcUhzc0pPaW5NMmQxRnhEdnRpWkkxWEt5YWlXYlkv?=
 =?utf-8?B?WUg3Q0h4cTZJR3dqRlkyeTBSdXFRalZLaHZ0MWJnVkJhQjVJY1hUbS84U3gx?=
 =?utf-8?Q?/vTWpLACpb3lN+DM2R91AghHMNZ7ZKTtNC5HfND71Q+l?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?RGV2MHF3cHQySEpCQmRIcnBsbE5xVExPSFFXYVV5c3dzVHVrQ2lRSkp3aTZt?=
 =?utf-8?B?aDB6blRyTEJIeTBlZVlaUUo2SFVYdTlLc3hKR1JqUnJITlMrT1dSQTcxT1RB?=
 =?utf-8?B?aTQ4eDdNSllSTkJXZ2FybDB4b2laSkpqbGFSV3JSaVpPbUhGZHpodm5zRG9u?=
 =?utf-8?B?VnZyQjhaVmQvN0ZZbG9kVmFqcVhhSnpwQTlKR29XdXlqZTQvc2FubWxtdW9l?=
 =?utf-8?B?QUhWMGZoUmIxMW5UOVBWTE1pbTBVRlhUUUpsSDRoOFNXUXVnY1M1NldVSmpH?=
 =?utf-8?B?YmhIalNUenBzRTk0RFBBMHJHQnVOYzhPVXp2Tkt3aXp0bGZyWldBcXMyQ2Z2?=
 =?utf-8?B?YkxDQ3MrWmJSZ21OUC94VG5WcG01ak5lTllTa09jT2gxOEpnWHdNZ2l5b0gw?=
 =?utf-8?B?M2lxVjZRdlZZV2hubUxSWXcyMC8vMDZjUnVWTDJxaFBraEJBaWF2ZUdjWEJH?=
 =?utf-8?B?Vk1zV3FJSlV0dDBvVkN5cysrY1pjbkRQaXZsU0NWNFZRZFFGK09LMDNKSmhU?=
 =?utf-8?B?ZGZYTVdhbW5hcDM5VHlEYUJaUDh1U2lWeEIrVEcvVjc3VVpVUHg5RjB1SkU5?=
 =?utf-8?B?QnBaRjdtZ084REdXRE5KSXYwaENDWk9DdDQ4VUpCWG12RjFrY2VqcWZDaWth?=
 =?utf-8?B?MnRPTCs2cXpudEJrOXhMRVYra0svYmVpTHJ5YnBZbVBZNnpiTy9UWVEwZ2tN?=
 =?utf-8?B?bUtyRTl5cGVUdjhGci9CQUVleUJtSHh2eGswaE4wWlhhaHYrQXIwSnQvdEZ2?=
 =?utf-8?B?R2QyaWJRQ3owbzVWOC9JVm9DWUxZSnh5YU40elNNeE1IOTdhdXMxc0tjN1lj?=
 =?utf-8?B?ci9HMHhUOTVKZG5tbVBNOURnTEFEMUhJSGRLZ1NCOUpSUGlNWXc5U1RCTmM4?=
 =?utf-8?B?T25pb3JWRDY1RGVYYlJOK2U0dFBSUG9ScER1TlkzNmJDVWpQU3BWempPT1hN?=
 =?utf-8?B?NDRQbVBDOGZJNVB3RE9hTWNPV1p0cEYvbnRXb1MxM1VRbGVrRHMvU0xqOG5X?=
 =?utf-8?B?cTZlK2hBWGp3K2lCL2p5NlNnTnREa1NrS0NPdm81dmJ0emw1WDVEdmdTNFJP?=
 =?utf-8?B?Q0NCTE9VSk8wS0NWTTZnZ1lBNVRTbS8rKzhMNEMzd282M2F6YlhzM0V0WVds?=
 =?utf-8?B?NUFQSEovRjkrUGFWaFY0ZnN6R0NjRHJYR1hsRXNubG1IKzE5QitwTTJoMDhr?=
 =?utf-8?B?VXhmSFFMSnd5cVhHQmt3OUlBcStyMVRUcFYzR2tpVDMrSWZiaE1jTXVUZ0wv?=
 =?utf-8?B?U3VOZHZ3UGhhTE5sR0hUanBSZmJtZWRxSHd1RzZMK3F2NDR6OGxYR0poN3lw?=
 =?utf-8?B?NW44SXBUTmpORVJ2RGhoMkpjbUlUZ2tEd04wTVRIYWlweXc4azl4N1BRaGZC?=
 =?utf-8?B?K0ttNFNTczFCREVqeWI5SUU3bVhacUx2NWpTNktNOGlBb0NmQUMxaFkyV09W?=
 =?utf-8?B?dmhBVzhzZ2pTOGMzdFY4bis2SFp3WDBPQWZUdENoMVMzNGswS1NXaUZhb1F3?=
 =?utf-8?B?M0xpd1NzTnJDMWZnOFFxazIzYjE2ZVZZaWZFNVZ2aWdyT0tabURENGR2VU5z?=
 =?utf-8?B?WFBsUDBObGFKUEFXTnpiMm12QmNFTnZRWUJIUXo3cUFXdE9reUtRZFZjVk1X?=
 =?utf-8?B?aEdYYVVqNFNCZVlFWHptZ2YwREdKS1ZSQ3NVRW9LQzE0VW44U05MWForS0Qz?=
 =?utf-8?B?WVVjZjVoUW9tOG5lM21XRE90RFloeFZzVVBhL003YU9tVmp2cGdJTDlINmRI?=
 =?utf-8?B?anhvL0tJMC8yTVdoTmJvYzNyMm9IRVl5ZDFpdUQwc3ZyWldXMUZwNldwZFdh?=
 =?utf-8?B?ZjVJNEwwOHphUk9oWWFiRnAxc01NTVRuc29ndTJCOWVWME9OZ2FpaDFDcVEr?=
 =?utf-8?B?aitCY09idTgyU1R5Z285WS9OVDJFckl2RkMwZ0FvWHdwblVNT2xUa3NOYXdL?=
 =?utf-8?B?NXVTa3hOSDI0czd6ZXUxRytZUDZIelE2RS9YYmJhWTRaSkxWVUxGUjEyaURX?=
 =?utf-8?B?UTlyZW5oRzltejNLOHhHamZTb3puS2ttQldtMlI0MWl4MmhCZVdqajU5cFhS?=
 =?utf-8?B?Vk1lTFpBTG9BSmR1U0F6RkE5bzBxKytDVDJ2cVZiWE42N0ZZdGpDanQ0bFB3?=
 =?utf-8?B?SUFFSzRITXZ0eWJxazZXWHRsNGtnT0dRNUVMNzArN1ZSV3ZoNTgxQ3N0dHFa?=
 =?utf-8?B?Y0M2UnJLNG9zeUJKU2V6cml1QnBVUFR0NWYrdzlyLzg5YWx1S04vNTJXN0s5?=
 =?utf-8?B?NnR1bVI0Z1UxZ1Bjb0dGbWJFWTV6QlJOWEFYYURYNWQzU1V1ZVAzUitydkhV?=
 =?utf-8?B?WlFuNUthRlV4aXo3KzY1c3FCN2pRM01Pc2pJRGtVTUI0RkZyU0ZmQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aba120a-e4ef-493a-e529-08de6317df75
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:32:12.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Cj5gDxiW7mplaZHi9X+e85V2yyxvsnhLul5YIrwf4yGjKeRUm8jAnjiNGnL+EhNediATDR+iua8x/n1c8H1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2900

From: Peng Fan <peng.fan@nxp.com>

No functions except reserving gd in the board files. The files are
useless, remove them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/beacon/imx8mm/Makefile        | 1 -
 board/beacon/imx8mm/imx8mm_beacon.c | 8 --------
 board/beacon/imx8mn/Makefile        | 1 -
 board/beacon/imx8mn/imx8mn_beacon.c | 8 --------
 4 files changed, 18 deletions(-)

diff --git a/board/beacon/imx8mm/Makefile b/board/beacon/imx8mm/Makefile
index 8484b85ae1268b2699e442975a4e476ed31f2283..eb762504266de80bad014dba0868c231f63c9ba1 100644
--- a/board/beacon/imx8mm/Makefile
+++ b/board/beacon/imx8mm/Makefile
@@ -4,7 +4,6 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-obj-y += imx8mm_beacon.o
 obj-y += ../../nxp/common/
 
 ifdef CONFIG_XPL_BUILD
diff --git a/board/beacon/imx8mm/imx8mm_beacon.c b/board/beacon/imx8mm/imx8mm_beacon.c
deleted file mode 100644
index 6459a99cb9d72a00316ccba63daf8414551bdfca..0000000000000000000000000000000000000000
--- a/board/beacon/imx8mm/imx8mm_beacon.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2022 Logic PD, Inc. dba Beacon EmbeddedWorks
- */
-
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/beacon/imx8mn/Makefile b/board/beacon/imx8mn/Makefile
index 54735792b9340aba0cd02a53fe2be22e5bda498e..e8fe9f1822e802a9889d3b93291d911f2e555e5f 100644
--- a/board/beacon/imx8mn/Makefile
+++ b/board/beacon/imx8mn/Makefile
@@ -4,7 +4,6 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-obj-y += imx8mn_beacon.o
 obj-y += ../../nxp/common/
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
diff --git a/board/beacon/imx8mn/imx8mn_beacon.c b/board/beacon/imx8mn/imx8mn_beacon.c
deleted file mode 100644
index 6459a99cb9d72a00316ccba63daf8414551bdfca..0000000000000000000000000000000000000000
--- a/board/beacon/imx8mn/imx8mn_beacon.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2022 Logic PD, Inc. dba Beacon EmbeddedWorks
- */
-
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;

-- 
2.37.1


