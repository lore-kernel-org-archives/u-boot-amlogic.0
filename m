Received: by mail-wr1-f65.google.com with SMTP id e16so6683653wrn.1
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+ACzGrZxHx5KU5iohsvFGgiYh65CYX5L3K0boU/WpY=;
        b=dQFBNDmWQL9H5JaXRz6/+lYOlYj29uf9u9uNHzWRer3/ih5rIJpkZ3ldp1aFIJlOHF
         1xsVTTfvNvTyqWld3xA+MFi3B7UXZuo7msWlP8VCBJOmHtQ3+C4IWNUQaVvFdec6CIBE
         JKI4avhMAf2VA9GtBd15pX6J1dO9xcBfJH9thtYWO+eed5JzX7DieHd7Iyj3TC1y+6Ub
         UX/iORj7oDWlNDEaJjRaJRusfchp3HE/0rk0VnfvTJuYO3FT/wRhnOIUIllWuoWnlGQF
         E5PgUTvw/YdYDWlfA55zyFpK457bMXt9iTCviPBl9XTASecLom/SyUHqCvRYkhXsY4Gd
         BCPw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/4] pinctrl: meson-gx: add support for getting pinmux status
Date: Tue,  4 Jun 2019 11:04:53 +0200
Message-Id: <20190604090454.18245-4-narmstrong@baylibre.com>
In-Reply-To: <20190604090454.18245-1-narmstrong@baylibre.com>
References: <20190604090454.18245-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

In order to support the "pinmux status" command, use the common functions
to get the pins count and names, and add the GX specific function to get
the current function from registers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c | 44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
index cf72576b6c..b37b517fe5 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
@@ -72,6 +72,47 @@ static int meson_gx_pinmux_group_set(struct udevice *dev,
 	return 0;
 }
 
+static int meson_gx_pinmux_get(struct udevice *dev,
+				      unsigned int selector,
+				      char *buf, int size)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+	struct meson_pmx_group *group;
+	struct meson_gx_pmx_data *pmx_data;
+	void __iomem *addr;
+	int i, j, pos = 0;
+	unsigned int pin;
+	u32 reg;
+
+	pin = selector + priv->data->pin_base;
+
+	for (i = 0; i < priv->data->num_groups; i++) {
+		group = &priv->data->groups[i];
+		pmx_data = (struct meson_gx_pmx_data *)group->data;
+		if (pmx_data->is_gpio)
+			continue;
+
+		for (j = 0; j < group->num_pins; j++) {
+			if (group->pins[j] == pin) {
+				/* We have found a group using the pin */
+				addr = priv->reg_mux + pmx_data->reg * 4;
+				reg = readl(addr) & BIT(pmx_data->bit);
+				if (reg) {
+					pos += snprintf(buf + pos, size - pos,
+							"%s ", group->name) - 1;
+					return 0;
+				}
+			}
+		}
+	}
+
+	/* Fallback, must be used as GPIO */
+	snprintf(buf, size, "%s or Unknown",
+		 priv->data->groups[selector].name);
+
+	return 0;
+}
+
 const struct pinconf_param meson_gx_pinconf_params[] = {
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 1 },
@@ -89,6 +130,9 @@ const struct pinctrl_ops meson_gx_pinctrl_ops = {
 	.pinconf_num_params = ARRAY_SIZE(meson_gx_pinconf_params),
 	.pinconf_set = meson_pinconf_set,
 	.pinconf_group_set = meson_pinconf_group_set,
+	.get_pin_name = meson_pinctrl_get_pin_name,
+	.get_pins_count = meson_pinctrl_get_pins_count,
+	.get_pin_muxing	= meson_gx_pinmux_get,
 };
 
 static const struct dm_gpio_ops meson_gx_gpio_ops = {
-- 
2.21.0

