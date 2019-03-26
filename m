Received: by mail-wm1-f66.google.com with SMTP id o25so13036473wmf.5
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnC/VK/Zx2lQ+isiC/ecCjtERMh0i8GbUUzHI5ySZl0=;
        b=nvVodrKTINwE5v9LkWgzNAyLCcKev8rq4wIqtEKmiqE2tySqC/XHKgRPABNx+pfsxw
         snQ2TZiuZEp9sAVQp0WT5T2HOjj8bcT95RVGFPulfWOMVch5KJz2od6JB+4yKhr+/S+l
         8DrKuAi5k7GZfK/HduOu/1Ss7T8hR+3Jh1ijG9Jywa369zrq/pdgo92TAVBwclUvUoII
         vAADo0b9OP/ZYshJI1v/Ts94FdvuJOzhKFpmGQeAeIs23l9msL5ux5gCu+Irhyll/NUF
         srIBjZNM8xYVojkSeUa2XrAJ/fMvdIGVV14O4cJxNdgpvICpYjcfyC0u9hGcCli0ktPl
         656A==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/3] phy: meson: add Amlogic G12A USB2 and USB3+PCIE PHY drivers
Date: Tue, 26 Mar 2019 16:15:36 +0100
Message-Id: <20190326151537.23118-3-narmstrong@baylibre.com>
In-Reply-To: <20190326151537.23118-1-narmstrong@baylibre.com>
References: <20190326151537.23118-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

This adds support for the USB PHYs found in the Amlogic G12A SoC Family.

The USB2 PHY supports Host and/or Peripheral mode, depending on it's position.
The first PHY is only used as Host, but the second supports Dual modes
defined by the USB Control Glue HW in front of the USB Controllers.

The second driver supports USB3 Host mode or PCIE 2.0 mode, depending on
the layout of the board.
Selection is done by the #phy-cells, making the mode static and exclusive.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/Kconfig                |   8 +
 drivers/phy/Makefile               |   1 +
 drivers/phy/meson-g12a-usb2.c      | 216 ++++++++++++++++++
 drivers/phy/meson-g12a-usb3-pcie.c | 345 +++++++++++++++++++++++++++++
 4 files changed, 570 insertions(+)
 create mode 100644 drivers/phy/meson-g12a-usb2.c
 create mode 100644 drivers/phy/meson-g12a-usb3-pcie.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 825ee7c3be..7d45bc46a5 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -147,6 +147,14 @@ config MESON_GXL_USB_PHY
 	  This is the generic phy driver for the Amlogic Meson GXL
 	  USB2 and USB3 PHYS.
 
+config MESON_G12A_USB_PHY
+	bool "Amlogic Meson G12A USB PHYs"
+	depends on PHY && ARCH_MESON && MESON_G12A
+	imply REGMAP
+	help
+	  This is the generic phy driver for the Amlogic Meson G12A
+	  USB2 and USB3 PHYS.
+
 config MSM8916_USB_PHY
 	bool "Qualcomm MSM8916 USB PHY support"
 	depends on PHY
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 099551d693..12602dbd33 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PHY_RCAR_GEN2) += phy-rcar-gen2.o
 obj-$(CONFIG_PHY_RCAR_GEN3) += phy-rcar-gen3.o
 obj-$(CONFIG_PHY_STM32_USBPHYC) += phy-stm32-usbphyc.o
 obj-$(CONFIG_MESON_GXL_USB_PHY) += meson-gxl-usb2.o meson-gxl-usb3.o
+obj-$(CONFIG_MESON_G12A_USB_PHY) += meson-g12a-usb2.o meson-g12a-usb3-pcie.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_OMAP_USB2_PHY) += omap-usb2-phy.o
 obj-$(CONFIG_KEYSTONE_USB_PHY) += keystone-usb-phy.o
diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
new file mode 100644
index 0000000000..ad1a77fcfc
--- /dev/null
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Meson G12A USB2 PHY driver
+ *
+ * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ * Copyright (C) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstron@baylibre.com>
+ */
+
+#include <common.h>
+#include <asm/io.h>
+#include <bitfield.h>
+#include <dm.h>
+#include <errno.h>
+#include <generic-phy.h>
+#include <regmap.h>
+#include <power/regulator.h>
+#include <reset.h>
+#include <clk.h>
+
+#include <linux/bitops.h>
+#include <linux/compat.h>
+
+#define PHY_CTRL_R0						0x0
+#define PHY_CTRL_R1						0x4
+#define PHY_CTRL_R2						0x8
+#define PHY_CTRL_R3						0xc
+#define PHY_CTRL_R4						0x10
+#define PHY_CTRL_R5						0x14
+#define PHY_CTRL_R6						0x18
+#define PHY_CTRL_R7						0x1c
+#define PHY_CTRL_R8						0x20
+#define PHY_CTRL_R9						0x24
+#define PHY_CTRL_R10						0x28
+#define PHY_CTRL_R11						0x2c
+#define PHY_CTRL_R12						0x30
+#define PHY_CTRL_R13						0x34
+#define PHY_CTRL_R14						0x38
+#define PHY_CTRL_R15						0x3c
+#define PHY_CTRL_R16						0x40
+#define PHY_CTRL_R17						0x44
+#define PHY_CTRL_R18						0x48
+#define PHY_CTRL_R19						0x4c
+#define PHY_CTRL_R20						0x50
+#define PHY_CTRL_R21						0x54
+#define PHY_CTRL_R22						0x58
+#define PHY_CTRL_R23						0x5c
+
+#define RESET_COMPLETE_TIME					1000
+#define PLL_RESET_COMPLETE_TIME					100
+
+struct phy_meson_g12a_usb2_priv {
+	struct regmap		*regmap;
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	struct udevice		*phy_supply;
+#endif
+#if CONFIG_IS_ENABLED(CLK)
+	struct clk		clk;
+#endif
+	struct reset_ctl	reset;
+};
+
+
+static int phy_meson_g12a_usb2_power_on(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
+
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	if (priv->phy_supply) {
+		int ret = regulator_set_enable(priv->phy_supply, true);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	return 0;
+}
+
+static int phy_meson_g12a_usb2_power_off(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
+
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	if (priv->phy_supply) {
+		int ret = regulator_set_enable(priv->phy_supply, false);
+		if (ret) {
+			pr_err("Error disabling PHY supply\n");
+			return ret;
+		}
+	}
+#endif
+
+	return 0;
+}
+
+static int phy_meson_g12a_usb2_init(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = reset_assert(&priv->reset);
+	udelay(1);
+	ret |= reset_deassert(&priv->reset);
+	if (ret)
+		return ret;
+
+	udelay(RESET_COMPLETE_TIME);
+
+	/* usb2_otg_aca_en == 0 */
+	regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
+
+	/* PLL Setup : 24MHz * 20 / 1 = 480MHz */
+	regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
+	regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
+	regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);
+
+	udelay(PLL_RESET_COMPLETE_TIME);
+
+	/* UnReset PLL */
+	regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);
+
+	/* PHY Tuning */
+	regmap_write(priv->regmap, PHY_CTRL_R20, 0xfe18);
+	regmap_write(priv->regmap, PHY_CTRL_R4, 0x8000fff);
+
+	/* Tuning Disconnect Threshold */
+	regmap_write(priv->regmap, PHY_CTRL_R3, 0x34);
+
+	/* Analog Settings */
+	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
+	regmap_write(priv->regmap, PHY_CTRL_R13, 0x78000);
+
+	return 0;
+}
+
+static int phy_meson_g12a_usb2_exit(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = reset_assert(&priv->reset);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+struct phy_ops meson_g12a_usb2_phy_ops = {
+	.init = phy_meson_g12a_usb2_init,
+	.exit = phy_meson_g12a_usb2_exit,
+	.power_on = phy_meson_g12a_usb2_power_on,
+	.power_off = phy_meson_g12a_usb2_power_off,
+};
+
+int meson_g12a_usb2_phy_probe(struct udevice *dev)
+{
+	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
+	if (ret)
+		return ret;
+
+	ret = reset_get_by_index(dev, 0, &priv->reset);
+	if (ret == -ENOTSUPP)
+		return 0;
+	else if (ret)
+		return ret;
+
+	ret = reset_deassert(&priv->reset);
+	if (ret) {
+		reset_release_all(&priv->reset, 1);
+		return ret;
+	}
+
+#if CONFIG_IS_ENABLED(CLK)
+	ret = clk_get_by_index(dev, 0, &priv->clk);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_enable(&priv->clk);
+	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
+		pr_err("failed to enable PHY clock\n");
+		clk_free(&priv->clk);
+		return ret;
+	}
+#endif
+
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	ret = device_get_supply_regulator(dev, "phy-supply", &priv->phy_supply);
+	if (ret && ret != -ENOENT) {
+		pr_err("Failed to get PHY regulator\n");
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
+static const struct udevice_id meson_g12a_usb2_phy_ids[] = {
+	{ .compatible = "amlogic,g12a-usb2-phy" },
+	{ }
+};
+
+U_BOOT_DRIVER(meson_g12a_usb2_phy) = {
+	.name = "meson_g12a_usb2_phy",
+	.id = UCLASS_PHY,
+	.of_match = meson_g12a_usb2_phy_ids,
+	.probe = meson_g12a_usb2_phy_probe,
+	.ops = &meson_g12a_usb2_phy_ops,
+	.priv_auto_alloc_size = sizeof(struct phy_meson_g12a_usb2_priv),
+};
diff --git a/drivers/phy/meson-g12a-usb3-pcie.c b/drivers/phy/meson-g12a-usb3-pcie.c
new file mode 100644
index 0000000000..920675dc99
--- /dev/null
+++ b/drivers/phy/meson-g12a-usb3-pcie.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Meson G12A USB3+PCIE Combo PHY driver
+ *
+ * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ * Copyright (C) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstron@baylibre.com>
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <dm.h>
+#include <regmap.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <reset.h>
+#include <bitfield.h>
+#include <generic-phy.h>
+
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <linux/bitfield.h>
+
+#define PHY_R0							0x00
+	#define PHY_R0_PCIE_POWER_STATE				GENMASK(4, 0)
+	#define PHY_R0_PCIE_USB3_SWITCH				GENMASK(6, 5)
+
+#define PHY_R1							0x04
+	#define PHY_R1_PHY_TX1_TERM_OFFSET			GENMASK(4, 0)
+	#define PHY_R1_PHY_TX0_TERM_OFFSET			GENMASK(9, 5)
+	#define PHY_R1_PHY_RX1_EQ				GENMASK(12, 10)
+	#define PHY_R1_PHY_RX0_EQ				GENMASK(15, 13)
+	#define PHY_R1_PHY_LOS_LEVEL				GENMASK(20, 16)
+	#define PHY_R1_PHY_LOS_BIAS				GENMASK(23, 21)
+	#define PHY_R1_PHY_REF_CLKDIV2				BIT(24)
+	#define PHY_R1_PHY_MPLL_MULTIPLIER			GENMASK(31, 25)
+
+#define PHY_R2							0x08
+	#define PHY_R2_PCS_TX_DEEMPH_GEN2_6DB			GENMASK(5, 0)
+	#define PHY_R2_PCS_TX_DEEMPH_GEN2_3P5DB			GENMASK(11, 6)
+	#define PHY_R2_PCS_TX_DEEMPH_GEN1			GENMASK(17, 12)
+	#define PHY_R2_PHY_TX_VBOOST_LVL			GENMASK(20, 18)
+
+#define PHY_R4							0x10
+	#define PHY_R4_PHY_CR_WRITE				BIT(0)
+	#define PHY_R4_PHY_CR_READ				BIT(1)
+	#define PHY_R4_PHY_CR_DATA_IN				GENMASK(17, 2)
+	#define PHY_R4_PHY_CR_CAP_DATA				BIT(18)
+	#define PHY_R4_PHY_CR_CAP_ADDR				BIT(19)
+
+#define PHY_R5							0x14
+	#define PHY_R5_PHY_CR_DATA_OUT				GENMASK(15, 0)
+	#define PHY_R5_PHY_CR_ACK				BIT(16)
+	#define PHY_R5_PHY_BS_OUT				BIT(17)
+
+struct phy_g12a_usb3_pcie_priv {
+	struct regmap		*regmap;
+#if CONFIG_IS_ENABLED(CLK)
+	struct clk		clk;
+#endif
+	struct reset_ctl_bulk	resets;
+};
+
+static int phy_g12a_usb3_pcie_cr_bus_addr(struct phy_g12a_usb3_pcie_priv *priv,
+					  unsigned int addr)
+{
+	unsigned int val, reg;
+	int ret;
+
+	reg = FIELD_PREP(PHY_R4_PHY_CR_DATA_IN, addr);
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	regmap_write(priv->regmap, PHY_R4, reg | PHY_R4_PHY_CR_CAP_ADDR);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       !(val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+phy_g12a_usb3_pcie_cr_bus_read(struct phy_g12a_usb3_pcie_priv *priv,
+			       unsigned int addr, unsigned int *data)
+{
+	unsigned int val;
+	int ret;
+
+	ret = phy_g12a_usb3_pcie_cr_bus_addr(priv, addr);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, 0);
+	regmap_write(priv->regmap, PHY_R4, PHY_R4_PHY_CR_READ);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	*data = FIELD_GET(PHY_R5_PHY_CR_DATA_OUT, val);
+
+	regmap_write(priv->regmap, PHY_R4, 0);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       !(val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+phy_g12a_usb3_pcie_cr_bus_write(struct phy_g12a_usb3_pcie_priv *priv,
+			        unsigned int addr, unsigned int data)
+{
+	unsigned int val, reg;
+	int ret;
+
+	ret = phy_g12a_usb3_pcie_cr_bus_addr(priv, addr);
+	if (ret)
+		return ret;
+
+	reg = FIELD_PREP(PHY_R4_PHY_CR_DATA_IN, data);
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	regmap_write(priv->regmap, PHY_R4, reg | PHY_R4_PHY_CR_CAP_DATA);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK) == 0,
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	regmap_write(priv->regmap, PHY_R4, reg | PHY_R4_PHY_CR_WRITE);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK) == 0,
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+phy_g12a_usb3_pcie_cr_bus_update_bits(struct phy_g12a_usb3_pcie_priv *priv,
+				      uint offset, uint mask, uint val)
+{
+	uint reg;
+	int ret;
+
+	ret = phy_g12a_usb3_pcie_cr_bus_read(priv, offset, &reg);
+	if (ret)
+		return ret;
+
+	reg &= ~mask;
+
+	return phy_g12a_usb3_pcie_cr_bus_write(priv, offset, reg | val);
+}
+
+static int phy_meson_g12a_usb3_init(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct phy_g12a_usb3_pcie_priv *priv = dev_get_priv(dev);
+	unsigned int data;
+	int ret;
+
+	/* TOFIX Handle PCIE mode */
+
+	ret = reset_assert_bulk(&priv->resets);
+	udelay(1);
+	ret |= reset_deassert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	/* Switch PHY to USB3 */
+	regmap_update_bits(priv->regmap, PHY_R0,
+			   PHY_R0_PCIE_USB3_SWITCH,
+			   PHY_R0_PCIE_USB3_SWITCH);
+
+	/*
+	 * WORKAROUND: There is SSPHY suspend bug due to
+	 * which USB enumerates
+	 * in HS mode instead of SS mode. Workaround it by asserting
+	 * LANE0.TX_ALT_BLOCK.EN_ALT_BUS to enable TX to use alt bus
+	 * mode
+	 */
+	ret = phy_g12a_usb3_pcie_cr_bus_update_bits(priv, 0x102d,
+						    BIT(7), BIT(7));
+	if (ret)
+		return ret;
+
+	ret = phy_g12a_usb3_pcie_cr_bus_update_bits(priv, 0x1010, 0xff0, 20);
+	if (ret)
+		return ret;
+
+	/*
+	 * Fix RX Equalization setting as follows
+	 * LANE0.RX_OVRD_IN_HI. RX_EQ_EN set to 0
+	 * LANE0.RX_OVRD_IN_HI.RX_EQ_EN_OVRD set to 1
+	 * LANE0.RX_OVRD_IN_HI.RX_EQ set to 3
+	 * LANE0.RX_OVRD_IN_HI.RX_EQ_OVRD set to 1
+	 */
+	ret = phy_g12a_usb3_pcie_cr_bus_read(priv, 0x1006, &data);
+	if (ret)
+		return ret;
+
+	data &= ~BIT(6);
+	data |= BIT(7);
+	data &= ~(0x7 << 8);
+	data |= (0x3 << 8);
+	data |= (1 << 11);
+	ret = phy_g12a_usb3_pcie_cr_bus_write(priv, 0x1006, data);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set EQ and TX launch amplitudes as follows
+	 * LANE0.TX_OVRD_DRV_LO.PREEMPH set to 22
+	 * LANE0.TX_OVRD_DRV_LO.AMPLITUDE set to 127
+	 * LANE0.TX_OVRD_DRV_LO.EN set to 1.
+	 */
+	ret = phy_g12a_usb3_pcie_cr_bus_read(priv, 0x1002, &data);
+	if (ret)
+		return ret;
+
+	data &= ~0x3f80;
+	data |= (0x16 << 7);
+	data &= ~0x7f;
+	data |= (0x7f | BIT(14));
+	ret = phy_g12a_usb3_pcie_cr_bus_write(priv, 0x1002, data);
+	if (ret)
+		return ret;
+
+	/*
+	 * MPLL_LOOP_CTL.PROP_CNTRL = 8
+	 */
+	ret = phy_g12a_usb3_pcie_cr_bus_update_bits(priv, 0x30,
+						    0xf << 4, 8 << 4);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(priv->regmap, PHY_R2,
+			PHY_R2_PHY_TX_VBOOST_LVL,
+			FIELD_PREP(PHY_R2_PHY_TX_VBOOST_LVL, 0x4));
+
+	regmap_update_bits(priv->regmap, PHY_R1,
+			PHY_R1_PHY_LOS_BIAS | PHY_R1_PHY_LOS_LEVEL,
+			FIELD_PREP(PHY_R1_PHY_LOS_BIAS, 4) |
+			FIELD_PREP(PHY_R1_PHY_LOS_LEVEL, 9));
+
+	return ret;
+}
+
+static int phy_meson_g12a_usb3_exit(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = dev_get_priv(phy->dev);
+
+	return reset_assert_bulk(&priv->resets);
+}
+
+struct phy_ops meson_g12a_usb3_pcie_phy_ops = {
+	.init = phy_meson_g12a_usb3_init,
+	.exit = phy_meson_g12a_usb3_exit,
+};
+
+int meson_g12a_usb3_pcie_phy_probe(struct udevice *dev)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
+	if (ret)
+		return ret;
+
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret == -ENOTSUPP)
+		return 0;
+	else if (ret)
+		return ret;
+
+#if CONFIG_IS_ENABLED(CLK)
+	ret = clk_get_by_index(dev, 0, &priv->clk);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_enable(&priv->clk);
+	if (ret && ret != -ENOENT && ret != -ENOTSUPP) {
+		pr_err("failed to enable PHY clock\n");
+		clk_free(&priv->clk);
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
+static const struct udevice_id meson_g12a_usb3_pcie_phy_ids[] = {
+	{ .compatible = "amlogic,g12a-usb3-pcie-phy" },
+	{ }
+};
+
+U_BOOT_DRIVER(meson_g12a_usb3_pcie_phy) = {
+	.name = "meson_g12a_usb3_pcie_phy",
+	.id = UCLASS_PHY,
+	.of_match = meson_g12a_usb3_pcie_phy_ids,
+	.probe = meson_g12a_usb3_pcie_phy_probe,
+	.ops = &meson_g12a_usb3_pcie_phy_ops,
+	.priv_auto_alloc_size = sizeof(struct phy_g12a_usb3_pcie_priv),
+};
-- 
2.21.0

