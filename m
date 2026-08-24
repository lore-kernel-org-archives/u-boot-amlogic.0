Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A541C61DB6
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.19])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13528.1787566598499322186
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 03:16:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=OEZ2mSZL;
 spf=pass (domain: cherry.de, ip: 52.101.66.19, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNX9Ls5rdvPpaFc7qUumYOX7JceJoJpGlnaBSlAbhQnL/4fnL1RVN6W2N9Nl4fWeIhqTzu5KGJRmDd1eupC0xhwkM8ijWwhR23VmIc+0X7H7rNMiYFKNRYpOmqushJbJL59EAsA2xm0DCMrvuq/0YDvX2CnxyVgZg6Rv3gumDZ7uMoTig5WCm+zyAUBEL4cvwWTg8dyE2hEEurxcEuMns6I/RK4RZYsnZEdHw2dBF+KZA9Oyoys9evHlMQ/6e9SxeEcPMMU0Kkhhu5RjZjP4HJ+7lbLvruLZy0lDsTHBG/CV3SfH5VHhpLlxsWbGpkbX2Uqkyug7N2EY1HkScNbsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVQqlnDD4+DxLjeQE9K8z9ylg4xKSbC8g2AluviguX8=;
 b=AUuBaDwkcw6r0vghkA/qSC6ipc6Q7PdqpTQyIGm5Hp7qbvwLUvaT4fdlVVz+vPLt7rgZ75ImR/jE/my46Ddr/kces0XLQTt0jyPHWm1vJ4g6oXYLCdWzY2QzSBOk6EtnM5M2V+xIXy6quiHtuahR7vRSIuxBLHVlRb/LuhmNCmLWC+OSbYmgVYOu0Sf5b5TAAcsSSkH6T98kYPwjQUGVQM5YOCEUu8Iljh4dndnCPyKju93dgk8eiYJ2JlMInXlY0HuWWdGe+AuFltA9pnQl9Bqb0o0IXu0AAheDmfTJ3geypcLs27PjzlHdOP6NuEmLKIO1zXfWwmMBBIND5DL+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVQqlnDD4+DxLjeQE9K8z9ylg4xKSbC8g2AluviguX8=;
 b=OEZ2mSZL5DXPHsBmcQUwwvCwHEqdLKwlwE2Mks+zpAB++I6e+A0XByX35RCGtZFtRWV+BO8rBASjMZfS24wXOSUoU3OJxht98TL5jyysD801bCDMR12j8UgUuq93xro0w0cTzEjwKTYFPoiyYMcGnBunCyd2WbWD3rWrCrhtZO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB12127.eurprd04.prod.outlook.com (2603:10a6:150:313::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:16:27 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:16:27 +0000
Message-ID: <4d7ef207-189d-4b7b-8fb1-385dc1411add@cherry.de>
Date: Mon, 24 Aug 2026 12:16:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
CC: Aaron Williams <awilliams@marvell.com>, Adam Ford <aford173@gmail.com>,
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
 <fa38d1ba-ea87-4e29-905d-f71c04dcd458@cherry.de>
 <e14e6b85-97d7-4546-88d5-7d5e3a875ae7@amd.com>
 <e128ba15-d1aa-4414-9273-8fe999e054d4@cherry.de>
 <ad8a8f9d-8fab-4976-9d9b-10e7f5bade9f@amd.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ad8a8f9d-8fab-4976-9d9b-10e7f5bade9f@amd.com>
X-ClientProxiedBy: AS4P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::24) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB12127:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4d0359-ca06-4360-e39d-08df01c8c22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|4133799003;
X-Microsoft-Antispam-Message-Info: 
	ltNAIfl/gFVdOeHfGIa4azeWTNi7Yswga7nVEVnlxLA9dkBxiovk4bot/8mn1PGAFIN4SxzflgQgyVhNpjfGlpodWI4V01cL8A9eUWOymchPlvPPmJ+zOu8FLSZa/H7Vt6NJstpW0B5C3DmAFBNeauZQvCJTIlNrCJjLGVyK+bq96nihnMm+811nNLMMJADWTZ+twnLkB19V2D+oqjEs7CzWPTkei94pVnGsvB95LOQXe1PmaP+DrguIcnd1ujKnREyvcyMmzY/cKd2JFujqLs5ortmq6h1t8WV8PfWXVAF5icQz6893YC5AqV9VM4VdY+PMjhFU4DpohP0wBRYrtxDT0ql12isGkJo0ccELPhcWRI2f3vkhhNUrZtjDV6TSFOVxw7OvBv6lr4X6Fjs28asu3uMuEcSL7slUzfo3DCwpuIkpRT/Eq0HWO9eb9LG94uziRMZ4tgLhIZS4Ckovoye3xWJOGOTooVEtqs5QzDwemqdcFvqQx9MBpBz4QS+WVjDH0wtLtF70PXZhfV8tZRxwrIIXvoGdlBQaz81BwUzITWnSVAlMWsHpU6gL1g4+lLl/HFS839JU4fyUhj/VZ1psVPWzIvm3+qGNj9SZ7oY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oH8VetsZGrvnE2x38wixZvNkksKiv+MitVkOK0KEdGTuMVoo7RKq4E538EUs?=
 =?us-ascii?Q?fD7CBKDZ89DTaHi+DEmVOSL3NVDbI20oEPkVljUOlGHVaDFA5NSHr5i0Uahm?=
 =?us-ascii?Q?BS+Ndmurx9GV7rr+Vcm8+V8PBNWcNxmrrJiJ3zK2UpvCSi/H0sq/GmmZjyiR?=
 =?us-ascii?Q?DPTSZCmbK0T5/LnJKkCMJRZA/3IlgepFhkiYnIKnrqdpdOLYDd7z8bRDAN4A?=
 =?us-ascii?Q?j2+ZABdklqyqL8aAz+R3ts2FJe1rgZo3IM8bdb30dM5b/XuNLNOkECaxQdcq?=
 =?us-ascii?Q?A+PVRMVqG2kiY+vUVFZjtJlIjtgTTS9vBgUiPcbol5ImTsF07TfCH7sSXYVV?=
 =?us-ascii?Q?a1uNvuGyTMV/z0ItZT7wgvNdO3j49r2VqL1CpxWk7i+thdGNQWTjqytkAY7V?=
 =?us-ascii?Q?ddoCAI75I8igPKrZ1VYD/K8oHjvXtCU0z7EmVh4bfqaaRrDoDEOsfBVcO726?=
 =?us-ascii?Q?ZM0p9kjpeNvxdhPpkj3j+09DbIhLfVNPlaKMs/AhqPzh+VuYgHf5QwwvEEkp?=
 =?us-ascii?Q?aSkK4tINChdOHWsoVJxGaQN52uDEp4DFd5TQH0I+uRgmST3DvnXfD2QJAAkp?=
 =?us-ascii?Q?tZOOrjy9SteX9ltfsWl33H+1YlVjcfMZwDNyRoKZDrzbRK4sdzMn9TI0bfA7?=
 =?us-ascii?Q?e/RqtEQRunNRfmIfgQLw+P2t5uAo+Y66cxfX1xkyKwtKUTPyHCe8zBFxvEmA?=
 =?us-ascii?Q?imPJBfhpb9/gO5gmu84sKw3+go3MWhtJa4vrEE/+7oeeEIAj6DY02PrKHmKF?=
 =?us-ascii?Q?r9JRIOGH01Wu4ZStrtkDgG5fcJlee8RbB5vm1JjMjarjGMEnHDiQzt7fIPta?=
 =?us-ascii?Q?dW+QuAAjj0RXzqpqBZJglJ7coqnGk2oay2JkocOjmkUZ6kvCeO0MH73ZFJpy?=
 =?us-ascii?Q?2qMFhmsdY8s4pC/weQwtg4A47a13343cHbufDFQqIms6rEI82TAlLislaiw5?=
 =?us-ascii?Q?tB+QnoMAQfia1fTcRanuuf94n79fHHFRi6KAA0PGHQm1w0sRMjxd+2eGDLv0?=
 =?us-ascii?Q?eltxRipfj97V6OTnKVbFTrb8G8x93bNfemBff19nguoYEc92jyjACIT5lq4d?=
 =?us-ascii?Q?CPTSDkmd1oDqLeHo+2rFfGl5jAzqwK0c8ZFf+9ev/19RLOEQC8gpTSHWaVk1?=
 =?us-ascii?Q?pl5i+b2LHQvk4BkllsJsxgxeAMqBuSjaCeVtWuTfj2uXQcijJFBq87m4E6e/?=
 =?us-ascii?Q?5tyDohNBXJCEzBy3xqLVc11tCzNrTZm8f5a85hZ6z6fcm7JW6sAi1u+7PqCc?=
 =?us-ascii?Q?MukcRSMFwxcN/ap9NhjpKcnunLIs4pyOUXCqV329fgSlLUmxQQAurTSvxdO5?=
 =?us-ascii?Q?qgMMwF4WLBqSII5Zrw0TUCGvXr3WdBIoznzJi87TieSp+3xPSlLkQLnrT847?=
 =?us-ascii?Q?Yovth9C9YGE4pc3qR+t/a7U1HlofcvBPTsuy7/4N1OFOQfEDmNFd4bBJ9Ehz?=
 =?us-ascii?Q?ySWf6zrKglyp9ULJ1CkdwAel15/McnxQYl9PFlIOmLMNPz/FymIup0t69tG/?=
 =?us-ascii?Q?AZeU3sCB4YWY67o+eizK8YzPam6U0hzH/Jpq6neHhMbN2kZsaarjREeMlUmX?=
 =?us-ascii?Q?wOqkP/XXoO0uxoLBGVCZ7/xmXb/5q/8hL/Dye4UgqhlAL4gcM5ZL+l0geH7l?=
 =?us-ascii?Q?7I1Xyt+vOFcC5i8rh0urCwZtdHjvQIwJCGFpx2sVpDLS5F8HqcqN1om3ydXM?=
 =?us-ascii?Q?J1eug/mJJmqJ2qUUW34Js4jUnh4v4dfQJwnU6epIgWbabftxbEhpvMO/Nhoo?=
 =?us-ascii?Q?TDZXMfi5g73Xqe+o/dP8tCWfloi5mxWAVKzvAw8Y5XbFWF0q5/SczhaMDXup?=
X-MS-Exchange-AntiSpam-MessageData-1: kpDr8LbTu5wokw==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4d0359-ca06-4360-e39d-08df01c8c22c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:16:27.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsLus+1+lwj7Kpl9MLxvdeL7ttp/yrOjjH0CKkVEcAM7IMesZk2itlTLzBZmf2NgQRmO8nEdfapk2TT1RZOHyRwYz7XerLvW6mZYbxdqE/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12127
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3054



On 8/24/26 12:14 PM, Michal Simek wrote:
>=20
>=20
> On 8/24/26 12:11, Quentin Schulz wrote:
>>
>>
>> On 8/24/26 12:07 PM, Michal Simek wrote:
>>>
>>>
>>> On 8/24/26 11:54, Quentin Schulz wrote:
>>>> Hi Michal,
>>>>
>>>> On 8/24/26 9:18 AM, Michal Simek wrote:
>>>>> A number of file (F:) entries across the MAINTAINERS files pointed to
>>>>> files or directories which had been renamed or removed over time. Dro=
p
>>>>> these stale references so that every F: entry resolves to an existing
>>>>> path.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>> [...]
>>>>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/=20
>>>>> mach- rockchip/rk3576/MAINTAINERS
>>>>> index 79cf9e97f70b..62c3ce765e0d 100644
>>>>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>>>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>>>> @@ -13,7 +13,6 @@ F:=C2=A0=C2=A0=C2=A0 configs/nanopi-m5-rk3576_defco=
nfig
>>>>> =C2=A0 NANOPI-R76S-RK3576
>>>>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Jonas Karlman <jonas@kwiboo.se>
>>>>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Maintained
>>>>> -F:=C2=A0=C2=A0=C2=A0 arch/arm/dts/rk3576-nanopi-r76s*
>>>>
>>>> This is a leftover from v1 which had a file there, but we merged the=
=20
>>>> v2. See https://eur02.safelinks.protection.outlook.com/?=20
>>>> url=3Dhttps%3A%2F%2Flore.kernel.org%2Fu-=20
>>>> boot%2F20260108143551.4017839-3-=20
>>>> jonas%40kwiboo.se%2F&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7C20d=
22328c2c14b04e70608df01c79b5d%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C=
639231628996802560%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw=
LjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&s=
data=3D%2BGNHaQOa3XRWnaRD%2BMBZJDH3t54Q17ZQGynxdQr34e8%3D&reserved=3D0 and =
https://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/
>>>>
>>>> For now we don't have U-Boot-specific additions to the upstream DTS=20
>>>> for the NanoPi R76S but we could in the future, so having a wildcard=
=20
>>>> like that would allow Jonas to be notified if one ever gets added.=20
>>>> So it's not completely useless. No strong opinion on still deleting=20
>>>> it or not.
>>>
>>> File is there or not. If you add it in future you should extend that=20
>>> fragment and that's it.
>>>
>>
>> And Jonas won't be Cc'ed on it being added if someone forgets to=20
>> update MAINTAINERS (which honestly is very likely), that's my point.=20
>> He maintains the board but won't be notified if something directly=20
>> related to the board he maintains gets added.
>=20
> you can use N: regex fragment for it.
>=20

Fair enough.

Cheers,
Quentin

