Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F7EE87845
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14741.1770118739743598253
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:39:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=pZod12ho;
 spf=pass (domain: oss.nxp.com, ip: 52.101.84.24, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTSokPV6BfEMP4W3zdPJy512EMtWGadlwg+w/8OU8wxII/aNePATE77cOo4mRyvD5zR4/J2BASBRO17nvciiJv5xGDqrq/i9aWOXT24t1DacSi9ViddVxPY8xwdgoBX2YH+h6dpfizZnKFKJXgyd+OPdwLMOwdhgkvfUKMC/fFlTTlfIxrRrHOVAfpO+DqYJpm8MAP+tAOF1v/a02DaxfAebvGA16xvCctYJQeUQ3M9aewHMB+QEFEGtP+jL1pxzt2OsRPowFMt6/ARmm267fhxTn15LMPNsHuy2bJVXfIc1nxLQJqt4nJ1KK2nLBRGKqnRIbO8FMyaxPWx6yHCe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSABK4mrFlRETHt7Ep9E6IaJWCfL36Ko+hKrDtSdzMg=;
 b=inLHcwrJHkHG6NaiIg4Bi70o4tWtAoZ6MfeoaPPfux8bYiHSxGc3ifvKRCialiAkbJUwSUvD8db2aidKf87iDpSsTfhyPvXN4m+SB5ChaElLxw/BsxSWpag5JTLjl/nBE9upF7WsF7UQBXy7vw0KgnpJIa0N168etGYzowFxjIzpRtFMuT+zlE4kZ2LaISouoi2O9vpsN8BPQoXYb80IWo/fzzXcedZ92xzN2Rt134IC4+vY28fJGU+OSDqjIp6M396QiTpa/0nWqSeC8CquqOUh0rpPQj7akPh5F0pEKmvfhC7oYZdy5K1dG9+J0rC9bNT9+2yH+iTPWGxdF3A0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSABK4mrFlRETHt7Ep9E6IaJWCfL36Ko+hKrDtSdzMg=;
 b=pZod12hoHhXKttUUcrBJYiPBs87HC7khKOq708GEZw5+naxcuGD1KNUdcBBajTBVmSmtXOVgLiTILpeVs3rXBHsl0Awdpk1XaA33wFcYRgeIM3Z6cCNKePnrM/k2K3pHqACztoUTelXriDuFKqFFIIwMOGl7ojL/15qdGa2FVWLMjdr5Oyqb7yGO5Wg5OULbh7qY0s2bQoTXnCqwLTCg7H9p9pAZSR/NqMNH+wU08diWh2Qi9KwluxEY98c99LzVMAjAAsMnIG9M+2TMb6rEozG/J0VWgjM9NkqRwqJmWM4PSivGfEr7bnMY/YeW2pSFbQDIfXcpkHrANkngXTqyOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8055.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 11:38:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:38:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:14 +0800
Subject: [PATCH RESEND 10/14] nxp: emc2305: Cleanup headers
Message-Id: <20260203-cleanup-v1-10-732e986039cd@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d3ef0e-adc1-4b4e-d868-08de6318ce6a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?WTM3d0t1eHFWR0FObG1YMWpWM3RvUHV3blhmZDhTTGMxOXlsSHd2UGpDcXQ0?=
 =?utf-8?B?UEszLytYenlJTlJzM0hnMTJLd2J1TjFGN0MvK240M2s4QzR6bXN1WjVlK2dm?=
 =?utf-8?B?VHMxeElkUmVReHdWemRPZkllNFUvdXltZld2Y3BVS2d4ZjUvYjZJTDlRSldZ?=
 =?utf-8?B?UThFcFVlSGk4SnlqNWo2b3ZKbkp1a2FMZ0RKaVo4UzROSVV4clpxMkJiUjZq?=
 =?utf-8?B?SkdUdG91ZU0vYWd2dUxHalMweTNwOWI4MmRnVk1SZmVkVHN0NmdPekdsMW9F?=
 =?utf-8?B?Vng3clhha2V5WU01Uitic3BSTFVNYUFCbEdiY05MNTdaT05qYjZkc2pBQzNl?=
 =?utf-8?B?enNCUU16c3NGKy8rSnprYmlkUTRKNkpsRFVnS0p5dXNQbTk0aUJ1Wll1Mjk5?=
 =?utf-8?B?aWU3S05vNGxTYldzWjRiRUtpQ1RBbHZrSnZEeGpDdlVvVzF2Z3FzbmhmS1VW?=
 =?utf-8?B?L0xjZnVQaEdyeUJhaHlqL0s1a1VrN0s5ZGcveG9mOXZaVE9HOE00b0JXRE5J?=
 =?utf-8?B?aE1OTWg0KzE0K3dncjN6RHVjcThDNjVieUVidE1sUkFoclB5L1VpeFE3UUg1?=
 =?utf-8?B?cGlteHk3MThyeWhMYXR2R0dPdEo2UDQvVkx5bHZUZ3Fqam9EblZiL0g2VnUr?=
 =?utf-8?B?WkR4engwSXhmWXd3dXZYdmo1T1ZFUUZGZllJRnR4djN6K3JDS1BZN2Q5Uktk?=
 =?utf-8?B?SWwwK2pYYmpTem43R2YweDkxR2ZlYjN5MWRKdmhnY3BaZDJnYkZZUlpoWU9G?=
 =?utf-8?B?ZllPTVVpYmFSQWkvSUFSb0xQV3lQV0FLR0YwSHBIK1dBelFaM2FmOE9zNFFY?=
 =?utf-8?B?MlNManZhZW10Rit5NFpXNTJvMVREekcvQ0RDNWVCOFFuN0NIMjhpeWZJdXRK?=
 =?utf-8?B?NmRtaS9TZzNzSUhLVnJ0eTFXL1JibFNFb3RFbzF6ZnZoYjlIMHJCNzBSOXRi?=
 =?utf-8?B?TFhlVDRFRDgrS1VEOEtPdFBFWU1KRkRLTjRZbHlxWi9sMkFRNTVQUHFvbEdv?=
 =?utf-8?B?Ylh1MThEUkt1SmdrZzhFaVF3ZlNsQ2hmMzJjTmhpM2p1UE1idmFuaFIwZy85?=
 =?utf-8?B?Z3dndUF6Ny9zaTN3dnlaWkdSaVRiOVhCNE9HY0pDekZBN0UwMVRhM2svNTFh?=
 =?utf-8?B?MlZkZzlHZllLclFGNkhhQ0lzWU8yTzNjc1JINkhZclBwQkNkOWFtNHd3L0VU?=
 =?utf-8?B?ZzJDYXZ6eHl0R3U5TDc0VWpxdFZjWkxka3NpUlBsdmNBUjdLVmtZWHc5QlNC?=
 =?utf-8?B?VTFSSnlONFFSSnFiWUUzdGZqZU9pd3J3Tkh0TGc3VW01UFhvZWdQMVRYajlm?=
 =?utf-8?B?OSsxdW44VWZsUkI2bE1XanJwczFuL1FramtOS2xVVEVPU1NhRTFteC94Z0lG?=
 =?utf-8?B?ZUc1eFZHNEYzNkYwcE9NdEMwdkp2eUVrQVlBU01nR2E5Wkd5dTJKVGxrblNV?=
 =?utf-8?B?VnJEbXRzQ1BOdjFaZ2ZVWXplTjU2Mzk0L3ZnMFRTQ2ZaNWJtd2w3UnVnbmU0?=
 =?utf-8?B?ODV1UE9sOTUzZEtjc0ZzQ1N5cG53WVY0eXYyZlJIUjhFV2JBZmU0TkNkMCtx?=
 =?utf-8?B?SCtoU09hTmsybjgraUUyQXNSYU1uTi9LczVVMEZyRlhJV3Q1MmZKYmZjVlJ4?=
 =?utf-8?B?U05VZEtKZ0pXcGxtSktmZ1Evd1VEY2g4VmoveXcxMGdnUGJaTzNEQS96QU9S?=
 =?utf-8?B?WmdXTXBIUmxOMUhvek41bFFJRlkyazk1RER1dC9UdTJEQjRBWk9Wak5VZzR1?=
 =?utf-8?B?QytCL2c3Z3B3OEE2SEtBNWxKQlczaDJmL09udU9heWw0RUl2ZGxUZ1ZtVGJB?=
 =?utf-8?B?c2hLQXVMYWthMmtPWVkvZkhQSzZrTldGZXF0UGJvMzgwUHJrVjNqY3NaTC8w?=
 =?utf-8?B?cDJoWlZYaWtLVlNWYjVMdWVlRU96NjJwVHpKQTZSa3hwclFBcHltYTVJVjYz?=
 =?utf-8?B?RWR6RkJucUI2aG8rbVdWRTI0UDlsZVhNMDZlZCs0U28waFRGMGFZcHp0ZTls?=
 =?utf-8?B?WjZTbU9UazZwQ3lhakFacHdmTUF4ZzM4YjVFOStrdUs0ZS9qRklaa205cTFx?=
 =?utf-8?B?UkRxUTE0aldpUUZMd21XbTluSDh1NU1Vb0tXemliYytRRzE1cUxyK0FiemY5?=
 =?utf-8?B?N3daWk1wQmtxazYyZCtlRFdRWEZhVEEzZVFLQVNsRlJSMnNJZnlZcHZtekRL?=
 =?utf-8?Q?CTsgNyigtpY+Jim4UHdRuZu3SixHCdXJen0lrjZn9TJN?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?RFhjMkVGWTZQMS9oTEsxVStKWHZ0RzZDSGNBQVhYT3hrY21LbENCMmJaZjJE?=
 =?utf-8?B?azI3R0pJc2trQXZ2Qk9CUUhuWThLKzBuNVp0VDYxVXRWSm15K0JNREkxUzVa?=
 =?utf-8?B?eGl1cFQxTU9hQlJndjFkNXcxMWRvV1Q3VXBQcUVqZDZ1eFNHWno2U04vanZW?=
 =?utf-8?B?Nkk2Y0dSZG0yZVFxT1o5alU5UHhsYW0rQXgxRGcrWGdSdW9GcTkrZ3Qyb3dh?=
 =?utf-8?B?RHg4R3Yvcjgza3RUTzc2TWpDczRuTlpPYURSajgvMGhtaTA2Y1Bnbm4rVUtu?=
 =?utf-8?B?ZS94RmNwcUVNcks2MDRzUkxmbU1ELzRzb3NrNGptdmphQnk4anJwOW9Wb0JN?=
 =?utf-8?B?Y3NwWEdIRWxrdmdDWjlyUlFjOE5DM0liM0dLc25sSWh4c2xZbFo2Uk1hbi9s?=
 =?utf-8?B?OGJGUFhXT041Sm9xell4OUtFUHVXQStKbmQ4Y1NIQ1h6Z1g0SkcvaWx2VUxK?=
 =?utf-8?B?N3RUczNkUzhnbno1N3QxaDNPcUEvcFZOSkJpSmZkWWQ5Sk1CSW5IMXB1SE1u?=
 =?utf-8?B?cHdsc1ZWaCtQeVNwZ0dPZE9oMHQrZWZzZ3ovYzlQMVNIcUZUZlJGT3U0VHVn?=
 =?utf-8?B?KzRNdHE3K25zaUh1RnRPMnVGdWw0dkZZNjZqcUlLaVg2VjI3WVRxT0s0L1No?=
 =?utf-8?B?M0FPbWRMUlhNR21IeklEMmxzd24yR2xCNlIvVGdvSHlaakR2cTdIYjJYUmR1?=
 =?utf-8?B?ZU9qT0UwbjlEOWJRRStmakRKOTdaYjRxTHVhUXZYYllNNjFTMVh0azBQaS80?=
 =?utf-8?B?V1VQL0FDbmZsRDNMVW5WdTl1WHZ0ZDZhb3pVczFUck9OSUYra3krajY0OUpX?=
 =?utf-8?B?THI3djBBVmVtTnVlOTNqWUJOV09iSGI2ajdxdHNkYVk3Q2ZEVE9KUzVvUDRj?=
 =?utf-8?B?QnoxVTVWaTMyalpqQjdzZjZ3RnlacUllYmtsN1orbDZuRmRaZ3FKaXA3R0Nv?=
 =?utf-8?B?M0VyVXU0Vjg3RWRVdkVWQ2FUSURSR3JSTlZ6SCtoYWg4ZTVEWjR2SWFVN1ow?=
 =?utf-8?B?eUR2T3l2SllkU1daKytheVVuN3JkZXZVM0l5aGdwY2JycHdQLzlDeGR4aEFs?=
 =?utf-8?B?b1ZuR1krdG1oZ0tlZmo4NjlHVWtjckI3ZU96SFAxQk5SMkFDZWwveWxNMThv?=
 =?utf-8?B?V05kckZzekNjZlZ1S1grSTIrQ2JiaE5JN01udEFOZ1k5U1VOanhZM2ZENytE?=
 =?utf-8?B?bUllVzdNcUF6RGFxQ3Q4WVVjL2NkMVRVVkJBQzI0TWtwZUZCR0hjc01tbjIw?=
 =?utf-8?B?b1R2eUFSSUtvSzkxcDZqY0Y2bjllMVc3a2VYMmlsQnpTVnI3bjRZak9ibDZM?=
 =?utf-8?B?ellkSk5sOUNYcmM2Ti81Qm9yWThJWDJQRE1HY3JGQVQwVDdlM0gzaGxpVFVL?=
 =?utf-8?B?WFZFdHBKUWZLa05FVkVKUC9NaS9HMDZBTVk3b0MwOGZleFpKeUhRWVd4UUli?=
 =?utf-8?B?NkFVejZ1N1dvOHlCWllSclBnYWxWc0xTQ0d5SkVybCtYdHN0OVFZZVpvT1pl?=
 =?utf-8?B?bnhKUCtmOVVndWJ5Z20yMEtHc08rQ1JteXhTNytCUS9YOERYOU14UEJLbm5T?=
 =?utf-8?B?M25XVGlhUzFwM0p2Y2FUaVBsaXdBK3FtSDNBeWEwVHhTZlM0UVV6THhieWpy?=
 =?utf-8?B?WmFZalF1MnJScGJSS0VjYktDSmYyejR2M0d2ekhLSFA2OVNDK0ZKaml1Wkts?=
 =?utf-8?B?Uk8xTmM5bWhTc3p1cEpHWG4vVkFxQitmY090YXgyTmovRXNUTk8wSU81bnhi?=
 =?utf-8?B?aWJJN0tSWUxtSTRJWkc4MklvSnFqVWZOQktJWWJoUHNHZnh2a3U2U1FtSC9E?=
 =?utf-8?B?Qmx4dFZxZjJmbDJ1MXVlazl2cWdWeVRHd3VpN3l6MlFsT2R0TzBQWEp1RHBp?=
 =?utf-8?B?Rk44UUErMVoybzcybVZGZENCcGM5S2xoTmVWTGdZVGdDMXNFU0F4OHVCOURX?=
 =?utf-8?B?b2hQUVJVTUxXQnVqRU5aem9oR2tKZDQyb3VCeEhycEtTYkNkU0lmbmtPaW1v?=
 =?utf-8?B?MEdPbnF3L3J4cjFCSkdrWGsrclNjRDZBeVlxYm1vcitCVnRkRUNRblNycjVr?=
 =?utf-8?B?b0lldjA5alYrakFOZkx3YWRmd1c4ejY4Nmx4ZWpXL3JEOXA0U2JjVEd4Nml6?=
 =?utf-8?B?N250U1VxTW41aTZNcnBBYkpxdGtySWh6R0tSY3BQY2lGNDBmSjhlTlpkREFp?=
 =?utf-8?B?S2JnNFUzWXN5TTRxTmVoWS9Md1JjRFU2S1lmNGh0ckMvSXFrZkF5U2V2c29n?=
 =?utf-8?B?clRLSlp0TGNaQ1p6RzFBcVZYSEFnbG1HKzkxZk8vbXRocGs1UlhMNlRTUmZW?=
 =?utf-8?B?dVVKMGM2eTlqWmx5aDM5Nk11NFpuMTlzaWYreTBGdUw1emV6M0NVZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d3ef0e-adc1-4b4e-d868-08de6318ce6a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:38:52.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CFr7OXmsqLb5+nzjNYb36OcFomibIlaZBt55N1GIrIQNJWXVSAvg0cd9hbAvjGxtcvhD8kobotLGZ87IeZPmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8055
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2916

From: Peng Fan <peng.fan@nxp.com>

There is no user of gd, drop the usage of DECLARE_GLOBAL_DATA_PTR and
the including of "asm/global_data.h". Include config.h to avoid
build error.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/common/emc2305.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/nxp/common/emc2305.c b/board/nxp/common/emc2305.c
index 50252bb5007f667bd53115922b9c8d06e76f7f61..7e5151eaf5f9f31cb0eba3f85115c0dec46f096f 100644
--- a/board/nxp/common/emc2305.c
+++ b/board/nxp/common/emc2305.c
@@ -4,15 +4,13 @@
  *
  */
 
+#include <config.h>
 #include <command.h>
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 
 #include "emc2305.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void set_fan_speed(u8 data, int chip_addr)
 {
 	u8 index;

-- 
2.37.1


