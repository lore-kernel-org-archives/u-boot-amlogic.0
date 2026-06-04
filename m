Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73236CD6E77
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:36:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8940.1780572025273530085
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:20:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=F1VzkdqU;
 spf=pass (domain: oss.nxp.com, ip: 40.107.162.61, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFe2M/iEomYbEZQL/RC/axhC02VeNtgjC5Aru9a2QyD2b0CNLFJAhixeyj29Y6Nn8TBllYLviX3It6/33tic0GCXPS2ybK5RZmzKIZ/g1d9CLgsFXPQXiPjXF8qmBap+U5HaBmwkADZ7iwuawj0sipb50IeL76aoVqtUl3creHJmLDqmbmXtDXZ0MJiTnGiqq74APsU6SQ1Rtx3/F/RQJbAorNHvPT22scD2rw/pHn6UxYVhfddNZZrA3aoH7mtMeuAI0TgqEvFscDGUpIHQEu9MOH+k0vFxQZWM6jPVlR2KRBfxxVcVRwbQZw0DbzgktMUtgSQrJSo2LUj/VFGTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmy91xF17tPEraBV0IAcTLFVZSsEGkjSDdd39J4S7Z8=;
 b=sxCe4Vl1hgNF/zod2MIzcjRPM7hxR26oL7XxkVwvJhsw7RQ6huLpF3vc55DKfQw6Ibbqhl+LYVJ1Is9+2k7Y1LvUNkIW9I+PYE4V1y8q6CnP8oCqp49OsKxIGyhgITyNrRj5hySkY6Xp+JYEh7E3VYpl68mT++gVhsIwZGvkmdPBQ+ijYEqR2gAxI3RFwM1G0+pVy4YJ+VYHaulnCPaKsaqO4Smp1KqtDrX1bqrRljVhKrLUMWOdlyG/fmyNEU+DhbKtEG/B0KzFvz+EP9/HBMg/k2PhQoCRvxRyQrjinNv66SUax3miNa65iT6t4PPZwqSVmLXXQ/N6cSbB1aa5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmy91xF17tPEraBV0IAcTLFVZSsEGkjSDdd39J4S7Z8=;
 b=F1VzkdqUHtt2FajGiIKnqLdb38w1jnRg+Mb7Mrx5I+GE7QqsT5AOKrgo7kmavfEmrOT3Ejc3ts1s8HUaWQKK5I52jWxc3uY0GLBoFb2FHhTtqS7ondt0u/DSniIGoBsRP0IeBFEEKAeA5DY3pWv9M3tnE964HqMuMu3s2HFoty4FV/j07OAixbCLNLfUegrcqFQT/XpaasLJAFy9oCC99NyxSqRlvOWtVK1xAs60Qwt6xf+I/y2/Dkxzt2BU2RKmrLf+uwQ1hnMVolPQCg5TSVhDdX7yssBOZ6eWlw2+tBZci/F0DSzc/EXMdz9RUyYjz1dlOTi6kGaH3KNl39m9FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:04:38 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:04:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:33 +0800
Subject: [PATCH 10/11] power: regulator: qcom-rpmh: convert ofnode API to dev_read API
Message-Id: <20260604-devapi-v1-10-961aded05ff4@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41851110-65ae-4bde-09d9-08dec22911ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 j7gsWJQ7/lJUz6ASPBmj2CI3+7NOReOUmxcFlpYHh8/PJVXECvWaHK8gmu5FFXFfC5hWoHd7zBPI893KjuubQST2EOIHwBzaYhULNWDKjDJKEJBc0yADv0x+VXfrpB2mSrJvWjSI/ANcuByinmK/UHDHU+REDZvrHob8UZllKsAqCU03YUftBLBC7Vdu3TzZ/pG0wOPtxgYDWKn9WJk5nD+deNo3zC/sG6KnYp6o98BULmueYJLYDTDufwdHO7wmuTE/XdNYw7R3yy1qtYYoRFrDghUYfQueGtx7YgKEyMJCBPvzlqWIf4XZrjiFt7NcPl6ld/pEa1cZWnkkARtDbplbWLEcaDa7xaOKNabpxxH+H3sD+VH+byY4mjMus253Eus3AAkheAuCrElyQQ2Avda/AGH0zRWk8Lj1REyF5Zv7TBMhOMIpROIQhpUu4x6z9xJSMD+YHmQgfrrGzWaNW0hJZkg+21Rd/AfueJ3i8XblTEWg/sMUfPTo5fCxiirOwMk9fGv01loQl6gmeGif4F8qpX3SzfTny3Og+oDmwP7WvmHYE/dyOxP578qUsJp1XI+pkGaNXwEm+GgmYxsIjJaKVU99zqWuMHwLiSC/tH4YOt3CIcFzRUSXti8JIj9hNN6TzaRQz12VgF6zmmrL7xPaBV+i4mAYBqdvsMhiwg6rR7G4crX5FdCgNf+jTXNH6SEuYefXVoUx5ZbTUQr0a1/lBOzsDD181UHABPGsrH5M5sIkzzECG+NjgjoWOeds
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?QU43dHlLZFF1SEJPL3Y3SVRSckFMT2ZKQXNxU2xDYTRXejJsL0FweXk2aTZw?=
 =?utf-8?B?T0trdWlWRnBrYzRNakROWFRMbkJNL2YzSXhub0NHcC9RM0pOa0ZGb290VzBZ?=
 =?utf-8?B?a0ZtLytWcVdYWE1LQ3hQTkR2WUQrUSt4RmIvVEVJenZyUDRwNVVZcENQUXFQ?=
 =?utf-8?B?NTZKSVJqZ1BjKzI4YW43dWs1NzdTTzRvWTFodHdZQ1kxVHAwemVDdWxMYnBB?=
 =?utf-8?B?YS8xUEs0WDdKY2JpNkhtU2tjTkgxU3JlbjV4czljWWwyaGVOMjZLdTQvcVNr?=
 =?utf-8?B?dXd2L2xyVTFxTVU4c1ZIR3QraG14dUlVUlBWMGtzQTdzVnRmSmRzZFhlTmw0?=
 =?utf-8?B?VERPR0xiakFyZWRpRHREWGpmeDZwaVlJRklBRVNvVitSdzRCS3RaZnRvaFRE?=
 =?utf-8?B?RkJhaGtiVm5lRU90TUNkQ0o3ZkFTL3JkWjNYME1YU0pDaGZXTmxBOW1pZGdN?=
 =?utf-8?B?RHBGaWphandiZnNFUTdVSTVGL2lHKzhOQStpZGhsMnd3RDFyZktHL05uOVUy?=
 =?utf-8?B?c2phUzFhNXFlY1ViKzFEUkt6YnFzR3gxOStXYTJtaHc4M2ljV003MFFnY3R0?=
 =?utf-8?B?ZkNtVzl1ZEI2Kzk3aldkTkp0Rkx4aWYrVldwejA4RGhrZk91cnhLdGt1cGQ1?=
 =?utf-8?B?WURleHZyeUtTSkdDdzFqWkJJVUJYQVQ4T3BpNXY0OW9lRVhvdHh1dXRvL1JO?=
 =?utf-8?B?Z01ZUkVYUXZUWjAydW9sUXpBa0dKdWw3c2owZ2ltVThnSm5kbGVrOFF2VGZE?=
 =?utf-8?B?bnFJZ21Ib0diYnlZUDBZaytTRUJZblB6ZEliS3I2NmhSS1orbnNHZE9yT1Vh?=
 =?utf-8?B?MkkvNWFJZDhnUzBrajdMVE1xNHpGM1YxL3A1VG1lOCtXOUJaaDFoOGR5a3pP?=
 =?utf-8?B?RFhjT2FRUEJXRVBqLzhxYnBEYXh6Zjg2a3REeWxqRzNhcjVsUEJMLzBWSVRD?=
 =?utf-8?B?enZLa1J1bm83ZmE3eFhablVTTEo0SkN1R0dDZTBHUGtBZGIrTVB2VW94ZXhw?=
 =?utf-8?B?bDBlTlBoUllwOVJmTm5ZaStzRFJFN3lRdXN3Uy9QdStPNWJHK2t0U1IwSnoy?=
 =?utf-8?B?cU9XcXo3SGxIeTRuY2FBbSsxNFZ3cm5zTnNwb2N1V3kvTndBK0gwU3RaMUZI?=
 =?utf-8?B?aFA1SGs5b1pZa2QvMHQ2U0FxeXdNL3BEV2x4MEZHZFdycENvL0pBMnRINC9H?=
 =?utf-8?B?bG5PZUFLbVlyNHluRkNyek5IQkxtZUxCanFIQ3FVUm92NVllL3l5akxBN3hH?=
 =?utf-8?B?NzdhN1Z2REltR2RhWC92NytGWHcvTzV0Q1Uwckc5V0VNaGJzd3FVblBQbmZX?=
 =?utf-8?B?R1E2TnJTYkt1Z2dycjM0TXdUWGJDZWZNejNkaWIvZG9JeDMvdDloZTNlU3Bl?=
 =?utf-8?B?L1h2R09tc2pXNjlRWjFpTlB5MFV5em1UUE1GTVU5Rmd6ODB3SFZIWUxKemZX?=
 =?utf-8?B?NlEvZmRyZ0t0TkdOT1RPWGNxM3dLZ25ZMmExVEZ1cG9sb3JiT2VDQ1AwUWgz?=
 =?utf-8?B?cVlBRnFmUytwY0dEM2pCdVdIZDMxKy9kMGVWWVJLc1ErSmlHeEJNYWlDQVlC?=
 =?utf-8?B?UFZ3dG5WTUZoYVkrRTJaRitIOWdyUFVjVEIvYXk4WnQrMlhhY3R1YXdmR3dC?=
 =?utf-8?B?c3J6aUhpWmdkdERKcUI4UnlPVlA3SlpvazJSQlQ4amYrbkFHYnBTdkcxNEZH?=
 =?utf-8?B?SERXWXZrWFZPNHZITmVqOUwyblBraE5kUG11WDBiWVBkL0luZzBSQzdvK2hK?=
 =?utf-8?B?cW5tT0duU0dHb0dVQnVwTmJCRmY3dnhhN1kwMkhNM0dVemZqdGdJTVQwbkR3?=
 =?utf-8?B?UG52ODF4cGYvZ0lIdHJJNUJaazZQcFhjQUtkcGFFK1RWeXBsOC9xVW9nWHRo?=
 =?utf-8?B?b1dQcTBHMk1neE1LenVYVytxSzZGd3E1UlJaanRCRVQyelNyUklYWDZFZU8v?=
 =?utf-8?B?OTZLT2doWU5lTk9RMURvQllZR3BzM2VHN05jUDBwMmRuMEZxUDFIN3hpSFdT?=
 =?utf-8?B?dWh1N0p4SlhybmNrdDhyeEVWcGJ5QkZ3RFJnWHB6RW9KWnlHMzhkZDJ0SCtk?=
 =?utf-8?B?akJLUENFR01pRzg4Z0NaYVYyeG1BYUE3Yk5aQkQ0RTBTUDZTcUlEOEozK05j?=
 =?utf-8?B?U1RzdjVzOC9yQ04vL2ZRZ2ZPY2FjZTFiSS9NYnplZTN4RlZRRUtWdHhtQUV2?=
 =?utf-8?B?b3NzZElvVDU0R05mL1BtWHJwQSt4em5KMlFmVUNESXlrVkd2NThaaS9xR01a?=
 =?utf-8?B?YkhnM3dRRm9sUVZPZGlqeGJRbTFKUTIyc3RBWE9PSnFOM0VENXlUdTBJMzFV?=
 =?utf-8?B?eThhOGQ1UEdXN3htaTN4N25xK0VEQldVSnhYbnVzL2dTRXFRb1grZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41851110-65ae-4bde-09d9-08dec22911ee
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:04:38.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBbnaH/oLzR5jlKZFJmY+KhYMruhehIyHyb69Ix+tpNnCEWEW36yZmg7c7w2joz6gFQKUhq/Vyw4b9BZ4yPAiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:36:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2993

From: Peng Fan <peng.fan@nxp.com>

Replace ofnode_read_u32(dev_ofnode(dev), ...) with
dev_read_u32(dev, ...), ofnode_read_string(dev_ofnode(dev), ...) with
dev_read_string(dev, ...), and ofnode_for_each_subnode(node,
dev_ofnode(dev)) with dev_for_each_subnode(node, dev).

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 4d65aae1690..f1de660c3a0 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/err.h>
+#include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/device.h>
 #include <dm/devres.h>
@@ -882,7 +883,7 @@ static int rpmh_regulator_probe(struct udevice *dev)
 	priv->hw_data = init_data->hw_data;
 	priv->enabled = -EINVAL;
 	priv->uv = -ENOTRECOVERABLE;
-	if (ofnode_read_u32(dev_ofnode(dev), "regulator-initial-mode", &priv->mode))
+	if (dev_read_u32(dev, "regulator-initial-mode", &priv->mode))
 		priv->mode = -EINVAL;
 
 	plat_data->mode = priv->hw_data->pmic_mode_map;
@@ -933,7 +934,7 @@ static int rpmh_regulators_bind(struct udevice *dev)
 		return -ENODEV;
 	}
 
-	pmic_id = ofnode_read_string(dev_ofnode(dev), "qcom,pmic-id");
+	pmic_id = dev_read_string(dev, "qcom,pmic-id");
 	if (!pmic_id) {
 		dev_err(dev, "No PMIC ID\n");
 		return -ENODEV;
@@ -941,7 +942,7 @@ static int rpmh_regulators_bind(struct udevice *dev)
 
 	drv = lists_driver_lookup_name("rpmh_regulator_drm");
 
-	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+	dev_for_each_subnode(node, dev) {
 		data = vreg_get_init_data(init_data, node);
 		if (!data)
 			continue;

-- 
2.51.0


