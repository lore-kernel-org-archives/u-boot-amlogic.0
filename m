Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E7CC7115F
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:51:50 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com (OS8PR02CU002.outbound.protection.outlook.com [52.103.66.48])
 by mx.groups.io with SMTP id smtpd.web11.2323.1750093113801776490
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Jun 2025 09:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=YkgXJQKS;
 spf=pass (domain: outlook.com, ip: 52.103.66.48, mailfrom: forbidden405@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0slcmhsGXZfux6yT4NJpZOurhWw37wcbcAauDfkNtzRNRjHNhXt7ZBKbGN3ZaryA3CTh/sTROuHOk/vmAwCz25YultYued2z3Ttm3obNymWo50wl1QpnBaECC5bTjB37tP5TijoQZoAcMZiKiC9Dbr8N6mYbklQTLteDtGgITudW6vrHyj6l7oR2Le2CtYjXxMflevfdwkT+7d/Fa02dIYRlojPSYyQ8RJdx3l6PG/K+pyK3X+lZjonJ3Nc/sM7waoLKuf639LRHOtNNc8jEyNZ+0O12hV6U+APAOTzf1TM4063Lf15YZz4bdgE7P1uHgWgFmAX+Xhke40gwroI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjDh4x7E3qfcnAB1ZE2xaUSB6eRI6UGNZKRzxhY8E4E=;
 b=WP1Y0uvYtWvxq9Z1lHRsMZCm627CCHb6w2S9reQL43V4lMFTuYO3ijy3zP6WEAXLAmSzOKl/O9djvt33vgfLKJAGcYzOa7VDxt4Yhw7w6smu+eLQmaKGda3SLITvJcAQC0spVWJ2+jf9RVZkkQoJxPcCZ3XPgFhRPD6zzEVrPHSFSwoB7JRsZTbFSoWE0P7ql/vcbWaHOW1uiFUnP3JC2u0moYOaMuuA2ur3XVad/oZTz7WryWFjixgFLas9D+7DlGrBcV3pRZKJpdhxlfxKKF5VbjGvM7gC/TEXpJXjWUrS6ScpoxEFZL1DrZDQRZ/5jbkd13usX531xXuG8lNNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjDh4x7E3qfcnAB1ZE2xaUSB6eRI6UGNZKRzxhY8E4E=;
 b=YkgXJQKSpePhc3VeHzSx3W4YwKiNTn0dFPK98BGL4/ACm3mxFcQynCVoneNfa2ZnMY8LWTEqWVRN2CEEk/U+EiFrHcLMoCtLP5sjErDokkg7UBW2qtUUyIokVcRqHr2tb+I+v/fjEmLyCMYURnaKu5PwrBv8rCXrfLfuUcsTEn8687cHhKPKspmWTzerljotN7WVG9M/dhG0LJElJjre9mMW3Wsf6tLIlFFkV8RZbPCXx2hP4KwzSNKUuJxl6C2MvsWvVB0NVrgre0PJh8yvVSdrwWGIMsezs1pFrleJGbR/mIKKstTCHqEWIubv4GRN+cjJxfPp+gq8/L4fxLx8pg==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by TY0PR02MB6127.apcprd02.prod.outlook.com (2603:1096:400:265::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 16:58:29 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%4]) with mapi id 15.20.8769.031; Mon, 16 Jun 2025
 16:58:29 +0000
Message-ID: <SEYPR02MB5557210DAFC9A63FA1FC27C09670A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Tue, 17 Jun 2025 00:58:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: meson: support gpio toggle command
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Simon Glass <sjg@chromium.org>
CC: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com>
 <28b0f2cc-4403-4473-8258-c08f12b1bd5e@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <28b0f2cc-4403-4473-8258-c08f12b1bd5e@linaro.org>
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <4e2a2b33-9ca3-47da-8bd5-9f5b70d7beb5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|TY0PR02MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d905e9-b82b-4002-823a-08ddacf70483
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|41001999006|6090799003|15080799009|19110799006|8060799009|5072599009|461199028|3412199025|440099028|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3bZ7Y8JNeWCeM3gyTGJYd2W1110UBYrpyQCa0K4VxIVQHAxjdyWEoXpRuVPp?=
 =?us-ascii?Q?FhhO3z6Sqka8wNE+cqYA4WWiEguwUXmjXsy9C1JrMpuSnWvDWzEcYYWQRA8o?=
 =?us-ascii?Q?tMgKg1CVAnD4z44Mhd9xpwok8dnBGjsS6OYEQqJ86ldBzQRyxrjhpE7eZvu0?=
 =?us-ascii?Q?3bKpAPZXCyqCoicWOSG+CZvV5Z0CvVnS53ctLMbCUpNOwUOad8ziFwjn6Pf0?=
 =?us-ascii?Q?8ToQlblliBZN3xVdTLQBp20rMNDhNFWpN9TkhIuYGlTLKDYyoKp8TUgizSPz?=
 =?us-ascii?Q?e8JVg1wOMkReQrxK5V2hUhU9O1pV+SABoUqaw+Iy+cD5v8No3vNUZqTkfX53?=
 =?us-ascii?Q?sAfWbszobPkDW0efkxFineSVa0ZGQK/arrODrbZH+F5A91pSIO3UfswKDdum?=
 =?us-ascii?Q?/wdAnxXLuNENrYsbO1BeYWwYdOWQyaCxz+Q2YDEVOvjyP+BEbE1qL2xWiXA7?=
 =?us-ascii?Q?g1K2efXHCekxOleQLogXUNwIA+my5BNAPDxLYZAHL2gcCJeplTS9qfJvLkdf?=
 =?us-ascii?Q?Uo77hzaX2ehm7yzMyxuENdObEObrHallqG3xsRKMTSYAqGG17WBC6FlygRaw?=
 =?us-ascii?Q?ULFlJET1steJJj+MGWc8AFaggCutbvF3OUrQGp/Pd58qNaUDDm1wB3tk8w5R?=
 =?us-ascii?Q?AFyGA8Z80s6nZvCpc2ZbTfZNQIIk6LAPNdqAix5NV4e9mUkjHE6+eG/06g+G?=
 =?us-ascii?Q?nLLF70ypWJ1j/xHdyPj6LxqJLn2YmsyTQO1IHUqD3klZnnn5aMeK7bheITnH?=
 =?us-ascii?Q?F5CKbFeJPk7YCy+rTZLo+dnUjAdNNA8g5AW6bLCCbMSENVHYCo+g8lH4ER7Y?=
 =?us-ascii?Q?hPxCe1SSYeO4tSPaeuUOxINX6+h7uE63LlK/c6G0O8gNoLUmPsnUofxM2kKY?=
 =?us-ascii?Q?hyN8vCJa3kDUlam5xD9JG5HVJywTdoJ6YVAJbMrdW8O8y53jubw5jeLCtSgL?=
 =?us-ascii?Q?LJcznI0bt6SPCsENc7EmwbQPqItBbNgNbvDEUrXzjpU36oE/OmX8SmrDAfQB?=
 =?us-ascii?Q?CidSYuNAOYjeNqQeVRsokh7HTqRQfgLDUJM92YzeagjvpkUfT08dAaRUMPTU?=
 =?us-ascii?Q?uXb53h9o5DpxMDOb7vfhtH/XnAL3rjoACthou7zQB1fa5sJ6Atz8VA3tFJrR?=
 =?us-ascii?Q?SV89eZib0ZaKa1Zj2g2+6LvLHs2e6ygfX9FP537A25n119B7E3wOdwHW58MP?=
 =?us-ascii?Q?ksnfc8bmTV5JEp0/o3GbEni2Mt5uNRMNpGNJbQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yWxLJB6bVt30Dpvdk6uOH29vzmFaP7hoS5EtYxQxWOFDWvUBfv+Dqa0Zxvpz?=
 =?us-ascii?Q?W2OQeF7z2ak4Goai1CrtNv2VLmEZ7EPKuYA8zwRcFGyzS82CPGczKGRd5z5D?=
 =?us-ascii?Q?4qrnrXQXCUX7ZdbSJPOAZkQRI33m92ammYmOmt/09zIHEXUFgFGAZ4nZ17Au?=
 =?us-ascii?Q?HxZsRMSuJdz218tu5SJtMa4brhFpf5cOreyCa2iO2ngaJ/g1lVWrtd9sc6a4?=
 =?us-ascii?Q?KSKwHAAOBSMN3zNzqgWFqVwcTv7xZrnGXh/o52YiCKup+rheb/Te4z4G0BmC?=
 =?us-ascii?Q?e997rCDFUOQbaISyAK9rG0A+6XteBo4AAwYLVn4iJH/uRRuZeJeDBYGSxMTH?=
 =?us-ascii?Q?jxQvPDi2Erh+cfRLEy/PRXSiXlu2dumrWSHjQLrBSkLXYLMpjroF3CxJPxww?=
 =?us-ascii?Q?SfnUO99Gr3c8wOD5YMkYqGD2D/nQYTNIscOZN5cXrmbXZbX7/HKyRmuG26Kp?=
 =?us-ascii?Q?Ht4Jdf3QXJxRONAB4kYW2r9YERJlYoRGiEbbu0QgDd2OKue+GDjME4/ObKiD?=
 =?us-ascii?Q?g/633LBQRbY4DeOVtWi596vdV8EVWj/w+YfNcEnEeIS9Z78fJAdMeeth0Cud?=
 =?us-ascii?Q?Lh5k+G89NP+BQb7jM7z/r4OJ4S5pmbugVCXbLfMg1if1dOI7q7DuN+sZ4Drk?=
 =?us-ascii?Q?y5nloDzXwwFG7lhqenK7cfEouj6+2JN+a8uzDgQO7mHHzD3p8MqJFIUnHEcK?=
 =?us-ascii?Q?JRDuoIA0UM5TaHmyDp3oNlWsDH4usDogR7EHWjG9gj8s/UB6Mat6Wti/mUjX?=
 =?us-ascii?Q?7puHOwLcwMtFu2OLV8sar+Khs53sg8sADxTvv2nUfR5jOfMgCmmFRXhbTomA?=
 =?us-ascii?Q?BFfT1rMrPkuazltCXsf2YHznLBlZuWFfy88FRGHYNfzg3/BM3H8Hwtg7MB7o?=
 =?us-ascii?Q?YQFcQA2a6rNeG4uIUPennw64Mwu7ZlKx0qyHj/ogBBuwLxAXGkBOIGm4Nj15?=
 =?us-ascii?Q?5grYhJwCyzJ8BmEIifgSLLsz1BNdTlOdBqex3JIBG5uh/NX4PUpqgk/9GKDP?=
 =?us-ascii?Q?0zdfbT8Ulw/EmPIoFf2ozE9ogoYeZCIxGh3stSRqUnVDL/3RvVRuRcDA6f2M?=
 =?us-ascii?Q?buMwJpgP0M+jiui8yh0tzG4WCh1ht55oFjnBIfP98jt9eWWqA7RAdeZkj+LC?=
 =?us-ascii?Q?pPxfLDqRLbv4ciymYr6T7WC+L6CuLp6Zci0GZAI2nzviUlvploVVM6/61Cy1?=
 =?us-ascii?Q?1tsSG4OLQgqlZ2dM/QW3YZDOt6v9c4QZUaa9CVoW47veM7R57bkwfKMuqiV8?=
 =?us-ascii?Q?lfyWNLfYzV/Rxmd6H2Qr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d905e9-b82b-4002-823a-08ddacf70483
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:58:29.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6127
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:51:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2716

On 6/17/2025 12:40 AM, Neil Armstrong wrote:
> On 16/06/2025 18:23, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> meson_gpio_get() always assumes gpio is configured to input mode. This
>> is incorrect and breaks `gpio toggle` command:
>>
>> gpio: pin aobus-banks2 (gpio 2) value is 0
>> =C2=A0=C2=A0=C2=A0 Warning: value of pin is still 1
>>
>> Fix it by adding the logic to handle both input and output mode.
>>
>> Fixes: 2009a8d03fe5 ("pinctrl: meson: add GPIO support")
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>> =C2=A0 drivers/pinctrl/meson/pinctrl-meson.c | 21 ++++++++++++++++++++-
>> =C2=A0 1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c=20
>> b/drivers/pinctrl/meson/pinctrl-meson.c
>> index babf1bccc969..a1f4afd11f94 100644
>> --- a/drivers/pinctrl/meson/pinctrl-meson.c
>> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
>> @@ -117,8 +117,27 @@ int meson_gpio_get(struct udevice *dev, unsigned=20
>> int offset)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct meson_pinctrl *priv =3D dev_get_pr=
iv(dev->parent);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg, bit;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 enum gpio_func_t direction;
>> +=C2=A0=C2=A0=C2=A0 enum meson_reg_type reg_type;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D meson_gpio_calc_reg_and_bit(dev->pare=
nt, offset, REG_IN,=20
>> &reg,
>> +=C2=A0=C2=A0=C2=A0 direction =3D meson_gpio_get_direction(dev, offset);
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (direction) {
>> +=C2=A0=C2=A0=C2=A0 case GPIOF_INPUT:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_type =3D REG_IN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +
>> +=C2=A0=C2=A0=C2=A0 case GPIOF_OUTPUT:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_type =3D REG_OUT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_type =3D REG_IN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_warn(dev, "Failed to get=
 current direction of Pin %u\n",=20
>> offset);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>
> Just return -EINVAL here


Fixed in v2

>
> Thanks,
> Neil
>
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D meson_gpio_calc_reg_and_bit(dev->parent, off=
set, reg_type,=20
>> &reg,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &bit);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>
>> ---
>> base-commit: c5afa1fef49f55146e78d6157470520391c40eca
>> change-id: 20250617-meson_ppinctrl-5139ca06b828
>>
>> Best regards,
>

--=20
Regards,
Yang Xiwen


