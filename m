Received: by mail-wm1-f68.google.com with SMTP id t5so13851583wmh.3
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RIzAo13YywZNh40XUqBespctRr8Rj2Cg5ANTYGSq4c=;
        b=IIwivXD8fiOEA/6xtKVaOURpebNc44rANCC5h4r396liKNIMWmJ9rXbJ+q+flhzxX0
         SpfIeQe3WV/LedfyNcxLLcQb5AJ9RdqGe2fa2lDPVM9/zAN9OPvVbLZrX+qRq0jTRvX7
         M4A0IVTmOzonDH84lehPGttusZeCZNb9oVxwHDURNVoxcGy3JmJlvNoHwsai9SDRnKxh
         d+ASdEx46ykcrbBsuvaV1sBQXjLHueHac49ta8hEqJ92tGN9G35pbBM7u7O3PmSY8cJD
         /51Dg42RUuA0kKzVAWR4FbS75SXTU15hxZ1hXbfYVt5g6Tdg7Ha18UjGTOXyHDmRrdoU
         zAVw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/4] pinctrl: meson: add common function to get pins name
Date: Tue,  4 Jun 2019 11:04:52 +0200
Message-Id: <20190604090454.18245-3-narmstrong@baylibre.com>
In-Reply-To: <20190604090454.18245-1-narmstrong@baylibre.com>
References: <20190604090454.18245-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

In order to support the "pinmux status" command, add common function
to get pins count and pin name.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 24 ++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 8735418c5b..eb40a84ed1 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -20,6 +20,8 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static const char *meson_pinctrl_dummy_name = "_dummy";
 
+static char pin_name[PINNAME_SIZE];
+
 int meson_pinctrl_get_groups_count(struct udevice *dev)
 {
 	struct meson_pinctrl *priv = dev_get_priv(dev);
@@ -38,6 +40,28 @@ const char *meson_pinctrl_get_group_name(struct udevice *dev,
 	return priv->data->groups[selector].name;
 }
 
+int meson_pinctrl_get_pins_count(struct udevice *dev)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+
+	return priv->data->num_pins;
+}
+
+const char *meson_pinctrl_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+
+	if (selector > priv->data->num_pins ||
+	    selector > priv->data->funcs[0].num_groups)
+		snprintf(pin_name, PINNAME_SIZE, "Error");
+	else
+		snprintf(pin_name, PINNAME_SIZE, "%s",
+			 priv->data->funcs[0].groups[selector]);
+
+	return pin_name;
+}
+
 int meson_pinmux_get_functions_count(struct udevice *dev)
 {
 	struct meson_pinctrl *priv = dev_get_priv(dev);
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index b3683e2073..0882dfe713 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -120,6 +120,9 @@ extern const struct pinctrl_ops meson_pinctrl_ops;
 int meson_pinctrl_get_groups_count(struct udevice *dev);
 const char *meson_pinctrl_get_group_name(struct udevice *dev,
 					 unsigned int selector);
+int meson_pinctrl_get_pins_count(struct udevice *dev);
+const char *meson_pinctrl_get_pin_name(struct udevice *dev,
+				       unsigned int selector);
 int meson_pinmux_get_functions_count(struct udevice *dev);
 const char *meson_pinmux_get_function_name(struct udevice *dev,
 					   unsigned int selector);
-- 
2.21.0

