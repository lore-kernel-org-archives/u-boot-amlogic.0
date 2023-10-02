Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.87631.1696265953291300345
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Oct 2023 09:59:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8CB64100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696265950;
	bh=A0DfJv78BZAlR6ZTJr8rUFQ8KTu5C2NvgdRnuUn79fo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kZ2/iKjDo9bUU3o23dvAvb6Lpcv1CAw5dkihoNNBvkt+VW0pNsyurF/5GUD8ZEebK
	 5EOys2ivnfCl15KjkIsqOPmoz+qeUYHtLsFjulAIuwrkjt85pgiwdfNWnUin2Z8p3Z
	 Os4z8r8RpO6GaCFZSpM3tZfkT+jN63NDhBUh1TgmqSnFJve6dEuEJiBNorEXXBoFpY
	 4CQ3mmlFGBfWfrBSaOQqE9nuusC2iyoMoHTVfisc3+1egMJww0TtT7EAE6SVx2KFYf
	 F7Kz0y2v+kAQQ4AVu8JlJY8FmvPbMYaXlT/ec0IsDP4CDEX6o9v0ZaDMB+arwYKNcd
	 cTvT03oOAnlXw==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 7/8] dwc3: add support for Amlogic A1 family
Date: Mon, 2 Oct 2023 19:58:51 +0300
Message-ID: <20231002165857.19512-8-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-1-avromanov@salutedevices.com>
References: <20231002165857.19512-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Now the driver supports also A1 phy layer.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 73 ++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-mes=
on-g12a.c
index 90418ddc1d..550e6682a2 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -28,6 +28,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
+#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
=20
 /* USB2 Ports Control Registers */
=20
@@ -102,10 +103,22 @@ enum {
 	PHY_COUNT,
 };
=20
-static const char *phy_names[PHY_COUNT] =3D {
+static const char *const dwc3_meson_g12a_phy_names[] =3D {
 	"usb2-phy0", "usb2-phy1", "usb3-phy0",
 };
=20
+static const char *const dwc3_meson_a1_phy_names[] =3D {
+	"usb2-phy0", "usb2-phy1"
+};
+
+struct dwc3_meson_g12a;
+
+struct dwc3_meson_g12a_drvdata {
+	const char *const *phy_names;
+	unsigned int phy_cnt;
+	int (*clk_init)(struct dwc3_meson_g12a *priv);
+};
+
 struct dwc3_meson_g12a {
 	struct udevice		*dev;
 	struct regmap           *regmap;
@@ -119,6 +132,7 @@ struct dwc3_meson_g12a {
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	struct udevice		*vbus_supply;
 #endif
+	struct dwc3_meson_g12a_drvdata *drvdata;
 };
=20
 #define U2P_REG_SIZE						0x20
@@ -293,10 +307,11 @@ int dwc3_meson_g12a_force_mode(struct udevice *dev, e=
num usb_dr_mode mode)
=20
 static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
 {
+	struct dwc3_meson_g12a_drvdata *data =3D priv->drvdata;
 	int i, ret;
=20
-	for (i =3D 0 ; i < PHY_COUNT ; ++i) {
-		ret =3D generic_phy_get_by_name(priv->dev, phy_names[i],
+	for (i =3D 0 ; i < data->phy_cnt; ++i) {
+		ret =3D generic_phy_get_by_name(priv->dev, data->phy_names[i],
 					      &priv->phys[i]);
 		if (ret =3D=3D -ENOENT || ret =3D=3D -ENODATA)
 			continue;
@@ -354,18 +369,36 @@ static int dwc3_meson_g12a_clk_init(struct dwc3_meson=
_g12a *priv)
 	return 0;
 }
=20
+static int dwc3_meson_a1_clk_init(struct dwc3_meson_g12a *priv)
+{
+	int ret;
+
+	ret =3D clk_get_by_name(priv->dev, "usb_bus", &priv->clk);
+	if (ret)
+		return ret;
+
+	ret =3D clk_enable(&priv->clk);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int dwc3_meson_g12a_probe(struct udevice *dev)
 {
 	struct dwc3_meson_g12a *priv =3D dev_get_plat(dev);
+	struct dwc3_meson_g12a_drvdata *data =3D
+		(struct dwc3_meson_g12a_drvdata *)dev_get_driver_data(dev);
 	int ret, i;
=20
+	priv->drvdata =3D data;
 	priv->dev =3D dev;
=20
 	ret =3D regmap_init_mem(dev_ofnode(dev), &priv->regmap);
 	if (ret)
 		return ret;
=20
-	ret =3D dwc3_meson_g12a_clk_init(priv);
+	ret =3D data->clk_init(priv);
 	if (ret)
 		return ret;
=20
@@ -398,7 +431,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 	if (ret)
 		return ret;
=20
-	for (i =3D 0 ; i < PHY_COUNT ; ++i) {
+	for (i =3D 0 ; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
=20
@@ -407,7 +440,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 			goto err_phy_init;
 	}
=20
-	for (i =3D 0; i < PHY_COUNT; ++i) {
+	for (i =3D 0; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
=20
@@ -419,7 +452,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 	return 0;
=20
 err_phy_init:
-	for (i =3D 0 ; i < PHY_COUNT ; ++i) {
+	for (i =3D 0 ; i < data->phy_cnt ; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
=20
@@ -432,20 +465,21 @@ err_phy_init:
 static int dwc3_meson_g12a_remove(struct udevice *dev)
 {
 	struct dwc3_meson_g12a *priv =3D dev_get_plat(dev);
+	struct dwc3_meson_g12a_drvdata *data =3D priv->drvdata;
 	int i;
=20
 	reset_release_all(&priv->reset, 1);
=20
 	clk_release_all(&priv->clk, 1);
=20
-	for (i =3D 0; i < PHY_COUNT; ++i) {
+	for (i =3D 0; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
=20
 		 generic_phy_power_off(&priv->phys[i]);
 	}
=20
-	for (i =3D 0 ; i < PHY_COUNT ; ++i) {
+	for (i =3D 0 ; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
=20
@@ -455,8 +489,27 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
=20
+static const struct dwc3_meson_g12a_drvdata meson_g12a_drvdata =3D {
+	.phy_names =3D dwc3_meson_g12a_phy_names,
+	.phy_cnt =3D ARRAY_SIZE(dwc3_meson_g12a_phy_names),
+	.clk_init =3D dwc3_meson_g12a_clk_init,
+};
+
+static const struct dwc3_meson_g12a_drvdata meson_a1_drvdata =3D {
+	.phy_names =3D dwc3_meson_a1_phy_names,
+	.phy_cnt =3D ARRAY_SIZE(dwc3_meson_a1_phy_names),
+	.clk_init =3D dwc3_meson_a1_clk_init,
+};
+
 static const struct udevice_id dwc3_meson_g12a_ids[] =3D {
-	{ .compatible =3D "amlogic,meson-g12a-usb-ctrl" },
+	{
+		.compatible =3D "amlogic,meson-g12a-usb-ctrl",
+		.data =3D (ulong)&meson_g12a_drvdata,
+	},
+	{
+		.compatible =3D "amlogic,meson-a1-usb-ctrl",
+		.data =3D (ulong)&meson_a1_drvdata,
+	},
 	{ }
 };
=20
--=20
2.25.1

