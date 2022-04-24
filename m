Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web09.15822.1650788531408563404
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Apr 2022 01:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650788528; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=MzEBO7DE9auqkZnesEKiPZANXiFvvuJ7g/vtaA+7ERI=;
	b=QclYQl5GmX6OYyG20/bzOqJaJLlfrjAek18QGdIcK8dvx1OV9CpaTx519Va2YBV38G3x82
	xoLRcYr8C/UHzfMZiK8wGqtl77cwOZNxXA1IjqlYPrPQn8EZPZDV0moNhCOuR2ZYyAv6q4
	UxuzmiDfThq3mrXbq2gmciPbFj591kyDMROoLxoVIJ4DQXcECZt6VqD71V4yiE1CxzISSZ
	u553HnVLBXhpWlk7pnoLCLNzh1Q1uufuQOA4H4stsXSRYDiY33EFddxzkcDqXShoFcM93l
	0HMs7yDciAMfPtJLBH1T0N23ooKosnt1L9774NmiDMJH/yOZpJS6kae8HAQi1w==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 1/6] clk: meson: add minimal driver for axg-ao clocks
Date: Sun, 24 Apr 2022 11:21:54 +0300
Message-Id: <20220424082159.757622-2-adeep@lexina.in>
In-Reply-To: <20220424082159.757622-1-adeep@lexina.in>
References: <20220424082159.757622-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add minimal driver AO clocks on meson AXG family. Only ADC related clocks
are supported.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/Makefile |  1 +
 drivers/clk/meson/axg-ao.c | 86 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 drivers/clk/meson/axg-ao.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index b9c6bd66cf..a486b13e9c 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -5,5 +5,6 @@
=20
 obj-$(CONFIG_CLK_MESON_GX) +=3D gxbb.o
 obj-$(CONFIG_CLK_MESON_AXG) +=3D axg.o
+obj-$(CONFIG_CLK_MESON_AXG) +=3D axg-ao.o
 obj-$(CONFIG_CLK_MESON_G12A) +=3D g12a.o
 obj-$(CONFIG_CLK_MESON_G12A) +=3D g12a-ao.o
diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
new file mode 100644
index 0000000000..311ffc1cca
--- /dev/null
+++ b/drivers/clk/meson/axg-ao.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <common.h>
+#include <log.h>
+#include <asm/io.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <dt-bindings/clock/axg-aoclkc.h>
+
+#include "clk_meson.h"
+
+struct meson_clk {
+	struct regmap *map;
+};
+
+#define AO_CLK_GATE0		0x40
+#define AO_SAR_CLK		0x90
+
+static struct meson_gate gates[] =3D {
+	MESON_GATE(CLKID_AO_SAR_ADC, AO_CLK_GATE0, 7),
+	MESON_GATE(CLKID_AO_SAR_ADC_CLK, AO_SAR_CLK, 7),
+};
+
+static int meson_set_gate(struct clk *clk, bool on)
+{
+	struct meson_clk *priv =3D dev_get_priv(clk->dev);
+	struct meson_gate *gate;
+
+	gate =3D &gates[clk->id];
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
+	struct meson_clk *priv =3D dev_get_priv(dev);
+
+	priv->map =3D syscon_node_to_regmap(dev_ofnode(dev_get_parent(dev)));
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	return 0;
+}
+
+static int meson_clk_request(struct clk *clk)
+{
+	if (clk->id >=3D ARRAY_SIZE(gates))
+		return -ENOENT;
+
+	return 0;
+}
+
+static struct clk_ops meson_clk_ops =3D {
+	.disable	=3D meson_clk_disable,
+	.enable		=3D meson_clk_enable,
+	.request	=3D meson_clk_request,
+};
+
+static const struct udevice_id meson_clk_ids[] =3D {
+	{ .compatible =3D "amlogic,meson-axg-aoclkc" },
+	{ }
+};
+
+U_BOOT_DRIVER(meson_clk_axg_ao) =3D {
+	.name		=3D "meson_clk_axg_ao",
+	.id		=3D UCLASS_CLK,
+	.of_match	=3D meson_clk_ids,
+	.priv_auto	=3D sizeof(struct meson_clk),
+	.ops		=3D &meson_clk_ops,
+	.probe		=3D meson_clk_probe,
+};
--=20
2.30.2

