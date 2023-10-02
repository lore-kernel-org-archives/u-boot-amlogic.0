Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.87801.1696265949151801231
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Oct 2023 09:59:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 925D0120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696265946;
	bh=h09tsDHxJ4Yq7zZBJG7akE8egNmXf1eriOetPOLWm0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=UxdE/FTHkTq/IZzb6AAx9s2R8yrd9BjwQU28l/QN+Qh3a7QjSQ9kYcgDre/4PNqw6
	 LZTt8Oa3a17w8y5kTbm1o010P5I5UhrM4NqIrFtYkRkTv23LTmPf/4fDgMF6mZAxBa
	 RnXG8mabUFJMlFIUtNjl6yHh+vNnmTK1mzpoNJv8Z8n1elqQILKwn77cxq0G+75eWJ
	 duk4NoNvfKvfS5mZbUQU7NBv9wZuWRfHTKmattQ4CpWsoU3blThULF7pNVtw4HO4+7
	 3zfm8DxXdkv0Qs5Rd1slt0CLTfCWisEG+loB+jTcFkFmdzRL7s7g5yBF+XmnyNXliG
	 GEKj5bh+7PhNg==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 2/8] reset: add support for Amlogic A1 family
Date: Mon, 2 Oct 2023 19:58:46 +0300
Message-ID: <20231002165857.19512-3-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-1-avromanov@salutedevices.com>
References: <20231002165857.19512-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

This patch adds reset support for the Amlogic A1 family.
We add the structure meson_reset_drvdata, which in the future
will allow this driver to be used for other families by declaring
only the correct parameters reg_count and level_offset.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/reset/reset-meson.c | 42 +++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 64bc696f13..9d0c8b354f 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -13,18 +13,26 @@
 #include <reset-uclass.h>
 #include <regmap.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
=20
-#define REG_COUNT	8
 #define BITS_PER_REG	32
-#define LEVEL_OFFSET	0x7c
+
+struct meson_reset_drvdata {
+	unsigned int reg_count;
+	unsigned int level_offset;
+};
=20
 struct meson_reset_priv {
 	struct regmap *regmap;
+	struct meson_reset_drvdata *drvdata;
 };
=20
 static int meson_reset_request(struct reset_ctl *reset_ctl)
 {
-	if (reset_ctl->id > (REG_COUNT * BITS_PER_REG))
+	struct meson_reset_priv *priv =3D dev_get_priv(reset_ctl->dev);
+	struct meson_reset_drvdata *data =3D priv->drvdata;
+
+	if (reset_ctl->id > (data->reg_count * BITS_PER_REG))
 		return -EINVAL;
=20
 	return 0;
@@ -33,9 +41,10 @@ static int meson_reset_request(struct reset_ctl *reset_c=
tl)
 static int meson_reset_level(struct reset_ctl *reset_ctl, bool assert)
 {
 	struct meson_reset_priv *priv =3D dev_get_priv(reset_ctl->dev);
+	struct meson_reset_drvdata *data =3D priv->drvdata;
 	uint bank =3D reset_ctl->id / BITS_PER_REG;
 	uint offset =3D reset_ctl->id % BITS_PER_REG;
-	uint reg_offset =3D LEVEL_OFFSET + (bank << 2);
+	uint reg_offset =3D data->level_offset + (bank << 2);
 	uint val;
=20
 	regmap_read(priv->regmap, reg_offset, &val);
@@ -64,15 +73,36 @@ struct reset_ops meson_reset_ops =3D {
 	.rst_deassert =3D meson_reset_deassert,
 };
=20
+static const struct meson_reset_drvdata meson_gxbb_data =3D {
+	.reg_count =3D 8,
+	.level_offset =3D 0x7c,
+};
+
+static const struct meson_reset_drvdata meson_a1_data =3D {
+	.reg_count =3D 3,
+	.level_offset =3D 0x40,
+};
+
 static const struct udevice_id meson_reset_ids[] =3D {
-	{ .compatible =3D "amlogic,meson-gxbb-reset" },
-	{ .compatible =3D "amlogic,meson-axg-reset" },
+	{
+		.compatible =3D "amlogic,meson-gxbb-reset",
+		.data =3D (ulong)&meson_gxbb_data,
+	},
+	{
+		.compatible =3D "amlogic,meson-axg-reset",
+		.data =3D (ulong)&meson_gxbb_data,
+	},
+	{
+		.compatible =3D "amlogic,meson-a1-reset",
+		.data =3D (ulong)&meson_a1_data,
+	},
 	{ }
 };
=20
 static int meson_reset_probe(struct udevice *dev)
 {
 	struct meson_reset_priv *priv =3D dev_get_priv(dev);
+	priv->drvdata =3D (struct meson_reset_drvdata *)dev_get_driver_data(dev);
=20
 	return regmap_init_mem(dev_ofnode(dev), &priv->regmap);
 }
--=20
2.25.1

