Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21629.1793114429094100383
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Oct 2026 08:20:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=QfPtGeja;
 spf=pass (domain: cherry.de, ip: 52.101.65.28, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoijYACEZtudPJpo3FCNWcwz3Nudlq/V9XqFZnN8DGp5XPJ8nrSmD6f3Satv6soq2ggP4fvaYjMywwzRqz54elSWEfj73O2QdFm8w79EWdAzt7rend71iKEM9Ihfh90+9A/PfKBCjKZHI0fOZL7lUmBy14xsGh7DNkeXSOzyBmMlVDsegpnBEZlO1JixeoAZmMkr0n7enbKmXRSoeZtgpWuhtKo2+8aDFkwCfK3l1NaFpCaocb+9lFUlyQ37tRaVBgAAQvGRyTsJ0bbpBBf+hiFraqc1ZtD0t0Y8VqtRy9Xg0qEaUmyIXufpVh5BqpH8deJYTqCGe+pValLaWESrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSfbXMum/hL3rjNUxklomLNu7agipoMTSSQqjArinM8=;
 b=rSdZ6A+v6yoq6X/lwhEOO6B+7V5WAikIQ8ZQ/43gCJPAIlOIzR/89CDZVaepld+uL9WtZHVHafjxkLR0NtmlR+nCzmDsOh02RtRfl60VQeBaixlSSUz+ZiZd9ejE07DlF34qT+HpHVwYWYsNp07jiJmlDiIpIyMEjgAFzGpd8WDYFf/gSrk9OzD+MhuDJSNwiiU1EgDWzoedD4y9wM7G3KbGvDeZOhmJxfxJbj2s5O1dP7KN0hX0ev2lMM+Zi634LIc26FJ/Oj3x5QGs0bNCtFydqn/UHIHlzh2i8F0yO3noyD3/Vgwzu6PvEmmCQSucBJEFs/B1Azdcb6CDjdPT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSfbXMum/hL3rjNUxklomLNu7agipoMTSSQqjArinM8=;
 b=QfPtGejaj1ZahswQ6wPuYNBZYo0o+Y+ONOm4OpuVoOl+z+5ROjsNK6S+yJMD7sGhRtBETKCBwD4UpYfMGhvkns78EbMdkeuMAFDbpg+zFb8HY+OgGwlqLAneauZWWdlLZrm5y8SMoUOFCoUk6kG+iWEq9eNMQO4xZe7J35yjbeU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI1PR04MB6782.eurprd04.prod.outlook.com (2603:10a6:803:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:04:28 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:04:27 +0000
Message-ID: <0bc7a7aa-c51f-47d6-acc3-22d554ecc09f@cherry.de>
Date: Tue, 27 Oct 2026 16:04:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: regulator: rk8xx: add RK818 LDO9 support
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Shigeaki Asai <y-asai.0816@docomonet.jp>, u-boot@lists.u-boot-project.org
CC: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-2-y-asai.0816@docomonet.jp>
 <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
In-Reply-To: <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
X-ClientProxiedBy: VIVP296CA0076.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:352::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI1PR04MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: c8609c02-52f9-41fd-b4a8-08df343b986e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|261026140227099003|4143699003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hDM2seZi7Mj8R4c7n/GnqiW1ycmGcP3BhU2sh/nMcVxVnkRz6xUdksFXUORnmR4lmRAylq/yDd3HfEzcVJwAxCqRueK1kifdTJ6YAwnojXSWaBFCBmb79YWI+aZ6KF+aR8exGWQ0N6uUg2f5f8wAasO6WNnmQ0KJlRDuqW3GeKJVDxuyDGbQ4olK2eFkmPm0teWTbBpsQdg2NcZI5N/Nf5bXEjR86CHMfK0F7cdmiMpffXgF2r2cp5dM6/p3obiXG/Z3Jm+jWtRv0HcXPBtf+6Viu+yE/ZmIzlcoyAqOA3wvw51ltDpB0mx55A41rsPDM/PyQiJlGsM22CZAm5BprUEj7/FSzI0epxIJIXuvkGtxiuEhvXlzVnbENs5qX2A/lmwKTJ6ovarb1lvBJLlKNLqZk3lVDwC0Yvwlb0ELe5qHgOdM/bkydcTbQy/b/ftu2EagOskGm0skL3Uw/5smAwXCGKTTFrIIi5g8qpoUBb3kbouZYVm9mrL3o6jhi18WS/XSZzJXYr9gG7mf8G1Vfl64CbLUIpbtmSnKdfvmb/Lip7m1uTEwdVbIWKKv3xklkSpWuuvsTf5eDm1T1yVbM6sJZGsUzfA9di/BmbMcf3MTYJLpFa6WdrHT6kpsuniL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1kcGxLQXJuVzNHMzFtUGJsRnd1L016Zit3aHZLdjhxNzZzL1Z3eitrNUp5?=
 =?utf-8?B?elQxc0cxVGpnR3RkU1NldEZoaGxuZVBKZG0yRm9nVlh4SVg2djI1TDJUTDBm?=
 =?utf-8?B?VlBqNWhyTjg1Y2p4UjVwR3E4YjlNd1JMSFUxczA5YnNBUVVaSWt2QytZRFE0?=
 =?utf-8?B?ZTJWQ3NpYUthMTExL2hnTlVGTjkxSmRzVGR6WkhIbVQ3RzJ6VzBKeWQ2RCtZ?=
 =?utf-8?B?eko0cW9BWk5tQUZzQk1rMWFGbnROQkhLeVZBMy9MQXB0dHVJYm9NL2F1RGhj?=
 =?utf-8?B?ZGEyaDk0K3d4MHY0elA4VVFoYklLQVRUYk5tUXA1SUVJOEUzV1ZBMDJUOW5k?=
 =?utf-8?B?UE9XY1ozR1NhV1dzVkU5QVQ2NERiOVZ5RC9lSGJoRjg3ckhnRzZZRjV2c0tK?=
 =?utf-8?B?elRRSU5qNjJxTUhhNVhra1NqaE4wVlc4OHBGTWtGZmo4bm0xVVVtM093VmVh?=
 =?utf-8?B?SlRDaTh1UWdnckxRS1VoNldMeHgySXNMRjJ5alVvNzFxUHBiK3RIMHVxVHhX?=
 =?utf-8?B?bVROanRMTWdqdFhObTl5Qm9LZUVoRExTcUtIVURjUkNsT3pZd2NtL0IwWkpu?=
 =?utf-8?B?MEg3Qzg3aFRGRE1RRW42U29iNkcweEllZGxEQzIzUHR1YmhBQXFtUUoyTjNx?=
 =?utf-8?B?ZTNscjVpTWtySTlFNFZhRCtFbDdnSGNsWnZ2Y0tVc205Y0hBNkxienluQ1Iw?=
 =?utf-8?B?TFA1V3k2Y1YyZGVsOGNsQktWTGpteDNaeXc3bTAvdnJGZzU5dGZ2cnRNU3pl?=
 =?utf-8?B?ZWZzRCtjK2ExWDZJZEFRcWVCQXdLK0YvV25MSlV3eEF4dzVWcldwOWtYbTB2?=
 =?utf-8?B?eThSN3dvSXhvV01sdFhmWEpha1pZSkhCN1Q3ZlNDdzV1ZUdtekxwUXMxblZy?=
 =?utf-8?B?cXlnNE84QVIyMi9rTjI2K3Fnc09rdzdnNElIWkhDcnB4K08zZnYrWWxjWlhl?=
 =?utf-8?B?NXpmWHo4NFVTeVBPUm54VTJBK3E2UG1nL1ZtSmtmNkl6QXNRcTNuSHNVdTJk?=
 =?utf-8?B?U21ZeVhGdENMM29tWGFjamE3NVhQRXJXcDNsTk9LaktnY1BueVVjNW9JMWtF?=
 =?utf-8?B?V2VkZHpKMWJDdi9mMC9yR25qWXczQzVOZ0E4WDNRL0xMakZhSTlWVEUzMXNx?=
 =?utf-8?B?QzIzSG51RklqVlJFdVFOK05HMzJGSmE4L3JhR01EU0ZyWTRyL3lybUFmblg0?=
 =?utf-8?B?K3hpNGZGd0h1SGZvYWU2SnA0UWU1UXdkNHVzVFdUZXd5SmJqVFBTOFFRaE90?=
 =?utf-8?B?c3hsdFBHSFVocnpYUXdlSTVWZXFReU1rekdOYmc2VVhxb3dLZ1ArVWJTWSty?=
 =?utf-8?B?a2x1U004QStCamZlWkFVTVUrM1d2d3VpOTlRSkk5SndQeUZXNnlVbE9YbVdv?=
 =?utf-8?B?S0hoeGhIQ3QwWHk4Y0NuVjhVK1d1amlVcE5SSjBsQzQ1ZWZSWEJwTkpPZ0po?=
 =?utf-8?B?NEVOR3R1ZEE3cTY5MXh4dGRncTg4ZFVXUHcyYjBZR0NMVXlrdmhzZjRnY0tY?=
 =?utf-8?B?cVRUREtrNVR3NDU0SHVYNEZ2MTZaWGExV2JBcFgvLzFkR2hSdERVaHF4ekZS?=
 =?utf-8?B?UGdlUjIxZmJ1UHZNRGwrMkZGemdnUEF4YnR5a1dVYUJqZEliNDdNUWRJbnlI?=
 =?utf-8?B?bXp3YTFkOGUzVEhKSFEwMHFnb1VJd3RRTlhRMThQYjBkNmorUkZHYVMxcGRs?=
 =?utf-8?B?TWpkamIyTjJlTGtMRFROdG1McHd0azNFNTdmeUtsT1MzTXBiV1M1Ykkxcm5v?=
 =?utf-8?B?alFCMjAvWTFWWW1wcWJSRUs2QTFRdmVmNEJaUXJqYXR0bVh6Y25PeWpNcjJD?=
 =?utf-8?B?bEswdHZzaGpRb0RSaSs3d0c0T0RRTU9EcWtsYmwxSHNkN0xMeEhEYTU3akVy?=
 =?utf-8?B?cWtKOTl1dDdKdFhGTjV5a1Z4OTJpZVpUek1OYy9UbXI1T0NMUGp6Wi90cVha?=
 =?utf-8?B?UC91cXl3dzlVMTNlekI2Rkx6eHgvL2ZEbytkeFdNMEl4OHpjRXJ6YnlBWlN1?=
 =?utf-8?B?RnhvRGh0MVVRMWtTMHFhSnovc0JpYnk5WGJsRXo2VTgzWnRYTkFCZ1JKQW5v?=
 =?utf-8?B?RWxJWkkwd3N2OEdFRFlGREdsMGIyQ0RCNFNsSjduMEthMVJBNGtDU3UrOHBx?=
 =?utf-8?B?Zm9LU1JhTU9wci9DbFU4R3JEWDI4VVZjekFtWW1UbkFPYzU3VjJWeXl6ZTNj?=
 =?utf-8?B?ZWRSVVNCOWgyNkxySEFFWk1nUE81M0QyeXJQUWhLYW5KbVdQTmRuWXc5aTJK?=
 =?utf-8?B?SHdMbUEwTG1WNVEvM1NsTDFRZzQ5aXpPMWtSQ09udXhqV3VXY0dBUGQvN2JK?=
 =?utf-8?B?QzVpenJGV3hYbUR6eUZKOTFDeTNOZWxCWithS253c0h0ekVNZld0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c8609c02-52f9-41fd-b4a8-08df343b986e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:04:27.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Di3dtVvWGUMk66r0SL9ELU4NKYpO9cF9aibIwlwmFcdcaIYnhas32cnttuwjhknzePcqGXc8KsHL4+yHC3yeFBQu9Et0jdAz3/BPQGZTow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6782
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 28 Oct 2026 15:27:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3141

Hi Shigeaki Asai,

On 10/16/26 3:05 PM, Quentin Schulz wrote:
> Hi Shigeaki Asai,
>=20
> On 10/10/26 3:32 AM, Shigeaki Asai wrote:
>> The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
>> LDO_REG9 indexes past the end of the table. Its voltage reads back as
>> garbage and it cannot be enabled or set.
>>
>> Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
>> registers (bit 5), and its voltage selector lives in
>> BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.
>>
>> Add the table entry and handle LDO9 in the enable and suspend enable
>> helpers.
>>
>> This patch was written with the help of Claude (claude-opus-5-5).
>>
>> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>

The patch never made it to the mailing list, c.f.=20
https://lore.kernel.org/u-boot/ or=20
https://lists.u-boot-project.org/pipermail/u-boot/2026-October/thread.html,=
=20
can you please fix the consistency issue and send a v2 and make sure it=20
hits the mailing list? This is fixing a real issue, even though you=20
don't have a need for it anymore, so I would like to merge this but I=20
cannot if it's not on the mailing list.

Thank you in advance!
Cheers,
Quentin

>> ---
>> =C2=A0 drivers/power/regulator/rk8xx.c | 46 ++++++++++++++++++++++++++--=
-----
>> =C2=A0 1 file changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/=20
>> regulator/rk8xx.c
>> index 88453bb7bdb..cb402c96ec8 100644
>> --- a/drivers/power/regulator/rk8xx.c
>> +++ b/drivers/power/regulator/rk8xx.c
>> @@ -60,6 +60,8 @@
>> =C2=A0 #define RK818_BUCK4_VSEL_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1f
>> =C2=A0 #define RK818_LDO_VSEL_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1f
>> =C2=A0 #define RK818_LDO3_ON_VSEL_MASK=C2=A0=C2=A0=C2=A0 0xf
>> +/* LDO9 is switched from REG_DCDC_EN and REG_SLEEP_SET_OFF1 */
>> +#define RK818_LDO9_EN_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BI=
T(5)
>> =C2=A0 #define RK818_BOOST_ON_VSEL_MASK=C2=A0=C2=A0=C2=A0 0xe0
>> =C2=A0 #define RK818_USB_ILIM_SEL_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x0f
>> =C2=A0 #define RK818_USB_CHG_SD_VSEL_MASK=C2=A0=C2=A0=C2=A0 0x70
>> @@ -297,6 +299,8 @@ static const struct rk8xx_reg_info rk818_ldo[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0 800000, 100000, REG_LDO6_ON_VSEL,=
 REG_LDO6_SLP_VSEL, NA,=20
>> RK818_LDO_VSEL_MASK, },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0 800000, 100000, REG_LDO7_ON_VSEL,=
 REG_LDO7_SLP_VSEL, NA,=20
>> RK818_LDO_VSEL_MASK, },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 1800000, 100000, REG_LDO8_ON_VSEL, REG_=
LDO8_SLP_VSEL, NA,=20
>> RK818_LDO_VSEL_MASK, },
>> +=C2=A0=C2=A0=C2=A0 { 1800000, 100000, REG_BOOST_LDO9_ON_VSEL,=20
>> REG_BOOST_LDO9_SLP_VSEL, NA,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RK818_LDO_VSEL_MASK, },
>=20
> Please stay consistent with the rest of the file where we have=20
> everything on the same line.
>=20
