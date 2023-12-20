Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E2CC4706F
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.68])
 by mx.groups.io with SMTP id smtpd.web10.19122.1703069074914503954
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 02:44:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=dBWnsMDZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.223.68, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPSWMyKVzkitD3j3FFPCMFyJ5kAeOGM2ZSqgCoZXGvoJ5mibne3dnk34fPUNPC38LbqTqEdhQ7VqYG6miRVVfNG+BVBZGmHtCkVo/a4PYqus3PzUvCLQeofP7BOSJfp2DqpTVtQ9YDjgijM5hKjmQnAb+9O1wb84ZIX7wCLrlNXUsT2Rx/5Jn7W7Dul+3pIe629wOzbMvnrNPoJSvdYaWBaCG1a/psosu6kiFlsORuZCtpNNqhhzmQgoEmgUpGR10wiu5ucR1hbY2Z2985uC7epj1r+VVubgzN4jT6SjAV4HE5xTjwhA05CDBHf6oWMikTy0x6CV4F+nz9UvHyzPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m5uw6XTpoCaXpGQYKn74ILivjMsgPfBa5fNTkb/1P4=;
 b=kzJcBG6x18gn7aVhJVb1gfUEMBVYNH6IgMT5/YfHWBB25VsYxBLKLWRFEeifpcyw8zZ1cwOvWDTeBTnyVhOyGKQjzuWY0G95VKLauRLOfgKz8LrXxP00nUeEOlmUXYnSvaFFSeNh9XB6o34omRloIuDtuO8KwZLjoIFwb2MneLHsjEGfb3UNmWLitMLhvtmehIpEKUwOpOO6xetbwopji7sZu8L9/1vyUzBQ1gyOjdAV50NvkbmSsK+p8K4/hjdCASItekkank0FnkMZPVcctQl2F/LzjN8OfWlIUJXuajnoV0tO9DliNjUkZx4IxMZFMfDicSL6YCHGRcyr2aHt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m5uw6XTpoCaXpGQYKn74ILivjMsgPfBa5fNTkb/1P4=;
 b=dBWnsMDZNtqKsBzW44oUGlI2anFnO3hJs9djYyQ+RnE/dm1MB+1s5/PoLDpIzGb0BdKl0ldRo3BHe659OjUu6mgkOH8oOIq4AaE1tJROBHJl9/oZyTWOiIpyx0CRUY3x1oCkf9b9FJw4q2NgXpu46V4/SmEqrX3dXdoInQCZgYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:44:32 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 10:44:32 +0000
Message-ID: <9d01918f-a27b-4f52-87d3-674c52547d57@amd.com>
Date: Wed, 20 Dec 2023 11:44:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
X-ClientProxiedBy: VI1PR02CA0063.eurprd02.prod.outlook.com
 (2603:10a6:802:14::34) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: b7356b89-efce-41f3-4bc8-08dc0148a62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ftJ0NmXOW5KsSANNXErY9tYYrXJ7TtLiiMFvoJrG29XKhuVsLWtr5EObi047Z9EFitRgtLZCa3TkUIJDSpagNk+JJ8Xm+IPXxRk9u1CDSDLNDHCds+kR86P9dB5sF+mWnLv97knlBqi3iw7oAdFSXzHIsr8IIzNlon+ej696UqLe333pTOXUPrOf/FV9LbUvNgCy8Je0vqbA2fEaFckAq7PVtxamRfz+5kZ3S3FKwvTfHDDRU4e8ghXhYuGTuI9XAvSG2Aeqeonwx0TLPOd6YEyT+vDOxJJMY9UjJSNNALPZLm8bseR62G49ySxlpXnWOeJH92ECOyFbui7dhW4SaN5J8kbdxoM9i2bc5ljieS7QqB2ERz6aWjbvIEI1ygorxElfXO/3/iN7y58o0/pyrlMF5H9qhre1jeIohNgSrUEvjueHJlwsau88o1lT4ULU0TVm3zVt6d2LbC0hI0hIv2bcNQZXfR5laq0jhAfQ9y5KEOW9hpWSIY89vb3Ky+PDw63i4kKdp4LrbsWQqtpPbpa7OZnSzWpmoxfndGueejTSUelCfc3Z2IAAlqBqTsLOFT8MOaXX/CPNY7s9X7wnWOeYgV5BsFflFrfdr/QYmmOIfV798ecqrKxSZYm3K4U/uWCw45zywok/e81zfNIrLis64gCZGAD+J3Oq5LQ75o9wQ/oyg1vWfXGxQa7RHD+u
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(86362001)(31696002)(36756003)(66476007)(6512007)(6506007)(53546011)(66946007)(6486002)(66556008)(6666004)(5660300002)(38100700002)(316002)(2616005)(8936002)(83380400001)(41300700001)(8676002)(966005)(478600001)(2906002)(7416002)(44832011)(4326008)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1FqTWkxcE12RW0veWkwM1NtZlBBcUtvMlp2bzhWSGVhaWU5OXJWTlpBRjZW?=
 =?utf-8?B?bmZXREhzb29GZHoyekxQSXVjRXhDN2oxY2lNTjZ3MzBvekIvZDQ0anUwUmY1?=
 =?utf-8?B?a1ExN0NnT1prVjBxYVA2YmxSODcwV01kcEF6RlVIdkZmYitUbW9ZQVpEN3dX?=
 =?utf-8?B?Mzdlb3JZTHZ5Z29MdS84VGU1cFpUV0FPamdleU5YV0VnYW1jcnBrU3VEZFlk?=
 =?utf-8?B?NGZzdXprbElQTXNNQmZzQ1NtcVNuSjJXMWM4WkZvUXp3Qm52dFhrMzhuR0RU?=
 =?utf-8?B?NDhOWTYrYi9KbEpJTEsrOXNVN0VQUWVHdG5MOVQveHJYR3pPS1dGTm9pYTZu?=
 =?utf-8?B?SHNrN0l2WmZEZXNwdlZ0Y1Y3WDJDZlN6bmlYdHdMMmMwNEpndVUzUURiS0lm?=
 =?utf-8?B?eWhEMmhDeGJZWVZadDQwTlpqNDROb01QWXpFNHJqQlFxbUMvZjZFNVdXeDJx?=
 =?utf-8?B?a0V1TkxLZEpRYSt4d3FOWE5JeHZlcDh2M0U5N3p0QkdjY0pnWEsxQ0hFUXUr?=
 =?utf-8?B?eWZUZlVNSGQ5RFBDSCtXMHdOOXZrSGFlZVZ0cHBueVFjdjdlVnJGMzdZdDd6?=
 =?utf-8?B?MzJJUGpFUENmdEJRQzhQRlprQ2l3TkZ0Z2dIMFlUb1R5VGRsSFhjM00zMllK?=
 =?utf-8?B?eHdUZU1TY0phblpGcVBYUlVCMmF0MGM4ZXp3UXNQRnRpUkZQYVRpNUZiMk8w?=
 =?utf-8?B?aHJFVTZDemJjaXFFWmF3ZGYxUktoVFpxME5uRCtFOU9kUjI0cmpQTnNseUJr?=
 =?utf-8?B?ZUxrSklXeGJKUzF0UWp5bUtqUTczSTIyeFNGS2M0aVZDMXRTK0U2MklaZ3dI?=
 =?utf-8?B?akFRaDBXTzEvblk1WUFkZnlaUVJWbmpoV01ocUxHd1pKb2R1cVJSWG55c3R6?=
 =?utf-8?B?Nk9vVUt5akZ3ekFWYnNUc3R0L2Fud1pSeDZURURac1RWeTJRN0JyOG51OXVQ?=
 =?utf-8?B?WFoxbVVDMEFxYlQwcWRGSnYxTzRybzJUWmF6RTBuWm9wZDk1b0RwS3BjaFl6?=
 =?utf-8?B?dkhrVEVpb3hKaGQ1dVp2TUErTG00b01keXpiMWlBeXVXVzFBUzR4NGxMcEs3?=
 =?utf-8?B?MkI2WDUwN3N4a2hvYnJ5UTMzVUN6emRja0o0cTRYRnhQUmJtckRFSEdTTU41?=
 =?utf-8?B?SUovSU1TKzhYdXdQcWJiNWdhTDZaYTNIK01iSjU4QVZySjMvYk9IY2tUMWh4?=
 =?utf-8?B?OHUvMWlwTHAxTExIRFpmOE8zN0FsaWNmM1lqNmloNEx6c1NOU2FLTkVHUHlU?=
 =?utf-8?B?WEZOTUJNbHVYUTM0L2ZRemtnVmVHL1oyTU5VYnBSazl2OUJ4cUZvUHZ2aGlD?=
 =?utf-8?B?bkgxWHJiWmltQnFCQk13Vko1b2RESUY2KzJKcUJkRyswNU5jZCtqcmJYOVdK?=
 =?utf-8?B?ZUZ3eWVTOEZMelkxaTF1ZnFlWG1GclNZVStXckgva0txRGppcHYzL2RjNmcy?=
 =?utf-8?B?RUdmcEpqUDM1ZERMalpWTk1XMzdpdkJhZ25RWDJZRVNyeENiU0c4dXArOVdQ?=
 =?utf-8?B?bUlCdjJRenFpZHd2d2VTTm4xTWRXMjhYMXJkRFN5d29HUFMyT3J6UEdBNnlY?=
 =?utf-8?B?T1lIRVduMUJiYWxMSXJFL0owemxHemN4cTZYM202TUdHdEU4T1ZxYVZoRm4v?=
 =?utf-8?B?cGpKaFF2WExhZEhvRDFpRm5xa1YvQUVBWDdxam5xMzkra1lqbzAyWmxnYzZD?=
 =?utf-8?B?S0J6dURjaU5KSWVBaDJveHo0SU1CK0ZPT09YNGphQlFwY2Q2NFE3QnVwMzFm?=
 =?utf-8?B?d3ZnNWdCVnowbWlqNkhES1hqMmFIdDRwQVVpaGhHYW1wTldRdWxBQVF5SzBY?=
 =?utf-8?B?R2VITTNLUU5HTW1UZHdTVGV2dG1iQkFBQWltLzc2dmpaaVg4WU80cUdQdmha?=
 =?utf-8?B?T3N4ZnhMR3JpRktENi9oQkdKODdWaGV2SkQ1NktKSnRxNjYrMmc2YS9hRUpL?=
 =?utf-8?B?TWpLRi9US2F0Z0FuK1FEM0xubFRhWHYzN0VxK0ViOW95NU5PcGIzQmZ0T05O?=
 =?utf-8?B?QmdJSWtjR1FEam92VWhGc3BTQ2tCQnNsQU44V2wvRFB6aEhEaEdOdGhqcm8x?=
 =?utf-8?B?a0JPRmY5Tlo5bW81M2xYdnplT2s2NzBmUk5LUURvZUxLVnltVmdhb1lidzcr?=
 =?utf-8?Q?676TlUf9zOhBfaBEvVIqxf1s7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7356b89-efce-41f3-4bc8-08dc0148a62b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:44:32.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPMO4GofBey1XujzQAMoDTyJReErJoWH9XGjk1AJU8PlD/h95ePytHFQmA0HcFcJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1954

Hi Sumit,

On 12/14/23 14:50, Sumit Garg wrote:
> Prerquisite
> -----------
> 
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-boot repo via:
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
> for U-boot SoC/platform maintainers. There has been past discussions
> about a single DT repo but that hasn't come up and Linux kernel remained
> the place where DT source files as well as bindings are placed and
> maintained.
> 
> However, Linux kernel DT maintainers proposed [2] for U-boot to rather
> use devicetree-rebasing repo [3] which is a forked copy from Linux
> kernel for DT source files as well as bindings. It is tagged at every
> Linux kernel major release or intermideate release candidates. So here I
> have tried to reuse that to bring DT bingings compliance as well as a
> standard way to maintain a regular sync of DT source files with Linux
> kernel.
> 
> In order to maintain devicetree files sync, U-boot will maintains a Git
> subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
> It will be regularly updated with every new kernel major release via
> subtree pull as follows::
> 
> $ git subtree pull --prefix devicetree-rebasing \
>        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>        <release-tag> --squash
> 
> The RFC/prototype for this series has been discussed with Linux DT
> maintainers as well as U-boot maintainers here [4]. Now we would like to
> reach out to wider U-boot community to seek feedback.
> 
> [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> [4] https://github.com/u-boot/u-boot/pull/451
> 
> Changes
> -------
> 
> Traditionally, U-boot placed copies of devicetree source files from Linux
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
> sub-directory. This allows U-boot to run devicetree bindings schema checks
> which will bring compliance to U-boot core/drivers regarding usage of
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
> 
> It is also possible to run checks with a subset of matching schema files by
> setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
> or patterns (partial match of a fixed string). Each file or pattern should
> be separated by ':'.
> 
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> $ make dtbs_check DT_SCHEMA_FILES=/gpio/
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml

Do you also plan to extend this to cover dt overlay + dt base generation and 
check it against DT schema.

Thanks,
Michal


