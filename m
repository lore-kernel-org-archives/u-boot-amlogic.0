Received: by mail-wm1-f66.google.com with SMTP id 22so5619629wmg.2
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/rQdCcDxQjjUs5gJj65atklmtg5YSToeo6WpZGpdVM=;
        b=hz8CIObd9lqE2wg2MDLI0dmORsjOQnN3Fs/GGzo5aL3X9EmFxhlv0ncnFaAga3Dona
         jFN1dPoiOpqONATVA03ytHkZqig/n/mtKgl1O8MYGUOt33kGfXzV8HNHcpetU5/eKk6m
         aubPolOpbV19RLeRe/LZx7YAnz09ZIWBbkX8kBhPoTI6CWju0oBcF+Bt3eNozbTvRzx7
         6fr4N1SJwlwkkNmnOz9X8o5xDHYlG1M+8Ftgl0tPanUde6oYzw50nZx1yuTshXxAFrJt
         2A85YzUh+2q7JXkEBxAAeVDBWKbQ+gMXMzEaYwQoQsnQYnSHukrS4uMecElX5uVxquCn
         2q7w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/4] pinctrl: meson-axg: add support for getting pinmux status
Date: Tue,  4 Jun 2019 11:04:54 +0200
Message-Id: <20190604090454.18245-5-narmstrong@baylibre.com>
In-Reply-To: <20190604090454.18245-1-narmstrong@baylibre.com>
References: <20190604090454.18245-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

In order to support the "pinmux status" command, use the common functions
to get the pins count and names, and add the AXG specific function to get
the current function from registers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
index f23b188f2f..10b070ea06 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
@@ -93,6 +93,51 @@ static int meson_axg_pinmux_group_set(struct udevice *dev,
 	return 0;
 }
 
+static int meson_axg_pinmux_get(struct udevice *dev, unsigned int selector,
+				char *buf, int size)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+	struct meson_pmx_axg_data *pmx_data;
+	struct meson_pmx_group *group;
+	struct meson_pmx_bank *bank;
+	unsigned int offset;
+	unsigned int func;
+	unsigned int reg;
+	int ret, i, j;
+
+	selector += priv->data->pin_base;
+
+	ret = meson_axg_pmx_get_bank(dev, selector, &bank);
+	if (ret) {
+		snprintf(buf, size, "Unhandled");
+		return 0;
+	}
+
+	meson_axg_pmx_calc_reg_and_offset(bank, selector, &reg, &offset);
+
+	func = (readl(priv->reg_mux + (reg << 2)) >> offset) & 0xf;
+
+	for (i = 0; i < priv->data->num_groups; i++) {
+		group = &priv->data->groups[i];
+		pmx_data = (struct meson_pmx_axg_data *)group->data;
+
+		if (pmx_data->func != func)
+			continue;
+
+		for (j = 0; j < group->num_pins; j++) {
+			if (group->pins[j] == selector) {
+				snprintf(buf, size, "%s (%x)",
+					 group->name, func);
+				return 0;
+			}
+		}
+	}
+
+	snprintf(buf, size, "Unknown (%x)", func);
+
+	return 0;
+}
+
 const struct pinconf_param meson_axg_pinconf_params[] = {
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 1 },
@@ -110,6 +155,9 @@ const struct pinctrl_ops meson_axg_pinctrl_ops = {
 	.pinconf_num_params = ARRAY_SIZE(meson_axg_pinconf_params),
 	.pinconf_set = meson_pinconf_set,
 	.pinconf_group_set = meson_pinconf_group_set,
+	.get_pin_name = meson_pinctrl_get_pin_name,
+	.get_pins_count = meson_pinctrl_get_pins_count,
+	.get_pin_muxing	= meson_axg_pinmux_get,
 };
 
 static int meson_axg_gpio_request(struct udevice *dev,
-- 
2.21.0

