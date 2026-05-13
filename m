Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3F8CD4851
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 12:57:21 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4287.1778667250055443384
 for <u-boot-amlogic@groups.io>;
 Wed, 13 May 2026 03:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=fq4fwqrP;
 spf=pass (domain: oss.nxp.com, ip: 52.101.84.62, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YY/eHU9n+/EKlq5IvZ4j0wQV7F1Z5csiAbJK9JU7MeN/tVgDiiiLuOWL/6C6bDou23Z+E/kcfAdH8CFkM3AgCiLz8EAsQ+vyPBofeSt5DaOxwBUxcJc1r3YcDgkfkyB47e77ZxwSi+5bLU+ZiMQlS5455QNCBK9HFVfd0kXwIil4w1ic72sMCsEsigP46DGPSDKQVILYSd63NgNWaIZP7KiYiVHacOP2AsvHq2sXBlcIyuzSmSNKmGDu/C+lkQBfJGPGe5uxS7V1elnxS+iIOHx6YTECn+EzHYt99oSJAKOa6rVdnvI8DHWFFqBdFcWPpBtYbac9qpcmI4sSjdSMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGYZwTElacdIJHmBYBhDR9IBIFKhSd7Zn8nm3SRRHg0=;
 b=tB/yWkBSOV+gM6JGBRhxDw92/QLpVk4uyXb2Q7/uuTeXeqcToGRZEq/02yy4mD6r6HWvVIC3zqgBaRNgOi4wZc8F2HmgEfwSegN+hTXGzR4lLkcY3JF8ArGWU+k0ky3i3S/4H7j51RnBf6u3ZUX0j35R5GtiE0e98sFB3bWR7COUJJ4PHMKMEyQf0QHKoyj3Yinh2s800WdwYnxBhBdG0zxwVi7uDFE5XiCPBq+k1Xg/6wwCqdpD0glCJgILTNbX8QXoTgUG+CCRPo1ab/07nuWXbralo93TcSp0T79Ym34rfoqUEdT8eVP7ZkwUOUsbbuSVVVGGSmYJHDRblXU49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGYZwTElacdIJHmBYBhDR9IBIFKhSd7Zn8nm3SRRHg0=;
 b=fq4fwqrPqwsk2CIMAEgrpTaxytxyDQH8Qw+SsXv8GwQKtuW7YQmFdkZ8wNq1LTdOqmkMhmbjnqp1zOThCP7HjvOoHXyRZdDKL9YQmSnil6R6Kj3J+yxTwRaEfYLn3/SALl/lQA0oj0+96qNmury1qe2gbAznx+lydVV4PhkG5JtJ7JxX++jVCzK4AAsq+d63SdF3p1IZ6gplw/K0yi2kBbgthODmTYnEh3Tj6VKrqQ598rR0BDwJzhiECHaLandBRb2NqMUetYQXWUAaYfNhtxd/o91yauTQvsK/8Pu6N5D8VJ8rmBN3HyFdEGqd1MMf2mLMsBL5JHWO4kCbcZCAPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:00:01 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:00:01 +0000
Date: Wed, 13 May 2026 18:02:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io
Subject: Re: [PATCH 09/14] power: domain: meson-secure-pwrc: Staticize and constify driver ops
Message-ID: <agRMS8C4KdE9MTRe@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-9-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA0PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAXPR04MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c9fbe4-46dc-4236-d5d3-08deb0d6661e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
 R5Y7V9waEOshStV0I3ZRzw1SmzqxnvpOfzylxLaBFfWHnquzOflozjXEayXmK3LG/CCPilY1Rvl0bAT5o+YYeY6YKRCE4ZWI6dQ9XqI3X13Fh7Gh/xZYQfh+t7rcHNOO1ktZCGqATxXW8r3bOLApI6oKYdH58AugyBWpSMTIVemRl5rz7oPK8Ee8DIn63InUkqAE6ZlPvQkxYKK0JNSyFY8cBFY7L8GJug6syx3B4Ad2WXAh/jDWPh7KNj00YNTnnbxm14Pycj6a9UQGzBo3bhMFQJLuqNhGJbtUmmvOBeGt/0zLMDhjIPJpP8ThqiMOv5zLcM9y2bw31uXgQNTi25t3+vEd5RxQ0I7KPV/bc4GMmw8qkB4fT06Ld3V96h3ojdHgDneuRh4dDYFcM0LLXDkQ9WgQlAq7pLTzWEl4+7//NWyKgYn0X1fq5tPJnEn2UtUBX80kJeEd4E1OrbBE6gQfiYlU+QmBIMK//efydwkFHAYh2h0NeXymTX3M2FXYFtugGawLQINNaQT4phe+Ti43Nsk0yeWcILsHW+YGQLwoawT54JIPdiXQfedhUfUpBhQnu3T3jFPzgy1mdzd1DcozW9GjhudTpuhk++zZcOEiUH/PEwq13qhNQk7EpM1yRyyBuGf2uqe/nWC6n6jhjO13tEHCiVwDR5H137myW3JFfDv2SAK2YoW4Q4V/quTR9hyJmXke34205o1YWvEdmqeAG9653/ok5eGctehp4UfeGTclXLhjOEN90dYjFWQ8
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?us-ascii?Q?rTOjR7VVUtCVjq3b+WEdWcZ0LEQRxmp13SqiCG2iriE19Dnut3hqExNIrXB3?=
 =?us-ascii?Q?70gNIbaGdrzuLCBs8jYui83jvGIrxMM3/8DW5NDsrg/RowCLxIvQqjt6poFf?=
 =?us-ascii?Q?a1bZ4VxibXmYaHbhgAw8VI4PEYHVrHSQ74gsb85CYoKvQy/oeqL0G8171shu?=
 =?us-ascii?Q?uGKLROnbf9GDPdjjIglH1IByczFEJAzH+oR3fxoRrfU3cIaS2BIqC7kfE3cq?=
 =?us-ascii?Q?gW2wIgkvbswKZ0Ufr4Cf1iGkp1/Dxb3D9UrjwzYDPnfhIdKDIMXNQ+3zyt0F?=
 =?us-ascii?Q?jygCCW1UvAPmAI/f42319U5eL44VSPYgXNjXCB9oB1b6rVgJwzjh+PzSMzo4?=
 =?us-ascii?Q?MYMgvrSjJqBrHebN6iGa+jBJ8jT4Sw3TiPdAAwtVkfbJ82+BdN4swlsYN+Eh?=
 =?us-ascii?Q?dmP/sxwAPMMNX4W4TDl2m8qmwg/gYSd36Xz74YMzu8RilK/6WchWP3SCtpbw?=
 =?us-ascii?Q?WcmM0SRVD4u4T+lgsEjDm6pqte6otLSjIICNexDuYuLdWcJ4y7evsi5qK9PN?=
 =?us-ascii?Q?hHpYSXwJyY13Y9WvBnCxEzZ7dM/Fi1rRuMZzc+Ku/w92UBZM4ANUD1zSLy2A?=
 =?us-ascii?Q?a8tOWWw896tYrsubt7cxJJFrd+J5z7Zrw3wKD9hPXDgbIqsdHCF+uV9153ej?=
 =?us-ascii?Q?zOlO+7YnEdgCGh9gj+sCsvIn4ZrwD4nouZchn3GT/EOnsora3bk53HJEmkwZ?=
 =?us-ascii?Q?wpMiJrctiDiJI0wtiIZULJ6nG3H0kHtx4JrrS3OlpdmXTIyDX3uOoiF5hII4?=
 =?us-ascii?Q?0RVXztJiQJ/pfkFgJUh3OatUGfYsG6NlobCJj9eCHxaUS4c2OQW7lf9OOf6o?=
 =?us-ascii?Q?eoFnQbiPEDreELUFR8u/3A4YYwI5dBJJ+F1VJE8FfHqy9LZYPygp4PPnuGRk?=
 =?us-ascii?Q?dWz7G49S11yEdWrf8MVgFz9mbVTMCep4OgBp0WM1LsKMrTYvbHB1h6GzYclX?=
 =?us-ascii?Q?Tx9ti1rzhpZLwAOEOFaZ5Dus/6Ui4QsbG3yXFnpnw8l0Wn7mi3O0rBJNew6m?=
 =?us-ascii?Q?T56KcjqMntmRw1Q8e+GhEHSJEeEzyldZ/ByDpw2Onb7TDRWRTnpxsTgU3n/5?=
 =?us-ascii?Q?VZ5uSfBOydU9wfyKQ+1OlS1+beKEjHNEDw+Nz0RH6gr2F+kjmDZEsLbVR1gy?=
 =?us-ascii?Q?O4DdgmpopRwtPdxh/zABlmyKPD/4CSgI1hJ0wXQFMEGeXC5im4B6ssPTTRqM?=
 =?us-ascii?Q?F7YcOl67m80w5p8wFl8sjS1kOoNvNUOnu9ANFyPUvbF0EHiVDmyXsDyFM/XE?=
 =?us-ascii?Q?g0IZOwWH7eOej7pEiGzZqJ2U0gdyp9XJherbXJpCBnAPetSnQKKkZ8sbNFi5?=
 =?us-ascii?Q?9Yt77RVnNFSGGwoDS+O+cJ+ZAnO8HoU2qW01NdfRwKmQex/6M1R3Qc06H9UO?=
 =?us-ascii?Q?hfWA6I1oveaIrJe4pG8/a2GZyPnD4XY5MaZA/JH88QnLObl+LqvatQ/utNVY?=
 =?us-ascii?Q?XrGMik63WxFJhEKWkK6sM1iqOawDXcOnrZItD2wuySPXUXAb0yucQoyFvup0?=
 =?us-ascii?Q?6CUu0TM9Eaiihd71hG1YqYJXKP01AUtgMWV45Iej7zYsKZ8xgRENqyQcctsa?=
 =?us-ascii?Q?lSljB35lcQ8UzD6b/uLKW8SjRq+mZiICCElkcR+vJMLkK5L3j/pcJ3nc8HHq?=
 =?us-ascii?Q?YX6ZkkimRHdlYxrSt4Hu7DmvV/I4QtiX0AbzOmjgKIYIPQDTbuvFyYWrHQY1?=
 =?us-ascii?Q?qj27uP8HuI71rJ2vvlrAlPIpQhe68L85w8O54JLk+GV4O4mQDdJuimXJ6wfX?=
 =?us-ascii?Q?uq1bzCiqBg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c9fbe4-46dc-4236-d5d3-08deb0d6661e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:00:01.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLJsEt/2C7aSq+L4mR9/Z2kUkt1ZOz+URokudXPRh2/haa2Oy3Qw5U5Y0+jRb3uGcXO9bLiz7vtkQrVKBzMH1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 13 May 2026 12:57:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2986

On Fri, May 08, 2026 at 02:22:09PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

