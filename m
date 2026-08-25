Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AA0C61DCD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:39 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22940.1787667000688972471
 for <u-boot-amlogic@groups.io>;
 Tue, 25 Aug 2026 07:10:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=proofpoint-05-2026 header.b=B3dg27M/;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=r2W0s4li;
 spf=pass (domain: ti.com, ip: 148.163.150.75, mailfrom: bb@ti.com)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PAvYWM765973;
	Tue, 25 Aug 2026 08:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=4TkEX2sEfvhr4FK
	28s4hXdV7ME/N+cvtFVnXhvqr9uE=; b=B3dg27M/mSM73NYsG2wdIUYrsoAjV3+
	u45RAdcC9RuxxMKirN07xjYrUc3loLZiZBK1eo8oJNd3r41gHYBQy1fgCxjFYPNC
	xEYWoOQfYtrhW7w7E56TEDe2q8sfXWbk23Eau9i3CKPVAwmTFwoOPGLszvS2/4Gh
	8leJ8zqttzfigPc+JxG5mnwywg30Wy50eLzxozu5TE1IcYjXBZnex4DaGpkElEUY
	Ua4q3PBlMrkBJz0cRM44PGo//kxhP/FxouJBDY/YdiTn3z/Q6WKuD9ohSTQKMZdq
	7u+w++kmyXYgQ1Z7VAFYkkr9WjqvrLQMv9vNGC6TfLbMShaZvqg0mnQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxkbtw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 08:48:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj9LEuT+2HWVaTyD5Bk/9tcbXl9ASAAJ8YZ8uFOcdZskYpfr5eb5TU5eqDgMkhlg6OhJICVPE3kEztSRnsZ5+mB0birLFn2eBkJDOWLWNo1EpiOpm7fd2AFhy+l8miCk/NajLzASuIwmE7VaK/rHnAbxtn9F3Pcov9J0vw29SvD2/fRFvOLPeDy3myLgPIxl+8oikLtRQ+0dB3SoCkLhlvfRVjtrLEi3+QjeXtSmzoAF3uPjUhEYtPstjBfICOROMgk5CVmF/cR42UFYUxrXN3/E24uXh2BMBQ6H37W7Cic6C5+o22+lObkRcGFPNgfFNiGdIzuPsQ35uqs0fW/W/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TkEX2sEfvhr4FK28s4hXdV7ME/N+cvtFVnXhvqr9uE=;
 b=l3og4tN/s3idEgk37sOO6hVMuu2vq1dlQRBUgBq0jTkN1i2oPb4HdGGQkFJ/w56BFcruiOd8Y3DysCIBccSO/Ac62AbKcAZWsx1RYmE4xRT9kD45x6FBkde3uckmx4sfHNkF+t5RR4lQToxyBmLbph/Svxa2K4C7bgSffeK8CE/AyjxWh+Xz3cbCjKF2qlWBOUsDKyVVnHMYStqEUsIokVv725cBuVdbbyqlZuBSdjQH4h/JVwau9sKz6YiENCvyDPNRGMmWTzc2pv9AAQouIgFdFvl7mPfm2WpSzjV1XG97DWbpDgm6GkwZN+1i5z4CxlRBj3jVMAW92RsaB00C8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=groups.io smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TkEX2sEfvhr4FK28s4hXdV7ME/N+cvtFVnXhvqr9uE=;
 b=r2W0s4liPpBXMnewYLuo8Q+s7fNRnqDACsgUbB74wHGecm05iI68bzivO1RSbM7bczoWBWrW6U4BYMw9MblNcGg578DhTPWo2sXGDq/FHA4ki8JFqBeJBB8HiFIp6vilQ6klgppougwZ6XD6bOleZkigFErkUYD60goZQKgNMOQ=
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by DS0PR10MB7127.namprd10.prod.outlook.com (2603:10b6:8:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:48:17 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::35) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 13:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 13:48:17 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 08:48:14 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 08:48:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 08:48:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PDmCcH2111203;
	Tue, 25 Aug 2026 08:48:12 -0500
Date: Tue, 25 Aug 2026 08:48:12 -0500
From: Bryan Brattlof <bb@ti.com>
To: Michal Simek <michal.simek@amd.com>
CC: <u-boot@lists.u-boot-project.org>, <git@amd.com>,
        Tom Rini
	<trini@konsulko.com>, Aaron Williams <awilliams@marvell.com>,
        Adam Ford
	<aford173@gmail.com>,
        Alban Bedel <alban.bedel@avionic-design.de>,
        "Alif
 Zakuan Yuslaimi" <alif.zakuan.yuslaimi@altera.com>,
        Allen Martin
	<amartin@nvidia.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Ashish Kumar
	<Ashish.Kumar@nxp.com>,
        Casey Connolly <casey.connolly@linaro.org>,
        "Chee
 Hong Ang" <chee.hong.ang@intel.com>,
        Chee Tien Fong
	<tien.fong.chee@intel.com>,
        Chin-Liang See <chin.liang.see@intel.com>,
        Chris
 Packham <chris.packham@alliedtelesis.co.nz>,
        Chunfeng Yun
	<chunfeng.yun@mediatek.com>,
        "Cogent Embedded, Inc."
	<source@cogentembedded.com>,
        David Lechner <dlechner@baylibre.com>,
        "Dinh
 Nguyen" <dinh.nguyen@intel.com>,
        Dominik Haller <d.haller@phytec.de>,
        "Dzmitry Sankouski" <dsankouski@gmail.com>,
        Eric =?utf-8?Q?B=C3=A9nard?=
	<eric@eukrea.com>,
        Eugen Hristev <ehristev@kernel.org>,
        Fabio Estevam
	<festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        GSS_MTK_Uboot_upstream
	<GSS_MTK_Uboot_upstream@mediatek.com>,
        Garrett Giordano
	<ggiordano@phytec.com>,
        Gilles Talis <gilles.talis@gmail.com>,
        Green Wan
	<green.wan@sifive.com>, Hans de Goede <hdegoede@redhat.com>,
        Heiko Schocher
	<hs@nabladev.com>,
        Holger Brunck <holger.brunck@hitachienergy.com>,
        Ian Ray
	<ian.ray@gehealthcare.com>,
        Igor Belwon
	<igor.belwon@mentallysanemainliners.org>,
        Ilias Apalodimas
	<ilias.apalodimas@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        "Jan
 Kiszka" <jan.kiszka@siemens.com>,
        Johan Jonker <jbx6244@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>,
        Jonas =?utf-8?B?U2Nod8O2YmVs?=
	<jonasschwoebel@yahoo.de>,
        Jorge Ramirez-Ortiz
	<jorge.ramirez.ortiz@gmail.com>,
        Julien Stephan <jstephan@baylibre.com>,
        Kever Yang <kever.yang@rock-chips.com>, Le Jin <le.jin@siemens.com>,
        "Ley
 Foon Tan" <ley.foon.tan@intel.com>,
        Lim Siew Chin
	<elly.siew.chin.lim@intel.com>,
        Marek =?utf-8?B?QmVow7pu?=
	<kabel@kernel.org>,
        Marek Vasut <marek.vasut+socfpga@mailbox.org>,
        Martyn
 Welch <martyn.welch@collabora.com>,
        Masakazu Mochizuki
	<masakazu.mochizuki.wd@hitachi.com>,
        Mathew McBride <matt@traverse.com.au>,
        Matthias Winker <matthias.winker@de.bosch.com>,
        "Matwey V. Kornilov"
	<matwey.kornilov@gmail.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nobuhiro Iwamatsu
	<iwamatsu@nigauri.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Parthiban Nallathambi <parthiban@linumiz.com>,
        Paul Walmsley
	<paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>,
        Peter Geis
	<pgwipeout@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        "maintainer:TK1-SOM BOARD" <Peter.Chubb@data61.csiro.au>,
        Philip Oberfichtner
	<pro@denx.de>,
        "Pramod Kumar" <pramod.kumar_1@nxp.com>,
        Priyanka Jain
	<priyanka.jain@nxp.com>,
        Quentin Schulz <u-boot@0leil.net>, Randolph
	<randolph@andestech.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>, Sam Day
	<me@samcday.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Shengzhou Liu
	<Shengzhou.Liu@nxp.com>, Simon Glass <sjg@chromium.org>,
        Simon Goldschmidt
	<simon.k.r.goldschmidt@gmail.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Sinan Akman <sinan@writeme.com>, Stefan Bosch <stefan_b@posteo.net>,
        Stefan
 Roese <sr@denx.de>, Stefano Babic <sbabic@nabladev.com>,
        Stelian Pop
	<stelian@popies.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sumit Garg
	<sumit.garg@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Teresa Remmet
	<t.remmet@phytec.de>,
        Tien Fong Chee <tien.fong.chee@altera.com>,
        Tim Harvey
	<tharvey@gateworks.com>, Tom Warren <twarren@nvidia.com>,
        Tony Dinh
	<mibodhi@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Wadim Egorov
	<w.egorov@phytec.de>, Wasim Khan <wasim.khan@nxp.com>,
        Weijie Gao
	<weijie.gao@mediatek.com>,
        "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        "open list:P212"
	<u-boot-amlogic@groups.io>,
        "open list:ARM SNAPDRAGON"
	<u-boot-qcom@groups.io>,
        "open list:phyCORE-AM62ax"
	<upstream@lists.phytec.de>,
        =?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas
	<noltari@gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
Message-ID: <20260825134812.nlq25ymj5gsnmdvb@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
MIME-Version: 1.0
In-Reply-To: <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DS0PR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b24f38-4094-49d1-2bac-08df02af8473
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|36860700016|376014|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	eieV5PR9GyMYkrgwdRSFoLpkk6KZgx2Ko+UGspVn2DwkDCBhmLtLxFgQUbndHmg/8dLNY8jE0yRF/iKTv0HWV2wNAUA3kCcJxW6QAxd9Giau1Lt/Dbkobbv3n3iRwLenEUIBG2jV9EIE9pZGRE1cJW+TKiFhd3TOkqEO6YCjmVDy7pm0WEKEMDbQV98hWoKgsETEX4ttZ9T2o3CtytaqykLkl2Up+/t4KiWygFQQsEjY0ZchOqWTZk2315SDUMK+hAW887tEW/parZ31bmiEvvPsdn60i9uCg1aY5XdvOmfEyKJi6wQ5Q10kcqN1hp9rkGFdjUJcJaSsiFtq8IYXvsN9laIx/3QBKb2+xU/s5l7tFwWGCXuXQK60KE4apxn1t2rw+eei30VnhFzfYQUgaYL+oJmwl8Icdjm6qQNbJafE6ayItA1l1Gj8MNV8jiZNiIBz2S181Ynnj63ks/r16EOp75h/J4cTR0twOuZdHLN+dhI8eVN7IUQTVTaJSYttxZynoZZStUDcV7HjmaceLNjRQJC79UkD+4w6pv1oQwgFLXBploV6VT3FrpcFIvV1aepZxXL5a9fXC20REscJn+TUOK6RFMwAzcEIi+CLtekW2ANCpsEXzpcEcifUtBnBazKoShB7yEzkzlqKZxm6HOBM2AhZ5loRvwY8dpS5SxGOvh63Vfq6+rILMs0qaDPKuKT7sPiNQpWJQHdE2w5s/Q==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ng4dd3WnyE2Mz4W8qxAhwNcwsTm95g2pMz0sOwxSG0xyuz7DOS4CJT+TgoOakUIhTQnjcz+q1NDZZ/9yrO4Kd/gtXTKDkX9CvNbEHr3/wqhsWc0z98JKo2soEjLNb/V2Hd/X8UVlNaJ9W+4dnWQpy4zutFyBePe0wKOY3luDE94ZTbWqroqHEBJMQw9VJAJOF1Hf8nlJjWGDfxvrkQTaqGko9rQTvp6EDYHDNv+nx+AuAT+0Y/RfJUnjLe7NR83gp9tK8aXT862o2ueCBRVMSBSAvxgXVZWiQ2L/HHgR96XaymrWFj/6xVw+Zbr69mV3qsJcRsZUWz4itH7cSVUpBIw2d9I19sn330YelS3cp8vYTjkuwCB3dd8JNlfVd5cMK30CeCHmCWbBgbA0m+anPjI0untvOIUydceU0TBx9E4e+EdJUsydQyMd3Sk9R7KQ
X-Exchange-RoutingPolicyChecked: 
	KyUOggAs6TSaWJVbJiZ6QB+WYxju3yAUtSU8X8xAzq076aSiZCp8wMSQi34LsMXX6quIVoqumF6JA7x7pL2z03ekcs+ttuiIoGEDcVnijo/7PL+2heKX6o3BnRyxSRvi00QK10kF2+BD+O70U+j51Xq1wzOdszFwCOK3h3hjg4uhDRqBk4lvTH/xvwaNFjgFoRBfW1ntu9ciIKtk0op+tIkm20Uqm9m+7JEbut6Py8wiDNaIFogKElL8vaz5kvwp646WAr+/WwPgYTH3LB+CzFkcLw9ZylWf1NRgXsawPHbo1AfbKtwAeBycEQD1G3oSk5cs+YmM0GyCoNPUqxjINg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:48:17.3467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b24f38-4094-49d1-2bac-08df02af8473
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7127
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNyBTYWx0ZWRfXwYbk0xKLUv9z
 rHV2AlocxJ9Zpduzr2sYAuhCrZ6LR2hEoGIxb2BisjduIxWlcQfcu47Yd7LDS86ul5dkrHkC1Y+
 zD/MoioeZ5ipbzY5rOkXG+DOsoPWBEo=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8d9d2b cx=c_pps
 a=P2JTm3oOj23y55bZWJDDIw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=zd2uoN0lAAAA:8
 a=sozttTNsAAAA:8 a=46slFY61AbQ_6GqxMQUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jzKHu4FKDW2tJkhdomvOQFpanLwzOHkY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNyBTYWx0ZWRfX+9a60bPE0O/X
 QGri5ri6zNYvmqPo2kgpLZ2ZkGQNMpbIYe5AJ5P+TuTWpDmPNQvQ0LeHYf1beYkub/m5BNNNX4F
 o7wKXziKiC90/vP7H4UKe8N1NZiJr/JvDG8O6t21TcQCjb6ogm6eU1tNOwU1pQl9Hx2mKa1lIvh
 kNPPrSJB0eI9Kas8WKx0auu/HhrHvrduXrsvAtB8TepHBmn1heAGnQMg3RPW15TAVzgcCZ0R1HR
 aw6GAm2/gdx3s+FkrjN8i803YqnY7DmjCn/Vz4Lw6cJsYDXFE9a6ScqQIqWHOEaQvpiiZIfjr+Y
 x0PWL2Br4jWf+8NhT0bZM2gEWpdYgIDg5nQceVhzY5zMGbH1WZ4ZUedB+oDy0m050efrOevHm3F
 X8scblPxFbqRm42oykgaa6la+xB1XSh+qzus+CVw+FD9kz6yZ/bijXhZRP2NXSb666T44Ia2cJO
 z/9kLT00IUNtYIL11Vg==
X-Proofpoint-ORIG-GUID: jzKHu4FKDW2tJkhdomvOQFpanLwzOHkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250117
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 13:42:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3070

On August 24, 2026 thus sayeth Michal Simek:
> A number of file (F:) entries across the MAINTAINERS files pointed to
> files or directories which had been renamed or removed over time. Drop
> these stale references so that every F: entry resolves to an existing
> path.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
>  board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
>  board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
>  board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
>  board/Marvell/octeontx/MAINTAINERS                |  2 --
>  board/Marvell/octeontx2/MAINTAINERS               |  2 --
>  board/Synology/ds116/MAINTAINERS                  |  1 -
>  board/acer/picasso/MAINTAINERS                    |  1 -
>  board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
>  board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
>  board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
>  board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
>  board/altera/stratix10-socdk/MAINTAINERS          |  1 -
>  board/amlogic/p212/MAINTAINERS                    |  1 -
>  board/amlogic/q200/MAINTAINERS                    |  1 -
>  board/amlogic/s400/MAINTAINERS                    |  1 -
>  board/andestech/voyager/MAINTAINERS               |  1 -
>  board/asus/grouper/MAINTAINERS                    |  1 -
>  board/asus/transformer-t114/MAINTAINERS           |  1 -
>  board/asus/transformer-t20/MAINTAINERS            |  1 -
>  board/asus/transformer-t30/MAINTAINERS            |  1 -
>  board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
>  board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
>  board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
>  board/avionic-design/plutux/MAINTAINERS           |  1 -
>  board/avionic-design/tec-ng/MAINTAINERS           |  1 -
>  board/avionic-design/tec/MAINTAINERS              |  1 -
>  board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
>  board/bosch/acc/MAINTAINERS                       |  1 -
>  board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
>  board/compal/paz00/MAINTAINERS                    |  1 -
>  board/compulab/trimslice/MAINTAINERS              |  1 -
>  board/comtrend/vr3032u/MAINTAINERS                |  1 -
>  board/comtrend/wap5813n/MAINTAINERS               |  1 -
>  board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
>  board/davinci/da8xxevm/MAINTAINERS                |  1 -
>  board/embest/mx6boards/MAINTAINERS                |  1 -
>  board/engicam/imx6ul/MAINTAINERS                  |  3 ---
>  board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
>  board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
>  board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
>  board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
>  board/ge/bx50v3/MAINTAINERS                       |  3 ---
>  board/htc/endeavoru/MAINTAINERS                   |  1 -
>  board/imgtec/xilfpga/MAINTAINERS                  |  1 -
>  board/intel/agilex-socdk/MAINTAINERS              |  1 -
>  board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
>  board/intel/n5x-socdk/MAINTAINERS                 |  1 -
>  board/keymile/km83xx/MAINTAINERS                  |  2 --
>  board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
>  board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
>  board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
>  board/lg/x3-t30/MAINTAINERS                       |  1 -
>  board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
>  board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
>  board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
>  board/mediatek/mt7981/MAINTAINERS                 |  2 --
>  board/mediatek/mt7986/MAINTAINERS                 |  4 ----
>  board/microsoft/surface-rt/MAINTAINERS            |  1 -
>  board/myir/mys_6ulx/MAINTAINERS                   |  1 -
>  board/nvidia/beaver/MAINTAINERS                   |  1 -
>  board/nvidia/cardhu/MAINTAINERS                   |  1 -
>  board/nvidia/dalmore/MAINTAINERS                  |  1 -
>  board/nvidia/harmony/MAINTAINERS                  |  1 -
>  board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
>  board/nvidia/nyan-big/MAINTAINERS                 |  1 -
>  board/nvidia/p2371-0000/MAINTAINERS               |  1 -
>  board/nvidia/p2371-2180/MAINTAINERS               |  1 -
>  board/nvidia/p2571/MAINTAINERS                    |  1 -
>  board/nvidia/p2771-0000/MAINTAINERS               |  1 -
>  board/nvidia/p3450-0000/MAINTAINERS               |  1 -
>  board/nvidia/seaboard/MAINTAINERS                 |  1 -
>  board/nvidia/tegratab/MAINTAINERS                 |  1 -
>  board/nvidia/venice2/MAINTAINERS                  |  1 -
>  board/nvidia/ventana/MAINTAINERS                  |  1 -
>  board/nxp/imx93_evk/MAINTAINERS                   |  1 -
>  board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
>  board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
>  board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
>  board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
>  board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
>  board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
>  board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
>  board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
>  board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
>  board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
>  board/nxp/lx2160a/MAINTAINERS                     |  2 --
>  board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
>  board/nxp/mx6slevk/MAINTAINERS                    |  2 --
>  board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
>  board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
>  board/nxp/t208xqds/MAINTAINERS                    |  5 -----
>  board/nxp/t208xrdb/MAINTAINERS                    |  1 -
>  board/ouya/ouya/MAINTAINERS                       |  1 -
>  board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
>  board/phytec/phycore_am68x/MAINTAINERS            |  1 -
>  board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
>  board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
>  board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
>  board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
>  board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
>  board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
>  board/renesas/blanche/MAINTAINERS                 |  1 -
>  board/renesas/eagle/MAINTAINERS                   |  1 -
>  board/renesas/grpeach/MAINTAINERS                 |  1 -
>  board/renesas/v3msk/MAINTAINERS                   |  1 -
>  board/samsung/starqltechn/MAINTAINERS             |  2 --
>  board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
>  board/siemens/iot2050/MAINTAINERS                 |  1 -
>  board/sifive/unmatched/MAINTAINERS                |  1 -
>  board/sunxi/MAINTAINERS                           |  2 --
>  board/ti/am62ax/MAINTAINERS                       |  1 -
>  board/ti/am62dx/MAINTAINERS                       |  1 -
>  board/ti/am62px/MAINTAINERS                       |  1 -
>  board/ti/j7200/MAINTAINERS                        |  1 -
>  board/toradex/apalis-tk1/MAINTAINERS              |  1 -
>  board/toradex/apalis_t30/MAINTAINERS              |  2 --
>  board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
>  board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
>  board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
>  board/toradex/colibri_t20/MAINTAINERS             |  2 --
>  board/toradex/colibri_t30/MAINTAINERS             |  2 --
>  board/toradex/colibri_vf/MAINTAINERS              |  1 -
>  board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
>  board/traverse/ten64/MAINTAINERS                  |  1 -
>  board/wandboard/MAINTAINERS                       |  1 -
>  board/wexler/qc750/MAINTAINERS                    |  1 -
>  board/xiaomi/mocha/MAINTAINERS                    |  1 -
>  board/xilinx/zynqmp/MAINTAINERS                   |  1 -
>  board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
>  board/zyxel/nsa325/MAINTAINERS                    |  3 ---
>  134 files changed, 241 deletions(-)
> 

Thanks for the cleanup!

For the TI boards

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

