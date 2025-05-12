Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC85C3ABCB
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 14:08:05 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.44])
 by mx.groups.io with SMTP id smtpd.web11.44469.1747033612977983330
 for <u-boot-amlogic@groups.io>;
 Mon, 12 May 2025 00:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=OSgOchDF;
 spf=pass (domain: cherry.de, ip: 40.107.22.44, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDuyhSYgHFlwH+DaSnr5RtxL4lJNOqVeo9HJqVTDWkW5gVvWIVj9MmlLNEZc0mHU4eD29zoOQ6hJaDqCd64JxzRXgibjLyK5kaQnOx8RYOFdNpMGoH+h4slGWf29v604MNjcFLc0psa69QhU2kIHY5p6NaakHRVaZ04auSNRx5idye0CmIWC25Qu56KdR8kAGOffmMoqRX2t7drfDwxt9QKbPj1v4wPf6zM8WG0qSMA5aCWkEHccUKywAje3pImAICQDRBvwFfvS/MoX+0wWugVwNz6nTepqEzMwgRbCk2EsA8ZkYcwZEAAZHGUOokptjpZ55+3UaxP08tSaqDZUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2FiWFV7VuxBNoLFyFBTrcxwMyuUVxShs381px7K8UI=;
 b=Leh0knwLLxIWZ+34SgCo4hXfPogShdpIIqcqVYcKyahx5/FVic0doFbJaE3hZEPKjk4MZFmNRXxk9qxAkK97rg7ZL2QZW3WUhDAQs0wcNkl0v6Sd9agQNYgm8BVV/ul7vurDkZNH8Ofy14Ze2jNI/SOm00pLfWu895P5V282ZAftgbaHr538xXycuR4r361wq/CUR+wpDhGwHDcfAkJ7bGvHDf+WWU4OrCfdwJgkP/ek3JJpgAnmU7DZmkCn62R/l92qmT3MdgesG7elkward3ZegXuNwVJRfLT2ID6ZMcLkYb9UG/uQPs/Lj2/GtUdloiw79Hl3RO79DYdFLnBazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2FiWFV7VuxBNoLFyFBTrcxwMyuUVxShs381px7K8UI=;
 b=OSgOchDF17Z8MoH5d3XzeB+VipwoF+M42D1bxmLe4gMdNRhv3gJC0IJbwIIwgo/pMedgVKsDVrJb519oadGIe6foxmj083SAnA8kYk0qWZaCKkHJK0QP2VYYveMnp3UUs+ZTbBgKveX46hCRTA4OItqYXjwrwqxk5nzNcpPc2VI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10537.eurprd04.prod.outlook.com (2603:10a6:150:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 07:06:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 07:06:47 +0000
Message-ID: <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
Date: Mon, 12 May 2025 09:06:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for I2C initialization
To: Anand Moon <linux.amoon@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>,
 "open list:P200" <u-boot-amlogic@groups.io>,
 Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10537:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6cebb0-df1c-41d1-a3b5-08dd91238f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L2NvZU9HREczdTF5aFZRNFNHZWIwUFlRaUNmK1B3OURCaW9YcFdMY1VZYUtF?=
 =?utf-8?B?YWNBSU9yVm5tV2FVaytzYVZDb0xBS2ZoWm85UmRKUTUvTlkzeElnSHdHWXEy?=
 =?utf-8?B?eTRSaXVhZ1NOY0lpM0JIc1F6Y1Zhb1p4YWw1RnEwY1ZUc1MyaWFTWW5pbktS?=
 =?utf-8?B?c3Bmem1taHFCakxtaVVOVTlKdllhemthOHcyc0tQem0yRC9yQStSOXFyYisy?=
 =?utf-8?B?TDRKZm40bk5UdUxWb1N3MDY2RDg4UzBRNzI2b3dHVCtTYk1LZ0ROaENESnpU?=
 =?utf-8?B?Qk5IUW1CakpVek1zeno1T3NEWkFoVVZOQmtvYzVLQk1JeEJKZmt6c2pBcTRw?=
 =?utf-8?B?NGFPV1UxbWlPRFFxRjN1WVJGOVFLcVFnRTYyN2h3aUlDNStYN1lZT1NKSmJD?=
 =?utf-8?B?ZmZxdVpZTld3eXRLNWJveFVXZWVuZExSdVNPTGY1WThwVmFic2QvVGtrL3Z2?=
 =?utf-8?B?SGpXUDU1bGZIeTNJeU1ZbjJsY1BaWkduNlVKaEhWV3RRakJmejB0cFhGelo4?=
 =?utf-8?B?clFuVEhBWFhTY3R3Ym5xa0NBYk1vMURRS21BcGlNbG9tUUpXSE94SkRMaytL?=
 =?utf-8?B?Y0FSZjFVZ0tKMTgyeUNmdHJjYUtZSlpEZENoTTJoaG1ncWV1UUpUYjJlQWpK?=
 =?utf-8?B?VFovckpac0NYeHhTRGUyWm96dE9jUy9IeEcrODR4NVg4MWpUUGtHcklYUnJD?=
 =?utf-8?B?WkJUQXREOThzakJ0TUhyMVYwa2VsejJTQU1ZYWhEaWJvdThYbytRYWdVSmZZ?=
 =?utf-8?B?SUtRc3U5WTlrQTJEOU5waGREWGQ1N3M0bytnUFJZejF2amhaWnlKTWg5WkdW?=
 =?utf-8?B?ZFVESkhOMGZDVGdPcFRTRDJoLzkvb3ZVVTgwa0FTL2tTOE1qV2pGV3RHLzJk?=
 =?utf-8?B?aTB2UytvcW5IVm1FeFB4Vms0bFNmY0FOak1LUiswaFJWTnFOZTNuTklkR0Mw?=
 =?utf-8?B?dGw1bnEzUS8zcktPVnBEODdkQ0Rla2VvYjdJREV4bEx2S2lLcHZMMjlOTDdI?=
 =?utf-8?B?dk5La1VxejIwbjB2QkI0MFQ4US94Y2lPRFIwcTh2c1FmZHFENWR6eGlFQ0U1?=
 =?utf-8?B?R3V4QmtVZFN4TFJZK2tjUnV2UjdoMDVueWpDWVlPVVRoZzRaNW1GdnVEYlVY?=
 =?utf-8?B?R1RtajVCODJKWkV0WnBLYlVSZnQ5dWhXazRleitpOVpxb0FWWjhiMEE5U2ps?=
 =?utf-8?B?bVc4cUtKTDk2Nk5GY09jNXNrSkpYa3FGOVVEdkZ6SjFxT1pYd2RvUldaNmZH?=
 =?utf-8?B?YjF3cml3ZWdRZlZuMjFqZEhYREYyRG1EWm92SE9Idy93UFRla2dmT1d3VDJD?=
 =?utf-8?B?ZUwwR200b1lVczVGaWtJc0JWYTgvMGN6SU5IRHM5Y3FJYnlPekRXWFVlenFU?=
 =?utf-8?B?Q0hFVHBzVzAxdXZFVDltOW9XM0UyTE03UXBsSDNGakZYR3NWaWh1cEN6aVNW?=
 =?utf-8?B?VkxEeFlMVWEzNEZSWHpiRVZmQnFmRmgweEpkbWQvT0JJbUVQL1hGMzRMTTR5?=
 =?utf-8?B?KzBQdGRLb1VzRDQ4Y1dwL2R0VjQ3QlNBbTgzWmpldURzVVpzYWZTNGJER0Ju?=
 =?utf-8?B?WGwwTGl1dWtCWkhZQVBQdTNPS1NhQUNkNVZqNEtXcTAzSjdJOFNTbHc2MUtu?=
 =?utf-8?B?VUIzMmZPWHpsTHJqTXN2d2pYS0MybW04OEZFSUtlN3hVWkJRRGZ2M2tuaVht?=
 =?utf-8?B?NGo2UHl6aU5HazR3cmpzVEptSk9ZYTVtQWJUMjB6Y1lGaGFnQTg5cnZ5SmdK?=
 =?utf-8?B?bUJ3K29IWWFWdGs3NUhRY1lyQTBCRHowWENSNVVoT1pFay9iRHpFa1lyaW9T?=
 =?utf-8?B?WVVLbEhxYXhxUWlkaWVFOTRiVmsxOUYrTHRLQ1pSOVlmZlVCbkxKTmVGOGho?=
 =?utf-8?B?eEc0UlFmMTgwdVBQZlRJOU9yQ0d4Q0xBMENrV0RpMW1ra0FZZGk0SzNEell5?=
 =?utf-8?Q?m5iAbuOjyRw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bWhnemF6UU53VmNaT2Exci8zYTQ0Z2dZeFhLc3V1a3p1RGlZOVJtcFlwMzYz?=
 =?utf-8?B?KzRwVmpFaEEyWnBYRy83VGs2UnJINUVFKzFlZWZRV0xRKzZRWDB5NWFDcVFI?=
 =?utf-8?B?Q25JUzJWM3lUaFhjdHYwWjlrZ2VLRmNaUkNkTkJsOUNOYW5FdDFQOHM4UWJV?=
 =?utf-8?B?MEV3cUY5YlVockdxZS95THBPNnRaTzEzaEF4anV5QjRic1lBc2xFRFhUVTVy?=
 =?utf-8?B?eXdVcVpCaUx0NHprWlVCY1JXbUhiRWJqVnhDVjNmTXVTUW8zb0hLYnNULzM4?=
 =?utf-8?B?MTJyNDU4cW9KS2xIeVB2ZnZWNUZTcWJDTHNpNWFjNVFXQ21LZVJhcUVneGox?=
 =?utf-8?B?YVBXYnIxbWRaS0I5R0RmOENVRkdJRTY2ZXlnVzZjZjdoZjBwTlo1NXF4UHk0?=
 =?utf-8?B?alM4ZURpNE0xMlhpRmE1MmpHNHhmek5wYmduNzZkTmwzWUFxWDRZZG5zaUd4?=
 =?utf-8?B?YktxVCswYUlJLy9WSFJxQzArSmIzaTNSazJzYXlPUW9xRm1mbUhQUlVsbVc4?=
 =?utf-8?B?RklzSkpoSUx1YVEwbmZiR2tia0xvVFE3QXNoQkxlS3g3ZERqSkwxWjdXRm5T?=
 =?utf-8?B?VWoxTlVlSUk5SlZqcHAzdVBCMUFjUUQwOHJ0dGVsUkNWdU9UZ1ZoMFJzdW1J?=
 =?utf-8?B?NVdHcEo2Q1hyZU9aUS9DTjFibWVCa2JDaGhqdkpHMzExbTRCSUpQanlqQ0Ns?=
 =?utf-8?B?S1h6a3pZbVFZLzlqWDR5MVJLQkE4cStGczFKTDVPS3NobGt0ZHA5V0xzemkw?=
 =?utf-8?B?TUNPd2tqeW8vY0Q1ZGtsbHdlWVZ0bjZjWkhkY0pHemRHcHhtZVlFV0pHWWd0?=
 =?utf-8?B?OFducnlINFQ2U0RYWEpDa3NFZlNSZEg2UmNVOFZGblQwQkEzVlJUS3dvc2hF?=
 =?utf-8?B?NytlQ054ek9tNGNsUFNyTFVFcllPeURtcnRiVTZTRFVWZXgwTmZ5aEdldHYw?=
 =?utf-8?B?RkJTc2hDRmpFbnc2NmlpTWxBUy9GN0VLMTl5YXcvK21OdmhOeitKaGd4Tkxw?=
 =?utf-8?B?aHhmSzlPNFJUdXl3MjNQNUpsdzZDSFg2R1JRWFVQd2s0N0xlYlhLSXRJQk5F?=
 =?utf-8?B?K2tWUHV6TnMzQ0pocXZDdURPeGdYM0tBc0VlMEtzZUl6QVlSZjBtRlJqbHUr?=
 =?utf-8?B?djlpSkVCZVg4TU4vSmw1SkZGQXlUYTRPME85KzhEai9oY25BcnNhZzVFN2lw?=
 =?utf-8?B?bzdHYUllaWRFV0hSYlp4Sy9XbzJGMDRvbFFjRU5iV2g3d3YxbW83dzVRY2tl?=
 =?utf-8?B?NmZnUFgvb1lpTEIwU3JncjBaOXpVOGtwREt5UGx0VTIwdlVxb0hWTDRnc3BB?=
 =?utf-8?B?NGM4V2NHYjBMcWRtNWNsYUxKRWNXOFNmYUNuVFJieUtoTUQra3VCNFlUL0xF?=
 =?utf-8?B?Nm9mT2V1b3hjWkNxTFU4L29jTGd0YjVMc1poLytJWlhWcmsrdVdpLytDMkoy?=
 =?utf-8?B?YmEvMmJxNjQrNnZhdVJ6RWlhd1pSS2JncXV6UkJaSGRvcVFPblZTVzg5czU0?=
 =?utf-8?B?TUtoV2p5RHRyUDZIejdKcXllcFA4anB3a1E3clJTaDlORW9XV1N3VDRIQmVi?=
 =?utf-8?B?ZEgwZ2k4QzlwWUw3RmNFTzdMd0NxYmdXOEZwdFFSNHhXaFdmNGxQOUZHRFN1?=
 =?utf-8?B?cXZpeXVpSDB6QW5QVWhYcVVVcm94aHJHQWhDd2tRKy9xaklnT0RwbDFCV2M3?=
 =?utf-8?B?ck5BZ0UwYy8ySm9wT3hlbjFzeVRXR2gyZlI0eHBxWnp2Q0QrcVpCZlFLYUtv?=
 =?utf-8?B?VEpHUHU2Vk9oOEZUejlDN3NUUmozdG43SmgwMnkwZGdHL2lBNXUxY3dvMSt1?=
 =?utf-8?B?a3BKZHpkZklDUVZpWG4wZzVlbUZoNW0wWkIwVE5qQ0NaVWM1MXZza0xEeVVC?=
 =?utf-8?B?YkV4MThkSHNMejY5RTJuK2Y2c3ZYTEQvTXNxaEJ6VzRPcWVlYzFkWkx1Tnc3?=
 =?utf-8?B?anA2S2ZZb0xSSHBIeTY3ZDZyVnZzTE9LYXFzQWNtZWcwWlcxYk9QNWZMQTg4?=
 =?utf-8?B?NGdSa2hiWlpjSnBmYnptNkR0V2lQdjF1am9rMWNKSWgxb3NxaFZSSnUrWmlY?=
 =?utf-8?B?T3RQL3NTb09MZ0cvQ3BCdFNBNUVIS25yNVpzMVh0RUtRdVQvb1lPWVZuTVNW?=
 =?utf-8?B?eVJJN2ZBNjJEVlEzajZpN0lib3hHWnl5aWpVWXQwbHUybDFUWjhJUERtR3BQ?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6cebb0-df1c-41d1-a3b5-08dd91238f8e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 07:06:47.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0gNseiiJwNrjJ4d08NhftA6tS9Fm0g3n9pEdCWAw/c4MTvE9KbMbOd5ZU1tAnV16gH1jpvZa8/le1Wj/o7ToZE06j0veOfVqOIkHb7wtWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10537
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 May 2025 14:08:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2702

Hi Anand,

On 5/9/25 7:45 PM, Anand Moon wrote:
> Hi Quentin,
> 
> On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Neil, Anand,
>>
>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
>>> On 09/05/2025 09:02, Anand Moon wrote:
>>>> Add conditional compilation for the usb5744_i2c_init() function based
>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>>>
>>>>     CC      net/net-common.o
>>>>     AR      net/built-in.o
>>>>     LDS     u-boot.lds
>>>>     LD      u-boot
>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
>>>> `usb5744_i2c_init':
>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
>>>> reference to `i2c_get_chip'
>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
>>>> undefined reference to `dm_i2c_write'
>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
>>>> undefined reference to `dm_i2c_write'
>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
>>>> undefined reference to `dm_i2c_write'
>>>> Segmentation fault (core dumped)
>>>> make: *** [Makefile:1824: u-boot] Error 139
>>>> make: *** Deleting file 'u-boot'
>>>>
>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>> ---
>>>>    common/usb_onboard_hub.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>> index 1242513c631..92e3f3a92c9 100644
>>>> --- a/common/usb_onboard_hub.c
>>>> +++ b/common/usb_onboard_hub.c
>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>>>        int (*init)(struct udevice *dev);
>>>>    };
>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>    static int usb5744_i2c_init(struct udevice *dev)
>>>>    {
>>>>        /*
>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>>>>        return 0;
>>>>    }
>>>> +#endif
>>>>    int usb_onboard_hub_reset(struct udevice *dev)
>>>>    {
>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
>>>>    };
>>>>    static const struct onboard_hub_data usb5744_data = {
>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>        .init = usb5744_i2c_init,
>>>> +#endif
>>>>        .power_on_delay_us = 1000,
>>>>        .reset_us = 5,
>>>>    };
>>>
>>> I think you should completely disable usb5744_data in this case
>>>
>>
>> I would recommend to go the same route as the Linux kernel which has a
>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
>> the necessary dependencies.
>>
> On Linux kernel, it needs to parse the device node with i2c-bus.
> 

Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with 
dev_read_phandle_with_args with i2c-bus?

>> We probably should be careful and figure out which boards are actually
>> using the usb5744 and add this symbol to their defconfig so they don't
>> regress.
>>
>  From my initial analysis configs/xilinx_zynqmp_kria_defconfig
> which use CONFIG_USB_ONBOARD_HUB
> I believe using DM_I2C to guard the code is the best approach.
> it should be around .init() callback to guard this to work.
> 

I disagree. The driver clearly supports the USB5744 and the driver is 
compiled regardless of DM_I2C support which is required (as far as I 
understood, maybe that's incorrect?) for being able to use USB5744? I 
don't like hidden dependencies.

Also, I believe Neil's point is we shouldn't try to probe the USB5744 if 
there is no DM_I2C support, simply excluding .init() callback will 
probably just render this "support" of USB5744 non-functional?

Cheers,
Quentin

>> Cheers,
>> Quentin
> Thanks
> -Anand


