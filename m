Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A126CD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:30:03 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8905.1780571916041386907
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:18:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=A5YwSIeh;
 spf=pass (domain: oss.nxp.com, ip: 52.101.84.56, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmXYcpHDjFhrq5hhrGsAUVsxn4eGPIg10RqbZ7nyUVVaJWvRHm5/hMLV6Vg8yYFRUpK4xfWprf4QWHAIuYRnJ9e2t2Rb5MclBIDUebt7WQFPADQINVzu7cD3Rrqw06E+q8wMYLR9O1+ptTAv8qL3QKVG6wguXmRpHV5Y7SXjuCN6xSWpK1origKEqEp+hobPajbwsgNTkdjWUpVmnxs/T2sK5f4V0rNenBLqf91PkOrv2W1X3+kXTywRI73gS3iEEfd1zZ/oUjYfWURoFEB93apt0esKFLs7Ex/f1E0aID4YYFKBXCnL99SeRqUZEl+layrgq075dpdtE96hGGzzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wlqLUSaNJI8cGFB5uWlxyG1HV3F0rOOHHwTtNDwtWo=;
 b=lYDRwDGQ62S5lyXGCfd4PeBTU+rJMkQrB070dCld5HH61wnOZzDPnOxpcg8tmg/T7VefWapspKgj6Hl+xEcu9LTqoyJkb3U2YWSCYedcL119yzRRyrXfCHqHlHf2TwRjy5d5w5BWvueUcDZqPd81PtvdYUf8Zed04ajjjxFpgGPYdZ/jC5Jf9HGHLGI2VlcoxkNewjjFQy7HzSE9+EaqwsrAx2YPXbM/ZC6ItE3fbJUNV5PpC3Gs7HlAYZS6WHphygk9iXM2M7NIB6TaFZ9DNYgyRIhE/30m/XtLpNzVUjhM7JeQKvQ6vsKBYW2hk+TqRJOZ2oQjvKQIO5ONp5njGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wlqLUSaNJI8cGFB5uWlxyG1HV3F0rOOHHwTtNDwtWo=;
 b=A5YwSIehtsUETEh7/+ZLH4AYpUerwzTe3n65R2WKkjiCEEgVVEiyq4RUSKeMjEQVsKA27FQwtjkSSn/w63i71WrWG0t+h/zRdeai714uD94376+f3CGn2XYVRUEXRy2OaSnRfj2c255y/rpmsvKKv6fKxYShF0vcJJZeM2GaNlUN0242HpFFSWoCE5ALVo2PKRngvhliL2hnw+xYHQlSOnI4QMdDF+BEvvSaQzgqHrmRCNmEfH4IGx+Kqo3d1vgGfQXfocm9yY0agnEuYSu8KUABDiZl4GV9cUD9xYM2oTpA1I4+jaNd1qAPlQtpN9TOy8l6pagPQIqaHjYih+oYmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA3PR04MB11228.eurprd04.prod.outlook.com (2603:10a6:102:4b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:04:04 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:04:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:28 +0800
Subject: [PATCH 05/11] power: domain: meson-gx-pwrc-vpu: use dev_read_phandle_with_args for hhi-sysctrl
Message-Id: <20260604-devapi-v1-5-961aded05ff4@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93b42d8b-ad49-4476-599d-08dec228fd67
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 ifr7cwMLIqca/nK3kxH/MP2jkaT9knMkamAcPduwsvgIMq6++rEHUX2rD5ZNaGnHRg3X05/zpKMxh7VoH2CN6QRAaPVaTkyATwEDgAio5FmFsqkToVQvNFONp29nzmZZJfLOyyZMj9sVGgl9gw6ipmAIMleexM2huQsENm9o86swLKPd1L7FmqK85Ox4qpb7Ge6aP8z4wMcZeb4KI7d6mH+dJymVZBx4PKwaWxn+gSZxJhLP5i7hfAWVtTRtY1B8sgr2McHcYT5hHcdmQVJp1W3kFa871MX0LuEyUXEG/0f0pIHMOQuzZdCEQ6uUhi/K3BF7I0vgvTy9uQyOJI+tPTW/zlmVUN/SpbrHEqFJ+CnALgSA4XPcl0AQnw9uOQGo1WtQXMs+sEXbWhbKC3QkRJZd+kyc4waFcq1YtwFsa/Tjb2qjcDvJxYdG2B7kwMMcTc0Wkesk1B8U8Vl99i3+4Dt+0FFgcIQd8yshl02UB7qiR0eIMrT5jMgTWuHIjpJEEhiKDNGEloskGMOOKjXly8RxdsrP46+7VgNZ7BJL391XL59MWGWc7rZhx5JnyqszPPLMZ4jskFzCUe8wv9tkCiFIXZAm3B/lYsqwSg3znONO8m65EufrO1jNCVSDFyMDfmIqoB2kjhFb6TvEmrj7MA605zAXPap6HrTpynI07eolJA+YWqgC3UAccWynMSzBPM8psZiJca0O+hrB7oGDpcjd28FZbLqBoiU8unzEDwmuGZwOGk/8wm1snu1KF1uX
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?SjJzRit3Slc0QkZOTllTa0dvOUVMc0dWSG1acTR3SHliWnF5d3RPeWxoUWFz?=
 =?utf-8?B?SmtuM1RvWG1HQjIvaWI4V3IzRVpnODVSR2RqL2F0QmEvbnFRNGpyZHMvQk9m?=
 =?utf-8?B?eHJrcGQxM0Y4R3UzVnV5cnBHNjk1UXIrTW1FRnc2T3ROMUNtaE1LK3B1ZVRa?=
 =?utf-8?B?SU9ER0ljbExiZ3Jab2s3K2NtT21oQStoTTVBRG5CcG9QNG1zQVFaWVVDbTBJ?=
 =?utf-8?B?NlZOeXJBWmtlYTdMWUZxeGhqWUJYeXVJSWdPM3NXemRsUW5qZjYrWG45SVlO?=
 =?utf-8?B?cUx1OWxydU5VT3RzbE9rRmpEK0Zmdm1KUXIwcTRlYytjc3FSV2hsb0N3SCsy?=
 =?utf-8?B?OUNpVEF0dG95V0hVMUtqU2NzSVRUUWo5NnBVMERTbmdPZlBIZzlBR0w1M2sy?=
 =?utf-8?B?d1FzSG1tQlQyZEJBSVZLMGVCRVlwY1JPTFZOdHZHQUZKd1c0ay9IYlZBSG1C?=
 =?utf-8?B?MHU2TmNidTBLZGpHTExJb2FmVWdwOUhvZ0RvRGJ3djhhSUlmajRWVzlPdmxJ?=
 =?utf-8?B?U2tjRHlTWmdHYWo4T3dpTlloZ0pzNUpnNmVBMXJXeWd6bThodVBmVS9JL3Zy?=
 =?utf-8?B?bk1LTDJoaDF5WjN5ZnRkM0VETW5CZ1JrZUlxSUJSMTdYNU5qbm9oYVFzRldB?=
 =?utf-8?B?ZmdkTTROaUNIcmpDWUpYTUo3QVJPQ0thNW1xd0tCRXFTcDVzVm5IaUloTWl2?=
 =?utf-8?B?MkN2MzdLendHbkhmbkNkL0QwR2tFV2VQUmZWTnFqY0pCNHBBaXFmUkpLeld5?=
 =?utf-8?B?NmYrYkh5UzN5cWJlZEdwREdSRVhpUHgzOXY4N1g4TXR4OUM5STBMQk83MTl1?=
 =?utf-8?B?bTdNUlNJdjVKc1R0K1VQMWF0am0vak1FdCtha0FQM1lTYmhjOGdpOTE4RTBo?=
 =?utf-8?B?cnlNSExncURodmRyajFacVlxd2NJckNJTk5wcVE2NE5uY054UVhvelpLcjJ0?=
 =?utf-8?B?cEJ0ckFxN2FaYUU1WWp3SE9vT3ExQ0tJczg3STAvYWU0UFFobnZSRlFwWSs0?=
 =?utf-8?B?T0VCK1dsZmVYaGRqMU15aDh1cFFvU1hpbEVGOEtLL0dXWndMSU5hYTRDU1RU?=
 =?utf-8?B?dTRIb1cwLzVLZEY1S1ZHVnR2OS9wTEFDckRjRlR3Y3A5ck02Z1JMYUp4VklL?=
 =?utf-8?B?MDE3ZGtnanFROXdBQXJSdkpiQXl2SlhZb3RaTkYzbVJUR2Q0UjVkYm0yRFB2?=
 =?utf-8?B?MTlza3U2ckR1Z1dXSVRTY0lHenpEaDVIVUFDUVp0WnB5clZnQkYxQ1QwcUlz?=
 =?utf-8?B?Ylc0aFoxTUNieE9DVkIvNGc5cFZ2NEI0KzcwYVJNL3poREZhbUVKM3E3cnpi?=
 =?utf-8?B?dkZWSm0wbUYrN3BIcGgybFRVcER5MXppbXh6RHNUV0loSStLVmNJMGZqUVU4?=
 =?utf-8?B?UEcvVTVWSzRhakFZTkJtVG5uNCswSUF1SDNHeGNPN1NUYzNmaTBQWmZ4cmlJ?=
 =?utf-8?B?dVM2Q0M0Um1mT2NuTFY0czVzb1FQVWN5QzJQZTl0ZDRBaGE1VkRIRG9XV2Qv?=
 =?utf-8?B?ZlVUK2xyYWR1RmVjYUJNVWF5dUhoYllkS0ZZS2FDNXJkQ1hJTnBnU1pVYzRm?=
 =?utf-8?B?TzhuRzRJSkpoSENXMVREZFZWV2xSc3E3T1BQWVhTYzNzUjhQMTMvaFdQWU04?=
 =?utf-8?B?N3ppSmhCMDlFaDdhd1BCeDlySEdQcFFqZDNpNnNEQjB2YlYraWNLTTN0b0FE?=
 =?utf-8?B?cHY5bEZ3NWxDTkF6dHpianNWc013dWlJSEY0cFFFVlptdGxwS3hqRXRROUJj?=
 =?utf-8?B?NWZ5dmdhNm9Vdzl2WU1VSEcwazE5aVI2dVhyZXdUUkx3b2xMUUhNTWtCNTBW?=
 =?utf-8?B?QjlkYmx4UmNobnlCSks5QWM5ajVMbWNMTFI3bW43R3h1ajVJRS9FN2RRTE9p?=
 =?utf-8?B?bHZsbWhhaXRvQ3dOVW9KZUlTL0NnQWtGTG5nYjZxRkE3b1EvM040UWg5TWli?=
 =?utf-8?B?VkJFWXFKeFREQU9yZzlnWmNWeHFWWEo0c0UvNFRFV3V3dlJlZyt2aTRTQm8v?=
 =?utf-8?B?N1NPOE1NbUNYZVAvc2wrYy9MNXlzdHNTUFhhaE14UStSQTEyQ3ZZQVdTd2pV?=
 =?utf-8?B?WFVHWitwM0RSU0xOaFhjM2pqM2NBRHc4VHRyOHRBUk4yS2kzaG9zVFA0NGRD?=
 =?utf-8?B?L0NsbGFlYy9pS3JwK3BEOXlxbk1mUzVncHY1UzNwSXVXbWdvUGhQK1dLZkpx?=
 =?utf-8?B?T2lLaVFaN0pWbnBBcXdKalYwbm1ETGhqN2htRjJ5WGhpWFVPaFdHREdJSXJM?=
 =?utf-8?B?MDRwazZUTGlOWlhXTFhCa3k3ZXhEc3g4WDBkN3hUN0FiUjJ6RUFPdzk0dUV5?=
 =?utf-8?B?c3dsQnJLQU1PUEZVcHJxNm55cU1TVE4vMnJORzdaNWRWQ0tYUVFRQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b42d8b-ad49-4476-599d-08dec228fd67
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:04:03.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATDEZ2+kjxMQsKbEoiTgjuINejb2+tTL9fk72BssBLRT+XNptjqgUyr2Sb++Op7Jl/9t4Q6mQg6rP8EEsrGkFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11228
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:30:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2987

From: Peng Fan <peng.fan@nxp.com>

Replace the manual ofnode_read_u32() + ofnode_get_by_phandle() sequence
with a single dev_read_phandle_with_args() call to resolve the
amlogic,hhi-sysctrl phandle. This is cleaner and avoids the intermediate
phandle value and ofnode_valid() check.

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/domain/meson-gx-pwrc-vpu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
index 325296b0dd7..e08c0fac49a 100644
--- a/drivers/power/domain/meson-gx-pwrc-vpu.c
+++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
@@ -283,24 +283,19 @@ static const struct udevice_id meson_gx_pwrc_vpu_ids[] = {
 static int meson_gx_pwrc_vpu_probe(struct udevice *dev)
 {
 	struct meson_gx_pwrc_vpu_priv *priv = dev_get_priv(dev);
-	u32 hhi_phandle;
-	ofnode hhi_node;
+	struct ofnode_phandle_args args;
 	int ret;
 
 	priv->regmap_ao = syscon_node_to_regmap(dev_ofnode(dev_get_parent(dev)));
 	if (IS_ERR(priv->regmap_ao))
 		return PTR_ERR(priv->regmap_ao);
 
-	ret = ofnode_read_u32(dev_ofnode(dev), "amlogic,hhi-sysctrl",
-			      &hhi_phandle);
+	ret = dev_read_phandle_with_args(dev, "amlogic,hhi-sysctrl", NULL, 0, 0,
+					 &args);
 	if (ret)
 		return ret;
 
-	hhi_node = ofnode_get_by_phandle(hhi_phandle);
-	if (!ofnode_valid(hhi_node))
-		return -EINVAL;
-
-	priv->regmap_hhi = syscon_node_to_regmap(hhi_node);
+	priv->regmap_hhi = syscon_node_to_regmap(args.node);
 	if (IS_ERR(priv->regmap_hhi))
 		return PTR_ERR(priv->regmap_hhi);
 

-- 
2.51.0


