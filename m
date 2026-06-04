Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2F8CD6E7B
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:36:53 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8925.1780571976366190294
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:19:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=et80nWli;
 spf=pass (domain: oss.nxp.com, ip: 40.107.130.61, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1WH8FWR8wJDSc85g8rwrCrFf3VVTOEFT9PPWTXAUsoqnzYna5r4wmCoDiabrmN5NaiIUzNUtfsZCDoeBy28h9d+ZvMmBVjQpAZTWfdRuwu718fmX5C/fb5VZgJKj4kSSv1vdBlvQUXQ9tkl++E2Qc3JpTEmkefVxBeSB5JIFf3O0UoSgK3fdZgIvsw8Ke77a8o73xRVtj+7RVZ+nImKU+2JDDMUhmdYXsuraMA/7tZvM66r3AWRkZ8M0ha2z+lfNXZuqzvZKC1OU5qhargHrwT3eopESuXfVe1VaFH/05M7In5ILYMfps9ha/fjU411cNCh5a8t/VVKxkiT8+VQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X39sUDC6pNo9oqMPgf8O8ZE1AdQBS2jHFq/C9pz3WgQ=;
 b=uAmzzfhp8XvvOuq6XvIOLarfYH1WcyAVvqL4l+Kiwk3h2231VWqsRHUhvBn359uieHRRA0Bcux3+qgODHLA4rPZMaQLD6ZmPddLt+EyUQh+L7mB2XDXD+C32zAiBtztjkiI8KvNID47ovcAB8shkHJ3WrJc/zczYkcLkklODdN2axDD3rPtAfvQp2rnR7L0beyDl5O4NS5kEXK8UTVGgTaJz05MlY7EmH1vDRf5TiGYUJOgvCu8eUgKMYIHRjvlU+qLGwoI6wPSShr+fQ3CmWBFmf0txyuv2ear3dmSKoR6qUq9dpHxzKu696mJLuMSdSaA1znrk/ZZOFd4JymSFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X39sUDC6pNo9oqMPgf8O8ZE1AdQBS2jHFq/C9pz3WgQ=;
 b=et80nWliT9x3eJJvnD8BLVwcbjPI34WHSk1GsCpESA56xes2cM370QLv8viFElubwPVue8W5U6KIZeerodBJ2VkWWBy8Zv5Sa2/vbmX6KKS10xMk4ANMe0edYFkRx6433weEzb3Y58SjlUWVWFwfDJy2kfjYTwSWMP0bzSnDlk/FrZ5hM6DK2sCTLmNLLsyXBlyPdeF4jISfdvQlZ1yPR2lcft6CipCbtfi2gHwa+v/ULv/p6GLtrunLnQPemwlWCdFwf2haE7CEyUYJmO/Jif/S9g47TtT5TL/Kw07/MFq3WCE2f00LcR0IilzAvwCBBne12hFXBlVYONxJZ0FjCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by MRWPR04MB11518.eurprd04.prod.outlook.com (2603:10a6:501:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:03:36 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:03:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:24 +0800
Subject: [PATCH 01/11] mmc: fsl_esdhc_imx: convert ofnode API to dev_read API
Message-Id: <20260604-devapi-v1-1-961aded05ff4@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|MRWPR04MB11518:EE_
X-MS-Office365-Filtering-Correlation-Id: caa6d0d8-595f-49ef-5557-08dec228ecb9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|18002099003|22082099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 EBaUKzUyrU3RFzE+qz4VP3eFlI3pr/gGVyyjFFGVzdgCgHXIbu0xLDVgettmLXPG9GhQ4rvGaAP3NEidRguE+/UscwMZTqiJiEdHGu/KTT1V9zw3Lw+QwomwQI0tnyUZNIF145/EwRFl+WNAIrVR0kbBk6J18Ou22V4bNilqJHDkpwg91tnNpBFKfOP8riEXsq2ZM2G3+gY+H2Qa0kPFnrJnPI8KEKRLw5fZbk/iLb2RQSipV+puAL9OT2edQdRC3HJPxMpDn/yGWfeE9zeiSdy0ScUm3jHDy42O+bkpBZdROHlZhH01p2RG2i3bIMGewuJy7zqAFDc1TPzlN9D58TD4se9XtoKALu/byQV3IUeAYE24yUyFYvS9T9StXGmcFI7lUEgABy/5C0jw/7F5TQr8ctERkF7XjCl/4846T262TG6oHQO9sTxPbGNUbhgOujH8IHGGLVtDFZRMcfOFL4Fn7D00YNQ3JdhU0wdPLHP9U/yl/NPYjQsf6uDTLtCvkrNTH+ANIKQgGoNN4mI30BI3+9hUyV/eVzXnI+ob+qJ2u/UhB0QMkxWRyBSffOMc1SVVElYT77PwyTbErxN9Ue1CInb+gGDflmbBiKZ9+/OOwxd9VLeoSrBQc28S241SBEHGB/9Si2JRclQw10Ayu4OqaUGskTf44yaAwpvuuIoa2eLW2K/MCiSCyzvKbTVNY3jjbDQIZsKKaQjgaydIofkfup7cqlyQiD4DnRJ6bMQ10H2uV27lnwJhr4ZxFUZ0
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(18002099003)(22082099003)(38350700014)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?bDdkamUwOHF0bmE1R3lQM25ITUlJZm8vejR2bTV0bHdsVVc1VnBuNzFWS2JJ?=
 =?utf-8?B?ZkFrOVBiK2NDRG9YaVRiMHExNzVhSVBvVnlHZjM1TVRNby9ZdDlUdGdYcjBz?=
 =?utf-8?B?SVUwekhIWWE4VkpJNnlhRGdCY2dIa1BEeWw4clVBcFZWRGtiMlpBR3lsNlJk?=
 =?utf-8?B?L2ZNRmhtb21mWXdWNGswUUxYQms0L0FCeGtVN1lPY2pKckp2NTRJZ1JMNTF0?=
 =?utf-8?B?TjV5cmVUeHk2V3lGZmcwS3ZGY1RXZlYrdmZQamQ2S2xlT0NvV2tRZE1ya1dN?=
 =?utf-8?B?Wk03cUZkL0hnaHRFalhJdTFxUlFwOS96bVp6VTZhOU1OQUVVa2FqSkkySitW?=
 =?utf-8?B?dGhLbUgxb25sSmRnWWhkM0RuMUo0WXkweE9qZzhPWlRPdEdENHM4Y1Jma3Fu?=
 =?utf-8?B?N1VleVNzWFBLcWc4Qlhxc1B5TlRZQXlFZU8zdjFyQ1pNSjdBYjBxYWdaSGdO?=
 =?utf-8?B?SGw5bW15VE5xNklYRCtiL3M2Q0RCMm9jRDNxNnF2TUxRVkFZa0FmM25mYXdi?=
 =?utf-8?B?L1g1Q3N5Vk9MY0pqYlhsdk15YWlrSEZ2ZHpEYmhGc0xTMVBMUzRvTEFuV0pF?=
 =?utf-8?B?WklSZTNpek1tMU85UGpJV2I2SzdTS2dYNHFRUFFGQlV3blZCM0lCWkJrZTc5?=
 =?utf-8?B?a2JHeWRSMytiTktDSG16ZjQ0Rm9yV1VNZDdHcjBDVGhHTytpVStZb2ZNWlVE?=
 =?utf-8?B?L1p2aE9CZnZQMm9tUDl1QUdqWUNyNXpqRVpkYi9Ja2lQcmdvUkVQN3Vwb1lM?=
 =?utf-8?B?MlQ0cVcrT2g1S2g2U1FibnVyZXlkZ0l1QUhZK0lKK0xPSmZob01ENXM3Q2pF?=
 =?utf-8?B?bitBZXYwQVMwbWp4TkNMOFR2UDU4K09yclhRZTQzWkIwUG1TMDZFMkdOR205?=
 =?utf-8?B?RlkrY2F4SE1WTUs5aSt2WFJjM3VDM2xvcjhmV2pwY0ZyTjJNRVdiemJMOVE4?=
 =?utf-8?B?Ulhzd292cG1mWXFrRTFOa2NnSXRPNTd4OW9ZMmlKWk8zc3ZxSUgvSktNdDFU?=
 =?utf-8?B?ZXg5YWxLYnVkYXRFK251ZGNaN1pjVXlIZ2hxSmNyL003NHZhOXM2a2E4TTlJ?=
 =?utf-8?B?d0JDZkVOSDB5VnRCZVI1bGVpUW9kSHpNanBIZGxFbE5WVkNtWnBlWld5MlpO?=
 =?utf-8?B?RSt2NVpMSTliMmQrdHdWZ0tEVThJeUVTb3pkanZ1NUtZSk1vWk5ybVZ1MU55?=
 =?utf-8?B?b3BtUjU2Y0sxcm4wQVl4MFYxUkwzV1dQdi9haDV4c2ZMelYrdEFsNVlOaGgv?=
 =?utf-8?B?NUZWYkpCM2Q4YjJTa2theDg3VFZidDhCZWkwQXFUMEk5cVVMeGdMQ2x1MjM1?=
 =?utf-8?B?NVBhY3lTRG05RURKWTFxanRXdHAvQjVPa2pmRzNRQURELzVWdmJFSUhnak4z?=
 =?utf-8?B?MGNJSUk0QVB6ZnNHa0VqZ3M3VTlLQmFxNVVCdVhCMFlZREJaazhaZnd2R21h?=
 =?utf-8?B?VXhDSHNnKzVpcGZXYUxDc3NpYk81YzYrTlJMWC9YQmVxcC9MOU52NFRLK2VE?=
 =?utf-8?B?R3hnd05DS0szRU5MeEhabjlkZlR1VitGUGJuRHQwVUpEdWVIbG5iOUdEbjVE?=
 =?utf-8?B?cjJITW9NT3o2cU93UjhWZUNmVGF0eCtHUHFZQzcwdGRUcDVMVzdWczlRYzJt?=
 =?utf-8?B?OWpTUFFMY3NpUkNxaFZiQ1dmYlVuVXhJTTQ1WDZ6NngxM2RIT3Y1WE1UVW0x?=
 =?utf-8?B?aWhmS0FGQXEybW9RcnZKaDIzbm5xMnFwSmp6bzNOUEhGVnY5R05CK2Rvd2Fm?=
 =?utf-8?B?SFMxNW5BQTlBMGNSRVQ2cHlpQnEwOWZENUNQOUxlRklFT3FwUlMwRkw0bFRs?=
 =?utf-8?B?akF0KzFKcGpsS29ZZEF2QldCMElPNk1DSnVSRGRJR0ZEeEtNUmU4N0pvM2pY?=
 =?utf-8?B?My9TdWlsRk1hUnJ3QnFjQ3ZURUw2M2FUeCt5V1pUTEJBa1lMQjZxSGdwNk1i?=
 =?utf-8?B?TU9nVFRCTkRpYkRDeFQ1MVY1T2NCUGtFRElIR3A2YlN6aFlGZGFxcFVvUnZa?=
 =?utf-8?B?QkROTWthV2ZPUW1TenpCMnVXT2NCQ0d2UTNTeEovOXdYazd6MnpLYXd5a3Fs?=
 =?utf-8?B?VVliU2wxcjdVWGVLMGtTeU1tSjZ1WmVWclRLbGRYRjRwMUpleitKemlyQ0dN?=
 =?utf-8?B?VFZHbU5ENGJhTVlCY05oWnBsSkVVMWtSajB6L0MrME0vZGJmNDRoelp3b0NV?=
 =?utf-8?B?UTBWZGtYS2diWHUwYlZjRU1STURlWmVyVG8ySEtoMXZ1M1ovTFRxWW1BaFdF?=
 =?utf-8?B?eHNuajFkSVoxaDFOLzhQQUlqblJvMVFJdi81TmxMRUQwbzZvejNkUVJWQUl3?=
 =?utf-8?B?VnJaeXcrN1djU0gwdUliUDN6bW5vWGg0a3ZuV08xa3NXdDI0RCs1QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa6d0d8-595f-49ef-5557-08dec228ecb9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:03:36.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGTslA9Z35sp+j7PxizzMbJ1rZQWtig4Fq1JhSKgClxBfsUnTg6mcpxAQgWWc4+UrmDuc3gFfJ871cKXYwrK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11518
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:36:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2996

From: Peng Fan <peng.fan@nxp.com>

Replace ofnode_read_*() calls with their dev_read_*() equivalents in
fsl_esdhc_of_to_plat(). Remove the intermediate 'ofnode node' local
variable and the now-unnecessary <dm/ofnode.h> include.

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 87125493c0d..e718a17f94c 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -36,7 +36,6 @@
 #include <dm/pinctrl.h>
 #include <dt-structs.h>
 #include <mapmem.h>
-#include <dm/ofnode.h>
 #include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
@@ -1393,7 +1392,6 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
 	struct udevice *vqmmc_dev;
 	int ret;
 
-	ofnode node = dev_ofnode(dev);
 	fdt_addr_t addr;
 	unsigned int val;
 
@@ -1407,15 +1405,15 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
 	priv->dev = dev;
 	priv->mode = -1;
 
-	val = ofnode_read_u32_default(node, "fsl,tuning-step", 1);
+	val = dev_read_u32_default(dev, "fsl,tuning-step", 1);
 	priv->tuning_step = val;
-	val = ofnode_read_u32_default(node, "fsl,tuning-start-tap",
-				      ESDHC_TUNING_START_TAP_DEFAULT);
+	val = dev_read_u32_default(dev, "fsl,tuning-start-tap",
+				   ESDHC_TUNING_START_TAP_DEFAULT);
 	priv->tuning_start_tap = val;
-	val = ofnode_read_u32_default(node, "fsl,strobe-dll-delay-target",
-				      ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT);
+	val = dev_read_u32_default(dev, "fsl,strobe-dll-delay-target",
+				   ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT);
 	priv->strobe_dll_delay_target = val;
-	val = ofnode_read_u32_default(node, "fsl,signal-voltage-switch-extra-delay-ms", 0);
+	val = dev_read_u32_default(dev, "fsl,signal-voltage-switch-extra-delay-ms", 0);
 	priv->signal_voltage_switch_extra_delay_ms = val;
 
 	if (dev_read_bool(dev, "broken-cd"))

-- 
2.51.0


