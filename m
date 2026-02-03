Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399AAE83F17
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13972.1770116259453963176
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:57:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=hGlz0FaA;
 spf=pass (domain: oss.nxp.com, ip: 52.101.70.15, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us89UZqLld7WKovXc0I1ss8b10p6meaceuwn2Q9AHqJzT+UiBSXOewwG69wS7O4z6Ng9vzskI3nf1WixdqcfA62mzDCePL1+iMQAZt81vQlkeVwrJ2g49sME8QcNTANEBhA02Cnl2v/TdG1RwpHEKOxeU9CTrcNhFWx/QvP5mjws86KjmWEGGvFs32IkTSFlbgDBFsjS1OU0n6zN3iTWe8wr63I/bOD7iJMjjy4al8yUhe9Bm0aE8lhfJdy8+uCs71vE37YTgjZcnfu+JFjE8BcLwJjtRr7xaRAXYt0OrZYNzSUWSv2valL+fCQpcbRinYdDjmbkcrVGv2wCWmtQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNZEjv4XeyFjVnflGVu4jur+/eBQa6VRS5f+9Ri8EII=;
 b=YgRtFcVis2JNKHrsbturFXs1x2phx0C8ZiJN3QTvoEblj5eLShwQ52YrAlXC5unTxkJb+ncTiYGEkTWVrw0USYc9pFnuPZn59SKoy64165AVGan851tT/XlmYmUREdgQ7Nxueid81fohuZm/h0KY4SBr4hBC4mdqwaNFxoot0TJZ+jJj9K2hwGYZfx3Uam6MzIIgDLeYfCmNhsmB584qK7h4Ar6bdpsVO0o59+4Bks+1ZWWdLD2JQsBUxMjsrKfngZw0U0leieCADHybpLTvrge9KljLxUfyzSB9IeBThfK+fL5LCoj/AtQykrBnnvBiJxzx1qmb5P8oOvzhbi+pVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNZEjv4XeyFjVnflGVu4jur+/eBQa6VRS5f+9Ri8EII=;
 b=hGlz0FaA2EZnbIIOSYQoBhcngBXWmTGu7lgyijk12zh83bcQ6rVcWaKVZsOo5Bc2UGmV5CgVrWfDMDXXTCvR2wlOby3vgaW7TZZ8hniBcPKMjiLMLNGM4tbWs/InzAeJaZjOV1dgBoYc85vE683bEQXlQvifbs39+Wv5AEsmOevIF/vWtCG8868Xi6EiUoHA2Np1JlqpNxkNtGvAxK7Bi/joB1DuqsTxQoz+dXEOQ1f0VIAsRPEAY99bIOAXKmfsStFFvWXWy7lHyQg+Caamp5pbubinxBy2sMakj7ZmMveFTA8HRFmFj89Zjjk4nXUpMyDe14gT9Z4tVp6+fEETMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by FRWPR04MB11197.eurprd04.prod.outlook.com (2603:10a6:d10:170::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 10:42:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:42:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:33 +0800
Subject: [PATCH 02/14] mediatek: mt7622: Drop useless board files
Message-Id: <20260203-cleanup-v1-2-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|FRWPR04MB11197:EE_
X-MS-Office365-Filtering-Correlation-Id: c7397bc2-30eb-4479-a2c2-08de6310edef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?NXU4QndqMkJUa0NMNG84ZlRLbWJsd0tnRzJWcVdHWHhFVVl1YWtKRnVRb2tU?=
 =?utf-8?B?MHBqKzBWOWU2S0k4Y2E1ZG54ZjFvSkcwYitDWjZ1ZlBVN08wN0UxOVN2Rks4?=
 =?utf-8?B?UkdwSnNNczBMSlRRbEM4OHBNZVFMeUxYakxhVWw3RDZvNGdtVWQ1Vm9oVUpt?=
 =?utf-8?B?MGFVWnFLbmxtZUZnV0huaDc3dENFMmo2QlM2bEFBZ3JXZ0t0aUlKUzlsd3p5?=
 =?utf-8?B?ZWs4OGFMelFyK3EreWRLK05BUy9zWFM3NkxlbDdKQzIzLzBnK3pSVjlHQ2lO?=
 =?utf-8?B?TWJoN1Q3QUVCMGdLT09aUXNDRWkvRHNYZFdFYnd3TGxoYWFSemFXd3NqMWwr?=
 =?utf-8?B?b2I3RmpVM2lIS3M3R0czUy9laUFQNHo4V0tiRzRkNmo2N0hNRFJabnloeFpw?=
 =?utf-8?B?QTA2aXlTdk9hcWFHcDYyeFBzZVl0dmZSYWJkTDc5WGpSeFI5Q0JCRUxBMnZX?=
 =?utf-8?B?VVhnSFZrRVRXYmRkU1IzZ0ZFV1Byci9mYVdzMDJBenFKK3pjZHQ3bFJjamhq?=
 =?utf-8?B?cll2M2dlSjd4K2srWnpjUXhGUzc2bHpSaGRHUXFZUXk0bllVTWJYUm56QWhI?=
 =?utf-8?B?M28zZjNnalAvQThpZXlPZE82bEhhdVYvK2x6YktjN0ZiUzhsVTlMcGs5c01F?=
 =?utf-8?B?S2U0ajZMU1ZUUmd6aURvb2haZVNHRHRDVzVLMUgwL1paZm1IUUE0dmpldnZy?=
 =?utf-8?B?VCswdE9tL3pueWtwYzVIZmNacng1NEYrd0Z1aUI4eTFrbjFTVWZaRlBNRXJs?=
 =?utf-8?B?NlBVM2cxOUdIeDJkM1Z0MU9MTjlxKzBXWFFNbC9ENDVrMTJJYmJlcWkrdDh4?=
 =?utf-8?B?SzRtZlhFWjRMSjhXZTMyNVZEN1EvSVZaLzNJOXJhanBVWFRuZ3ZuaXp1YVdp?=
 =?utf-8?B?Y3NvMlZWdC8xaUJQa1JoNVJPSHBuQVd0UkZlbExFU21uaXBNMDFaMGtPRld4?=
 =?utf-8?B?cUtoN3RPNGhzWU1qL1VqbTFjTEJ2cnM2ZVdYbW9sMVl0cHZaN0w2dDQ2V1FW?=
 =?utf-8?B?RXhwc2lhbDBocWEzc3JuejQ4WHl1UktOaXhSYzQvRTJJQ1FBSFRBQ2JSK1N0?=
 =?utf-8?B?aVBEVXRNckN3YmlGZ3pYb3BVa1VkRGdkVEo3VjkrbHNMeGtrS1BEL05vbS9B?=
 =?utf-8?B?bytnS1IzU1JUU0hwNnVaZEFWa1kxMStqbUpZRlZ5TmdRQzlhZTJyT2c3Tndr?=
 =?utf-8?B?Z1hIY2IxUmRlVVdXeHA1ZWNob3MzOXRyRTRocG96TU5MSitLWTNFNXhMTDlQ?=
 =?utf-8?B?UmxzYVk0YVlJUEhOazNMRzg4dk83djkzdkF5QUthdExKOWFRM3Z2TDVlYi9l?=
 =?utf-8?B?emM2U3JUSlo2N1N2TFBXVXJwcTA5ZlFRL1VTeTIrVDQ4SFJaMm1mc2xCaGQ1?=
 =?utf-8?B?Zld2N25wMms5RWVSdnI1cDk2Y2NDdGRPR3FocW5HYkIxam13N1Zjd1NhUGhP?=
 =?utf-8?B?dGdmM0dDMlFPSGNvWUJZbjFxVjFFQnZQYXlnczRpQ0JPT2Y3QlZ1c2Uzb0lm?=
 =?utf-8?B?d2N2dktYb0FLMXYvRFExUjZubWVTSlhtYmh2bERlbDZqQmg2cDJEaHFhMTVP?=
 =?utf-8?B?WUE5S2NaUDhpM2pyMVRzSUVoUFptUFVKY1lJTXU5bFVhNW9xR1pWVFBzMnV5?=
 =?utf-8?B?L0hkYlMvVS82MDJvSDFwM0R5WWcwU1BBL1BNaHNYejVpN1dBaWp5YWpDSnlS?=
 =?utf-8?B?a2MweWJWeVlxN2RlZUFQUFY3RWNLVldyRU90U3FWMjlKMUsvOGNjc1o4WE1T?=
 =?utf-8?B?NnVDOFRya0hEOVUyNWRTNjdzV21jUlc3SkJkRGlZLy9uL3pOTnROUUpSVlhN?=
 =?utf-8?B?a1YzSG5RREVWdjdvTjRpQVZPZUZuSk5wZGIxRVB0TWxqZlFMck5DYU5zL01a?=
 =?utf-8?B?RWxrYlFRRGxxZzRiVk51WWFGbWVQL3hLQWdlcGVvbHFzclJkVEVTYVVrdnRI?=
 =?utf-8?B?QnF1aU5SVXh2b1dOMDhEKy8wMWNoT3RsYzVqWk1jZ1dQWkt3ckJ3S3U4VnJi?=
 =?utf-8?B?a1NFWU1oWUM3blBYbVlXUVFRWVprV0V2WWZWeVJNY2Vib3hnQmFIdm93bjVh?=
 =?utf-8?B?M2ZFRE5wMU1CanlNWFlYTEpPS3N6QWZ2YnRVbnpBbGdNZ3V4UmE2Wm5HSUJs?=
 =?utf-8?B?SkxBbVRzanBkMEdjT2xGWVBaY0xQMXhjalRGdHVJTlR0a3ErN3U3UkRLRDhi?=
 =?utf-8?Q?gpVUw2BoJ2T2TWXz/KviUjmqRxsEeP45onuCVJkzTAF2?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?TmxreGFXMStFM2VWcEdTMnp1WkRsaFV2TzkwUUNIQmpobnpuZXY4aE43Rkxq?=
 =?utf-8?B?UHpVbC9ieVoxZHcxYm1neHpJQkpGQUNXSnh5cG5wZ0xadkFSNVZBcUJ0U0o3?=
 =?utf-8?B?bGFSRzFwYTJDNFdhdjdQYkZMTGlkdWVyZDl2MHlCM2dUaFp0TitFRTlUZXUw?=
 =?utf-8?B?RkJIWWNZWlVkT0ZJU05aSHVqM28zRVBORCtyL2dBOTFZaFVxRFhVa2xWUElm?=
 =?utf-8?B?amMzTlhjRUtndkFDdDRRQ2RNWDNoOWRjcy9xT1d6b3lmRThIWmZFWnRtSkJ0?=
 =?utf-8?B?L1ZiZE5zVXlPaEcvam9xbVNSa0s4c1FZbDFNNE95SlJFbE1wNy9XR1pNdkVw?=
 =?utf-8?B?WGIyRWJkZktNUDRITWgxVmxiVWx4RmVOWmFDWEJWWW56V2R4NjU0SEx6NTF4?=
 =?utf-8?B?QUQxZFduUXpVZnR1dmpIWTlaTGdjQ3JPRWl4Zzl2eEZGdGQvTjRndGRrSGdN?=
 =?utf-8?B?eVN0YjFiVU14S2Z5OGFEVGcwWkdZekltWmkyL1pHYithcjcyUFgrZXU4dWZQ?=
 =?utf-8?B?TVd6c1MyeGcxRW5LckdYV051WkdObU5SeUVxL3Z6WGJUL1oxSUphNWFhZUNa?=
 =?utf-8?B?bzA4bzNzNVBmaWtyYkY2U25pOGo5dDZBNWJJL0VxeUdMcGp6S3hzS3d6bThH?=
 =?utf-8?B?dWw4VHVQMG9UQXJteG9Ec3BSVXAxOGhhVlV0S0crWjhhSXlRQUFValQvYjZr?=
 =?utf-8?B?QVh0QkNmdU45TC9YQkFsbFJPNmhkZEl3dXZtUElJVWlmSUNObTVqUzBTMkc0?=
 =?utf-8?B?U3hYcWYvaHpwelRsd0EyN0tSYnFZS0hFVThDemptcWVPSXdtSFRLYlN5Z0FX?=
 =?utf-8?B?VXhMNlB0Uk5vY2puMGlCaGpBMTAydGtsZXJPcVF1K1dLQURTbldVTmxXVXRj?=
 =?utf-8?B?a0RPLzR3Wm5PNzkwMVZSTHdDV2VOclBpNVM1S1dRcWtYbXQ5VWlIakxMZEN3?=
 =?utf-8?B?bWxvNmIxSkVXTWMxQmxsaGRHWldSdVFJYUF6L1J2WWZQMW5OczFsRXpnd3RK?=
 =?utf-8?B?M0hYTy91T0RXRFJ0WU1tL2lMTDhBZitudGhROGJoT3lnVGd0L29WNzNRQzdw?=
 =?utf-8?B?TWM1OFlQZXZOdDFzRy9NN25HZ3NKVk5rMlRSOElGT1RxOU9Ed00vTm1xeld6?=
 =?utf-8?B?WklBVEpEV1pxZkNOUDdLaDl4WDlXYkV4TUlQQzAxL2JhYnNQMld3U1l1cmgv?=
 =?utf-8?B?WGwwcVV3a1QvaGRCdjVBL25tMjhMUmRJQVZhK3NJRS80ZGEvdVhBSm1MZnEy?=
 =?utf-8?B?N0R6N1YvSmpjdllpN005OXUzWDFkOGRiWEExQ1ZHNlpiMGs1Z2JMM1JVWVhi?=
 =?utf-8?B?bHc2SlZUbkYvcUNGQm05cExtRFNlcm9nN3ZJcmZXdVZrak5ZNEU2MmR1SkpJ?=
 =?utf-8?B?M09la0R4dmk0R2JCbWhCaVZuOGl2MG5GemJmbHNQSnhOMUxMNDRFcVFaanFE?=
 =?utf-8?B?bVdhbGdHc3lsN2NoTXhMd1RyMjVuUlMweGZyeHVYMDBjRWpMQXczVWUzcUcv?=
 =?utf-8?B?T0crMEZHcXRuV3ZnWUZZNFpiTkdWYnp6RlB4blhxczlkKzZxRDdOZDI0akUr?=
 =?utf-8?B?bHNMZGFYT2ljeE02RHpsOXJQZnA3WGVEalFXUXJLejlrViszSFFmVjFhNFln?=
 =?utf-8?B?eFVKUStQRHVhK2lkQjVoVXBsSXp5cEFBcUd6dktBaUtlSERUS2hvSSttUThh?=
 =?utf-8?B?a1B3c0hvMldKNWtnTGsyNUI1N0FrTWJHWmY5NW96VmFBdkJJd3pqYzlscDBP?=
 =?utf-8?B?Q2hhVFRLT00rWVNBeWJkNDNpN0tVUTdOVlNsbFVKaXYrQkxBdkUwamtBUXda?=
 =?utf-8?B?UzNsSHFQUDV1UFNIdmVzNDFpSDc5Z3Y1a082elRyMXluTllNYUFDakRoVEtx?=
 =?utf-8?B?RFdPNmtpeTVTc0ZteWxQaDdPN2tKN2dzV3AvQkJrVmFnVGpKdFlGczJsUjNG?=
 =?utf-8?B?K1RQOEdSajVYRzRKSXBhNC9zOWs5Vkd5R0JVclJmeE54OTBTRFVkR0loV2g4?=
 =?utf-8?B?dW9pMTJYZEEvMm50UDNyWHJ1MVR0c1JEeG1kYXV6UDZROWpIRlRhczN4aEgv?=
 =?utf-8?B?RGhubmt5ZVovZDFWUTlnSG52WDdIeERqOVdMa3NnTnFQNDJzMzdaQlBtek1U?=
 =?utf-8?B?YlJ2WHNmTitVVVdRNEtURWcwdnlEVG0yM1kvQTN3TU83c2dXVWt6VEJweWxC?=
 =?utf-8?B?eTlNa2tPL3RFbDhudjUrTTBCK3NwRFEyMFcyc3hCemFhR2FLejlyeUFQeDBT?=
 =?utf-8?B?UnJqRnNhTG9sZGliUUY0MGtoRDZacFZlc29NNHlkVUF2OTJoclErTUpvNnVS?=
 =?utf-8?B?R1BRdjNOa0crQyszUXNVTEdveHE3Z0RLa0FtSFM0QnAxLzNERFZYQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7397bc2-30eb-4479-a2c2-08de6310edef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:42:29.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs0uY55swVnJC+/AjPfBbyNs95lkULzj90Crp4Ux/jIZG7r01Lfq4UVkgeyRybgT3HkWkMtPl1qtljgJPDNf1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11197
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2902

From: Peng Fan <peng.fan@nxp.com>

No functions except reserving gd in the board files. The files are
useless, remove them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/mediatek/mt7622/Makefile     |  2 +-
 board/mediatek/mt7622/mt7622_rfb.c | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/board/mediatek/mt7622/Makefile b/board/mediatek/mt7622/Makefile
index 64f101337bf16620665cc5d7a308849ba127e107..35f3136e833b4d7f8a92233708e3e15765272b0f 100644
--- a/board/mediatek/mt7622/Makefile
+++ b/board/mediatek/mt7622/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier:	GPL-2.0
 
-obj-y	+= mt7622_rfb.o
+obj-y	+=
diff --git a/board/mediatek/mt7622/mt7622_rfb.c b/board/mediatek/mt7622/mt7622_rfb.c
deleted file mode 100644
index 405f393aade112356ef8422a6e9d4f271ed2e672..0000000000000000000000000000000000000000
--- a/board/mediatek/mt7622/mt7622_rfb.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2018 MediaTek Inc.
- * Author: Sam Shih <sam.shih@mediatek.com>
- */
-
-#include <config.h>
-#include <env.h>
-#include <init.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;

-- 
2.37.1


