Received: by mail-wr1-f67.google.com with SMTP id r4so7067792wrq.8
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81ToyyJShp8t0urDRpzBk0Q3BQLwBYybMvHzFkgSUqk=;
        b=JDP5YWDXWstNtJYJh5fzhErDcCFGCdKOzqFuwoWleADjbwygocQrvf5cjNyE4jZzAI
         GjkVnfnyXVbfVBX/76sBked77gSGs+FjcHZdWfMj2dTkoY+/0NsE+3P+zMcBMHX8XdPP
         2BMbG//xha80xlo2cpiK9BRnzJ+Lr3wWkbb0aQ0cGdSr0sTN7NtDGa37q7nypG43sSPI
         Fv/p6awDibZNM2dbGu4bnVKMNHZ2lvGg6VbxTuEVCQjK18OuWSh5NGzxD7CWageJ9F7A
         7eQjb0WcCdBxD1Fs9P5gXxxOvKUMfpAkjUKO1GJNKus1xw23VGzaAvlpDOP2P8X6nKez
         zDHw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/6] clk: meson: add g12a support
Date: Tue, 26 Mar 2019 16:02:37 +0100
Message-Id: <20190326150240.20620-4-narmstrong@baylibre.com>
In-Reply-To: <20190326150240.20620-1-narmstrong@baylibre.com>
References: <20190326150240.20620-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, sjg@chromium.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Jerome Brunet <jbrunet@baylibre.com>

Add basic support for the Amlogic G12A clock controller based on
the AXG driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/clock-g12a.h | 104 ++++++
 drivers/clk/meson/Kconfig                    |   8 +
 drivers/clk/meson/Makefile                   |   1 +
 drivers/clk/meson/g12a.c                     | 315 +++++++++++++++++++
 4 files changed, 428 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/clock-g12a.h
 create mode 100644 drivers/clk/meson/g12a.c

diff --git a/arch/arm/include/asm/arch-meson/clock-g12a.h b/arch/arm/include/asm/arch-meson/clock-g12a.h
new file mode 100644
index 0000000000..d52e27e008
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/clock-g12a.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2016 - AmLogic, Inc.
+ * Copyright 2018 - Beniamino Galvani <b.galvani@gmail.com>
+ * Copyright 2018 - BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+#ifndef _ARCH_MESON_CLOCK_G12A_H_
+#define _ARCH_MESON_CLOCK_G12A_H_
+
+/*
+ * Clock controller register offsets
+ *
+ * Register offsets from the data sheet are listed in comment blocks below.
+ * Those offsets must be multiplied by 4 before adding them to the base address
+ * to get the right value
+ */
+
+#define HHI_MIPI_CNTL0			0x000
+#define HHI_MIPI_CNTL1			0x004
+#define HHI_MIPI_CNTL2			0x008
+#define HHI_MIPI_STS			0x00C
+#define HHI_GP0_PLL_CNTL0		0x040
+#define HHI_GP0_PLL_CNTL1		0x044
+#define HHI_GP0_PLL_CNTL2		0x048
+#define HHI_GP0_PLL_CNTL3		0x04C
+#define HHI_GP0_PLL_CNTL4		0x050
+#define HHI_GP0_PLL_CNTL5		0x054
+#define HHI_GP0_PLL_CNTL6		0x058
+#define HHI_GP0_PLL_STS			0x05C
+#define HHI_PCIE_PLL_CNTL0		0x098
+#define HHI_PCIE_PLL_CNTL1		0x09C
+#define HHI_PCIE_PLL_CNTL2		0x0A0
+#define HHI_PCIE_PLL_CNTL3		0x0A4
+#define HHI_PCIE_PLL_CNTL4		0x0A8
+#define HHI_PCIE_PLL_CNTL5		0x0AC
+#define HHI_PCIE_PLL_STS		0x0B8
+#define HHI_HIFI_PLL_CNTL0		0x0D8
+#define HHI_HIFI_PLL_CNTL1		0x0DC
+#define HHI_HIFI_PLL_CNTL2		0x0E0
+#define HHI_HIFI_PLL_CNTL3		0x0E4
+#define HHI_HIFI_PLL_CNTL4		0x0E8
+#define HHI_HIFI_PLL_CNTL5		0x0EC
+#define HHI_HIFI_PLL_CNTL6		0x0F0
+#define HHI_VIID_CLK_DIV		0x128
+#define HHI_VIID_CLK_CNTL		0x12C
+#define HHI_GCLK_MPEG0			0x140
+#define HHI_GCLK_MPEG1			0x144
+#define HHI_GCLK_MPEG2			0x148
+#define HHI_GCLK_OTHER			0x150
+#define HHI_GCLK_OTHER2			0x154
+#define HHI_VID_CLK_DIV			0x164
+#define HHI_MPEG_CLK_CNTL		0x174
+#define HHI_AUD_CLK_CNTL		0x178
+#define HHI_VID_CLK_CNTL		0x17c
+#define HHI_TS_CLK_CNTL			0x190
+#define HHI_VID_CLK_CNTL2		0x194
+#define HHI_SYS_CPU_CLK_CNTL0		0x19c
+#define HHI_VID_PLL_CLK_DIV		0x1A0
+#define HHI_MALI_CLK_CNTL		0x1b0
+#define HHI_VPU_CLKC_CNTL		0x1b4
+#define HHI_VPU_CLK_CNTL		0x1bC
+#define HHI_HDMI_CLK_CNTL		0x1CC
+#define HHI_VDEC_CLK_CNTL		0x1E0
+#define HHI_VDEC2_CLK_CNTL		0x1E4
+#define HHI_VDEC3_CLK_CNTL		0x1E8
+#define HHI_VDEC4_CLK_CNTL		0x1EC
+#define HHI_HDCP22_CLK_CNTL		0x1F0
+#define HHI_VAPBCLK_CNTL		0x1F4
+#define HHI_VPU_CLKB_CNTL		0x20C
+#define HHI_GEN_CLK_CNTL		0x228
+#define HHI_VDIN_MEAS_CLK_CNTL		0x250
+#define HHI_MIPIDSI_PHY_CLK_CNTL	0x254
+#define HHI_NAND_CLK_CNTL		0x25C
+#define HHI_SD_EMMC_CLK_CNTL		0x264
+#define HHI_MPLL_CNTL0			0x278
+#define HHI_MPLL_CNTL1			0x27C
+#define HHI_MPLL_CNTL2			0x280
+#define HHI_MPLL_CNTL3			0x284
+#define HHI_MPLL_CNTL4			0x288
+#define HHI_MPLL_CNTL5			0x28c
+#define HHI_MPLL_CNTL6			0x290
+#define HHI_MPLL_CNTL7			0x294
+#define HHI_MPLL_CNTL8			0x298
+#define HHI_FIX_PLL_CNTL0		0x2A0
+#define HHI_FIX_PLL_CNTL1		0x2A4
+#define HHI_FIX_PLL_CNTL3		0x2AC
+#define HHI_SYS_PLL_CNTL0		0x2f4
+#define HHI_SYS_PLL_CNTL1		0x2f8
+#define HHI_SYS_PLL_CNTL2		0x2fc
+#define HHI_SYS_PLL_CNTL3		0x300
+#define HHI_SYS_PLL_CNTL4		0x304
+#define HHI_SYS_PLL_CNTL5		0x308
+#define HHI_SYS_PLL_CNTL6		0x30c
+#define HHI_HDMI_PLL_CNTL0		0x320
+#define HHI_HDMI_PLL_CNTL1		0x324
+#define HHI_HDMI_PLL_CNTL2		0x328
+#define HHI_HDMI_PLL_CNTL3		0x32c
+#define HHI_HDMI_PLL_CNTL4		0x330
+#define HHI_HDMI_PLL_CNTL5		0x334
+#define HHI_HDMI_PLL_CNTL6		0x338
+#define HHI_SPICC_CLK_CNTL		0x3dc
+
+#endif
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 2419a30dcb..994b44ad7a 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -13,3 +13,11 @@ config CLK_MESON_AXG
 	help
 	  Enable clock support for the Amlogic AXG SoC family, such as
 	  the A113X/D
+
+config CLK_MESON_G12A
+	bool "Enable clock support for Amlogic G12A"
+	depends on CLK && ARCH_MESON
+	default MESON_G12A
+	help
+	  Enable clock support for the Amlogic G12A SoC family, such as
+	  the S905X/D2
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 47a5ad588e..c873d6976f 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_CLK_MESON_GX) += gxbb.o
 obj-$(CONFIG_CLK_MESON_AXG) += axg.o
+obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
new file mode 100644
index 0000000000..fedc9eb7dd
--- /dev/null
+++ b/drivers/clk/meson/g12a.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2018 - Beniamino Galvani <b.galvani@gmail.com>
+ * (C) Copyright 2018 - BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <common.h>
+#include <asm/arch/clock-g12a.h>
+#include <asm/io.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <div64.h>
+#include <dt-bindings/clock/g12a-clkc.h>
+#include "clk_meson.h"
+
+#define XTAL_RATE 24000000
+
+struct meson_clk {
+	struct regmap *map;
+};
+
+static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
+
+#define NUM_CLKS 178
+
+static struct meson_gate gates[NUM_CLKS] = {
+	/* Everything Else (EE) domain gates */
+	MESON_GATE(CLKID_SPICC0, HHI_GCLK_MPEG0, 8),
+	MESON_GATE(CLKID_I2C, HHI_GCLK_MPEG0, 9),
+	MESON_GATE(CLKID_UART0, HHI_GCLK_MPEG0, 13),
+	MESON_GATE(CLKID_SPICC1, HHI_GCLK_MPEG0, 14),
+	MESON_GATE(CLKID_SD_EMMC_B, HHI_GCLK_MPEG0, 25),
+	MESON_GATE(CLKID_SD_EMMC_C, HHI_GCLK_MPEG0, 26),
+	MESON_GATE(CLKID_ETH, HHI_GCLK_MPEG1, 3),
+	MESON_GATE(CLKID_UART1, HHI_GCLK_MPEG1, 16),
+
+	/* Peripheral Gates */
+	MESON_GATE(CLKID_SD_EMMC_B_CLK0, HHI_SD_EMMC_CLK_CNTL, 23),
+	MESON_GATE(CLKID_SD_EMMC_C_CLK0, HHI_NAND_CLK_CNTL, 7),
+};
+
+static int meson_set_gate(struct clk *clk, bool on)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	struct meson_gate *gate;
+
+	if (clk->id >= ARRAY_SIZE(gates))
+		return -ENOENT;
+
+	gate = &gates[clk->id];
+
+	if (gate->reg == 0)
+		return 0;
+
+	regmap_update_bits(priv->map, gate->reg,
+			   BIT(gate->bit), on ? BIT(gate->bit) : 0);
+
+	return 0;
+}
+
+static int meson_clk_enable(struct clk *clk)
+{
+	return meson_set_gate(clk, true);
+}
+
+static int meson_clk_disable(struct clk *clk)
+{
+	return meson_set_gate(clk, false);
+}
+
+static unsigned long meson_clk81_get_rate(struct clk *clk)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	unsigned long parent_rate;
+	uint reg;
+	int parents[] = {
+		-1,
+		-1,
+		CLKID_FCLK_DIV7,
+		CLKID_MPLL1,
+		CLKID_MPLL2,
+		CLKID_FCLK_DIV4,
+		CLKID_FCLK_DIV3,
+		CLKID_FCLK_DIV5
+	};
+
+	/* mux */
+	regmap_read(priv->map, HHI_MPEG_CLK_CNTL, &reg);
+	reg = (reg >> 12) & 7;
+
+	switch (reg) {
+	case 0:
+		parent_rate = XTAL_RATE;
+		break;
+	case 1:
+		return -ENOENT;
+	default:
+		parent_rate = meson_clk_get_rate_by_id(clk, parents[reg]);
+	}
+
+	/* divider */
+	regmap_read(priv->map, HHI_MPEG_CLK_CNTL, &reg);
+	reg = reg & ((1 << 7) - 1);
+
+	return parent_rate / reg;
+}
+
+static long mpll_rate_from_params(unsigned long parent_rate,
+				  unsigned long sdm,
+				  unsigned long n2)
+{
+	unsigned long divisor = (SDM_DEN * n2) + sdm;
+
+	if (n2 < N2_MIN)
+		return -EINVAL;
+
+	return DIV_ROUND_UP_ULL((u64)parent_rate * SDM_DEN, divisor);
+}
+
+static struct parm meson_mpll0_parm[2] = {
+	{HHI_MPLL_CNTL1, 0, 14}, /* psdm */
+	{HHI_MPLL_CNTL1, 20, 9}, /* pn2 */
+};
+
+static struct parm meson_mpll1_parm[2] = {
+	{HHI_MPLL_CNTL3, 0, 14}, /* psdm */
+	{HHI_MPLL_CNTL3, 20, 9}, /* pn2 */
+};
+
+static struct parm meson_mpll2_parm[2] = {
+	{HHI_MPLL_CNTL5, 0, 14}, /* psdm */
+	{HHI_MPLL_CNTL5, 20, 9}, /* pn2 */
+};
+
+/*
+ * MultiPhase Locked Loops are outputs from a PLL with additional frequency
+ * scaling capabilities. MPLL rates are calculated as:
+ *
+ * f(N2_integer, SDM_IN ) = 2.0G/(N2_integer + SDM_IN/16384)
+ */
+static ulong meson_mpll_get_rate(struct clk *clk, unsigned long id)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	struct parm *psdm, *pn2;
+	unsigned long sdm, n2;
+	unsigned long parent_rate;
+	uint reg;
+
+	switch (id) {
+	case CLKID_MPLL0:
+		psdm = &meson_mpll0_parm[0];
+		pn2 = &meson_mpll0_parm[1];
+		break;
+	case CLKID_MPLL1:
+		psdm = &meson_mpll1_parm[0];
+		pn2 = &meson_mpll1_parm[1];
+		break;
+	case CLKID_MPLL2:
+		psdm = &meson_mpll2_parm[0];
+		pn2 = &meson_mpll2_parm[1];
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	parent_rate = meson_clk_get_rate_by_id(clk, CLKID_FIXED_PLL);
+	if (IS_ERR_VALUE(parent_rate))
+		return parent_rate;
+
+	regmap_read(priv->map, psdm->reg_off, &reg);
+	sdm = PARM_GET(psdm->width, psdm->shift, reg);
+
+	regmap_read(priv->map, pn2->reg_off, &reg);
+	n2 = PARM_GET(pn2->width, pn2->shift, reg);
+
+	return mpll_rate_from_params(parent_rate, sdm, n2);
+}
+
+static struct parm meson_fixed_pll_parm[3] = {
+	{HHI_FIX_PLL_CNTL0, 0, 8}, /* pm */
+	{HHI_FIX_PLL_CNTL0, 10, 5}, /* pn */
+	{HHI_FIX_PLL_CNTL0, 16, 2}, /* pod */
+};
+
+static struct parm meson_sys_pll_parm[3] = {
+	{HHI_SYS_PLL_CNTL0, 0, 8}, /* pm */
+	{HHI_SYS_PLL_CNTL0, 10, 5}, /* pn */
+	{HHI_SYS_PLL_CNTL0, 16, 2}, /* pod */
+};
+
+static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	struct parm *pm, *pn, *pod;
+	unsigned long parent_rate_mhz = XTAL_RATE / 1000000;
+	u16 n, m, od;
+	uint reg;
+
+	/*
+	 * FIXME: Between the unit conversion and the missing frac, we know
+	 * rate will be slightly off ...
+	*/
+
+	switch (id) {
+	case CLKID_FIXED_PLL:
+		pm = &meson_fixed_pll_parm[0];
+		pn = &meson_fixed_pll_parm[1];
+		pod = &meson_fixed_pll_parm[2];
+		break;
+	case CLKID_SYS_PLL:
+		pm = &meson_sys_pll_parm[0];
+		pn = &meson_sys_pll_parm[1];
+		pod = &meson_sys_pll_parm[2];
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	regmap_read(priv->map, pn->reg_off, &reg);
+	n = PARM_GET(pn->width, pn->shift, reg);
+
+	regmap_read(priv->map, pm->reg_off, &reg);
+	m = PARM_GET(pm->width, pm->shift, reg);
+
+	regmap_read(priv->map, pod->reg_off, &reg);
+	od = PARM_GET(pod->width, pod->shift, reg);
+
+	return ((parent_rate_mhz * m / n) >> od) * 1000000;
+}
+
+static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
+{
+	ulong rate;
+
+	switch (id) {
+	case CLKID_FIXED_PLL:
+	case CLKID_SYS_PLL:
+		rate = meson_pll_get_rate(clk, id);
+		break;
+	case CLKID_FCLK_DIV2:
+		rate = meson_pll_get_rate(clk, CLKID_FIXED_PLL) / 2;
+		break;
+	case CLKID_FCLK_DIV3:
+		rate = meson_pll_get_rate(clk, CLKID_FIXED_PLL) / 3;
+		break;
+	case CLKID_FCLK_DIV4:
+		rate = meson_pll_get_rate(clk, CLKID_FIXED_PLL) / 4;
+		break;
+	case CLKID_FCLK_DIV5:
+		rate = meson_pll_get_rate(clk, CLKID_FIXED_PLL) / 5;
+		break;
+	case CLKID_FCLK_DIV7:
+		rate = meson_pll_get_rate(clk, CLKID_FIXED_PLL) / 7;
+		break;
+	case CLKID_MPLL0:
+	case CLKID_MPLL1:
+	case CLKID_MPLL2:
+		rate = meson_mpll_get_rate(clk, id);
+		break;
+	case CLKID_CLK81:
+		rate = meson_clk81_get_rate(clk);
+		break;
+	default:
+		if (gates[id].reg != 0) {
+			/* a clock gate */
+			rate = meson_clk81_get_rate(clk);
+			break;
+		}
+		return -ENOENT;
+	}
+
+	debug("clock %lu has rate %lu\n", id, rate);
+	return rate;
+}
+
+static ulong meson_clk_get_rate(struct clk *clk)
+{
+	return meson_clk_get_rate_by_id(clk, clk->id);
+}
+
+static int meson_clk_probe(struct udevice *dev)
+{
+	struct meson_clk *priv = dev_get_priv(dev);
+
+	priv->map = syscon_node_to_regmap(dev_get_parent(dev)->node);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	debug("meson-clk-g12a: probed\n");
+
+	return 0;
+}
+
+static struct clk_ops meson_clk_ops = {
+	.disable	= meson_clk_disable,
+	.enable		= meson_clk_enable,
+	.get_rate	= meson_clk_get_rate,
+};
+
+static const struct udevice_id meson_clk_ids[] = {
+	{ .compatible = "amlogic,g12a-clkc" },
+	{ }
+};
+
+U_BOOT_DRIVER(meson_clk_g12a) = {
+	.name		= "meson_clk_g12a",
+	.id		= UCLASS_CLK,
+	.of_match	= meson_clk_ids,
+	.priv_auto_alloc_size = sizeof(struct meson_clk),
+	.ops		= &meson_clk_ops,
+	.probe		= meson_clk_probe,
+};
-- 
2.21.0

