Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7848E83EFE
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13697.1770115767161425202
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:49:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=BCW0FaAo;
 spf=pass (domain: oss.nxp.com, ip: 52.101.69.50, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDp5RBogxnfZ6CbZfT61FBAE61nrhCkU5W6Y5rCtyG7EBClOegUtrCbcPLqBIFPFqzTA5bygt4HBS7+srMY+Z/CnOVWUrc22Ri69nhcD5uem2b6K0T7VosLfsLxCa1TxFmybDvree3XfqoDhBU2DqZn58hhX21Y8QXon4hlywAbGTKXUfvHhAOIclLUFyQZGeQWzQoCKFrcUFAMLSZwkqJMCVIe1vp0lyg8+6axXM9kYWqu5OX/LX1FTRirevENeE8MAIk/+CcCoUrYKzoMBtb5712zGZFfMlDlK0AnGRayE+txx2YzTUO7OxKLFJJbCYYpgP7wRtWPmOM5+vh2X8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl+Uj1K48vUj4yxZKuP6zOWmIwhFmSeOCZJI8Wb8I3M=;
 b=ilAPnHQ2W+LvrrAPHKCxyOIixXXI284FELEC5VhaajBQZ1ph3psufMKFbUKYZYn8aqp+z6L3Pud6t0LJyN+Dc8zhw2POXJ4GKUdUKzVoFPhhWk+6yd2Yhj2/AiL0VNskaH94zToNVpqDyaWvcmhJ3/hzezbM/FCSlQi5PXEwU12mWZ5xkFRLj/K+kg9H9gO86jbYuLiG04e4rPFkywXDOx1gCvWUEzOqtWoxJgmIYxGIZdfu1P89McXdhuzKzu7SDjDAYehmG8avztXrirFYnOUPAUen89+Ei9BKq+Fve4O2rqKUpvdCADbTBpGuf+p3mCSqyfsr9P4SBJ/mB3YI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl+Uj1K48vUj4yxZKuP6zOWmIwhFmSeOCZJI8Wb8I3M=;
 b=BCW0FaAosHv1y7Puy8GiAcMzErHUZIvV6bKfIccCJyxGD9LFcr9VIM+8C1rAX6isnwllS2RestzOWIq1bpfjTr1wr+F+hhQaDw7tJrLIbP8WAqvN4uHpzUsvcydFleCcbN5oX7U54k2HBZ8bysYfSzGkdVpr4PJRUnXEjrPEd1HFWKLkT9pI4mWe3uOMJ1xRBfb5dolFphFlEvwZt7vmxq/ybsinlip8H/2TYjNXPfTiEGaU6sTXzWeudHwXpRdZRdNM6Rz+7nRULwD3VSzUPPgVt3PVlyTCQ0PpEKE7eQ7TT8H1yOCGhpZcsanuUvND+2i3gAkN2XdkhyOEFNiQmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:49:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:49:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:42 +0800
Subject: [PATCH 11/14] pci: layerspace: Add missing header files
Message-Id: <20260203-cleanup-v1-11-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 184d3e66-ad3f-4ecc-5979-08de6311e12a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?b3dmaURJTmhlZTZSalRZMTA0REQ4WHJldW5GUG5zM2pqL0pyVit2eGhpV1dB?=
 =?utf-8?B?SmpMcDcramhkdDRDY2VYeitzZ3hFSU9uS2pXU2V0RklRSUJoS0RraFpUL2w2?=
 =?utf-8?B?UWNBREFwb251OGJkTk1QVHlvT0NXNjN6TzVENlJYZXdqMkZqRW1JUGFjWk8w?=
 =?utf-8?B?L0dOVjZLRjk4Rm5lcC9GaktUY3Uya0t3LzV6MzFRbXY1Y2c3K0Z6Y3R5MU1W?=
 =?utf-8?B?T2V0NFlUbGxQQ2N5Rkdma3NYRmU0RmdDYVRLVzB5MGl4MHFyRDl3OTV6dWpa?=
 =?utf-8?B?WjFHeXJQNmorKy9LdTJ1REdYQ0gxcHpTdUdSUXBYdFRsWENkeXYrUk42a0JX?=
 =?utf-8?B?UkhJSE04TFhzWVRsQmpZV1hISXVjQmdiRTlJT0VCVDQzeUlQY2wyUXUxVjhQ?=
 =?utf-8?B?eEZwbThXZUFPVm5YVllqNmlmcEpPb3BEZXR5SFhHRUlBekZxS1hPY3d2azZa?=
 =?utf-8?B?aTNaSlFadDhZN1k3bEdEbG5LSXFZTGNDMDkxVFVKT3k0Z3VPOHk4Ymt1MEww?=
 =?utf-8?B?NGxmWkJOam9OTWsxTHJjaHIvSWRUbTA2aTN5VCt1eVc0Z2RiaXhrSHNLSXBO?=
 =?utf-8?B?a1JVYm1YQXExanhnUERWRm9sSHRFVnJCRHlmMzdDYW5qMGdqN2g0OExOakRx?=
 =?utf-8?B?M3JlOWo1aTRPRC82NjI2aUJMOWlYL21PN2hRY1dOUkgwMVR5YTJFZzVUa2Yy?=
 =?utf-8?B?ZU0zNjRQT2JNY213VnVQdnV4Qytkd3pUWEhGT1EvSitFclpvOU9wNmIvdmNx?=
 =?utf-8?B?MzNkZ1o0emtPWVFENFQ5N3prOW5zWEoyWGF2TlpHNlRpeVkrVnhTM2lxRk95?=
 =?utf-8?B?R2lEN1dHUDRrM3JQQ2pVTnEvQ0RwZUhzNWhWZ1h4UnE3UEVEZldwM2VLRmdp?=
 =?utf-8?B?VUtoL3dQQURjQXRQMjFLaHNxVms0S1ROTEZBUVh0WndIMUJtYU4ydUloNEQ3?=
 =?utf-8?B?NFVNQnU4S1dIQTdHeG5Sa2tVQllob29CdlUrelhmUEhwU3NFODBmY29HR29w?=
 =?utf-8?B?RkwyWHNQQlBheFZjWnMveXZESEgyaE1IUWtGU01vSE9uazZuRFRCcUdsL0JM?=
 =?utf-8?B?bkcxc3prN2xlbFUxczF3ZjE0TmJkRHNXSURjQ2hpb0lqbVQ2ZmtubUVrWnhS?=
 =?utf-8?B?OVV2OUlWVksyL1hUSUNYaUQ4eTlFaDFQamFKeHRKcm5qVU5hcUFGOWlyVDVo?=
 =?utf-8?B?NTkvNzhCZmplL29GaC8vbHR5RzFZN2FjOTgzTDVkOXhtb00zTmpISlNKY0w0?=
 =?utf-8?B?V2Uyc3R3K3VLZzZLSnFmSWRkNTJBR040b3JCZEpaSjNzeDRXVFdQVnFRdnlC?=
 =?utf-8?B?aUgrUUUxSDV0SVdzUS96aGMvd2paU3lxU1VYR2dTWXpqRmkreGFnM2NQV3pV?=
 =?utf-8?B?cVVlVnFjRXBMRWU2a2dFMVpnaXlQNklGWTI4eUVETmZkYVhhdUtlN0lBOEl4?=
 =?utf-8?B?T01tUytkclI3Qk1lTHpnWk1icGNlMlVhMXhiVzRHSzk0MHZUVjVtSVcrcENI?=
 =?utf-8?B?RU9RMVpKYjg4K2FPSUNpSEsrcGs2MDVrVUVLNG5HaWY1d3NIVVYzQ2VWYm5h?=
 =?utf-8?B?WnIrM1ltTkxyVlliY1poUGcvUi9WbUl4N1gxdGYxU2xpN2lMTDJvSjFQTjFG?=
 =?utf-8?B?Y2pkeE4yZ3JqRGo2NldCWkNQWVVuQ3I4ZitIWGUxSFhHQmJvV2R3UDlBU1Vr?=
 =?utf-8?B?ZjJCR1N1V1oxL2d3TXRPb3VSZHZIRXVybmhZMVRZdk1aVTBXRlF4bEFkeW9E?=
 =?utf-8?B?Q0EvT0hWbG9Hb20vdmNkNi9IQzlnNlF5eDNPYVY0ajMyV3NyQ0huUEdsVm4w?=
 =?utf-8?B?UVU5VUJGY1RHWlE3SkZhQXA0blpRMmwvT0VydmwwU2kxdHRhRUp6c2cvRXdR?=
 =?utf-8?B?QTJ4Y1dhRUdvVUJiTXo1bzBTZGMxQm9sdHlOQjlQQmpXZW1IRkc5ajF2NG8r?=
 =?utf-8?B?V0JkSWJuTXhQZVFkdjJXQnptS2U3UVhIcGV4ZjN1dy9KNVAxUnh3NlY3WEIr?=
 =?utf-8?B?aWdIbk9hQUY3M3NUUjdKOEdOWEthd29TL0xmb29lV0J0anFNMU1NL0Y5aElW?=
 =?utf-8?B?WXhYdndwTkNqQkxReHhFWXZnSmVMMTF6U2UvRWF4L0RETVg1OTMwQmY1Wmpw?=
 =?utf-8?B?MGcvTEdKdzYvSUh0d1hFek9qSHJhSUl4QXJONXBQSmMyZ0N3V1NkdDBhQkxM?=
 =?utf-8?Q?1u+a9AGdP4J6xZJGvj3zKF62fOSeVKEwhI/XnZI53DG5?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?ZCtwaUxSLy9QUVlndWpFZFdLakQxZkFWRTZvMWdMWXVNS0N6bVVCd29ZTE1M?=
 =?utf-8?B?ZGlYTHA0N0t6Rll0elhkdTM1UkFpUXlxd1kyTUpEaEdTWHI4ODc2Uk5uWUF6?=
 =?utf-8?B?aHhwY1lWWkNVK2EyRERzQ2dxcmxrMEY2ZnZnNnFLenA5aVpuVGt1NUwxWGJQ?=
 =?utf-8?B?YmVtdXJrUnpxaFhXOGdzQzFGcHUxdFJYR08wUDluZjFMNlNBNlB4QzJucHZo?=
 =?utf-8?B?NndaOXp6a25HYUhiQ1p3MStaT0F5aUpHQjlqc0IreURRMWtvSmhXeHFWaVBE?=
 =?utf-8?B?L3Bod1hDcWNDbVptdlFLcXZuSThvWlZsVXZTQWdXUjk3M0F4TXpNbm1XYXps?=
 =?utf-8?B?Vnk4cUF0REpBU05VQlhZK21BMWNGSDRRZVRnT3dva2NjbmsvTmpHeEpyMHgr?=
 =?utf-8?B?ZkE2bnowN01nWUVoaG5Udk9tM0Nyd1lHbENMUG9xTGt0M3JMUDcrVll3VUhI?=
 =?utf-8?B?aTZOWG9XMUJjQ0NnTGRYeUZlVHdzNXNOMVVUNytLMThZaGw0TU5Yajc4RHJ2?=
 =?utf-8?B?UllIODFvQnY1V2ZFVSt3cnUwQzhySGJpcDZCOGNwWDYyUVExWXVSdThQK3hV?=
 =?utf-8?B?MUhpSnE1MDE1TWRYQUtCUHZkQWtaeVlCYjFGR2lHbGZSa2VNMmR5b1pUMmRL?=
 =?utf-8?B?elVvRDJtS28xS2YyOHliekxlM0ZHWVdVUlVXVm1Db2tnTG5oelEyNDZDT1U4?=
 =?utf-8?B?NjQxRWVCZi9oTXRmUmJvVEdWL2Jlelg5MGMyQjZxcjNTVHhWRzQ2RzQ1R2pL?=
 =?utf-8?B?SjFUMXRvOGM2RnNIdnBJZEtMS3Ryb1lRVENjZm1wSXB5Vms4dzI4L3NaUE5o?=
 =?utf-8?B?ZHNWdE9LWGxnV2pnWTVybGxxeGNvQkV3bGRTYmE5SVJCOXdIL3VJZnNsZHEw?=
 =?utf-8?B?ZjdsN2EydmwwYmRneTRBaUQyeTI1M3czRUZkTllUNU1Qb1lPNlN0QXVPTXhG?=
 =?utf-8?B?YmtGZ2k2Yk5SSURlUW9keDN0VnhJSTRSbkpUM2dYZlJhWDBTUWNGWGI3M1pT?=
 =?utf-8?B?Y0JmU0l0Y3dOVlhZZkhQOVZqWDExNHhHbWE1NW4zTUVyU0tmT0tSa3NEVE5j?=
 =?utf-8?B?NlU2bkRRSk94c3hIaE1nWk5SZ21vaDVqTUVMK05UOHd0bGtPcnJJbGNlYSto?=
 =?utf-8?B?MHMvZVpkR1N5eHRwU0RjY0tmdjhWRWw2ZWFlY203WGp6NWZETVpFNU1Xb3NH?=
 =?utf-8?B?U0RiWmJxdnZHK2VjVTZZV21MbERCdGZMNVBJTzI2T2JnbzAzSm1rWVBrMkY3?=
 =?utf-8?B?TE8xL2Y0S0YyS09IRzQvYXlxdlc0UGJXZzJ1MW9KNWtkMEhnay9ZMiswbGRI?=
 =?utf-8?B?cDQ2b0JNaEFGbTFzL1FjVFY5ejRUaGF6UzVEMFNuZ0k0UzZJcFhyaXJuU1hp?=
 =?utf-8?B?WUxiNGhaaERuZGFXK3lyUzBZL1FpdVJ6OWM2dzJUZmNYYmxNNEZjMlNma3k3?=
 =?utf-8?B?WXBOMzdMVUs4eFJkL0NBK29kb3FOZ3VldzZqQ0FjSFFYcUdNdy9pTFpZWDl2?=
 =?utf-8?B?QjBORjhxQ3JPZklJUVR5YjY0VXZNb1FlSHRTUXBQQ2tLcjZDU1FmQkk1QUk0?=
 =?utf-8?B?SUxIQ0lYVXVpYjNaeGxmMis5UlVzdzA0OGh2MjlKb0NjMW9aVGRCMUZSMDha?=
 =?utf-8?B?OEVJczN1VG1mdC9tRy9oRXFXQVdGTy9WZU1OQWEya3ZKS3dyMElnMG1ZODkx?=
 =?utf-8?B?NXhFNDhkcjNpTjhDdVlEUEcrc1VhenVBYlF1YlZlVGZua216REc4eG9zSklI?=
 =?utf-8?B?NldiMGllYlNKeW5kUjI1bmxncFJ0Sng4L2x0cHVEUDZkSlBZb1RNd2I1Q0Fi?=
 =?utf-8?B?UFVnRjBIM2ZnUFE1UDBaaTU4cDVuSVl6Y1cvZjVONFpwNzZ0ZG1kd2RXN0Vp?=
 =?utf-8?B?YVMzcXNaN2dmOHpFT3hLQ0o4K1NONTlPQTNEN1RjM3Z1UjRaVGNac2s4RkpT?=
 =?utf-8?B?b2pyV2Zsa2sxeVBXYnk0QzU4RTJ0bE9NWE4wNDRVR2RLLzRpWVFSbHNTNkV4?=
 =?utf-8?B?blpSZmpQaThRWDBNM0V4Y2k0UjA4UGtqSkNHbTJ3bkV2dnZFQlJoclVsdkF6?=
 =?utf-8?B?elRSMG5mVWdFTVJpV3F3Tmo2M2U1S0RremxqUDNXcXR4V21LTHhYOE9jSVpZ?=
 =?utf-8?B?OWpvd3JBM1Z5MmJOdWU2eDBlYkhhaTBRdUFvSWNJWDNkcmpaQkZMTnQ0eXVm?=
 =?utf-8?B?VFh6QWJtbHNWQTNlMmowbS9FK096L2tLUGVWQ1ZidVVnWFlSSmhFdHZ4REdG?=
 =?utf-8?B?bXpwN0pCMGlGSmVzVEJYbWQxZDU1SWpQU1dLb0NjSzcyQ0tEUTYxc0hNb3dr?=
 =?utf-8?B?c1hYMGM4dzM3eVhVWUlLeGlhK0tyenk1UFpGZ2tGdEpwR3IydUtyQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d3e66-ad3f-4ecc-5979-08de6311e12a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:49:17.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqfQiKY6zxTH9Zjvfle4iU64LrmK1u+muhM3capXDozyqJMmhiohr100nS8nNIbMMSer+DZVTWyL6XR0vLlIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8989
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2889

From: Peng Fan <peng.fan@nxp.com>

struct fdt_resource, u32 and bool types are used in this header, add
missing header files following "include what you use".

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pci/pcie_layerscape.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie_layerscape.h b/drivers/pci/pcie_layerscape.h
index b7f692f645070ad594585dd177df9c66a55e80d2..d5f4930e1813bd570a6d5106c11f2ceaa74bac2f 100644
--- a/drivers/pci/pcie_layerscape.h
+++ b/drivers/pci/pcie_layerscape.h
@@ -7,9 +7,11 @@
 
 #ifndef _PCIE_LAYERSCAPE_H_
 #define _PCIE_LAYERSCAPE_H_
-#include <pci.h>
 
+#include <fdtdec.h>
+#include <pci.h>
 #include <linux/sizes.h>
+#include <linux/types.h>
 #include <asm/arch-fsl-layerscape/svr.h>
 #include <asm/arch-ls102xa/svr.h>
 

-- 
2.37.1


