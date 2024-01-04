Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F20BC47DDD
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.47])
 by mx.groups.io with SMTP id smtpd.web11.50806.1704362956313188414
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jan 2024 02:09:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=ofLIUHpC;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.223.47, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G71xzHQk0XPM/PpuEssvE63hRsiv9rsx0QOwYegyx/PhN7CWsCsQSLGDkT+LiC3ENQF+a2fRQ7I4rIA8p1H8hfIeLu+kN3Ksu+zlnWQJSnowIG6PyIYMg/gLlbS3mbz1J9PRdC0DU+uosct3FM1uqwOaROXI2c/vSOKZvxYii7zkEWgv5phtsnluK1tlXKSKCdIkV59YW8Ta++Yj3V57MtsZ2RTqngLtJYuDhaZt34/VqvkKy/lUO9vlrxh5npDrwdhinoAf4GuqJOoXgwQ6uoWjgfjWYCzhJKU/e8oHwNyCDX+tU4CEIyod2BxF+oAnmopgyVvCVSnUeFU/Qm2Jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPWyvuCA8nFIBL8p3HVkp10ph4V5W912JGL0VoGkpQw=;
 b=OHwOFOh583BUFHRqfludTEKiDUeqEk+rQKgyoEgrAq2CU8jAdbYsxMSa91KQej6n7yIQMvCagra2yeyKX0S2axR8beoUpIQxRb55bLPI5aO4tTUy9gJai5406U2MjxMYkw0FMiP/WTzmMba5Ymn7S4Q4OKQ15NiA9lkczRSZmfz2locs+h8oTD5+YcoN/jJiLeY1dctc34/827VqOsOFKyp78rH2JZEXjw8wbgUca7xsXm/Xd8mWGRhz6N2406CB9dObUXFTZc5/qsfHWrd4g6lLqU9N0g03+Cwsr8F5HcUcyUiAEqBlQoj/OAP/I6N45lASMV/jsE3I4AORVPWdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPWyvuCA8nFIBL8p3HVkp10ph4V5W912JGL0VoGkpQw=;
 b=ofLIUHpCVqkuSap0+lfc5zuyNM26e71w1iG+g360X+NkQocQ9887F2DRNonEvzQZPkHsw4MfL3g6+iPTrJGJp9bK5gv+RW8RusT2Lj1cxW8dLFnpg67+3s+Lb8D000SuLEeQ4wSlqTU9KFT6o6SJpElXJbfgxt48CvKledWBkwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 10:09:13 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 10:09:13 +0000
Message-ID: <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
Date: Thu, 4 Jan 2024 11:08:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
To: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>
CC: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240103163201.GL1610741@bill-the-cat>
X-ClientProxiedBy: VI1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:802:1::48) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1931ad-e663-4334-c6ae-08dc0d0d338a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+hoLCv9kNwTig+3f7AjoJuwEKbeLoyzT4kHRqlL1UtZdvKRu5gTgzVgMaJnK1MbE2P9ur4ARt1LGsRxNgxWYswLw/MrE2ZTMlYc7VEf1tEB0Fvg65yrzDIXRgmq9Jr0JL5Qgfmwe4kDXYbgCV07nmY5Jq4QJ6hugj2ycf4ajFQv/N9zlkL+n/S9dzyRjzvg9Y8lH7R0z0qtXcBuLV1LpLb+NfMFwVQHh+4B+zN3qQN3vTi73WOtKdClEJdqUCem/y0GFFuTeCiHx5WaM/mZaGY/apPiVU4aGN3O2ScHAQGnm40oOD0ndEnO8lnrMPCYn1BiI7vX1JKUI8persPlnnVqEu5kuuLcI82BqnRQM9XC5C8NZ3vfs7nWFEs7UXRxLk8TKjsmdWSQWB4r1gnjOZ7/hcaGlT+GoHJqUUqNDZZ67yUPlAlzgeWY2Z5srRTMFvjABXzB3m4ntGKza+tXJXwRkT0TBn7C4t92zXWLITtvzeeOwtjnI10EeOochcBNn7LRYTjEgExCrXErfwlbOdgWzcam2Rnoc6wDxEegdfHavsb768/oXNEQQ1Fll2hMDS38V9Og7v2B8cMFdItYgKtZG3qwD98notolHA65JOP3l3XBqsr07FbTAF4sxMjae4EjpNIeiRrjRtBrWRuaiww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(66556008)(66946007)(8936002)(66476007)(478600001)(8676002)(110136005)(83380400001)(6486002)(6666004)(53546011)(6506007)(6512007)(2616005)(316002)(26005)(15650500001)(44832011)(2906002)(7416002)(5660300002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hIbx9HYpRuNdDTU1bSPg23xqN0AoaeuasVltlY5jrNK+1Qyn/Np+ScGULba9?=
 =?us-ascii?Q?6YJegd/wCjJy1dZL1oCppiHIo8/T+RKpde7pZfpzKD2D0P/9GIxmNj2op17j?=
 =?us-ascii?Q?PkrNs7TIUm+dQrz03lShD0Qe1Dcm9NMWlEBT+vt/VW8b4T1AoqAuYY1jPCyT?=
 =?us-ascii?Q?Un3PyBufqgVBVycHP4gNoe+FJNWPVzci9fzoi0rdZLPEYRId5AcPZgX8sjKK?=
 =?us-ascii?Q?0UVHxcVhi3bRCaIHMO5ONzAD5j3TLLlPoFIcLdUYOQwgF3Hx2d//ZMw4aD1o?=
 =?us-ascii?Q?S6PWU47etqg6SIua+I+1rqvgxY5P4Zti3pqdlbBpCeMoahEI7XSppSXTUS0V?=
 =?us-ascii?Q?dJUAayo1JahtMcPa2yqytvJYXzfCYRFIKQ8xFDCZuFW0Ijdxcqz7a2NmHcaA?=
 =?us-ascii?Q?++DAPhvjYOzNHY7H9hbE8ByKIPoeWBFUezPWGguRcgAP1u4SCbcuns67DVtw?=
 =?us-ascii?Q?JhDrF+IWCialEoPUWoHOKwvCAYiArbpZUqGHVhA3deKtolM5iTUbqupmG1KX?=
 =?us-ascii?Q?niaTZ9qMMGWj8agfS/4HMAJgwve2U1xgGKjQiPiJb3x3qs9xmG7L52i01yvs?=
 =?us-ascii?Q?ehiy9Fx886HcVw+/ht1ivmN113Nk1G2A0jX7YXVcwa1SYJJYGOCtEpYlaoPz?=
 =?us-ascii?Q?aA2lrRTc7V5pflnNdXm2qMyVFXMt20FYEdDtfGX+ROzESw80KBLizoSk8eOT?=
 =?us-ascii?Q?kt9NKs1fqmpKYUnn6YmomiEHaMZpLF7GrmfeX+ODtJC7wt2UhXB1ukgSAd07?=
 =?us-ascii?Q?ZPeTFIZPbriWpRtiu9lyHC7GSfEffm3b4+cHYtydehuOpvmO7MCHD0CgRImZ?=
 =?us-ascii?Q?T1X3q41NTEN0hk7qYjnzHQ/1E6f7KruHV92dzuyHdrkFET3k9We2OCXeqTgH?=
 =?us-ascii?Q?jgEPgCPbEHLHANz4Ym0dTuecyQk2lH+4q8V71Pe/I3CaRpDOvuFEGDnoYg1L?=
 =?us-ascii?Q?wqVCsv3fuiBUCBs2GEw0C3TXCamKUjoxNLM/2SFr6gHwFcwNcII1izSrHoOl?=
 =?us-ascii?Q?aMcvSqm+0bQIj06A7ePenwjxC0N0nO3IcsbTm2Xp9+QfNTUQ+09j6b9/S5Y5?=
 =?us-ascii?Q?mYW6wOmDNSFM2ezLt06CZqgW9JoBJKGoE7HqI2duicLjSmtk61w4jX9XmCP5?=
 =?us-ascii?Q?rmlSj3tMZmSRq7ipAyJCm0ZuXr/3O6vgWfs2qR+lQeSXQ/9YSnWyPMkLHx3A?=
 =?us-ascii?Q?WzFVzZ3fGruhUbldhCA416ylgvabNTD3BBP11MA5MhUBRDFlMk8fn8vCluVs?=
 =?us-ascii?Q?bvgZ6kySguXKySW71kykGpCMNqEIs8JnGgEZXpJ5HCtGV2xyTVZGI+p526Uq?=
 =?us-ascii?Q?8VePMECZeam+HpKKA3VRjDHE5Npkh1kkOGwHZJ77eBC1K0oYM1wOKV1uvvFO?=
 =?us-ascii?Q?A0CbuT3v/LSkd5fm0P/M/PQuocUJ61NWOuaRjh7lTSSUArQTxXcyMAbMAVA2?=
 =?us-ascii?Q?Fq1QFslO9fPSM7kB2r+en/b0atOILkIdCpIyIldc4vG9D3GxU+h8z2Ob8yhE?=
 =?us-ascii?Q?HjzcZT2tNsKeM0v2K7oLoqiwmmePSToH6q/x+x+sm7x+a3H4R4SeVolT93vL?=
 =?us-ascii?Q?Ymqh9eauG+vknuUWZmRNX2W9dnTsXCSQgqrme5HV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1931ad-e663-4334-c6ae-08dc0d0d338a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:09:13.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOAswLLGru072B80ZKXqHSPPeWGW1NvfiLy9EDA0wuvtUvrvWmW47KSXbyRR4eGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2035



On 1/3/24 17:32, Tom Rini wrote:
> On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
>> On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> [snip]
>>> +In order to maintain devicetree files sync, U-Boot maintains a Git sub=
tree for
>>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is =
regularly
>>> +kept updated with every new kernel major release via subtree pull as f=
ollows::
>>
>> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
>> had in the original repo). I don't think it's relevant.
>>
>> We're not likely to regenerate the tree, but any clue what 'git
>> subtree pull' would do in this case? It could happen if we switched to
>> git-filter-repo.
>>
>>> +
>>> +    git subtree pull --prefix devicetree-rebasing \
>>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devic=
etree-rebasing.git \
>>> +        <release-tag> --squash
>>
>> I'd put this in a script to run. Documentation tends to be not quite
>> correct. A script could also be smarter and figure out <release-tag>.
>=20
> Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
> something using subtree, I do hope to learn some lessons from what you
> do there. The first thing is that given the size/nature of the commits,
> I had figured I'd be the one doing this as a subtree pull+squash then
> push, rather than posting to the ML since it'll be huge and
> un-reviewable, but with a note sent off to the ML that people should be
> aware the next sync has been done and retest as needed. But Sumit, were
> you planning to do some of this instead?  The second thing is that if we
> move the subtree part in to dts/ instead (where we will still have the
> Makefile/Kconfig we have today and then our Makefiles within the
> directories, this might get more complex and so really require a script
> to keep it from getting error prone?

I played with this series and didn't really have time to dig into subtree=
=20
mechanics but one thing I see is that when squash and merge happens you can=
't do=20
simple rebase anymore which is time to time very useful.
I see some different rebase strategies and --rebase-merges option but if th=
is is=20
adopted it should be properly described how to rebase u-boot tree which con=
tains=20
some subtrees.

Thanks,
Michal

