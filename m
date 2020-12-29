Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web08.12084.1609250352748520117
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Dec 2020 05:59:13 -0800
Received: by mail-wr1-f47.google.com with SMTP id r7so14726956wrc.5
        for <u-boot-amlogic@groups.io>; Tue, 29 Dec 2020 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBWh7OY3b66Tlf7qAD5uTFXQ3f7A+qC63D1MRfLh/B4=;
        b=t6NBDXxLIYVNl+jlo/r1tl+yVNiW2caCk9KA7eiuzTqZVgmNoljPi/9TybXsjuLQrv
         W5OHRy2CZsKmOxKZfJaycdbzrf/ViguIpGFa9rmYL7B9KAHKV3u48Hvn162pWqXJj6sO
         ILe+6Qvau2t4HB34v9GSQiFlq9FG3wQAOQ6wrV2TrKyuNLK7Ge6CA3LlvxAJTKhaRTg3
         OCClP4UGB7nqkg08IlE+ohhaN8VmgYO5eeuNKkaTVkJUIzYGU1OGwrT0ZyBS+fE2f1rD
         6w0lEWxX7ahmPi8FwN/+J3DkO/DxO2WjaSE2t9+yUnwh7u75HYBWY97LI0J1VsEbzo5+
         SeBw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/4] phy: Add Amlogic AXG MIPI PCIe Analog PHY driver
Date: Tue, 29 Dec 2020 14:59:01 +0100
Message-Id: <20201229135901.30090-5-narmstrong@baylibre.com>
In-Reply-To: <20201229135901.30090-1-narmstrong@baylibre.com>
References: <20201229135901.30090-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, sjg@chromium.org
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Amlogic AXG MIPI + PCIe Analog PHY provides function for both PCIe and
MIPI DSI at the same time, and provides the Analog part of MIPI DSI transmission
and Analog part of the PCIe lines.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/Kconfig                      |   9 +
 drivers/phy/Makefile                     |   1 +
 drivers/phy/meson-axg-mipi-pcie-analog.c | 233 +++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/phy/meson-axg-mipi-pcie-analog.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 00d77eef08..e64802e8f3 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -205,6 +205,15 @@ config MESON_AXG_MIPI_DPHY
 	  This is the generic phy driver for the Amlogic Meson AXG
 	  MIPI D-PHY.
 
+config MESON_AXG_MIPI_PCIE_ANALOG_PHY
+	bool "Amlogic Meson AXG MIPI PCIe Analog PHY"
+	depends on PHY && ARCH_MESON && MESON_AXG
+	select MIPI_DPHY_HELPERS
+	imply REGMAP
+	help
+	  This is the generic phy driver for the Amlogic Meson AXG
+	  MIPI PCIe Analog PHY.
+
 config MSM8916_USB_PHY
 	bool "Qualcomm MSM8916 USB PHY support"
 	depends on PHY
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index b2fd2d06f6..8daf9f6089 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_MESON_GXBB_USB_PHY) += meson-gxbb-usb2.o
 obj-$(CONFIG_MESON_GXL_USB_PHY) += meson-gxl-usb2.o
 obj-$(CONFIG_MESON_G12A_USB_PHY) += meson-g12a-usb2.o meson-g12a-usb3-pcie.o
 obj-$(CONFIG_MESON_AXG_MIPI_DPHY) += meson-axg-mipi-dphy.o
+obj-$(CONFIG_MESON_AXG_MIPI_PCIE_ANALOG_PHY) += meson-axg-mipi-pcie-analog.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_OMAP_USB2_PHY) += omap-usb2-phy.o
 obj-$(CONFIG_KEYSTONE_USB_PHY) += keystone-usb-phy.o
diff --git a/drivers/phy/meson-axg-mipi-pcie-analog.c b/drivers/phy/meson-axg-mipi-pcie-analog.c
new file mode 100644
index 0000000000..276e6004e5
--- /dev/null
+++ b/drivers/phy/meson-axg-mipi-pcie-analog.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic AXG MIPI + PCIE analog PHY driver
+ *
+ * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <common.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/io.h>
+#include <bitfield.h>
+#include <dm.h>
+#include <errno.h>
+#include <generic-phy.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+#include <reset.h>
+#include <clk.h>
+#include <phy-mipi-dphy.h>
+
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <linux/bitfield.h>
+
+#define HHI_MIPI_CNTL0 0x00
+#define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
+#define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
+#define		HHI_MIPI_CNTL0_BANDGAP		BIT(26)
+#define		HHI_MIPI_CNTL0_DIF_REF_CTL1	GENMASK(25, 16)
+#define		HHI_MIPI_CNTL0_DIF_REF_CTL0	GENMASK(15, 0)
+
+#define HHI_MIPI_CNTL1 0x04
+#define		HHI_MIPI_CNTL1_CH0_CML_PDR_EN	BIT(12)
+#define		HHI_MIPI_CNTL1_LP_ABILITY	GENMASK(5, 4)
+#define		HHI_MIPI_CNTL1_LP_RESISTER	BIT(3)
+#define		HHI_MIPI_CNTL1_INPUT_SETTING	BIT(2)
+#define		HHI_MIPI_CNTL1_INPUT_SEL	BIT(1)
+#define		HHI_MIPI_CNTL1_PRBS7_EN		BIT(0)
+
+#define HHI_MIPI_CNTL2 0x08
+#define		HHI_MIPI_CNTL2_CH_PU		GENMASK(31, 25)
+#define		HHI_MIPI_CNTL2_CH_CTL		GENMASK(24, 19)
+#define		HHI_MIPI_CNTL2_CH0_DIGDR_EN	BIT(18)
+#define		HHI_MIPI_CNTL2_CH_DIGDR_EN	BIT(17)
+#define		HHI_MIPI_CNTL2_LPULPS_EN	BIT(16)
+#define		HHI_MIPI_CNTL2_CH_EN		GENMASK(15, 11)
+#define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
+
+#define DSI_LANE_0              (1 << 4)
+#define DSI_LANE_1              (1 << 3)
+#define DSI_LANE_CLK            (1 << 2)
+#define DSI_LANE_2              (1 << 1)
+#define DSI_LANE_3              (1 << 0)
+#define DSI_LANE_MASK		(0x1F)
+
+struct phy_meson_axg_mipi_pcie_analog_priv {
+	struct regmap *regmap;
+	struct phy_configure_opts_mipi_dphy config;
+	bool dsi_configured;
+	bool dsi_enabled;
+	bool powered;
+};
+
+static void phy_bandgap_enable(struct phy_meson_axg_mipi_pcie_analog_priv *priv)
+{
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
+
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
+}
+
+static void phy_bandgap_disable(struct phy_meson_axg_mipi_pcie_analog_priv *priv)
+{
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			HHI_MIPI_CNTL0_BANDGAP, 0);
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			HHI_MIPI_CNTL0_ENABLE, 0);
+}
+
+static void phy_dsi_analog_enable(struct phy_meson_axg_mipi_pcie_analog_priv *priv)
+{
+	u32 reg;
+
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			   HHI_MIPI_CNTL0_DIF_REF_CTL1,
+			   FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0x1b8));
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			   BIT(31), BIT(31));
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			   HHI_MIPI_CNTL0_DIF_REF_CTL0,
+			   FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL0, 0x8));
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0x001e);
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL2,
+		     (0x26e0 << 16) | (0x459 << 0));
+
+	reg = DSI_LANE_CLK;
+	switch (priv->config.lanes) {
+	case 4:
+		reg |= DSI_LANE_3;
+		fallthrough;
+	case 3:
+		reg |= DSI_LANE_2;
+		fallthrough;
+	case 2:
+		reg |= DSI_LANE_1;
+		fallthrough;
+	case 1:
+		reg |= DSI_LANE_0;
+		break;
+	default:
+		reg = 0;
+	}
+
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL2,
+			   HHI_MIPI_CNTL2_CH_EN,
+			   FIELD_PREP(HHI_MIPI_CNTL2_CH_EN, reg));
+
+	priv->dsi_enabled = true;
+}
+
+static void phy_dsi_analog_disable(struct phy_meson_axg_mipi_pcie_analog_priv *priv)
+{
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			HHI_MIPI_CNTL0_DIF_REF_CTL1,
+			FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0));
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0, BIT(31), 0);
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
+			HHI_MIPI_CNTL0_DIF_REF_CTL1, 0);
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0x6);
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL2, 0x00200000);
+
+	priv->dsi_enabled = false;
+}
+
+static int phy_meson_axg_mipi_pcie_analog_configure(struct phy *phy, void *params)
+{
+	struct udevice *dev = phy->dev;
+	struct phy_meson_axg_mipi_pcie_analog_priv *priv = dev_get_priv(dev);
+	struct phy_configure_opts_mipi_dphy *config = params;
+	int ret;
+
+	ret = phy_mipi_dphy_config_validate(config);
+	if (ret)
+		return ret;
+
+	memcpy(&priv->config, config, sizeof(priv->config));
+
+	priv->dsi_configured = true;
+
+	/* If PHY was already powered on, setup the DSI analog part */
+	if (priv->powered) {
+		/* If reconfiguring, disable & reconfigure */
+		if (priv->dsi_enabled)
+			phy_dsi_analog_disable(priv);
+
+		udelay(100);
+
+		phy_dsi_analog_enable(priv);
+	}
+
+	return 0;
+}
+
+static int phy_meson_axg_mipi_pcie_analog_power_on(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct phy_meson_axg_mipi_pcie_analog_priv *priv = dev_get_priv(dev);
+
+	phy_bandgap_enable(priv);
+
+	if (priv->dsi_configured)
+		phy_dsi_analog_enable(priv);
+
+	priv->powered = true;
+
+	return 0;
+}
+
+static int phy_meson_axg_mipi_pcie_analog_power_off(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct phy_meson_axg_mipi_pcie_analog_priv *priv = dev_get_priv(dev);
+
+	phy_bandgap_disable(priv);
+
+	if (priv->dsi_enabled)
+		phy_dsi_analog_disable(priv);
+
+	priv->powered = false;
+
+	return 0;
+}
+
+struct phy_ops meson_axg_mipi_pcie_analog_ops = {
+	.power_on = phy_meson_axg_mipi_pcie_analog_power_on,
+	.power_off = phy_meson_axg_mipi_pcie_analog_power_off,
+	.configure = phy_meson_axg_mipi_pcie_analog_configure,
+};
+
+int meson_axg_mipi_pcie_analog_probe(struct udevice *dev)
+{
+	struct phy_meson_axg_mipi_pcie_analog_priv *priv = dev_get_priv(dev);
+
+	priv->regmap = syscon_node_to_regmap(dev_get_parent(dev)->node);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	return 0;
+}
+
+static const struct udevice_id meson_axg_mipi_pcie_analog_ids[] = {
+	{ .compatible = "amlogic,axg-mipi-pcie-analog-phy" },
+	{ }
+};
+
+U_BOOT_DRIVER(meson_axg_mipi_pcie_analog) = {
+	.name = "meson_axg_mipi_pcie_analog",
+	.id = UCLASS_PHY,
+	.of_match = meson_axg_mipi_pcie_analog_ids,
+	.probe = meson_axg_mipi_pcie_analog_probe,
+	.ops = &meson_axg_mipi_pcie_analog_ops,
+	.priv_auto_alloc_size = sizeof(struct phy_meson_axg_mipi_pcie_analog_priv),
+};
-- 
2.25.1

