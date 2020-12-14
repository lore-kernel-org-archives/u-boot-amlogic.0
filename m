Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web11.33541.1607945111607361115
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 03:25:11 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201214112455euoutp01e24cf7035da4762902a56f9a340645f0~QkYt7PrR90131301313euoutp01Z
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 11:24:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201214112455euoutp01e24cf7035da4762902a56f9a340645f0~QkYt7PrR90131301313euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607945095;
	bh=+0e8dKAiob1OcjRvD9TwFvbIOMafBCQMSn4wKEe4suE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rb7dwA+7u37qygmrBg2xePmK/E4pvgumvD5h2EU0eA3gS1gdL+ShPbkXe5mYa+uHF
	 sg/PXzIgoXXK8zeHS0o8ns4IbXHIdbYDuwqV9yplfPFS1ljcJR6yNh4Y8igh+hPm3z
	 cNGOeiTOb64T8c3HofDicemscX0KykJN6lEcQfhE=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/6] clk: meson: add minimal driver for g12a-ao clocks
Date: Mon, 14 Dec 2020 12:24:32 +0100
Message-Id: <20201214112437.18757-2-m.szyprowski@samsung.com>
In-Reply-To: <20201214112437.18757-1-m.szyprowski@samsung.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112449eucas1p2ce0ef939e0d7f468e64be3555f29ea04@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add minimal driver AO clocks on meson G12A family. Only ADC related clocks
are supported.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Change-Id: I0c91848bc55493e19570db333e7da6020d687907
---
 drivers/clk/meson/Makefile  |  1 +
 drivers/clk/meson/g12a-ao.c | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 drivers/clk/meson/g12a-ao.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index c873d6976fa..7204383e173 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_CLK_MESON_GX) += gxbb.o
 obj-$(CONFIG_CLK_MESON_AXG) += axg.o
 obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
+obj-$(CONFIG_CLK_MESON_G12A) += g12a-ao.o
 
diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
new file mode 100644
index 00000000000..7a0abea77c4
--- /dev/null
+++ b/drivers/clk/meson/g12a-ao.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <common.h>
+#include <log.h>
+#include <asm/io.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <dt-bindings/clock/g12a-aoclkc.h>
+
+#include "clk_meson.h"
+
+struct meson_clk {
+	struct regmap *map;
+};
+
+#define AO_CLK_GATE0		0x4c
+#define AO_SAR_CLK		0x90
+
+static struct meson_gate gates[] = {
+	MESON_GATE(CLKID_AO_SAR_ADC, AO_CLK_GATE0, 8),
+	MESON_GATE(CLKID_AO_SAR_ADC_CLK, AO_SAR_CLK, 8),
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
+static int meson_clk_probe(struct udevice *dev)
+{
+	struct meson_clk *priv = dev_get_priv(dev);
+
+	priv->map = syscon_node_to_regmap(dev_get_parent(dev)->node);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	return 0;
+}
+
+static struct clk_ops meson_clk_ops = {
+	.disable	= meson_clk_disable,
+	.enable		= meson_clk_enable,
+};
+
+static const struct udevice_id meson_clk_ids[] = {
+	{ .compatible = "amlogic,meson-g12a-aoclkc" },
+	{ }
+};
+
+U_BOOT_DRIVER(meson_clk_axg) = {
+	.name		= "meson_clk_g12a_ao",
+	.id		= UCLASS_CLK,
+	.of_match	= meson_clk_ids,
+	.priv_auto_alloc_size = sizeof(struct meson_clk),
+	.ops		= &meson_clk_ops,
+	.probe		= meson_clk_probe,
+};
-- 
2.17.1

