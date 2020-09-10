Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.17393.1599727712580953458
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 01:48:32 -0700
Received: by mail-wr1-f66.google.com with SMTP id t10so5793502wrv.1
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJvcTeEcWwqP0fIqcy4W5CHGUO902g8hC+ytbhws0Ho=;
        b=WZcAoIGNmCiLRqF89MpMBaQvbfiETf8QJ6mp5SXMzqnBCTN2ML52IklxrLmd2TUOFW
         UI20AuJVk90VcEkwKvp6V+5wf8iCZi8P5cbo3mMm9H2PHrdTyvk4h/knMeQ8CI9oR2ML
         JiU56urMbRYEjcmrTzG40w49Xq9nDXKW3SiWePqjnmmYzuHUqvOeWWt+f5BPUugzyv2C
         1b9D3Pndwh+E8fZvBN+brbXcPVdyWx2LFh2xU6trYAEY+md3iaVsYh/GbmjZBbifUEyk
         k7OVepKGTPeAJuX9V5DpvIY20GW3c4Nbkwzn7slr0moOlSCZxkb6rAnZjHILXizReYsp
         nGeQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/8] phy: meson-gxl: remove invalid USB3 PHY driver
Date: Thu, 10 Sep 2020 10:48:15 +0200
Message-Id: <20200910084819.25312-5-narmstrong@baylibre.com>
In-Reply-To: <20200910084819.25312-1-narmstrong@baylibre.com>
References: <20200910084819.25312-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The registers which are managed by the meson-gxl-usb3 PHY driver are
actually "USB control" registers (which are "glue" registers which
manage OTG detection and routing of the OTG capable port between the
DWC2 peripheral-only controller and the DWC3 host-only controller).

Drop the meson-gxl-usb3 PHY driver now that the dwc3-meson-gxl-usb
driver supports the USB control registers on GXL and GXM SoCs (these
were previously managed by the meson-gxl-usb3 PHY driver).

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/usb-gx.h |   1 -
 drivers/phy/Makefile                     |   2 +-
 drivers/phy/meson-gxl-usb3.c             | 219 -----------------------
 3 files changed, 1 insertion(+), 221 deletions(-)
 delete mode 100644 drivers/phy/meson-gxl-usb3.c

diff --git a/arch/arm/include/asm/arch-meson/usb-gx.h b/arch/arm/include/asm/arch-meson/usb-gx.h
index 7200a4c31a..61f1809df9 100644
--- a/arch/arm/include/asm/arch-meson/usb-gx.h
+++ b/arch/arm/include/asm/arch-meson/usb-gx.h
@@ -11,7 +11,6 @@
 
 /* TOFIX add set_mode to struct phy_ops */
 void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode);
-void phy_meson_gxl_usb3_set_mode(struct phy *phy, enum usb_dr_mode mode);
 
 int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode);
 
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 74e8d931d3..c839c250bd 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_PHY_RCAR_GEN2) += phy-rcar-gen2.o
 obj-$(CONFIG_PHY_RCAR_GEN3) += phy-rcar-gen3.o
 obj-$(CONFIG_PHY_STM32_USBPHYC) += phy-stm32-usbphyc.o
 obj-$(CONFIG_MESON_GXBB_USB_PHY) += meson-gxbb-usb2.o
-obj-$(CONFIG_MESON_GXL_USB_PHY) += meson-gxl-usb2.o meson-gxl-usb3.o
+obj-$(CONFIG_MESON_GXL_USB_PHY) += meson-gxl-usb2.o
 obj-$(CONFIG_MESON_G12A_USB_PHY) += meson-g12a-usb2.o meson-g12a-usb3-pcie.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_OMAP_USB2_PHY) += omap-usb2-phy.o
diff --git a/drivers/phy/meson-gxl-usb3.c b/drivers/phy/meson-gxl-usb3.c
deleted file mode 100644
index 9de55bb5df..0000000000
--- a/drivers/phy/meson-gxl-usb3.c
+++ /dev/null
@@ -1,219 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Meson GXL USB3 PHY driver
- *
- * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- * Copyright (C) 2018 BayLibre, SAS
- * Author: Neil Armstrong <narmstron@baylibre.com>
- */
-
-#include <common.h>
-#include <malloc.h>
-#include <asm/io.h>
-#include <bitfield.h>
-#include <dm.h>
-#include <errno.h>
-#include <generic-phy.h>
-#include <regmap.h>
-#include <clk.h>
-#include <linux/usb/otg.h>
-
-#include <asm/arch/usb-gx.h>
-
-#include <linux/bitops.h>
-#include <linux/compat.h>
-#include <linux/bitfield.h>
-
-#define USB_R0							0x00
-	#define USB_R0_P30_FSEL_MASK				GENMASK(5, 0)
-	#define USB_R0_P30_PHY_RESET				BIT(6)
-	#define USB_R0_P30_TEST_POWERDOWN_HSP			BIT(7)
-	#define USB_R0_P30_TEST_POWERDOWN_SSP			BIT(8)
-	#define USB_R0_P30_ACJT_LEVEL_MASK			GENMASK(13, 9)
-	#define USB_R0_P30_TX_BOOST_LEVEL_MASK			GENMASK(16, 14)
-	#define USB_R0_P30_LANE0_TX2RX_LOOPBACK			BIT(17)
-	#define USB_R0_P30_LANE0_EXT_PCLK_REQ			BIT(18)
-	#define USB_R0_P30_PCS_RX_LOS_MASK_VAL_MASK		GENMASK(28, 19)
-	#define USB_R0_U2D_SS_SCALEDOWN_MODE_MASK		GENMASK(30, 29)
-	#define USB_R0_U2D_ACT					BIT(31)
-
-#define USB_R1							0x04
-	#define USB_R1_U3H_BIGENDIAN_GS				BIT(0)
-	#define USB_R1_U3H_PME_ENABLE				BIT(1)
-	#define USB_R1_U3H_HUB_PORT_OVERCURRENT_MASK		GENMASK(6, 2)
-	#define USB_R1_U3H_HUB_PORT_PERM_ATTACH_MASK		GENMASK(11, 7)
-	#define USB_R1_U3H_HOST_U2_PORT_DISABLE_MASK		GENMASK(15, 12)
-	#define USB_R1_U3H_HOST_U3_PORT_DISABLE			BIT(16)
-	#define USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT	BIT(17)
-	#define USB_R1_U3H_HOST_MSI_ENABLE			BIT(18)
-	#define USB_R1_U3H_FLADJ_30MHZ_REG_MASK			GENMASK(24, 19)
-	#define USB_R1_P30_PCS_TX_SWING_FULL_MASK		GENMASK(31, 25)
-
-#define USB_R2							0x08
-	#define USB_R2_P30_CR_DATA_IN_MASK			GENMASK(15, 0)
-	#define USB_R2_P30_CR_READ				BIT(16)
-	#define USB_R2_P30_CR_WRITE				BIT(17)
-	#define USB_R2_P30_CR_CAP_ADDR				BIT(18)
-	#define USB_R2_P30_CR_CAP_DATA				BIT(19)
-	#define USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK		GENMASK(25, 20)
-	#define USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK		GENMASK(31, 26)
-
-#define USB_R3							0x0c
-	#define USB_R3_P30_SSC_ENABLE				BIT(0)
-	#define USB_R3_P30_SSC_RANGE_MASK			GENMASK(3, 1)
-	#define USB_R3_P30_SSC_REF_CLK_SEL_MASK			GENMASK(12, 4)
-	#define USB_R3_P30_REF_SSP_EN				BIT(13)
-	#define USB_R3_P30_LOS_BIAS_MASK			GENMASK(18, 16)
-	#define USB_R3_P30_LOS_LEVEL_MASK			GENMASK(23, 19)
-	#define USB_R3_P30_MPLL_MULTIPLIER_MASK			GENMASK(30, 24)
-
-#define USB_R4							0x10
-	#define USB_R4_P21_PORT_RESET_0				BIT(0)
-	#define USB_R4_P21_SLEEP_M0				BIT(1)
-	#define USB_R4_MEM_PD_MASK				GENMASK(3, 2)
-	#define USB_R4_P21_ONLY					BIT(4)
-
-#define USB_R5							0x14
-	#define USB_R5_ID_DIG_SYNC				BIT(0)
-	#define USB_R5_ID_DIG_REG				BIT(1)
-	#define USB_R5_ID_DIG_CFG_MASK				GENMASK(3, 2)
-	#define USB_R5_ID_DIG_EN_0				BIT(4)
-	#define USB_R5_ID_DIG_EN_1				BIT(5)
-	#define USB_R5_ID_DIG_CURR				BIT(6)
-	#define USB_R5_ID_DIG_IRQ				BIT(7)
-	#define USB_R5_ID_DIG_TH_MASK				GENMASK(15, 8)
-	#define USB_R5_ID_DIG_CNT_MASK				GENMASK(23, 16)
-
-/* read-only register */
-#define USB_R6							0x18
-	#define USB_R6_P30_CR_DATA_OUT_MASK			GENMASK(15, 0)
-	#define USB_R6_P30_CR_ACK				BIT(16)
-
-struct phy_meson_gxl_usb3_priv {
-	struct regmap		*regmap;
-#if CONFIG_IS_ENABLED(CLK)
-	struct clk		clk;
-#endif
-};
-
-void phy_meson_gxl_usb3_set_mode(struct phy *phy, enum usb_dr_mode mode)
-{
-	struct udevice *dev = phy->dev;
-	struct phy_meson_gxl_usb3_priv *priv = dev_get_priv(dev);
-	uint val;
-
-	switch (mode) {
-	case USB_DR_MODE_UNKNOWN:
-	case USB_DR_MODE_HOST:
-	case USB_DR_MODE_OTG:
-		regmap_read(priv->regmap, USB_R0, &val);
-		val &= ~USB_R0_U2D_ACT;
-		regmap_write(priv->regmap, USB_R0, val);
-
-		regmap_read(priv->regmap, USB_R4, &val);
-		val &= ~USB_R4_P21_SLEEP_M0;
-		regmap_write(priv->regmap, USB_R4, val);
-		break;
-
-	case USB_DR_MODE_PERIPHERAL:
-		regmap_read(priv->regmap, USB_R0, &val);
-		val |= USB_R0_U2D_ACT;
-		regmap_write(priv->regmap, USB_R0, val);
-
-		regmap_read(priv->regmap, USB_R4, &val);
-		val |= USB_R4_P21_SLEEP_M0;
-		regmap_write(priv->regmap, USB_R4, val);
-		break;
-	}
-}
-
-static int phy_meson_gxl_usb3_power_on(struct phy *phy)
-{
-	struct udevice *dev = phy->dev;
-	struct phy_meson_gxl_usb3_priv *priv = dev_get_priv(dev);
-	uint val;
-
-	regmap_read(priv->regmap, USB_R5, &val);
-	val |= USB_R5_ID_DIG_EN_0;
-	val |= USB_R5_ID_DIG_EN_1;
-	val &= ~USB_R5_ID_DIG_TH_MASK;
-	val |= FIELD_PREP(USB_R5_ID_DIG_TH_MASK, 0xff);
-	regmap_write(priv->regmap, USB_R5, val);
-
-	phy_meson_gxl_usb3_set_mode(phy, USB_DR_MODE_HOST);
-
-	return 0;
-}
-
-static int phy_meson_gxl_usb3_power_off(struct phy *phy)
-{
-	struct udevice *dev = phy->dev;
-	struct phy_meson_gxl_usb3_priv *priv = dev_get_priv(dev);
-	uint val;
-
-	regmap_read(priv->regmap, USB_R5, &val);
-	val &= ~USB_R5_ID_DIG_EN_0;
-	val &= ~USB_R5_ID_DIG_EN_1;
-	regmap_write(priv->regmap, USB_R5, val);
-
-	return 0;
-}
-
-static int phy_meson_gxl_usb3_init(struct phy *phy)
-{
-	struct udevice *dev = phy->dev;
-	struct phy_meson_gxl_usb3_priv *priv = dev_get_priv(dev);
-	uint val;
-
-	regmap_read(priv->regmap, USB_R1, &val);
-	val &= ~USB_R1_U3H_FLADJ_30MHZ_REG_MASK;
-	val |= FIELD_PREP(USB_R1_U3H_FLADJ_30MHZ_REG_MASK, 0x20);
-	regmap_write(priv->regmap, USB_R1, val);
-
-	return 0;
-}
-
-struct phy_ops meson_gxl_usb3_phy_ops = {
-	.init = phy_meson_gxl_usb3_init,
-	.power_on = phy_meson_gxl_usb3_power_on,
-	.power_off = phy_meson_gxl_usb3_power_off,
-};
-
-int meson_gxl_usb3_phy_probe(struct udevice *dev)
-{
-	struct phy_meson_gxl_usb3_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
-	if (ret)
-		return ret;
-	
-#if CONFIG_IS_ENABLED(CLK)
-	ret = clk_get_by_index(dev, 0, &priv->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = clk_enable(&priv->clk);
-	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
-		pr_err("failed to enable PHY clock\n");
-		clk_free(&priv->clk);
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-
-static const struct udevice_id meson_gxl_usb3_phy_ids[] = {
-	{ .compatible = "amlogic,meson-gxl-usb3-phy" },
-	{ }
-};
-
-U_BOOT_DRIVER(meson_gxl_usb3_phy) = {
-	.name = "meson_gxl_usb3_phy",
-	.id = UCLASS_PHY,
-	.of_match = meson_gxl_usb3_phy_ids,
-	.probe = meson_gxl_usb3_phy_probe,
-	.ops = &meson_gxl_usb3_phy_ops,
-	.priv_auto_alloc_size = sizeof(struct phy_meson_gxl_usb3_priv),
-};
-- 
2.22.0

