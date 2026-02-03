Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63116E83F1F
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14677.1770118475592248382
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:34:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=R1i783MX;
 spf=pass (domain: oss.nxp.com, ip: 52.101.83.4, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRfgmZS8nSbpM7w78dLBGgeyEwdDq0Eo+lgx8XNOvo/W+3cD8E55sicQN9ptUl7nV+s0f6bnadzXZckCIT6K2WKpQpo0Hh2smvKcCZESDk0OT+n2sA9eEB294uCwKiAFvOlH/bDyABiwcCV6n7yrOw9ra7I3sJwTZMo+yx8mO1R+LdThg4fr4aUYOPwfw1DfC+qTogMvB24bjKOto/VVYGSyLGNtdWXCzismgZf8JlaJ8IgwPaEqbLDt4yDSTJyDtUNIh5GwXxhHrGoH/kyQLQGxkd+Td0MsvY8vErH97W2Fm6+YtjOi1ptKmDxkfWRP0oaXn8IbHz7cgayAWhSW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfNIjXlzFleMlM5Sbj+07/Y7FJm025AMJVxfxnXJVNc=;
 b=dtQjPHqWxKl7gj79MLakq5lqazcmvpdc24Wj5qbsk9dWrjK2wzSaPLX01Cwjl65bTV7UbghQFFd+lbFrXR7f1xgPErFJ/BAmBtgUDReDIc6dVgjip5D6EzOaSDKrw+kd0n+RsSCPMQ5JddbSIelUfyGcyn93ifEo92O/Ud6KJTv0ytG2xrHOgbEYIwQPmgNKHrK0ph7YCrsMuPUhOHLdPX5DZe8750kMtR8zbogQz7Brsa9aGIV9EhLMhTfJG9tLlJUqvK18zPJBtMnoJ/K7U95M8xule2mJumyx2zCgOJCmjv2OYZAzuGl/zr/IwGdMlu50t4+viu6wk2fyJ0fMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfNIjXlzFleMlM5Sbj+07/Y7FJm025AMJVxfxnXJVNc=;
 b=R1i783MXFDCSq9Xu/k++BhoqgINdUK9s/6+S4xAmEsysmFjczxGAnjxZZzMQkdrB8AjZVYTNiY4UsgfUDQF4fc6I7up9odJqNE4OSOoQlMd/nq0CLVyj1gmPui6kchADyylz3nLbwp1LpKaYD/r3ARwPx+7062hklVW9b4Tyue4hTU6/DUOYJNSLiaQG9KeND8SBgSXtEPBXWdDH69qLbdfmgr2lB9zMTxP+i5fenTNpCQg0BXiY7uDFU5h0+sTNHTqcdkrphoHhWXrPDfiddP+7YVM7mvR3ZmoKxqyAH6RFugc/4gSDgSprwSVLVnimEOuW7zMyv8o3y2sAvVsmew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9125.eurprd04.prod.outlook.com (2603:10a6:20b:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:34:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:34:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:08 +0800
Subject: [PATCH RESEND 04/14] cmd: mem: Include vsprintf.h
Message-Id: <20260203-cleanup-v1-4-732e986039cd@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 691f8642-2d06-4415-9a3e-08de63182f5c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?VFYvK0RZUXRnMVNKWWhQZnVEMTd6YUtqNFd2VjEvaHAyRldVMkFleWxVL3Jh?=
 =?utf-8?B?Z0ZudU5aNkdpamNHUm9DV1JkR0dZSG9OWjlNL0ttdFJ6eDBKeC8waXo4cVB0?=
 =?utf-8?B?Y1pLbkRsRTQwOVdaeDU2ei9XK0JBa2pTR2hwRkpVanF6UXNYdmk3WVU0Z2Mx?=
 =?utf-8?B?ZEVSaUY1YWlSNVRqTzVBR2NBVUFnNEw4bnA2cXNxYitESmEySmdPU3M4S0FO?=
 =?utf-8?B?eWp3blQyV3pySXBKaEtOazhUWWMvN1pSN1p3bUp4d3hzRmNCNS93ampWRWhv?=
 =?utf-8?B?Y0ZMa2YyLzdsdjAxNVZSTXFlek45VUxDKzVDeDV1dXVlWlRjK1VVOE9vTUVU?=
 =?utf-8?B?Q01LVkthb1VDa3Q4bFdpdjdxRmtmTnB5dXpEOG1LcVNtRXBQQmRrdFFSWS9o?=
 =?utf-8?B?aVNOTC9YRDIwREF2VFJ6ZjNzRTJ5bDhabGQ1SHVrMXE0MG1uSlNDVDg4eThC?=
 =?utf-8?B?aFFmbTZLaVRmbzdrcmFZVmdNbnk1MjNrWDgwZ0Q5Y00wcWlmL2cwZzFTQi9X?=
 =?utf-8?B?UloyVlhralMrVGFhU0pibFBDRC9zVHpIN1dvSzJjVmdzZDlWeGlQTmZZTzRz?=
 =?utf-8?B?ZE1vcjAxdU5QVjg0blg3bys4RVdnS0QzTFBHOXZVOXltekgzaHNpVDFLUkFs?=
 =?utf-8?B?K3pzOUpjTWptb3Uyd2lZdXBEcUc0Z2NmN3ZBdjdGV0M3aWtZMnNBSUVUVGJs?=
 =?utf-8?B?SXNMaDEvVHE5VnZOTTFpUXhoa2dpYnVSUVhVWGhwOGJJUy9nSFBQVnVaSUIr?=
 =?utf-8?B?b2w3d29iWGd2bnVoa2Vqai9WQkdSR1o4aTZTQUxCczRlVm5zSW9oUnp6bUdr?=
 =?utf-8?B?Sm9LQWV5YUhjTDlrWXlyNURUK3ZJd01CSmpFMW1KdnUzU0VHcDNQdmVMS21X?=
 =?utf-8?B?bHBKSXl6M2R5ZHpxeTdnVlJ6anlEcmJ4SVBMcWZxYndKRVE4bHVTSi85VDVw?=
 =?utf-8?B?Sy9EQk9FV0s4aUsxUFdhclZhbkhQeW1rUko3azZ5MDR5TzdCNFdIODkyUElm?=
 =?utf-8?B?enpUdlJMREp5YWpTVm5RZXpidFMzbDVzZkxuSzlITGpvb2E1SnZjalB3Vmxt?=
 =?utf-8?B?OU01a2lUYUFQNVMrWHl1OFlxNUVhbU1rS3VCc2F5QThNckVNNm5wSFhSV2hp?=
 =?utf-8?B?WVpFZFYwTlAzMmw3dEszSjVjWnR4UEJaeXg0TjU2RmVDb1VQYkd5aFpkS1Rw?=
 =?utf-8?B?YVFNYlRwRVZWVFhkRGJrcUpCamtUUUZWSDZjWTYyZ2NpbnBOWnFNZ1liWDVS?=
 =?utf-8?B?VjN3cEo5MmVRdWlWVGhrZytVUW1xSVF1WFR0QjVIUy81YXc0Yjc3c0Y1eVpr?=
 =?utf-8?B?djcyVlZuSmtFV0hRRThLZ0xOSlliMHFkeUdwbXVHU0hpenl2QkVPOGsxcTd4?=
 =?utf-8?B?RU12QitJdmZmWTNNTTczQ29SVWRuM01mamhjdlZORE4yM2FLQmFMVzVweThO?=
 =?utf-8?B?UkluTk01eCtNOHUzZ3Znb05ScUFwWjdPOGYwV3IwVktNaFNFcSt6T1M2RlJX?=
 =?utf-8?B?MC9kODlPZFZnVUhyL29IWkhvbHJuREY4ck9yWHZXb0RIUkw3d3VxTE1HSjBF?=
 =?utf-8?B?elVMV0FMOW5VRW5UQjUvQnhCY2NzMG1BODI4cTlkOFEwbG56cVdaR0liNmNT?=
 =?utf-8?B?ZDI5VWdWZjBFVDVEVDNtR1dXVUZPZWRabHVLY1RqSzEzREh3dXUrUVlFMFpG?=
 =?utf-8?B?WktFQkJxcm1wVG5WTDNXUkptS3VrU0dGTzNCNW9wblROWWYwSnBhR0pMQURo?=
 =?utf-8?B?anNhcnE2T2NyVDJVdmFSeGZDaEpnNVNIc3o2T2tFS0tZemJzVUpwMVpzckxK?=
 =?utf-8?B?T0tmK0N1UzBqM0d1K0FOcjBWa3IwaWgzZWhoR1hIKzVkMXR6NEQ2TkNubDRL?=
 =?utf-8?B?aXB4TEJtNlRTc2o2amQyM2xxbTRRWk1QZVJqN09NWjlXbEREZTQwNW9UU1FL?=
 =?utf-8?B?djhoaUhLa3NMb0FOQkU4VEtrSzArSnNWd2RsQUZ4RitBV1FrOUpLU2lDZGp3?=
 =?utf-8?B?bUszb1BYUVpZTXl5a25PNENQSkxPa05qaE5rRWRhRnJ4TDBOWnFlMXAzWmw0?=
 =?utf-8?B?bkFqaDF5V3lmV0dhNUUwUzRiZ2ZUWWlHWGhBMVdJZmx4WnkwOW5ZMlBNSnYv?=
 =?utf-8?B?RXgzM095R0RsTmdRaEVaNDdHUUw0V3V0RXNwc0NWWVV3bllraThuUmpWaHB5?=
 =?utf-8?Q?HkTZwJTeCwPzfMcyPZ3XwA16HyNnL/89nTvmgrgPaYGe?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?UkJ2WDBJS0lGR1VmdGM1SnF5WDUyNFlGVUFFM21tVjRYUHhYSjVxOEZva1Bq?=
 =?utf-8?B?bkRKOUs0RFFpRk1mYlkvcEVkaGE0L0Q3T1o1VWN2VXFDbDAxZi9wZFJrQmpM?=
 =?utf-8?B?ZVRQV3ZSVnp5UDBjcWlMM0xIVkJtaGNkWmFUbmlwTUdIemhvQ2tEOHp2dlMz?=
 =?utf-8?B?Wjh6SGx1L056NzVvNDdXN1FpVTdoS0J4aVg5MkRqcFRRU3ZGbXFKZW5uM3RS?=
 =?utf-8?B?VDBkUlk3V2kzb1cyY0ZlWWFuMmtnT2hZQXRmZjkrK1UyUmdDbDBjNUI3NjNE?=
 =?utf-8?B?Q1dPU1JsV3prcitDLzM5SmR1SU1IMXNiSlhCSEhIcG1oMzFGdUtsbTEva1Zp?=
 =?utf-8?B?Wmp2cE1KWWZTSVk2ZDg2bWJ0M2txa1BobjVnT0JLY1hvelJRUkMyKzFyWkdV?=
 =?utf-8?B?SnpOeUxKVkVQcDVFcmpSQlRLdWFnVHZhUmF0QzhhSURSYnZHY0dvMjMzMXhS?=
 =?utf-8?B?L2kvM0RDN3BqbXVUTkJaNDRnQVBUKzdzalMrWDhvUDg4aU9SZ2ZZNkRybFVQ?=
 =?utf-8?B?OVR6V1pQem1UQzFaV1FYT1dpQzB1bmx5a01TNVBpMXFOV1VZOXdBWnh6N1ZV?=
 =?utf-8?B?N2lZUnlwVEFYZnFNamdCc0pDOWdSU2xYUE9XdFpmWXdJZ0NIOVlJblJjbzFm?=
 =?utf-8?B?dnVpR24vUWRqMHZ3V0MvcHNtZUYzclp4NHFNSHRZOEV2UHRVRVR4QVlRU3FP?=
 =?utf-8?B?VnBVa2hLdS80ZWNyVjhVZDd4REJYamoraDUvRS9WU211ZjIxcnlBaHhUM2lQ?=
 =?utf-8?B?SWF1b294M2YveHVmTEtrWEZndFBDYmx2R2RKd3gvbG5ZOFJ6SW9UYnUvNTR1?=
 =?utf-8?B?bGZZYlFIVm9Kd0kxdm5PRFV5YnpQQUhzcHN5Zk5kTnVGMEdGeHdZN3ZiUFVT?=
 =?utf-8?B?c0dtak5qTW9ZUytEOWh2NGdGZTVXTTQrZ2RwTkxUeGZNK0xNODU0QlU3VS9P?=
 =?utf-8?B?Y0FWNE5aWUlKb0lnYVgwOGV5MVphNDFSZER2Y0F1aWxRRkZ3WE5aRUMxbXpn?=
 =?utf-8?B?R3MxSDJ6azdLdmt0NnBMdzByVCttSDVWZHc4VW9yTlV1YS9hNnNoUTB5QjNs?=
 =?utf-8?B?RWU5T212dFNPa05jZ0VxczdaWlJiU1VEWjFieWFVcjBlaUJnNEEwaEg4ZElD?=
 =?utf-8?B?TmtrRGVBd2NDc2xUMVhwRE5ZTiswQTVkM1IyNHFpUWE2R004SWdrbkQxYzhl?=
 =?utf-8?B?ZDlyMkcvVWczbjU4eVdTV1B3OHhiMW1VSE9GSWJkRTM2UnFuTUw0RGlpWEs1?=
 =?utf-8?B?b3dJTUtCamQ2T1J1UXg1eUR4TzNINFlqb2pqT1pYZjJiWEhHYStWejMvZUNR?=
 =?utf-8?B?cEVveDVHVXRwV013d1A3L0pOUUV1R245bFFmV0I3RjNnUDl2NEdQTy9SYzV2?=
 =?utf-8?B?ZHlDVm9nZ1Vucm9XY3ZBbHcrei9kaHhiZDhpQmRlVVNFbXhMZnVXMy8zNEZO?=
 =?utf-8?B?b0xzZTVMb0FiNEhmMHVIejB0SGVjU0VwbDR2L01YcmNIRWVPY3Z2dWQwY1VK?=
 =?utf-8?B?SGxEZ1ZhbjA0enFwcTB6K3NJZjJpNW1hRElyQmUxTzhDUlhCMXo2OVpYVGFG?=
 =?utf-8?B?cG5HR1lCRE95VHZnVS9iZTVFeVNpUjFzTHhpRWtJVzNPeWs3YTNLblVkcTlt?=
 =?utf-8?B?ZEtYaFpxS1VJT1lRb2Q5bERDK3ZLQS9GaWhpRThvYmJHTm5QdE5sMUxLVXlD?=
 =?utf-8?B?aHAxcnQ1MlV5YmtQcHd4WUJtK1VPcDhwMy9Hd3p5WUJDS2JZQVl2d25mNmVZ?=
 =?utf-8?B?VXZUSzFoRWNhY2xVT1c1MGl2SzlYd2ZleFBGOWE4aW0wSlA2Q0g5RERzMm1o?=
 =?utf-8?B?Y09FR0hNcGkxb3FKMEd4VzQ5K1hreTVROUw5N2h2UTRXbFdQckdwVjk1c2l3?=
 =?utf-8?B?akt2KzI5SHluWXhqdUYrUTR4d3FkMXRFMUZGY3ZuSmRwSGxCaDJOQ0VGWjkx?=
 =?utf-8?B?UkFoeS9sVjBaRkM4YkpydW5iN3ZhNVdqL0ZoZ2dZaFgxd0JrbnUvUUdFaVh0?=
 =?utf-8?B?Vkgyd0ZDcVUwL1BSRllGTXRsZXFabXF4dGxVSFJZQXVmd0JFcmFhTzhSQnNY?=
 =?utf-8?B?TXBldU53eTRnM0VCVG1GV0dyRDZRMzlvSTRLQjVaV0tJQjlNQlF1MUNNT1Ni?=
 =?utf-8?B?WS80ZjVOazdsMC9NcHMrcExlOFhpOHV1WW5FZlFCNGpqNjlveTE0QW9KVDdB?=
 =?utf-8?B?SVc1U3h4MXJqVC9URzQ3NGdLTnRrQVdzRjl1K2VPcFpnK2FNMkFSdVNjWjE0?=
 =?utf-8?B?N0FGbnF2OTNHcjVIQUVJMmhCZjVxNkVPRHRqZUoyUmU2aXRUbC91NHZjWFVL?=
 =?utf-8?B?SnBTNWxEVDhWV1FGaGpNYmhFMkhYVmJldWszcnB6WDZrSDJjOURZZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691f8642-2d06-4415-9a3e-08de63182f5c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:34:26.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9jugryXPHxmbjlsUbJ5wWdUpRaO6RDS3nbfG9oPyQ/8QFP8HfyYzCmFEHtY0LUfc8rtFv9fZdasEbGVwqAouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9125
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2905

From: Peng Fan <peng.fan@nxp.com>

hextoul is used in this file, so include header file vsprintf.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 cmd/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/mem.c b/cmd/mem.c
index d5d7ca2790bdf2d100606963c0c2d48b1c6b6978..8690fc1e4e6b93d78b48cf4c080c7f52bf2504c8 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -26,6 +26,7 @@
 #include <mapmem.h>
 #include <rand.h>
 #include <time.h>
+#include <vsprintf.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
 #include <asm/io.h>

-- 
2.37.1


