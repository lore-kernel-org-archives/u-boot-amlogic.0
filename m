Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.88792.1696936435231964166
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Oct 2023 04:13:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 45A3D100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696936432;
	bh=e2OChmm/ieZLnaVCCxqOjoymXv3jta8FBPn/QwxH5TU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jdONpSf71zv4j6CzAcGeu2iv+Ht7pcGJxP05aWHoP7I4n4QgEYkojBvfgrkzr5U5T
	 qoIdYAQVZHwcHAaYOb/Yz2SckEbcj5pu4h91IjYHRXq1i9CVhGCMHhXuh+D9fCeZTy
	 lVV6cjpcIQ+FS2feOBl1nI16JeHUsjwj87zSq6g4tDX1G8Y/vkuhcrwGKdyTdj+1tg
	 9LY2GQgnneFoCYngE7+AY9fSpn1XgJ6Ia57hui9liB7dC0HjmuzgF9vMNTEfmNvx63
	 NMQAAKbEg2GEiFipY+rLsacOEdt8RHUyokbqblMPCSA6CChCsgP8+gq8e8SQtaYKEz
	 m1owwq6AIJqYQ==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 1/1] drivers: rng: add support for Meson S4
Date: Tue, 10 Oct 2023 14:13:38 +0300
Message-ID: <20231010111344.77563-2-avromanov@salutedevices.com>
In-Reply-To: <20231010111344.77563-1-avromanov@salutedevices.com>
References: <20231010111344.77563-1-avromanov@salutedevices.com>
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
index e0a1e8c7e0..ba60325b94 100644
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
+	pdata->priv =3D dev_get_driver_data(dev);
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

