Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED428E83F09
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13674.1770115720385918028
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:48:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=c4lDrC53;
 spf=pass (domain: oss.nxp.com, ip: 40.107.162.41, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPGw95FuyIxH1mfyHFm16dAEcEJnIqmUZzufXEggv50ukl8PnH2RP4t8Txnh6X/D2QjWHMAN72INu6AU/5T8PuwrpDDpqjNadHTxNYXva0BzcySycShSBkts2D6QRb0xvuuS44+HvIwEEkF6vpFvCYPj+Cred9Xd3VRgUbt0BpCTbiDx4tC7HEe8+0VPl4DsxQBGlMXpgp+6SxEHsb44LsrWVeEMvizPr6hbcLQaVLPBX1WsAgTV/foAcxpQQlM94Pbd8BnynfOdOOFx816uF7H1WGS1iuBNftUV6mJ+LccvKUGsXUvWIQANqR3DqYe7euwMkgnQjG0HL+dT4887Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSABK4mrFlRETHt7Ep9E6IaJWCfL36Ko+hKrDtSdzMg=;
 b=JFwzKiaZ/ObRqAMOCxj+r8319pl0BiYcFm43u1jwbWkEUCMHmAEzNfZF5r1ybSQXLpD1Z2Q6ZkWSiqxGeeFXSit5b0CyJ7SDSqnYFbz5T+tJXY/1Ip1Zaqxy4WDa+zA1B1Etn2CpxgJgo5BFs8r9VaRp1BWTwURyFTUGGr+Nqxh26TMYpvBRuaAr1U3IGc3oY8SDHlQxioWhQNS84pY7f8Y4SHBBuPDTzAZGQNnPSA7DXE0i+4dj+v+1Ch2iLziDdgqzGlgOjL5fBiEiGU1uo0ZHwut7ljO6TXjFAlv9+4Ssoq3N0ZTvCpFL8QGgtrwt27EG90rZyrT3hUtAgq751Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSABK4mrFlRETHt7Ep9E6IaJWCfL36Ko+hKrDtSdzMg=;
 b=c4lDrC53ZvjeoQ1OsghhbR+jz0l3xoo+ZyHep/bTPZU+zrNxkqJx1Dh77YiqDPlIeFoMUN0BDezRkPo2JOuKB5wZ+QshaW+Yazgh0GY1CN6yqv/evXiY1wcGXNYJyYBIzL7JnNbHT6mhiTK6l8xvvUDBu3D0JbcZmn/LZr2eyMcUL/pyWTOYlptMNmsJ6ocV3mItG/hi3D+taGH24USJpt0RgVZPZbP90PVkLY5udy4H23vsfc348eA7YgMoatDeQ1Nq0pLEh5Pej8prB1VkVveF4/9Dyv+vnaCZvEApyh81hxILodW02UWSZRqoe5OEd6BtPRVnVYJUPif43Bfmpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6908.eurprd04.prod.outlook.com (2603:10a6:10:116::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 10:48:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:48:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:41 +0800
Subject: [PATCH 10/14] nxp: emc2305: Cleanup headers
Message-Id: <20260203-cleanup-v1-10-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 82437bd3-176a-4fb6-e087-08de6311c66b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?NThSMDgrTVlCbXFINElPVUl4aXh0eWJ3bUUvY1g5bVh4cGw2MHF3OGVFZDJ6?=
 =?utf-8?B?M1hGTk9NQUJmMHgxVEJScTRYcktCelZtaGVhL0xJOElKR0dyeXl6bzAwK2JN?=
 =?utf-8?B?VXJFZElNeGErMGRyTGk5ZFlaemd2SC9zOUxKNWNPb1RQYlZyZ29zUko3V1oz?=
 =?utf-8?B?d0Joem9kcG5xYW1qZVpQdWRaaVBMUFdsU2R2TlFDM3ZXYlVpYlQxU1BOQkhm?=
 =?utf-8?B?ZHBnRmFQREd3TDAvYW1MQm5zUmJLenc2NVZUNXgxSTdockduTFFjcFUycUUz?=
 =?utf-8?B?VTVUcG9FaVZUT2s0cWU3Mm5WUmNvU014ZnNkaVdJcjRXNWVVY1ltTVBpWlc5?=
 =?utf-8?B?dzk4cDcva21iMnB6ZzFIdGdkTDQ2dzlYZmhDMWNEQmE1cXQ5WGtNWWRuaHRX?=
 =?utf-8?B?ZFRYa21XMmIwbnR4TVJIbGZOeEZKWXErNkNpU3VUSjhCQkpDN1dUNTRCbTRZ?=
 =?utf-8?B?WUNnTjNoZWJqVXZWQmxxR0pLZ3FUaGo1T1FPR0E4clg4ZkhDeHlwVi9HSTFG?=
 =?utf-8?B?RER4d2RFcEtPdlUyS0ViR0tGNnRENmlJenZGYjhOUEozMVZFNGlVMlhxUHo4?=
 =?utf-8?B?dGgybVRCZDlkUXFkK3MrWFlTMFFtdXB2TlNSUElTaTc1dE0xZG1Jc0pEQUdj?=
 =?utf-8?B?K2FYRXB2ZnQ2ZHVNektGRE1CdUVRUndXNnFoaGozRUVlbFExd2k5YVFGU29u?=
 =?utf-8?B?SHhjNmdaWWZta1Eyay9wK3hNUW9hRFNpRy9ST3FpZVhTMFIyeHFNQ1ZyRTJR?=
 =?utf-8?B?YXVvRERrT1J2djVuTTR3ZXp5MklvZGdHNCt2OXIzek1Qam5pdE9udmh2OTFr?=
 =?utf-8?B?ZW5KZ0tQTWw4bHFUK0pqVUFTNExDV29ZSkVySWNGa1cxM2xaMS9CR3dmRkd4?=
 =?utf-8?B?TUJ2VkwvcktGcDIxT3IzakhCc2lhRkJhM1U5U20rdWlLVWlFaUhnVXRBcGRX?=
 =?utf-8?B?YThHODBrN0gwUlowTWJnY2tDOERKSisrNTJmbCtnR1RkRU1KeithdDY5V1N0?=
 =?utf-8?B?VndMbU9VNlptU0VETk5hK00xMzFqc2N0K0NLM08yYm1mcDVocWdaQ2xNSEsx?=
 =?utf-8?B?M1cxaEJKOXdldHNxZUphdmpMVENqVTFwamw5czgrU1VjNzU1SS9rNlVaK1VG?=
 =?utf-8?B?bUtXaGQ0ZkVHQ3U0dmgyT2JRWXhNWTJiUCs1L1JMMUM0c2V6eVN4MWUyMk4x?=
 =?utf-8?B?aXhLTnM4cmJIUmtEYWswZzhnVTFwZmMrZzMxb3BJTUp6WHBXdk9kYnhSY0c4?=
 =?utf-8?B?eUdvYU93Y1VNT2RjNUYzRXgxNG5HVm16aXhuQW5XUG9ERnZKMVZhUzQ4aTVk?=
 =?utf-8?B?QnFwSEcwSVNiQldEM3crbWJWVGxsd2hCRnF5aWJMUXJJQ25zTStZMGh6L2l0?=
 =?utf-8?B?STVmQTRWTXlpTEdnVHhKTm9DanpaR0RoSTBlUzBtWFNaWG5XNGxiRWMxaXlx?=
 =?utf-8?B?NkVkTUtrVStCZEVVQWdRaE10VURFdGMzVFdJN0hJbzY3Y0hpclBnSzB3Rm8r?=
 =?utf-8?B?RnFxWjFBRU1mYWsycW9TTmRkaDBKUzRNdWRHK2pGRVUwTVN1bFFKdXVQSTVt?=
 =?utf-8?B?bDVSRVdUUXl5TjZHVnREWHltenlPVy9JY3lIeG5EYVpSaDYrdkZKUjMzYm9R?=
 =?utf-8?B?SStGNStkQU8wdDQ3aUdZdEh6MCtJMVU1OHNhdE9YbWdOUENOUTFJRFFHUGxz?=
 =?utf-8?B?N1JySjdiVStlbU1uUDVJLzM4NDJGTzk3RFBIb0JXVCt1djZkbytIQlV1QTd6?=
 =?utf-8?B?WU1JZDV2Qkh2N0xzUlN1aTF6N3JDbzlqVGFOU1hyUFhKZ1MzS2ZITURnZXNr?=
 =?utf-8?B?YmNGRGVmRjRYb2p3K2trVXp6dW1DQVRnWGwrTmpuRkprRkw3YURuV0tYOGs4?=
 =?utf-8?B?OXlSMStISXlKM0VLYlZPNURFR2hpbmd0R0JBNklhS1laanVBL0ZZY1BwNGVW?=
 =?utf-8?B?YTRTWDFuNnRSWXlVRmVlSHYvak5zOUpZVWZwZXc1UUJnTXdSQUNESzFKS0Ft?=
 =?utf-8?B?S09EbFZWZnZsSjdGcXYzNzBueGltMmU2MHVlMk9NMlo2bUtWYVd6M3Y5aDVD?=
 =?utf-8?B?b05XR3h3WHZ4V2RkeXk5UVIvb3h2ME5naWFzWldTK0wwdWVvQ1FaekZxTzJD?=
 =?utf-8?B?d1FKempkUHFtSFlJaVRRRExIUVhpWEFicldaTkRYT0pMUUhnVEhTeGo0MnFP?=
 =?utf-8?Q?ADzYN6YBR1jK1BzFwaWXdQ9XYQMCR3pQ2SJCujRTI93c?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?aTZkMDlVdjNacmNSMEhZVWV2MVk5bTgrbWhiWXBBN0JsemE4aEQvK3Exd2p4?=
 =?utf-8?B?UTJHa0FZSGdSOXAwU2dQWThMOFdRMVdLY1JEWkVkYTNNZDVYa2FscFFnMVRZ?=
 =?utf-8?B?SmlWVitLUGlNR3NRQW9STGRPdnlKeCtaNnN3SlVsOVFEZEEwT245UVNWTGJx?=
 =?utf-8?B?cUxQSzhSelB2Mk5EVksycHVraC9lOHJvMTl6OUVuL0VhVllweExyd1RJZVlI?=
 =?utf-8?B?Q1l4K1pBeUtLOXk4b3RyaWdTM1pLb2xJVVFRdGVkTXhldG14bUpSeDBCbUpU?=
 =?utf-8?B?YWlpNmFiWkFZUHNzaldESjliZFo1RXV4emNuM0VmMi9kYy9pYkEvaEtWL0xw?=
 =?utf-8?B?Nk1jcVZlcVZhMktONXpFa3owL0hkQTFPSkx0alg2SHVyYUdtNnRsWUVDSWdT?=
 =?utf-8?B?U2VlR0xhQXg3RnhEelZ2TmNCK2h3Y0lXWlcxNTJKYkZGYlA0bjM5V09MQm83?=
 =?utf-8?B?WmUvSjA0aEpCeGF1ZEQxYm56MVVramtTNFRpdG44WUZBZFQvallOdTdHYTdj?=
 =?utf-8?B?RU9wVkZicFo4Wlo2OUdLODNyL0hHVW5mcTBWM2F0NlRRbHpDVGh0dDJwUElo?=
 =?utf-8?B?SFFlVnZKNk1WODRhLzdEUzhlVSt0OTVNZDZ6VGo2Z1JjaG5VSUFyd0xhanRV?=
 =?utf-8?B?MzU1NkdEcDNlMXYrVEd1a2NaY0VxcDhBNFNPZ2liTjNTRzNVNEFRT3BLQ2NS?=
 =?utf-8?B?ZTgzeEJxNG85QUpSbEVzdmY4TlM4K2ZZT0k0cjFDV3I3WUZMaXZsYitUQm5C?=
 =?utf-8?B?SXpGODNMeUFrQXBRbS9oMmVyYlh5b1J1bGtnQzVueHBnZ2lIU0hCaFNiZmVP?=
 =?utf-8?B?SG9mVHVWeWNUYWphYmltTkw4VFhNaFc4azRId2Z1QzBTV0YzWEFVTnBjTXlH?=
 =?utf-8?B?QzdycVI4eStoaW50NktMZitQL0dJa0w5RVQyUkRnTHNqb1I0U0pwaHEwejFN?=
 =?utf-8?B?cU5rY2FvWDZpOGttdFUyb0NDN3V0RUdUS1BQT2RaN29laWI2UlpCclhBRE9B?=
 =?utf-8?B?cUQvd0N4ZGhXYW5qaEo1ZmgvWXpFdEo3djdyckdab3pkZmM3Y2VYSjdLdDBv?=
 =?utf-8?B?NWlsZGdSTitzZS9Ed3JSYnZoQzluNkpIVFN1N1JqSlVJc3ZqSHJReGNpaEN2?=
 =?utf-8?B?anhOQ1Aza2pyMHlyMHNncEtOZm9yUlJHNXk2cjNza08zYTI1RWhyaHJ3TzNJ?=
 =?utf-8?B?alRKOURPUE5CQkdpSTFFTGl4ZG52TU8zaVp1ODQzZCtNR1lYZnBsR3BsYnBi?=
 =?utf-8?B?Ni9kL0xsOFRBeThXbnRkSVBacUY5djlRamRIK3NUMGdhWm43MGpSQy9tOWRX?=
 =?utf-8?B?TXVwTXgyUUVWRVBqN0RHZlRRenRCM0JMTFhoTnZEdHgwRDNLaFpxNlliYjA1?=
 =?utf-8?B?UlhkNHRIdSsvM0lOeEhBMWdQR2JXRlBmdi9wWWdPeW9oeUVNOEtRM2Y0NzJR?=
 =?utf-8?B?RmEwR0pGK08xWThrQ041ZnlmcnJ0S0t2MWcvNVpNRklaNDhMZC9GcGNaOTNI?=
 =?utf-8?B?Y0NVTUFySGkvakN2SVFtS1RERG5aK25qR3Nxbm0xeld1VDlrNnk1VUNMdEJE?=
 =?utf-8?B?SVJlYWNRTWhRa2IzUU1NWU9kZXpQWHZmZVJ2K0ZVTUJxQmJyTnJFbGZ4MjF5?=
 =?utf-8?B?VG1UK1ZoRkF0eDZMb3J3aGdPYkVCckpZeWF3OXZ0a29UNSs4K0dpTkJHYmFL?=
 =?utf-8?B?RlpyNWVXR09pbXNpR1F3cmszZWU2cStrZi9yWWozTmJBc3NqZVI0MlUzVFd2?=
 =?utf-8?B?SUlhbmJaYm1ONW1ncHBDQmpBK3I3WEtHRlB3VXFqMjVvRWVqTSs2OWpHcEhG?=
 =?utf-8?B?aU0vNG5wNzY1VFlRNkNIbUUzdUFEcWplWUZ4L2U5V0xYZE1JL1o0RGh2OVhw?=
 =?utf-8?B?emdLVHR0dE9XZEd4RlhITEt0REVvYmZWM2VsbzBOVTN0Z01XQVIzZ0FQcld5?=
 =?utf-8?B?S1RzQTNMUkhjcjBUYnFTRzBtUk1BSVJrYncyenJCd0hsN3hXQ0FvSGZSYkI5?=
 =?utf-8?B?ZXlWb2tERkx2dDJWNXNSTERoOFhjcjF4NzYzUVZIYXZBMEd4NnJkYVJNNzdI?=
 =?utf-8?B?MWRQS1JTSjgyU0M4MkREaFBjdlg3a3JHWHVDd2trWGlaaWk5Q0dmR1A0UklM?=
 =?utf-8?B?VWNsMUF5cElvdFh5cWRXeGErcERobUwrZVhZU3dXU0NlNVlrNXo2WWdHS1V0?=
 =?utf-8?B?YkZpSElxeXZPaGIvYm5CQzdNaDh0TGRaREtTRmRXMWxrYzZsaG1sUVRhbGVa?=
 =?utf-8?B?SUdKbHN4bk5BbFNlTDl2NkpFWm9Qb0pmb0loTnZRQWtXU3JCYVFOSmQzcFJy?=
 =?utf-8?B?bE8ybGx2Y0tRWVh5WHdDdXNFSEtMVWFGTy9ZNlNPTHp0eEFLYU1sQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82437bd3-176a-4fb6-e087-08de6311c66b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:48:33.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9hm24FUfKXtJ9dTdIhjAmG5QqRgfqby69jNUgELyRXyUyhtXOk8utnWTq3V0IY0u+EsAA5ToMlyt9g6XQu5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6908
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2898

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


