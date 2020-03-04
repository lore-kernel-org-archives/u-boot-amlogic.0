Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by mx.groups.io with SMTP id smtpd.web12.3870.1583284668488037336
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Mar 2020 17:17:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1583284664;
	bh=BofA/IK2E6KBeItKCLLnokODlDH6nfTnzhiVeWSfA7o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=guQhLe2OETkW+mUo9+/ussJuobRWgoU4erchk0j9+XQNHl1wCbMXNco7O7gAZwEEo
	 5p+CLeNNeUtEyxizO+1j9+5mgRvz9xBzrbSyvZpTW4fr2qjjOfJRkP5LMq2jLWCMta
	 sk/PqPrOtMpozgsaowSaKNoeGDRJ2d5mh5v5JSnA=
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/2] drivers/rng: add Amlogic hardware RNG driver
Date: Wed,  4 Mar 2020 02:17:38 +0100
Message-Id: <20200304011738.33763-3-xypron.glpk@gmx.de>
In-Reply-To: <20200304011738.33763-1-xypron.glpk@gmx.de>
References: <20200304011738.33763-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

Add support for the hardware random number generator of Amlogic SOCs.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>
=2D--
Resent
=2D--
 drivers/rng/Kconfig     |   8 +++
 drivers/rng/Makefile    |   1 +
 drivers/rng/meson-rng.c | 120 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/rng/meson-rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index c1aa43b823..edb6152bb9 100644
=2D-- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -8,6 +8,14 @@ config DM_RNG

 if DM_RNG

+config RNG_MESON
+	bool "Amlogic Meson Random Number Generator support"
+	depends on ARCH_MESON
+	default y
+	help
+	  Enable support for hardware random number generator
+	  of Amlogic Meson SoCs.
+
 config RNG_SANDBOX
 	bool "Sandbox random number generator"
 	depends on SANDBOX
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 3517005541..6a8a66779b 100644
=2D-- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -4,5 +4,6 @@
 #

 obj-$(CONFIG_DM_RNG) +=3D rng-uclass.o
+obj-$(CONFIG_RNG_MESON) +=3D meson-rng.o
 obj-$(CONFIG_RNG_SANDBOX) +=3D sandbox_rng.o
 obj-$(CONFIG_RNG_STM32MP1) +=3D stm32mp1_rng.o
diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
new file mode 100644
index 0000000000..4b81a62353
=2D-- /dev/null
+++ b/drivers/rng/meson-rng.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
+ *
+ * Driver for Amlogic hardware random number generator
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <dm.h>
+#include <rng.h>
+#include <asm/io.h>
+
+struct meson_rng_platdata {
+	fdt_addr_t base;
+	struct clk clk;
+};
+
+/**
+ * meson_rng_read() - fill buffer with random bytes
+ *
+ * @buffer:	buffer to receive data
+ * @size:	size of buffer
+ *
+ * Return:	0
+ */
+static int meson_rng_read(struct udevice *dev, void *data, size_t len)
+{
+	struct meson_rng_platdata *pdata =3D dev_get_platdata(dev);
+	char *buffer =3D (char *)data;
+
+	while (len) {
+		u32 rand =3D readl(pdata->base);
+		size_t step;
+
+		if (len >=3D 4)
+			step =3D 4;
+		else
+			step =3D len;
+		memcpy(buffer, &rand, step);
+		buffer +=3D step;
+		len -=3D step;
+	}
+	return 0;
+}
+
+/**
+ * meson_rng_probe() - probe rng device
+ *
+ * @dev:	device
+ * Return:	0 if ok
+ */
+static int meson_rng_probe(struct udevice *dev)
+{
+	struct meson_rng_platdata *pdata =3D dev_get_platdata(dev);
+	int err;
+
+	err =3D clk_enable(&pdata->clk);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * meson_rng_remove() - deinitialize rng device
+ *
+ * @dev:	device
+ * Return:	0 if ok
+ */
+static int meson_rng_remove(struct udevice *dev)
+{
+	struct meson_rng_platdata *pdata =3D dev_get_platdata(dev);
+
+	return clk_disable(&pdata->clk);
+}
+
+/**
+ * meson_rng_ofdata_to_platdata() - transfer device tree data to plaform =
data
+ *
+ * @dev:	device
+ * Return:	0 if ok
+ */
+static int meson_rng_ofdata_to_platdata(struct udevice *dev)
+{
+	struct meson_rng_platdata *pdata =3D dev_get_platdata(dev);
+	int err;
+
+	pdata->base =3D dev_read_addr(dev);
+	if (!pdata->base)
+		return -ENODEV;
+
+	err =3D clk_get_by_name(dev, "core", &pdata->clk);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct dm_rng_ops meson_rng_ops =3D {
+	.read =3D meson_rng_read,
+};
+
+static const struct udevice_id meson_rng_match[] =3D {
+	{
+		.compatible =3D "amlogic,meson-rng",
+	},
+	{},
+};
+
+U_BOOT_DRIVER(meson_rng) =3D {
+	.name =3D "meson-rng",
+	.id =3D UCLASS_RNG,
+	.of_match =3D meson_rng_match,
+	.ops =3D &meson_rng_ops,
+	.probe =3D meson_rng_probe,
+	.remove =3D meson_rng_remove,
+	.platdata_auto_alloc_size =3D sizeof(struct meson_rng_platdata),
+	.ofdata_to_platdata =3D meson_rng_ofdata_to_platdata,
+};
=2D-
2.25.1

