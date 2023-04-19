Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by mx.groups.io with SMTP id smtpd.web11.38070.1681911639760151503
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Apr 2023 06:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1681911638;
	bh=yMN6XEqM/zTEsnuN7Vqu7PJOxBCFsyZmpRgLlv9PxOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJCCFZoVR8g9M7F49HWuYqv5c3Xp9RR/cya290jFcBjbbk6D9ZETYS81zKcY7uhsH
	 DjaqHAUQx8eNdZbozfNvcpjasOIKt6MKTZGfg+BQeSSlN4oa/MXWxQry6fZv3dhTL5
	 aRKH9MmRXC63wNuBwV50sqiijii5dzB8JFunDp6uMj13BXwKU4RaFqIehDrH/w+q1n
	 LSsFZ3L7BAefYN01EsPc76F6BHGK5N+bdBOdlBTapskYQhH7JeyATpK10xFx0SXBQ3
	 CE0qmZGWsMVWsd/FPSKgOPVZ+WZ6WtFT/ZO1HPw89S3i8Oo83XPSy9VsHbe9FJ907O
	 q6eTarAWnLQog==
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v5 4/6] phy: remove phy-supply related code
Date: Wed, 19 Apr 2023 16:40:12 +0300
Message-Id: <20230419134014.128461-4-eugen.hristev@collabora.com>
In-Reply-To: <20230419134014.128461-1-eugen.hristev@collabora.com>
References: <20230419134014.128461-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: kever.yang@rock-chips.com, jonas@kwiboo.se, eugen.hristev@collabora.com, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, xdrudis@tinet.cat, jagan@edgeble.ai, neil.armstrong@linaro.org, anarsoul@gmail.com
List-ID: <u-boot-amlogic@groups.io>

phy-supply is now handled at uclass level. Remove it from the drivers tha=
t
implement it at the driver level.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 drivers/phy/meson-g12a-usb2.c | 48 -----------------------------------
 drivers/phy/meson-gxbb-usb2.c | 38 ---------------------------
 drivers/phy/meson-gxl-usb2.c  | 30 ----------------------
 3 files changed, 116 deletions(-)

diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.=
c
index 2fbba7fdae01..650b88bd1803 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -54,50 +54,12 @@
=20
 struct phy_meson_g12a_usb2_priv {
 	struct regmap		*regmap;
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	struct udevice		*phy_supply;
-#endif
 #if CONFIG_IS_ENABLED(CLK)
 	struct clk		clk;
 #endif
 	struct reset_ctl	reset;
 };
=20
-
-static int phy_meson_g12a_usb2_power_on(struct phy *phy)
-{
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	struct udevice *dev =3D phy->dev;
-	struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
-
-	if (priv->phy_supply) {
-		int ret =3D regulator_set_enable(priv->phy_supply, true);
-		if (ret)
-			return ret;
-	}
-#endif
-
-	return 0;
-}
-
-static int phy_meson_g12a_usb2_power_off(struct phy *phy)
-{
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	struct udevice *dev =3D phy->dev;
-	struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
-
-	if (priv->phy_supply) {
-		int ret =3D regulator_set_enable(priv->phy_supply, false);
-		if (ret) {
-			pr_err("Error disabling PHY supply\n");
-			return ret;
-		}
-	}
-#endif
-
-	return 0;
-}
-
 static int phy_meson_g12a_usb2_init(struct phy *phy)
 {
 	struct udevice *dev =3D phy->dev;
@@ -155,8 +117,6 @@ static int phy_meson_g12a_usb2_exit(struct phy *phy)
 struct phy_ops meson_g12a_usb2_phy_ops =3D {
 	.init =3D phy_meson_g12a_usb2_init,
 	.exit =3D phy_meson_g12a_usb2_exit,
-	.power_on =3D phy_meson_g12a_usb2_power_on,
-	.power_off =3D phy_meson_g12a_usb2_power_off,
 };
=20
 int meson_g12a_usb2_phy_probe(struct udevice *dev)
@@ -193,14 +153,6 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 	}
 #endif
=20
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	ret =3D device_get_supply_regulator(dev, "phy-supply", &priv->phy_suppl=
y);
-	if (ret && ret !=3D -ENOENT) {
-		pr_err("Failed to get PHY regulator\n");
-		return ret;
-	}
-#endif
-
 	return 0;
 }
=20
diff --git a/drivers/phy/meson-gxbb-usb2.c b/drivers/phy/meson-gxbb-usb2.=
c
index 7a2e3d2739e8..70a80b863819 100644
--- a/drivers/phy/meson-gxbb-usb2.c
+++ b/drivers/phy/meson-gxbb-usb2.c
@@ -12,7 +12,6 @@
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
-#include <power/regulator.h>
 #include <regmap.h>
 #include <reset.h>
 #include <linux/bitops.h>
@@ -81,9 +80,6 @@
 struct phy_meson_gxbb_usb2_priv {
 	struct regmap *regmap;
 	struct reset_ctl_bulk resets;
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	struct udevice *phy_supply;
-#endif
 };
=20
 static int phy_meson_gxbb_usb2_power_on(struct phy *phy)
@@ -92,15 +88,6 @@ static int phy_meson_gxbb_usb2_power_on(struct phy *ph=
y)
 	struct phy_meson_gxbb_usb2_priv *priv =3D dev_get_priv(dev);
 	uint val;
=20
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	if (priv->phy_supply) {
-		int ret =3D regulator_set_enable(priv->phy_supply, true);
-
-		if (ret)
-			return ret;
-	}
-#endif
-
 	regmap_update_bits(priv->regmap, REG_CONFIG,
 			   REG_CONFIG_CLK_32k_ALTSEL,
 			   REG_CONFIG_CLK_32k_ALTSEL);
@@ -140,26 +127,8 @@ static int phy_meson_gxbb_usb2_power_on(struct phy *=
phy)
 	return 0;
 }
=20
-static int phy_meson_gxbb_usb2_power_off(struct phy *phy)
-{
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	struct udevice *dev =3D phy->dev;
-	struct phy_meson_gxbb_usb2_priv *priv =3D dev_get_priv(dev);
-
-	if (priv->phy_supply) {
-		int ret =3D regulator_set_enable(priv->phy_supply, false);
-
-		if (ret)
-			return ret;
-	}
-#endif
-
-	return 0;
-}
-
 static struct phy_ops meson_gxbb_usb2_phy_ops =3D {
 	.power_on =3D phy_meson_gxbb_usb2_power_on,
-	.power_off =3D phy_meson_gxbb_usb2_power_off,
 };
=20
 static int meson_gxbb_usb2_phy_probe(struct udevice *dev)
@@ -192,13 +161,6 @@ static int meson_gxbb_usb2_phy_probe(struct udevice =
*dev)
 		return ret;
 	}
=20
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	ret =3D device_get_supply_regulator(dev, "phy-supply", &priv->phy_suppl=
y);
-	if (ret && ret !=3D -ENOENT) {
-		pr_err("Failed to get PHY regulator\n");
-		return ret;
-	}
-#endif
 	ret =3D reset_get_bulk(dev, &priv->resets);
 	if (!ret) {
 		ret =3D reset_deassert_bulk(&priv->resets);
diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index 9fb376cec448..4c631310efac 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -16,7 +16,6 @@
 #include <generic-phy.h>
 #include <regmap.h>
 #include <linux/delay.h>
-#include <power/regulator.h>
 #include <clk.h>
 #include <linux/usb/otg.h>
=20
@@ -101,9 +100,6 @@
=20
 struct phy_meson_gxl_usb2_priv {
 	struct regmap		*regmap;
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	struct udevice		*phy_supply;
-#endif
 #if CONFIG_IS_ENABLED(CLK)
 	struct clk		clk;
 #endif
@@ -167,14 +163,6 @@ static int phy_meson_gxl_usb2_power_on(struct phy *p=
hy)
=20
 	phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
=20
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	if (priv->phy_supply) {
-		int ret =3D regulator_set_enable(priv->phy_supply, true);
-		if (ret)
-			return ret;
-	}
-#endif
-
 	return 0;
 }
=20
@@ -189,16 +177,6 @@ static int phy_meson_gxl_usb2_power_off(struct phy *=
phy)
 	val |=3D U2P_R0_POWER_ON_RESET;
 	regmap_write(priv->regmap, U2P_R0, val);
=20
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	if (priv->phy_supply) {
-		int ret =3D regulator_set_enable(priv->phy_supply, false);
-		if (ret) {
-			pr_err("Error disabling PHY supply\n");
-			return ret;
-		}
-	}
-#endif
-
 	return 0;
 }
=20
@@ -229,14 +207,6 @@ int meson_gxl_usb2_phy_probe(struct udevice *dev)
 	}
 #endif
=20
-#if CONFIG_IS_ENABLED(DM_REGULATOR)
-	ret =3D device_get_supply_regulator(dev, "phy-supply", &priv->phy_suppl=
y);
-	if (ret && ret !=3D -ENOENT) {
-		pr_err("Failed to get PHY regulator\n");
-		return ret;
-	}
-#endif
-
 	return 0;
 }
=20
--=20
2.34.1

