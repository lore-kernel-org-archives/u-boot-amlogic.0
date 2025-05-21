Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0AC54ED0
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 07:17:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.47])
 by mx.groups.io with SMTP id smtpd.web11.357.1747838085746168877
 for <u-boot-amlogic@groups.io>;
 Wed, 21 May 2025 07:34:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=pw7sTH98;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.92.47, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+4+m3VjJUdZSIs77Tl/uF6og50AyTuIlVb/OoSfYVTMs3jbTUX4h1Rt0gV20BxowuYRPKPATbAOlDoGw6B2uBpAtyBLMPNkLxGjrDC0H+y6tQDO6KKY51ArOFINb6iZiyUjaXNoctj34+P5pIA6VQ7Ku43eBMHVOkJth5YUaXVBHmIuVB/HG+pC4PruyN7Xs8oKFpHA/9GoV4p2DPggxyG4Fs6eLZjR+z5NHgdbZOLYXDeMPMnGFEduCHATMSUcUJpih8zsywha3avIaCoUddKeVJgoNWNH/ndDEIfoXswnVpX3pE3+1tqtYlpaPb5qWpJHbA6/faRHB4Paw9497A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCmT4RSKvWV0D6QwHMuWmxKQtJ0QIXEu1Qa6XmrEAI0=;
 b=ndgc5geM806z1h7bnpGf4XIoQSHwbG83fLZcQdY8UKUew/jUCEJkiKNTKm/ogKVXUCYbuKwGhXe3ORthQuKntFB7hD/NxSnvsQ+4fhp0ej+5HdHbZM6t3AjtWvXbiIhXl84R6PuzzodAJndREOBM4hdH1UwAzSsCa04EYfJbeJ8D7eJBADPqvnsW2BRVLPXKSZna5iSouIPzml+RmSvnnFEELdizgUzfl5R3y8UP8GUoT0u0lJJGuThGqUjCIuoNcfYPud6hu6c8DdkU3+HH3IyN6HGW5e5YRl57uiijekW5QKVBX7gz45omxTILIJzd3z5pycEEB1z8fwv4K0tMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCmT4RSKvWV0D6QwHMuWmxKQtJ0QIXEu1Qa6XmrEAI0=;
 b=pw7sTH98t0x2ApHkrBQQr5C3t14pgr2s/MuwaRXerYd+lmLxtEXuRX6oqppcMW52iJKfGWQ9fG8b9C7k08+HrYnXm5X6bSeiiqnZoehiIrSq45whiN+pf8cDC891L0Zz9ZH3tF8bWnADmlD7xBOIlTTVLrY1yzxWNuZ3xikntGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 21 May
 2025 14:34:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 14:34:40 +0000
Message-ID: <5c8a4460-6d11-46d0-8863-739c94682120@amd.com>
Date: Wed, 21 May 2025 16:34:26 +0200
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
X-ClientProxiedBy: VI1PR09CA0093.eurprd09.prod.outlook.com
 (2603:10a6:803:78::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: fced3426-efe7-4abe-f0dc-08dd98749e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PI1djnRSS/NMKhJUGLR5PvXwNYWkvhOxuiUiWmy7SPiSgYCFdAtIU5CZ5kkv?=
 =?us-ascii?Q?obRCHaFFhXBGvLYWFUr77Xkj8aE5TtEV07M6+I+QVFnGq3Oa3/j/WTgohV+C?=
 =?us-ascii?Q?+lzxKgAa1Dz5nftPpKwBQtmvrqisCo9PT4rrEQVbMygOdCBZsRqm1Rt8Y2wI?=
 =?us-ascii?Q?818Mul23NfJadeJ8mIsybEC9E1bOjq8T0CeAoOy7NdxBbECaeG1p8ZV9gYZV?=
 =?us-ascii?Q?apzJlZZ+ayfgAIhv85EVOgaf2DPilFeDxyxKHNqAeXEmMT2iii8n0KfnaRUY?=
 =?us-ascii?Q?D8Jlnri7SISND21f+bx+eHJ4X3p/bEUGrZ5BqKpfwjBHYXK0m62SOxHX3AvZ?=
 =?us-ascii?Q?2xwq0TG099VDrreZ1XICQtaboYv/5wL72kaIZuFxgPEh7VxNgH92Hsz11o43?=
 =?us-ascii?Q?pjwVE5wCyXbuPHsog6fMMgP5r4Ke5xtgDwC2zsd9HxAlRlB5sMrSycHuQAJ0?=
 =?us-ascii?Q?bmK05b7lCNrzVMsCUBy60QDN+zkfDJy9/drVC0oS5xcQIYNe4NyQRY1lG0Zx?=
 =?us-ascii?Q?R00poAwxS4YGr/1R5Ne3U3ubst1UdfJl9RTVAhUoQqD5rDGMQwsUXRYZkiCl?=
 =?us-ascii?Q?MOTVm2PFHOi2IcRFGUGLSS6sCKz0k5ghLljNTu5aD5sQRIhwR7TcPzCuHDba?=
 =?us-ascii?Q?vx9f6lf4y5KZB584e2ylUHZJxnEwiWAkYJteFsV7k9jQWOutiJrYvx2qp8xP?=
 =?us-ascii?Q?PCVOsccBm6dfEGYHoHlg66YrFLTVpyc5yVdjIY9nc/D2W05P9B/y/lST6L6M?=
 =?us-ascii?Q?Kfn0DVZp/0wsUb3Itd0yMRQVt+a5xwto41lyREQGKc/YTRt8S9q+WsFtCzYA?=
 =?us-ascii?Q?MgPRcqmIr8cCi1dues+GlroAvd+pel54jVwAw2u+uon2QusRyAeJgglj2Axf?=
 =?us-ascii?Q?92zM6WsVZ7hFV8mhAeclJb5LtL2J4gIm8oNwtO/0CPRUoXJYhLvUX1zCeY2/?=
 =?us-ascii?Q?fcw8cJLdM+IBBxstr4Oj1A+INHhuTxe/R4qVBjk7LDuImE9L4RIpUO9Yb23w?=
 =?us-ascii?Q?ohzjsPfOOfABt+Ugbzb08oxciJvuw53Rvv9hN2B7mcQ1nrVo8OU/XKOZ+0TE?=
 =?us-ascii?Q?21MoRdMXzNWxoMMtyNebAKJC6EHs1TekiQLL9xLHUuEO3PRpdSWG5ywh/XXS?=
 =?us-ascii?Q?T/xnt9AZubwfooSOhW9P8gQIO2I1jJlQSPYjydy2ArnWsS7isiOe4i7IMg1E?=
 =?us-ascii?Q?YgbNb/KmtLRQ/zw6WHKvB2MrCRkNx2OQC9Kh9fHxsLBgoocPsZ/R9/2WX1pQ?=
 =?us-ascii?Q?thONlL5qHCh+juRupeDCGoUvQzj4ZUbloqZUaOpg8Dv0YObWeA9QLVxBjvf0?=
 =?us-ascii?Q?AKwW5U2/nS71Pxz48vgcUxWLcb8KEwNuh3Y8io9MTuypzhWT2/eCyBNNAbw4?=
 =?us-ascii?Q?L4MlJslFLrR1Tia8rsgVojqg6ysKSNNER2C7l/0n0OMQw8kEPLjoCBAfu6cj?=
 =?us-ascii?Q?HZPi5dd+0qw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CJh5uilLg4d6GAGvtVvgv5xOa5GojNO9DaXjgZ/Qlh4MiCDebEmGQe/mfcti?=
 =?us-ascii?Q?36kQ4t4DaOqM/brWlN2wb0eB27RPAqQUftfn0GRglJ9OpSJkxNHJczaEfWr6?=
 =?us-ascii?Q?MLQUPeQXWM74F35s4OB9QHYmjOyaivUskVqMnlb4ydKQLMgwuctD6OaGlSVl?=
 =?us-ascii?Q?LsoyKuAYvDfhXwR80FAhc/ghFsBi0VTZ2dwvyZ8NYau7G8fl8aVFEjR/MtTK?=
 =?us-ascii?Q?64kFJZuKCMW8KmQjxCDJLO55UP3xqnL2rjvxN7nYh29gkirdVHH0rQ8QEABG?=
 =?us-ascii?Q?AHIcBGJBQk1J+cEODiTM9VH4eyKusAKA34bPU6i8/SCLfuseaSyGmAOSSajB?=
 =?us-ascii?Q?SJXV7jYBlJkIitfCy6NwmSEKZadySVIntHJu5HMRyWzNsOAIGzqBzDUzzAvK?=
 =?us-ascii?Q?VOntM2p+UuQZfN/pGzGH78oYlX/CewK7P+RhzjNUqW3cl7J5n4I8/JpOOhs5?=
 =?us-ascii?Q?UiUQRNvKHhEvYNmh7MvhFnJ2mqja6xF67E59YpY4jgCrp5mm1NWq6k4CpVuh?=
 =?us-ascii?Q?LPu1hZpzCCrAcsKnKUCLhlkouOQGVmm/aSC/kVcg/hWk7xHjD2vKcJBiTQOM?=
 =?us-ascii?Q?E261lZBQu2ndYvy4nA9bCkEmXTET5w8EinWNOnMquK7jD/dwPUILs0VKjSXw?=
 =?us-ascii?Q?cWyhi6x2G5JNoXP15yJIM6rUdmFGj/T9NtQUSizxGVVOE/EaCDLi00EhpVCW?=
 =?us-ascii?Q?GaVCxmgEWlgTlFI2BhnUFiq+Af9+6CMPN6kAAXXM3Pe/hnDph7mK8mKBJtQz?=
 =?us-ascii?Q?AcTjORGwI+Y26L39IYVmRlyCeuZsFrSZvxk2FUKkAXrH2HoNFoIN0Z+74B+5?=
 =?us-ascii?Q?A0jyn7EOHJZ7JY5JQR7rSeG9DCz4CUSceE3vdtDhuwUDTF7FCfRpvkwpsnPo?=
 =?us-ascii?Q?/teT9kJYmuMYicKDGwPsdJhPFB5jF1XPxT5qW+LYApg0WqJeYYDvRUznvjQA?=
 =?us-ascii?Q?wCv95xxyCbOZTx5JQ1dQFyBepfJRm085zjHaaVbMUZmg4mL4px9FaYWI4e2I?=
 =?us-ascii?Q?BqxkLsQn34Dt3wwn/zc8lbjLnoVflOOIR/XRlJjKbwLepG1CitwFGqZSMSj0?=
 =?us-ascii?Q?hX7mlwRXNBta2EnPtM+AnzpCKc5glxy4qyzn+vxKPxnMXV0EnqP7zMT3m7af?=
 =?us-ascii?Q?EfMvMGNx8QNbgSSXXZtsuaSjAlw7g+/V6X8DWJ7eiU0/vTZ8ZzflHuUGeCGk?=
 =?us-ascii?Q?Eu4lJhxaLNZrQMzI1J11Jubg63Tywq839jlzglZnw3/v1cE2gN4RgW8LPCA3?=
 =?us-ascii?Q?fVxGc7dbOOcqwSxF4dZkwEmLaFBd933dTJUIXAuUr/FOJT11bhTTdLXxCVUq?=
 =?us-ascii?Q?B019omPZSw/P5Q1UzRkBsRBDGE0Csu/4yuY//y+VU4eFan0o2CQHuLd9uA29?=
 =?us-ascii?Q?BM+DlwJyMCs7RMgnCQzXGq5phI2teobtKNERg541DwzD6Qk7yi0miZzCI/Uq?=
 =?us-ascii?Q?Mum3Xx82QPTFLNYGmtzjMu8DG6SC6tjb7yhhpODr9YmU6aQTd5paGaYRYIbi?=
 =?us-ascii?Q?9b4uS+HYmG2I/v6yzZc9gkDmyylwWuugra0Ow8mvudSKW6qgGvMBerpXsxlX?=
 =?us-ascii?Q?0LW7JkEvSF8j+zfgt7j8rXXkcb0IDh/zGLih5YEr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fced3426-efe7-4abe-f0dc-08dd98749e5d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:34:40.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YmfoWeoU6Rf4IyzFR8/TIWYUDfkTqHBE7ukRDtKl62ggOE2gyRzocshSctB+jTp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 23 May 2025 07:17:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2706



On 5/12/25 09:06, Quentin Schulz wrote:
> Hi Anand,
>=20
> On 5/9/25 7:45 PM, Anand Moon wrote:
>> Hi Quentin,
>>
>> On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> w=
rote:
>>>
>>> Hi Neil, Anand,
>>>
>>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
>>>> On 09/05/2025 09:02, Anand Moon wrote:
>>>>> Add conditional compilation for the usb5744_i2c_init() function based
>>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/net-common.o
>>>>> =C2=A0=C2=A0=C2=A0 AR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/built-in.o
>>>>> =C2=A0=C2=A0=C2=A0 LDS=C2=A0=C2=A0=C2=A0=C2=A0 u-boot.lds
>>>>> =C2=A0=C2=A0=C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot
>>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
>>>>> `usb5744_i2c_init':
>>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
>>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
>>>>> reference to `i2c_get_chip'
>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
>>>>> undefined reference to `dm_i2c_write'
>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
>>>>> undefined reference to `dm_i2c_write'
>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0)=
:
>>>>> undefined reference to `dm_i2c_write'
>>>>> Segmentation fault (core dumped)
>>>>> make: *** [Makefile:1824: u-boot] Error 139
>>>>> make: *** Deleting file 'u-boot'
>>>>>
>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 common/usb_onboard_hub.c | 4 ++++
>>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>>> index 1242513c631..92e3f3a92c9 100644
>>>>> --- a/common/usb_onboard_hub.c
>>>>> +++ b/common/usb_onboard_hub.c
>>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*init)(struct udevice *dev)=
;
>>>>> =C2=A0=C2=A0 };
>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>> =C2=A0=C2=A0 static int usb5744_i2c_init(struct udevice *dev)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0=C2=A0 }
>>>>> +#endif
>>>>> =C2=A0=C2=A0 int usb_onboard_hub_reset(struct udevice *dev)
>>>>> =C2=A0=C2=A0 {
>>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data=
 =3D {
>>>>> =C2=A0=C2=A0 };
>>>>> =C2=A0=C2=A0 static const struct onboard_hub_data usb5744_data =3D {
>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init =3D usb5744_i2c_init,
>>>>> +#endif
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .power_on_delay_us =3D 1000,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .reset_us =3D 5,
>>>>> =C2=A0=C2=A0 };
>>>>
>>>> I think you should completely disable usb5744_data in this case
>>>>
>>>
>>> I would recommend to go the same route as the Linux kernel which has a
>>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
>>> the necessary dependencies.
>>>
>> On Linux kernel, it needs to parse the device node with i2c-bus.
>>
>=20
> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with=20
> dev_read_phandle_with_args with i2c-bus?
>=20
>>> We probably should be careful and figure out which boards are actually
>>> using the usb5744 and add this symbol to their defconfig so they don't
>>> regress.
>>>
>> =C2=A0From my initial analysis configs/xilinx_zynqmp_kria_defconfig
>> which use CONFIG_USB_ONBOARD_HUB
>> I believe using DM_I2C to guard the code is the best approach.
>> it should be around .init() callback to guard this to work.
>>
>=20
> I disagree. The driver clearly supports the USB5744 and the driver is com=
piled=20
> regardless of DM_I2C support which is required (as far as I understood, m=
aybe=20
> that's incorrect?) for being able to use USB5744? I don't like hidden dep=
endencies.
>=20
> Also, I believe Neil's point is we shouldn't try to probe the USB5744 if =
there=20
> is no DM_I2C support, simply excluding .init() callback will probably jus=
t=20
> render this "support" of USB5744 non-functional?

USB5744 can be configured differently. We are using two configurations.
1. no initialization over i2c
(but still you can have a need to have driver for reset or power)
2. initialization over i2c to start the hub

And there is also one more configuration via SPI.

It means I don't think DM_I2C should be real dependency on getting usb5744 =
to=20
operate.

Thanks,
Michal




