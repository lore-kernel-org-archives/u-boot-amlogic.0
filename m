Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E688CE83F0B
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13625.1770115492369104301
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:44:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=OWMeYKUS;
 spf=pass (domain: oss.nxp.com, ip: 52.101.70.30, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3IMIdmcqrcwFemxw/8gruVzjiKXcdBVx6G/LlFJPfZqTviDyUSDqU1Q9eaRKYqPJ0vZmiPHieGetmSSlY/h8rPTvU9gTCiIFcuvCRzAsomTkN54yi1t6PWlIWYAbTygNpi8ka8nZjGEBrluaL4Xx5iZIfZzlzgXnWgznGBQ2476He5oOrZHQYK1qyqhTq6i23L5Od0uVj85FzwTy6DUfJHtyjHooES/FFsJoPJI/fPwjPYxMv1zH1Wuw24SN1zaYce/c6a5mW8BuFfOZg4ZgDrh6pl50/s5dOm/bEUFyPHVrvtsEPY7Rb/PwOUImY4lNV7e51TOrzfiyOH2gacRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxfvyil36xY1D/eNw+BGYVnOp5UonpwJ6UoczsWHOPY=;
 b=b6C2nD3/U2qOjdM3eOQbLZTx3RDyis6yRbF2GRDwnBHKx4d4aLVnSWE9W+so8Bi6xtzznb4ZhK/UnqDb19xncF3jkfnOgMhIFME8bu6bHOUANnoWpZi25fzbDYr/GEA9beHE0JSOSQPKvY3e9c5E9+KpY2iIVs2jNaNINBk/u7M+SSbttW0hHNu1CSrZIckKPtR5KZNjGf5yNyRZEXOT6s8modI6w1Fdc0sOwig6L5tAyXQzXVF09icN8gINlTp3JF9zXfnckfVRikfx98MSq+m2z8WFHwv1vZtYdgvKOdk4TXuFf0awmQhk5S4f0zXO435wfiReCbi4M6+CaEX0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxfvyil36xY1D/eNw+BGYVnOp5UonpwJ6UoczsWHOPY=;
 b=OWMeYKUS9rZd1qi3PoKiKrHMPEVLL25dm/OdIr77RwFFH0u2KpQ3GsnHNAQ0AqLzzm4Dnafetc+RYehEHO08TgS3X2i4vBsnbWGUJtbx7g4CCm7U9Hm+98xry9Zwtm2Wcods763qofMuzkGc4g0hykE/KKXhcXLjSziVz2AEFItqPgmb73aFLZHoTqRq4QRqgQ3zZ6s3ptPxw+TJM1EBK5PJUDbCuzpkhMGa3RwlCK7cdMKVd6l1HOubqXbk5Iv1kiasRwY4an2jYs8mTjziSq3FpwMjQVHvOe8ciGjk4eopF05ZkRGqjvsWYNgW4eM3GhTnndHU8BjPHXAP6nQOLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7147.eurprd04.prod.outlook.com (2603:10a6:10:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:44:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:44:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:36 +0800
Subject: [PATCH 05/14] test: log_filter: Include vsprintf.h
Message-Id: <20260203-cleanup-v1-5-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: bf345142-4113-4bf6-fb24-08de63113e72
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?Zml6bERDNnJ5RmRaR281Skc2U2NSUWxFTG1ONzh2VnNrMTZzTHBPYWp0K2pt?=
 =?utf-8?B?Mkl1MXBmWUpjaGxHU1pkcmUzYkpWSThDeDVyQjRqY0FLcHdaYjM2em91ZTQy?=
 =?utf-8?B?aUdYSG03TTh5dmxNOFdRMHJ1aFRQWDdkSGQ5WG9PanoyM2FhMk5WNjkreVUz?=
 =?utf-8?B?NXFKVVlaM2tyYnM2ZFlEbDZVM0EwL2QxaENEZGpLRG9rbnhaSEFXaFNCSldw?=
 =?utf-8?B?UEhPRnRDTzA1TDhybnZXbmVxSDRYWHJvTmpsN1VYQlpwSEhKS3pTaWtOcXdm?=
 =?utf-8?B?WXRvaHJONnVYd1ZNNFlpVTVwdVV2Mk05dEVmRjB0QkJwZEdYa1ErOTZGZ21M?=
 =?utf-8?B?Tlp5ZnBvM3dpa1ZQZ2xoRU5vb1ptWjRSSHFYbXlGWjIvREo2N1NYMWdFNTkv?=
 =?utf-8?B?b2dBRHRMakhacHJqVm0xbk5zMDV6QjZrTklVUVlFVmlTbmQ3VXVOV2tXOGVN?=
 =?utf-8?B?YnVnVFk2WWtUbCsvMFhPQ3RNZTNDQ0swaVNtYXU1RkxNeGNIWldyVUhxVG9l?=
 =?utf-8?B?eG5SaW5zc0hLVXdZbnEydlF3eE9HazhxelJFL3liRUxVbjduZnR2QktvaXh6?=
 =?utf-8?B?UnExalVteUJwVXRhbDVNc1VCZDV2UmVJUVVkWFRhVlI4VUh0REg2UDg5M0Jw?=
 =?utf-8?B?ZGtxbjBDOGZveWd5blVISTl4NHdYRVBiY2Z6SG1yTDRYUHVDYUJ2MTRieExu?=
 =?utf-8?B?b1N5ZjBxNndSRFBTZXN1VGVTZzIrbVRIQ2V0Vi9MeW1DTHpLWEI3NGJJdTM0?=
 =?utf-8?B?RlByKzE3TUtVUTBzUk1zN0VSUHBJaFhKeDIxRGUxRDhhbFBXVE9SZ1NySTM4?=
 =?utf-8?B?TXV6Y3dQOXcrdVhLTkNOZmZvZjhPSTB3K0w4SmFSd3VoOGVFSW5hWm5vTHJz?=
 =?utf-8?B?blVjcHhnNzVEWTBNKzVVUERCWlE0KzMrL3FNZmp3azdJQy9VRWVsaHdja0po?=
 =?utf-8?B?WGcvKzEzcG5QaFUwdEE2U2pFVkhHb0haam9tcE1EV2RCTXZQQ3hyNUtyS1FB?=
 =?utf-8?B?WEk1SGtMSXRCTGZoSFdIT2RleVhLNmt1bFhMTXQrcTREN1kxdzdWRXczNitj?=
 =?utf-8?B?dEtHV0pyenhZcDNtRWpLenE4ZGlRd1JiRkU1dVVoYlFNa05CSFdRTVFIVlhp?=
 =?utf-8?B?WnM1dnRtQnJRY1l0c1BzSTZVVTBPMzdSbFhxU1RSbG9WMnhodC8vK28vVlpZ?=
 =?utf-8?B?Y0FIUStsdVBOT0w0Qi8xRFNIMTRoUVhEOGIwNUZrZDhLdjNHdGVsTmRtZ2dx?=
 =?utf-8?B?cVRYMjJ3MHRnNW9ic1NmTzJtTW9rVTNOT0dSV01kWkFxekdRcXZXUXdreDVw?=
 =?utf-8?B?cER6Zy9nY1htVFptS2FjbjkvS0EycGZraTZRL1d6N01sT1haekQ4Y1NjR3Fo?=
 =?utf-8?B?WENhY1NEUE5vQkZNMWh4bFpHTytqUldwRTY0QWZaanl5bWRDRlVTN3M4SUF6?=
 =?utf-8?B?amVJYVFrQUhaVG93UGVWMXA1amdBZzhjT0h3YkJwYk50akFld1YzRlZkZzAr?=
 =?utf-8?B?MGFEL1VRTUdiNDBQNlllZThoMXpCY2RWamI2cmVST3dNZUx6MGdXdWx0Z0dz?=
 =?utf-8?B?a3lGRGFDVDdudVlaRHIybGdqeENXaCtSc3R2cFFaY0RmWVhNY1dJcWhHSzg0?=
 =?utf-8?B?d2FuV21meHBXVGZRRHJzYmRvNnFMWGFxZmk5bzNCYmdFZytmOHRWU2pja2Nr?=
 =?utf-8?B?QUpzNEw0UXJvR1BaSHJJRHJyVWQwem9WRTFkS28vNW9TRGlGZFpmOTI5N2RP?=
 =?utf-8?B?ZXVUT3p5cncwVU1aeGxwZ2Zkc1VJa3ExOWhFN1JMUFVMUGZwZGlBaGxLVmRr?=
 =?utf-8?B?bWpZMGRWZm1ST3VhY1JXMWtnMTVXT3JnM0RhV0lBZnZyTnNWdDlnYTBUdG5R?=
 =?utf-8?B?WUIwQytLaFVUWU5zSU8zaVJCQVlVcjZQbGpsb29XcG83eGljVTBmL1RmUzYw?=
 =?utf-8?B?aGQxeUhYR0NyY01uMXZKd3NCYmVscUlkRmkrMDV6ZElwR2xMQ2UvK1NScEhF?=
 =?utf-8?B?M1lmeVRUSmpSVGdqVW1TTStNRHJnWlBWVEJ2ZkwxYk45cGtTUnQyRkt4U2x6?=
 =?utf-8?B?c25CVnNyTUkyMjM2c1BPY0VxVDZZbVRpQWhQbm5EckIzUHIvZHlhQmxadjVj?=
 =?utf-8?B?R1JDbGJQbzVJcHRoOTFFdHgveFlpVWc1TGRzVy9JV1hmTTJGOFlyUUl4Zmdo?=
 =?utf-8?Q?RQ4IY0iwViJWmf9Ib4VzpqUWNaYmhu5TQeGgDPqaPHNu?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?ZkMvTVpQd3hQR25KaXUyMkI0UVF5WWhmRHh0eVAwTkEvYkQySFZMSnQxWXlB?=
 =?utf-8?B?TFNMUE1yZjdHZ3cyZERBbVZ2K0dhZFNLWnJQQm8wbDlITGJoVjR6blY2am8w?=
 =?utf-8?B?YWpDQksvNDI0NnN1RmhkOGR0aUFBS3hpZ1ZYZFFNV210TFNtQVZPRGM0NXpp?=
 =?utf-8?B?QnlFZUdaczFZcnJLL2Y2bU10REFHWkE0cDJZV0xhRWd0a0pBYUhjampROVMz?=
 =?utf-8?B?anF4czFOalEyRTVzYVduaktxOWdBb01ZOGVCVzV4blZuWCtIVm5yS0kxTHBT?=
 =?utf-8?B?dUhqQ3gwdTU3MldmUGpjQmxCRGY3NG5hWUl6Rk51aHpKS0JTai9FMUowVXVH?=
 =?utf-8?B?bEltRS9VcFphcVB6c2VBZ25yS2RVWEN5S01YZnFBY3ZVSS9MRldubVNVeXEx?=
 =?utf-8?B?QUE2RXhQclAwa0ZjUUV3UFpjaVBheGFneU1qM1VCWnVyMXV0R0tQYVRmeThG?=
 =?utf-8?B?RkN2ckhDTGFPQWZTSHBwVy8zcHg0Z1JnRzRISTFiRFVheWxqWWdnMXVTYVVo?=
 =?utf-8?B?QlRUdnlONCsreGNHb2o1VDRRamV5b0ZtS2puUitCSllXWmpQNFMweTRjQU1J?=
 =?utf-8?B?MHhWcWNaY1JURTE1YUNQeEpqc281d3M0TWoySUJpVUxhZXplNVk0MUJPcUdq?=
 =?utf-8?B?ajdiMjJWY041d3A2c0ZKcUlrSDdITDdCRDcra3g4UGxGekozRFJjRXB3ejhI?=
 =?utf-8?B?MUpZZDNNQlhnb2hXankrT2FjSXp3R1BUQU10VzNObkJlWDhOeDRPZlRoSFc0?=
 =?utf-8?B?WllaR1BLV0dvbDNaOE8rY3NVNE1CcFJDaEtkMUxacllMWUtjbmtBMzBuZFhW?=
 =?utf-8?B?di9JZHVjWkZOSllnOXBGTWtVMVB4VTkrYVRseitBREhFQjUvR0M1QVptSEJp?=
 =?utf-8?B?UWU2b0o4T2phdHVjSXJ2TUtmRm9VOGhCeGFPYW10QU1DeXNqdTUvVU5rUEJk?=
 =?utf-8?B?SXNsQjltRTV5amtVa1MxcXN1a2ZpMzBDUHExT0lKUHRrNUtzVktzQVRUYTZI?=
 =?utf-8?B?UmUwUXduTC85TzU1Q2w4azBseUIyYkpvT1dLZ296VXg5eGVTaXRTOHBqSlg2?=
 =?utf-8?B?UUdLdHdHUGNjYVRoaGV6SmZXUkVQWTBjQlkyMGtEeDkrNkZSQXc4bUFCK1M3?=
 =?utf-8?B?QWZhNzRveDNnTkIzakVPeWJDak5ybDlDankwcktZY1ZscVE2a3d0OGUwRkJy?=
 =?utf-8?B?Q2lFUmNNVzJDeWQzdmlUVEhPa1k4amo4ZzRSM2hWck9CZ3BGemFJclJ5T1Zn?=
 =?utf-8?B?ZTlkb0Q1TitZRktKbmRLZlBzaGR1L1kxSkc1aWNReUJxOTJ5blZ3ZU5QcFM0?=
 =?utf-8?B?Mm93d3AzbklpdFE3Z1kxdVJGRjBiZ0hMYzZpNkhVOTVGNTMzT0E1OEhQcVlD?=
 =?utf-8?B?MEZ4WGpaQ05jYUo2U1BxZFluNGU0UGZCKytBbVFNbVl3Z1duS3VrSy9ycWJ6?=
 =?utf-8?B?M0J1NTM2OGdSL3U1aUV5WUk5UkVLeEVpSGRPWUpMaEtkc2MzTGR3V3lxT2RV?=
 =?utf-8?B?bzltYmg3Wkc0Y1FXd2Z2T091Vnp0TC9tRUlGZ1RzUG9uOWN3cWp1SkhIa3px?=
 =?utf-8?B?NE9nOG95Z0NZZC9BeFRPWGQwMjA1dTJ3NkVCa1VLWGhYWHRjMHBHT0hHY1hN?=
 =?utf-8?B?YUlkL3BxckFaWFNPMmY5cmZKNnJTZ01KRllQaWxHdWllMHpVYnR2WFJ4Q3ow?=
 =?utf-8?B?ektGSTN0bXBVdmF0TENoa3VYdE9aS1htUEJZRE4yU3NQZFhPbkpPZDVZV0tM?=
 =?utf-8?B?bHMxd3Y5d1JYUjcwTTlWd1BBTDBURWJyd2NQRWYySWM5YkhGNkFwdkIvY05m?=
 =?utf-8?B?cWhQWDZFVkFjczU4ZDRLTmlsTmZtaDFOVVNLdVlJMmRYc2pveGxIRlBzYk84?=
 =?utf-8?B?UzM2ZUFKMlU1VDUwbW1OTTFFZDQ4WHF4UHhtVTJFdk5TNk9XM3p0UTA5TTVm?=
 =?utf-8?B?SmVBRTFzNWtRcVZ2cFdPZStXanFHMUxoZTE0enpwcGRYTVBtOE1FMHlBd3RL?=
 =?utf-8?B?dHFMZmxCK0JadnV5eDZ2U1JYZFJKV3JEZUlLbVBuRlRITExKQ3VQc2pscHRs?=
 =?utf-8?B?VmV4ZXhYSG9QRFZIS3lnSWJRMER2elpWRDNjNWt5OGZOV0ZpZFZJWW9ZWVNs?=
 =?utf-8?B?bzA2R21qK21UbnBuOStEbVluQkpYTXpQQkRlbnlXaHEzTFJUT0NtTE1mckJm?=
 =?utf-8?B?YlFHY0diUWQ5RjdTaG9oSUhIQ05YOWgwcFpPVjQybm5xaFFPVURzdkFzRzdk?=
 =?utf-8?B?QnBJK05BeWFFdUdBRktJOWJ6K2JHRlliaXZoUE9VNDVWYTJNQm1ldWVUTVNI?=
 =?utf-8?B?QlVySUhHM204MUtWSlFyYlRtRHFiemdwT2tHOWNSdFhuNlhPL1YrZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf345142-4113-4bf6-fb24-08de63113e72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:44:45.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ml7MDToyQYdwD86v6WR0qmyZ3CclAdLJpPv3AsrOclK65Yq+eNfw4zUdGEtueY2gD/nUq3hMiuzi51ZOSvV78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7147
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2892

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


