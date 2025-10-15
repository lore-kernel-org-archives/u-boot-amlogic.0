Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99520CCD1AB
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.65])
 by mx.groups.io with SMTP id smtpd.web11.23832.1760549162454913160
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 10:26:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=gXlURPSB;
 spf=pass (domain: cherry.de, ip: 52.101.69.65, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcFF2IqBj5RSLGgPunsOT4JX7AwoRwwx98u0KbueInc46io3DoBD9bU3d84do+8HV4GbmXgvSO4QedRx2GafiqmlEkTMLHLjDxnSHsSy1PoDNKGs5e9wngJb8N5hbNPhrQcXs30unqcWYdkhnsLzof3BOLzmbvLwON4CiosM5vyZZ8vxNWteN/YiqzznNqWVdGaoUy/O1LNJ2U122jxBohy8KtNZadRxoZ2LAWzZDgVU5caga0p2vmtJo3as07LLBxN5zO41oyGutnQT5Uy3U1j1yaz4T7t+RKLun4ad6uid7xXQRjhpgjPPo979eYD7Im/Rtn4NtkVF2Gvaybkbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR1LOsMIe1FLXlWU9reazFY1IcUsrl4dzvBD3hcWIio=;
 b=oE5P/NjxJfpeLcuThIIp7zRefvqWgfMSgjlyaJUDG0jhOp8ciiQ3MdKhPfeAcFeFM3ycsJ7Cqfj4T1ZkpVJmksmGup90mzjMTtvj01FCH421ndEHCqZNS00+Me6qCRVBfI53B1/6rz9sZR4IaPkE15cHyT8xXC2TTm3YCfrvySEHrpz3DhtGJOquXtdqInN3MQsukSNDRWNJYl+D5ke/S95IkNE2K160gaP1nI2fgwGlqQx+6NGSVP9+H3/gtKzVWz8U0JpatUHDgreGyNw6qrNDHgf4pXHcnKDYu2JjFGZR5KcKMWeeaheN9BHx+d7maI/u6Z3zTgPWmWqSMEfyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR1LOsMIe1FLXlWU9reazFY1IcUsrl4dzvBD3hcWIio=;
 b=gXlURPSB/RT4ld5G6nUqqn+U/iNRgVYPnCEUkbEVo5Hl2xzgt68Ecex3EBy9a4shFAE7hT7jHBup1MshHSjPepCoDsjsBGqRc1Ia+G3IOlq+KYDcW3mRQwMreobHiHso5CVvD0OML7OjVzLYvj4uFPwi4nRZ1LrXlm8vJPje95I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 17:11:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 17:11:55 +0000
Message-ID: <fc4dbf76-cba2-495c-a4e6-e3f9fc770690@cherry.de>
Date: Wed, 15 Oct 2025 19:11:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] arm: dts: meson-gx-u-boot: add binman configuration for U-Boot SPL
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
CC: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
 <20251015-spl-gx-v4-6-f5d7fe03225b@postmarketos.org>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251015-spl-gx-v4-6-f5d7fe03225b@postmarketos.org>
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: daade51c-4d9d-47ad-699b-08de0c0df101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW56SGZ6ZnBTd2FqODFxQnpUV2ZLN3VVUFAzd3F2Y2MveTVkWnJYdjQ4bklr?=
 =?utf-8?B?VVVTOGZBb1VpckQ5cHR3L1ZlWHE5dFNQVWdLZzFKSHUwMno0WTU5OGtNRXVX?=
 =?utf-8?B?RXdRSU53Um5Oc3lORXRBbnNua0FQT1Z1NGxXdnRIRHZaa2R6TGdHdFV4bGV6?=
 =?utf-8?B?WGQrOWtzSGRnTEVlbWpBRXZNNU1uelZpWmJxQnByRHV3am5DQjIrVHRsbDdD?=
 =?utf-8?B?N3ZIUU9SWTRNQnVVTTBWV3d5OVRpV2lnU3FiN0NtL2x4OU5yMk5zd09jVDl3?=
 =?utf-8?B?bTJONlBEYkZuSXNTeXg3MWFXaTd1SWV2VnNjTXBHcnB0UUQ0STZnbmJZSVlp?=
 =?utf-8?B?YU1vREI0QzlHZW5rSm5kT29VcktVSStNazZUSUoxL08vaXdSMG5FMkNERXlk?=
 =?utf-8?B?SHgzZ1FuODlqQTAxcjYrcW0zZ2oxTGJUMEdNMnhHV0FjR2lMMERCSzQ1clpH?=
 =?utf-8?B?OXJtNW9uSFRFVG91L1B2S05qcnBZWEZGcExOVUt3cnN2R1Z1Z2FlU2JoZm9S?=
 =?utf-8?B?Y05kVjYrYlhRb1BUTnR2UkN6aklLeVVNTUlkemVlT0dKRkZnQngrSVdhNzBY?=
 =?utf-8?B?SkJyOUZnd3V5aFJHVU1ybVpSdEhtQU1KNjZTWVl0VldvYmVMY1paUjFoREp5?=
 =?utf-8?B?bW91TlVvVHlWTWJpL1J5YUV4dGVaYXVzYk90VFZXMTlPeis0Q2VFdENkeTlm?=
 =?utf-8?B?eVFBWnBIb2MrUXJudExDSHk1aWUzSjlLMk0xTi9yOW8ra3NXeTlkbGJzajBU?=
 =?utf-8?B?UW9KY2lndWpoTjA2dFN5Z1dmM1FjRGhRMmc4T1V5ZXE1WlN2TFZ2NlUyanRk?=
 =?utf-8?B?VDZMMDQ5VG5LbVY1S2ZCWjNiNW1EZThmWEdJcEh1SkdCYVRNQnU2V0hvK0d1?=
 =?utf-8?B?clQyOWdGWFRYU3lrQ2RxN1dsVXRaSkpMRTZxVG9nR1lLQWdYZ3VZSWRpMGtR?=
 =?utf-8?B?SThXbzJEV0ZPNUhwOURsYkN4dFU3Umx4UWZUWEZMSGs0T0krVVNQTXRGQ2Fn?=
 =?utf-8?B?NWM0TWFiOHcySHNaNlMxODlDelVSQ3hhUDR3cW4rOHpHV2ZRTngxMFdadzhB?=
 =?utf-8?B?QVR6UUpRaWNvNWpjSTN4T2VQNlRZN3hpRTVKeVE2cEI5bWF2MmRzblVuL0ha?=
 =?utf-8?B?aURBWjZQd2YrUitTN3VUZG02MnZocUgyT0krOHF5RFdoVHVHR2JldUpuNWdX?=
 =?utf-8?B?QWxVL2VSNlBXeVNuMk5lRU9iZUxkUzlEZnVaclIvY01EU3dYMUpCM043bHNz?=
 =?utf-8?B?aUNjYWJSY1V4ZEViUmoxWTNsMEh0RVg5SGdaL1d5c2hWeUNza01FamVqQ0pI?=
 =?utf-8?B?TUZyUHF5akd0RTlqQWdNMzNvMXloV1pJZnhITFN6Vkdwb1VlWThCcTltUjZG?=
 =?utf-8?B?OTZFcjR5VlkxMjFvVzVnUCtDYTVaTjEzNzJwTWZoNy96YjFGRGt0WEJSWkxz?=
 =?utf-8?B?VHVpdkF0VFhIdjRuNE5ic2EreERwcG5lQ0FYYms3MmtxTGIrWmF4NXlWdFhT?=
 =?utf-8?B?b0J5TG41aHB3R2FpM3plUW4rd2xEL2RIRFpFUUgzbHNZS0E2UE0yZmtqanMz?=
 =?utf-8?B?eU5aRzZFbzYzemkwRWpXR1E5TlgvYzBGak5PUFhMalpXRDkzQlZXRG1tZWd1?=
 =?utf-8?B?ZVdPS2dJQWhkUjFjTXl4Q3M0SFB3dlZueVRGc3l2V0xRUkVqUE52QjFNL1h2?=
 =?utf-8?B?WWhYbWZjbVpmSXFxOTczR1hiOEpEZUpicHlZTW1UM2lEd0NESzBmVlBFcWIy?=
 =?utf-8?B?NWVRV2N1ZngrTmxjankyanZWZUhraEZDNndZMXptbGtKcUxmSUUrV1FZNW1P?=
 =?utf-8?B?VHU0RzRlRzRuTGx5a2lKUjVJTFZOSmZiUUhVdTBhYmxyY1hnSkx0UW9Zakp0?=
 =?utf-8?B?KzVGRmhLV0lwSTlvZnY2dklZeGpRSUorY20xZ3hXWjN2VHBDUG40bTZBSUxI?=
 =?utf-8?Q?HhHPFeKyYT5iMF8Yqc1yxZjl0c9CmCvX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9JalpGbTArallmbFBCY3FFcFQwdHVMK0FydW1Fa2lmenVpOFRza0tydEVz?=
 =?utf-8?B?aW5XODkvQWVnSXJaMTdiVVpZWDRMUEI4Vk4vSXU3bHNjTDV3S0NDS3pMWTdP?=
 =?utf-8?B?QzFsZ2JMTmpwRXdCSkNJbldocTVnV0RPNXRqNnZrL2F3OTJjelNTaWRpWkYr?=
 =?utf-8?B?dUlBcThGZmRGVGJ0K3Jnd1BhWXlTQ01ERHRHbUZHYXgwbGM0clBLeEdQdXlJ?=
 =?utf-8?B?c3pONFV0YThMTnRCeThDaW1tT1JnU0Z2WFRHMkhqR0tmaXBDV0l2THlha0hx?=
 =?utf-8?B?NnMrUnVXYm9yejhXaVhxZjdIeFdiWllTSSs1Z21WVFMreUR0SlZQRW1zZWlO?=
 =?utf-8?B?eEVubWVUdkRQL1ZoRTFCbHZZaUdCUUgrbUFIeUlpY1pWTUVyRlltb0ZBNHFj?=
 =?utf-8?B?YlZuWWttcktLOFM3Zy9IZk1HUys4RTlWMkdIM3dFejR0VVJ6NHJ3czcvMU5a?=
 =?utf-8?B?NXJEQ2RXWk8yOFBQeklpQmFTRngza1o4RjU1SVpFTEdEZm1abE5tajEvTXZU?=
 =?utf-8?B?ZVJxaUs0Ym1lQWNZQzZrM1ltSmdxcXU3b0tUNVN4UmMrdFJzeEdpRERqVHo0?=
 =?utf-8?B?WWRXNG51b3lpT3lLSE9qU3NvakY0QW8yS3Y1SERzcDdhaE80M0sxMHpNMXJZ?=
 =?utf-8?B?TjF0UWwwOTVLUDZySHplRjExTStGRXhBeGo3aUdsOXpFL3JZRXJ1N3kwWmJS?=
 =?utf-8?B?RnVoMFpuNHlmZ0dwL1pHeWdlUjhBSmpWcWxDNnM2bitxTzFjQTN4K1ZCdHdi?=
 =?utf-8?B?c2ZWei91U2Y2ZVJSQ2dRbGRNMC95QXMxTy92Sm8veE9EMEQ1QWJkcVJ3Slhp?=
 =?utf-8?B?QTZuV1FibWJNMTJkMjJsNEs3Wm5XS1ZUdXdNTWtlY1dxcFZBd2dnMitzWHI5?=
 =?utf-8?B?ajEyTjZpQkRoY3VQR2tyQkxmcHJ1SCsrRzlyRThxSjZiM1UzOUZtQ2xFOTBN?=
 =?utf-8?B?THVGenVVYjJyOEtjakIvSzdJWDlmemcyUmpLQ2srbnY0S1VUZHpuQkRic3Fx?=
 =?utf-8?B?WjB1a01RdVBzTVZFdHhkeXBGK1gzMU05bFRFMTNQUHptOWRZNGZyaWJUblpL?=
 =?utf-8?B?WDM2SGpWMDNhOVBnNngwdXMyOXo3cTZRQXlvNnVGQzBvZFJ3Mkxuc2F4ZS80?=
 =?utf-8?B?VUNUS2hGODlYUFdPWDgycEJiNDhwVU9JZk94UzBreVQ2QXhudys2V0E4STV0?=
 =?utf-8?B?aHE2RmNPc3BobnUyWXBaVmIyeW9XNHhJVndIVHliWmNuOStjRTNUejJzVDVF?=
 =?utf-8?B?RnBpTmtleVZORzIyQ0FaWkRSb3psRGhjNWRPdjRWQ3A2dzVkTkJNM2FRZjYv?=
 =?utf-8?B?UDJyb3YzaWYzNmRyczZxWWVHRUYwd1pvT2t4ZGtURGxGUEt6dDJBRU1ROTBl?=
 =?utf-8?B?OWlwbU83d2tEMWlZZEVMN2cwWkVUTmp3OGpXQ1AwWTRoSUIyWEovZGs1Yk5V?=
 =?utf-8?B?TnBZaTFMVUplY3kyQmMrTm13alYxTnN4ZmxvVGFGUjlXNmx2WXFnNERjU0ZE?=
 =?utf-8?B?bmRMazBVRXVMV0tYVVczTmJpOXdjSCtKSnJ4Q21leThxazVOSWJrNTArVU0x?=
 =?utf-8?B?cFB1UFBXWXBMTU9qTDhzbmtFbWd6RnhDc3EyUVlKWUZ2L200WW04WmxVcWxq?=
 =?utf-8?B?a2RyVGR3amEyYVJWVUJPdFA0OHlvMHV3ZlcrZDA2QVpuUmJFZS9pcEVRc1c0?=
 =?utf-8?B?OEo2UzUrajhoN2habEtLK0RUeDl2RUlZOEl2SVVNZXRTOU9xL21IbHgyNW0w?=
 =?utf-8?B?VVFmb0hRS3d0bXZObE1DZG91bFg2V0FPU2xOUXFKOUVXaEJhWGpVdjRBekpq?=
 =?utf-8?B?U0t6NmFCU01rbkdBS09FRWdDTEg5WE1LY1NxRVlmTkE3bFNIVlZtQm1NQURI?=
 =?utf-8?B?dlYwWjdvYmxmay9nWkdsanBlR2RtT0ppWGI2cVpocG43Ly80blUxSnpNcGxU?=
 =?utf-8?B?RDIxWmhjbmxCS0xvLzRUYUtWOGFyTnhCYXJQMzU2R3VLelhLbHk4TzFEa2RJ?=
 =?utf-8?B?eGVFMmVlVkhmQ0N2WVZHT2N4WU43UmpjVFh5bHlDSzk1T1k4UWxMQ3Z5UzZN?=
 =?utf-8?B?bEVWWDJtZUJjMCt0VzNuOHRhVWl1SGc0bnhBcC9OUTFkL0RoY0dVRUJXOHRp?=
 =?utf-8?B?ZFlFNExOaWdJalRRUUYyd0xhQXFTc0V3T2UzdVRhTlZHSWFKS2xVWm53eU9m?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: daade51c-4d9d-47ad-699b-08de0c0df101
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 17:11:55.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CDqH/JJ1I7QZKtwd5/Eca5qM6jLSkPjO+/zT/8PTZLhXvsBaA5ylm0IwOhhtydR3D8EjlxfwCsmqoTc8HdO0q72OIZI3Ev0N2oddjS+sL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:35:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2838

Hi Ferass,

On 10/15/25 6:25 PM, Ferass El Hafidi wrote:
> Add binman configuration to meson-gx-u-boot.dtsi to automate building
> bootable images using amlimage.
>=20
> Signed-off-by: Ferass El=C2=A0Hafidi <funderscore@postmarketos.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Quick drive-by comments.

> ---
>   arch/arm/dts/meson-gx-u-boot.dtsi | 142 +++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 142 insertions(+)
>=20
> diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-=
boot.dtsi
> index 9e0620f395e..d05f869c06e 100644
> --- a/arch/arm/dts/meson-gx-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gx-u-boot.dtsi
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright (c) 2019 BayLibre, SAS.
>    * Author: Maxime Jourdan <mjourdan@baylibre.com>
> + * Copyright (c) 2023 Ferass El Hafidi <funderscore@postmarketos.org>
>    */
>  =20
>   / {
> @@ -15,6 +16,16 @@
>   	soc {
>   		bootph-all;
>   	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +

I don't believe this is required for binman so please split into its own=20
commit with justification.

> +#if defined(CONFIG_BINMAN)
> +	binman: binman {
> +		multiple-images;
> +	};
> +#endif
>   };
>  =20
>   &vpu {
> @@ -30,3 +41,134 @@
>   	      <0x0 0xc883c000 0x0 0x1000>;
>   	reg-names =3D "hdmitx", "hhi";
>   };
> +
> +#if defined(CONFIG_MESON_GX) && defined(CONFIG_BINMAN)

Isn't MESON_GX implied since we are in meson-gx-u-boot.dtsi?

> +/* binman configuration on GXBB and GXL */
> +
> +#if defined(CONFIG_MESON_GXBB)
> +#define BL31_ADDR 0x10100000
> +#else /* GXL */
> +#define BL31_ADDR 0x05100000
> +#endif
> +

First question is... can't this be derived from the binary already?

On Rockchip we do

fit,load;
fit,entry;
fit,data;

for OP-TEE OS and TF-A though we do split the binaries into multiple=20
nodes (see @atf-SEQ and @tee-SEQ). I'm not sure if those properties are=20
applicable to only tee and atf nodes without a node for each segment, if=20
it isn't...

I would highly recommend against doing this.

I would instead have a

arch/arm/dts/meson-gxbb-u-boot.dtsi with

&fit {
     atf {
         entry =3D <0x10100000>;
         load =3D <0x10100000>;
     };
};

and have the default entry and load be 0x05100000 if that really is a=20
sensible default (otherwise put none in meson-gx-u-boot.dtsi and declare=20
it in each meson-gxXXX-u-boot.dtsi). Then your boards would include=20
meson-gxbb-u-boot.dtsi instead of meson-gx-u-boot.dtsi (and the former=20
DTSI would include the latter DTSI).

The benefit is that it makes it much clearer what would be required to=20
support a new family/SoC of the Meson GX family. Or what exactly could=20
differ between families. But also keeps the main -u-boot.dtsi readable=20
(which is not that easy to do, see our horrendous rockchip-u-boot.dtsi :( )

> +/*
> + * On GXBB the base address of the SCP firmware doesn't matter as SPL wi=
ll
> + * send the firmware to the SCP anyway, and can get the base address fro=
m the
> + * FIT. On GXL it matters, as BL31 is supposed to send the firmware, so =
set the
> + * base address to what GXL BL2 would load the binary to.
> + */
> +#define  SCP_ADDR 0x13c0000
> +
> +&binman {
> +	u-boot-amlogic {
> +		filename =3D "u-boot-meson-with-spl.bin";
> +		pad-byte =3D <0xff>;
> +
> +		mkimage {
> +			filename =3D "spl/u-boot-spl-signed.bin";
> +#if defined(CONFIG_MESON_GXBB)
> +			args =3D "-n", "gxbb", "-T", "amlimage";
> +#elif defined(CONFIG_MESON_GXL)
> +			args =3D "-n", "gxl", "-T", "amlimage";
> +#endif

Same here as suggested for the load address of TF-A.

On Rockchip we use CONFIG_SYS_SOC but I don't think you can on Amlogic.

You could set SYS_SOC depending on MESON_GXBB/MESON_GXL/... in=20
arch/arm/mach-meson/Kconfig and be done with it, but there are some=20
side-effects (read SYS_SOC doc).

Another way is to add

&binman {
     mkimage {
         args =3D "-n", "gxbb", "-T", "amlimage";
     };
};

to arch/arm/dts/meson-gxbb-u-boot.dtsi.

> +
> +			blob {
> +				size =3D <0xb000>; /* The BootROM loads 48K max (header is 4K) */
> +				filename =3D "spl/u-boot-spl.bin";
> +			};

I'm not sure this actually works? It would rely on a binary located at=20
spl/u-boot-spl.bin, which binman doesn't seem to be generating? Either=20
we;re missing something to generate it with binman, or something=20
external to binman generates it?

Typically it is generated with:

u-boot-spl {
};

?

If you're trying to enforce a max size, then we have Kconfig symbols for=20
those, probably SPL_MAX_SIZE and then I believe binman enforces those=20
one way or another. If it doesn't, then many boards and architecture=20
have a problem and we should fix that so you can rely on it.

> +		};
> +
> +		fit: fit {
> +			description =3D "ATF and U-Boot images";
> +			#address-cells =3D <1>;
> +			fit,fdt-list =3D "of-list";
> +			fit,external-offset =3D <CONFIG_FIT_EXTERNAL_OFFSET>;
> +			fit,align =3D <512>;
> +			offset =3D <CONFIG_SPL_PAD_TO>;
> +
> +			images {
> +				u-boot {
> +					description =3D "U-Boot";
> +					type =3D "standalone";
> +					os =3D "u-boot";
> +					arch =3D "arm64";
> +					compression =3D "none";
> +					load =3D <CONFIG_TEXT_BASE>;
> +					entry =3D <CONFIG_TEXT_BASE>;
> +
> +					u-boot-nodtb {
> +					};

Why no hash for U-Boot?

> +				};
> +
> +				atf {
> +					description =3D "ARM Trusted Firmware";
> +					type =3D "firmware";
> +					os =3D "arm-trusted-firmware";
> +					arch =3D "arm64";
> +					compression =3D "none";
> +					load =3D <BL31_ADDR>;
> +					entry =3D <BL31_ADDR>;
> +
> +					atf-bl31 {
> +						filename =3D "bl31.bin";

I believe this is already the case if you set BL31 environment variable=20
to bl31.bin. I would simply remove it and let the user decide what's=20
best for them. For binman this comes from the -a atf-bl31-path=3D${BL31}=20
argument.

The benefit is that you can now point to a BL31 outside of U-Boot's=20
tree, which is super convenient for debugging TF-A, or with build=20
systems like Yocto or Buildroot.

> +					};
> +					hash {
> +						algo =3D "sha256";
> +					};

This means your boards all need to have CONFIG_SPL_SHA256 if=20
CONFIG_SPL_FIT_SIGNATURE is provided otherwise the hash cannot be=20
verified. Please check if that is the case (enforced at the Kconfig=20
symbol-level would be best).

> +				};
> +
> +				scp {
> +					description =3D "SCP firmware";
> +					type =3D "scp";
> +					arch =3D "arm"; /* The Cortex-M core is used as SCP */
> +					compression =3D "none";
> +					load =3D <SCP_ADDR>;
> +
> +					scp {
> +						filename =3D "scp.bin";
> +					};

I would recommend to attempt mimicking what's been done for atf-bl31=20
(then you need to add a new argument to the lists of arguments for=20
binman in the root Makefile). See above for benefits.

> +					hash {
> +						/*
> +						 * The hash is used by the SCP and passed to it
> +						 * by U-Boot SPL.
> +						 */
> +						algo =3D "sha256";
> +					};
> +				};
> +
> +				@fdt-SEQ {
> +					description =3D "NAME";
> +					type =3D "flat_dt";
> +					compression =3D "none";

why no hash for FDTs?

> +				};
> +
> +			};
> +			configurations {
> +				default =3D "@config-DEFAULT-SEQ";
> +				@config-SEQ {
> +					description =3D "NAME.dtb";
> +					fdt =3D "fdt-SEQ";
> +					firmware =3D "atf";
> +					loadables =3D "scp", "u-boot";
> +				};
> +			};
> +		};
> +	};
> +};
> +

Is the below really related to adding binman configuration???

> +&vpu {
> +	/delete-property/ bootph-all;
> +};
> +
> +&apb {
> +	bootph-all;
> +};
> +
> +&sd_emmc_b {
> +	bootph-all;
> +};
> +
> +&sd_emmc_c {
> +	bootph-all;
> +};
> +#endif
>=20

Cheers,
Quentin

