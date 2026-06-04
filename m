Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB31CD6E6D
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 12:30:03 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8934.1780571882562750539
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 04:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=fEUQRMkf;
 spf=pass (domain: oss.nxp.com, ip: 52.101.66.3, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIUoeD8dvkCzBSn/bm9tE3eKUTtJ+med4/UwIPIYP2zIPAiny7lebG4Q8X9Nihj7pPDRe1OuxgjXatbidegTdd6e8EQ23THTU2I96jEjP2ZAkW6PEEdQr09Fzy9XhMUbrb9vHwIM16pVGimhKS4cCN/9P2WL+994fE+XLGgVSu309uSRx9QWogyEC9mJTw6RCUCZTSSCR/cJK4nvm9GJ+8LNF+ZtFG0NwsqG/OArDefZ0hFw+GWGhwXMDW3JOoUAABSo+6ipw6fTDv85NPLo4OyWIZqHzRHix3A7/dRLYb/wS6DI+87ixYzhuAMssj/vXjRWYn9HtWcsqrJxt3yIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOCYYe9+Nn6oyV+c6TTfQfCIH0+XO4gmV86mrH7G588=;
 b=yvpOmbpWkdCMC2UFovIVkUX6hj0KpjmHqf8WGtjCcvdMDn1u9CTWhLx8C4cszjZsqOBSrkPmoR/R0ZdfjthbcjV18xQ6UKE7OohDyoT/rgtIakbLR5Bo8XF33ZVX0kuou3bF127gj6BfYhsxOqXGQ2cMfFEgjfpQ4aBZpMf4R/mLno9EnE/9rlQu0Asp0U9CFmoojqhh/Y2odwgir4/JqHNUcdj7C5m5INiJ1LXMA2t3jLKPwD12YW1hfhPtmpbq29UePrDEW8hFvfmCayGSXGw0YQd+hTOv0Ns7LBoQGGrrx7ixjjHiNDoIlzpNGUxoK6eD2ax31kpd/HL5J1W/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOCYYe9+Nn6oyV+c6TTfQfCIH0+XO4gmV86mrH7G588=;
 b=fEUQRMkfLQ5/fs4CKSOWYGJm+ttHwQ5UIYNc8ePG/kKiasg6u/f3b5szoedvckl+0hl/D9OCQBFuQvnn5b7GS9JuvKieBsSviEC9fgqrdvDa1wd5aHGGjdzI3FOJG/i8y7+j/3uqp0c7kkGPp0IbNz7TosbOuS2Grzo7OkUixAj9ieDB254F0L26wmQ31IR0xSDSWcT8JEkhAlb3Vop5kZyCoSr0GTvhIyciu58cm1Z+JJhJuWaT5X3ZbxbKf25nLixUYNjXiTHRcvnBtMfJot/3SZxdPQ5xYBdHBi700ytrlNk1TGHrkPPYDuQRIzyFUnekFCnpCi86Ggt0/I5r6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA3PR04MB11228.eurprd04.prod.outlook.com (2603:10a6:102:4b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:03:49 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:03:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jun 2026 20:20:26 +0800
Subject: [PATCH 03/11] mmc: octeontx_hsmmc: convert ofnode API to dev_read API
Message-Id: <20260604-devapi-v1-3-961aded05ff4@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92dab254-c6df-4573-2c23-08dec228f4ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
 raIUgWhRLzmkE4/YWIlNZus8Btuds7ZvsHslALkCMFZoZ+evcyXlrCDgnNmzKWqRV5Gm0fz9YswFw7+BTWhFsd6gQEY+enz27lvSOh7pmbn+Ii8vHdQcdPE2qoyXTtJ3c2Jg7SG0k9PjKx4nfbl0C2Ku6etT2BopU1hPaoXl+J+yL2uel7SEIC2vFgxno+cQdMlBL4FDSWoMqjAyj2oQuBwSSXwW1rmroZrEXrkwkmX5P1ys4vvlLwFtsUwq9608xrScdw7iOpEMJ8VBhtGNQWBKl4vSXeUATeIDzyunA1idYD4/NyrHPvyiyrR9Lj7lj8qxwAjh4p3iDWNmMBdVyWbfvnoJ6yo+N9fHbOt4slHP7hCSYZczE+sUkyNLWzE8kmm19gNeK27lOdp665KtPtOwbDPZozDhgJE4ddT0+57PnCgJVmFevaNBK6ayYbVid0J1v/qWQ/hj8BueD6WC3ZAnsysPrbBpDHVha75/HhF6jzKMLe8BOg6dUQVZBGCpR1hyz/hVKCMdPLaopP+kn2Bkz0OXf06vVPsmnIh1JgdvVqVJWK7Jocdvwnl8hQDJSt/10edlz0pySoh1lQIME6IqQRRHQS3PJZMV7BlVqgafBErxjg5gTfiEPbApftrtH+YPy/xi0zS2T25sI5EwY8bZEN4DXvfVdKRyAZRc6hOE92I60XImieN3U3idOpCoHmCop6J9Hw9YPeM5NmagniE0VRrlEQsRTn3xfquv4FtSTT0wQGOWPlKxmJIG6jFS
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?blJUL3FWUXA5WW5FNE9oeTgvcTl1cmNQblBteFMzSXRQcURiT3drbUk4V2hD?=
 =?utf-8?B?RDBWWEZaQWxMVFd5emlLcmxYUllzcVQ0YVdFdGFRMHdkaEdOcWc3WTZJYi9t?=
 =?utf-8?B?QVpnZzI4emZMTkNtTHpqK1lXNU5GdmRpa3FvdzFXQ3F5Z1BCejViSFNDdG9p?=
 =?utf-8?B?N24yVU9Qc0xPYXp3YVc4Z3pxU2FsdEFZaTVjS0xHWWsvc1N1YTkrZitrblJX?=
 =?utf-8?B?dnRocWo4Y0tnRHJFOEtMaDNpdE81eUkvSEh6eFpZd2wwVFJ0Z3ZUbTVNdkts?=
 =?utf-8?B?WGRxMEorN2w3aWdzbnpJMGJXNGV3WUg1MUMxamE5azdSR1VaS3VhMkdMUXlQ?=
 =?utf-8?B?VDJ6SnBWdnNOY25sSGhDbWxUa0IxblBCaytZc3BiSVZLdU50OFRjMFVEWXFR?=
 =?utf-8?B?REplRzI1bGVFYWkzY2RhbHBzSnVUVjVXaCtxTm9lWENVQ1J6a1ZPVlFUcnNM?=
 =?utf-8?B?dXMycGpQdGN6L0ExQnhoZVhXN25hSlZ1cklyQ0lkWWl0YllnZ29XQ2p4MnhT?=
 =?utf-8?B?ZkFQU3pMaHZPTDFqTnBBTG93Mno5UTBDSU9XbE5rMlJsYkI2M1hqaGx0WEY5?=
 =?utf-8?B?UHI1dzBRamQzN2FOTC9pa2V0Uzh3UE5ua0VVZ3k4cXh1UU9EMFFZNFc5ZWFy?=
 =?utf-8?B?c1c0aHVyWVBNdzBjOEMrS1lLY1FxSkQrMmRtZncvbUs0T1VpOVZjQWViWjNP?=
 =?utf-8?B?VDBRUktsNDk1VDZvblI2SjRRbHpIdGdBTFloQkVlN1pob25zbVk4NXVKdGdm?=
 =?utf-8?B?Q2IzNUZHS0QvWVVTNndlZGdUZ2pWZFd6VVZQVWpiNldFY1lvcVZndktMUzVU?=
 =?utf-8?B?dW9DTmpuVXJjdjVYTkhEU1JNRTRHUERuK0ZVSUFKZTJRZlBENXl0ZkxoNkR2?=
 =?utf-8?B?dHI2bXJzT0c3aHhnL2g2RjZwWWdHSm5naWtnZFhSQXk2Z2RBYk14VUU4cVhU?=
 =?utf-8?B?d1NpbWlCZWROSjBMbngzSjE1cCt3a1B5VGt0UmtuRmxkNzV2aHFLK1F4cGZN?=
 =?utf-8?B?MHBsL0dNU2xsa3hxamR3QWJTa0IvczJVRU5ZYmdmR1VLdzdBM0tndkdVOHFs?=
 =?utf-8?B?NllZQlllSDlYVnU2MnY2Y3pUazF5aUlhSFVuOXdHNmhtbXVUTlF1VWNHQjRj?=
 =?utf-8?B?R1hEMDl0dENiSTRqTkNkSzY5dFVLckF4NHRTbFU5VmhuNXgyWXBZNitpMXpj?=
 =?utf-8?B?RWQrNmppUEdicUdHWnZQZXkxUldOQjRPR1lhSDdtUFg0R1NBWVFPMTliUmxR?=
 =?utf-8?B?TEp4ZXRVSFB6ZjdBc1JWQkd4NzE3dkllOXZoWTlVWUxuVHZ4bHBKd1Vlb1pT?=
 =?utf-8?B?NW1YNUhVZ0RkK0FKaXFvVkdhOTh1RVFaMVJGbm5zcFVOVWRFOE9XajhWZWE0?=
 =?utf-8?B?eENpSUordFlWMGd1dGtLZkJGaEs2SVlaNWJkOHE2TU0vSEJlS3Y5M3ZPYjJh?=
 =?utf-8?B?WkJ5bTl3Y1kwUFE4eDh0NUsvakFsQVhFa0JXZG1QbGlYRCtsUld3U1pHeC9R?=
 =?utf-8?B?SnVTTjF2bUMvR2VHTU04bjRJclExYVo2N1M4RHVjOS9KZnNtU1VtNEZHRTNa?=
 =?utf-8?B?YyswNlViRC9WbzM3VWlFSDRBSWZST2tRV25GcFhVV3RkMkIwam55c1U1aTlT?=
 =?utf-8?B?N1dvUWlHMHZMVXVQNzdTbjNyYmlyYTFoaVl3R3Q5SUk2VWhyV3lyVnhTcGE2?=
 =?utf-8?B?TE5Zc3l1MnUwWjkzTUY5SHdKUkt1VE1HNnF3bURyYkFRT2tVMksvT3VTNGw5?=
 =?utf-8?B?RmhheGpNVEU1S2lKU1VIbnRBaFRDNjZDVFhiYmlHRVRkR2lCZFMxN1d2WWJZ?=
 =?utf-8?B?NFBUaDlnY0NqWnkzaEllQTdFUFFGVytCR3BVdVdBdzZQai9Ed3I0QzFkZnpD?=
 =?utf-8?B?WW1pVkVmKzNUdkF0SngyYW5MV3ovT0NxdDl4S1F1dkFyVmZtZXN1U3FjY2RT?=
 =?utf-8?B?RjlHZFJGSUx2M0ZXNGF5REhQdzI5Tk0rR0k1NWExYlNySVdkekJPQ21UZmpt?=
 =?utf-8?B?elhnQ280RHZqM1dNbEwyT3hCWE9GMitjb3loYWVYaDYzN0syb0YxTm91TFFE?=
 =?utf-8?B?RnhHWkRSTmVIOEhsR2dBTFhFQ3d1Z1FoRGJLYkpFamNaakt1NkZiYzZ0clNp?=
 =?utf-8?B?ZXAwM1VreTZqSjZXd1M0RUFMUmJoTnF5WmFsdG1VbU94NExyUGNQbklHY25W?=
 =?utf-8?B?ZkNOUXc4UVpCOGhmRzdLaHZ4Zi9zejYwZFl5WlF0aUtxcDB2b0VqQjBQV3lG?=
 =?utf-8?B?NFlaMEpoekkwMnZlVFV3RmRYQUVXTkZRblh3THNibk5wd1RWUEV0V3RTYXh2?=
 =?utf-8?B?RFRsSzhZWWcrTkxac0JTTHpScmJ1RDEwTVB0SCtzU3laQTdPU1haZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dab254-c6df-4573-2c23-08dec228f4ec
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:03:49.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1VHXDx1MWWoRGWu1bhc3XTJfD34AxEajdScJEzFva9Fguq9aVLDD5EGNhwrus06y/eTbDPAGKICfKmgq4YMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11228
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 12:30:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2989

From: Peng Fan <peng.fan@nxp.com>

Replace all ofnode_read_*() / ofnode_read_bool() / ofnode_get_property()
calls with their dev_read_*() equivalents across
octeontx_mmc_get_valid(), octeontx_mmc_get_config(),
octeontx_mmc_host_probe() and octeontx_mmc_host_child_pre_probe().

Remove the intermediate 'ofnode node' local variables, the now-unused
'host->node' assignment in the probe function, and the corresponding
'ofnode node' field from struct octeontx_mmc_host.

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/octeontx_hsmmc.c | 74 ++++++++++++++++++--------------------------
 drivers/mmc/octeontx_hsmmc.h |  1 -
 2 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/octeontx_hsmmc.c b/drivers/mmc/octeontx_hsmmc.c
index bb4fb29424b..b4942f99a52 100644
--- a/drivers/mmc/octeontx_hsmmc.c
+++ b/drivers/mmc/octeontx_hsmmc.c
@@ -3514,7 +3514,7 @@ static u32 xlate_voltage(u32 voltage)
  */
 static bool octeontx_mmc_get_valid(struct udevice *dev)
 {
-	const char *stat = ofnode_read_string(dev_ofnode(dev), "status");
+	const char *stat = dev_read_string(dev, "status");
 
 	if (!stat || !strncmp(stat, "ok", 2))
 		return true;
@@ -3536,16 +3536,13 @@ static int octeontx_mmc_get_config(struct udevice *dev)
 	uint low, high;
 	char env_name[32];
 	int err;
-	ofnode node = dev_ofnode(dev);
 	int bus_width = 1;
 	ulong new_max_freq;
 
 	debug("%s(%s)", __func__, dev->name);
 	slot->cfg.name = dev->name;
 
-	slot->cfg.f_max = ofnode_read_s32_default(dev_ofnode(dev),
-						  "max-frequency",
-						  26000000);
+	slot->cfg.f_max = dev_read_s32_default(dev, "max-frequency", 26000000);
 	snprintf(env_name, sizeof(env_name), "mmc_max_frequency%d",
 		 slot->bus_id);
 
@@ -3562,26 +3559,21 @@ static int octeontx_mmc_get_config(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_ARCH_OCTEONTX2)) {
 		slot->hs400_tuning_block =
-			ofnode_read_s32_default(dev_ofnode(dev),
-						"marvell,hs400-tuning-block",
-						-1);
+			dev_read_s32_default(dev, "marvell,hs400-tuning-block", -1);
 		debug("%s(%s): mmc HS400 tuning block: %d\n", __func__,
 		      dev->name, slot->hs400_tuning_block);
 
 		slot->hs200_tap_adj =
-			ofnode_read_s32_default(dev_ofnode(dev),
-						"marvell,hs200-tap-adjust", 0);
+			dev_read_s32_default(dev, "marvell,hs200-tap-adjust", 0);
 		debug("%s(%s): hs200-tap-adjust: %d\n", __func__, dev->name,
 		      slot->hs200_tap_adj);
 		slot->hs400_tap_adj =
-			ofnode_read_s32_default(dev_ofnode(dev),
-						"marvell,hs400-tap-adjust", 0);
+			dev_read_s32_default(dev, "marvell,hs400-tap-adjust", 0);
 		debug("%s(%s): hs400-tap-adjust: %d\n", __func__, dev->name,
 		      slot->hs400_tap_adj);
 	}
 
-	err = ofnode_read_u32_array(dev_ofnode(dev), "voltage-ranges",
-				    voltages, 2);
+	err = dev_read_u32_array(dev, "voltage-ranges", voltages, 2);
 	if (err) {
 		slot->cfg.voltages = MMC_VDD_32_33 | MMC_VDD_33_34;
 	} else {
@@ -3601,12 +3593,12 @@ static int octeontx_mmc_get_config(struct udevice *dev)
 		} while (low <= high);
 	}
 	debug("%s: config voltages: 0x%x\n", __func__, slot->cfg.voltages);
-	slot->slew = ofnode_read_s32_default(node, "cavium,clk-slew", -1);
-	slot->drive = ofnode_read_s32_default(node, "cavium,drv-strength", -1);
+	slot->slew = dev_read_s32_default(dev, "cavium,clk-slew", -1);
+	slot->drive = dev_read_s32_default(dev, "cavium,drv-strength", -1);
 	gpio_request_by_name(dev, "cd-gpios", 0, &slot->cd_gpio, GPIOD_IS_IN);
-	slot->cd_inverted = ofnode_read_bool(node, "cd-inverted");
+	slot->cd_inverted = dev_read_bool(dev, "cd-inverted");
 	gpio_request_by_name(dev, "wp-gpios", 0, &slot->wp_gpio, GPIOD_IS_IN);
-	slot->wp_inverted = ofnode_read_bool(node, "wp-inverted");
+	slot->wp_inverted = dev_read_bool(dev, "wp-inverted");
 	if (slot->cfg.voltages & MMC_VDD_165_195) {
 		slot->is_1_8v = true;
 		slot->is_3_3v = false;
@@ -3617,7 +3609,7 @@ static int octeontx_mmc_get_config(struct udevice *dev)
 		slot->is_3_3v = true;
 	}
 
-	bus_width = ofnode_read_u32_default(node, "bus-width", 1);
+	bus_width = dev_read_u32_default(dev, "bus-width", 1);
 	/* Note fall-through */
 	switch (bus_width) {
 	case 8:
@@ -3628,63 +3620,63 @@ static int octeontx_mmc_get_config(struct udevice *dev)
 		slot->cfg.host_caps |= MMC_MODE_1BIT;
 		break;
 	}
-	if (ofnode_read_bool(node, "no-1-8-v")) {
+	if (dev_read_bool(dev, "no-1-8-v")) {
 		slot->is_3_3v = true;
 		slot->is_1_8v = false;
 		if (!(slot->cfg.voltages & (MMC_VDD_32_33 | MMC_VDD_33_34)))
 			pr_warn("%s(%s): voltages indicate 3.3v but 3.3v not supported\n",
 				__func__, dev->name);
 	}
-	if (ofnode_read_bool(node, "mmc-ddr-3-3v")) {
+	if (dev_read_bool(dev, "mmc-ddr-3-3v")) {
 		slot->is_3_3v = true;
 		slot->is_1_8v = false;
 		if (!(slot->cfg.voltages & (MMC_VDD_32_33 | MMC_VDD_33_34)))
 			pr_warn("%s(%s): voltages indicate 3.3v but 3.3v not supported\n",
 				__func__, dev->name);
 	}
-	if (ofnode_read_bool(node, "cap-sd-highspeed") ||
-	    ofnode_read_bool(node, "cap-mmc-highspeed") ||
-	    ofnode_read_bool(node, "sd-uhs-sdr25"))
+	if (dev_read_bool(dev, "cap-sd-highspeed") ||
+	    dev_read_bool(dev, "cap-mmc-highspeed") ||
+	    dev_read_bool(dev, "sd-uhs-sdr25"))
 		slot->cfg.host_caps |= MMC_MODE_HS;
 	if (slot->cfg.f_max >= 50000000 &&
 	    slot->cfg.host_caps & MMC_MODE_HS)
 		slot->cfg.host_caps |= MMC_MODE_HS_52MHz | MMC_MODE_HS;
-	if (ofnode_read_bool(node, "sd-uhs-sdr50"))
+	if (dev_read_bool(dev, "sd-uhs-sdr50"))
 		slot->cfg.host_caps |= MMC_MODE_HS_52MHz | MMC_MODE_HS;
-	if (ofnode_read_bool(node, "sd-uhs-ddr50"))
+	if (dev_read_bool(dev, "sd-uhs-ddr50"))
 		slot->cfg.host_caps |= MMC_MODE_HS | MMC_MODE_HS_52MHz |
 				       MMC_MODE_DDR_52MHz;
 
 	if (IS_ENABLED(CONFIG_ARCH_OCTEONTX2)) {
 		if (!slot->is_asim && !slot->is_emul) {
-			if (ofnode_read_bool(node, "mmc-hs200-1_8v"))
+			if (dev_read_bool(dev, "mmc-hs200-1_8v"))
 				slot->cfg.host_caps |= MMC_MODE_HS200 |
 					MMC_MODE_HS_52MHz;
-			if (ofnode_read_bool(node, "mmc-hs400-1_8v"))
+			if (dev_read_bool(dev, "mmc-hs400-1_8v"))
 				slot->cfg.host_caps |= MMC_MODE_HS400 |
 					MMC_MODE_HS_52MHz |
 					MMC_MODE_HS200 |
 					MMC_MODE_DDR_52MHz;
 			slot->cmd_out_hs200_delay =
-				ofnode_read_u32_default(node,
+				dev_read_u32_default(dev,
 					"marvell,cmd-out-hs200-dly",
 					MMC_DEFAULT_HS200_CMD_OUT_DLY);
 			debug("%s(%s): HS200 cmd out delay: %d\n",
 			      __func__, dev->name, slot->cmd_out_hs200_delay);
 			slot->data_out_hs200_delay =
-				ofnode_read_u32_default(node,
+				dev_read_u32_default(dev,
 					"marvell,data-out-hs200-dly",
 					MMC_DEFAULT_HS200_DATA_OUT_DLY);
 			debug("%s(%s): HS200 data out delay: %d\n",
 			      __func__, dev->name, slot->data_out_hs200_delay);
 			slot->cmd_out_hs400_delay =
-				ofnode_read_u32_default(node,
+				dev_read_u32_default(dev,
 					"marvell,cmd-out-hs400-dly",
 					MMC_DEFAULT_HS400_CMD_OUT_DLY);
 			debug("%s(%s): HS400 cmd out delay: %d\n",
 			      __func__, dev->name, slot->cmd_out_hs400_delay);
 			slot->data_out_hs400_delay =
-				ofnode_read_u32_default(node,
+				dev_read_u32_default(dev,
 					"marvell,data-out-hs400-dly",
 					MMC_DEFAULT_HS400_DATA_OUT_DLY);
 			debug("%s(%s): HS400 data out delay: %d\n",
@@ -3692,12 +3684,10 @@ static int octeontx_mmc_get_config(struct udevice *dev)
 		}
 	}
 
-	slot->disable_ddr = ofnode_read_bool(node, "marvell,disable-ddr");
-	slot->non_removable = ofnode_read_bool(node, "non-removable");
-	slot->cmd_clk_skew = ofnode_read_u32_default(node,
-						     "cavium,cmd-clk-skew", 0);
-	slot->dat_clk_skew = ofnode_read_u32_default(node,
-						     "cavium,dat-clk-skew", 0);
+	slot->disable_ddr = dev_read_bool(dev, "marvell,disable-ddr");
+	slot->non_removable = dev_read_bool(dev, "non-removable");
+	slot->cmd_clk_skew = dev_read_u32_default(dev, "cavium,cmd-clk-skew", 0);
+	slot->dat_clk_skew = dev_read_u32_default(dev, "cavium,dat-clk-skew", 0);
 	debug("%s(%s): host caps: 0x%x\n", __func__,
 	      dev->name, slot->cfg.host_caps);
 	return 0;
@@ -3843,7 +3833,6 @@ static int octeontx_mmc_host_probe(struct udevice *dev)
 		pr_err("%s: No device tree information found\n", __func__);
 		return -1;
 	}
-	host->node = dev_ofnode(dev);
 	host->last_slotid = -1;
 #if !defined(CONFIG_ARCH_OCTEON)
 	if (otx_is_platform(PLATFORM_ASIM))
@@ -3851,9 +3840,7 @@ static int octeontx_mmc_host_probe(struct udevice *dev)
 	if (otx_is_platform(PLATFORM_EMULATOR))
 		host->is_emul = true;
 #endif
-	host->dma_wait_delay =
-		ofnode_read_u32_default(dev_ofnode(dev),
-					"marvell,dma-wait-delay", 1);
+	host->dma_wait_delay = dev_read_u32_default(dev, "marvell,dma-wait-delay", 1);
 	/* Force reset of eMMC */
 	writeq(0, host->base_addr + MIO_EMM_CFG());
 	debug("%s: Clearing MIO_EMM_CFG\n", __func__);
@@ -3922,13 +3909,12 @@ static int octeontx_mmc_host_child_pre_probe(struct udevice *dev)
 	struct octeontx_mmc_host *host = dev_get_priv(dev_get_parent(dev));
 	struct octeontx_mmc_slot *slot;
 	struct mmc_uclass_priv *upriv;
-	ofnode node = dev_ofnode(dev);
 	u32 bus_id;
 	char name[16];
 	int err;
 
 	debug("%s(%s) Pre-Probe\n", __func__, dev->name);
-	if (ofnode_read_u32(node, "reg", &bus_id)) {
+	if (dev_read_u32(dev, "reg", &bus_id)) {
 		pr_err("%s(%s): Error: \"reg\" not found in device tree\n",
 		       __func__, dev->name);
 		return -1;
diff --git a/drivers/mmc/octeontx_hsmmc.h b/drivers/mmc/octeontx_hsmmc.h
index 9849121f174..c374ce18838 100644
--- a/drivers/mmc/octeontx_hsmmc.h
+++ b/drivers/mmc/octeontx_hsmmc.h
@@ -123,7 +123,6 @@ struct octeontx_mmc_host {
 	union mio_emm_cfg emm_cfg;
 	u64		timing_taps;
 	struct mmc	*last_mmc;	/** Last mmc used */
-	ofnode		node;
 	int		cur_slotid;
 	int		last_slotid;
 	int		max_width;

-- 
2.51.0


