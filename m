Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.105636.1696332538515761422
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 04:28:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 02E4C12000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696332537;
	bh=aFsGu+0Y8wTbxw4/QIEFMU/gCctcf9R0zTVJfZ/JNHE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=q7aqN5/nBmVk/CIhKzXOHsJyaF18McL5e2ifa3e6KckQvsvrXiQpIpg8gzaQwSvsl
	 16ho8TTCXazj8eDQ2WUFxHhmH8UvSWJCxquXCbz4uUZR4iT/wh87oWdNkLfyh47Prf
	 W35mEpVASvdYzT66vyDD6rd6Lf30EDqDSO/84A9Dp1KlfOWnjeom2G2qCjQLKVkcj7
	 /eDJZcjFJ4V7UVKUXq4jyymLAokdVWCRTOSDyJSKvBTduP92NWTvx7busfFl1VcS2Z
	 5RFhFickS7Gs+lhxI/Z736ZWrV0HXHCSZfkLFcpKAlXPFLEj5vn6N37JYMhFXDH/qs
	 uRFn+qIr5HdmA==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 7/8] dwc3: add support for Amlogic A1 family
Date: Tue, 3 Oct 2023 14:28:33 +0300
Message-ID: <20231003112838.41503-8-avromanov@salutedevices.com>
In-Reply-To: <20231003112838.41503-1-avromanov@salutedevices.com>
References: <20231003112838.41503-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Now the driver supports also A1 phy layer.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 73 ++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-mes=
on-g12a.c
index 195670e4ca..5433ac0dca 100644
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
@@ -461,11 +495,20 @@ static const struct dwc3_meson_g12a_drvdata meson_g12=
a_drvdata =3D {
 	.clk_init =3D dwc3_meson_g12a_clk_init,
 };
=20
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
@@ -474,11 +517,21 @@ static int dwc3_meson_g12a_child_post_remove(struct u=
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

