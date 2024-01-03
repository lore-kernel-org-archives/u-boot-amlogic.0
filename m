Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC5C47077
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.87])
 by mx.groups.io with SMTP id smtpd.web10.16757.1704286449902479774
 for <u-boot-amlogic@groups.io>;
 Wed, 03 Jan 2024 04:54:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=odXHmQBU;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.102.87, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJezamiYlIsEWPI3GfxsH3XNkdJND0c1Nr752K4BPDFdzMny7QQNJJQJUDAYMEi0SnTyk1gqb4PCBhmZm4eTLgLKVcg6cdthlH0Dkmez1XBKD/tYRc+3eCSAm6pPl8cvndRi7dDIDqzyPomDZ2hHOueIesr6KoJyYl4CAKoLGVNFBZCPCfKqFB41Ko+9kwX+NA2dqnH8W3OFmBYAaz9IgY6COPeVdUobk+oPxmvB5N+oQM7Cm11ZnZaN3EL+c0umzSG0IByZdgmILHr1lqNqcNisg3Z0OOICXf8BuSSZLLsqcT9uq+rPkOajrj3XBv/Q6LYmz/3wehX7c/t2mcpHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8muDJNNxGnl4rb2aIkxr4ZVHWeZEcUj8/awoIkoQp38=;
 b=aQGwWynjzNcEytWuBTVrScy1jxv0VT6V5yt8IRAHlKxScJTHDjRpWG2TkwRHN0Bh1+NpoCUacUuWckvmOGEnyZTkzVtBRdbJaMYs7xyZ7RFMhDmhUnHCcczUoqHMB4l3uVApAipcy9hXAzZ6f7DVK2HxMOTVStVVCuw7TkmV5V1VNkIA6IEuG8SBytVLJDAuEX1QorZBIpYtjZA3dar1Rt30Zxz02jE1Cc6kNL+CGATUpHYR58jiFMuc79tv3RgIUSK4dU/euEnwOUxulKR5LU+cRCIh3kVqlq3lei1E0XYCqdXG2Q1fdjhUpxisPU6JMMkfoQ0IJyBNzapoh3WGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8muDJNNxGnl4rb2aIkxr4ZVHWeZEcUj8/awoIkoQp38=;
 b=odXHmQBUzM0nKnUMGvvIMP0Re97TlUOaH0k6791Vkvj9rRrDUA8F9HglLjOwHp3PIF5yEOT0sN7rJMeCLu6RPnKc9Jpu88wQexTMNTP16jmITknUbD8YsRuI5SBdx+OrI5TmugAJC2HO86z5svYyVxs/Gfe7sjGYyyd7VjFm0nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 12:54:07 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 12:54:07 +0000
Message-ID: <5602ebb2-25c9-4f0e-88b7-64662874d0f4@amd.com>
Date: Wed, 3 Jan 2024 13:53:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] An effort to bring DT bindings compliance within U-Boot
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
X-ClientProxiedBy: PH7PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:510:23d::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: baad2317-9eb4-4087-0990-08dc0c5b128b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r8S1wEsYO4dMCahg9O3AwL6RiKHQ0nv18p6FsT19nSkHUNizw8jJtSa7CKe1B1tbgVWBkWtqSmUA1oT/QRtWfEqXI82Q+hmMGT/nMKGkFQxuylVIw6PRrjTROcv8LkrsxM20evaqm7LxL41Nq64Yakz1s/paLo7zN7gCdrK593Oc8Jotsn2llGi8j8Tspg17svruO4FI5w6fvKxr6xlN93auGNGyxuWHGGqgRaOHvKMPeCLUOLg7lj4kDVHQ8vl259XJ8gE4B+0dcu7L4bL8CQPmRgyaPEEKcUX+m2RRxBtGxKGskXUakb/CyMZjyNF7RmNIUHM17sEWd6gb56TYGnOb9WWFm7a/faVQ39lP4BnI2zFZ0wxSseU00SLb77rQDlPNUpslmWMLitYE5rfiP5CaDo03aupJjOWB4skRrnAYyRfgmbjIltEqmFDyMPiBgS25+J8HaoGzdvfC4MZy1UxoLgommRPyh8CjISsjTlegUeyuoE5jlcq/NqwBp2xaN9wq7kRbvwpFFO8btGtMYsjYWEZ15VdlFvlX7jKcl7tnjEm6RN7YNf07bh48VM8vkVO4h8v5k+SwVGjsQejt3deZzWKyRXhnrWgI96IxUeJGFFEhapm+IVfQXiTNJsWVBeCB4xBNfJzSloYLs5XhtYub5mxIeemIAePmgeWoRrNJIDQxrrFXb4Rw3Q5Cl/rD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(31686004)(53546011)(66556008)(66476007)(66946007)(6506007)(6486002)(31696002)(86362001)(6512007)(6666004)(38100700002)(2616005)(41300700001)(83380400001)(2906002)(5660300002)(4326008)(44832011)(478600001)(966005)(8936002)(7416002)(26005)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmtaRDJSM2poQjVLWE1FQUtGSHc0bGhTR0IxZUxudElualJZM3hxQUJQYWRz?=
 =?utf-8?B?UUl1UnV2WmE2SStndERGd2h6WmxpbzdoeEVCMWU2Y3Vpc0VGdEFEZkRHbTB5?=
 =?utf-8?B?NTZ0cGZ0ejFubnhLWGFXeCtUSi9SOVNBem1MQ2M3NmxhTVc4ekR4b0FGTU83?=
 =?utf-8?B?NXZEaXRHWi9DTWlIVTZOdGkxSGtsZUJKVi9NemdQb284cTU0dVNBSGU5TkR3?=
 =?utf-8?B?L3g1RDVjK1BRUG9JS3pobGo5OFhVTjlCK212TGR1SkJRNjM2aWNSRHlTYUtm?=
 =?utf-8?B?K2pkVWt0TDV3SWYzeDBsUkREbkw2WHppQ1BsTmZpbUh0TFpUb0dvZmJ4WVZn?=
 =?utf-8?B?QldwUTVSN0l0MS9LODZKWjlMaEp6NDYwQzJFQytaZlM3R1JFYUNqYU5TMFl6?=
 =?utf-8?B?SDJNZjMyTEVwVzc4Tm5IS0s2SnlERWR3bE5TWlgzalIwMnUraEZIRUcrZ0d5?=
 =?utf-8?B?MFBYMkJvVTFLUTg2MmJoTk5pNXBMNEJJUWNXU0w2dENnVHBoNnNUU1ptZVRW?=
 =?utf-8?B?VTBkcmFBV29IRXhBdWpLcEVYbXBXaEZ2SEUvUXF6NFFhM0lnRzhPWVJYM0JX?=
 =?utf-8?B?RnZhTzRzRXdQRk9MNjdzaDMyR25sMm1HNE83bmJDT202N1JhS012ZklRYWFQ?=
 =?utf-8?B?aHNDcVM1bHZNK0szSk9jUGZxMGsvMEJxeHpvZUhDTmtZd2I4b0tMWmdxSkRH?=
 =?utf-8?B?TzJoNGlhaGR3WkxHSHVpVmVLYkxxQ05NOStUdTQ5N3NQcU1uNVd4czlaTFhM?=
 =?utf-8?B?d0J4YnZoTnF5Q0VlSUoyVVlYdGNuMmVReWpZWGFRNnU0YjRjNGFYU0ZTRTBm?=
 =?utf-8?B?QXFqU1MzSjVoQU1PNit6NWt6ZEQyUUpsOFdrVFJ1YzRORGFjd1FCU1ByWC9R?=
 =?utf-8?B?SzZCWkdTdGNLaTliV2xXYzU4dmswNEhxblFaZDJ6aHN6bGhWU1ZJTGdjTEdZ?=
 =?utf-8?B?dy8xOS9wMGRGcjR6U1lLdmxvL0UrLzgvQWh1NFVaQU5sYjZBMGt5RU9YV0xp?=
 =?utf-8?B?UW1ZT2l0K1Q0aWhqS3ZWYXIra0MvUXBLNlZvZStZNkhwODNxR25sRmR5OWg0?=
 =?utf-8?B?SXdOanpxaTk5a2tmUXpYckZyOTM3UFNZWUVFVi84QmFBOFQ4ZEdqL09OM0w0?=
 =?utf-8?B?QW5vSDhQcG5TK09KaEJxSjVNRndsOE1jaXl2UkJqZFI5QWdQWDN2R29RSklv?=
 =?utf-8?B?UUZ2dnlLOEF0elJNSU9ZM0tpL2Z3a0tPNnMxdGxqWHRjY3VTcWhwa3haU205?=
 =?utf-8?B?NjBwckVMWktWK0l1Q2NOT21DN090a2QwRnJqOC80L3BJdC9UZzg4Y1IydGpx?=
 =?utf-8?B?c0dYVkhMTDVwdFB6Z0t0UXRxSkdYcEZySWFmbzlFL0xWTjhLZ1dMMzRIbXM0?=
 =?utf-8?B?WUhWY2Q0RFBrVEwrTG80blFhZ2N5clNRbmtvSnBTcVo1WDFQelZFK1g1VDNE?=
 =?utf-8?B?MkYvQVJHTklvNjRrSWJqa3hFWTlhbkxxMVZqNFliTmpPUHhKMmdEYUlQa2x6?=
 =?utf-8?B?MW9PU252N3IxYjA4amdRSDkwZ2wzdXVaV2NzZFhESjlPMm5DUGRkaHN1ZzJa?=
 =?utf-8?B?ZjAydUF2V01MUEZrMnczRjF0eFhjQ29DcmxvMEhDdVd6d3ErQWh0UGtJUG1M?=
 =?utf-8?B?SGRtVEtrRzlFcUIxUDF6dXkxTU9QZ3dUT3YvR3dVcWhMWE5aM05SV1BZMUs4?=
 =?utf-8?B?WS8zTWM5QTZRRkJpdDlHRHo5VDZYdDJVN1JCQUVQVzBPY2NuNi9iaTllQit0?=
 =?utf-8?B?YjVYL1JJNkVDUkJLcFMwNGJZSWxGNVpEM2R0eGZ4ZUtJWmZKZUtPUDZNdHZT?=
 =?utf-8?B?dWI5Y1RNYnR2N0IwZUZLL2c0SnFsc2ZteTJKVnVlMkFiNEVYZEwrUitzYkIy?=
 =?utf-8?B?OHgweFJwS0M3UlBGYWliemNkNzJqRkhLZm5vYStIZnYwWVA3T090c1RXVDZy?=
 =?utf-8?B?UlZyWmswL3hDNTdXWlE4WHBGeTJGeFRCenFZRzh6Z05yVmpITUxFS0VVWXRD?=
 =?utf-8?B?bE4yYWlzN0hsZis0NSs4ejZMazBxN0p4Uld5VThjeFZ4cmt4SUpQSlR3WHh6?=
 =?utf-8?B?SDVhUnE0Qkw0SDBLaVFXWTFmRE5vcEZZWFBQNmpRUHFTMm9WVzRLcEg3UmFD?=
 =?utf-8?Q?eQvhldkegA/y3DpxHGMyNBY3X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baad2317-9eb4-4087-0990-08dc0c5b128b
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 12:54:07.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdjNxwXpK0qspY1YY65f1zlR7Az5WddceQIkNvNBzzaXpU60FW/uG1DL4BPaRWgy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2028



On 12/28/23 12:57, Sumit Garg wrote:
> Changes in v3:
> --------------
> - Patch #4: Minor commit message update
> - Patch #5: Replace CONFIG_* with Kconfig options
> - Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
>    instead.
> - Patch #1, #3, #6 and #8: Picked up review tags
> 
> Changes in v2:
> --------------
> - Patch #1: excluded gitab CI config check and added commit description.
> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> - Patch #5: s/U-boot/U-Boot/
> - Patch #6 and #7: Picked up review tags
> 
> Prerequisite
> ------------
> 
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-Boot repo via:
> 
> $ git subtree add --prefix devicetree-rebasing \
>        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>        v6.6-dts --squash
> 
> Background
> ----------
> 
> This effort started while I was reviewing patch series corresponding to
> Qcom platforms [1] which was about to import modified devicetree source
> files from Linux kernel. I suppose keeping devicetree files sync with
> Linux kernel without any DT bindings schema validation has been a pain
> for U-Boot SoC/platform maintainers. There has been past discussions
> about a single DT repo but that hasn't come up and Linux kernel remained
> the place where DT source files as well as bindings are placed and
> maintained.
> 
> However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> use devicetree-rebasing repo [3] which is a forked copy from Linux
> kernel for DT source files as well as bindings. It is tagged at every
> Linux kernel major release or intermideate release candidates. So here I
> have tried to reuse that to bring DT bingings compliance as well as a
> standard way to maintain a regular sync of DT source files with Linux
> kernel.
> 
> In order to maintain devicetree files sync, U-Boot will maintains a Git
> subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
> It will be regularly updated with every new kernel major release via
> subtree pull as follows:
> 
> $ git subtree pull --prefix devicetree-rebasing \
>        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>        <release-tag> --squash
> 
> The RFC/prototype for this series has been discussed with Linux DT
> maintainers as well as U-Boot maintainers here [4]. Now we would like to
> reach out to wider U-Boot community to seek feedback.
> 
> [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> [4] https://github.com/u-boot/u-boot/pull/451
> 
> Changes
> -------
> 
> Traditionally, U-Boot placed copies of devicetree source files from Linux
> kernel into `arch/<arch>/dts/<name>.dts`, which can be selected via:
>   
> CONFIG_DEFAULT_DEVICE_TREE "<name>"
>   
> SoC/board maintainers are encouraged to migrate to using mirrored copies
> from `devicetree-rebasing/` into `dts/arch/<arch>/<vendor>` via:
>   
> CONFIG_OF_UPSTREAM=y
> CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
> 
> An example have been shown for Amlogic meson-gxbb SoC and corresponding
> derived boards via patch #7 and #8.
> 
> Devicetree bindings schema checks
> ---------------------------------
> 
> With devicetee-rebasing Git subtree, the devicetree bindings are also
> regularly synced with Linux kernel as `devicetree-rebasing/Bindings/`
> sub-directory. This allows U-Boot to run devicetree bindings schema checks
> which will bring compliance to U-Boot core/drivers regarding usage of
> devicetree.
> 
> Dependencies
> ------------
> 
> The DT schema project must be installed in order to validate the DT schema
> binding documents and validate DTS files using the DT schema. The DT schema
> project can be installed with pip:
> 
> $ pip3 install dtschema
> 
> Note that 'dtschema' installation requires 'swig' and Python development
> files installed first. On Debian/Ubuntu systems:
> 
> $ apt install swig python3-dev
> 
> Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> installed. Ensure they are in your PATH (~/.local/bin by default).
> 
> Recommended is also to install yamllint (used by dtschema when present).
> 
> Running checks
> --------------
> 
> In order to perform validation of DTB files, use the ``dtbs_check`` target:
> 
> $ make dtbs_check

I have been following your guidance here and I have also seen it to work but not 
sure why. Anyway I have strong suspicious that any Makefile rule is not right.

I am getting this issue.

/bin/sh: line 1: @: command not found
make[1]: *** [devicetree-rebasing/Bindings/Makefile:68: 
devicetree-rebasing/Bindings/processed-schema.json] Error 127
make: *** [Makefile:1181: dt_binding_check] Error 2


devicetree-rebasing/Bindings/processed-schema.json is not generated properly

I am using the latest dt schema
$ dt-validate -V
2023.12.dev6+gfb80ec43c204

and no issue to run it from Linux source code that's why I expect it is not 
issue with my PC in general.
Do you know what can be wrong?

Thanks,
Michal


