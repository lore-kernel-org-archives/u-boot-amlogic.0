Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.6365.1697097521418920037
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Oct 2023 00:58:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A5E8A100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697097517;
	bh=sy4N0ZTghRBI2B/EdK50f4TLPJgcw3YLEzckxMhdD2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NlDZG6Jia2gTZctWEhAXt74Kf1amRJgOZH5aVEI2gxXG6C5pNxN7/qZiN5Xz/ynKP
	 x8dwQ7ZyAec/I4QPylJ2c3t4HJGLm9zf5fsomLdYJcGMAmbFPoR/J6lRicFHYru41p
	 TEj8mC6dxRiMTAMga7lexUc6F9RgJq8AXK3jxSUm7nblo40osRSqp7mq1WOUpKdQ62
	 ixV3l+0vwZFyUM/+xeK/JzCMhqOYfCOrJgWzCBLWWzf0I4X0Jx2g+AY4wHoD3L/vi+
	 +crDpOod+E7bHM7c/PUM0fDxxwda/zT2AoE6OSIZCCC7A9UmV7rdLiI6mjzrROvR8D
	 pU7aVx08GIxpA==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 1/1] drivers: rng: add support for Meson S4
Date: Thu, 12 Oct 2023 10:58:25 +0300
Message-ID: <20231012075828.22685-2-avromanov@salutedevices.com>
In-Reply-To: <20231012075828.22685-1-avromanov@salutedevices.com>
References: <20231012075828.22685-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sughosh.ganu@linaro.org, xypron.glpk@gmx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

For some Amlogic SOC's, mechanism to obtain random number
has been changed. For example, S4 now uses status bit waiting algo.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/rng/meson-rng.c | 72 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
index e0a1e8c7e0..fd2988e91b 100644
--- a/drivers/rng/meson-rng.c
+++ b/drivers/rng/meson-rng.c
@@ -10,10 +10,23 @@
 #include <dm.h>
 #include <rng.h>
 #include <asm/io.h>
+#include <linux/iopoll.h>
+
+#define RNG_DATA	0x00
+#define RNG_S4_DATA	0x08
+#define RNG_S4_CFG	0x00
+
+#define RUN_BIT		BIT(0)
+#define SEED_READY_STS_BIT	BIT(31)
+
+struct meson_rng_priv {
+	u32 (*read)(fdt_addr_t base);
+};
=20
 struct meson_rng_plat {
 	fdt_addr_t base;
 	struct clk clk;
+	struct meson_rng_priv *priv;
 };
=20
 /**
@@ -27,10 +40,11 @@ struct meson_rng_plat {
 static int meson_rng_read(struct udevice *dev, void *data, size_t len)
 {
 	struct meson_rng_plat *pdata =3D dev_get_plat(dev);
+	struct meson_rng_priv *priv =3D pdata->priv;
 	char *buffer =3D (char *)data;
=20
 	while (len) {
-		u32 rand =3D readl(pdata->base);
+		u32 rand =3D priv->read(pdata->base);
 		size_t step;
=20
 		if (len >=3D 4)
@@ -44,6 +58,47 @@ static int meson_rng_read(struct udevice *dev, void *dat=
a, size_t len)
 	return 0;
 }
=20
+static int meson_rng_wait_status(void __iomem *cfg_addr, int bit)
+{
+	u32 status =3D 0;
+	int ret;
+
+	ret =3D readl_relaxed_poll_timeout(cfg_addr,
+					 status, !(status & bit),
+					 10000);
+	if (ret)
+		return -EBUSY;
+
+	return 0;
+}
+
+static u32 meson_common_rng_read(fdt_addr_t base)
+{
+	return readl(base);
+}
+
+static u32 meson_s4_rng_read(fdt_addr_t base)
+{
+	void __iomem *cfg_addr =3D (void *)base + RNG_S4_CFG;
+	int err;
+
+	writel_relaxed(readl_relaxed(cfg_addr) | SEED_READY_STS_BIT, cfg_addr);
+
+	err =3D meson_rng_wait_status(cfg_addr, SEED_READY_STS_BIT);
+	if (err) {
+		pr_err("Seed isn't ready, try again\n");
+		return err;
+	}
+
+	err =3D meson_rng_wait_status(cfg_addr, RUN_BIT);
+	if (err) {
+		pr_err("Can't get random number, try again\n");
+		return err;
+	}
+
+	return readl_relaxed(base + RNG_S4_DATA);
+}
+
 /**
  * meson_rng_probe() - probe rng device
  *
@@ -59,6 +114,8 @@ static int meson_rng_probe(struct udevice *dev)
 	if (err)
 		return err;
=20
+	pdata->priv =3D (struct meson_rng_priv *)dev_get_driver_data(dev);
+
 	return 0;
 }
=20
@@ -102,9 +159,22 @@ static const struct dm_rng_ops meson_rng_ops =3D {
 	.read =3D meson_rng_read,
 };
=20
+static const struct meson_rng_priv meson_rng_priv =3D {
+	.read =3D meson_common_rng_read,
+};
+
+static const struct meson_rng_priv meson_rng_priv_s4 =3D {
+	.read =3D meson_s4_rng_read,
+};
+
 static const struct udevice_id meson_rng_match[] =3D {
 	{
 		.compatible =3D "amlogic,meson-rng",
+		.data =3D (ulong)&meson_rng_priv,
+	},
+	{
+		.compatible =3D "amlogic,meson-s4-rng",
+		.data =3D (ulong)&meson_rng_priv_s4,
 	},
 	{},
 };
--=20
2.25.1

