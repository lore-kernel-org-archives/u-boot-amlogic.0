Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323BE8307C
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14614.1770118566448807958
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:36:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=IP7EikkP;
 spf=pass (domain: oss.nxp.com, ip: 52.101.72.1, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClCWMXwQ7837an3Qnh5NcJ72JJ9IPey80u8//ddZQ69G+uTw5NalASbSjPZH2ZoOF6Cz6cE1QEufgz9ZLrOJ77bb1/1lgvecE27aLLuyu2GgINMf30mbhsYorygpACGbHXJwWYw+lDvj+1qDI/4JKXwLws8gN5b6NEYhRtudLAU/4rfhydMaWW3hAu2mKuL79qOWnuxZKYsaTo9K2FvRLBuHLTiXefCj7YRGT+U4NXKUM0QrrwJYNPy8UlUZJ1urzRuMTEi9SCjiz2ghu4ByyMIrY3NRZ32TVGVEvUZwhgtY7Sjh8E+3wlsFtl3E0Fu1ttuLlP8MMOVswhVK8n3tFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VssyrbsKhy/hzCHFhqpCm15ufXmqdTZQ6a9TAby6Zcs=;
 b=VrEWF0X7d/PEwmVdwvjIH9z/hW1M/ZZQ8zHvDk5a0ygoOCzbhRfdctKW3ujKP+JZviIh212c+lc9qRk0gYOQpwpfOMETtDefCuPG+P5gn5hKyqwjsdo7YorQ/Dwuy+pgqEgnIfmddUvMMRQjcgRhfeIFLOR7gwWJuFW66VumTL6iGFVZTXu4XbcTiHelQdNN9LXSpcNA3oDTWHiuj13J1DOosWnb7W9H/FJkHiG+PDLBYU/zz10EdW04dE9GCmNzevHSh87vjUgS/Y0Ic669WCQZAz85F3ACNus+eQJKBoJ8vbrDBvBN88N/MbXnUDOp4D/qmgVXE9ZAk9Mdom75Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VssyrbsKhy/hzCHFhqpCm15ufXmqdTZQ6a9TAby6Zcs=;
 b=IP7EikkP0DPdSw+XWCKLQoEvd+SbL8PsgZ71DtvT44gLG9CWsNMoEA+rRdhqUaGYnZNbwvd3xhN4Jp8qoPc+V8czDCtIFwtHggrS5tQXhirFvsIW5vJvCZaTxqX95wbVPksOiv1aHpapBHKfJ2n11AQm8qS/YDvnUVfsnQF5csXcWXAbpOMrgkcYLEMdgzg31bgtXEGtsP0dKkApssg8wcRiUPQN5LwpOdzhEMcGXu4/17q4qFQfouaFJka25WAqSbBjotgxEE5ss6LoeC4mjwHDyXvBKyABaOaPZBZwlIyd9FlryuyeznR0b+qRudvBrUtGxh3f0Wtl2NOe0X1caQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10749.eurprd04.prod.outlook.com (2603:10a6:150:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:35:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:35:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:10 +0800
Subject: [PATCH RESEND 06/14] xtensa: relocate: Add missing headers
Message-Id: <20260203-cleanup-v1-6-732e986039cd@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10749:EE_
X-MS-Office365-Filtering-Correlation-Id: 79396eba-cd1e-455e-ba3e-08de63186483
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?VjBvYXpoeDI5bTRYeDB5bEc0bE4wRDhITWNza1ljeENiOXA2LzZRenYrYllU?=
 =?utf-8?B?bWMzTCtUdVM5VUM1Y3JnMjBBK3o4RGl3bGNyU2c4S01NVUQxRHBVa2Q2OFJV?=
 =?utf-8?B?eEtGWmNCSkJ3aERGNVBiQmJ5ZEdBa1lEU1FFM2tZNzl0TWw4eDFPcnhDZFYv?=
 =?utf-8?B?aTdsUGdsa2tyTWFQY3VOSmxWTG5sNVRDRHFEMUJya3VOdEQ4MWZUV3BzeVNj?=
 =?utf-8?B?a3ZiMElIU3F3Y0w4dXJjVktLS2FkWURxNENpYlRnMG1ORmI3b294ZDVSYWo3?=
 =?utf-8?B?UUI1OEhPaHR4dktyZU5MQnpRL2FNQlRyV1NGbXVWOU9XS1cvcFNDQm5ETDlP?=
 =?utf-8?B?YlJJeUVTcVIzZEtoQ0cyTlRPeEdCZU1SblBXdjY1Z3hCYW5yRDRhRUI1RFB4?=
 =?utf-8?B?ejBrKzRVdkFSRWhqS0dscmhZdFBiOWxxVkR3L1BpMkVoOWUydTVGdm16WC85?=
 =?utf-8?B?NzNRMEtyUXhkOWNxMGQveTNEUG5CUFIrL0tLaUlBWUlTYzR1OWdwMENJek9S?=
 =?utf-8?B?dEZEeDBYajVCWHpvVER6QU1KZ0gvM2owaFd3K0orTTRjZTU2TVNwcUhDWWNT?=
 =?utf-8?B?aWRiMC9hKzNhM2F2K2RzdnBQbTBNK3ArU2RYdDh5ZlR3cUFNUkk2SEZOakQ1?=
 =?utf-8?B?enVCc0lBaFlqbkptMjJXdDJicmVBT0JmRzQwWEI3VWpQZGFqaVhaTTFUZG1P?=
 =?utf-8?B?QjFOZHRsSTJYZFVid1o0RHN4UU43QlA1UldhbFdaVGZLbnJVRUNMZmowaG9Y?=
 =?utf-8?B?Z3I1NHlMazArbFo2YThRQ2lNV0VGY2E2aWgwKzhINXBidEZ2M1VXZWNNc014?=
 =?utf-8?B?Z2NTSVBCMzh5N0FnNUVORW9wYXg0OXNqb2x5Ym5RYStTWnhrQmx6M0hkQXFG?=
 =?utf-8?B?eExRS3k1ZUh5cVFZbUNTUTJmTWV4L0x6VmRsdGh1c0Nxc3VJZHloWmFYVHd5?=
 =?utf-8?B?ZzJWVlJsbHZBV0U5SEtFWkdUQW5hYnhIWER1elJaN2l1Nlh3QjAxc212Q0lL?=
 =?utf-8?B?TmtES2IrYXE2eks3TVFDMUFJUXd0U0ZVSjlsN2JNeVRBcjV1RUpKdVNmcGZj?=
 =?utf-8?B?clovc01McHB0TkJscHBNZWRMYm56clVVS0xjL0VuSWlzNWFoOEdnMVBQSXdG?=
 =?utf-8?B?WFpyZ1N3bXB1SCtURjZBclRLV2xhOTlJUXBwZ0RrZitKOUF1ZUpPWlZNeGh2?=
 =?utf-8?B?SmlPMHVrTHR2K2lOTVVJV3J5WG81RGd3OENqNFVIVkUrcG1tVFcvaWlVWTBx?=
 =?utf-8?B?Ni9lMGFIaXlqb2l6dEJWZzc0Q0kzUmI2bTdQUU9Yd3JFZXY4UlhHdWovWDFp?=
 =?utf-8?B?YWcrNVc2K1lSdnRpUFk2VGFmeEYwd3VtSzlVTzV2RzdyUlN1aGkwaG5YMDdD?=
 =?utf-8?B?ZGh5RUx3VHg3QkJUV3EzWlJKSWVYNUNWdXpkQ1l2WW1nM0plc2pZd2JxNVpL?=
 =?utf-8?B?L0FkbkM4MWJ4T1pXRzJYSjNEM3FMdTRiTXQrSDY4OU4yRzE1WXdxQWRXbmZO?=
 =?utf-8?B?R2U3MWxWbU1VbkFFdDh3em1HaE9PampOMThCdmxGWktjQjhoQWxWYVZ2UC9C?=
 =?utf-8?B?WVJhemtnb3FOeEYzYVczdXlVYzhrNStNSU9HeFpLZ2JMSm1iRDJTLzYrMUZl?=
 =?utf-8?B?UldoYVU1eDdSOHM4RHVUYitsTTJwSGR4aFM0UnFGcFFHVHlzQlhlWnZpS0R2?=
 =?utf-8?B?eGN1RE9haDA4c3p4b2NGeFZFTXZ3ZjRBR1FEelMyakhBak1KcFk4R3B4QTVr?=
 =?utf-8?B?VXhJRmNPajAxSmR2a1Z4NDkvKzZQQnVaakc2MzA0Nmh3RnkrNXVSUExMenNE?=
 =?utf-8?B?K0QraFU2MGk5TC9reGhkcVltRmtNNEpIT3VxOHUzR2krV0EzandWSlJJVEdN?=
 =?utf-8?B?NnhEK1A5azJYb1N6QkpLY3JhdSsxeWFhUm9kKzZ1anlZanlnMlRZRDZIdkVY?=
 =?utf-8?B?Nzk1cS9ZZ09NMjVlTVJqbi93cC9mR0hFZEhURk1wWGNHQlArWEE5VFI1ckh5?=
 =?utf-8?B?NkM0R1hGY25EbVM3dDVYeFRPc00xdFV0QklKRnovbW5vVHh6YlJpajBYTkJ2?=
 =?utf-8?B?cXZjMUloYzdWKzBSLzdnQzhLc2NwMUhSMFlyL2hsYkRBVFlPa2pNSU00dmNK?=
 =?utf-8?B?eWltR0dycmpJZGhiV0VLT3dpNGhZMlE0MW1GTmNUdStRZ1NUMzlMQVVhN3FK?=
 =?utf-8?Q?tiqLjwH/b/AkkCAbrRVi10niTQW9JZIeO/N/gHx0h6OF?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?THRlc2dlTWdVUW91Y0lNejVoN2hnZzFPejdBaTZHZDgvdFIzNGxBc2xHc01N?=
 =?utf-8?B?RlBldTJvOEVtMndFTEhXR21LVVlHdmg2WXZ4c3hNV3dmZmFMU3dBTXdPWmhl?=
 =?utf-8?B?NmwvNFh6alFESXc0VGRtdytwOXlPNnJhL1FYU3FMWnZlSVpLYXhUeUloMUN4?=
 =?utf-8?B?SkV4TUIvaWhUbjdjUFVBNnRoMGxDdFZFY0l2Z3lIZ0dmdFZoMmVYTTJUck90?=
 =?utf-8?B?MVpURm8wQS9HU3VtdlpPMkxEMHprVjkyWnhJNWQ4QTN1b1g1WXpNVVpLNWxz?=
 =?utf-8?B?ZnZENy96T3Myckx2bDZYZ0pwQUR3S0VKMjRPMWsvSjFTMlhEdmVZdHE3NE1M?=
 =?utf-8?B?dUU0WXhBTXZzRC9OaWtzdWVpWXJPZmV2VFZ1YzVQU2lYMG82WnVKSEZRcHZm?=
 =?utf-8?B?QVN5R1A4a3pZSlNWN2NYbkpWUHNSZ2Jqa1hTVDM1S1o5eGVyK2lmUU96R01t?=
 =?utf-8?B?UW4yR3V3OWl5SlpCTHN2MndmVUw5NFZGdGlJK1I3Y20xMUd6L1RCYkxoUldK?=
 =?utf-8?B?S1ZJem8xclFrbVNZSjc2ajNJOExhaTgwRnRwN0xiclVYcDZmQ1h0NEhlcEVT?=
 =?utf-8?B?aU10WGJ2UlpOQnA4c1hoL0tERGpNTGtXYkdqb2syNXE3eFJuL3JWeEQ5blNQ?=
 =?utf-8?B?ZVVlYitPT0dIcEp5S0h3eFNLaXFBZUw0NnplL1JvSCt6LzdYNlRWUkJKM0cv?=
 =?utf-8?B?WFJVbkZMcSsvbCtKTEpHd01UeTBkemRFaGlsam54dlM4c1dLcGpvVk1CckVN?=
 =?utf-8?B?ZmdYUGc2WXZaWmdiNzZDK3VDR2MwM3c1cWczM1R3SDR5WldUM1dxWkRHdUho?=
 =?utf-8?B?SDZ1K2lKRHdtellQVUpUZVJqR21obFc0SEE5YW12enkycTExa0NEcFJCK24w?=
 =?utf-8?B?Y21ra0tkY3RhV3ZzckZzR1l1N3Q2NUN2a0FPVkpmUWhnTzBadXozdlNSelNw?=
 =?utf-8?B?NUZkSFRoTlJLUExNWXNsZHQrUERGZDJONmFpSjNhbGVtczZrYUV3bnVrdFo4?=
 =?utf-8?B?VzNvYU96K3o3WDRtTGNuVVp1dUMrcjdGTGIyejBEc0xrSjBQTGJ4Ym1hK0JC?=
 =?utf-8?B?dHdRRklZdUc5RXJFakljNzdUOVNEMGFBdG5MZG5nS0ZXYTV4UFZhNFZwekhj?=
 =?utf-8?B?TGZxK3hUMnlFd09tU25mNXN3SVFNRjdOU0xWd3prNmRyUm1KZ0JReHFTZnFT?=
 =?utf-8?B?OWdCZDg0TklYczhxTWJwOFJBaUhSOEFZN3RCdjZRQW00SjJFYmNZMHZwQ0Iz?=
 =?utf-8?B?MTNTaVVoRy9JWEVXc2R2V0QyVGR2SGF6b1ExRXJpRVdkTTQxN3Vlb0wwTGl0?=
 =?utf-8?B?Z283V25uaEEzbTlmR2pINlp0UVFoLzVhTC9ML1VzZkp5aVRwQUZmaU1NUDFE?=
 =?utf-8?B?cE5RK0R3eGNVb005MDJaWk1tNFlxL3RLOFNUaDE5dHJ6RDN0d1ZWTDc3Mkg5?=
 =?utf-8?B?U2Z6RDhCb1VoUmc4OTZOU1VMT1U5Q1hld0czV1gxRjVjMFZDSFE0Kyt3ellH?=
 =?utf-8?B?NEV2amJDemRHNm9kajhVZHZ0WkJXVmhoNHBRTW9XYzNSZ0hvY3BqSURZckd3?=
 =?utf-8?B?RmhrclR0TmxBVnJGMHdaYi9zaTdSOWxpaTI0bHUxeTJXZzhiWTFhVXUvNDZD?=
 =?utf-8?B?UFRkRHB0bng5c2pIMC83cHQyK1poc1g4cWlnc0tBMHI0R0Y4K004LzQzV3Qy?=
 =?utf-8?B?S0lwb1JhZ05QTmVibXRoc210QVpQNUZ5eitlczhzZVlZZTYvMHlFOEJQVExV?=
 =?utf-8?B?US9SR08xa2UvTU10ZW9HNlNtdjZBdG5XV0dRNjVobldOUjR1UWVFeWVVdURs?=
 =?utf-8?B?c1NxeXQ0SmxOVkE5czFqTHVXSDI5ZkxhQU55VGhGYk9jZjdlUlVlNHdsSXhv?=
 =?utf-8?B?V3YyMG1lS3hNZnRvS3RUTHF3a2FDK3A2Qm1SbWc0WkdzVnI2ZWRsRTBLNkFj?=
 =?utf-8?B?VnJYSU1qUWRnY1pvMHFKRksrekZzaHZoVGk0NDVRMCtxakVUb2VBM2cxcUFP?=
 =?utf-8?B?UVN4djl4S0NiZzM5dVp5cThlY29DK3lPMC9RV1gxbWp5SjFBRTJkaG1UVzht?=
 =?utf-8?B?ZWJnTHJOcDBVVm5RWFlxdWxCcmJEcmpJSWRON1VqTVk3KzBRUzJPMmhvSmJU?=
 =?utf-8?B?czh1MkJxdUlNcENWaVNXVnlFRlZIOGNsOHVHUmljU1RTRFFuUTIzUmxkQ3Rz?=
 =?utf-8?B?TGV1L3pHSFhWZnhDRjRxc3FQbW5USEVHMnZ0c283dXJ5UG5NemhZOVdzWG1k?=
 =?utf-8?B?cGFLM0dTL3A2aFVyN285S0x0K3dUbFQzVUlGRXAxTnkxTlptOFNlWlErOTZC?=
 =?utf-8?B?OVFuMU5UT1dURzZwMExiS2xqeGJ3d09oSWxwK3h6SzFyTEFrVlB3UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79396eba-cd1e-455e-ba3e-08de63186483
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:35:55.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzupwCTemxkaDQsEfs/YBDiKKpmbzbAmPewu+1ubpdQZEKkTSs5i4HflE8DINiipB0i3go1IOCn7fDV5yjfhiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10749
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2909

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


