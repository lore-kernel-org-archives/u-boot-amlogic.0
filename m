Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0DFCD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:36:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8955.1780571958379428135
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:19:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=YaoUV0w5;
 spf=pass (domain: oss.nxp.com, ip: 40.107.162.65, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYasyM/11w6P+UC7jii67lhcpo04MGNQx0875soPnNnoyrEbRI+aA1L09hNCvRJb533dpkovOojj0R21g915eooLPM0qnDzN3tjVqDNHimJ1niH5BoV2fog5Tzd8e+T9yA+1bwtPyWLxF6xJgbvGbPElsCmNmbTWCrxYUoaTzUwHO/qzhz9mfJmvjQ6b4xYNMyWO+2787zHZ1JvLCES9uS6buxwYxfPZwawdXsvHp8ies0i7xitoevdiI+inVQxwn4kU/g3lyN8iALVXd7kAp3Ocn9f8rWN+03lvcGFOGZUIyfQDhzvPFwuObUK9jXeWr0YsBx0fN0ct0JVSPUumzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR5KnX1CpjqkpIulCqqiTEH6qE+ehfY0Pf7MsBkXBeo=;
 b=fLMIzyj8QzzFMfjyxhV3iXSVOIC0lFjNESPijT2KuQAgBCMvHAZk+vxqMdsFHOXKsNE1f2A07MoLJhr1gzuKUxX0ztXMc96wdv0xd7cYO96+HBCt2fQwmajt85PLyWAR3nFTppY9U9JVsYOBXMJhtkqGqnZDtccMabFA5nMxvw0iD4CCDXFuU/rncuEUdx9ljsy3D+pn23Xf/iLyNJ/eJNMZFCQyxiP15DJv6kSQmlGIdKdUhgz7KUeTuL3rpP5dcvzsnbDJ7CV5aG3xmCby7ozxtUQ+nTfCOwyjSNQThO1W3v4ZXJWCMjaYgvVOUyZ9eVFtFvqUrQHXPZ5yzDf0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR5KnX1CpjqkpIulCqqiTEH6qE+ehfY0Pf7MsBkXBeo=;
 b=YaoUV0w5ZFo+QNKv0wo505RxPEi4zQ6FT6a2ErDqphRSaQ4t1yfT7+bHQZ7KGMqZrX7PGyYyuAasQTFvacAC9AO3+bTZpt1zetxr+Mh65RjAomEQ69QnxgNjzbDzm970uvkp22mz0JxLC0aLDGLTXYqQ4I3CvNNhcsDA7ShSE+gmxitjvP0kZ2aKuDTTyWm/+LNfgQAimsBrugBMH70/glndSyR2kCw1dwpT06ZKSWhRmkqXo1jv4Qas1cimQm51Ti8JBdqRrQ77X8C0mvrADU1d9FO9lgSky1Rlec1qsUHQWB/TsM17mu2DOMIVtZOuSdlrrTH6XWyK+vpYpKE5Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:04:24 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:04:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:31 +0800
Subject: [PATCH 08/11] power: pmic: qcom: convert ofnode API to dev_read API
Message-Id: <20260604-devapi-v1-8-961aded05ff4@nxp.com>
References: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
In-Reply-To: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB10291:EE_
X-MS-Office365-Filtering-Correlation-Id: 3774ace4-c7e9-4d08-572a-08dec22909a8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 2ICqQ3oQGyxvMcCwi1JcxVCOH//1/+fQm3ThtTNQhhASzxzeUPFt5jip5rP5s56eDHDmtM1PfEFWezgUdr6GH9jWTuYzlq1G2DiQyWuOkzT6D5HrUuIFrwhQQ080kgL/UnujXz3gA4fGGEhRZSAdFuDPSwZJvP4+UyuEck1TLziS9guIOYaRj60eFlkbl5/s3QZD6S6rS91UD2XZF7gmudC8/cokJ/HkqSwa0/FyZ+9Ejrbc8vsFdtK5Y3FAL6wjuVx2yf9KMjBCh/3Vdv+knm1cZXkLKzuGxw1ZoK49wf43iRdWhud1dlyIgYG/e1UFh+ACVotZGDLpd9Y/eHxR1AlWu+RrK5dCOyzw4axCgWu/Zn/94bcFZD+fCxN5Q0kIGaxQImpYgmnXf3WO4FR+dJRqeLNNqgco6ItsAVUO+JEuHPS1JP4Ye5+75m1JXzWi8GHKi0KptILBEqOxNelPKLH7lVuzrmGAnPllAB7g1f7Z4H2N3+sopJU9+eQJNMHHX13WH1eylmKNyyt+w4bLf8cBpOqUZ2i/UauNojjbj8ymbLKKnLdWBzXAj+0HwKP+P6B4eyA8Rk3I7iR5mab43oh1LbVL6N32nXvOA7aKNr4er0KUto399XirVJRGjGrOsO9EEZsJR2cTYr8i4TNjBRv7KOk1VnQ47VXgf/iv3R5dVmYloVLmpo7E+PX5DIBHIdsT89nogq+a/f1N+NKp1nS4g3gthxy6kfj/nd8WYzjL8W1Y0yIBHCWLnmEzCaQ5
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?Z0VubE5nUUlKK0hiVm5Ub3pOeS85bmt2ZjhFUHp4anlmR2dQMU9TWG9OOGJv?=
 =?utf-8?B?eEhRbW9raDZoVlE1bXAvMm10RG5CYmhUOE1QeEJxcEFnTWxLQmNCYUJnZWFj?=
 =?utf-8?B?Um9uZUpJblR2VXl6Nzc5NjhGM1V4bkJuYW5RWDdjc3Q2VW0wa0RldnJhUVN6?=
 =?utf-8?B?WGR6a29YV0JnZzNVTWRocDVFbXYxRWhCempaREprM1k5MW56TG9kYU4reFgv?=
 =?utf-8?B?NHE4VCsrRW1BWHZDMGlGbjdMU1JiL2tpdE81TVFnQ1lyVmwxK0lzSW82Z1NU?=
 =?utf-8?B?Q2ZmVXM4QUFQQ0FEbnJNM0NGTndtZUpMTlNSR3NCOFRwWUVwMzBTQld5VmR2?=
 =?utf-8?B?Q3J2am1DdHc0VHhUcmVNNUdlc3hIclZzS280TGZnM0NNVkpsckpsSXZGcG9t?=
 =?utf-8?B?cmdNcis3cU5ZeEpLM1pmNmxQQ0RoRzZHYnBNSGd6OVFPQ3dZTWtJMFVhb1Nn?=
 =?utf-8?B?SkJKN1dwWm1mTU9BZTdSRzZQTDliQU16UDZMYmVObWhuWWJPY2JFZEN5NUlw?=
 =?utf-8?B?SHRMV3ByMVJ6ZzlkMXpLYTFXaGlSRDNFZFZyengwQXVVMkl3OWo2dWoyY1Nq?=
 =?utf-8?B?K1hRamx4V0RqR2xuMmRVNHp5WnVtSXVJMzB5ZU5SeGQ1VW9kTVIxK0d0Kzl1?=
 =?utf-8?B?cVlJeHlXejI3RFNtTFBDbzQyRW10L25SWUplaWR1UkdWaXhZRmdrNlFwalZO?=
 =?utf-8?B?NVkyTWxnNE5lVmhXRmFZLzB3Zk9kZ2xTWGNWcTRKbzBOdW56S0d6R3dCMDlh?=
 =?utf-8?B?MndOMCtacndxWmpiL2szVUpFTkhjd3VuODUwZFZ3M3VQTkpQQWZ6djFGOUxt?=
 =?utf-8?B?WGdNdzBuTmFRRkFFWDBQdVArNGNteUZVMzJxNzQyUzdiZU01aVVmT1Z0Z3E0?=
 =?utf-8?B?cWJiU1dGYW5SUnN6Zzk0ZG5VVkNwU1ZTbkxZbWw4ZmVFa04vSmlCYVl4d2J6?=
 =?utf-8?B?ZlRSbHZOMy9hZkptRXpEZG9LRFpCZzZKV09kZmFjM083cXVtUHA2V2dLeThB?=
 =?utf-8?B?aDBvVDFxWmZIQll1WjltMlhEdG8zUm5kQjVDVW02V1BqNFM1TDlwdXlMWUpH?=
 =?utf-8?B?Tk5VdzFjckFDallabFpmNFVOMGhwZjNkN1V1TFRPVUJhVlAvbzUyNy84YmNq?=
 =?utf-8?B?SGM0c3JwNWU4Vm1uYzJFU09RY3lPck1rcVd1eG5URXRvTHY1VWtCbXhKV0d4?=
 =?utf-8?B?QTdyUWYxWnphN0p1WXZxNy9nZ1duMjhCazFjOVhNWEMzM1hhR1VmZWtNZWpl?=
 =?utf-8?B?b25rSkRmbDQzMmgyWlc2K3VFZng5ejZ0dUp3QS9lUVRFa0JsdENMb3BwYkZX?=
 =?utf-8?B?RmZOclcrcE5sbHR6a2kvTnpQSmgzd0VaUyt4Z0hsQWtPMFFYN2UrYlh6WEt1?=
 =?utf-8?B?cllab0VTL1ZyaGNkRkRtdTFhQW9pWWNCdUVhOHVESFdtbHJHb3ExTElITW9V?=
 =?utf-8?B?VFoyT1Vtam15NTVzbDlzMlRUcDNmSmRxUS9KOHI0VFBhNXJ4d2hsaFIwZEFH?=
 =?utf-8?B?Q3FLV203Z1VucmRoMWN0eUFBSHl2UkxLQ0twamF2bExUQ3hvZWZpS1lYUnBi?=
 =?utf-8?B?ZEJJa0pvZG8zdHpsekRzR2RhVkVCSzBIYTJYL3hYRlNUSlB4ZmRkVWFDSGVo?=
 =?utf-8?B?My9BamR6OVQ0NmZqMnNFQU1xTDFUVkRMaGZ3dHVlNTI5R1ZaaXp0VnJkN1l0?=
 =?utf-8?B?QWpiN0F5ZVdhaUFGeUVVTjhHM2V1dkp4VE1tOWRaUCtUbytrNFY5MXY2UFds?=
 =?utf-8?B?WllVVjFWTVh4Q1lBZGZQM0ZzenlQdkxySGJpb3oxd1EyVGYvSEZvRkhNL01T?=
 =?utf-8?B?ckRYRWFnNk8xOWdZTStsSTBFMmkxbCtkMCtaRFN0YkNiNWE1Wkg1M2x4UFhU?=
 =?utf-8?B?L3U1MEl3WmhIam4vdmJ3VUUrU0pGcFVpMGxxbklKZEdFQkYzcjNtbFl2Vjhx?=
 =?utf-8?B?VmpNM1Ztd05lbk45UmNVRGlFREZ4WmlqNi91YU5FR3ZGb29QRlUrMVQ1ZXpm?=
 =?utf-8?B?eGpLQ0JyaW9sb2VtOW12RkZtYzVneHFNYVBMWUt3M3hEMnpHd2ZmRHN0a21B?=
 =?utf-8?B?NUJlb2xFc3hSQmYzZkk3TFdtV1BhcGkwbkxiOVFHdWNwNFIrRm1CUHB5UmdS?=
 =?utf-8?B?YnlvUER3YUd5Y2RWTndEMm1vOUl4VUN3Wml1aGpUQXRLTnpHdEN4WUN5VElo?=
 =?utf-8?B?U1BJZTFYcHo1M0NITElRQjNZWVNFd2VDRVB4L1lNREt2TkNWajJ0Uk9MdGVQ?=
 =?utf-8?B?bWdXUkVRQ2tXTGs0MXY5VStSWmZSLy9BNW9pcUNWK3U2UVdQendTMkZYRUFl?=
 =?utf-8?B?R2xKSS9NRGtBWWJXWEl2bkZwUzJNcXBWR1lSQjZaeWNEVDZHK3ROdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3774ace4-c7e9-4d08-572a-08dec22909a8
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:04:24.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xGCkReZXoE7/AWD+B08FqEXuQOoe1/eTQdcLcF2g/BgSbDbLKtEIrb4COeyBX4HFodwZFNaIjU8OyNpdWdVCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:36:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2991

From: Peng Fan <peng.fan@nxp.com>

Replace ofnode_read_u32_index(dev_ofnode(dev), ...) with
dev_read_u32_index(dev, ...).

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/pmic/pmic_qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
index 92d0a95859b..4b8dcc6104c 100644
--- a/drivers/power/pmic/pmic_qcom.c
+++ b/drivers/power/pmic/pmic_qcom.c
@@ -72,7 +72,7 @@ static int pmic_qcom_probe(struct udevice *dev)
 	 * contains two discrete values, not a single 64-bit address.
 	 * The address is the first value.
 	 */
-	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
+	ret = dev_read_u32_index(dev, "reg", 0, &priv->usid);
 	if (ret < 0)
 		return -EINVAL;
 

-- 
2.51.0


