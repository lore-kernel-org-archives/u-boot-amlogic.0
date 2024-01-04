Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE89C47DDB
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.65])
 by mx.groups.io with SMTP id smtpd.web11.51758.1704367534050415053
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jan 2024 03:25:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=c/dMDNVU;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.65, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4H/u6wS81YlWYf8LcxI++snIlFpEFfjiSLtF/7EWQDGsFAcf90uToZc1XVUaC+Qfe3Ij6x4mPhZslzWvohqz04lMW64EjRxyl81c+5H7f+/fYJuzDRMZLHUmtE79f4lRu+0RXfQPtPY9srystX/gnOSugrobsOTI19aZ4mI3vodofE5n/opo7YOUNPEXCwNBlHt7S94fo4u5vvzCw56Ffltl38/pnV7s8M1N/dpwK/9gA9w/kVfdPrUr2zhFHfcd5fOVI3taW/cRjfE0XjFFs8uoa5YFcayEcQ2dbWgQPBs0N/9Uzeh/6cQNC8ewH5THcCQRTSXHFKRsp+9qIWNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8nJpysV7fXSOFd2scesD1ZIZgWrO5G34y2Y79GWabI=;
 b=ck04PtKFCJQTx5Bownvf9j3lmOWoygLW8jhE/mc3eehaes82blmSIbYB2k8B2fKmG7MKJ+16LQGSIF7WeHBz+fejWjMYImRFEv61ydMBRi0hY4PoJKDjgk57TtJmRfwaupt5TsXi/cAYOB4hpbDktqcMD4FLGEvQJ3XAI4A0/ZGNEjuR4O6gknkxXVSEhVQt5bsSyG7yuh+uNFI4gI7BbN6TNyMSiyufAIm78O0SRi2R/+q2g31zGN8n16doe2ooIsvcP9zjtRjS+K2kkrYZiTOpp+4EIJGVgqESALENjbwHNYl8A6CXIyIig09wHV79XkD39IcOcefuTXfgKdMrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8nJpysV7fXSOFd2scesD1ZIZgWrO5G34y2Y79GWabI=;
 b=c/dMDNVU0iLmIKBPSak+4gHu31djR47Ygh7yYXXCmiYNe99/xEepjUnPwhSscpXj7hhEbbxDxgeR0qio+WRHK+zLc7HauDq/kGNpYpzxPP9xhL14nGgGXfNSrH+Mmjyb5ISAeeGtBTW3EvdEkMOmwuC2tCoDfDaXrcH3cLKyOE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 11:25:31 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 11:25:31 +0000
Message-ID: <6989436a-aaa1-4c07-9f49-856be9a8b011@amd.com>
Date: Thu, 4 Jan 2024 12:25:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] An effort to bring DT bindings compliance within U-Boot
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <5602ebb2-25c9-4f0e-88b7-64662874d0f4@amd.com>
 <CAFA6WYNeVq9pM9Uau6bQdUMNw40-1sMHOGuYs4mfa3bX6Ob2TA@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFA6WYNeVq9pM9Uau6bQdUMNw40-1sMHOGuYs4mfa3bX6Ob2TA@mail.gmail.com>
X-ClientProxiedBy: VI1PR07CA0226.eurprd07.prod.outlook.com
 (2603:10a6:802:58::29) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 656eb45e-d529-4de6-74f2-08dc0d17dc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z1zUwhlEfKnsw0HLtwpfHCftgg7KMSzeQ6qJ0cOQn2W0XunpmJ6MulVppvj0hz8XTuv+u7EIzZta1in5fE3MS5grP6I8Y490vMekNH7eWllyUz5kVJHXL701Xx6OHVMlsPsJv3J9FQ0g/NVUnnAyLvcYYE12WMrztKjm30St7l2WsYfSiqiUplNbellKrDwaHz3kPYWVBP9TA0hlB2MJW8S1HBEQwLAXYvljPDEyx0BdoqTm45EILtgIGTSQQxDVsB3566m+izwbNzLbJTA1KlilYb/J2odOME2RJJNqAqhc2v2KVoNWbP65aszNIfrMhxcmb95Z9ig2+LYhMMhYZisRZ2/5xePR1pBcZDf4/ox0VKiilUnCa3ExjhJ1MXyAC5GJA/UNGH3DrWvcaO5tG5tinI8NLfb4WwxoZKU4pzg0/icAmY7EJ1FeSj+sotsFMfrIclS+hMGkYNaH9odrd7dBrPq3h6Htzn/Qw+SAkb+Tf5iM9JohQ0zvULkdeMLmkDonOxwhb8mxOhKbEoSvMRttoZTtDwAeTUkNZ/7eZcRiiXhqsyKk8gM7RHphzDR2FbDe/EZvDOPnd7vEDkU4+BRFVqfasotMq0p/BtOeRpA9xycnyfvCUl0crlk3lAL1zbCLBt/bN5ZHqZxkYhO5RWM0JQRElDOPINn4TA6F0/+IgDcGxCmGbpCeC5H8AF8c
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(26005)(53546011)(2616005)(6506007)(6666004)(478600001)(6512007)(6486002)(38100700002)(86362001)(31696002)(36756003)(5660300002)(2906002)(7416002)(41300700001)(83380400001)(966005)(66946007)(66556008)(66476007)(6916009)(316002)(8936002)(4326008)(8676002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0U1cmNFaXV1OHZ0WGJDNXVHQWI4NFg0dFUxLzBBbUt5NEtZaFV2WmF5K01R?=
 =?utf-8?B?dTJqdUhRTFB3VVV4VEdtRFRDbzhpUkJNMExLM0RZKzZCYVB1NmRZVndjTWhS?=
 =?utf-8?B?Yjc0YVozT3psOSs3ODk5U2tBYm05NFRIK0lFdmxKOU1IN0UyWUsyZ3FYcE1I?=
 =?utf-8?B?MzJhMzAzSVV0QlByeUlkVm13L1U5NmRqRyt5QVBDN2NLZnJPWmthcHRRQ0J4?=
 =?utf-8?B?RnFXc1UwY2ZnNnlNRlNnVXFxUXZDQXZRckhDUUtweDZZNVZFS2IrTkhVSEtG?=
 =?utf-8?B?TjlqOWw4Q0dRb1Y2VHlKZXNPcW13QzEzckw5Vi9ZZ2lmTDRDNHZndlpXc2lE?=
 =?utf-8?B?Y09CNmtwWW1YbUtiZWlUN3dTVHF4VFEvWDNva3hiNktOYkRNdk1hQjJQNWhq?=
 =?utf-8?B?VXNwZVZ3VG5CR0tSblE5SmNOZEhHSmd6U3RXVyt2OW9NSmhZL3ZpU3NYVHhr?=
 =?utf-8?B?RjA5cnU4Mm5nNDRWTVExVEZmVjlLUVVNZW5ubWUzajNITklZeUlEcVhwaUpO?=
 =?utf-8?B?NEdDODBqZCsrQXdLcWI2NDFpU2JESW5UMEc4QW40SkpwRW1PUzhQbUJZYnJQ?=
 =?utf-8?B?dHdqaTI1bGZsTStRTjNKWXk0R1dXRVQ3ekg3SzE4T1lBcTQ0RWphbmNlTFA5?=
 =?utf-8?B?NW1hVzVRRlJ5MDVNSFZYQkJPYnNUbWNQaEhNbGFxV0JMc3NnbE5zNjl5aFRP?=
 =?utf-8?B?UGJwWUovQnRLNG9HU0pBSmlEM3BGVVIrOUwzUHNsZU92TlJsY0lLZkh5WFMz?=
 =?utf-8?B?WmZ2VE1zdEtlNk45ZzEzUWhLRzFob0ZnSW1qWlRUQ3Q1S3ZBLzBER3ZZdS9m?=
 =?utf-8?B?SmpOL3VTTS83dVpnZDhMS3Zmc2Z3dkdFQWh6cjBNZ0ozcDFCSEQwenF4WGlQ?=
 =?utf-8?B?MGlTbGtJT0JzeG16aHpRS0NqVkRQdmVtUk5hR0o2OXNEejdhZTE5ZWQwaDl6?=
 =?utf-8?B?Qis3L3pvVlYxWXZmWHdkdGVHU0tjMDY4SW5NV2ltSUNOdVBneHJ2c1BvNXRt?=
 =?utf-8?B?bnRneHZrdFNqbHl0SlZmMUpnby9jVnc1MmZHdHZTbFgwUWlhSmhxZnk5WTZR?=
 =?utf-8?B?ejByQWxlTEhtZEZqQ3pnalYyTUVqY0hNWnd2dU1PSnpUTWgwQ2JIZ0x6aE84?=
 =?utf-8?B?cnB4SmJpckM3SzJmMWhQOVk2RHhveDBTWktFUi85SG1iRlljaDFtUkhadTFS?=
 =?utf-8?B?aTBCSFhnZ0dZYzk2VzJRQVFvQUFvdmFjNkF2QUk1YkFZaFM4K2taZmpWVytQ?=
 =?utf-8?B?dTRGWjhUVjJ3d3JqSnpqb3VXZ3I4cTcwbFI4WG1CYnQxajkwQU5qVi9Md3Nt?=
 =?utf-8?B?cWgrc1FZMDQ0K053UktNQ2o4SlpRakJaUi9Hd0UvR1crWXlYSUxNTVJSYlRT?=
 =?utf-8?B?UlU1ck5pZjlBZDdScFVtNUNvVmI3d0VzbVd5Qmd0RndpS2tNN014Q3VMdkJk?=
 =?utf-8?B?VG9zaisxRDc0RXBRWFNQeElkZlM2enRmTTBZK3dTVENLbHhjTlUwVjl3aHIz?=
 =?utf-8?B?ZDdSREl1THpJb3RnTjd3MUJjQ1g5c3VCSFgveHpQenFZckZWaFhrWStPcG5l?=
 =?utf-8?B?a0N5QnlkMWZFT09JWXZDQWtwUkM1VzFRRWZyUEhHUFZhTHhUbUZkNmo5M05K?=
 =?utf-8?B?L05Xa2NXbzBvM0tDelVBL21mVDUyZndhbEZ2Szd6OU1SVkxsSWorWVZMc24r?=
 =?utf-8?B?VVdFUEVkakVFR1RwWHlDWVI4blF5czdlV1UwenlGZWdwS0hBM3dOVk1vWVBT?=
 =?utf-8?B?dWpWY0hpQmJGMHppS251NEZaeXdDb2dOWjNtSDdockxEWHQxTUxqMWtCdTRn?=
 =?utf-8?B?T2dqZnRUMTBhRnZGc3czSjh6bFptelpINy9xQnZEdXVIZjlObTUxQWhKVHhK?=
 =?utf-8?B?ZzdOY1ZlRi9OUE9WYnI3T21TMi9ubFdUdlAzY05Hem5oOGxjUnEzanRkR24z?=
 =?utf-8?B?b1hybXVKeXo0S1J3SVZvbzRGaVRFY0x4N2pvalFxREdLQ1lWbUhiRGVwdDZE?=
 =?utf-8?B?VWNDUVRYY0NrRnNaa3V4QXQzNHJ2RnBadGhBOE1IYmpYS0E1bHZIcnpiejIy?=
 =?utf-8?B?UDA1T1B1bFQyMGhLWjdxREtoWS83YkhPOXE3SldnMG13RlhCbk1tM3g3YldO?=
 =?utf-8?Q?J1yDJoRyOw7KMBMQqw0LNjQNJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656eb45e-d529-4de6-74f2-08dc0d17dc84
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:25:31.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZLsngqksbvRHgD6C8CuRsxMFN+ZcIvyKyWGpMaFv0+mQT/KpZI3eQB8K+9f2h31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2036

Hi,

On 1/4/24 09:18, Sumit Garg wrote:
> Hi Michal,
> 
> On Wed, 3 Jan 2024 at 18:24, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 12/28/23 12:57, Sumit Garg wrote:
>>> Changes in v3:
>>> --------------
>>> - Patch #4: Minor commit message update
>>> - Patch #5: Replace CONFIG_* with Kconfig options
>>> - Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
>>>     instead.
>>> - Patch #1, #3, #6 and #8: Picked up review tags
>>>
>>> Changes in v2:
>>> --------------
>>> - Patch #1: excluded gitab CI config check and added commit description.
>>> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
>>> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
>>> - Patch #5: s/U-boot/U-Boot/
>>> - Patch #6 and #7: Picked up review tags
>>>
>>> Prerequisite
>>> ------------
>>>
>>> This patch series requires devicetree-rebasing git repo to be added as a
>>> subtree to the main U-Boot repo via:
>>>
>>> $ git subtree add --prefix devicetree-rebasing \
>>>         git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>>         v6.6-dts --squash
>>>
>>> Background
>>> ----------
>>>
>>> This effort started while I was reviewing patch series corresponding to
>>> Qcom platforms [1] which was about to import modified devicetree source
>>> files from Linux kernel. I suppose keeping devicetree files sync with
>>> Linux kernel without any DT bindings schema validation has been a pain
>>> for U-Boot SoC/platform maintainers. There has been past discussions
>>> about a single DT repo but that hasn't come up and Linux kernel remained
>>> the place where DT source files as well as bindings are placed and
>>> maintained.
>>>
>>> However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
>>> use devicetree-rebasing repo [3] which is a forked copy from Linux
>>> kernel for DT source files as well as bindings. It is tagged at every
>>> Linux kernel major release or intermideate release candidates. So here I
>>> have tried to reuse that to bring DT bingings compliance as well as a
>>> standard way to maintain a regular sync of DT source files with Linux
>>> kernel.
>>>
>>> In order to maintain devicetree files sync, U-Boot will maintains a Git
>>> subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
>>> It will be regularly updated with every new kernel major release via
>>> subtree pull as follows:
>>>
>>> $ git subtree pull --prefix devicetree-rebasing \
>>>         git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>>         <release-tag> --squash
>>>
>>> The RFC/prototype for this series has been discussed with Linux DT
>>> maintainers as well as U-Boot maintainers here [4]. Now we would like to
>>> reach out to wider U-Boot community to seek feedback.
>>>
>>> [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
>>> [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
>>> [4] https://github.com/u-boot/u-boot/pull/451
>>>
>>> Changes
>>> -------
>>>
>>> Traditionally, U-Boot placed copies of devicetree source files from Linux
>>> kernel into `arch/<arch>/dts/<name>.dts`, which can be selected via:
>>>
>>> CONFIG_DEFAULT_DEVICE_TREE "<name>"
>>>
>>> SoC/board maintainers are encouraged to migrate to using mirrored copies
>>> from `devicetree-rebasing/` into `dts/arch/<arch>/<vendor>` via:
>>>
>>> CONFIG_OF_UPSTREAM=y
>>> CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
>>>
>>> An example have been shown for Amlogic meson-gxbb SoC and corresponding
>>> derived boards via patch #7 and #8.
>>>
>>> Devicetree bindings schema checks
>>> ---------------------------------
>>>
>>> With devicetee-rebasing Git subtree, the devicetree bindings are also
>>> regularly synced with Linux kernel as `devicetree-rebasing/Bindings/`
>>> sub-directory. This allows U-Boot to run devicetree bindings schema checks
>>> which will bring compliance to U-Boot core/drivers regarding usage of
>>> devicetree.
>>>
>>> Dependencies
>>> ------------
>>>
>>> The DT schema project must be installed in order to validate the DT schema
>>> binding documents and validate DTS files using the DT schema. The DT schema
>>> project can be installed with pip:
>>>
>>> $ pip3 install dtschema
>>>
>>> Note that 'dtschema' installation requires 'swig' and Python development
>>> files installed first. On Debian/Ubuntu systems:
>>>
>>> $ apt install swig python3-dev
>>>
>>> Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
>>> installed. Ensure they are in your PATH (~/.local/bin by default).
>>>
>>> Recommended is also to install yamllint (used by dtschema when present).
>>>
>>> Running checks
>>> --------------
>>>
>>> In order to perform validation of DTB files, use the ``dtbs_check`` target:
>>>
>>> $ make dtbs_check
>>
>> I have been following your guidance here and I have also seen it to work but not
>> sure why. Anyway I have strong suspicious that any Makefile rule is not right.
>>
> 
> Thanks for taking time to test DT schema checks. It looks like your
> suspicion is correct.
> 
>> I am getting this issue.
>>
>> /bin/sh: line 1: @: command not found
>> make[1]: *** [devicetree-rebasing/Bindings/Makefile:68:
>> devicetree-rebasing/Bindings/processed-schema.json] Error 127
>> make: *** [Makefile:1181: dt_binding_check] Error 2
>>
> 
> I was able to reproduce this issue once I installed yamllint on my
> Ubuntu machine.
> 
>>
>> devicetree-rebasing/Bindings/processed-schema.json is not generated properly
>>
>> I am using the latest dt schema
>> $ dt-validate -V
>> 2023.12.dev6+gfb80ec43c204
>>
>> and no issue to run it from Linux source code that's why I expect it is not
>> issue with my PC in general.
>> Do you know what can be wrong?
> 
> The issue here is basically due to old U-Boot Kbuild infrastructure
> which isn't in sync with Linux kernel. This Kbuild commit [1] changes
> aren't present in U-Boot leading to this issue.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a2429e1faf40b2aaa481aa4b001a74d222c7e8b
> 
> Following change to adapt bindings Makefile to old U-Boot Kbuild
> expectation should resolve this issue:
> 
> diff --git a/devicetree-rebasing/Bindings/Makefile
> b/devicetree-rebasing/Bindings/Makefile
> index 8b395893bd8..7d08372691c 100644
> --- a/devicetree-rebasing/Bindings/Makefile
> +++ b/devicetree-rebasing/Bindings/Makefile
> @@ -47,9 +47,9 @@ quiet_cmd_mk_schema = SCHEMA  $@
>                        rm -f $$f
> 
>   define rule_chkdt
> -       $(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
> -       $(call cmd,chk_bindings)
> -       $(call cmd,mk_schema)
> +       $(if $(DT_SCHEMA_LINT),$(call echo-cmd,yamllint) $(cmd_yamllint),); \
> +       $(call echo-cmd,chk_bindings) $(cmd_chk_bindings); \
> +       $(call echo-cmd,mk_schema) $(cmd_mk_schema)
>   endef
> 
>   DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
> 
> If this works for you then I will include it as a separate patch for v4.

yes that works.

Thanks,
Michal


