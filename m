Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFDECCF2D6
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 07:36:14 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21485.1792156864745007652
 for <u-boot-amlogic@groups.io>;
 Fri, 16 Oct 2026 06:21:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=gcD5so7b;
 spf=pass (domain: cherry.de, ip: 52.101.72.41, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJCP5lTHbMYxK9EwbbJDLS/WP6aVe4axv2ibJ5dOzDP8zXapUFzMZsiU3DFBbbIDXBl49J8BJWeL6sFahgRsF/RTNhOfkwANF79vG8noOznyG5uhFni9LAignsJuKkoH0mPLfJ2+s+w736NZ1KY9NTrOCNLOdNpP8XN0cCX1g6AS1ZFmDgOnL7oChVclYvqV6yduaN46LpsDANJpJlA5rdN91Qm/Rk9HAZbzBRsdlsCR3R8XRPdO1ynXhuw8fxXcHKXu5QMc3HQyHSH9ZUjq+3N9QFQSlhVH7bWOAyV4R1wjtTRg6MO2njt1MEfpQmt0E9P2DZV4ssMTCBLbB1mh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/AC3iJv2p/7X2bMpXIhp6UAs4HMPojT0Qy7prr9qBY=;
 b=iIqEMd4WlEXUeSiMXjQqo8T3IooBLz5rcxdx1QU4EvcOff2Z3ZfdiIoddnV5xqO4ZfZAgkNQSs6peLTiwCiZcH9B3xwUjZkJ1JL5cVAuCEsCKZ/kfmS0+K8aRg3fkbLZyul2suJ2Ti8a6A11JLA3AjsJTmaxIg1J4pkJQMfomS1+mrA6qdEASfOuVXN26Tm/lqp1Mpc9bTJMC3vQGSbj9dTbNeaTJKS0l1HpGkPpW7wyqQ5bs9DF1DRwHewBMhT6tMB/VQcbzqDgGoaKe6aO0yaYqngzC37Kf+XjH2Q0k1uXyvI/FvTjujihroWBpLPBe0xPQP6drMYYAxs0pU7BkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/AC3iJv2p/7X2bMpXIhp6UAs4HMPojT0Qy7prr9qBY=;
 b=gcD5so7bt4CB8a2+qMUVAeARLAHGWPA233SOLxPz0rMlpJXtWUIWGfzSwC0sMYvI2IV0Dh5RD3+GT04mBHvxcNSFBxbtO23uoqCOIUQRPI6LhI8fhv+kd/S90SEZTUYqhd7kRbCWUYRMKrmKhcITakI4gjmg01D2x/Nf2VNhiVI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 13:05:16 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 13:05:16 +0000
Message-ID: <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
Date: Fri, 16 Oct 2026 15:05:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: regulator: rk8xx: add RK818 LDO9 support
To: Shigeaki Asai <y-asai.0816@docomonet.jp>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-2-y-asai.0816@docomonet.jp>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261010013237.2269021-2-y-asai.0816@docomonet.jp>
X-ClientProxiedBy: VIZP296CA0025.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 5623f523-1239-4de8-3896-08df2b861f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|56012099006|4143699003|5023799004|261009223027099003|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	p5MYBwwkjlp+kPfFLHny2PpTqH77swnygr7kivY+wfr8Rig5RoTT5/+RPXqgkf6Zsc81wM545nMYO7UddvEjAGNlUcv9agiUPw6EPHoM0ARHHgJ3ENm60mzMCxVb1ZNQcNCymjYDgzyDK0UAW3ehCEyRsm8Qw6Qe/FFKVencfYa1wMcDL4WVFj523eCsobaw6xX+QeYIownlPCplPPIqexcoP4f6DzC/fEId0KUg4/TFsjnbwKUvlFhkYzofA22Ee7Y/nfXGpSgShtxU0i7k34tXqflx0O/oCOU5i7Kgm2c4M8IECCFkICQVSlbNJRnkURaY4AzWLRWWov2DfPnhZqa5Dy2tqaX4diH6N6qfecyn28jAwcl+w5fPeASE4DpARI/Fo1hfKjSZhp6xQ7MMcjCfdRPwdSTvt8XA6M9Vo0IfAkeCMESdlnUbGKnwHwG5fQKVFzcbuo8ftXRboXOn1guZaKI9BxCovRvOyAklAkuUsj0vaglM5Q10w2hGESV7Hg5TSEhB2Mie33tRzdIq7j/aiU8ZiBPO0g2CTZpkCWcCsW0LkoLHUQp5ZUDOUpmgqvRJ003fOlno6DlwK9ojRTo2gPN0ZtmbVdGcMu3is4Rjvd8W3V0+ffnKR6nR4wKgwNo1yjNldej1UQdCJLCEnoUA5Zx/F/WGD3v4iskhB18=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(56012099006)(4143699003)(5023799004)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0gwY0h1Qnp1aUxMaWdhdUh1NUpyRWp3MVJHUUh3NFdXdG51M04wYzMyQTRS?=
 =?utf-8?B?TXQva2poSjFGeWxzQklxdHI3N01FMXprZEpNaXhKU1JLemhhVFJ1RDE5bUNX?=
 =?utf-8?B?L2kvV0FpcFRRd3JjVmhNSWowM1NGL0hBWno2ZGRkQ25mWnlNa2hHYVlrcXNS?=
 =?utf-8?B?RVhxaXNaSDBoRzVSekFXQUtnREw1TXpDbnpIRjR5UU9WeXdJVlMrQ3dKdGc4?=
 =?utf-8?B?NTNMbXVXTmZ0NW4xRHU4ai91RFdvWXFSaHNBcGRXd3FUVklmakNJNnFGbzRC?=
 =?utf-8?B?VzZYYmtjT0xLVjRWdXNGdmd5bUVhSGRTZnVtUm5xWGc1SmllSjVLcGVseXdl?=
 =?utf-8?B?ajlxU2ZQN1V3QVRIWmdmQUlsaktTdHRjODRNZ2Z4SjBTUG1LbGF6bjJqOEtU?=
 =?utf-8?B?MndvWWNSSzdzSWdNeEhGYzk2YXRrT2RFUUVNNmFCTndzQ3VZdEdjajhNZ3Vl?=
 =?utf-8?B?U3Npa2M1NnNhQUtjZGZNandRSzhuWE41ekhZMEdGOE9MWEdaYVZ1OWh5UE1L?=
 =?utf-8?B?NEMrRGUyTmlPQVBGU0o0ZlluN01XTzhUM21SY2E0ekxEYUpsWnJXQzNwRGk5?=
 =?utf-8?B?ZWhtenB3cVp4czZMbHJjZlRTWlNSd043QUMxL0xTbjdDNkZDVTQyWG9EVVdk?=
 =?utf-8?B?MXVXbEtPRVZXdUM5b3oyYkFWRmIwVmxkblJrSEdEZit4dFNqZVhBYksvM0R1?=
 =?utf-8?B?MEZTMjJRUllUeW9HRWMrNlBLbDJ3cHBZQy85OTVucm5BR2k0SU5uS0ZEKzVV?=
 =?utf-8?B?T2FCY0Q4dFg1TGVLaWMyaWgvN3k5eTVqR3AreUt5YUpuU0htWFNQMWZxU3JZ?=
 =?utf-8?B?dkNXelJLVXhsblE3ZHpEVjNoUlZka0xKeTlaOVljbUJuNW1yVWdqWUJrVWxN?=
 =?utf-8?B?ZzZZNmNPeVhONVlGbDg1WEtRNEdEUGlQTC9tR0hoT1RWdHVib1QydGVnY2xr?=
 =?utf-8?B?NUowMk1uS3p2U3pkc09CZnJGT2lxOVZhUVZQN2swczcvbHBWR2dJL1dFQkhz?=
 =?utf-8?B?VTJsbzNFVWllVExlRHdJR2pKRzREZSszd0I1ditGaWI2UTB3bm5NQlRHYmNW?=
 =?utf-8?B?Nk5qSUN2RE9kY0d2NDQ3Z09WSE1qRFRBVGdMQkJHTnpDUTFRbVE0dktEckEr?=
 =?utf-8?B?RkNSMGd5STZjNWtvWVZVd0luUVYzY25Ibmdya05rMzE1RXU2aHQ0blZRR052?=
 =?utf-8?B?aHpzMGIvc3JOQ1NRaEI0RlFCU1RDUytwSkpzdTZiK1pYRjhxWlFSNEtxQWVS?=
 =?utf-8?B?b2JhRzFMc2hDeUVXUUkwNXJhUHFsbTExUFhxK0ZZOVlsc0tnVVoxQmZUM2pG?=
 =?utf-8?B?YUhoeHcvTUd4UFJ4UlBNZExaMUpGbG9nT0FXUEhJb2JiMFNHR3dEKy9FcEcw?=
 =?utf-8?B?emlOdGplVkxTVFBmWVNhaHV4MUJBM25uV1NKZGl6RGZuem1WK0JGQVlWNlhr?=
 =?utf-8?B?eHBhVzM5QzN1enp2WXlGNml3bDBvRVU3TU5idEdTSUdqekZmdTNuTGkyVUxk?=
 =?utf-8?B?dEkraXUxd0RubzA0NnJ6ZHBjZE8xRkthTUVPYjU2YU5QZCt5dXJKbWp1eUZK?=
 =?utf-8?B?c1VZWk9rY25yeEp3SVYyUklkMThicENvb1d5SzdHMlpKL3lqUzUxV3VsOThL?=
 =?utf-8?B?YjZPampraEM1SkNzaG0yUWxsUTZaT0diRkE1NFhsbGMrTi9pYTQ4b1pmbDVF?=
 =?utf-8?B?TFI3U2Y3WGtMeW0zQ09SMDdhRnJnWkduMit1eTY4eWdsMjk1WWxFY0hlRkU5?=
 =?utf-8?B?Ly9TZ1VIeHhKQzZPNTdJQUlXNU9wQnlHd1pqclZUanV4c2EyYXlLclhCRXgr?=
 =?utf-8?B?bWJPNHBiQU1VeW5tNVhJTDhNeXJDc3hJa2RBbElsc0JZUHpPVGh2WG5RYnFR?=
 =?utf-8?B?dkNSL1o5NFUwT1RqWXcvdDQwUlFNT1phSXViay8wTUlpS2FxWE9kSE5QUmUz?=
 =?utf-8?B?cnVvZjh4MUd3SkdMSjlCb2ZTdDBEd3BrSzdSWUJHTzFGbUZVbTlya1FBQmFU?=
 =?utf-8?B?dzBhdGtkc0RGRTU3VGt1djVyZ3Y3Sk1LYmJXb3JsY1BuOXJRSUNHcUlUZllU?=
 =?utf-8?B?VmFDS3ZjWFJjTlFhNDRubGwvNUErWHM2NDhTSHhOUExqQllTUy9tRGRkcFVQ?=
 =?utf-8?B?TjdkaUl1b0VaSzBhdU0wR3N4QkQvdHNpRS96RXYrNGlFdzlNQUh4RG1RMHR5?=
 =?utf-8?B?b015TVFYdlZWTVA2eVJpVndsNlY1aDZubEV6S0loUW8zSzVqWUNrTy96WGhl?=
 =?utf-8?B?SVlLenk4WU9Sclg0cEltTmExcXgzM0RlVWlVdzBvdlNPeUtldHhNa1lKMXBR?=
 =?utf-8?B?V2JuQ2JvSXFUVnJWREFrQ3ROSVFBK0hpODhrcDZDckxhMzMvbFZvdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5623f523-1239-4de8-3896-08df2b861f26
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:05:15.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjoVOPyLUe4IqbFEtaQtGqDIl1SkNiR/A6J1SZoRaAcU/5WWKBvbOgG5+lJgeLbPxTjYVYO2EhEih6jZWJuaqzlP2LRquaCcpMHwTfVLwao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 19 Oct 2026 07:36:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3138

Hi Shigeaki Asai,

On 10/10/26 3:32 AM, Shigeaki Asai wrote:
> The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
> LDO_REG9 indexes past the end of the table. Its voltage reads back as
> garbage and it cannot be enabled or set.
> 
> Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
> registers (bit 5), and its voltage selector lives in
> BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.
> 
> Add the table entry and handle LDO9 in the enable and suspend enable
> helpers.
> 
> This patch was written with the help of Claude (claude-opus-5-5).
> 
> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
> ---
>   drivers/power/regulator/rk8xx.c | 46 ++++++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 88453bb7bdb..cb402c96ec8 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -60,6 +60,8 @@
>   #define RK818_BUCK4_VSEL_MASK		0x1f
>   #define RK818_LDO_VSEL_MASK		0x1f
>   #define RK818_LDO3_ON_VSEL_MASK	0xf
> +/* LDO9 is switched from REG_DCDC_EN and REG_SLEEP_SET_OFF1 */
> +#define RK818_LDO9_EN_MASK		BIT(5)
>   #define RK818_BOOST_ON_VSEL_MASK	0xe0
>   #define RK818_USB_ILIM_SEL_MASK		0x0f
>   #define RK818_USB_CHG_SD_VSEL_MASK	0x70
> @@ -297,6 +299,8 @@ static const struct rk8xx_reg_info rk818_ldo[] = {
>   	{  800000, 100000, REG_LDO6_ON_VSEL, REG_LDO6_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
>   	{  800000, 100000, REG_LDO7_ON_VSEL, REG_LDO7_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
>   	{ 1800000, 100000, REG_LDO8_ON_VSEL, REG_LDO8_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
> +	{ 1800000, 100000, REG_BOOST_LDO9_ON_VSEL, REG_BOOST_LDO9_SLP_VSEL, NA,
> +	  RK818_LDO_VSEL_MASK, },

Please stay consistent with the rest of the file where we have 
everything on the same line.

>   };
>   #endif
>   
> @@ -695,8 +699,13 @@ static int _ldo_get_enable(struct udevice *pmic, int ldo)
>   		break;
>   	case RK808_ID:
>   	case RK818_ID:
> -		mask = 1 << ldo;
> -		ret = pmic_reg_read(pmic, REG_LDO_EN);
> +		if (priv->variant == RK818_ID && ldo == 8) {
> +			mask = RK818_LDO9_EN_MASK;
> +			ret = pmic_reg_read(pmic, REG_DCDC_EN);
> +		} else {
> +			mask = 1 << ldo;
> +			ret = pmic_reg_read(pmic, REG_LDO_EN);
> +		}

This is not great, I would prefer to have some additional configuration 
in rk8xx_reg_info instead, but since we do it for many other cases 
already, nothing for you to do on this issue in this patch.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

