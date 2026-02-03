Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B31E83F15
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13930.1770116204032814156
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:56:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=FhFcCInN;
 spf=pass (domain: oss.nxp.com, ip: 52.101.69.31, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II04IJaHZSTYKahjN7ob/xcgUO31HC3p8ycfTf1U+Mb+GZfDKCn228+8j3XJ6/tETfpS+imHpkHsErB3TVf2iL85Z5UUnXkmq+bSR9BVYkc/+YFm1fDVDwPnx/Jyt+4wPm5DIBNgFwx2v13xThtPoiZ4UhhQCwkANxMRPTpUmQzM6V68tYHJF4+cjnQkxTpedrcZin1cXlxcC9HKmr76NOKtcPWW0Zw+cMDszxLASwxWRQ8A2rWTi1Z0uqj4HluHVLw4CY2zWmLrJFM25O5LKSBvpureQfn7jeRg/oBYmBR1VbTtdfZ+NonUuq2u9INkBO7f+TJulS/Cvy91FrKV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXIalp749cy1dt2rrod5zpIWmAn2Ztur8mGaWhxYvzc=;
 b=WE+B/TZ9789y230jtXiDffOhu/bwrZYj94jnq9z7MgiAzxz8PVBcLdUY+j+CSXYgP9t9tRyVDj565dPeXrNNQ0A2cIV40vTnrrGG4+4yM1UdY1r2WXQl5m3Ord3zrRm2LLtUZcmo7fNtu18RngnYJVxIg/K2wzH3m7eeaJPtd9KzceYoHBn4yKPcfDTOGI8Y8c2W26dOonT+8NsIFoC2Lc4J/zGwVGVZ2r2zfU8Hz09hVWJvGDp8JFd5XNueR8IRRLmn0HHoucO73A/ahuGq+lbzmL/8Nb8ydCorj7hwXcKrfnBjUPtPYLL+DYItxHAf7KBG2eC37++7DkRhujBTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXIalp749cy1dt2rrod5zpIWmAn2Ztur8mGaWhxYvzc=;
 b=FhFcCInNPj2S214SGFhcwRMQmtqKkfs/Nqg1fv2+8AFo+vlVDsRKZBvm4X8hkBOP4qPM0yx3JcU2ksmVIR7lvSNT5XMwiS9Fx2UohI32W/FSstbqazn8ruiWYku9CZar9yUJ57f5F0m6XVhDx+eU4RSpo34J5C+GkbMPo0YM8UgLPWXXaoRfLTOKvObKdL9Mbf/YPe3ObUT9FUjcl/5XRz6qhMVjPFA3I8vzyjI2uWrZZvl3H4rDWoUNHzLlni1GpDv6Q0cz7CUAweNHqof52gA2klCsgBp2JnWhiaDWGoVmtxQHWDIkULeLSH6rO+5age1RyR88Nz0FiWVUJDXDFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8291.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:41:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:41:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:32 +0800
Subject: [PATCH 01/14] beacon: imx8mm/n: Drop useless files
Message-Id: <20260203-cleanup-v1-1-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 130af9bc-6b69-471f-d6bb-08de6310d2f8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?dW4wMjdUQUxmSTNTVkNDRThiTUlERXpGUHNjeDNvWmVxc0dhYkEydVJic242?=
 =?utf-8?B?bkp4Q1A4aHhMU2lMbUZrZVJGUXRPbzZ3blZWMCswendqa2tpeFQ1K0hBam9X?=
 =?utf-8?B?YmQrZjdsbWFGSU15T0Q2dWhORDRNWFliSFlzbUtDdmwvd2xQL21LVVNHOU5T?=
 =?utf-8?B?ZzhzcXA4M1hEaDZrckJhVEl0VTF4Q0VZajNib0pBRjVta0ZFTnpiV0xuMVV3?=
 =?utf-8?B?cVdLY1JaTFhDaFNFMXlHeHRVS0dPaENOQjJmM3haK2tzZm9FVG9PNlE3a1lz?=
 =?utf-8?B?NHVJODRieWIyOC9DU1M3ZkJWdG1OamlmN2Nwa0tnRkQwRDhLZWZhZk91WVVW?=
 =?utf-8?B?TXVPZkEwd0cvTTRZN0s5T3JDa0tqTWF3S0VsU2QrWGM2WEtBaStEWndIS3lq?=
 =?utf-8?B?Rk1sVG91N0ZlZnJXRDM4SmpWTC83ekFadDZPSkF0RmlySHhNV0M4aGo4TE4v?=
 =?utf-8?B?RFZBdUJ4djUwSTI5UnR0Tk4wS2ljWUFBNDNGRkhNS3NkWG9CZDlJYThqaEkw?=
 =?utf-8?B?WTZpSFltTUt6b1p4MS9SdU9PVWVMWHZRMElGNURlL2gwNTkzY2xudHZKTmpC?=
 =?utf-8?B?b0loMFREWExRbkVGQlR6aWlaZEtEcytocGJ6ZGhnOE16clBwNWMxczBmZzEx?=
 =?utf-8?B?V0U5MHAvTS9hY0RROHhuZzZWdWhZa2krOTV1aUpnKzFsWDZHaWhBekFVaTdn?=
 =?utf-8?B?OHBrSHE2aFZONjB4VHB4MTMrK2J3R3BuQ3BSejFCbDV6WCtNRjRRUUtzblkz?=
 =?utf-8?B?RThNeERqK1pGMlBzcXNzQ2tha1RVRWhraFlPTHl4YnJ3Q0pZUER4N1NVVlhL?=
 =?utf-8?B?Vk82Q1RJZ1ZuYnRmcEJpWmM1Uk1tcTVGcnFTVExaRkVFWFQ3UmZlaVZPLzRU?=
 =?utf-8?B?cURYUXZqU09XSjFQNXBKYlQ4WjJ1S21aeWRtVEZCVUVNaWs5L3ZQWUpIVGYx?=
 =?utf-8?B?UG0zMWpuZVhkVDBFM28wS3IraStha1pFay9aMys5K3VQUEJmVW91emU3TWhU?=
 =?utf-8?B?U1d6ck5WRmRtVGd2d3ZSR3dDbHV5aVByOVV5Wmk1VUlBL0gzTHRQSWtoZVZm?=
 =?utf-8?B?M0x1ejFyZXBDb0lhNExlYlFmMldNclJlVEw4Q2cwVmJodzIyTVBYOW8weW5q?=
 =?utf-8?B?aDBhdk9qU1hCTU04ODZmY29rYmVLWlhIMmJWb1VvKzg4MW1ScjgrZ3NTZFhO?=
 =?utf-8?B?cVA3ejBtL0hxMWlOOUJON3Fkd0xsYnRpOFd4bXFxTWVKaFV6MFVoRkY1Z2Z4?=
 =?utf-8?B?UlRuUk5kTC9KN092N2JuOUN1SzNJTTFwVlJLOC9xWkU3OGFZamxEN29ueHdI?=
 =?utf-8?B?bVlMMi9DcTdHb0tPcTRDeG9wRmNTM2p6MEE1SVliQ3ZKM0xMcEhBU3dGclRz?=
 =?utf-8?B?bFByNnZsOVFBb20wNWxOWUJGVFBNZTdsakVseFZUdWV4M2hWZ0ZDVU1FcHhQ?=
 =?utf-8?B?SlA3Vml0Y2IvWEVBeVZZVGs3QVdWcmx6SVZlbHYxK2VNUTQvYkJVMkI5enp2?=
 =?utf-8?B?U3VmeHkrdVVvK2VnSERpVFlqQXBlQnAwMjhwVGhEeHpMdEpLLzJvdkxId3ha?=
 =?utf-8?B?T2Rub3FJSlllMUhPUWhSdkpwV0tBWnlBWkNaWlM3cSsxZzNkQitBQ0Nwcitt?=
 =?utf-8?B?STV0dXQwZ3R4QXJrSzBZVzVucUYwT3hISHVuT1BaenJaN0pESkJtNkxyVVQ2?=
 =?utf-8?B?L0dZeUdKUUc5UUxmVENXYjdIY1hVSjlvTjZHQlpSaGtyWmtaQWk3TVc5dWQw?=
 =?utf-8?B?aFVaK2dsSjFkb3IyeVBFdGVjZ0E2bTNFOTQzd05ma2EwVjdjenhkNEE1RDR2?=
 =?utf-8?B?dTRnWHFYTkFjZ1luSEdlaGFMa0tGOXAzTW1pc3B5cGZKWTljMGZCbHp1SWJT?=
 =?utf-8?B?d3FMMVI2QUtqTnhTa3dlN3F2VDlYZ0tIWm5EcWlycWdoR0tYSFdYeXBPN0Ux?=
 =?utf-8?B?RVhVTGkxdDRvY3grTk9LTUwxTjhDK2cvWm45bE85clBGRG16Y2ZPRkc3d1Zz?=
 =?utf-8?B?TGE4d3RnMnI2SGNUSHBpdldJbHhoUFdDNVNISHMwbkN5cmorYUdFblNTOHcv?=
 =?utf-8?B?OUVsN3ZkUExidFFKZ01LMkxQZnJtdHZlMGloRkp6ZldiRVZHYWo1VkxSakY0?=
 =?utf-8?B?OGZDN1ZSZ2FHc2lzbC9OR0dWenhFSzZvcHJQN1JjbU5meWJtdTFDdVJQekQ3?=
 =?utf-8?Q?Db/pzjWNQwaK5URUHOJBC+AR1n9IFKbZuW4NVJ9Mi7FP?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?K0c0WEtsaHpZQ29hMlh2ZUxNV1BpMVFycVVPdXJxOUs5YXQzaHVobWVBT1l1?=
 =?utf-8?B?VForb2JTUm1SNzRselNDNUVFQVVZZmtkTFV6bzFCT24yUnhNK0hDdHpsZVUr?=
 =?utf-8?B?bkh4cDdERjRnbzM3Y0Fob3RvVks3OWQ4Rkg5QkF0MG13T2VkOEZaVzBxTmdO?=
 =?utf-8?B?Qk9SY2xYZzJ3MTVHTzF1M2FsZmNuUHFwL1pFNFlGS2NsTmg0YVlkQ2thdDZa?=
 =?utf-8?B?OHl5aTB5ODFPMlNudjU1V3dyQTNIOVVvMXl5K2pGSFNWWmFURnZNUkFtSUxm?=
 =?utf-8?B?RmhjaFltRXRNYi9QWndoZkFaaDNjbmtGbnN4RG92MzlOTzRmV0RiM3pna2hw?=
 =?utf-8?B?NURORUhJK1hVRDFLSVd5RmpDaHd1MUNGVGNneGxwRFo2ejNVYk5xY2VNUndP?=
 =?utf-8?B?dGhXaGhDUjlTeVMyTHNsWmVjZDRWc1N5MWpoU2ZZQlozTHVxeHg1K25SWHlF?=
 =?utf-8?B?SXJFZFgrZVhXNU41dVFiakJOTXgwa0tOVU9rR2l0anpXcnlYRG5nQkVUSmxI?=
 =?utf-8?B?ckZXZG90ZEFqVkpOT3c1TEowK0Via25kNkhGSUVkWWtpaVh4RDZRajBkY2hY?=
 =?utf-8?B?NDJXVFpMcmlKazN6eGJzT1FoMjVIVjlwNExoWVkwWW5hYUhXb1VVcUhNMVlL?=
 =?utf-8?B?TmtzcEUwV00rRkxySnQzUGM0WGdBZmQrT2NQdlMvbkI5QUlaa0xPV3lpZnRF?=
 =?utf-8?B?bDE4TTlwZUVzcUlYQVFCOFFESCsyOEYyT3NCbkR5dGhyZVM0amI1MENhMU1u?=
 =?utf-8?B?OEdjS2JtL2I4cVdZSEUreklZaHBtNXhUaWRYT1hjdXpQQVo3MktRbUdOODR5?=
 =?utf-8?B?d0FBd2FXZ2RYVnJYaTd5RG5LS0ZZVG9MaVRIVGoyUUVoUStmZHp4M3RKb0VO?=
 =?utf-8?B?WVRTSVBDSEo3QkYrd0RGSWp5S2RIUlMvd1MrU0VTZkZ6aFRyeU0ycFMxSVdU?=
 =?utf-8?B?RVdaalFXeEdXWWN3a1NTd2ppc1JsUlZTUUJkS3UvdWJ5dXdseTdaK0FQSVIz?=
 =?utf-8?B?Q1ZCclJ1QTUybFRxejZDMkl4VHJnYndHdVk0V1J0Tnd5aVpha0ltMkhZamkz?=
 =?utf-8?B?ajlQR1N5VTRCcXZPZnNzTnlOVkR4RGhMVU0yNkwzWFREZ0NGNkNhVTZ6UERz?=
 =?utf-8?B?Wkl2N216cEtmMUZ3MjRQYmJBMDdFYjI3b0RqbWE2NThKa29YWkRwc2RxL2Qy?=
 =?utf-8?B?aDZxVGxJbHYxUW5hdE5jNjdxRmJmbnlJRHJMZ2RWS1A3L1VyaWlxdTZwOFFu?=
 =?utf-8?B?S2tvTWRuUjJrcGlOY29nQnViOFJGN0U5RVRlN1FSaWI3OEhna2RMN2ZxKzdB?=
 =?utf-8?B?ZjJ3REpHQmIvbk52WXdWYWJXQ21kQmdRQllIUm02Q2RvNURzZldQbndTWGJo?=
 =?utf-8?B?SDhQVkI1eVA3cXBJeDBvR1lZLzF1RW93OHpHcEdiRlJQcWtzOGd4MVB3SmZ0?=
 =?utf-8?B?YkFBbjlPZkJUbll5N2JEMTQ4S3NwdUhTL29nSG1SaHpQeWcvOFZ5cEpSalBJ?=
 =?utf-8?B?dWdIa1RkNmFtK292ZXFCV3FzanFiYkU3MW8rbXNDQWkyODJhcHRUZ1NaM2Mx?=
 =?utf-8?B?bDgvTVJQRERWNitxMzVnOE0zcFRqM0NDR2tsN2FaN1k0Qk5RcWd2WElzdTlw?=
 =?utf-8?B?TDdQMVRHbW53akF2R2ZDVWlsOEx6SGhoNllMUkN0eEZ0cE5neW4vQ0VvZDBr?=
 =?utf-8?B?cVI4QzNObzkyNXlzWjBWam9sNzlnd2YvVktseHhvcFNBZjV4K3RCUXNJS2JH?=
 =?utf-8?B?WEVCODA4TFNVb3A3dFR2dGhVRWYyQlpkWnNWTkh0NElYUUl6U2FWWE8vNXZk?=
 =?utf-8?B?N01HY0hzdk9ta0x0L21iZFBQZVM2SzhGeWh5UmJZWUJlMnF5dEhUSG0zcytp?=
 =?utf-8?B?ZWZWeHluV2dhVVNDU3pUVlJuV21ETXI4dDkyampSZ1FVaE1FZWExbGdOV0Rz?=
 =?utf-8?B?K3dJQXY4SmNmT0ZIQTFLNGk3YzlIWDVyL0RNL2M3STdtbkJ1TWtjRHRSTGlH?=
 =?utf-8?B?bHhGNkFJbXRUOHl5RHRpamtJUFlsT1VjSzUxdDB0S3ZCTDBuRFpMY3J3K2FI?=
 =?utf-8?B?b3RQY2ZrREVWbldkNTRiMUpsWDdLTnJFWWNpbzM3YmVhR1Z0WHJUd1Jpd0Yz?=
 =?utf-8?B?V1pmT0NGUWYyU0tDZUFWMDFkNFAxYk8zaU5tOVZQeTZrVXY2MjQraGNhQjho?=
 =?utf-8?B?cnZpMm5jRGo4VkE0b2pERnR4UGw1cktBYmN0SC9ZVzdTYnVGNG42cy8vaXl4?=
 =?utf-8?B?TXNVUGQ1cHhzb3c1cHdtTDZaNTg0T1p5cGcvM2dHRmJ3QURPdVpWNWxraGNU?=
 =?utf-8?B?dVJ2YzY5TEdEM2Q2dEh2S2lQSFVBQ2Z4QjM2NnZRaGlxV1hVOTJiQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130af9bc-6b69-471f-d6bb-08de6310d2f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:41:44.6881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpyQUpW3/vyDy67LFWllcq0726+6dmUs+eMeJwgDWlBXQqJc8OFqrQJyPCeNWFFEkRUh/Vx+Sru/ZI5yfxyYLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8291
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2901

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


