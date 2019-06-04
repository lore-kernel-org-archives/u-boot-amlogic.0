Received: by mail-wr1-f66.google.com with SMTP id e16so7239694wrn.1
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eBfI+VIespU2MmD95SxhdwEYDD/42AAk9VQNWQ6gldk=;
        b=qzxtl3tIQi1UoYt0EInaejq6fuQhdG2IpoV03ooxKavhv2pxd0j+PfXZnLobJfJroh
         KnkKAiXQ0PUInw7gFvgwWlyQsGDTa7jLUijCy3oWqic4QQVZCKyVtpdVJlLRVJFmXOOQ
         4NoNKDmyROrB35GoDAIfhb648vb8BS5/gLuO0G/jJ5d6t8w+pjQIMzAjXqSUX1LmMZMq
         IIHiYXigCG7zOtT1xwttzJjU2zB/s/4yXBSfyVJQ2l5Oc7ft3Fh9rdyyN+mQvu78ZQCt
         0Kw9fiT1dqP07XCC3Pp2Y7Hn1cAIQavs/y+k7rU3LVEX+M0sqgh2Y9c2Gi11F2Z9Vo8Z
         0B+w==
Return-Path: <glaroque@baylibre.com>
From: "Guillaume La Roque" <glaroque@baylibre.com>
Subject: [PATCH 2/3] pinctrl: meson: add support of drive-strength-microamp
Date: Tue,  4 Jun 2019 13:53:07 +0200
Message-Id: <20190604115308.26510-3-glaroque@baylibre.com>
In-Reply-To: <20190604115308.26510-1-glaroque@baylibre.com>
References: <20190604115308.26510-1-glaroque@baylibre.com>
To: narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

drive-strength-microamp is a new feature needed for G12A SoC.
the default DS setting after boot is usually 500uA and it is not enough for
many functions. We need to be able to set the drive strength to reliably
enable things like MMC, I2C, etc ...

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |  1 +
 drivers/pinctrl/meson/pinctrl-meson.c         | 46 ++++++++++++++++++-
 drivers/pinctrl/meson/pinctrl-meson.h         | 43 +++++++++++------
 3 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
index f23b188f2f..6af404ed68 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
@@ -97,6 +97,7 @@ const struct pinconf_param meson_axg_pinconf_params[] = {
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 1 },
 	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 1 },
+	{ "drive-strength-microamp", PIN_CONFIG_DRIVE_STRENGTH_UA, 0 },
 };
 
 const struct pinctrl_ops meson_axg_pinctrl_ops = {
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 8735418c5b..432aaed02e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -198,6 +198,47 @@ static int meson_pinconf_bias_set(struct udevice *dev, unsigned int pin,
 	return 0;
 }
 
+static int meson_pinconf_drive_strength_set(struct udevice *dev,
+					    unsigned int pin,
+					    unsigned int drive_strength_ua)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+	unsigned int offset = pin - priv->data->pin_base;
+	unsigned int reg, bit;
+	unsigned int ds_val;
+	int ret;
+
+	if (!priv->reg_ds) {
+		dev_err(dev, "drive-strength-microamp not supported\n");
+		return -ENOTSUPP;
+	}
+
+	ret = meson_gpio_calc_reg_and_bit(dev, offset, REG_DS, &reg, &bit);
+	if (ret)
+		return ret;
+
+	bit = bit << 1;
+
+	if (drive_strength_ua <= 500) {
+		ds_val = MESON_PINCONF_DRV_500UA;
+	} else if (drive_strength_ua <= 2500) {
+		ds_val = MESON_PINCONF_DRV_2500UA;
+	} else if (drive_strength_ua <= 3000) {
+		ds_val = MESON_PINCONF_DRV_3000UA;
+	} else if (drive_strength_ua <= 4000) {
+		ds_val = MESON_PINCONF_DRV_4000UA;
+	} else {
+		dev_warn(dev,
+			 "pin %u: invalid drive-strength-microamp : %d , default to 4mA\n",
+			 pin, drive_strength_ua);
+		ds_val = MESON_PINCONF_DRV_4000UA;
+	}
+
+	clrsetbits_le32(priv->reg_ds + reg, 0x3 << bit, ds_val << bit);
+
+	return 0;
+}
+
 int meson_pinconf_set(struct udevice *dev, unsigned int pin,
 		      unsigned int param, unsigned int arg)
 {
@@ -209,7 +251,9 @@ int meson_pinconf_set(struct udevice *dev, unsigned int pin,
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 		ret = meson_pinconf_bias_set(dev, pin, param);
 		break;
-
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		ret = meson_pinconf_drive_strength_set(dev, pin, arg);
+		break;
 	default:
 		dev_err(dev, "unsupported configuration parameter %u\n", param);
 		return -EINVAL;
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index b3683e2073..9261910948 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -58,6 +58,16 @@ struct meson_reg_desc {
 	unsigned int bit;
 };
 
+/**
+ * enum meson_pinconf_drv - value of drive-strength supported
+ */
+enum meson_pinconf_drv {
+	MESON_PINCONF_DRV_500UA,
+	MESON_PINCONF_DRV_2500UA,
+	MESON_PINCONF_DRV_3000UA,
+	MESON_PINCONF_DRV_4000UA,
+};
+
 /**
  * enum meson_reg_type - type of registers encoded in @meson_reg_desc
  */
@@ -67,6 +78,7 @@ enum meson_reg_type {
 	REG_DIR,
 	REG_OUT,
 	REG_IN,
+	REG_DS,
 	NUM_REG,
 };
 
@@ -99,19 +111,24 @@ struct meson_bank {
 		.num_groups = ARRAY_SIZE(fn ## _groups),		\
 	}
 
-#define BANK(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib)		\
-	{								\
-		.name	= n,						\
-		.first	= f,						\
-		.last	= l,						\
-		.regs	= {						\
-			[REG_PULLEN]	= { per, peb },			\
-			[REG_PULL]	= { pr, pb },			\
-			[REG_DIR]	= { dr, db },			\
-			[REG_OUT]	= { or, ob },			\
-			[REG_IN]	= { ir, ib },			\
-		},							\
-	 }
+#define BANK_DS(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib, \
+		dsr, dsb)                                                  \
+	{                                                                  \
+		.name = n,                                                 \
+		.first = f,                                                \
+		.last = l,                                                 \
+		.regs = {                                                  \
+		    [REG_PULLEN] = {per, peb},                             \
+		    [REG_PULL] = {pr, pb},                                 \
+		    [REG_DIR] = {dr, db},                                  \
+		    [REG_OUT] = { or, ob},                                 \
+		    [REG_IN] = {ir, ib},                                   \
+		    [REG_DS] = {dsr, dsb},                                 \
+		},                                                         \
+	}
+
+#define BANK(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib) \
+	BANK_DS(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib, 0, 0)
 
 #define MESON_PIN(x, b) PINCTRL_PIN(PIN(x, b), #x)
 
-- 
2.17.1

