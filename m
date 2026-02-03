Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B240E83F06
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14634.1770118652103833587
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:37:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=j5rWjiTR;
 spf=pass (domain: oss.nxp.com, ip: 40.107.162.21, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysvJJNxsXcEXt9BWCZleX7p8/wvUo9rJ6XNAG69V4XfGFEf8lOlhTRA6iVn2n++UKMhzKLF/w/8x+4md9d3Lvh4IKgwqMyNJW2qg50p8Zb207UIgNZh79hFg3T37Pn6iF4SxE//eAGYd5uMBv51ZVvkAQFJk7vSSfdtgLeklObOu1xvThm4XFdFcLM3T1oJc9npOGwIKmdDuzEvVZmBnVyqrDwkgIoArbfiAzQfOBrVa3ssIv4gfTNIlzMzgLhsPvtdrO01gLkL5ltoqKgN9xlejO7uTITa46jxEPgN7y8oaRLxxbee/+aInFS3LZKWEWmUF2KdH/CyeD55MHX04oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v0xNatn2VRaEqixmv6b6Y0wkMotCYfBmo97xeZd3uw=;
 b=zUEFZKKk3+seonyGJHIFbb3wRb0GQYL4zb7eXMiVrpzB5mGcHvN6BW5/c34P3rtMTb4E/1o8KU6j7UYG1DrI8eWb3aiatzGHbszDWs31xddwuWQxdYsQOAtebkb9+9Y1dQoM8Kx3iK4ulbLvGKsoPubwBDsoApnEcgMJ/rEOVI6TEWo2ZCFAmBE8K91fI+HuLbkV+vekPNlSwTeyY2CJcGhC/J1tnPbw7PGyOMKWae1AFxv5Uq+9QmEXNDBBMsMPd+zTvDHCznq32mLP47ukjPETZ+JcxJI6L7MeqIxDqqW279Iz5ZslLLqtrNz88S2rlLBGFJbH6r2ALINtDFlN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v0xNatn2VRaEqixmv6b6Y0wkMotCYfBmo97xeZd3uw=;
 b=j5rWjiTR/BWKa5E7lizznV7la5juL3E2iBqUcOjKoJlcMd5zfPoydf4tAPlt+nhkm6Yoo2X5KET0d89a5O4llwY5LYEaT7+HiupLdsvmcJcYA+7yHFCkS5HeR727XJrgiR2buHBFHkB9u3Rz2VY6oLhLEBJwLFn8mQ38carG5yc1ySkjpIetLeMWMD9sO2NVOPd9xtim9O67l1kdZHqZk4lQ0qKUjGfvavzk1q8AN9r+QS+2d/MC6NsSnqMIeDbT2qxtzubBvbemp0FhV+y2WlqqlPV0kuYqc4qVzl5vj/w4iY3pDTNwuNQM0JqqfmzG72QAtemWiogIJjXgQiHi/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 11:37:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:37:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:12 +0800
Subject: [PATCH RESEND 08/14] tegra: pmc: Cleanup headers
Message-Id: <20260203-cleanup-v1-8-732e986039cd@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|MRWPR04MB12330:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a20f44-28e5-4340-46fa-08de63189988
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|7416014|19092799006|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?NFhZL0YzcEF4MThtU2lXY09CbE9UejVWQ2h0aks1dVhvbTROSTBhNmEva3ZQ?=
 =?utf-8?B?NW9JenRjYjJoaWNjVmRwbEVmNWdCcitFclJwak1PNzBWREIwTFpjc3ZDQUJR?=
 =?utf-8?B?NUkvRWZGTFMveDJBbzlyTXRTNDZlcXFycnFSMW1mV2RlQmNneTBMeXVIalBP?=
 =?utf-8?B?M05BZitZaUdIOStHNldjTUwyZGkwbk8rTjZ1QUpCcVhsUjdrMlpacUtSRGlJ?=
 =?utf-8?B?TS9aWGVLRTVxeWRKSVVZMHFSSkRDM3pxQzJjYXVyWmo5akF5YWVyWjlNTW44?=
 =?utf-8?B?M1UxS0gxNDRxQnRpUHdBVVdUTDJPaExJUVJlTUQvMlpwUkVMSTFOU2J2WTRI?=
 =?utf-8?B?aGRtcE42U3MveEpTWGNwQktIUDdVT3crMEFaYjJ2WkpsTVJkdS9GTFA2NWky?=
 =?utf-8?B?RWdTdGNFT0dVWHV2OEtjMXFSL0Fva2E5RnkzQ2wzSVN1a1d1bUNYd3kxb2Fo?=
 =?utf-8?B?b0ptaXVTUGNsSGJqSFNNYlhERGxjbkZzSlR1ZUVwNkZsNCtFOEs3STJyalRw?=
 =?utf-8?B?SE5wWVZUemRtNEoxUGFCZ0ptUEhQeU1mdXVDckFRa2dzWXl0SU5tM29XeDZ3?=
 =?utf-8?B?d2JJbjlLS3dISWdzWlRseEE4ejBHeG90ZE9aRnhxUkNqbnhoV2Fnd0xFaGtJ?=
 =?utf-8?B?aHBsSVhVa3hQYmpDTUI1MGxwekNXMG1qT0VYMExwRnJJeVVIcUZRQnY3SG95?=
 =?utf-8?B?dEpvcGRsb0xrcS9BdGE2K1pPVkh0eXUwL21Vc212Sm50aHBHeHBiV1dDWld1?=
 =?utf-8?B?VzhUVWFxY1I5QWZRYzdSRkZ0aCt2TG9IYWt1QmhnU1NuczFnbmJlU0pLeUI1?=
 =?utf-8?B?M0trODNMaCt0SlNzOGdOemNadEMvNmdOL3J6a0thNHRVZTYrb2x0elBUUHBE?=
 =?utf-8?B?WHJRYVpPMS9OVzFUMXFMWXR6VlJVUGduNStNMGtzaWh1VWl3MEltdWZwQllh?=
 =?utf-8?B?VWlaS1UrOHYzZGhma2FCaWVtaWxNK29oTmIwR3hiaXpyMDFGVGNGYldjcytM?=
 =?utf-8?B?bDhNbTExWlg5eDMvZ2tjYTZZdDBwdHhNU3ljOWkrMFdaT01jaXhSR00zZm9q?=
 =?utf-8?B?Nkh1OGdzSlBsMEc0K0t0TE1LYjdhOTUrMGc1ek5IRloyN1lnSVRzcnU4MVhw?=
 =?utf-8?B?WC9nTFdSWUtXbk5DR1pBVGtCb0xTcm5PUHBVQTF5VUdOeVJrQWNsMUphMUZQ?=
 =?utf-8?B?NjNmUG9XTFJnajR3UmthMFUyS2ZiR0JBVjl3eGVCb1ZVRlBjRXcrajc0WnRu?=
 =?utf-8?B?SVFnK1RCYzBPb3FQTnRpMWY5SThzWUtmZWxjblgzZEpBRm8rVEZpdE1RSjZU?=
 =?utf-8?B?NkZnMWRqT0FLTjY5Um1PNlF0ZGs2L0dNVWlYajNramdmUVl5dU5IYnlJKzJB?=
 =?utf-8?B?V0JYMk50UlAyQmg0bFROZHMyV1lTWTI4Q1ZBaDdjb1VnTTBNaUtsdjVsUFc3?=
 =?utf-8?B?OFNMR2Q5SXNaL1hYTTNQWFdOa3NadFFEMFlDM0pZVzhmZm1iMmJSL3lyS1BD?=
 =?utf-8?B?ZG5nMHhJK1RxeGNRRzk5NVlPanpnOFZnS0NSY012YWl0cENuZm1BQVc5ZTNn?=
 =?utf-8?B?QitNcGZDNWtHWEFiVkUydytHbjNyUEtkZW4rQ3hxOFl0M1pBcEVOckhRVitS?=
 =?utf-8?B?dmhFZUsyS1c4UU5HQWZyQk44YWkxWExnNXpXTk1qcDB2VC90WWNBNi96NWFh?=
 =?utf-8?B?ZHB0azJMMjhhN2xza3RBanM2OVc1enBpK3MzZ3B5RlEzVUl3Uk4rSWJGczla?=
 =?utf-8?B?M1pqN0VyMDJWUEF6cFFSYy9LWXRvQWdWeVNNU0RlN2k5T0swak5Lc2pjbDJm?=
 =?utf-8?B?ZXdYV0ljWUFndW9zV0I5SjEyZURTQ05nb0VWSU5Qd3k5WUF6RURSUWtsd1Fz?=
 =?utf-8?B?QTE3R2RyV0VqT3JqbVYzTU1selFWNlNrVFZOcUNiUmdxTVNxZ0Y5TktFTWpN?=
 =?utf-8?B?YmtnaXNlTnBHbDVpd3hZR2RUdWkybHdFamN5Vy9CVkNJTHZiMzJxb3kvdGNU?=
 =?utf-8?B?NS9yOWpHVVNvUnpKSVpSWFFNWGlOVnVDRS9RTXRqelphdVdVU1hNOXhMdElD?=
 =?utf-8?B?VHUxcTNWMDhRZkZwbi9TWU5JcEhkaGtpUkthRW11dUQ0d09WbER5TWI5bnpl?=
 =?utf-8?B?VSt5ZDdOUjIzMnhVR1BkUXk5amtVc0lYS0pwNXE1ajRoa2lybnRTYTFCWVJz?=
 =?utf-8?Q?czP9YPSnAyI73GXOr1v81/hHHl4b+163h2PKcDvZakQm?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?U3lmQ1hvTVRVVDJOaWNvU0VNTmN6Y0Z6aVR0azc3UktBKzJMUnk4N3RSUm9k?=
 =?utf-8?B?UFhwdXM5d3dLK0VsYmFSdVdsc0FVbk0wN053RGpEbTdQN1ZOaFQ4Mmg4WWF2?=
 =?utf-8?B?UlRQY2xJZCsvZmkyYkEzN1YzSjVISjV5aG1BWksyRHVuc0VQeW5xaWJ3VUx2?=
 =?utf-8?B?ZU9XczdycXg1bjAxQ2FBb2hGdUxDSGtBK3ZVMGpGdTFxOTJ2T0VjZTUvaStS?=
 =?utf-8?B?ZGFXRjhHRUhKK0huMVJ6S2ZjYzVzQXZhOVVVRVVxeFVrSWZuU3BWSXJHa0VO?=
 =?utf-8?B?ZDRLWjdBT3RQdnE0ZnB1R1gwL2JCWXVpcXZST1hnOEdLTmtpRmthUkxHb1NZ?=
 =?utf-8?B?WC9EYnNYOFJEVlFiYXFSVkExOCt1WmphbVN3LzlZOEZ3d00rN01RSS9YVXFG?=
 =?utf-8?B?NUpjTWdVU2NESGl6RUNiRFBkS2VLT2lZVHgzNDBYSnl4V1VzZnhqY0FTcERW?=
 =?utf-8?B?ZURiSktNK2VzYnhTcjc4RnhZWWdWcGkzWHpkblBlVFVjc1UwcFdZVkRDUkt2?=
 =?utf-8?B?U0xOZXRqZVlZRndZVG1oMW1nT0c4d292RzY0Nzl3clpjOHhFVHZFbUNBem84?=
 =?utf-8?B?bGtvaGl3Nko5VXdHT0lVdjlpUnhIUGF1SEQ4aUNzbXh5dnErdzkweEttYldW?=
 =?utf-8?B?WDUyUU84ZE1QWXVNdG9QR2lDMHpVajBjTlRNTWROZ3ZZUmJPelRiZ1lobE53?=
 =?utf-8?B?d3hrNEtVSDRCT3NmUVBOQmZEODkyRVNmYVdndm53ZDJMMmJSMks4RkFzMGcy?=
 =?utf-8?B?emZGckpxSkF2dGJmc2d4Y2FCcm1CMGppZHcwMXNzWG8yOWVKSUlYQkVpL3BS?=
 =?utf-8?B?WFZGOWlSMGVVVjBVSTR5YnBkMmlpTDRJTTZOL0JmQUtLQzdSQXBUOWFTUVlt?=
 =?utf-8?B?MGtQUHFtaUtoYjc0SWRWWGEzOXVISmxOVkE2SEcwKzNObDB0T01xNjhkcmVW?=
 =?utf-8?B?SlM2ZnFTVUM0WWk0MGFQd1ZFVkc2NVJ3Z1l5MVNMbHhrQzArNEZBeHl6bDlk?=
 =?utf-8?B?aEZvaW1yWncxSUh2UndyV1grYXpzSHl4bmt0N1VSWnJSQndnM1IreFRDcDFX?=
 =?utf-8?B?NXFUS3czVzVIUHZBcUlLdGVvaDN0bDZSQzVqcjVWZUg1ZW5XanhIQXpSZ1E0?=
 =?utf-8?B?a3NTZ3E5ZVJVRzlsQVAxRFJzU2xPYVRndldLZkg0SDdjV0J4SlFsajhUb3RD?=
 =?utf-8?B?UEVjdmJaSUs5VFpCK3FqZjFlclR0T1o5YTRCTkM0Q2dEWjNIcWFxMHVlbTg3?=
 =?utf-8?B?SGVXT0d0QWRuaVQ2b080enVaeVI1M09LUUhSRDE3UHdEU0M2ckw0UDFXRmEr?=
 =?utf-8?B?ZHFBRFl5TVFOa2dDWHhDZDkxSTNtQmtWWE9kVkJreW5zSW4xVkxvMlBJeDBQ?=
 =?utf-8?B?T094MEI2MFJQYTk4Z1VuQkJCSnRydW1uUHBsTkpYblYyNXh5VUkvNmRveC80?=
 =?utf-8?B?R3Bhc1RwY2FTQjJPQ1VlSUNURm55Ymlhc2pYM29DeEVOODJrdjdJRmJIbkxq?=
 =?utf-8?B?V280akJyb1RiOWVPdnJJZlBPT1BPMGp3Wk1uQTR6VWdCWHo0MWNNaldTa0FY?=
 =?utf-8?B?cjNLZm8zYWRwYmh4NzZldVZQK2ZjOEM5TzJaRzUrajlvRndVc3NEZXM2U25p?=
 =?utf-8?B?U1l1WjhKcUlvS212NUdscFlhdXVwWndtS0gwTkxoemFzenhjeEtLd1pqK1RM?=
 =?utf-8?B?TE82aXF5Qmc2YVJEUWk3cFdHeFNUSzVtWGpUQ0dZOFdwdFRCRmFFRWhXOWxG?=
 =?utf-8?B?WkEwek1zdE45VnVFWmVpYmJ3Z050Z1ZlVUR1bHp0ejJ1em84dzEwOWJwK0Rj?=
 =?utf-8?B?VThyNjRRZmRYMGtLdVdnUnVkSUNjaklsZ3lVS2xacE41WE1tMm0xb1k0a29F?=
 =?utf-8?B?aVl4TURhaFhvMUQwSlA3RGhiQk5rT1ZCbk04ei9XV1YxYjU5L2dGWHI0WUsv?=
 =?utf-8?B?OGU4NnZreVg1RnJIVG1RZDNrYjl4Um1QdjAyaGhmVzhBQU1WRGFITkRZcmxC?=
 =?utf-8?B?cEVpUFJhOHFJQWY2VGR1RzlQbTg0UzRXL2duaVhxSFAxbUN2eFMwdno2SXZE?=
 =?utf-8?B?Yk9lc25YQnNDTjNUaEdSUm1Hdk5PVFVMeXNvOXJCR2RiRTk3VE12ZjA3RHBw?=
 =?utf-8?B?eXhxL1UrUWJCZmFUUmpWakkva1gxQldqN3d3aUMxQlU1TXpKWW9Na0pILzdu?=
 =?utf-8?B?K1NhbzM2enJreHBUNGxzYkFaTnI1Mk5EQXM0NzE0T09TbmZYMmh0ZmZ4RG85?=
 =?utf-8?B?ZjF3MkZjOGcxRkY2RWdlS01zcmd5dXRoeCtVNDVTN3dTdit0SnlGR1FNQ0Na?=
 =?utf-8?B?LzFxcVhrMytmVFIyczlONzkvRjdWNXhLN0lLVkRRVU9HZUNLV3I3UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a20f44-28e5-4340-46fa-08de63189988
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:37:24.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1Q/2CHcb2vLF7dA2SEphoFQ3bk+4Xzv48md4ZBEoWUU1uW2jpFpi+vpFo6+quJ8RuWHW3UFlGpjjgFOgS4D6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12330
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2911

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


