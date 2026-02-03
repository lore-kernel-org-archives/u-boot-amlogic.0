Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF868E83EFF
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:33:55 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13704.1770115812955536203
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 02:50:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=oSmws5M+;
 spf=pass (domain: oss.nxp.com, ip: 52.101.66.10, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzNBJJiEHDEqulzKnLMuCYCqWbb3xDPrlfeRRHt8vGUbOXq4JVotYdW/rVQkmJ3ofU4AbPoniY+YhTe1ZOnv0NVKUcz7n6v1zuNAcDt4WX0EGQJ3ix7kRhPw9qcvqCsqsB0TwHX+MSJbaMLqPQhYIVxqBTLk1IpEbOg3g7kiFTr069F1iVYOszW3LQOOTvV5gnb62AZvjj489ZPZhwnVUPSc6WvnudoDzK+zUn3VDmcJBMeI3S5m2MVKlk1KpSVMheMGp56cCKOKTfLif/34aHFqISLvwo78wfj+9lWogu6ok9yZ2xT+OmdC8fKkdEC3i/Btz925RNiaiB4qznkP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mARH3HXQvn9H2K9C75Ooeo+YZ9BTcmxpCVUThYGK/EU=;
 b=ZLJ8RPqU+U+jhNOZpFAjPfkwLOAuluhqjv8QZr3btBAmowB6jjLj0WoArt6zWClvzaqvy2LFXRoSvxhRAYacgsLd0KnlkLuLo/sQobXzsnC2AC0M/gmGUr0hMlMa9sUIKrroeut+fBz5y7WiqIQ+qT/g1DLEEAmVczRRqaRrYyGEc9ObPJPZqF1cUm3KdeN5VKLaKFWvfQvTgr/Tw25PrvxYjM/MHP5lrLUUR8TY3vlO+eH+xSvUIXu1B2RONyRGeUaCgBnTKWLyMfxcdc318iHMD1KmOYOsGPmfcPdQfE2ZIQKqvh4z7OJkaw9bRyXyXomjxPPVVJ8jzv9lEgw2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mARH3HXQvn9H2K9C75Ooeo+YZ9BTcmxpCVUThYGK/EU=;
 b=oSmws5M+VR4YetJjTTeYXuhauFwDTzfZsDLafSLpzz4NH5DcPSwHd9Xa0rDlMyL3YcvCLia2NMJOlbt2A767/o/jwY0YofVKmU7pPZGKbswu305q6xawPXy50YBkWzyMcmS/v0pZlLse80E3JjtWYZcrVq/QdFpO4hMxUZQs4FZPxZ4jP1BW2tlf/knB2szfnlo4P5u5fGiFzeLubEh8Ljkk1kyWU8zVUXvwhocRZiFLNkJ3Q0GNtvhBIEIvjW58m4ozCiDsbp7QYVFs20NHlqCoH8rCMUSy1medkNyPYFJTUVcMc4LD3EfQf4fE78K3Z3zDwSDJTEoTyX43EJoCaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:50:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 10:50:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Feb 2026 18:41:43 +0800
Subject: [PATCH 12/14] renesas: common: Include asm-generic/u-boot.h
Message-Id: <20260203-cleanup-v1-12-4221c13e7558@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e61b993-f5a3-4d95-5d06-08de6311fbde
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?L2E3SjFua1BqWW5MTTNFYUJNY2c1clJGLzhjMnVWWHJwc0MwZTV4YzQ1dlp1?=
 =?utf-8?B?Z0lzRDcrc1dXQVdBYUdBdXIvbkRZWFlMZTlSZkNhdEhWaVhkdXZlSVQvNzNV?=
 =?utf-8?B?b2pwalFTTHlBQ09NVCs1V0VCNDFMdkkzeUQzN0xJdExobjA3aUhOWEMva29t?=
 =?utf-8?B?Zld0dGxDbTNsdWlEQmZsWnphUDJNcEZQOFowNW0xSlQ0cWFlK3VCcTJ1WkpF?=
 =?utf-8?B?ZkQ2M2s2Y0lSUk9pOE83d1ZZZlNnT0ZjaDViTWNIUlhnc3NlQ0VWZHc2d2hC?=
 =?utf-8?B?SVh0Ymdkc0NnYXhmZWhiQmxTVUhDcXdBVXIvZ0Rrd2JHN3IrQ2lxK05pSkcx?=
 =?utf-8?B?M3EvUlVuQ2ZUOWl3WkkwaFlvMm1jMWlTZXoxSzdpeHIyU3E5cnMzc1NVVWhF?=
 =?utf-8?B?a0pJNFJLT1l4QkJ0alJ1TS96R25NTXhReFpqcnRxdEpYaVBwTHRaQTFGbkdm?=
 =?utf-8?B?aUpOdlR6cmY3ancwM3NDQzFldUEwMHBEVU9CN2RXd28zaUw5dnNDYjdOTE1I?=
 =?utf-8?B?aVJsVUhRQ2Y4ZFdGU1puR2xlRTdmblVMa2Q5U3JJd2ZlNU9ydGlkbHR0Tkc3?=
 =?utf-8?B?alhqTnUvUW05cWZBMzR6QnZsYVZEc3dwNkF1cjRPMXVKTjRMTk92UllIYlZr?=
 =?utf-8?B?cm1ZVGpCeC9QY1hlN0t2WkpwRHMvUnhHYjY4KzJJdnFod1N3aGczTFlhQzRt?=
 =?utf-8?B?RSszSXZxV2g0T3B3U0JFTDRPeEtCaTZHSFJrd1FlWUgwNnJ6bGg1QzZPRm5p?=
 =?utf-8?B?dkRicUhGRkMydnBMOStnVXRPMVVHdGIyVTVCdktYSXZaZVN4UGYzcDcrSHds?=
 =?utf-8?B?eHNvWjVONE4zQXFQRWVSM0NoeWV6dWVQbWV3Y1p0MXpYbmNneUVCYXFCKzBR?=
 =?utf-8?B?emdaamNyTm5KSzlrU0pPWEFKaWpFdVFpNk82VlJndG9MNStia3NzUjVZT1ZZ?=
 =?utf-8?B?TlFxWUpydTgwZ1JHYnd3Ymh1MXczaW5SY2VIa1EvSWUyRGh1SVQyVjNocHVp?=
 =?utf-8?B?QmFhbUM5aWhCR1VaNEROWGJIUCtUYkQzdTY0SGdERkdsR1I5b0t3WFcxcTU3?=
 =?utf-8?B?L3k3ZCthaU5EVTNDaXdzUGhnZkNWNmc3UUZTeGI4UjM5b0pVeVBnL2lya0lQ?=
 =?utf-8?B?dVZMazhGZ0tuNjhrY2NFbW1wNFB1NTFjMi8vQ3BGQjZRWjRaRGo3NnI0eFhI?=
 =?utf-8?B?Tkx3ZDEvRUxLMzVHMUFaU0xjaXVEWTF0U1JuUEJVYkxCSEc4aVdKWE56VFVv?=
 =?utf-8?B?OWdQZVJXKzAyRC9iZHFUZU9yMCtka1RoSGplRXl1b1EyaDA1UnhENk1abEFT?=
 =?utf-8?B?TmNjMGRVYUF2Znd2ZlM1WXRVNkI1NDEzMzhSMXhqOHVhS0pJQzhIck16blRU?=
 =?utf-8?B?RXZHMW1CZGxuZHl4R1pBTks4dWRRRXdvTU1mbUJzMFJvOFlTYmgyNU51M2hP?=
 =?utf-8?B?SXhRSEw2WGkyOVBXelhVTHN2N2dGOFJxdTlTa01jakp5Q1ZiaXZjNzZMNFRT?=
 =?utf-8?B?VjFQSEpkYkZtZXBNamhIeWtucmdOUW1Pcm9hR3dZYXp4eFpyMXIveTZsa0tZ?=
 =?utf-8?B?alhnS25HcnJHUzk3YXhLTmROWmVxY2o5S1JKNEpQeW43S1RYZjMyeEs0ZmVM?=
 =?utf-8?B?UUc4c0dMOFB4c040cXZ4MGJpSml1TnI5L2Rid2RKbEJxZDNKczR2SmJJd3lr?=
 =?utf-8?B?UVQ5YjVzMTVkbmpPQlVMWkwyMEdlMnpMOTlCMm1palBWeEFOUzhLSk9IRHNO?=
 =?utf-8?B?cXdrZ3pJYnduUmdtbXlXL0VMaWNiSmlEZWV3SGljbEdnNWxsS1lPbEFQbkJs?=
 =?utf-8?B?WEIwUjZuZlFwTWVKd3VkdWFvb3NNRWYxc0p4K1h2bk10dGcybkU5K1k3WlNq?=
 =?utf-8?B?em1waGV2Qk5FT3ZwVVhsa2lBUVowend2L01VTFE1dEZ5TlVWa3RBTmZRRjBj?=
 =?utf-8?B?NTJwYzR3Y2ZUQjFsZ3dzT2ZrWU82NFN6b0pYTzF1MlpuZVpKS24vQS9CZDdW?=
 =?utf-8?B?WmY1V2Q0ZTI4SlM2ZGFJaFJiekJXVjBYWjBSRHZuZDV3VDY2a3AwNkc3SzYw?=
 =?utf-8?B?clp3MFpVRmNPSkFaVlp3VDUxeGNqT2NOcGUxank0Wkhhd3EyOTJNVjJXU2ZO?=
 =?utf-8?B?K01VSi8yeTJhN21uRXppRWdiRHYzaHgzR0xXamRONTY2bGdlQ040enZZNXp5?=
 =?utf-8?Q?YVsY12QciVrn5WQ1aJ8stJRfG6PrYXmAA1hER+oFIIyH?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?RjhaOHlheVJ0a0czdVo4aXR3NHlYQ05EODJhZDRjTkVWU0FJK2Y0b0xaNHNC?=
 =?utf-8?B?aCtpbjFxV3lDNGc5Wkxld3gyS05oc0phQXBuMU12Z2hhYzUvaTYxMWxGRG1P?=
 =?utf-8?B?cUxNcWREZ3M0cnFRb1ZmbDRWS2lJaVZJRlNCTE94YVEzb2VLbzRKRVdKemJv?=
 =?utf-8?B?aklCY0pDQ0taaS9LaWR4TTlSdWxqSXloWUtjUDF4VWVXNU1saFlHaXNHRXRy?=
 =?utf-8?B?UWszK2VZKzkwRFRQelJ1MkJuVmREeWU2bzdTSmJET2lvVFZINm5LS0dZYW8w?=
 =?utf-8?B?eWt6Z0JsYnpPWmFKWUR4dHVIQnZQVElHT3BmTFNxcUprRzdQTW1icE95VFBJ?=
 =?utf-8?B?Z1RPNDlVNTNOZU41YUo3eUdGditVc0lzb2ZiRGlybUlrRm9jQm82SjdIU1Z4?=
 =?utf-8?B?NThZZXdrSUJYRVVmWVZzekNWRG1BdmVhaUMzTlIxbUpRUTJ3QWxuaHU4UFJx?=
 =?utf-8?B?Q1BkRUx2V2NjOGRiK1YzZTVIZ2c0Rkw4TXRoVmsvN25nN1ZVVGllSkE2Tjg1?=
 =?utf-8?B?MndQRFJMSng0RWJtdUhlbFhHQzdUTllQd1k5YTJHNzlQMDZSQkRtdkljRHZ6?=
 =?utf-8?B?NTZUUm5vTGgzUkV4dGtDeTJhUGVLK2VNVlhLTXJGM1dyTUJJaURtZkYxVnli?=
 =?utf-8?B?ZUx3cDUyYk1KMlA3K1Avalg3TEdrbHJOck1haGoxcjJYYnRGNTlNc3lJNzlT?=
 =?utf-8?B?dTB0NjRWNTRwYWtEdU9ESGVGRkJSQm9iUjdNUFZZZWlaeHArbS9MNGx3MWtE?=
 =?utf-8?B?ZFNnVmtzRlpLa2YvUkI1RGlwZmtoSUliampyZ1RNS1E0dTBPMzQxQW1hUGdW?=
 =?utf-8?B?bCtUOHVYbnRkdWExWTdocUNYZCt4N25qTHRTeXR3b0V1cWVTbXByd3U5cm1K?=
 =?utf-8?B?SGhxNnJDZXVWYVlPaEJlM2orRE1GL0pWVlZxVnVvbzk0T0YvMjc5ZkJkMGZC?=
 =?utf-8?B?TU5KME5JTFRjd1hDVDd1T0JDQ1NEbjNHOW9ORkdsWEVEU0puc01NdnJFR1BR?=
 =?utf-8?B?L2thck9VR2RjbEVGdndCNGIrZUlka3hmcGlxVHdPUXUvajFVbnJlbGlFRkNo?=
 =?utf-8?B?Mk5Pa1dYTGw5bnozU0tEOXd4TXBXbzU2ek9CdmRTS1IyU3dwMklkNWVFdGh1?=
 =?utf-8?B?OGxTU3daVXFreE5sbEMzWVkvNHNXaXU1bU9LNU9FeVVPeE5JdEVxZmRvZE9H?=
 =?utf-8?B?WndDL1J2RVBmdWJpalFrczJaenpPclZXcUQrT2FXdjk5Qk4xYkZBNEhXMUF3?=
 =?utf-8?B?akhvT3RNOGswU2ZYU0ZEbCtJTnloVHRCTlN2Y1ZMUVlqODhsSEFFajZyTFFO?=
 =?utf-8?B?WmlLK2tqSGtna0pJR2tObHJBMFY2OXlTVWRBUDc1NjI1QmJSV0oxQjNZY0lD?=
 =?utf-8?B?VTJxUm45bmwvT09PRWRGbVl1Ui9tRFh6aXVoaTdwZisyYU5BTEVpOXg4Mkps?=
 =?utf-8?B?ZVlPTE1iUENkWkZ2V0FkRjZQMXd5eDVkY0Vpbjh4U2xvVTR4Q082RUp0MVlK?=
 =?utf-8?B?MVhJUGg4RldMZlZaS0d3K3VsdHdHRTM0amFER3lDdmtrVFE2Y1pTS0tURUtk?=
 =?utf-8?B?dTJiR2dldHdQdUxMVVdiVGxxU2xkN0R0OUozT0s2R0tBQldnTFV3L0FGRHp3?=
 =?utf-8?B?S2Y2cTlNekJSNFJVbUZYb1lJZDNYVmpBZ3B0TWtSOFR3RzQ3aU0weWtLQ1l1?=
 =?utf-8?B?ZTFxdTh0bzg1MXlBUFhRbG5HTTNqMnEwYlcrNGpxaDBnTlk5TC9Ha2xuWDZi?=
 =?utf-8?B?TkxhTUlQeGx4K212SHR5VmsrSkV3UUEremJndUFSQ0JDOTlzR0EvamNWdFZz?=
 =?utf-8?B?Z0pOeERXWHd0RjFoTzZ0RkVVRkhKVUgyM3hxQlRxVFVCUzFqQXk0d2xCOEEw?=
 =?utf-8?B?YytwMjAxMS8wZ2ZydHZPTzZOWDd0L0lrUUFpRjIwUTNSUE8yTWZzcFRHRHlO?=
 =?utf-8?B?UU1mTkNJWXl4WUtlOG83YjVidHZZMFJoVFI2L2JnS1NNcitFUTNLbGkzTWJE?=
 =?utf-8?B?NFJFaWpJVHFnOGxWTURKMDBhSENnYjZzRE5PYjhHQzVjY0o2RzE5bEhlM0Fy?=
 =?utf-8?B?VHVZSmtqdWh5SlBqeUNlOGxCa3RPT2U0Sit1OUdsMnZGN3pXYXZOV2lLUURV?=
 =?utf-8?B?SkFBd2dTVkRsdWdJQUt0cG9wNExLM3I0T0duYmlOaXExYXova2hJU3oxNTVt?=
 =?utf-8?B?bDF4bkw1Sm8yWHZ5YkNtdTBXQ04zcVZWNlI1MjR4Q1V3OExzdUJnMEwzZlBu?=
 =?utf-8?B?YVRVVHNtREpQUzI4MDJlVTRqMFJodUFvN2pOYm1rVlZxNVcySmZPc2Z6czhu?=
 =?utf-8?B?RVFaVUZkbVljQ1FTNnN1blRHWFdjaFVLMVFzUm9OT0dVTmZCTU4wQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e61b993-f5a3-4d95-5d06-08de6311fbde
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:50:02.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjQuGXabYLhYGAxOAFJVFF0b19eZGg5f5nCmbDlh4JK8+L5Ho/XAlmd8DslrACnWAT9aC/QH4YZ+9YILSiGESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8989
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:33:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2890

From: Peng Fan <peng.fan@nxp.com>

struct bd_info is defined in asm-generic/u-boot.h. Include it to avoid
building error after asm/global_data.h are removed from this file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/renesas/common/gen3-common.c | 1 +
 board/renesas/common/gen4-common.c | 1 +
 board/renesas/common/gen5-common.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/board/renesas/common/gen3-common.c b/board/renesas/common/gen3-common.c
index 94da00985d34049222a2c5aaec650d03dc2aec85..f89ae81e95ec551b8b254fd0fee0b9839f798b85 100644
--- a/board/renesas/common/gen3-common.c
+++ b/board/renesas/common/gen3-common.c
@@ -16,6 +16,7 @@
 #include <asm/io.h>
 #include <dm/uclass-internal.h>
 #include <asm/arch/renesas.h>
+#include <asm-generic/u-boot.h>
 #include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4-common.c
index 38fba7a5ea77778383d29f2403a585bdb54994e9..81c6f6f4c6ddbf78f50657bef9a31a4f3e8e6099 100644
--- a/board/renesas/common/gen4-common.c
+++ b/board/renesas/common/gen4-common.c
@@ -13,6 +13,7 @@
 #include <asm/mach-types.h>
 #include <asm/processor.h>
 #include <asm/system.h>
+#include <asm-generic/u-boot.h>
 #include <image.h>
 #include <linux/errno.h>
 
diff --git a/board/renesas/common/gen5-common.c b/board/renesas/common/gen5-common.c
index a05a3e8abef46f55ae649d11741ad45797090728..3b724e59049c0b451b6e346a6ecb9846c3226e97 100644
--- a/board/renesas/common/gen5-common.c
+++ b/board/renesas/common/gen5-common.c
@@ -10,6 +10,7 @@
 #include <asm/mach-types.h>
 #include <asm/processor.h>
 #include <asm/system.h>
+#include <asm-generic/u-boot.h>
 #include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;

-- 
2.37.1


