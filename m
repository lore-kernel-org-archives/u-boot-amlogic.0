Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BA4C3DA6D
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 07:17:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.84])
 by mx.groups.io with SMTP id smtpd.web10.17053.1747893294441978857
 for <u-boot-amlogic@groups.io>;
 Wed, 21 May 2025 22:54:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=l7qEM9v9;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.102.84, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxedrxh5FKi6TONUhPuCINxXugcw+ksL+3rSv4toBx5vpTOgAGZGSnG8eLpGqJbAdLMfc92gey5VM1TYjIqAjMuUhQf+fyxzbp37YfBDzeMCmw/HgTm0nRYKQXm11cGPtpHL0Vqb13GCIyQuSUTMOVGG7LCCgqKf0tuMoBsS3hV1XecDjELJdkPnS4erVXsGg2QeY4q2J7Or41vEwHcJleJWw5ke3PO+vbBWXo63A90m0BEd8aWGbJRqyc8hT0ztDw24adsraIozjFa+DyTzeDYeOS1atrBcuHXVNBfqZu9dHFEgsz5XLM7nA+KhonciYqLp02WGBhqW4gIlddvgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBEXNlwGh2CofAvh3Lv5ln4J1dr6WXvnqDvvipi7AGc=;
 b=WfsWugWLd2MegAvabhbeI5/ogHlotBb5Mk+Nc4NytBT+OdOLNqaTj/oAtj2HMqFd6DZqRKEbZvAeh0dlvsA8dr43zafeX3KSkQ+P3HV8ykROxPNhArUFI3a74u2bxdilzc0Pg208lct4eIg+k0aDih7eZjx8GuZPt3fX2S7nmtGqJfCvUysPsd8jWfsGyf/JPbJIQyXlfJHHT/w1YhTS4+TVGOx3vYDtmMPKz/VEgkgRH037LUz3gcc86AQu8KVyOtgaAX5fYkSrrRPvN1Oow/KLeCaDEppYGTA4iSASWCHk7BSimRtN8cLHRrSNhWsHTphdvTFRXN+I0SebexM5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBEXNlwGh2CofAvh3Lv5ln4J1dr6WXvnqDvvipi7AGc=;
 b=l7qEM9v9i3FQH/WHSfRcIoO8ubPJCDlV0sBu6mibEb6WPRQKC99F+ZZvApipeWCyMBUIHFkTZh60GNhqDimpjemL22eMeY9/Aezo0PxJS4hlJH9f4NTubqF6qi5JdG297u0zVR7+t3ObwheJD44R++d4BKG92KFiPOU2phFD1ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 05:54:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 05:54:51 +0000
Message-ID: <c09545c8-a074-44bf-bac4-778381763a5f@amd.com>
Date: Thu, 22 May 2025 07:54:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for I2C initialization
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Anand Moon <linux.amoon@gmail.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200"
 <u-boot-amlogic@groups.io>, Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
 <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
 <5c8a4460-6d11-46d0-8863-739c94682120@amd.com>
 <62fd78fc-b82d-4876-9a52-b95b07d3e393@cherry.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <62fd78fc-b82d-4876-9a52-b95b07d3e393@cherry.de>
X-ClientProxiedBy: YQBPR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e198cc7-bd22-4222-7c87-08dd98f52b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ejm6mNeqX3kftSzkbk7RIUmgCLXeVMspL+aPjMzsaF54lIDuOnwJPS5aRkBY?=
 =?us-ascii?Q?IXUOqxRYvXpNNLhuHkGmzzC8veg9ZYg1a1G7lRtW9pr/+JYFr7xqxp0UYy1f?=
 =?us-ascii?Q?O7a4/hPRPaAgO9Q/yOcDAM4Nk8lAtBRyXzI0t1P4AoXJfPf9B+1+vtw2X+B8?=
 =?us-ascii?Q?LFT8EA6u4iLfid/skGbKvLFRwFCI54qKVrmxMvgFAtxgdKClnwqhk9OSNAeZ?=
 =?us-ascii?Q?5eqBICiixXAVzWNbuKPECa/weiXSfglxfFyX5uQ4CPz6o5PCyVfZbBUoPsR1?=
 =?us-ascii?Q?vGaDPBaW0o0TnGUW0svdmqEyWgb/s/mLooY7LXrzkyJ4Cxo+iCZHVdY+j1/e?=
 =?us-ascii?Q?DjyY5eCnIG1RC8iZmslEmH9iORRJAKRV2E6TN7VQZ1ahBQRL6QGwxTJLw2JW?=
 =?us-ascii?Q?+9SGnh6CloVw/4yyjDgowihREbUG2PCN9VqHs+B5mEbk2/wtGZ0jC1ILJmGH?=
 =?us-ascii?Q?c2D9I61V21l9zBW5gnOqDgqNz1W4T4ztpsO47/6DMvbADFCr9emvV35KZsKv?=
 =?us-ascii?Q?JGPT7b1GpkWTHUlTXdyGa4tebmOGHTiyiEPl6Sv/4aSSLphTMq+xYWIMvlFC?=
 =?us-ascii?Q?2FSub852iPmR3Sbb51hO2fEGYRLP/YZ379MtMILrcERoTQHEjklEzwghCLPh?=
 =?us-ascii?Q?ZP6h+aEM96fkLRX+70iBXvJtN3U2VqliMS/lvRRtGAVqE6Afvx8l++CLXO82?=
 =?us-ascii?Q?0nBqL/UYjB1UjvA3UqANohXS0Z0YqZVGblparu1ShuAJ1U04C8Dx1gFV3RBW?=
 =?us-ascii?Q?kBuvwPXMHNNg1HnWva8SPNsqYMHIOuGHagPAgoBjwlD74vuFQNkkKjhhDXxw?=
 =?us-ascii?Q?0vw/s4QyDZvTpaYOa3Rx3hv/LWNvCZ0jlbQIhW645d8wJPiwplY9f22X+5We?=
 =?us-ascii?Q?lZYuiXopYKrrGssip/5cYy5HQe+hBmII5CzhD3Q9TkjOhZ2N/4UguDbMziLC?=
 =?us-ascii?Q?aT59TwGeBfBwl5sdpB+GLxh+ePpIeiVNzmF1Zwd0eTgmmjTcCdmKNkNPPR2e?=
 =?us-ascii?Q?6407Onv2xdxr/hFJOL1vXwf/YbYIysCM813MkAW4p+aZt5pnekchRRsM/YXs?=
 =?us-ascii?Q?gcZUE+dnQqaYi30X9jsMdZwTcf70q8ni71sDG+wV4t9x8C5sfg1MfsZM9ETr?=
 =?us-ascii?Q?a4XiGTcm6jZyYApiDX7+f2yavNMChhzmmi4Ngh9GZquixZ/73CDAocGMpA70?=
 =?us-ascii?Q?Fs2BrkG3CX5cve4z6hgJPwyLFH75MwBeP6nxosXu0q3n7WN/+6/3NCLVFGbI?=
 =?us-ascii?Q?jRVqvaLV4tPyfdSWnHmy44gyZATLuasO/WpVmS2eyhCmK+XkED2i6Q7Rtok7?=
 =?us-ascii?Q?P9svEDTfBvq8854jAjMLXW6VePdX4l0VqZSiGH/2ZzrtY0PMX6OBT+0X7iwI?=
 =?us-ascii?Q?Ckpsytf1y+c1h3vuF5gGRzbc3HhIJffisFGblYGTd2CbAY2JUlxFYKkaFy00?=
 =?us-ascii?Q?ex1bFXEnq9w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+aJ/131EzKVRQNrHvcKKi0FaawSom0RHWd+INQlDxNvcVtTQmRxWaz2Bn23S?=
 =?us-ascii?Q?fKibKHaBPhUG0/Mbuy90sD2Mizog9KuSOU+m1cs2SRiXvwYnrfw2FqkQrRXQ?=
 =?us-ascii?Q?9+FoD4+pnws9LkXTPdGMaDSbooMNGBc6TSeYIAAHtgGX+bAtTN6LNy4dTKhS?=
 =?us-ascii?Q?hdcJgjiCu179lHbooh53e9wZQIvr+5tPANL3Q5kduaimrl6o6/LgC0CeQU7S?=
 =?us-ascii?Q?8V5/cMUPe1Q5xIcEjkvrVBli9PO9b8o85R4yUWV9GkP5ZbcguUWA41FLkWFR?=
 =?us-ascii?Q?rkaxX0f6dBPyOo4k8BNtModjmmif/SiHMvb8z9oeh51o9OdWnaJZoWfq3X9V?=
 =?us-ascii?Q?7/0NTN2xvnRWDRZGQKPnBlLlUo/40y/Az4kGfx+VZZxryuFapHLNihNlRpYG?=
 =?us-ascii?Q?NlFi/EGLcxfb7mDS0ekQmSXvg33qZXybI0zFJihRGB4AyYt70rV8MU7f6RQq?=
 =?us-ascii?Q?F9m3SW7ggzs7OauJ4NmeIE5WZUJzo8B8Z6syvp6RNP0vBQBvkojsOseEUnh9?=
 =?us-ascii?Q?aibbduSasOF3UQgP9xAiWj2JqUwh3oTkNhS1f9dSStb1itRqwu9wwysnZ4a8?=
 =?us-ascii?Q?uiY80b9UJo4rMYTJETlqGKrWF1x7WGns9GyWfPc+f8oEx0qKGacUonUfMvLd?=
 =?us-ascii?Q?NBqkdGohz8qWscjEzrknmdL19Ttrvz1wQMnSZwHoB1Iy3jAfZa9whcCGlS57?=
 =?us-ascii?Q?ljIfJsqIeMNMFKtCgZgOelmLUsTO61WEZNLa9iyClihMw1Q4XOeq4YsxuJPi?=
 =?us-ascii?Q?5lpFuwGjOrrDX3uhI2JJjqnt/ZMlO/xE4e89nWaHJiefMRYlqLDVcV3onEvq?=
 =?us-ascii?Q?lkZ2BMoayTobInt3VLOURJDcRaeW8IvLcv18kU+Q49X9/VNOGC8oCKD9Glei?=
 =?us-ascii?Q?qQOCyCSN6xfUdCwt86+nJ4OVhNt84VGMAE4ZI5K0a746i799jeMinNP2zE6D?=
 =?us-ascii?Q?ofk8xcw10SFj9+ZUPKeKUaM9TfyTUF2h8N6eRW2MhYnNrQq83CCqz7DLFlrn?=
 =?us-ascii?Q?p4HGlfLWSexDCIqxr9+CC6BmPSlrkpvNeiJfyFqpREa2KseCpvE+zlFta3u9?=
 =?us-ascii?Q?Oep7vkLlsyfHfSWGON5RedR6l5g9ypciz59YiZpPN9OEngmkhzgZMqHfi/I8?=
 =?us-ascii?Q?OXPwKH3mnQlDY7pfV/ASvbadkCqRrU1icA+NDx3qRKp3eu8PYF5av/euZBGt?=
 =?us-ascii?Q?gVf/z097mUrSSUIFm2l6itxJHHxXrwaoaoQLE4IorkUMr7jbbGxgyt8OYesv?=
 =?us-ascii?Q?OXhc8Zcdo65KphJO1/dvCj7Vvtlqms/W57cK6ZvgBKEVDEzJ1eLUvkvvinit?=
 =?us-ascii?Q?lHhcQHb3x8y17XoGYgNsj7oIllpSUVqMAtVUWMgvl8GNDUYI9fmACzKAtCaI?=
 =?us-ascii?Q?BU029KySb3cCf1TEi1iYK3kpLh30CYioume5jbhQDTb7sq+vgoiMr5nHwh9s?=
 =?us-ascii?Q?myDmSUQOF/wKwu9s56NwEmF9fdRgL1HuY+hwEoab1Vqz3Z5+0LkPehW9JZii?=
 =?us-ascii?Q?V3s0R1KY9LgHWcGBkYMqCEbtj2swRN/QXAEuvIew7lT/knHCADB68QuCsrT5?=
 =?us-ascii?Q?syc9ofORQy6HxjtcdBhzWGmI5FjgvA6Zl9ff9bMI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e198cc7-bd22-4222-7c87-08dd98f52b05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 05:54:51.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp0bkNVLyMIK7hZk1XOqC+VWtH1RcSoWEVQvRqopBpRdCqeYgZ4eldT+46WsBk6/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 23 May 2025 07:17:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2708



On 5/21/25 17:18, Quentin Schulz wrote:
> Hi Michal,
>=20
> On 5/21/25 4:34 PM, Michal Simek wrote:
>>
>>
>> On 5/12/25 09:06, Quentin Schulz wrote:
>>> Hi Anand,
>>>
>>> On 5/9/25 7:45 PM, Anand Moon wrote:
>>>> Hi Quentin,
>>>>
>>>> On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de>=
 wrote:
>>>>>
>>>>> Hi Neil, Anand,
>>>>>
>>>>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
>>>>>> On 09/05/2025 09:02, Anand Moon wrote:
>>>>>>> Add conditional compilation for the usb5744_i2c_init() function bas=
ed
>>>>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/net-common.=
o
>>>>>>> =C2=A0=C2=A0=C2=A0 AR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/built-in.o
>>>>>>> =C2=A0=C2=A0=C2=A0 LDS=C2=A0=C2=A0=C2=A0=C2=A0 u-boot.lds
>>>>>>> =C2=A0=C2=A0=C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot
>>>>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
>>>>>>> `usb5744_i2c_init':
>>>>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
>>>>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
>>>>>>> reference to `i2c_get_chip'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boo=
t-
>>>>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0=
):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boo=
t-
>>>>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8=
):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boo=
t-
>>>>>>> maineline/common/usb_onboard_hub.c:104: (.text.usb5744_i2c_init+0x1=
f0):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> Segmentation fault (core dumped)
>>>>>>> make: *** [Makefile:1824: u-boot] Error 139
>>>>>>> make: *** Deleting file 'u-boot'
>>>>>>>
>>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>>> ---
>>>>>>> =C2=A0=C2=A0 common/usb_onboard_hub.c | 4 ++++
>>>>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>>>>> index 1242513c631..92e3f3a92c9 100644
>>>>>>> --- a/common/usb_onboard_hub.c
>>>>>>> +++ b/common/usb_onboard_hub.c
>>>>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*init)(struct udevice *de=
v);
>>>>>>> =C2=A0=C2=A0 };
>>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>>> =C2=A0=C2=A0 static int usb5744_i2c_init(struct udevice *dev)
>>>>>>> =C2=A0=C2=A0 {
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev=
)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>> =C2=A0=C2=A0 }
>>>>>>> +#endif
>>>>>>> =C2=A0=C2=A0 int usb_onboard_hub_reset(struct udevice *dev)
>>>>>>> =C2=A0=C2=A0 {
>>>>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_da=
ta =3D {
>>>>>>> =C2=A0=C2=A0 };
>>>>>>> =C2=A0=C2=A0 static const struct onboard_hub_data usb5744_data =3D =
{
>>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init =3D usb5744_i2c_init,
>>>>>>> +#endif
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .power_on_delay_us =3D 1000,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .reset_us =3D 5,
>>>>>>> =C2=A0=C2=A0 };
>>>>>>
>>>>>> I think you should completely disable usb5744_data in this case
>>>>>>
>>>>>
>>>>> I would recommend to go the same route as the Linux kernel which has =
a
>>>>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which add=
s
>>>>> the necessary dependencies.
>>>>>
>>>> On Linux kernel, it needs to parse the device node with i2c-bus.
>>>>
>>>
>>> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with=20
>>> dev_read_phandle_with_args with i2c-bus?
>>>
>>>>> We probably should be careful and figure out which boards are actuall=
y
>>>>> using the usb5744 and add this symbol to their defconfig so they don'=
t
>>>>> regress.
>>>>>
>>>> =C2=A0From my initial analysis configs/xilinx_zynqmp_kria_defconfig
>>>> which use CONFIG_USB_ONBOARD_HUB
>>>> I believe using DM_I2C to guard the code is the best approach.
>>>> it should be around .init() callback to guard this to work.
>>>>
>>>
>>> I disagree. The driver clearly supports the USB5744 and the driver is=
=20
>>> compiled regardless of DM_I2C support which is required (as far as I=20
>>> understood, maybe that's incorrect?) for being able to use USB5744? I d=
on't=20
>>> like hidden dependencies.
>>>
>>> Also, I believe Neil's point is we shouldn't try to probe the USB5744 i=
f=20
>>> there is no DM_I2C support, simply excluding .init() callback will prob=
ably=20
>>> just render this "support" of USB5744 non-functional?
>>
>> USB5744 can be configured differently. We are using two configurations.
>> 1. no initialization over i2c
>> (but still you can have a need to have driver for reset or power)
>=20
> Fair enough, some hubs are configured "properly" by default so don't nece=
ssarily=20
> need an interface. Such is the case for the Cypress HX3 we use on RK3399 =
Puma=20
> for example. The default is enough so we don't need the i2c interface eve=
n=20
> though it's exposed by the IC. Thanks for the reminder.
>=20
>> 2. initialization over i2c to start the hub
>>
>> And there is also one more configuration via SPI.
>>
>> It means I don't think DM_I2C should be real dependency on getting usb57=
44 to=20
>> operate.
>>
>=20
> Would diverge from how it's handled in the kernel (today) though.
>=20
> Can we please follow the same logic as in the kernel though? Meaning we s=
hould=20
> report some message if the i2c-bus property is present but DM_I2C is not=
=20
> enabled, in which case it's likely a misconfiguration of the bootloader.

Make sense.

M

