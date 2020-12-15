Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web09.12732.1608043387020035644
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 06:43:07 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201215144248euoutp02917d1d4a886dfaa50e95dd57d575ca1d~Q6ux5xonF1490614906euoutp02s
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 14:42:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201215144248euoutp02917d1d4a886dfaa50e95dd57d575ca1d~Q6ux5xonF1490614906euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608043368;
	bh=tqiyrcofRXDD8+Jvxf8Hvi5HLF9twruT3mGu/SaynC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsGxCRlwm+C3CRRhixC6vNf3R1S6BXE8l9dvaoWvuEs8QsYoC9dB6T3GUNMrzzqFe
	 yp7gt3Fx2mfaWYM5vEbiMYNuQNLY63wPbPmsoVl9CryWfDm34BYHxkMFqFreVTgB+O
	 X25ooMaQgLdaPiVLs6t6BCMyF7E0QEG2EaF+WQQQ=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 1/7] clk: meson: add minimal driver for g12a-ao clocks
Date: Tue, 15 Dec 2020 15:42:24 +0100
Message-Id: <20201215144230.9235-2-m.szyprowski@samsung.com>
In-Reply-To: <20201215144230.9235-1-m.szyprowski@samsung.com>
References: <20201215144230.9235-1-m.szyprowski@samsung.com>
	<CGME20201215144242eucas1p1ff9e7e4acd3ef9b86fa15a2cd4ac05a5@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add minimal driver AO clocks on meson G12A family. Only ADC related clocks
are supported.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/clk/meson/Makefile  |  1 +
 drivers/clk/meson/g12a-ao.c | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 drivers/clk/meson/g12a-ao.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index c873d6976f..7204383e17 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_CLK_MESON_GX) += gxbb.o
 obj-$(CONFIG_CLK_MESON_AXG) += axg.o
 obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
+obj-$(CONFIG_CLK_MESON_G12A) += g12a-ao.o
 
diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
new file mode 100644
index 0000000000..7a0abea77c
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

