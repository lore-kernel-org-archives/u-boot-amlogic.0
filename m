Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2865ACD4F25
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 12:57:21 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4286.1778667249753120738
 for <u-boot-amlogic@groups.io>;
 Wed, 13 May 2026 03:14:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=tmM3iHsC;
 spf=pass (domain: oss.nxp.com, ip: 40.107.130.71, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6FmAfOR6Ug5wAx8wNCoFbm4XZbM2tXzgLlOgP/HHUh9ewW8YVO8cac3hMk3FdsQdsSklkTIpOW8MabwfVOGGzcQ3o1OWbopq8K3NEZH2d1i6rneq3cTqG831KGYVRozN4iGweIU9wPVKY8MWZaSYHkKAF7VL6gb6V+nCa+TvWQcVMMkFBgtGbcfTbpw7WYl65H64uup6kexNtmBRC0jTzNPyHJo3JqiPX3gXlr/grHyKBQclaEp3gcvOn/5ohgx8JH1fATgOWrEdY/iR7PUEooAltbb4Wv/PR55NIQr6kr4shw1SOYQ8K2oFjDQnzOT3DMMUTaOSGP/upMw8qx4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mepdsjn0GvTxyE+ULFzZcBdSiZGUW2gydqDfWrlDRWg=;
 b=dFoyGOYtaIaTFTpODqrqU381IInrlLJ1irp6oPMU9nev7KbXy+R466jlRKEwpujZUsJHIeC4LT6DPbl19G8XKZsuJvMKG4mPIQIJDwjSk9woS/4PAMAx+BOe/GDgkBeEYJLwe/tGHs5vTjAdAZLkAdcUFH/I0Zdxz9D1YYcw1XtAIIiWjSX/mETPL5asS/tGVfxsdA2L/vowITyMTgjchb5G5KTDK+6I+U5I5zetmslurZr+mvABEpfwE0U7i4RPZPSrZW08l2FE8PjBHWpaqK4ULbUK3btsYZzwW+tqaOMQGXDnRTm3L2Cm/XkLmaHiJz/Muevp9b3UfjUom9LQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mepdsjn0GvTxyE+ULFzZcBdSiZGUW2gydqDfWrlDRWg=;
 b=tmM3iHsCrGaEBa7hHxY8CoD7IFZBtYkHzCGH/zWS6746fZDwzMHzhbg1x6mkSx5sCTRZ037IfUYyvvxndov9N7EyB2lYbx9uhIyxGCDP0e0uYFN98ePUmiCtvwezIG2Ic4zRRdpwts6lJfw+mQFU16wbcO5zF+EKrbtSlOl0MCTrhpsVH/W43HL4/j62T6GO14f5rRV4kiejdVmlDjrxDv8snWo8z9rRFJ8sXrcVQqj5w4xHp48CWoKIf5kGzrgHHrK3bSLa00z65MqvxltoIIZ0spevqMEWQN0edh0W6Joruxt1FzFMulLnVqabzeR14Ze3nJrXNlK0A+MkjHGgGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8384.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:59:47 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:59:46 +0000
Date: Wed, 13 May 2026 18:02:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io
Subject: Re: [PATCH 08/14] power: domain: meson-gx-pwrc: Staticize and constify driver ops
Message-ID: <agRMO2x3MTmsCV7L@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-8-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA5P287CA0178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::14) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c9d85d-9678-49ef-1899-08deb0d65d17
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: 
 PC/4rG/XFouUjddly0RaOoAM+rtack8tk0r8DXJ8ARYwtcFoTFjudnanSMvg0vtDK+TeiS54nTvT5+/axJw/kqQUauuVFYhbaMdD8gzTtQY/W2DfCVjieM7fmUZOSodRYIipy8eAewLY2uije9b5zlmeN0wcJi1TIQnJ79ofSCjDak4+g4eeFqJMRwYPqlVBZesWcibP8qAuWrXgyxjxcum82jZ8woA7W5OOTWPnJLTEXREVradaVwC0DbDzzfBDT13ZWMEZwH6CiLtfAS3/MY0ipmv7P/om+icZMhH3OcdNHPGwypT04y1n+LJ/NM2RFg2rmBlbXinvi9tRPOXw0NhQYVKsDCPldg2VXW/ysjXK7pjoXt6wUfwpddM9fqlvHatht7Qnf11GGRUUeGYs9+fqGeUQ2gBrq9kbecwWAx0JZ6pUukJg+Toc+SdujwF1RWWnGJABDJx/AyJkl2HaeKarWHu9/PtagEyzOi54WrwH5MmqkUAZtMbtJTq7rRjh61fg9h+zx5YZnbm/Vb+fYKJD+p0Tr4K9ddhohnaACrlLb8IcbClY9Boq3AHWp+rkX8Hyb+a6b3WjZBobm3BdwTEYtrH3BtDaHrqhhBO1Cf8KOXI9EJZw1UfsFFIR+h4yS+sUx1gvDRevuu8wE2PmIiCNXzBU0+yB4q4CKJFgUxKyt+MzBlcBfRnKoHopZpoLmsHIMKjr8y3jCS/Ggak5pwSiV3V1xjuyNW444YKHkXIdAFudXnVxUV9UWuCnhIsc
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?us-ascii?Q?IEKT+lI2o/FyjZPy3WaAZARtRPmNJC4Mj13QQZIatNft3je7qXOHptzh/Xl0?=
 =?us-ascii?Q?ePTrZzIP8fuUuNOEoPzwVhnXOXFMtzO96myov/3QlpuR4TE0jIb4aGU8dI6U?=
 =?us-ascii?Q?Cr8hZ3TlWH2TABz1C74Tt0YrCRp+OXs7F1/f7iQ/fGQcSgC/e+J3z7Eql+NL?=
 =?us-ascii?Q?CwDs2zK32TR6Ck4BdQT+TtogkCVYNaSH7i7nuK1uNJaBS63DFRRB28lxYBjc?=
 =?us-ascii?Q?y1LpLtBH4UlrMm5pZi0jsEY8tBpKVLJzSl4u1zwa9iXuBAknbNycCKr1Jy9s?=
 =?us-ascii?Q?wLI5ub6pj+Xl8AJhnosxY2FWPjaafdQmmnDJ2XncdMdORgiS0QMNUWTrYuqn?=
 =?us-ascii?Q?nTIrnPj30dLe/fvgTuSAE7Q7biN+POOpxKBNOmXdv4gDDzRXk+FSfJwdhkpE?=
 =?us-ascii?Q?h1dBMvkVh+1YJgO72D1c4VZzpHvPmrkhoQNDett5ZaPW2m3kBrwnUTZX98cH?=
 =?us-ascii?Q?asXA8m3AQSl+EpbOL/19qXaBpuZnYiLnvqLB6xAwmn9wcs4AALMBpoLVStZy?=
 =?us-ascii?Q?3CZdz60YmvvwjRpC+pKi7Y4/jhBtUuUhG0Rb32eHQu5KRJcI/D4+VH2ITs23?=
 =?us-ascii?Q?IcFHnSkMk7cdCEqizibup66Mg6MVD2/bbb4D1pN7sOTpN5qlJB40s7sTlC25?=
 =?us-ascii?Q?ZGO+Kt4sN0fDKcgMi3BvkUHoM8i+yWaPXFQzPDE4QpdJtrEbKGD+e3IQai4P?=
 =?us-ascii?Q?r2LcUHYczuTBc6daDKuDIjfKTNM3uXAPhwSMlANruW1fbpeYwFtImqLss87x?=
 =?us-ascii?Q?aLq+Vuf3dTWunbZwgKSYenMtPjqh0WWa5w8SD0C/pfZe80SBe/Ec37lo7FcN?=
 =?us-ascii?Q?rtC5iZQivTmT5rX7zVaKkaEYfN9UCls8VY3ROQi7Bebx37DtDtXqIgjkLEy2?=
 =?us-ascii?Q?h9xnmB5KLywDpS7irSfO8L0XLDKUosAcDzecKL4FmQl2LEhSXOlg7bH7AHJ6?=
 =?us-ascii?Q?GUmwTeenwd7don3/w5eLcgp+Up2fRBFapOkRCHlSgiJMwPUjfxqADtVTaU+0?=
 =?us-ascii?Q?ctKwATA0nJ3Nsw5/ZvY5BcoCDdoZetRV7xOzlIiZBD+Qv1piSNVj801MOr9S?=
 =?us-ascii?Q?//iy/wLWvAY14L37SbQ2Be21O888gvCJtRt6Tn1bUD8jDOJt4j84p/vTW6/0?=
 =?us-ascii?Q?TD57q450GC2xJhq82I9iUiPDAZ6mhsPxwVfQ6jjf3iqXkdnB0W4o1rQ0jH7d?=
 =?us-ascii?Q?jiKq9mGO2zsgIjABBdhmxS74SBGkInu6uLVyYHOi7R9DPRqU8nFXJZaKYK73?=
 =?us-ascii?Q?n+6U8bS/DZmRzu5kHY9Jfc8e5qJpVL/BpkROC6dsLg/tLDnyS5VXnazw0Iov?=
 =?us-ascii?Q?6sUXLckzbFCxw5O5bQbxlyBDC9jks9QzyWZwt0Py6Q8P07RAYNKmACQPZgyQ?=
 =?us-ascii?Q?INwWbqu8f7nNlO4gH8b5seHZQfwSDF27tuR6WKREekihux/zENQIrPVHR6Vm?=
 =?us-ascii?Q?GvADYxY7ASAiRF3ZbRSaVEIBXdTElIG1x0VcY/KUvF56+W5SFtF5E8K4uHd+?=
 =?us-ascii?Q?2+obZUrYRVbSTKEyU76dREs0Vsj5tGk19BpS4TmMXhcxYPT9kkdgr8kYFSvq?=
 =?us-ascii?Q?EzoMkwPWwCuPPoplvcH0RzSYivtPo3ms+m20Oaurdz3n2lJLpyrId4DykMcr?=
 =?us-ascii?Q?oOg3D7bgGuL6BAB6HOzsQ0Ki6z+g88rO5LEgTseMKxOENPM4jZ6tmsV0f6Ve?=
 =?us-ascii?Q?rp2v6OmnINPa37n818wW8QLUA2HI67UsnpQNDBIDMR4pHSa5JvMmXI96C+44?=
 =?us-ascii?Q?faAKnYgVhw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c9d85d-9678-49ef-1899-08deb0d65d17
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:59:46.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OW2JQiCYXKSRTgmVaa3/jtlmeipbuoW9GL3WWqYg19eDqSekNATmgZqvxzaTD2luOWRA9NpUlrp9y7a25wZgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8384
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 13 May 2026 12:57:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2985

On Fri, May 08, 2026 at 02:22:08PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

