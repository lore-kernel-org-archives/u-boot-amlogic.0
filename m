Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.11084.1696496094949004591
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 01:54:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9F83C100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696496092;
	bh=NMu1lIRHNmIhKwnU6DhP2nt4DxHPA3IZ6QekHx/eqL0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=TjBqAYzbTbu+ZRbgLqae7OaQQ6fASsOoCPRgtU2u5KZQ8xql/f5U4rBbN8VlmXL73
	 nBuV35mAGeUAfR9JZL713Kll3a6YDDwQ2qRBkcsnWrcMpalO0K97JaDc+TW4VPZjNd
	 z7sIDlsK8ZZnLBrXJsIRjRG8si1M/rMaRLNjbPy/K0UPzAzm+iv2CCMkmlnGhvprJt
	 NhFhAnGsFgGVn/Zi7Ck5rfM4NTo46doEzicKOJZGhjoubYZavbWXH8dcEA8rpmPo8r
	 IyWZLsnvICptJ9noXgT3SvC4sVPhCq1WYY9FENBw1B89E+2WXX90VFqE+bFlJzUmT+
	 fHm7Q5uEe0yRQ==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 5/8] phy: support Amlogic A1 family
Date: Thu, 5 Oct 2023 11:54:26 +0300
Message-ID: <20231005085434.74755-6-avromanov@salutedevices.com>
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Setting G12A and A1 is similar, so we can use G12A phy
driver with little changes.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/Kconfig           |  2 +-
 drivers/phy/meson-g12a-usb2.c | 79 ++++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 8ac5769ed9..60138beca4 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -200,7 +200,7 @@ config MESON_GXL_USB_PHY
=20
 config MESON_G12A_USB_PHY
 	bool "Amlogic Meson G12A USB PHYs"
-	depends on PHY && ARCH_MESON && MESON_G12A
+	depends on PHY && ARCH_MESON && (MESON_G12A || MESON_A1)
 	imply REGMAP
 	help
 	  This is the generic phy driver for the Amlogic Meson G12A
diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 2ea0498f86..4ba3992bda 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/printk.h>
 #include <power/regulator.h>
+#include <power-domain.h>
 #include <reset.h>
 #include <clk.h>
=20
@@ -147,18 +148,28 @@
 #define RESET_COMPLETE_TIME					1000
 #define PLL_RESET_COMPLETE_TIME					100
=20
+enum meson_soc_id {
+	MESON_SOC_A1,
+	MESON_SOC_G12A,
+};
+
 struct phy_meson_g12a_usb2_priv {
 	struct regmap		*regmap;
 #if CONFIG_IS_ENABLED(CLK)
 	struct clk		clk;
 #endif
 	struct reset_ctl	reset;
+#if CONFIG_IS_ENABLED(POWER_DOMAIN)
+	struct power_domain pwrdm;
+#endif
+	int soc_id;
 };
=20
 static int phy_meson_g12a_usb2_init(struct phy *phy)
 {
 	struct udevice *dev =3D phy->dev;
 	struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
+	u32 value;
 	int ret;
=20
 #if CONFIG_IS_ENABLED(CLK)
@@ -197,8 +208,7 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT2, 2) |
 		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT1, 9));
=20
-	regmap_write(priv->regmap, PHY_CTRL_R18,
-		FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
+	value =3D FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
 		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_W, 9) |
 		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_S, 0x27) |
 		FIELD_PREP(PHY_CTRL_R18_MPLL_PFD_GAIN, 1) |
@@ -210,6 +220,11 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 		FIELD_PREP(PHY_CTRL_R18_MPLL_ADJ_LDO, 1) |
 		PHY_CTRL_R18_MPLL_ACG_RANGE;
=20
+	if (priv->soc_id =3D=3D MESON_SOC_A1)
+		value |=3D PHY_CTRL_R18_MPLL_DCO_CLK_SEL;
+
+	regmap_write(priv->regmap, PHY_CTRL_R18, value);
+
 	udelay(PLL_RESET_COMPLETE_TIME);
=20
 	/* UnReset PLL */
@@ -232,13 +247,19 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_VREF_4_0, 0) |
 		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_DBG_1_0, 0));
=20
-	regmap_write(priv->regmap, PHY_CTRL_R4,
-		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
-		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
-		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
-		PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
-		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
-		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
+	if (priv->soc_id =3D=3D MESON_SOC_G12A)
+		regmap_write(priv->regmap, PHY_CTRL_R4,
+			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
+			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
+			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
+			PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
+			FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
+			FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
+	else if (priv->soc_id =3D=3D MESON_SOC_A1)
+		regmap_write(priv->regmap, PHY_CTRL_R21,
+			PHY_CTRL_R21_USB2_CAL_ACK_EN |
+			PHY_CTRL_R21_USB2_TX_STRG_PD |
+			FIELD_PREP(PHY_CTRL_R21_USB2_OTG_ACA_TRIM_1_0, 2));
=20
 	/* Tuning Disconnect Threshold */
 	regmap_write(priv->regmap, PHY_CTRL_R3,
@@ -247,10 +268,15 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 		FIELD_PREP(PHY_CTRL_R3_DISC_THRESH, 3));
=20
 	/* Analog Settings */
-	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
-	regmap_write(priv->regmap, PHY_CTRL_R13,
-		PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
-		FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
+	if (priv->soc_id =3D=3D MESON_SOC_G12A) {
+		regmap_write(priv->regmap, PHY_CTRL_R14, 0);
+		regmap_write(priv->regmap, PHY_CTRL_R13,
+			PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
+			FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
+	} else if (priv->soc_id =3D=3D MESON_SOC_A1) {
+		regmap_write(priv->regmap, PHY_CTRL_R13,
+			FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
+	}
=20
 	return 0;
 }
@@ -282,6 +308,8 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 	struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
 	int ret;
=20
+	priv->soc_id =3D (enum meson_soc_id)dev_get_driver_data(dev);
+
 	ret =3D regmap_init_mem(dev_ofnode(dev), &priv->regmap);
 	if (ret)
 		return ret;
@@ -298,6 +326,22 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 		return ret;
 	}
=20
+#if CONFIG_IS_ENABLED(POWER_DOMAIN)
+	ret =3D power_domain_get(dev, &priv->pwrdm);
+	if (ret < 0 && ret !=3D -ENODEV) {
+		pr_err("failed to get power domain\n");
+		return ret;
+	}
+
+	if (ret !=3D -ENODEV) {
+		ret =3D power_domain_on(&priv->pwrdm);
+		if (ret < 0) {
+			pr_err("failed to enable power domain\n");
+			return ret;
+		}
+	}
+#endif
+
 #if CONFIG_IS_ENABLED(CLK)
 	ret =3D clk_get_by_index(dev, 0, &priv->clk);
 	if (ret < 0)
@@ -308,7 +352,14 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 }
=20
 static const struct udevice_id meson_g12a_usb2_phy_ids[] =3D {
-	{ .compatible =3D "amlogic,g12a-usb2-phy" },
+	{
+		.compatible =3D "amlogic,g12a-usb2-phy",
+		.data =3D (ulong)MESON_SOC_G12A,
+	},
+	{
+		.compatible =3D "amlogic,a1-usb2-phy",
+		.data =3D (ulong)MESON_SOC_A1,
+	},
 	{ }
 };
=20
--=20
2.25.1

