Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77765CD6E78
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:36:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8924.1780571971953619623
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:19:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Pq5Wuyvx;
 spf=pass (domain: oss.nxp.com, ip: 40.107.162.13, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmgmOW47qsXwQfFtPAewyuKo/fzAWLiUcLbmAnPZBnrIVV5HWTfuUpdJkvUd8rrYHNW/2bz5iVD6kkWFOtqFFHPxIQGMK+uWSnQyCVYBK+Llg7X14JIKv4kiJ5dvRARabCn6AzDuUMtAUWi9/7GGOYpcMn3ZUSjnM+WgVXabr8K1zXsh6/xIxwSyDcEYgi6Aw+dT466N7bAj7djYTuueBds4Rc/HaOrVEYVz6SVc/i57I1lftnjwfsuQ7bZHbAAanv7L0qNLyH9Yf0/m/rAy7KnO33eOcyHJ7SWd/XqOio0wLYd/51ICFLUgYJbsE6h1HQS27mCqexedR2gZTB7xqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88b+YCAW3Ul0mz2K47N6iVr3IqocHBsvrws4uS1Z9+Q=;
 b=CFAm9aUJTAaSva/o6hllZCYfKG1MgHEi9raKq+GfmRaHqa1P7Yx7uGbsC6XDEcI6XXlKOZL9SLxU+SOo3hFIMpJa1AiACmCSoroTJBuH1IMN+IlwxBq9AphuyQi9H8esWKl1cYWfVrwVR6DaEps6LBH/+4RMTmPWOhPYyNT3pqXfjkcIa+9Z9TZXxxa1Ffr2RJQK0BuOPcBS/DwPHhuixrEqKcgu9NIXo5kUhNii8SPf2vAfC8VfJ7io5LG92YbDFnW1JNybMu+sZkpx6zJkRqGikJd1oHAqlUyFemia/f0BgAQ9pzxhpsQfaekBq+S+ytHVBKpx7D3Mqk2w+NZWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88b+YCAW3Ul0mz2K47N6iVr3IqocHBsvrws4uS1Z9+Q=;
 b=Pq5Wuyvx3W4hOj+a66+x7EafiCA9dSLJ2Ixa6aDFZ2HF3CWSKAlxkmkG0olvuH5Gi5NyH8O+/9voTdgXJDSNxHrIxGBNSaIgrjK5P7Dcj80iS+lce5E+GOC50Jq/2KQXUHxicib4DF82DeE+UtbLyvpt9Qyb1FyNEiF+4fNFGd+t1KKqVIOWLgZiBu6ha55aWKqVWliewYbMGn190Ovy6ooT/Nye51Hp8LlUrEiDpleoXSk+3Jcl6ZXEvTkzyaugKI+jkmoPuKYX4Z5YhZIWDjgCqEGiRB1MiyAAoPT4RFqTIIH8q6s9H3sQAmoGyaZMOv27viLrzkAord3R4Qh2RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:04:31 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:04:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:32 +0800
Subject: [PATCH 09/11] power: regulator: anatop: convert ofnode API to dev_read API
Message-Id: <20260604-devapi-v1-9-961aded05ff4@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3893d1ea-07ae-40df-6aba-08dec2290de5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 l3JQn7e9KBNbGNFYjmiZ8134p12MDPtzBZBfVjFq43wy9QOYMjl5x/TXJ4T2EyUUK+7g+dnFs0PZv1VYRx4VWxA42ugPW6S46PzAPtFCXeV/axldFbd4zPC8ExXP1XFrqEVZD5I75zjQPynutgtyz/SaOWaBhszoY/Yfj4jtbnpKzQ0d7xVs/VLBj2Sg8j3ns6F/ZaKU4xlvVZ+cXt6OHaXAaWh+1axHO6PBwsqtcAhXo/AMlv2XPxVcZaXRdEzSQHVMD4CCzaq4Fw0Pt9hE48b0+4UceKsM+cc3Iz1EwJOhO5wmT0oZV9IKiGU11a7c9pjbIcKPBQzbZdx+/7fPOD8WMGpCM9Pv6hgKDAZDvz9iHJWbo6yN84bhoYmpSlWmJrkxWBJVdIDYXYVWdtKuKr4/YjTiGCC1L826TZPKTr1L7z/H7Q9ySPiFHczeEAEvOahIGHrS0IPdBb22D+nMhWNB7/dchMumCpsPcN0vcoDuMRtFnUesBZp48nCCotu1FH+maCpBnpj+wBBzL3kXglMuYE+ms1HW2N9xzWwYGR6i1zeSSfPPJ4gAJnoRJn5Ipiic/WFbis+WckKN5oOe5qQ50g8UCJpGrG54QMyV4YMumuUcMhilFrl+W9cJtswVC0ivMJaytobf+yIngQjkg8mWQUBt3cr1Uf1daX54TvwcHGK1NTPmc9umsTt0Y2EYRyY4kcCnkojvGocnc4XdwXQ1wgg0/5gsaueZqBNFfI1l/UNvpwldmVnpaY+Mjc8x
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?VVV4K3BCNjV6N2xtYnB5b0VjUCthd2NaR3VvNExvSUsvcWRsc3VlMm03NVNB?=
 =?utf-8?B?WFhhQU0zTkNjK3Z1UnU5ZW1RV2VmUmNTZktBQ0h2c1E1MzhJczFubGE0eSs3?=
 =?utf-8?B?UkFkNk5oQ1BLU1h2SXVjSE1UY0lmaXJTVU1qMENOaGZVMnJLTC9kOXZEaWdM?=
 =?utf-8?B?OTAvSzRoTzByeVFZc2o4QWZWWDdHNjJYd3RKYy9vZ2lIYUdpdGNiY3M2SGRt?=
 =?utf-8?B?OE5scW1yNGNBTjkzb0RZZHFBdzZqT3VPM1FwTWpEN0ZubWQxdUwwakFsZGp2?=
 =?utf-8?B?dEFvTVpTc2V2NEZ5SFFHWjBBcVRnd1YwLzRYelVZbitpUHNiQ3JOaHp6VUNx?=
 =?utf-8?B?ZFB5Z1ZJWVNKZ1kxQUR5S1cwdVd5L0hhcXh0a09TWVJHU1JYd3Y2RmdCbXp3?=
 =?utf-8?B?M3VTamNIa2hQTUZqTElLamtmcnZqeXdsOUR4SGNMS1BRQVhtbWZSNzlLNkI2?=
 =?utf-8?B?V3ZVU0U4djRmWmpjM0pHVFlObEwyMVNMTkFrajFwK2VISHUyNjlpZSt4bkhR?=
 =?utf-8?B?MXJnc2R3MWFpK1ZnMUo0enFMZHVyMzkwNWJ5RmNDYWVaV0lOdG5md0ttd2dN?=
 =?utf-8?B?OEZCMnkwUmg1cWxBTG96ZXdiRUZIQnUxVVVVWXhZdjA0VEMzYklkVmF0cmkx?=
 =?utf-8?B?MVJSQi9OV2QrU3dJMys3YjZ5OTlEK0N4aVFROGdlU0w3a1JGTzY3TGoyRldr?=
 =?utf-8?B?REg4TUN6cjFoa1MxSnhrbGNDNXhiU3p2NWdGYS9TKzR4YUYrMFlNSVlMVU9M?=
 =?utf-8?B?eHdyRmE0Z3Rxc3VsUjR0bGZEZ0lSOW9VK3dkdDM4K09YY2dZSWRpVHpaeDlO?=
 =?utf-8?B?M3c4SHRBVWtNREh4SkJPQnIzRWVWVU56MjY3TkJLcWtjU3JkdDJsL0ZFVDI5?=
 =?utf-8?B?cHlRZU1WcTE4ejNTN0FzckZVc2RubTdBRU1JV214dXVxUk42Y3BZY1lpbTdF?=
 =?utf-8?B?SHBld0hqQnFHN0pReXl2ZzB5ZkhNNTRWdXVmM1hjRkJ4ZnphcU5Mc2FFSDFz?=
 =?utf-8?B?VVpEanJCUHRYZFVpL3dKR3dIOHB6UkdkN3pkdWtsdUhiWmoydkJEWXFzb2dE?=
 =?utf-8?B?VTRDYklMazJPeCt1K0tjb3htOEE2MDV5RE10MmZSbCtPQVRRZ0xUMDdmMjhK?=
 =?utf-8?B?TXozRVhkZnNYVFMvdDRHaTFhYTlTMDhmampVd0VONmZ0Rys2MS9zbmROWFlO?=
 =?utf-8?B?UXJCa0xDNlNXUUd1MGJmUVR6L1ZrK21QWFFoL3I2dCs3NmdkeVRITEZGcHo0?=
 =?utf-8?B?RzJMdjBsOGFiNWRnWTFYazlrRHdmdVdjd2hNV09OTU5qLzBZbE9wU09wcmxx?=
 =?utf-8?B?bmpodlNNNkgyc1NldkxoQVp2dDAxcisyS08zM3lONVBXc3B1WGdxcDZLSTdR?=
 =?utf-8?B?UDcrVUlPTCt2VHVJQWNQZUsyUVlFbTBZT3Y4dlpwZlJsYnZzS0V3MDA2K3N0?=
 =?utf-8?B?clErREdwR1k1MFVHT0hmdEdhRE5EKytKd0o5OGlLdFRjN2k4d0htOUdiZmpv?=
 =?utf-8?B?Mm9FdUlid0wwSjE1TllqNjEvc21kaTNFYmt6RTdwWHI1L2JTc25NNlRmYlkv?=
 =?utf-8?B?T1dDOVJxYlFJeFl4TUF1QnNmRCtiU1AvSjhLdXIwZ1dYNVcvVk8wZ3ZQU3VT?=
 =?utf-8?B?aHZqRVRnVHBtaUR6SU1CUHF0aVZRY1ZhRHRvaWt1bG9oT0R4OXZ5WVhMZ2RG?=
 =?utf-8?B?TzAyUERMSzJ5Z1MzZ1hYRi8vQlJmamF3d0Y0Ymg1bEFYWEVxSERJajhxWTJs?=
 =?utf-8?B?NlZ2Q3ZyekdFNkpEdVROQ1ZNTWYvS2gvenNKWmpzRXJNR1pZVUp5SHpWTzRI?=
 =?utf-8?B?enNVZlBVSnpnVjlmakVucHh5YzdnOXNRL2xmRjlwNlAyeGhBWGMvNHZFRzgr?=
 =?utf-8?B?YVp2a0RqYlF5Mjd6Q2l4Sk9GalZiMjJ1MGJ1WUtHbmw5ZCszMCsxTHhkZXp3?=
 =?utf-8?B?a2hhN2RXcjNkK3BwR1hUUVdkNmhaZGdxUWkrM0NENWdwV3N0cmZxSGNBQ2NL?=
 =?utf-8?B?T1pPckRkQUwxeE9PeUJhNnJ0aWdmYzF0aTlrZTZXSE1qK3VjV0dEQmlwS2c1?=
 =?utf-8?B?T3FXRE1YMEl3N2hldjZrTHVYNkk0WWtTM0FNZnRJU1pMNk1CRWRtR2xaVyth?=
 =?utf-8?B?akZCVm1xdGlTZk5TYVRSb3ZZYkl4L3pjckFrMnFYWGlNcDRtdnVPN08zQjlW?=
 =?utf-8?B?R3M3TWptaDgwQTY2MUt0N0Q2cUt5MjhoaFR4VmhoenhNZWJabHZaeXBrdGx0?=
 =?utf-8?B?MFVVRUZKUHVmdk9oNFN1Q2xnMzJwY3FPdzFjbVJQcm9LNlRUZTVlMThYNjRp?=
 =?utf-8?B?K1lGZElTa1BqaXlnTWppcVZyOEg3UnA1WitEL0FpSU9kQXJvY1ErUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3893d1ea-07ae-40df-6aba-08dec2290de5
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:04:31.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFx9Nl4QaDAixqtye4Mwiy/w38ezwVxCjsG5xO52q1YJoEe8MN+88Dgbq3K9YVS1vwmsvfm1JpEf4wlh3kffzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:36:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2992

From: Peng Fan <peng.fan@nxp.com>

Replace ofnode_read_string(dev_ofnode(dev), ...) with
dev_read_string(dev, ...).

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/anatop_regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/regulator/anatop_regulator.c b/drivers/power/regulator/anatop_regulator.c
index 824a753db16..88570a1f624 100644
--- a/drivers/power/regulator/anatop_regulator.c
+++ b/drivers/power/regulator/anatop_regulator.c
@@ -170,8 +170,7 @@ static int anatop_regulator_probe(struct udevice *dev)
 	anatop_reg = dev_get_plat(dev);
 	uc_pdata = dev_get_uclass_plat(dev);
 
-	anatop_reg->name = ofnode_read_string(dev_ofnode(dev),
-					      "regulator-name");
+	anatop_reg->name = dev_read_string(dev, "regulator-name");
 	if (!anatop_reg->name)
 		return log_msg_ret("regulator-name", -EINVAL);
 

-- 
2.51.0


