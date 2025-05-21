Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17916C54F30
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 07:17:38 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.62])
 by mx.groups.io with SMTP id smtpd.web11.1743.1747840711603263701
 for <u-boot-amlogic@groups.io>;
 Wed, 21 May 2025 08:18:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=TBaFfT7N;
 spf=pass (domain: cherry.de, ip: 40.107.20.62, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqvAVrLrepnn7kM77LZ1SI7y8DBCr8geALf4uY+gA06hFPdEzd+1U6oXqm6vr/zsGqnkpFYASUx0V+iGyNfiFvg3H8Q/tlLIaBq29IQBkca+INl6NIlTqb5ovniQ5gec5nN09RJPDZrOEUHOB/KPRbwGRz/q3V2/ehPrJETxI5r8GrZIhszw32KnI6bNEZziW3W0LgnfIMBbqDAefbs0PxaNhkB99eRqG/D86cIQUNJ3LJtrZ1F7m9U25vzQHI9QpXNtc+4cHbotmNtN2QCmItwLlio+BCs3/MB2k2mb6a264S1oPb0ROu1pfiYP69k1YXMkcI1FEMIgBF3BiiyQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfZl/j/5wUlsoreDGhhZdJkZaQ3aB3X2pFxT9pwefoU=;
 b=sUw601TBi5moqUYZPSpg+51rF7esdSRu9F/gYeBJkNx+kMUMBjFu3kAMpTuU7xj3F5pxqJNOjmtcBduy68pD1/FaGBUNwiOVkSWzwYTj9BhXJzBIAqL/MOQcQrL94QEPOpPxN1dqvAwsG+Kp6DwaQJuaf235AEwk8Hzl0iAftelPqpCwKKlGFoCCNzAvXyjO6W2wT9Q+IE6KAJ8X99f5oegWd4YLpoc7uoaPKgiV9QG0dbfvWpXAbb9bZqZm1bxPXv7jpRRhAjTDfOpqJ4ql8fdVwGM2bWPn6Fs0UTyFAL32irTgJUEiJO30I38DzCsNU/nbfKhHpJ3X8vDLnY0/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfZl/j/5wUlsoreDGhhZdJkZaQ3aB3X2pFxT9pwefoU=;
 b=TBaFfT7NsUN1iEEd6LNqShXftgslF14Ux0qwwVOtxiEe3MePDdN4Lip/up5Dzcv/hqhRFyRIJCttQ3KjuWluiGE+WrQWFq3k7a+eNlRw0L1X3vazpK93tL+xC9b2mPehwdGa+EzHDor3949hf1jeaJGZAWU2HHIEYj4LIUb6Mtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA3PR04MB11107.eurprd04.prod.outlook.com (2603:10a6:102:4b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 15:18:27 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 15:18:27 +0000
Message-ID: <62fd78fc-b82d-4876-9a52-b95b07d3e393@cherry.de>
Date: Wed, 21 May 2025 17:18:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for I2C initialization
To: Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>
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
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5c8a4460-6d11-46d0-8863-739c94682120@amd.com>
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA3PR04MB11107:EE_
X-MS-Office365-Filtering-Correlation-Id: e351189e-cde6-4d5a-1e16-08dd987abc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9/WyR56KgOXNalYAlpdKjNRnivrFIVou2atKrq2NNbJwNhFceWddkZT/JRLJ?=
 =?us-ascii?Q?rk/VYxC5cfZ5V3kxXXrE52kZ1/fnEkRiUSZ3ak0ibTkGtw1oEtteSF5QNJMi?=
 =?us-ascii?Q?WiwEz1uCbf8EeYCvlvJMKo8yI0TucYD8s5YnJ+1ZIXuTXhKl+hIpWkbmXIa5?=
 =?us-ascii?Q?xbmqMhgNiQianOj0EqmUg6eNMduu/yPy191e9lAq2mjSUluKzG6rlwidvPUq?=
 =?us-ascii?Q?NWdmeuN5640/5LCrJ3Al/9qnd8YXvX21Fu7Sy6pExKmjGU9/Y1cJblaHSADn?=
 =?us-ascii?Q?fyURt2k1r4gwVjQB3V9TzEJ9zLZ1lRLzIeQEDJYVTNQSyvwond6adPSr8hnj?=
 =?us-ascii?Q?H0YA7S3n/sJcFbWcsr4hvtONQCfTTWRZWDjXcGYGCxmIOuqD7A8jXg4khAA4?=
 =?us-ascii?Q?JfgDSUfxC3ozR2lxx23YYQ+aDYbZw4K4CdI2QXzUkH5Rww0s1iUfWAZ/fgEm?=
 =?us-ascii?Q?Nhb7DYY6tml2qwZ9lmVkF4jbohJbJTbII+/JmrgFJ5rhXIMlIYO/8aGRhvYG?=
 =?us-ascii?Q?HTIHG8/m3h36mDg1aHjlyf8CcQi2uOCjGrPOair2a+t/bFFFSSMLraXjozRD?=
 =?us-ascii?Q?yS2+KNZBgNYSbNLJSDOhmO7bYeSoK2pYACQB/Sg1gcySpVmbNwDxNPr32XOT?=
 =?us-ascii?Q?b+h5bml1vh4UIh3M5Rgqum3ATdhbu/E8g/cfPmGntEjs9hGKzSVE1+sK6xLS?=
 =?us-ascii?Q?lDM60mH+Qx0G1WpHWmkl9QvLiX/UH/LggmHpwki2BA4llvXS9s7SQSo26/Pk?=
 =?us-ascii?Q?9tys6k8EWHWDS6r38EtMpjBZlC5JBNYt3n3umcboXFi142Nt6lLXidwlzthc?=
 =?us-ascii?Q?UaHBYQM9x73U9Zgp7J1Xn5xI8mTQ0sNQssansxUE9eyw0IH/zINgiFOfBnYI?=
 =?us-ascii?Q?NizBCTdpXfLhzb/rPRi41PjG8lXuN06Ot/gwslDcOoiSIGAbt+wWbTz44UFf?=
 =?us-ascii?Q?r3CaBM5D+3+1Asfja1O4ihYpVO+19Dugy0X3J2GNesBpTayLbvQcWGmfRyHg?=
 =?us-ascii?Q?FwdCqbdv3SxIjy8PnRSYy/pv0nXYT84nxecYBcrNkK9EepCfKgn/602Bi0hw?=
 =?us-ascii?Q?zq9gpDVgSIuby9GKexa4vnFj2hy/KctEQZHKzDDj816qQ2Q/bz+kMocKa7ZR?=
 =?us-ascii?Q?++BLY9OIWsxJLbtZgNi74Ax6gzD0fx7GB/S19/Ug+Paa/+f9wIu9ddR+z5oS?=
 =?us-ascii?Q?CmD4D0f8RMiThAw7FYBHTjFp3y8pRTvPGvgnUtMeLySYEspw8ESt/ess03hv?=
 =?us-ascii?Q?XKoa5N7Mfta/abp5y/vRRTpHGsad/mqFxjz0vsVUIEj+ETlos/1mdIBnOXxp?=
 =?us-ascii?Q?drVaFJ1vC/XYRQXptRr3mE/Q/i558SR6/oNaOYlO4AO8m8KwTXjREkaN/gTm?=
 =?us-ascii?Q?SlKLHv0cy4nFHUv/zOHvw0bBNCRNqo1crMGIYkbN4kv7dqQkxLquqGgR46TT?=
 =?us-ascii?Q?CyR44FkbGKQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l3l2K2z1fFXpt8HVFLFZHQv6m2HiE0Y1bGY7EoCMw9oJ9OdfLU3cscX5cAhc?=
 =?us-ascii?Q?6h/ByufDBEH6Jj8qG4WeucENn3V5DZFvZz2be0zDhkyxc3LXa6jm260OLmlC?=
 =?us-ascii?Q?ttpJdJSpcext0sg4o1/U0ERSEM+uVg0smeetm6yvkM0wl3QDkM8YmlYVVZeM?=
 =?us-ascii?Q?t75biEEqzzAg7DKd8e9s9dy2E+/yvH6WOGJnSgJWPkykpPzT/SmB7afEDno6?=
 =?us-ascii?Q?BiYwaeHCsU1AxKVwxVE7qEQBDbfU8lgbDyr9/dZWx0E8MDABXaZp6PvEd75B?=
 =?us-ascii?Q?zY/B45NkbeFnxId+q0kIewm7cb2mKQcvPKLU5qAlemaW3StP3zgGBW3JUdDN?=
 =?us-ascii?Q?YC5vym1Oh7C3bM4YwoWedotElYHMtAnlhhBBL0IN6DseH/T9NS7q7RgqeZxl?=
 =?us-ascii?Q?cBUyp91wSyhQWx+hiDrPVnztxPD8oLpVuRcDBihCOPBtS4054OD3q01zX0o3?=
 =?us-ascii?Q?QaZY9v9IK0EwVIs/EhSSeI1tYdTGxfwuYmPPfscc4AA67CLRP+b9kn1paA3D?=
 =?us-ascii?Q?ynwuRSIZEzIOzQfYtTNszu62F8LwPg8EBTZYE/7Lj0d3WPg5u6M2wRuxYFon?=
 =?us-ascii?Q?t0oVBXgWTdh3oPloSm6H9TXT5+gYvY0hAvrt/eHDQ3KiHwTbYFs5V3iIzAMA?=
 =?us-ascii?Q?ap6EmzLphGmYcWBDtSVrQeYUmke/on2USg6q27npwpapQi3sD9Zk84LhRk2I?=
 =?us-ascii?Q?Nc5wABtGzNPnMJZNPrISumPqRX4+OjXb9WGvlnIAXxR5rBrj3IJLG09QBAHi?=
 =?us-ascii?Q?y+pv5M9Q2iaiTuC/if4iqRxPm0IYyQWS0/7S1Jmsk4R/jNg4ba2waPY8vvQr?=
 =?us-ascii?Q?SDfmLxLOwTkrzphePcScQPgzXK+gYqL/jNfVVxC/F68rxCT9RmLX0I0tAw2q?=
 =?us-ascii?Q?whz+L9+3KdtLLE9B8gXpWwse7NssZNu2sO5aHdhOZm8m1XcuQSx+fmYP1atr?=
 =?us-ascii?Q?Jy24YljATk2LtzeSH1yDVdjDpBm66nhHX36mBgngqZ0fFaAfRf2MN99OHduv?=
 =?us-ascii?Q?29mf9tfczEoBJW23qBZM6Q3KOBppaPDpofVJKfpBBN3LnFZAzs2aO4fD7eXO?=
 =?us-ascii?Q?iJtntoApjtdGkuA2BxusLUQpJI38Q7hREkIGW34CLzSkfON6g4BVeEuWzSbT?=
 =?us-ascii?Q?/Fxy3ecmz/lViXqoFCN75sUQlMaoyBa98MRx0gkJiKkEjcCRC9OrDLHsxh5t?=
 =?us-ascii?Q?iL4Ay2HjXP/YhOrVws44TcpnP7GRLiqmc8OG0/YM1IFfQS+/IxEJMBmJL8h1?=
 =?us-ascii?Q?+c6N+aSrW+XHH9wXEtWFO1B30DtcZ2IxDaHwEB/uxQklHphfV9TSCRl0H7tx?=
 =?us-ascii?Q?sRhM9wq1gXolPjnLPphM1ALqKuIenwQ7yTSORneXd/K7LZ7pv0sjovi3bV1N?=
 =?us-ascii?Q?aVDzN9BC2rnog4feNDOmj5LDj+GlAE1mx8mBxqcIe16mfMtBED7ujFf6aF9z?=
 =?us-ascii?Q?e4F/s+t5bD0pqggSdJrWluFkkDzhkzxnLx00lx9u/0QuT5nDAs86J2UTbhyx?=
 =?us-ascii?Q?PnolE+xNGLH/fSVOGkT9os8/1v/mm+1TB4Zog3skgXstofNnrFhrGMWnVuXo?=
 =?us-ascii?Q?XhpYKqvfcJC4dMgaVpZ2/Md0RemVNpRWr/HFsAqn0DRItxTzyLxE+yPX+NI6?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e351189e-cde6-4d5a-1e16-08dd987abc41
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:18:26.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdpxraETCNCaDD79KQ+PcTBVhaBXO5wRvw5b3Ps1IH9d41tXp084VUuvSeGZTD9b/O6z7flVA1+WbmfAa9zSAouI7MsZ2PM76noR++HQWTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11107
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 23 May 2025 07:17:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2707

Hi Michal,

On 5/21/25 4:34 PM, Michal Simek wrote:
>=20
>=20
> On 5/12/25 09:06, Quentin Schulz wrote:
>> Hi Anand,
>>
>> On 5/9/25 7:45 PM, Anand Moon wrote:
>>> Hi Quentin,
>>>
>>> On Fri, 9 May 2025 at 17:21, Quentin Schulz=20
>>> <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Neil, Anand,
>>>>
>>>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
>>>>> On 09/05/2025 09:02, Anand Moon wrote:
>>>>>> Add conditional compilation for the usb5744_i2c_init() function base=
d
>>>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/net-common.o
>>>>>> =C2=A0=C2=A0=C2=A0 AR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/built-in.o
>>>>>> =C2=A0=C2=A0=C2=A0 LDS=C2=A0=C2=A0=C2=A0=C2=A0 u-boot.lds
>>>>>> =C2=A0=C2=A0=C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u-boot
>>>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
>>>>>> `usb5744_i2c_init':
>>>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
>>>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
>>>>>> reference to `i2c_get_chip'
>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot=
-
>>>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0)=
:
>>>>>> undefined reference to `dm_i2c_write'
>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot=
-
>>>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8)=
:
>>>>>> undefined reference to `dm_i2c_write'
>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot=
-
>>>>>> maineline/common/usb_onboard_hub.c:104:=20
>>>>>> (.text.usb5744_i2c_init+0x1f0):
>>>>>> undefined reference to `dm_i2c_write'
>>>>>> Segmentation fault (core dumped)
>>>>>> make: *** [Makefile:1824: u-boot] Error 139
>>>>>> make: *** Deleting file 'u-boot'
>>>>>>
>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0 common/usb_onboard_hub.c | 4 ++++
>>>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>>>> index 1242513c631..92e3f3a92c9 100644
>>>>>> --- a/common/usb_onboard_hub.c
>>>>>> +++ b/common/usb_onboard_hub.c
>>>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*init)(struct udevice *dev=
);
>>>>>> =C2=A0=C2=A0 };
>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>> =C2=A0=C2=A0 static int usb5744_i2c_init(struct udevice *dev)
>>>>>> =C2=A0=C2=A0 {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>> =C2=A0=C2=A0 }
>>>>>> +#endif
>>>>>> =C2=A0=C2=A0 int usb_onboard_hub_reset(struct udevice *dev)
>>>>>> =C2=A0=C2=A0 {
>>>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data=20
>>>>>> usb2514_data =3D {
>>>>>> =C2=A0=C2=A0 };
>>>>>> =C2=A0=C2=A0 static const struct onboard_hub_data usb5744_data =3D {
>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init =3D usb5744_i2c_init,
>>>>>> +#endif
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .power_on_delay_us =3D 1000,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .reset_us =3D 5,
>>>>>> =C2=A0=C2=A0 };
>>>>>
>>>>> I think you should completely disable usb5744_data in this case
>>>>>
>>>>
>>>> I would recommend to go the same route as the Linux kernel which has a
>>>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
>>>> the necessary dependencies.
>>>>
>>> On Linux kernel, it needs to parse the device node with i2c-bus.
>>>
>>
>> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with=20
>> dev_read_phandle_with_args with i2c-bus?
>>
>>>> We probably should be careful and figure out which boards are actually
>>>> using the usb5744 and add this symbol to their defconfig so they don't
>>>> regress.
>>>>
>>> =C2=A0From my initial analysis configs/xilinx_zynqmp_kria_defconfig
>>> which use CONFIG_USB_ONBOARD_HUB
>>> I believe using DM_I2C to guard the code is the best approach.
>>> it should be around .init() callback to guard this to work.
>>>
>>
>> I disagree. The driver clearly supports the USB5744 and the driver is=20
>> compiled regardless of DM_I2C support which is required (as far as I=20
>> understood, maybe that's incorrect?) for being able to use USB5744? I=20
>> don't like hidden dependencies.
>>
>> Also, I believe Neil's point is we shouldn't try to probe the USB5744=20
>> if there is no DM_I2C support, simply excluding .init() callback will=20
>> probably just render this "support" of USB5744 non-functional?
>=20
> USB5744 can be configured differently. We are using two configurations.
> 1. no initialization over i2c
> (but still you can have a need to have driver for reset or power)

Fair enough, some hubs are configured "properly" by default so don't=20
necessarily need an interface. Such is the case for the Cypress HX3 we=20
use on RK3399 Puma for example. The default is enough so we don't need=20
the i2c interface even though it's exposed by the IC. Thanks for the=20
reminder.

> 2. initialization over i2c to start the hub
>=20
> And there is also one more configuration via SPI.
>=20
> It means I don't think DM_I2C should be real dependency on getting=20
> usb5744 to operate.
>=20

Would diverge from how it's handled in the kernel (today) though.

Can we please follow the same logic as in the kernel though? Meaning we=20
should report some message if the i2c-bus property is present but DM_I2C=20
is not enabled, in which case it's likely a misconfiguration of the=20
bootloader.

Cheers,
Quentin

