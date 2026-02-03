Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B556E95360
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14869.1770119290260582102
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:48:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=quZvL386;
 spf=pass (domain: oss.nxp.com, ip: 52.101.84.12, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnLTQtiR8bWH0LE7Ptp24QsJdd9okwlOrLehKkVY9ol/c1viIb4gwp3O/EHQA7OX6HPsuLlO3+2k/ry5DOHCvfpoghU7QakF3MNS0IPn0Ugmv7TobyuL3cHhwnBtuyOpZtGQOWWpVJZOu1eOqNdovODMMnhYgA7lEIJUN5ki+Os/syBKdqUT/p4YB3A8wHXBqYH5BwJxQJPhe9v5pk6tZkO2K/QSIiBbk/BpgNDGrSQgZli372rUs/e5/baxBi5qmtqZ5N/MWG6Y8fZGqzlPgRcM72EtKTnz1cugX9u9Gjt6OEKp2V81GPJ4oq6O0fgHBWa66tE6cF0T3kGzHDW5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/+98cRh/Z/gTBVI70bAPSNgYTGHwqWJGS4SfAwFycs=;
 b=SZTuSjI/rGxhJkPpBSIed4tippwGYwpvzfvXgD66YEOWOFm4HmAWyceNwWvVCk86/MCeyaA1x3P64HTTMcHkcJ98zsU9aJgUhN0dO51QCFWAJYm028OIDTtj+e8XBiX7cmMrLFMAXr7Y3HkF6sUm+YH5X9DWnJw4DXWz33p0sU4RcEljom1LnIs77lJHq+AESl0oJ/8TdOuLwe8t8cfJPe6YBOvMzp9+PpugWwAqZKw1S5Aerd0SlWUx7OpfhjJIXPI9/+JxJUPHeMlRFdRvADcSMjnjdxK3Tl1cd0Zt02ufBvabMAysHIP6hqbvBtHOX6xhVjrMQVE/c2sRHnjAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/+98cRh/Z/gTBVI70bAPSNgYTGHwqWJGS4SfAwFycs=;
 b=quZvL386itjtK6BxRfPpxDgBshk2JuRQtxPWh7veuDONsK6MVsxuqYS+iWEoM5e+fP+ieD7Q304ixWd5/fa3xJSsWKcrI1IXxpnzpDkCfpknNdhvmMmSe8QA/2t8Ssen9hl+pJUDij3pkOq2pENi/ll9hGMOXYIv0Gwzft7Gbqx5wJltTD+nKY762JFax3ff1el0YUwS1FFXpVldJEquh/hAUFyY9u/C8yXemfkpkf7aaavPn0lWAI/FLm1RQ8/0rDjwGty/aOwflSjNTCA0dio6rstpa5F5LTEGuMQN1lrXg1P2tuxgMYzReYIJd4ybh9NEhVYDrtEEM17U8TvAbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10526.eurprd04.prod.outlook.com (2603:10a6:102:441::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:48:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:48:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Alexey Brodkin <alexey.brodkin@synopsys.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Tom Rini <trini@konsulko.com>,
	Stefan Bosch <stefan_b@posteo.net>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Vasut <marex@denx.de>,
	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
	Tien Fong Chee <tien.fong.chee@altera.com>,
	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Weijie Gao <weijie.gao@mediatek.com>,
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
	Aaron Williams <awilliams@marvell.com>,
	Thomas Chou <thomas@wytron.com.tw>,
	Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>,
	Yao Zi <me@ziyao.cc>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
	"Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Randolph <randolph@andestech.com>,
	David Feng <fenghua@phytium.com.cn>,
	Linus Walleij <linusw@kernel.org>,
	Peter Hoyes <Peter.Hoyes@arm.com>,
	Liviu Dudau <liviu.dudau@foss.arm.com>,
	Adam Ford <aford173@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Gilles Talis <gilles.talis@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
	Mario Six <mario.six@gdsys.cc>,
	Marco Franchi <marcofrk@gmail.com>,
	Alifer Moraes <alifer.wsdm@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Thiery <heiko.thiery@gmail.com>,
	"Lukas F. Hartmann" <lukas@mntre.com>,
	Patrick Wildt <patrick@blueri.se>,
	Martyn Welch <martyn.welch@collabora.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Peng Fan <peng.fan@nxp.com>,
	Teresa Remmet <t.remmet@phytec.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Angus Ainslie <angus@akkea.ca>,
	kernel@puri.sm (reviewer:PURISM LIBREM5 PHONE),
	Stephan Gerhold <stephan@gerhold.net>,
	Sam Day <me@samcday.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
	Ilko Iliev <iliev@ronetix.at>,
	Kamil Lulko <kamil.lulko@gmail.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Dillon Min <dillon.minfei@gmail.com>,
	Bryan Brattlof <bb@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lukasz Majewski <lukma@denx.de>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	Heiko Schocher <hs@nabladev.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Ramon Fried <rfried.dev@gmail.com>,
	Jerome Forissier <jerome@forissier.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Stefan Roese <stefan.roese@mailbox.org>,
	Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
	Greg Malysa <malysagreg@gmail.com>,
	Ian Roberts <ian.roberts@timesys.com>,
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
	Utsav Agarwal <utsav.agarwal@analog.com>,
	Arturs Artamonovs <arturs.artamonovs@analog.com>,
	Anastasiia Lukianenko <vicooodin@gmail.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Thierry Reding <treding@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Anatolij Gustschin <ag.dev.uboot@gmail.com>,
	Brian Sune <briansune@gmail.com>,
	Tingting Meng <tingting.meng@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ye Li <ye.li@nxp.com>,
	Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
	Jeremy Compostella <jeremy.compostella@intel.com>,
	Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
	Debbie Horsfall <debbie.horsfall@arm.com>,
	Harrison Mutai <harrison.mutai@arm.com>,
	Jonathan Humphreys <j-humphreys@ti.com>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Wadim Egorov <w.egorov@phytec.de>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Anshul Dalal <anshuld@ti.com>,
	Alice Guo <alice.guo@nxp.com>,
	Francesco Valla <francesco@valla.it>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Benjamin Hahn <B.Hahn@phytec.de>,
	Yannic Moog <y.moog@phytec.de>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	"Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
	Vishal Mahaveer <vishalm@ti.com>,
	Keerthy <j-keerthy@ti.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Vitor Soares <vitor.soares@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Maxim Moskalets <maximmosk4@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Mark Kettenis <kettenis@openbsd.org>,
	Adriano Cordova <adrianox@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>,
	Anton Moryakov <ant.v.moryakov@gmail.com>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Joseph Chen <chenjh@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	David Zang <davidzangcs@gmail.com>,
	Viorel Suman <viorel.suman@nxp.com>,
	Sky Huang <SkyLake.Huang@mediatek.com>,
	"Lucien.Jheng" <lucienzx159@gmail.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Alexander Feilke <alexander.feilke@ew.tq-group.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Christoph Fritz <chf.fritz@googlemail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>,
	E Shattow <e@freeshell.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Paul Geurts <paul.geurts@prodrive-technologies.com>,
	=?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
	Eoin Dickson <eoin.dickson@microchip.com>,
	Brian Ruley <brian.ruley@gehealthcare.com>,
	Swamil Jain <s-jain1@ti.com>,
	Zixun LI <admin@hifiphile.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
	Sughosh Ganu <sughosh.ganu@linaro.org>,
	=?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
	Alexander Graf <agraf@csgraf.de>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>,
	Leonard Anderweit <l.anderweit@phytec.de>,
	Dinesh Maniyam <dinesh.maniyam@altera.com>,
	uboot-snps-arc@synopsys.com (open list:ARC),
	u-boot-amlogic@groups.io (open list:ARM AMLOGIC SOC SUPPORT),
	u-boot@dh-electronics.com (open list:DH electronics DHCOM i.MX8M Plus and matching c...),
	upstream@lists.phytec.de (open list:Libra-i.MX 8M Plus),
	u-boot-qcom@groups.io (open list:ARM SNAPDRAGON),
	uboot-stm32@st-md-mailman.stormreply.com (moderated list:ARM STM STM32MP),
	adsp-linux@analog.com (open list:ARM SC5XX)
CC: kernel@puri.sm,
	uboot-snps-arc@synopsys.com,
	u-boot-amlogic@groups.io,
	u-boot@dh-electronics.com,
	upstream@lists.phytec.de,
	u-boot-qcom@groups.io,
	uboot-stm32@st-md-mailman.stormreply.com,
	adsp-linux@analog.com
Subject: [PATCH RESEND 14/14] treewide: Clean up DECLARE_GLOBAL_DATA_PTR usage
Date: Tue,  3 Feb 2026 19:47:01 +0800
Message-ID: <20260203114702.1867224-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260203114702.1867224-1-peng.fan@oss.nxp.com>
References: <20260203114702.1867224-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: MA5P287CA0259.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10526:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fe8d39-5be3-4a95-ebf7-08de631a1576
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014|13003099007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MDsmbmXfqTTd3RcfubcZI01KiYl/CEOxRW49s/ahPRgNEZCAd9XORG3D5zLG?=
 =?us-ascii?Q?BBN7OBPsYG/qM7DPlIWKh4pcCijazgdNVmMZxA2zWc9pKi8e2wOf9PymYoCx?=
 =?us-ascii?Q?74HqYBxBhdUOaCDrXAzOuHXoCqJ3MdhRo5QdWbsgOwkb49tZBYqI5APGcQ0K?=
 =?us-ascii?Q?cEK/zzTw+EF/XZsgRuYN9v8rLroRauK2I2W7aGCuChLCZQIfAAqoFJxkLu+Y?=
 =?us-ascii?Q?TYxUnhNxDGOiYZQGFgx/Rb4sab1p/4VGpR7MJBNjq8F+nVuj2d3E1gq34vg7?=
 =?us-ascii?Q?W5etSTAMbAwdtacK01bSG6fFWZxgPF8H+THvmBtjZMuCGosiqwibK3/3+ZUd?=
 =?us-ascii?Q?EvyxhCXUcSR4TVP39ocGnpIjopStct8LM+VkY+G54FgQWpi0Ku3GnT5E6ueV?=
 =?us-ascii?Q?Oo6p/GkCVNxS46FYunLGL8A27Np4khNmxlhHwP0BD/WBfU6mcwc36e4NrR3y?=
 =?us-ascii?Q?4jO2K30PUCUykDWNKcaZzSQoq4HOcVf3HW4QpiOX5b9WmBJ0Pqm/d5nAOYhL?=
 =?us-ascii?Q?0l8iIh9xwE91bHCNwyVyK4GzA/RBzATYezFBQAW3Q/tDcEqRtR/QxOPDoKMh?=
 =?us-ascii?Q?0Qjz6IEfVOILr9gitrMMYfLwJTsjNz3llzdmD3ismy52HXbTNY2q/nhuvoWo?=
 =?us-ascii?Q?rLDWw3mw5bEJlyACUxuoSSQvLq1GiiKJIBc1k7FQU+NDK4VYUS28pjOJQBLj?=
 =?us-ascii?Q?YF1YcKmI6vQa5zv3pawNh6uuJ/WTA+B3+qZIm9GBOTC3tGxBLhRB5TMTB3l6?=
 =?us-ascii?Q?v7vZ4s3J9PdWahoYclgeIEGLzISVjwYOJcKtox4ScoUuKK4o3BJBAb9Ir46x?=
 =?us-ascii?Q?10Lk3/T9q0cB+CB9lLzrPsaITkT4V/35noBNdRaRYf7XOdebK+WDu5jQynRW?=
 =?us-ascii?Q?TGMZ9ZdsnUOs/ops31tFdtAQaySidIhi3OuD0pCFOG1dtn/M3BSFUfE3fITW?=
 =?us-ascii?Q?JbM7+V8nkz23Ip/PcCAkHSn3olL4SaRHvPQvcPtx1by1X9IoWmhNyRzlBP/G?=
 =?us-ascii?Q?Z5tvTEhJffXDqfzLPSDcbj9iSQ2OJDA+wA/YOnaqu//YoM7HAZvmTsoZKClL?=
 =?us-ascii?Q?g266BqDBcJlJTUX8zj95PO0iEMHhmAPML+noJlwRRlYuRj4bAg8wyKyZLi3g?=
 =?us-ascii?Q?LBcZ8HhcozK0hJvkU/AZY5Iv+QeeCtomeglsfM/p+4gypZoYfyNgfR6b38zw?=
 =?us-ascii?Q?b9Sm3O91u71a6qTm3I2pkjFet8qZoR7mpP4qKrPvqm5UHLI+lo9tlk9IC9na?=
 =?us-ascii?Q?IQg2kVHEgw0aMldndDKe938CG24iHwWCP6DhGkDmcMXNp9eeZxE6GW1JgvcG?=
 =?us-ascii?Q?lKyhBxKSvb1Ohyq7iWw/gDr1xriT1p/M3qddEliff+nB3sHg+UDAfOCNC/FA?=
 =?us-ascii?Q?n5Dtj5yOwbfDXTr0D1Fa5az/vs8bKPlxQcxRi1VVoZn0Do73N3btrJq7oRWh?=
 =?us-ascii?Q?96nEvdC1P96Emr7eJrjUiOhC3yJSquoz3E0SKkIA4mriGG/RIq4w8rlxK7e3?=
 =?us-ascii?Q?J6wiVLp/DqFSvLlgtkaU++qAdXC+mngYeuOcP88NylhunRykcndxG5BLHCHd?=
 =?us-ascii?Q?JcGi7Gck5QTypF9AtLU6wawmIIaEwkKLQK/rYJsFLwhdzSOxYtWzA/AMl+XQ?=
 =?us-ascii?Q?nA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUQcyRvl98kDp49G+Ol4WI5lGbQmOreshB1W4mPOkvtz6bM6xFtFUVSV2L1Q?=
 =?us-ascii?Q?MJBMxAvSQZnJAdEUgdmFAXBzsm8/yj33roFe28Q1VNlC88unyGfuKxSOBuOz?=
 =?us-ascii?Q?6/N16SEFQ+rc0MWUdkPoSLyVCn5rkxtYiw4pQwu+AmIVJ/WrNrrou+bn2RL6?=
 =?us-ascii?Q?BUn1HMp2CgScG/My/8PKg3+u05XwgbFXfX+MYvACgXUGla6HNNXk6ZGbWV3k?=
 =?us-ascii?Q?yy4EhXGD/LwBK/tagpid23xxyC+pTKH41/4AcHG2EM8ljtQ3nlAzfmS137Zn?=
 =?us-ascii?Q?/36cNgTidVoERNCRZjsuQJSZx43ZNRgUeF69ZPIqNFPvAyXPW3KSV4Uh48vY?=
 =?us-ascii?Q?mT5VAd0adprZogv13ovQxYoiGv/3hSi4ZNAK+B6mcdbwIlzHPU5hZtwM1tBE?=
 =?us-ascii?Q?5T2pJWpoF4qAwXhEwMa0xbneeeonHDXEhBBnD10ZUeDIVw2Ivdael/MsgZ6H?=
 =?us-ascii?Q?n69waGOa0unuiByYm6P93dYNQACKjD6RXDoL/ZmvjF6gu5RW2VIJhuCNN6B9?=
 =?us-ascii?Q?HXZrLk2oi5P3rV55YmuAqP/omOQgXwnPbwewWkmu4Hb3lW436JU5hszSF+Q7?=
 =?us-ascii?Q?Y0ZBpJLM1n/mvI0AZm/jvbY1g2Ngvg14IiQzJHoEtLiVF0VuYdDtL4SnoBVP?=
 =?us-ascii?Q?Ngg+N4qKzcu+H2cEg1o3FmR8rI5XC5UlmEXZdlJtWWJKy3K6Ffp9350H+U2j?=
 =?us-ascii?Q?ADBVnrP0+YQM98BqM8zqiO7BSqZDi/FsONcCqnpqaHed1guGvHEpAA4mrHUm?=
 =?us-ascii?Q?kiqxpEUg6uI0AdbsjKW/Flr6EnfbWJlv7rGLlCBmjKVXTNwlnIj/BDQRnpBo?=
 =?us-ascii?Q?Mj9vAmL9sfu8ZhAVif2P9iNB9ZfuAdRLJBhbrc0Q1HvGtFQxM4ZnG8Q5F4fl?=
 =?us-ascii?Q?vFM3y+f7zpu26cXZwo2eNIQqN8NpZea8swNAm2cWp6LlmzxpMXWOHFXa9XL0?=
 =?us-ascii?Q?ibz5EGPwtak344OrBbkViA94+mCc7om60pnxYKS+r6FQYmt/8b5zfVCTL4sm?=
 =?us-ascii?Q?x2yYK36nWNn7eoz2pGlvGLgga0P1m7WIsENx+vpL2Bs42yu6dlzxIp6iArvc?=
 =?us-ascii?Q?VtbvmVaMxm7VhAbHB32BSoFDfufVTm/XPRJtE70dC0vFToBQPkKBN2jFkBqf?=
 =?us-ascii?Q?wTkr/e3EM4OOfRV07YxQSl7hwOju2yLPsx3gW2R/ohLhNe/51wR890sLjMuk?=
 =?us-ascii?Q?xAeHYL3fTpklRuNWhA8nM92ydbkmfiMpdYbqNROUDJLl/5AQZoyR22sPIbV3?=
 =?us-ascii?Q?TWrTMTibgWGHNyDvAFmRurSWyOltyimf9vfmtDAcQ1ODHkY2pt75v4NDiRs2?=
 =?us-ascii?Q?MP8zCWVLG2wpI8t5ijAWSkUuwhu80YCB7LUBfAb+xU0LLZxCzIqHApG+WRl6?=
 =?us-ascii?Q?ENjeS9MJhvhpYzIlXSU1sAQn/ouhhR+2rOe8gqcoiT3EypCdWw3RC7ZBR5dI?=
 =?us-ascii?Q?+vPXRQGxzK2j0QTqZoZN2TMZLTWMnwLYbyOAOxHVhSiZ0BFbdGeeWbFV1yKt?=
 =?us-ascii?Q?EdDqL5MtdqYYPEVTWa+VH9ktBMHpHzDlQpfwXBZ/2Ozoe3997Yv2QwaCvCmC?=
 =?us-ascii?Q?vDFoJpN0EnVJ0J/N/GOFDgYMvAT3t8nQtjBDaRGEeH91SrVlK8YUAR7CFaEe?=
 =?us-ascii?Q?NtCMisKTijkJJoa2VkdFVpuz6mkoB7qOoGbHe/QXkr92j5kBxKWmvS1Vl6fm?=
 =?us-ascii?Q?SUVktjIVbubO50ikn4wzutoc8v0qddp2LAZXpJBuvGL/OSCP0mshEEr2uTPr?=
 =?us-ascii?Q?u+amubjmGA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fe8d39-5be3-4a95-ebf7-08de631a1576
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:48:02.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqSS2e6khleKay1S3+3RJN6gd/j/2XPSj5DW6o5a7YsJDnXBbFK3rvu2yk15m6Bq4z6hUZgQLEq621BM5kKArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10526
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2917

From: Peng Fan <peng.fan@nxp.com>

Remove DECLARE_GLOBAL_DATA_PTR from files where gd is not used, and
drop the unnecessary inclusion of asm/global_data.h.

Headers should be included directly by the files that need them,
rather than indirectly via global_data.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arc/lib/bootm.c                                        | 3 ---
 arch/arm/cpu/armv7/s5p4418/cpu.c                            | 3 ---
 arch/arm/mach-aspeed/ast2600/spl.c                          | 3 ---
 arch/arm/mach-imx/imx8/clock.c                              | 3 ---
 arch/arm/mach-imx/imx8/fdt.c                                | 3 ---
 arch/arm/mach-imx/imx8/iomux.c                              | 3 ---
 arch/arm/mach-imx/imx8m/clock_imx8mm.c                      | 3 ---
 arch/arm/mach-imx/imx8ulp/cgc.c                             | 3 ---
 arch/arm/mach-imx/imx8ulp/clock.c                           | 3 ---
 arch/arm/mach-imx/imx9/clock.c                              | 3 ---
 arch/arm/mach-imx/imx9/clock_root.c                         | 3 ---
 arch/arm/mach-imx/misc.c                                    | 3 ---
 arch/arm/mach-imx/spl_imx_romapi.c                          | 3 ---
 arch/arm/mach-meson/board-axg.c                             | 3 ---
 arch/arm/mach-meson/board-g12a.c                            | 3 ---
 arch/arm/mach-meson/board-gx.c                              | 3 ---
 arch/arm/mach-socfpga/clock_manager_agilex.c                | 3 ---
 arch/arm/mach-socfpga/clock_manager_agilex5.c               | 3 ---
 arch/arm/mach-socfpga/clock_manager_n5x.c                   | 3 ---
 arch/arm/mach-socfpga/clock_manager_s10.c                   | 3 ---
 arch/arm/mach-socfpga/mailbox_s10.c                         | 3 ---
 arch/arm/mach-socfpga/misc_gen5.c                           | 3 ---
 arch/arm/mach-socfpga/misc_soc64.c                          | 3 ---
 arch/arm/mach-socfpga/mmu-arm64_s10.c                       | 3 ---
 arch/arm/mach-socfpga/reset_manager_s10.c                   | 3 ---
 arch/arm/mach-socfpga/spl_agilex.c                          | 3 ---
 arch/arm/mach-socfpga/spl_agilex5.c                         | 3 ---
 arch/arm/mach-socfpga/spl_agilex7m.c                        | 3 ---
 arch/arm/mach-socfpga/spl_gen5.c                            | 3 ---
 arch/arm/mach-socfpga/spl_n5x.c                             | 3 ---
 arch/arm/mach-socfpga/spl_s10.c                             | 3 ---
 arch/arm/mach-socfpga/system_manager_soc64.c                | 3 ---
 arch/microblaze/lib/bootm.c                                 | 3 ---
 arch/mips/mach-ath79/qca956x/ddr.c                          | 3 ---
 arch/mips/mach-mscc/cpu.c                                   | 3 ---
 arch/mips/mach-mtmips/ddr_cal.c                             | 3 ---
 arch/mips/mach-octeon/cvmx-pko.c                            | 2 --
 arch/nios2/lib/bootm.c                                      | 3 ---
 arch/riscv/cpu/andes/spl.c                                  | 3 ---
 arch/riscv/cpu/cv1800b/dram.c                               | 3 ---
 arch/riscv/cpu/generic/dram.c                               | 3 ---
 arch/riscv/cpu/k230/dram.c                                  | 3 ---
 arch/riscv/cpu/th1520/spl.c                                 | 2 --
 arch/sh/lib/bootm.c                                         | 3 ---
 arch/x86/cpu/ivybridge/model_206ax.c                        | 3 ---
 arch/x86/lib/init_helpers.c                                 | 3 ---
 arch/x86/lib/zimage.c                                       | 3 ---
 arch/xtensa/lib/time.c                                      | 3 ---
 board/BuR/brsmarc1/board.c                                  | 3 ---
 board/BuR/common/common.c                                   | 3 ---
 board/Marvell/octeontx/smc.c                                | 3 ---
 board/Marvell/octeontx2/smc.c                               | 3 ---
 board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c         | 2 --
 board/advantech/imx8mp_rsb3720a1/spl.c                      | 2 --
 board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c       | 2 --
 board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c       | 3 ---
 board/andestech/voyager/voyager.c                           | 3 ---
 board/armltd/vexpress64/vexpress64.c                        | 3 ---
 board/beacon/imx8mm/spl.c                                   | 3 ---
 board/beacon/imx8mn/spl.c                                   | 3 ---
 board/beacon/imx8mp/spl.c                                   | 3 ---
 board/beagle/beagleboneai64/beagleboneai64.c                | 2 --
 board/beagle/beagleplay/beagleplay.c                        | 2 --
 board/broadcom/bcmns/ns.c                                   | 3 ---
 board/cloos/imx8mm_phg/imx8mm_phg.c                         | 3 ---
 board/cloos/imx8mm_phg/spl.c                                | 3 ---
 board/compulab/imx8mm-cl-iot-gate/spl.c                     | 2 --
 board/coreboot/coreboot/coreboot.c                          | 3 ---
 board/cssi/cmpc885/cmpc885.c                                | 2 --
 board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c | 2 --
 board/data_modul/imx8mm_edm_sbc/spl.c                       | 2 --
 board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c | 2 --
 board/data_modul/imx8mp_edm_sbc/spl.c                       | 2 --
 board/dhelectronics/dh_imx8mp/common.c                      | 2 --
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c           | 2 --
 board/dhelectronics/dh_imx8mp/spl.c                         | 2 --
 board/emcraft/imx8mp_navqp/spl.c                            | 3 ---
 board/emulation/qemu-riscv/qemu-riscv.c                     | 2 --
 board/engicam/imx8mm/icore_mx8mm.c                          | 2 --
 board/engicam/imx8mm/spl.c                                  | 2 --
 board/engicam/imx8mp/icore_mx8mp.c                          | 3 ---
 board/engicam/imx8mp/spl.c                                  | 3 ---
 board/gdsys/mpc8308/gazerbeam.c                             | 3 ---
 board/google/imx8mq_phanbell/imx8mq_phanbell.c              | 3 ---
 board/highbank/highbank.c                                   | 3 ---
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c                     | 3 ---
 board/kontron/osm-s-mx93/osm-s-mx93.c                       | 3 ---
 board/kontron/pitx_imx8m/pitx_imx8m.c                       | 2 --
 board/mntre/imx8mq_reform2/imx8mq_reform2.c                 | 3 ---
 board/msc/sm2s_imx8mp/sm2s_imx8mp.c                         | 2 --
 board/msc/sm2s_imx8mp/spl.c                                 | 3 ---
 board/nxp/imx8mm_evk/imx8mm_evk.c                           | 3 ---
 board/nxp/imx8mm_evk/spl.c                                  | 3 ---
 board/nxp/imx8mn_evk/spl.c                                  | 3 ---
 board/nxp/imx8mp_evk/spl.c                                  | 3 ---
 board/nxp/imx8qm_mek/imx8qm_mek.c                           | 3 ---
 board/nxp/imx8qxp_mek/imx8qxp_mek.c                         | 3 ---
 board/nxp/imx8ulp_evk/imx8ulp_evk.c                         | 2 --
 board/nxp/imx8ulp_evk/spl.c                                 | 2 --
 board/nxp/imx93_frdm/imx93_frdm.c                           | 3 ---
 board/phytec/imx8mp-libra-fpsc/spl.c                        | 3 ---
 board/phytec/phycore_imx8mm/phycore-imx8mm.c                | 3 ---
 board/phytec/phycore_imx8mm/spl.c                           | 3 ---
 board/phytec/phycore_imx8mp/phycore-imx8mp.c                | 3 ---
 board/phytec/phycore_imx8mp/spl.c                           | 3 ---
 board/phytec/phycore_imx93/phycore-imx93.c                  | 3 ---
 board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c   | 3 ---
 board/polyhex/imx8mp_debix_model_a/spl.c                    | 3 ---
 board/purism/librem5/librem5.c                              | 2 --
 board/purism/librem5/spl.c                                  | 2 --
 board/qualcomm/dragonboard410c/dragonboard410c.c            | 3 ---
 board/qualcomm/dragonboard820c/dragonboard820c.c            | 3 ---
 board/renesas/common/gen3-common.c                          | 3 ---
 board/renesas/common/gen4-common.c                          | 3 ---
 board/renesas/common/gen5-common.c                          | 3 ---
 board/ronetix/imx8mq-cm/imx8mq_cm.c                         | 2 --
 board/samsung/common/exynos5-dt.c                           | 3 ---
 board/samsung/common/misc.c                                 | 3 ---
 board/st/stm32f429-discovery/stm32f429-discovery.c          | 3 ---
 board/st/stm32f429-evaluation/stm32f429-evaluation.c        | 3 ---
 board/st/stm32f469-discovery/stm32f469-discovery.c          | 3 ---
 board/st/stm32f746-disco/stm32f746-disco.c                  | 3 ---
 board/st/stm32h743-disco/stm32h743-disco.c                  | 3 ---
 board/st/stm32h743-eval/stm32h743-eval.c                    | 3 ---
 board/st/stm32h747-disco/stm32h747-disco.c                  | 3 ---
 board/st/stm32h750-art-pi/stm32h750-art-pi.c                | 3 ---
 board/technexion/pico-imx8mq/pico-imx8mq.c                  | 3 ---
 board/ti/am62x/evm.c                                        | 2 --
 board/ti/am64x/evm.c                                        | 2 --
 board/ti/j784s4/evm.c                                       | 2 --
 board/toradex/apalis-imx8/apalis-imx8.c                     | 3 ---
 board/toradex/apalis_t30/apalis_t30.c                       | 3 ---
 board/toradex/colibri-imx8x/colibri-imx8x.c                 | 3 ---
 board/toradex/colibri_t20/colibri_t20.c                     | 3 ---
 board/toradex/common/tdx-cfg-block.c                        | 3 ---
 board/toradex/smarc-imx8mp/smarc-imx8mp.c                   | 3 ---
 board/toradex/smarc-imx8mp/spl.c                            | 3 ---
 board/toradex/verdin-imx8mm/spl.c                           | 3 ---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c                 | 3 ---
 board/toradex/verdin-imx8mp/spl.c                           | 3 ---
 board/toradex/verdin-imx8mp/verdin-imx8mp.c                 | 3 ---
 board/xilinx/zynq/bootimg.c                                 | 3 ---
 boot/bootmeth-uclass.c                                      | 2 --
 boot/fdt_simplefb.c                                         | 3 ---
 boot/image-sig.c                                            | 2 --
 boot/image.c                                                | 3 ---
 cmd/bloblist.c                                              | 3 ---
 cmd/bootefi.c                                               | 3 ---
 cmd/bootm.c                                                 | 3 ---
 cmd/date.c                                                  | 3 ---
 cmd/mem.c                                                   | 3 ---
 cmd/sound.c                                                 | 3 ---
 cmd/spl.c                                                   | 3 ---
 common/cli_hush.c                                           | 3 ---
 common/stdio.c                                              | 3 ---
 drivers/block/sandbox.c                                     | 3 ---
 drivers/bootcount/pmic_pfuze100.c                           | 2 --
 drivers/cache/sandbox_cache.c                               | 3 ---
 drivers/clk/altera/clk-agilex.c                             | 3 ---
 drivers/clk/altera/clk-agilex5.c                            | 3 ---
 drivers/clk/altera/clk-mem-n5x.c                            | 3 ---
 drivers/clk/altera/clk-n5x.c                                | 3 ---
 drivers/clk/rockchip/clk_px30.c                             | 3 ---
 drivers/clk/rockchip/clk_rk3308.c                           | 3 ---
 drivers/clk/rockchip/clk_rk3528.c                           | 2 --
 drivers/clk/rockchip/clk_rk3568.c                           | 2 --
 drivers/clk/rockchip/clk_rk3576.c                           | 2 --
 drivers/clk/rockchip/clk_rk3588.c                           | 2 --
 drivers/clk/rockchip/clk_rv1108.c                           | 3 ---
 drivers/clk/rockchip/clk_rv1126.c                           | 2 --
 drivers/cpu/bcm283x_cpu.c                                   | 3 ---
 drivers/cpu/cpu-uclass.c                                    | 2 --
 drivers/cpu/imx8_cpu.c                                      | 3 ---
 drivers/cpu/mtk_cpu.c                                       | 3 ---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c                   | 3 ---
 drivers/firmware/arm-ffa/arm-ffa.c                          | 3 ---
 drivers/firmware/arm-ffa/ffa-emul-uclass.c                  | 3 ---
 drivers/firmware/arm-ffa/sandbox_ffa.c                      | 3 ---
 drivers/gpio/gpio-uclass.c                                  | 3 ---
 drivers/gpio/nx_gpio.c                                      | 3 ---
 drivers/i2c/mxc_i2c.c                                       | 3 ---
 drivers/i2c/nx_i2c.c                                        | 3 ---
 drivers/i2c/ocores_i2c.c                                    | 3 ---
 drivers/i2c/soft_i2c.c                                      | 3 ---
 drivers/i2c/synquacer_i2c.c                                 | 2 --
 drivers/mailbox/imx-mailbox.c                               | 2 --
 drivers/misc/atsha204a-i2c.c                                | 3 ---
 drivers/misc/fs_loader.c                                    | 3 ---
 drivers/misc/imx8/fuse.c                                    | 3 ---
 drivers/mmc/ca_dw_mmc.c                                     | 3 ---
 drivers/mmc/f_sdh30.c                                       | 2 --
 drivers/mmc/jz_mmc.c                                        | 3 ---
 drivers/mmc/msm_sdhci.c                                     | 3 ---
 drivers/mmc/mv_sdhci.c                                      | 3 ---
 drivers/mtd/nand/raw/pxa3xx_nand.c                          | 3 ---
 drivers/mtd/nand/raw/tegra_nand.c                           | 3 ---
 drivers/mtd/nvmxip/nvmxip_qspi.c                            | 3 ---
 drivers/mtd/spi/sf-uclass.c                                 | 3 ---
 drivers/net/dwmac_s700.c                                    | 3 ---
 drivers/net/fec_mxc.c                                       | 3 ---
 drivers/net/gmac_rockchip.c                                 | 2 --
 drivers/net/mvneta.c                                        | 3 ---
 drivers/net/octeontx/smi.c                                  | 3 ---
 drivers/net/phy/fixed.c                                     | 3 ---
 drivers/net/phy/phy.c                                       | 3 ---
 drivers/net/phy/xilinx_gmii2rgmii.c                         | 3 ---
 drivers/net/sandbox-raw.c                                   | 3 ---
 drivers/net/sandbox.c                                       | 3 ---
 drivers/net/ti/keystone_net.c                               | 3 ---
 drivers/net/xilinx_axi_emac.c                               | 3 ---
 drivers/pci/pci_octeontx.c                                  | 3 ---
 drivers/pci/pcie_dw_meson.c                                 | 3 ---
 drivers/pci/pcie_dw_qcom.c                                  | 3 ---
 drivers/pci/pcie_dw_rockchip.c                              | 3 ---
 drivers/pci/pcie_dw_ti.c                                    | 3 ---
 drivers/pci/pcie_layerscape.c                               | 3 ---
 drivers/pci/pcie_starfive_jh7110.c                          | 3 ---
 drivers/pci_endpoint/pci_ep-uclass.c                        | 3 ---
 drivers/phy/marvell/comphy_core.c                           | 3 ---
 drivers/phy/omap-usb2-phy.c                                 | 3 ---
 drivers/phy/rockchip/phy-rockchip-pcie.c                    | 3 ---
 drivers/phy/rockchip/phy-rockchip-typec.c                   | 3 ---
 drivers/pinctrl/mtmips/pinctrl-mt7628.c                     | 3 ---
 drivers/pinctrl/nexell/pinctrl-nexell.c                     | 3 ---
 drivers/pinctrl/nexell/pinctrl-s5pxx18.c                    | 3 ---
 drivers/pinctrl/nxp/pinctrl-imx-mmio.c                      | 3 ---
 drivers/pinctrl/nxp/pinctrl-imx.c                           | 3 ---
 drivers/pinctrl/nxp/pinctrl-imx8.c                          | 3 ---
 drivers/pinctrl/nxp/pinctrl-mxs.c                           | 3 ---
 drivers/power/domain/imx8m-power-domain.c                   | 3 ---
 drivers/power/pmic/bd71837.c                                | 3 ---
 drivers/power/pmic/mc34708.c                                | 3 ---
 drivers/power/pmic/mp5416.c                                 | 3 ---
 drivers/power/pmic/pca9450.c                                | 3 ---
 drivers/power/regulator/pwm_regulator.c                     | 3 ---
 drivers/pwm/pwm-sifive.c                                    | 3 ---
 drivers/pwm/rk_pwm.c                                        | 3 ---
 drivers/pwm/sunxi_pwm.c                                     | 3 ---
 drivers/ram/stm32mp1/stm32mp1_tests.c                       | 3 ---
 drivers/reboot-mode/reboot-mode-gpio.c                      | 2 --
 drivers/reboot-mode/reboot-mode-rtc.c                       | 2 --
 drivers/remoteproc/rproc-uclass.c                           | 2 --
 drivers/serial/ns16550.c                                    | 3 ---
 drivers/serial/sandbox.c                                    | 3 ---
 drivers/serial/serial_adi_uart4.c                           | 2 --
 drivers/serial/serial_htif.c                                | 3 ---
 drivers/serial/serial_xen.c                                 | 3 ---
 drivers/smem/msm_smem.c                                     | 3 ---
 drivers/spi/ca_sflash.c                                     | 3 ---
 drivers/spi/microchip_coreqspi.c                            | 2 --
 drivers/spi/mvebu_a3700_spi.c                               | 3 ---
 drivers/spi/omap3_spi.c                                     | 3 ---
 drivers/spi/spi-sunxi.c                                     | 3 ---
 drivers/spi/spi-synquacer.c                                 | 2 --
 drivers/spi/spi-uclass.c                                    | 3 ---
 drivers/spi/tegra210_qspi.c                                 | 3 ---
 drivers/spmi/spmi-msm.c                                     | 3 ---
 drivers/thermal/imx_tmu.c                                   | 3 ---
 drivers/timer/ostm_timer.c                                  | 3 ---
 drivers/timer/sp804_timer.c                                 | 3 ---
 drivers/usb/common/common.c                                 | 3 ---
 drivers/usb/phy/rockchip_usb2_phy.c                         | 3 ---
 drivers/usb/tcpm/tcpm.c                                     | 2 --
 drivers/video/hx8238d.c                                     | 2 --
 drivers/video/imx/mxc_ipuv3_fb.c                            | 3 ---
 drivers/video/nexell_display.c                              | 3 ---
 drivers/video/rockchip/rk_lvds.c                            | 3 ---
 drivers/video/rockchip/rk_mipi.c                            | 3 ---
 drivers/video/sandbox_sdl.c                                 | 3 ---
 drivers/video/tidss/tidss_drv.c                             | 2 --
 drivers/video/zynqmp/zynqmp_dpsub.c                         | 3 ---
 drivers/watchdog/armada-37xx-wdt.c                          | 3 ---
 drivers/watchdog/at91sam9_wdt.c                             | 3 ---
 drivers/watchdog/mt7621_wdt.c                               | 3 ---
 drivers/watchdog/orion_wdt.c                                | 3 ---
 drivers/watchdog/sbsa_gwdt.c                                | 3 ---
 drivers/watchdog/wdt-uclass.c                               | 3 ---
 fs/fs.c                                                     | 3 ---
 fs/ubifs/ubifs.c                                            | 3 ---
 include/relocate.h                                          | 2 --
 lib/efi_loader/efi_capsule.c                                | 3 ---
 lib/efi_loader/efi_gop.c                                    | 3 ---
 lib/efi_loader/efi_rng.c                                    | 3 ---
 net/eth-uclass.c                                            | 3 ---
 net/tftp.c                                                  | 3 ---
 net/wget.c                                                  | 3 ---
 test/cmd/exit.c                                             | 3 ---
 test/cmd/test_echo.c                                        | 3 ---
 test/cmd/test_pause.c                                       | 3 ---
 test/dm/blk.c                                               | 3 ---
 test/dm/i3c.c                                               | 2 --
 test/lib/test_print.c                                       | 3 ---
 test/log/log_filter.c                                       | 3 ---
 293 files changed, 826 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index b143392ee6c..91bce5235a5 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -10,9 +10,6 @@
 #include <irq_func.h>
 #include <log.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 static int cleanup_before_linux(void)
 {
diff --git a/arch/arm/cpu/armv7/s5p4418/cpu.c b/arch/arm/cpu/armv7/s5p4418/=
cpu.c
index 27ffb450378..2c550439559 100644
--- a/arch/arm/cpu/armv7/s5p4418/cpu.c
+++ b/arch/arm/cpu/armv7/s5p4418/cpu.c
@@ -7,7 +7,6 @@
 #include <command.h>
 #include <asm/system.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/arch/nexell.h>
@@ -15,8 +14,6 @@
 #include <asm/arch/tieoff.h>
 #include <cpu_func.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifndef	CONFIG_ARCH_CPU_INIT
 #error must be define the macro "CONFIG_ARCH_CPU_INIT"
 #endif
diff --git a/arch/arm/mach-aspeed/ast2600/spl.c b/arch/arm/mach-aspeed/ast2=
600/spl.c
index 0c5a82ed094..60f2c5d291e 100644
--- a/arch/arm/mach-aspeed/ast2600/spl.c
+++ b/arch/arm/mach-aspeed/ast2600/spl.c
@@ -9,9 +9,6 @@
 #include <linux/err.h>
 #include <asm/io.h>
 #include <asm/arch/scu_ast2600.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 void board_init_f(ulong dummy)
 {
diff --git a/arch/arm/mach-imx/imx8/clock.c b/arch/arm/mach-imx/imx8/clock.=
c
index 4e49b5bf375..e37d3bf31e4 100644
--- a/arch/arm/mach-imx/imx8/clock.c
+++ b/arch/arm/mach-imx/imx8/clock.c
@@ -3,12 +3,9 @@
  * Copyright 2018 NXP
  */
=20
-#include <asm/global_data.h>
 #include <linux/errno.h>
 #include <asm/arch/clock.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 mxc_get_clock(enum mxc_clock clk)
 {
 	switch (clk) {
diff --git a/arch/arm/mach-imx/imx8/fdt.c b/arch/arm/mach-imx/imx8/fdt.c
index ce78c8ce919..8337edc2f62 100644
--- a/arch/arm/mach-imx/imx8/fdt.c
+++ b/arch/arm/mach-imx/imx8/fdt.c
@@ -6,7 +6,6 @@
 #include <log.h>
 #include <firmware/imx/sci/sci.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <dm/ofnode.h>
 #include <fdt_support.h>
 #include <linux/libfdt.h>
@@ -14,8 +13,6 @@
 #include <cpu.h>
 #include <dm.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static bool check_owned_resource(sc_rsrc_t rsrc_id)
 {
 	bool owned;
diff --git a/arch/arm/mach-imx/imx8/iomux.c b/arch/arm/mach-imx/imx8/iomux.=
c
index 3e27d75827a..b6175a50226 100644
--- a/arch/arm/mach-imx/imx8/iomux.c
+++ b/arch/arm/mach-imx/imx8/iomux.c
@@ -4,13 +4,10 @@
  */
=20
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/iomux.h>
 #include <firmware/imx/sci/sci.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * configures a single pad in the iomuxer
  */
diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-imx/imx=
8m/clock_imx8mm.c
index 77c8efc7899..b7b3702041e 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
@@ -8,7 +8,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <div64.h>
 #include <errno.h>
@@ -16,8 +15,6 @@
 #include <linux/delay.h>
 #include <phy.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct anamix_pll *ana_pll =3D (struct anamix_pll *)ANATOP_BASE_ADD=
R;
=20
 static u32 get_root_clk(enum clk_root_index clock_id);
diff --git a/arch/arm/mach-imx/imx8ulp/cgc.c b/arch/arm/mach-imx/imx8ulp/cg=
c.c
index f9d8ed5b048..69585a3605b 100644
--- a/arch/arm/mach-imx/imx8ulp/cgc.c
+++ b/arch/arm/mach-imx/imx8ulp/cgc.c
@@ -10,12 +10,9 @@
 #include <asm/arch/cgc.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <hang.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct cgc1_regs *cgc1_regs =3D (struct cgc1_regs *)0x292C0000UL;
 static struct cgc2_regs *cgc2_regs =3D (struct cgc2_regs *)0x2da60000UL;
=20
diff --git a/arch/arm/mach-imx/imx8ulp/clock.c b/arch/arm/mach-imx/imx8ulp/=
clock.c
index c390f20d769..1b5cbd56f50 100644
--- a/arch/arm/mach-imx/imx8ulp/clock.c
+++ b/arch/arm/mach-imx/imx8ulp/clock.c
@@ -12,11 +12,8 @@
 #include <asm/arch/pcc.h>
 #include <asm/arch/cgc.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PLL_USB_EN_USB_CLKS_MASK	(0x01 << 6)
 #define PLL_USB_PWR_MASK		(0x01 << 12)
 #define PLL_USB_ENABLE_MASK		(0x01 << 13)
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.=
c
index e65cabef2c9..14a2bdf5762 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -10,7 +10,6 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/ccm_regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <div64.h>
 #include <errno.h>
@@ -19,8 +18,6 @@
 #include <log.h>
 #include <phy.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct anatop_reg *ana_regs =3D (struct anatop_reg *)ANATOP_BASE_AD=
DR;
=20
 static struct imx_intpll_rate_table imx9_intpll_tbl[] =3D {
diff --git a/arch/arm/mach-imx/imx9/clock_root.c b/arch/arm/mach-imx/imx9/c=
lock_root.c
index 5dbc398e97f..acf79a40584 100644
--- a/arch/arm/mach-imx/imx9/clock_root.c
+++ b/arch/arm/mach-imx/imx9/clock_root.c
@@ -11,11 +11,8 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/iopoll.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct ccm_reg *ccm_reg =3D (struct ccm_reg *)CCM_BASE_ADDR;
=20
 static enum ccm_clk_src clk_root_mux[][4] =3D {
diff --git a/arch/arm/mach-imx/misc.c b/arch/arm/mach-imx/misc.c
index 7452b82f110..90d91b2300a 100644
--- a/arch/arm/mach-imx/misc.c
+++ b/arch/arm/mach-imx/misc.c
@@ -6,14 +6,11 @@
 #include <lmb.h>
 #include <log.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/mach-imx/regs-common.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* 1 second delay should be plenty of time for block reset. */
 #define	RESET_MAX_TIMEOUT	1000000
=20
diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx=
_romapi.c
index b7008df8e35..d36536e600e 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -7,13 +7,10 @@
 #include <image.h>
 #include <imx_container.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/sys_proto.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Caller need ensure the offset and size to align with page size */
 ulong spl_romapi_raw_seekable_read(u32 offset, u32 size, void *buf)
 {
diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-ax=
g.c
index 6535539184c..542792cad1b 100644
--- a/arch/arm/mach-meson/board-axg.c
+++ b/arch/arm/mach-meson/board-axg.c
@@ -10,13 +10,10 @@
 #include <asm/arch/eth.h>
 #include <asm/arch/axg.h>
 #include <asm/arch/mem.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int meson_get_boot_device(void)
 {
 	return readl(AXG_AO_SEC_GP_CFG0) & AXG_AO_BOOT_DEVICE;
diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g=
12a.c
index dc4abe1e107..17722cb897d 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -12,13 +12,10 @@
 #include <asm/arch/g12a.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/meson-vpu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int meson_get_boot_device(void)
 {
 	return readl(G12A_AO_SEC_GP_CFG0) & G12A_AO_BOOT_DEVICE;
diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.=
c
index 0370ed57e20..d5c506df22b 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -11,14 +11,11 @@
 #include <asm/arch/gx.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/meson-vpu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int meson_get_boot_device(void)
 {
 	return readl(GX_AO_SEC_GP_CFG0) & GX_AO_BOOT_DEVICE;
diff --git a/arch/arm/mach-socfpga/clock_manager_agilex.c b/arch/arm/mach-s=
ocfpga/clock_manager_agilex.c
index 9987d5bcee6..95c7f044952 100644
--- a/arch/arm/mach-socfpga/clock_manager_agilex.c
+++ b/arch/arm/mach-socfpga/clock_manager_agilex.c
@@ -10,12 +10,9 @@
 #include <malloc.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dt-bindings/clock/agilex-clock.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static ulong cm_get_rate_dm(u32 id)
 {
 	struct udevice *dev;
diff --git a/arch/arm/mach-socfpga/clock_manager_agilex5.c b/arch/arm/mach-=
socfpga/clock_manager_agilex5.c
index 7ec28d91ef3..fa068a9eeb1 100644
--- a/arch/arm/mach-socfpga/clock_manager_agilex5.c
+++ b/arch/arm/mach-socfpga/clock_manager_agilex5.c
@@ -14,7 +14,6 @@
 #include <stdio.h>
 #include <time.h>
 #include <vsprintf.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -23,8 +22,6 @@
 #include <asm/arch/system_manager.h>
 #include <dt-bindings/clock/agilex5-clock.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static ulong cm_get_rate_dm(u32 id)
 {
 	struct udevice *dev;
diff --git a/arch/arm/mach-socfpga/clock_manager_n5x.c b/arch/arm/mach-socf=
pga/clock_manager_n5x.c
index c4c071330fc..8e47b4b8f5b 100644
--- a/arch/arm/mach-socfpga/clock_manager_n5x.c
+++ b/arch/arm/mach-socfpga/clock_manager_n5x.c
@@ -6,15 +6,12 @@
=20
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-bindings/clock/n5x-clock.h>
 #include <malloc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static ulong cm_get_rate_dm(u32 id)
 {
 	struct udevice *dev;
diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/mach-socf=
pga/clock_manager_s10.c
index d6c64e98010..fd27470f967 100644
--- a/arch/arm/mach-socfpga/clock_manager_s10.c
+++ b/arch/arm/mach-socfpga/clock_manager_s10.c
@@ -7,14 +7,11 @@
 #include <compiler.h>
 #include <dm/device.h>
 #include <linux/errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/handoff_soc64.h>
 #include <asm/arch/system_manager.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * function to write the bypass register which requires a poll of the
  * busy bit
diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-socfpga/ma=
ilbox_s10.c
index f9c34e85711..5e8768168d3 100644
--- a/arch/arm/mach-socfpga/mailbox_s10.c
+++ b/arch/arm/mach-socfpga/mailbox_s10.c
@@ -8,15 +8,12 @@
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/smc_api.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/secure.h>
 #include <asm/system.h>
 #include <hang.h>
 #include <wait_bit.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define MBOX_READL(reg)			\
 	 readl(SOCFPGA_MAILBOX_ADDRESS + (reg))
=20
diff --git a/arch/arm/mach-socfpga/misc_gen5.c b/arch/arm/mach-socfpga/misc=
_gen5.c
index 5259ef54d73..ae33051c00f 100644
--- a/arch/arm/mach-socfpga/misc_gen5.c
+++ b/arch/arm/mach-socfpga/misc_gen5.c
@@ -6,7 +6,6 @@
 #include <config.h>
 #include <cpu_func.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <env.h>
 #include <errno.h>
@@ -28,8 +27,6 @@
=20
 #include <dt-bindings/reset/altr,rst-mgr.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct pl310_regs *const pl310 =3D
 	(struct pl310_regs *)CFG_SYS_PL310_BASE;
 static struct nic301_registers *nic301_regs =3D
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/mis=
c_soc64.c
index 5222b384434..356240a647e 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -17,11 +17,8 @@
 #include <asm/arch/system_manager.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/global_data.h>
 #include <mach/clock_manager.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Agilex5 Sub Device Jtag ID List */
 #define A3690_JTAG_ID	0x036090DD
 #define A3694_JTAG_ID	0x436090DD
diff --git a/arch/arm/mach-socfpga/mmu-arm64_s10.c b/arch/arm/mach-socfpga/=
mmu-arm64_s10.c
index 1dc44ab4797..1a7f8d42415 100644
--- a/arch/arm/mach-socfpga/mmu-arm64_s10.c
+++ b/arch/arm/mach-socfpga/mmu-arm64_s10.c
@@ -5,9 +5,6 @@
  */
=20
 #include <asm/armv8/mmu.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 static struct mm_region socfpga_agilex5_mem_map[] =3D {
diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-socf=
pga/reset_manager_s10.c
index abb62a9b49f..7e1ecc1cd1d 100644
--- a/arch/arm/mach-socfpga/reset_manager_s10.c
+++ b/arch/arm/mach-socfpga/reset_manager_s10.c
@@ -7,7 +7,6 @@
=20
 #include <errno.h>
 #include <hang.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/secure.h>
 #include <asm/arch/reset_manager.h>
@@ -20,8 +19,6 @@
 #include <linux/intel-smc.h>
 #include <wait_bit.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define TIMEOUT_300MS     300
=20
 /* F2S manager registers */
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl=
_agilex.c
index 48f258a37b4..53a9aa55f80 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -7,7 +7,6 @@
=20
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <hang.h>
@@ -22,8 +21,6 @@
 #include <wdt.h>
 #include <dm/uclass.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 reset_flag(u32 flag)
 {
 	/* Check rstmgr.stat for warm reset status */
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/sp=
l_agilex5.c
index 1be347360f5..2c3e40b664a 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -6,7 +6,6 @@
  */
=20
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <hang.h>
 #include <spl.h>
@@ -19,8 +18,6 @@
 #include <wdt.h>
 #include <dm/uclass.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 reset_flag(u32 flag)
 {
 	/* Check rstmgr.stat for warm reset status */
diff --git a/arch/arm/mach-socfpga/spl_agilex7m.c b/arch/arm/mach-socfpga/s=
pl_agilex7m.c
index 90065ccee6f..7371202a712 100644
--- a/arch/arm/mach-socfpga/spl_agilex7m.c
+++ b/arch/arm/mach-socfpga/spl_agilex7m.c
@@ -15,14 +15,11 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/u-boot.h>
 #include <asm/utils.h>
 #include <dm/uclass.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 void board_init_f(ulong dummy)
 {
 	int ret;
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_g=
en5.c
index df79cfe0f7f..08b756db2ca 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -6,7 +6,6 @@
 #include <hang.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <image.h>
@@ -25,8 +24,6 @@
 #include <dm/uclass.h>
 #include <linux/bitops.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 spl_boot_device(void)
 {
 	const u32 bsel =3D readl(socfpga_get_sysmgr_addr() +
diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5=
x.c
index 81283ef7162..a49be837921 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -10,7 +10,6 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <dm/uclass.h>
@@ -20,8 +19,6 @@
 #include <spl.h>
 #include <watchdog.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 void board_init_f(ulong dummy)
 {
 	int ret;
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s1=
0.c
index fa83ff96adc..a0d3c96d456 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -7,7 +7,6 @@
 #include <hang.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <debug_uart.h>
@@ -22,8 +21,6 @@
 #include <watchdog.h>
 #include <dm/uclass.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 void board_init_f(ulong dummy)
 {
 	const struct cm_config *cm_default_cfg =3D cm_get_default_config();
diff --git a/arch/arm/mach-socfpga/system_manager_soc64.c b/arch/arm/mach-s=
ocfpga/system_manager_soc64.c
index 913f93c8f94..a5c0387190b 100644
--- a/arch/arm/mach-socfpga/system_manager_soc64.c
+++ b/arch/arm/mach-socfpga/system_manager_soc64.c
@@ -6,12 +6,9 @@
=20
 #include <asm/arch/handoff_soc64.h>
 #include <asm/arch/system_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitfield.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 /*
  * Setting RESET_PULSE_OVERRIDE bit for successful reset staggering pulse
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index 4879a41aab3..2410515f4ac 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -17,12 +17,9 @@
 #include <image.h>
 #include <log.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <u-boot/zlib.h>
 #include <asm/byteorder.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 	void (*thekernel)(char *cmdline, ulong rd, ulong dt);
diff --git a/arch/mips/mach-ath79/qca956x/ddr.c b/arch/mips/mach-ath79/qca9=
56x/ddr.c
index 2e46e24f483..754e2573e37 100644
--- a/arch/mips/mach-ath79/qca956x/ddr.c
+++ b/arch/mips/mach-ath79/qca956x/ddr.c
@@ -5,7 +5,6 @@
  * Based on QSDK
  */
=20
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
 #include <asm/types.h>
@@ -182,8 +181,6 @@
 	DDR_CTL_CONFIG_MISC_SRC1_SRAM_SYNC_SET(0x1) | \
 	DDR_CTL_CONFIG_MISC_SRC2_SRAM_SYNC_SET(0x1)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 void qca956x_ddr_init(void)
 {
 	u32 ddr_config, ddr_config2, ddr_config3, mod_val, \
diff --git a/arch/mips/mach-mscc/cpu.c b/arch/mips/mach-mscc/cpu.c
index 22b1b98e0ef..8ae6fb9437a 100644
--- a/arch/mips/mach-mscc/cpu.c
+++ b/arch/mips/mach-mscc/cpu.c
@@ -4,7 +4,6 @@
  */
=20
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
=20
 #include <asm/io.h>
@@ -14,8 +13,6 @@
 #include <mach/tlb.h>
 #include <mach/ddr.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CFG_SYS_SDRAM_SIZE <=3D SZ_64M
 #define MSCC_RAM_TLB_SIZE   SZ_64M
 #define MSCC_ATTRIB2   MMU_REGIO_INVAL
diff --git a/arch/mips/mach-mtmips/ddr_cal.c b/arch/mips/mach-mtmips/ddr_ca=
l.c
index e2e1760a646..5fc4e0c49e8 100644
--- a/arch/mips/mach-mtmips/ddr_cal.c
+++ b/arch/mips/mach-mtmips/ddr_cal.c
@@ -7,13 +7,10 @@
=20
 #include <asm/addrspace.h>
 #include <asm/cacheops.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <mach/mc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define COARSE_MIN_START	6
 #define FINE_MIN_START		15
 #define COARSE_MAX_START	7
diff --git a/arch/mips/mach-octeon/cvmx-pko.c b/arch/mips/mach-octeon/cvmx-=
pko.c
index 8a9181362bd..432488f7815 100644
--- a/arch/mips/mach-octeon/cvmx-pko.c
+++ b/arch/mips/mach-octeon/cvmx-pko.c
@@ -52,8 +52,6 @@
 #include <mach/cvmx-helper-pki.h>
 #include <mach/cvmx-helper-pko.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define CVMX_PKO_NQ_PER_PORT_MAX 32
=20
 static cvmx_pko_return_value_t cvmx_pko2_config_port(short ipd_port,
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 71319839ba2..294ebfb508b 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -10,9 +10,6 @@
 #include <image.h>
 #include <irq_func.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 #define NIOS_MAGIC 0x534f494e /* enable command line and initrd passing */
=20
diff --git a/arch/riscv/cpu/andes/spl.c b/arch/riscv/cpu/andes/spl.c
index a13dc4095a4..1e19fad9288 100644
--- a/arch/riscv/cpu/andes/spl.c
+++ b/arch/riscv/cpu/andes/spl.c
@@ -8,11 +8,8 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/system.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(RAM_SUPPORT)
 struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 {
diff --git a/arch/riscv/cpu/cv1800b/dram.c b/arch/riscv/cpu/cv1800b/dram.c
index 91007c0a3d3..5d7659887b9 100644
--- a/arch/riscv/cpu/cv1800b/dram.c
+++ b/arch/riscv/cpu/cv1800b/dram.c
@@ -5,11 +5,8 @@
=20
 #include <fdtdec.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/sizes.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
index 91007c0a3d3..5d7659887b9 100644
--- a/arch/riscv/cpu/generic/dram.c
+++ b/arch/riscv/cpu/generic/dram.c
@@ -5,11 +5,8 @@
=20
 #include <fdtdec.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/sizes.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/arch/riscv/cpu/k230/dram.c b/arch/riscv/cpu/k230/dram.c
index b2d3e4fd6a9..5d7659887b9 100644
--- a/arch/riscv/cpu/k230/dram.c
+++ b/arch/riscv/cpu/k230/dram.c
@@ -3,13 +3,10 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
=20
-#include <asm/global_data.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <linux/sizes.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/arch/riscv/cpu/th1520/spl.c b/arch/riscv/cpu/th1520/spl.c
index b95470485f6..ceb934021d9 100644
--- a/arch/riscv/cpu/th1520/spl.c
+++ b/arch/riscv/cpu/th1520/spl.c
@@ -10,8 +10,6 @@
 #include <log.h>
 #include <init.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define TH1520_SUBSYS_CLK		(void __iomem *)(0xffff011000 + 0x220)
 #define  TH1520_SUBSYS_CLK_VO_EN	BIT(2)
 #define  TH1520_SUBSYS_CLK_VI_EN	BIT(1)
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index bb0f59e0aa2..1c118870dad 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -13,11 +13,8 @@
 #include <env.h>
 #include <image.h>
 #include <asm/byteorder.h>
-#include <asm/global_data.h>
 #include <asm/zimage.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifdef CONFIG_SH_SDRAM_OFFSET
 #define GET_INITRD_START(initrd, linux) (initrd - linux + CONFIG_SH_SDRAM_=
OFFSET)
 #else
diff --git a/arch/x86/cpu/ivybridge/model_206ax.c b/arch/x86/cpu/ivybridge/=
model_206ax.c
index b72de96a277..ed0ad686b3f 100644
--- a/arch/x86/cpu/ivybridge/model_206ax.c
+++ b/arch/x86/cpu/ivybridge/model_206ax.c
@@ -14,7 +14,6 @@
 #include <asm/cpu.h>
 #include <asm/cpu_common.h>
 #include <asm/cpu_x86.h>
-#include <asm/global_data.h>
 #include <asm/msr.h>
 #include <asm/msr-index.h>
 #include <asm/mtrr.h>
@@ -23,8 +22,6 @@
 #include <asm/turbo.h>
 #include <asm/arch/model_206ax.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void enable_vmx(void)
 {
 	struct cpuid_result regs;
diff --git a/arch/x86/lib/init_helpers.c b/arch/x86/lib/init_helpers.c
index bd0efde00c1..96943cb8c46 100644
--- a/arch/x86/lib/init_helpers.c
+++ b/arch/x86/lib/init_helpers.c
@@ -5,13 +5,10 @@
  */
=20
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/errno.h>
 #include <asm/mtrr.h>
 #include <asm/u-boot-x86.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int init_cache_f_r(void)
 {
 	bool do_mtrr =3D CONFIG_IS_ENABLED(X86_32BIT_INIT) ||
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 2ea9bcf59c2..a5f2231aa52 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -30,7 +30,6 @@
 #include <asm/bootm.h>
 #include <asm/bootparam.h>
 #include <asm/efi.h>
-#include <asm/global_data.h>
 #ifdef CONFIG_SYS_COREBOOT
 #include <asm/arch/timestamp.h>
 #endif
@@ -38,8 +37,6 @@
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * Memory lay-out:
  *
diff --git a/arch/xtensa/lib/time.c b/arch/xtensa/lib/time.c
index 319635c6b09..1fe33a4c62b 100644
--- a/arch/xtensa/lib/time.c
+++ b/arch/xtensa/lib/time.c
@@ -5,12 +5,9 @@
=20
 #include <clock_legacy.h>
 #include <time.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/stringify.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if XCHAL_HAVE_CCOUNT
 static ulong get_ccount(void)
 {
diff --git a/board/BuR/brsmarc1/board.c b/board/BuR/brsmarc1/board.c
index c05eec6b35e..01d7a8c39e2 100644
--- a/board/BuR/brsmarc1/board.c
+++ b/board/BuR/brsmarc1/board.c
@@ -18,7 +18,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/mem.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <asm/emif.h>
@@ -30,8 +29,6 @@
 /* -- defines for used GPIO Hardware -- */
 #define PER_RESET		(2 * 32 + 0)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if defined(CONFIG_XPL_BUILD)
 static const struct ddr_data ddr3_data =3D {
 	.datardsratio0 =3D MT41K256M16HA125E_RD_DQS,
diff --git a/board/BuR/common/common.c b/board/BuR/common/common.c
index 3513f43a9f5..bbafecd7909 100644
--- a/board/BuR/common/common.c
+++ b/board/BuR/common/common.c
@@ -13,12 +13,9 @@
 #include <env.h>
 #include <fdtdec.h>
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include "bur_common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* -----------------------------------------------------------------------=
---*/
=20
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/board/Marvell/octeontx/smc.c b/board/Marvell/octeontx/smc.c
index 8df32049bda..ab6284a732c 100644
--- a/board/Marvell/octeontx/smc.c
+++ b/board/Marvell/octeontx/smc.c
@@ -5,13 +5,10 @@
  * https://spdx.org/licenses
  */
=20
-#include <asm/global_data.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/arch/smc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 ssize_t smc_dram_size(unsigned int node)
 {
 	struct pt_regs regs;
diff --git a/board/Marvell/octeontx2/smc.c b/board/Marvell/octeontx2/smc.c
index 9e3169576c6..10645a74f69 100644
--- a/board/Marvell/octeontx2/smc.c
+++ b/board/Marvell/octeontx2/smc.c
@@ -5,15 +5,12 @@
  * https://spdx.org/licenses
  */
=20
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/arch/smc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 ssize_t smc_dram_size(unsigned int node)
 {
 	struct pt_regs regs;
diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/ad=
vantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
index 8c9e9830876..a9a12a4f659 100644
--- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
+++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
@@ -26,8 +26,6 @@
 #include <linux/kernel.h>
 #include <power/pmic.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifdef CONFIG_NAND_MXS
 static void setup_gpmi_nand(void)
 {
diff --git a/board/advantech/imx8mp_rsb3720a1/spl.c b/board/advantech/imx8m=
p_rsb3720a1/spl.c
index 1f7c1f25adc..fb8e8437759 100644
--- a/board/advantech/imx8mp_rsb3720a1/spl.c
+++ b/board/advantech/imx8mp_rsb3720a1/spl.c
@@ -29,8 +29,6 @@
 #include <power/pmic.h>
 #include <power/pca9450.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 #ifdef CONFIG_SPL_BOOTROM_SUPPORT
diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/board/=
advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
index accd300df04..fbe8b247e69 100644
--- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
+++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
@@ -16,8 +16,6 @@
 #include <asm/arch/sys_proto.h>
 /* #include <power-domain.h> */
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			(SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			(SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c b/board/=
advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
index 3def182f296..8214e627768 100644
--- a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
+++ b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
@@ -8,7 +8,6 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
 #include <asm/io.h>
@@ -19,8 +18,6 @@
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/andestech/voyager/voyager.c b/board/andestech/voyager/vo=
yager.c
index dc8f1347775..23fd0910ef8 100644
--- a/board/andestech/voyager/voyager.c
+++ b/board/andestech/voyager/voyager.c
@@ -5,7 +5,6 @@
  */
=20
 #include <asm/csr.h>
-#include <asm/global_data.h>
 #include <asm/sbi.h>
 #include <config.h>
 #include <cpu_func.h>
@@ -19,8 +18,6 @@
 #include <net.h>
 #include <spl.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64=
/vexpress64.c
index e8f1c2fe9fe..d68da0e3d65 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -12,7 +12,6 @@
 #include <errno.h>
 #include <net.h>
 #include <netdev.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <linux/sizes.h>
@@ -24,8 +23,6 @@
 #include <virtio.h>
 #endif
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static const struct pl01x_serial_plat serial_plat =3D {
 	.base =3D V2M_UART0,
 	.type =3D TYPE_PL011,
diff --git a/board/beacon/imx8mm/spl.c b/board/beacon/imx8mm/spl.c
index 93ee5b7ee0c..1e5935788ff 100644
--- a/board/beacon/imx8mm/spl.c
+++ b/board/beacon/imx8mm/spl.c
@@ -5,7 +5,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -23,8 +22,6 @@
 #include <power/pmic.h>
 #include <power/bd71837.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/beacon/imx8mn/spl.c b/board/beacon/imx8mn/spl.c
index e91d3fdcf5e..46db42ec921 100644
--- a/board/beacon/imx8mn/spl.c
+++ b/board/beacon/imx8mn/spl.c
@@ -9,7 +9,6 @@
 #include <log.h>
 #include <asm/io.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mn_pins.h>
@@ -32,8 +31,6 @@
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
index 027fae38278..e82e385b774 100644
--- a/board/beacon/imx8mp/spl.c
+++ b/board/beacon/imx8mp/spl.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
@@ -22,8 +21,6 @@
 #include <dm/uclass.h>
 #include <dm/device.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/be=
agleboneai64/beagleboneai64.c
index 500fcc58ed8..27b1f22562c 100644
--- a/board/beagle/beagleboneai64/beagleboneai64.c
+++ b/board/beagle/beagleboneai64/beagleboneai64.c
@@ -13,8 +13,6 @@
 #include <fdt_support.h>
 #include <spl.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct efi_fw_image fw_images[] =3D {
 	{
 		.image_type_id =3D BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID,
diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay=
/beagleplay.c
index 9bc9ca30e95..70d296de9f8 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -14,8 +14,6 @@
=20
 #include <asm/arch/hardware.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct efi_fw_image fw_images[] =3D {
 	{
 		.image_type_id =3D BEAGLEPLAY_TIBOOT3_IMAGE_GUID,
diff --git a/board/broadcom/bcmns/ns.c b/board/broadcom/bcmns/ns.c
index 47a01227a35..cb53ec68cf8 100644
--- a/board/broadcom/bcmns/ns.c
+++ b/board/broadcom/bcmns/ns.c
@@ -9,12 +9,9 @@
 #include <log.h>
 #include <ram.h>
 #include <serial.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv7m.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/board/cloos/imx8mm_phg/imx8mm_phg.c b/board/cloos/imx8mm_phg/i=
mx8mm_phg.c
index 091c9a59a52..1ca1c07e08e 100644
--- a/board/cloos/imx8mm_phg/imx8mm_phg.c
+++ b/board/cloos/imx8mm_phg/imx8mm_phg.c
@@ -7,14 +7,11 @@
 #include <init.h>
 #include <miiphy.h>
 #include <netdev.h>
-#include <asm/global_data.h>
=20
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =3D
diff --git a/board/cloos/imx8mm_phg/spl.c b/board/cloos/imx8mm_phg/spl.c
index b8892ed2fcc..b2340a0ded3 100644
--- a/board/cloos/imx8mm_phg/spl.c
+++ b/board/cloos/imx8mm_phg/spl.c
@@ -10,7 +10,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -28,8 +27,6 @@
 #include <power/pmic.h>
 #include <power/pca9450.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/compulab/imx8mm-cl-iot-gate/spl.c b/board/compulab/imx8m=
m-cl-iot-gate/spl.c
index 6d9af2538b6..daac6dca4ce 100644
--- a/board/compulab/imx8mm-cl-iot-gate/spl.c
+++ b/board/compulab/imx8mm-cl-iot-gate/spl.c
@@ -32,8 +32,6 @@
=20
 #include "ddr/ddr.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/coreboot/coreboot/coreboot.c b/board/coreboot/coreboot/c=
oreboot.c
index f2ca1076768..d0e8db6cdfe 100644
--- a/board/coreboot/coreboot/coreboot.c
+++ b/board/coreboot/coreboot/coreboot.c
@@ -7,9 +7,6 @@
 #include <init.h>
 #include <smbios.h>
 #include <asm/cb_sysinfo.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 int board_early_init_r(void)
 {
diff --git a/board/cssi/cmpc885/cmpc885.c b/board/cssi/cmpc885/cmpc885.c
index 49c13056edc..552349d104a 100644
--- a/board/cssi/cmpc885/cmpc885.c
+++ b/board/cssi/cmpc885/cmpc885.c
@@ -26,8 +26,6 @@
=20
 #include "../common/common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define ADDR_CPLD_R_RESET		((unsigned short __iomem *)CONFIG_CPLD_BASE)
 #define ADDR_CPLD_R_ETAT		((unsigned short __iomem *)(CONFIG_CPLD_BASE + 2=
))
 #define ADDR_CPLD_R_TYPE		((unsigned char  __iomem *)(CONFIG_CPLD_BASE + 3=
))
diff --git a/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c b/=
board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
index e271d060efa..ab4a484d393 100644
--- a/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
+++ b/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
@@ -14,8 +14,6 @@
=20
 #include "../common/common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_late_init(void)
 {
 	struct udevice *dev;
diff --git a/board/data_modul/imx8mm_edm_sbc/spl.c b/board/data_modul/imx8m=
m_edm_sbc/spl.c
index a9ef049652a..c6a5740c7a7 100644
--- a/board/data_modul/imx8mm_edm_sbc/spl.c
+++ b/board/data_modul/imx8mm_edm_sbc/spl.c
@@ -27,8 +27,6 @@
=20
 #include "../common/common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int data_modul_imx_edm_sbc_board_power_init(void)
 {
 	struct udevice *dev;
diff --git a/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c b/=
board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
index d6f0a917023..5c319df1cde 100644
--- a/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
+++ b/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
@@ -17,8 +17,6 @@
=20
 #include "../common/common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void dmo_setup_second_mac_address(void)
 {
 	u8 enetaddr[6];
diff --git a/board/data_modul/imx8mp_edm_sbc/spl.c b/board/data_modul/imx8m=
p_edm_sbc/spl.c
index f81b7274556..314f7e87a9d 100644
--- a/board/data_modul/imx8mp_edm_sbc/spl.c
+++ b/board/data_modul/imx8mp_edm_sbc/spl.c
@@ -28,8 +28,6 @@
=20
 #include "../common/common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int data_modul_imx_edm_sbc_board_power_init(void)
 {
 	struct udevice *dev;
diff --git a/board/dhelectronics/dh_imx8mp/common.c b/board/dhelectronics/d=
h_imx8mp/common.c
index f6db9f67804..5d89c94970d 100644
--- a/board/dhelectronics/dh_imx8mp/common.c
+++ b/board/dhelectronics/dh_imx8mp/common.c
@@ -8,8 +8,6 @@
=20
 #include "lpddr4_timing.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 u8 dh_get_memcfg(void)
 {
 	struct gpio_desc gpio[4];
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhel=
ectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 5c35a5bf447..3fe98d36f5b 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -20,8 +20,6 @@
 #include "../common/dh_common.h"
 #include "../common/dh_imx.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int mach_cpu_init(void)
 {
 	icache_enable();
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_i=
mx8mp/spl.c
index 714f846521e..727e1ff3774 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -29,8 +29,6 @@
=20
 #include "lpddr4_timing.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_ODE | PAD_CTL_PUE | PAD_CTL_=
PE)
=20
diff --git a/board/emcraft/imx8mp_navqp/spl.c b/board/emcraft/imx8mp_navqp/=
spl.c
index 7f30f3af742..5ee94d078f8 100644
--- a/board/emcraft/imx8mp_navqp/spl.c
+++ b/board/emcraft/imx8mp_navqp/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/sections.h>
 #include <dm/device.h>
@@ -20,8 +19,6 @@
 #include <power/pmic.h>
 #include <spl.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu=
-riscv/qemu-riscv.c
index 97c8211c100..ce5bc34ca71 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -15,8 +15,6 @@
 #include <virtio_types.h>
 #include <virtio.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_MTD_NOR_FLASH)
 int is_flash_available(void)
 {
diff --git a/board/engicam/imx8mm/icore_mx8mm.c b/board/engicam/imx8mm/icor=
e_mx8mm.c
index 236337546ae..bb70e7d4ff8 100644
--- a/board/engicam/imx8mm/icore_mx8mm.c
+++ b/board/engicam/imx8mm/icore_mx8mm.c
@@ -19,8 +19,6 @@
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_FEC_MXC)
=20
 #define FEC_RST_PAD IMX_GPIO_NR(3, 7)
diff --git a/board/engicam/imx8mm/spl.c b/board/engicam/imx8mm/spl.c
index d51ae241e85..5a6bcb1747a 100644
--- a/board/engicam/imx8mm/spl.c
+++ b/board/engicam/imx8mm/spl.c
@@ -17,8 +17,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icor=
e_mx8mp.c
index bfdc447c478..864afa92aee 100644
--- a/board/engicam/imx8mp/icore_mx8mp.c
+++ b/board/engicam/imx8mp/icore_mx8mp.c
@@ -14,7 +14,6 @@
 #include <miiphy.h>
 #include <netdev.h>
 #include <linux/delay.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm-generic/gpio.h>
 #include <asm/arch/imx8mp_pins.h>
@@ -22,8 +21,6 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/gpio.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =3D
diff --git a/board/engicam/imx8mp/spl.c b/board/engicam/imx8mp/spl.c
index cd31aa6041d..c1aa28a17bc 100644
--- a/board/engicam/imx8mp/spl.c
+++ b/board/engicam/imx8mp/spl.c
@@ -12,7 +12,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
@@ -24,8 +23,6 @@
 #include <power/pmic.h>
 #include <power/pca9450.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/gdsys/mpc8308/gazerbeam.c b/board/gdsys/mpc8308/gazerbea=
m.c
index 05e4d84460a..123dda21423 100644
--- a/board/gdsys/mpc8308/gazerbeam.c
+++ b/board/gdsys/mpc8308/gazerbeam.c
@@ -17,13 +17,10 @@
 #include <sysinfo.h>
 #include <tpm-v1.h>
 #include <video_osd.h>
-#include <asm/global_data.h>
=20
 #include "../common/ihs_mdio.h"
 #include "../../../drivers/sysinfo/gazerbeam.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct ihs_mdio_info ihs_mdio_info[] =3D {
 	{ .fpga =3D NULL, .name =3D "ihs0", .base =3D 0x58 },
 	{ .fpga =3D NULL, .name =3D "ihs1", .base =3D 0x58 },
diff --git a/board/google/imx8mq_phanbell/imx8mq_phanbell.c b/board/google/=
imx8mq_phanbell/imx8mq_phanbell.c
index 9544d6dd19a..2f16f1da26c 100644
--- a/board/google/imx8mq_phanbell/imx8mq_phanbell.c
+++ b/board/google/imx8mq_phanbell/imx8mq_phanbell.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -21,8 +20,6 @@
 #include <asm/arch/clock.h>
 #include <spl.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
=20
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
diff --git a/board/highbank/highbank.c b/board/highbank/highbank.c
index 0ec88447384..62a7b5b0420 100644
--- a/board/highbank/highbank.c
+++ b/board/highbank/highbank.c
@@ -11,7 +11,6 @@
 #include <init.h>
 #include <net.h>
 #include <scsi.h>
-#include <asm/global_data.h>
=20
 #include <linux/sizes.h>
 #include <asm/io.h>
@@ -37,8 +36,6 @@
 #define HB_SCU_A9_PWR_DORMANT		2
 #define HB_SCU_A9_PWR_OFF		3
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 void cphy_disable_overrides(void);
=20
 /*
diff --git a/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c b/board/kontron/osm-s-=
mx8mp/osm-s-mx8mp.c
index 3db7176f723..739a78d2c8b 100644
--- a/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
+++ b/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
@@ -5,7 +5,6 @@
=20
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <dm/uclass.h>
@@ -22,8 +21,6 @@
=20
 #include "../common/hw-uid.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_KONTRON_HW_UID)
 struct uid_otp_loc uid_otp_locations[] =3D {
 	{
diff --git a/board/kontron/osm-s-mx93/osm-s-mx93.c b/board/kontron/osm-s-mx=
93/osm-s-mx93.c
index d4645285771..b6feef549d1 100644
--- a/board/kontron/osm-s-mx93/osm-s-mx93.c
+++ b/board/kontron/osm-s-mx93/osm-s-mx93.c
@@ -6,7 +6,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <dm/uclass.h>
@@ -23,8 +22,6 @@
=20
 #include "../common/hw-uid.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_early_init_f(void)
 {
 	return 0;
diff --git a/board/kontron/pitx_imx8m/pitx_imx8m.c b/board/kontron/pitx_imx=
8m/pitx_imx8m.c
index 2ee97169c6f..f71fa57b808 100644
--- a/board/kontron/pitx_imx8m/pitx_imx8m.c
+++ b/board/kontron/pitx_imx8m/pitx_imx8m.c
@@ -15,8 +15,6 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
=20
diff --git a/board/mntre/imx8mq_reform2/imx8mq_reform2.c b/board/mntre/imx8=
mq_reform2/imx8mq_reform2.c
index 6ee1c5c52a1..bcb31564a73 100644
--- a/board/mntre/imx8mq_reform2/imx8mq_reform2.c
+++ b/board/mntre/imx8mq_reform2/imx8mq_reform2.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -26,8 +25,6 @@
 #include <linux/delay.h>
 #include <power/pmic.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
=20
 static iomux_v3_cfg_t const wdog_pads[] =3D {
diff --git a/board/msc/sm2s_imx8mp/sm2s_imx8mp.c b/board/msc/sm2s_imx8mp/sm=
2s_imx8mp.c
index b1ce014bd55..b2f763dcc02 100644
--- a/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
+++ b/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
@@ -18,8 +18,6 @@
 #include <asm-generic/gpio.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =3D
diff --git a/board/msc/sm2s_imx8mp/spl.c b/board/msc/sm2s_imx8mp/spl.c
index b1b5561838d..902179aad29 100644
--- a/board/msc/sm2s_imx8mp/spl.c
+++ b/board/msc/sm2s_imx8mp/spl.c
@@ -17,7 +17,6 @@
 #include <log.h>
 #include <mmc.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
@@ -33,8 +32,6 @@
 #include <power/pmic.h>
 #include <power/rn5t567_pmic.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/nxp/imx8mm_evk/imx8mm_evk.c b/board/nxp/imx8mm_evk/imx8m=
m_evk.c
index ecc20768cb5..a8c1ef287e5 100644
--- a/board/nxp/imx8mm_evk/imx8mm_evk.c
+++ b/board/nxp/imx8mm_evk/imx8mm_evk.c
@@ -9,14 +9,11 @@
 #include <init.h>
 #include <miiphy.h>
 #include <netdev.h>
-#include <asm/global_data.h>
=20
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
 	EFI_GUID(0xead2005e, 0x7780, 0x400b, 0x93, 0x48, \
diff --git a/board/nxp/imx8mm_evk/spl.c b/board/nxp/imx8mm_evk/spl.c
index cd251d274ff..5c588046ff4 100644
--- a/board/nxp/imx8mm_evk/spl.c
+++ b/board/nxp/imx8mm_evk/spl.c
@@ -10,7 +10,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -28,8 +27,6 @@
 #include <power/pmic.h>
 #include <power/pca9450.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
diff --git a/board/nxp/imx8mn_evk/spl.c b/board/nxp/imx8mn_evk/spl.c
index f96f5c45789..6554d445a59 100644
--- a/board/nxp/imx8mn_evk/spl.c
+++ b/board/nxp/imx8mn_evk/spl.c
@@ -11,7 +11,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch/clock.h>
@@ -32,8 +31,6 @@
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/nxp/imx8mp_evk/spl.c b/board/nxp/imx8mp_evk/spl.c
index 12da1b2abfb..25abf6b589e 100644
--- a/board/nxp/imx8mp_evk/spl.c
+++ b/board/nxp/imx8mp_evk/spl.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
@@ -22,8 +21,6 @@
 #include <dm/uclass.h>
 #include <dm/device.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/nxp/imx8qm_mek/imx8qm_mek.c b/board/nxp/imx8qm_mek/imx8q=
m_mek.c
index 72527f774ca..56f577714e7 100644
--- a/board/nxp/imx8qm_mek/imx8qm_mek.c
+++ b/board/nxp/imx8qm_mek/imx8qm_mek.c
@@ -7,7 +7,6 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
 #include <asm/io.h>
@@ -18,8 +17,6 @@
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/nxp/imx8qxp_mek/imx8qxp_mek.c b/board/nxp/imx8qxp_mek/im=
x8qxp_mek.c
index adb9556a021..4bf6645b893 100644
--- a/board/nxp/imx8qxp_mek/imx8qxp_mek.c
+++ b/board/nxp/imx8qxp_mek/imx8qxp_mek.c
@@ -7,7 +7,6 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
 #include <fsl_esdhc_imx.h>
@@ -21,8 +20,6 @@
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define GPIO_PAD_CTRL	((SC_PAD_CONFIG_NORMAL << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/nxp/imx8ulp_evk/imx8ulp_evk.c b/board/nxp/imx8ulp_evk/im=
x8ulp_evk.c
index 4bf77a488cc..cd17f6960c7 100644
--- a/board/nxp/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
@@ -14,8 +14,6 @@
 #include <netdev.h>
 #include <asm/gpio.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_FEC_MXC)
 #define ENET_CLK_PAD_CTRL	(PAD_CTL_PUS_UP | PAD_CTL_DSE | PAD_CTL_IBE_ENAB=
LE)
 static iomux_cfg_t const enet_clk_pads[] =3D {
diff --git a/board/nxp/imx8ulp_evk/spl.c b/board/nxp/imx8ulp_evk/spl.c
index fe637077928..656c2723494 100644
--- a/board/nxp/imx8ulp_evk/spl.c
+++ b/board/nxp/imx8ulp_evk/spl.c
@@ -21,8 +21,6 @@
 #include <asm/mach-imx/ele_api.h>
 #include <asm/sections.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 void spl_dram_init(void)
 {
 	/* Reboot in dual boot setting no need to init ddr again */
diff --git a/board/nxp/imx93_frdm/imx93_frdm.c b/board/nxp/imx93_frdm/imx93=
_frdm.c
index cfbcde2e1a5..d97720795d6 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.c
+++ b/board/nxp/imx93_frdm/imx93_frdm.c
@@ -7,7 +7,6 @@
 #include <efi_loader.h>
 #include <i2c.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch-imx9/imx93_pins.h>
 #include <asm/arch/clock.h>
@@ -15,8 +14,6 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
 	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \
diff --git a/board/phytec/imx8mp-libra-fpsc/spl.c b/board/phytec/imx8mp-lib=
ra-fpsc/spl.c
index d704d588579..08111641aa6 100644
--- a/board/phytec/imx8mp-libra-fpsc/spl.c
+++ b/board/phytec/imx8mp-libra-fpsc/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/mxc_i2c.h>
@@ -24,8 +23,6 @@
 #include "../common/imx8m_som_detection.h"
 #endif
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR		0x51
=20
 int spl_board_boot_device(enum boot_device boot_dev_spl)
diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/ph=
ycore_imx8mm/phycore-imx8mm.c
index f6ae0bf0308..9f6a4ec704d 100644
--- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
+++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
@@ -5,14 +5,11 @@
  */
=20
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
 #include <miiphy.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =3D
diff --git a/board/phytec/phycore_imx8mm/spl.c b/board/phytec/phycore_imx8m=
m/spl.c
index faff064779c..e688793bc74 100644
--- a/board/phytec/phycore_imx8mm/spl.c
+++ b/board/phytec/phycore_imx8mm/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mm_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/sections.h>
@@ -19,8 +18,6 @@
=20
 #include "../common/imx8m_som_detection.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR		0x51
 #define EEPROM_ADDR_FALLBACK	0x59
=20
diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/ph=
ycore_imx8mp/phycore-imx8mp.c
index b345dc7c985..5f0a7ee6a94 100644
--- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
+++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
@@ -5,7 +5,6 @@
  */
=20
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
@@ -17,8 +16,6 @@
=20
 #include "../common/imx8m_som_detection.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR		0x51
 #define EEPROM_ADDR_FALLBACK	0x59
=20
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8m=
p/spl.c
index cb8e450b995..fc7aefd0073 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/mxc_i2c.h>
@@ -23,8 +22,6 @@
 #include "lpddr4_timing.h"
 #include "../common/imx8m_som_detection.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR		0x51
 #define EEPROM_ADDR_FALLBACK	0x59
=20
diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phyc=
ore_imx93/phycore-imx93.c
index cfc6d91f20f..cdaedd52c14 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -7,15 +7,12 @@
  */
=20
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
 #include <fdt_support.h>
=20
 #include "../common/imx93_som_detection.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EEPROM_ADDR            0x50
=20
 int board_init(void)
diff --git a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c b/bo=
ard/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
index c709d017483..7f0925074fa 100644
--- a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
+++ b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
@@ -8,7 +8,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <env.h>
@@ -18,8 +17,6 @@
 #include <miiphy.h>
 #include <netdev.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =3D
diff --git a/board/polyhex/imx8mp_debix_model_a/spl.c b/board/polyhex/imx8m=
p_debix_model_a/spl.c
index 6cbd1815cad..c154ad7a1ce 100644
--- a/board/polyhex/imx8mp_debix_model_a/spl.c
+++ b/board/polyhex/imx8mp_debix_model_a/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/sections.h>
 #include <dm/device.h>
@@ -20,8 +19,6 @@
 #include <power/pmic.h>
 #include <spl.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/purism/librem5/librem5.c b/board/purism/librem5/librem5.=
c
index 5178ee6929d..a2bc0c08f0b 100644
--- a/board/purism/librem5/librem5.c
+++ b/board/purism/librem5/librem5.c
@@ -31,8 +31,6 @@
 #include <usb/xhci.h>
 #include "librem5.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_early_init_f(void)
 {
 	return 0;
diff --git a/board/purism/librem5/spl.c b/board/purism/librem5/spl.c
index ed57554a2bc..568224f9732 100644
--- a/board/purism/librem5/spl.c
+++ b/board/purism/librem5/spl.c
@@ -29,8 +29,6 @@
 #include <linux/usb/gadget.h>
 #include "librem5.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 void spl_dram_init(void)
 {
 	/* ddr init */
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualc=
omm/dragonboard410c/dragonboard410c.c
index 4698b9d5e3e..36e4d49046e 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -15,13 +15,10 @@
 #include <net.h>
 #include <usb.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <fdt_support.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static u32 msm_board_serial(void)
 {
 	struct mmc *mmc_dev;
diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualc=
omm/dragonboard820c/dragonboard820c.c
index 12a9273ec4b..236022a99f1 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -10,7 +10,6 @@
 #include <init.h>
 #include <env.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
 #include <dm.h>
@@ -24,8 +23,6 @@
 /* Strength (sdc1) */
 #define SDC1_HDRV_PULL_CTL_REG          (TLMM_BASE_ADDR + 0x0012D000)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void sdhci_power_init(void)
 {
 	const u32 TLMM_PULL_MASK =3D 0x3;
diff --git a/board/renesas/common/gen3-common.c b/board/renesas/common/gen3=
-common.c
index f89ae81e95e..5c543807b64 100644
--- a/board/renesas/common/gen3-common.c
+++ b/board/renesas/common/gen3-common.c
@@ -12,15 +12,12 @@
 #include <fdt_support.h>
 #include <hang.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/uclass-internal.h>
 #include <asm/arch/renesas.h>
 #include <asm-generic/u-boot.h>
 #include <linux/libfdt.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* If the firmware passed a device tree use it for e.g. U-Boot DRAM setup.=
 */
 extern u64 rcar_atf_boot_args[];
=20
diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4=
-common.c
index 81c6f6f4c6d..ac87f2f08e3 100644
--- a/board/renesas/common/gen4-common.c
+++ b/board/renesas/common/gen4-common.c
@@ -8,7 +8,6 @@
 #include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/armv8/mmu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/processor.h>
@@ -17,8 +16,6 @@
 #include <image.h>
 #include <linux/errno.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void init_generic_timer(void)
 {
 	const u32 freq =3D CONFIG_SYS_CLK_FREQ;
diff --git a/board/renesas/common/gen5-common.c b/board/renesas/common/gen5=
-common.c
index 3b724e59049..c60a76c5038 100644
--- a/board/renesas/common/gen5-common.c
+++ b/board/renesas/common/gen5-common.c
@@ -5,7 +5,6 @@
=20
 #include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/processor.h>
@@ -13,8 +12,6 @@
 #include <asm-generic/u-boot.h>
 #include <linux/errno.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void init_generic_timer(void)
 {
 	const u32 freq =3D CONFIG_SYS_CLK_FREQ;
diff --git a/board/ronetix/imx8mq-cm/imx8mq_cm.c b/board/ronetix/imx8mq-cm/=
imx8mq_cm.c
index 602216854ba..e41cfefe375 100644
--- a/board/ronetix/imx8mq-cm/imx8mq_cm.c
+++ b/board/ronetix/imx8mq-cm/imx8mq_cm.c
@@ -10,8 +10,6 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
=20
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exyno=
s5-dt.c
index 68edd1ec282..2ba2d6330fd 100644
--- a/board/samsung/common/exynos5-dt.c
+++ b/board/samsung/common/exynos5-dt.c
@@ -9,7 +9,6 @@
 #include <env.h>
 #include <fdtdec.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <i2c.h>
@@ -36,8 +35,6 @@
 #include <samsung/misc.h>
 #include <tmu.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int exynos_set_regulator(const char *name, uint uv)
 {
 	struct udevice *dev;
diff --git a/board/samsung/common/misc.c b/board/samsung/common/misc.c
index c134a9d70e2..85e564f27ee 100644
--- a/board/samsung/common/misc.c
+++ b/board/samsung/common/misc.c
@@ -8,7 +8,6 @@
 #include <command.h>
 #include <env.h>
 #include <libtizen.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 #include <samsung/misc.h>
@@ -37,8 +36,6 @@
 #include <power/pmic.h>
 #include <mmc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifdef CONFIG_SET_DFU_ALT_INFO
 void set_dfu_alt_info(char *interface, char *devstr)
 {
diff --git a/board/st/stm32f429-discovery/stm32f429-discovery.c b/board/st/=
stm32f429-discovery/stm32f429-discovery.c
index 4b0defda1ec..333b78c27f3 100644
--- a/board/st/stm32f429-discovery/stm32f429-discovery.c
+++ b/board/st/stm32f429-discovery/stm32f429-discovery.c
@@ -14,13 +14,10 @@
 #include <env.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
=20
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	int rv;
diff --git a/board/st/stm32f429-evaluation/stm32f429-evaluation.c b/board/s=
t/stm32f429-evaluation/stm32f429-evaluation.c
index 88c825334a8..feba46d38e4 100644
--- a/board/st/stm32f429-evaluation/stm32f429-evaluation.c
+++ b/board/st/stm32f429-evaluation/stm32f429-evaluation.c
@@ -8,13 +8,10 @@
 #include <env.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
=20
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	int rv;
diff --git a/board/st/stm32f469-discovery/stm32f469-discovery.c b/board/st/=
stm32f469-discovery/stm32f469-discovery.c
index 7aab7f71d0c..d153efdc2b4 100644
--- a/board/st/stm32f469-discovery/stm32f469-discovery.c
+++ b/board/st/stm32f469-discovery/stm32f469-discovery.c
@@ -8,13 +8,10 @@
 #include <env.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
=20
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 	int rv;
diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f74=
6-disco/stm32f746-disco.c
index 07bc8a5f0a2..4b1e443100d 100644
--- a/board/st/stm32f746-disco/stm32f746-disco.c
+++ b/board/st/stm32f746-disco/stm32f746-disco.c
@@ -15,7 +15,6 @@
 #include <spl.h>
 #include <splash.h>
 #include <video.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv7m.h>
 #include <asm/arch/stm32.h>
@@ -23,8 +22,6 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int dram_init(void)
 {
 #ifndef CONFIG_XPL_BUILD
diff --git a/board/st/stm32h743-disco/stm32h743-disco.c b/board/st/stm32h74=
3-disco/stm32h743-disco.c
index d00f55379c5..6c5c6710926 100644
--- a/board/st/stm32h743-disco/stm32h743-disco.c
+++ b/board/st/stm32h743-disco/stm32h743-disco.c
@@ -7,9 +7,6 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 int dram_init(void)
 {
diff --git a/board/st/stm32h743-eval/stm32h743-eval.c b/board/st/stm32h743-=
eval/stm32h743-eval.c
index d00f55379c5..6c5c6710926 100644
--- a/board/st/stm32h743-eval/stm32h743-eval.c
+++ b/board/st/stm32h743-eval/stm32h743-eval.c
@@ -7,9 +7,6 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 int dram_init(void)
 {
diff --git a/board/st/stm32h747-disco/stm32h747-disco.c b/board/st/stm32h74=
7-disco/stm32h747-disco.c
index 645685a64f1..24a229bf0a2 100644
--- a/board/st/stm32h747-disco/stm32h747-disco.c
+++ b/board/st/stm32h747-disco/stm32h747-disco.c
@@ -8,9 +8,6 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 int dram_init(void)
 {
diff --git a/board/st/stm32h750-art-pi/stm32h750-art-pi.c b/board/st/stm32h=
750-art-pi/stm32h750-art-pi.c
index 31c85c6816e..244bb5eefb3 100644
--- a/board/st/stm32h750-art-pi/stm32h750-art-pi.c
+++ b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
@@ -7,9 +7,6 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 int dram_init(void)
 {
diff --git a/board/technexion/pico-imx8mq/pico-imx8mq.c b/board/technexion/=
pico-imx8mq/pico-imx8mq.c
index 1659db112fa..5515fc09f99 100644
--- a/board/technexion/pico-imx8mq/pico-imx8mq.c
+++ b/board/technexion/pico-imx8mq/pico-imx8mq.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -24,8 +23,6 @@
 #include <spl.h>
 #include <power/pmic.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
=20
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 2e8336900d1..49e58ad6d6c 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -32,8 +32,6 @@
 #define board_is_am62x_lp_skevm()  board_ti_k3_is("AM62-LP-SKEVM")
 #define board_is_am62x_sip_skevm()  board_ti_k3_is("AM62SIP-SKEVM")
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
 static struct splash_location default_splash_locations[] =3D {
 	{
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 25076a8a588..764e3011bac 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -27,8 +27,6 @@
 #define board_is_am64x_skevm() (board_ti_k3_is("AM64-SKEVM") || \
 				board_ti_k3_is("AM64B-SKEVM"))
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct efi_fw_image fw_images[] =3D {
 	{
 		.image_type_id =3D AM64X_SK_TIBOOT3_IMAGE_GUID,
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index cabb3017ee1..8a4d40a5a95 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -14,8 +14,6 @@
 #include <asm/arch/k3-ddr.h>
 #include "../common/fdt_ops.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct efi_fw_image fw_images[] =3D {
 	{
 		.image_type_id =3D AM69_SK_TIBOOT3_IMAGE_GUID,
diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis=
-imx8/apalis-imx8.c
index a8c38208693..b915673d9e3 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -5,7 +5,6 @@
=20
 #include <cpu_func.h>
 #include <init.h>
-#include <asm/global_data.h>
=20
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8-pins.h>
@@ -24,8 +23,6 @@
=20
 #include "../common/tdx-cfg-block.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/toradex/apalis_t30/apalis_t30.c b/board/toradex/apalis_t=
30/apalis_t30.c
index 2c785da41ea..8dad41f4122 100644
--- a/board/toradex/apalis_t30/apalis_t30.c
+++ b/board/toradex/apalis_t30/apalis_t30.c
@@ -11,7 +11,6 @@
 #include <asm/arch/pinmux.h>
 #include <asm/arch-tegra/ap.h>
 #include <asm/arch-tegra/tegra.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <dm.h>
@@ -23,8 +22,6 @@
=20
 #include "pinmux-config-apalis_t30.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PMU_I2C_ADDRESS		0x2D
 #define MAX_I2C_RETRY		3
=20
diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/co=
libri-imx8x/colibri-imx8x.c
index 2a71e7b92de..0a86420700d 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -5,7 +5,6 @@
=20
 #include <cpu_func.h>
 #include <init.h>
-#include <asm/global_data.h>
=20
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8-pins.h>
@@ -21,8 +20,6 @@
=20
 #include "../common/tdx-cfg-block.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	((SC_PAD_CONFIG_OUT_IN << PADRING_CONFIG_SHIFT) | \
 			 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
 			 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
diff --git a/board/toradex/colibri_t20/colibri_t20.c b/board/toradex/colibr=
i_t20/colibri_t20.c
index 05c3377a60b..ccfe2c4933c 100644
--- a/board/toradex/colibri_t20/colibri_t20.c
+++ b/board/toradex/colibri_t20/colibri_t20.c
@@ -13,7 +13,6 @@
 #include <asm/arch-tegra/ap.h>
 #include <asm/arch-tegra/board.h>
 #include <asm/arch-tegra/tegra.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <i2c.h>
@@ -21,8 +20,6 @@
 #include <linux/delay.h>
 #include "../common/tdx-common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PMU_I2C_ADDRESS		0x34
 #define MAX_I2C_RETRY		3
 #define PMU_SUPPLYENE		0x14
diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/td=
x-cfg-block.c
index 0fc3759695f..e53530175ae 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -4,7 +4,6 @@
  */
=20
 #include <config.h>
-#include <asm/global_data.h>
 #include "tdx-cfg-block.h"
 #include "tdx-eeprom.h"
=20
@@ -22,8 +21,6 @@
 #include <nand.h>
 #include <asm/mach-types.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define TAG_VALID	0xcf01
 #define TAG_MAC		0x0000
 #define TAG_CAR_SERIAL	0x0021
diff --git a/board/toradex/smarc-imx8mp/smarc-imx8mp.c b/board/toradex/smar=
c-imx8mp/smarc-imx8mp.c
index 915b413b15e..38fb3d61f5b 100644
--- a/board/toradex/smarc-imx8mp/smarc-imx8mp.c
+++ b/board/toradex/smarc-imx8mp/smarc-imx8mp.c
@@ -2,14 +2,11 @@
 /* Copyright (C) 2024 Toradex */
=20
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm-generic/gpio.h>
 #include <linux/errno.h>
=20
 #include "../common/tdx-cfg-block.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_phys_sdram_size(phys_size_t *size)
 {
 	if (!size)
diff --git a/board/toradex/smarc-imx8mp/spl.c b/board/toradex/smarc-imx8mp/=
spl.c
index 32233c0e1ab..511f62e871b 100644
--- a/board/toradex/smarc-imx8mp/spl.c
+++ b/board/toradex/smarc-imx8mp/spl.c
@@ -8,7 +8,6 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <dm/device.h>
 #include <power/pmic.h>
@@ -16,8 +15,6 @@
=20
 #include "lpddr4_timing.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/toradex/verdin-imx8mm/spl.c b/board/toradex/verdin-imx8m=
m/spl.c
index 3c2d0ba1dd4..10b9991e3bf 100644
--- a/board/toradex/verdin-imx8mm/spl.c
+++ b/board/toradex/verdin-imx8mm/spl.c
@@ -11,7 +11,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mm_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/iomux-v3.h>
@@ -27,8 +26,6 @@
 #include <power/pmic.h>
 #include <spl.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define I2C_PMIC_BUS_ID        1
=20
 int spl_board_boot_device(enum boot_device boot_dev_spl)
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/ve=
rdin-imx8mm/verdin-imx8mm.c
index b4402415845..b56f5bf30a8 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <hang.h>
 #include <i2c.h>
@@ -17,8 +16,6 @@
=20
 #include "../common/tdx-cfg-block.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define I2C_PMIC	0
=20
 enum pcb_rev_t {
diff --git a/board/toradex/verdin-imx8mp/spl.c b/board/toradex/verdin-imx8m=
p/spl.c
index 8628112a782..b39058b1b5d 100644
--- a/board/toradex/verdin-imx8mp/spl.c
+++ b/board/toradex/verdin-imx8mp/spl.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
@@ -22,8 +21,6 @@
 #include <power/pca9450.h>
 #include "lpddr4_timing.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
diff --git a/board/toradex/verdin-imx8mp/verdin-imx8mp.c b/board/toradex/ve=
rdin-imx8mp/verdin-imx8mp.c
index 34ce25512e8..59b4607f065 100644
--- a/board/toradex/verdin-imx8mp/verdin-imx8mp.c
+++ b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
@@ -8,7 +8,6 @@
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm-generic/gpio.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <errno.h>
@@ -21,8 +20,6 @@
=20
 #include "../common/tdx-cfg-block.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
=20
 /* Verdin UART_3, Console/Debug UART */
diff --git a/board/xilinx/zynq/bootimg.c b/board/xilinx/zynq/bootimg.c
index 9eb0735f55d..52400672799 100644
--- a/board/xilinx/zynq/bootimg.c
+++ b/board/xilinx/zynq/bootimg.c
@@ -5,15 +5,12 @@
=20
 #include <log.h>
 #include <part.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <u-boot/md5.h>
 #include <zynq_bootimg.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define ZYNQ_IMAGE_PHDR_OFFSET		0x09C
 #define ZYNQ_IMAGE_FSBL_LEN_OFFSET	0x040
 #define ZYNQ_PART_HDR_CHKSUM_WORD_COUNT	0x0F
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index a9709465f6e..c841dd0d6d4 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -19,8 +19,6 @@
 #include <mapmem.h>
 #include <dm/uclass-internal.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int bootmeth_get_state_desc(struct udevice *dev, char *buf, int maxsize)
 {
 	const struct bootmeth_ops *ops =3D bootmeth_get_ops(dev);
diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 5822131767d..69c7c2e24c0 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -8,14 +8,11 @@
=20
 #include <dm.h>
 #include <fdt_support.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <video.h>
 #include <spl.h>
 #include <bloblist.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int fdt_simplefb_configure_node(void *blob, int off)
 {
 	int xsize, ysize;
diff --git a/boot/image-sig.c b/boot/image-sig.c
index 6bc74866eae..4eab017bc2d 100644
--- a/boot/image-sig.c
+++ b/boot/image-sig.c
@@ -5,8 +5,6 @@
=20
 #include <log.h>
 #include <malloc.h>
-#include <asm/global_data.h>
-DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
 #include <relocate.h>
 #include <u-boot/ecdsa.h>
diff --git a/boot/image.c b/boot/image.c
index dd96f712b6f..3f745254763 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -24,12 +24,9 @@
 #include <fdt_support.h>
 #endif
=20
-#include <asm/global_data.h>
 #include <linux/errno.h>
 #include <asm/io.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Set this if we have less than 4 MB of malloc() space */
 #if CONFIG_SYS_MALLOC_LEN < (4096 * 1024)
 #define CONSERVE_MEMORY		true
diff --git a/cmd/bloblist.c b/cmd/bloblist.c
index 333ae558142..318a1af0220 100644
--- a/cmd/bloblist.c
+++ b/cmd/bloblist.c
@@ -8,9 +8,6 @@
=20
 #include <bloblist.h>
 #include <command.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 static int do_bloblist_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index b8f5bb35950..85f41c3b0a0 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -17,11 +17,8 @@
 #include <mapmem.h>
 #include <vsprintf.h>
 #include <asm-generic/sections.h>
-#include <asm/global_data.h>
 #include <linux/string.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct efi_device_path *test_image_path;
 static struct efi_device_path *test_device_path;
=20
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 2c5aea26d98..ca7cec91fad 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -15,14 +15,11 @@
 #include <malloc.h>
 #include <nand.h>
 #include <asm/byteorder.h>
-#include <asm/global_data.h>
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <u-boot/zlib.h>
 #include <mapmem.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if defined(CONFIG_CMD_IMI)
 static int image_info(unsigned long addr);
 #endif
diff --git a/cmd/date.c b/cmd/date.c
index 8614f022761..d047872289c 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -11,9 +11,6 @@
 #include <dm.h>
 #include <rtc.h>
 #include <i2c.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 static const char * const weekdays[] =3D {
 	"Sun", "Mon", "Tues", "Wednes", "Thurs", "Fri", "Satur",
diff --git a/cmd/mem.c b/cmd/mem.c
index 8690fc1e4e6..68eb6989b94 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -28,15 +28,12 @@
 #include <time.h>
 #include <vsprintf.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Create a compile-time value */
 #if MEM_SUPPORT_64BIT_DATA
 #define HELP_Q ", .q"
diff --git a/cmd/sound.c b/cmd/sound.c
index 8f67cbd96e1..7546059022f 100644
--- a/cmd/sound.c
+++ b/cmd/sound.c
@@ -8,9 +8,6 @@
 #include <dm.h>
 #include <fdtdec.h>
 #include <sound.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 /* Initilaise sound subsystem */
 static int do_init(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/spl.c b/cmd/spl.c
index f591dc07fb6..ddbbd4a8172 100644
--- a/cmd/spl.c
+++ b/cmd/spl.c
@@ -9,11 +9,8 @@
 #include <env.h>
 #include <image.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static const char **subcmd_list[] =3D {
=20
 	[SPL_EXPORT_FDT] =3D (const char * []) {
diff --git a/common/cli_hush.c b/common/cli_hush.c
index fb087960c92..fe8fe93bd54 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -84,7 +84,6 @@
 #include <cli_hush.h>
 #include <command.h>        /* find_cmd */
 #include <vsprintf.h>
-#include <asm/global_data.h>
 #endif
 #ifndef __U_BOOT__
 #include <ctype.h>     /* isalpha, isdigit */
@@ -125,8 +124,6 @@
 #endif
=20
 #ifdef __U_BOOT__
-DECLARE_GLOBAL_DATA_PTR;
-
 #define EXIT_SUCCESS 0
 #define EOF -1
 #define syntax() syntax_err()
diff --git a/common/stdio.c b/common/stdio.c
index 3eeb289dd8b..fc965944209 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -18,11 +18,8 @@
 #include <serial.h>
 #include <splash.h>
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct stdio_dev devs;
 struct stdio_dev *stdio_devices[] =3D { NULL, NULL, NULL };
 char *stdio_names[MAX_FILES] =3D { "stdin", "stdout", "stderr" };
diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
index 9cb27561a97..4b3de0529ce 100644
--- a/drivers/block/sandbox.c
+++ b/drivers/block/sandbox.c
@@ -10,13 +10,10 @@
 #include <os.h>
 #include <malloc.h>
 #include <sandbox_host.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <linux/errno.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static unsigned long host_block_read(struct udevice *dev,
 				     lbaint_t start, lbaint_t blkcnt,
 				     void *buffer)
diff --git a/drivers/bootcount/pmic_pfuze100.c b/drivers/bootcount/pmic_pfu=
ze100.c
index 8c529f5592b..dd11344322b 100644
--- a/drivers/bootcount/pmic_pfuze100.c
+++ b/drivers/bootcount/pmic_pfuze100.c
@@ -13,8 +13,6 @@
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PFUZE_BC_MAGIC 0xdead
=20
 struct bootcount_pmic_priv {
diff --git a/drivers/cache/sandbox_cache.c b/drivers/cache/sandbox_cache.c
index 375892fafb0..b27960f1bfa 100644
--- a/drivers/cache/sandbox_cache.c
+++ b/drivers/cache/sandbox_cache.c
@@ -6,9 +6,6 @@
 #include <cache.h>
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 static int sandbox_get_info(struct udevice *dev, struct cache_info *info)
 {
diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agile=
x.c
index fdbf834bb2f..9d49561512b 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -6,7 +6,6 @@
=20
 #include <log.h>
 #include <wait_bit.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <clk-uclass.h>
@@ -19,8 +18,6 @@
=20
 #include <asm/arch/clock_manager.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct socfpga_clk_plat {
 	void __iomem *regs;
 	int pllgrp;
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agil=
ex5.c
index fb1e72ffc5c..92b91a9dfc8 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -12,7 +12,6 @@
 #include <stdio.h>
 #include <time.h>
 #include <vsprintf.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <dm/lists.h>
@@ -26,8 +25,6 @@
 #include <wait_bit.h>
 #include <clk-uclass.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define CLKMGR_CTRL_SWCTRLBTCLKEN_MASK		BIT(8)
 #define CLKMGR_CTRL_SWCTRLBTCLKSEL_MASK		BIT(9)
=20
diff --git a/drivers/clk/altera/clk-mem-n5x.c b/drivers/clk/altera/clk-mem-=
n5x.c
index b75f52d203b..ac59571a853 100644
--- a/drivers/clk/altera/clk-mem-n5x.c
+++ b/drivers/clk/altera/clk-mem-n5x.c
@@ -4,7 +4,6 @@
  */
=20
 #include <asm/arch/clock_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include "clk-mem-n5x.h"
 #include <clk-uclass.h>
@@ -13,8 +12,6 @@
 #include <dm/util.h>
 #include <dt-bindings/clock/n5x-clock.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct socfpga_mem_clk_plat {
 	void __iomem *regs;
 };
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 9e4e7a1d908..185c9028a78 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -4,7 +4,6 @@
  */
=20
 #include <asm/arch/clock_manager.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <clk-uclass.h>
 #include <dm.h>
@@ -12,8 +11,6 @@
 #include <dm/util.h>
 #include <dt-bindings/clock/n5x-clock.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct socfpga_clk_plat {
 	void __iomem *regs;
 };
diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px3=
0.c
index b5054e84c32..d143a6b85ee 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -13,15 +13,12 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_px30.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/px30-cru.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	VCO_MAX_HZ	=3D 3200U * 1000000,
 	VCO_MIN_HZ	=3D 800 * 1000000,
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_r=
k3308.c
index e73bb6790af..97043b8693c 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3308.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -19,8 +18,6 @@
 #include <dt-bindings/clock/rk3308-cru.h>
 #include <linux/bitops.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	VCO_MAX_HZ	=3D 3200U * 1000000,
 	VCO_MIN_HZ	=3D 800 * 1000000,
diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_r=
k3528.c
index d58557ff56d..bcdc0f930d2 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -17,8 +17,6 @@
 #include <dt-bindings/clock/rockchip,rk3528-cru.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
=20
 /*
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_r=
k3568.c
index 533031caead..bb49af358e6 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -16,8 +16,6 @@
 #include <dm/lists.h>
 #include <dt-bindings/clock/rk3568-cru.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 struct rk3568_clk_plat {
 	struct dtd_rockchip_rk3568_cru dtd;
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_r=
k3576.c
index 125b08ee832..1026af27ca1 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -17,8 +17,6 @@
 #include <dt-bindings/clock/rockchip,rk3576-cru.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
=20
 static struct rockchip_pll_rate_table rk3576_24m_pll_rates[] =3D {
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_r=
k3588.c
index 8c3a113526f..be401a9faee 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -17,8 +17,6 @@
 #include <dm/lists.h>
 #include <dt-bindings/clock/rockchip,rk3588-cru.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
=20
 static struct rockchip_pll_rate_table rk3588_pll_rates[] =3D {
diff --git a/drivers/clk/rockchip/clk_rv1108.c b/drivers/clk/rockchip/clk_r=
v1108.c
index 75202a66aa6..e1b9ccf1236 100644
--- a/drivers/clk/rockchip/clk_rv1108.c
+++ b/drivers/clk/rockchip/clk_rv1108.c
@@ -11,7 +11,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rv1108.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -21,8 +20,6 @@
 #include <linux/delay.h>
 #include <linux/stringify.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	VCO_MAX_HZ	=3D 2400U * 1000000,
 	VCO_MIN_HZ	=3D 600 * 1000000,
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_r=
v1126.c
index aeeea956914..39920d34b75 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -18,8 +18,6 @@
 #include <dm/lists.h>
 #include <dt-bindings/clock/rockchip,rv1126-cru.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define RV1126_CPUCLK_RATE(_rate, _aclk_div, _pclk_div)		\
 {								\
 	.rate	=3D _rate##U,					\
diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
index 59a7b142c95..ad638cd8fff 100644
--- a/drivers/cpu/bcm283x_cpu.c
+++ b/drivers/cpu/bcm283x_cpu.c
@@ -11,7 +11,6 @@
 #include <asm/armv8/cpu.h>
 #include <asm/cache.h>
 #include <asm/io.h>
-#include <asm/global_data.h>
 #include <asm/system.h>
 #include <asm-generic/sections.h>
 #include <linux/bitops.h>
@@ -19,8 +18,6 @@
 #include <linux/delay.h>
 #include "armv8_cpu.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct bcm_plat {
 	u64 release_addr;
 };
diff --git a/drivers/cpu/cpu-uclass.c b/drivers/cpu/cpu-uclass.c
index 2c8e46c05e3..b73768de918 100644
--- a/drivers/cpu/cpu-uclass.c
+++ b/drivers/cpu/cpu-uclass.c
@@ -15,8 +15,6 @@
 #include <linux/err.h>
 #include <relocate.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int cpu_probe_all(void)
 {
 	int ret =3D uclass_probe_all(UCLASS_CPU);
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 5f17122c36c..3cd00199548 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -6,7 +6,6 @@
 #include <cpu.h>
 #include <dm.h>
 #include <thermal.h>
-#include <asm/global_data.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <firmware/imx/sci/sci.h>
@@ -18,8 +17,6 @@
 #include <linux/clk-provider.h>
 #include <linux/psci.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define IMX_REV_LEN	4
 struct cpu_imx_plat {
 	const char *name;
diff --git a/drivers/cpu/mtk_cpu.c b/drivers/cpu/mtk_cpu.c
index 2a08be9b6d1..4f4e5480eac 100644
--- a/drivers/cpu/mtk_cpu.c
+++ b/drivers/cpu/mtk_cpu.c
@@ -10,12 +10,9 @@
 #include <dm.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <linux/err.h>
 #include <linux/io.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct mtk_cpu_plat {
 	struct regmap *hwver;
 };
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/a=
rm-ffa/arm-ffa-uclass.c
index 96c64964bb7..76a8775e911 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -12,15 +12,12 @@
 #include <malloc.h>
 #include <string.h>
 #include <u-boot/uuid.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/root.h>
 #include <linux/errno.h>
 #include <linux/sizes.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Error mapping declarations */
=20
 int ffa_to_std_errmap[MAX_NUMBER_FFA_ERR] =3D {
diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/=
arm-ffa.c
index 94e6105cb38..9e6b5dcc542 100644
--- a/drivers/firmware/arm-ffa/arm-ffa.c
+++ b/drivers/firmware/arm-ffa/arm-ffa.c
@@ -10,12 +10,9 @@
 #include <arm_ffa_priv.h>
 #include <dm.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <linux/errno.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * invoke_ffa_fn() - SMC wrapper
  * @args: FF-A ABI arguments to be copied to Xn registers
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/=
arm-ffa/ffa-emul-uclass.c
index 1521d9b66ac..6198d687354 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -8,7 +8,6 @@
 #include <dm.h>
 #include <mapmem.h>
 #include <string.h>
-#include <asm/global_data.h>
 #include <asm/sandbox_arm_ffa.h>
 #include <asm/sandbox_arm_ffa_priv.h>
 #include <dm/device-internal.h>
@@ -17,8 +16,6 @@
 #include <linux/errno.h>
 #include <linux/sizes.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* The partitions (SPs) table */
 static struct ffa_partition_desc sandbox_partitions[SANDBOX_PARTITIONS_CNT=
] =3D {
 	{
diff --git a/drivers/firmware/arm-ffa/sandbox_ffa.c b/drivers/firmware/arm-=
ffa/sandbox_ffa.c
index 44b32a829dd..f1e8de4bf0d 100644
--- a/drivers/firmware/arm-ffa/sandbox_ffa.c
+++ b/drivers/firmware/arm-ffa/sandbox_ffa.c
@@ -8,13 +8,10 @@
 #include <arm_ffa.h>
 #include <dm.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/sandbox_arm_ffa_priv.h>
 #include <dm/device-internal.h>
 #include <linux/errno.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * sandbox_ffa_discover() - perform sandbox FF-A discovery
  * @dev: The sandbox FF-A bus device
diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 38151ef1bee..7651d5360d6 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -18,15 +18,12 @@
 #include <fdtdec.h>
 #include <malloc.h>
 #include <acpi/acpi_device.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define GPIO_ALLOC_BITS	32
=20
 /**
diff --git a/drivers/gpio/nx_gpio.c b/drivers/gpio/nx_gpio.c
index 741b2ff7f17..5abbb34daea 100644
--- a/drivers/gpio/nx_gpio.c
+++ b/drivers/gpio/nx_gpio.c
@@ -7,12 +7,9 @@
 #include <dm.h>
 #include <errno.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct nx_gpio_regs {
 	u32	data;		/* Data register */
 	u32	outputenb;	/* Output Enable register */
diff --git a/drivers/i2c/mxc_i2c.c b/drivers/i2c/mxc_i2c.c
index 2dfc1c4eab5..268bb39f009 100644
--- a/drivers/i2c/mxc_i2c.c
+++ b/drivers/i2c/mxc_i2c.c
@@ -18,7 +18,6 @@
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -30,8 +29,6 @@
 #include <dm.h>
 #include <dm/pinctrl.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define I2C_QUIRK_FLAG		(1 << 0)
=20
 #define IMX_I2C_REGSHIFT	2
diff --git a/drivers/i2c/nx_i2c.c b/drivers/i2c/nx_i2c.c
index 8562dd82bd6..706b7adefe8 100644
--- a/drivers/i2c/nx_i2c.c
+++ b/drivers/i2c/nx_i2c.c
@@ -7,7 +7,6 @@
 #include <asm/arch/reset.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/nx_gpio.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
=20
 #define I2C_WRITE       0
@@ -45,8 +44,6 @@
=20
 #define DEFAULT_SPEED   100000  /* default I2C speed [Hz] */
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct nx_i2c_regs {
 	uint     iiccon;
 	uint     iicstat;
diff --git a/drivers/i2c/ocores_i2c.c b/drivers/i2c/ocores_i2c.c
index cf714d22ee4..32704ee8854 100644
--- a/drivers/i2c/ocores_i2c.c
+++ b/drivers/i2c/ocores_i2c.c
@@ -12,7 +12,6 @@
  * Andreas Larsson <andreas@gaisler.com>
  */
=20
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
@@ -75,8 +74,6 @@ struct ocores_i2c_bus {
 	u8 (*getreg)(struct ocores_i2c_bus *i2c, int reg);
 };
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Boolean attribute values */
 enum {
 	FALSE =3D 0,
diff --git a/drivers/i2c/soft_i2c.c b/drivers/i2c/soft_i2c.c
index 79f7a320502..4102375e5b7 100644
--- a/drivers/i2c/soft_i2c.c
+++ b/drivers/i2c/soft_i2c.c
@@ -25,7 +25,6 @@
 #endif
 #endif
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
=20
 #if defined(CONFIG_SOFT_I2C_GPIO_SCL)
@@ -82,8 +81,6 @@
=20
 /* #define	DEBUG_I2C	*/
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifndef	I2C_SOFT_DECLARATIONS
 #  define I2C_SOFT_DECLARATIONS
 #endif
diff --git a/drivers/i2c/synquacer_i2c.c b/drivers/i2c/synquacer_i2c.c
index 6672d9435e3..6e5722327c5 100644
--- a/drivers/i2c/synquacer_i2c.c
+++ b/drivers/i2c/synquacer_i2c.c
@@ -112,8 +112,6 @@
 #define SPEED_FM		400	// Fast Mode
 #define SPEED_SM		100	// Standard Mode
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct synquacer_i2c {
 	void __iomem *base;
 	unsigned long pclkrate;
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index b1e0465e7a8..c7eaa3de96f 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -15,8 +15,6 @@
 /* This driver only exposes the status bits to keep with the
  * polling methodology of u-boot.
  */
-DECLARE_GLOBAL_DATA_PTR;
-
 #define IMX_MU_CHANS		24
=20
 #define IMX_MU_V2_PAR_OFF	0x4
diff --git a/drivers/misc/atsha204a-i2c.c b/drivers/misc/atsha204a-i2c.c
index 3b9046da880..aa3094fcc01 100644
--- a/drivers/misc/atsha204a-i2c.c
+++ b/drivers/misc/atsha204a-i2c.c
@@ -15,7 +15,6 @@
 #include <errno.h>
 #include <atsha204a-i2c.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/bitrev.h>
 #include <u-boot/crc.h>
@@ -25,8 +24,6 @@
 #define ATSHA204A_TRANSACTION_RETRY	5
 #define ATSHA204A_EXECTIME		5000
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static inline u16 atsha204a_crc16(const u8 *buffer, size_t len)
 {
 	return bitrev16(crc16(0, buffer, len));
diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 2928cf75f89..6af4c7f15e7 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -13,7 +13,6 @@
 #include <fs.h>
 #include <fs_loader.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/root.h>
 #include <linux/string.h>
@@ -25,8 +24,6 @@
 #include <ubi_uboot.h>
 #endif
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct firmware - A place for storing firmware and its attribute data.
  *
diff --git a/drivers/misc/imx8/fuse.c b/drivers/misc/imx8/fuse.c
index 90d251a4405..872713e30b6 100644
--- a/drivers/misc/imx8/fuse.c
+++ b/drivers/misc/imx8/fuse.c
@@ -8,11 +8,8 @@
 #include <fuse.h>
 #include <firmware/imx/sci/sci.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <linux/arm-smccc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define FSL_ECC_WORD_START_1	 0x10
 #define FSL_ECC_WORD_END_1	 0x10F
=20
diff --git a/drivers/mmc/ca_dw_mmc.c b/drivers/mmc/ca_dw_mmc.c
index 1af5ec0532e..d5a4453a62e 100644
--- a/drivers/mmc/ca_dw_mmc.c
+++ b/drivers/mmc/ca_dw_mmc.c
@@ -6,7 +6,6 @@
=20
 #include <dwmmc.h>
 #include <fdtdec.h>
-#include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <malloc.h>
 #include <errno.h>
@@ -26,8 +25,6 @@
=20
 #define MIN_FREQ (400000)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct ca_mmc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
diff --git a/drivers/mmc/f_sdh30.c b/drivers/mmc/f_sdh30.c
index f47cf848521..f0356e1e960 100644
--- a/drivers/mmc/f_sdh30.c
+++ b/drivers/mmc/f_sdh30.c
@@ -29,8 +29,6 @@ struct f_sdh30_plat {
 	const struct f_sdh30_data *data;
 };
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void f_sdh30_e51_init(struct udevice *dev)
 {
 	struct f_sdh30_plat *plat =3D dev_get_plat(dev);
diff --git a/drivers/mmc/jz_mmc.c b/drivers/mmc/jz_mmc.c
index fc10bb256a4..651d9868305 100644
--- a/drivers/mmc/jz_mmc.c
+++ b/drivers/mmc/jz_mmc.c
@@ -8,7 +8,6 @@
=20
 #include <malloc.h>
 #include <mmc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/unaligned.h>
 #include <errno.h>
@@ -419,8 +418,6 @@ int jz_mmc_init(void __iomem *base)
 #else /* CONFIG_DM_MMC */
=20
 #include <dm.h>
-DECLARE_GLOBAL_DATA_PTR;
-
 static int jz_mmc_dm_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 			      struct mmc_data *data)
 {
diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 38dc36a2194..66f3cf2de4f 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -13,7 +13,6 @@
 #include <reset.h>
 #include <sdhci.h>
 #include <wait_bit.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <power/regulator.h>
@@ -61,8 +60,6 @@ struct msm_sdhc_variant_info {
 	u32 core_vendor_spec_capabilities0;
 };
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int msm_sdc_clk_init(struct udevice *dev)
 {
 	struct msm_sdhc *prv =3D dev_get_priv(dev);
diff --git a/drivers/mmc/mv_sdhci.c b/drivers/mmc/mv_sdhci.c
index 2da5334c21f..a8b63a20387 100644
--- a/drivers/mmc/mv_sdhci.c
+++ b/drivers/mmc/mv_sdhci.c
@@ -6,7 +6,6 @@
 #include <dm.h>
 #include <malloc.h>
 #include <sdhci.h>
-#include <asm/global_data.h>
 #include <linux/mbus.h>
=20
 #define MVSDH_NAME "mv_sdh"
@@ -14,8 +13,6 @@
 #define SDHCI_WINDOW_CTRL(win)		(0x4080 + ((win) << 4))
 #define SDHCI_WINDOW_BASE(win)		(0x4084 + ((win) << 4))
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct mv_sdhci_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3=
xx_nand.c
index 7bf54fa4654..7324dc72e0a 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -9,7 +9,6 @@
 #include <malloc.h>
 #include <fdtdec.h>
 #include <nand.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
@@ -30,8 +29,6 @@
=20
 #include "pxa3xx_nand.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define TIMEOUT_DRAIN_FIFO	5	/* in ms */
 #define	CHIP_DELAY_TIMEOUT	200
 #define NAND_STOP_DELAY		40
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra=
_nand.c
index ef43dcad079..0bee7eace90 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -7,7 +7,6 @@
  */
=20
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
@@ -26,8 +25,6 @@
 #include <linux/printk.h>
 #include "tegra_nand.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define NAND_CMD_TIMEOUT_MS		10
=20
 #define SKIPPED_SPARE_BYTES		4
diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_q=
spi.c
index 1a109bee557..383971bea66 100644
--- a/drivers/mtd/nvmxip/nvmxip_qspi.c
+++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
@@ -11,9 +11,6 @@
 #include <nvmxip.h>
 #include <linux/errno.h>
=20
-#include <asm/global_data.h>
-DECLARE_GLOBAL_DATA_PTR;
-
 #define NVMXIP_QSPI_DRV_NAME "nvmxip_qspi"
=20
 /**
diff --git a/drivers/mtd/spi/sf-uclass.c b/drivers/mtd/spi/sf-uclass.c
index 102a9236826..a9db5296b2d 100644
--- a/drivers/mtd/spi/sf-uclass.c
+++ b/drivers/mtd/spi/sf-uclass.c
@@ -11,13 +11,10 @@
 #include <malloc.h>
 #include <spi.h>
 #include <spi_flash.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <test/test.h>
 #include "sf_internal.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int spi_flash_read_dm(struct udevice *dev, u32 offset, size_t len, void *b=
uf)
 {
 	return log_ret(sf_get_ops(dev)->read(dev, offset, len, buf));
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index 969d247b4f3..76daab961c0 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -5,7 +5,6 @@
  * Actions DWMAC specific glue layer
  */
=20
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <clk.h>
@@ -24,8 +23,6 @@
 #define RMII_REF_CLK_MFP_CTL0		(0x0 << 6)
 #define CLKO_25M_EN_MFP_CTL3		BIT(30)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void dwmac_board_setup(void)
 {
 	clrbits_le32(MFP_CTL0, (RMII_TXD01_MFP_CTL0 | RMII_RXD01_MFP_CTL0 |
diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index fee9973c4dc..ba105dd2825 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -18,7 +18,6 @@
 #include <net.h>
 #include <netdev.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
=20
@@ -36,8 +35,6 @@
 #include "fec_mxc.h"
 #include <eth_phy.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * Timeout the transfer after 5 mS. This is usually a bit more, since
  * the code in the tightloops this timeout is used in adds some overhead.
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index c8cfe7448d4..2b6080dd9ee 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -11,7 +11,6 @@
 #include <net.h>
 #include <phy.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/arch-rockchip/periph.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -28,7 +27,6 @@
 #include <linux/bitops.h>
 #include "designware.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
 #define DELAY_ENABLE(soc, tx, rx) \
 	(((tx) ? soc##_TXCLK_DLY_ENA_GMAC_ENABLE : soc##_TXCLK_DLY_ENA_GMAC_DISAB=
LE) | \
 	((rx) ? soc##_RXCLK_DLY_ENA_GMAC_ENABLE : soc##_RXCLK_DLY_ENA_GMAC_DISABL=
E))
diff --git a/drivers/net/mvneta.c b/drivers/net/mvneta.c
index 1640868c24a..baa18202d6e 100644
--- a/drivers/net/mvneta.c
+++ b/drivers/net/mvneta.c
@@ -20,7 +20,6 @@
 #include <config.h>
 #include <malloc.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
@@ -37,8 +36,6 @@
 #include <linux/mbus.h>
 #include <asm-generic/gpio.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define MVNETA_NR_CPUS		1
 #define ETH_HLEN		14	/* Total octets in header */
=20
diff --git a/drivers/net/octeontx/smi.c b/drivers/net/octeontx/smi.c
index 217bcac2ce2..5a822b64427 100644
--- a/drivers/net/octeontx/smi.c
+++ b/drivers/net/octeontx/smi.c
@@ -10,15 +10,12 @@
 #include <pci.h>
 #include <pci_ids.h>
 #include <phy.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
=20
 #define PCI_DEVICE_ID_OCTEONTX_SMI 0xA02B
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 enum octeontx_smi_mode {
 	CLAUSE22 =3D 0,
 	CLAUSE45 =3D 1,
diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
index 11d36164976..4ab709a14d5 100644
--- a/drivers/net/phy/fixed.c
+++ b/drivers/net/phy/fixed.c
@@ -10,9 +10,6 @@
 #include <phy.h>
 #include <dm.h>
 #include <fdt_support.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 static int fixedphy_probe(struct phy_device *phydev)
 {
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b58283fe3d5..d7e0c4fe02d 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -17,7 +17,6 @@
 #include <miiphy.h>
 #include <phy.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
 #include <dm/of_extra.h>
@@ -26,8 +25,6 @@
 #include <linux/err.h>
 #include <linux/compiler.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Generic PHY support and helper functions */
=20
 /**
diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_g=
mii2rgmii.c
index e44b7b75bd5..f5a7dd349c9 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -8,9 +8,6 @@
 #include <dm.h>
 #include <log.h>
 #include <phy.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 #define ZYNQ_GMII2RGMII_REG		0x10
 #define ZYNQ_GMII2RGMII_SPEED_MASK	(BMCR_SPEED1000 | BMCR_SPEED100)
diff --git a/drivers/net/sandbox-raw.c b/drivers/net/sandbox-raw.c
index 1d716716778..c3d40f0b59e 100644
--- a/drivers/net/sandbox-raw.c
+++ b/drivers/net/sandbox-raw.c
@@ -12,9 +12,6 @@
 #include <env.h>
 #include <malloc.h>
 #include <net.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 static int reply_arp;
 static struct in_addr arp_ip;
diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index 2011fd31f41..0ea50c484c0 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/eth.h>
-#include <asm/global_data.h>
 #include <asm/test.h>
 #include <asm/types.h>
=20
@@ -84,8 +83,6 @@ struct icmphdr {
 #define ICMP_ECHO_REPLY		0
 #define IPPROTO_ICMP		1
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static const u8 null_ethaddr[6];
 static bool skip_timeout;
=20
diff --git a/drivers/net/ti/keystone_net.c b/drivers/net/ti/keystone_net.c
index d4abc9a0411..40c98e72e4d 100644
--- a/drivers/net/ti/keystone_net.c
+++ b/drivers/net/ti/keystone_net.c
@@ -7,7 +7,6 @@
  */
 #include <command.h>
 #include <console.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
=20
@@ -26,8 +25,6 @@
=20
 #include "cpsw_mdio.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifdef KEYSTONE2_EMAC_GIG_ENABLE
 #define emac_gigabit_enable(x)	keystone2_eth_gigabit_enable(x)
 #else
diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index fb48feb4469..e9cc5db52d2 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -15,7 +15,6 @@
 #include <log.h>
 #include <net.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <phy.h>
 #include <miiphy.h>
@@ -23,8 +22,6 @@
 #include <linux/delay.h>
 #include <eth_phy.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Link setup */
 #define XAE_EMMC_LINKSPEED_MASK	0xC0000000 /* Link speed */
 #define XAE_EMMC_LINKSPD_10	0x00000000 /* Link Speed mask for 10 Mbit */
diff --git a/drivers/pci/pci_octeontx.c b/drivers/pci/pci_octeontx.c
index 875cf7f7115..6752112a878 100644
--- a/drivers/pci/pci_octeontx.c
+++ b/drivers/pci/pci_octeontx.c
@@ -11,14 +11,11 @@
 #include <log.h>
 #include <malloc.h>
 #include <pci.h>
-#include <asm/global_data.h>
=20
 #include <asm/io.h>
=20
 #include <linux/ioport.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * This driver supports multiple types of operations / host bridges / buss=
es:
  *
diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
index 483b07ce078..1eff6d1b0ed 100644
--- a/drivers/pci/pcie_dw_meson.c
+++ b/drivers/pci/pcie_dw_meson.c
@@ -16,7 +16,6 @@
 #include <power-domain.h>
 #include <reset.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -27,8 +26,6 @@
=20
 #include "pcie_dw_common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct meson_pcie - Amlogic Meson DW PCIe controller state
  *
diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index 978754e8472..10c45aaba20 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -10,7 +10,6 @@
 #include <syscon.h>
 #include <malloc.h>
 #include <power/regulator.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -21,8 +20,6 @@
=20
 #include "pcie_dw_common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct qcom_pcie;
=20
 struct qcom_pcie_ops {
diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.=
c
index 208aa30463a..61117fa95e6 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -13,7 +13,6 @@
 #include <reset.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -24,8 +23,6 @@
=20
 #include "pcie_dw_common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct rk_pcie - RK DW PCIe controller state
  *
diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index dc6e65273b7..37c295fdd38 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -10,7 +10,6 @@
 #include <power-domain.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -20,8 +19,6 @@
=20
 #include "pcie_dw_common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PCIE_VENDORID_MASK	GENMASK(15, 0)
 #define PCIE_DEVICEID_SHIFT	16
=20
diff --git a/drivers/pci/pcie_layerscape.c b/drivers/pci/pcie_layerscape.c
index 1be33095b9c..db7c4f47916 100644
--- a/drivers/pci/pcie_layerscape.c
+++ b/drivers/pci/pcie_layerscape.c
@@ -6,7 +6,6 @@
  */
=20
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <malloc.h>
@@ -16,8 +15,6 @@
 #endif
 #include "pcie_layerscape.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 LIST_HEAD(ls_pcie_list);
=20
 unsigned int dbi_readl(struct ls_pcie *pcie, unsigned int offset)
diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive=
_jh7110.c
index 0908ae16b67..761e64be58a 100644
--- a/drivers/pci/pcie_starfive_jh7110.c
+++ b/drivers/pci/pcie_starfive_jh7110.c
@@ -15,7 +15,6 @@
 #include <regmap.h>
 #include <reset.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
@@ -39,8 +38,6 @@
 #define STG_SYSCON_RP_NEP_OFFSET               0xe8
 #define STG_SYSCON_K_RP_NEP_MASK               BIT(8)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct starfive_pcie {
 	struct pcie_plda plda;
 	struct clk_bulk	clks;
diff --git a/drivers/pci_endpoint/pci_ep-uclass.c b/drivers/pci_endpoint/pc=
i_ep-uclass.c
index 902d1a51eaa..b71defe4019 100644
--- a/drivers/pci_endpoint/pci_ep-uclass.c
+++ b/drivers/pci_endpoint/pci_ep-uclass.c
@@ -13,12 +13,9 @@
=20
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <linux/log2.h>
 #include <pci_ep.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int pci_ep_write_header(struct udevice *dev, uint fn, struct pci_ep_header=
 *hdr)
 {
 	struct pci_ep_ops *ops =3D pci_ep_get_ops(dev);
diff --git a/drivers/phy/marvell/comphy_core.c b/drivers/phy/marvell/comphy=
_core.c
index a4121423873..b074d58f9f6 100644
--- a/drivers/phy/marvell/comphy_core.c
+++ b/drivers/phy/marvell/comphy_core.c
@@ -7,7 +7,6 @@
=20
 #include <dm.h>
 #include <fdtdec.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/err.h>
@@ -18,8 +17,6 @@
=20
 #define COMPHY_MAX_CHIP 4
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static const char *get_speed_string(u32 speed)
 {
 	static const char * const speed_strings[] =3D {
diff --git a/drivers/phy/omap-usb2-phy.c b/drivers/phy/omap-usb2-phy.c
index 2be0178882a..6df4ff4eb05 100644
--- a/drivers/phy/omap-usb2-phy.c
+++ b/drivers/phy/omap-usb2-phy.c
@@ -6,7 +6,6 @@
  * Written by Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
=20
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <errno.h>
@@ -39,8 +38,6 @@
 #define USB2PHY_USE_CHG_DET_REG		BIT(29)
 #define USB2PHY_DIS_CHG_DET		BIT(28)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct omap_usb2_phy {
 	struct regmap *pwr_regmap;
 	ulong flags;
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchi=
p/phy-rockchip-pcie.c
index 660037034ec..5775101c4cb 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -9,7 +9,6 @@
=20
 #include <clk.h>
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <generic-phy.h>
 #include <reset.h>
@@ -19,8 +18,6 @@
 #include <linux/iopoll.h>
 #include <asm/arch-rockchip/clock.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * The higher 16-bit of this register is used for write protection
  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockch=
ip/phy-rockchip-typec.c
index 66d1d32d25c..305d5b0dd48 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -10,7 +10,6 @@
=20
 #include <clk.h>
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <generic-phy.h>
@@ -21,8 +20,6 @@
 #include <linux/iopoll.h>
 #include <asm/arch-rockchip/clock.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define usleep_range(a, b) udelay((b))
=20
 #define CMN_SSM_BANDGAP			(0x21 << 2)
diff --git a/drivers/pinctrl/mtmips/pinctrl-mt7628.c b/drivers/pinctrl/mtmi=
ps/pinctrl-mt7628.c
index dc7acec4a77..be3a28eb94d 100644
--- a/drivers/pinctrl/mtmips/pinctrl-mt7628.c
+++ b/drivers/pinctrl/mtmips/pinctrl-mt7628.c
@@ -6,15 +6,12 @@
  */
=20
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
=20
 #include "pinctrl-mtmips-common.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define AGPIO_OFS			0
 #define GPIOMODE1_OFS			0x24
 #define GPIOMODE2_OFS			0x28
diff --git a/drivers/pinctrl/nexell/pinctrl-nexell.c b/drivers/pinctrl/nexe=
ll/pinctrl-nexell.c
index d5be7baf50d..af1acd91649 100644
--- a/drivers/pinctrl/nexell/pinctrl-nexell.c
+++ b/drivers/pinctrl/nexell/pinctrl-nexell.c
@@ -7,13 +7,10 @@
=20
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include "pinctrl-nexell.h"
 #include "pinctrl-s5pxx18.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* given a pin-name, return the address of pin config registers */
 unsigned long pin_to_bank_base(struct udevice *dev, const char *pin_name,
 			       u32 *pin)
diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/pinctrl/nex=
ell/pinctrl-s5pxx18.c
index a6ae5764fbc..aeed3f1e1e1 100644
--- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
+++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
@@ -9,15 +9,12 @@
=20
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/pinctrl.h>
 #include <dm/root.h>
 #include "pinctrl-nexell.h"
 #include "pinctrl-s5pxx18.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static void nx_gpio_set_bit(u32 *value, u32 bit, int enable)
 {
 	register u32 newvalue;
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-mmio.c b/drivers/pinctrl/nxp/p=
inctrl-imx-mmio.c
index 2f4228a9fc5..7cdbbbba747 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
@@ -5,7 +5,6 @@
=20
 #include <malloc.h>
 #include <mapmem.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
@@ -16,8 +15,6 @@
=20
 #include "pinctrl-imx.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config=
)
 {
 	struct imx_pinctrl_priv *priv =3D dev_get_priv(dev);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctr=
l-imx.c
index 7d91ccfb26f..d8011768581 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -5,7 +5,6 @@
=20
 #include <malloc.h>
 #include <mapmem.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
@@ -16,8 +15,6 @@
=20
 #include "pinctrl-imx.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int imx_pinctrl_set_state_common(struct udevice *dev, struct udevice *conf=
ig,
 				 int pin_size, u32 **pin_data, int *npins)
 {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinct=
rl-imx8.c
index 9b3b5aec07a..23865ee6428 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -9,14 +9,11 @@
 #include <asm/io.h>
 #include <firmware/imx/sci/sci.h>
 #include <misc.h>
-#include <asm/global_data.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
=20
 #include "pinctrl-imx.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define PADRING_IFMUX_EN_SHIFT		31
 #define PADRING_IFMUX_EN_MASK		BIT(31)
 #define PADRING_GP_EN_SHIFT		30
diff --git a/drivers/pinctrl/nxp/pinctrl-mxs.c b/drivers/pinctrl/nxp/pinctr=
l-mxs.c
index 85ab5fdf640..8b764738014 100644
--- a/drivers/pinctrl/nxp/pinctrl-mxs.c
+++ b/drivers/pinctrl/nxp/pinctrl-mxs.c
@@ -5,7 +5,6 @@
  */
=20
 #include <log.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/io.h>
@@ -15,8 +14,6 @@
 #include <dm/read.h>
 #include "pinctrl-mxs.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct mxs_pinctrl_priv {
 	void __iomem *base;
 	const struct mxs_regs *regs;
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/doma=
in/imx8m-power-domain.c
index a7e64971a2a..1c731b897cc 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <malloc.h>
 #include <power-domain-uclass.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/sys_proto.h>
 #include <dm/device-internal.h>
@@ -22,8 +21,6 @@
 #include <dt-bindings/power/imx8mp-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define GPC_PGC_CPU_MAPPING			0x0ec
 #define IMX8MP_GPC_PGC_CPU_MAPPING		0x1cc
=20
diff --git a/drivers/power/pmic/bd71837.c b/drivers/power/pmic/bd71837.c
index a5df2570fc3..13642794765 100644
--- a/drivers/power/pmic/bd71837.c
+++ b/drivers/power/pmic/bd71837.c
@@ -7,14 +7,11 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/bd71837.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static const struct pmic_child_info pmic_children_info[] =3D {
 	/* buck */
 	{ .prefix =3D "b", .driver =3D BD718XX_REGULATOR_DRIVER},
diff --git a/drivers/power/pmic/mc34708.c b/drivers/power/pmic/mc34708.c
index 43badb5767a..0ec52e25a9e 100644
--- a/drivers/power/pmic/mc34708.c
+++ b/drivers/power/pmic/mc34708.c
@@ -9,11 +9,8 @@
 #include <errno.h>
 #include <fsl_pmic.h>
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <power/pmic.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int mc34708_reg_count(struct udevice *dev)
 {
 	return PMIC_NUM_OF_REGS;
diff --git a/drivers/power/pmic/mp5416.c b/drivers/power/pmic/mp5416.c
index 9d44f0ae655..899c2beeb37 100644
--- a/drivers/power/pmic/mp5416.c
+++ b/drivers/power/pmic/mp5416.c
@@ -9,9 +9,6 @@
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/mp5416.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 static const struct pmic_child_info pmic_children_info[] =3D {
 	/* buck */
diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index e5c1f037b61..c95e6357ee8 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -10,7 +10,6 @@
 #include <dm/lists.h>
 #include <i2c.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 #include <power/pmic.h>
@@ -18,8 +17,6 @@
 #include <power/pca9450.h>
 #include <sysreset.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static const struct pmic_child_info pmic_children_info[] =3D {
 	/* buck */
 	{ .prefix =3D "b", .driver =3D PCA9450_REGULATOR_DRIVER},
diff --git a/drivers/power/regulator/pwm_regulator.c b/drivers/power/regula=
tor/pwm_regulator.c
index ff738faadc5..adde5156c76 100644
--- a/drivers/power/regulator/pwm_regulator.c
+++ b/drivers/power/regulator/pwm_regulator.c
@@ -11,12 +11,9 @@
 #include <errno.h>
 #include <log.h>
 #include <pwm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <power/regulator.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct pwm_regulator_info {
 	/* pwm id corresponding to the PWM driver */
 	int pwm_id;
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index e9777c71f5e..dea7bc57495 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -17,7 +17,6 @@
 #include <dm.h>
 #include <pwm.h>
 #include <regmap.h>
-#include <asm/global_data.h>
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/bitfield.h>
@@ -40,8 +39,6 @@
 #define PWM_SIFIVE_CHANNEL_ENABLE_VAL   0
 #define PWM_SIFIVE_CHANNEL_DISABLE_VAL  0xffff
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct pwm_sifive_regs {
 	unsigned long cfg;
 	unsigned long cnt;
diff --git a/drivers/pwm/rk_pwm.c b/drivers/pwm/rk_pwm.c
index 0a64eb01dc2..b51dee31a98 100644
--- a/drivers/pwm/rk_pwm.c
+++ b/drivers/pwm/rk_pwm.c
@@ -11,14 +11,11 @@
 #include <pwm.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/pwm.h>
 #include <linux/bitops.h>
 #include <power/regulator.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct rockchip_pwm_data {
 	struct rockchip_pwm_regs regs;
 	unsigned int prescaler;
diff --git a/drivers/pwm/sunxi_pwm.c b/drivers/pwm/sunxi_pwm.c
index 2140a05b679..1dd2428da77 100644
--- a/drivers/pwm/sunxi_pwm.c
+++ b/drivers/pwm/sunxi_pwm.c
@@ -9,13 +9,10 @@
 #include <pwm.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/pwm.h>
 #include <power/regulator.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define OSC_24MHZ 24000000
=20
 struct sunxi_pwm_priv {
diff --git a/drivers/ram/stm32mp1/stm32mp1_tests.c b/drivers/ram/stm32mp1/s=
tm32mp1_tests.c
index 6108faa7073..3b41d6045ad 100644
--- a/drivers/ram/stm32mp1/stm32mp1_tests.c
+++ b/drivers/ram/stm32mp1/stm32mp1_tests.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <rand.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/log2.h>
 #include "stm32mp1_tests.h"
@@ -19,8 +18,6 @@
=20
 #define PATTERN_DEFAULT	"-"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int get_bufsize(char *string, int argc, char *argv[], int arg_nb,
 		       size_t *bufsize, size_t default_size, size_t min_size)
 {
diff --git a/drivers/reboot-mode/reboot-mode-gpio.c b/drivers/reboot-mode/r=
eboot-mode-gpio.c
index 22ee40c3433..8d3e53d50ee 100644
--- a/drivers/reboot-mode/reboot-mode-gpio.c
+++ b/drivers/reboot-mode/reboot-mode-gpio.c
@@ -10,8 +10,6 @@
 #include <reboot-mode/reboot-mode-gpio.h>
 #include <reboot-mode/reboot-mode.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int reboot_mode_get(struct udevice *dev, u32 *buf)
 {
 	int ret;
diff --git a/drivers/reboot-mode/reboot-mode-rtc.c b/drivers/reboot-mode/re=
boot-mode-rtc.c
index 4f4ad63febc..adca584d622 100644
--- a/drivers/reboot-mode/reboot-mode-rtc.c
+++ b/drivers/reboot-mode/reboot-mode-rtc.c
@@ -9,8 +9,6 @@
 #include <reboot-mode/reboot-mode.h>
 #include <rtc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int reboot_mode_get(struct udevice *dev, u32 *buf)
 {
 	if (!buf)
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-u=
class.c
index 2dbd3a21cea..47cb64fec77 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -22,8 +22,6 @@
 #include <linux/compat.h>
 #include <linux/printk.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct resource_table {
 	u32 ver;
 	u32 num;
diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 4f7de3ea215..c885b46cf56 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -14,13 +14,10 @@
 #include <reset.h>
 #include <spl.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 #include <linux/err.h>
 #include <linux/types.h>
 #include <asm/io.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_LCRVAL UART_LCR_8N1		/* 8 data, 1 stop, no parity */
 #define UART_MCRVAL (UART_MCR_DTR | \
 		     UART_MCR_RTS)		/* RTS/DTR */
diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index cc0491bc3c8..658cbd2bbc9 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -14,13 +14,10 @@
 #include <os.h>
 #include <serial.h>
 #include <video.h>
-#include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/serial.h>
 #include <asm/state.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static size_t _sandbox_serial_written =3D 1;
 static bool sandbox_serial_enabled =3D true;
=20
diff --git a/drivers/serial/serial_adi_uart4.c b/drivers/serial/serial_adi_=
uart4.c
index 45f8315d0a0..784310ba231 100644
--- a/drivers/serial/serial_adi_uart4.c
+++ b/drivers/serial/serial_adi_uart4.c
@@ -80,8 +80,6 @@
 #define ERXS			BIT(8)
 #define ETXS			BIT(9)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct uart4_reg {
 	u32 revid;
 	u32 control;
diff --git a/drivers/serial/serial_htif.c b/drivers/serial/serial_htif.c
index 2a93bbbcc9f..690de3fc085 100644
--- a/drivers/serial/serial_htif.c
+++ b/drivers/serial/serial_htif.c
@@ -8,14 +8,11 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <serial.h>
 #include <linux/err.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define HTIF_DATA_BITS		48
 #define HTIF_DATA_MASK		((1ULL << HTIF_DATA_BITS) - 1)
 #define HTIF_DATA_SHIFT		0
diff --git a/drivers/serial/serial_xen.c b/drivers/serial/serial_xen.c
index e05805f6372..4ba8d3ee641 100644
--- a/drivers/serial/serial_xen.c
+++ b/drivers/serial/serial_xen.c
@@ -7,7 +7,6 @@
 #include <dm.h>
 #include <serial.h>
 #include <watchdog.h>
-#include <asm/global_data.h>
=20
 #include <linux/bug.h>
=20
@@ -20,8 +19,6 @@
 #include <xen/interface/io/console.h>
 #include <xen/interface/io/ring.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 u32 console_evtchn;
=20
 /*
diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
index b6b92d3530d..7a50d5a5792 100644
--- a/drivers/smem/msm_smem.c
+++ b/drivers/smem/msm_smem.c
@@ -7,7 +7,6 @@
=20
 #include <errno.h>
 #include <dm.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <dm/of_access.h>
@@ -20,8 +19,6 @@
 #include <linux/sizes.h>
 #include <smem.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * The Qualcomm shared memory system is an allocate-only heap structure th=
at
  * consists of one of more memory areas that can be accessed by the proces=
sors
diff --git a/drivers/spi/ca_sflash.c b/drivers/spi/ca_sflash.c
index db32e39add2..f00df93a5f5 100644
--- a/drivers/spi/ca_sflash.c
+++ b/drivers/spi/ca_sflash.c
@@ -21,9 +21,6 @@
 #include <spi.h>
 #include <spi-mem.h>
 #include <reset.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 struct ca_sflash_regs {
 	u32 idr;		/* 0x00:Flash word ID Register */
diff --git a/drivers/spi/microchip_coreqspi.c b/drivers/spi/microchip_coreq=
spi.c
index a84b257fb1a..b3ff611e8f7 100644
--- a/drivers/spi/microchip_coreqspi.c
+++ b/drivers/spi/microchip_coreqspi.c
@@ -18,8 +18,6 @@
 #include <linux/sizes.h>
 #include <asm/gpio.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * QSPI Control register mask defines
  */
diff --git a/drivers/spi/mvebu_a3700_spi.c b/drivers/spi/mvebu_a3700_spi.c
index fde9b142fb8..79836d7e271 100644
--- a/drivers/spi/mvebu_a3700_spi.c
+++ b/drivers/spi/mvebu_a3700_spi.c
@@ -11,14 +11,11 @@
 #include <spi.h>
 #include <clk.h>
 #include <wait_bit.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <asm/gpio.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define MVEBU_SPI_A3700_XFER_RDY		BIT(1)
 #define MVEBU_SPI_A3700_FIFO_FLUSH		BIT(9)
 #define MVEBU_SPI_A3700_BYTE_LEN		BIT(5)
diff --git a/drivers/spi/omap3_spi.c b/drivers/spi/omap3_spi.c
index 35bd8766097..b2d115aded4 100644
--- a/drivers/spi/omap3_spi.c
+++ b/drivers/spi/omap3_spi.c
@@ -20,13 +20,10 @@
 #include <spi.h>
 #include <time.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <omap3_spi.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct omap2_mcspi_platform_config {
 	unsigned int regs_offset;
 };
diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index e00532a371b..0bdc112d249 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -26,7 +26,6 @@
 #include <fdt_support.h>
 #include <reset.h>
 #include <wait_bit.h>
-#include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
=20
@@ -35,8 +34,6 @@
=20
 #include <linux/iopoll.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* sun4i spi registers */
 #define SUN4I_RXDATA_REG		0x00
 #define SUN4I_TXDATA_REG		0x04
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index a3c0ad17121..66c97da610b 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -99,8 +99,6 @@
 #define TXBIT	1
 #define RXBIT	2
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct synquacer_spi_plat {
 	void __iomem *base;
 	bool aces, rtm;
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 49b584c648d..60401633341 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -12,14 +12,11 @@
 #include <spi.h>
 #include <spi-mem.h>
 #include <dm/device_compat.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <dm/lists.h>
 #include <dm/util.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define SPI_DEFAULT_SPEED_HZ 100000
=20
 static int spi_set_speed_mode(struct udevice *bus, int speed, int mode)
diff --git a/drivers/spi/tegra210_qspi.c b/drivers/spi/tegra210_qspi.c
index b969a7993d4..0f77fbc8d41 100644
--- a/drivers/spi/tegra210_qspi.c
+++ b/drivers/spi/tegra210_qspi.c
@@ -9,7 +9,6 @@
 #include <dm.h>
 #include <log.h>
 #include <time.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch-tegra/clk_rst.h>
@@ -19,8 +18,6 @@
 #include <linux/delay.h>
 #include "tegra_spi.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* COMMAND1 */
 #define QSPI_CMD1_GO			BIT(31)
 #define QSPI_CMD1_M_S			BIT(30)
diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index f3cd98c3db8..b89dd0b406b 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -10,13 +10,10 @@
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <spmi/spmi.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* PMIC Arbiter configuration registers */
 #define PMIC_ARB_VERSION 0x0000
 #define PMIC_ARB_VERSION_V2_MIN 0x20010000
diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index c8389d507ee..1bde4d07f52 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -5,7 +5,6 @@
  */
=20
 #include <config.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
@@ -19,8 +18,6 @@
 #include <malloc.h>
 #include <thermal.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define SITES_MAX	16
 #define FLAGS_VER2	0x1
 #define FLAGS_VER3	0x2
diff --git a/drivers/timer/ostm_timer.c b/drivers/timer/ostm_timer.c
index 314f956cdfb..3841d3c90d0 100644
--- a/drivers/timer/ostm_timer.c
+++ b/drivers/timer/ostm_timer.c
@@ -7,7 +7,6 @@
=20
 #include <clock_legacy.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <clk.h>
@@ -22,8 +21,6 @@
 #define OSTM_CTL	0x20
 #define OSTM_CTL_D	BIT(1)
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct ostm_priv {
 	fdt_addr_t	regs;
 };
diff --git a/drivers/timer/sp804_timer.c b/drivers/timer/sp804_timer.c
index 3e57f4b98ba..05532e3330c 100644
--- a/drivers/timer/sp804_timer.c
+++ b/drivers/timer/sp804_timer.c
@@ -8,15 +8,12 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <dm/ofnode.h>
 #include <mapmem.h>
 #include <dt-structs.h>
 #include <timer.h>
 #include <asm/io.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define SP804_TIMERX_LOAD		0x00
 #define SP804_TIMERX_VALUE		0x04
 #define SP804_TIMERX_CONTROL		0x08
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 13e9a61072a..22aa6525c96 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -7,14 +7,11 @@
  */
=20
 #include <dm.h>
-#include <asm/global_data.h>
 #include <linux/printk.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/phy.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static const char *const usb_dr_modes[] =3D {
 	[USB_DR_MODE_UNKNOWN]		=3D "",
 	[USB_DR_MODE_HOST]		=3D "host",
diff --git a/drivers/usb/phy/rockchip_usb2_phy.c b/drivers/usb/phy/rockchip=
_usb2_phy.c
index ce9a7b5b819..bdbd0d44813 100644
--- a/drivers/usb/phy/rockchip_usb2_phy.c
+++ b/drivers/usb/phy/rockchip_usb2_phy.c
@@ -5,15 +5,12 @@
=20
 #include <hang.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
=20
 #include "../gadget/dwc2_udc_otg_priv.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define BIT_WRITEABLE_SHIFT	16
=20
 struct usb2phy_reg {
diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 0aee57cb2f4..3061b466d7c 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -19,8 +19,6 @@
 #include <usb/tcpm.h>
 #include "tcpm-internal.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 const char * const tcpm_states[] =3D {
 	FOREACH_TCPM_STATE(GENERATE_TCPM_STRING)
 };
diff --git a/drivers/video/hx8238d.c b/drivers/video/hx8238d.c
index f0220e4cc07..b6980b1aec1 100644
--- a/drivers/video/hx8238d.c
+++ b/drivers/video/hx8238d.c
@@ -16,8 +16,6 @@
 #include <panel.h>
 #include <spi.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Register Address */
 #define HX8238D_OUTPUT_CTRL_ADDR        0x01
 #define HX8238D_LCD_AC_CTRL_ADDR        0x02
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3=
_fb.c
index ab416fdd33c..ef5d4faf3b3 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -21,7 +21,6 @@
 #include "ipu_regs.h"
 #include "mxcfb.h"
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/video.h>
 #include <linux/err.h>
@@ -37,8 +36,6 @@
 #include <dm/devres.h>
 #include <video.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int mxcfb_map_video_memory(struct fb_info *fbi);
 static int mxcfb_unmap_video_memory(struct fb_info *fbi);
=20
diff --git a/drivers/video/nexell_display.c b/drivers/video/nexell_display.=
c
index ea3776258a0..e0416b70ec0 100644
--- a/drivers/video/nexell_display.c
+++ b/drivers/video/nexell_display.c
@@ -16,14 +16,11 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <video.h>		/* For struct video_uc_plat */
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/display.h>
 #include <asm/arch/display_dev.h>
 #include "videomodes.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #if !defined(CONFIG_DM) && !defined(CONFIG_OF_CONTROL)
 static struct nx_display_dev *dp_dev;
 #endif
diff --git a/drivers/video/rockchip/rk_lvds.c b/drivers/video/rockchip/rk_l=
vds.c
index c969dae30b6..97c8619a6d8 100644
--- a/drivers/video/rockchip/rk_lvds.c
+++ b/drivers/video/rockchip/rk_lvds.c
@@ -10,7 +10,6 @@
 #include <panel.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
@@ -19,8 +18,6 @@
 #include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/video/rk3288.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct rk_lvds_priv - private rockchip lvds display driver info
  *
diff --git a/drivers/video/rockchip/rk_mipi.c b/drivers/video/rockchip/rk_m=
ipi.c
index 0a603083ba9..e7b5973ca58 100644
--- a/drivers/video/rockchip/rk_mipi.c
+++ b/drivers/video/rockchip/rk_mipi.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <panel.h>
 #include <regmap.h>
-#include <asm/global_data.h>
 #include "rk_mipi.h"
 #include <syscon.h>
 #include <asm/gpio.h>
@@ -22,8 +21,6 @@
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/rockchip_mipi_dsi.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 int rk_mipi_read_timing(struct udevice *dev,
 			struct display_timing *timing)
 {
diff --git a/drivers/video/sandbox_sdl.c b/drivers/video/sandbox_sdl.c
index 69dfa930273..48da350080a 100644
--- a/drivers/video/sandbox_sdl.c
+++ b/drivers/video/sandbox_sdl.c
@@ -7,15 +7,12 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <video.h>
-#include <asm/global_data.h>
 #include <asm/sdl.h>
 #include <asm/state.h>
 #include <asm/u-boot-sandbox.h>
 #include <dm/device-internal.h>
 #include <dm/test.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	/* Default LCD size we support */
 	LCD_MAX_WIDTH		=3D 1366,
diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_dr=
v.c
index 790ff6e591c..c231fd0341e 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -42,8 +42,6 @@
 #include "tidss_regs.h"
 #include "tidss_oldi.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Panel parameters */
 enum {
 	LCD_MAX_WIDTH		=3D 1920,
diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zyn=
qmp_dpsub.c
index a0efd3393f5..fba65bb3d5b 100644
--- a/drivers/video/zynqmp/zynqmp_dpsub.c
+++ b/drivers/video/zynqmp/zynqmp_dpsub.c
@@ -20,12 +20,9 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <dm/device_compat.h>
-#include <asm/global_data.h>
=20
 #include "zynqmp_dpsub.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Maximum supported resolution */
 #define WIDTH				1024
 #define HEIGHT				768
diff --git a/drivers/watchdog/armada-37xx-wdt.c b/drivers/watchdog/armada-3=
7xx-wdt.c
index 4b51178e1b8..d7a6b8de492 100644
--- a/drivers/watchdog/armada-37xx-wdt.c
+++ b/drivers/watchdog/armada-37xx-wdt.c
@@ -7,14 +7,11 @@
=20
 #include <dm.h>
 #include <wdt.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <dm/device_compat.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct a37xx_wdt {
 	void __iomem *sel_reg;
 	void __iomem *reg;
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wd=
t.c
index 72e13787448..2fb25126b8c 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -15,7 +15,6 @@
  */
=20
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/at91_wdt.h>
 #include <div64.h>
@@ -23,8 +22,6 @@
 #include <errno.h>
 #include <wdt.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
  * use this to convert a watchdog
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 6308d9632a8..08ef3d84e26 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -11,12 +11,9 @@
=20
 #include <dm.h>
 #include <wdt.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct mt762x_wdt {
 	void __iomem *regs;
 };
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4562b2a37e3..a2000b968c9 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -16,15 +16,12 @@
 #include <clk.h>
 #include <log.h>
 #include <wdt.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct orion_wdt_priv {
 	void __iomem *reg;
 	int wdt_counter_offset;
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 03585529bb6..807884c5bc7 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -5,7 +5,6 @@
  * Copyright 2020 NXP
  */
=20
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device.h>
 #include <dm/fdtaddr.h>
@@ -15,8 +14,6 @@
 #include <watchdog.h>
 #include <wdt.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* SBSA Generic Watchdog register definitions */
 /* refresh frame */
 #define SBSA_GWDT_WRR		0x000
diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index b32590069d9..438833b2245 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -14,13 +14,10 @@
 #include <sysreset.h>
 #include <time.h>
 #include <wdt.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <linux/kernel.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 #define WATCHDOG_TIMEOUT_SECS	(CONFIG_WATCHDOG_TIMEOUT_MSECS / 1000)
=20
 struct wdt_priv {
diff --git a/fs/fs.c b/fs/fs.c
index 319c55c440a..8ea50a6c13c 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -24,7 +24,6 @@
 #include <ubifs_uboot.h>
 #include <btrfs.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <div64.h>
 #include <linux/math64.h>
@@ -34,8 +33,6 @@
 #include <erofs.h>
 #include <exfat.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static struct blk_desc *fs_dev_desc;
 static int fs_dev_part;
 static struct disk_partition fs_partition;
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index 40bad0e7da7..b0cc0d2e1b2 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -16,7 +16,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
-#include <asm/global_data.h>
 #include "ubifs.h"
 #include <part.h>
 #include <dm/devres.h>
@@ -31,8 +30,6 @@
 #include <abuf.h>
 #endif
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* compress.c */
=20
 /*
diff --git a/include/relocate.h b/include/relocate.h
index 8ca25e1105e..331be138728 100644
--- a/include/relocate.h
+++ b/include/relocate.h
@@ -8,9 +8,7 @@
 #define _RELOCATE_H_
=20
 #ifndef USE_HOSTCC
-#include <asm/global_data.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
 #endif
=20
 /**
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 89e63ed8dd5..d66ddd1bbf8 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -21,7 +21,6 @@
 #include <mapmem.h>
 #include <sort.h>
 #include <sysreset.h>
-#include <asm/global_data.h>
 #include <u-boot/uuid.h>
=20
 #include <asm/sections.h>
@@ -29,8 +28,6 @@
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 const efi_guid_t efi_guid_capsule_report =3D EFI_CAPSULE_REPORT_GUID;
 static const efi_guid_t efi_guid_firmware_management_capsule_id =3D
 		EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 3abb47d610e..9403e09691e 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -13,9 +13,6 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <video.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 static const efi_guid_t efi_gop_guid =3D EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID=
;
=20
diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index 4734f95eee1..7810b4e47ea 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -10,9 +10,6 @@
 #include <efi_rng.h>
 #include <log.h>
 #include <rng.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
=20
 const efi_guid_t efi_guid_rng_protocol =3D EFI_RNG_PROTOCOL_GUID;
=20
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index a233912fd8e..5c437143a30 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -14,15 +14,12 @@
 #include <log.h>
 #include <net.h>
 #include <nvmem.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <net/pcap.h>
 #include "eth_internal.h"
 #include <eth_phy.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /**
  * struct eth_device_priv - private structure for each Ethernet device
  *
diff --git a/net/tftp.c b/net/tftp.c
index 78ec44159c1..73d6a6a3c1b 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -16,12 +16,9 @@
 #include <mapmem.h>
 #include <net.h>
 #include <net6.h>
-#include <asm/global_data.h>
 #include <net/tftp.h>
 #include "bootp.h"
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * We cannot use the 'tftpput' command in xPL phases. Given how the
  * support is integrated in the code, this is how we disable that support
diff --git a/net/wget.c b/net/wget.c
index d3642958bf0..49bfb9fcb96 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -4,7 +4,6 @@
  * Copyright Duncan Hare <dh@synoia.com> 2017
  */
=20
-#include <asm/global_data.h>
 #include <command.h>
 #include <display_options.h>
 #include <env.h>
@@ -17,8 +16,6 @@
 #include <net/wget.h>
 #include <stdlib.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* The default, change with environment variable 'httpdstp' */
 #define SERVER_PORT		80
=20
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index fdde054b928..e20bc5f7b98 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -7,11 +7,8 @@
=20
 #include <console.h>
 #include <mapmem.h>
-#include <asm/global_data.h>
 #include <test/ut.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Declare a new exit test */
 #define EXIT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, exit)
=20
diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
index 8b306cc907f..7ed534742f7 100644
--- a/test/cmd/test_echo.c
+++ b/test/cmd/test_echo.c
@@ -6,14 +6,11 @@
  */
=20
 #include <command.h>
-#include <asm/global_data.h>
 #include <display_options.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 struct test_data {
 	char *cmd;
 	char *expected;
diff --git a/test/cmd/test_pause.c b/test/cmd/test_pause.c
index 174c31a3852..b2cf60d3e74 100644
--- a/test/cmd/test_pause.c
+++ b/test/cmd/test_pause.c
@@ -5,12 +5,9 @@
  * Copyright 2022, Samuel Dionne-Riel <samuel@dionne-riel.com>
  */
=20
-#include <asm/global_data.h>
 #include <test/lib.h>
 #include <test/ut.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int lib_test_hush_pause(struct unit_test_state *uts)
 {
 	/* Test default message */
diff --git a/test/dm/blk.c b/test/dm/blk.c
index 1b928b27d9c..f67869107da 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -8,14 +8,11 @@
 #include <part.h>
 #include <sandbox_host.h>
 #include <usb.h>
-#include <asm/global_data.h>
 #include <asm/state.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Test that block devices can be created */
 static int dm_test_blk_base(struct unit_test_state *uts)
 {
diff --git a/test/dm/i3c.c b/test/dm/i3c.c
index 81336e67555..816ecabd722 100644
--- a/test/dm/i3c.c
+++ b/test/dm/i3c.c
@@ -8,8 +8,6 @@
 #include <dm/test.h>
 #include <test/ut.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Basic test of the i3c uclass */
 static int dm_test_i3c_base(struct unit_test_state *uts)
 {
diff --git a/test/lib/test_print.c b/test/lib/test_print.c
index cd7f3f85769..2aeb034b121 100644
--- a/test/lib/test_print.c
+++ b/test/lib/test_print.c
@@ -7,13 +7,10 @@
=20
 #include <command.h>
 #include <display_options.h>
-#include <asm/global_data.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 static int test_print_freq(struct unit_test_state *uts,
 			   uint64_t freq, char *expected)
 {
diff --git a/test/log/log_filter.c b/test/log/log_filter.c
index 680c60164b6..147b83980cf 100644
--- a/test/log/log_filter.c
+++ b/test/log/log_filter.c
@@ -6,12 +6,9 @@
 #include <console.h>
 #include <log.h>
 #include <vsprintf.h>
-#include <asm/global_data.h>
 #include <test/log.h>
 #include <test/ut.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Test invalid options */
 static int log_test_filter_invalid(struct unit_test_state *uts)
 {
--=20
2.37.1


