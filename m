Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E6FCCD1A4
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:41:45 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (CHN02-BJS-obe.outbound.protection.partner.outlook.cn [139.219.17.98])
 by mx.groups.io with SMTP id smtpd.web10.9651.1760682648111250249
 for <u-boot-amlogic@groups.io>;
 Thu, 16 Oct 2025 23:30:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: starfivetech.com, ip: 139.219.17.98, mailfrom: hal.feng@starfivetech.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z65OOz7gqtc2p3RL9cFwujH1Pu08bEL4HgPFIF54N5sNMw9CO8JxEde5wVlpaBRrCZpVQH/6I5HHjRyfhltJwlqPz/4J4WOKWdJHDgfmr39QTxt5o6EOXCIlM9xqd6I3l7UWhbhB9yPD2DmCWuLzwdelYznCF00OF76Wi+z2CRMQj4kdN1pQDNvRkIL5wVQ3CaUoKwOqVO0WuZDuPNeE+FRKxV67V3vW/oNow175aDx+F9QGXHlUA9SkPqo56lZTiRPiikJs3q3mrxmVmek/Sl80mx22679EFhIbDHLWwKNd4P9+qTZnIDaghLD5jm9yLx3RMYiqqJ09Gfis5gjNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRbwJHgqJbGObCubRJClpZaAICrSiP1lLULx0nM1ljE=;
 b=mOvT994bLO0qMZsygftlrtSayHGa/CsIrfCq4L4GvpeXe1n4tfOftlpYhr8IvxrltMtLZekKE1GpU+J6UBx28KFLbpAMiNL/Nfm0mr7fVD+z03P4m0s+ejvO02IHodzuE1MUA9psrfPw/RmSKRAL5szHnNZoajJMt8ojbqk1uaI+0/iIFBq06v0BGRV0uHQtr4+ipIdgn1oOTYq+e8hkkh/0pjWld//Ubz6ncX0DDhsYzJsgzdGQ+oOM23BTezRRRSZngwIyLTHh9s4hj87kRm4yhbUyvHI3e/mbCujSAGGfRpJ5f6WMxSCJ8LxqYZ+jLxBB0x2ou6INl9r+ryX0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1292.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Fri, 17 Oct
 2025 06:16:25 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9182.020; Fri, 17 Oct 2025
 06:16:25 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, "u-boot-amlogic@groups.io"
	<u-boot-amlogic@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
	Paul Barker <paul@pbarker.dev>, "uboot-snps-arc@synopsys.com"
	<uboot-snps-arc@synopsys.com>, Dai Okamura <okamura.dai@socionext.com>,
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
	"adsp-linux@analog.com" <adsp-linux@analog.com>,
	"uboot-stm32@st-md-mailman.stormreply.com"
	<uboot-stm32@st-md-mailman.stormreply.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, Stefan
 Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>, Leo Yu-Chi
 Liang <ycliang@andestech.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
	<sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
	<kever.yang@rock-chips.com>, Quentin Schulz <quentin.schulz@cherry.de>,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, Jonas Karlman
	<jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, Joseph Chen
	<chenjh@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, Heiko
 Stuebner <heiko@sntech.de>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Peng Fan <peng.fan@nxp.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, Michal
 Simek <michal.simek@amd.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, Sam Protsenko
	<semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, Alice Guo
	<alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, Padmarao
 Begari <padmarao.begari@amd.com>, Minda Chen <minda.chen@starfivetech.com>,
	Sumit Garg <sumit.garg@kernel.org>, Tien Fong Chee
	<tien.fong.chee@altera.com>, Alif Zakuan Yuslaimi
	<alif.zakuan.yuslaimi@altera.com>, Naresh Kumar Ravulapalli
	<nareshkumar.ravulapalli@altera.com>, Muhammad Hazim Izzat Zamri
	<muhammad.hazim.izzat.zamri@altera.com>, Tingting Meng
	<tingting.meng@altera.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Minkyu Kang
	<mk7.kang@samsung.com>, Heiko Schocher <hs@nabladev.com>, Jonathan Currier
	<dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao
	<weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Sam Shih
	<sam.shih@mediatek.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Thierry Reding <treding@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>, Nathan Barrett-Morrison
	<nathan.morrison@timesys.com>, Greg Malysa <malysagreg@gmail.com>, Ian
 Roberts <ian.roberts@timesys.com>, Vasileios Bimpikas
	<vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
	Arturs Artamonovs <arturs.artamonovs@analog.com>, Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>, Dario
 Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH 10/24] clk: starfive: Remove negative error returns from clk_get_rate
Thread-Topic: [PATCH 10/24] clk: starfive: Remove negative error returns from
 clk_get_rate
Thread-Index: AQHcPeCTl3OZn3TuNkywZg/cMbxr9LTF3l3Q
Date: Fri, 17 Oct 2025 06:16:25 +0000
Message-ID: 
 <ZQ2PR01MB1307D6856E5DEB84C846F4DAE6F62@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-10-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-10-5f80f827407e@linaro.org>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1292:EE_
x-ms-office365-filtering-correlation-id: 87baa8eb-f7aa-470f-c8ac-08de0d44b398
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|41320700013|1800799024|7416014|38070700021|921020;
x-microsoft-antispam-message-info: 
 OkGCrB2u36G52ugbtSKBEQlFYYv33x3lJ3sPSiNnpzXRc28Pft37w4qzHTHZdddNjU3XCGiv0XH8XHDI6sxV3LxlBewJaNnfkibizxGUWHlHvWS5hjCLFdHV7IdonrXWxpQ49zH2xfVHbl0AihZ2A0JxaIxfnFohZtZ4YwdmmofIoFlV9oCtLsOCgE3nFBsn1S5rKAVgftuqiAdn2P1ctwWcGTaWwkoi9MSIyLG9G/YcDuwrs1S92hPaWlsmDVZ4xeE3MM7Qk0xQQ9F5qiZZI0pG/NV06bDJbR3u80KMXKM2euk5IsExU6Xg8S84E4iV8s8MtN+7Jt3YaTJ+PuVTTvIIP1UbRmMfzU7m4qQHYWIkV8BSvQk9aDlu23JiZL2CpLy9DfvYW4gN+ZbHUyD+foshIoRX5q2t0/oukNJyvFBKQ3RDNljoIrxbl/EL0kipV4nn7V7ulrYEnOt7uTuh6DRgtKpI6Qnfei9pytFMiTlWXzAqjZc2CwQ/2ux63qOiHryQmElQ6cMMVPWxr9+SQmJFPMryvqIAkYIpjait1TdlutedNgnS6qWgzuPbXG3a4B8ewgFWCeB8s3I8++B3jJSYyVVtYA9QZP7PjezRjR4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cHFQSmlWdlZwN3lZNTh5eFI2SzB1WktsQnJsQ1ZJT0k1YlE5dDc1aWxKMVZ4?=
 =?utf-8?B?L01qeXI2WTZVZTI5Q0liRWx4QWNBVUl6VnR4V0JKKytuNUxXaWIzTi9XeUhW?=
 =?utf-8?B?elkydlNiQU9zUFY4eGQwL0c0MkdKVzJlSjVVclEyaU5TNXc4WFliTzJtVkFZ?=
 =?utf-8?B?b0FIRVpPejBGeE1tVXJ0bHVPUUFLdUtXZ2VxTEFvQWN3emUxellGMGtzcnZ0?=
 =?utf-8?B?cTc3c0dybWRhUEVLNmRCTnRldjdDeXJZQmhtQmRST3NaalVubHphcmNLZkZq?=
 =?utf-8?B?cXo4Z3lBTFZKUjZqcUlyNHQvS1UyellUK3huUzgra0U0eGx5ZlF3ZnJFbHF3?=
 =?utf-8?B?NVpBK2FBbFlDSjkvQzhKZXJZby9Kd21hZU9STHB6M0NhaHFnak80cFdMWW9E?=
 =?utf-8?B?UUU5QytoYTdNRFJWTUdHc1ZmSzlHeWVxQ3JxZGNoNjdJZ1VUQVByVTFmNlov?=
 =?utf-8?B?d0pkcHRaOHJMU1pPRmx6ZnI4L09KZ3NQemQyQk0vR0Z4bXJIN2h0WTByL1RY?=
 =?utf-8?B?eVBCUlovUnpRdXNodU8rUGlMdFl1dkU5YlRhcEswYVpOYUVFTDVMV1M4WHYv?=
 =?utf-8?B?QTZVSzByc3RtOTZLamJTbU93UzY3S1pUN0VBSnZUblhaV3FlNFBIcUJOcXY4?=
 =?utf-8?B?dTg3QXNWODBpTXRzZzVuaG94L0xwZHNtL0poSEJjVUZzQnYyWUtOZkkybnlp?=
 =?utf-8?B?S25NVDJIajVCcG1McmsvWitnNEZvdElVTHpqdDlkUWozT1R3Z2RhRXdlb0Y4?=
 =?utf-8?B?d005dWJvNTBKaVJyNEliVTlFcCt5ZTZSb0xkZktaMzErcnZqRSs2K2VZWkl2?=
 =?utf-8?B?L08wZHFPR2FnUVAyd1phWTJieGFldjdmY0FJRkt2Nkt6NE8rTVcxMnh0dy81?=
 =?utf-8?B?dC9yVExCSUN3V0dqTHlSbkFocHloc0lycHgrV0lvQ1ViUis5NWdLWHVQZWx0?=
 =?utf-8?B?Z0xTVUF0alhjcEJ6MmQ0cy9Tcm8rK1JUUUlTdkVIczYvS2VRQUU1SThnNDk1?=
 =?utf-8?B?VCtqVStKM21JM01WKy9kYllZUWs4dWpFdUFrQ0c0aTJFK0dHb1FTaW9UUFkr?=
 =?utf-8?B?QWVmRHlOMTJqVXA0elBiWXRGR2lyaHZzb0tab3hqTlJVQ2I1RTZOeE8zRUYv?=
 =?utf-8?B?N01EbXBMeHNNeU1jZWlRT3ZrTXRPQitQVCtxRnpVeVVPVnUrRjNlVTlkMXZU?=
 =?utf-8?B?UTZ1b0lpbjFKUi9mWlNsdndNM2p6SkpXVUlIRElIcE5HclhsbU85YmR1Z3hQ?=
 =?utf-8?B?RytNZzdRWEZJcmVNYlAvY3NCMFZxUTJjajdqWko4RVB3bkQ2VnRUREdhc2sy?=
 =?utf-8?B?WDRDNmpacmtGenBWWWk5QnZoRlNXOTYwdVVBSm9TOEg2Ry9rSUU1SHp5dUZa?=
 =?utf-8?B?cWNQMFFZMjFOdXBOTkpqWTJJb3hxVnNpVVZnZ2JpS3ZhbGgrQVpLOWJWMFpR?=
 =?utf-8?B?bk5Pc21lNktheTZvbi9NYTJ4dWhnLzZEdmN2eUVnMFZuZzVUYktOSEVyR2FM?=
 =?utf-8?B?Y1lubG5BQVYzUXJVbmV4V1ZYLy91Q05KK28zTzJpKy9PeFhHYVNMNzg3L0pN?=
 =?utf-8?B?T1c1ZVd1OWxzT0s3dnFkK2dUdHROSVZTQUNJOGJ1WmFVVmVpKzZzT0tpNlRJ?=
 =?utf-8?B?eTZ4Zk5tZ0x5SW1OajIrbWFHU3Z5cWZZeUhRK2dCV2tISjBiSnBpVVlIVjNy?=
 =?utf-8?B?ZEtVc1FkMDl3V3Fya1hsSXJBVk5vQzEvQlhUT1NqNXZUSlpiUWgzY3AvWHpF?=
 =?utf-8?B?TlhoVWR6RFpBcTgrTlEwc3V1bFMzcFpteVVaSmZOL21KMEZ5bGp2cUdCb2lx?=
 =?utf-8?B?bmMyWDluMnJDT0hYUkpzbVZJYXg0TWZqSmlrREF4b2FNd3ZaWHJaeEl6Z0hx?=
 =?utf-8?B?aDNOSng0VkUxSmJQdDJHWm53K3ZVYzNDSkY2UkpScEpMblovR1pHLzZNUEFN?=
 =?utf-8?B?dm9zQmkrNjhnRE5YZkp0bEpxUktUcStmczNyaFNEWGZRMVRlRDdLbDUzZURv?=
 =?utf-8?B?d0FVUXhtT01hY1pOejF0cjFKekVSeUlKazMyL3pQMFcrNjEvbFFTMTZobllF?=
 =?utf-8?B?Nk81azhOWUNIcFJmMmYrWWRyaUtYUVFmaFFGTm5MMWw2ZFdaUGYzbElHenlx?=
 =?utf-8?Q?7hIKfK1LsVlTnaIZCtJLHfPd3?=
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 87baa8eb-f7aa-470f-c8ac-08de0d44b398
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 06:16:25.5171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXAQQgC3sfzFDo4QPF3hMKlbvwoGCtXpwU/DGVseUbxFjADQZNxZkAWx6A07sKN8u5fcLOjhMon1tPUE7F7dXv9BOCbrv5Cf10L+dmrcKUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1292
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:41:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2842

PiBPbiAxNS4xMC4yNSAyMjozMiwgQW5kcmV3IEdvb2Rib2R5IHdyb3RlOg0KPiBjbGtfZ2V0X3Jh
dGUoKSByZXR1cm5zIGEgdWxvbmcgc28gZG8gbm90IGF0dGVtcHQgdG8gcGFzcyBuZWdhdGl2ZSBl
cnJvciBjb2Rlcw0KPiB0aHJvdWdoIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IEdv
b2Rib2R5IDxhbmRyZXcuZ29vZGJvZHlAbGluYXJvLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IEhhbCBG
ZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpIYWwgRmVu
Zw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvY2xrLWpoNzExMC1wbGwuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1qaDcxMTAtcGxsLmMgYi9k
cml2ZXJzL2Nsay9zdGFyZml2ZS9jbGstDQo+IGpoNzExMC1wbGwuYw0KPiBpbmRleA0KPiBmOGFm
MTcyMjdjNTAyYTM5Y2M4ZjRiNzdmNTJhM2Q4OGZlZDIxMGE5Li4xMmRkMTRjMDJjNjgzYmI4NjA3
NDMNCj4gYmNiOTk0YjU0OWU3YThmNzRiYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvc3Rh
cmZpdmUvY2xrLWpoNzExMC1wbGwuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9zdGFyZml2ZS9jbGst
amg3MTEwLXBsbC5jDQo+IEBAIC0yOTIsNyArMjkyLDcgQEAgc3RhdGljIHVsb25nIGpoNzExMF9w
bGx4X3JlY2FsY19yYXRlKHN0cnVjdCBjbGsgKmNsaykNCj4gIAllbHNlIGlmIChkYWNwZCA9PSAw
ICYmIGRzbXBkID09IDApDQo+ICAJCWRvX2RpdihmcmFjLCAxIDw8IDI0KTsNCj4gIAllbHNlDQo+
IC0JCXJldHVybiAtRUlOVkFMOw0KPiArCQlyZXR1cm4gMDsNCj4gDQo+ICAJcmVmY2xrICo9IChm
YmRpdiArIGZyYWMpOw0KPiAgCWRvX2RpdihyZWZjbGssIHByZWRpdiAqIHBvc3RkaXYxKTsNCj4g
DQo+IC0tDQo+IDIuNDcuMw0KDQo=

