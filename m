Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD4CCD6E79
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:36:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8916.1780571947801174846
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=N0OS0/IW;
 spf=pass (domain: oss.nxp.com, ip: 40.107.162.39, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6llzfdEHrtDspcFMLCcxTNQTGjssNHl78bqui+Q/IB8lKh7o2h+CKQAuhxzOVOjY8gWnRXnSiasfTQwO5AA4Tnar6xEGSASsV7dsH9ItAB5HK3HMUPSOzvC5tHNNmxmrNTtRA6LLEJhow768sRESfaWg9xbNCIFuVscHHL0kkdAll+irPMX1JADi8r/tNLk9W2xa3aFXlkgipf7SaLmHbXE6hPcuVBzopN4FJUsykfPJ8TTYJ75dn/mSOnuhkVEVj8NHzDzGvlYBewG3wtG8d0T/JPH2aEh7XJNUGAT0xUYhhLg5+XIK0x8Ua64Kz3h6xd6bRVR6Dn49Q6tBHU/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYoEsSBCpslcm5AIHM9p05hmhuz26xHD/glqILmwHk8=;
 b=S31C1iPJUbSdGGlWwIByDBbVDaPXi/3vkI5yGCzF+Iym+Rj3V4cSlMgKH0QM3CcVTG5mWiv9xcL2QO9xBH2oMzPDU3I6yPRO+LsF8O5xGmE6sky7l5J8GQKYuaMt3qvc7A31zz3YRjZh5yjXSWUxbSJAKItNLM9sTXV5nB/j4xtkAWRoRsz82gGNebfuoNbsKgO68MbL/CXpBcYnkYzl8UOBI7Dm7FrswLJmbWx5UYQyp3peznlYObfwGx/GvohfBsrMICws3IC7Xla9VbtKHL5hlNQ438SjFAuSCfz0nHu3V33luE9T/ENMY7NbHI2rw+7phBvclGMG7TSwx1PpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYoEsSBCpslcm5AIHM9p05hmhuz26xHD/glqILmwHk8=;
 b=N0OS0/IWrBMEBIbatjV4Zep7f7zInd2LapxoLmQ5+9he4BTuPiOi2xQtGCFvUdubnqrKRKE7fKK4CysN1FhAKCgbpZxnekTICE1Srjdnce4q6Bh5ypQlgborjXevJkHjOaF6u/LrhOZBEMn4O3jnjUP72LH2zhsD+AKmPYfAYJ6v49pqw9VSsQZkLgkmlPjoGsFgELkakiB05t1ot73T4Dt5inNrW2N932z+3sQQHUNi2CUcv4PqSaQWDiah5w8GxyBPrKvek9/rqxwUiCGrPBTqKh/C96gqFqXqXpVAweejAK1isELEdq17XBcwpQ/02O9Yb7UdWPbSjfSktAEx8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:04:17 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:04:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:30 +0800
Subject: [PATCH 07/11] power: pmic: pca9450: convert ofnode API to dev_read API
Message-Id: <20260604-devapi-v1-7-961aded05ff4@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f4e6aa3-3dd8-4f6a-f5d5-08dec2290597
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 kDxS0qkkA4CYf77As2cHdyPj5/hgEzcSPUUz/zVowv8CaQK7R4WRJVDBouhzwepcGU5fU8XNCcNFqB1q/tkX8rE/0q+SZrMlIcOm9SuaiJjYtFXBLwp7+hGRik1CzJoWJj/aColmS0beygwlCuoBi75ZpFyTf721wbg1W1TxbFTsB5RsvCnSVU4VaWwMVB2iEWmLErYPpWUllxCnE5x/+CPkP3t7lcpZ+nzaAlhGrq2+0tXVC+tp2LXPDE23hAa4HY4TH/a/wVKvqDC7elCL+8d5VEfU5pGeGQ+4ROLUWzdnbeFuA0NvH+Bqy4tPAmO3x11ciJuQqmhsne0ENYQZIHFyfA0VmsyvvO/9kabB7bajMsEUdiLKbtmcKZjLBscYI5qvAaGbLNl340+4pa2iu+yL/eVVetGAOntdBW5PdlEBPwPV+jU2x9ExpJjJ2dWUsqmqeyseWdvrkJoxa851MGVTPmADstMY63WEGo6cNFcaYOMxX4HdcZjumcZu38Rt8RFNJVjChR1XXnCca4IUXj+g6H9SNIhxfijyOVqtWcUPgEeOTNtz1m5kfNaajTRwRagrQ0piVBzJIIyQiUU7q6itxHrxPIlXlyJFct4nohNMQvk0Bs+tPwicSe3xLhMoeS1PCvhqm8j8C8c+yMHI+NAwxIzJFclNQp69GLTmualeKCrLlSVuv/aJIB2/xgBkh/L2eqDvMOa5nKmY/PK/0Xe6SFLF6LQF8vzIJ1mexQwmXiN79Q7tC2zggjMEJFYk
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?Y3kvNDB6TytKTk9vRktoaFVrVFpaamZKcTlRZ0VxSmIyOEdYVW1wempHcnZl?=
 =?utf-8?B?eDZSS0hkMVVJNnFqZXBza2Vhbm5rdnBidU5YbGRtOG1BNWVaNUF1NHdmemw2?=
 =?utf-8?B?amNGYzlKb3VwcFpWNWJzcXU3eE5qMkNPVkdoTGptZ3V6elR4eURXWEhUdlpQ?=
 =?utf-8?B?YzJMaWtnRFRSaUhiVGpESjY3SHVJRDZYc0MvNUVPbHo0ZzBnVVFtOE9jdFVQ?=
 =?utf-8?B?STFkWmxmY01JZHFQam1HdTVuNnp6SXE1U1JuSzJyZDNZeWVrMzlGRjhaUDE0?=
 =?utf-8?B?dExDVXVQSjduNHdvazdIVFNMWUozSWFuNHZiYWlUelBjUTR3NWtpWmxUMlN3?=
 =?utf-8?B?R1V0YytNME5nSkpwYlRNMUpNTWFWdHM2SGQyLzNmN2lBY0pMUGk4UGNtemdo?=
 =?utf-8?B?U1JBTlduUGdETnd5MHc1Ulpad1FNVXFSZitLaTFzdGYwdjd2Nnh5TVBZd25i?=
 =?utf-8?B?YkxxL056ZTVIT1NNbHNmZ1VpK2tYbmx1OEQrNmE1ZHFneEFkQWp1Y2I4NUdI?=
 =?utf-8?B?MGJEVFZNZ0cybEUvOHpoZGRyUHRXZ1lPR2RXWDBmMHVyTk9laGwzblpybURI?=
 =?utf-8?B?Znc4cXV2d09BWUphQVVFZWlUTk1jL3FsUUJVbENpdTU1SnJJNVY0RUdvTWZS?=
 =?utf-8?B?RTdGRy9nYUVVdkwyNUt3NGkrK0dkY2tPdmJPSlFINDF3eDdRRmJtazFsbnFV?=
 =?utf-8?B?eVQxK2tJQkV2VHZLbzkzdVJvalU4RU1IRHRTOWJFY0pmYmZENGF1dXZyb3Va?=
 =?utf-8?B?RVdEVWZiY21ic0RDY1VzQ3RCenZFVGxCejRRUlBWVDBVZGZxT0VtUGdlSEM1?=
 =?utf-8?B?UnR0R2VpY2cxUUoyanpFamVOVW4wNHRjQlFYMHB5VUhQYithaVY3NDZ1cytU?=
 =?utf-8?B?U2trMHlwZ0dXVi9QcUpTZGRjSmhiZmNMankrdjZkUkpvSDFjMmMzdU9PZnA5?=
 =?utf-8?B?N0U3OHFibXpMdStib3N4dlZXU3lJUjZsS0g4aVNiQjg3Vm81b0NoVWFMTWM2?=
 =?utf-8?B?OVFjaGR0Q0k1bHlkODFSdk9ab2xPT2VGZWNMSzhhaEpRSFR4eGtUYTVyWFhj?=
 =?utf-8?B?S3ZpaWlJWEVicnNwOXVFRzdVaFlUSXY4Y21iYjZTcTVJUHpZblVqTDVNSEZh?=
 =?utf-8?B?UElxUHBKMzV2dDBCR0k5ZmtoQ0tzU00rTGhlNVNUSkkya1J1akVCVnhrZUhI?=
 =?utf-8?B?dVA0cjVuY3JWZzVoWHlRUjdIYjkyNnlaM3Q5aGFIbm5ObEQ0VFVxYkVzY1hS?=
 =?utf-8?B?SlhOaWxYMjEyYi9IUnVvVU9hRThzYVVuNmhKenBjczJVTmpra1grak9ZYWRq?=
 =?utf-8?B?djg4TDdncXpVeTVnSTlOU2tQem9VVitHWjZiaEE4RURFcGplUXMrZ25PSlNl?=
 =?utf-8?B?K1locXQrMTJPQ3k4Z1IrbTlweGFWaUlPRytBYmx4MVFSUEtuYjE1SFg3dGJM?=
 =?utf-8?B?aE5lWnJJeUJQYlY1VldqWUNSc0JPL3BYRmd6SWhSeGN5dUliYXRKbjQxZDc3?=
 =?utf-8?B?YXd2NVduejU5UHJHdUN1SVVuUTlqRzlwZTdSc3Y2bHVtOFVCV0JUb3ZiQnZO?=
 =?utf-8?B?ejZ0YU9zVUJRcFYreEY5MVl0RDF2TW9yNUlKSG9YZFNmeGh6QWhNK2VqNHdu?=
 =?utf-8?B?UU1yWWpQRkcrbmVBWUJqaW5tK2pSZEJmZ0JLTkRFTjJLUHNud2RwRjdWRmE0?=
 =?utf-8?B?NGw0SEl5Rm5MczdGL1pyVWRZcHA0c3dlalN5UExscmVRanQ2Z1cxRDNFT09F?=
 =?utf-8?B?SytDK2puM0dSMXFoUmtkMC8wVkJEQnBBbTZqWWVIbGZRa3dvQlRuTXRyUjFa?=
 =?utf-8?B?TEhmeDlPaWREb3FSSHg4bU0yMUxoUEIyTHNOSE9DU3hRaVlKWjhxT3lVdHlY?=
 =?utf-8?B?amFuVHFWcjhBNDNZcGFVZDczN3ZrVCt5Vi8vYmk3eTB6RzJtL0pFYTRhekJG?=
 =?utf-8?B?ZDMxVkl3MTVhSUVuS3dHVnoxRENGYmJZNHdIMlJIeUtpQmgySXcwaGZ1dnU1?=
 =?utf-8?B?VDBuU0hpUEI5K1pFVE1oS3dNQXhyRGlhNkhBNm1FOFZUb3IxSXBrZ0VqZGpq?=
 =?utf-8?B?S3hBU3FwMXRZM2tQRUdGaVRtUEowSFJ4MmQzWldUSUJpQmxrMk9jbWNMZ3JH?=
 =?utf-8?B?Yk1TNlV3enFtSjUrYzJDWUVhZzFNUVA5MTVFbVpINytDNG9ocUdOUEtscFhj?=
 =?utf-8?B?Umc2T1NuT1lHVlFkZHdwb21pUVd1NlRHUkhwSHovLzJPajZ0N2hGUjhobkFL?=
 =?utf-8?B?YjBUUTdNbVdrRUdXWStvcm5yM1VMMDVGV0xGWHRtRDF0ZTcwQjFKZEYvcGtG?=
 =?utf-8?B?MHBYd1VCUGowNzI5Tmc0dDdKenZ3dXZyb0ZYVE5rVC9jUkttbW1VZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4e6aa3-3dd8-4f6a-f5d5-08dec2290597
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:04:17.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qm9pBqiO+C8j6qR7l22PLBzvf1QrKB85G6na4LixW7FwyjNO0sbzO0whzYR8HarAsJSU9BDSf7gLdAGY2xvMAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:36:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2994

From: Peng Fan <peng.fan@nxp.com>

Replace ofnode_read_bool(dev_ofnode(dev), ...) with
dev_read_bool(dev, ...).

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/pmic/pca9450.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index c95e6357ee8..cbe8cd05be7 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -90,7 +90,7 @@ static int pca9450_probe(struct udevice *dev)
 			return ret;
 	}
 
-	if (ofnode_read_bool(dev_ofnode(dev), "nxp,wdog_b-warm-reset"))
+	if (dev_read_bool(dev, "nxp,wdog_b-warm-reset"))
 		reset_ctrl = PCA9450_PMIC_RESET_WDOG_B_CFG_WARM;
 	else
 		reset_ctrl = PCA9450_PMIC_RESET_WDOG_B_CFG_COLD_LDO12;

-- 
2.51.0


