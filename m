Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mx.groups.io with SMTP id smtpd.web10.8105.1604642256067796130
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Nov 2020 21:57:37 -0800
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201106055732epoutp02fe1ad8e6965dcb0cf0027dc54a76fe42~E1aCIg3Jo0613106131epoutp02z
	for <u-boot-amlogic@groups.io>; Fri,  6 Nov 2020 05:57:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201106055732epoutp02fe1ad8e6965dcb0cf0027dc54a76fe42~E1aCIg3Jo0613106131epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604642252;
	bh=cMkUgccJtC8OCL0G+HGMheDrSrod/wT3PMiEfbzCOqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNXjopjkGzniv1bJyUN+juLF/1i/NvvOf+m4sgjsHYmEuFFYGm2babLlv0XgTDcS1
	 gklvTMdbj9rWfM+wV+KlWzGRoxn2w8rM6npFuw2BqFZViAzREZVetcdD/ATQ6wjmt4
	 7xGd8zYyp11OzDNgdbp/bp9LyeY6s6h8Zu+D+1Ps=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/2] phy: meson-g12a-usb2: fix the potential build warning
Date: Fri,  6 Nov 2020 14:57:47 +0900
Message-Id: <20201106055748.20042-2-jh80.chung@samsung.com>
In-Reply-To: <20201106055748.20042-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <20201106055748.20042-1-jh80.chung@samsung.com>
	<CGME20201106055729epcas1p137fa71d5261735b8a98f56b62a629b72@epcas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: narmstrong@baylibre.com, agust@denx.de, u-boot-amlogic@groups.io, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Fix the potential build warning.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/phy/meson-g12a-usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.=
c
index a1e621975867..447ce7283db2 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -66,10 +66,10 @@ struct phy_meson_g12a_usb2_priv {
=20
 static int phy_meson_g12a_usb2_power_on(struct phy *phy)
 {
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	struct udevice *dev =3D phy->dev;
 	struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
=20
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->phy_supply) {
 		int ret =3D regulator_set_enable(priv->phy_supply, true);
 		if (ret)
@@ -82,10 +82,10 @@ static int phy_meson_g12a_usb2_power_on(struct phy *p=
hy)
=20
 static int phy_meson_g12a_usb2_power_off(struct phy *phy)
 {
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	struct udevice *dev =3D phy->dev;
 	struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
=20
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->phy_supply) {
 		int ret =3D regulator_set_enable(priv->phy_supply, false);
 		if (ret) {
--=20
2.29.0

