Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E511DC4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 09:02:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.64])
 by mx.groups.io with SMTP id smtpd.web11.6005.1713333764993057681
 for <u-boot-amlogic@groups.io>;
 Tue, 16 Apr 2024 23:02:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=jnsuQdnC;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.64, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2mnsJZ9wOhyhMnOiP7BegKhEc9lDQIY8HwJKCxd0B65PsXQ359343+8kUAUkRGOZN0E0Y0BH/37z5/vkrOprBlo2qZbUfxTMXPD1xP7Vw0aYWcqKlcbU5qkREFNTleAxUuWryDHXaVp8n9IgvMvy87lx0KGOfbR+apv7ODRFgQdriumZC4GBdBxtSjoz5uku82RTdFUTqdbXKn1WT8nhpt4Fr1VfiL8wXM+l5ZpXfcE+M7vPeT3GQwmtAWlhig5I1r9pATaFKxG0/3SN0jmpLcLFh4xBjWwj8Kfxx5X1lv9MnkxTd+p25a0P0JPRBT3HgMhP+5LooVrfEOXvrNQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=550iGHWzR0/Fb+lrltbCktr9L/p3ZZuLExtWFg4DxKs=;
 b=YNHZ2NwsyLv7TLv0ZxDFQMgJek0lu+Z/G45gXL/I6rCI+DS/bvMOVscBVmHDVfJROiQQbYGVbU2ORt5ZZqI5iBRQprMFjSyRhu0fwdxY0KPupzUGg4ABOuo5SpRkhzLC/zUq7w0B3yVHCyGKsHmM5xmulnpzw4Zp/aK/4aFTBQ2pZE3qHq6tFxMOHQBnv8NDU9SdLVvHXMAHVI6W0CBitupEgF5xQ8LVfG20JvW5g0z4+U8JmtM675Nd3vK/iCcDuxOJ1T9lopvtwzPHBbQwecsRT9S6NtxqoIU6FzfpQdF84L/UEITtkDQjMVMIDdeVzJwpqIDDd2GsSlcU2j12pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=550iGHWzR0/Fb+lrltbCktr9L/p3ZZuLExtWFg4DxKs=;
 b=jnsuQdnCpHmDllmsIX/J7l558h5HDytt84qWdxKdg4Yldg3cO3giRd3PvBh0mtTjosD6e3nZ7pjtVxXvILgemmUpcff1mmEHxH7uph6Q/DefY3s/TB00kFF3dwYr6hmaZeY+ufeGpCdOvZnZfbf+z4OtOAZkALZV3izcVQH9XWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:02:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 06:02:42 +0000
Message-ID: <9444bfd8-e441-429c-9d41-b94029288a1e@amd.com>
Date: Wed, 17 Apr 2024 08:01:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] common: Convert *.c/h from UTF-8 to ASCII enconfing
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Aaron Williams <awilliams@marvell.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anastasiia Lukianenko <vicooodin@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Doug Zobel <douglas.zobel@climate.com>, Enrico Leto
 <enrico.leto@siemens.com>, Fabio Estevam <festevam@gmail.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Grzegorz Szymaszek <gszymaszek@short.pl>, Heiko Schocher <hs@denx.de>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 =?UTF-8?Q?Pawe=C5=82_Jarosz?= <paweljarosz3691@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Philip Oberfichtner <pro@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Viacheslav Bocharov <adeep@lexina.in>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "open list:VIM3" <u-boot-amlogic@groups.io>,
 "moderated list:ST BOARDS" <uboot-stm32@st-md-mailman.stormreply.com>
References: <cover.1713250508.git.michal.simek@amd.com>
 <abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
 <20240416160631.GO1054907@bill-the-cat>
 <58f122b7-e9b4-4028-941a-0f1b647ffe4e@gmx.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <58f122b7-e9b4-4028-941a-0f1b647ffe4e@gmx.de>
X-ClientProxiedBy: VI1PR07CA0244.eurprd07.prod.outlook.com
 (2603:10a6:802:58::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 28aedb1b-ffc8-481f-8078-08dc5ea3feaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n1Yyz6KC7A9cUwgEXbXs3caWT/WWJPxNIIeHRzhNsvOsm5yduprHfewHUqbhNFFxgaMNNMCZ8rLxj2Q1u0sxJTNJjkJM9TCPdh1l4HupTNNZddk0uGO42SdN8d7UHbQ1lz79GN0Du/aNE/1+BHC4NWOptnUgevCeqS+LtzS/CoKjtCOZSUYihLxfhGGle9c0EkjqeeJsCZlaCRPmuvvOqzUNqqTo1jBfrvoAPxZ/Qp77yzwKrqVpNAb8uOwnAD3v3Zc+MO6h6zuL5qCjS933jBUalXjRO6kP12zYX033J6hmxHM1GbQX6kAVRlWFrbMjfj0bMYEOb+zneztQmehXnkrggLbwO1pi75swKIWd/dnSZrKdV1CsYD4thVuUyCINz7EY8Mq2oRYLhxpVQtoHb2Vg5/I5Cp77PiYcUvgPCFLIo52qZ1NQweO1uNCOhotnlEd/qBLhVN8XdamLgHdDmD69Y8XCwErpALtHbktTWmTNUr+PCx/teGBRPPNUgSBjuK/9ovT0IA32PUsUlYkBFooob7HHomZlQGhuQ/FpJHsdHJ0TIQFatjICEfApykdeH+6xgyXA8YkSDGyKsnnRfJBanMGHcKMmKotYylSoSuHZh5+mFpYtxMqoCObLHEpLaOUkfQ1lqwhZHgob6LLARKZdrFuhxeGyXVjKTnht47I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KMk6a7MNa8hr/xKj/YT3je4bu3RAu3Gj36eHIyRl4vdABUMpzKk1rEo8c5CV?=
 =?us-ascii?Q?5kpW3N2E6SRkSzyTgaImP7NFgb6Gr6Fbt1KZovJ5MorlyBpPGIIB+xKFbQJ0?=
 =?us-ascii?Q?NzCW6eJfSqM9bVmmVFybYFdje0Rf5Dy34wohL4up/2FqNfG0YKu9xOEpakuB?=
 =?us-ascii?Q?kDjJRHV3S8wBjYXO26lTEKUoqsv8Vyn/roQoJ18AOu/yZLnjXGQ/bwKEnSrj?=
 =?us-ascii?Q?Or4ookzSFz6OGIc+ORcYhBotIxoWYg1gvE+sFQlXhq2V+BGjUj2T/ZUq9itk?=
 =?us-ascii?Q?5VZJojIx3ni3DvuKYzLsKrRhqJc+YlUjPWavek+Cvnmi0DvyGISsXbcs48ba?=
 =?us-ascii?Q?SeAa/BRJoj94SlCQ9h8pg0jtYOehoqlGfU+tSYSz7bbZ/pORSUg2na7NRV8A?=
 =?us-ascii?Q?RCNAyyHmblCGKqqFUSlV+2ta0JnuR2Bn/n1ibxPdAW0HMLedqm0hgxgKbuXh?=
 =?us-ascii?Q?4ECgo4P5RIE9FIM8J8WnvDTW162ib9KmYVNT/ligoDZ//Xc2/Udt17mVke2l?=
 =?us-ascii?Q?JL6L5CPUqaAqYg1w+MzG6Ayy5PoL2xqCOoT3riVEH/eIuvH+OpKUHyEBzo39?=
 =?us-ascii?Q?+zRRSNE1YcGVJNlidBrWvUvloulk5hOnja1r7VVD/qI9WcXwObyOOJkYKZu4?=
 =?us-ascii?Q?N3/pMYla15Qasv8vLlLa7z5Z+0twFyqgbUhLGsfhukDJUItXn3DvYWdE2ltT?=
 =?us-ascii?Q?3uhSJre0tFJjA51d5GQoiELHs6F4kpL0pV2kSWE63UeyUUrGyvcwDK6rMX+Z?=
 =?us-ascii?Q?3oN28lNJwYp+q1YdxLwOsXy/0mztUH/O7Y6tbBm/ETdHOjvf44TsvjdIcd+P?=
 =?us-ascii?Q?lpKzUknGEHA5Shf0+lnzI9g68xldyALHyXI7LjzdEQq+Qns1ygZvz2+s7YgC?=
 =?us-ascii?Q?3ExBqDvyc+UO8edrEmQV9R48tcxIa3Aq5kE2x0ndp4HiZMp1pZ+N8vuCAcpE?=
 =?us-ascii?Q?4MsV/+UqI0JbsmHnSDU0WHGo2etAsIIOYc9UB8u2neWDy+1LdvGgyaK2FSB9?=
 =?us-ascii?Q?skI2+DF7sJSBOe3LM/44HmehNHZ3cz63NiM+RbLIMVNyQh3A0eSggbTDrdX9?=
 =?us-ascii?Q?pMrElNLTAu8iOLdZaB2sZKdu/eQOJ3LHM51n6EfVWlztDJxILGx02uXkPFeM?=
 =?us-ascii?Q?5Mei9DEzGSSVsw80nZRnYgqumwgauMg6tTxLSTMQ1Z2nPOJHOsB6lx5IHIAR?=
 =?us-ascii?Q?TuCSz84VPePyY2XjOH/YIsqT8/KNlqXu0GOQv01TWrx6q746WpaOTXInP8vh?=
 =?us-ascii?Q?MCRv2HTKYXhItNkWXe6Ciqxvy+geAHe0lDVv0L0q4Fw+/A6Xbt7ASS9nCY5S?=
 =?us-ascii?Q?f6IupKlWjhYJUrk33YKgNZ4DL2X8FPZzboqghsTHcyKnPPMjOGLR9bHF7cgy?=
 =?us-ascii?Q?AgWgd32XrfrNQWT0fE5yhkDjUZNTzwUVi6VV/6Ngp3W3gwEb5rOG/79Ak/yl?=
 =?us-ascii?Q?hr/0HJ0v0O6xgMMTiGb+3h4pjjr/i72bgfW0XVtF3En2auXxPrTs3FULH6cQ?=
 =?us-ascii?Q?VUyBXpZUKXfwVTnHXfAhx4xGzeUMFzdLLds1efRjI1RR3MXYOeA7VOr3WGkW?=
 =?us-ascii?Q?4fGm10XuUviDXUe1QDhAfFm6YuIlQdVHMdOvVi5J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aedb1b-ffc8-481f-8078-08dc5ea3feaa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 06:02:42.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NZt5H1q4VOrFYTXdjcMIP+5BS/6CDFByyngtTGPgc54De1D2VwBsJfIMT0Xzrpm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 22 Apr 2024 09:02:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2276



On 4/16/24 18:19, Heinrich Schuchardt wrote:
> On 16.04.24 18:06, Tom Rini wrote:
>> On Tue, Apr 16, 2024 at 08:55:19AM +0200, Michal Simek wrote:
>>
>>> Convert UTF-8 chars to ASCII in cases where make sense. No Copyright or
>>> names are converted.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>
>>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>
>> Now, how did you test / find these? Given names a CI test is unlikely
>> to be doable but if it's otherwise scriptable I can put it in my loops
>> and just fixup as needed (like I do today for adding <common.h> for
>> example).
>>
>=20
> There seem no to be too many non-ASCI strings outside of comments.
> Should we care about non-ASCII comments?
>=20
> $ find . -name '*.h' -exec grep -P -Hn "[^\x00-\x7F]" {} \; | grep -v
> ':\s*[\/\*']
> ./include/configs/tec-ng.h:13:#define CFG_TEGRA_BOARD_STRING=C2=A0=C2=A0=
=C2=A0 "Avionic
> Design Tamonten=E2=84=A2 NG Evaluation Carrier"
> ./arch/mips/mach-octeon/include/mach/cvmx-pko3.h:369:=C2=A0=C2=A0 MEMALG_=
SUB =3D 9,
>  =C2=A0=C2=A0=C2=A0=C2=A0 /* mem =3D mem =E2=80=93 PKO_SEND_MEM_S[OFFSET]=
 */
>=20
> $ find . -name '*.c' -exec grep -P -Hn "[^\x00-\x7F]" {} \; | grep -v
> ':\s*[\/\*']
> ./drivers/mtd/nand/raw/nand_ids.c:65:=C2=A0=C2=A0 {"H27QCG8T2E5R=E2=80=90=
BCF 64G 3.3V 8-bit",
> ./drivers/video/dw_mipi_dsi.c:861:MODULE_AUTHOR("Yannick Fertr=C3=A9
> <yannick.fertre@st.com>");
> ./board/bosch/acc/acc.c:440:=C2=A0=C2=A0=C2=A0 .SRT =3D 0, // Set to 1 fo=
r temperatures
> above 85=C2=B0C
> ./cmd/2048.c:65:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("=C2=A0=C2=A0=
 =C2=B7=C2=A0=C2=A0 ");
> ./cmd/2048.c:79:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=86=90, =E2=86=91, =E2=86=92, =E2=
=86=93 or q=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \n");

I actually use more force way and simply run uni2ascii -B < file to all fil=
es=20
and then look at git diff and pick what it is valid.
Above find is not able to find all that strings.

For example this one could be also fixed which above filter it not able to =
find.

--- a/include/mtd/ubi-user.h
+++ b/include/mtd/ubi-user.h
@@ -1,8 +1,8 @@
  /* SPDX-License-Identifier: GPL-2.0+ */
  /*
- * Copyright =C2=A9 International Business Machines Corp., 2006
+ * Copyright (c) International Business Machines Corp., 2006

M


