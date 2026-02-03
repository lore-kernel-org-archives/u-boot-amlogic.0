Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557DEE83F1C
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14569.1770118387622501528
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:33:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=xM4UCuun;
 spf=pass (domain: oss.nxp.com, ip: 52.101.83.45, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpXU6nyL7aJFdtkne/p7OqvJFAKK6LvGLLQew0J4pXLKucljugTjJfOE6avzrJJ6td+IeUDQaUangvmoAw+tgL6yW0632IFVoAlcFZDDEcJj1vMRZ3pjlLeic0HoMEWEPrJZCl7yc2X4pJSHnUFqeARv8QTJ8cWorLkrFLScfkxaaRwUxh52Es3V0VOupgLafshIcQFrXnwEZYOQ9gY7R0xEnbLD1qcmQgkpwsX6FYWvqRYmYMt1+1gtaN1psfZzMF/bn2Cb2a/17Hu0zd34h0PO8c8ZGavQKHSRZMaOTeB4pKnOmvJaLHutv4s1Lz0Qimcz5Sm2ISyzoJJbIWq7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNZEjv4XeyFjVnflGVu4jur+/eBQa6VRS5f+9Ri8EII=;
 b=OhJCAFlGYta3E6mbxmR512xcV75K6XeTiSbZG/Jlxu11glAqlso3lDo/vuP/5PtsI8p12arJoey/OKMxmzNQpNkWYDoE6YUUQpWLELDF+uNNwWToXtVCNvxdYTuUs8V+zXTUjm5sSVh7YIYaUbPv49S06xBzMZ9gcsFw41JFsR2rs6lCEIUJ5LJg/J2Q+VmEBrVx4+99qqTIxkqNK65G3KQhsSIwvk2Tvkfx4u3sUTIi8a7RK5KtG9cB0w0ujS4VlR9hWkIzZd341XzDXOQ4cm2oHNdjz1h380EwCoKZdehDCtT33kZa80QLriewuaGuBXxGnYXFSaMMALFlEXgjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNZEjv4XeyFjVnflGVu4jur+/eBQa6VRS5f+9Ri8EII=;
 b=xM4UCuun/pufWXRr1v0ShumSrnwDwE+z/NdEWmmlqSCh1dz8tgmmCtLVWJrshtEWzkVKMyBP9//ffgDIy15Zf/WB0bz1Bi3XahTecjXvVX01KzI3/S4dJzdgC7zUhaFXzNWxIgHOGkkt+bP75cU/PQ2ui318sf5U6pvBrG23d8FxNrrr4lpf3SIwU5QEsixslsrI2YRPDQ6X+K061yGrRyPHRLDz6ANgs0T47h4KEAINfPLNCll3HSuCYX8lFbzhFuPXFBFdTl6mXf7h9zX5Ur3AHsW0i3De7UAKmjCzoJcFkRcYCj4QUgZ7RICg8hODf+gLbQoIyWi/jasZXQOy/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 11:32:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:32:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 19:32:06 +0800
Subject: [PATCH RESEND 02/14] mediatek: mt7622: Drop useless board files
Message-Id: <20260203-cleanup-v1-2-732e986039cd@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: d69e01cf-0b73-4f21-1191-08de6317fa19
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?TkQ1eGJnOXZmd0EyREs3eHgwaC94VmNxQmdBcDUxcjVkdW9aT01aQ1p6cEQw?=
 =?utf-8?B?cWxWUWpZZUtEd3llY0c4OUt6dEJyWEthaWZkdUpGemZ6RWpRVVRkWm1aeVd0?=
 =?utf-8?B?QTZFdyt4cUJKQTliWmZtTFduS1B5QkZFUC93ZXN1eEI4aEwrTjFvZ1N5NjJk?=
 =?utf-8?B?QitkLzFTdU11dkh4VnAxdktFMXBCK3lNT3FzRlNRZEZyOU9jRG93RVk4K0pN?=
 =?utf-8?B?Y1ptbEpLU2tmRWRkdmxtaERZQjlQaVRqbG5RcDA4QXBjN3dnZVdPdm1CM0dE?=
 =?utf-8?B?ZFV6cGdxMXk3NW56dVNVTGx2bWJDVXR4RDN1VSttU2FER1EwVEtYSmtXMCtk?=
 =?utf-8?B?blpyeWVFbkFVYkpDa3lzTmJOQjk2VjcyYzBmMlFaSWFEUkJvSWJsZUpQbmlO?=
 =?utf-8?B?eW1kNTB5QnZYSTh3aFNYRXFvcHR0UUJDVDA3OFNYaVpmWlNOdldOQXVocFBk?=
 =?utf-8?B?T0lleEVxS0gzVHdLRm5hRmRIUzFFckRPbS85U1R4ZFRMZU1MQzJKTWtGSjk2?=
 =?utf-8?B?OUlaY21VcFVIQUd5NmJhdEhuVDZOMFlQcDBVa2NsYndubmF6dmFjU1Z5aERN?=
 =?utf-8?B?Rm5BZDlLRzBqTjZnT2RvUUd5bDFmWFlkaU9pSzljSGxDYWRMMmhUNXJBMCtJ?=
 =?utf-8?B?T2t6cUpWRHFNVkVIeC9WMDZka2p3YjQ2SnJUVHd2NUorMU5UZFJtRUVaVEdW?=
 =?utf-8?B?azNXTmpiL2ovWHIwc3ZNQzl3SG5SQmMvNXVHakQ4eHZHNEM4Y3ZWcnpsNmJi?=
 =?utf-8?B?R1JSR2hOaWVXc00wSmR4b2xtM2V1Y1Fld3I5TGQ1UXJ5TmV5akdLdStuZG5J?=
 =?utf-8?B?SWZsRTJ6UDhTZVY5dWRwdVVVdDNtYmxoOXZYemdaVW5hUGdtTVcxakdkazNS?=
 =?utf-8?B?LzVUc0ppMFU5ZWtkMFdReklGdlI2VU4rRGdmd2dFU3RrbklxNmk3WkZzcklR?=
 =?utf-8?B?MVZLUlQ4VmM2bFIxbnZaaUQ5TURjQkpBaURjTkxmbWNiRFhZckU0RVNTYThN?=
 =?utf-8?B?NEpWK09hVm43VVo3OEJwcWJoOXZKcnJUSmd0bmZPc3RSdW4ySW0wcGNOY0V1?=
 =?utf-8?B?SkV3Sm5LWVJGVFN5aHJFazVWd0JDckIrNVo1eGFJclREUlpPV25NQUVmL21J?=
 =?utf-8?B?aFlwMW9SNWpZYTM2Nk9raEVoSWZuN1FBVVJUVDUvU2JLMHlRL1YyT3ZsamMy?=
 =?utf-8?B?OUZLMHJCTjNsUVhLZHB6WHpFZ29Ea3BqSmpzK3RRcWhteGZNdFl3N2VWNHZS?=
 =?utf-8?B?MHRVT0RuZGN6cGxJcDg5cDMwcFlsdnVWSGxrUHdHUFZNQ3c3d3k2VzZtQlFB?=
 =?utf-8?B?dlJuT0hEa1U2UFp2NC9VT1U3V0laSEZyWUI0YzV0MUVDMWtxdnpJZ2krUHdW?=
 =?utf-8?B?TEZTeTNFYkxvYjJES2dqV3g4ZGMzdEU5Y2FkczV4TzdNemtmaWMvZFRUeHdT?=
 =?utf-8?B?QnZWOWV4Y1FwOVpjaDF6N2I0OUFLZElYNktKbEl6OUZOYXd2ak90ZG0vQjRU?=
 =?utf-8?B?MUh6SGlQTFpvVDJ5ZDlrdlJJcUg0bjRHZW4zMU1rNitGZGUxMWZJV0IzVUlP?=
 =?utf-8?B?eHJpb3V5cHZNa1hlSVBacDRFNkxqdnhwWlZ2Q0MvdDZxM2tBdFRKQkdvYXV5?=
 =?utf-8?B?UXhQVVJ3bjQ3VThuNlpTcVJDdjJNdFRLUWVzZVpZd0I5NUhQa3JjaFhIbXNI?=
 =?utf-8?B?Z0F3UmpLZTFvN3IwTjdTYkRWZWlibGVTUHVac0lpZDRGSjEyS2dsSDZGaEM0?=
 =?utf-8?B?djF2WEdLZUEvdVp3SHhuMEhkUzgxYXFzV0ptOGVQTmVzcmdBOFNqOEhvQkR4?=
 =?utf-8?B?aURLNld3Ukh5NFJDVWg4Z24yRXJic1pSMTlXelJZL1lHV0wrODQ1dDhyZnBu?=
 =?utf-8?B?Tjgvam4wOVppWUlsR0haN0xvUVl0QXlEQkZhbHpjbDJ1WGh1bFg5QXNYNEhy?=
 =?utf-8?B?YmN4TTJsaDNUZE9tN0VlS3oycWtNaWRIbjFWRTJub0JjNDdqa0h2ZWlkandF?=
 =?utf-8?B?WmhTVjdHTXh1Rko1ZG4xcmd1ekxteEtsbWNYSk53WmhWaGVTQkdVRDBldkli?=
 =?utf-8?B?dEVpdVJLZHlVUDZjdGJpWEQxbFBUZW1lVVNGRnQ0aFNsQjFNVnB1T3k3RFgr?=
 =?utf-8?B?UWt1aFp0NFhSU0N4aEFsZ1RBTmZJOUhPVFBRRmtoUDFPNlByRzRVOC9aeVl1?=
 =?utf-8?Q?3eycUBaTYB281uilxdGMHvSS4f4GtoRLe2pIPp1+6MMr?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?VFVEMHBjVVYvZ3RaUnVKWWpVZ3dIT2hNU3huTTArdVZXTWhva1lxSXhVOERR?=
 =?utf-8?B?TmhNbXlMQXUrTHhOOC9zWTFhUzRwVVZaWjNYeVovU1pwRmJkUHBRSVVCU1Z3?=
 =?utf-8?B?Vi91bjQ1V2dnRkNWVWl5VVFuZ3YyRXduQjJWMkNZVGNRMkRZR0xENnd3UTZ0?=
 =?utf-8?B?ZU9wLzRuMjgxWU53aVVlUEZjeTlGaThWSWEyd1N2VjRia2RuYXlSL1FxVzdo?=
 =?utf-8?B?bGZIRlh1SmllTVdhUGFNVG51Y042RWpiMXpiR1FLUnFqbTU3aXlXbHBFMEpU?=
 =?utf-8?B?Y0RGakpoUms4bTdKb1FncXQ3T1JsWTBjS2NUcUd5cC93akxnTzhPc3RSMGpS?=
 =?utf-8?B?MjJoTVdQSW5JQ0ptc1JMQzBOQ2pNQXhoZ2NqQi9VNUNMN0hEVWYwRWJOOGpj?=
 =?utf-8?B?c0UxbW5Bd1BYTjBiREtDcENPVldLZkM0bkdNQ1liV2Y4TCtCUFk5NDRJeGt3?=
 =?utf-8?B?TXpZc2dSYjRORGlIRzdWMUJZTkZEUVhuUGIybHR5K3E2OXE1em9iRy9sK1FQ?=
 =?utf-8?B?OGd0UlFpdGJYS3pMY1I2Vk1weGVMYkozQVFJcDNBNXVER1g0NzhyZ1ZmbE5G?=
 =?utf-8?B?T3dQeVRVSnQ3UTBiNGt2aE5MQThkMjhJbEF4b2p1eEZFVGtaM3QxRmpzS09v?=
 =?utf-8?B?aGhRRmxyZmkvd3Z0dHlSQVYzaDh6QXNtVkdDMEtyZlA0RnNzeFZYWWhMakxB?=
 =?utf-8?B?aHlhMVdObm1BRWVBVkZCbDZFazNpUWZHU2E1bTBrc1lHRVYxZlY2aS82MllN?=
 =?utf-8?B?ZU1nRTBBLzJjMWlRVk5mQmdvdUgvalFWTk9mZlJZTlVwaEFWUVI0NXBWOWYw?=
 =?utf-8?B?WXMxby9RZEFnNmltODlZZ3g0YUx2OXA3MHNrMm16b2pXS0VXQXJYYXRrNXY0?=
 =?utf-8?B?RDdtNjJ0ZGF5R1VkdDJZQ2htdEVWK1RxZHZvNFZPRzRiTWR2ZEJIbWwvb3Jt?=
 =?utf-8?B?djMybHJnQnViTkVST0NRLzlhSGNaQ2ZPWllmY0t2MmJVTi9FOTYzcXhSejNs?=
 =?utf-8?B?emt0TEhtK2gvQU1ablFZQVdMcm83bmdLaFZ5empIZDJNS1dXb1RVYjBwTHFX?=
 =?utf-8?B?YWg2emhQRDdvbHlacE5ibDcwVDZkY0lhWDJjenl1amxOSUk4cDdkaUVRK1R5?=
 =?utf-8?B?SC8zdHlPVTFlTHBwcERVMmxYaWxYS3ZwUnNtckVvUDJrTEZhVnpjNWxLVXVI?=
 =?utf-8?B?cXcvSjc1anlMdm8zR1UzeXBseno1RmgzTnRyK3NKY0o0Tk0yRjV5WU5zZTdV?=
 =?utf-8?B?bVd5ZVFaVTVvT2JWOS9WWlhyeGoyOGt3VGVwVm5wT2V0SHlIVUdoa01FNER1?=
 =?utf-8?B?Z1BPTW5pL21CRk5qak1DTktNYUhTVDJRQjdVVWJmYUEyK0ViVEwyVlFUcXJQ?=
 =?utf-8?B?YUZlUVJPc2x2NHovZ0lzUU10YXI0TG0wKzRuWWFBcUZBa0tTRWJpWDdFV0Fj?=
 =?utf-8?B?NVcvRTMrall5bm9CNnNlU2lJMGE2RkNkb2pXTVVWalpHRi9VMklUdnF6V0NT?=
 =?utf-8?B?TWtORWdFRkw4Mk9sUXJONjJuV2h6ZmdmeVVJMXYzdmlFVWxDdVBLWlNwa1JU?=
 =?utf-8?B?TGtBZzhtQVlNYVhjNFExek5VaTE2d0VWeHJVZDlLSFF0T2ZrNzgyVGF2VnVp?=
 =?utf-8?B?S2tUNC9NQzhCZ1FzNjEwS3h2N0NFRUlkVm82WHU5eXpGNGMrZ1BwOHU4ZDJi?=
 =?utf-8?B?RmVwVThFa0toS1dRZURCVk1FemVyUnV6Z0pRUGxnV3hzbUlldnh0N0VZaE51?=
 =?utf-8?B?L1B4QXJHWFlPdmViSlFJaEk1TjBWbElYY1BnNGI5UUU0VGFFMm0raEdRSGxo?=
 =?utf-8?B?Vy9IcDJUYnpJREJZTytZVzJaUFZYekVnYkx5WlREQjMyRzdYd0FLdjh0aTFI?=
 =?utf-8?B?SVI3OU9GUUxTYXQ4Ly81d2xZb2ZaN0VoTzBRYjJSU0NCWjZua0RUYVFGYkdr?=
 =?utf-8?B?MTVIcklReEVlNkMrdFFQYUpwVkEvYjFSVDFWR3RndnpIcFNqd08xMHkyazY2?=
 =?utf-8?B?dm54b0JBOVhBV1RsZFhPd2l2aDBBTWhSblMzWHlDOFVvMS9MbmJORTVDaWpu?=
 =?utf-8?B?ZjBva2l4ZkVzbnFEYzdOWTFXQ2N0MUdxeTRwdXc4U3RxWmJYcEd3UjIrRVNj?=
 =?utf-8?B?cmNET3RIeU1ib3o5RXh2TkFJbmlzcDUxOW9NbU5HZ29kaXBIak5mSFRCY0w4?=
 =?utf-8?B?MXU2SUtCcWg0Vm8wOUJMSkJYOGJvcERzbGtkbEFsaFVhZi9SNnFaWUpmSXdC?=
 =?utf-8?B?b0RtQ0ZmMFNzV2hGb2x3U3M4U2NtaklkY0ZHNmJUdTl3bWVQQ0lyaDIvUFhY?=
 =?utf-8?B?a1lHdENFUzQ4c3BLUkZoeHIvQzFieHZXVTVkbDVZWWNOZDNnc3pDUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69e01cf-0b73-4f21-1191-08de6317fa19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:32:56.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg8Oigb2HUC8O76fEg07QMJWMgh6dxXkFuCVbpEDa/FqRkZlu2AEOyzL+t9wwDOWaXmjXPuMnVOritJrIQ2d8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2904

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


