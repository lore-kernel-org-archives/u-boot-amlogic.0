Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web12.31406.1612171669594044197
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Feb 2021 01:27:50 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210201092746epoutp01d9c6ef052933c6d6f25622dfcc301910~flZbc09UW3005530055epoutp01M
	for <u-boot-amlogic@groups.io>; Mon,  1 Feb 2021 09:27:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210201092746epoutp01d9c6ef052933c6d6f25622dfcc301910~flZbc09UW3005530055epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1612171666;
	bh=+SjmZbrQD8zR6PlCWMttDUll93gl0MU4OK0fyjaED9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdRVc9Ll2ilzKBXYqmvgBO6mps5Js4GxL1ZyOjGPtRRdj1O88h8S64yPU4Z3Fs7v1
	 PcoZYIZ1BMD/B+DD4WgaCpOvTPyVKe21qUbl5ArQCc8FY5PoivsdzArCE81J0Y9PpY
	 xAPr0i7pWrrAocz8sbRJeXmO2izONvSAfpVpTX7A=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/3] mmc: pwrseq: add mmc-pwrseq file to provide a generic interface
Date: Mon,  1 Feb 2021 18:28:04 +0900
Message-Id: <20210201092806.14314-2-jh80.chung@samsung.com>
In-Reply-To: <20210201092806.14314-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <20210201092806.14314-1-jh80.chung@samsung.com>
	<CGME20210201092741epcas1p47e4964865eb34f80de175f6b9bac1303@epcas1p4.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, narmstrong@baylibre.com, sjg@chromium.org, kever.yang@rock-chips.com, yangbo.lu@nxp.com, faiz_abbas@ti.com, u-boot-amlogic@groups.io, philipp.tomsich@theobroma-systems.com, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add mmc-pwrseq file to provide a generic interface.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/Kconfig      |  8 +++++++
 drivers/mmc/Makefile     |  1 +
 drivers/mmc/mmc-pwrseq.c | 51 ++++++++++++++++++++++++++++++++++++++++
 include/mmc.h            | 14 +++++++++++
 4 files changed, 74 insertions(+)
 create mode 100644 drivers/mmc/mmc-pwrseq.c

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 14d79139864a..a88e4833be84 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -18,6 +18,14 @@ config MMC_WRITE
 	help
 	  Enable write access to MMC and SD Cards
=20
+config MMC_PWRSEQ
+	bool "HW reset support for eMMC"
+	depends on PWRSEQ
+	default y
+	help
+	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
+	  devices.
+
 config MMC_BROKEN_CD
 	bool "Poll for broken card detection case"
 	help
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 1c849cbab2f1..89d6af3db30b 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -6,6 +6,7 @@
 obj-y +=3D mmc.o
 obj-$(CONFIG_$(SPL_)DM_MMC) +=3D mmc-uclass.o
 obj-$(CONFIG_$(SPL_)MMC_WRITE) +=3D mmc_write.o
+obj-$(CONFIG_MMC_PWRSEQ) +=3D mmc-pwrseq.o
 obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) +=3D sdhci-adma.o
=20
 ifndef CONFIG_$(SPL_)BLK
diff --git a/drivers/mmc/mmc-pwrseq.c b/drivers/mmc/mmc-pwrseq.c
new file mode 100644
index 000000000000..2539f61323d1
--- /dev/null
+++ b/drivers/mmc/mmc-pwrseq.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2021 SAMSUNG Electronics
+ * Jaehoon Chung <jh80.chung@samsung.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <mmc.h>
+#include <pwrseq.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+
+int mmc_pwrseq_get_power(struct udevice *dev, struct mmc_config *cfg)
+{
+	/* Enable power if needed */
+	return uclass_get_device_by_phandle(UCLASS_PWRSEQ, dev, "mmc-pwrseq",
+					   &cfg->pwr_dev);
+}
+
+static int mmc_pwrseq_set_power(struct udevice *dev, bool enable)
+{
+	struct gpio_desc reset;
+	int ret;
+
+	ret =3D gpio_request_by_name(dev, "reset-gpios", 0, &reset, GPIOD_IS_OU=
T);
+	if (ret)
+		return ret;
+	dm_gpio_set_value(&reset, 1);
+	udelay(1);
+	dm_gpio_set_value(&reset, 0);
+	udelay(200);
+
+	return 0;
+}
+
+static const struct pwrseq_ops mmc_pwrseq_ops =3D {
+	.set_power	=3D mmc_pwrseq_set_power,
+};
+
+static const struct udevice_id mmc_pwrseq_ids[] =3D {
+	{ .compatible =3D "mmc-pwrseq-emmc" },
+	{ }
+};
+
+U_BOOT_DRIVER(mmc_pwrseq_drv) =3D {
+	.name		=3D "mmc_pwrseq_emmc",
+	.id		=3D UCLASS_PWRSEQ,
+	.of_match	=3D mmc_pwrseq_ids,
+	.ops		=3D &mmc_pwrseq_ops,
+};
diff --git a/include/mmc.h b/include/mmc.h
index 1d377e0281f1..637081415430 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -591,6 +591,9 @@ struct mmc_config {
 	uint f_max;
 	uint b_max;
 	unsigned char part_type;
+#ifdef CONFIG_MMC_PWRSEQ
+	struct udevice *pwr_dev;
+#endif
 };
=20
 struct sd_ssr {
@@ -801,6 +804,17 @@ int mmc_deinit(struct mmc *mmc);
  */
 int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg);
=20
+#ifdef CONFIG_MMC_PWRSEQ
+/**
+ * mmc_pwrseq_get_power() - get a power device from device tree
+ *
+ * @dev:	MMC device
+ * @cfg:	MMC configuration
+ * @return 0 if OK, -ve on error
+ */
+int mmc_pwrseq_get_power(struct udevice *dev, struct mmc_config *cfg);
+#endif
+
 int mmc_read(struct mmc *mmc, u64 src, uchar *dst, int size);
=20
 /**
--=20
2.29.0

