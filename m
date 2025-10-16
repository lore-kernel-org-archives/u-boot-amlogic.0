Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECBECCD1AF
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.64])
 by mx.groups.io with SMTP id smtpd.web10.3817.1760606469407567011
 for <u-boot-amlogic@groups.io>;
 Thu, 16 Oct 2025 02:21:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=hOwRpUYf;
 spf=pass (domain: cherry.de, ip: 40.107.159.64, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPoRV+sM+SL/6QyweSrd37si5zR15zebJNa207uEW8W51vXmyKl8A/XfEVuNPQjEGYyHkUews+I8UMaLhsgduQpfbwKwEJXE/hpM2Y+FNhzseZ5VeNViG2o09qC/zRuzPeLHTOY0/y02SdmKuJCZwDEBHLFhTFQSo4c1P6A/Mr+Lz2tzXi1mR6Ea0XgP7m2FgbPcFpT8lmkwR8oqHDS/k/snsnaYKoO5V35nJCtYqoxcJxLYjFqFCHHjzjSVlUbzcVpeZHD/Bxfniy9sXKdpVxIjE2g4jJ9EU5+6H4mmoLjx4vr65Yez6bG28UTKvkHz45EKqzYZwEkIK277jYq8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju7I5LUmoKurHPMzFvSEwws6vrnvvW3jESc/Hav2zDo=;
 b=e4eJl5f8JOQ2u7qOz9bubAa6A8RMYSWi6QhnlkmHFEcvWR8tNA9ud5p/ZuQyzmo+vAuhfFiXCrYasH+Vyaxsrwp/M8pAei2dd3CUIYTTqhHaX1jjEEdl2ZsEQ1KrcPHygSGHRsG7cfalHwTr75rmDo+H2hxWDyRYDWcHXrmchWAQ13q5eqMIbeeX9HZODgx0KTcE1xbEBjZTySlL4nnKLJa4GmNPyQZEXb2Vqge5OVwtM2Iiav0iysuL5IUer6NAImU9WuR8cf9TBhHc72Qn1C1za6+ybpE505gHsd0TEAv18sHYtH2VaDDxYhSvD1/XDkpf0730fZnUqBhZV2EA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju7I5LUmoKurHPMzFvSEwws6vrnvvW3jESc/Hav2zDo=;
 b=hOwRpUYfaH9BPKf9skUU0PD1EZ1lYKx7ba7m0+C6Agu2p0vKi15GypPX3+Dr0nlL5hpZyA//l3zCJkv144pscCala/92JOTJ2CAzt/0JoBCnTFA2sFkD9nmAe7WlTmY/uE80vZXzBuRCiY9vnfghbTm0C7aM/bnVzrQvSSHk14w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8334.eurprd04.prod.outlook.com (2603:10a6:102:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 09:21:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 09:21:04 +0000
Message-ID: <88297023-efd7-47bd-bd4d-a03dff1c2e19@cherry.de>
Date: Thu, 16 Oct 2025 11:21:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] arm: dts: meson-gx-u-boot: add binman configuration for U-Boot SPL
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
 <20251015-spl-gx-v4-6-f5d7fe03225b@postmarketos.org>
 <fc4dbf76-cba2-495c-a4e6-e3f9fc770690@cherry.de>
 <DDJ3ADEZWAMW.27UXI62EV28ZZ@postmarketos.org>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DDJ3ADEZWAMW.27UXI62EV28ZZ@postmarketos.org>
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bed3efc-497d-4759-16e2-08de0c9554ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SjR3OHdIVWpGQ0VQT0JvWXk4QmxNNWYrWFdNbnAyS3BIL2RwQzlaYkFlSHJw?=
 =?utf-8?B?ZnZpbU8vSkE3NnBPWnREQ2tpeE5WZnUrK2tnRm1ZVGFaYXVqK3NCTE5FaXhv?=
 =?utf-8?B?cHVPSjdIeWFBS0VQVjNRYStidm52a2ZUWkIzaXVXRVdsbkVsTkF4VXNxTHZm?=
 =?utf-8?B?K09PS0ZickNNcStrcTV5WnVFNnZGSGVNazRsWVpJT0JvelFwQUlCOWFJUlZw?=
 =?utf-8?B?SzVtTkdDMkFyZlM1bzBocW85UXRkUEVNS0FZT2RnQ05VUzFxOUZCUmRQT3FM?=
 =?utf-8?B?RXY4S21BQjcrYTZxeW16Nlg4TmozdWJ0TVZPaFdLUW44WndlUHdoaHdaWEZt?=
 =?utf-8?B?OXZDQmYzZjFTVlkrMjQ1UWY0MWswTTNzdVg0UXVwNWh3amhuMDNsdSsrWlBZ?=
 =?utf-8?B?cVZvbEpPZFlDenNSa1l1c1I1Y0NCc2tyOUFKSXdlTzl3ZFNyS01XUHBOSll5?=
 =?utf-8?B?VzF1TFBnWXhWaTFWUTZ4Z1B1bHdjL09GWEJLalg0K0FGcmdOUFBIMHBKY0ty?=
 =?utf-8?B?ZXlBeVFoU2RvNjZ2M0VaR3hLOHBISk1xYlZReUVZSVk2Y0QvUThSSm5CWHp2?=
 =?utf-8?B?OExSOCtPTnBYUEV2elVRQ3ZqSFFFUkZLbWc1VThYL2lyT09kSWt1UUhna2R1?=
 =?utf-8?B?Z0QzRjVTQWdybDNoVm5RSk1DR0M2UmpTbXNjd3Urd1g0RWFwK1RsaWxsSGYv?=
 =?utf-8?B?bnhrdys0S3F1YTQ5L282bzlwenRnVXE4b0hKMDlldSs2UVBJZS9NWkl4RG1E?=
 =?utf-8?B?QnRUWTIrRFNac2hZK3pSRHJDRjE5TEtBSmtEeU00OXlzL0s4Q0FyTnpVeURq?=
 =?utf-8?B?VXl2WG1IdkxKVm5OMWNFWjJwdHFORFJ3a1h1NWJDMllCOGtFRk43bERrc0ht?=
 =?utf-8?B?QndIUzVYVXNHZkw4MGRqdFpWa3hSNFF5d253bGt4NUQrQUQvYVRGUXpKeVp0?=
 =?utf-8?B?Szh2V3Q2VGx1ZmF3SVUyNGc2MVBEa2kyWnZWa1JNQnh2TUZsVnJHVnRtNis0?=
 =?utf-8?B?ZXVWZlJFK2ZTeFAwNnZ2dkdvN094ZndXYzhwL1JSb2VnZm45MmcvdHlqczNV?=
 =?utf-8?B?T05ZUDh4TlNDZWZaOG5GVzdPempkY2Mza1BFQ3VJSFlYb0NUaEVTMzNCcGh2?=
 =?utf-8?B?MXVLMkQwZ3hBVHBqbURzbDZvU01UNUNoWi9IdEJndmFBejVzZUFPRUhqWU9z?=
 =?utf-8?B?MkZKc3ZXOVl6eGtHWXMrWDRtVTdjdVBLWXh1cnM4Rm0xVnVjUXl6M3o2Tkly?=
 =?utf-8?B?QW8rYXF1THJTQnBzclArcFhZT21sSXpRQlFBV1dUTTBxWUxDSFZBR0FveUZv?=
 =?utf-8?B?dGQ2UUk2YVVUODhsWm1ZSHZuWkExRmFmclN1VU9sTGI4N1NRcWZsRjE0N1dn?=
 =?utf-8?B?ZHJmOWV1KzEwVVBEQ3BPWFQxdDE2cUhlYXBrcVNWNldTbEg0ZWlrSWpYby91?=
 =?utf-8?B?bUF0NUpHUkdkemZJTEJ4QkJmejJEMEVTN2Nzd0pLaHRnQ2JQdUd3S0lRY3N5?=
 =?utf-8?B?a2NkV1p4QWllWlRUQi8xenpPTEZudUdKc0JQWkVTQ21yeWRTYjhab3dJV2Jx?=
 =?utf-8?B?VVdNL2RuU3B0Sk1TRjFWZjRNcEQ5MVVOY3YyZTl1cFh2VUdzbmo1bFN6QWNo?=
 =?utf-8?B?QWlmekJZWnZxckFlRVdPZ3Y3Rmd1VTlNOXIrQ25zVDFYdDJTS3VYT1UzT0hn?=
 =?utf-8?B?a2dzODlmR0ErSEE4MW02M2VLL3A0S3Fyd0hrTnIrR3J3L3IrR3lUZ05uUEU3?=
 =?utf-8?B?d3FTb1NiUWdMeDlybVo1NWEzdFZNRnZtNk5Jb0lYMWI4aG5lelFhazU3aG1r?=
 =?utf-8?B?K0hqVG85aWZMWmRNU3l6bHFPVnZjcE9iU2M3QXJnUUE5amJwekI4dTJZeCtI?=
 =?utf-8?B?NWw0VlgweGh1TTlDRWtiODVCRmtFT3VsVzh3OTFJYTBGdE5zQ2R5aDVNcE5q?=
 =?utf-8?Q?37zcDp/LT99nvQf0RpktpKAJZp+MxFi9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWpheDFiQW5ISDU4bzZYWUtrUHBrTnFhLzJZbHFENGJTcDQ2T3ArUDR5K2dy?=
 =?utf-8?B?OUtTay90eXEyYjJpWGkrajU1d2N2VG53Nno5dDdqejhzR0hqOEJsOXVuMmMz?=
 =?utf-8?B?UU9DdWdKaFBqUS9rUUlrWlZGSFRreTFqTnlaRVpHdFkrQ0xsc3ZwR0huV1VJ?=
 =?utf-8?B?a1luQjVOeUJ4VTJXMGsxYnFpS2ZBd2JvTU1uSkJDUitscDZCZXJkbG0ybDVF?=
 =?utf-8?B?cUtjNkpyd0RxNGg4aDhZRUE5UHlkQjVNb0pnSE1NL0FOeEZ5QzdKdDdDd29B?=
 =?utf-8?B?M1FqTFVpcEI4NGNlN0xxdDJ4UXcwNjE5ODRhS0pyb0ZIaUttSVYxN0xFR0dY?=
 =?utf-8?B?c3E3ZFBWNjhxSlFsR0c1UFF0NjJhUTdjQ1FQZmJvSS9PSlRZb3Awd0Z0MXBX?=
 =?utf-8?B?WVI3ZnRMQUtSWE5mczdNM3U1TGNTQzM3TXlqWWZURzEzZ0FxVEU5Z1IvN3gy?=
 =?utf-8?B?R1oza0J1VGJ2SnhtaExPM0ROdVVmYjFjb1NJeHpSZjJibXNEZThocEZKZlo4?=
 =?utf-8?B?K3NXaGwyOHVIT2ZsRXdTQ1d6Yk5mRFJBNHRlRTJBVUcwY1RJUVVXS3NIZkU0?=
 =?utf-8?B?OXVhdlFuYk8vVVBWYk5RbXZzNVhna3FNbFh0ajlPVTZTaHczdHpMc201UHlM?=
 =?utf-8?B?RjE5akY2WjUvWHdVU09RNkVhMGNCZXVTVVpaOGJrVWg0UUF3c2dVVmRZN1lu?=
 =?utf-8?B?Z3h4U1hxcXFFYWxIRmpaQmRjYkgvZDgyRzEyTjk3bzUxV3hUaGFpcDNiU09K?=
 =?utf-8?B?Y3loWmR0NXhsNmxGM0Rnc3Z6QzlnaURsNlFLMFhxQUlRTUZtY3pVVmloQ0pN?=
 =?utf-8?B?cVpLUGxHTEYrZ0lmVWhxZFJvWFRRencxTG1qYXBuNENaZHUrWHh5T1daOVhw?=
 =?utf-8?B?MWxrQW4zVjZETmdmWWZTM3pHNXB1elRyS1dTS2UzWEVJNDNxWjdyRUI5RUg1?=
 =?utf-8?B?S2JKNUtFajNNenF3RXdaTGhpR21obU1lWTc5YzNRSktpaUhSZTE1WURvQmlz?=
 =?utf-8?B?NGlPZWRSbDAyQmhYcmVMemdIOGE3bWprMWp4MGs2am9TcXdwRGE5bHpaNmxC?=
 =?utf-8?B?MEJTMjRBYTJ2VThUa0tZUDFzZlpVd3ZCakZQMGpTMkRWQzYwYkhmUnJwYTRz?=
 =?utf-8?B?SU50UmE1MTJxdkM1NFdSbFVxcGcxdG40QVdtRzIxdHdBZm5sUW9JTXJCSUtk?=
 =?utf-8?B?NHpFVTUzM0lhUjlTeWtZNmw0MDR1VkhXaXd5ZVNUejZLZVdsQjJ6bHNaZmJY?=
 =?utf-8?B?a2djOE9CanU3WjFpTjNsVWxGWkUyVGtzTUxBTnU2U0JDN3BDNURaOWZmV1ZK?=
 =?utf-8?B?eGVvZDNmdjEvdmRsSHY5d2R6Y0hZYm92UzcvaVNkMW9yMUhva0Zwb3hnUUcv?=
 =?utf-8?B?eUk4U3B2b3FSYVRBWGpXaTJ1RWY5bFlha1BOcFNQZSs2aDJxWVl0RTYvN1ZV?=
 =?utf-8?B?Uk8wUGxtNi9jMUNaNW53R3NLT3gyL3dOeDdYWHNDaWpKQzhSQ2dUcVlwUnl5?=
 =?utf-8?B?alBBSzI4WkRaTHBvWks3a3JMNXh6V01BS3JnYlMzdHBLSEpkdWFvYWtneWVP?=
 =?utf-8?B?VkZyRVZHVThyb1Z6SGZ1MUh1WWx5SlZSbCtiaTBvSkJLUWI2RW5MTVBOWmVl?=
 =?utf-8?B?a2tLOWFJTW9YbU5KWEsrMUVuTVUrWXBBTThmYnFVdFU3OGcvZUNvMFE2TzJz?=
 =?utf-8?B?aFJsNzRpaWhVbTNMNzFRV1BmNlVkY2liRndlWFVyS1hLSERDTDVWRENyeDJa?=
 =?utf-8?B?aG4ycXhKUXRGdUhIb1Z1b3EyQlk0U0NRNWJKTGdxZnExNzhvVFZFSERZcFNZ?=
 =?utf-8?B?V2EvNlZxcG90NmZjSUZ1Uk9wU2xVUnVvRjYxNW9vSUN1Rld2MnRhd3gzR0Fm?=
 =?utf-8?B?T1RORi9ENW5JeUtpOVdvc0hqZzJMMkM0Qk9Za21vbG5RcmdsNGI3SDdBK0R3?=
 =?utf-8?B?Z1lYVGxxNEUveURlOTA0clJPMVhITkRIeTg0eTV1c3dORm1RKzQ5eXdXejJw?=
 =?utf-8?B?RndqS3BCKzloNjN4WUpNSnhRb1pmNG9haTNBNnhLdURFc1VxVXJ3VktxcTdG?=
 =?utf-8?B?ZTFocTRoemFydE13ME4xWnVsSDhMMlBWY3lJcHI2SXh1WldhZFhndGlnVU5P?=
 =?utf-8?B?T0NudFU0Z2VHY3hpOVhVNlZ5VzdlVEdCL2IyME5WVXFMU1JVSFVtQUQ3MmU5?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bed3efc-497d-4759-16e2-08de0c9554ca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:21:04.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfP3rsafSzlnwiXKPS2STm1VJxOWr+TSG4zm0gtvmIoGyYL24CYhlElv1fkD1NHjhG9TVOpOaENHNhbKqMsp9+Xwmm9ztFGQI7CrwrrDjVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8334
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:35:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2835

Hi Ferass,

On 10/15/25 7:58 PM, Ferass El Hafidi wrote:
> Hi Quentin,
> 
> On Wed Oct 15, 2025 at 5:11 PM UTC, Quentin Schulz wrote:
[...]
>>> +
>>> +			blob {
>>> +				size = <0xb000>; /* The BootROM loads 48K max (header is 4K) */
>>> +				filename = "spl/u-boot-spl.bin";
>>> +			};
>>
>> I'm not sure this actually works? It would rely on a binary located at
>> spl/u-boot-spl.bin, which binman doesn't seem to be generating? Either
>> we;re missing something to generate it with binman, or something
>> external to binman generates it?
>>
> 
> spl/u-boot-spl.bin is generated on build-time, it's the U-Boot SPL
> binary. And that does work according to my testing...
> 

Yesterday me was convinced binman is generating the SPL binaries but it 
isn't the case :) Sorry for the noise.

>> Typically it is generated with:
>>
>> u-boot-spl {
>> };
>>
> 
> ...but I think this is much cleaner, so I'll go with that.
> 

And this is essentially

blob {
     filename = "spl/u-boot-spl.bin";
};

Because tools/binman/etype/u_boot_spl.py is inheriting Entry_blob whose 
default "filename" property is "spl/u-boot-spl.bin".

TIL :)

>> ?
>>
>> If you're trying to enforce a max size, then we have Kconfig symbols for
>> those, probably SPL_MAX_SIZE and then I believe binman enforces those
>> one way or another. If it doesn't, then many boards and architecture
>> have a problem and we should fix that so you can rely on it.
>>
> 
> I did know of SPL_MAX_SIZE... Might have just overlooked it though.
> I think this should be the proper way to do this, yeah.
> 

If I were you I'd triple check though, because I'm not entirely sure it 
does what you want. I quickly checked on Rockchip and I think this is 
rather enforced at the mkimage level in tools/rkcommon.c where we store 
the max size of the xPL (size of available SRAM to U-Boot (third member 
of spl_info struct)) and compare the size of the xPL (TPL if there's 
one, SPL otherwise). See rkcommon_check_params().

Though that tool predates our use of binman for generating the images on 
Rockchip, so maybe Binman checks properly. I vaguely remember having 
binman shout at me that my xPL was too big (likely because it detected 
an overlap with the offset at which U-Boot proper is expected). One way 
to be sure is to artificially increase the size of the binary and check 
if it fails when expected to.

FYI, on Rockchip we went for a unique binary (u-boot-rockchip.bin) which 
contains both the xPL and U-Boot proper at the expected offset. Then you 
just need to tell users to flash the binary at the offset the BootROM is 
expecting to find the xPL header. It's rather convenient (but is a bit 
"bloated" by zeroes if U-Boot proper is much later in the storage medium 
compared to the end of the xPL, e.g. by default on Rockchip proper is 
almost ~8MiB after the start of xPL) because regardless of the device or 
configuration, the flashing instructions are the same. We still expose 
the xPL and proper files individually if you want to flash them by hand 
(which comes in handy when you want to use those 8MiB for storing e.g. 
the U-Boot environment(s) and not erase it whenever you flash U-Boot). 
Food for thoughts :)

[...]

>>> +				};
>>> +
>>> +				atf {
>>> +					description = "ARM Trusted Firmware";
>>> +					type = "firmware";
>>> +					os = "arm-trusted-firmware";
>>> +					arch = "arm64";
>>> +					compression = "none";
>>> +					load = <BL31_ADDR>;
>>> +					entry = <BL31_ADDR>;
>>> +
>>> +					atf-bl31 {
>>> +						filename = "bl31.bin";
>>
>> I believe this is already the case if you set BL31 environment variable
>> to bl31.bin. I would simply remove it and let the user decide what's
>> best for them. For binman this comes from the -a atf-bl31-path=${BL31}
>> argument.
>>
>> The benefit is that you can now point to a BL31 outside of U-Boot's
>> tree, which is super convenient for debugging TF-A, or with build
>> systems like Yocto or Buildroot.
>>
> 
> You can already point to a BL31 outside U-Boot's tree, and this is what
> I've been always doing when testing.
> 

Reading tools/binman/etype/atf_bl31.py and 
tools/binman/etype/blob_named_by_arg.py, it seems if BL31 env variable 
is set (and thus passed via -a atf-bl31-path to binman) then the 
filename property of atf-bl31 node is replaced with BL31. So you're right :)

> But I think having it check for a bl31.bin inside the tree when $BL31 is
> not set is a sane default IMO .. but correct me if I'm wrong and it's
> considered poor practise.
> 

No opinion on this.

[...]

>>> +				};
>>> +
>>> +				scp {
>>> +					description = "SCP firmware";
>>> +					type = "scp";
>>> +					arch = "arm"; /* The Cortex-M core is used as SCP */
>>> +					compression = "none";
>>> +					load = <SCP_ADDR>;
>>> +
>>> +					scp {
>>> +						filename = "scp.bin";
>>> +					};
>>
>> I would recommend to attempt mimicking what's been done for atf-bl31
>> (then you need to add a new argument to the lists of arguments for
>> binman in the root Makefile). See above for benefits.
>>
> 
> One can already `export SCP=../path/to/scp/firmware` and have binman use
> that.
> 

Indeed, it is passed via -a scp-path to Binman. And this mimics what's 
been done earlier in this patch for atf-bl31, so I guess this checks out 
:) Sorry for the noise.

Cheers,
Quentin

