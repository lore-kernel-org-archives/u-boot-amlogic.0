Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF38C61DC6
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:29 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6781.1787726271252243974
 for <u-boot-amlogic@groups.io>;
 Tue, 25 Aug 2026 23:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=oyDWb6zD;
 spf=pass (domain: oss.nxp.com, ip: 52.101.69.45, mailfrom: peng.fan@oss.nxp.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4PhGge8GeX9enkTWhXZFeE2ScGfMBJC4/S2gmHk+KdSv2uWB1kPijfBesarFcHquV6c1Y5yQgDjEhL5AYq331VCvFBFYyvfkolF0ca28hUrpMN2OlhaNQdQFB8dJ4CTX8i1U719f1BAOi3mwaTEyVzUu7SbwB4SN+Qrvsj3Ni0xYOhsJfDMfnDzz0BhIo0QKAn623YUQUlfSo4F13dlRLVpRxLioWSeAQfoWdLhpgw9qqGuSlp6GCQI7E/fjPde2Z9hGWhTsDmfCREBbgbfpyydZTuHRyz7TzFNADrhlCZBnC8+xIM7QFQdFgaAxrl35GEHGwEdSBucMtrfJPnVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzUPQtyLl4sy8azslM9hR6gXOfnwxRIrt/fC4l8qDJU=;
 b=km1VJtp/VlCfBjkPd7XuVBW336dk3cIkWZkA389FBIvK3Fqjh+VVjeS1XYByybGGbRqPgLqkb9Q1H8BJ1XHKthYpVqSta80dqVLHMsxlfRe3kRwmW1bpqbAndMyis3Et7RBO+OMEHiXvZ1a8EVdxqnuHlSpJRbP81hnthGKGupBhU+zl65Hwt3gN2bPh4zrJzkn6649aWC8YKGADuireXjgv35ObTXK2381VYfwSVZbxWtPxHFqxr/WCavE7p2WINNEUGr8QlSkRAnjCYhCqI18NQTbJjAqn3F77T6jY2LlsZaXvTjgfuSJ6fSvmyiTd25fkD4xL2UMAJRxorp5MCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzUPQtyLl4sy8azslM9hR6gXOfnwxRIrt/fC4l8qDJU=;
 b=oyDWb6zDcFzP6FUI00jMmXUhZT1XfshXIz9I5fW6H2OEvd9/K/TMvGuOrX+2bqTRI9yGLtjkDwsijpGi4oybXRNTjI6nEbVbSeJlAWSA3yiTZLmrMVPzZUrNPT2tiaKOO4C+0P+Ce3YkIDox+SFA4lfYAehu7PAI9WPl3/iGXrAOUNOjbjJUNHPms54smWjwRrVOnQm2iWp2dhU+w+FEYB8mBuZ+wjbSayXS9z0gj1EiIEssDi6Sx3TRsQOsUH0iZ7Trp/I2JcKSr9sij9lp8Sa+idtc0vPhJ5FT4YEWQ4Uqjoa3KwZyXeLn4h/tRQ1w+q4UoPL+sKqMVcUEmO0Zzw==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7404.eurprd04.prod.outlook.com (2603:10a6:102:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 06:22:16 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 06:22:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Sean Anderson <sanderson@brivo.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, "u-boot@lists.u-boot-project.org"
	<u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, "u-boot-amlogic@groups.io"
	<u-boot-amlogic@groups.io>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: meson: Parse devicetree properties
Thread-Topic: [PATCH v2] mmc: meson: Parse devicetree properties
Thread-Index: AQHdM8wGN7aA9jvVAE+gGOkQ/Cle+rav3qzQ
Date: Wed, 26 Aug 2026 06:22:16 +0000
Message-ID: 
 <MRWPR04MB12330C27FDBD33609FBE9E53188AE2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260824132518.522252-1-sanderson@brivo.com>
In-Reply-To: <20260824132518.522252-1-sanderson@brivo.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-26T06:21:30.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|PR3PR04MB7404:EE_
x-ms-office365-filtering-correlation-id: 27a1710e-a329-4cd0-e6ef-08df033a5ffa
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|56012099006|10067099003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: 
 bivFfk6q6B8gvBrZcoFNBHdTjZqTE2C1o69b+MZaZphVvFS+f8DVyieK+lcp9VjdupR5OoS0DnMjMEHjIZRaLyQRYc54IvGQHQK65TgUlHJbWzlVfXgjZvqtEWhgWLHScIJGzc23rmhrcTDR6hdA8/dSZPtbcSLr7k+Kvx+rWt76xmtS6NCwwyCHXpV5Q93C8/qvrZWUtSRmrT1/WkCjJnNfC68aGAjo2EPqiafp75eYxQAs52l7NdQqwDQHT21bO9fnYaFvdw/RTW7+R6V4AtEuvzXHtz6xJqm/R7aJuuYytp7iu0FuBINDu34TV0T907ndC7jp42sHKOQRiPK8B8iAWxY1HbCBU5Eg9CB5JYNmkwi9SA3TGk/mMVewoo56VObtgBmBIKgCavKN4+05xYDJat8CdemFo7OCyi+C+wp+Ii9fwOwjl0D3grWxfzH8jHwwcmzQo0Kd3uqzjuwuFUFPxc4y7qN2hRkH8P+swKZM6u33a23DJ9ZrswSM3GDS1zQrNj/7uRCJQElUW3TAbVXNcASaI48xGSZ/9KiO5Uipg9s8rvjAAdLIP0d6COcgghjMS72tKs392mphWmq2FvAzkdCkfnywXEjQSOlxOaKDM1jdpOo5155tYZn2k39VIekeNgjxztPVj3av6SN0olC7yB/9NcK5k+rw6UyNjtdvVdlw3ZWBMEsAh+hlIkWgoDm0+y5VBc8BeVyr4JAwOnyYaX0AU5nEbvaS4kWBIM8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?glWOP4hWNXlLRLo5qeRZhioQyU5JYocPO7YraCQcS9APbc0ZIgtrvvo+bfe0?=
 =?us-ascii?Q?fnVWLoliY0KeYDBOgYm1Du+y1/sM0yFMu4xehyUSe3N02MUGuiHePtPMPK+O?=
 =?us-ascii?Q?6D3DEJSfSp1EuYSOAa8KETRWVktxCDukVxD90uy5FoKdvwv8tSBPAk4qMQOf?=
 =?us-ascii?Q?l1fEwoYnpCjUU2DNqY6TWk/42MsPRMR5UW9YpOjnSUBo7rTjFBcrUAAF/Zdn?=
 =?us-ascii?Q?oRyMrwF5/sL3R7JGphvz6DP35jcUqjfVV20ypkOo9EjcLcUqrKxEIMwcv4ub?=
 =?us-ascii?Q?wtlenbF8EVkaKtsyXruA2071uXe79VFY5t+tfB1BCBwFK6hJUeuRGQy0cCLc?=
 =?us-ascii?Q?wUC7f90Xnpel2917bQHoQvZtxBl//l6RucQmzxmkYBB/axFCT4OKIRWKMEpv?=
 =?us-ascii?Q?H6BE40pNZiMLw3fl/qFi0LaDNGKj1Ct6VLrMcgnghzf1hCqCjBYYJvjLtxWo?=
 =?us-ascii?Q?LU7lp+tzeFxkjE/WGucrmaYMaJu6lfaV7HepY/0bbVV4WEcB2BJXg0QQTVnZ?=
 =?us-ascii?Q?EVU3uX4hQ6Z14fnlDYXNECAs80NCzzYeEG0fPpVMpHvCORul2lNEZW8OmrDN?=
 =?us-ascii?Q?oGyl6E6wMI/GW3+4uu8IiUBJG3tXhFVLj4O5F46Znvj6VCPCZHC+2oReb+Cc?=
 =?us-ascii?Q?YdnP9b4X7ILldR1wLpRa+lvM8Na/9DtMXrEz6D/WMjzdwzchBA/1LFtvbGgY?=
 =?us-ascii?Q?t0O2BaT0i5UXzW5qk8mUd5uPNvciNENbNIJSFnWsWN0nVDhe+OagBXKcGeJH?=
 =?us-ascii?Q?miovfdKUMBv6WbqwlzXkZs1gcy3mJdk5cXazQd447CB4zfZhJ+pJXfFktovO?=
 =?us-ascii?Q?yxHmxs6pDStPSC2ulyfMbTdCfYUlAvL5XhWFSJA+J2mnYot9QVb/5Ow9oalA?=
 =?us-ascii?Q?EaC98S+SA7Q5Cl5uLHWq8dfbxomIrjC9xzeqtS4cuJEHqdxMbu12SYkg7Wm1?=
 =?us-ascii?Q?i0WzSkQ9ahu2l1J1Fy6Tn1qBHrl+16Znn6G0gK4MJZhyi6gM6bofnYty90Ei?=
 =?us-ascii?Q?J9mGBJQamhU6gBnyiFZnAt49n+G6SeGnj06Xu+mhHxsNFC2LKULbuyBq7nOh?=
 =?us-ascii?Q?gXFAgej81Ne5j+PD8wPmCXMEaU7cshKLagWH6s62EKFBQrN1x3mmn/tXft1D?=
 =?us-ascii?Q?N+yn/RGV35t59A0YVov9AVHP+HHPg0SF+pt4Fs74gAkiHzYZ3MbgnVVf3X+X?=
 =?us-ascii?Q?KZN2jPWLOpLHhRLolXSkfGcDTiCxq/35uZ9gM1CXuK66PvyWFgeLBkrKgUzQ?=
 =?us-ascii?Q?CbmpyaGM3E12llrLFp99R5R2S5zvM3mMjM1LMLNwSSK+HyxqF1Zd+fLerVgZ?=
 =?us-ascii?Q?6SfxVGRT9SEG6vxHjWb8a3dWD4GwVKjXLnZz5VhNlYICZvoRlNGoZVFfvB18?=
 =?us-ascii?Q?R1HY5pyVEp/bOey5KvKXqM2XBoP05cIDbV8wejq1XSh3gPYLBhRTCUrrb0gb?=
 =?us-ascii?Q?liQ8VAUfSV5ZRolvC474W9cEq8ksGvFGa8LT1CEuQSAm2okBxjXra9YK4jdO?=
 =?us-ascii?Q?5KITqZ5kh75aKtaN1Zj+zMyf0zPkIg4aaLEHJX3D7RWqhtQridxomLIWS0Lf?=
 =?us-ascii?Q?RPvqM7Qj8QtRvtfeNwZsX5ah56DSq3JO1MFnMUnz53MFwF1W8Bgm5T36R+xw?=
 =?us-ascii?Q?DBDb1tApESS9Ns5+F3OMQf1MDmgx3Auo7NNrVFshXHSoMu9zTXSFjRbWCq7t?=
 =?us-ascii?Q?Fzt1rvGDY7FlukljuPzdPeaoGgKm1zdMC55fY0Brx28QVuGA?=
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a1710e-a329-4cd0-e6ef-08df033a5ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 06:22:16.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUc9wWbT6dQmrfUDb0f3FbPhj6v9rAzhrm0jadqysruzf/bhxm1F/iOSwJPi+WlN8qkvubWNJBGysBZMtb5pCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7404
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 13:42:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3063

> Subject: [PATCH v2] mmc: meson: Parse devicetree properties
>
> Parse devicetree properties so things like max-frequency are respected.
>
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

NXP Confidential

