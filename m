Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED85E83F1A
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14578.1770118428934829243
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:33:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=s8Ho8occ;
 spf=pass (domain: oss.nxp.com, ip: 52.101.72.14, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2SPUs4hro8l8/rNiVqd7jaaPBT0KfvgJY1gFjA0WI1jkHT07cf1UsmG30213PLN4gRRExYaqN9bmtGp2Rd0PiuDGOSuN/x5a67w++Q1JbnpmF0zcmiC4kWSbVXZix4phNwVCO23jdQxjRVVvmBtbEmHcHTJe8EsYr9ga4JXemjovYDKrcuVJR+cOgBVzJ9eNSPagdmFnyRmJl1K99nmnkkmP4lvbypmwN+Mooc+egvj1WHqd9tHMee7dnd1cb3wV8wbjOVGVKG+WgpuVrzKlnDDy9cK2jHBZck0F1b43dkdBu7+FnkeUpzAd7To6yL0orU5XQq5+9d4fRovasQq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxbr7uyv8Xqm+u1OsX4NFT/MEzMSpSPFOaM6+KTG3SM=;
 b=V9d8emNnG36Rkrze+XOmjjzuhh5hNy5JpSI/P+i2asgFXqFod2z8q5gcXTqKbeoOp23cpwcRYqp6nMlb87KpJMFbpTXHk7Zr94r1C91m2a7ZtskoE8nNlet7TWT2mPx8Z1qz5cl0KO5diQvolr5BZfaUqN1I3nGJ4u58KPM3IN/UoisSPE25YjjE/8zVu1GllUjU7nPmf3TT87RA+O4+nslF/sgaK3GJR4LCLsYXjmMu4B77yNUHn8nHakUBcmfINUFPG9nhwoZJoIFtks4hp3AtgD26oGK9At9St/gdlwrFWcxodqVrWKJeJoL3WWwzGQbND2uZgmC6LdUSaJmzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxbr7uyv8Xqm+u1OsX4NFT/MEzMSpSPFOaM6+KTG3SM=;
 b=s8Ho8occyhRin4Qbp1RkHNYML29XH0dVtplZ5x02MVzl+5HnRT3VIjPlEq79q7ZDzd33u7ZtUklnh3YLbN+CSH5plM+PYJOelTmYi3T7F8fPOBaJq0p4QD/e4OaCo2i0dhBbhZ09bcTBA+rpJGQ/pTn4pPPTDfq1oEP8z8hSCwEzQVJFZkZyuxdZgB8d2FodClKcARw56fHD/kH60+hRJkyLq9PnMnzyORhYHJifIzIfHolcOdkl3hsAkPi7Ro/1vzf3PrL+iQjxIazJIEodta2WxwocVYx8JfcOBG3Rm+qUVA/69uq7ZzvyVORkogLfc/779otN1L2w735B0JTz5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9125.eurprd04.prod.outlook.com (2603:10a6:20b:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:33:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:33:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:07 +0800
Subject: [PATCH RESEND 03/14] common: cli_hush: Include vsprintf.h
Message-Id: <20260203-cleanup-v1-3-732e986039cd@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ee54c42-07fd-4d4d-e812-08de631814c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?K05VaUJ4cG82Z3FLVDB6aXEyUERhNVBYNDUzT1JuL3BFWXJldVdrZlpDUGI4?=
 =?utf-8?B?UUZsaFdxTitIU1MwYWNsY05Cc2huU2w2QUxVeWVOdGFPV1FKeDBDZXlrendz?=
 =?utf-8?B?REsvSXBISGNlV2NtelpBMFhzc2hJUnRBdlBqOFhzaWRYQ0xjK2lYM3hnL1l5?=
 =?utf-8?B?cDBYUjJkMjdwSExYc1ZnbXd1LzZJSXNCTUFZcDFrYjFWZHZ3NGIzUVdCUVhw?=
 =?utf-8?B?U3pYRUgvckRreVhjeVNLSFVocGxxcEYyalJZQWthbm40QlNwREpFOSsvcGtu?=
 =?utf-8?B?cVhzQ2ExcjdJY01qYkVqd0poZ2h3SC9nb1N2dWpSMURLd21DZWFPUXFaY2JL?=
 =?utf-8?B?WlJrN2NkbHFuOW04WjNDK0pYeC9kZUwydmNtUmsrMk16eXozR1RxZTRIOFUw?=
 =?utf-8?B?T0ZUVXo0RDNJTGNsOE94aGkwTktIS2VmWk1nekFMNkk0THRVVWdVUmxuSGtI?=
 =?utf-8?B?clVDRytYODFJQmRDUWo1UmR2MUFYNGJBbmdscU5PZWNNSHlIeG8zNVFmQjQv?=
 =?utf-8?B?cVBBUURsNUJRaFNOOW5BMjhoTllCbzNJYXg3Q2xQLy84REg1QnBGRENuRGpm?=
 =?utf-8?B?WGJqOG5YZWNzTUhEOFpBL04vaGpKYlVvdXpYK3JYQkNUb0hIYmhIdGVQTjZu?=
 =?utf-8?B?dFhmMFhMcHQwc3BzMFcxMllBK2t4c01PSFRPbTlSQm5oZDRuK1MrVzg0RnJL?=
 =?utf-8?B?V0RHZ3dUWWpxeVR2a2ZmbU5pWVh1b1R3UVIzRkpHSSt2TlZxcS9CNDNCN3VQ?=
 =?utf-8?B?b2UvejdVT1ZIcUZUSUVyNjN6eEh6WGNLRTBPdnNpS0F5NmszSGIrSVlCbU4v?=
 =?utf-8?B?T1pSaWh3SURCV0pkeTg2T3VTQ1pTc0xPNTVWMkRlSGlITkFKT3V6bjdmUUIz?=
 =?utf-8?B?K0JoNjJETjQyRlJkRnpmK2dZOG16cks0d05LYVdkNnh4SWtrY2tHWUJWRnN5?=
 =?utf-8?B?bDlGQjloMmtmMU1wWWtIKzh3M0xBTmVjbDVDV3p1YXZodDNoYWs4UTRXaXdJ?=
 =?utf-8?B?MGtaTldRb1c5bk1uclJUalpNeXI4R2cyNFd1bUd4aGEvYnJFSnlaQ1IxWE9F?=
 =?utf-8?B?UUU4M2dvQm1hQW5lTXg3RnZoZjU4S2VTMlNHZHlHZDY3eWpzaWhRMmE4RnJF?=
 =?utf-8?B?UllkTjQrVWQ0OWliN2gxbWhOTFExcUlLUzRnWldtV2laMHhqWHpJNkZvM0J0?=
 =?utf-8?B?K1NnL21ya2hmcFprM3hTaTYwOE5ac0Zvd0pIOTRyMXNCL1BZU0Exak5YQnRG?=
 =?utf-8?B?bm9ORElSamxQTVBpVm5hVk9lTWlDNDlYVytCenpZQ28wZlFzUEp5WlhjWnpq?=
 =?utf-8?B?VEZtTEllRDFyNUs1NnY1VURFSk9reTdQNElTQlMxb0wxYytsdllJbko0UnRn?=
 =?utf-8?B?bUNNcjhpTng2WEVtbGRxMzRmc2M1SCsyeW1GeXh6aGpjbUlXOWQ3dDZoZDYw?=
 =?utf-8?B?U0hVNUhEeHozS3FGOWtIaFNMTncvN0k1NHJiWTlFWGl0VjRMUTdYUUxyWkp1?=
 =?utf-8?B?eGExdkpGdHVoZit0VmVVWnVtREw2ck1XMmRXNXpXejdKSE1BblFVangxQ25I?=
 =?utf-8?B?TmlKaEVqU2NvMkx1VTJlSFRZU0NBenJSWmhDaFNLOEhyM2hwWVFuOVowZW1P?=
 =?utf-8?B?WDVKSWUvZVN2RFFqSWR4dldjN25vQ2NyK2Y1aHNEWXFya1haS2JBc0gyWnBh?=
 =?utf-8?B?WU1KUGIwMkFFbm8zVVFFcTkvMU5UQkxtU0tuMTMvWXhUSzZIQnFBU1JGWkw3?=
 =?utf-8?B?SGVSc2dERWVOTjZVRmpxcnJUbEE4b3IvcVhYOWNiRjdXVzAyNVQ2ZGRiUGFJ?=
 =?utf-8?B?YTZzZnBPWGFXczVjVW1HY3lxSENSMThDNWRCd1RQTktYNVNYb0lCMjRGaC80?=
 =?utf-8?B?anI0b0hKRVZTb1JyWENYVVRTb05LRjhpTzBJUWhHYjc4ckh3R2RvQm8rWFJW?=
 =?utf-8?B?blV3TWJKVHprZWJqYzd6K0JkbVMxSmg5MTVYanV0QWtMT3liek9VTUt6Umkx?=
 =?utf-8?B?d1M0TUE0SVcrTHhub2VwZ0ZvbjFVcnk1ekp2WE9ERHRXTWZJMSt1RG41QjBB?=
 =?utf-8?B?dU16TXp6R2NCZTNReXZlWDQyNFNGd2JuZXhYRUt5S1ZQQklTSUtYc0JoYTlU?=
 =?utf-8?B?ZTJmdTVpNU1CSGQweTBpRXg2d0FVTmZMRFQ0TDZja1dWUGVCZU1WTXB1TjNE?=
 =?utf-8?Q?LGId6Bbl2Xbyni3Ub1HxF4ui8YfKohGyq+9EBKyOxhVg?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?MGZhVy9QaC9qNkl3VER4YVowa3JpMllhQWJDZkNHdjZscXFjbGxqMmx0SzNW?=
 =?utf-8?B?UGJUSkdmRndqZVRwT2lWRGVjNmJxVWxPNUNST0RoVkY2K2Y4R29ZS2JSRHNS?=
 =?utf-8?B?OEJUaW1mUjc2dEVHYnNUUXpZWldEcDAvbmx0S25nV2ZONzcxUWIyaUtIRzVP?=
 =?utf-8?B?TkRBM3hGUGtTclZBbXhjUEc2VTF3T3RwWUFTRWh1YzA4a043d0xRd3ByQUU2?=
 =?utf-8?B?WnlsanJ2bE5XUjhqQ0VIZUlYQU9XWkIxSktHbnZCbkhBUVM3UkR0OVJwckVS?=
 =?utf-8?B?MmIvKzE4YlJBdjQySUtYM2JjUlpXdlg3RTB4bTBEd3UzZ2dUSUp3SFo5bFlw?=
 =?utf-8?B?cEdYR3ZoVmVRaEtsRUxHYjZ2NkE5UDVsLzdibnRSZW9LNlRJcTZIOHF6NjJp?=
 =?utf-8?B?SzV5bEQzeVgwV2YzUnUwUHhTby9DZmRMNEdHOWNvaTBQRnl3a29LRyt1ZkxO?=
 =?utf-8?B?VHJmdDZkd3pDWWpJend3NDBZTHJDUTR6OXdUMFlYeXBSNGw2aXhSODVWZmtP?=
 =?utf-8?B?ZytiZmpPZUNZUzFKVDhjMVMzNHJqTVFLOWtSSFhNcEhqZ2E2MGRBWnJwTFJS?=
 =?utf-8?B?QTdoUUl6K0ZUdWd3dkw0WmUrTmljZS9DM1BBa0hWK1NzVUJkVzJGazE2L0NS?=
 =?utf-8?B?VFFWdzJObWlNbUxvUW0vL3E0N1pFSUxCZ091NDZVajFqS0xUem5zaHJBUVFL?=
 =?utf-8?B?L0kzNksxZHBsbjRsODc5Y29DV25wNG16czlNT2U3d3A4YXNBTXc4emNFdERi?=
 =?utf-8?B?Y0UzTFNsaU83TkZ3MVUxczIwK3F6VnFVTFI2YVd5MWUwOHNIcjJyWk9PS2Za?=
 =?utf-8?B?Q1F4SWpaNE5GMXpYOUpJcnlzai90NWppYW4xNTl3Y3QwYkc0MWg3R05kWVB6?=
 =?utf-8?B?NEVZUHRJeHlZQ0FtNlFKbFg0UVYrNm05bHJvaW1qZGxnR3R0eW9aMGVXVXNU?=
 =?utf-8?B?TjM2bUpINWEwenpRckhxRnVjbGdISElSakpsZVFHT01hOVIxZ3JROFVaQ3JF?=
 =?utf-8?B?ZDY4azYxOFhoQmNQQWJxUC95cXN4Ukc4MW9mK2hVZ1lzWitWSUIwcTRLcDh0?=
 =?utf-8?B?RnlrSXRocWEwNkJrakZSdEdTY2R2dFBiN2dZanFMdGlDR1FOb2p6ZVJiWEIy?=
 =?utf-8?B?eTZ4aXBiZUpiY2dNYTBuWFk5amwzeEdNSkFOWjFVOHZYb1l5QnpPejNVZTBj?=
 =?utf-8?B?WGs3OXZVWFNUYjNTODh1bkFsQ09MTnNob0x6cmRJWFBMSEczUWdpQnFpdGNM?=
 =?utf-8?B?eHVNTFhLVEFnclZaSGtkc1RUenhkZTRGN3hwOWxHMSs4dXdEMzZSTWVJTVJ3?=
 =?utf-8?B?SHd5NXl5SjdFZk4yTURPU1dqSXowNFphSFVWOFZxRUFMTHNwYnJ1LzEzdGlq?=
 =?utf-8?B?Z3FvcWdFZG1aRzI0dEZ5SWQ2cGM2bXltZFdxc2FzYkJ4U0JyS1dVNlpJMUxk?=
 =?utf-8?B?UGVHYW9wV3JJNmtKM0xxRWJnY1ZraFF3VExWRmc1bGVnTGRwOEhrbUNOM1E3?=
 =?utf-8?B?dVpRYWtDcVNiWFZLWXJmLzRtUVZBRkhHS203WVhmSHVuQlBZc25aR21XZ1N1?=
 =?utf-8?B?WGlEeUNZSklMUVVoN1NyUHlLRlJVYUFqVGo2bDkrbzZBN0RNaURibWtCVjh0?=
 =?utf-8?B?azh0SC8xRVZxK1NRM2s1dU8xdXpJdnZzMlFkUkJNV1BMZ1l2VGtUa2krQS81?=
 =?utf-8?B?Wk5Ma0RaanZDK2ZTN25LYXNPaGpnNkMzTUdPWFdJbG1YWDJ6VHROaHZWeXly?=
 =?utf-8?B?U2l3TE1NcXpRREVlZGxEOXFOZ0wrc0lhbmhHa2FybkdFdDg3UGlSUDNWc3pu?=
 =?utf-8?B?RGlvVnVWK2IvT25lM1FOTDA0QzB2Y0N6bFFjdU1FZkdkTjhiNWpjTnJRMnBO?=
 =?utf-8?B?RGdpNW5GUjBiZjFTL094UU5WN2JpRStrVUdIQ09CejZ2THI4T2dGbjhXZWp0?=
 =?utf-8?B?WlhPcm1LMXd5NzNuOStsd3hFUjkwY3ZrTFdBTnZ0ZzBCems4Y3hnWlUwRURp?=
 =?utf-8?B?aE1FdGw4bmEwcjhsUndXT2NSMCtmRXc2cjhublBzYXRQb2hkZVc0VGxJT2RI?=
 =?utf-8?B?L2ZyMnVNQ3ByQWtlSWg1V1BSam9CTHZJeS9hekRvZEpnRWlBYU51K0ZTOU9O?=
 =?utf-8?B?bmQ1VGNnM3pWWDRvSWFxNUdNRFBZODA0Zm9ja1ExNkVVWWlidHNISFpRKzRh?=
 =?utf-8?B?aDBmWnpRWHM0NUhPRDUxc1VObTJWWnphTE91SHpXZ0tqcUxwU2FlWGxuU3BJ?=
 =?utf-8?B?ejkvUzFmZHJvWEdjTFhONVM0eUZuN1VUc0JLYU1YRkJadWJtbUd6U25hS1gx?=
 =?utf-8?B?dFJieDVWNXZaZFI4b0Y0UEthcGlnTUh4a016NUlMT3JyRityS1N5UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee54c42-07fd-4d4d-e812-08de631814c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:33:41.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBNiMOxU8NdKmw5OOvwf03AVMWLOpDtlEVP34ivWkCdk4lYck5VVGcP1pUWsqP+OjRE/YD2V7euo55aTSqMegw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9125
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2903

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


