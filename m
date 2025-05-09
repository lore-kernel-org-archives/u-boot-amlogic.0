Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B9C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 12:47:26 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.40])
 by mx.groups.io with SMTP id smtpd.web11.12446.1746791514853797544
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 04:51:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=OwnvGDAu;
 spf=pass (domain: cherry.de, ip: 40.107.241.40, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uie7InAgdK9SsvgQpWs6H55rWfyqORCwMR3iWbwjD9T8aBR3jZPGAxXpH+5WaBD24+9HIFfHARo4ZSIvTDApxGYL9LAX/v6B+fuwj7Hm5VxnAoAHcVsD8zpVNzlpkDclLzYnPp6UOxVz4xxQK5bqWnJlaw5RCH6vqkY8X0sc30IDal6ZOPJEhoswHScE0WfPCNrAoDWwLiBkoPV0us7+WK/FH6EWCY63Udz8D5nXzA2sCvmiUev4GxCf5iCTV0t7ZFk6u8AZ78CWAq+jngnGlXsruj+CHK6THhGk0SU2qfkfTbP99CuBAAf8t7opVYSsdvu0p6EiQvsUujcKCdsaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtIHmvdvkOnMg0C1kHn8TPfcBvHMOP/SMDVqQ21TwD4=;
 b=fzkJdAeB9XhCLOqE4cDfxpXhyzjH3FHsGy1PX2SA3m/ua9rVkxAHYOn0Cuda/ENPavKlwmLKol7XDqDwdSSJdQbffvXivD2ra/oV9S2eb4pdfWMGOTSVYswz1+lU4lWdRzU1heqdPSmQ+KGWzrFMz6adRH9qTmUwWjuv9Ydd6Uq5+e5H4mDdmZufDavEGP9gQ8DsILc0ZwWT6kfHpMBnYoQaIgWouIzew1gVphauPxgJdTiGVYt6tT+Q0Jlj0aE8TQxw7LLQ1Vz3kxAZ6slAYJDxMDXsOWWkljSHLdwzOmMOrJF1I3e4a6W4uP/RG5L0Lmveiht2YRVc77tmNY4MRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtIHmvdvkOnMg0C1kHn8TPfcBvHMOP/SMDVqQ21TwD4=;
 b=OwnvGDAuKiWTVtcLPc5jQ+Q8eku3Ym7gs/t8ofxjC6uiX4BC/4/595pnnxUwyqaEP4dAStd/lKtg0b+Wt5jEdkF2jhm+p/cwNsNAmNtYVNs424gc4uc6bm/n1Ky0RKpGXadSokSGgxQS+GyWKfr3+x3O6RP6xd+eGLYAwNOoYBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7185.eurprd04.prod.outlook.com (2603:10a6:208:19d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 9 May
 2025 11:51:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 11:51:51 +0000
Message-ID: <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
Date: Fri, 9 May 2025 13:51:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for I2C initialization
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>,
 "open list:P200" <u-boot-amlogic@groups.io>
CC: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
X-ClientProxiedBy: FR4P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: a08e89c8-0416-491c-ac86-08dd8eefe2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Gk7ADhICbigD+4Ey5vZ65oYuJVpwX0OsrYShwQT6gSm7monhglzE611UtPu9?=
 =?us-ascii?Q?unVZujLnCgzmKbCjuTNZYUTScVki0z2EA5jAk99VKXb6weqnvTiClrXKhgi/?=
 =?us-ascii?Q?pqXYVm4msmxDZbXnFduMWBNSzmykT+8Zb9CEYuUjpRjmSb+ozMyE//3DoKRz?=
 =?us-ascii?Q?MHf2FYonnkuNmP3tlZISurg0z0qwCt0pY0giUt980NPoUXX8giNYC0U4U7UI?=
 =?us-ascii?Q?WvAS7pFW/yztGhSv29No/X/rYsvBmT8rstKT8hYQQDvBnI/4WXhNrGddxSmP?=
 =?us-ascii?Q?XqjaHejqDEXZfGLBcBVYrOmQXNtv+QxdlcGY/fizo2g6vDvke3ozL/srWLgo?=
 =?us-ascii?Q?MlWtO3QvJBkGhNCOMlvkZ93Goo0he5IzvywQV/E+lMfv4wq5GFcV7bsOmEU7?=
 =?us-ascii?Q?cIOUAYBMe25v8S6fe2fYWGAHmRjoO78bMyr1Erx+Qx6kJlhRdtLeocN8yuz0?=
 =?us-ascii?Q?dHDDXKJ7gTpW0vZqnYlQRhG2rQbfLkgouJojbzQdiW5rTq4IZjHoHfo3XWY0?=
 =?us-ascii?Q?bpjeJ8/NxnjaBWcbP2kpzzropU4iscgj6tM8V6jm5/t1s/R7KOiGP6sGbiGz?=
 =?us-ascii?Q?iVkop5kxFxxhReNxp0XeKNiRr6RPclOT0YZTg14IYoZJWJh6at/6ji0P+Gju?=
 =?us-ascii?Q?9DIazi93i/kWRQn38HQZecPoiuVGsQoz/l0d2gsVEcMr1vUqe5IDQprtonmy?=
 =?us-ascii?Q?X/fETJWSH4Yg5IC95orHDfwdqTBln5MMbpp1b9WvdNhyQTG17OErYZIyRmfn?=
 =?us-ascii?Q?EYRaXkDNpMKU3jngIeJ4sf0jvgw8ELV8PbsXO2iLLQ186FpS2yXZBqKjeCjZ?=
 =?us-ascii?Q?YQQPH1AtimStK8K33XOD4kY+kR9Q83ph+6PXoT3RkYJ0MPrQUfbKipejDYEQ?=
 =?us-ascii?Q?RjySwMC9nWTQzzk+dSMMZ/33S/+v/XfXIFoCqUyk7bypnHZgKKLVitJyfgGX?=
 =?us-ascii?Q?LAqfY4gpebI9HdAatvRLqYQT7NCQkTm3Fv1LC7SSKhRfZ6JbLbDeB6IYVf/2?=
 =?us-ascii?Q?QmN9J4MSW+VKUtXIJ3WHK/fJ+NBb+UZ1G1PpQvzIAWtoGZZnSBqs1aBVssUM?=
 =?us-ascii?Q?GgfQ/0cmiW56tKim9YD6RgjBz9LfxFR12ljQ5cZqi8W4AF3zSQgf4xWsWIcK?=
 =?us-ascii?Q?OdSVXDJ1HOL0h68CzQg2FiC/84tpisKLKPrv1F/LrntNlHrbIUdkpUFQ0hyj?=
 =?us-ascii?Q?Eel2hgu6IDNoQuwe3kip9k1ocpv9DJgvxl00zZ33V8pi031My+O5GiIzpelR?=
 =?us-ascii?Q?zmvj3ZYYaUCxmXoVdgGALStkbq/Djk57M7fOKkJHlY8pnWeDjXnzw1Rdx0Z+?=
 =?us-ascii?Q?AeYVHIJbppCEfubYeAMDktwhVV7NrtQqJWDji4+5jucH5tk081/7bt4Lfyo9?=
 =?us-ascii?Q?m3NpB6rGytfBTufDsGDcv2Q5ffYhnLm0eFkKoQCgEHgPeLNbAQhtQfjf97Kq?=
 =?us-ascii?Q?k/IFiCpIDLp1y0zfE6JSNBbHPTlOh/9C2sf/O3DT9lFGHKRQoTdedQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dXWmBZScJWqjWYbljzhfaMfHM/aJU2jwIc7jpdDKDHuXJWHTYakcO5oxlpKm?=
 =?us-ascii?Q?AmxbK/FdqWY5PYuSyRsu3jsLnsdHWUuF2GL3ZPY0KRUymZrftSEmei0CfO6Z?=
 =?us-ascii?Q?GgHdrzJDc8IZk7lct0i+840GRIp6wFjQo8IO3V0PUdPPn3Kr7qWxFvmLtm/A?=
 =?us-ascii?Q?6CIxW4/iTgzzzhm0YCXXh+e3GAsRcMM0pD24jWfJn20TWCo4a8xq1FgiGdM8?=
 =?us-ascii?Q?5ObWHUtxfPPP3IdWUC7zidyJuFSQwX5EKqrd/fumnooV0rZN5b6pKYPsbrza?=
 =?us-ascii?Q?jbf4+GKH1Gw68k6iINhD6EkTBMK09HkCLlaay449VstMopAVprPSZgFMshbB?=
 =?us-ascii?Q?3pIyRK0lFq3zYRQ38AtBNZ4I2HAnRYWa4Syuv8BATg6vQoX2Y3xZTLU9QibW?=
 =?us-ascii?Q?tVXA/q4FolLrPdEuCWX6usUO//YbGmKLF94TQE0WaExB7np55zhPg4qXIW0M?=
 =?us-ascii?Q?BetPNktYVBG2gN/cUZN/Df121qGkrQPUaP4jw+B++02mqlt26POnwHnvwzSM?=
 =?us-ascii?Q?ol/fxm+EEIrWbBZdVhIKoSRlN46drKFFomv2lDTMojTV67zcu0ECrtD5RAE0?=
 =?us-ascii?Q?HOBb8VEBnaV7Fsoy+U4MZysdwsUcbzJsG4Vhup0HBUNNL14AxJeliSvlaMzb?=
 =?us-ascii?Q?CVvIsLF63zwdBtudt2GWJQu27pTesHs5g/ypibhpvCWv8GTdEBUgdEzkzcjR?=
 =?us-ascii?Q?dkKw9f346ySVFeg/eDdFIU9Lefh0yCH7uuEFW7tbaBb1hH0ZVw6Tx2r3H7MM?=
 =?us-ascii?Q?VfavkYWGeXW4zzgwtRqT1tH1q7xTdNgJVrKqt0lHbkAbSQc1X1z+mVQeaxSY?=
 =?us-ascii?Q?myk7JnutJ0EV42dnoGXyaQrM1stppOLvrVy/VSBeyVg0WWV5KafIRxHgylYY?=
 =?us-ascii?Q?/rLuRBXJAIX88G/rG9WkDtX/dHJnr1Yyc/rO9cplcS2hpriUO+fp8wreh5D2?=
 =?us-ascii?Q?L5vHuL6nrMgBuypXMd/nvB+vbuNATTS8NQqowo2fviKZNfmp9RCF/YUL5M26?=
 =?us-ascii?Q?eddsjRrTU45vP5WHyoa/SD6s+gHyqzC7VFQ2+ByLOCAoPlrvTJ5PMwRmREmB?=
 =?us-ascii?Q?VeNp7W9YJ8N8o/UF6bPZc2msedWlMY0aD1jnRFS77cQVQU4sgo2oa/xqV8lo?=
 =?us-ascii?Q?Bm128CK0ALdB6PY1RbwHevVOrzyVxzgV1lymGhu1yuVo9+WvrH5n8zdt9A3s?=
 =?us-ascii?Q?P7BGP0T3NebVpbciObKn6NgPE906VW5KeYZ3Lf1Rtnd3N4jxL0g06u4yH6Je?=
 =?us-ascii?Q?zBxb7eXmeq9ZlbeWlz4xHjP1z0N1hCsXhvNN/uVyR6kyo+S3r3/fkP1A2POr?=
 =?us-ascii?Q?VIZjRR965C453GH1EsMx2dESOITTz2/GyfbEvYULoCe7QZ0tIT3/iFPyifbA?=
 =?us-ascii?Q?sZsIo8pPtUipiSb/jkQsCZHEj3RxXq+7QVo9yyROGopTxx19an/k3IJFO9Jq?=
 =?us-ascii?Q?Vo8z16AwZZ+9wniFPj4V9bd15O9c8UJpfsbmROAkPkUrXzByyf/7pLlSvpDB?=
 =?us-ascii?Q?KW2b1tuNtqnLnuow8BpqlU8c1WQZOAKsGnVYyTqa6hRR7zAgWV1xjivRk5iA?=
 =?us-ascii?Q?z0FtpakYgHtAJYnon1YG53OJYPh/71f/44aTU7LBGCRNK08zA5P9PEiQlb5Q?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a08e89c8-0416-491c-ac86-08dd8eefe2d7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:51:51.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2ZnvMv8QvwYOHBsvSvuZWpUfNEJUcFZipw3jGhtkLBZk9HTbEu7Ia4GvTqKjbDoLI4p9z90VtGxKhAZn2GMyhN8CQG2MrhfPyz/jHSB6XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7185
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 12:47:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2693

Hi Neil, Anand,

On 5/9/25 9:57 AM, Neil Armstrong wrote:
> On 09/05/2025 09:02, Anand Moon wrote:
>> Add conditional compilation for the usb5744_i2c_init() function based
>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>
>> =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/net-common.o
>> =C2=A0=C2=A0 AR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/built-in.o
>> =C2=A0=C2=A0 LDS=C2=A0=C2=A0=C2=A0=C2=A0 u-boot.lds
>> =C2=A0=C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot
>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function=20
>> `usb5744_i2c_init':
>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/=20
>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined=20
>> reference to `i2c_get_chip'
>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-=20
>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):=20
>> undefined reference to `dm_i2c_write'
>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-=20
>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):=20
>> undefined reference to `dm_i2c_write'
>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-=20
>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):=
=20
>> undefined reference to `dm_i2c_write'
>> Segmentation fault (core dumped)
>> make: *** [Makefile:1824: u-boot] Error 139
>> make: *** Deleting file 'u-boot'
>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>> =C2=A0 common/usb_onboard_hub.c | 4 ++++
>> =C2=A0 1 file changed, 4 insertions(+)
>>
>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>> index 1242513c631..92e3f3a92c9 100644
>> --- a/common/usb_onboard_hub.c
>> +++ b/common/usb_onboard_hub.c
>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*init)(struct udevice *dev);
>> =C2=A0 };
>> +#if CONFIG_IS_ENABLED(DM_I2C)
>> =C2=A0 static int usb5744_i2c_init(struct udevice *dev)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> +#endif
>> =C2=A0 int usb_onboard_hub_reset(struct udevice *dev)
>> =C2=A0 {
>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data =
=3D {
>> =C2=A0 };
>> =C2=A0 static const struct onboard_hub_data usb5744_data =3D {
>> +#if CONFIG_IS_ENABLED(DM_I2C)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init =3D usb5744_i2c_init,
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .power_on_delay_us =3D 1000,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .reset_us =3D 5,
>> =C2=A0 };
>=20
> I think you should completely disable usb5744_data in this case
>=20

I would recommend to go the same route as the Linux kernel which has a=20
special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds=20
the necessary dependencies.

We probably should be careful and figure out which boards are actually=20
using the usb5744 and add this symbol to their defconfig so they don't=20
regress.

Cheers,
Quentin

