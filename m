Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44133.1793197502993499149
 for <u-boot-amlogic@groups.io>;
 Wed, 28 Oct 2026 07:25:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bDFoBQe2;
 spf=pass (domain: cherry.de, ip: 52.101.65.47, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjNTsf54p/62Dz9TZ7ebgEdUicmaVC6jBZvj9CxfXW/HZLugwi2TtQXl13Mea5Z3D8XxgjBpXmUGC+MAw1GZPqrMHh3X5cS9uI5qqFUP09L1rXMG4n8FhbJ0ZugnysGpuTEDMxggoM24vkyMRF7bcX9GGnTWde/jEpIwm/bIfibhYSp3ygOnVCmTnLIPqQEgnwh3WQo5QzVXNx/O612daA7H6S9i6T6UrG65ZlEyFESB/lXDwUCQ9ZUIm1omE6IhYTW4fasOc9F57K8uLqebUMKgwPlnE/HTZvCiqgCpA0oScZ7hcL7HW1brHIIAY1KGs5+2lpzWYW5FgjOqc5FKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Py7En7Ikxwh4omXuGqxUwh+kVNc39H281CPmcq7YBA=;
 b=sHBzYhPuOuPujBqFsJfzjpSAFpP0DtIzzvpacy9xd1u5iThOJgYYXDw0JIoTd7pKDqLM/WtQM0Ghh35sFojnAKlYiWSwJEqC9juhPo9R64hqtRaTGIDeqGxe7PBEU9qRMn35JTAdH4u1uqJrT3SZLCyl2ijZQw4HpUscPZndYNqRj8zrg8g1r+slLW2ppgNaM2FQp37SeJNrOwCDUN7EKDEqjcSl+saCLsnQ7SjYrTyDzmBDmCX02B6IHoklDQ75vhEGIVnkpaRPH8L2sNB0ANecVZ9TM6/6uPzG3LFLM100BwYXDISyYWWV/VQXXqnqVVYLK6iYAMoFnJNDj7sm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Py7En7Ikxwh4omXuGqxUwh+kVNc39H281CPmcq7YBA=;
 b=bDFoBQe2rSmTzcg1N1evwGI9z5MiCLDzM1euwKxeklad10htqSWWMRS11A59RupQzVQHGZlgm2g6Y68mt923zWGAV0BMkzz/4uM4Z1mdn6rAcaPn4ayRgTjQlChwgMLzOP+5ARqOhSCmyTxd8TwSqhMbpBF5Xw3jRs3/xMNKYKY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMDPR04MB11298.eurprd04.prod.outlook.com (2603:10a6:20b:6cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:24:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:24:58 +0000
Message-ID: <1bee9457-b560-4077-940d-b9f75426f8b1@cherry.de>
Date: Wed, 28 Oct 2026 15:24:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] video: use bpp conversion helpers consistently
To: Reza Kurniawan <imkyufie@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Eugen Hristev <ehristev@kernel.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding
 <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
X-ClientProxiedBy: FR5P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMDPR04MB11298:EE_
X-MS-Office365-Filtering-Correlation-Id: edd6e49a-c02f-4197-b237-08df34ff3e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|56012099006|261009223027099003|261022105027099003|261026140227099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: a6jmBwbT77Wik2t4U1rsAa9rw49i/Qlxd5iDSksJ4oCMaTT/lD0ZV+ABkWGZ9Ic7tS+i0n71G8wDwJtt8OjGG2mPDYHl4zamKoXZaITfpEeVBN9dql+K1Y1rQuMqr8GpsptayU2bLB9yQwKpCOYV55MCykYtRavhmE+orYWc8zf35kvly2m/NVSNQASom2x8FFyUke2hTV3GdHamMTcEkNkvULt+AvJkXLpi7x5Vzp6LZNn1OOhXy38QmPnSkdLJh/6hZTzF7611XKKW9gRkMe7LVen7S6JHmfuqRIi6tcvHSH9aEDv22FLYp1b3dUeViIh5lloCIA1gavxZNZtUcn/hFI1IZnt1F2KNdNLninQbG91AbxeZ9sd+VvRbFNv89ZvYKjzPvXB09oukIbzAaKtn2UvFquVDUX6V9X0VGDa1yVgRvXOq2AQGujA9lr36AUGQhi9+ot5JrdFlk6mH5USbU/iaflsLqp6kzkqGr/Jcr8/6hstQNaXCROZXMk1fn76bP+kMG9MzkdVqmhFbo5lgpMRgccsLBJcGY/bKvbuqvwNJkJMM4+Gm8QCxttD3wA/jwRKmovUMVB7er8lUIKvuoK2hIgB56RL2ae5g2PZ+7tozM8OkDEiHTB8FthFm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxVV3M1K25uRlI0MkpRcUZiNml0bU0vU3NrNHlKZWNvUDFvQnNQblpwYW10?=
 =?utf-8?B?algxaS9zeXVCbGVBK3hHbThwS0dyRG5TbkdKN3lrU0k3Tm56SzJpQTgrM1I2?=
 =?utf-8?B?Ti9oazZNclBkQXpYaTNqS3MxVVhmMkljSWJZYXlycWVZRmZXTlF2YWV2cGNj?=
 =?utf-8?B?NlNUUjNTcFRBaWd4amR3ZE11Qy9QR2EyNUpkcndlbSt1bGp6TjBnK05WWkFk?=
 =?utf-8?B?dlU0TjNkeUlRblVxTlU5bHhrb3BSOG1pQ0c3SjcwSEkvK040ZnZ2eFR4cE1D?=
 =?utf-8?B?SlYwcW9WZVB6KytqdkV6NU9PNEU5QVpRRFBHYlFOUHg2YVdpT2gwNCtreG5z?=
 =?utf-8?B?VWdmMHJ2cjM4dDNJbWhZZ2pTeU5zRVFFVStuSm5aVThqU1h2cW1UQ2hsQUpZ?=
 =?utf-8?B?N3lEeDk5VDlUb252eTkwM04zMmxLMXFvZklmUUZ5SWFEbjBoNDM5S3htSVhy?=
 =?utf-8?B?WW1vU24wZEQxTGc3a3VHVGJ2dGJneHVjU1FPK3pLNVpVc2hHVmtZRXNMemlZ?=
 =?utf-8?B?Unh2YnQzZjkyY05BdjUwQ0xKeCt0RllLZndOYittUG1HVFdvclFndythSXNN?=
 =?utf-8?B?Sk9oUngzVVVPZnZmNFMvWDJEQnNRZ1UwbE1tNyswR2hBZ2Q3VzhEVGZmQ3pu?=
 =?utf-8?B?bFBsT0lIRUw0VFFHRmI5OUE2Q3NDcjhpbWUvQUtiZDY4M0pNOTZEMFBhMlpj?=
 =?utf-8?B?RENNeTJtUGNBeWo0ZHEwZWZIcmpXb1QyNkRLalNMN2FPaDN1dVdUUWc5NDg4?=
 =?utf-8?B?aE9JclBBaEZiWXIxTjVrazQ3ZERMUG9PbDgrWmtQdWl2Q3NKakJkakhzcXNB?=
 =?utf-8?B?RjgxTzBQL29UUyt4eXZjNGYzUjQ0ZDZBOHF4WHZNMDZ4ZG1YM3lsUkh3L0pE?=
 =?utf-8?B?TDk5SjhXR201QlRNbWRGSVh5SFAvaUtjOEcrMWo4WG1OVnN6eUF5QlR4UURs?=
 =?utf-8?B?YkxHUlQ5QXBlMFgyQUpoank4dFJHRVlSOHJ0eWh6UXZ2dVRoeFNsSERSR1hC?=
 =?utf-8?B?N3NIa29kbVEvQVBzMWRKY1FKbHJmVE9rT3diWWo3NE0zbmdZbWk3bk9aL1JR?=
 =?utf-8?B?MnhBZVBzQm45UG5UdzhOVzJTU3lra2NQKzBuSnRNQzh5YzRISUs2UWNxV3Rn?=
 =?utf-8?B?K2xnWWZnMjk4VzFaRUlNZXdqcXl3ZHdIbmdPZC9STGRETE94eHg3MzNFZDIy?=
 =?utf-8?B?MHd0RnM4TU1CRFp6ejlzaFMvSHEzSzgrd29FWFVJN3NlNWxBWUtUWjBBeDZv?=
 =?utf-8?B?dWJ1WnZORk1SZ3NmZ0VuZjdpQmtENzJYd0ZhYVliV01obm5YRTJpVG9EL2d1?=
 =?utf-8?B?ZVZCdFFtaWJlSE9CZ21MZ1Q0cWRhMFBFSjFsM1VmWU5xVW5Fb0JLMnNiZHpU?=
 =?utf-8?B?TEVVaEVmZDY2S25USldWNHlOY3dKa1pZRmFuTzVPNTBPVlJUeG1wcmpraVNr?=
 =?utf-8?B?K0xTY2VSc0dVZk9yNmxIODlKVkFZbUZrZlFyUmUveTdCbHgzellpNWxwU2w1?=
 =?utf-8?B?cEIvUVNtQzhMZ3RJNjlUcXlTZnk3OWJGUktiNjJSbkJsM0E4dzRLbCtkcmJZ?=
 =?utf-8?B?MldoTEYzakRsSENDNjBwYVV0YTBnaGtiSlBSekpaRWo0dHVDaTdMTEsxclpk?=
 =?utf-8?B?T2gwOGhET2dlem5OU1VkQTdmaVZyV2pna3dGejRQdDlYS0RoNS94V1Bmc3Fo?=
 =?utf-8?B?anJRVE1jbVdOQnZoVjA2Y1hjOXVIYXVOZlRaVkJnUjRiVWpZUGMyK1AwWVZ2?=
 =?utf-8?B?MFM4ZVZ2SFgwb2gzYnBwUVBpZGRRVXh6emVBeVdOdjBLRUF5TkgvVWVHUW5O?=
 =?utf-8?B?akpJMnlJNk1XbFp3UmRWTlp0SFVSVVI1QTFZeExWREFVcHc3cDB2R090MFA5?=
 =?utf-8?B?ZFlFeVRDTDZiQUsxZVpmNmhHSE1tVnBzN3RNSHNEczJqUE1Vd0F5RnZKVUJp?=
 =?utf-8?B?eHRKRnFJZHBLdnZKenFsN2pFRDJRbCsyT3k0VytvZVg4R3BHcXJEMFNURFpm?=
 =?utf-8?B?cktnbmo0WFc2ejNScjN5cDJPNk8wTTR6MUorWS90b0JjWUl4aUxxVHdVMHBn?=
 =?utf-8?B?azhyUzkwUDUwT1JaNFl4MGxZZ3JidHVsbU9LUENxRnNmU2ZZNTZXaGkwYTBt?=
 =?utf-8?B?enZPSFFsRVNFbnljY1hzR2tPaS8zMXozclhmS1U1dElSb2JzTzNPVlc4Uy9v?=
 =?utf-8?B?c2xrcWNOamZPQWRHZ0ZuUGNVNE42Z3BHN2QxWGVCbVdzMjNWeUxMVUhORkRM?=
 =?utf-8?B?Slhsa3lsZWFpdUVheXg4T3RKRFFBNmNiclJpem1wOHlpVWhMT1RFQmlRbWlD?=
 =?utf-8?B?Rk16b3QzQTFMbVN2c2tqd0lDeU1WNE0vN2RBcGtYZ25ycVBqdC8xdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: edd6e49a-c02f-4197-b237-08df34ff3e72
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:24:58.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElWVIezq1GYP7pCvVWz60WxWXKeAzlDqs22jTykI05mXDaEJfN96XUaZ5vdxhLbjb/+S1iWQ9GXFtZVS7BqPQ/0adU1NH+S3BkaloR9YS/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11298
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 28 Oct 2026 15:27:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3143

Hi Reza,

On 10/16/26 8:30 AM, Reza Kurniawan wrote:
> Many places open-code the conversion between log2 bits-per-pixel and
> the actual number of bits or bytes per pixel, using expressions such as
> "1 << bpix", "(1 << bpix) / 8" and "((1 << bpix) >> 3)". Meanwhile,
> <video.h> already provides VNBITS() and VNBYTES() helpers for exactly
> these conversions. Replace the open-coded expressions with the helpers.
> 
> Using the helpers makes the intent of the expression clear, removes
> duplicated bit manipulation, and reduces the reliance on the specially
> crafted VIDEO_BPP* enum values, since callers no longer need to know
> that those values are log2 quantities which is also important for
> future extensions.
> 
> Note that VNBYTES() is only correct for 8bpp and above, since it returns
> a whole number of bytes per pixel and cannot represent sub-byte pixel
> sizes. Every site converted to VNBYTES() here uses 16bpp or 32bpp, so
> the result is identical to the original expression.
> 
> No functional change is made.
> 
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
> Changes in v2:
> - Convert uncaught conversion cases in the following files:
>    - arch/sandbox/cpu/sdl.c
>    - boot/fdt_simplefb.c
>    - drivers/video/atmel_lcdfb.c
>    - drivers/video/rockchip/rk_vop.c
>    - drivers/video/sunxi/sunxi_de2.c
>    - drivers/video/tegra/tegra124/display.c
> - Updated commit message
> - Link to v1: https://patch.msgid.link/20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com
> ---
>   arch/sandbox/cpu/sdl.c                 | 4 ++--
>   boot/fdt_simplefb.c                    | 2 +-
>   cmd/bdinfo.c                           | 2 +-
>   drivers/video/atmel_hlcdfb.c           | 2 +-
>   drivers/video/atmel_lcdfb.c            | 4 ++--
>   drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
>   drivers/video/meson/meson_vpu.c        | 4 ++--
>   drivers/video/mvebu_lcd.c              | 2 +-
>   drivers/video/rockchip/rk_vop.c        | 4 ++--

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de> # Rockchip

Cheers,
Quentin
