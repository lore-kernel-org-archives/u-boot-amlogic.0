Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A41BCD4F39
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 12:57:21 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4225.1778667223011531960
 for <u-boot-amlogic@groups.io>;
 Wed, 13 May 2026 03:13:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Dy5Mxgny;
 spf=pass (domain: oss.nxp.com, ip: 52.101.66.10, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBg2vXFePvLTv0XqPq1fXqAx8nVyycgszOgljm7Ga+aFloLW3GXNJX0suOY7j9MLUyzcu4Of+0DzQA0AlruRl7src/DHEZz//h9sQxiK37PZchp0XzpaaCjaL6f5ye72wPJ/OdPGK5Lw4wBhYUTATAC7uWpiLifhqFk7BtOoovwAeVg2QxC9YnAktXLOX28U/vQ+erIkqNDMzPEUYnxNf7MaNnMLBaUJCMkN5Bp5uJRel81ditwlEPKtP9iNTW7Bt7upgTXPpzmI+MKiz/bsK1HmeDCjKBPvg5iFM190iYjYNb1qbM9dzrN95srJgZmue4n+BnLMgxYTabGI5fV8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkv/EQKeUYjCnyU84dQpzBA3+AdbqAgUPn+irf0Oep0=;
 b=VZqPXPMaNa9sDEacTieywI+y5V1fE/sl1iRvQ7EXYyGZBjj2DcYkgfqW+5nzAcf5a31d0wyGyU4QvqnciDA0864AssIspes1WJoVdhwS6CKdTxNFqnlB10BGV4cTH/uoSsdfvfGyald1fU1F3XPH2ZXJUTaz5xODftDWdLlcknn5tiOtDQyv5BoAaJ4JcFqpQ6TDPqXY/oyOz+/O2Po8FZuQOdQvHB7HtmsG0V0IChkARswD6C4IvUPEkLjpkFI13jKWiiahYqEELjDN6v8lGFvZoXOZ4e+JQXyfxhwyk0MQkBaMjWWHxUkyGEt1cyj++wM7pEPEpm1zixUG74x6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkv/EQKeUYjCnyU84dQpzBA3+AdbqAgUPn+irf0Oep0=;
 b=Dy5MxgnyzNKPDixwgw8q0lPmOs1On/Byfx5hnyas2dB6Tn6sMwQ2drIJEw5HQ1JFxgOReYpoUAtqxqKw0lA4LA1kWks/XQTmvco8243OxNcGPSNy2Cgt73CyRrTXTCg5uZDluB1e5NtLtzoqOri4TEhkVEqbiMHBi8C/pFEJCAd9Q2ZODRY8Ss8BA4bOEPVHesYzaTOSyyBG+B0iwqX8weZT6gEvrYZ3DeQVZCnQojNDm84LsVII1VjdLpBHfLqJaRIkwEXSJJhapgEaL/vg1id6rWb+hu232oamDyFCTDtG9V1iAYxWbZsX8HNisNCYKnjXhhds4er3SQsVncrXZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8384.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:59:30 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:59:30 +0000
Date: Wed, 13 May 2026 18:02:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io
Subject: Re: [PATCH 07/14] power: domain: meson-ee-pwrc: Staticize and constify driver ops
Message-ID: <agRMK4sKmo3rkkFk@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-7-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: 92454564-24d7-4e43-c629-08deb0d65358
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: 
 Gee9bOoIS4cjDV0vLNcy8dKMBJ00zKvvOAs/V8ZAHEHZ1UQCa1sI/qzpxOHKbIqVaZSbej9qh0OPdAewRfW5M2DrwtYv7byr1clRArLG1iyD+Z27/k3kwzRlYVYoZTlf/Hvop/+7COAVoZ1QVgSvfXZkvCttAHYiarzLbvELcaLswQU0SMhGHKz75EFpmaWmhnaT8lr6ypVsSsi6tYJN30WcJ+59voER0FcHy5iUgLN+ekrNjNSvFML5aPDhztVD8KCjotioD5oDdK1r1q1IsQ8wa5glFASs0MYL0/LnQa6Hl1hx7Ksh8lXPIMJ7DLuLAmSTuq6SMMGMEDmeWArCsleGZriY2qmwu3/8aawsMSo9vwv4bt3EhVGydXkrmWQxaoLhSjsUNhvEyh4zJ5ga01Z8LD38jLI1Hab47fD2fPsGXZcNZWD5WaSixlZaf9SbK3abAFNpes7rHB26iqkTQS2TGCyFvd/zrnBQqwjjDaX7/+42FKhv9TljX57QNQANfMSTsBhqM83LRP76fQsV3wO+bWf3Y9O1vPtSFm1E359g4/YAm2PMrihYVjN9lsY2DrJZYMiftg6pspx6LHicMC/fk7n837mCtjsGkMcr+VI8PYADUbYVmPEAYledklWtxJA06Y2iP5DsS2JpUNzR7Mwc4szwBYNqmAWnC/8NV8Kvqx6LBzluRJWiHg8ZQTjt3yLbv0XNif7FxozinU3v5eP5Svt4bKte8jb1A54rdR84yzhyxQ5bFwtu3sGtSkCn
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?us-ascii?Q?0JUizPNpEuN4IPinXgINRSFErAHlqx1eeL9ga9MkRmkjPTfr9o07Fum+K4J7?=
 =?us-ascii?Q?GL0rCF7Eyly2ibYpp/wg2n/TiP2y+JEZMn3nZ9bjK5V5/L+q9WFmCTKG2H/R?=
 =?us-ascii?Q?nXdUPx7xag13Y+vwYNj57kq7i/Ctyuexs2qtdG7bBCs7fBa9nkZPhRV7dpoS?=
 =?us-ascii?Q?bkZe+nENuVEYtRpTfpf0C9vMUoyn/STtpDM74qYWEQ+YFbS1vw+H6yE+lICM?=
 =?us-ascii?Q?xwytH95yqT93oQYlQnprFDUvslxvCirAZR4S21us00SIUeF7FFdl9c5OQmox?=
 =?us-ascii?Q?vuRnb2lx99OE2B41UCemiXiQ2dCC9wzgWoZQdSjI8z6ljuoeg0e5aA1TQ8b1?=
 =?us-ascii?Q?I6e2qVmVaHCiqaeoOxzo6pDe6CBXZFBij9INWozHuH9CzABXyU8k+ByMVT8v?=
 =?us-ascii?Q?mZ38EN80SwCh9cD2T3QDGJlifriOqypjY+L7++IsykGKkjGPtGNvo3NBCLwD?=
 =?us-ascii?Q?uhcWmETK5dsoB0nP0CXsoSvCmBB6E5zrZoM55bNCAjp8SO9ISZQz/t392sdH?=
 =?us-ascii?Q?2cmARkhZl/B0GMex7MG2TGM+XSkOVHJ1WtS3cCPomcnhVuRdbmG5ERS+ZCox?=
 =?us-ascii?Q?xjZgr2CzvUmPw06ycQbdw0onZx5kqV3zrzS02bZTUyrmaUmO40zsI8R8g09n?=
 =?us-ascii?Q?VHgH1Fc4F+4TOI6wC+vLSRbXDnb4DLDODp/M9uGMbDCaWB9/KlgOKsejAgJm?=
 =?us-ascii?Q?Dcufwt47reDV0TInMaFFQ2tH4vn3tPZdcrKtXqaaYS/Zn0nNfWPdt55u/8H5?=
 =?us-ascii?Q?DXi/5AJa10kjsiHdx2uJHFNzlWbytb5biZ/LG9yEnCG/M2RkJgfmv+wBs4q7?=
 =?us-ascii?Q?7q4d8P4b+Q6cQ6LmXP4m9oG0kFTeJGH2hGb84ySsYdB3ATmigQB/Q0eK3Ew9?=
 =?us-ascii?Q?HaPd4L8E5hyXE/6ehMG574E+dCk/VXN/aNN/7md9DDCb/TbqEPcSKy+MmcTz?=
 =?us-ascii?Q?VNwDRdVxgVmulDmlDZbxbTfdfz1Ad9LyZ4s3erT2bEg5Z0Mk62U4bSrk8SxM?=
 =?us-ascii?Q?2D3kz11oIz/exspD2SJo4JQgt6DgnnNUQK7FrgbSa3buWLic9UULzF6Xjt2s?=
 =?us-ascii?Q?fxkw7nXMRUF5ArZd2cwXkh1avPtyxihUEHloLUSlY8y484vXcB4Ox8qtQU83?=
 =?us-ascii?Q?OXzCghXGQCTZdM9QaYz8DePyA0L0XTDKzgh2yrPHagbpqYOPpztq5L4xmJMM?=
 =?us-ascii?Q?q2Z6ywWZX0ZIBEE1E8R/rtJtPWr0SPS51FbIRDcG2g8J0WhslPaIc8fA3TgL?=
 =?us-ascii?Q?aniblUxhbFKzgxS54G6PuK3cO/RBtbO6WkexRMHH9v6XVlR2YL0YbzUE+7In?=
 =?us-ascii?Q?vDcik39XQ7u1QITmIol+BtoNNt+QA9CBcLonWpSI9Bwn2MPNfnmJ0YXce71E?=
 =?us-ascii?Q?6ZWURcVAwYcu4TcWZaH/jUWJVw0VIqwB28w3QGDyQj7KySi2YQzVAmCy5x4V?=
 =?us-ascii?Q?EPoSpnXfCs1w2OyP1g8xQYzeYUlzI2CqQsY8n4GgTtt2SV54IJn6Z8qv98r1?=
 =?us-ascii?Q?j94xgVQ5RqrBH4saVEI89JrUbPz+2rYSxiSfbC499YRMNy3JAVo9LqE+NGiL?=
 =?us-ascii?Q?QtgaI7mTlF2ghomqjIWiK3JMFihe+ypjMJJnNQVvEKYESOnoIm6C4oQkTAs1?=
 =?us-ascii?Q?WBXhR9rhp8kX6/Cg5hGSjFKb30InZBwOgth11rDpGI90Mm05WlXhbmqAhn8z?=
 =?us-ascii?Q?hyNh7xz7EtDyhNzoDvUCf3cxPPs9gC2g+963Q0xhwXi90Rr3p+DhyTeu1NA5?=
 =?us-ascii?Q?YvdlR/6orA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92454564-24d7-4e43-c629-08deb0d65358
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:59:30.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjaTTmIvnGxMapqLvmiEPopYP0fGvGtLUQHllpi7HufjkX8bWdykKXujrra0brBlBRXKMhteIDeHhD8RgWWemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8384
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 13 May 2026 12:57:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2984

On Fri, May 08, 2026 at 02:22:07PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

