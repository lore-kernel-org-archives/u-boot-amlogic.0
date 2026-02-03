Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3BAE83F18
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14695.1770118523646279398
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:35:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=CTSgbNWK;
 spf=pass (domain: oss.nxp.com, ip: 52.101.83.4, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQOfit3C0XeF79Kz7SQxLnYx8EufxL4TF4uwZYx1+5i538p0SX2JPFRWpqXQUBwyyMch3q9h4Mv3X2vpr/DJ+0M0Xnf59EOBGc/dBio2L2SQfDBSVFrz+hFh62RZIELrdgLhiQifnWfhyfP3/1PZskVO4wBDGQhMNW0/dTYFuargRny3WtxfhWai5JDCkllBP6v7RhP3CSV61B3Ehy0XaJPJRLyQ0oJo7Ec1Y7GrvC8hVQ73SRWLdf++r2Zqwib/AfjHe8zLUpNjT+S6wG2yQykpbl8hfBAwXo59e5QsAUMy47xkk9JYXLC1QS0LLpSB86vKP+RcCiqChHk9Fz3kkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxfvyil36xY1D/eNw+BGYVnOp5UonpwJ6UoczsWHOPY=;
 b=PjHMcQYvKHuYulCaIXuXcJF3OlOQbbA2O15kwc87nq7U5fwl70Mq5+t1907ERk76ZKE2Fgku87hn/f74cd+eGQwc6Ht3w2OYeLJDo7+AN8vGh6OtM1izK9d0Q6CEzlT3yplfzB0pRrFfnWrVNpIH6/J4W6jRT+6MRzwmz6OJ+bZf0AbcA8MPAVtFwJSLBwWzD/qwphayOjEED4bTABWalqk1/9pPLkDjHhY90XL/LSh43Gtei0VNgq/yzSFCHRcPSxG9SUCcL66blZDas0GqkDiALZZSCE4kWqhmWTM52sve4bw7RnKKLAzvxeTlMSqKJFIV7/WFO3Slb4Tiiqx5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxfvyil36xY1D/eNw+BGYVnOp5UonpwJ6UoczsWHOPY=;
 b=CTSgbNWKdlCCH02vJt52Ldhb2L7hE1vRCEZvUQgnFH6szssi28+nquLdFwB8B/a9F5HkaEgi6yLhcKPPlfiGeFoZxgDnRUzTf4o18XL4hdMlla79Af5/xUjDu2Zq0QVKe7nL61/0awH7oVx3s+bdvYxPPAPsK75x/hGILuwv9V/dZeOBMC/g3OpNit64mKwowUARNsATmnMGrzMSXoI27f29yzIAfklPIa62YzPMs/paDzdXKGmGVjRmt1yUWRYOcuVeIdmeHDzGc8Uzp8wjEG77/TV4Im/qh7d8lBlU12pi46/xOrr57fs/TQeRMZXCteBQEkN8Q9AkRhUKnZGoPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10749.eurprd04.prod.outlook.com (2603:10a6:150:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:35:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:35:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:09 +0800
Subject: [PATCH RESEND 05/14] test: log_filter: Include vsprintf.h
Message-Id: <20260203-cleanup-v1-5-732e986039cd@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2cb36ce2-a0a2-4442-9249-08de631849fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?UTF1SFF0dkdPQ2xlYlk2RkNzN1JhUWpuam5oR3p1ZE56NXhZMTdoMmlxYjVP?=
 =?utf-8?B?R285T2FYWUZnZUJ1eWY1TVJadWZLK1pXRFNZcmtZbXJtNlR2WitoNkIyalh0?=
 =?utf-8?B?dXIxdk1paXJIcXNqYVAvY2FGUElVcGVHWGtIQUZmRnNEdGo3NUZYUUpPZk1O?=
 =?utf-8?B?L2N2ekNNaEJTbTc1cVNtRkRFZEJlVWEvT2xOMDk2Y0VVZEl1amtjL0Fra0Vj?=
 =?utf-8?B?S3ByV1JsdFlpbDJOVGliaHVlUmg4V3AzUnI4dHh2U2dOZlpaWnZqYXJDSHJj?=
 =?utf-8?B?VWp1RmpsL1ZoT0hibllkVllJdlJURkpJekc5dURkMmF4SlF0eEhSOS83WFNH?=
 =?utf-8?B?bmdjekFaMUFqaWVNaXJxMm1TT21QSGt6MklwZVltL3NweG9TS3MwTm9SdTdR?=
 =?utf-8?B?TUhsdmJHb2FILytVMnhMWmlPVnFvRSs0S05qUUpHaFJxb21QMC91QTdNOFRV?=
 =?utf-8?B?SThveTRsMmdLSDlERTRNdUFwOFZaaWZLL1BadTF4bThHa0JteHF0VWNwRk55?=
 =?utf-8?B?aVJoeHFLZDMraW01bFNEZGl2eG9HV01ScmY2aGlqdFdRRk9hYlFDamRBd1Y1?=
 =?utf-8?B?em1sY3AwZ2lqa0VOZUdBNDE4SEFxa2lQYSttbVdrSWVMVTdMZXl4Nk5kdHRG?=
 =?utf-8?B?RlNkVVNXazAxV0RjNGU4QnlqcnBtdCtDTWJGb1pvQVI2cm9kWTBxU1EzTElw?=
 =?utf-8?B?aWxITi9LZldMZmxxVERXWnladXBQU3VGaElrckUrNzBzL0VjWkg3NUlPS0N2?=
 =?utf-8?B?L2Q1R204ak1pbUVvZWdIdll6L0pTb2prQXF6cVRBb29GZ2FRcXMzdUVwR0FJ?=
 =?utf-8?B?ME5kM3k3TnM0NytHU2NTcS83bXdjQzVORWxwOE5nTzZKUHNmRjdIVUZPZCt5?=
 =?utf-8?B?R1AxODBibUVQeFcrNE5LMWgvZzR0dWdmOGYxR1VZMERhSENBOXh2SlI1SVBk?=
 =?utf-8?B?enJIOFNFSnNxa3hMdWZMdlhjZTFCNjBES1pPL1RIc1ZwejZaYmRGeFhrUWI4?=
 =?utf-8?B?T2t2QzJMa2NMZ0UwcmZ2bUcrSEFzbjRJWDRrNTY2SHgwNGlYQ1VkRm1NOUUw?=
 =?utf-8?B?d3dnU2N3Z3lUdU1WZTE0YmY0aGRCUEg0bkRZd0R6eXozNWw3UXMzREpuZk5Q?=
 =?utf-8?B?eUFpaktWN2pDK0dRYnFFb3pLb0FueGpsazZhSEVESnF6TEM5MkQyYzhPd0t1?=
 =?utf-8?B?aDg2MFllakdkTk55MFJXNy92UmV5YnZudVJ0ck5MZVh2NFJTd0I4SDcvN1pS?=
 =?utf-8?B?UmFjQk02UmFVSzQ3OHBRR3pEa0FJM3J1T2I4WVN5WDNBTm1uOUZOOUIxbitT?=
 =?utf-8?B?NE84Nkd5NllKclVSRW1OYWpoUVN2VzM2QzBRZkFWODdscElnV0JGMHd6S0Va?=
 =?utf-8?B?aUpwSFByOU1KUWhnL2F0VU8wY05Cdnd3ZC81VlV6MkdwWGpVTExQajJidlFo?=
 =?utf-8?B?dUlOQnVzQ25yVXg1RXpSZkJ4Mk50LzRVOGdoK2ViZVRwa2RjOWhYZ0RBRm5C?=
 =?utf-8?B?cVJad25CSGRXSzc0aFVtR1h0czBJNHVkaFhCOXZ2ODBBRVNBN3VlVlNxaHJP?=
 =?utf-8?B?ekdFUWsySUpqakpJRzM3TlJLM203Qk0wNVR6L0dsWFlvTlpKc2x4TVBqbGQ2?=
 =?utf-8?B?YWNKVGQ3bFh0b2RtVmFSeTliSVJvaTB3K2k3KzB4WTVtRVRQMUxzL0hTT256?=
 =?utf-8?B?M2QrLzRnK3ZVOStRbUhXb2U1eFFmaU1YVHlWaVlVNmtzVVJNSGowdHROaEV1?=
 =?utf-8?B?Z2Zuc3NKeTVzRWk2WXZUL0VJQjh1MzYxSnc0Y1c0MTVLNWV0eW1jSFlGZnB2?=
 =?utf-8?B?aWtGRXRBdGFnOWxpL05zQVRzWUhjRmYxYWRmbS8wWjFwWElzbW1tUEZ5Sm9B?=
 =?utf-8?B?ZmFlVVJlY2N3S29VZEFmckhQNm1zWGUwMG1SQmF5NkwyVHpSM2tPSnBqSkYx?=
 =?utf-8?B?R3RzdndFQUZBbTRYY1NZUmR6czRzSFp3Q3pHMFpQcVJ2aVlScGg0TTlmSzJJ?=
 =?utf-8?B?T3RVdEJjUHdjZFhSS3E3RGcrUmphRisxOUlJTS9neExFaCtFSVhEZU5pU1JL?=
 =?utf-8?B?YkdrejBGcFdMV0RqMnk3V0hOa1RZTlNJR0s2RHdCVVN0WWR0VzVtSmlNQjhP?=
 =?utf-8?B?VDJ4ZWFNWmdrQkQxYVZLUnkwVEs5bVhjeDBEb1FIS3FZbTIvbEQ5UE9rT1NE?=
 =?utf-8?Q?IYf1pkRsvK5HJDWZK96jsEGGAl3IUH7VtaTR7I0mw+0C?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?QkZLY3k4cVBaVXN3Ny83d3MvczN4aWxQbW1sSDNVZ2tLZGxYSHpJck1yWGZr?=
 =?utf-8?B?M0NJZHV0eHRUdmI0eEphakxhaFNyUGtLMWgvQmNWRDZwNmdoektPSXVBWkNI?=
 =?utf-8?B?bGJHQU9VSy8yWUFORUpxcUtWQ0lCZW5oY2VnZ05HdkNDeDFwMTN6MlFDemkz?=
 =?utf-8?B?ZXg2d2ZENW9LWkx3YkFtU1JSaWdoS01LRHltZnNkaHNuTUxTT0Q3SXU1cW03?=
 =?utf-8?B?QzBIOGVkQXZPcVorMWJaOWpNYVIwQU1zeitGNzZhbnZCZFlqWVNPNi85YlpU?=
 =?utf-8?B?Nm9nU1hBMWFzUHZlZGpDdGRkMlU3N3loMm12YzFwRHhtWEJiZ3AyUjdtWkhZ?=
 =?utf-8?B?OEhZTXQ3YnhXRUcxUnVFUG9RUE13SkJHN01YUGlBU2VScS9xWDRBVWNyVTVF?=
 =?utf-8?B?Vi9oOGN2TjlTczJFQXRFTDk1NU41UjZaQzZhTHlHQkZpZWMrNmdmUGdYbmk1?=
 =?utf-8?B?TjMzVUk5cG9mSkk0VWQyeXVKR0tUVnA4L3h3SmdIcysyTFd4cithM2lyZXEv?=
 =?utf-8?B?WUdVN09LL3doMWR4d3pHOTZ2SXpmL3I5WGdacHVGL0tKZVZHVHQvL3pqczlk?=
 =?utf-8?B?Qy9zZWNuMEUwU0JRWHdEZE9SRVU0OXVYWGVzNFZNdzBQUEJQRFVwL2hlTDM0?=
 =?utf-8?B?eWduYWlnZlFFbi9CL0RzNi9XRTVDd1FPWlgydXdUdHhUZENjckFoODVHZ2ZE?=
 =?utf-8?B?QWl5ZmtkZExaT29JenRpKzN2cCtJR2thOXZMZ3NYRDNMbFpaeWlXVWo1NDg4?=
 =?utf-8?B?cDJ1cGVwazBod2dWcU9KUlA0NGIrQ1k5QjhML3lCcTQwRGpyczlGZkV2MzA5?=
 =?utf-8?B?cHd4ZkF6VnJJdU5sMDdkNDFDaWJRRTlEd3ZuTkZoRjA3dUl4WTFtK25jU1lY?=
 =?utf-8?B?clVRRThwK0dpLzVpSlZIbE1GUGQxSGlGYVpESUswM21kT25KcTZDTmloUzlr?=
 =?utf-8?B?S3dybmswajI0QXc4eWdwY1UyTnQzQ1FDdUhnWlAyQlB2SWVIM0M5anA0VWxu?=
 =?utf-8?B?WTlDckxWbzBXRUVFcjkzOXB2bVZqM21jS3d4QmNwMldLS1RoV2M3Y1p4M041?=
 =?utf-8?B?b0F4SXl5K2FqS3FYV0ZmcDVzQ1l4OUg0N01TRzNRbm83c2IxNzNSbnZxUTNK?=
 =?utf-8?B?YTh6aWFzeG40WThhK2RLNlpjS0pEWlA5blZBTGJDUElxMnRoM3ppWStoV3U3?=
 =?utf-8?B?WWlSNlNTd2dITzJUZGduQStMVVA2b3BlTXhoZ1dDZ1d4bVFJTFA4bUdVYlNj?=
 =?utf-8?B?aENtWTVpNXZBVHQ1RXBkenJCZTRvR2VXNWJTUmlKNW1BaUlSUStwZDN5WFVa?=
 =?utf-8?B?OUdNa0RPbCtCbFpTbGNRWi9aWnJwOWRsUUxRakRCOUliK0tnTHMzWlh1VUVi?=
 =?utf-8?B?RFZmN3lHYVlXTFNoR1BZUXFQYVE2aVlJR3k3ZTQvUkgvZmdqUkNRNUdoY3ZT?=
 =?utf-8?B?ZXlXaVgyVlJ3RmNQOXBqSzhNR0pGaDRCalIxNGJpOFM4M1lKUCtHcGpLMXdO?=
 =?utf-8?B?Zk95dy9TUnZQdDJIRkdVY0NaL2xjN0NQemFkNXpEU3BpQlZOTWNwNzRiQUc5?=
 =?utf-8?B?NnZZQ0RGMzI4OW1LeXBSb0dlNlFrSVhSbk1FTGtXYTFoWlBreU80MTFveW5R?=
 =?utf-8?B?aVdqeTZoaUNPaG9vU2Vmc1gvdlpndVRobm9LdG8vdG5PbWExUHVpUVlnT1RK?=
 =?utf-8?B?R3JBYWV1RzREVlRuVUNTdzZIVURtLzZFdUdYV0ZMMkZXbGRTMVBHQVNsVGlJ?=
 =?utf-8?B?RUo5ejcrYnFhZDRSc0g2SStBTEpGa1R5ZldZNWxKTmFxejJpUzNBam9zenlJ?=
 =?utf-8?B?VmxhWWZTeHoyWmd4eEltc2puSGZRM0FBVmFya1JmNGcydWVMVmN4NldxTjJ4?=
 =?utf-8?B?NFhpNWVBSUdOSGhhYXJwZTFJQ3A0aGV5SlN4aVYxOTJQN1BDeHovKzg5dkNR?=
 =?utf-8?B?UEFBejFTMEw4ZnIxVGtYQStDMFBiM2JwSk9UKzJtb1BxSlNVMVpVRncycldS?=
 =?utf-8?B?NlBPUXdZck9lMFN4T0JPcGNqamxrYTlOWG9MSjZTMk0wblJ1Q2VLOTBXVU51?=
 =?utf-8?B?YW5JVEZ3ZWh6elJMZFA3S00xQ3BSQnBKaG5Vay9JZTQxM20zSWwwa3hNY21I?=
 =?utf-8?B?d0kyeVBHZHZYcWR3M0dXZG9pTnhQYndudTc2b2ZLMk00R3FtSEw2b3ZIdVp6?=
 =?utf-8?B?bWloU25RdlpoemRTWjF1SHV5NUJtby9BSGZyZkpYL0dYeDZZRHZmM2N0OC9V?=
 =?utf-8?B?eTdjdmtIUXhRZlhxRit1UG41SnhjZ0JwdmVMTDJQMVZJK2h4SmVRblQxQThx?=
 =?utf-8?B?Mk9VYTNqanRSRlZoMlp6Z3ozSjFZU2hYRWFiMVBzb1RMaklQaFdvQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb36ce2-a0a2-4442-9249-08de631849fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:35:10.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luS5EYMlp3scFZVOgYCkT9nrXMeZ+s7Kwgmpk0x29XvjLp+r6diKK04qXqbxmofub0GJPw3s58hg0BLjHrVVXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10749
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2906

From: Peng Fan <peng.fan@nxp.com>

snprintf is used, need to include vsprintf.h. Otherwise there will
be build error after asm/global_data.h is removed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 test/log/log_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/log/log_filter.c b/test/log/log_filter.c
index 8622dcf29130f6f6eb70536e042c2ed51ad61893..680c60164b623bb30bf0a5457c190bab8d97468a 100644
--- a/test/log/log_filter.c
+++ b/test/log/log_filter.c
@@ -5,6 +5,7 @@
 
 #include <console.h>
 #include <log.h>
+#include <vsprintf.h>
 #include <asm/global_data.h>
 #include <test/log.h>
 #include <test/ut.h>

-- 
2.37.1


