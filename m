Received: by mail-wr1-f65.google.com with SMTP id g3so2428382wrx.9
        for <u-boot-amlogic@groups.io>; Fri, 22 Mar 2019 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=5fKBIdpGc0GQ79zlEs28/2Xd35EUBdAHg9bYpAQQjAs=;
        b=zqUgUqw9NwF/GkW7FzJaQ7sMIeAeYM3WfRwj2Dypot9Sc0fFZVbVrQmTs0Y/42N3uD
         p+w82U0wpK/KjabfC87hhWoly/I1KGuY0PjMsFh5XCIsGmCrazNK2GIf+NsqUV9HHGbA
         Z5MMenPFmsCWXXfu/ddcIO+VzUjWaL99s72C3xRV2eL50yRQe8hkC5OluQJc9T3S7QRz
         hBNxZLNmV1gs9V2lL8CrGz3VjmmgdMNC0iNvnqChFtofoJt2AJKBGRHsUVLnDJQomlOX
         3ICnsJr8907GiPKJCqp1MDI7fYw+EgIs8s13Vn68igyhCXuWPPFtzZ+JhOmFLhDgdvvB
         8w5Q==
Return-Path: <glaroque@baylibre.com>
From: glaroque@baylibre.com
Subject: [PATCH] i2c: meson: add configurable divider factors
Date: Fri, 22 Mar 2019 14:49:32 +0100
Message-Id: <20190322134932.17103-1-glaroque@baylibre.com>
To: hs@denx.de, narmstrong@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

This patch add support for I2C controller in Meson-AXG SoC,
Due to the IP changes between I2C controller, we need to introduce
a compatible data to make the divider factor configurable.

backport from linux:
931b18e92cd0 ("2c: meson: add configurable divider factors")

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/i2c/meson_i2c.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/meson_i2c.c b/drivers/i2c/meson_i2c.c
index 7d06d95cf3..ee59bac123 100644
--- a/drivers/i2c/meson_i2c.c
+++ b/drivers/i2c/meson_i2c.c
@@ -41,7 +41,12 @@ struct i2c_regs {
 	u32 tok_rdata1;
 };
 
+struct meson_i2c_data {
+	unsigned char div_factor;
+};
+
 struct meson_i2c {
+	const struct meson_i2c_data *data;
 	struct clk clk;
 	struct i2c_regs *regs;
 	struct i2c_msg *msg;	/* Current I2C message */
@@ -229,7 +234,7 @@ static int meson_i2c_set_bus_speed(struct udevice *bus, unsigned int speed)
 	if (IS_ERR_VALUE(clk_rate))
 		return -EINVAL;
 
-	div = DIV_ROUND_UP(clk_rate, speed * 4);
+	div = DIV_ROUND_UP(clk_rate, speed * i2c->data->div_factor);
 
 	/* clock divider has 12 bits */
 	if (div >= (1 << 12)) {
@@ -253,6 +258,8 @@ static int meson_i2c_probe(struct udevice *bus)
 	struct meson_i2c *i2c = dev_get_priv(bus);
 	int ret;
 
+	i2c->data = (const struct meson_i2c_data *)dev_get_driver_data(bus);
+
 	ret = clk_get_by_index(bus, 0, &i2c->clk);
 	if (ret < 0)
 		return ret;
@@ -272,11 +279,24 @@ static const struct dm_i2c_ops meson_i2c_ops = {
 	.set_bus_speed = meson_i2c_set_bus_speed,
 };
 
+static const struct meson_i2c_data i2c_meson6_data = {
+	.div_factor = 4,
+};
+
+static const struct meson_i2c_data i2c_gxbb_data = {
+	.div_factor = 4,
+};
+
+static const struct meson_i2c_data i2c_axg_data = {
+	.div_factor = 3,
+};
+
 static const struct udevice_id meson_i2c_ids[] = {
-	{ .compatible = "amlogic,meson6-i2c" },
-	{ .compatible = "amlogic,meson-gx-i2c" },
-	{ .compatible = "amlogic,meson-gxbb-i2c" },
-	{ }
+	{.compatible = "amlogic,meson6-i2c", .data = (ulong)&i2c_meson6_data},
+	{.compatible = "amlogic,meson-gx-i2c", .data = (ulong)&i2c_gxbb_data},
+	{.compatible = "amlogic,meson-gxbb-i2c", .data = (ulong)&i2c_gxbb_data},
+	{.compatible = "amlogic,meson-axg-i2c", .data = (ulong)&i2c_axg_data},
+	{}
 };
 
 U_BOOT_DRIVER(i2c_meson) = {
-- 
2.17.1

