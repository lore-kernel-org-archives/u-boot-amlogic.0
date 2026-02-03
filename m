Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D185FE83F05
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13838.1770115677273193571
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:47:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=R7649k+Y;
 spf=pass (domain: oss.nxp.com, ip: 52.101.84.67, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4IfR1VyqYJkFrKmo/OEFtalfmgVWq5vJs0vPzXVtJd3cku08Ypf+HCnOAWMQlM6UrZH9bmz3BVdZKXwma44YYt7CB5bEbRAhqRTgF8l0CNP0aNYmxMZlyWpeOiTBL3VMDZgRMRChRXezV1lDjdJCToEBcsJDX163Efm3MbUn8ZjBfic/82AwXaYwIUWt4OZB7zynsV1zhD1ezxFyU9oPku4J9+m9f8HSDMf1oMoVMPcvuc+2t5fCYelIHMK7uw5fP40+ZOIznVoVZSDB6D5JJnIufVICgwq47F1HY1d5HIBtw+bWG5+iAYxCGDkokB9vPMgtRxVqzuq+1WLELQ8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlZ7txCufvgBDrNMB2IW01K9N8kpcuL+X1j2xht0yaA=;
 b=HBMjTRsIibp+HAjgOIaoIEeRcwypBCH/c6r0bw2I/0BUxuTzXjHDU9YmP0tRvejis9o6dK0rfnHvLX+VpbcYttEyjeyfPB7HmWyr8BS1XB/UN2RG9KWW/kn+djHVQFpPgeIYqseeyoM6RrSiIlxdd6StUv2hJgAWc0LHaiUL5fentsROYg9A37+wGLUa7Ps9njHioX/O0kT4XNAtiZfGC4zkOtcJs5z2nVGM56RAOVF944XVGNjNvpE6idzHZvzeJuVXkNRPmRHCo9JvUXiarzF3uUVRrmx07U6LlARP6pmihwJX2wIuBxu7UEomMwlOFCcz1+8z771Q5yoBUYs00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlZ7txCufvgBDrNMB2IW01K9N8kpcuL+X1j2xht0yaA=;
 b=R7649k+Yvto6nfzE5frOZymoBsPoegNf9Gz88cgG2L0CKoTDLhy4LJR0nkjqyPXiC2kmjSuIcRVtQ4JlILJyANAIh85IewT0u2LO7Qoik89lsPBs2GUhziOg602Tta+1sfV7/hZzSdBZQv9zoSS+h921DURjqh3XUkOFiHtPLOz0+FVTGLpVfqLWp2/Sj7GyiNyAEC3AY6LKJZgLUFNCBZjj2D9N4U44/0mhB5bCiuRepJ36ufb4cME/aT5SwUPi9E+W8G2z8JXTMHVSDgxEfMghrKmhuiwcZ0M9keplDT8w78Q0tBQ32yMqxIYOAt6q++BL8Y+S5yUFsJ3hh7jZvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11639.eurprd04.prod.outlook.com (2603:10a6:150:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:47:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:47:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:40 +0800
Subject: [PATCH 09/14] rockchip: evk_rk3308: Cleanup headers
Message-Id: <20260203-cleanup-v1-9-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11639:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2244ec-641e-4816-53f5-08de6311aa88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?WVl0dHgwbGZPSGJhRGhWcTg3d3d2WDVoNHVjNjFPK1JEVzgvd0ZIOEJPWWp1?=
 =?utf-8?B?a21WSVJZblVMWEVBeEwwemxKaDRsQ3RwZGVSV0pXc09CUnBFbEZFa3pSaXZB?=
 =?utf-8?B?V1E1VGdvTFRjYlhmRkE5Z0RkNXVsRVhPSkxmTGtrb01GUWJlb0llT1NJcHFY?=
 =?utf-8?B?K3haK0lMOGsvOWNtMHdtL08yOFArWEFpMXNIT2IwZkp5V3BPcmFKY0RBaStO?=
 =?utf-8?B?MS9LbURyVWltazIzMU96OXZObTFOMXBZcVZ4elBmS2Y5Y1ZZRXRlVkF6ZXlH?=
 =?utf-8?B?cGpiNXlVSS9GVEsvUlNLbm5ueDZIRmtTdjFmTGVFakVvNFNxV2tvUUR5bXdQ?=
 =?utf-8?B?amNncTZWTXYwNVdUZFowK2RCYW1TS1NwOHlXbVZDZE9zbnhPaE9YSEM0WElp?=
 =?utf-8?B?KzQ3MEc3K2xWQk1KZEVlQVI5eEZQVmtmbEtaT2xxeU92MGwxZDJXZjlHNzVy?=
 =?utf-8?B?Y1FSaGYveDM2RkdZTWgybEhsM0hkS1NxaXk0aXVyanptYzFlRExJdkQxbEht?=
 =?utf-8?B?QzRRWStJL0l0dFhldk1JdEtXUGZseHkvYXg5dklPclVnK2Yvbm5kZmE1Y2V6?=
 =?utf-8?B?aGdDNUJONi9YN3lkNnNWaDNFRkhGeUk4a3dIVER5RGxVb1AwcWJwMUdrQitM?=
 =?utf-8?B?Tnpzd0gwcjRFY2VjcVMrUUdZdEdXNnlnWW9zVEhnS25BRVhsUHZleUl5azFX?=
 =?utf-8?B?b2JVcEhrR2pseHBTdkNQZFFCTjN2QjFGamJqK0RPa09BUWpKNTFSdytLNmw4?=
 =?utf-8?B?ZXdCbFZ5VTFCUEliYzV5YWdMbkROa21RcUdsaElodHhId1k4eEMxbFFuSGV0?=
 =?utf-8?B?MWtlUW9kM0dQK2ZwUFZjYVdNYW9qQjZtdDdybEo3c1lsemhUWGRmWGthaFc5?=
 =?utf-8?B?Y3BERDhkMzJVRWVEV0NvYUlkK3E1Y085TDVKR2tJbWhabFFrU1J4K0tNVWJO?=
 =?utf-8?B?UXpXSEp1Mk55Z1JkblJrWGxEZTF5ZmRFSGJITHAyUW9Eclc2SDVrMWpZVkVt?=
 =?utf-8?B?VEkvUW1Yb1hGa3FQVlhMUUtyL0pyellMQjk1aUo0dG85dGlKUWRhR1U0U01n?=
 =?utf-8?B?U1dlTnNuOTJVL3BMeVZLdTdaL3piK1V2OENqcUlKWjdjNlVzUXo2dDU3azd1?=
 =?utf-8?B?QzZPQXVzZnZjUHpaU04yOFRjbXR6cEFhd1prdkhoT2tQOXpCQndGYWQrUG0y?=
 =?utf-8?B?dmlqNU5Sd0xMdlYyUXVBMjVLd0VUTERVR2Y1SFBtSUdqcU5EdTg3QUoxaDBy?=
 =?utf-8?B?bHFsRFNvMUxncEIvbTdvT1NUSEFNcmJwaUx3WjMwMG42NTYybFBZOXBkczFF?=
 =?utf-8?B?T1JVaFNWTkFNVS9uNXl1REN3Tkh0ak5MMmV4bFZRaDVHL0pqenJSSHNsZkY3?=
 =?utf-8?B?dWFpTmNNM2ZkMVliNHAvUzhiN1JQck1tcmRVczZ5US9PU2ZycS9sNnA0MG1s?=
 =?utf-8?B?WlI1RVA0TGN1bEpET1MyekRtbjgxblM1Z0pnOHVsNHNob0h0Nmd2bXBzNVJ3?=
 =?utf-8?B?RDBjSGFBUXlTQXRmTGlqVFlBUmhDUkNkQVRsL1JJVjgxOXhXMFFJcTJUVGl3?=
 =?utf-8?B?akxaSWp4aGtyTXdCMERYVkg0cEZWNkdMYXF0ZXJMbm4rNHhwV3VLRWQzTUlw?=
 =?utf-8?B?WHBYLzNoOUxXaFZUMkJxNS9ZK2tVbWVmcHRzSHFZUGlrelBkSHYySi9HMzJk?=
 =?utf-8?B?QnVMcVFhZWNlUCtiV0pxQmZsRlBrODRHWTcvQUVxRk04SjlkSThETlJ6S2FS?=
 =?utf-8?B?UUNHZytaV0I3ZFliZmN5YUlveVNzNGpYcDdjYTBHc1lYV01JODk0bFlicTF1?=
 =?utf-8?B?TzZUZjIwMVFlY2kxTVUvdGhGZ3Jxbmt4a0JwVzZMZmR6RkRYdE80bkdFT0R1?=
 =?utf-8?B?WTZNUm1iRUFiWStYQWZWUzEyeEFNZjA2TFpCOGtUVmpHQm4wc3JYcGV1QlBo?=
 =?utf-8?B?OHVyOTVvdlBOQzAvbmgyODMwc0E0LzVqWFJvU3dyUDBvemxWQTByWUVwRU8w?=
 =?utf-8?B?U2ZrZzA5UGRhN3ZSeXMzQmlYYWJKZ0g5aFpFVmgrQVFMNC9WTDFidmNvQnBD?=
 =?utf-8?B?eXdDNFJTWlB6WmtaTk5nS0oyWWJRYk13dmwwRityK0hnM091NEU5Znd5TnYz?=
 =?utf-8?B?SmZkbnAxOGZVTU5ESmxFb0xuZmROdkIrN093RlhSRDJKc1hvMHFyck1jb2ZF?=
 =?utf-8?Q?g31tfcCblaTZJrrdv/qidvDkBcYqB3elzkF/+/aIdKZI?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?bkZ5N3JXazl2QWxwa2JUMkRROWNtTW4yRXRVUjRta0xEaU1JMVkreTdrRnlj?=
 =?utf-8?B?MlpXK2dYdkQxUVF1SWl5KzBkUUtVaGl5VTVQa2pJbHZUYzdSNmR5TzdmK3Uw?=
 =?utf-8?B?NE40Q2daeUIxandSeTNBV3ZjclZpd200NnViWlpndlQybk9UUjJEWk9DU2sr?=
 =?utf-8?B?NTJ6L1BOK3BpMWFEU2NrZUh3VHdWSkFUUmdnbzZQNXZyOS81RHdJUytGdHpT?=
 =?utf-8?B?ZHZ3d0tvRjhqUHNGc1hjY2RTUVBIa2NmKzM4ZnA1clZlNjdDWWtlblQ5aGht?=
 =?utf-8?B?bHJIWUlmeEFOZjBtQUl0Y3lNMVByVTdMK2FadmcyLzltS1R4eGxpWkFoYUdy?=
 =?utf-8?B?VFo3VXUxY1IyNEZla1dhREMwSEJZSEY5V3hKZC9qOWdLdEU4bHErdU5HdUEr?=
 =?utf-8?B?cHF3VDdOT1VaY2M4WkZRWGNSN2NuYTBzWUtzVHJvWndRZDdvZ3NvWHJ6YnhC?=
 =?utf-8?B?TmZ6dm00MTV4NTFoKzNNNWU2ZkxrQVJ3YXEyaFVoQlZZRkN1VTZQc0c3V25a?=
 =?utf-8?B?MGNlRDZvR2lDVkxEYlMwSVdhSk9HWk9tUG5IOWp1a0JzcXFBQytrZnFBQnE3?=
 =?utf-8?B?RlZHdm9uT0Z6TFg3Q1JVMC9DK1lFUXJoaGdSNnFlc2FGY0ErRFMycFU4TldZ?=
 =?utf-8?B?aWxzSCt2Zmw3TlhNWElFbHpVVjhrMm5RSERHUjZOZWZ6MzYzcWZnbGw0OTFs?=
 =?utf-8?B?ZUl1Z0s5RHlLQythMjNkeVVxeEJuWDZJK29kLzVvY21CNENYekNnbFpRNHFy?=
 =?utf-8?B?NVFNRGlKUHdTSyttSHBHaWdmZDRyd0JPK1F4QXJPN0lhTU40UitMZnFZV2ov?=
 =?utf-8?B?R0xZbndpK0I3Ym42K0lieTZOYzVvZmw2VjdWTjhiVzlPLys5TDF2Z0NNTlIx?=
 =?utf-8?B?N2c5R2MwUWx0b29GTTFCM2RTNVhoYlBDVmZOYmJDUUZQSjRPNWdrVGJnMUdK?=
 =?utf-8?B?T0RiWFFYcVpFaytOUWRhRHhxRDJBZXdTdUFwTFM5RjlCSmJNZk14U2cxdENB?=
 =?utf-8?B?M1hGWFJRT2xnZzgvN291dXU5WXZOZjFvYVVLS0h2V1ZtbjIvNXQvOUdPYURz?=
 =?utf-8?B?RTYrcGsvbjlIbnBIdFhZSXBNeUR2dmhKQWpLYS8wWmpGcFhSc09jaVBsa3c3?=
 =?utf-8?B?SGhuQmhyQlM0YUZQMCtqNWtGNUg0Ykg1ZXFEbmIzeXFSWUdrQ1c1ajFXOWVh?=
 =?utf-8?B?RytsMmxKQm56WE1EZ1BEakFYR1JTbTBGNTdLRUdxU2tZWFpZVFlib1Mvdk1T?=
 =?utf-8?B?OFZaWEUvRk9TRzhNcXBmWWY0VnRqSXcwOE1FU2I0V0xrRGJkTXlIeDlCV0s3?=
 =?utf-8?B?eis4NEZhRHduenpXeTdyaVpMMXNsUXd6eEVFdlExRHQyRGlXSFkveDNvaEVE?=
 =?utf-8?B?K3RoeXA0bGRZbTNML1JTS244K2tYRTUvaDFKaExTdDhQTjlweGgwa1AyUk4v?=
 =?utf-8?B?VjNZZ1VPdWJBcDV3RnBadDNUTVMvNUZaYnl0VnQvbU01ZzhjdWVueTRZUWhz?=
 =?utf-8?B?ckVFdlh5ZHFGcWZpaEM2c2hqVlU0blZZTHVlYWcvV3M1TS9Hci9XNWx0Wkh6?=
 =?utf-8?B?d0dKZkJMdTdhR3E0L0lCSC9UWmt1YWkrRnBRL1VsWTNuRDVlUHRyVGt1NXM2?=
 =?utf-8?B?TXlrRkFIbVcvS0hHc0FVcnVjTWxEcjJjY2oxeFQ3T2R6ajRuakJQdlJUUG1j?=
 =?utf-8?B?UmdmSDRrbmU1L1l1TmV3d1FGdmRoOE8ranRxNGM2b050TnBTRlc0bjg3VEEx?=
 =?utf-8?B?dWNRZ2dzb0dYKzE2cmxYWVhRcVlKaUlybW9DcXVoTUxuVTFsS3d0djBCYkIr?=
 =?utf-8?B?eWNuTUJJUmpCOEQ0N0tLcDA1ZHo5MTJEaTNRQlR0Q3lHSXBnNnhGOWdSNHU4?=
 =?utf-8?B?M20vUTllWEpJMGh3VUV2eW5HQVpmVlkxdGhnWWp6L2hWNVhySlllSmZrbjhD?=
 =?utf-8?B?NDZaRnE2STJrSGVpeGhrSzlrU0VNSjFuck9zSTIrSWhFTG5RMkYrNzhXeEJI?=
 =?utf-8?B?dlVDVjZwQ2EvT3V2UnJzb3N0T3Jvc3NWMks4RlJKUVhtWEg0TFlsU1lqOWpK?=
 =?utf-8?B?VXZ1ejRJV2pxQjgyV1RFY0hiaEVzQXdlM081N2V2djdXTEQ5bXFnWGpmMzVu?=
 =?utf-8?B?S1FSazFIcTZGL0NrMVlyUEhCMFhFT3ZwRC85eXJrenBNQ1pjUFhiQ1hSTEU5?=
 =?utf-8?B?MnhpLzBWTjZXaHh6NFM0NDhRV09xbGN3VXpKZmNMa2xMUVdzTytMRnR3Rzdm?=
 =?utf-8?B?ZUcrUUYzZWxDbm1FS01YUVlmRDY5RmFyd3JDYVo0bXVVdVVoWFBWaXAyb2Mr?=
 =?utf-8?B?TTVpNkdRaW4wQnJNL2RTbzJoYzVyMkJWQlhLQVFENXd6Rk5jaUdtZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2244ec-641e-4816-53f5-08de6311aa88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:47:46.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mvY0vazLJiXZQ0ZNHG8Aq8qzZhf3BzxAp8dLZgaPEcd6BEPkBI1mSmcWwRxEJY2gQHCD9kHOWTnJUaO7l2YdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11639
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2897

From: Peng Fan <peng.fan@nxp.com>

There is no user of 'gd', so drop the usage of DECLARE_GLOBAL_DATA_PTR
and the including of 'asm/global_data.h'. Also include correct headers
to avoid build error.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/rockchip/evb_rk3308/evb_rk3308.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/rockchip/evb_rk3308/evb_rk3308.c b/board/rockchip/evb_rk3308/evb_rk3308.c
index c895da934a998b4f8a4a8b32fbc7336bd4c41604..75536fe117db3fe26abf5a60d2d68e72ee99dfde 100644
--- a/board/rockchip/evb_rk3308/evb_rk3308.c
+++ b/board/rockchip/evb_rk3308/evb_rk3308.c
@@ -4,9 +4,8 @@
  */
 
 #include <adc.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
+#include <stdio.h>
+#include <linux/kernel.h>
 
 #define KEY_DOWN_MIN_VAL        0
 #define KEY_DOWN_MAX_VAL        30

-- 
2.37.1


