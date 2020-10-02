Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.10170.1601629790016526698
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Oct 2020 02:09:50 -0700
Received: by mail-wm1-f68.google.com with SMTP id e2so926181wme.1
        for <u-boot-amlogic@groups.io>; Fri, 02 Oct 2020 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4qruB3j9/X2BgX7EGFI/5+xDEQlLJDdzc6MyNp/2Cc=;
        b=b0LtFYFWU9g4LSy6rILAcrdFZ+KBpGIWL/DUWWBsg7HwEH57kb+1U80MSCUXpFMBci
         TuRRG7X/0Fu9VQvPWQILhvkveUzFRV/Ayh8QmPhucu5UmkkF2M+j+nG+9FdrVpmhePE3
         vm1DZFaI/Jn+xf0twmZ0qqqsZROrmAo1G6xja2mt5JRFPiHUyQvon3C4mFdCAz5e6Sto
         iBUa5vWdEmUw5mVdj08JH0PnOj6yCU5j+1Yz8GZFCGF29Dc2zCOYX3QN42leAMGIbdaa
         jcW+RWA4bBzqbpuy93DyXpVfrlIDCM38BDRJt3AOQu1l+kTTtJ12JUm+n08ihpYcHWP9
         dIzQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] pwm: Add driver for Amlogic Meson PWM controller
Date: Fri,  2 Oct 2020 11:09:44 +0200
Message-Id: <20201002090944.1022765-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This adds the driver for the PWM controller found in the Amlogic SoCs.

This PWM is only a set of Gates, Dividers and Counters:
PWM output is achieved by calculating a clock that permits calculating
two periods (low and high). The counter then has to be set to switch after
N cycles for the first half period.
The hardware has no "polarity" setting. This driver reverses the period
cycles (the low length is inverted with the high length) for
PWM_POLARITY_INVERSED.

Disabling the PWM stops the output immediately (without waiting for the
current period to complete first).

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/Kconfig     |   7 +
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-meson.c | 528 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 536 insertions(+)
 create mode 100644 drivers/pwm/pwm-meson.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 61eb468cde..b3bd5c6bb7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -23,6 +23,13 @@ config PWM_IMX
 	help
 	  This PWM is found i.MX27 and later i.MX SoCs.
 
+config PWM_MESON
+	bool "Enable support for Amlogic Meson SoCs PWM"
+	depends on DM_PWM
+	help
+	  This PWM is found on Amlogic Meson SoCs. It supports a
+	  programmable period and duty cycle for 2 independant channels.
+
 config PWM_MTK
 	bool "Enable support for MediaTek PWM"
 	depends on DM_PWM
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0f4e84b04d..f21ae7d76e 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_DM_PWM)		+= pwm-uclass.o
 
 obj-$(CONFIG_PWM_EXYNOS)	+= exynos_pwm.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o pwm-imx-util.o
+obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MTK)		+= pwm-mtk.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= rk_pwm.o
 obj-$(CONFIG_PWM_SANDBOX)	+= sandbox_pwm.o
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
new file mode 100644
index 0000000000..cafb571f16
--- /dev/null
+++ b/drivers/pwm/pwm-meson.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2020 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (C) 2014 Amlogic, Inc.
+ *
+ * This PWM is only a set of Gates, Dividers and Counters:
+ * PWM output is achieved by calculating a clock that permits calculating
+ * two periods (low and high). The counter then has to be set to switch after
+ * N cycles for the first half period.
+ * The hardware has no "polarity" setting. This driver reverses the period
+ * cycles (the low length is inverted with the high length) for
+ * PWM_POLARITY_INVERSED.
+ * Setting the polarity will disable and re-enable the PWM output.
+ * Disabling the PWM stops the output immediately (without waiting for the
+ * current period to complete first).
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <div64.h>
+#include <dm.h>
+#include <pwm.h>
+#include <regmap.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+
+#define NSEC_PER_SEC 1000000000L
+
+#define REG_PWM_A		0x0
+#define REG_PWM_B		0x4
+#define PWM_LOW_MASK		GENMASK(15, 0)
+#define PWM_HIGH_MASK		GENMASK(31, 16)
+
+#define REG_MISC_AB		0x8
+#define MISC_B_CLK_EN		BIT(23)
+#define MISC_A_CLK_EN		BIT(15)
+#define MISC_CLK_DIV_MASK	0x7f
+#define MISC_B_CLK_DIV_SHIFT	16
+#define MISC_A_CLK_DIV_SHIFT	8
+#define MISC_B_CLK_SEL_SHIFT	6
+#define MISC_A_CLK_SEL_SHIFT	4
+#define MISC_CLK_SEL_MASK	0x3
+#define MISC_B_EN		BIT(1)
+#define MISC_A_EN		BIT(0)
+
+#define MESON_NUM_PWMS		2
+
+static struct meson_pwm_channel_data {
+	u8		reg_offset;
+	u8		clk_sel_shift;
+	u8		clk_div_shift;
+	u32		clk_en_mask;
+	u32		pwm_en_mask;
+} meson_pwm_per_channel_data[MESON_NUM_PWMS] = {
+	{
+		.reg_offset	= REG_PWM_A,
+		.clk_sel_shift	= MISC_A_CLK_SEL_SHIFT,
+		.clk_div_shift	= MISC_A_CLK_DIV_SHIFT,
+		.clk_en_mask	= MISC_A_CLK_EN,
+		.pwm_en_mask	= MISC_A_EN,
+	},
+	{
+		.reg_offset	= REG_PWM_B,
+		.clk_sel_shift	= MISC_B_CLK_SEL_SHIFT,
+		.clk_div_shift	= MISC_B_CLK_DIV_SHIFT,
+		.clk_en_mask	= MISC_B_CLK_EN,
+		.pwm_en_mask	= MISC_B_EN,
+	}
+};
+
+struct meson_pwm_channel {
+	unsigned int hi;
+	unsigned int lo;
+	u8 pre_div;
+	uint period_ns;
+	uint duty_ns;
+	bool configured;
+	bool enabled;
+	bool polarity;
+	struct clk clk;
+};
+
+struct meson_pwm_data {
+	const long *parent_ids;
+	unsigned int num_parents;
+};
+
+struct meson_pwm {
+	const struct meson_pwm_data *data;
+	struct meson_pwm_channel channels[MESON_NUM_PWMS];
+	void __iomem *base;
+};
+
+static int meson_pwm_set_enable(struct udevice *dev, uint channel, bool enable);
+
+static int meson_pwm_set_config(struct udevice *dev, uint channeln,
+				 uint period_ns, uint duty_ns)
+{
+	struct meson_pwm *priv = dev_get_priv(dev);
+	struct meson_pwm_channel *channel;
+	struct meson_pwm_channel_data *channel_data;
+	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned long fin_freq;
+
+	if (channeln >= MESON_NUM_PWMS)
+		return -ENODEV;
+
+	channel = &priv->channels[channeln];
+	channel_data = &meson_pwm_per_channel_data[channeln];
+
+	period = period_ns;
+	if (channel->polarity)
+		duty = period_ns - duty_ns;
+	else
+		duty = duty_ns;
+
+	debug("%s%d: polarity %s duty %d period %d\n", __func__, channeln,
+	      channel->polarity ? "true" : "false", duty, period);
+
+	fin_freq = clk_get_rate(&channel->clk);
+	if (fin_freq == 0) {
+		printf("%s%d: invalid source clock frequency\n", __func__, channeln);
+		return -EINVAL;
+	}
+
+	debug("%s%d: fin_freq: %lu Hz\n", __func__, channeln, fin_freq);
+
+	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
+	if (pre_div > MISC_CLK_DIV_MASK) {
+		printf("%s%d: unable to get period pre_div\n", __func__, channeln);
+		return -EINVAL;
+	}
+
+	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	if (cnt > 0xffff) {
+		printf("%s%d: unable to get period cnt\n", __func__, channeln);
+		return -EINVAL;
+	}
+
+	debug("%s%d: period=%u pre_div=%u cnt=%u\n", __func__, channeln, period, pre_div, cnt);
+
+	if (duty == period) {
+		channel->pre_div = pre_div;
+		channel->hi = cnt;
+		channel->lo = 0;
+	} else if (duty == 0) {
+		channel->pre_div = pre_div;
+		channel->hi = 0;
+		channel->lo = cnt;
+	} else {
+		/* Then check is we can have the duty with the same pre_div */
+		duty_cnt = div64_u64(fin_freq * (u64)duty, NSEC_PER_SEC * (pre_div + 1));
+		if (duty_cnt > 0xffff) {
+			printf("%s%d: unable to get duty cycle\n", __func__, channeln);
+			return -EINVAL;
+		}
+
+		debug("%s%d: duty=%u pre_div=%u duty_cnt=%u\n",
+		      __func__, channeln, duty, pre_div, duty_cnt);
+
+		channel->pre_div = pre_div;
+		channel->hi = duty_cnt;
+		channel->lo = cnt - duty_cnt;
+	}
+
+	channel->period_ns = period_ns;
+	channel->duty_ns = duty_ns;
+	channel->configured = true;
+
+	if (channel->enabled) {
+		meson_pwm_set_enable(dev, channeln, false);
+		meson_pwm_set_enable(dev, channeln, true);
+	}
+
+	return 0;
+}
+
+static int meson_pwm_set_enable(struct udevice *dev, uint channeln, bool enable)
+{
+	struct meson_pwm *priv = dev_get_priv(dev);
+	struct meson_pwm_channel *channel;
+	struct meson_pwm_channel_data *channel_data;
+	u32 value;
+
+	if (channeln >= MESON_NUM_PWMS)
+		return -ENODEV;
+
+	channel = &priv->channels[channeln];
+	channel_data = &meson_pwm_per_channel_data[channeln];
+
+	if (!channel->configured)
+		return -EINVAL;
+
+	if (enable) {
+		if (channel->enabled)
+			return 0;
+
+		value = readl(priv->base + REG_MISC_AB);
+		value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
+		value |= channel->pre_div << channel_data->clk_div_shift;
+		value |= channel_data->clk_en_mask;
+		writel(value, priv->base + REG_MISC_AB);
+
+		value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
+			FIELD_PREP(PWM_LOW_MASK, channel->lo);
+		writel(value, priv->base + channel_data->reg_offset);
+
+		value = readl(priv->base + REG_MISC_AB);
+		value |= channel_data->pwm_en_mask;
+		writel(value, priv->base + REG_MISC_AB);
+
+		debug("%s%d: enabled\n", __func__, channeln);
+		channel->enabled = true;
+	} else {
+		if (!channel->enabled)
+			return 0;
+
+		value = readl(priv->base + REG_MISC_AB);
+		value &= channel_data->pwm_en_mask;
+		writel(value, priv->base + REG_MISC_AB);
+
+		debug("%s%d: disabled\n", __func__, channeln);
+		channel->enabled = false;
+	}
+
+	return 0;
+}
+
+static int meson_pwm_set_invert(struct udevice *dev, uint channeln, bool polarity)
+{
+	struct meson_pwm *priv = dev_get_priv(dev);
+	struct meson_pwm_channel *channel;
+
+	if (channeln >= MESON_NUM_PWMS)
+		return -ENODEV;
+
+	debug("%s%d: set invert %s\n", __func__, channeln, polarity ? "true" : "false");
+
+	channel = &priv->channels[channeln];
+
+	channel->polarity = polarity;
+
+	if (!channel->configured)
+		return 0;
+
+	return meson_pwm_set_config(dev, channeln, channel->period_ns, channel->duty_ns);
+}
+
+static int meson_pwm_ofdata_to_platdata(struct udevice *dev)
+{
+	struct meson_pwm *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr_ptr(dev);
+
+	return 0;
+}
+
+static int meson_pwm_probe(struct udevice *dev)
+{
+	struct meson_pwm *priv = dev_get_priv(dev);
+	struct meson_pwm_data *data;
+	unsigned int i, p;
+	char name[255];
+	int err;
+	u32 reg;
+
+	data = (struct meson_pwm_data *)dev_get_driver_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	for (i = 0; i < MESON_NUM_PWMS; i++) {
+		struct meson_pwm_channel *channel = &priv->channels[i];
+		struct meson_pwm_channel_data *channel_data = &meson_pwm_per_channel_data[i];
+
+		snprintf(name, sizeof(name), "clkin%u", i);
+
+		err = clk_get_by_name(dev, name, &channel->clk);
+		/* If clock is not specified, use the already set clock */
+		if (err == -ENODATA) {
+			struct udevice *cdev;
+			struct uclass *uc;
+
+			/* Get parent from mux */
+			p = (readl(priv->base + REG_MISC_AB) >> channel_data->clk_sel_shift) &
+				MISC_CLK_SEL_MASK;
+
+			if (p >= data->num_parents) {
+				printf("%s%d: hw parent is invalid\n", __func__, i);
+				return -EINVAL;
+			}
+
+			if (data->parent_ids[p] == -1) {
+				/* Search for xtal clk */
+				const char *str;
+
+				err = uclass_get(UCLASS_CLK, &uc);
+				if (err)
+					return err;
+
+				uclass_foreach_dev(cdev, uc) {
+					if (strcmp(cdev->driver->name, "fixed_rate_clock"))
+						continue;
+
+					str = ofnode_read_string(cdev->node, "clock-output-names");
+					if (!str)
+						continue;
+
+					if (!strcmp(str, "xtal")) {
+						err = uclass_get_device_by_ofnode(UCLASS_CLK,
+										  cdev->node,
+										  &cdev);
+						if (err) {
+							printf("%s%d: Failed to get xtal clk\n", __func__, i);
+							return err;
+						}
+
+						break;
+					}
+				}
+
+				if (!cdev) {
+					printf("%s%d: Failed to find xtal clk device\n", __func__, i);
+					return -EINVAL;
+				}
+
+				channel->clk.dev = cdev;
+				channel->clk.id = 0;
+				channel->clk.data = 0;
+			} else {
+				/* Look for parent clock */
+				err = uclass_get(UCLASS_CLK, &uc);
+				if (err)
+					return err;
+
+				uclass_foreach_dev(cdev, uc) {
+					if (strstr(cdev->driver->name, "meson_clk"))
+						break;
+				}
+
+				if (!cdev) {
+					printf("%s%d: Failed to find clk device\n", __func__, i);
+					return -EINVAL;
+				}
+
+				err = uclass_get_device_by_ofnode(UCLASS_CLK, cdev->node, &cdev);
+				if (err) {
+					printf("%s%d: Failed to get clk controller\n", __func__, i);
+					return err;
+				}
+
+				channel->clk.dev = cdev;
+				channel->clk.id = data->parent_ids[p];
+				channel->clk.data = 0;
+			}
+
+			/* We have our source clock, do not alter HW clock mux */
+			continue;
+		} else
+			return err;
+
+		/* Get id in list */
+		for (p = 0 ; p < data->num_parents ; ++p) {
+			if (!strcmp(channel->clk.dev->driver->name, "fixed_rate_clock")) {
+				if (data->parent_ids[p] == -1)
+					break;
+			} else {
+				if (data->parent_ids[p] == channel->clk.id)
+					break;
+			}
+		}
+
+		/* Invalid clock ID */
+		if (p == data->num_parents) {
+			printf("%s%d: source clock is invalid\n", __func__, i);
+			return -EINVAL;
+		}
+
+		/* switch parent in mux */
+		reg = readl(priv->base + REG_MISC_AB);
+
+		debug("%s%d: switching parent %d to %d\n", __func__, i,
+		      (reg >> channel_data->clk_sel_shift) & MISC_CLK_SEL_MASK, p);
+
+		reg &= MISC_CLK_SEL_MASK << channel_data->clk_sel_shift;
+		reg |= (p & MISC_CLK_SEL_MASK) << channel_data->clk_sel_shift;
+		writel(reg, priv->base + REG_MISC_AB);
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops meson_pwm_ops = {
+	.set_config	= meson_pwm_set_config,
+	.set_enable	= meson_pwm_set_enable,
+	.set_invert	= meson_pwm_set_invert,
+};
+
+#define XTAL 			-1
+
+/* Local clock ids aliases to avoid define conflicts */
+#define GXBB_CLKID_HDMI_PLL		2
+#define GXBB_CLKID_FCLK_DIV3		5
+#define GXBB_CLKID_FCLK_DIV4		6
+#define GXBB_CLKID_CLK81		12
+
+static const long pwm_gxbb_parent_ids[] = {
+	XTAL, GXBB_CLKID_HDMI_PLL, GXBB_CLKID_FCLK_DIV4, GXBB_CLKID_FCLK_DIV3
+};
+
+static const struct meson_pwm_data pwm_gxbb_data = {
+	.parent_ids = pwm_gxbb_parent_ids,
+	.num_parents = ARRAY_SIZE(pwm_gxbb_parent_ids),
+};
+
+/*
+ * Only the 2 first inputs of the GXBB AO PWMs are valid
+ * The last 2 are grounded
+ */
+static const long pwm_gxbb_ao_parent_ids[] = {
+	XTAL, GXBB_CLKID_CLK81
+};
+
+static const struct meson_pwm_data pwm_gxbb_ao_data = {
+	.parent_ids = pwm_gxbb_ao_parent_ids,
+	.num_parents = ARRAY_SIZE(pwm_gxbb_ao_parent_ids),
+};
+
+/* Local clock ids aliases to avoid define conflicts */
+#define AXG_CLKID_FCLK_DIV3		3
+#define AXG_CLKID_FCLK_DIV4		4
+#define AXG_CLKID_FCLK_DIV5		5
+#define AXG_CLKID_CLK81			10
+
+static const long pwm_axg_ee_parent_ids[] = {
+	XTAL, AXG_CLKID_FCLK_DIV5, AXG_CLKID_FCLK_DIV4, AXG_CLKID_FCLK_DIV3
+};
+
+static const struct meson_pwm_data pwm_axg_ee_data = {
+	.parent_ids = pwm_axg_ee_parent_ids,
+	.num_parents = ARRAY_SIZE(pwm_axg_ee_parent_ids),
+};
+
+static const long pwm_axg_ao_parent_ids[] = {
+	AXG_CLKID_CLK81, XTAL, AXG_CLKID_FCLK_DIV4, AXG_CLKID_FCLK_DIV5
+};
+
+static const struct meson_pwm_data pwm_axg_ao_data = {
+	.parent_ids = pwm_axg_ao_parent_ids,
+	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_ids),
+};
+
+/* Local clock ids aliases to avoid define conflicts */
+#define G12A_CLKID_FCLK_DIV3		3
+#define G12A_CLKID_FCLK_DIV4		4
+#define G12A_CLKID_FCLK_DIV5		5
+#define G12A_CLKID_CLK81		10
+#define G12A_CLKID_HDMI_PLL		128
+
+static const long pwm_g12a_ao_ab_parent_ids[] = {
+	XTAL, G12A_CLKID_CLK81, G12A_CLKID_FCLK_DIV4, G12A_CLKID_FCLK_DIV5
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
+	.parent_ids = pwm_g12a_ao_ab_parent_ids,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ao_ab_parent_ids),
+};
+
+static const long pwm_g12a_ao_cd_parent_ids[] = {
+	XTAL, G12A_CLKID_CLK81,
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
+	.parent_ids = pwm_g12a_ao_cd_parent_ids,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_ids),
+};
+
+static const long pwm_g12a_ee_parent_ids[] = {
+	XTAL, G12A_CLKID_HDMI_PLL, G12A_CLKID_FCLK_DIV4, G12A_CLKID_FCLK_DIV3
+};
+
+static const struct meson_pwm_data pwm_g12a_ee_data = {
+	.parent_ids = pwm_g12a_ee_parent_ids,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_ids),
+};
+
+static const struct udevice_id meson_pwm_ids[] = {
+	{
+		.compatible = "amlogic,meson-gxbb-pwm",
+		.data = (ulong)&pwm_gxbb_data
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-ao-pwm",
+		.data = (ulong)&pwm_gxbb_ao_data
+	},
+	{
+		.compatible = "amlogic,meson-axg-ee-pwm",
+		.data = (ulong)&pwm_axg_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-axg-ao-pwm",
+		.data = (ulong)&pwm_axg_ao_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ee-pwm",
+		.data = (ulong)&pwm_g12a_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
+		.data = (ulong)&pwm_g12a_ao_ab_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
+		.data = (ulong)&pwm_g12a_ao_cd_data
+	},
+};
+
+U_BOOT_DRIVER(meson_pwm) = {
+	.name	= "meson_pwm",
+	.id	= UCLASS_PWM,
+	.of_match = meson_pwm_ids,
+	.ops	= &meson_pwm_ops,
+	.ofdata_to_platdata = meson_pwm_ofdata_to_platdata,
+	.probe	 = meson_pwm_probe,
+	.priv_auto_alloc_size	= sizeof(struct meson_pwm),
+};
-- 
2.25.1

