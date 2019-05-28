Received: by mail-wm1-f68.google.com with SMTP id z23so1865447wma.4
        for <u-boot-amlogic@groups.io>; Tue, 28 May 2019 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4JIDeE9c9S6Ou4LNLBQrYjHQhxVE/9MG79pyhIqiDK0=;
        b=l6TQTDj3pjjnzdky3DmULBsbIB2TbGv1SAMMY/KtnjX7kpIv3p3XI1ZAG9IQNgSxSm
         1E4rc1H/+IzUIizKQK/jKsbm+fHiSaA0qtWdfqKhfPlMcwA5vJ+C61/k7KelTLAJ9XGf
         qVp9YEgJbWqh8+EwQCqJh+0xKCDssOaoAZb/UxhMErqVhEkLVkfYwrqUnW9kfgJYEgJn
         bGkekQxGHPp4Sst4LqLom6IY1rqDSmXswgpvdW5Pa3o+NngJrv40Cj/CiVnCSH6FXahl
         VYooMUkV5PoR0//BX/p7eJSCG5eBMN5sLY+6NCGNhaH61SsbcdSCPZ5T/IZms3l4kS03
         GMhA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/3] clk: meson-g12a: Add PCIE PLL support
Date: Tue, 28 May 2019 10:50:37 +0200
Message-Id: <20190528085038.8088-3-narmstrong@baylibre.com>
In-Reply-To: <20190528085038.8088-1-narmstrong@baylibre.com>
References: <20190528085038.8088-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The G12A PCIE PLL clock was introduced in Linux 5.2-rc1, and is needed
for USB to operate, add basic support for it and associated gates.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 103 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index fedc9eb7dd..112326e553 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -22,6 +22,8 @@ struct meson_clk {
 	struct regmap *map;
 };
 
+static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
+				      ulong rate, ulong current_rate);
 static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
 
 #define NUM_CLKS 178
@@ -36,6 +38,8 @@ static struct meson_gate gates[NUM_CLKS] = {
 	MESON_GATE(CLKID_SD_EMMC_C, HHI_GCLK_MPEG0, 26),
 	MESON_GATE(CLKID_ETH, HHI_GCLK_MPEG1, 3),
 	MESON_GATE(CLKID_UART1, HHI_GCLK_MPEG1, 16),
+	MESON_GATE(CLKID_USB, HHI_GCLK_MPEG1, 25),
+	MESON_GATE(CLKID_USB1_DDR_BRIDGE, HHI_GCLK_MPEG2, 8),
 
 	/* Peripheral Gates */
 	MESON_GATE(CLKID_SD_EMMC_B_CLK0, HHI_SD_EMMC_CLK_CNTL, 23),
@@ -231,6 +235,36 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 	return ((parent_rate_mhz * m / n) >> od) * 1000000;
 }
 
+static struct parm meson_pcie_pll_parm[3] = {
+	{HHI_PCIE_PLL_CNTL0, 0, 8}, /* pm */
+	{HHI_PCIE_PLL_CNTL0, 10, 5}, /* pn */
+	{HHI_PCIE_PLL_CNTL0, 16, 5}, /* pod */
+};
+
+static ulong meson_pcie_pll_get_rate(struct clk *clk)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	struct parm *pm, *pn, *pod;
+	unsigned long parent_rate_mhz = XTAL_RATE / 1000000;
+	u16 n, m, od;
+	uint reg;
+
+	pm = &meson_pcie_pll_parm[0];
+	pn = &meson_pcie_pll_parm[1];
+	pod = &meson_pcie_pll_parm[2];
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
+	return ((parent_rate_mhz * m / n) / 2 / od / 2) * 1000000;
+}
+
 static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 {
 	ulong rate;
@@ -263,6 +297,9 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	case CLKID_CLK81:
 		rate = meson_clk81_get_rate(clk);
 		break;
+	case CLKID_PCIE_PLL:
+		rate = meson_pcie_pll_get_rate(clk);
+		break;
 	default:
 		if (gates[id].reg != 0) {
 			/* a clock gate */
@@ -281,6 +318,71 @@ static ulong meson_clk_get_rate(struct clk *clk)
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
 
+static ulong meson_pcie_pll_set_rate(struct clk *clk, ulong rate)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL0, 0x20090496);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL0, 0x30090496);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL1, 0x00000000);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL2, 0x00001100);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL3, 0x10058e00);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL4, 0x000100c0);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL5, 0x68000048);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL5, 0x68000068);
+	udelay(20);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL4, 0x008100c0);
+	udelay(10);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL0, 0x34090496);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL0, 0x14090496);
+	udelay(10);
+	regmap_write(priv->map, HHI_PCIE_PLL_CNTL2, 0x00001000);
+	regmap_update_bits(priv->map, HHI_PCIE_PLL_CNTL0,
+				0x1f << 16, 9 << 16);
+
+	return 100000000;
+}
+
+static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
+				      ulong rate, ulong current_rate)
+{
+	if (current_rate == rate)
+		return 0;
+
+	switch (id) {
+	/* Fixed clocks */
+	case CLKID_PCIE_PLL:
+		return meson_pcie_pll_set_rate(clk, rate);
+
+	default:
+		return -ENOENT;
+	}
+
+	return -EINVAL;
+}
+
+
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+{
+	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
+	int ret;
+
+	if (IS_ERR_VALUE(current_rate))
+		return current_rate;
+
+	debug("%s: setting rate of %ld from %ld to %ld\n",
+	      __func__, clk->id, current_rate, rate);
+
+	ret = meson_clk_set_rate_by_id(clk, clk->id, rate, current_rate);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	debug("clock %lu has new rate %lu\n", clk->id,
+	      meson_clk_get_rate_by_id(clk, clk->id));
+
+	return 0;
+}
+
 static int meson_clk_probe(struct udevice *dev)
 {
 	struct meson_clk *priv = dev_get_priv(dev);
@@ -298,6 +400,7 @@ static struct clk_ops meson_clk_ops = {
 	.disable	= meson_clk_disable,
 	.enable		= meson_clk_enable,
 	.get_rate	= meson_clk_get_rate,
+	.set_rate	= meson_clk_set_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
-- 
2.21.0

