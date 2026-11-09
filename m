Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8170.1794236963615615921
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2026 07:09:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=B827z4ZI;
 spf=pass (domain: cherry.de, ip: 52.101.84.15, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijkEpaDTUsGtsLnVvLceoZup6iWwXsZLiav+1ZZ15AEwivw9WNryNr2CY7f6+Mq7yoGLuowZe6y5CIJwGuEcLSq0gv43+9WI6PKyyNqmTTpU/NlMU+jnWGyBuLinQ9E4+o5g1XqSRLfJ7Q5zqcGxGfGUtXXHioN7msaP0ejZj/pdoRsqn81McXwctdm0nO0rewg1EhVb3/R+8ECfU5alNnez08IOwQ9k7lN2XmXMuYwtJKmN2i8fzp4o8gsHg52mPsT1IRqmO7U1VTeCUbJ0oAECzwrd/1V4EQIq9mCcIqcaS88VlSqEj8YP1XKfDrONR/cqNSe/YDR6Xek3i+KXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBaS+hAduFaBAwicnrFmt1Tnk0ChBUcglLiMklu4RX0=;
 b=CCYO4rjdAC6lo34NDK6YER1ie7iRl8aLU6nEk4/biIayICAP2TG99fSqWNdeCmUtaE18hXCnL6E5RhymSYvsVKz+i/0riUWBgriGmXN+6j6CNlaQAoifbpk/OOqiHvFPkl9WQDa/d0lYx6UBq+KEoswvLkAoaJT0KmuM9tFRkjKHseX4T/AcZvsd3Z6eNyJIaj3ILMXpxdvNmSPoZAzDeoZu1cJP3nklFRluwfL3o382riUOvzmOfnlH/oLrbwCH+aU35ke1hv4G0x8NO7znueQp/VCfbM/0izoCnUjxwVsFwlMzYIPL8RQ6ZJCDxrDA9FW5Yhqv9192LxWB+1/ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBaS+hAduFaBAwicnrFmt1Tnk0ChBUcglLiMklu4RX0=;
 b=B827z4ZIBrgTPSYtAvI+RnwEFuR1MUZzePJ3ShLTJ43kfY2xdF39jY3t5SJx85iyYCKmRDVpxbZopQ9bR26Fc2dyeLU6kdJo0+JDcBFxBDhbxQVTZpSDMHz3AHPECLXV5DBtscNpwc3LYvozuATq+Gc+wPom6ZaqNhhA4Arv9IA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:53:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 14:53:58 +0000
Message-ID: <a6f38e2b-9af6-4457-9704-8d2355f173dc@cherry.de>
Date: Mon, 9 Nov 2026 15:53:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 19/45] doc: develop/coccinelle: update links
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <foss+uboot@0leil.net>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-19-ee7573fe3a4a@cherry.de>
 <96de4f8c-f686-4e93-8dc0-babe27adcad3@gmx.de>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <96de4f8c-f686-4e93-8dc0-babe27adcad3@gmx.de>
X-ClientProxiedBy: VI1PR06CA0171.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::28) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 34821c9f-2923-4e2f-0f31-08df3e714890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261028144727099003|261026135527099003|261102123227099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|56012099006|261021135927099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261026140227099003|261026130827099003|261026121527099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: P2WezTW+5imX2HLmvG8Q1sb8KfH3beZXgNBBxuvaguc4gjbz6m6sbHAY13udHb/gB3mwPwgxWGDpRkvhReSbgcHCipH/hMjzI5gSWxk8muOgMiWfSLN6LYAfgfU3MEcWqsYmzcsTzcmm/d/hzkbWUjCeAsvjiaYkb81SQmxJBrulKaFh+yJwkQEG3oORUzcAXp+YGWc2RnbLtIaBWaKBfk3nFcTfCi9c/jZhZj4ErYKwCKuQDk/2wjq7wRhxD+usVUvBDutLdM6/aHCfDHY4gKwDVtXJbdIHiICeTQBpv3S7MEjR/Zyd/iwqPT5Hq5jbaNGt7GC+rCoD73Z2s6zy4gsgS1njrhLUv5opIm6HoyvNE7RC7n31HrjXDuUrHxb2qkE7x+95vMPUZ4UYJxmVOVI+AWlFDY9/dq/Cb+rv4dfqnWpfIE6e6xT9gGSYA1a4XHhq7EWV/icKEQjALbiqBMxVxS3586bXc8PmlDhmEnGL1YkSyOXCXkzEVKoW+sm7wcfrUdZ2nW7mirtaABoTmtIzjSfKPAm7QTFtacObvG+y89Oip8ZH0MrZ/PZUzNynHTM6BNu7O1rpjzqaX2+7Cap11pdRh3AEbcrFJLDoQaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261026135527099003)(261102123227099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(56012099006)(261021135927099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261026140227099003)(261026130827099003)(261026121527099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(261009221227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+lEsoerZ5erEBWUv5sW58+RVCH2QLOhjG9Dq8Wd4ed2qVXjjSwqRmUc1E5v9?=
 =?us-ascii?Q?HnT0riXQujwQ3Wx+w+7MKGty7DYGQ7FgKXKAvrkS9aoqfKcp/2fu8RNQf9vs?=
 =?us-ascii?Q?jp1A0cfeEYvdik24EahGRVKVn1LsAgzSdKavKNxWZwJEA8Zx6v9P0Az75ozu?=
 =?us-ascii?Q?ryImCEL8yfLJcCdrV6BEQZaRWjVd7r+l1J7LvWGHZ5GPrfFIVUUOz7/Vxkjd?=
 =?us-ascii?Q?ukqyyUrLAIHf5AWknyqdM3PtpM8HIEeum+A7oxTSxpMd8vElywmSuwQC2Tt4?=
 =?us-ascii?Q?yx7NnzT9qmfy+Z0RVgTnchCjY/fVIz9Isjj9f/S+Slgs6VsJJxjVw7qCYvjZ?=
 =?us-ascii?Q?4YN33WiBattPcSmQq4hL6kRQnhT7MJj+7IgajwNkXrZ2wf5OFX8JRVR71syW?=
 =?us-ascii?Q?1vVfWSPp95YZYow7A6E0BKGn7Xsfqw/RobT1zR1PXtqzrK/NQM5h1fOKAdef?=
 =?us-ascii?Q?rXg4CDLrqayY9moPPh5x39yo6+biAqRtMvM3Kd7DfYbwUu8skkSmDQOjyoyJ?=
 =?us-ascii?Q?UskS4frRdPGyfnqSzJZ+j2nOmLthppBmcK2VMnaDpfFb40f4NTR/BnpnskKA?=
 =?us-ascii?Q?V6c4ZuxJOWoMPRn02xsilbOy+hVGhT9YkC3mquGr9r7mQmrE3CEwz1ArLBqd?=
 =?us-ascii?Q?L+1rhCDa96UGh0KxnA8Smrga00+2xVdAQJmPpQWv48xQ1dOlzLyQhYQ7F04M?=
 =?us-ascii?Q?r6yeyYMzQT6goSqWIahL37GEOFtj78zn1lvnGY43jaoztcW3BezWNCcQpuAN?=
 =?us-ascii?Q?EPGlIWP6iY9cyesbohFWMwqNFpTSNUqL+HmaY5PDV8u+L+JHQcUIwa9SEjR4?=
 =?us-ascii?Q?vHjeBAteWfE6PFEOs3IEOnLEJJba6LiiUWxBs18qOV68LbhuX+hFvxTA/s4n?=
 =?us-ascii?Q?ZZgp+s4NKZB5DKO/bYAQrqEP/I8H6VRAUOJB4wh1hlfPWknTN9o+xwc9eqEW?=
 =?us-ascii?Q?uGipQJcKYxsmgfU0jRv8KcRWBnUjZi2qcUAAg43+rUjazfvFQiHr8HLgtKdd?=
 =?us-ascii?Q?8+IKjKSJ+Vd+IXkHiNgb9R6RwNb+GGsEjoKAj8Pp646pmW1iiR9z8kzYgq27?=
 =?us-ascii?Q?HUzmUswXC0p3vHXu0zJM99bnimI7VcJqip8jl6CZKImxzSaTHDyZfJ6faQEp?=
 =?us-ascii?Q?OPxQ18atdBgP7GK5ym3Iab9pGNGeyqk371Ea18XG78e19jUmwyUGCn6ovtHx?=
 =?us-ascii?Q?XUrnwBL49lPuPlSNKk6Alg547pjHYEQbEO79FP+cCYetiSOmls3wq/48P8CM?=
 =?us-ascii?Q?dujzP70QDbep/JJZCnORF930UyjUn+jlprC+UoX9Ae+NPrjxA89onZGblXr5?=
 =?us-ascii?Q?EiaU2e3AM1etkLFhbvVdhmHKZKHkFDbVMCi6copRk5sD0HFiMBJl2Jq/lWUN?=
 =?us-ascii?Q?afPWQN/6ccHJ3+KZfrMCkUjJdXJI6W2BcLsj02u0xzh0MuAgo05Acotp399l?=
 =?us-ascii?Q?STVgQnjIpQ2lDq28eSjK602NK3W4uszGXMotvs9PvFFIQTemndv0fzgS+6+B?=
 =?us-ascii?Q?A78D+F8GA8eVLxGFLgPht6Y8gRB1bc2qAdh0D8LeCqgzvq43RU0a6I1s1OUY?=
 =?us-ascii?Q?FzD7mgBU9hd92cfQfJ/3g/uBDBWtEOsklwz7cnsnEOL7IyOEqCTsvvrmjrLp?=
 =?us-ascii?Q?HsnP2/Jh6ZNZSP9cKfwDw4zBnT2xJgKEH4PeeCpuh0WNUzueH7kzP6Thy5W3?=
 =?us-ascii?Q?k6cXlRHz+Pj//WcyFkz/XUb7YwKD19GOBf42pVzGmv94M4q3yvo3DId0Z37U?=
 =?us-ascii?Q?GkkTHcq03w=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 34821c9f-2923-4e2f-0f31-08df3e714890
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:53:58.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mIYp3Z2WwTUEZi2sLyEkdR9ZcEGkoUtf8ko4IomntRE9fHf/n7M0oXFU4UR8LgF6z6qIZ7ZSbp9a6MsQkZu+D96LIO+9wZ3eZXa7/fUhHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2026 15:41:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3147

Hi Heinrich,

On 8/29/26 6:48 AM, Heinrich Schuchardt wrote:
> On 8/25/26 18:49, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The original links often time out. On the Wayback Machine[1], the root
>> URL is redirected to https://coccinelle.gitlabpages.inria.fr so use that
>> link directly.
>>
>> [1] https://web.archive.org/web/20251028230912/http://coccinelle.lip6.fr=
/
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> =C2=A0 doc/develop/coccinelle.rst | 4 ++--
>>
>> diff --git a/doc/develop/coccinelle.rst b/doc/develop/coccinelle.rst
>> index 70274c3f5f5a..54ea8eee0e9c 100644
>> --- a/doc/develop/coccinelle.rst
>> +++ b/doc/develop/coccinelle.rst
>> @@ -34,7 +34,7 @@ of many distributions, e.g. :
>> =C2=A0 Some distribution packages are obsolete and it is recommended
>> =C2=A0 to use the latest version released from the Coccinelle homepage a=
t
>> -http://coccinelle.lip6.fr/
>> +https://coccinelle.gitlabpages.inria.fr/website/
>> =C2=A0 Or from Github at:
>> @@ -66,7 +66,7 @@ The wiki documentation always refers to the linux-=20
>> next version of the script.
>> =C2=A0 For Semantic Patch Language(SmPL) grammar documentation refer to:
>> -http://coccinelle.lip6.fr/documentation.php
>> +https://coccinelle.gitlabpages.inria.fr/website/documentation.html
>> =C2=A0 Using Coccinelle on the Linux kernel
>> =C2=A0 ------------------------------------
>>
>=20
> Hello Quentin,
>=20
> The page was copied from Linux.
>=20
> Maybe you want to add your fixes there too to avoid loosing the=20
> corrections when re-syncing.
>=20

First link was changed in 117376394061 ("coccinelle: update Coccinelle=20
URL"), second link was changed in 87444fdce5bb ("docs: dev-tools: modify=20
SPL reference URL to actual SPL doc entry") to a different link=20
(https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html).=
=20
Do you want me to send a follow-up patch to fix this, or do we just wait=20
for the next sync?

For patch 20 where I remove some text, Linux fixed the link instead in=20
4fe1e1dcca07 ("docs/dev-tools: fix a broken URL in=20
dev-tools/coccinelle.rst"). DO you want me to revert the commit and=20
re-add the proper URL or do we just wait for the next sync?

Cheers,
Quentin
