Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ABECD6E6D
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:36:53 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8918.1780571954461418602
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=f1QnQOIQ;
 spf=pass (domain: oss.nxp.com, ip: 52.101.72.30, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEdKiabq021pGBQrSe9+F4mk6DHJIoReMC6Ok6gKqmSVQDkBLCspEVNYnDCauImER56+QIlpADTg2lb8aa95Y6ys+lFYS1WSZ9O3idiu0/iiKwOgF4dYmBPXP6j7yw2CamN99QlvyudJAgBTbLLM5Tbs+7bDMgnfdZnCI+yYhfqwgl2QBhfneL9Ua4pyrZmV2VQHXFFtOBaycOcbZk78866gp9jIFc+YaBGloT0ttqkzqslxt5nXrat+t4CZ3Zi4B0i9K4Zet5tGP8TbGEJ/F4QK3OLbgLMJ5dBL8x6S1tYrMs8IsCecebFaYr0RFthQXryxz9C6X+f0odKof6Bq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14JWT6gUg0k5dLS4AjpjyT5W8T77rtHlEXdc5tbt8Zg=;
 b=esPTFSfaeEpDV4BbhgWV5xlmmDcKQFek/fvw2luTCQfKON5EN5W5BMb9gWMY5hQg92wEN+cFHIAIaT1tPGPIrukG8d7AYfw1hxRvjdxNOV6Z6cEkGq5QqNZQjDfCJ7VNAaM1XKAyZRZCnlaQY8cc7JzPD7T7PNc1tYPzqbgddUxjWiL26VScJ1EVtmZ17PBtk3vtPSDCITwlNhpoVlBRK6EGpN7og+TbdTIAS+YlEzPAlXJuAVJ2W4CTQH62m6RADAWfL4+z1wrdr/oovRm/pVZcKMmf1p+r9PmmIjGLKhf6ck0h3oxFLi1MF+pda8lH+VpMh3vxuouMh9oGl4ZX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14JWT6gUg0k5dLS4AjpjyT5W8T77rtHlEXdc5tbt8Zg=;
 b=f1QnQOIQyetykLRTf2b32AQM64FGiPcsTP0U88HMi0kTP5yVURcfC61P8qIalDqxsY6iILvNOL/+XkjkW+RPez12WuspyQPvrdve/TlegcgxGf7eG+3/uFWxPaWIaegZ7KM3FbnOKlJX22BlXYyShT687dNUCH5uQNvP6mNFR3zoOAN1eN+yBickQ2NK3T+BPdIjGjoTs0O++UCDkQ/oQhkAGwmrKNl1rdHuPdLxRixr5A5cNPrqhX91qCy4QOLur/BUIGUZ/LIsBZ4+uMFoheiKPm3nD6z9AYO70PlqncIbGAiEYfT7T45/1RO7Sv85WaWEJAeEavLflr7xkhEASg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA3PR04MB11228.eurprd04.prod.outlook.com (2603:10a6:102:4b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:03:58 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:03:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:27 +0800
Subject: [PATCH 04/11] power: domain: meson-ee-pwrc: use dev_read_phandle_with_args for ao-sysctrl
Message-Id: <20260604-devapi-v1-4-961aded05ff4@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48ca2647-b551-4a80-2eb7-08dec228f957
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 WrAGxJmivx840iBtm8kH8Ohl2Qp2Wzt2myaI1xGk0fJtOS66N4N0yTTYIpo3v1Mx5HPbs9JfiA6dkrG7Re1R0mllljejHTp6BFqIHpIyhMl+IxNdGGxS50kHkWz1eRJX1wYbclH0Rvxe+mBn6DnhHv8LEsVm6rzlOMUMGYGniqahgQDhlIhX/Dx+EBqEecXG+7+ULqQPpwJ8i7PweQMkwi6DpG2Te9iV+bI9VrsPC7ffxdH0rRYTp48j62KJZDIXhYjibZ7l87hoFaQpQynU3pJ2pZOEtzMn2x6hHojEK4fmXQ7CIgrVn/nc1JiW67EKm6XxfaBZWVzrJNKQmoHnuPlbhgyXK6bwuz7Uv/t1hZkayFNEYxnxYRJj4woOVXzm6ChGR+eXEaw04F76mPIgO3oMAt7BSw1+uDDUUBk8f0GyajvisuqzTV+Sr78OEP7mX/Vy4zsOIoXErL7H9VypD/u5UFCOvixCtFCIH5Vtij+ViEZvvtxt4b8G9mgTlTbMygU4F0H40Do8R0f3+R47QvFOaz4m3M33RlKkfpz2mupPbtrp/SENzaXETmATn0lYc9uNE9boRvF9ESuxwVPFwJow1/qfd896gz5q+Qatv5Ke2xYl36nPjZNU/A7+L5blYA/1YJO920Vb+YHLBzM9cpBSl0FPw/3Un+O70i7211NzptYnLMqKv2yoR2o4Q+suvW7j8AXRZKE2deVQ9+jcb9QXAA2YzJ0WBi3ygLxIuxleUU/vJNMoa4GjLRzKtN88
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?b1ZoL0trRlNQUXNUOGNBQzBXQzlmZkppRGpFTzJtVDFxT0hWSSs4aDFxTnh5?=
 =?utf-8?B?VjJEQzJNZ1FjMGM4eEEvNkk5MTduQjA5c1NXYkhPbXcweEdrNmpHWnFaSVBL?=
 =?utf-8?B?dSs3K1RYa2gxV1FHRTlkazM3YnRQUi9xNnNveTc3RkFiaWk3YW05d3hYcTNT?=
 =?utf-8?B?dkRpRms3ajZCWFgxMFRTUDdFSkJGcFJrLzRvTlRwYWNvZXFuK3BUeEh4am54?=
 =?utf-8?B?SG52dTFvNVowMmpCWWUvZUlmWEVkZ0NQWVF3VnBUcmN6SGUzV3ozRjhHQW95?=
 =?utf-8?B?YTlZTzJwdTFRUnZ5T2RvQUxxQnVpUHlPNTBJWmNSOFZDQlg4Q2pqTDZwcTJ1?=
 =?utf-8?B?alFVeUZzYTdrQTdYcGdWZU9SK2VCMEI3WUVaejUra3NhZzJsdEdtMzF5YWtk?=
 =?utf-8?B?RWxkV3JqQTdmYURCOHdSSlVhMnR4bXRVcmNSTEZpdUQvV1RvVlNLbkdrditI?=
 =?utf-8?B?cWxtaEd4Zk9YaU1HaS8wVzR1bWQ1OVpXTnpsNmtPVXY3bzJqVUsyc0NLS01R?=
 =?utf-8?B?MllHamJZcUx3SzQ0VXlMYzRZb1Jkcm0wSjJrT0pWemdoZTBYZk1uZ2ZWQUU4?=
 =?utf-8?B?cXhLNXlrMFJmRVFsNzl1eWQ4SkRvTTgrZ0pqZjRNV1ptYlBKWHZGV050d1hi?=
 =?utf-8?B?UWI4RjNZL3ZZbHNsdzgzRUxtL0J2SDdqMUI0Mmg0aTUyaUxkZC8xT1hFaVpL?=
 =?utf-8?B?Q052bXp5RkRKNnlJSk9BNUFFZTdvUjFPMVRFMzZJcTZadUlEczBCMWdtdWVr?=
 =?utf-8?B?bWczK2hXbDdjbGUwaDhUaUpsQ3JaTVlhWjlmaGdlbUczZ1hhM3MzQWhPSVhV?=
 =?utf-8?B?YUhjOXdicHJCSS9NbUhnU01Wa2lnK21FcUJiZVNMOUtQNWxhRWkwRVd1bTRz?=
 =?utf-8?B?MitWYkhHclVMQVptRGRCaC9tdG5EV3dKOWJ4UDJqL25pR2pGdTdUZ2pMOHU5?=
 =?utf-8?B?MGszSGwvUVR0UVp6OXVSbW5qNCtCN3hscENoYTZvQ1RhcGJablM2NU1lVDBl?=
 =?utf-8?B?V3RmbUpIbERMcFdFdjhwRnJWRGxISWhWMnNDdk1FcnBEU1dQTzlFSUlJckRa?=
 =?utf-8?B?MjlOVHlEUWZ2NzI4OHdwbUV2Rjh5bUVmRXFaa3RjQVBCTzVQNWZlMHpqa29h?=
 =?utf-8?B?MitrWWNCODhScUlhckZTdUoxKytPOVFPM01PZDNsaWdiVS9WbG45bXFLMzBM?=
 =?utf-8?B?UEdDeTE2SHJhcytyOXRsQ0dwVWRPbS9CUjhXbEF5MjQ0NmZuY2wrN0Z4UUNG?=
 =?utf-8?B?WGUwdktiTmxYL0liZFF5MXlnZ25jdFBWQ1NuYk12SXpuTThOYmFsdHJCK0Fz?=
 =?utf-8?B?UHFTRXJOeXN4SVozeDhuS3dzVE41VjVQcWZ5UHUyMyt3VE02NWdEZTl6bkd1?=
 =?utf-8?B?OTUvdGl5Z1ovWDF4RzF1U2M3eHFVczNyZUFxOTljY25LVitKdHN3eWZGbEJ2?=
 =?utf-8?B?SmVmekpsc3ZZRlJiNzlOb1R5Tndva25OZ21NZjRzNUdBUmJFVTZDWUFZYjNm?=
 =?utf-8?B?NWh2M2o2alVzVDNldUs1ZmRrakx5MU5yWmVkb0VnUTZkM2NwZnRCLzhIbEE1?=
 =?utf-8?B?ZWZVT2d4c3lYQ0dUZEdFQWNuT0Z6WmFPckZlMkh3ektCczQwUW14ei96NzEw?=
 =?utf-8?B?QkhjZ25rSzJRQUFadSt2ZVpneVNqMDcwUzA0T2lKT0ZOdThHUlc2TTRYRTUy?=
 =?utf-8?B?bGNrS29JcEJTdjdzdDdCZzJnTUZMcE96dkRSamE1VHVnWlZRUTQ0OXpDSDI4?=
 =?utf-8?B?TG1oaW5pV3AxRzJ5OGJrMU9sU1RVZG9GbTF6RDRJMHJ0bmdGUzhKYkYzZjhI?=
 =?utf-8?B?VWdXbERmVE5hUWZLdEZBR2YwSUY2N3l5U05uZm1MYmtqQVdOWHRPdVFRNnNu?=
 =?utf-8?B?SmNVeXdnMVkyQnpGWkdpMVFWUVo4ZURCcXpWcm1icHNoR0ZNNzlzUmVTcDVw?=
 =?utf-8?B?TXVNN25ZUS9RNGo2RVhmSXRMNm0rTmVodkx5YmFLaURJaEtjQlNXZit6UUNR?=
 =?utf-8?B?T2syN2J0N0xtZzNNSWN1THpwZDdRcktnT1FScm5KWkthQXJydjBGR2FVTzVa?=
 =?utf-8?B?NzEzMTVjU2huWC9YUDlmTm9OS3lzNnA3YVNPTmVSTVJDZlo3Rm8zY3JLdGcv?=
 =?utf-8?B?ZEs3dG4yWlFGYTFsajN4SkR2NEd2b1ZQUGNuUkJwbXluUG9rU1E4ZzhuRFl0?=
 =?utf-8?B?dTFscEhXYzlFYjJwTit4MTFGclJSdEQzckpyRmJtSHpOSHVDNm42ZXhpdXRx?=
 =?utf-8?B?QUQvZ1ArNS9KbWZINUkrbzkySE5taURTUm85UDJZM2M4a1FXeVdsMHdkRVdx?=
 =?utf-8?B?bkUrOUx1bTBDenNScE42d2dqNFhFR2FlUnlNV3Y4bHY1bHpLTEpiQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ca2647-b551-4a80-2eb7-08dec228f957
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:03:57.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sHRPxr1qoSYNX5S2vSfQJ5vdYA+wZ2MMCJtQUU3r3H7cZZeZvg8K12apM8y8cvStMkbzwS854z01dLVYgQvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11228
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:36:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2995

From: Peng Fan <peng.fan@nxp.com>

Replace the manual ofnode_read_u32() + ofnode_get_by_phandle() sequence
with a single dev_read_phandle_with_args() call to resolve the
amlogic,ao-sysctrl phandle. This is cleaner and avoids the intermediate
phandle value and ofnode_valid() check.

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/domain/meson-ee-pwrc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
index 6361f3a6c59..882238f2937 100644
--- a/drivers/power/domain/meson-ee-pwrc.c
+++ b/drivers/power/domain/meson-ee-pwrc.c
@@ -435,8 +435,7 @@ static const struct udevice_id meson_ee_pwrc_ids[] = {
 static int meson_ee_pwrc_probe(struct udevice *dev)
 {
 	struct meson_ee_pwrc_priv *priv = dev_get_priv(dev);
-	u32 ao_phandle;
-	ofnode ao_node;
+	struct ofnode_phandle_args args;
 	int ret;
 
 	priv->data = (void *)dev_get_driver_data(dev);
@@ -447,16 +446,12 @@ static int meson_ee_pwrc_probe(struct udevice *dev)
 	if (IS_ERR(priv->regmap_hhi))
 		return PTR_ERR(priv->regmap_hhi);
 
-	ret = ofnode_read_u32(dev_ofnode(dev), "amlogic,ao-sysctrl",
-			      &ao_phandle);
+	ret = dev_read_phandle_with_args(dev, "amlogic,ao-sysctrl", NULL, 0, 0,
+					 &args);
 	if (ret)
 		return ret;
 
-	ao_node = ofnode_get_by_phandle(ao_phandle);
-	if (!ofnode_valid(ao_node))
-		return -EINVAL;
-
-	priv->regmap_ao = syscon_node_to_regmap(ao_node);
+	priv->regmap_ao = syscon_node_to_regmap(args.node);
 	if (IS_ERR(priv->regmap_ao))
 		return PTR_ERR(priv->regmap_ao);
 

-- 
2.51.0


