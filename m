Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FAAC61DC3
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13449.1787566240045229550
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 03:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=m8M+XWEF;
 spf=pass (domain: cherry.de, ip: 40.107.162.49, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAPwc4f9gNQnO2t3Ke7dGzfCpL52PUx38a+DOHsH4i0Bf3tguDhrkCeePMVYJMjBBoG/KA7qwLyhGgXienDicumbbjp+G87PWcFO4qyIBet0gqP6XFuDa1CUE2UxfSZHLNRHuAVlH7vUSFzhadY9UcZGRPw63e2D4Na1Y6LX1wTkKGo6zM5MpuWucvnpA1Pe+rtFOs02+RmrN3qXWI38SiKJkHNM5il1MogD7nKHzp3Nrr4rq8LV5u8ajHHUFkiBAfA8Zf9eKyZ3ojJGLUKuKryBKoLHo9OraK2yy/xS6oJKtBeN2QIhBij3A8J+ARussNjG6vjhu8bJZeGqU/HrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ2K1hq1XVstYeDRnLsFnc6YaCdwJ5xscU5pLfT4yHE=;
 b=bsoe8lve8vvrAVtqkT1hUe52N6wgq6hJc4qic0fGIuum6K+ygBdVToLwa87oV+7tJSsFj00LbagQ1YqPzjznjS14CRtslqkn0k8gFin0XS13Uyg5d3Aig7Tu0Xu8p+olyopkADJ0dAWEohECqOpYq6VCqzrL4Uf+kaBZgIt5mjzgvGCLYHN66RVALXmbltIBlIWbphyqv8XcQuqeABssF7IfKvdTZ+tEt/vf30Co6F9yk4UK19rUkwpBg3aBApWrkm5Yz8TF4DfgchpG4klJB7xKFlFD/qqNKhv6qD6nNVFjYxoejVWHSTKWFkHiDiww4XKQXAHgH9FLRvl6MaMJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ2K1hq1XVstYeDRnLsFnc6YaCdwJ5xscU5pLfT4yHE=;
 b=m8M+XWEFGiyOqpdtvWvdzYOMOT5ePgkBiH4fedQ/ra84Jop1xjiDRAClnRfIBY0teZHOuZhycJGlE1LA4ekValFU5rsqVA2Y+etpQGDWZL8eZ9N9dGhi3qkKY6NZ57SXOJMpsvelgd/JxLWESeAtTX87Jpko2Ien3PL++0y8Xvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA1PR04MB10120.eurprd04.prod.outlook.com (2603:10a6:102:461::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:54:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:54:40 +0000
Message-ID: <fa38d1ba-ea87-4e29-905d-f71c04dcd458@cherry.de>
Date: Mon, 24 Aug 2026 11:54:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Aaron Williams <awilliams@marvell.com>, Adam Ford <aford173@gmail.com>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Allen Martin <amartin@nvidia.com>, Andre Przywara <andre.przywara@arm.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Bryan Brattlof <bb@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinh.nguyen@intel.com>,
 Dominik Haller <d.haller@phytec.de>, Dzmitry Sankouski
 <dsankouski@gmail.com>, =?UTF-8?Q?Eric_B=C3=A9nard?= <eric@eukrea.com>,
 Eugen Hristev <ehristev@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Gilles Talis <gilles.talis@gmail.com>, Green Wan <green.wan@sifive.com>,
 Hans de Goede <hdegoede@redhat.com>, Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>, Le Jin <le.jin@siemens.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Mathew McBride <matt@traverse.com.au>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Geis <pgwipeout@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 "maintainer:TK1-SOM BOARD" <Peter.Chubb@data61.csiro.au>,
 Philip Oberfichtner <pro@denx.de>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Randolph <randolph@andestech.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sam Day <me@samcday.com>,
 Sam Shih <sam.shih@mediatek.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Guinot <simon.guinot@sequanux.org>, Sinan Akman <sinan@writeme.com>,
 Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>, Stelian Pop <stelian@popies.net>,
 Stephan Gerhold <stephan@gerhold.net>, Sumit Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Teresa Remmet <t.remmet@phytec.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Warren <twarren@nvidia.com>,
 Tony Dinh <mibodhi@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Wasim Khan <wasim.khan@nxp.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
 "open list:P212" <u-boot-amlogic@groups.io>,
 "open list:ARM SNAPDRAGON" <u-boot-qcom@groups.io>,
 "open list:phyCORE-AM62ax" <upstream@lists.phytec.de>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
X-ClientProxiedBy: VE1PR03CA0024.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::36) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA1PR04MB10120:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fce293-c5d1-4280-fd10-08df01c5b712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	30R1UclLRT1GTgndd1tWq4KP+T3oBFvS/QnbVAcrANqAs5f4cu2gUMzbX2QyiOSQFUIsBTWAlEMNL869PtwvnfQ3ucJF+O6DI/XxBEIg3jgToBJCoef4pByFHj4YUB2U30yDRchU/hA6mbIOiE44J+zavOfQFcIuWB94QAeTFrsNRWfHx+mqez1HjMeI69fwb21/KOQiYzaJ53xWmVQI3wzbVsXhoSmsU1LKnF8PNaGG5DA/t1q+FO6TQNANN2t8zxqa99JFCggcoJvWt+UcjD10+Q9DrgO1RQ4lWSInPUIl9JOKqDSWfKbMFCxbVnYPX2Dq7z+YMnVaFhC0sRUd90Kgt3sHC81+J4yQtV5kIGLvedwQsLrse6W73hCgJirQ56QDfc6WUOlmtgy/A7gCjP8Dh6UfRmz/1V16p32O/IA9s08Zj9wKE6cB3Aqk6xVD6szw/MKjh6SqeGbCAmTl/9bTyV8tGdtUW39LiVQqQy4hMgSBdlt4B9z3tKnNuf3L5FbxD+ddQX+IMSm/CAiWeYBz0HC0PB2WJi7zgO0SG5/OPMec7/oBh1PO8mQQLPNNkutw7nimsPZ/fHRy8VTsmJxxCaXkV7+OgFv0tyu92DdSs8Gk061SGirhTj60PXFfGHu6s+B2gjVjnLfGQzq/OvPDc0SaLmOZLjzAaNzJvq8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3RPTE01VkMwQmRnVnVpLzlYbmxXNVVuY0ROZUNmRUdIeTlyWjhoTGRiRHh0?=
 =?utf-8?B?bjE0Q0RpSzlEZTZTNHh0MGFMSnJ2elRHWmpBSjdkVHpnOU9jb3FGZEFraFBW?=
 =?utf-8?B?SzIxMyt6eTRUeHpzeVN4UUYwTkgrakdNd29KVXROTGVUR2l3eUdUSXJCTjUw?=
 =?utf-8?B?MGpDWUlmS01nUTFFelNoOHBUY0x2U1NvNkY2RHVrblZIaG1pM2dPN2kvVTFm?=
 =?utf-8?B?MkhEeGRGTVVjRGZ2QTVtVk4vaTgvYzhWOGExa0QzSFRpYis1ZzlEZjJWVVNq?=
 =?utf-8?B?elJFbHlxVVptdDNuVjdoZUtjL0Q1bFZrWmxCZ0U0N1FxRldNOTdhSXprTGc4?=
 =?utf-8?B?UFZZZVdwbDQzemZyTWFETWdKNzRHYlRzZUhqaXY2SHNIbmNGd0hmdjJZVlIr?=
 =?utf-8?B?S3k5Q0J1NjlFM1JmckQwQm9Ud1ROWE96NUo3RFdsWE9mbVdDckhqLzVEbWFy?=
 =?utf-8?B?TUlDUXYxb2VqczFUaG1RelRibnJqRS8ycnpYWTc0UHd6OHVZcDJCZEcyWkRh?=
 =?utf-8?B?MWlualdsdDdKWEdhOTdYT3R3ZEFlQ1hBeE8zZmNPSmJCMFhQTE1rY1pIWmRM?=
 =?utf-8?B?TkRHYm05MXJCeG41THp0M3JOVzQ5L1pDS290VVVhZHI5VnFGVFFraWozV3pm?=
 =?utf-8?B?V0RsYkEvMit6bG1wU0dMODZENEZtcXcxaUsvMUpMSkJIZDZXalpYcmo4bmhK?=
 =?utf-8?B?QnA4S1p1ck5vVWRucEQySWEyQW1KYTZRTkFSbW1odE9GZHlFK0V4S1I0TjVE?=
 =?utf-8?B?SHNZb01GcFJEZ3g0ckRpVHY5elJ1VFkvLzdyZTFqMFdqcllBTkRvVmpocjBm?=
 =?utf-8?B?cVNmcDFEYzBlOUpyZjFPSEFsUnRjZjhyUnlhRG5obE9IWGN4aFpLdE9FQXJU?=
 =?utf-8?B?aHlCTWpUdUZPU1RndXNmQkNQUzBsYWU3K05ZaVU3N21TelIybWl5OXZsUUox?=
 =?utf-8?B?bGNCVVVPWWtzODJzVW5zRHkzdmZBZko4T3ZMa3IxaUJ1QWxuajVveWJZSW1t?=
 =?utf-8?B?MFpKcFV3ZU9HYXU3dk4xd1lHSnZ5WGlzOGdHMTBqY09MNHZaZm40SHEyRlRZ?=
 =?utf-8?B?aVhLcllwOExsRFgya0FBZ0dvdy9aQTVSaWhQNDgzOWxkUHduNUF6RHJrdGg0?=
 =?utf-8?B?c2FKcnVwSVhndzJkZGd2UzRFVnN2UmZMOGNINXlZQi93alRaVjZNOVNOMldJ?=
 =?utf-8?B?dnJkcnltTmFKejBydklJVHoyMnFqMmtmVmZBNlBNa01RRldJVzZra0pqQ2kr?=
 =?utf-8?B?R0NMaVRVZGQyak4rc0laMnZJdHVxNlFodVBPcnRTeEVkQTBVTTd6YTFhaWds?=
 =?utf-8?B?N0U2MVJGTllnZ2dBa0psSVN3dWpMcnE2TmlSRGtsbHhTeDFXS3hoMFB4VjB5?=
 =?utf-8?B?WEYvYkxFNHFNb2lyaXJ3Uk5hSDVlQllGa1hpcUcrcGNCajFqZXlQSUg5YlhI?=
 =?utf-8?B?NTBKNHBHL2lCWVBxc3Z1dzd3em9RcC9FMFB6eTlpV2h6OVRycWxUb1p5ZUxZ?=
 =?utf-8?B?UkRUekcvSTlBK2Uram55L2Uxbm9wd2U4bXlKck55Z0YrYXNkckhFczI3K1NK?=
 =?utf-8?B?eERJL1dqUTA2bkVxaTRXZTh5a1ZKSDR4YmVISGV6YVRhVFpGUDMzeDU1QTZq?=
 =?utf-8?B?a2ZYTGJEMmVERGlGSlBseUpIeXFqOWFaR3d6OVVNZW9SWlFBRlNJS3hnT0NB?=
 =?utf-8?B?eVlDeDVqL1Zoa1I5ZDlwNEdiaStNeUtBVldvTXRVbWQyVWZvU2JFVWdwcGND?=
 =?utf-8?B?Z25iaXZ4L3dJQnU5MmloZXczNUZUajBEeDNyd0tJSUczbFBLb09oVWI4VDRz?=
 =?utf-8?B?Y2JrbzBSTW5IOThqeGxNUlVBaDEwMDRPOXBjWTY2WXJJQnR0MW1CTVd3RlRJ?=
 =?utf-8?B?QStPRkNmRjBMN1RvMXNEcUJGVTc4ME5nUmpETDlKZ2RuVlpWdndZTDhzSjhF?=
 =?utf-8?B?eXNkUDRIZmREaG9qV3BnRHNFdHR6K2ljZ2lsbU9BbUdRSUQyVVNFSUpHREFH?=
 =?utf-8?B?b2prM3NRRXJjblJyTm9HUS85NkRRTGNNMTlaSzdIZmd6OEpZbVpXbDdlRFdt?=
 =?utf-8?B?ZHk3TURxNjJIR0MzWVpYRzZDWXJMV1E0MkEzZFlicFJLc0ZYRFZGREs1WEZO?=
 =?utf-8?B?dTRYd2NZV1ZoMUdGQWZLNS9BU1I5YTNTZnIrTEtsaTJxaUd0ZlVOT1UzRlVq?=
 =?utf-8?B?aTZkcVdhTER1S3FCdHRPTElEWThXNURNMlh2WU5sOGMxWEhaN0Z0UFpHektL?=
 =?utf-8?B?VDhGdnIzWVA4b0VURWVlSmNuL09yOXZ1QmgvZ0RRc3k5dy9lTUJmUWF0Y3VK?=
 =?utf-8?B?NzNORjVSWFlqblROOXFSZFpEYjYvTlZTT2RQSkQwdVcyeXVGbmtaVHFDZG1I?=
 =?utf-8?Q?s9jiB/ZzJhfQQjupJDsY2Zm5GcWHLG6HYNonr788kz97q?=
X-MS-Exchange-AntiSpam-MessageData-1: BAHTcg+/D7+0sseBbFE/pZtnGBOGFZLJxII=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fce293-c5d1-4280-fd10-08df01c5b712
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:54:40.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgvaPZ4fAIuLTynUx9yjTvSWpaSYzggKhHVHL+b5YoVlUSEK+nwNlNSpL0R35hYMyyFbTKjA7qtkdUOJOpLWRyg2naKAJtsfn3Z46eHeUBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10120
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3051

Hi Michal,

On 8/24/26 9:18 AM, Michal Simek wrote:
> A number of file (F:) entries across the MAINTAINERS files pointed to
> files or directories which had been renamed or removed over time. Drop
> these stale references so that every F: entry resolves to an existing
> path.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
[...]
> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> index 79cf9e97f70b..62c3ce765e0d 100644
> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> @@ -13,7 +13,6 @@ F:	configs/nanopi-m5-rk3576_defconfig
>   NANOPI-R76S-RK3576
>   M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> -F:	arch/arm/dts/rk3576-nanopi-r76s*

This is a leftover from v1 which had a file there, but we merged the v2. 
See 
https://lore.kernel.org/u-boot/20260108143551.4017839-3-jonas@kwiboo.se/ 
and https://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/

For now we don't have U-Boot-specific additions to the upstream DTS for 
the NanoPi R76S but we could in the future, so having a wildcard like 
that would allow Jonas to be notified if one ever gets added. So it's 
not completely useless. No strong opinion on still deleting it or not.

[...]
> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> index c43f469589dd..2e7f43042ba3 100644
> --- a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> @@ -3,4 +3,3 @@ M:	Jacobe Zang <jacobe.zang@wesion.com>
>   S:	Maintained
>   F:	configs/khadas-edge2-rk3588s_defconfig
>   F:	include/configs/khadas-edge2-rk3588s.h
> -F:	arch/arm/dts/rk3588s-khadas-edge2*

Was never a file matching this path, even in earlier versions of the 
patch before it got merged. Same remark as for the NanoPi R76S above.

So this looks fine for Rockchip boards (+ the changes requested by Johan).

Cheers,
Quentin

