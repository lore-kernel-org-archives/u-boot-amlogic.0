Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA08C3ABDD
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 14:32:43 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web11.80950.1747153328679967215
 for <u-boot-amlogic@groups.io>;
 Tue, 13 May 2025 09:22:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=MYFMPNyn;
 spf=pass (domain: cherry.de, ip: 40.107.20.69, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krWG8lRjh7ojTo1V4sdeWW3nSTYngqE4zWE5kv0NqUTjoXqsHzmB28/8REXzmK1LlYgAeEIUtgCoq5PtXUSiguXgL2+g2gw2DZJw2oTp/dC6xc2x2l3R1pKAcBUeQG++zk/RP33hPhFuqVvFwO+7rDdhB0045O9t7zvuj9NnAgAL5uOWiGJM04rqus+Eact5hTUY0dq3FQnv2KiS74OnD7h9P8RUfjn9dLK1G1VoS5LF2DFCzdPyqfXfkxoTqC5ruC6giFgBwzA0zHeJ5PpY2hsHs1evYHa//pDBPLJR0oDoETe9Snk5cG8PoHT1AvAt343WK1QK/m6OOOzk/mK2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyKjUypVGp+2VUKm4l6qgN0vNRVn+qRjnyEyWxA5NTA=;
 b=al0OmxHyUiRQmPUpO2uE//V9luR+gCU8tSymEJQyVIsWoyVnV1zVgtSQS8sJLaceL3ij1TW3qeWhkK1sQvUdz16AeAlZiviVhbMWoMU4cjF8I1BkKEtGBsMWowGSF/wABsAnTuUtaX3F284HHtAcaU8ftkR3fKtizIYn+F516n/CMp2RCtjPmstXar43SnJI0heJM1Puh31Lxo3wWPYtiv2VksVsz/vYvq+G60/J/jRBNNIyhOCAHS+ubGAVO+m/9RZp9Zdx02/sQQvlLGgI861eWFc3sv8OwW9VjlpjPCEopoLqKwrPu9f++7FiQNj/bcEsaYYs8baphbig7sITEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyKjUypVGp+2VUKm4l6qgN0vNRVn+qRjnyEyWxA5NTA=;
 b=MYFMPNynjRdw/cEMwa/Nv1XmV0v8iZCSgu0FR9WvMOMNHu6L90rnUZBdAng1bzs2k83L4KXlX4+2lVnTOOmFaMaqlID2eeHY8X9nHUSj1zzlo6AAHUlnrSqHqK4dwaq67/7UH3fgVZ7ZFXJ7WQ+ch82w1iEHl9TSx6qwLOuhK4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6994.eurprd04.prod.outlook.com (2603:10a6:208:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 16:22:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 16:22:05 +0000
Message-ID: <03e20ce1-6e37-4141-b5d6-2f87254a69a1@cherry.de>
Date: Tue, 13 May 2025 18:22:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for I2C initialization
To: Anand Moon <linux.amoon@gmail.com>, u-boot-amlogic@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>,
 Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
 <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
 <183EB9E9446C2114.11104@groups.io>
 <CANAwSgRxLqj+dGH4jDMZFDkAJXe=V7fmKGdEdPU=+cR5NKyg3A@mail.gmail.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANAwSgRxLqj+dGH4jDMZFDkAJXe=V7fmKGdEdPU=+cR5NKyg3A@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fa6093-3992-4cb1-3abf-08dd923a4ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S1M0V0p4OXF6Y0J6cnZSekoxNUhIM1RoUzR2aVpRQ3d5eHBQU0dUdExwUWlE?=
 =?utf-8?B?dlVGUkNvS29NRTZOU2xicitHRFRPUEpPa2pQQThlUXZCVlUrQllOMkdjQUpR?=
 =?utf-8?B?OWdjeXFKMk1Iak04NkJDS0xKQmFjQ1JFcGxnUStmUEVmdUZxazJqMXR2bzJs?=
 =?utf-8?B?KzRQTTB4d2txdFNqSE9YRVNSMEJMU0hNYjFENmhPT2lzZmFxRVdjTFJBTkpx?=
 =?utf-8?B?T1lSQVpReDQ3SExXWm9sZmNCeDFFT1pqaVZuOEQ0V253YVpmajZsSmZnQUwy?=
 =?utf-8?B?MmxaOVZHR3BCTncrMXNHRUNDaU5KU2xSVzR5ZkVCSHpKVGJETVVLcmdHNlBu?=
 =?utf-8?B?bTVsS255VUZtUXl0TmlFQVRDSkR1ekJUalpRUTE3REE4dngyODQxR0hFVTBP?=
 =?utf-8?B?aVJ3ckFuVEtXOG1URnNyaWV3eUtkaWw5UUJYdmlzTU82ZnRmVzhmVTB0MTRE?=
 =?utf-8?B?RUdxZ2lCOG9pako5eDNVc3lqS2dtRXZUQmgzSGpwcGhJc3FRaWRYVFQrMjNF?=
 =?utf-8?B?ZGVQTFhWRjJwRG1EWEhaeUlJT2lmRmNFWStDZkIwb0VDVnVEaFpWZ0hnRzM3?=
 =?utf-8?B?RFVaV2pEL2lyVm9uV0MwU0hIN3FzR0dCUk4zRE5oTS9sRW9Vc0MxWjBqR0Vk?=
 =?utf-8?B?ZVVDcnoxYy9VRmtYWXcySGNyNDAwTFEwMEpxR1JNZUtQMlpJV1p2bWszenN0?=
 =?utf-8?B?OERQMzFXQXJoS3NEOFZBbHFZWWhYL2Zma2FaQ25iSmN2U0R6aW96T3dxVzlj?=
 =?utf-8?B?d0hwaE5FQTZLNUhOckxGVDIyR0NmVUhYcUxUdFd1cllTVHJ3QjVKa3lEb200?=
 =?utf-8?B?NzNNYnA4aUcyNWYvVThCWU1FdHk4QVRvdFNaczFxdUpIQnV2VGhsLzFhbC9p?=
 =?utf-8?B?b2lJVHNoeXB2YmxJNlFBbVRnOHNvQ21vSmdKTVVCOGJqMWpnc3MyTFc2eUNt?=
 =?utf-8?B?bTVBbDBZZTFlVmFLQ2lWUlhVYkRaMU9ralF2ckxHTEIrV3hRdGxIdjQ4K0dK?=
 =?utf-8?B?QjJHU3pHZHRxdStVSXpoQ2R2bXRDdFNUejBHQXlocHJGMElXZ2tQUVRBcE9K?=
 =?utf-8?B?UUxNbzBjaDBFNVA1cXE5RU9GK25mcW1uaG9DeHhndEJrbjZSb1JGNHRpTEhZ?=
 =?utf-8?B?VHkxcUMxRXRpK2ZuRG52akN0aXZUREtzRWh3d1YvVnBiVHlORVczWE92VlRI?=
 =?utf-8?B?TmE5SFl4Und2WjlWbXltaEQ3TnQ1S2hqcHdINkFub1NkMlVSRkRCWmtWczF0?=
 =?utf-8?B?Si91RzRUTG1Ob2cwdVpGTHV6clpwTUVYcTcxbFFzR2tORlNJUlNuUC9wZTJj?=
 =?utf-8?B?ZGZISWhCK043RWJsWUJsYWlQU0RoN3BVNENuZVFoVTNZR1ZkTy8yZldVTFlv?=
 =?utf-8?B?VjVQYWJiaElWZ3RINjdUc2VabzVpR2ZsekxGTElYclVjNGpBT0FwTGVXakk0?=
 =?utf-8?B?eUhuMGkzUE9idjVrREJjMHpURko3N0tWZmV5MG16UG9CQW1RMCtJYUJYTFRp?=
 =?utf-8?B?RWZTZGNhZ3dhMlI5VzZQUWpqcmQ2dGh5dk8wNW13Snp1MWpLUXE1SC81Ymlz?=
 =?utf-8?B?RE1hOXo1ZkNVOGsyWHBxL0hPZXB0NkhYalNiWHpRZ2FQaDRqWU5FMkRkUHFW?=
 =?utf-8?B?Sm1VcjVQcmMzQkhCTHJha1NXTktBeGlvcnA5RmRTb0tBR2ZTcldtSmQ1ZU5L?=
 =?utf-8?B?ZTQxcTl6R3R3RktiTHR4TkN4YXE4WWFtanovS2NRQTJmWXE4V29PK01PN2xX?=
 =?utf-8?B?QTNzd3lMS2txeHE3N2podGxiYkloVGlaZFI4REpHd3pUNWJyUUVoeFduSVpW?=
 =?utf-8?B?WDZEVERNSzhaZDlna055dGszTnpZTi81MnNqSlBWZGsvTjg0dUlUVVFPQVI4?=
 =?utf-8?B?OHdyaHdVVFZyQ2xXcHJ6ZFVXOU9DZHJXdElIVzl4MVNhQlVCN0kvZnp0RVNK?=
 =?utf-8?Q?rHv0QfBFeVQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzNCMjVyY0RsVTR2bDNYeGlnUWh5Ky9GZEtQeWRyZnl5SUU0eGhRY20rczkx?=
 =?utf-8?B?b1pIMHY2dW5FakdXKzUwM2k4VERyWDJ3SXgzL2c4WkQ4d0RqbGhCOGtlaTV5?=
 =?utf-8?B?UVR2SzV0S2dnYWY4NC9tNnJ4V0NzV0lXSTNxWHd5amtaNjF6eWVwT1U5eEUz?=
 =?utf-8?B?T3ozT0trRk9lK05pZnRCQW9NQzJnMk8vVGlzLzQ0T3R5Q1JFRmxrNDRRY3U2?=
 =?utf-8?B?NnVtUDgxQXJmVFBEbGluK09HL2ZkdDNjQXlYVXlpM25kYjRYdzh2TzJ1OG9r?=
 =?utf-8?B?dzhSVU1FcGxrZ0hlSC9yeTJVUUE5VUwzZVYyV0J3d0J4cUpFUys4bW81Y0Jq?=
 =?utf-8?B?SGNVTm1mWUlYVzNvNzNXNlpyT05wZ3NpSDRmTDJPTmZ3enh5bHBRWENHTHh2?=
 =?utf-8?B?U2xJTDc3SGYyZFcrOUhLWTNyUW5jK25kM2lwWmk4RElXZU5UMjFvQnIwbE1a?=
 =?utf-8?B?UTBYSE10RVRxZnh0VWV0dVNoNFFCZ3hMTVVWamZmN2RtdkxZQyt4SElncGQ5?=
 =?utf-8?B?TmpvenE1VEtReWVjdWRXd2RnNVFKc1hDeW9VY1IzTUgzU1E2UEE0QzFXdFg0?=
 =?utf-8?B?TGtZcEdWYlJyT282bklBTGpONjlLeE41NHhRK0EyL3JGNjBPQzkzbDhjYUtY?=
 =?utf-8?B?dGpsSEwybTdMNm04ZzNvQ3FtUDBTQVNwYjZtdStFZm54a1JGYVRtYW5YSU05?=
 =?utf-8?B?K0l3VEcxL1VNREtVRkQzV0hMa09IZGRwY3dCaVlhOXk5SVl6U2o3Z1FadE9W?=
 =?utf-8?B?K2R2bnc4YVdkRTdzTjQ5allpUWlhSUFkOFpTRVQ4MUMwZXRnQlVERmd6cW1r?=
 =?utf-8?B?dENwU1J6U05FK2NiR3I2eWFYaHN0V1F5c3o0dW9OT0NmRnhEWnBSeGJjQzls?=
 =?utf-8?B?TGUxTXBoZE1kaVQ5N2R0ZVEzOWVqWVhOOFhsSjhBSTBaUXBsNmJkQ3dZT0VY?=
 =?utf-8?B?OTNtR1p0eUZFS0hjUXpZZUZDU3BwU2tWSWorM0w0YXpMWkxOaGl6bmYyVmhM?=
 =?utf-8?B?SE53ZkZpNWtkZUh5WS9ERHpUMFk2b1lqeFk2QXVaWGhSMVJncU8zcU1KSFFp?=
 =?utf-8?B?OWd3a044UGVoNndxSGVpOXNVck9KN3c1TVpkcGhCYksvaWUwQWZrVkpGVWJC?=
 =?utf-8?B?WnEya0NtNFJDOWVFQVJQTHZlTWx3eGZheUpJYjVGNllkdnZqUlVGc2NPbkRL?=
 =?utf-8?B?UHQ0N0E4UUJyTUhnbkxPdVZqS3Vxam93cVlGVHcrSmIrSDljMDdVRkVUTG9x?=
 =?utf-8?B?TEQ0cmNWZndWVlE1LzNWV3Y5U3cyVkQzQVgwc1RFSzNuK1l5M2dEd2UrR2Fj?=
 =?utf-8?B?OXEwVTAwS1VMWmhTUkMvTHpBdFlVZHp3ekVBYzZXdVdhbXFZeGZ1SEt6RDdE?=
 =?utf-8?B?MVN0SFR1RXg0NXlKb1dlQkRmREdPRjJOS0VBWEpJVTFJWjdMRGxZRlhhZmtB?=
 =?utf-8?B?WlpCd3I3T2dNajU3NlpkbjJGZjZROFRvd3FDSUNPYmtKRUVkdTNuK2hXbHg1?=
 =?utf-8?B?ZHR5Ym5QVC9EZERsa2pTVG1MWGxHQW1FRDZWUGZOZXZIY2JUbjNldkFuS2oz?=
 =?utf-8?B?d1FQa3YwRXBkN2ZwS1UvTUVOMUhmcGloVGd3b0kySTRyUWNxZXhONm5XQkVh?=
 =?utf-8?B?RHJOcVp5WHN3UFNRMGZlK2VaNGx5RVJLdlM3U2xUcW4xSDd4ZjZGblhROEZq?=
 =?utf-8?B?Mmh1b2hPRERqOGozMklFWndYSUZsbHM0WVIzZXk2djVjSEpDZVFsb2F5LzA3?=
 =?utf-8?B?NXd4dFR4K0xiL25vUFRaM25xYTI2NGxPSUdWVWNQN1U5SStwTlIxT1BMWnpW?=
 =?utf-8?B?WlJJQU5BRjZsTVJ1Y1hyQ3d3bnBoY0hFV2NRWHlYdXZpWE9hUFNCRzluN1Fa?=
 =?utf-8?B?NnpPN0NCeExEZ2JOOFhjTmVuODNMYVg4SzdaZmU0NXVyY1BKTDlBTzZDNlJQ?=
 =?utf-8?B?TjU1SE9Na0E2RG1UcTU4Nm1zTVR0djRIQlFPb3JyQ1JDKzkrdVI5YUNLQ2FU?=
 =?utf-8?B?TXpHYzRSbXVCUVNxRnpGY2pBcGNiRmNhU2k3Y0IwY0tFbkJIRjVsUVVUbmlj?=
 =?utf-8?B?OFNYNFJOTm5TUkthS1VaTzZmcGNiZ212YzRSOFVLTEQwUTYrVUlFNHFOalhm?=
 =?utf-8?B?akZJZWJrUXJrdGdNOVd5a3M1ZGJCNnh0OFNwaVh2bUZKQVRHTncyYUl4T1Ra?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fa6093-3992-4cb1-3abf-08dd923a4ce9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:22:05.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXrmjU86I+fwj2vyNW/FJNl7i5O19Mv/Za6fWKBsRV6MZCRBrODsuQZ5HIoJZaa7joIjkci5dvJxToIMerSgLASh6UxMXeJDOVvZH03XseA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6994
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 20 May 2025 14:32:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2705

Hi Anand,

On 5/13/25 6:14 PM, Anand Moon wrote:
> Hi All,
> 
> On Mon, 12 May 2025 at 13:51, Anand Moon via groups.io
> <linux.amoon=gmail.com@groups.io> wrote:
>>
>> Hi Quentin,
>>
>> On Mon, 12 May 2025 at 12:36, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>
>>> Hi Anand,
>>>
>>> On 5/9/25 7:45 PM, Anand Moon wrote:
>>>> Hi Quentin,
>>>>
>>>> On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>
>>>>> Hi Neil, Anand,
>>>>>
>>>>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
>>>>>> On 09/05/2025 09:02, Anand Moon wrote:
>>>>>>> Add conditional compilation for the usb5744_i2c_init() function based
>>>>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>>>>>>
>>>>>>>      CC      net/net-common.o
>>>>>>>      AR      net/built-in.o
>>>>>>>      LDS     u-boot.lds
>>>>>>>      LD      u-boot
>>>>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
>>>>>>> `usb5744_i2c_init':
>>>>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
>>>>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
>>>>>>> reference to `i2c_get_chip'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> Segmentation fault (core dumped)
>>>>>>> make: *** [Makefile:1824: u-boot] Error 139
>>>>>>> make: *** Deleting file 'u-boot'
>>>>>>>
>>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>>> ---
>>>>>>>     common/usb_onboard_hub.c | 4 ++++
>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>>>>> index 1242513c631..92e3f3a92c9 100644
>>>>>>> --- a/common/usb_onboard_hub.c
>>>>>>> +++ b/common/usb_onboard_hub.c
>>>>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>>>>>>         int (*init)(struct udevice *dev);
>>>>>>>     };
>>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>>>     static int usb5744_i2c_init(struct udevice *dev)
>>>>>>>     {
>>>>>>>         /*
>>>>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>>>>>>>         return 0;
>>>>>>>     }
>>>>>>> +#endif
>>>>>>>     int usb_onboard_hub_reset(struct udevice *dev)
>>>>>>>     {
>>>>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
>>>>>>>     };
>>>>>>>     static const struct onboard_hub_data usb5744_data = {
>>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>>>         .init = usb5744_i2c_init,
>>>>>>> +#endif
>>>>>>>         .power_on_delay_us = 1000,
>>>>>>>         .reset_us = 5,
>>>>>>>     };
>>>>>>
>>>>>> I think you should completely disable usb5744_data in this case
>>>>>>
>>>>>
>>>>> I would recommend to go the same route as the Linux kernel which has a
>>>>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
>>>>> the necessary dependencies.
>>>>>
>>>> On Linux kernel, it needs to parse the device node with i2c-bus.
>>>>
>>>
>>> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with
>>> dev_read_phandle_with_args with i2c-bus?
>>>
>> ok.
>>>>> We probably should be careful and figure out which boards are actually
>>>>> using the usb5744 and add this symbol to their defconfig so they don't
>>>>> regress.
>>>>>
>>>>   From my initial analysis configs/xilinx_zynqmp_kria_defconfig
>>>> which use CONFIG_USB_ONBOARD_HUB
>>>> I believe using DM_I2C to guard the code is the best approach.
>>>> it should be around .init() callback to guard this to work.
>>>>
>>>
>>> I disagree. The driver clearly supports the USB5744 and the driver is
>>> compiled regardless of DM_I2C support which is required (as far as I
>>> understood, maybe that's incorrect?) for being able to use USB5744? I
>>> don't like hidden dependencies.
>>>
>> Okay, I will add a new configuration option to guard the code as done
>> in the Linux kernel.
>>> Also, I believe Neil's point is we shouldn't try to probe the USB5744 if
>>> there is no DM_I2C support, simply excluding .init() callback will
>>> probably just render this "support" of USB5744 non-functional?
>>>
>> Let me debug this more, I will update the next version.
>> I need to check if this binds correctly to the USB hub reset.
> 
> I am trying to get the usb_onboard_hub to bind.
> but this driver is not getting probed in the first place,
> I am missing some configuration to get this working.
> 

Don't know your setup, but maybe have a look at 
https://lore.kernel.org/u-boot/20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com/ 
?

Cheers,
Quentin

