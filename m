Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6DCC47422
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 08:59:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.54])
 by mx.groups.io with SMTP id smtpd.web11.10352.1706252722793101710
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Jan 2024 23:05:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=EN9H9/Br;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.54, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9dhiBMQxyk63cOwWmVI1j1MMUvDopMzo8byG4EOvPwINsbbM7m7XrMjVT4gDXfVc8REiOgdQ9OS54d2lKtiUvEfImhMv7EcBHHdSswU0RB9FUFjZ4a7HzsFCMqnAyppy71Pvyz7ACrFcqPtxg4oj/LaohigJOX2rsMbnPWc2XIRjvC8d36qn/zj6IQffd+Hvy4elM/HnEDEZe2vR7LZhubESRWO26eByylQQkToJri1oRUbiHLyiGhJPFWgN0jF+6nBclLzDkgJ1lv9weze/arw4MLRtyEiBiM99e6xZDVnL+itGLRtRf9MtcthUTzoAPeqSAkyYuwB92Cpt/tHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc9qg2iP93z2QmF0WHKxxf6iMi21vRbcol6JzEIm75I=;
 b=GEAKP3IF+9GzXKqzyMs1+F9aE3fQIHuPSAiSPddlwvcHpaK9ru9uLJrSKyboY9SxIoPgF1EWJ3gIgISQPkCwhbo+TfyfGStDiMYJAX//1Yf3Fvf/CrP1noHHYK6KeidrmVmyWQfr+XsQHxW17pJPQoMemFL1b6gBDbG+3Q1NURYrAcmp551SyxEOb+d7FGIdhj6Mzwjwl/pX1byWfihhKmqgwu/lLGe9YzErlzeHGqyztsLmMsgTQDkrkkKjhgzt7DmLQoXp0+aCk4Z08Hvt1Ul8NQDY3CPG3FJix75H7sYYKm+nYduD5sd5gxPbNuW+IzkgJrS/37t8XJ8y+jhtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc9qg2iP93z2QmF0WHKxxf6iMi21vRbcol6JzEIm75I=;
 b=EN9H9/Br2/z/ozGFwsCj3L7NbpBKHgXwzICaPgu2SFGTUwA59D4QJURuhlBJ8xSkmLhf3WLzc2r8NstIDEdd2riXiisfhpF7puTPXzdEmdKxKrhKP0BNEO5yrN0YjnhE+T8vht8gKRvB+HMe5ZexR5HlfWqs6gmEsM5NpPcXv4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 07:05:18 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 07:05:18 +0000
Message-ID: <115d5376-8cf9-474a-9344-223df4ee1d6a@amd.com>
Date: Fri, 26 Jan 2024 08:04:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
CC: Sumit Garg <sumit.garg@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
 <20240125150400.GM3652023@bill-the-cat>
 <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
 <20240125231933.GY3652023@bill-the-cat>
 <0d4ed462-a5ec-4114-84ab-d2e2a6d79b69@denx.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <0d4ed462-a5ec-4114-84ab-d2e2a6d79b69@denx.de>
X-ClientProxiedBy: VI1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:50::15) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL1PR12MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: db6d59d2-2701-47cd-a0b6-08dc1e3d275b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hnWrBe6Z7fGVGCuhxO/q1xEymqPpeLc29cGbzV6e4bNXOfcXjsv18MCF4blSBQKyUp2Sajm1XW2XO++DopDLliOreDGejgURVajpjcRkPwJVHGUv0XLG5XRoaESOVKz3moIx7W7G+GTmkd0HmX8PB+d1oJLBl6zHDUSNREMRVwRfink44gi7AFFWJ0vPii1pqOJ2pHSl2phZ2JzEyKjro/M4Nlz5g2Bcj/lgbBNmWuY7vUdxw0kfXgfwIaSHcDi4W19Pv5EbXTimPtG9mQYlPyTI7+eDEMKRGoM5oqYjiEIMEj9ujbt2tsSgs7+B02fIZFFOa8/NfCUn28IsGKjpxFk9bso99cHglFUiQ2/yC21uN+hh/V/ncfyWiHK55057tPgyBjmt/pch4dzOoxXDgEUy+3MWpA6PMaMUnE7fqLxS3boX/O2Dt8U5Ddj3bUfB3973OqOU35zA3EhmEc1DnLF07xACHxj6zLSf+ng5k7GLPfwzI6Jb77WIgbf+MMl2GCF0gCA6NEcG+Sr3LTlqJ+x51eBqdbJdSeYCA7BHRHXOnlFKRveG/pOIc2r3vkt8OSd9lceUpCjZzzo3eHKPH+bCo9wCyPH28R/uH5XIGRp1aG3yF71TL6Ql2u0XaRN7LNDROBuezbA+WnnYCMn2hw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(2616005)(53546011)(26005)(38100700002)(4326008)(5660300002)(44832011)(8676002)(8936002)(41300700001)(7416002)(478600001)(6486002)(6506007)(6512007)(6666004)(2906002)(66476007)(66946007)(66556008)(54906003)(316002)(110136005)(36756003)(86362001)(31696002)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tBYW8EhIl8TW97cmNkWetOUoriOqxtHjcxTIG2wRINk//MlKAN8xOAVwYW5K?=
 =?us-ascii?Q?i/i006Iv4D83N9DJ8GJ8eTtDMtJhG+aYF4BuodNJ4BLZPuGxCJvrwUDtJhH9?=
 =?us-ascii?Q?/C0rxNRpJtWuROmqb54y8tmrMIvSFg4VeMtGZhpUvMzzc9FKHAQNCbdapBDE?=
 =?us-ascii?Q?u7F7PM6/ZtyWgeamq1VVtJzEVqHy2mkhStKkr+1Oxe3lMPj8XOgVYlsOUgyQ?=
 =?us-ascii?Q?VoJI6OAeRY1n4h0LZdrC3/8lPt5AxNumHEp07V63Yh9Y2JVfu9C2H3JWTDPp?=
 =?us-ascii?Q?hsy38F/I85QrkhlVEmmL0Wbp/Io0jN/lOChRD2s4YLMwzvj7wlVvCobE25MC?=
 =?us-ascii?Q?McXKJ+A8XDV5nqzC7b0ObL8oAJHxMqy5C3zbcv6NGUZ0XAO/PDdsQmeLwd8b?=
 =?us-ascii?Q?EoF2rRgbgcKO0/SGHEIyPJaNX165EZRh1PeMzGZFLIl2V5zrLPbowHvTusMm?=
 =?us-ascii?Q?E3VNNRsG0qO5Gz+PuInr39fiwNGZet/hlPHW88H4uHg7MsktHbEFXZBz9ian?=
 =?us-ascii?Q?L5vfOZ4rna8i43H+AI5kSrA9HVcgTgi9bEHh13vTdcJ5IKBnI8Hw+XURvF9a?=
 =?us-ascii?Q?NsN9QhQUZGWOofI3cL/A8vSofELC4L3P3Qem98f9AhAmsJyPQkR0MRXSwoje?=
 =?us-ascii?Q?g+3tYF38avBRoIUtsM0SjmNR021WPe+acM0uRsUVvLuj3/Gy7vD7p3w+W2mv?=
 =?us-ascii?Q?+1xOeUGvRK9G0AXFKB58eOTNrUK7KRbGbYTAmuncg/MC/o9ocnzzN8VPuKtL?=
 =?us-ascii?Q?cxDex2y9czzM52zhuO+pYdrsCtu7HRzPq2u4TPedyaruh8hgEjETYZjcuvY9?=
 =?us-ascii?Q?R4ignYl/5ogZwPnFsZb/AIt2Q3NIB+8FXVTSGd2P+Xs6/UmrAXRFMCixm4xQ?=
 =?us-ascii?Q?Ah0986QbZYfYhloRHVcdsg9RfN8et0M2OG2CjmeaOged2MRQuZVqVkaTinnR?=
 =?us-ascii?Q?NMII4IEN3hnB5DRpfAY6/Sgpw71BC7UYZcBuBj5dD2ZZm+ndDfkYVFt8NLiY?=
 =?us-ascii?Q?wGQrviIOSMbb3mbCTlnhg+L7doX3SGGCuGFApVjkHsCuLnrQVD4GwfC8TsKl?=
 =?us-ascii?Q?GUcrKjInjypICUzsuKkyqqlKkT8CEhLRNB9/z6tlgZGzdQGE0cVNTKEp8RQK?=
 =?us-ascii?Q?1QfX7drqfnk+P+LKu395azi/qwsYs641txn13Smp+O88EFN+n1Dg3fHS/QbM?=
 =?us-ascii?Q?8ba/F+68K1ZcoQ4Vtptj4pw7h3dcTabMQxcBZrGaxclaZGHai2u6gwzJ7gA4?=
 =?us-ascii?Q?Uw5G3NW2Q7CNWgUyci1kIo41WUBJ9siz/DQ0Kq/1qHWGtasJ3ENyft235jRy?=
 =?us-ascii?Q?72S5q5HExpnJ3/XAMJfpw35Gi9dcA8CrM0K5aYJWL13VA4cM74PQBCl43TWA?=
 =?us-ascii?Q?01t5KOnL0fRs3RUELMCTOf46oC30KzzvzBQ812ibPJVHWm/lbZtD28ivHwZC?=
 =?us-ascii?Q?APq5MQcCeQG/pzKTgpXLSb2ohGvdYj+jFJWlvOOYy3801n/E69jPjl4d5meB?=
 =?us-ascii?Q?Xtl5KhTvds2ky7bnESWae7+kfkcEO2T7Bm/M+QO8/nRnRGVOEqlGdDBZupLX?=
 =?us-ascii?Q?j/jjvmsd2nfe2WKI/o4V6moCvU9GLke8GnoPxMOa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6d59d2-2701-47cd-a0b6-08dc1e3d275b
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:05:18.4044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T3FpbqUzRWgXF6gwoHoKY/ehdv9qQTq7apjDQoNl1sbifQuh816huuUNVavD9X+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 26 Jan 2024 08:59:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2091



On 1/26/24 03:10, Marek Vasut wrote:
> On 1/26/24 00:19, Tom Rini wrote:
>> On Thu, Jan 25, 2024 at 05:38:23PM +0100, Marek Vasut wrote:
>>> On 1/25/24 16:04, Tom Rini wrote:
>>>> On Thu, Jan 25, 2024 at 12:54:22PM +0530, Sumit Garg wrote:
>>>>
>>>> [snip]
>>>>> But at this point we have to move away from apprehensions about DT AB=
I
>>>>> breakages and provide real examples of the DT ABI breakages in the
>>>>> past. Are you aware of any DT ABI breaking change backported to Linux
>>>>> stable releases? This is the sort of information we would like to mak=
e
>>>>> DT bindings maintainers aware about.
>>>>
>>>> Well, how far back are we going? There was a serial related one, but i=
t
>>>> was probably closer than not to 10 years ago and lessons have been
>>>> learned from it already.
>>>>
>>>> The real breakage comes in the form of (from the Linux kernel):
>>>> commit 37685f6a63eeca2135d1f704e7638409a071b1f6
>>>> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> Date:=C2=A0=C2=A0 Tue Feb 19 08:46:33 2019 -0800
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: am335x-evm: Fix PHY mode for =
ethernet
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The PHY must add both tx and rx delay a=
nd not only on the tx clock.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The board uses AR8031_AL1A PHY where th=
e rx delay is enabled by default,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the tx dealy is disabled.
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The reason why rgmii-txid worked becaus=
e the rx delay was not disabled by
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the driver so essentially we ended up w=
ith rgmii-id PHY mode.
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Peter Ujfalusi <peter.uj=
falusi@ti.com>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Tony Lindgren <tony@atom=
ide.com>
>>>>
>>>> And this is of the style "the DTS was wrong before so we can break it"=
.
>>>> This is the specific example (as the board is in my lab) that comes mo=
st
>>>> clearly to mind but there have been similar examples in 2022/2023.
>>>>
>>>> The other just as painful examples I think may be where Marek is
>>>> concerned and it's around nodes being renamed for correctness. We've h=
ad
>>>> a number of cases where a - turned to _ (or vice versa?) and whoops,
>>>> platform stops booting. Down the line, tooling would catch that, and
>>>> it's a problem of not being able to use better tooling until we have t=
he
>>>> updates that might break the boards that need the better tooling.
>>>>
>>>> And really this gets to the crux of the problem, how much testing do w=
e
>>>> insist happens prior to a re-sync being merged? Do we want to go with
>>>> the whole of the dts files are re-synced, or do we leave it per vendor=
?
>>>
>>> I'd much prefer to leave it per vendor, with the recommendation to use
>>> synced DTs. Eventually things will stabilize and vendors will start
>>> switching over.
>>
>> To be clear, every SoC (or really, board) has to opt-in to OF_UPSTREAM
>> to start with. With that, I see switching to OF_UPSTREAM meaning that
>> there's a commitment to keeping up with dts change in upstream dts that
>> might lead to issues within U-Boot. Do you still feel it would be better
>> to have the re-sync _also_ be per custodian tree? That might be a bit
>> harder to handle.
>=20
> Maybe the best thing we can do is just give it a try and see how it works=
 out,=20
> esp. since it is opt-in per board .
>=20
> It would still be good to solve the part about pulling in fixes from=20
> linux-stable though .

I would let board owners/custodians to deal with their boards.
There is very high chance that if you do it globally that it is question of=
 time=20
when something will break.
It make sense to talk about how to do that transition and describe that ste=
ps=20
and having tools/script to help with.

Thanks,
Michal

