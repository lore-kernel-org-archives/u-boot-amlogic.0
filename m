Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.44])
 by mx.groups.io with SMTP id smtpd.web10.1859.1578446146119164865
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jan 2020 17:15:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A60fuuiIObThOrAEbgLByuLj04o0tOcWqTsQ8/Pmqr0=;
 b=agKRSYVYcWqGqWrzjJLhxvZKolxOblsxLB8GmZWy9vkkCxRzQNWDG7CaQfHfOQs6cDi0bWFr23d8FphZJ0ykwqmplbrLAxd5en/k75fTOowSfZOi6Flt9Pvn5VW9DwVclz1/QV4+HbWZJb6JBeKb1PILGFViqVY+cVcFtFuFL74=
From: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCHv3 2/3] configs: meson64: enable GIC support for G12A/G12B
Date: Wed, 8 Jan 2020 01:15:44 +0000
Message-ID: 
 <AM0PR04MB4481DA4FD4A33055EFFD7840883E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20191226113353.1757-1-linux.amoon@gmail.com>
 <20191226113353.1757-3-linux.amoon@gmail.com>
 <c76c932d-2927-624e-d67b-7a332b9a439a@baylibre.com>
In-Reply-To: <c76c932d-2927-624e-d67b-7a332b9a439a@baylibre.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Neil Armstrong <narmstrong@baylibre.com>, Anand Moon <linux.amoon@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

PiBTdWJqZWN0OiBSZTogW1BBVENIdjMgMi8zXSBjb25maWdzOiBtZXNvbjY0OiBlbmFibGUgR0lD
IHN1cHBvcnQgZm9yDQo+IEcxMkEvRzEyQg0KPiANCj4gT24gMjYvMTIvMjAxOSAxMjozMywgQW5h
bmQgTW9vbiB3cm90ZToNCj4gPiBFbmFibGUgR0lDIHN1cHBvcnQgZm9yIEcxMkEvRzEyQiBwbGF0
Zm9ybS4NCg0KSnVzdCB3b25kZXIgd2hhdCBpcyBHSUMgc3VwcG9ydCBpbiBVLUJvb3Q/DQoNClRo
YW5rcywNClBlbmcuDQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuYW5kIE1vb24gPGxpbnV4
LmFtb29uQGdtYWlsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTmVpbCBBcm1zdHJvbmcgPG5hcm1z
dHJvbmdAYmF5bGlicmUuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2NvbmZpZ3MvbWVzb242
NC5oIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvbWVzb242NC5oIGIv
aW5jbHVkZS9jb25maWdzL21lc29uNjQuaA0KPiA+IGluZGV4IDczNjA4MTI3N2QuLjUwNzA3YTMx
OTcgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9jb25maWdzL21lc29uNjQuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvY29uZmlncy9tZXNvbjY0LmgNCj4gPiBAQCAtOCw3ICs4LDcgQEANCj4gPiAgI2Rl
ZmluZSBfX01FU09ONjRfQ09ORklHX0gNCj4gPg0KPiA+ICAvKiBHZW5lcmljIEludGVycnVwdCBD
b250cm9sbGVyIERlZmluaXRpb25zICovIC0jaWYNCj4gPiBkZWZpbmVkKENPTkZJR19NRVNPTl9B
WEcpDQo+ID4gKyNpZiAoZGVmaW5lZChDT05GSUdfTUVTT05fQVhHKSB8fCBkZWZpbmVkKENPTkZJ
R19NRVNPTl9HMTJBKSkNCj4gPiAgI2RlZmluZSBHSUNEX0JBU0UJCQkweGZmYzAxMDAwDQo+ID4g
ICNkZWZpbmUgR0lDQ19CQVNFCQkJMHhmZmMwMjAwMA0KPiA+ICAjZWxzZSAvKiBNRVNPTiBHWEwg
YW5kIEdYQkIgKi8NCj4gPg0KPiANCj4gQXBwbGllZCB0aGlzIHBhdGNoIHRvIHUtYm9vdC1hbWxv
Z2ljDQo+IA0KPiBOZWlsDQo=
