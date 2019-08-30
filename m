Received: by mail-wm1-f68.google.com with SMTP id v15so7076770wml.0
        for <u-boot-amlogic@groups.io>; Fri, 30 Aug 2019 05:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKq730oGl/GyNVd+fmatS6/bxidLjiiGNPrZEiENnwo=;
        b=B/Cmj3kyDbMF6z258r6rE5JXgqRYZMtJVyPJoAOHOOCrIdcAlodxPWC4Oq0Ylashxr
         XPt8JnHA+B+82ut6P5wU7ygxLUpwbeH05EY4V4Ir+vrkCMzR9MnmCvaL1FIW4YWCQut+
         QBBipNLGl50eN/DLq9n/nS/7WUIHHi3v/Z4IHh8k9r8RYXCpUyPn3NJCItdQzVNsTj3J
         FZD8m8MzpcgthypxmurClLZPdsSKGuCAw/I5eFfxjwGljvHzVwMVZwnNys1yVodYX1uN
         dDVoqy8nZ8czMoi2/c9abzouL9q7eNFtEKjMiTNKAXSrxPKyH6tj4Ccel1Jwx57/52c1
         0I2A==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/8] power: domain: meson-gx-pwrc: add G12A support
Date: Fri, 30 Aug 2019 14:09:21 +0200
Message-Id: <20190830120928.23890-2-narmstrong@baylibre.com>
In-Reply-To: <20190830120928.23890-1-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, jh80.chung@samsung.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add Amlogic G12A support for the gx-pwrc driver, aligned on the
Linux v5.2 driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/power/domain/meson-gx-pwrc-vpu.c | 155 +++++++++++++++++++++--
 1 file changed, 145 insertions(+), 10 deletions(-)

diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
index d631d3e6ff..f44e33bacb 100644
--- a/drivers/power/domain/meson-gx-pwrc-vpu.c
+++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
@@ -14,6 +14,11 @@
 #include <reset.h>
 #include <clk.h>
 
+enum {
+	VPU_PWRC_COMPATIBLE_GX		= 0,
+	VPU_PWRC_COMPATIBLE_G12A	= 1,
+};
+
 /* AO Offsets */
 
 #define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
@@ -26,6 +31,7 @@
 #define HHI_MEM_PD_REG0			(0x40 << 2)
 #define HHI_VPU_MEM_PD_REG0		(0x41 << 2)
 #define HHI_VPU_MEM_PD_REG1		(0x42 << 2)
+#define HHI_VPU_MEM_PD_REG2		(0x4d << 2)
 
 struct meson_gx_pwrc_vpu_priv {
 	struct regmap *regmap_ao;
@@ -34,12 +40,12 @@ struct meson_gx_pwrc_vpu_priv {
 	struct clk_bulk clks;
 };
 
-static int meson_gx_pwrc_vpu_request(struct power_domain *power_domain)
+static int meson_pwrc_vpu_request(struct power_domain *power_domain)
 {
 	return 0;
 }
 
-static int meson_gx_pwrc_vpu_free(struct power_domain *power_domain)
+static int meson_pwrc_vpu_free(struct power_domain *power_domain)
 {
 	return 0;
 }
@@ -91,6 +97,73 @@ static int meson_gx_pwrc_vpu_on(struct power_domain *power_domain)
 	return 0;
 }
 
+static int meson_g12a_pwrc_vpu_on(struct power_domain *power_domain)
+{
+	struct meson_gx_pwrc_vpu_priv *priv = dev_get_priv(power_domain->dev);
+	int i, ret;
+
+	regmap_update_bits(priv->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
+			   GEN_PWR_VPU_HDMI, 0);
+	udelay(20);
+
+	/* Power Up Memories */
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(priv->regmap_hhi, HHI_VPU_MEM_PD_REG0,
+				   0x3 << i, 0);
+		udelay(5);
+	}
+
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(priv->regmap_hhi, HHI_VPU_MEM_PD_REG1,
+				   0x3 << i, 0);
+		udelay(5);
+	}
+
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(priv->regmap_hhi, HHI_VPU_MEM_PD_REG2,
+				   0x3 << i, 0);
+		udelay(5);
+	}
+
+	for (i = 8; i < 16; i++) {
+		regmap_update_bits(priv->regmap_hhi, HHI_MEM_PD_REG0,
+				   BIT(i), 0);
+		udelay(5);
+	}
+	udelay(20);
+
+	ret = reset_assert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(priv->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
+			   GEN_PWR_VPU_HDMI_ISO, 0);
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int meson_pwrc_vpu_on(struct power_domain *power_domain)
+{
+	unsigned int compat = dev_get_driver_data(power_domain->dev);
+
+	switch (compat) {
+	case VPU_PWRC_COMPATIBLE_GX:
+		return meson_gx_pwrc_vpu_on(power_domain);
+	case VPU_PWRC_COMPATIBLE_G12A:
+		return meson_g12a_pwrc_vpu_on(power_domain);
+	}
+
+	return -EINVAL;
+}
+
 static int meson_gx_pwrc_vpu_off(struct power_domain *power_domain)
 {
 	struct meson_gx_pwrc_vpu_priv *priv = dev_get_priv(power_domain->dev);
@@ -127,8 +200,63 @@ static int meson_gx_pwrc_vpu_off(struct power_domain *power_domain)
 	return 0;
 }
 
-static int meson_gx_pwrc_vpu_of_xlate(struct power_domain *power_domain,
-				      struct ofnode_phandle_args *args)
+static int meson_g12a_pwrc_vpu_off(struct power_domain *power_domain)
+{
+	struct meson_gx_pwrc_vpu_priv *priv = dev_get_priv(power_domain->dev);
+	int i;
+
+	regmap_update_bits(priv->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
+			   GEN_PWR_VPU_HDMI_ISO, GEN_PWR_VPU_HDMI_ISO);
+	udelay(20);
+
+	/* Power Down Memories */
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(priv->regmap_hhi, HHI_VPU_MEM_PD_REG0,
+				   0x3 << i, 0x3 << i);
+		udelay(5);
+	}
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(priv->regmap_hhi, HHI_VPU_MEM_PD_REG1,
+				   0x3 << i, 0x3 << i);
+		udelay(5);
+	}
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(priv->regmap_hhi, HHI_VPU_MEM_PD_REG2,
+				   0x3 << i, 0x3 << i);
+		udelay(5);
+	}
+	for (i = 8; i < 16; i++) {
+		regmap_update_bits(priv->regmap_hhi, HHI_MEM_PD_REG0,
+				   BIT(i), BIT(i));
+		udelay(5);
+	}
+	udelay(20);
+
+	regmap_update_bits(priv->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
+			   GEN_PWR_VPU_HDMI, GEN_PWR_VPU_HDMI);
+	mdelay(20);
+
+	clk_disable_bulk(&priv->clks);
+
+	return 0;
+}
+
+static int meson_pwrc_vpu_off(struct power_domain *power_domain)
+{
+	unsigned int compat = dev_get_driver_data(power_domain->dev);
+
+	switch (compat) {
+	case VPU_PWRC_COMPATIBLE_GX:
+		return meson_gx_pwrc_vpu_off(power_domain);
+	case VPU_PWRC_COMPATIBLE_G12A:
+		return meson_g12a_pwrc_vpu_off(power_domain);
+	}
+
+	return -EINVAL;
+}
+
+static int meson_pwrc_vpu_of_xlate(struct power_domain *power_domain,
+				   struct ofnode_phandle_args *args)
 {
 	/* #power-domain-cells is 0 */
 
@@ -141,15 +269,22 @@ static int meson_gx_pwrc_vpu_of_xlate(struct power_domain *power_domain,
 }
 
 struct power_domain_ops meson_gx_pwrc_vpu_ops = {
-	.free = meson_gx_pwrc_vpu_free,
-	.off = meson_gx_pwrc_vpu_off,
-	.on = meson_gx_pwrc_vpu_on,
-	.request = meson_gx_pwrc_vpu_request,
-	.of_xlate = meson_gx_pwrc_vpu_of_xlate,
+	.free = meson_pwrc_vpu_free,
+	.off = meson_pwrc_vpu_off,
+	.on = meson_pwrc_vpu_on,
+	.request = meson_pwrc_vpu_request,
+	.of_xlate = meson_pwrc_vpu_of_xlate,
 };
 
 static const struct udevice_id meson_gx_pwrc_vpu_ids[] = {
-	{ .compatible = "amlogic,meson-gx-pwrc-vpu" },
+	{
+		.compatible = "amlogic,meson-gx-pwrc-vpu",
+		.data = VPU_PWRC_COMPATIBLE_GX,
+	},
+	{
+		.compatible = "amlogic,meson-g12a-pwrc-vpu",
+		.data = VPU_PWRC_COMPATIBLE_G12A,
+	},
 	{ }
 };
 
-- 
2.22.0

