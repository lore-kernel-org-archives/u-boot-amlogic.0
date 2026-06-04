Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6461ECD6E76
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:36:53 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8927.1780571980478253689
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:19:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=qjktBliy;
 spf=pass (domain: oss.nxp.com, ip: 40.107.130.66, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJRPyBLuU8W9EaWHMna0alqobtZm90eA3hDCFfj+yQCcERsiZMxq6vcmFQ937gKKlA1uCfB89wLbUj6jl6YEA5tPRiyVLmzPgnDG6ecDGaBgM0QtjjUKZ5A3La3g4hmrmSIAo6x+jOmUnTDYTsUHvgGO+tDAU+OmXO/6g0u1GWWfs4oTtrLcdp9b06wO8T4LXeHa+lrnDl0Z5UAC70OqjokJPXPaXmOWM9NSlC0H+vAY+oOiobfr26X17nH6l8QgKjjgJxqrz/0hkB+aSOwKzfPBOTUAwVEYmYzEDhkvNcMlhn/4+EQM8HLdHmPo0HwNpYiscU37lI9eJM7/YuU0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4cPctA0JQAMWzhiCs4Dxd3+D2a2FVQ39GkOnsiZZKA=;
 b=yxiGhZIR0Q1Khu+Y5ZHwtfqk5CDDMI8wl45LfUVfNu3+pKr0Lsnc5Yk1pAp3lPA+oP9MEfelm8iZzP5euG3CgPoN5aIcjzHJ7vwQmvnKbxpzERkU7AvtTFETs0TnBiGDP808TugFpJWzLgeQezR2O8g2jnW1DvoKWHeF25vjn6xWvNt4wwH7e6/tT8YztKwfX4jqmPbDxuoVOYYufgc5j+yiJsQ7HFNLOYYTRivvr13eUjDdgqh6mNF5oQyu2rZe/JWgMoXERQzOA8BYRUc9VKPizRP1w0kQLDkh7FfZHy/J97/Tapp5cVUCdrdsnVmw+3y7KuWBG7IbyIvnLc03Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4cPctA0JQAMWzhiCs4Dxd3+D2a2FVQ39GkOnsiZZKA=;
 b=qjktBliyDRVxQYQ7/3sziy/gf81malWHx87anT614+WhDtWsNMck15J4wBzXUkTYgVHJBxKgslUIZNR7V1uXIfN2B/2RzuGCaqhsFhmSP75tI7Nh68rg9uVTkokmEzI1TsnW0IzWDIPp4nRQPbWlrmH9pL04GrWxbSXl1weonImQIV7LtDKeMm+ocyTq0VyfVWgQWF4zXj/TkMHSBW8LMV2ml+H2hnfH835DPi0HFUB53M1BMdwMJutbX0j5AiPewMK8S37ZubsDjBy1ROfwKGDB1iyVYqbRwelDoMdszhIwskJX/F3V13GMZ2a+tYwmY9bcfJbxcQs7bHPZni83iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by MRWPR04MB11518.eurprd04.prod.outlook.com (2603:10a6:501:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:03:42 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:03:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:25 +0800
Subject: [PATCH 02/11] mmc: msm_sdhci: convert ofnode API to dev_read API
Message-Id: <20260604-devapi-v1-2-961aded05ff4@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6b5450e-58a7-411c-1f75-08dec228f0cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|18002099003|22082099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 j4+IFepgnJ+bHWBS6R0LzJQ8GA5si9fIg274TSD1DUYEm7L3ULx7jBhwEbn5NjSnqreocEpqpZ1FEpBmCxiqmOBt4QtKV7EOP8dmI9jzkfsoVPJH4nigU3bzJ1bXgD65keAceL3c1O8/uiUESpmSUab8wAZtCNoy/V6o82mvZNduhLsVAqEZYgWQh/W2qV3kBqGapEg506Go0EWU5NaI/Vp455LR7TmI/UNwIomuRKXXQ5vymYeKyr/DITYqjK4sA3uuhHKJYrCFAL91J8zS+9XCT0kz4kB+YTsQYR/2tPR6YDcIQdTUrNFr3w2h9bDMZz5e0g6WKGu40uVzPpGKJ0vwxwSIWE/2bsRkfbVbSYnr9Yn3F3uNUSE9lqP3eC2odg+a0WtyERNMwI47OpUfsc1Ga7IGYZpxat9Ou0tSofBxD3k6GhFMzpW/3lE+8UdhraiFvJTG10qTYsQJOFkeJBhJR2ClyRgIbiIMwM231G7cfgp0YJjDpVT3C5vFvoRNU0Lll533Z6ef3A2/ZjFwG/tc6GMiU/PsZ+gTjSJeX1DXxIZhfl3X4ZPOMgS84GDL9ISL+Iw6jAqt6v1SHpbXw7n7GlZqX2pLceh0JTB6DtlgCIJmIDwC+gOEiJXmOS/tTuPaH4QVWel+mxKPrqiJaX/w7FSIcOIc3uEOiVdUqfvqfDbBqAKapuvpJalR9vL6ZbBpmO40M0x52zR/4sL3PmsUsnBpWM5wcovhNSSEVVxTNosxGoQVwIcDM4WjVFTZ
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(18002099003)(22082099003)(38350700014)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?TWxyT2Vybk9EL1c4VWgrVWhmbkR3QzhlMVhMeW5yQlh5UzE3R3pHVXdxOHIx?=
 =?utf-8?B?MzVXNndqMEVlcyt2UlM4VkZWTVdIQjFWcHpWWXBHdEwrRXdVUldab0RiQ1E1?=
 =?utf-8?B?RFF5NlRWNVViL0I2b28rTUl1TzFCQnJueDJjbktKOWVTcXNFd2x4V1lTYnFx?=
 =?utf-8?B?akV5OURrLzMwczNJWllYVSthZFhSRzFUelJSK1ZJekhrbURJV0NjMW5rRFMx?=
 =?utf-8?B?SmFTRnRzRnVJaXYrcDB1TG5ZYytpaXZBb0VMOStmcXJTbzQxWG1HUTNZbEpI?=
 =?utf-8?B?d1hrK1dyakp4MFNKb1lPcXN5Ym5yV09sUGEwVFRhQmwveXFqWlhteHdiTkFH?=
 =?utf-8?B?TjdqMXhjSS8zNU5YVldueVRrTjJkNUJ3OTk2UTQvNk9ZaEVHSDlxUFpKOTlF?=
 =?utf-8?B?dWFlNXVBeFhqMEovdjNmS1lYeXp2UVdmV1ovOGVVNGRPa3NodW1VTWNmTXRp?=
 =?utf-8?B?RnBPZnpUSDhLSnQ1bERYVytaSG9IbGdVblloREcyYzRVZFR0WXpobzJNVTJ3?=
 =?utf-8?B?OThTQTM1SVM5bXZXaFQxeDFPWE5pT0NOcVdKNkxGcGhQSWFveVgzczhNeU9u?=
 =?utf-8?B?di9ONXR2bVhrQzJNM3puNWdNSkpIRU9TUmVtNmJkOFgvWnNEV0twRlRDRUNz?=
 =?utf-8?B?RGRpSXFhaEk4NER1SlpqUm9aYmIxWVVETWs4Y0dDSjdwbU9RYXVPbi9XNUNF?=
 =?utf-8?B?QkF2K25JVHM1cjRHSTdDY0ozYmFQZVJmQ2NZNGo4SXBTalVyaVNNblZUY2th?=
 =?utf-8?B?amhmUER4aDAwYm9GNUd3ZExoNkVZSmhsMDVqQS96MW5KSVZZVHNDU0VmZGx3?=
 =?utf-8?B?Sld2S2lCdGJ1aG43SjFWNVk4ZnQ3SU4wOE9pbEZxbGllRjZoNXNkVG83dEp2?=
 =?utf-8?B?a0FWcldqeDk0My9JY2NZYU5HaUlHSk53bWVtS2svemhFNUduY1JNY0FmOFF5?=
 =?utf-8?B?RExkTHUrRE5Kd0VQeE41c2dCK3U1TkwyQ1hBcnZUY29HdWdsck44Z0szYU9N?=
 =?utf-8?B?dkpFNWFKQ3VMbnI0aDZSNnF2WmFYbDhIRUFiYlREMWtkZjRDM3VpemlkUGts?=
 =?utf-8?B?ZzBXWDR0VmxISU5oSzZaUC9oVGIvU3Q1NjV4M01CWURteTFzVXZpUkxKUUM0?=
 =?utf-8?B?eFNtSWtCd2h0Mm9wVHZjeUQrS3IwR1YvTjlZc01hbW1FMVVuQWJjdEFjejJi?=
 =?utf-8?B?MTVxYi9rWk1XUW5Gc1FGakZRZm1mdzB6ejY4R2hBMk4wenlOZmF5TlpuV1N0?=
 =?utf-8?B?UXBCc0N3bTZJVnAwU294bnlSdmdmNDZWeDlaNkdzeFkxUWpFSkFTK2ZwUEVS?=
 =?utf-8?B?Y3lvSEh3YXdJMVY4WUlZTTFTRktrOExKR1ZWc1duaVFyKytwb2thdk9TckVR?=
 =?utf-8?B?Y3M1bHREZGFxSUpOU0Ztd2hrQXc0VnJNeTY3Z3pOQlNhTC9RbjlnbHNBTThL?=
 =?utf-8?B?UTIvQ0xiWlppcGxONXlSdWYyVHU0cnhzU2ZTcWpEZnNwaXdkalRJRVdLWjQw?=
 =?utf-8?B?dEdjK055VHZYVWNzY0NLL3p5VXU0U1FzVllNN29FQlFvd2lYdDlGRjFtTllT?=
 =?utf-8?B?YTZJMDE0blNzVWJ4VmQ4OWxOclRUNVhjQ2wvVDFOOU1tRUtrQ2UyamFlOU9n?=
 =?utf-8?B?dlFid0V4eXI1dXVvRGEzOWRuRzN1QzVRdEJrNXB0M0V5eTQzbk8va0VlWE9o?=
 =?utf-8?B?OHp5NXpmQnRrZExKanR3MC8zQWNDSUpiSFBoUEFKaDR1THYvV0k4Y2oyRi9M?=
 =?utf-8?B?enhRY3FRd3dWOU1PMDQzcStyQ21tM1cwZGdNYlJWSlNzYzh2eVUyeVYzMDc0?=
 =?utf-8?B?cEphVUFROW94am9sYURYZGdobzRXLy9aU2FwUVhBM3JMK2Z2ZFRLN3Nuc2JC?=
 =?utf-8?B?U285azlyeldvVGEweTJnV0tkUHJuT21wN3dLZWhFYkQyV2VSaFBmRm5McDEr?=
 =?utf-8?B?WnE4dHRHSFlzQ0g4a0ZWalZ4ZjFOT3B6WHRCZnhLYzhkWDhvREV1dmhyS25q?=
 =?utf-8?B?Vk94YVJ4MzhXZk80WGVWVHI5blBHWFFUanVwcXdaeXExOVNpbnR2SDZpUTNs?=
 =?utf-8?B?VlpZYVVQVlcrUVJwYThpejBDNGYwMVBGS2kwL0JpOTZaNnJUekVGTDd0WlJR?=
 =?utf-8?B?NkN2blJjNnp6TkZ5VnlvT2Yrb0pKRGFZQWRLWlJ3bFJiLzBxUzF5UXYzQitW?=
 =?utf-8?B?TWhGNWFWdTRCREF6cEpTczRMRi9hQXVlTEZWUnFyL3ROQytXYWRacGRJK01C?=
 =?utf-8?B?UWhReHBySDNCbjNtTEVTZUhyS3JNM3BzT3JSTnVSdkNDWm5yeWViTnhYM0pB?=
 =?utf-8?B?anNwY2lDbUJuRnBDdVBCb29Mb2JMTWJTZ09oa1VYVFhpZjZqRkFrQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b5450e-58a7-411c-1f75-08dec228f0cd
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:03:42.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ktom0GgjclqHETifuP8zxCgBt7tj5HlYvznPhO76G2eYpKHAsBrXXpawFl8oIMHI8AosRhRWdW4o8NXiBNFTwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11518
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:36:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2990

From: Peng Fan <peng.fan@nxp.com>

Replace ofnode_read_u32(), ofnode_get_property() and
ofnode_read_string_index() with their dev_read_*() equivalents in
msm_sdc_clk_init(). Remove the intermediate 'ofnode node' local
variable.

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/msm_sdhci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index aaa87923604..7bdb02142a2 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -64,14 +64,13 @@ static int msm_sdc_clk_init(struct udevice *dev)
 {
 	struct msm_sdhc *prv = dev_get_priv(dev);
 	const struct msm_sdhc_variant_info *var_info;
-	ofnode node = dev_ofnode(dev);
 	ulong clk_rate;
 	int ret, i = 0, n_clks;
 	const char *clk_name;
 
 	var_info = (void *)dev_get_driver_data(dev);
 
-	if (ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
+	if (dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)))
 		clk_rate = 201500000;
 
 	ret = clk_get_bulk(dev, &prv->clks);
@@ -87,7 +86,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
 	}
 
 	/* If clock-names is unspecified, then the first clock is the core clock */
-	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
+	if (!dev_read_prop(dev, "clock-names", &n_clks)) {
 		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
 			log_warning("Couldn't set core clock rate: %d\n", ret);
 			return -EINVAL;
@@ -96,7 +95,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
 
 	/* Find the index of the "core" clock */
 	while (i < n_clks) {
-		ofnode_read_string_index(node, "clock-names", i, &clk_name);
+		dev_read_string_index(dev, "clock-names", i, &clk_name);
 		if (!strcmp(clk_name, "core"))
 			break;
 		i++;

-- 
2.51.0


