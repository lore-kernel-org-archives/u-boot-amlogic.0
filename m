Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBCC61DBD
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 13:20:33 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.32])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3715.1787861720940106278
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 13:15:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=cu/irDdN;
 spf=pass (domain: cherry.de, ip: 52.101.72.32, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuD0BmrE/bHHIkibIC1hCMSgTMlEUuSIUnTf9aZRKC3wrSiPo120h6HdF3PaJ3go6t11WwB+11wB+zY7tR1L52nuBxUVAVOS5EbE7G2uvMb/fHEz1YDA5nT7ECiMWNSR/OSOKXllZVfbWufAMg2wIS26wHaCz2UobS6ALr8Xw3ZmuGMDILkiC/Ug/n9mOtvd7P5sjmD9kUt8P+Trelgrl4tljHiQ3UgtQuRDWk3DS3jGzYGYKgDTx3IgEoEITS+T+zpUnhuY5gok5cVnoK234gK9mi5NTgI57lSZOX95vMl1sLizHiOhu5dnwsQVocbjK1popQG/4/P+rDQX0AS0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuQkdLGHWiH56wM1mZiNHtIFlZsLafqsS0F0iSs4jRA=;
 b=gRwuxhhFvMFpeyW02luHhucKsFqkRPaTUUSbrAoI0us9V+zLfPqOWQkDIFYyn5nqsWPLpUnuLWla1bFeCzLTT2NanJjaBx0iLiosb2S0SF9jz31g0Wzqles08ZYdIoRH1DBLbxKsWmhelWnM7Nz7d2yp1Lt4mZPEdXs9O1FjLuOdkGb6NsW5Nt9lzyY6B2ANRFFkHAOytWXl8COD9xuzCP6NwM3usqkfc9uyIMEc5xhNXBeC1YH6ZK8RYLEldjmqhm6OOkvER4L953Z03i2sug3JmpbP3I+OiRn+9wYj6UHQHG5gdc0iv+eIFyisG2Qqm4buJE+sCm0uN8oen4HvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuQkdLGHWiH56wM1mZiNHtIFlZsLafqsS0F0iSs4jRA=;
 b=cu/irDdNpnW4iWvH54AdaU5yXFthCjtiWASUWUzr6NfLZMWob1cY2wd58X7CRIJ6KDQ6IMo1/dOmNhhcKTVL9xC6ht/SC4dOYG3/5+892/AizsMVFAL5E91fd7URyApGkqLUq64X4iNvcvavjl16OXNn3fkkJcLb6KvAnlDdya0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB345699.eurprd04.prod.outlook.com (2603:10a6:190:51::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 19:59:17 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:59:16 +0000
Message-ID: <81241329-290d-4c4e-80b4-c3bbdaa26cf8@cherry.de>
Date: Thu, 27 Aug 2026 21:59:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 00/45] doc: fix some issues reported by linkcheck
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <a2b54c83-97a2-4b81-9c6c-6be32f127985@gmx.de>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <a2b54c83-97a2-4b81-9c6c-6be32f127985@gmx.de>
X-ClientProxiedBy: VIUP296CA0138.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB345699:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f6c756-4612-4447-7ee1-08df0475ac89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|7416014|1800799024|10067099003|6133799003|4133799003|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	l7x2R+vElhlZF57PwhUvH5fcvJWtsZhq3cK2nO2u0NYt5r/7tTZSqvIuFKg66ZWlezeKCtpZUoXylneGIxzOiw2kRQeFic6Rgkp6Cra9LQIoSG5Zkhx+dRB8AEmGLRFu0DhX7RAJXEM++HHna6yBrfRRQEq1XKg4tlsMuxh77bjQ9vzmss21O+wAQBXdpw6vXLe+Sr151po+Tmn4+gPSMJ1tYk8OPcUM1wkfVnxDFE/JckEe5bptwtgXoB5uwtXZ7arwkYNyfDrOiKeh3n0ksO+HlV4Q9ZeceB87XkJcO1t/AxxkM3nAr7VrJG3Ua32KiX84txSZRv4B3iYqNp9988V/X0Hma7gVdvuNbA6Lgojbh7T0ulpuuzRuC74B5u7FXbzJvyIjy0duEjor4KS8eEmSBiZd4nFj/O/LSNbCV0DJ2767kPQCGCA6KpDAFV679TTbVfJnisGCZhSZvnlQK+lqugKn2wKvSdEmvqrlrJd8oqZu8S4oT04vbXWQh73G8vELGmLNkK6+CZ06DGpgo14u5hPM49Q2ohzivymVUQWiWVvrhPEPd8Shh2bfyaisEngdHZT28DcnbYi4ktTPmLAp82MW4AuOYd6yEbNFsWk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(4133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUprTUUvdkFXSko4MkNvbmlHMXFBV1VEZmtVSkRTc0tOWDJuMmRvWkN2NFVh?=
 =?utf-8?B?UWljcWdzeWIweC9DM3paeE5JV2hOVG85dEVQUjN2RHR5YkJTdElvb1hGS0kv?=
 =?utf-8?B?VkpRWmdWM1grRW1HdngwaVRTb3U5b0ZLbmhyZm5kOUFTcWRNdHpzMXlxRWM2?=
 =?utf-8?B?K0ExNkkyaFozbDhzUWtoWjl5aFhwV0l3dFZ2U3paUkgzL0laZmNKYVV0WDNl?=
 =?utf-8?B?a3VxK28xL3U1eXlmYm9Gdm1tSTVpN3E0dFJmODV0WTdaeVlFdTg4Nk9MZnh4?=
 =?utf-8?B?MHJuWmRrb1QxdjRGNUROcThPdkJOTFNtc1YxMzhCdSt1bmdJVWFoaUZmZGhq?=
 =?utf-8?B?SWkzK0Y4c2NDTmZpU3k1VGpKeXFZcEx5bzNYai9RNU5yYVF1aGgzRGhoRW1V?=
 =?utf-8?B?NklyeEIyTmh0cVAyVTA3YXZCMW1mNm42TUpYSHVVb0J6aEpQcUNwYmtZeEc4?=
 =?utf-8?B?ZXBkemZDNUZaMjVyVml2eW55K0JSbWtXZ0tvWm9Qb2ZGQXhhdUxxdHRSREVk?=
 =?utf-8?B?bHJMNXJTeWR2c2RSTU42NTgrRkh5dEJGY1JwM2ZDdThrSkx0eHFNNlp4ZkFy?=
 =?utf-8?B?ZlV2b2dLL3FLVkw2aDBnMHFncU9KdWdRcitNakxYNWl0cUVnYzhMTHcvc2ox?=
 =?utf-8?B?ZjA3Rldya1YySi9RNytzNDVvNkoybjl6Y29WVStyelpYQnFBazZURGtydXJN?=
 =?utf-8?B?a2hIdHpNZm5xT2lsWm1ybDJGaDlYUkNBZldzYy9zY1RLMVNieFdYcFhOR3Fx?=
 =?utf-8?B?S2pva0o1UmV6U1JiMkVUSU1lVTRLczZLYVJlNW9tT1hER1lXSEVOaGRmd3Bz?=
 =?utf-8?B?VWxmUkNMYmRuaE1hYjBSRVZyUE4rdVFpQ2V3ZThPSFVXLy9IajJVNVhpeExw?=
 =?utf-8?B?bjM5cjg5QmRrSDBZMkhwZUlhS01Zb3Q0cUNEYUhPbEJFM0JxY2x2M3NXdmpo?=
 =?utf-8?B?Nm5IU21ZSS96TU1zT051MXhOOVpNdDRoQy9yNTZJSUZCMFY1c0ZWaXEvUUlv?=
 =?utf-8?B?QnBXZkZHa1QvNlZ2SmJ4WU1pamw5M3lxWHNacUhwR0VBdjFDWHg0TG9ONTZ6?=
 =?utf-8?B?dTZjSkRlZGhMZTlyRkVIWG1yS3I1ODJvWlVzQWpldzhNMnQrZVdOR0VYeFFw?=
 =?utf-8?B?R205cVpLS3NVaXBPZW1LdVRvcmpDM01qS0Zzck55RjdVV2tHZ21HdUJES1VH?=
 =?utf-8?B?WWcyRHNyMll5dGVQcHpGU3dQK3VIQ1pWUXVLNllQVVY1V2NaMVhjY3ZHYTFD?=
 =?utf-8?B?RjZDbFFlazE2d2RMdFkySkVCQjE4TlgzNFdqY0JBWGlsVUZOZ0JtREFTNmZl?=
 =?utf-8?B?ZlJyMk1hd2REL2dydmRwYmhNTWlzMmwzRHIxS1VkK25jZ2xieGY3RjYzRm5S?=
 =?utf-8?B?Z2E3Tk9XVnd4N2kyRk16ZzJqeTZBQmNQdzJLWVB2VEJNSEhYR1BkK3QyZjJl?=
 =?utf-8?B?aFBpUG05QkcyV095UnYvcE11Sjc4eTNHbGVlalBSTlgrSG9NMXdjWVV0UENH?=
 =?utf-8?B?NU9YZ2pqdE1lRzFEN09JSFAyRGoxeTlIWlNYRjgrYkw3VnFPR1RuM2FUQ3gv?=
 =?utf-8?B?QVYrMlh1RmdFZWVRYzdMTHBkZDEyRTdFOHlJVE0rcTQ0T1BYeTZIZStnV2ZP?=
 =?utf-8?B?K2R5RjhYa1JmVGh6S0JSbEtjS0ZXRDdKWnJ1MnVWOVpaSTc5Z2ZrbVVHNFVY?=
 =?utf-8?B?aHNqa2trd0phN013RHMrSkF1WExoL3JIM3BMclRQRDVtR2hqOUFKSWNjWjVS?=
 =?utf-8?B?T1ZlNVp6SVcrMU9wbmVlOGtXVDZqeDhFZnIyUGJIUVdYVHJJdm5heElzVjhL?=
 =?utf-8?B?U2NaWTVBS1hMMDV1dnJoTWM0NDRPUEttemt0K3BJeGswcGdSQjVBNlN0QUV0?=
 =?utf-8?B?ZWJGNkJBeWJ2TitYSFhPSEZmRjJldmJjKzZOQlZvc2h4VUN1QjhQVDNTRmxk?=
 =?utf-8?B?anIrUEY4K0RncEpCNVF3dmgxaGJmNHpvVFNKMHRrZFBVRndiMUpWUGtyQmZ6?=
 =?utf-8?B?Y1hjNDMwV21VKzRGb25jRmxjZVYxRkZ2QkpzeHNGRzV0UHV5a2hVVzYrSDVJ?=
 =?utf-8?B?STQ1UFloWGxHRWVtV0FBeTVDc2xTd29MR1BaZlpTeEZsaFFKL0VKT1N3Nm8z?=
 =?utf-8?B?M2RmNE10dzR5MDFLWU5jelNubGR4SS85V0xIak1nWkVRUENpVVZLSzFaajg1?=
 =?utf-8?B?MnJETllWSUwxYllQOW9RS00yZldvTU5tU0tQa01mWUdLdk51cTJhZURkbjVj?=
 =?utf-8?B?V3hwZ2RJU1p6eGZUTHI4ZUszQ0UvWlE5UUxoUWlXYW1xWEdsK0Y1d2IzWnVi?=
 =?utf-8?B?cUcyMUF3cStIOXl0QzBDcSsvQmhaOGtib0ZkTmx4VjNyNVNGNEVYQjBCTldT?=
 =?utf-8?Q?okeZVspwiTd4OnqumaWuaW7O+jugmQmzNf/T5lCFb8kmd?=
X-MS-Exchange-AntiSpam-MessageData-1: PDiEkkDnxtFXIppONe9xqcHN8F+Oro8mqPw=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f6c756-4612-4447-7ee1-08df0475ac89
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 19:59:16.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgKftiEPHSjFSz3brYpzeT/8GpLAEmIqUl98ZqfdfITaPECLjWD05ZKWs2wxOrRkXLeJjgqOYnmNUnuq7zl5RUxY0jp7o5k7mGSPJTj/GnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB345699
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 28 Aug 2026 13:20:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3084

Hi Heinrich,

On 8/27/26 1:03 PM, Heinrich Schuchardt wrote:
> On 8/25/26 18:49, Quentin Schulz wrote:
>> Saw a dead link and made the mistake of running `make linkcheckdocs`.
>> Now I'm knee-deep in it and cannot ignore all the dead and redirected
>> links. A day later, I've had enough so this is what I managed to fix in
>> that time. There are many URLs still redirecting (could be fine, but
>> needs to be individually checked as some big companies have a tendencies
>> to redirect to generic pages instead of issuing 404s...) or returning
>> 4xx. The issue is that those 4xx also need to be individually checked
>> because since the AIpocalypse has started many websites now have web
>> crawler protection in place and linkcheck will trigger those and be
>> denied access (or be heavily rate limited).
>>
>> Please be mindful and only run this script once, save its output and
>> work on fixing individual errors without rerunning the script, otherwise
>> we would only participate in hammering websites even more (linkcheck
>> runs multiple workers in parallel and retries when rate-limited).
>>
>> Note that linkcheck doesn't check for links in code-blocks so our
>> instructions may point at dead links also.
>>
>> At an attempt to avoid tens of people running linkcheck at the same
>> time, here's the output sorted and filtered on !ok status:
> 
> Hello Quentin,
> 
> in patchwork.ozlabs.org, lore.kernel.org/u-boot, and https:// 
> eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.u-boot- 
> project.org%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C3c09d2cdb28041d4b5cc08df042aede7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639234254572323528%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=EVMJd%2FfRl5KHcaDFXZvcck%2F38e8nTUtVCJ61A8CT1Cg%3D&reserved=0 only patches 1 - 21 arrived.
> 

I know, 
https://lists.u-boot-project.org/pipermail/u-boot/2026-August/629812.html 
(for some reason it didn't make it to lore.kernel.org...).

I once again got rate limited for 24h, so the last three patches will 
have to wait for this weekend. I'll likely need to split this in two or 
three for a v2 so I don't get rate-limited in the middle of a series.

> Please, send the rest of the series using
> 
> --in-reply-to=20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de
> 

Thanks, was wondering how to do that!

Cheers,
Quentin

