Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.64507.1695657150323712168
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Sep 2023 08:52:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C3C0510000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1695657148;
	bh=hujYMZXELB/QyXuPZaUBGnn6vM0DscwqoI9PNepDV14=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=R4OlfYlIjkruX4bqbRdhmn3rinFzG7CSEkxm8yesokXwaxdEDvM1IQfloxJzP6aN2
	 DGaLLhc0Yx2rrYnKHqLT68NgKYeeru1VGW6pMzGvmmakSQG+LZ23kQ31hJy60B0+OP
	 CX6eTYzXQ/YjaZu9CjmL7e2vPPolfvYod0NX1umOQZxt1b+cTLebs9U57dbehhCgPe
	 aRasTikyFprFyRZXRSsUlVQc6Z8HIHQ8W6qcAitEaUkXnYjsrUDzAKqmOwx3Igrdne
	 sFUdcE10CBvqtBNn4OnbEcrnHnqu4E8D04kuTxXjCqBj6rmQrGrSiZ131sUBc2X4Bv
	 p0t4IIK0IvEQQ==
From: "Igor Prusov" <ivprusov@salutedevices.com>
Subject: [PATCH v2 2/2] clk: Add clock driver for Amlogic A1
Date: Mon, 25 Sep 2023 18:52:09 +0300
Message-ID: <20230925155209.130671-3-ivprusov@salutedevices.com>
In-Reply-To: <20230925155209.130671-1-ivprusov@salutedevices.com>
References: <20230925155209.130671-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Igor Prusov <ivprusov@salutedevices.com>, Simon Glass <sjg@chromium.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

This patch adds basic clock driver for Amlogic A1 Family which supports
enabling/disabling some gates, getting frequencies and setting rate
with limited reparenting.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/arch-meson/clock-a1.h |  23 +
 drivers/clk/meson/Kconfig                  |   8 +
 drivers/clk/meson/Makefile                 |   1 +
 drivers/clk/meson/a1.c                     | 723 +++++++++++++++++++++
 4 files changed, 755 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
 create mode 100644 drivers/clk/meson/a1.c

diff --git a/arch/arm/include/asm/arch-meson/clock-a1.h b/arch/arm/include/=
asm/arch-meson/clock-a1.h
new file mode 100644
index 0000000000..f6795f5e0c
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/clock-a1.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018 - AmLogic, Inc.
+ * Copyright 2023 (C) SberDevices, Inc.
+ */
+
+#ifndef _ARCH_MESON_CLOCK_A1_H_
+#define _ARCH_MESON_CLOCK_A1_H_
+
+/*
+ * Clock controller register offsets
+ */
+#define A1_SYS_OSCIN_CTRL		0x0
+#define A1_SYS_CLK_CTRL0		0x10
+#define A1_SYS_CLK_EN0			0x1c
+#define A1_SAR_ADC_CLK_CTR		0xc0
+#define A1_SPIFC_CLK_CTRL		0xd8
+#define A1_USB_BUSCLK_CTRL		0xdc
+#define A1_SD_EMMC_CLK_CTRL		0xe0
+
+#define A1_ANACTRL_FIXPLL_CTRL0		0x0
+
+#endif /* _ARCH_MESON_CLOCK_A1_H_ */
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 994b44ad7a..cdc9d6f76c 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -21,3 +21,11 @@ config CLK_MESON_G12A
 	help
 	  Enable clock support for the Amlogic G12A SoC family, such as
 	  the S905X/D2
+
+config CLK_MESON_A1
+	bool "Enable clock support for Amlogic A1"
+	depends on CLK && ARCH_MESON
+	default MESON_A1
+	help
+	  Enable clock support for the Amlogic A1 SoC family, such as
+	  the A113L
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index a486b13e9c..d975f07aab 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_MESON_AXG) +=3D axg.o
 obj-$(CONFIG_CLK_MESON_AXG) +=3D axg-ao.o
 obj-$(CONFIG_CLK_MESON_G12A) +=3D g12a.o
 obj-$(CONFIG_CLK_MESON_G12A) +=3D g12a-ao.o
+obj-$(CONFIG_CLK_MESON_A1) +=3D a1.o
diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
new file mode 100644
index 0000000000..3aec42f33b
--- /dev/null
+++ b/drivers/clk/meson/a1.c
@@ -0,0 +1,723 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ * Author: Igor Prusov <ivprusov@salutedevices.com>
+ */
+
+#include <common.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+#include <asm/arch/clock-a1.h>
+#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
+#include "clk_meson.h"
+
+/*
+ * This driver supports both PLL and peripherals clock sources.
+ * Following operations are supported:
+ * - calculating clock frequency on a limited tree
+ * - reading muxes and dividers
+ * - enabling/disabling gates without propagation
+ * - reparenting without rate propagation, only on muxes
+ * - setting rates with limited reparenting, only on dividers with mux par=
ent
+ */
+
+#define NR_CLKS				154
+#define NR_PLL_CLKS			11
+
+/* External clock IDs. Those should not overlap with regular IDs */
+#define EXTERNAL_XTAL			(NR_CLKS + 0)
+#define EXTERNAL_FCLK_DIV2		(NR_CLKS + 1)
+#define EXTERNAL_FCLK_DIV3		(NR_CLKS + 2)
+#define EXTERNAL_FCLK_DIV5		(NR_CLKS + 3)
+#define EXTERNAL_FCLK_DIV7		(NR_CLKS + 4)
+
+#define EXTERNAL_FIXPLL_IN		(NR_PLL_CLKS + 1)
+
+#define SET_PARM_VALUE(_priv, _parm, _val)				\
+	regmap_update_bits((_priv)->map, (_parm)->reg_off,		\
+			   SETPMASK((_parm)->width, (_parm)->shift),	\
+			   (_val) << (_parm)->shift)
+
+#define GET_PARM_VALUE(_priv, _parm)					\
+({									\
+	uint _reg;							\
+	regmap_read((_priv)->map, (_parm)->reg_off, &_reg);		\
+	PARM_GET((_parm)->width, (_parm)->shift, _reg);			\
+})
+
+struct meson_clk {
+	struct regmap *map;
+};
+
+/**
+ * enum meson_clk_type - The type of clock
+ * @MESON_CLK_ANY: Special value that matches any clock type
+ * @MESON_CLK_GATE: This clock is a gate
+ * @MESON_CLK_MUX: This clock is a multiplexer
+ * @MESON_CLK_DIV: This clock is a configurable divider
+ * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
+ * @MESON_CLK_EXTERNAL: This is an external clock from different clock pro=
vider
+ * @MESON_CLK_PLL: This is a PLL
+ */
+enum meson_clk_type {
+	MESON_CLK_ANY =3D 0,
+	MESON_CLK_GATE,
+	MESON_CLK_MUX,
+	MESON_CLK_DIV,
+	MESON_CLK_FIXED_DIV,
+	MESON_CLK_EXTERNAL,
+	MESON_CLK_PLL,
+};
+
+/**
+ * struct meson_clk_info - The parameters defining a clock
+ * @name: Name of the clock
+ * @parm: Register bits description for muxes and dividers
+ * @div: Fixed divider value
+ * @parents: List of parent clock IDs
+ * @type: Clock type
+ */
+struct meson_clk_info {
+	const char *name;
+	union {
+		const struct parm *parm;
+		u8 div;
+	};
+	const unsigned int *parents;
+	const enum meson_clk_type type;
+};
+
+/**
+ * struct meson_clk_data - Clocks supported by clock provider
+ * @num_clocks: Number of clocks
+ * @clocks: Array of clock descriptions
+ *
+ */
+struct meson_clk_data {
+	const u8 num_clocks;
+	const struct meson_clk_info **clocks;
+};
+
+/* Clock description initialization macros */
+
+/* A multiplexer */
+#define CLK_MUX(_name, _reg, _shift, _width, ...)			\
+	(&(struct meson_clk_info){					\
+		.parents =3D (const unsigned int[])__VA_ARGS__,		\
+		.parm =3D &(struct parm) {				\
+			.reg_off =3D (_reg),				\
+			.shift =3D (_shift),				\
+			.width =3D (_width),				\
+		},							\
+		.name =3D (_name),					\
+		.type =3D MESON_CLK_MUX,					\
+	})
+
+/* A divider with an integral divisor */
+#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
+	(&(struct meson_clk_info){					\
+		.parents =3D (const unsigned int[]) { (_parent) },	\
+		.parm =3D &(struct parm) {				\
+			.reg_off =3D (_reg),				\
+			.shift =3D (_shift),				\
+			.width =3D (_width),				\
+		},							\
+		.name =3D (_name),					\
+		.type =3D MESON_CLK_DIV,					\
+	})
+
+/* A fixed divider */
+#define CLK_DIV_FIXED(_name, _div, _parent)				\
+	(&(struct meson_clk_info){					\
+		.parents =3D (const unsigned int[]) { (_parent) },	\
+		.div =3D (_div),						\
+		.name =3D (_name),					\
+		.type =3D MESON_CLK_FIXED_DIV,				\
+	})
+
+/* An external clock */
+#define CLK_EXTERNAL(_name)						\
+	(&(struct meson_clk_info){					\
+		.name =3D (_name),					\
+		.parents =3D (const unsigned int[]) { -ENOENT },		\
+		.type =3D MESON_CLK_EXTERNAL,				\
+	})
+
+/* A clock gate */
+#define CLK_GATE(_name, _reg, _shift, _parent)				\
+	(&(struct meson_clk_info){					\
+		.parents =3D (const unsigned int[]) { (_parent) },	\
+		.parm =3D &(struct parm) {				\
+			.reg_off =3D (_reg),				\
+			.shift =3D (_shift),				\
+			.width =3D 1,					\
+		},							\
+		.name =3D (_name),					\
+		.type =3D MESON_CLK_GATE,					\
+	})
+
+/* A PLL clock */
+#define CLK_PLL(_name, _parent, ...)					\
+	(&(struct meson_clk_info){					\
+		.name =3D (_name),					\
+		.parents =3D (const unsigned int[]) { (_parent) },	\
+		.parm =3D (const struct parm[])__VA_ARGS__,		\
+		.type =3D MESON_CLK_PLL,					\
+	})
+
+/* A1 peripherals clocks */
+static const struct meson_clk_info *meson_clocks[] =3D {
+	[CLKID_SPIFC_SEL] =3D CLK_MUX("spifc_sel", A1_SPIFC_CLK_CTRL, 9, 2, {
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+	}),
+	[CLKID_SPIFC_SEL2] =3D CLK_MUX("spifc_sel2", A1_SPIFC_CLK_CTRL, 15, 1, {
+		CLKID_SPIFC_DIV,
+		EXTERNAL_XTAL,
+	}),
+	[CLKID_USB_BUS_SEL] =3D CLK_MUX("usb_bus_sel", A1_USB_BUSCLK_CTRL, 9, 2, =
{
+		-ENOENT,
+		CLKID_SYS,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV5,
+	}),
+	[CLKID_SYS] =3D CLK_MUX("sys", A1_SYS_CLK_CTRL0, 31, 1, {
+		CLKID_SYS_A,
+		CLKID_SYS_B,
+	}),
+	[CLKID_SYS_A_SEL] =3D CLK_MUX("sys_a_sel", A1_SYS_CLK_CTRL0, 10, 3, {
+		-ENOENT,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+	}),
+	[CLKID_SYS_B_SEL] =3D CLK_MUX("sys_b_sel", A1_SYS_CLK_CTRL0, 26, 3, {
+		-ENOENT,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+	}),
+
+	[CLKID_SPIFC_DIV] =3D CLK_DIV("spifc_div", A1_SPIFC_CLK_CTRL, 0, 8,
+		CLKID_SPIFC_SEL
+	),
+	[CLKID_USB_BUS_DIV] =3D CLK_DIV("usb_bus_div", A1_USB_BUSCLK_CTRL, 0, 8,
+		CLKID_USB_BUS_SEL
+	),
+	[CLKID_SYS_A_DIV] =3D CLK_DIV("sys_a_div", A1_SYS_CLK_CTRL0, 0, 10,
+		CLKID_SYS_A_SEL
+	),
+	[CLKID_SYS_B_DIV] =3D CLK_DIV("sys_b_div", A1_SYS_CLK_CTRL0, 16, 10,
+		CLKID_SYS_B_SEL
+	),
+
+	[CLKID_SPIFC] =3D CLK_GATE("spifc", A1_SPIFC_CLK_CTRL, 8,
+		CLKID_SPIFC_SEL2
+	),
+	[CLKID_USB_BUS] =3D CLK_GATE("usb_bus", A1_USB_BUSCLK_CTRL, 8,
+		CLKID_USB_BUS_DIV
+	),
+	[CLKID_SYS_A] =3D CLK_GATE("sys_a", A1_SYS_CLK_CTRL0, 13,
+		CLKID_SYS_A_DIV
+	),
+	[CLKID_SYS_B] =3D CLK_GATE("sys_b", A1_SYS_CLK_CTRL0, 29,
+		CLKID_SYS_B_DIV
+	),
+	[CLKID_FIXPLL_IN] =3D CLK_GATE("fixpll_in", A1_SYS_OSCIN_CTRL, 1,
+		EXTERNAL_XTAL
+	),
+	[CLKID_SARADC] =3D CLK_GATE("saradc", A1_SAR_ADC_CLK_CTR, 8,
+		-ENOENT
+	),
+	[CLKID_SARADC_EN] =3D CLK_GATE("saradc_en", A1_SYS_CLK_EN0, 13,
+		CLKID_SYS
+	),
+
+	[EXTERNAL_XTAL] =3D CLK_EXTERNAL("xtal"),
+	[EXTERNAL_FCLK_DIV2] =3D CLK_EXTERNAL("fclk_div2"),
+	[EXTERNAL_FCLK_DIV3] =3D CLK_EXTERNAL("fclk_div3"),
+	[EXTERNAL_FCLK_DIV5] =3D CLK_EXTERNAL("fclk_div5"),
+	[EXTERNAL_FCLK_DIV7] =3D CLK_EXTERNAL("fclk_div7"),
+};
+
+/* A1 PLL clocks */
+static const struct meson_clk_info *meson_pll_clocks[] =3D {
+	[EXTERNAL_FIXPLL_IN] =3D CLK_EXTERNAL("fixpll_in"),
+
+	[CLKID_FIXED_PLL_DCO] =3D CLK_PLL("fixed_pll_dco", EXTERNAL_FIXPLL_IN, {
+			{A1_ANACTRL_FIXPLL_CTRL0, 0, 8},
+			{A1_ANACTRL_FIXPLL_CTRL0, 10, 5},
+	}),
+
+	[CLKID_FCLK_DIV2_DIV] =3D CLK_DIV_FIXED("fclk_div2_div", 2,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV3_DIV] =3D CLK_DIV_FIXED("fclk_div3_div", 3,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV5_DIV] =3D CLK_DIV_FIXED("fclk_div5_div", 5,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV7_DIV] =3D CLK_DIV_FIXED("fclk_div7_div", 7,
+		CLKID_FIXED_PLL
+	),
+
+	[CLKID_FIXED_PLL] =3D CLK_GATE("fixed_pll", A1_ANACTRL_FIXPLL_CTRL0, 20,
+		CLKID_FIXED_PLL_DCO
+	),
+	[CLKID_FCLK_DIV2] =3D CLK_GATE("fclk_div2", A1_ANACTRL_FIXPLL_CTRL0, 21,
+		CLKID_FCLK_DIV2_DIV
+	),
+	[CLKID_FCLK_DIV3] =3D CLK_GATE("fclk_div3", A1_ANACTRL_FIXPLL_CTRL0, 22,
+		CLKID_FCLK_DIV3_DIV
+	),
+	[CLKID_FCLK_DIV5] =3D CLK_GATE("fclk_div5", A1_ANACTRL_FIXPLL_CTRL0, 23,
+		CLKID_FCLK_DIV5_DIV
+	),
+	[CLKID_FCLK_DIV7] =3D CLK_GATE("fclk_div7", A1_ANACTRL_FIXPLL_CTRL0, 24,
+		CLKID_FCLK_DIV7_DIV
+	),
+};
+
+static const struct meson_clk_info *meson_clk_get_info(struct clk *clk, ul=
ong id,
+						       enum meson_clk_type type)
+{
+	struct meson_clk_data *data;
+	const struct meson_clk_info *info;
+
+	data =3D (struct meson_clk_data *)dev_get_driver_data(clk->dev);
+	if (id >=3D data->num_clocks)
+		return ERR_PTR(-EINVAL);
+
+	info =3D data->clocks[id];
+	if (!info)
+		return ERR_PTR(-ENOENT);
+
+	if (type !=3D MESON_CLK_ANY && type !=3D info->type)
+		return ERR_PTR(-EINVAL);
+
+	return info;
+}
+
+static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
+
+static int meson_set_gate(struct clk *clk, bool on)
+{
+	struct meson_clk *priv =3D dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
+
+	info =3D meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	SET_PARM_VALUE(priv, info->parm, on);
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
+static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
+{
+	struct meson_clk *priv =3D dev_get_priv(clk->dev);
+	u16 n;
+	ulong rate;
+	const struct meson_clk_info *info;
+
+	info =3D meson_clk_get_info(clk, id, MESON_CLK_DIV);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	/* Actual divider value is (field value + 1), hence the increment */
+	n =3D GET_PARM_VALUE(priv, info->parm) + 1;
+
+	rate =3D meson_clk_get_rate_by_id(clk, info->parents[0]);
+
+	return rate / n;
+}
+
+static int meson_clk_get_parent(struct clk *clk, unsigned long id)
+{
+	uint reg =3D 0;
+	struct meson_clk *priv =3D dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info =3D meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	/* For muxes we read currently selected parent from register,
+	 * for other types there is always only one element in parents array.
+	 */
+	if (info->type =3D=3D MESON_CLK_MUX) {
+		reg =3D GET_PARM_VALUE(priv, info->parm);
+		if (IS_ERR_VALUE(reg))
+			return reg;
+	}
+
+	return info->parents[reg];
+}
+
+static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
+{
+	struct meson_clk *priv =3D dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+	const struct parm *pm, *pn;
+	ulong parent_rate_mhz;
+	unsigned int parent;
+	u16 n, m;
+
+	info =3D meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	pm =3D &info->parm[0];
+	pn =3D &info->parm[1];
+
+	n =3D GET_PARM_VALUE(priv, pn);
+	m =3D GET_PARM_VALUE(priv, pm);
+
+	if (n =3D=3D 0)
+		return -EINVAL;
+
+	parent =3D info->parents[0];
+	parent_rate_mhz =3D meson_clk_get_rate_by_id(clk, parent) / 1000000;
+
+	return parent_rate_mhz * m / n * 1000000;
+}
+
+static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
+{
+	ulong rate, parent;
+	const struct meson_clk_info *info;
+
+	if (IS_ERR_VALUE(id))
+		return id;
+
+	info =3D meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	switch (info->type) {
+	case MESON_CLK_PLL:
+		rate =3D meson_pll_get_rate(clk, id);
+		break;
+	case MESON_CLK_GATE:
+	case MESON_CLK_MUX:
+		parent =3D meson_clk_get_parent(clk, id);
+		rate =3D meson_clk_get_rate_by_id(clk, parent);
+		break;
+	case MESON_CLK_DIV:
+		rate =3D meson_div_get_rate(clk, id);
+		break;
+	case MESON_CLK_FIXED_DIV:
+		parent =3D meson_clk_get_parent(clk, id);
+		rate =3D meson_clk_get_rate_by_id(clk, parent) / info->div;
+		break;
+	case MESON_CLK_EXTERNAL: {
+		int ret;
+		struct clk external_clk;
+
+		ret =3D clk_get_by_name(clk->dev, info->name, &external_clk);
+		if (ret)
+			return ret;
+
+		rate =3D clk_get_rate(&external_clk);
+		break;
+	}
+	default:
+		rate =3D -EINVAL;
+		break;
+	}
+
+	return rate;
+}
+
+static ulong meson_clk_get_rate(struct clk *clk)
+{
+	return meson_clk_get_rate_by_id(clk, clk->id);
+}
+
+/* This implements rate propagation for dividers placed after multiplexer:
+ *  ---------|\
+ *     ..... | |---DIV--
+ *  ---------|/
+ */
+static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rat=
e)
+{
+	unsigned int i, best_div_val;
+	unsigned long best_delta, best_parent;
+	const struct meson_clk_info *div;
+	const struct meson_clk_info *mux;
+	struct meson_clk *priv =3D dev_get_priv(clk->dev);
+
+	div =3D meson_clk_get_info(clk, id, MESON_CLK_DIV);
+	if (IS_ERR(div))
+		return PTR_ERR(div);
+
+	mux =3D meson_clk_get_info(clk, div->parents[0], MESON_CLK_MUX);
+	if (IS_ERR(mux))
+		return PTR_ERR(mux);
+
+	best_parent =3D -EINVAL;
+	best_delta =3D ULONG_MAX;
+	for (i =3D 0; i < (1 << mux->parm->width); i++) {
+		unsigned long parent_rate, delta;
+		unsigned int div_val;
+
+		parent_rate =3D meson_clk_get_rate_by_id(clk, mux->parents[i]);
+		if (IS_ERR_VALUE(parent_rate))
+			continue;
+
+		/* If overflow, try to use max divider value */
+		div_val =3D min(DIV_ROUND_CLOSEST(parent_rate, rate),
+			      (1UL << div->parm->width));
+
+		delta =3D abs(rate - (parent_rate / div_val));
+		if (delta < best_delta) {
+			best_delta =3D delta;
+			best_div_val =3D div_val;
+			best_parent =3D i;
+		}
+	}
+
+	if (IS_ERR_VALUE(best_parent))
+		return best_parent;
+
+	SET_PARM_VALUE(priv, mux->parm, best_parent);
+	/* Divider is set to (field value + 1), hence the decrement */
+	SET_PARM_VALUE(priv, div->parm, best_div_val - 1);
+
+	return 0;
+}
+
+static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ul=
ong rate);
+
+static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong r=
ate)
+{
+	int i;
+	ulong ret =3D -EINVAL;
+	struct meson_clk *priv =3D dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info =3D meson_clk_get_info(clk, id, MESON_CLK_MUX);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	for (i =3D 0; i < (1 << info->parm->width); i++) {
+		ret =3D meson_clk_set_rate_by_id(clk, info->parents[i], rate);
+		if (!ret) {
+			SET_PARM_VALUE(priv, info->parm, i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/* Rate propagation is implemented for a subcection of a clock tree, that =
is
+ * required at boot stage.
+ */
+static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ul=
ong rate)
+{
+	switch (id) {
+	case CLKID_SPIFC_DIV:
+	case CLKID_USB_BUS_DIV:
+		return meson_composite_set_rate(clk, id, rate);
+	case CLKID_SPIFC:
+	case CLKID_USB_BUS: {
+		unsigned long parent =3D meson_clk_get_parent(clk, id);
+
+		return meson_clk_set_rate_by_id(clk, parent, rate);
+	}
+	case CLKID_SPIFC_SEL2:
+		return meson_mux_set_rate(clk, id, rate);
+	}
+
+	return -EINVAL;
+}
+
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return meson_clk_set_rate_by_id(clk, clk->id, rate);
+}
+
+static int meson_mux_set_parent_by_id(struct clk *clk, unsigned int parent=
_id)
+{
+	unsigned int i, parent_index;
+	struct meson_clk *priv =3D dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info =3D meson_clk_get_info(clk, clk->id, MESON_CLK_MUX);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	parent_index =3D -EINVAL;
+	for (i =3D 0; i < (1 << info->parm->width); i++) {
+		if (parent_id =3D=3D info->parents[i]) {
+			parent_index =3D i;
+			break;
+		}
+	}
+
+	if (IS_ERR_VALUE(parent_index))
+		return parent_index;
+
+	SET_PARM_VALUE(priv, info->parm, parent_index);
+
+	return 0;
+}
+
+static int meson_clk_set_parent(struct clk *clk, struct clk *parent_clk)
+{
+	return meson_mux_set_parent_by_id(clk, parent_clk->id);
+}
+
+static struct clk_ops meson_clk_ops =3D {
+	.disable	=3D meson_clk_disable,
+	.enable		=3D meson_clk_enable,
+	.get_rate	=3D meson_clk_get_rate,
+	.set_rate	=3D meson_clk_set_rate,
+	.set_parent	=3D meson_clk_set_parent,
+};
+
+static int meson_clk_probe(struct udevice *dev)
+{
+	struct meson_clk *priv =3D dev_get_priv(dev);
+
+	return regmap_init_mem(dev_ofnode(dev), &priv->map);
+}
+
+struct meson_clk_data meson_a1_peripherals_info =3D {
+	.clocks =3D meson_clocks,
+	.num_clocks =3D ARRAY_SIZE(meson_clocks),
+};
+
+struct meson_clk_data meson_a1_pll_info =3D {
+	.clocks =3D meson_pll_clocks,
+	.num_clocks =3D ARRAY_SIZE(meson_pll_clocks),
+};
+
+static const struct udevice_id meson_clk_ids[] =3D {
+	{
+		.compatible =3D "amlogic,a1-peripherals-clkc",
+		.data =3D (ulong)&meson_a1_peripherals_info,
+	},
+	{
+		.compatible =3D "amlogic,a1-pll-clkc",
+		.data =3D (ulong)&meson_a1_pll_info,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(meson_clk) =3D {
+	.name		=3D "meson-clk-a1",
+	.id		=3D UCLASS_CLK,
+	.of_match	=3D meson_clk_ids,
+	.priv_auto	=3D sizeof(struct meson_clk),
+	.ops		=3D &meson_clk_ops,
+	.probe		=3D meson_clk_probe,
+};
+
+static const char *meson_clk_get_name(struct clk *clk, int id)
+{
+	const struct meson_clk_info *info;
+
+	info =3D meson_clk_get_info(clk, id, MESON_CLK_ANY);
+
+	return IS_ERR(info) ? "unknown" : info->name;
+}
+
+static int meson_clk_dump(struct clk *clk)
+{
+	const struct meson_clk_info *info;
+	struct meson_clk *priv;
+	unsigned long rate;
+	char *state, frequency[80];
+	int parent;
+
+	priv =3D dev_get_priv(clk->dev);
+
+	info =3D meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
+	if (IS_ERR(info) || !info->name)
+		return -EINVAL;
+
+	rate =3D clk_get_rate(clk);
+	if (IS_ERR_VALUE(rate))
+		sprintf(frequency, "unknown");
+	else
+		sprintf(frequency, "%lu", rate);
+
+	if (info->type =3D=3D MESON_CLK_GATE)
+		state =3D GET_PARM_VALUE(priv, info->parm) ? "enabled" : "disabled";
+	else
+		state =3D "N/A";
+
+	parent =3D meson_clk_get_parent(clk, clk->id);
+	printf("%15s%20s%20s%15s\n",
+	       info->name,
+	       frequency,
+	       meson_clk_get_name(clk, parent),
+	       state);
+
+	return 0;
+}
+
+static int meson_clk_dump_dev(struct udevice *dev)
+{
+	int i;
+	struct meson_clk_data *data;
+	const char *sep =3D "--------------------";
+
+	printf("%s:\n", dev->name);
+	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
+	printf("%15s%20s%20s%15s\n", "clk", "frequency", "parent", "state");
+	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
+
+	data =3D (struct meson_clk_data *)dev_get_driver_data(dev);
+	for (i =3D 0; i < data->num_clocks; i++) {
+		meson_clk_dump(&(struct clk){
+			.dev =3D dev,
+			.id =3D i
+		});
+	}
+
+	return 0;
+}
+
+int soc_clk_dump(void)
+{
+	struct udevice *dev;
+	int i =3D 0;
+
+	while (!uclass_get_device(UCLASS_CLK, i++, &dev)) {
+		if (dev->driver =3D=3D DM_DRIVER_GET(meson_clk)) {
+			meson_clk_dump_dev(dev);
+			printf("\n");
+		}
+	}
+
+	return 0;
+}
--=20
2.34.1

