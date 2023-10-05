Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.11086.1696496098628812229
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 01:54:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8B15410000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696496096;
	bh=6ag0ha3pE645b3O7w64Wiju/bymnps7ScsPqEjZQpOo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=XxdV6YP4MSmqgx3RybdzizgI7ngUwrgemV+BeEs7XOQ6IgML3aoI0c6vjQYN8eo/X
	 YInrLqQl187juTsCbPlQ+USxUEo3FpjtqnIJO7d/VrHr5oSvja+sWQP6t1oqqfcrel
	 SCa/DHtWgA/18Lu+FM+XRpcxyAvsky+kg77MnIVnCVW6/s0DZsINmBqaO2DDn5CqQI
	 cLR+8zEuBs/rjIlTOJ9ATdIaFgwUw4P8gq57W482Ivc6/hcNAf+NMZ8dN0J+y1UQaj
	 USbFc8Bqmqbz21goLbdCwyHZw81c3PqzhuFkaRj5BbkdNBn+ZSX0FJ2ml/HyAk7RkB
	 4BSYgSirfXJHg==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 7/8] dwc3: add support for Amlogic A1 family
Date: Thu, 5 Oct 2023 11:54:28 +0300
Message-ID: <20231005085434.74755-8-avromanov@salutedevices.com>
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Now the driver supports also A1 phy layer.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 79 ++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-mes=
on-g12a.c
index dc5a976f71..e0356e653f 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -29,6 +29,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
+#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
=20
 /* USB2 Ports Control Registers */
=20
@@ -103,10 +104,22 @@ enum {
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
@@ -120,6 +133,7 @@ struct dwc3_meson_g12a {
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	struct udevice		*vbus_supply;
 #endif
+	struct dwc3_meson_g12a_drvdata *drvdata;
 };
=20
 #define U2P_REG_SIZE						0x20
@@ -294,10 +308,11 @@ int dwc3_meson_g12a_force_mode(struct udevice *dev, e=
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
@@ -355,18 +370,36 @@ static int dwc3_meson_g12a_clk_init(struct dwc3_meson=
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
@@ -399,7 +432,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 	if (ret)
 		return ret;
=20
-	for (i =3D 0 ; i < PHY_COUNT ; ++i) {
+	for (i =3D 0 ; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
=20
@@ -408,7 +441,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 			goto err_phy_init;
 	}
=20
-	for (i =3D 0; i < PHY_COUNT; ++i) {
+	for (i =3D 0; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
=20
@@ -420,7 +453,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 	return 0;
=20
 err_phy_init:
-	for (i =3D 0 ; i < PHY_COUNT ; ++i) {
+	for (i =3D 0 ; i < data->phy_cnt ; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
=20
@@ -433,20 +466,21 @@ err_phy_init:
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
@@ -456,11 +490,26 @@ static int dwc3_meson_g12a_remove(struct udevice *dev=
)
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
 static int dwc3_meson_g12a_child_pre_probe(struct udevice *dev)
 {
 	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-g12a-usb"=
))
 		return dwc3_meson_g12a_force_mode(dev->parent, USB_DR_MODE_PERIPHERAL);
=20
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-a1-usb"))
+		return dwc3_meson_g12a_force_mode(dev->parent, USB_DR_MODE_PERIPHERAL);
+
 	return 0;
 }
=20
@@ -469,11 +518,21 @@ static int dwc3_meson_g12a_child_post_remove(struct u=
device *dev)
 	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-g12a-usb"=
))
 		return dwc3_meson_g12a_force_mode(dev->parent, USB_DR_MODE_HOST);
=20
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-a1-usb"))
+		return dwc3_meson_g12a_force_mode(dev->parent, USB_DR_MODE_HOST);
+
 	return 0;
 }
=20
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

