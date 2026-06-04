Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3C6CD6E6B
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:30:03 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8932.1780571879991753184
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bG2sZDYi;
 spf=pass (domain: oss.nxp.com, ip: 52.101.65.16, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K50opWE2QkAkICploMGorOiU/XH/ZMXoDlU/ZJdHTJOD3xxfgGUVhsXVHJkjZSGCDD89oou14IHf1NkVFc+GsRmt5He0c7OuqQ+r6CUxbDj5JlUGwu/v6DMYko1rGUSPxvE5zrfyJ/k0uWohhcPSbSD6WhTXnuO1bAFRb4fYuogDAHqzpq9bTbcbnM6U+ux4EMSR7wIkOYAUTbModJz7Y/3Z90MIsO9HFImKYLVXQwJGXNt2xVQw//37LPtSQOys7/Pqm3hDzcj6N5rzYCK2kKHO27mLkn479N/NW2djnRTQ+CxUzZeOr9VQetzvgGvMqeNN48DD2IvTkoqTz2hRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksBdT5ng/9PeDhF4tLi6qLlfg9JTyHfcR54N9Y/1/7w=;
 b=xfuAk384FB77/L29frhlmheCEBlopnn7iWbSKeikF/vLmo7a1aWWp1E+FkWYd22zkb8fNz2/5J/awFlHJioqUog3oFcPuWrfwAtVqrtOWtZKWZyUNUtdJj8frLKaZBiG5ah+sWCS1uC+D8FDzU46BvNpu6hhAOd8YpVStkcc7ErWrSmHQOU98CA5luP1XQc6dShKvEXPcpRWxgQmH1I5t6rKj1YOf91IIocvgLEHauWyU8U+qXfwH9Buy1PvpmWHqh4e+LR1uwu3rvNVip2drk1stRPJ+i/Q7oJKySRh4RQJo0pg5n/pLcDjVcIWErsBcwuvosqOVH3CoRH1f2JVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksBdT5ng/9PeDhF4tLi6qLlfg9JTyHfcR54N9Y/1/7w=;
 b=bG2sZDYii/X4D/dhEggA6d5jPJ+U/61pHpXcxJGHe186F3BGIhlFyuIwUcEZUyHQLEi2TJoiyt1W3X90pRspvrohMBH/4eoHfDzs1O0w3F6XjSkgbIOrHrhrTnBbFZ9s0kCJDG0yd3pYHIQPbQ5lJB/GiGak/uMIOv/qjm/AXuqbo1lf5/LB4fmug9lam1JklsfgMN2FEbf0nroj1I3dOiriCU6tFbbmd2WyumbKIdMDQ/Dl/YwKtyjd1G5eJ3cev3edGtWOjuOhsKHrvkQbmCQeX38tNgeqSqTmGVRrKGrzqkNvXnKsSAuRJP4MRZssd9FURu4FkOb2AGUdXNrSFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by MRWPR04MB11518.eurprd04.prod.outlook.com (2603:10a6:501:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:03:29 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:03:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/11] mmc: power: convert ofnode API to dev_read API
Date: Thu, 04 Jun 2026 20:20:23 +0800
Message-Id: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
X-B4-Tracking: v=1; b=H4sIAIdtIWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMT3ZTUssSCTF0D0zRLY5PktORkAxMloOKCotS0zAqwQdGxtbUAqTz
 2B1gAAAA=
X-Change-ID: 20260604-devapi-05f934cfcc04
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot-amlogic@groups.io
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Yao Zi <me@ziyao.cc>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|MRWPR04MB11518:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a14051-45f2-4684-c640-08dec228e868
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|18002099003|6133799003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 SIkNiynn0H/9xnR8sAp4qrNX3WU653qhOQ1s5YC8QuswIKagmD6QFpx5SMbrPue0it4Ua9IC+9ibw83TIEVB+MmVca4BQxPoBO1UPrV+Cknsqocn0KQ4lj1qo6C2PEO81L+UoZ5k+rEsE+TcRf3jQ8x8zDLaQAyY8ep8wFQT6mrVq7iyU8BTLzPpCc7fCNVJAaZoYeldxoeMci93py5WfjYnlcoppPBUJMWZPXKlnvLaJ3gEvuCtreJ13CYpnUQ8LUrb1mDp4kS0ekKx7xi1WuqI3zAphz10QaJ+rh1Njf14zeyhqIstWhgqZdhAc68Oo+94GgPldqEQJRqoJYlhCBS5F96qWMQ+vit8MJjDS9sLQwerFGeg++sIEGcxTXNNsVyq+paHjcxy983DWAE1a7eBdzO/5Rb1cT1OEH7ZZ4CWeIWRqsLSFcAltjCPd1vJLkLDeo/Tau30uXiCFgVWBkKJaqqcRI5fh7OGsa/32Ii8kxyE5qKCOqpZC8m4cuybwurtMw00Mw2/rgQHqBy/coL+U141yNxQhsm8wll1SJzb8xjVZCgbWZVqNgXPWbVrCQYKL/Bs1BX9SVyZ0Vfy+BL0xp3WR0Q5QEeFdaSWr7HW1WtvrftG7YMv36wgTDjxEIjOAlKEPUDdC4nUb+YjSpknU09L1PcCsBE3HDwnUkIabfj7tQei3fWnW5G7MuL7cxsEkpu9ao23lJ7lrdHEl7G/yTf79aJHG9N3oxffpiEkhPfYRCuHw86grYC6XlZR
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(18002099003)(6133799003)(38350700014)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?amRBZjhuUEVUbk9hMXEzZjFYVFlWdlhMYTdkK0EzMzZLS3ZXL2t5aS92QStn?=
 =?utf-8?B?MkxOell6bExVNU1KeUpDaEl6S0c0cEdhQWVxbElYeXhFMDd3RE1zWDhDWHk5?=
 =?utf-8?B?NnlJQ3pjWUgyRlZQOURhb3pId3pEUVJsMi9PZjh1OEZpSEFwekhrT0xZdGM4?=
 =?utf-8?B?Mnk1NC9hT1REdzAzV002TG5Ta0NRb0lNMkxSSk4zbTJTVUlRbVU4b21QRUww?=
 =?utf-8?B?MGdkMlNkTFB4Nm9RQ2pqRzBIYk9jU0hQbDNpY0xFY3l3c0N3RFJFZ3AxTUY1?=
 =?utf-8?B?dHV0WGJuSEhCNnl6aWxVdnJLc01ZRm9sRUVOSkVtVjA5aG55THFKczhOdnhw?=
 =?utf-8?B?VDhjV2wxVEllYXJ0Yk9ETVBjSEJGTklUR3B5dm1UZXd2cVd4Z1Eyajd6NVh4?=
 =?utf-8?B?MXd0MnpqZnhucDZ2VmlJbXVzU2dOSG5MMjFwZ3oyNHZ6alFjejlqcml1Z2o1?=
 =?utf-8?B?MGZGbnNwWXh3THRJeEoyekM1NFozSDFIc1hTMWFsbTRqcGFIOVFpbW5qajZO?=
 =?utf-8?B?WHYyWXJLWmU2TXh0a25EaFQ4NjRwRjVZWlJoR3JyRG55SnQ0M2dMQjBJNE5E?=
 =?utf-8?B?aVk2ZHpncEhtK2s5NHVadFBOYUk4WEY1cmNUN3JXNHlsMkhhZVJiSjNqa24z?=
 =?utf-8?B?UEFDZlZycHlRTVFERk50RFlCNGlBUndaT0NFRk5NbFlLUU9ZQ0dZOXlNaUVE?=
 =?utf-8?B?VGthRHJhWjVNN1JGVW1EYzQ0YXlKWm5HdGZBdXZ3Tm5ZNUZCTGxJanREalR1?=
 =?utf-8?B?ZGZiQmI2Mm1xcFRkakcvQ09pbzUrU2piNXdUWlZ3ZFplb1pXMUpnNmRoenV3?=
 =?utf-8?B?Q1hTTzNHdENCMDdTc0U1dmovV2hpS3B4aXdpTk54cnB3ZGdwUmRGRi9vQ3Q3?=
 =?utf-8?B?eVpuZGhxbGh1VWUwRWxDd2JYZHFmS3J4UHN1QXY0Qkxaek5OSHhyU3VpcXU4?=
 =?utf-8?B?YVpxdjg1MEZNcnROdk1BNWxERlRINEtFK3huZk0xYmdMRFo5bmtFMEo4Umxj?=
 =?utf-8?B?RERpb2RZWWNFS3FQSldDSjc5c2FuS0tWR0hKVEI3T3ozL2laRi93RDBJbExJ?=
 =?utf-8?B?eFBtK1MrTGdUN3RkQTNna3JqeGNqVzVPdkFOY3lyV0xhWlJDR2RxZkpqb29J?=
 =?utf-8?B?UjRtNjdoalI4c0xuamhudTB6dDk2ZmR3MWJSdnJCenRzQ2ZLVnZ5Ung2cFA5?=
 =?utf-8?B?MytvMVN6elBxeHlVWnd1QkE1TmpTWlpxcVdmVDV0Mmp1cnA2a25RWER5Smhu?=
 =?utf-8?B?VExmaXloSFZUMDdaRGYzM3RxaWZyMUtXZE82SXVhNVdRQjk3Q0p6eGU0d3Jw?=
 =?utf-8?B?aEZhMHBVcTNub0lCTFl4Z3BvYVJSeDZWd05QOHBWbk91aDF6cEtmdG45SS91?=
 =?utf-8?B?QkVDSldHMTRtdGcwSUwwTDZQU2NMTFc5UVlwUW10UkRBNXVKSytYRXFRaU9y?=
 =?utf-8?B?dHBuKzQxUmZFU1FGUFE1V1BQdThRNHd0OWQ0YUI0dlRSanBJQkZkNWJQdmRQ?=
 =?utf-8?B?dzQrTXI1QTM4Zlo2Nm83VzJxbjdGTi9iWXErNDhlOGtNaWJFZGRGZm53ZVlW?=
 =?utf-8?B?ZCtrbms2eWh0dkY4ZGE4cklVWFJWVGNmaWJrcStqUUVXdlRjOUF6NG82Q0g1?=
 =?utf-8?B?RFlPWUtqQ1pRV3Nqb0c1T1hpL21mVUZkZ1JpdGM2bmlnTEFaMkdBb05jNkN6?=
 =?utf-8?B?K0xnd3BNUXlYOE9EYmUwVzZKck4xcjQxU2ZDc1BaOTREZVZZc0ZoQWlDMDVN?=
 =?utf-8?B?VjdkNncwM2RUQ203N2xwMDI2UE5IRmMvYk5uRiswTFRmTE9GY201emdsb25C?=
 =?utf-8?B?SmYyZjQ4Slg5SFJoMGNGOTEvaTBCcVZZWGhFNGNhcTRSMHpqcGU3dHNpL2Rz?=
 =?utf-8?B?a0hJa296SHNKcDVmeVc5a3BYOWd5QzRtNDNCS0VCUjBKK0Q4OHlFSXV1Q2lT?=
 =?utf-8?B?YVE1Z1hKa0NKOEJOa0FBUllLbFNqYkE3M1R5b0kvSXkydkI3T3dXUTRXbFRS?=
 =?utf-8?B?U2hvZHFNdEJXWFNUbnR2eWNpN1lwZHBXZGxBTldQQkxEMGFyVTNoT0Q0MklG?=
 =?utf-8?B?UnU1M1BBRXdjV0p0bjBMR3lxVVFnUVMrU0hKTmswVStNbm92azRRMTBEbUYw?=
 =?utf-8?B?dUxKVGI5K0V0NVBNSlZQaUYybFdxU05BYjlKNnhWaWpmeDI2bkF6Wmd6WW1h?=
 =?utf-8?B?ZjdqdEZ2Y0FWdUh5b0Nydkx2SjFrUDNJY2ZtSEFwdVQ2by9wNm5iTTVCa1hx?=
 =?utf-8?B?c2tIaXNjRkVtRFp5aWt4eXdYeWowMWlYd2ZuQnQzQjl0MysvMnFVU3dvYksv?=
 =?utf-8?B?SlJxbXAzdnBuUW9CTURRUFE4bDlBcThyS0JVSTNSVk96UFlWNHh3UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a14051-45f2-4684-c640-08dec228e868
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:03:28.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9qBBsLXNHA/qU7gmY2R41L0m1g8+qlqyuiTbKSno3Olyr0gqVeyHgkYCrzOQYypZnjMKmM5G0Fg23aDXSVmqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11518
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:30:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2988

Convert MMC and power drivers from using ofnode_read_*() /
ofnode_get_property() / ofnode_for_each_subnode() /
ofnode_find_subnode() to their dev_read_*() / dev_for_each_subnode() /
dev_read_subnode() equivalents. The dev_read_*() functions are thin
wrappers that internally call dev_ofnode(dev) and forward to the
corresponding ofnode_*() function, so there is no functional change.

For the Meson power domain drivers (meson-ee-pwrc and
meson-gx-pwrc-vpu), the manual ofnode_read_u32() +
ofnode_get_by_phandle() + ofnode_valid() phandle resolution sequence
is replaced with a single dev_read_phandle_with_args() call.

This cleanup removes intermediate 'ofnode node' local variables and
the now-unused host->node field in octeontx_hsmmc, making the code
more concise.

Drivers converted:
  - mmc: fsl_esdhc_imx, msm_sdhci, octeontx_hsmmc
  - power/domain: imx8m-power-domain, meson-ee-pwrc, meson-gx-pwrc-vpu
  - power/pmic: pca9450, pmic_qcom
  - power/regulator: anatop, qcom-rpmh, scmi

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (11):
      mmc: fsl_esdhc_imx: convert ofnode API to dev_read API
      mmc: msm_sdhci: convert ofnode API to dev_read API
      mmc: octeontx_hsmmc: convert ofnode API to dev_read API
      power: domain: meson-ee-pwrc: use dev_read_phandle_with_args for ao-sysctrl
      power: domain: meson-gx-pwrc-vpu: use dev_read_phandle_with_args for hhi-sysctrl
      power: domain: imx8m: convert ofnode API to dev_read API
      power: pmic: pca9450: convert ofnode API to dev_read API
      power: pmic: qcom: convert ofnode API to dev_read API
      power: regulator: anatop: convert ofnode API to dev_read API
      power: regulator: qcom-rpmh: convert ofnode API to dev_read API
      power: regulator: scmi: convert ofnode API to dev_read API

 drivers/mmc/fsl_esdhc_imx.c                   | 14 +++--
 drivers/mmc/msm_sdhci.c                       |  7 ++-
 drivers/mmc/octeontx_hsmmc.c                  | 74 +++++++++++----------------
 drivers/mmc/octeontx_hsmmc.h                  |  1 -
 drivers/power/domain/imx8m-power-domain.c     |  4 +-
 drivers/power/domain/meson-ee-pwrc.c          | 13 ++---
 drivers/power/domain/meson-gx-pwrc-vpu.c      | 13 ++---
 drivers/power/pmic/pca9450.c                  |  2 +-
 drivers/power/pmic/pmic_qcom.c                |  2 +-
 drivers/power/regulator/anatop_regulator.c    |  3 +-
 drivers/power/regulator/qcom-rpmh-regulator.c |  7 +--
 drivers/power/regulator/scmi_regulator.c      |  2 +-
 12 files changed, 57 insertions(+), 85 deletions(-)
---
base-commit: 31af00bdc6a3ab5d4ada83e08407f2ce289f0ec6
change-id: 20260604-devapi-05f934cfcc04

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


