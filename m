Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5CBC61DC7
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:39 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26732.1787677060975754097
 for <u-boot-amlogic@groups.io>;
 Tue, 25 Aug 2026 09:57:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=R4pK+XLP;
 spf=pass (domain: cherry.de, ip: 52.101.83.14, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErXZSbeoLAhI174+mfv+L99575/89hsjOQa5Hoy37BwvKdchdv6M0ikIkOp2E2kRbxFbnLKL8ZToYkw13moVin3fKhGrArUoPKKO7vAgVYFNdBf+52QqKw6Tg5bQxTPtoQoWU6DOEbOJxsB5YWZvhLC5kwRgOWH2bAkcIKHVFO7+BOpYUWFqTerxWty58zWY2TQ0Sfq5tGRJ0Y09zwsslokNGp0bPOXq1kDr25KfwTyuzDfV8nVrEOW5kbGZJBDnq1uVBApw2rvgE838ERMFWCvKz2tOGVRC7yIomCotxEDdvFITNMcvnSKlc8LlCfN/1LFqJ+v1KsP8NQgMFY9SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xm8hdwcXUxFm/I9LxPp2xJ4tY/KWjgcAPN+MJAurSQ=;
 b=NBSynn5tG6P5RDKR4kCMtXdIvJ9iZdbnQU1CL05GjFEgDG63Y8I6HejJ9KVMnxbHxmNPkcLVz3/UHojmOCy418zCkdpoQkVopa88h+RAyHfGp5uhdmpM6iDB7Bw5OmwHGTLUXYayLwnAltrX8qmLauVDdVTtQZ+sJOdsfS8Uw7plEK5XHrry8uDbU+XV6Nxs7zBrlmbfUWhRlTu53MKlZ2p2EDtUbGxRWwXJDFYY8ICj7vfK+r0PBGqU8HSChxaRvC+f2BGb2AoKkQOjXrWFOrX/6JPcxhmlZaZ/zKnwJ61bqlZS9aqPgAM1nfXmUAiWOVwyCbaJNp0fvpQ4pG7XtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xm8hdwcXUxFm/I9LxPp2xJ4tY/KWjgcAPN+MJAurSQ=;
 b=R4pK+XLPsbiHfvAflMd5CUPudj6S3awc3rkrLhfoLxpbcKlSCdIiqevKD7EyGnBMbjWtKC+GblMFtw5An0sBcTjNW/dnl5hGyZBmD5WPdePhdkloTqbs6N2WK7B+/69RqLYi79JNyXHyxyhDUKOhsL0DHqszyTUWcaH8EAFL8NA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MI9PR04MB977914.eurprd04.prod.outlook.com (2603:10a6:290:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 16:57:36 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 16:57:36 +0000
Message-ID: <2320d518-770f-4ee2-b08e-b520669f6c2c@cherry.de>
Date: Tue, 25 Aug 2026 18:57:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 00/45] doc: fix some issues reported by linkcheck
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
X-ClientProxiedBy: VI1PR10CA0089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MI9PR04MB977914:EE_
X-MS-Office365-Filtering-Correlation-Id: bed7511d-c1cd-41b1-caf6-08df02c9f6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	WzbArGGymDH4u+GzwMv3hZ7qxOdFO3SWeyf09Ctw6lmfRv2QdZZkLjM8pTHbGdbpYvdl4wPmaz9+Ac/4NVzoMunrq6HP2UlhENdIbKBrTh8j2X0ygr1caH65DKhKUWIIpiMsQzxWqeK/ukry5cGXqIWPqAsUhQfXbxvfBAseWlxy0WLo/UFpI7K4OOa2jzHKFcEsnIwSDFA6AfWNCRlLVYz6xCVozUu5TDkQ2GjvLK4hmXPpLfS3nEigcue2sDwwABVQEckKZFUS/Or5eTWi2jmamKfijDCeosO405AJ2/9NUT1c4idMGhz/a04SDZZVW8f1Vkmf1hNduYqGlOf+j/ZwYWtKR5flE286zJt5anww0O/JOCNQZapk32GwfnMLEf+UL3w0sjxNpXrFnTaz1uqQBoJ7skAqQLr6BkIj50xWpOKXch2TlhvSDvszudU+HSCPJmGE391ww16IOewk0jlSYE+zaz+0ldNG9R0fL1AJXtQ+Yuj1epScSpPXJbfBdRfcH6W8YAWa5TyjN+Mto101unIxyMuJPwebj39SESjuRloSb1LyHDiw3bzdkmPIomJX9CDXROmtM5JxOmFcT3QfR4u3oDlx8xJXiJ7rScQY2lzuFqz5UNkKUEd6CrApzZAIVO7ZVFBZxTfQrRmGo+0T57cBLhzowEiJZcXyMek=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c09QaTRPN21XbDBYbDJCOHJ5bXFzQURuTGsrQUZJU09OamZzWDJnZTdHUVVB?=
 =?utf-8?B?STZ5ckszTnlKaGpJb3RNbXVOMW1zQjFheFRQaGhXZUc2NHIyRmdETVFGVjhO?=
 =?utf-8?B?aFYzNkhraGQrU2Y0L2tnSEpUSzlaUGdOZlRtSFR4WkxGN0UrdnlzclNYWnJy?=
 =?utf-8?B?VUR1T01rZGhVZkJZTzVMSVQrTXlvTC9RZXNLVFRmdXkxbFJ6dVdwc1U3MjJu?=
 =?utf-8?B?dFZMMlJ3UUFNM1loS0F5cUJxV2ZmbklNM1FuUW0yWSt4QnRwMDJmN294Mm5E?=
 =?utf-8?B?UFY2MVpJTjVqYWlVWWVBRHgyMXRrZmlVNUFsbGVPdStYc0RqWUlBUlNGRTNj?=
 =?utf-8?B?Q011bGdVVnN0OWhXQzRydGgvRUNRVEp0MTdSa2V5NlV5OUlpZ3ZOclN0dERj?=
 =?utf-8?B?dmdsdUd6NFZ6Y0xZa0xWTmtpSnBwWEVyUEcxOHB1UFl6M0lnNlA0dlMvL0oz?=
 =?utf-8?B?bjJkSjI2UEI1a0ZpbFVJb21nYW8vSy9PWFY2TXlOdGx4YmI0QURCMURiODN0?=
 =?utf-8?B?VVVQb1QwODhQbzN3NFJRc2owUThqd2F5bm5LRDM2UUNjYUpNaVBldlBhd3Rt?=
 =?utf-8?B?Q0F0bkxWSjhBa2NVTlpERE1qWDNHZ3Z0NG9Vb2ZZTVVNVm8rYUtTdDlnTC9i?=
 =?utf-8?B?M1AvTkZ4K2E1VkJSc3FkUHJRVkVuRlJ2a2RNbFcrZVd2M29VZ00wa1kyZGJl?=
 =?utf-8?B?OE1iVUZBNVc5ZHdaRVdzMDRaUHZieThyYVNXODRiVWwyM0xXdTVnOEhxOTVT?=
 =?utf-8?B?RmVGcE52R202TVBObjA5MFVZWkxMQU9TSGcwTVNTZlVPYU9EeHZKaU5oc2xJ?=
 =?utf-8?B?cXVaU1p6Q1BwVjUyeWVETzExdFdBdHk3QmpMMzNZdjFQU1hoOFc2Zk1vSW00?=
 =?utf-8?B?d0FYdjR3OFBYdmdqUUx4elIwTTV5U3BWM25qMWNWaEF2TWpOYVZ0dm11aTUx?=
 =?utf-8?B?VGRQby94MjF4RjlEWkdJL0pNWnN5TlhvMDZFOExLODhYMExEa2xselFNWTVO?=
 =?utf-8?B?VDQyY0wrVml3ejFBckVQcmFEbHZmUGpVK242M0VmVHN1eXFPbFhUT0RVK3hR?=
 =?utf-8?B?SmJsdkRTdHlTMlhPQnRRVDlRL2wxMVIvSGpxbUMrK0xTMzRDRzNaTmpNMXJq?=
 =?utf-8?B?SU9IczdkMFk2Q3dKck91bVVoMnk4dXZ3TE5ib0hVS2h0Q1hvZW9kNmhiSWlE?=
 =?utf-8?B?eTFISGpuOFFtdjJGcDNWSDlpNS9KdmFkL2NYWlpLUXMrY2IrRm5HUHBJZURP?=
 =?utf-8?B?c1ZLYnZkdEs3NXFjTmN4NEJHMk42dERXaFJGQnZlV0sxTS8zdHdwSWNSZXp1?=
 =?utf-8?B?Wk9RTTFVdm9MSGdOdWJYcjJ0cFNCMjFkVHVlYktkUXFRbGZPRGJsUm40emd6?=
 =?utf-8?B?MkxSb0k5UEdoNmFpeVFPNHZpWmlpR2c3SitNejFSaU1VaTF2ZzU2cEVrMzJv?=
 =?utf-8?B?cWdRemdqZ0FLdDJ2aks1UVkyemZma0dOTXExT3I5UmZwT0c2WmFKdUkvbnJv?=
 =?utf-8?B?YzhZemlyT1Y4RTdlYWdzNnRpSThoY3YrUUdNaXdLUFFiL1NPRDF0Uk9jTFQ3?=
 =?utf-8?B?ODU1aElPWDV5anJxTnhGQTJoN0pJNDZYdGdzZllGbWJNRGJCd2FQSmNWcitm?=
 =?utf-8?B?bHNLSWFHQ25Ick54QUsxdjhBYllhUkI0OFRHZjBFck5OYmx4emc1S09lbk9H?=
 =?utf-8?B?d1ViaFRNTzVvcktIRGc2aENaeWRQUm1ybGM5bDVVSk5QcGg2RXZJNWZpWnFi?=
 =?utf-8?B?WUpHNC9LZUMzSGV1VlRTNy9nYWpmNW00dHQrd0tuSjFMUFZkbk1MZEs3YWRz?=
 =?utf-8?B?SUp6UklWcGQzYXNCTmkyTm9nUmR3TnhJUUJCVC92RHdEbkxTRjR2V2dtU1k5?=
 =?utf-8?B?MkhYQWxEckV3Skt5MWhIRE5EdEdMSUNVTFFhL08veTBpTFh2NC8yN3oyWGQr?=
 =?utf-8?B?Zm1pQTNBNEZ3cmZXcC9EeFNidEU0WmZzRmVpZDlORXJhY2NhUnRLNTA4NTdh?=
 =?utf-8?B?dEdkV3MwYjU3aHpYNmM4dHgvMEw0V2hPTnF6b25mVklXU3orRjVNOHRVemFq?=
 =?utf-8?B?VVVIMGJTa1VESGxiMkxFc05pKzZCOVR5T1pIUmJiNFNPdEtNa252SVpOZDRj?=
 =?utf-8?B?UHB2Vy9KZ1psZHQ1Rm5LM2NtV0Fjd0YwTmM2MUpUTmxvRVJGcWVXeGI2dG44?=
 =?utf-8?B?MzdDWE54ajc5Mi9LYmhSNHF4K0huRlBmc040aHRHd1VyRDB0T2Q5ZzZEUVJz?=
 =?utf-8?B?ajhXLzJ1MHRVOVZqVURFK0ZYcC9TSlBYa04yTHUwdDNhUW1pQWtLT055V1JM?=
 =?utf-8?B?VjVFZ2czRU5nSjB2QzNmMSsvSUMwT0RSemtjWVNZdlF6VWljQm0vcDZRc3ZY?=
 =?utf-8?Q?ePCP/0s25up6Eoktah7erLmKYZYqhH6FbhpiEc3AynHh6?=
X-MS-Exchange-AntiSpam-MessageData-1: 1Z0SPHdAV2bBzZaiQDnY/rjh2HDxseKE+pk=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bed7511d-c1cd-41b1-caf6-08df02c9f6e0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:57:36.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWJ4YoC+JlDdKvbPOaa/0TVQEOiB9FNiH5nUV7+o31wwwHfT+XkDPtZEfFeyAT81OpBXKwhpsaduxSu28L9rl+89UmQ5aYDo9aWE2WzNxKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB977914
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 13:42:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3066

Hi all,

Got rate-limited for 24h by my mail server, I'll send the rest of the 
series Thursday.

Cheers,
Quentin

