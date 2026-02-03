Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A0E87840
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:34:06 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14919.1770119875807255342
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Feb 2026 03:57:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nxp.com header.s=selector1 header.b=FnMAvxzi;
 spf=pass (domain: nxp.com, ip: 52.101.70.40, mailfrom: peng.fan@nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxL9gqtuPtGAHdHVaUKhuk7AeGaZf117r/lmq3e1cdnZEHcw+c9KuobNfHGZNGmzVs9sWfbLQIOdw3z9Bq/2vBnPdqJpi9rhA+a1u2IVRtZ0o+HH9cOp6HVWU3jYk1ArNpWkgnIH1Vtit4v8jmFvyjj9Dk3PAVFq2QE2CpiIANBf6hK9JiODUmu/m9IORfI03NeO5C555PyJbkm5wsabaQBm4fPSqTLkjfY/mrd6lAzML8QJtk9WL/GwbVUJVBXuF2orUneJLTZ2yGcAlc5E4Ld/cKLsD5s/kB6SFITW2JB9U0VqrNmYIw3iigazLMG2Yogy0On6zCvhc05LyfMZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFHF3wIXgVYkPzJLzTMj0VWXodJbQvuzSiFcUWdIaoM=;
 b=rPIwT5c7wDiyHbwu4fbQqdRjdEmld1i0/Dap5PrzmDz2y4EjP0/km9Gbz+RCCeQodYPFeQElz/Q2GLaJ0AETX7wbi2ucJYbLQ9r52oqRZ6Dpz3K5xOP2rSFUExqR9u53j+Ak7Ju8wkYL7uR/pkEOTQMJQPeeleRTniYLKqGwH9S2fQIqd7x42t3p6CCCOgXvTgUfQ9Jtu2UdTYw9ZenIl5zn7ib3iOnY/oIATX8vRDMP7zgZRF9pwrF8FFF1pl8BXdyj2bZ2ljW/w00BlV1IRgn165+n6E+hp+4LbK5hYTHUcfFG8qvIT0B07QLw/0spAkhgw//ejSXixVU7HXJX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFHF3wIXgVYkPzJLzTMj0VWXodJbQvuzSiFcUWdIaoM=;
 b=FnMAvxziuH9P+IpRtnXmKMD+JCkxqrFTrP+JJQCS3RrRHUfF1re7CJUF1kkwesZUowG9rzMQIiWkk50kMWk9aqTS3QSp/0qu1mcjlRBRs7k4aBjmsQNayTCTETzhHEUI7hgdHnhPXIZI0UHz3WIM6S86BkaOWiwHNPGyA/BnXOaKGSkq8CbdQs+yidqsN6MgkGjpZKE5NVehEAm8ilyTQH6UP3Inccwiwz9qjA0pj+UvyJM3vgzJzHa/NcPNZDTvrFqkXt+QIPf6Gll60Xxd6lepi27oTrBHTCWE9zauTAjYGYCnlMa4O18VpOnqqLTq1MJR29XrKWqalHR1NyOm1Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8055.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 11:42:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:42:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "u-boot@lists.denx.de"
	<u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
	<GSS_MTK_Uboot_upstream@mediatek.com>, dl-uboot-imx <uboot-imx@nxp.com>,
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Christoph Stoidner <c.stoidner@phytec.de>, "kernel@puri.sm" <kernel@puri.sm>,
	Sam Day <me@samcday.com>, Sumit Garg <sumit.garg@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, "uboot-snps-arc@synopsys.com"
	<uboot-snps-arc@synopsys.com>, "u-boot-amlogic@groups.io"
	<u-boot-amlogic@groups.io>, "u-boot@dh-electronics.com"
	<u-boot@dh-electronics.com>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>,
	"uboot-stm32@st-md-mailman.stormreply.com"
	<uboot-stm32@st-md-mailman.stormreply.com>, "adsp-linux@analog.com"
	<adsp-linux@analog.com>
CC: Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>, Alice Guo
	<alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>, Sam Protsenko
	<semen.protsenko@linaro.org>, Sam Shih <sam.shih@mediatek.com>, Ryder Lee
	<ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, Igor Belwon
	<igor.belwon@mentallysanemainliners.org>, Anton Moryakov
	<ant.v.moryakov@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
	Rasmus Villemoes <ravi@prevas.dk>, Mattijs Korpershoek
	<mkorpershoek@kernel.org>, Jerome Forissier <jerome@forissier.org>, Simon
 Glass <sjg@chromium.org>, Max Filippov <jcmvbkbc@gmail.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, Vitor Soares
	<vitor.soares@toradex.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>, Philipp Tomsich
	<philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Stefano
 Babic <sbabic@nabladev.com>, Alexey Brodkin <alexey.brodkin@synopsys.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Stefan Bosch
	<stefan_b@posteo.net>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang
	<chiawei_wang@aspeedtech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Vasut <marex@denx.de>, Simon Goldschmidt
	<simon.k.r.goldschmidt@gmail.com>, Tien Fong Chee
	<tien.fong.chee@altera.com>, Alif Zakuan Yuslaimi
	<alif.zakuan.yuslaimi@altera.com>, Michal Simek <michal.simek@amd.com>,
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Gregory CLEMENT
	<gregory.clement@bootlin.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Aaron Williams
	<awilliams@marvell.com>, Thomas Chou <thomas@wytron.com.tw>, Rick Chen
	<rick@andestech.com>, Leo <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Bin Meng <bmeng.cn@gmail.com>,
	Wolfgang Wallner <wolfgang.wallner@at.abb.com>, "Ying-Chun Liu (PaulLiu)"
	<paul.liu@linaro.org>, Oliver Graute <Oliver.Graute@KoCoConnector.com>,
	Randolph <randolph@andestech.com>, David Feng <fenghua@phytium.com.cn>, Linus
 Walleij <linusw@kernel.org>, Peter Hoyes <Peter.Hoyes@arm.com>, Liviu Dudau
	<liviu.dudau@foss.arm.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
	<robertcnelson@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Gilles Talis <gilles.talis@gmail.com>, Jagan Teki
	<jagan@amarulasolutions.com>, matteo.lisi <matteo.lisi@engicam.com>, Manoj
 Sai <abbaraju.manojsai@amarulasolutions.com>, Mario Six <mario.six@gdsys.cc>,
	Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>, Frieder Schrempf
	<frieder.schrempf@kontron.de>, Heiko Thiery <heiko.thiery@gmail.com>, "Lukas
 F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, Martyn
 Welch <martyn.welch@collabora.com>, Ian Ray <ian.ray@gehealthcare.com>,
	Teresa Remmet <T.remmet@phytec.de>, Mathieu Othacehe <m.othacehe@gmail.com>,
	Angus Ainslie <angus@akkea.ca>, Stephan Gerhold <stephan@gerhold.net>, Jorge
 Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, Ilko Iliev <iliev@ronetix.at>,
	Kamil Lulko <kamil.lulko@gmail.com>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Dario Binacchi
	<dario.binacchi@amarulasolutions.com>, Dillon Min <dillon.minfei@gmail.com>,
	Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Apurva
 Nandan <a-nandan@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Heiko Schocher
	<hs@nabladev.com>, Masahisa Kojima <kojima.masahisa@socionext.com>, Alex
 Nemirovsky <alex.nemirovsky@cortina-access.com>, Jaehoon Chung
	<jh80.chung@samsung.com>, Michael Trimarchi <michael@amarulasolutions.com>,
	Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, Hal Feng
	<hal.feng@starfivetech.com>, Stefan Roese <stefan.roese@mailbox.org>, Nathan
 Barrett-Morrison <nathan.morrison@timesys.com>, Greg Malysa
	<malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, Vasileios
 Bimpikas <vasileios.bimpikas@analog.com>, Utsav Agarwal
	<utsav.agarwal@analog.com>, Arturs Artamonovs <arturs.artamonovs@analog.com>,
	Anastasiia Lukianenko <vicooodin@gmail.com>, Oleksandr Andrushchenko
	<oleksandr_andrushchenko@epam.com>, Mateusz Kulikowski
	<mateusz.kulikowski@gmail.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Anatolij Gustschin
	<ag.dev.uboot@gmail.com>, Brian Sune <briansune@gmail.com>, Tingting Meng
	<tingting.meng@altera.com>, Mahesh Rao <mahesh.rao@altera.com>, Ye Li
	<ye.li@nxp.com>, Naresh Kumar Ravulapalli
	<nareshkumar.ravulapalli@altera.com>, Jeremy Compostella
	<jeremy.compostella@intel.com>, Bernhard Messerklinger
	<bernhard.messerklinger@at.abb.com>, Debbie Horsfall
	<debbie.horsfall@arm.com>, Harrison Mutai <harrison.mutai@arm.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Anshul
 Dalal <anshuld@ti.com>, Francesco Valla <francesco@valla.it>, Mathieu
 Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Yannic Moog
	<y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, Primoz Fiser
	<primoz.fiser@norik.com>, Hai Pham <hai.pham.ud@renesas.com>, "Guillaume La
 Roque (TI.com)" <glaroque@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>,
	Dhruva Gole <d-gole@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Keerthy
	<j-keerthy@ti.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, Maxim
 Moskalets <maximmosk4@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Adriano
 Cordova <adrianox@gmail.com>, Mark Kettenis <kettenis@openbsd.org>, Osama
 Abdelkader <osama.abdelkader@gmail.com>, Andrew Goodbody
	<andrew.goodbody@linaro.org>, Muhammad Hazim Izzat Zamri
	<muhammad.hazim.izzat.zamri@altera.com>, Quentin Schulz
	<quentin.schulz@cherry.de>, Joseph Chen <chenjh@rock-chips.com>, Finley Xiao
	<finley.xiao@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Elaine Zhang
	<zhangqing@rock-chips.com>, Viorel Suman <viorel.suman@nxp.com>, Sky Huang
	<SkyLake.Huang@mediatek.com>, Lucien.Jheng <lucienzx159@gmail.com>, Loic
 Poulain <loic.poulain@oss.qualcomm.com>, Varadarajan Narayanan
	<quic_varada@quicinc.com>, Alexander Feilke
	<alexander.feilke@ew.tq-group.com>, Markus Niebel
	<Markus.Niebel@ew.tq-group.com>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Christoph Fritz
	<chf.fritz@googlemail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, Sai
 Varun Venkatapuram <saivarun.venkatapuram@amd.com>, E Shattow
	<e@freeshell.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Paul Geurts
	<paul.geurts@prodrive-technologies.com>, =?utf-8?B?Si4gTmV1c2Now6RmZXI=?=
	<j.ne@posteo.net>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Eoin
 Dickson <eoin.dickson@microchip.com>, David Zang <davidzangcs@gmail.com>,
	Brian Ruley <brian.ruley@gehealthcare.com>, Swamil Jain <s-jain1@ti.com>,
	Zixun LI <admin@hifiphile.com>, Antonio Borneo <antonio.borneo@foss.st.com>,
	Sughosh Ganu <sughosh.ganu@linaro.org>, Gabriel Dalimonte
	<gabriel.dalimonte@gmail.com>, =?utf-8?B?VGltbyB0cCBQcmVpw59s?=
	<t.preissl@proton.me>, Alexander Graf <agraf@csgraf.de>, Alper Nebi Yasak
	<alpernebiyasak@gmail.com>, Alexander Sverdlin
	<alexander.sverdlin@siemens.com>, =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?=
	<alvin@pqrs.dk>, Leonard Anderweit <l.anderweit@phytec.de>, Dinesh Maniyam
	<dinesh.maniyam@altera.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>, Ferass El Hafidi
	<funderscore@postmarketos.org>
Subject: Re: [PATCH 00/14] treewide: Clean up usage of DECLARE_GLOBAL_DATA_PTR
Thread-Topic: [PATCH 00/14] treewide: Clean up usage of
 DECLARE_GLOBAL_DATA_PTR
Thread-Index: AQHclPmVOZhfiI7Tykq5GNWvlOXbRrVw2kJA
Date: Tue, 3 Feb 2026 11:42:04 +0000
Message-ID: 
 <PAXPR04MB84594DBC04C4957716EA9C79889BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
In-Reply-To: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8055:EE_
x-ms-office365-filtering-correlation-id: c6733bb0-bd79-491f-ae81-08de63194112
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K2tNN1RpNGhCVnVxUXJFb0dqOVFoelpBL1dvbmgyK0FoYVhGU25pVGZUSCtX?=
 =?utf-8?B?ZGZiWVdKNTlsay9QeVVjQzE2L0xrSVBvVGdPZG5QWUtwZUlrVlpBT243UnYv?=
 =?utf-8?B?VmZUTEIrdy9QcFVmUE9Ha1RrUHNKSDNudzc0b0JuclVUWURETmY0WmdPNTdB?=
 =?utf-8?B?ZndQMlpJZTJOSzVKQm1ocmQrVWtOV0E3eE1CS1Z3YjY0WWJHekQ0czRZbFlh?=
 =?utf-8?B?MDcwVVBsS2tvNU5qbW1CbnhCTWoxTnNYRHJzenYwU3dRL3drVnRLdlVMd2Mw?=
 =?utf-8?B?dmo4U205TWhPcHNmNTloRkNGdGhiTExncWVwWVhlYjlmczJEeitqajNBcDdD?=
 =?utf-8?B?VTROY05haEMwWC8xMEtEa2RoS2FaZTVHREFnUDRMUDhtcEdOSnRPSEtXUWdT?=
 =?utf-8?B?Z0ZrSVRoeHo3cEx2Sk1GcTFWYkh6RkVnNmw3Q3RDejRpZnkyUkV6cENtWDdh?=
 =?utf-8?B?VEptdkFRd3ZNTEI5cUJKVUpYVW1BbVpnOHFzR0t6NXRIaUxleEVqRTlkemlF?=
 =?utf-8?B?NzdYQnpQZVhGWlk4dmpZNUh6aWtwKytqODl1NG5nQlJwSWx6QmcwOXh2Zm5v?=
 =?utf-8?B?YThPWVhvZU9IQUlJK3FJdjE0UnB0SnFWN1lPam9QdW1uZlJFamtadXB3aWho?=
 =?utf-8?B?MkgrajZlaHhpU21DREpsOVkyUjl4RUF3VXp4ZUlOVkE0TThQMEVQQkMzd2kw?=
 =?utf-8?B?RlhYbDFmVXd1dFlBNkxEWGdjVmZUTVRTSk12dzZ3TzZueXFFUy94ZzBqMHk0?=
 =?utf-8?B?SUtZRlE1d3NhaThyU2pUbWh0ZWVsZ2k1OUkyQnd6WWZXSmlmeENUV2x2Qm9q?=
 =?utf-8?B?Rm8veFJTUnVMRlNkMWdJY0xNc0daRVlRK0RUWFdWcGJLYjUvVGlzSENEQmhX?=
 =?utf-8?B?TTh3d1FBVmFreHBIS3pCU1F4SVl4eFZHM056bExSdGo1ZjcwZ2JROTNWbUpW?=
 =?utf-8?B?Nlp6ZStqb2hSQU90OFo1dG9mb28xbDF6NTRRMXFGWXR1enZwdCtUSHRpOGhi?=
 =?utf-8?B?TTcreXFCb2pOQ2lTZE8vejVLek52SE5zRHllLzlKejE5WXNoTGxQeEtVS09M?=
 =?utf-8?B?RnlZVk8ycXhLbXJnZ1BTZVU4RUZVNEtUSS9POU1iTFU5Q0xmZmVvQnRDTmZt?=
 =?utf-8?B?RUpjVHZEb1NZRHJMT3dNK2pCYUtabEdXanJiTXlkTEJjWFEyYks4OVhRSnMv?=
 =?utf-8?B?TGdZZFNJd1YreTRhMGNhL3JXSW5yQTMyMTNYcyt1RGVrc1JMTkRvYjNrQ1Jl?=
 =?utf-8?B?Nzd2dkpmTTZSZHY5M1lHRUdKdmx5eUsrOGlpRU1ySWYrRE9LZjlsWUdXT09D?=
 =?utf-8?B?dHE5QTh0bXdHdVVzNmZSOTI5bndCOUp3ZDNaL0JpaTJ2eC9BK3M5SHFKRGVs?=
 =?utf-8?B?dUU5T09rU29rTVZ6M1VVTU8zYTZWcFN1QTh0b0RUMUFkUkcydnhIejQxWE05?=
 =?utf-8?B?QWZnclh5NWpWK1JURkZhcVpPaGhCTjRteitnd1MxUTJRdGVSamRGcGFTREhQ?=
 =?utf-8?B?andsR2paM01pVEphUjVZRGZYNFdwVGo3SUNZVTY5bjBkZXNWdmoyNWVRblZu?=
 =?utf-8?B?cXN1dEwxRFBDTlovSER4TzNoR0NDMG1INHlLS1ZKRVRlUjdKcktqV2NCWG1j?=
 =?utf-8?B?Q2ZYQXpKS2dTQWNVaGtEUlgyWERHMTVoT1kzUGF0Z2p5TEVDZTJvNUFCdHox?=
 =?utf-8?B?UlhEbEhlWktCVFV3dmV0Qm9SRFpDWlBzN082WFdzQmlBSkRadTdxeHZlN2VD?=
 =?utf-8?B?U01LYmxXUHlTc3dVVnJ6UkM2ejlZbkE1UmM4MUM2TURZNTB1aExJb0xUaUxv?=
 =?utf-8?B?cjVwTWVibW9OTit0cXltNWx3WHBLZk9oaHBhN3ZjV2ZvT0dPRmMrTHNjelZq?=
 =?utf-8?B?NlRCWTg0RU1KMTVyNUs0bUNoMlo2RXVaWEdKYXVLMDNaaUlvNXE1WTVjNytn?=
 =?utf-8?B?S0dPaE9zcVpaZjN3Rzc5di9PVHFzc2JUdnpMRmp0cGZOMjd1MmJaQ2JZT2Ix?=
 =?utf-8?B?ZVFqTXR5YldkL1E1SkVoSWlydXhBcUhaNDBLb2RjZ1NTQnpSVjFSM3dNY2R2?=
 =?utf-8?B?K2VyVnJpYjJaeGoxWG9UVTI0WEZWL0o0WElHZTVNNURIOVU3SUFZL2xDUjBs?=
 =?utf-8?B?ZVo3Sm9SamxicEFBdk5CdG5zYkZWRm5wTnREQ3BYUVQ2SXB6SHJ5Yi9ITzZU?=
 =?utf-8?B?K3c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U1o1Y1RSUjBoMElHcDl4VkY1Z1NrU2R4SXVSRFZPMlg4dzlVcW96TE9MbjE1?=
 =?utf-8?B?V0xUVXhsOEV3aEpFUWp0ODBucWtIRG5rWmhQeWcveVphbWpRWUN3T2Z5RCsz?=
 =?utf-8?B?U0c4WU1MQnJFZ21QRmlRNlI0RTFYYkIzU3liSStCWDdsdjhiQjg5cnhnZHRk?=
 =?utf-8?B?Y1pLMjhCOWZFS1Ewa2RRVFBMV2lRTHl2bjY0Mk5vMVE2U0h2N0ExeUZSK1pP?=
 =?utf-8?B?NjlhcmIvSjdnVjBGREk5cUdONFUrZzdGb0NHQ2NZTWlEc29NSTAxU3pteURh?=
 =?utf-8?B?Z2NWaHJqTDcybW5wS1J6QkJGUWVjUkRYREorWWh3cG9ITWJQdjk2clRVeDRJ?=
 =?utf-8?B?LzVYSmR1WkIzUTlybGZVam4wVklaZHMzSlNtbVZ1SlJ1UXJPejNiRWJobUJh?=
 =?utf-8?B?enVEa1h0NVhMUUUrOURPbVdDRFpwY3pzRG9OMGhYYTllYkJZckp4dVZuNnhz?=
 =?utf-8?B?aXdoN0VlMVc2aU1DWVlzNTZEODdBOHNGaC9GQndpOXVrQTdRWDVIL1VxZWRB?=
 =?utf-8?B?dUlTYlBWcE5rb0ZtWW9IZ3loT0dIV1ZicUVYMGZRaVNyMjlFaWlTZUhTZkFZ?=
 =?utf-8?B?MGFVc0g1NkNhc080NG5zSFFlNkxmZ2hYaXlpOWNwVXcxUnVqeVlqVmd5ZVFz?=
 =?utf-8?B?Ym9sS0xaTTVqczVuQmtOdWxiWC9NeUFTNU9wbXdSa3d5NXpCSURoTzRBeU15?=
 =?utf-8?B?MU1QTXhtbHVLRG1JZURkenNXMUFyZmZhQmJxUnJPY2tzeElDaE13MlJMaVJL?=
 =?utf-8?B?cEx2QjBTbjRCZzMxZk5iVyt1WUU3QUc3NDYreGFlYlVyRlFFZWdVYUtzNTRT?=
 =?utf-8?B?Myt0bEtCTnY3N01XQjQ3OUtEOUxGcFU5bUpHMWpxLzRFcERUTXpDbUF4NnNF?=
 =?utf-8?B?RE5IMjNsai9pdE5JNC9FeHRQVlJ0dkk5NGR3REs0QVAxWktxYXh5VXpkN0FJ?=
 =?utf-8?B?LzJ6em0ySzQ5ckRIQWdGdHAzc2J5T044aDI0cUdSeUxXYkFPNDRtL05zaUsx?=
 =?utf-8?B?N3A4d3ZYNmQ0T3F2bE1jaHJGb2QwdDlpTUE4QXVwdk8xZXJ5YUdUcy9HSUNC?=
 =?utf-8?B?ZDFNMWxqQ3RSRkpOQ2Y0SVFZZUdQaHpRWkczcGUvRjAxYzBiOVhUUGliNHFY?=
 =?utf-8?B?eFV4b1FwZG5EVUNxZzkzZElFdUZmQjlqUjg4ZlIvbGk0c3FHbW42VlErTnNy?=
 =?utf-8?B?Ukk4YlZLTCtBYTJINzdMWWlYM056WVVRYzlhTzNjc0NwdjhzQ0JCS012M3U4?=
 =?utf-8?B?QTFWbXpTYis5a3BTcDgrb0JQekpBUDhBODF4eVBlVDB1RkNWcy9rcEVaU1Nj?=
 =?utf-8?B?RERRbng3dVlna01Xa0xucnQxYnFMeDczZ0JmV2Mrb2JjeUhFMHJvL2RzTTQ5?=
 =?utf-8?B?UXdjaDVYdU1IcFZubkt1TldzWERrTWU4QVNwOEEySkVxQy9md0Z5WmsvK0tQ?=
 =?utf-8?B?VzBadUN5UDNWWVFxbVhNUlpDL1pUSzJEcERPWW90dUlJc0R1OE1ieEFkeHU1?=
 =?utf-8?B?SlBWbDdFVFlSdHNWZXlnSjE5STlObkV2blFyYWRSYkw5YzBLYVhGTEI4c2FU?=
 =?utf-8?B?eFVKYWhGYWJidU5RRStsdVVzYi9pb1pVTnA3b3V2UEVQWDVRMFZDMjVja3A4?=
 =?utf-8?B?TWRKV0tHYU1scGRIdFgwMmtBMitWNFV5eUxIOU1DTXRxRzRDWTluanlKOU0z?=
 =?utf-8?B?S2xCcWFDL05PUGFWR2VYWmp4ZEMvR2lhbXl4K2VzNDNwVFhKRE13aUtRS3JP?=
 =?utf-8?B?bG9JcWJ3Wk5PbXNTT2FWM0RRL2pMMS9wSHVKd3ZHRlF0RTVBd0F4V0JObHhx?=
 =?utf-8?B?UEQ1M1lwZGMxcHpHeHJ3YWhnVnVzbkpadXNyVkpIUyszMnVFa1U5VnRtSU1P?=
 =?utf-8?B?OWJSbHFBcTI3K282SWpubkw4V1h2T3hkakVjdkJMdFhOUnZYT05qV3ZKS1hu?=
 =?utf-8?B?QlpSNS93M01kSkdMOXpmd25id291YlhCRktiZEV3eFVQeHJwSkdsUER5WFo4?=
 =?utf-8?B?WGRadVgzbGd0RFVSQ2R3NFpqWFBPMGUxcmo0RE5PK3JJdkt5elV2dEpTUHR0?=
 =?utf-8?B?aFRlNVBYQ2pxRmlVNUN2MnpuT3JlSHp0Y1VqMWlpUmoyS0t3WC8xVFRLWXNN?=
 =?utf-8?B?cDlrTVNvUGIxQXljY3NmTG56QUI3Q2F1MVBmaEZWTk1kWUF1WGk0UDhYQ1Ar?=
 =?utf-8?B?cGwvbkF2dzB6Vm5tN3JHaENxcG8zYWN5Q1RST1c4QnRVcVl5aEdjWVhLZnFw?=
 =?utf-8?B?QkpoSml6N3RZZDdwYUVqTTNYYTNHd0o3VTI3QkEyL2JveTJoTWRSV3NabkVD?=
 =?utf-8?Q?n672+g/DYWmEsb+fB3?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6733bb0-bd79-491f-ae81-08de63194112
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 11:42:04.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Zg6Dqum1S8Qd+jF23Zkr0nEJhsr6MMqA0hbqNW3+cf9L8fTEGHKXL7/UZLzhDPp04i4SJ8Uv5E/iXfT8nxDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8055
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 04 Feb 2026 09:34:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2908

PiBTdWJqZWN0OiBbUEFUQ0ggMDAvMTRdIHRyZWV3aWRlOiBDbGVhbiB1cCB1c2FnZSBvZg0KPiBE
RUNMQVJFX0dMT0JBTF9EQVRBX1BUUg0KDQpCNCBmYWlscyB0byBzZW5kIHRoZSBsYXN0IDIgcGF0
Y2hlcy4gQW5kIEkgYW0gbm90IHN1cmUgaG93IHRvIHNlbmQNCnBhdGNoIDEzIGFuZCAxNCBpbiB0
aGUgc2FtZSB0aHJlYWQuIFNvIGp1c3QgcmVzZW5kLCBidXQgc2VlbXMNCnJlc2VuZCBzdGlsbCBm
YWlscyBmb3IgcGF0Y2ggMTMgYW5kIDE0LiAoOg0KDQpSZWdhcmRzDQpQZW5nLg0KDQo+IA0KPiBU
aGlzIHBhdGNoIHNldCBwcmltYXJpbHkgcmVtb3ZlcyB1bnVzZWQgREVDTEFSRV9HTE9CQUxfREFU
QV9QVFINCj4gaW5zdGFuY2VzLg0KPiANCj4gTWFueSBmaWxlcyBkZWNsYXJlIERFQ0xBUkVfR0xP
QkFMX0RBVEFfUFRSIGFuZCBpbmNsdWRlDQo+IGFzbS9nbG9iYWxfZGF0YS5oIGV2ZW4gdGhvdWdo
IGdkIGlzIG5ldmVyIHVzZWQuIEluIHRoZXNlIGNhc2VzLA0KPiBhc20vZ2xvYmFsX2RhdGEuaCBp
cyBlZmZlY3RpdmVseSB0cmVhdGVkIGFzIGEgcHJveHkgaGVhZGVyLCB3aGljaCBpcyBub3QNCj4g
YSBnb29kIHByYWN0aWNlLg0KPiANCj4gRm9sbG93aW5nIHRoZSBJbmNsdWRlIFdoYXQgWW91IFVz
ZSBwcmluY2lwbGUsIGZpbGVzIHNob3VsZCBpbmNsdWRlIG9ubHkNCj4gdGhlIGhlYWRlcnMgdGhl
eSBhY3R1YWxseSBkZXBlbmQgb24sIHJhdGhlciB0aGFuIHJlbHlpbmcgb24NCj4gZ2xvYmFsX2Rh
dGEuaCBpbmRpcmVjdGx5LiBUaGlzIGFwcHJvYWNoIGlzIGFsc28gYWRvcHRlZCBpbiBMaW51eCBr
ZXJuZWwNCj4gWzFdLg0KPiANCj4gVGhlIGZpcnN0IGZldyBwYXRjaGVzIGFyZSBwcmVwYXJ0aW9u
IHRvIGF2b2lkIGJ1aWxkaW5nIGJyZWFrIGFmdGVyDQo+IHJlbW92ZSB0aGUgaW5jbHVkaW5nIG9m
IGdsb2JhbF9kYXRhLmguDQo+IA0KPiBBIHNjcmlwdCBpcyBmb3IgZmlsdGVyaW5nIHRoZSBmaWxl
czoNCj4gbGlzdD1gZmluZCAuIC1uYW1lICIqLltjaF0iYA0KPiBmb3Igc291cmNlIGluICR7bGlz
dH0NCj4gZG8NCj4gICAgICAgICByZXN1bHQ9YHNlZCAtbiAnL0RFQ0xBUkVfR0xPQkFMX0RBVEFf
UFRSL3AnICR7c291cmNlfWANCj4gICAgICAgICBpZiBbICIke3Jlc3VsdH0iID09ICJERUNMQVJF
X0dMT0JBTF9EQVRBX1BUUjsiIF07IHRoZW4NCj4gICAgICAgICAgICAgICAgIGVjaG8gIkZvdW5k
IGluICR7c291cmNlfSINCj4gDQo+ICAgICAgICAgICAgICAgICByZXN1bHQ9YHNlZCAtbiAnL1w8
Z2RcPi9wJyAke3NvdXJjZX1gDQo+ICAgICAgICAgICAgICAgICByZXN1bHQyPWBzZWQgLW4gJy9c
PGdkXy9wJyAke3NvdXJjZX1gDQo+ICAgICAgICAgICAgICAgICByZXN1bHQzPWBzZWQgLW4gJy9c
PGdkLT4vcCcgJHtzb3VyY2V9YA0KPiAgICAgICAgICAgICAgICAgaWYgWyAiJHtyZXN1bHR9IiA9
PSAiIiBdICYmIFsgIiR7cmVzdWx0Mn0iID09ICIiIF0gJiYgWyAiJHtyZXN1bHQzfSINCj4gPT0g
IiIgXTt0aGVuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGVjaG8gIkNsZWFudXAgJHtzb3Vy
Y2V9Ig0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzZWQgLWkNCj4gJy9ERUNMQVJFX0dMT0JB
TF9EQVRBX1BUUi97TjsvXG5bWzpzcGFjZTpdXSokL2Q7cy8uKlxuLy87fScNCj4gJHtzb3VyY2V9
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNlZCAtaSAnL0RFQ0xBUkVfR0xPQkFMX0RBVEFf
UFRSL2QnICR7c291cmNlfQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzZWQgLWkgJy9nbG9i
YWxfZGF0YS5oL2QnICR7c291cmNlfQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBnaXQgYWRk
ICR7c291cmNlfQ0KPiAgICAgICAgICAgICAgICAgZmkNCj4gICAgICAgICBmaQ0KPiBkb25lDQo+
IA0KPiBbMV0NCj4gaHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzE3L2NvbnRyaWJ1dGlvbnMvMTYy
MC9hdHRhY2htZW50cy8xMjI4LzI1DQo+IDIwL0xpbnV4JTIwS2VybmVsJTIwSGVhZGVyJTIwT3B0
aW1pemF0aW9uLnBkZg0KPiANCj4gQ0k6IGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L2N1
c3RvZGlhbnMvdS1ib290LW1tYy8tDQo+IC9waXBlbGluZXMvMjkxNzcNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gUGVuZyBGYW4gKDE0
KToNCj4gICAgICAgYmVhY29uOiBpbXg4bW0vbjogRHJvcCB1c2VsZXNzIGZpbGVzDQo+ICAgICAg
IG1lZGlhdGVrOiBtdDc2MjI6IERyb3AgdXNlbGVzcyBib2FyZCBmaWxlcw0KPiAgICAgICBjb21t
b246IGNsaV9odXNoOiBJbmNsdWRlIHZzcHJpbnRmLmgNCj4gICAgICAgY21kOiBtZW06IEluY2x1
ZGUgdnNwcmludGYuaA0KPiAgICAgICB0ZXN0OiBsb2dfZmlsdGVyOiBJbmNsdWRlIHZzcHJpbnRm
LmgNCj4gICAgICAgeHRlbnNhOiByZWxvY2F0ZTogQWRkIG1pc3NpbmcgaGVhZGVycw0KPiAgICAg
ICB0b3JhZGV4OiBjb21tb246IEFkZCBtaXNzaW5nIGhlYWRlcnMNCj4gICAgICAgdGVncmE6IHBt
YzogQ2xlYW51cCBoZWFkZXJzDQo+ICAgICAgIHJvY2tjaGlwOiBldmtfcmszMzA4OiBDbGVhbnVw
IGhlYWRlcnMNCj4gICAgICAgbnhwOiBlbWMyMzA1OiBDbGVhbnVwIGhlYWRlcnMNCj4gICAgICAg
cGNpOiBsYXllcnNwYWNlOiBBZGQgbWlzc2luZyBoZWFkZXIgZmlsZXMNCj4gICAgICAgcmVuZXNh
czogY29tbW9uOiBJbmNsdWRlIGFzbS1nZW5lcmljL3UtYm9vdC5oDQo+ICAgICAgIHNvY2ZwZ2E6
IGNsb2NrX21hbmFnZXJfczEwOiBBZGQgbWlzc2luZyBoZWFkZXIgZmlsZXMNCj4gICAgICAgdHJl
ZXdpZGU6IENsZWFuIHVwIERFQ0xBUkVfR0xPQkFMX0RBVEFfUFRSIHVzYWdlDQo+IA0KPiAgYXJj
aC9hcmMvbGliL2Jvb3RtLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMyAtLS0NCj4gIGFyY2gvYXJtL2NwdS9hcm12Ny9zNXA0NDE4L2NwdS5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL2FybS9tYWNoLWFzcGVlZC9hc3QyNjAw
L3NwbC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYXJjaC9hcm0vbWFj
aC1pbXgvaW14OC9jbG9jay5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0N
Cj4gIGFyY2gvYXJtL21hY2gtaW14L2lteDgvZmR0LmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL2FybS9tYWNoLWlteC9pbXg4L2lvbXV4LmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14
OG0vY2xvY2tfaW14OG1tLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gv
YXJtL21hY2gtaW14L2lteDh1bHAvY2djLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDMgLS0tDQo+ICBhcmNoL2FybS9tYWNoLWlteC9pbXg4dWxwL2Nsb2NrLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9jbG9jay5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gvYXJtL21hY2gt
aW14L2lteDkvY2xvY2tfcm9vdC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+
ICBhcmNoL2FybS9tYWNoLWlteC9taXNjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAzIC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1pbXgvc3BsX2lteF9yb21hcGkuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gvYXJtL21hY2gtbWVzb24vYm9h
cmQtYXhnLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL2Fy
bS9tYWNoLW1lc29uL2JvYXJkLWcxMmEuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAz
IC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1tZXNvbi9ib2FyZC1neC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9jbG9ja19tYW5h
Z2VyX2FnaWxleC5jICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL2FybS9tYWNoLXNv
Y2ZwZ2EvY2xvY2tfbWFuYWdlcl9hZ2lsZXg1LmMgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAg
YXJjaC9hcm0vbWFjaC1zb2NmcGdhL2Nsb2NrX21hbmFnZXJfbjV4LmMgICAgICAgICAgICAgICAg
ICAgfCAgMyAtLS0NCj4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9jbG9ja19tYW5hZ2VyX3MxMC5j
ICAgICAgICAgICAgICAgICAgIHwgIDUgKystLS0NCj4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9t
YWlsYm94X3MxMC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL2Fy
bS9tYWNoLXNvY2ZwZ2EvbWlzY19nZW41LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAz
IC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1zb2NmcGdhL21pc2Nfc29jNjQuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9tbXUtYXJtNjRf
czEwLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL2FybS9tYWNoLXNv
Y2ZwZ2EvcmVzZXRfbWFuYWdlcl9zMTAuYyAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAg
YXJjaC9hcm0vbWFjaC1zb2NmcGdhL3NwbF9hZ2lsZXguYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMyAtLS0NCj4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9zcGxfYWdpbGV4NS5jICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL2FybS9tYWNoLXNvY2ZwZ2Evc3Bs
X2FnaWxleDdtLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYXJjaC9hcm0v
bWFjaC1zb2NmcGdhL3NwbF9nZW41LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAt
LS0NCj4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9zcGxfbjV4LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL2FybS9tYWNoLXNvY2ZwZ2Evc3BsX3MxMC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1zb2Nm
cGdhL3N5c3RlbV9tYW5hZ2VyX3NvYzY0LmMgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFy
Y2gvYXJtL21hY2gtdGVncmEvcG1jLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDQgKy0tLQ0KPiAgYXJjaC9taWNyb2JsYXplL2xpYi9ib290bS5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gvbWlwcy9tYWNoLWF0aDc5L3FjYTk1
NngvZGRyLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL21pcHMv
bWFjaC1tc2NjL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0t
LQ0KPiAgYXJjaC9taXBzL21hY2gtbXRtaXBzL2Rkcl9jYWwuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gvbWlwcy9tYWNoLW9jdGVvbi9jdm14LXBrby5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4gIGFyY2gvbmlvczIvbGliL2Jvb3Rt
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNo
L3Jpc2N2L2NwdS9hbmRlcy9zcGwuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAzIC0tLQ0KPiAgYXJjaC9yaXNjdi9jcHUvY3YxODAwYi9kcmFtLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gvcmlzY3YvY3B1L2dlbmVyaWMvZHJhbS5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL3Jpc2N2L2Nw
dS9rMjMwL2RyYW0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0K
PiAgYXJjaC9yaXNjdi9jcHUvdGgxNTIwL3NwbC5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMiAtLQ0KPiAgYXJjaC9zaC9saWIvYm9vdG0uYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gveDg2L2NwdS9pdnlicmlkZ2Uv
bW9kZWxfMjA2YXguYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBhcmNoL3g4
Ni9saWIvaW5pdF9oZWxwZXJzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAz
IC0tLQ0KPiAgYXJjaC94ODYvbGliL3ppbWFnZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGFyY2gveHRlbnNhL2xpYi9yZWxvY2F0ZS5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKysNCj4gIGFyY2gveHRlbnNhL2xpYi90
aW1lLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBi
b2FyZC9CdVIvYnJzbWFyYzEvYm9hcmQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAzIC0tLQ0KPiAgYm9hcmQvQnVSL2NvbW1vbi9jb21tb24uYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL01hcnZlbGwvb2N0ZW9udHgvc21j
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2FyZC9NYXJ2
ZWxsL29jdGVvbnR4Mi9zbWMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0t
LQ0KPiAgYm9hcmQvYWR2YW50ZWNoL2lteDhtcF9yc2IzNzIwYTEvaW14OG1wX3JzYjM3MjBhMS5j
ICAgICAgICAgfCAgMg0KPiAtLQ0KPiAgYm9hcmQvYWR2YW50ZWNoL2lteDhtcF9yc2IzNzIwYTEv
c3BsLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgYm9hcmQvYWR2YW50ZWNoL2lt
eDhxbV9kbXNzZTIwX2ExL2lteDhxbV9kbXNzZTIwX2ExLmMgICAgICAgfA0KPiAyIC0tDQo+ICBi
b2FyZC9hZHZhbnRlY2gvaW14OHFtX3JvbTc3MjBfYTEvaW14OHFtX3JvbTc3MjBfYTEuYyAgICAg
ICB8DQo+IDMgLS0tDQo+ICBib2FyZC9hbmRlc3RlY2gvdm95YWdlci92b3lhZ2VyLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvYXJtbHRkL3ZleHByZXNzNjQv
dmV4cHJlc3M2NC5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL2Jl
YWNvbi9pbXg4bW0vTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEg
LQ0KPiAgYm9hcmQvYmVhY29uL2lteDhtbS9pbXg4bW1fYmVhY29uLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgOCAtLS0tLS0tLQ0KPiAgYm9hcmQvYmVhY29uL2lteDhtbS9zcGwuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL2JlYWNvbi9p
bXg4bW4vTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgLQ0KPiAg
Ym9hcmQvYmVhY29uL2lteDhtbi9pbXg4bW5fYmVhY29uLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgOCAtLS0tLS0tLQ0KPiAgYm9hcmQvYmVhY29uL2lteDhtbi9zcGwuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL2JlYWNvbi9pbXg4bXAv
c3BsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2Fy
ZC9iZWFnbGUvYmVhZ2xlYm9uZWFpNjQvYmVhZ2xlYm9uZWFpNjQuYyAgICAgICAgICAgICAgICB8
ICAyIC0tDQo+ICBib2FyZC9iZWFnbGUvYmVhZ2xlcGxheS9iZWFnbGVwbGF5LmMgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyIC0tDQo+ICBib2FyZC9icm9hZGNvbS9iY21ucy9ucy5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvY2xvb3MvaW14
OG1tX3BoZy9pbXg4bW1fcGhnLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4g
IGJvYXJkL2Nsb29zL2lteDhtbV9waGcvc3BsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDMgLS0tDQo+ICBib2FyZC9jb21wdWxhYi9pbXg4bW0tY2wtaW90LWdhdGUvc3BsLmMg
ICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQo+ICBib2FyZC9jb3JlYm9vdC9jb3JlYm9vdC9j
b3JlYm9vdC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvY3Nz
aS9jbXBjODg1L2NtcGM4ODUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAt
LQ0KPiANCj4gYm9hcmQvZGF0YV9tb2R1bC9pbXg4bW1fZWRtX3NiYy9pbXg4bW1fZGF0YV9tb2R1
bF9lZG1fc2INCj4gYy5jIHwgIDIgLS0NCj4gIGJvYXJkL2RhdGFfbW9kdWwvaW14OG1tX2VkbV9z
YmMvc3BsLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4gDQo+IGJvYXJkL2RhdGFf
bW9kdWwvaW14OG1wX2VkbV9zYmMvaW14OG1wX2RhdGFfbW9kdWxfZWRtX3NiYy4NCj4gYyB8ICAy
IC0tDQo+ICBib2FyZC9kYXRhX21vZHVsL2lteDhtcF9lZG1fc2JjL3NwbC5jICAgICAgICAgICAg
ICAgICAgICAgICB8ICAyIC0tDQo+ICBib2FyZC9kaGVsZWN0cm9uaWNzL2RoX2lteDhtcC9jb21t
b24uYyAgICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQo+ICBib2FyZC9kaGVsZWN0cm9uaWNz
L2RoX2lteDhtcC9pbXg4bXBfZGhjb21fcGRrMi5jICAgICAgICAgICB8ICAyIC0tDQo+ICBib2Fy
ZC9kaGVsZWN0cm9uaWNzL2RoX2lteDhtcC9zcGwuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAyIC0tDQo+ICBib2FyZC9lbWNyYWZ0L2lteDhtcF9uYXZxcC9zcGwuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvZW11bGF0aW9uL3FlbXUtcmlzY3YvcWVt
dS1yaXNjdi5jICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgYm9hcmQvZW5naWNhbS9p
bXg4bW0vaWNvcmVfbXg4bW0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAg
Ym9hcmQvZW5naWNhbS9pbXg4bW0vc3BsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMiAtLQ0KPiAgYm9hcmQvZW5naWNhbS9pbXg4bXAvaWNvcmVfbXg4bXAuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL2VuZ2ljYW0vaW14OG1wL3NwbC5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2FyZC9nZHN5
cy9tcGM4MzA4L2dhemVyYmVhbS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0t
LQ0KPiAgYm9hcmQvZ29vZ2xlL2lteDhtcV9waGFuYmVsbC9pbXg4bXFfcGhhbmJlbGwuYyAgICAg
ICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL2hpZ2hiYW5rL2hpZ2hiYW5rLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2FyZC9rb250cm9uL29zbS1z
LW14OG1wL29zbS1zLW14OG1wLmMgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9h
cmQva29udHJvbi9vc20tcy1teDkzL29zbS1zLW14OTMuYyAgICAgICAgICAgICAgICAgICAgICAg
fCAgMyAtLS0NCj4gIGJvYXJkL2tvbnRyb24vcGl0eF9pbXg4bS9waXR4X2lteDhtLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4gIGJvYXJkL21lZGlhdGVrL210NzYyMi9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGJvYXJkL21lZGlhdGVr
L210NzYyMi9tdDc2MjJfcmZiLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTIgLS0tLS0t
LS0tLS0tDQo+ICBib2FyZC9tbnRyZS9pbXg4bXFfcmVmb3JtMi9pbXg4bXFfcmVmb3JtMi5jICAg
ICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvbXNjL3NtMnNfaW14OG1wL3NtMnNfaW14
OG1wLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgYm9hcmQvbXNjL3NtMnNf
aW14OG1wL3NwbC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4g
IGJvYXJkL254cC9jb21tb24vZW1jMjMwNS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDQgKy0tLQ0KPiAgYm9hcmQvbnhwL2lteDhtbV9ldmsvaW14OG1tX2V2ay5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL254cC9pbXg4bW1fZXZrL3Nw
bC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2FyZC9u
eHAvaW14OG1uX2V2ay9zcGwuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAz
IC0tLQ0KPiAgYm9hcmQvbnhwL2lteDhtcF9ldmsvc3BsLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL254cC9pbXg4cW1fbWVrL2lteDhxbV9tZWsu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2FyZC9ueHAvaW14OHF4
cF9tZWsvaW14OHF4cF9tZWsuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAg
Ym9hcmQvbnhwL2lteDh1bHBfZXZrL2lteDh1bHBfZXZrLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMiAtLQ0KPiAgYm9hcmQvbnhwL2lteDh1bHBfZXZrL3NwbC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgYm9hcmQvbnhwL2lteDkzX2ZyZG0vaW14OTNf
ZnJkbS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL3BoeXRl
Yy9pbXg4bXAtbGlicmEtZnBzYy9zcGwuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0t
DQo+ICBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vcGh5Y29yZS1pbXg4bW0uYyAgICAgICAg
ICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL3NwbC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL3BoeXRlYy9waHljb3Jl
X2lteDhtcC9waHljb3JlLWlteDhtcC5jICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2Fy
ZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAzIC0tLQ0KPiAgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvcGh5Y29yZS1pbXg5My5jICAg
ICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL3BvbHloZXgvaW14OG1wX2RlYml4X21v
ZGVsX2EvaW14OG1wX2RlYml4X21vZGVsX2EuYyAgIHwNCj4gMyAtLS0NCj4gIGJvYXJkL3BvbHlo
ZXgvaW14OG1wX2RlYml4X21vZGVsX2Evc3BsLmMgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0t
DQo+ICBib2FyZC9wdXJpc20vbGlicmVtNS9saWJyZW01LmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyIC0tDQo+ICBib2FyZC9wdXJpc20vbGlicmVtNS9zcGwuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQo+ICBib2FyZC9xdWFsY29tbS9kcmFnb25i
b2FyZDQxMGMvZHJhZ29uYm9hcmQ0MTBjLmMgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQv
cXVhbGNvbW0vZHJhZ29uYm9hcmQ4MjBjL2RyYWdvbmJvYXJkODIwYy5jICAgICAgICAgICAgfCAg
MyAtLS0NCj4gIGJvYXJkL3JlbmVzYXMvY29tbW9uL2dlbjMtY29tbW9uLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDQgKy0tLQ0KPiAgYm9hcmQvcmVuZXNhcy9jb21tb24vZ2VuNC1jb21t
b24uYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArLS0tDQo+ICBib2FyZC9yZW5lc2Fz
L2NvbW1vbi9nZW41LWNvbW1vbi5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstLS0N
Cj4gIGJvYXJkL3JvY2tjaGlwL2V2Yl9yazMzMDgvZXZiX3JrMzMwOC5jICAgICAgICAgICAgICAg
ICAgICAgIHwgIDUgKystLS0NCj4gIGJvYXJkL3JvbmV0aXgvaW14OG1xLWNtL2lteDhtcV9jbS5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4gIGJvYXJkL3NhbXN1bmcvY29tbW9u
L2V4eW5vczUtZHQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2Fy
ZC9zYW1zdW5nL2NvbW1vbi9taXNjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAzIC0tLQ0KPiAgYm9hcmQvc3Qvc3RtMzJmNDI5LWRpc2NvdmVyeS9zdG0zMmY0MjktZGlzY292
ZXJ5LmMgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL3N0L3N0bTMyZjQyOS1ldmFsdWF0aW9u
L3N0bTMyZjQyOS1ldmFsdWF0aW9uLmMgICAgICAgIHwgIDMgLS0tDQo+ICBib2FyZC9zdC9zdG0z
MmY0NjktZGlzY292ZXJ5L3N0bTMyZjQ2OS1kaXNjb3ZlcnkuYyAgICAgICAgICB8ICAzIC0tLQ0K
PiAgYm9hcmQvc3Qvc3RtMzJmNzQ2LWRpc2NvL3N0bTMyZjc0Ni1kaXNjby5jICAgICAgICAgICAg
ICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL3N0L3N0bTMyaDc0My1kaXNjby9zdG0zMmg3NDMtZGlz
Y28uYyAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2FyZC9zdC9zdG0zMmg3NDMtZXZh
bC9zdG0zMmg3NDMtZXZhbC5jICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQv
c3Qvc3RtMzJoNzQ3LWRpc2NvL3N0bTMyaDc0Ny1kaXNjby5jICAgICAgICAgICAgICAgICAgfCAg
MyAtLS0NCj4gIGJvYXJkL3N0L3N0bTMyaDc1MC1hcnQtcGkvc3RtMzJoNzUwLWFydC1waS5jICAg
ICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2FyZC90ZWNobmV4aW9uL3BpY28taW14OG1xL3Bp
Y28taW14OG1xLmMgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvdGkvYW02Mngv
ZXZtLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAg
Ym9hcmQvdGkvYW02NHgvZXZtLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMiAtLQ0KPiAgYm9hcmQvdGkvajc4NHM0L2V2bS5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgYm9hcmQvdG9yYWRleC9hcGFsaXMtaW14OC9h
cGFsaXMtaW14OC5jICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL3RvcmFk
ZXgvYXBhbGlzX3QzMC9hcGFsaXNfdDMwLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0t
DQo+ICBib2FyZC90b3JhZGV4L2NvbGlicmktaW14OHgvY29saWJyaS1pbXg4eC5jICAgICAgICAg
ICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvdG9yYWRleC9jb2xpYnJpX3QyMC9jb2xpYnJpX3Qy
MC5jICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL3RvcmFkZXgvY29tbW9u
L3RkeC1jZmctYmxvY2suYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBib2Fy
ZC90b3JhZGV4L2NvbW1vbi90ZHgtY2ZnLWJsb2NrLmggICAgICAgICAgICAgICAgICAgICAgICB8
ICAyICsrDQo+ICBib2FyZC90b3JhZGV4L2NvbW1vbi90ZHgtY29tbW9uLmggICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyICsrDQo+ICBib2FyZC90b3JhZGV4L3NtYXJjLWlteDhtcC9zbWFy
Yy1pbXg4bXAuYyAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvdG9yYWRleC9z
bWFyYy1pbXg4bXAvc3BsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4g
IGJvYXJkL3RvcmFkZXgvdmVyZGluLWlteDhtbS9zcGwuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDMgLS0tDQo+ICBib2FyZC90b3JhZGV4L3ZlcmRpbi1pbXg4bW0vdmVyZGluLWlteDht
bS5jICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9hcmQvdG9yYWRleC92ZXJkaW4taW14
OG1wL3NwbC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJvYXJkL3Rv
cmFkZXgvdmVyZGluLWlteDhtcC92ZXJkaW4taW14OG1wLmMgICAgICAgICAgICAgICAgIHwgIDMg
LS0tDQo+ICBib2FyZC94aWxpbngvenlucS9ib290aW1nLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAzIC0tLQ0KPiAgYm9vdC9ib290bWV0aC11Y2xhc3MuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgYm9vdC9mZHRfc2ltcGxlZmIu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGJv
b3QvaW1hZ2Utc2lnLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIgLS0NCj4gIGJvb3QvaW1hZ2UuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBjbWQvYmxvYmxpc3QuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgY21kL2Jvb3RlZmku
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0N
Cj4gIGNtZC9ib290bS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDMgLS0tDQo+ICBjbWQvZGF0ZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgY21kL21lbS5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArLS0tDQo+ICBjbWQv
c291bmQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAzIC0tLQ0KPiAgY21kL3NwbC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGNvbW1vbi9jbGlfaHVzaC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0tLQ0KPiAgY29tbW9uL3N0ZGlv
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0N
Cj4gIGRyaXZlcnMvYmxvY2svc2FuZGJveC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL2Jvb3Rjb3VudC9wbWljX3BmdXplMTAwLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQo+ICBkcml2ZXJzL2NhY2hlL3NhbmRib3hf
Y2FjaGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVy
cy9jbGsvYWx0ZXJhL2Nsay1hZ2lsZXguYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MyAtLS0NCj4gIGRyaXZlcnMvY2xrL2FsdGVyYS9jbGstYWdpbGV4NS5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL2Nsay9hbHRlcmEvY2xrLW1lbS1uNXgu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9jbGsvYWx0
ZXJhL2Nsay1uNXguYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4g
IGRyaXZlcnMvY2xrL3JvY2tjaGlwL2Nsa19weDMwLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL2Nsay9yb2NrY2hpcC9jbGtfcmszMzA4LmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9jbGsvcm9ja2NoaXAvY2xr
X3JrMzUyOC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy9j
bGsvcm9ja2NoaXAvY2xrX3JrMzU2OC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAt
LQ0KPiAgZHJpdmVycy9jbGsvcm9ja2NoaXAvY2xrX3JrMzU3Ni5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy9jbGsvcm9ja2NoaXAvY2xrX3JrMzU4OC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy9jbGsvcm9ja2NoaXAv
Y2xrX3J2MTEwOC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZl
cnMvY2xrL3JvY2tjaGlwL2Nsa19ydjExMjYuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDIgLS0NCj4gIGRyaXZlcnMvY3B1L2JjbTI4M3hfY3B1LmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL2NwdS9jcHUtdWNsYXNzLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQo+ICBkcml2ZXJzL2NwdS9pbXg4
X2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAg
ZHJpdmVycy9jcHUvbXRrX2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvZmlybXdhcmUvYXJtLWZmYS9hcm0tZmZhLXVjbGFzcy5j
ICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL2Zpcm13YXJlL2FybS1mZmEv
YXJtLWZmYS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9m
aXJtd2FyZS9hcm0tZmZhL2ZmYS1lbXVsLXVjbGFzcy5jICAgICAgICAgICAgICAgICAgfCAgMyAt
LS0NCj4gIGRyaXZlcnMvZmlybXdhcmUvYXJtLWZmYS9zYW5kYm94X2ZmYS5jICAgICAgICAgICAg
ICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL2dwaW8vZ3Bpby11Y2xhc3MuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9ncGlvL254X2dw
aW8uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRy
aXZlcnMvaTJjL214Y19pMmMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDMgLS0tDQo+ICBkcml2ZXJzL2kyYy9ueF9pMmMuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9pMmMvb2NvcmVzX2kyYy5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvaTJj
L3NvZnRfaTJjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0t
DQo+ICBkcml2ZXJzL2kyYy9zeW5xdWFjZXJfaTJjLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyIC0tDQo+ICBkcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQo+ICBkcml2ZXJzL21pc2MvYXRzaGEyMDRh
LWkyYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVy
cy9taXNjL2ZzX2xvYWRlci5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MyAtLS0NCj4gIGRyaXZlcnMvbWlzYy9pbXg4L2Z1c2UuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL21tYy9jYV9kd19tbWMuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9tbWMvZl9z
ZGgzMC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAg
ZHJpdmVycy9tbWMvanpfbW1jLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvbW1jL21zbV9zZGhjaS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL21tYy9tdl9zZGhjaS5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9t
dGQvbmFuZC9yYXcvcHhhM3h4X25hbmQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAt
LS0NCj4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L3RlZ3JhX25hbmQuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL210ZC9udm14aXAvbnZteGlwX3FzcGkuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpL3Nm
LXVjbGFzcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRy
aXZlcnMvbmV0L2R3bWFjX3M3MDAuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDMgLS0tDQo+ICBkcml2ZXJzL25ldC9mZWNfbXhjLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9uZXQvZ21hY19yb2NrY2hpcC5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy9uZXQv
bXZuZXRhLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0N
Cj4gIGRyaXZlcnMvbmV0L29jdGVvbnR4L3NtaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL25ldC9waHkvZml4ZWQuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9uZXQvcGh5L3BoeS5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZl
cnMvbmV0L3BoeS94aWxpbnhfZ21paTJyZ21paS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDMgLS0tDQo+ICBkcml2ZXJzL25ldC9zYW5kYm94LXJhdy5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9uZXQvc2FuZGJveC5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvbmV0L3Rp
L2tleXN0b25lX25ldC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+
ICBkcml2ZXJzL25ldC94aWxpbnhfYXhpX2VtYWMuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9wY2kvcGNpX29jdGVvbnR4LmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvcGNpL3BjaWVfZHdfbWVz
b24uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJz
L3BjaS9wY2llX2R3X3Fjb20uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAz
IC0tLQ0KPiAgZHJpdmVycy9wY2kvcGNpZV9kd19yb2NrY2hpcC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvcGNpL3BjaWVfZHdfdGkuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL3BjaS9wY2ll
X2xheWVyc2NhcGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAg
ZHJpdmVycy9wY2kvcGNpZV9sYXllcnNjYXBlLmggICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNCArKystDQo+ICBkcml2ZXJzL3BjaS9wY2llX3N0YXJmaXZlX2poNzExMC5jICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9wY2lfZW5kcG9pbnQvcGNp
X2VwLXVjbGFzcy5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMv
cGh5L21hcnZlbGwvY29tcGh5X2NvcmUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMg
LS0tDQo+ICBkcml2ZXJzL3BoeS9vbWFwLXVzYjItcGh5LmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9waHkvcm9ja2NoaXAvcGh5LXJvY2tjaGlw
LXBjaWUuYyAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvcGh5L3JvY2tj
aGlwL3BoeS1yb2NrY2hpcC10eXBlYy5jICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBk
cml2ZXJzL3BpbmN0cmwvbXRtaXBzL3BpbmN0cmwtbXQ3NjI4LmMgICAgICAgICAgICAgICAgICAg
ICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9waW5jdHJsL25leGVsbC9waW5jdHJsLW5leGVsbC5jICAg
ICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvcGluY3RybC9uZXhlbGwvcGlu
Y3RybC1zNXB4eDE4LmMgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL3Bp
bmN0cmwvbnhwL3BpbmN0cmwtaW14LW1taW8uYyAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0t
LQ0KPiAgZHJpdmVycy9waW5jdHJsL254cC9waW5jdHJsLWlteC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvcGluY3RybC9ueHAvcGluY3RybC1pbXg4LmMg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvbnhw
L3BpbmN0cmwtbXhzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJp
dmVycy9wb3dlci9kb21haW4vaW14OG0tcG93ZXItZG9tYWluLmMgICAgICAgICAgICAgICAgICAg
fCAgMyAtLS0NCj4gIGRyaXZlcnMvcG93ZXIvcG1pYy9iZDcxODM3LmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL3Bvd2VyL3BtaWMvbWMzNDcwOC5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9wb3dl
ci9wbWljL21wNTQxNi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0N
Cj4gIGRyaXZlcnMvcG93ZXIvcG1pYy9wY2E5NDUwLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL3Bvd2VyL3JlZ3VsYXRvci9wd21fcmVndWxhdG9y
LmMgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9wd20vcHdtLXNpZml2
ZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZl
cnMvcHdtL3JrX3B3bS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDMgLS0tDQo+ICBkcml2ZXJzL3B3bS9zdW54aV9wd20uYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9yYW0vc3RtMzJtcDEvc3RtMzJtcDFf
dGVzdHMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvcmVib290
LW1vZGUvcmVib290LW1vZGUtZ3Bpby5jICAgICAgICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4g
IGRyaXZlcnMvcmVib290LW1vZGUvcmVib290LW1vZGUtcnRjLmMgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDIgLS0NCj4gIGRyaXZlcnMvcmVtb3RlcHJvYy9ycHJvYy11Y2xhc3MuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4gIGRyaXZlcnMvc2VyaWFsL25zMTY1NTAuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL3Nl
cmlhbC9zYW5kYm94LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0t
LQ0KPiAgZHJpdmVycy9zZXJpYWwvc2VyaWFsX2FkaV91YXJ0NC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy9zZXJpYWwvc2VyaWFsX2h0aWYuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvc2VyaWFsL3Nlcmlh
bF94ZW4uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2
ZXJzL3NtZW0vbXNtX3NtZW0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAzIC0tLQ0KPiAgZHJpdmVycy9zcGkvY2Ffc2ZsYXNoLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvc3BpL21pY3JvY2hpcF9jb3JlcXNw
aS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4gIGRyaXZlcnMvc3BpL212
ZWJ1X2EzNzAwX3NwaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+
ICBkcml2ZXJzL3NwaS9vbWFwM19zcGkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9zcGkvc3BpLXN1bnhpLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1zeW5xdWFj
ZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4gIGRyaXZlcnMv
c3BpL3NwaS11Y2xhc3MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMg
LS0tDQo+ICBkcml2ZXJzL3NwaS90ZWdyYTIxMF9xc3BpLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9zcG1pL3NwbWktbXNtLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvdGhlcm1hbC9p
bXhfdG11LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBk
cml2ZXJzL3RpbWVyL29zdG1fdGltZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAzIC0tLQ0KPiAgZHJpdmVycy90aW1lci9zcDgwNF90aW1lci5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvdXNiL2NvbW1vbi9jb21tb24u
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2ZXJzL3Vz
Yi9waHkvcm9ja2NoaXBfdXNiMl9waHkuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0t
LQ0KPiAgZHJpdmVycy91c2IvdGNwbS90Y3BtLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy92aWRlby9oeDgyMzhkLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy92aWRlby9pbXgvbXhj
X2lwdXYzX2ZiLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZl
cnMvdmlkZW8vbmV4ZWxsX2Rpc3BsYXkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDMgLS0tDQo+ICBkcml2ZXJzL3ZpZGVvL3JvY2tjaGlwL3JrX2x2ZHMuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy92aWRlby9yb2NrY2hpcC9ya19taXBp
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvdmlkZW8v
c2FuZGJveF9zZGwuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+
ICBkcml2ZXJzL3ZpZGVvL3RpZHNzL3RpZHNzX2Rydi5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAyIC0tDQo+ICBkcml2ZXJzL3ZpZGVvL3p5bnFtcC96eW5xbXBfZHBzdWIuYyAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy93YXRjaGRvZy9hcm1hZGEt
Mzd4eC13ZHQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMv
d2F0Y2hkb2cvYXQ5MXNhbTlfd2R0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMg
LS0tDQo+ICBkcml2ZXJzL3dhdGNoZG9nL210NzYyMV93ZHQuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy93YXRjaGRvZy9vcmlvbl93ZHQuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGRyaXZlcnMvd2F0Y2hkb2cv
c2JzYV9nd2R0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBk
cml2ZXJzL3dhdGNoZG9nL3dkdC11Y2xhc3MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAzIC0tLQ0KPiAgZnMvZnMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGZzL3ViaWZzL3ViaWZzLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBpbmNsdWRlL3Jl
bG9jYXRlLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyIC0t
DQo+ICBsaWIvZWZpX2xvYWRlci9lZmlfY2Fwc3VsZS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAzIC0tLQ0KPiAgbGliL2VmaV9sb2FkZXIvZWZpX2dvcC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIGxpYi9lZmlfbG9hZGVyL2VmaV9y
bmcuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBuZXQv
ZXRoLXVjbGFzcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAzIC0tLQ0KPiAgbmV0L3RmdHAuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIG5ldC93Z2V0LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICB0ZXN0L2NtZC9leGl0
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0K
PiAgdGVzdC9jbWQvdGVzdF9lY2hvLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMyAtLS0NCj4gIHRlc3QvY21kL3Rlc3RfcGF1c2UuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICB0ZXN0L2RtL2Jsay5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzIC0tLQ0KPiAgdGVzdC9k
bS9pM2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MiAtLQ0KPiAgdGVzdC9saWIvdGVzdF9wcmludC5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyAtLS0NCj4gIHRlc3QvbG9nL2xvZ19maWx0ZXIuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0tLQ0KPiAgMzA2IGZpbGVzIGNoYW5n
ZWQsIDIyIGluc2VydGlvbnMoKyksIDg2NyBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29t
bWl0OiAxZGUxMDNmYzI5NzYxZmE3MjlkZmZhYTE1ZDBjZmIyNzY2YmUwNWU0DQo+IGNoYW5nZS1p
ZDogMjAyNjAyMDItY2xlYW51cC01NjBjOTAwZjdiYzMNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
LS0NCj4gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNCg==

