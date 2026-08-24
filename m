Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3394EC5DF9C
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13576.1787566540039556212
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 03:15:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=ADLgWOHD;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.46.2, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jis4lmTMCG/6vVExKNlzVPInPlUKE5K4LDUSPanrTOLxafK8iQltP/aCkPA85oVI9WJlJnF5bkOFsaQhd5swPAoNbyULMzQfgjxDlr8Sm9keMlxWOww6Kd6ms9+tqTQcB9xv1sErR014vjukFBukr3GjZtA8owiaiWl70U9H1K3lUkXY9Wch1i6ym7PI3AWF7G+9rCh2KA83au5y9VVnTtKuot+HfkcVA5UlLQXXmrq1m0jRqHEP4DBdmPsHS9QZxect90M4WrH2Rql0ZJxrziHkrgmIduo8WokcgPDcECcF4XuOvo+j5DgY5YEMOkHJaFuTtYDYe36bywjYdZJ9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NppZK+oPP+XQR+WB2wkjWiBPQyhl6zSP8nSN511MAbo=;
 b=vLbPCj3UeY/b+t7MxvVA/zst+k7J7X8YLOYCxWoFb5NqZFckVcSB3UDs0vMzJqwgExdUnjnj2LrFX3+FWuEkK603bjddd0pQuv5+nU/4m9pvBc8NpYZKcXLO9cF+V0oMHUyFbSnhgseZ//A3dUcxG1KwkNTmYciEOOICvjdx6TBHo0dlbaBFayH+HnpMX/e+OcsddsgibJWW1SBI7V7wWc1OE6CUCyKFyb0xsm173GTWa2xilQeDCpi3kA7U3iqcSTadMd1ct2DTjtJUGxWQRTDIZsDcyWsBegwdqt551inxkH3xYy//KghKkTAX1/y5KfXH4GVSdjpP3XnladKKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NppZK+oPP+XQR+WB2wkjWiBPQyhl6zSP8nSN511MAbo=;
 b=ADLgWOHDtuIQiUETpctMahSI8X9MQA+zafMap9h47P68YgiB5IAjlAMzDdxIvNpaLSRjppfSGJnis8zDu2EKJJzxC4boV80SfoANen6GoHyd2fsZJQQ5IimS/lidtWhhAgNmKG1bFs/eRSHXR8cJl6u1xsJtIP9PcRBV7tjOQL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:15:27 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:15:27 +0000
Message-ID: <ad8a8f9d-8fab-4976-9d9b-10e7f5bade9f@amd.com>
Date: Mon, 24 Aug 2026 12:14:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, git@amd.com, Tom Rini <trini@konsulko.com>
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <e128ba15-d1aa-4414-9273-8fe999e054d4@cherry.de>
X-ClientProxiedBy: VI1P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 20377e99-b342-422b-9b01-08df01c89e5b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|10067099003|4143699003|4133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	jXH1FFF63KJe8XFrOoaDfH/mYZMIuhFUtftCPBX91bwqcCtgRq1/n8GDdZ6KJJz/VTu5+xC5TR4CsvD8IlUv65Uo15Q+ZWGE+EoVgABf592l6jfGt+wy5tA+cG0OOG14ZBywT3o/pmBbE2zkJ5TUvM3RM0eMVOG5RvpTijBy+F+xpf2SnzeFv9JsclHnmj0MujuRsIMQsvi+GlkptndEoc7b9Ymzp62h26ZD85ZljZTagDmJ5eO7AJUKDCpul76SnQ8dCJ+7BBIw27i9H7pCYKAYcLck51Wo4mXXvc7VfhBUKCvxR+3fgDPs+X2lR+JwitjHrGr/8RUI4NX57HdsVXBSIF5xJUpjW/fb7t4oFbUnR36vX9Zi85FqYpgL4PtpgyBJLigOarxXL9tLPKmPbgWMIfBkLxPdxMZmljmp8QvrKBfFeEumFUIooArF2qseHslJNXEOAB5q7vUzNH0vxrYkEw9v4bl+GalwDFSoJxddg4gfXqxVuc2BAalql808eBX53Ep9Q10BFj+frZX4n3AzXC/C5g2+J/6j8DbmhpRi+fndOsfUpjoHAeLFG5MEL3cQKS/rgoNT/530ddFEezg1nCNLx449R646BvgzihI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(10067099003)(4143699003)(4133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xcfshZDG3YBPVUb9AlybP+LlR1HJj5W9IwoLMk6EsQr9JglHYAHZzVvV983h?=
 =?us-ascii?Q?dhmUt4eJZ9T4TkcxgYnkpaHe2yLObbyEzvS0NK1Sl9ec9u2UPb4DD3yEPiOf?=
 =?us-ascii?Q?kp1v26mZaToBMdB85A7mo8nI0CnhgypufF369PssbiCd/uvDEmOoxT8AD7Ta?=
 =?us-ascii?Q?5qTaPWo1oPFfQrkBttRh6nUURUeYYiJsmoyl7qxd63QvDUhNDEche+AzzFh7?=
 =?us-ascii?Q?4CSZSmK0Z4Ub460qG3UuJtsibaS1pYne8TpySjQqe7dnn5RUYR1GyBigTOPf?=
 =?us-ascii?Q?Bb/qLNi2RsFnPr4bcw6yl8hJ+Rx78ou2GQi9avBPGg+fhjhjNuH00y2Ivx+q?=
 =?us-ascii?Q?P2K0d6up8ci2A0ijZcudI6dy8bHBBq3vHVfIhlEzNhGzwz+HNUZ9Lnx6oYuS?=
 =?us-ascii?Q?5qhEp97xK7+B/NuVZrzRn2+PX5GCiwe26pYgY9QiMadZUKI9EHzGPM5UIK1B?=
 =?us-ascii?Q?tFFNsNXnjeDvjQ1KaviocklhRxq6Te4fLMN0k0VMHRrWoqPb/f32cP+GpETV?=
 =?us-ascii?Q?/y85yuL6jFdKEnguWEfoVJaKGsxB/2rRSchK5S2CeT5o8lRYlwAh8HJPLenL?=
 =?us-ascii?Q?I77cF8WaJJzGO7n5+xcFeHTfp2XjpsDC4KXgzCltGg6vqphkTrDyv2SwEx99?=
 =?us-ascii?Q?YfsvGCAVbspgkt6ZUxVlWmOWqkCfMHjZ6mJl0mRrIa0fdMzfZ9xil21OgUbt?=
 =?us-ascii?Q?XvCcyQJM6avJIDepOGpzXo6abQaN7uDVXT3SpiVuYRHRFQIlC7QBOAN0Tuno?=
 =?us-ascii?Q?JvwidWgcVU5wt1js6qQw7adfhNz3Vlh09gf9nLGYZKQJ+BCf9d+vpRZtm895?=
 =?us-ascii?Q?OjN5pkXMr3oItWAf+QxjhIGtuhC9sqfxG0Apw277AtpbACa/SW/O+bDWCgAG?=
 =?us-ascii?Q?o/sgqql8s9SGbBZkreFtyA/1V0+DF9C61lt6Oed5PP+gOPgQBl4ZQH1cuQaw?=
 =?us-ascii?Q?FXI0yQAfY4Kh7KW/6XqdrfyAuZLwwVttrRlaWxV8CHtiS/jIalMOJla4Pojg?=
 =?us-ascii?Q?gWDUajN+0id9lVOMygK6SapcSsJxLTz7kKE5wxNXEei2y1DBL4ynPTX6o4MR?=
 =?us-ascii?Q?dYScDzwmBaz5tyWGVRXOGtX/rTztRQuPiMtnKBrlV3P8LPLcpoBAC+bZdYfj?=
 =?us-ascii?Q?qDp2ck1hCeUhL23b5GOs8nrA931BNIEL12Yt+iQKEM7cro2PPRJVOsHIJreo?=
 =?us-ascii?Q?CZxzv2grfvqOEwq87lqDdQGdEw2WDhqxBaJqYHFmAsst3fC+tC5hfh3Zjt1m?=
 =?us-ascii?Q?Q+x2BvJOm28T6A/uz7kYdM883Feyy/DECLQY/WtZkxxip5MqVgyc0lLFeBK3?=
 =?us-ascii?Q?gpoBgJ4A1OVC+SGjAZMoCV4lnhVQXOSOq2XbzPnjPuO2xuQIfJkvBvRj+oGZ?=
 =?us-ascii?Q?o3wyuDqEZFLNnCg5kIuPFsNTk6yn8J2byh6DDNTnxC8L+DyV/VrKR2RqCCQy?=
 =?us-ascii?Q?8AEALrp3ZQNhn595ZWaC1cx7LJG01Jh6C3Z5gmdKXI6AKjD02S2DywUy2HYz?=
 =?us-ascii?Q?MW9WxUlxzf/F3259yubhJuo3qmplYmizpWssD0haJSE084E9EOrjiaB+vlWm?=
 =?us-ascii?Q?U40QRux+NQYFgFRCeVehxThFG9aVP+1L5e7ZdfjYPPi8bqFP4vsWg1DKmdoo?=
 =?us-ascii?Q?cpHC/YZkJi92Uq6b2oKBiKtOlbPghO+9kMLgReVafYn6X7ckZe2Z0YmjPihV?=
 =?us-ascii?Q?rcibCBO/Dp0YFCv2/SI/04avwMC6C0FlRBoAfYTyKLqllfhp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20377e99-b342-422b-9b01-08df01c89e5b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:15:27.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox0e/k+Sc5t3pih+nf7QbEbMOAa4kovYKRcnZTV4Cs1/A1jvS+Eb6uMVQZ8YHPmt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3053



On 8/24/26 12:11, Quentin Schulz wrote:
>=20
>=20
> On 8/24/26 12:07 PM, Michal Simek wrote:
>>
>>
>> On 8/24/26 11:54, Quentin Schulz wrote:
>>> Hi Michal,
>>>
>>> On 8/24/26 9:18 AM, Michal Simek wrote:
>>>> A number of file (F:) entries across the MAINTAINERS files pointed to
>>>> files or directories which had been renamed or removed over time. Drop
>>>> these stale references so that every F: entry resolves to an existing
>>>> path.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>> [...]
>>>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/ mac=
h-=20
>>>> rockchip/rk3576/MAINTAINERS
>>>> index 79cf9e97f70b..62c3ce765e0d 100644
>>>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>>> @@ -13,7 +13,6 @@ F:=C2=A0=C2=A0=C2=A0 configs/nanopi-m5-rk3576_defcon=
fig
>>>> =C2=A0 NANOPI-R76S-RK3576
>>>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Jonas Karlman <jonas@kwiboo.se>
>>>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Maintained
>>>> -F:=C2=A0=C2=A0=C2=A0 arch/arm/dts/rk3576-nanopi-r76s*
>>>
>>> This is a leftover from v1 which had a file there, but we merged the v2=
. See=20
>>> https://eur02.safelinks.protection.outlook.com/?=20
>>> url=3Dhttps%3A%2F%2Flore.kernel.org%2Fu-boot%2F20260108143551.4017839-3=
-=20
>>> jonas%40kwiboo.se%2F&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7C20d2=
2328c2c14b04e70608df01c79b5d%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C6=
39231628996802560%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd=
ata=3D%2BGNHaQOa3XRWnaRD%2BMBZJDH3t54Q17ZQGynxdQr34e8%3D&reserved=3D0 and h=
ttps://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/
>>>
>>> For now we don't have U-Boot-specific additions to the upstream DTS for=
 the=20
>>> NanoPi R76S but we could in the future, so having a wildcard like that =
would=20
>>> allow Jonas to be notified if one ever gets added. So it's not complete=
ly=20
>>> useless. No strong opinion on still deleting it or not.
>>
>> File is there or not. If you add it in future you should extend that fra=
gment=20
>> and that's it.
>>
>=20
> And Jonas won't be Cc'ed on it being added if someone forgets to update=
=20
> MAINTAINERS (which honestly is very likely), that's my point. He maintain=
s the=20
> board but won't be notified if something directly related to the board he=
=20
> maintains gets added.

you can use N: regex fragment for it.

Thanks,
Michal

