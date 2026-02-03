Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C5CE83F06
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13620.1770115448815948093
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:44:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=p65qqupV;
 spf=pass (domain: oss.nxp.com, ip: 52.101.72.36, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSo8nJTOpSvUNoY+812hmg7ciaUghctkX51QXQLMH3fAOw+85FBb5baFsjKIbHGeh7P6+GBtwXqTyzG9g5fUbrxkK/dm2abhQkBxDfHzvb4a8o3j0jSvd7J8/TYoKhau2vYfgmOAbqljQ3+RJQpZ5Ab33RoBZUo2/xaxNHqFPSkLnXG6QeD2u3OJgtR8xZ2ZR9Ot/c5KROwHmPDvhZIMm2fT5JgMOcBtIEM25hSvgLvTq/jgKTiRcD51PZSraWrAiHQC+tY3BzD8GGLGPJjkdQou8WrVZZfc+Y4O8efpgQu5EE0XxhoZVcUPoQaeH/At+PYLJ8FDthWOixC4gHt2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfNIjXlzFleMlM5Sbj+07/Y7FJm025AMJVxfxnXJVNc=;
 b=gFKP8lDiLVofNumyM94g4X4iYleKH9kC5XQfo/uF9fFL8WIPjRhbLwkZwbb7VK1uC5t0rBNY1wW4l62aR2ISSyHjDjPHCkoJnJhkJYSblwRuHUUlJ+eaT6drG8RUCmO1pcZ6TaQQK94g80murEgU62xODugi1yQFx5TLkIN84UwHxjT9nfYA6BIabCO/kYrFmDdVJX5Ug/+ga+ura+Jlhz5BavAra2H+yG30TdCKhfwRvuWspCpS/B9h/vwHx/N19qMPv8gyV/1/J6f3oLb/+9K9m3t0bBP+USBQ780GfycPnXWN5rpitswuWAp1srDdn9N/JKNpfc2tgTyhBthqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfNIjXlzFleMlM5Sbj+07/Y7FJm025AMJVxfxnXJVNc=;
 b=p65qqupVwPKEONbDlnQE74wKyHbjkhvzuyAVC3ZYOKZ90J2DW0RsumeMZc75chZWp6UxI8tyTA6zkwBN6mYPCKODDUDOW+14ZvrkasnUXLwMMOR6ukRZuPFLv2YYVBelO/Gi7qGpeBhy4Vb0z32xH5Cs8AvPb6uCEJAfvtpLtq+qff4tqtESX4oZlDdB5lr8nYRGiOhyMML24jUZwP06h0ZcVwOMwwJ+jPvihTCGABPzYtP4tQBuQx/aMe9aszyJWk2Anhw52F1doYwZCNAeKnDhdAdYR8FZU+ywe/Cgx/7Zh2t6iJQ9Mw6i/Amf9/5xug08MrJDBWqxLRFkjYBz7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7147.eurprd04.prod.outlook.com (2603:10a6:10:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:44:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:44:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:35 +0800
Subject: [PATCH 04/14] cmd: mem: Include vsprintf.h
Message-Id: <20260203-cleanup-v1-4-4221c13e7558@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6d22f78-1644-4f05-829c-08de631123bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?TWZ6Wng3SUtnQzBxNHFYcE9SdnBJYkNqeURsclZDWVJJTTdzK0ZKTVFQV1lX?=
 =?utf-8?B?anViRFVRdW9tTEtPeXBMeVo4b0krWmw1UzlZd2phRmthM0FrMk9xbnpUN3E1?=
 =?utf-8?B?ZWpYK2o5K0pDeDREcFJxS2tBdzdxbU1KRTJWZmNBdzF6L0Ewc1VMaXc1aXJK?=
 =?utf-8?B?dGJKdGpFcmlsNWNDUGVZTFkyZW9NOHJOalNZRzVmVjVEbWtOZ2l6VEhKRUxB?=
 =?utf-8?B?c3ozVHNqK2tYZDZhY0FvTGpQQXU3UXgvWkpWcTVGQUkrWVVLYmxacC9JNTBm?=
 =?utf-8?B?QUR1SFZHN0kyclMyWXlndGNGYWxTL0VXNXpIVXVpRE9WUDA1V2FoTlFPTk5u?=
 =?utf-8?B?VER4WVhFRjhPalZUZ2xydkhUN2Nad0U2ajlxbUxHL2MvMFhvTk5ORExTZStw?=
 =?utf-8?B?ZitDRDVaK011Q3lMTDRJdGpBdGRhbjdxazRQdWFycVhGZEtBM1ZCV3RFQjMr?=
 =?utf-8?B?aDRmaEgzR3M0dnd3TUdzUzh2S2NHeVY0UC9xTm9SRXpMQmRSU0VmTFFvcGlE?=
 =?utf-8?B?RVpGMDFYcEx0Wk05MkhJZ29KcmpvZWowbmgxTHRhbjVNcSt5blo1cDJzSDVI?=
 =?utf-8?B?T3JkM1F0RFN6YmpyaUhXcG9qTWt4NkM1di93UEFHUVdhN1FmUi9nUkpiNVFp?=
 =?utf-8?B?Snh5ckkwa1h0bmpqS0RYdG5XZ2xwMUxyTGxsOWtrOWpsSEUrVHdwdHdtWXpL?=
 =?utf-8?B?RjlUcVBFREtodGUrRXVhc0ZBVnVsRUhnZVBkSmI3SzRNS010VGNTdlhVZlhz?=
 =?utf-8?B?cHg1SGs0b0pDWW5ZSWtMK2trcEhYRUlkM2FOejloMWMwL0dsVzRNR1hzeVVQ?=
 =?utf-8?B?ZENNRnRMUE1KRlVLTTJzTlZqN1E4b3RscXEyWEk5ZnU4RVl0d3BPM2FSV2JW?=
 =?utf-8?B?SDVpR1hRdy9jWTFnS2FyVnBLMXlLb0Y0ek4wT2d3RHo5dmhSamhJejFySnhW?=
 =?utf-8?B?VlorQ0JTcjh2YWlrTlNjLzRxMGk2cmlpWTVGaFFmaTRaQXZ6RmpFdVdsRzBl?=
 =?utf-8?B?NEVISERpWlI4VktBa1U3YXYvNzJiVmVRbEZIaDJNK0wvZGJCY1dFMDVESFV4?=
 =?utf-8?B?aFhtV3BzRHVWdWtwTEJVWWVaOXpqV3B1T2xHbXlzZDBYWHNEUHQ1MFNCSVZJ?=
 =?utf-8?B?MFA3RThUczVLSHJmQ2c5OS8vdUVzT010L0N0QkdqWDAxTUQzNHhLZkM4dFpE?=
 =?utf-8?B?YjNoQXpOcHl6UElZNFpKT3oySTdPeUdwUHpPdHd0aEd4QjJLUnNhdWY0OTRP?=
 =?utf-8?B?dDhZdEtxeHZlMVdOU3hqcWNjYWVoWE5GVVZHZGxqdjh1VktaVFZBU0kxUktV?=
 =?utf-8?B?dTQ2d1BCVnNaTmJLdVlWNmxIcStKY21NMHoydHFzaUp5MWZjaVBFUFYvMEMx?=
 =?utf-8?B?SGdvVFU5MzJubGZqS1d3bXVrYjUxTDkzQk9YSUdRSEpqN2xON1cxUkpMaWpN?=
 =?utf-8?B?ZEUxcDMvUkRidHlPZ2ExaU1ZNi9LY0RXUkcxZHYrU1hXZlJQTlRoNzF6U21r?=
 =?utf-8?B?cGMyZW1CdmNrcC9VVjJHM0tYR3l3ZCt1azdZM2VYdmthc0Uycm1yZUU3SjBw?=
 =?utf-8?B?bU1DVUEwV0FkT2pReVZUTWVoM2daendNVmU3K3ZtbUoyU1lwK05mZVhsQkpJ?=
 =?utf-8?B?d1BVcXpCZWlEckVRcmhpNjA4c1dYNEszU1kydDhleW42YkdYaDA5cFhrK3lM?=
 =?utf-8?B?TXJpS0Q5N25TNkJycFZlM2hOcDBlMStJaDE1WkQ0ZFU1Mk5UbnJ4NTNheHhz?=
 =?utf-8?B?Zk9pTTUwM2JoaVJ3Wm9RVCsxR3NBWTJ3Q0JZUmNkZjQzcXZ3L3Z6Y1ZXdDVz?=
 =?utf-8?B?ZTVyZHFQVnBtM2dxdzNiU3llcnNCVGlrVmFyOVVxMGV6TU8xOWY3dFJvS2Ry?=
 =?utf-8?B?aTVFUVdUQ2hLR3RIWER0dlBuUitKc0tHaVZRTEdiNTV6bzdpemE5WklFOW9x?=
 =?utf-8?B?MjlNS3NnV2ViM0ZtNVVwTVE2djhCMHhsZlU1VTMxYU9adXpJbFJ1b1lxQ3Ft?=
 =?utf-8?B?b1lycXUzVm8waFlWQ3JWeXY5TzRJT0d0c2RxRjAzZFRDTHdhSGxQS2lITktN?=
 =?utf-8?B?bjBxSlA2S3BRbnRUZlB1VzlrZ3ZjSFRYK0ZsV20xZlNxMUZIN3l0cFpKcjB2?=
 =?utf-8?B?eHRPR1E4Y3F6bW13N2NESk1uMHJvNGdkZ1JlcHFXTityY1c4azBGcWg0d1FJ?=
 =?utf-8?Q?bExF3gGe2X2MwMLRgy1MxPTVBJiN+Ou7uswRM9sg3t2L?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?WEhDSnJMdVcweXZHcXhZaGt4YjdpMDRXQ1F1U0trcllUdVJBQkovR1lmcFBo?=
 =?utf-8?B?T2dScmN0UGdOOXhPcWtNZHFiNnRwWVhPV3F0MXcxYm9ZMFNSMjhLakpMRis1?=
 =?utf-8?B?WFdoRVNLN0NjalE1R0NpUGhRelRZZUNuR0JBOHhrUEgwS1NPTFZkZWpoMSt2?=
 =?utf-8?B?ajRDcCtWQytDV3NwK29ieTlTaHlaRDZKU2g1b0VKNmhVeHR6amw5Zjk3Zys1?=
 =?utf-8?B?TmhHclFPSFNHeSs4MzViMU05c2lOQ2hhaXZoWVJ5cUcwUWVUMjZBQ2RTKzVN?=
 =?utf-8?B?T2didnROSHdJTUs3cDVVVi9lOTN4UUFyR2E2V2RFV2h0a2FtczVvREhISllw?=
 =?utf-8?B?SHg3bjF3SFYzRVRFZTNra244ZzFTVEMyc3RvOGR2R2JlWVA5b2xJeWpFTVVJ?=
 =?utf-8?B?M3U2c1RkbmNlVVFHQTVPR2M1S216YW9hVXVrQmt2RXNOekg5eUtiQ1o5NnpO?=
 =?utf-8?B?QWZ5MkpqMk4xb0NobFl1TzFrSHN0MkJobGhsSEJCdkF4eGx2dG9uR0Iyc0Rt?=
 =?utf-8?B?RVplMEZRblNNTUwxeEtoMXhjbEdCUkd0T0xZcmluTUlQMGpEdlVSYWsxdUND?=
 =?utf-8?B?NFllQ2V0aXlweWlHc3VkcU1vSDhhMEhqcndXOHBiWWM0cjRWWFRtWWYvajF5?=
 =?utf-8?B?aEQ2RGx0Slp2Mk1qVEcyQVFRY1MxUm54WHdqa1UwaDk0ei8yMzNGb3NqWjF3?=
 =?utf-8?B?M0tObDkwekxVMm1tWmdNTjA4aEVJd0hOOFJiNUE1RzcxMUhpakpvaWNkdWth?=
 =?utf-8?B?UmlKd3M5dUthcGNUVFAxbGJvZ0t0ZThLamtBOG1nQkdJaks1ZkIzZDNDa2Ew?=
 =?utf-8?B?MTdoZzl6QzZtaldrTlZQOTR6OUgxbnF0YTU3d0RWU1hQVGFKNC9zdWl3Mmdp?=
 =?utf-8?B?dmhCajBVSlphQ3VOYU1vZDdlNjNJNXFxSEt2SnY2Yjh6ak1iOFVrRVRpczZo?=
 =?utf-8?B?UEIvS3prbEpQMC9GU3JPeU43a1EzMFpmNFBZQ3FCZW5TL3F1Y2l5MUJNczF2?=
 =?utf-8?B?TGtZclNPZnlxRXRhRS9odnFSOHkzeVR5cm1vaHV5dTVHRkErUVJtSjQ0V2tz?=
 =?utf-8?B?T1pWc2hrTWZERmFWYjlIZXQySHVyemVnZC9INFJjM1VHcVltOTlwMzJsSTNW?=
 =?utf-8?B?U0xvVzNNTlZpOVdKQ2xvYkdnWmdFdFZwVktZbm1jRGJiTlB4MGNQcFBRdXlI?=
 =?utf-8?B?YzdzMVNvNVEwaXVEa2ZBUzQ0RXpYYnRzMVFjNUMwdVRhQVhYbFIybUVOSUY4?=
 =?utf-8?B?UGdFMFhpY1JZejFlT1hIcVlkbjFHL3lwYzIrWkVkcEszWDNxQ3BXbEUvOXBW?=
 =?utf-8?B?elAvblVSQUhva1VzK2hUZzR1a3NTY2R6a1IxQ1ZhbjFyT0pPV1YrQmhQWHFq?=
 =?utf-8?B?WENFVTlRWnRhVXZOUGtUTWR5VXFVODRGNmtBTGpOT2ZxbXg4elhCUXNLTnpP?=
 =?utf-8?B?cU9LdDhBV1l3NkNXLzlWdXpKYzhwVVdnRmRKS29YdiswcGY0Zmg3VXVYZllV?=
 =?utf-8?B?ZEdLQ082L0V0Z2JtTythd01hZGQvQ3hZc3p3ZDZDYWVJbnRZTm1sY1pSRzdY?=
 =?utf-8?B?ME1Ycmx6NG9TbXBDbFhmQnJKeFBBQjl2ZnI0TkZmY1lDS09vMU01eklQWm1N?=
 =?utf-8?B?L2krWHQ4TnRyNnMzYUluTGVGb0hkdUxwYmpobUlGME15ZWxDaGdlVGNUZWc0?=
 =?utf-8?B?WDFtMGRQMHhTL2N2WjhvRGtoaFhwQmtJRkRWTzJUTHpldmJJdXJITDRhWExK?=
 =?utf-8?B?b1NZdHRPNVo4amVMZ3pTbnYyUWtjR091MTNTbzZwRDRVZ2FGUkZFZXFjRjdy?=
 =?utf-8?B?bzVqOHJ4ZzlIREJrMFFsMXJabmhjblVhNnBtM2gxVU9US2VvTG9UOG1IcXdC?=
 =?utf-8?B?YmZZWGdtSFNNRU9sOEF5U3RmNSt4aGcrL1gvbEFuMXJ0RHZyall2aExZL2dw?=
 =?utf-8?B?a0lXR1cyNzREOXovT1B4RXk2aURHUEw5NGFqTC9Bb01ZNE5JOWhGVHQ3ZWVr?=
 =?utf-8?B?emhuY0JwdkZWUUVFb1hLUDc0V1dJTys5S0RtWUhqTFdkMzFGQXptSVhzcVZq?=
 =?utf-8?B?RGlMc0VWcGhucnpMYmozTkJaRXFhM0NsZWViRVNGZjFVR0s4b3FjN0JvOUhR?=
 =?utf-8?B?aWlKd1BVV0RhYmd3ZnI1QWdOZmUraXhVUytaQ25sN0pCem90MG9NeDBnMHpT?=
 =?utf-8?B?eXFOQlh4QlR2NytmeXM4TTM3RlJhUVlBY0JHeGRlSGxoWjZSVjcwV1hXcllo?=
 =?utf-8?B?cFJlOWdFcmtITVJWQlJUbi9sMGZwTmZpVk9HT0Y3eWxUMHhCTXhQUmVSdlJp?=
 =?utf-8?B?NDVjR2o0TzR0RTREVWRnSGQyNjNGdTNnUE5GZU1lOTVMZk9BTUZLdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d22f78-1644-4f05-829c-08de631123bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:44:00.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFKU/SY3Ypd8pq3qsZabPijGusxnCe6TBsiwGimBBAq6U/hHU2JGbnIeYqpueVo+DckNhWFaZIszR6FZah0b1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7147
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2896

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


