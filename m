Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by mx.groups.io with SMTP id smtpd.web10.102661.1680617544984152589
 for <u-boot-amlogic@groups.io>;
 Tue, 04 Apr 2023 07:12:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1680617543;
	bh=9pztbJBIPwsR7FNXQRYbxKHawyXwaTKVtiHfC2bTlS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tlcz47uBFdfIXa86mXPg49BhODz4l51p11y9kkTuNc0m5OqXa0gUs57OMs/FUu31V
	 6c/pQq7nl2kUnCrI15ZNdf0frJivbGzCTh9hfzeU1SCdJ/zCiA3Unhe5dvejGMrOu3
	 zaTnJTDBF6j9bxMPKI6C/CXnu37Q/MeVGB9SBWFw281p9zw9/t+CCH4VBK6Ut6m2e2
	 rSIo+yLbzSGuzVm3XI4ZxAj/tG/74tUCGspGM9KcPEU5NsALrY2IBnlfG+30snZk4E
	 FU8/4lsyxrgkwtue2p0ul7brweXBiBGwX9rzCOBZh75rV2L99NelKBzsXw7ssMx2KD
	 UeZxAgKdxLpoQ==
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v4 5/5] phy: rockchip-inno-usb2: add initial support for rk3588 PHY
Date: Tue,  4 Apr 2023 17:11:55 +0300
Message-Id: <20230404141155.283987-5-eugen.hristev@collabora.com>
In-Reply-To: <20230404141155.283987-1-eugen.hristev@collabora.com>
References: <20230404141155.283987-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, kever.yang@rock-chips.com, neil.armstrong@linaro.org, jagan@edgeble.ai, jonas@kwiboo.se, xdrudis@tinet.cat, anarsoul@gmail.com, Eugen Hristev <eugen.hristev@collabora.com>, Frank Wang <frank.wang@rock-chips.com>
List-ID: <u-boot-amlogic@groups.io>

Add initial support for the rk3588 PHY variant.
The lookup for the host-port reg inside the struct now does a do {} while=
()
instead of a while() {} in order to allow a first check for reg =3D=3D 0.

Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v4:
 - moved all vbus/phy-supply to the core
Changes in v3:
 - add handling of -EBUSY and -EALREADY for regulator return
Changes in v2:
 - add handling of -EACCES
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 60 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/=
rockchip/phy-rockchip-inno-usb2.c
index 55e1dbcfef7e..22e2797eea28 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -201,14 +201,14 @@ static int rockchip_usb2phy_probe(struct udevice *d=
ev)
=20
 	/* find out a proper config which can be matched with dt. */
 	index =3D 0;
-	while (phy_cfgs[index].reg) {
+	do {
 		if (phy_cfgs[index].reg =3D=3D reg) {
 			priv->phy_cfg =3D &phy_cfgs[index];
 			break;
 		}
=20
 		++index;
-	}
+	} while (phy_cfgs[index].reg);
=20
 	if (!priv->phy_cfg) {
 		dev_err(dev, "failed find proper phy-cfg\n");
@@ -348,6 +348,58 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_=
cfgs[] =3D {
 	{ /* sentinel */ }
 };
=20
+static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] =3D {
+	{
+		.reg		=3D 0x0000,
+		.port_cfgs	=3D {
+			[USB2PHY_PORT_OTG] =3D {
+				.phy_sus	=3D { 0x000c, 11, 11, 0, 1 },
+				.ls_det_en	=3D { 0x0080, 0, 0, 0, 1 },
+				.ls_det_st	=3D { 0x0084, 0, 0, 0, 1 },
+				.ls_det_clr	=3D { 0x0088, 0, 0, 0, 1 },
+				.utmi_ls	=3D { 0x00c0, 10, 9, 0, 1 },
+			}
+		},
+	},
+	{
+		.reg		=3D 0x4000,
+		.port_cfgs	=3D {
+			[USB2PHY_PORT_OTG] =3D {
+				.phy_sus	=3D { 0x000c, 11, 11, 0, 0 },
+				.ls_det_en	=3D { 0x0080, 0, 0, 0, 1 },
+				.ls_det_st	=3D { 0x0084, 0, 0, 0, 1 },
+				.ls_det_clr	=3D { 0x0088, 0, 0, 0, 1 },
+				.utmi_ls	=3D { 0x00c0, 10, 9, 0, 1 },
+			}
+		},
+	},
+	{
+		.reg		=3D 0x8000,
+		.port_cfgs	=3D {
+			[USB2PHY_PORT_HOST] =3D {
+				.phy_sus	=3D { 0x0008, 2, 2, 0, 1 },
+				.ls_det_en	=3D { 0x0080, 0, 0, 0, 1 },
+				.ls_det_st	=3D { 0x0084, 0, 0, 0, 1 },
+				.ls_det_clr	=3D { 0x0088, 0, 0, 0, 1 },
+				.utmi_ls	=3D { 0x00c0, 10, 9, 0, 1 },
+			}
+		},
+	},
+	{
+		.reg		=3D 0xc000,
+		.port_cfgs	=3D {
+			[USB2PHY_PORT_HOST] =3D {
+				.phy_sus	=3D { 0x0008, 2, 2, 0, 1 },
+				.ls_det_en	=3D { 0x0080, 0, 0, 0, 1 },
+				.ls_det_st	=3D { 0x0084, 0, 0, 0, 1 },
+				.ls_det_clr	=3D { 0x0088, 0, 0, 0, 1 },
+				.utmi_ls	=3D { 0x00c0, 10, 9, 0, 1 },
+			}
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct udevice_id rockchip_usb2phy_ids[] =3D {
 	{
 		.compatible =3D "rockchip,rk3399-usb2phy",
@@ -357,6 +409,10 @@ static const struct udevice_id rockchip_usb2phy_ids[=
] =3D {
 		.compatible =3D "rockchip,rk3568-usb2phy",
 		.data =3D (ulong)&rk3568_phy_cfgs,
 	},
+	{
+		.compatible =3D "rockchip,rk3588-usb2phy",
+		.data =3D (ulong)&rk3588_phy_cfgs,
+	},
 	{ /* sentinel */ }
 };
=20
--=20
2.34.1

