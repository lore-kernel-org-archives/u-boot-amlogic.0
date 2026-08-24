Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455EFC5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.19])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13475.1787566310567724930
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 03:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=FL9PXhOL;
 spf=pass (domain: cherry.de, ip: 40.107.159.19, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lS/Jco2GRH8Xm/mw8sDIxeYXpf54XS9IUWK1FTA7Mc4PmfWwwxm+FbXAmRFS2F/VZEb5JwplXrzN1BTLSZWc2vhj2cVV9ZVLpnLetil7qXBgoV4QsmVXMKb7q/HOoEHKCfjwbekT1JlVrNvROZyWo+RhexNHzaoOuUmYTWD86daU++m1ZhNg7AWm9/mC7V0cRwdC/QmjafxiDkhCejbUIw/PlmN9/DV8I/+O6TrNToxJue7jRo4n0h50S4oBV2xQtKdu6kpprlnuGmQLqE9wWGjN/nluplNJSD+C3TjSRwFyDv7UExVyoy2Tc2yFqgyfuzE7bg89TuEKGSUw1PP/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itqz8dLIGB1XeH2YEl4/OSZatM8E8RCKxrgn9f0nKpY=;
 b=EKwcj4p0+qUBw7k13v6l6JhjKSpW4CWv0qn0EMHWeZSpbTMU6Mh4f0y1ufp8pi7odsvFHzh+PHlhWE0hJ4G/84XSVBmT8equSF1oODtd/awZW7etXBiumvBwze6vH5Swy1/PKoSGfOd9U6qbGWzW3THzH/ZkDEdGX/Ldi4UwPe34WuYmGpm820Rcl4BFFquYLE1LD+THXsXennJ+bR36La8JUPMSuaBZhAx6qljRRi6InHvSRgLfpkd2R+ANeLLfIfC0hH7qHLu4HL2ThVscZoaWj7ITRHFHoj8azN0cD78hVu1fJIgLy77CHFA07S7j8TAHVN+Uj2XYUGxnixej4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itqz8dLIGB1XeH2YEl4/OSZatM8E8RCKxrgn9f0nKpY=;
 b=FL9PXhOLZKf2MI/Yj7qovf8akHJaNW3CtoARvH6Fi0vGCxP+r5qNTtIRdK025WFY1qMojiL7idugF9EMVG9SYIg8KAXgZJp6RYKd7L+QqBCOZQlB/cPUHpgdHegfFNEGW+FodK4fNXVeKArbMzLzDK2UcISkDs3T6TMmcAeVsQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VE1PR04MB7341.eurprd04.prod.outlook.com (2603:10a6:800:1a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:11:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:11:40 +0000
Message-ID: <e128ba15-d1aa-4414-9273-8fe999e054d4@cherry.de>
Date: Mon, 24 Aug 2026 12:11:35 +0200
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
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <e14e6b85-97d7-4546-88d5-7d5e3a875ae7@amd.com>
X-ClientProxiedBy: AS4P192CA0051.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VE1PR04MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a6199b-4acc-4ad0-2377-08df01c81734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|4133799003;
X-Microsoft-Antispam-Message-Info: 
	VwGUtacAoc9SwpQ/nzmiYn0FZK4T7UGIOhvH4Dn5SRe2wvX3ndGs3gKv5/ZRbipnHNi0YFGm5UCCH2CSX59WzwOeNfGf9DTc9eT1uz0YHMkBVb/5LfqBSLNjlhN0qrar4eAB5rafwqTQVayXoFESQjln9Nm5RJjf9BdGyhLlQGSpumLCLOmd9rvlZXezCcuZNnRp/mb246111ZY1M0idsvRq122cIwpoRvFZnWPAoNSPrKsIhC5OMxD3WmxnewM1PBObUBnHWxSOMNJO3jnr3p5Pz3hbOetymFZbX+9fiEiAst2aRP02bKX4WVBjPkEb0qbh2qz/hAMvF3QanYtmV7O9AWyEfLF91FQQxbXBHRyb7Wa6o/Pcx6q2eYfJdWyUXzAW7mj0StHjTbf2PG5fKW2ImLvFf10Dagw11kru9yOlBamXOuNxLsazG4628omOuIfThWJS4cmLW7lHViXu3Gw4yPwIYuut8+JTziGaaBG1swOO0BVYiuXQvI7Z+BdFGqJPID7KKRZHTKd9LCftKWb0JjQ8E3qsFWzWBhoL6D/QAgqi/be/mSrD57yol9RJqMCFKASzcRfebU7fBXdq/8GRVdaYbPjv7zk26d0Mqeo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vItWUisuPMXJK8IbAOsch8EdEAXG086KE1FAGRXA8T10IYNOrwzVRloMv6y9?=
 =?us-ascii?Q?v/d6OcndM1b2CGyNjIa/ZSqe9FVmt2E85HELSoNiMrw4qqzTwBpJwAIIDtGj?=
 =?us-ascii?Q?/andxwYxL+0f6YQld8S6tLyauVeknDimQhrq5p/32bFllJU7L0lpOG+ReEzb?=
 =?us-ascii?Q?qXm57OKFRSZbDxcZhQtgjuGEWN6gIpexM12ZetshOaJ1+FI5lsv1IJP/YlFP?=
 =?us-ascii?Q?CVJXJwukg0xXsB4LM/ctWqDCkQHyFJdHvZRU2qW9q92jRfDjAfbKAFFloiwP?=
 =?us-ascii?Q?Z7TrkMV72JDoVINDFlJRqOaxIILQ/je/oeu86D7v1FopJAE6g0GUckXvwLaO?=
 =?us-ascii?Q?O7HFhyrW/+sfX8zBunBNBylR3rf6dFje1ZxNyNLK4WBwdfDfPTctfZ+HfjK/?=
 =?us-ascii?Q?VWf9IlJEXRN8qlSacFOk/J2k6rDOhHDKWTqC8+egNfFtn0ut74SD/B3AEs2n?=
 =?us-ascii?Q?OZyLcWNdNQsXAHW9XIKIh2BJjb4I/Q+LB2diJDelZBbrIx24WqF5W+jFHtMy?=
 =?us-ascii?Q?L0GIbPipWC+1P3O96CS81LW+0lSlGENb7teMNQtRcJH7X2Rs7FYLxcmBH8+V?=
 =?us-ascii?Q?Dz0noq9scb34r5RGVOJQA4dMwbu1o6Ke7XeeqrlyBC3rM5HkmTlP3zNja8M7?=
 =?us-ascii?Q?M3IH12ii1JjpH9Q6kuvNqQPaTarhK8/uIm+Hb9LWc1epSHUObAi9VqgEQUt2?=
 =?us-ascii?Q?2pSSeDxAvyQrBFELeCT0LOepzRqZFwuWxbFn5PTT7Cm8uqQIcIjTvGH6MUls?=
 =?us-ascii?Q?bjqtsG/K7SFS7jYA90wnSciGRyd6MtwCxUcx7oIOPmsyJ00zEklnC4sX7K4f?=
 =?us-ascii?Q?PuSeJmV9krUacwHS1sRiP2Xz63B96waQwAZwyMFDKuXY5K92E/fRwPQ8aVtA?=
 =?us-ascii?Q?u2hMpDaU/fBKQl190kMil3dF59PFn6NVGPW36alNIBHV+4RaFsiPYY5OYF+u?=
 =?us-ascii?Q?vsuPxmWJ4P4yO7nBdFCmUfgLO77bl77CFd5Usn4EfHrbQL/Tu+pEBZciLqLS?=
 =?us-ascii?Q?p8ZkXdLZHfYZ375U0Qdewb6dW40nsbB2/5HIixuIOuAaERRnVw+wP9dk4vIK?=
 =?us-ascii?Q?WMObWVgI1X4omZ8UiKmszD6URDl1factBacJwf+orfg8Va6QT3kuDzxcF7pR?=
 =?us-ascii?Q?vJfDrb4Tv86Mjs92uucraXQZLAtp9bJE4iZLEPNBtOhMZOurJ+1cMeHLdhWC?=
 =?us-ascii?Q?x3ho9nYGH432QYq7p5e33dfXDGDpFK+5pJkILfl/snPN3b+Qrxu1FCBjGg0U?=
 =?us-ascii?Q?1X/dQset1mAaBZZE5uQJpcXP0Clm6A7Kc3FJjPNQvy+EAwRtGTYd7lzrYr9i?=
 =?us-ascii?Q?AVIurV9m/2tcAvTZhC3kyvTikN5c7kpm1CzhYUBYcTlubwMFnQuEmGc/sYx2?=
 =?us-ascii?Q?vtLHJOOduz6JLnL8cUS1lYmyYcTCyFb/PydJg2+u+IH46uFmnbb4vxOSgAsX?=
 =?us-ascii?Q?n3tD/HA5n9+0ft6j6cBeKGlUchExjJ5MvzHc4ZIy2t/d7biXnQqJYt5Iu6Vh?=
 =?us-ascii?Q?3ddfNkQbAS6q5CgNIIU+OY+6yvu7Xp9Ly8TDt8uboiJXhJ0m0Only4S7QoPj?=
 =?us-ascii?Q?wrjGuRZ9X9h+WGLVvoCqC+8OorxRUrYmDRDkNjNl7pLc1DjpdqKv9+RNVc5W?=
 =?us-ascii?Q?zdWWDYHxIYQykvemM/60DLOOWNKyGMlyIlG73veQHhM5EsCtcGFXFvSc/uh8?=
 =?us-ascii?Q?nJwgL3Uv8GUo48sQIIroGL3uAv/26kyRiVwBNfsC0AFLNrvEAKeYZ09a54Qa?=
 =?us-ascii?Q?a6kVK4VtliyOM9RmT+OLn5eTHLgS5f5MgwGFsieBqxcQjQETfwwkohFlC6FX?=
X-MS-Exchange-AntiSpam-MessageData-1: pCpbp5GuMTdOnoD7QEY6tSOaSNcyKxqAIBM=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a6199b-4acc-4ad0-2377-08df01c81734
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:11:40.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5wGW45c1ILQIomHhAzTu9HkGBkdmsuFyZfe2zZyTAmf553CVJw6JIpOp4cCSRi2vyZYBrlsh4RAOmDmOyzDLvLwDsZ/nMl/A6IDrZ96Umk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7341
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3052



On 8/24/26 12:07 PM, Michal Simek wrote:
>=20
>=20
> On 8/24/26 11:54, Quentin Schulz wrote:
>> Hi Michal,
>>
>> On 8/24/26 9:18 AM, Michal Simek wrote:
>>> A number of file (F:) entries across the MAINTAINERS files pointed to
>>> files or directories which had been renamed or removed over time. Drop
>>> these stale references so that every F: entry resolves to an existing
>>> path.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>> [...]
>>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/=20
>>> mach- rockchip/rk3576/MAINTAINERS
>>> index 79cf9e97f70b..62c3ce765e0d 100644
>>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>> @@ -13,7 +13,6 @@ F:=C2=A0=C2=A0=C2=A0 configs/nanopi-m5-rk3576_defconf=
ig
>>> =C2=A0 NANOPI-R76S-RK3576
>>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Jonas Karlman <jonas@kwiboo.se>
>>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Maintained
>>> -F:=C2=A0=C2=A0=C2=A0 arch/arm/dts/rk3576-nanopi-r76s*
>>
>> This is a leftover from v1 which had a file there, but we merged the=20
>> v2. See https://eur02.safelinks.protection.outlook.com/?=20
>> url=3Dhttps%3A%2F%2Flore.kernel.org%2Fu-boot%2F20260108143551.4017839-3-=
=20
>> jonas%40kwiboo.se%2F&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7C20d22=
328c2c14b04e70608df01c79b5d%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C63=
9231628996802560%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj=
AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sda=
ta=3D%2BGNHaQOa3XRWnaRD%2BMBZJDH3t54Q17ZQGynxdQr34e8%3D&reserved=3D0 and ht=
tps://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/
>>
>> For now we don't have U-Boot-specific additions to the upstream DTS=20
>> for the NanoPi R76S but we could in the future, so having a wildcard=20
>> like that would allow Jonas to be notified if one ever gets added. So=20
>> it's not completely useless. No strong opinion on still deleting it or=
=20
>> not.
>=20
> File is there or not. If you add it in future you should extend that=20
> fragment and that's it.
>=20

And Jonas won't be Cc'ed on it being added if someone forgets to update=20
MAINTAINERS (which honestly is very likely), that's my point. He=20
maintains the board but won't be notified if something directly related=20
to the board he maintains gets added.

Cheers,
Quentin

