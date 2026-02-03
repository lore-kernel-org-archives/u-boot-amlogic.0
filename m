Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E684EE83F0A
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13644.1770115586920418161
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:46:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ldyaYipn;
 spf=pass (domain: oss.nxp.com, ip: 40.107.130.8, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw3p42QLUdhSmngkTIasATjMEppNoXk+M7Nof05CBCDRqpZQSxfFF/OesszH8lfHCtxL1psirTgvByh/PTAY04td8AYF3ky05nKUHEp5er793wKVwRTUDWVbuRrPsqwiVCx8oH66inon9pHWkjANARroEyxBFjmE5ABH2Z7RjANpdHp4aBLp2IaZij1WPtWIokMA5iqTqVsaWYGmXprsvABgDEReDHHZQJaeRlDrp5juUHxguBQALm4qr3MbFs59g/cRR9ddW1+DSSaakdXfUrU2v/J39yYt1znxHu3m/RYUJOvCsI82WHsio062Qis45WXQ56swnN0i5acY95ZqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPspR1f8x8EmRHTo7a/aAkNO/gymepd95G3Fd1O9huE=;
 b=Qvtz5IXtYo5b2m1qXRAX2ZX1CVMrZj3R2RCOvM0yKiGzrY9dX6jwbK8wztqgZX7xLixwiHzYBiBG45QWk64VwyZBhHpSFdL16YVWLW+sO/ea1CjGsgljZaw/1q1X8EpJrg1VQ7xRau6sMgmJSF61clBR8MaMN37QXIkgxs+G10GaOSxI6a8UxC2n9BRM3MO2YXSpk4tszZo61MdQ7PvtVKGPAt1uyaBQKMqjUAmMdvfX63ghHhz7w75dvAkpGYvxhrvH/wpDa0mQKHH29zCaxv3+aDaVGHx6MHkGHgPJXFz18wfyW/XmcQlg4bk6nsGR7aESGkkDifD5e5hPzQiizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPspR1f8x8EmRHTo7a/aAkNO/gymepd95G3Fd1O9huE=;
 b=ldyaYipnhUnlZ0OfH1s5oVACakQG31d3Acn66OqkOsV9ek2yG0a6LoQwGxsav7j8DXyoqflSbUufcJXD/wIBZaE81Z3NWGK/DvTO/UMWqkHu7hU1Upp/M8AEetXwn4wegmZ6FfixMStF85zFFojAkDsYqDqaGSG3VEwJcsAxoH5TR+fuvPx61oH1yTbeLcCgnQ//TpUsmSO3Y2W8dWO4EHeVFI0XLRh7lkGQMBFUvDgjQx7ZdO2X0Xr3eF6wIRs4nJ9ac6aQDTJWSCkeEFw4uZPItKSWFEu42vecZpEWppayyaNucuDMNnVuMA/aTwb2zS2Wdo/NwYYCuXBDmE6dfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11639.eurprd04.prod.outlook.com (2603:10a6:150:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:46:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:46:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:38 +0800
Subject: [PATCH 07/14] toradex: common: Add missing headers
Message-Id: <20260203-cleanup-v1-7-4221c13e7558@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0dd77bf7-32e3-4b44-c2b3-08de63117473
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?cnVickJpUWxhYTd0UWhvQ2dPbUpDWjJ1SkYzckhwWFcycDVVRUxZL3ZBSEdy?=
 =?utf-8?B?OGc2ZmYyUU80Qk9HYmxpUnhMNmd6bFg1RVZlZlhXbTdVdXVpTEl2TUlCZFRh?=
 =?utf-8?B?WHpuUXFNS1MzWDBmWDJUOUluZllHbjdpQ05lZm9xekY1NkZsK2JNK0ZpRVQ2?=
 =?utf-8?B?MlZyMmNSaG4yMEN6MUxkbE1Md0lHWHArZjBSNUptMjE3YTVsSnU2cUxXRW9t?=
 =?utf-8?B?UjRoT0k0dVVobUFURXVXV2hDK01yOVhWbytYTkNyOWN3K2paZlA0QzlOcTJN?=
 =?utf-8?B?T05sTkl5YzBzZGpKT1ZVbXVnd1AyWXdlUjk1WjZ1OU9mayt0RjBFN242TXdS?=
 =?utf-8?B?NzRmRmgrcGFVdVJoMStldStHb1prYnBiYjgxYUN5ZVlkRDlMNjlpOVp1QzVR?=
 =?utf-8?B?b05EaDc5VUR5QUhDd3E3eDNpbEMzMEFPUlZMV1llS1VmVjFPTHpvYWlFT2Zr?=
 =?utf-8?B?a0YzY0ZpK3hBekFRU0tuaGFxbjBDQyt5WUlFeVdkSC8vaW1ySndjVVZWZ0Jp?=
 =?utf-8?B?dmtKL2lFSVlKK1BacEY5KzdRM2c1ZWo4Y1BQaTZCekR0SllGdGtOU2I5aHkz?=
 =?utf-8?B?NmFOTzlCS1VKeDYvRERzUmovbzhKKzhUN1BrQ3FQL3JLei9LWHJSVnFUZDBM?=
 =?utf-8?B?c3J6TVVaZ0RzajZwTHdQV2JpQXM3OTIzMmtac0k5dVFwQTEyN1o5R0p0cUJ1?=
 =?utf-8?B?eU1Ja2JXRFgwVFJOdUhhcWNORlBnUnptRkw4R2tnYnNROW4rK29ud2xxVUxG?=
 =?utf-8?B?UGlnS3E0MzAvREhxa0xpRjVhOVdPVmsrNkRyVDJOOXJSbU9BNS9WQjRCZ2hN?=
 =?utf-8?B?V0NjQXpJVjZwR0JVMVI2VzIzbWxocWUwTUprQVJJb1RCdG05UWVxZ2FpTmlR?=
 =?utf-8?B?eERSWS93anhjY0hvOXV3cGp6UmZmRW5zTDNGRy9aSy8va24vSEMvNFNFRStS?=
 =?utf-8?B?b3ExdUxyUWc2bUcyTjJzcUMyZG5jaDFYSThkZm01a2tGOXlDMXVwR2owMk5G?=
 =?utf-8?B?aW00dXJiRHBRTEVZeC9ZbDdqMXp5TFFBY0N1RXM2bEVtbmljUXlWQ01aN0s2?=
 =?utf-8?B?SkExZHhtV0xXaitIT3ZCNEpYa2dvQ1kvc0R0K090TXlSODlTa0EwT2tJN3Ba?=
 =?utf-8?B?M2tURVQ0SlFYVFVlZEcyUnA1ZUM2SUdTWkZLZkgyeEZVSFN0VHVKL2lwSWhh?=
 =?utf-8?B?eWhWc0R0Rkt5YlArUVRvdHRJYzk4YVQ1YU1TZ2syb2c2c1FwVUlwZGFVRXRr?=
 =?utf-8?B?bHFLT01KWG5tcWRHdCtpemxYcjU0aEZtK0Z3WGljT2ZQeFZybGdaSHhFMUNJ?=
 =?utf-8?B?SUxJOXdESnl2MC81bmRQZFFZL3JrcVEybzNWY3lsNDVnRkRuRGhZaTA0dFl3?=
 =?utf-8?B?Z0UwL0VEajdObGNHSlZuQ1I0bDRxaUo4a3RyYnVlMmplVGJiQ1Nlb1dsa3p2?=
 =?utf-8?B?K3h3a09nWGxxZjFxWjJSbytwUjhqZ3lIWldadVVveGlPSHhFeVNUV0kwTU9U?=
 =?utf-8?B?dklyZTM5VU9sakxTRnBVTEFibnJJQzhQby94ZlZvRlcrT0N0UExzOHNFNnZQ?=
 =?utf-8?B?Z2hRWVgyblI1dVM5Vm9mbFpIUWM3TVowTE9pUWtXV1BlbHIzTE1PdDRGenR4?=
 =?utf-8?B?MUR0aVJ3V1NYUkV0SDR2V28ya0ppZDlISXFMWkFOSXVyZVIzL25tanNGb1Vs?=
 =?utf-8?B?aUdJSTdEOWdGWjNGYmZUMkFEWXE0Z2tBMEZzN0dBdTk0emE0b2NCcHIwODRL?=
 =?utf-8?B?N242cGVEMGsvMU1RQlRKNllxb1NndktaRnNWVmFZcmpTU1RJbkdxZVlVSS9x?=
 =?utf-8?B?bFdyY2dzWVBlRmtsK3Q5WGkvTW85L0g0VDFGUVNTaWZmQVkxWVVJNWJoMHp2?=
 =?utf-8?B?Z05yVE0yNnJTQS94TThSOUoxWDZTYWFRZmFkUEE2TVNNRnQvQTlRa1pOc28y?=
 =?utf-8?B?UGZ2Mmg3UGVFTnkyTGlESlEycjNHdG9QWTJSbkdLeVFNZklZZ1R4NjFUcGpo?=
 =?utf-8?B?Vy9wNUMwZ05FY2wxSzgwQXZma2NKNk96UytOa2tXM1NtcnRTVjFtelNZWEtp?=
 =?utf-8?B?aFJ6WklxaTJGanIzRWViTmFPMFp2c2s3UHNtYUJRb0ZJUFh6SlJzR1U4b0t5?=
 =?utf-8?B?SHdMa0FNaG9qWDBxbkt6Ynl3UjlzWHl5bnJHa3k3cmVlMFdLTi9uNnYxZTlk?=
 =?utf-8?Q?BLVdH9X2lrMsTKWNSvkELwKoYOibtOtPPz/h+zE456Xe?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?YmR3SDhQMytlVG1aWTdJRHloYzlIc2lnVFRReVVlVmhkd2M3NW9PWUMwcWJH?=
 =?utf-8?B?Zkw5V0hWMVRIek9CNkdYdlV4U3VNUW93WXpZZE13Y1ZHRVhJWWVMSGpxQnc3?=
 =?utf-8?B?N283WXJGV3YrUlNQWUxmNjVVdmY0Nlo4TTBWQ3hMcFZXUG5yWFFOUXlGdWNz?=
 =?utf-8?B?UTEyVlg4M245bU45Z3JoOU8wRm9hYkxpc2FvZFBiRG5qV0YrUHVRbkNDZmlF?=
 =?utf-8?B?R1RHQitpWUJwa3o0NjRlSVQ4WXNyYUNTN2trU1BWR2I2MEQrT0NEZGV3c2ZR?=
 =?utf-8?B?eExnaHpiZ3lBTzN0bThyYnNGdjJJNjEwSllMNVBaVm8rN2U0enp2UlJPMjdS?=
 =?utf-8?B?OG9FSlN3Uy81SCt2TG1mNHFmYVpkdWYveVJYMmpVNlZLbElmSUI1Zjgzcmx1?=
 =?utf-8?B?WUtRV2g2eDJ6clQ0KzNRNysrU3k3VVBIZFl3QXZLTlMrRkZqbjI4Rlg1MkYz?=
 =?utf-8?B?YitDL1ZjbTdVd1hxcWpmTmsxRG1mK0Y1dTFBekFmUjRIanZ5ajg4Ky9GRjJ4?=
 =?utf-8?B?b3lCby8wc3Q0RGw1Nm90MUV6SGdSZldXdk05LzFkMzlYRTNlbU1IZzhhQWtQ?=
 =?utf-8?B?OXNOdjJOY3NMK2hieEV6Y2JkTnRVYjZRWXpJTW5zYW1HZEc3bEQ1NmJjajQr?=
 =?utf-8?B?NTM1Y3VXM2QyampVa0xMNGVCWGJJUXBJSjlYREV2bTByWGxqR0djVFZJM01a?=
 =?utf-8?B?U04wcEp4SmNlcXVTOEd5S285UW4wZkZINkVxbHNHWGNuS1p1RXpUOUx6clph?=
 =?utf-8?B?eWZQNTR4Z2tNaU1OZnVKZXRKZGY5YWUrUlU3WEg0cGxHV0tWOUIyY0p5Mkpu?=
 =?utf-8?B?MVJHV1llL1VoNCtuNndoQWlTSTcrbUNHaXFZWW1YL3pMaWtRYlIrZWtYeXIw?=
 =?utf-8?B?M3p5NUM5Q3lGTUFLc2JrL1l6T1NqeFh0L2ZyS1AwZ1dqaURkOFhuNHo1d2dT?=
 =?utf-8?B?aVRseFUxcEVuZnFGL1A3NTV2ckxha0RkaVgreTBESW0vL3R6bUVMUzNHYnJH?=
 =?utf-8?B?OVFuTHR2S2h5L2NNc0pmU0lBaitHZExKU3hXaWVzbk53MEg4dEpPa0VSVVlr?=
 =?utf-8?B?Q3h3STNndFIyWjlHcFc1UUQ1UTZyWlFINzhFQ09wUXppdm5XMkEwUjVaMGhl?=
 =?utf-8?B?THNlbkVzSElxUXBqdS8rQ0dGNUlpSGltdFg4bmdMNyt6VGp6dHZ2UmYza0dO?=
 =?utf-8?B?ZTdhV1pROUNWbk5sY2NqVHlxLytEdlhEQ0FwQ1FWeTZhNXhkcmFNL2ZNeUZT?=
 =?utf-8?B?NUlHOW1oYlNkWVE5aUpmZnVBNEF3TGZYcTdXbDYybExuclNnL0FrVTlRcWhH?=
 =?utf-8?B?ZzN4VnJVeERTOE1oeGQxZ2xoMnQ0MDVmNHE2eGVNL0dNYzE5eTlFcmJHcHFv?=
 =?utf-8?B?bS8rTGlBQXFxNmNvVzlFeEtMNVhrcDZxemdpa0VhT0NRbWlDMVVwSGlzaWND?=
 =?utf-8?B?cXN4aW1WeEdDajNJc2pnczNWQnNEN3MwZHdtaDRHcy9LbytsWmNqOXJRZ0hi?=
 =?utf-8?B?MFRqMElETEFac2E1SldmL2Y5RU9FMlFjTTJheWdvRzd1QnJnTjFoV0tnREc3?=
 =?utf-8?B?UVh6NUZaWDlLNElVYkdoSE9ScERVSVAzek5pb2dFWXdNSDZZWk5ZamF1YjZC?=
 =?utf-8?B?KzMwZnl1REFWYnJ1elJKdThYNEd3dUhKTmo5dEVEaDg3dHMyOTdGdlBIK1d4?=
 =?utf-8?B?eW9vVXZWc1NRdUFFZHBzM2M3N1Fvem5WN2R1aWJnQkRHeUJzcklycHZlcjZV?=
 =?utf-8?B?bUg0ak9xaXk2QVhpT0JXN2w4RkNNbzlwWEhOYUNVQndINmZrUXpVdU5Ja2JE?=
 =?utf-8?B?MTg4NUxjQncxVWo0KzdnczhlUEs4NTB4ZDhmNDJQcXNGWURXeTNIcmNja1g4?=
 =?utf-8?B?L0tna3FEL09rRC84N0FSVnowYUpjblVoZ09IeVYrMEN1V0pmVC9sei9NU09N?=
 =?utf-8?B?eHdIaVhwQmE4T1VBb0RwUEZnbVpIaHA4RncvdlcvcXAvWjNheXVaT2p1cnBZ?=
 =?utf-8?B?RUlUWitiaW9rQXZtMGNqaHNGVHJJZ2xUOXROQUxHNmE4LzZlalBqK011WkI1?=
 =?utf-8?B?TGNJRnRNMUNGRWViQ203MmZlL0dveG9QdSsyUm9RUmdoTUpUODZKVVpmUjBL?=
 =?utf-8?B?cVhEZjZqcms0VFZSTU4rbGRNUGFXZFRCM05FN1BUaTJwWVd2YXA3Qmd2eHhJ?=
 =?utf-8?B?Y0c3YTJ2RUllazdBVGRDR2tjZjR6NEY5M3ZSUG45YnZtbi9OMkhoSGgxNHJp?=
 =?utf-8?B?YkdhY2t3dlVDcjQ2Mk0vVHJBdytLaWo5WXUyTEN6ZSsrSTdsRGdDM2V5c0xt?=
 =?utf-8?B?dW9qdlhqdEsySExaa2NRWUNXa2M0b2Y1eFFQcnk4TjhZMjVUbTVKZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd77bf7-32e3-4b44-c2b3-08de63117473
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:46:15.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOq8hyXURNSPFDDptG7CqxHjKpRpPag4vkQo6X9It04MLX6ZGzNr0arhCGk7eVF/jFJRokpXtAiFnPuNPu+s2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11639
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2894

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


