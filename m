Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A4E83F11
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14708.1770118610077533010
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:36:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=uYMd540e;
 spf=pass (domain: oss.nxp.com, ip: 52.101.65.27, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHshHMXQhYy7O2Itcff3G/ArVuAlLcFijcEaPk/zXy6RLtyrr2DC/vWREIeGdWsVfkmmHM8PUr9mQIvLfgEewCeEwvhhKW9DtaaNxFDbINuWkn+NgILGbNX4fgotW/Iu8tgzfd/ZSV8f0zDqm77B4pEADB8IhYyiWdNW8NJn2/TmXjg/pQVYfNx5GrJ3mA1UgrUL32RDFxsacT8c+3G4xtQGNV/feV+O3G3S5Etpn8Gpga44PSZLyk7c+BXC0g4KT3EiO8/QxkILN6ntgUvIHUKNkoU7ZDmb+aQOLGV1jC77U6BKHtIBwRxZapc1TsRJ/814S3SaHIfJZy9UUAOdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPspR1f8x8EmRHTo7a/aAkNO/gymepd95G3Fd1O9huE=;
 b=FEoSqQb6Fy0Ifa3hwGkKB381RjhOEwooBbNFrIgilBd/IVQi6FtmmaDqPWPZYxd4kitr4ZjUMKPKCeU6XwOpvi+f6clyZqc4QQ2TuygZVcTCp1tlLtATXh1RV/K5bXMG8RNQdytNZBd2ECSE+DFc6g96PKwOQ5LazVX7JAZTPZixG0p8TTqTvJGWMzl/J1nXBW8wSmezzQWLm8FNsYbja5Zoaat7+n09KPOV4KDbeykBnLCTMUbuQBcxEcsB7xdRw8mn89rDZxr09E5UgcV4CQ590qd5p7Nwa9nZmiFDOmmaZXN74x//P1FlKSFXHAzIukp7HhhSdsFeMl1NW4a4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPspR1f8x8EmRHTo7a/aAkNO/gymepd95G3Fd1O9huE=;
 b=uYMd540ezKDIXYV//XxBqCZKuj012owGfJSGc7tZ/0y06UXrQyk//pJKXYHJ9FHqg9tuGjEq5sn/gpuemDjk8zl1S2+IwkqXONFqV4cBqw4oaSsY3aOjC3zKfieA3oOxpAdwqdkxSodUWeJYV2CH8GGGbJw/MGCO8T1e5Kv8fSpJWrJw/XPuvrV8R2lMHQQ/myzFwir0pkBVMKlzJHf3uQ7TrFlvfOAdd1ktQBX+QGvWYegFy7rDD21q9CCFz2VRVE+OxXbRx3LUWmF0ra7jvZrGSa/eySz+2FhRgjnvs3MKu8BeO6ok6P1F4DeXtokIVx2L62qr9rx5zVFbVsYvnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10749.eurprd04.prod.outlook.com (2603:10a6:150:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:36:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:36:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:11 +0800
Subject: [PATCH RESEND 07/14] toradex: common: Add missing headers
Message-Id: <20260203-cleanup-v1-7-732e986039cd@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3450b19c-02d1-45d7-dca7-08de63187f03
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?MThFZ1gwdkFzUndPS3puWUliOG4rcGVZUHVhRG1iWXRSaWFIbkQzUjRQNGNv?=
 =?utf-8?B?cFFya2lFN1VKYUFQcmRSZFdKRW11eVlmNitWTGVzOGk4cTNuVktjY3NndWxM?=
 =?utf-8?B?NUQyRWdwMDV5YUU1TmJTaE96OHBBTEhDajVoRENodU5kY05EQzBpNkFLbTU0?=
 =?utf-8?B?R2lQNjBzSXVpcVpHOU5PVURtTEptUWthanFaeE9NU1dwSFMvbTBMVEF4cDc3?=
 =?utf-8?B?VHU3cWxQZE9uNzlzSUFsQmRNcytMNGdMTlVwNmdoQ3Rwc3E1Q2ZQVEdxUXBN?=
 =?utf-8?B?a2xKUGp0VzlCYU5GSy80YXZOQ3FuUnZHSkhpdzBlL1U3b1FtUS9ncWRjZEYx?=
 =?utf-8?B?ejVXRnlzUGQzcFNidEVQcVZERFMrNlJPcWtxeVg4TzRRbHJ3SW9rTkQzdTJo?=
 =?utf-8?B?U1dISmczdEZGNitKb0d6OGdRc2VLYVpuT0pEQTN5emlBZnp2MG5WeUJQZGtq?=
 =?utf-8?B?TzdUcVk4UEZVWWMxZ3owUjFYZm1DSkVGU01MR1VTcVBYN3ZJKytkdFhsb1lI?=
 =?utf-8?B?TDA4RUwreW85RjByempFVmZhY1dqME9Hc1U2c215SjdNM2RCSVhhRlRLcVhX?=
 =?utf-8?B?M05UdStOTXNleTVmaHV6cjViZHk4TVMzSFVjeUhhRGhXUXdTRzlhbVpsT1VC?=
 =?utf-8?B?WnU2eG4rY0ZoTGxuNFVFemtaTXlwQVBPd3FZRU16bXdDMHRUZVpDTmxYa2lE?=
 =?utf-8?B?dDNXOUJzbEhud1UzZ3lsNlc4QXR4aSttYml0Tmc0Z3JzRElmREZHN0FyQjVP?=
 =?utf-8?B?YkU3S1FKTjdWYjRBUEhKZHhKRW9sSGZ2WDBVYUdOUkYrNk5yZmVPZEFvc3NC?=
 =?utf-8?B?QXY3aGVNek1jbm5aUUxGeVlpTDFnQ1djbVNyalhUU0YvNmhiZlI4bERrbysy?=
 =?utf-8?B?VG45ZlpLcVNlR0lUMWFJMDNxMWI4WTdyeTRvR09WMzI4K2tkdDIvbktyVE1u?=
 =?utf-8?B?OGRsNzdlTE9iSTZmeWUySFIwakJKZmdVekhiWnBnVE95eUgweWhBelNxVFBM?=
 =?utf-8?B?Q2dsb0VGeVNPRjlkS3cxZVFieDNCTGt3VXZNdWFSN0I4Wmx6bm8rV0xvZEJF?=
 =?utf-8?B?L2lCWkxSbi9VRHF6WkozTy9ZN08rZFIyWVl1NkVsRk9vcER6eGVuV0k1U1NY?=
 =?utf-8?B?K0xzcFJxMm8rekhqR0l3blVNNmxkQWZzUFUyUnNodUlUSkRWU2NwdldpelpN?=
 =?utf-8?B?ZmFEaXlkdmdDRTZSRmg3b0ptekV6cDVCTGM4SEdwV2FJem9JcFk4K2VDbVB6?=
 =?utf-8?B?T1hhdTBuVFk1MXZQQy8xQ3lTeWNmOFhmTXFHdXNHbithY0tSVWM3UTZWMDRr?=
 =?utf-8?B?Yy9YYlhoVlRDbDNlWWpBV3pyTDZiZXJLYVhTY1k3aDl3dDZzWDRzK2RUR1Ex?=
 =?utf-8?B?TzJzUnY2NDZlZUVFWmpmay8xQTVrUlA0T21nd0RhVnh5dk5yOHBKYSswNFZT?=
 =?utf-8?B?bWxjak1HN1oxQXdRZzk1aXNZYnV2M0ZHOUpkQU5GdUVqQ0xDVmcwdWtTQ2wv?=
 =?utf-8?B?K1RXSllvQS9oSzZNS2NPMHo1cDB4TFA3djhQYmZXNG1UcG53c2pvdnBwMUxt?=
 =?utf-8?B?Q2RUS1krRFQ1SmJHQWVuM1RHTlJ5aW5Zbml3clVON2pLZm5mdkRCSnlpVEJs?=
 =?utf-8?B?ZzZZVUtvR0ZIbnRqTUVjMVpPQzJ0YWh3VThvN3hKUUI0WnNhVmFESGlpTEdX?=
 =?utf-8?B?bENobFk1SmhzcGdlUlpGNGxsOEJldThsZDZDYzU5cWtnNC9OTnY5WXNHN3hl?=
 =?utf-8?B?cFVES3lOUHdqd0RiNlk0M1luRmFiQ2xsS1BQQlpFYUExQ1VsUVpQT3JNK0Nv?=
 =?utf-8?B?WllQZHN5SE9VY0ZkTHlpbG55MDBPN1YzMnpjWGJVcVBheVJnTm5sMVlZN3M0?=
 =?utf-8?B?L2pPTHQrajYvVUEzTk5DVmY4SEMweVFGa2dka1N2OTA1WDN2eXYvMzJvU1dz?=
 =?utf-8?B?a0JZRWpkWk5kb1JGWjBlSFNiaHUrTnpJTkZEbnM5TUUycDVWdWQ4WWd1bXBN?=
 =?utf-8?B?dERRb3k3WDV2M0grZG1sSVpkMldLNUI4OHdvUEZmVUFsZVRWNEN2SE9Pc2wv?=
 =?utf-8?B?eDcrVUJRMU9aMit0OXQwdDJHNDVSM0xRcEVhNEt4QlplWVd5MG9LUkFMMmd5?=
 =?utf-8?B?NWVnbXhQdnVUd2o1bm1kVWo4ZEZSRHdkR2g4bjFPcU14V0VBVEx3bWJFemNF?=
 =?utf-8?Q?0UfpJ71bTc2JGF809JF6kCIzj/+o8YN3ZUD4meSxLA2w?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?WDlzUGdBUFlreWR5dkxpL291bHZsemhRSlZuOEpjS3lzMENpTVFQR252Rmp0?=
 =?utf-8?B?Nm5Od1Rqa2NDRDJRSTM1RERmNHNjMXZwUXVQZ1dVK3IySGdrUTRpcmlSdHBG?=
 =?utf-8?B?YUVjTnlodkFYNXlFN2xiKzJDcEFYMFlHRzYxclMxblFLQy9vdlNMNDFuUktt?=
 =?utf-8?B?UmRrZy9lc0hqM0t6a21ua283NUx3aXZ2RjhCWTdQSE96bU0zbXVUWGZXdVg3?=
 =?utf-8?B?bjc2ZjFwU0lsUGplOGNoWWZBVE90TW95SXlhWWR0NXdja3piTnh3OVRLMkF0?=
 =?utf-8?B?QXhHQWh6d2o2dlA4T2Rzc2tnY2s5MmpoT1Z2eUNhM1Erck9JbnpZK01qd3NK?=
 =?utf-8?B?SE5vM3ZrZEJJUU01Z1pucngyTmxCTENaN0FJcWNjZzFJSjlkMi9IV2c5RmdL?=
 =?utf-8?B?cXEyWE96cWtjTFhsUDMvLzVyK0k3Z1RsNkVUNHlkOWtTUlBDMVVMQzlPdjRp?=
 =?utf-8?B?bjBscDdyZW0zYzFHUVVTbzc5R3Jobks4NUFIS3V3aUEwMEJXaTR2RklLTTdu?=
 =?utf-8?B?QkprNDJ2RkdmRU50NUIxcklUcndXMThBdGk5aHR4Z2hlWkNCUjFUUWVUeXJ0?=
 =?utf-8?B?ZjllL0JiaVVCTU9jcmJvaWV1dHozVXREaWlrUkdYUjdkajZMT1FyYnBmRWFz?=
 =?utf-8?B?UncxSUZzYnBzaDdxRXZDY0pTSkxoNEd1dGdxbkZnbFdQdk9kNXh2djE4WTll?=
 =?utf-8?B?NVVDemMzS2Q0VFgxbms0Rit5Q1J2VWJxRWRNT1Qzb0srU3dqdTZOTUgxLzFm?=
 =?utf-8?B?cDV5RW01S3lKQkhwRDBQYUdOL2cwMkxaR2hDK2RHSVVoTEZONFUyV2xTRG5Q?=
 =?utf-8?B?QkI2MWQrRS9uVFg5Y0o5VGtxY1g1VFQzbFZvSG1nRWJDMm5NMWlBM1NiS3Er?=
 =?utf-8?B?WWpTZUQ0ZS9mZUFVY1RTUkU4SFRnTTNUUVY0RzhUWXNnRy8wU3ZYZTlYMlkr?=
 =?utf-8?B?UDBuWkdXbktlOFh6cmkwY0I0L3NjSk1yZGZ2Mmsxb005a04rUlVZdkwzL0ZS?=
 =?utf-8?B?U2Vob244RnBwVWRTOXNCOHNaRElFV1ZtNlVQWVdPVGhRRXlCSldoQlF0WVJY?=
 =?utf-8?B?MnQyRWV0c1A1c21aTlVidlUwRVpzekpRcDQxS0w3d29VOENZZmt3aklSZUlF?=
 =?utf-8?B?ZUFNeERJNWRwS0R6bTdGanBNWkhsQlVnRTRZSi9FME44RzRERCtDbnVtNjRV?=
 =?utf-8?B?WVQ3bUtvTWovS25TRmVZQ0JWUjBIdndvRWVzd3pWSWdXZU4zc1NFVnpadTJC?=
 =?utf-8?B?NVVrM2xvZXAySTlPeW81UldFSFFURE9JWkJsZjJxY2poR2hLb21XSEUyZ1ow?=
 =?utf-8?B?REFmQStpd0NxWTFHN1FmdGdoTlFFUzQ1aWRLRmozaEtlMW9TeEYxaUJVYVVQ?=
 =?utf-8?B?Uk5IRWpaYWhvWjhZeEhaUzBHcGt3NFJOYWlCc0Y5MU1yK1BhZ1M4YXVNc1pC?=
 =?utf-8?B?VGZxWmJ2V3RaTERpaGViWFVVanRhMWxqZUErRHJDZHpNMGJkUmpxdXJYSmhG?=
 =?utf-8?B?eStJWWFoMlpvbGQ4dldxOXB6QVVYOU9XUkE3N2JROTBNdk9UeVVZbWdzS2tF?=
 =?utf-8?B?emdBY2lWbG92ekNoSG82L2xqK0ZnSHprUE9OZEtOaEJvbXpmTW9qSWpQMVdT?=
 =?utf-8?B?K1AvN3dFS1Bnb21BZnlXWTl0VGMzQmg0WUdvbWhvM01sWXhQbGd1ZGpTTHlq?=
 =?utf-8?B?azhZREZNeDhhMVAvYjBXK0Y1am44Z3B3VHlyb2t3OHRudzVkRFBML0c3aTFK?=
 =?utf-8?B?aWRjQVJ6ZFdDR3lDaVdEMWY3WWlsUFFCTFVrTS9ZcnFQcEVLVUYxejJ4L3ZE?=
 =?utf-8?B?MGQrSDRGYjBqZWxLVUFqcHJGRFRPQzIxb0tHREhyYjZzZWFDT3pTK0RIOStC?=
 =?utf-8?B?RG1vUG1vbmtWZEZqTjhyclFxQlFyenVNU3FxMWVKUExSby9JbUh3Y3dKY25p?=
 =?utf-8?B?TDBKVFZxZFh3ZFdqREdPdnB1ZDJCK1h3MUNPN3RZcC9ub1BvU0luOWZLNmlO?=
 =?utf-8?B?ZFBVenJUMDZqbjdCYTY2MWs2Z2tucGMrRDg5QkpnZ0dFVTJIWnFYTkJ2VGls?=
 =?utf-8?B?YUpBV3ZtRFZaNStSaVFOdWpjWFo5TlRxMzBqK1hnbHg3Kzg2MS82TWVybk5W?=
 =?utf-8?B?dE0xcWVwWGtCYXN6dk5xWXVVMzJpQ0Z5ZEtEYThFQkhqRU1CTTAzamNXYWVa?=
 =?utf-8?B?N2J6TFdTL0ZhTGlCVlVMQmRzeUtsR0wyZ21iczhtd1pzVzVXMWhNeFpDdUJ5?=
 =?utf-8?B?Q0JPYSsxd2s1VlBqN2JraDVIdnltemFhTWFIenBmSnJhWm9zSzFRbm85YXhH?=
 =?utf-8?B?UTRzMnFzdEQyUmdwc1FvV210Qk5mT2kwSjFkNjhLWDhLZS8vNVpLUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3450b19c-02d1-45d7-dca7-08de63187f03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:36:39.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqZ+tjSBKLOMD+5AfzEGcY86Sr2Pc/vEAm+xBwBzJO8qmUfuu1nLZmzMz7TTtrNlQYtfd4luEEEB2Aq6PClNXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10749
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2910

From: Peng Fan <peng.fan@nxp.com>

Include linux/types.h and asm-generic/u-boot.h. Missing the two header
files will cause building error after cleaning up usage of
asm/global_data.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/toradex/common/tdx-cfg-block.h | 2 ++
 board/toradex/common/tdx-common.h    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index b28033d8332e09d063a6a8ad1d4e334703077f00..067daec0d776070b0b53fc26d1043d6eb781a527 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -6,6 +6,8 @@
 #ifndef _TDX_CFG_BLOCK_H
 #define _TDX_CFG_BLOCK_H
 
+#include <linux/types.h>
+
 #include "tdx-common.h"
 
 struct toradex_hw {
diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
index d446e9f1d5ca7d3d5a1318b389393d28854e2263..db3369a8f9ef9b409c53c45e94aa5f22933a44fa 100644
--- a/board/toradex/common/tdx-common.h
+++ b/board/toradex/common/tdx-common.h
@@ -6,6 +6,8 @@
 #ifndef _TDX_COMMON_H
 #define _TDX_COMMON_H
 
+#include <asm-generic/u-boot.h>
+
 #define TORADEX_USB_PRODUCT_NUM_OFFSET	0x4000
 #define TDX_USB_VID			0x1B67
 

-- 
2.37.1


