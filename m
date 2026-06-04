Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB40CD6E7C
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:36:53 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8926.1780571979107925287
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:19:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=RZNJRKKR;
 spf=pass (domain: oss.nxp.com, ip: 52.101.72.25, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uauVGGJIuWu0ZcAvfNYiQCnYsFFQjV1YJQoh2nVwYWbX4ZjPv0jvYt8aMZOJeQ7DQp9Et7GtOyOqBKBdmKSb9phf7oT/L/cfepiZg+hTtvRIMR+deIWVIXssht9/8h+XB49nWe2sTOzEtPzBn+BuLVZBE33euNEAVkY6VxNVUEpd6+GsKvl/Uq9Q614hve581KYSAOvw+9XoOUClREV9ps75HFgvRHrgtyge0BH2NSlKVdWUXDKVVUHZHRqJBsUe/UMYykSxdVEWu7CwNTrU95h/vzCgsgAlAzMFFDXiQqUJqsWnp3Iqx1LAB1vBvtwXVSbXF2EhLEEMBkgCAz7OwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI4uehdYwDNo/9512/rcVlXSHABKnlKQwi+di5c0ChY=;
 b=E6kNzP8eCtVrbPCugPQPt3fTmoKUf/fa4UJ4Rb/F7Otse0RxtdTkMrLJTCrW9Jd1WhTJ/alN+ho7DJz3ygZ6WXwJDuSJ1RSTwlj8iCQWwuKQ4IFJG38iu6yva/E+bD13WzCwi2OPytZMNGfdinxYETH2wZ/ejyNhbt/zKmwhyVZhOQD4b5iKhV9Roj1SIpyPlNkckxXzLuzz6auRz35rC+CS4HV/maVo482bamGe3sffhJUgfnO1rb02EVILMJiaqnMjoEhSXujE7eBkADdsqwlYKGenC3Oe1Odtkf904pV2sK4AAoAE8S5I0pNAMknNF9Yd+4CSU4fjqIP4bNfIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI4uehdYwDNo/9512/rcVlXSHABKnlKQwi+di5c0ChY=;
 b=RZNJRKKR2p7S1TtFOQupeQHHQ5Tc2hfWbRIYwnLYUzqSf3tgmv8ZGNTcP/ihnOhodOMKMCDXiaU7lkDPCNSGQhFjoOFO2BhZHw5LNAZ34bPojJZ2VRkIOzrdPAV+RaZB2WRhgfJz8ueaOoPy4DcQIQoJZrmctNe2DXUqImLBfUhtEKhgf6Ila2hncwjep6VLFl1852crXECChQfzCZdTTYMGOj4gaoRUuTongDxPIPRt/8PfeVhr+OrTVb3YGmezE3RaLorDctg7JN7smq/Up3dESqIZk6O9z/FgAYM1unygJUFEAh0SVlAinpaw6kc9bkNzhvKfpJBhTt6RvyrfSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA3PR04MB11228.eurprd04.prod.outlook.com (2603:10a6:102:4b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:04:10 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:04:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:29 +0800
Subject: [PATCH 06/11] power: domain: imx8m: convert ofnode API to dev_read API
Message-Id: <20260604-devapi-v1-6-961aded05ff4@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA3PR04MB11228:EE_
X-MS-Office365-Filtering-Correlation-Id: ab940d85-fcba-4962-b6ab-08dec2290178
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 0jXTRRvsh2w9/pq9CSiQXPKj40gcK+Z33QKksowp8rR5vUZ0uUZYb411N5UzMRnsD+Rz+bG+A6in4/JXE2zre3a8IxvQ1AhwHCG6qvAsUi8HwCYbDnZzQJ42TLfNKctQfXYtSDiC9KFeITzFZYUUsfk2tswramfuINtZArxeO8HCuR0feBOBdtWEB68y1fLVuoPuHE1lR36xeu/ySaS2/hfNuDlOchERvcC0yUVpGIBHue7hl8Oz6GyzUrUMqkPfBZCr9qgtL+0o9Ts8Z4wyVDMwvLcFU2zx9LVdl1bG1YgyoP39ENrEXiYE/qTETAOlDlNtw9MttbdT/+5Aa2MGsIC6Q7H+wJqfk4VXPyFYbKVzfbF89DvXWDAuOakKXtTzzX77G2HbRmNpc7JlN4ezEvq0cAPAOdrf/NFvVezYK72BFP0jhIZfZd8XsB87H01yvqfWBInqV3F53F7qehJ4e5ULcELhVeg6kPKLCteQfsCCJ3GkepyoflU/D8Jgdpc/pp48teNZCgfGI9N+ljV6gbYS/vpHcTKAQmPhJ4yjY6PWghkKU4n/PbuBu8wPS8JyunT+rf1wpCHzCrx9ECAttMGtLG/EOmuVQwghxWmdeiJZ2bZ7EqTEgT5eGpWSjF3WNhsxeFeBCE7XC6s1E3U3fy4agVtjfE3ohrF0nB79RW/tFaGwKHVgsdJk+p8gzxhbcltJB3hcEQBYpjQ/ivIEZXXgsfq8yNWhAlfygbPvWan8I8eyMjT7KHSGCv2OZS2t
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?OUppQjA0V1RDdlJoRHh5cUhYLzNHY09ab0JXbldacWh1dFZuWnNvRmNhQ1ZB?=
 =?utf-8?B?UG1INDBZZ0lhSUZDZ3dtT0JDSE9BTFlhL1VYTVpyVDd0UWEwbWtNdU1zZjd5?=
 =?utf-8?B?dHQraDlNK1R3YWRJY3FMQXBEZW10WjdrS0ljQlIySCs1VzkwSmxpUE9LQ2tM?=
 =?utf-8?B?WVRSdy8vNFZyTFlseTVSSEhJRFBrdGJRS01tam1BbWZqdHFNbWpzVGxHL04w?=
 =?utf-8?B?N0hBK21GaUNwNEtjdm15eUtJbUtzb24xcE1ldXZFTkJSS1A4ZjN6Q3NZc2sv?=
 =?utf-8?B?QTZlWGIwYWoyOW5MWjU2RXpsRldZYjZmQk9BSnZYV0dKb1ZtVmtSeHdBWHAy?=
 =?utf-8?B?cXFXK0tBUkVZdGRyMFhubXA5WjhWY0Y3am9vamlISXRKdzV5YUVGMFhFNCt2?=
 =?utf-8?B?TFRxNGNrM1RuaFRFTjdCaGNqVC9vL2F0dGdFTHo5ZDg2RE0wbFEzNThiWEJ1?=
 =?utf-8?B?TTU5dnlBU0JPOWZlOWE5dk5ETmZXamRKWGh5Tkt3RmN6bDJiWGlDY0RWaFFV?=
 =?utf-8?B?cWowa3RONllBTXZpYlNuM2d2Z0lqOTBQVzJVRGFoZUZiWE5VQXVIblFFb3hV?=
 =?utf-8?B?YnRUU3pKWnNTbGhIeXovZldnNHQvdzUvVTdyczVoSmRnTHUrL0FySUtvSTVX?=
 =?utf-8?B?SGMvMVZYRm1XNEswQStiTHVBN2poc0xlUlZCVnEvTHFSeFNJV3VKckNScUs2?=
 =?utf-8?B?NjJOa1VPM1c1S3lNUFNXMUhDYmU3RThyUU50WVJkUVpKVEFTeGM4cjJQdWNL?=
 =?utf-8?B?T1E1UGxwYU01d3UzbWlPTkdxSncyWUNrSXNsOUdDb0lhV0tZdVJqRVR6dk9r?=
 =?utf-8?B?Z2lCYW5MMGd4QU00T1p2WTBWVjh2elFxZzNzTFFuR3BNaWhCbDBFNnpDZVlj?=
 =?utf-8?B?Q3BBdklaU0tPZmFZNnhCNW5tS2tqa1V0eWhCN1dQLzBGN3ZiQkRDdmhheml1?=
 =?utf-8?B?T1Y5c2dDSVdXNTZmanNzOU9WdzdnYm5SMWkvMWIzTmgyTmxXRFJtcXFMVlY4?=
 =?utf-8?B?RXdUSWROaTZoMzlxbmR3c1NiZjdiUkJVR2ZaVkVTdUtDRm9VYU9XYVE4YW1M?=
 =?utf-8?B?ejhhK09SRGxEZXJmVEp2QmU1amJnRHA3RkZUbUlsMUYvcURZWWFZVlhJL3pK?=
 =?utf-8?B?ckZUbTVXSWJ3cTh2NTM5c1h6WktxWkF4eis2MEJnVmZWTnF2S1Bzc1RiTVlv?=
 =?utf-8?B?L1NSMGx4SUdSZWU2TlJDYlFNSVdzNGxGcGpDK1c2eW1iT2l6QzZDYXI2VFY5?=
 =?utf-8?B?eC9KV0VKcERVWG1rRW5KdHJrMVY3L2V1RHRDWkNoSW9kV0xEQkVTYVhKeDhU?=
 =?utf-8?B?THZpekJkZkhrdmNSbHNUN0xMWHQ4QXhTOTBpeTJtQ0hLcm1Kek5RbWdUUDRI?=
 =?utf-8?B?aXRlS3FlbzN2bXlFMi9PdFo4Z296TjUxMDVxTHVYWk9oYjNMZ3B4SWN0Y2xS?=
 =?utf-8?B?b0phcXQ4SmF0L1FKWUpvYjdQN0xha1VhTU9OU21Ib1NwR0RBRUROYjR6OEoz?=
 =?utf-8?B?VjdhaVlZT0UxVjRydlZkbklLYXdUZFRrZlFvdnBBZUhxZ2NTeFZ6dytTZ1RI?=
 =?utf-8?B?Ynl3N0xRQXQwaUlKVkRFdVZHTitoSWhjbGU4SklxYWs4NGJhQzdrSjVaakVX?=
 =?utf-8?B?dXEwWUFRSi9FUlVxY1pIL2E0K3BnSEZreEt4SGtsTWR2dk9PUy81T2VoUU53?=
 =?utf-8?B?Mk11dXYvWVJoSkgwckljM3JkdU5NVHpiazQ5OWM2dlFjd2gvN0hDSTFUeGYz?=
 =?utf-8?B?MkgrWWFmL3JBVjR6WnM4TmJYdElQYnN6OThuTkkxZjExbjhYTjlaRlVKRDVx?=
 =?utf-8?B?bUliWnFySjhTUjkzSWRxV0RJR1d2MFZTQ1ZWSy8za1dhRURqOVYwY2JYSUV5?=
 =?utf-8?B?blIxSi9CR3FzZVdqY2JVMnBnbUIxRUorWW5GMVBUZHZBNUpSQ2xqc05UbEx1?=
 =?utf-8?B?RGJ4KzlUbXNOYlFzaVhpWmMwcDFXTEl1OW40WXdEUEN5a2w2K1EwWTZhbXBa?=
 =?utf-8?B?L0hjMXRncW02NnkyS3lrSzAvM293TEI5MlFITU15bC9ReHloVUFCREQxS29q?=
 =?utf-8?B?NmgrbWhZVDltUkkwenFWNkRFM1kxT0laam5ZVUI4MGJpaTZaNFh4Nk95NGdU?=
 =?utf-8?B?Qit3RGFrTTJybGRuUXJpQVR2OE8yaUtLMWhMTHB6SG40d05VS3ZuMHc5VWZj?=
 =?utf-8?B?NkI4Q1NHS2pQS0VDcFF5ZUpsNXA2VDFpWjRYYWpmaTkyTVhsMk44bUVnTWNF?=
 =?utf-8?B?K3Q1UTNqRm5JWlVJWEVBQ0cxV3ZzKy9mT3ZERm85dWQ1QXBweTRGWmZuQUxO?=
 =?utf-8?B?d2ovc2ZRQW9Dc2hYclA2K1o5cjdnSVdra0RlL0NXbmEzU2VqbW1rZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab940d85-fcba-4962-b6ab-08dec2290178
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:04:10.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMvi2tOm312LYgXvrJvDJnw5E9Dcvt9Pr/S01ggtNN4nE/lVCfI6fKygOAVvf2H6wfDxZiEy9NIcyOTu3AuUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11228
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:36:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2997

From: Peng Fan <peng.fan@nxp.com>

Replace ofnode_for_each_subnode(subnode, dev_ofnode(dev)) with
dev_for_each_subnode(subnode, dev) and ofnode_read_u32_default(
dev_ofnode(dev), ...) with dev_read_u32_default(dev, ...).

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/domain/imx8m-power-domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index 5fdb95fb6a7..a3ef49aa67c 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -476,7 +476,7 @@ static int imx8m_power_domain_bind(struct udevice *dev)
 	const char *name;
 	int ret = 0;
 
-	ofnode_for_each_subnode(subnode, dev_ofnode(dev)) {
+	dev_for_each_subnode(subnode, dev) {
 		/* Bind the subnode to this driver */
 		name = ofnode_get_name(subnode);
 
@@ -531,7 +531,7 @@ static int imx8m_power_domain_of_to_plat(struct udevice *dev)
 	struct imx_pgc_domain_data *domain_data =
 		(struct imx_pgc_domain_data *)dev_get_driver_data(dev);
 
-	pdata->resource_id = ofnode_read_u32_default(dev_ofnode(dev), "reg", -1);
+	pdata->resource_id = dev_read_u32_default(dev, "reg", -1);
 	pdata->domain = &domain_data->domains[pdata->resource_id];
 	pdata->regs = domain_data->pgc_regs;
 	pdata->base = dev_read_addr_ptr(dev->parent);

-- 
2.51.0


