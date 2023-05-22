Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.20313.1684757396245225503
 for <u-boot-amlogic@groups.io>;
 Mon, 22 May 2023 05:09:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1684757394;
	bh=fSUz3ZXihACywpR7Buv/quoHfItnZzDqEMDhjDYO8Ng=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Aw2ik455w8BydejvM7vxLsUP1BnTpZ8nTtbas4zExmT6xyyBqApeMgfcTydTf2Z/B
	 A+ww9W/Ras0E0cZRt3lI2/TIFmSpronvEw9ubJ9UZE3cYWvZdxPOhqs9Cc8T+0x9n8
	 MXqqxsW4kZfXx94iJeuduhFaY57+Y6P1TR8hGXjrP6SbM8Tsrbr2lw49G4F5ElrMhI
	 4Roq1y0cW+wn9bLDZpmn8g4W6TVJkHCbWwnK1trzeOUXnrBkWWWjB6i2gJ5mL/vzbe
	 QU+McjScgjHxxoa/hERqPbaesRmDBy8YW/CTHIMWi95AXnyIj520xQQxT6/oB8hEdy
	 Z1bKryYy0sTqw==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 2/3] drivers: meson: introduce secure power controller driver
Date: Mon, 22 May 2023 15:09:40 +0300
Message-ID: <20230522120941.63962-3-avromanov@sberdevices.ru>
In-Reply-To: <20230522120941.63962-1-avromanov@sberdevices.ru>
References: <20230522120941.63962-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, jh80.chung@samsung.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

This patch adds Power controller driver support for Amlogic
A1 family using secure monitor calls. The power domains register
only can access in secure world.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/power/domain/Kconfig               |   7 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/meson-secure-pwrc.c   | 160 +++++++++++++++++++++
 include/dt-bindings/power/meson-a1-power.h |  32 +++++
 4 files changed, 200 insertions(+)
 create mode 100644 drivers/power/domain/meson-secure-pwrc.c
 create mode 100644 include/dt-bindings/power/meson-a1-power.h

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 7e1b8c072fa..411c210756a 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -68,6 +68,13 @@ config MESON_EE_POWER_DOMAIN
 	  Enable support for manipulating Amlogic Meson Everything-Else power
 	  domains.
=20
+config MESON_SECURE_POWER_DOMAIN
+	bool "Enable Amlogic Secure power domain driver"
+	depends on POWER_DOMAIN && ARCH_MESON && MESON_A1
+	help
+	  Enable support for manipulating Amlogic Meson Secure power domains.
+	  Support for Amlogic A1 series.
+
 config SANDBOX_POWER_DOMAIN
 	bool "Enable the sandbox power domain test driver"
 	depends on POWER_DOMAIN && SANDBOX
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index e6244776216..aa5a4ba57cd 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) +=3D imx8mp-hsiomix.=
o
 obj-$(CONFIG_MTK_POWER_DOMAIN) +=3D mtk-power-domain.o
 obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) +=3D meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) +=3D meson-ee-pwrc.o
+obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) +=3D meson-secure-pwrc.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) +=3D sandbox-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) +=3D sandbox-power-domain-test.o
 obj-$(CONFIG_TEGRA186_POWER_DOMAIN) +=3D tegra186-power-domain.o
diff --git a/drivers/power/domain/meson-secure-pwrc.c b/drivers/power/domai=
n/meson-secure-pwrc.c
new file mode 100644
index 00000000000..f70f8e02423
--- /dev/null
+++ b/drivers/power/domain/meson-secure-pwrc.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ * Author: Alexey Romanov <avromanov@sberdevices.ru>
+ */
+
+#include <dm.h>
+#include <asm/arch/sm.h>
+#include <power-domain.h>
+#include <power-domain-uclass.h>
+#include <dt-bindings/power/meson-a1-power.h>
+
+struct meson_secure_pwrc_domain_desc {
+	char *name;
+	size_t index;
+};
+
+struct meson_secure_pwrc_domain_data {
+	unsigned int count;
+	struct meson_secure_pwrc_domain_desc *domains;
+};
+
+struct meson_secure_pwrc_priv {
+	const struct meson_secure_pwrc_domain_data *data;
+};
+
+static int meson_secure_pwrc_on(struct power_domain *power_domain)
+{
+	struct meson_secure_pwrc_priv *priv =3D dev_get_priv(power_domain->dev);
+	struct meson_secure_pwrc_domain_desc *pwrc_domain;
+	int err;
+
+	pwrc_domain =3D &priv->data->domains[power_domain->id];
+
+	err =3D meson_sm_pwrdm_on(pwrc_domain->index);
+	if (err) {
+		pr_err("meson_sm_pwrdm_on() failed (%d)\n", err);
+		return err;
+	}
+
+	pr_debug("enable %s power domain\n", pwrc_domain->name);
+
+	return 0;
+}
+
+static int meson_secure_pwrc_off(struct power_domain *power_domain)
+{
+	struct meson_secure_pwrc_priv *priv =3D dev_get_priv(power_domain->dev);
+	struct meson_secure_pwrc_domain_desc *pwrc_domain;
+	int err;
+
+	pwrc_domain =3D &priv->data->domains[power_domain->id];
+
+	err =3D meson_sm_pwrdm_off(pwrc_domain->index);
+	if (err) {
+		pr_err("meson_sm_pwrdm_off() failed (%d)\n", err);
+		return err;
+	}
+
+	pr_debug("disable %s power domain\n", pwrc_domain->name);
+
+	return 0;
+}
+
+static int meson_secure_pwrc_of_xlate(struct power_domain *power_domain,
+				  struct ofnode_phandle_args *args)
+{
+	struct meson_secure_pwrc_priv *priv =3D dev_get_priv(power_domain->dev);
+	struct meson_secure_pwrc_domain_desc *pwrc_domain;
+
+	if (args->args_count < 1) {
+		pr_err("invalid args count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	power_domain->id =3D args->args[0];
+
+	if (power_domain->id >=3D priv->data->count) {
+		pr_err("domain with ID=3D%lu is invalid\n", power_domain->id);
+		return -EINVAL;
+	}
+
+	pwrc_domain =3D &priv->data->domains[power_domain->id];
+
+	if (!pwrc_domain->name) {
+		pr_err("domain with ID=3D%lu is invalid\n", power_domain->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#define SEC_PD(__name)			\
+[PWRC_##__name##_ID] =3D			\
+{					\
+	.name =3D #__name,		\
+	.index =3D PWRC_##__name##_ID,	\
+}
+
+static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] =3D {
+	SEC_PD(DSPA),
+	SEC_PD(DSPB),
+	SEC_PD(UART),
+	SEC_PD(DMC),
+	SEC_PD(I2C),
+	SEC_PD(PSRAM),
+	SEC_PD(ACODEC),
+	SEC_PD(AUDIO),
+	SEC_PD(OTP),
+	SEC_PD(DMA),
+	SEC_PD(SD_EMMC),
+	SEC_PD(RAMA),
+	SEC_PD(RAMB),
+	SEC_PD(IR),
+	SEC_PD(SPICC),
+	SEC_PD(SPIFC),
+	SEC_PD(USB),
+	SEC_PD(NIC),
+	SEC_PD(PDMIN),
+	SEC_PD(RSA),
+};
+
+struct power_domain_ops meson_secure_pwrc_ops =3D {
+	.on =3D meson_secure_pwrc_on,
+	.off =3D meson_secure_pwrc_off,
+	.of_xlate =3D meson_secure_pwrc_of_xlate,
+};
+
+static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data =3D =
{
+	.count =3D ARRAY_SIZE(a1_pwrc_domains),
+	.domains =3D a1_pwrc_domains,
+};
+
+static const struct udevice_id meson_secure_pwrc_ids[] =3D {
+	{
+		.compatible =3D "amlogic,meson-a1-pwrc",
+		.data =3D (unsigned long)&meson_secure_a1_pwrc_data,
+	},
+	{ }
+};
+
+static int meson_secure_pwrc_probe(struct udevice *dev)
+{
+	struct meson_secure_pwrc_priv *priv =3D dev_get_priv(dev);
+
+	priv->data =3D (void *)dev_get_driver_data(dev);
+	if (!priv->data)
+		return -EINVAL;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(meson_secure_pwrc) =3D {
+	.name =3D "meson_secure_pwrc",
+	.id =3D UCLASS_POWER_DOMAIN,
+	.of_match =3D meson_secure_pwrc_ids,
+	.probe =3D meson_secure_pwrc_probe,
+	.ops =3D &meson_secure_pwrc_ops,
+	.priv_auto =3D sizeof(struct meson_secure_pwrc_priv),
+};
diff --git a/include/dt-bindings/power/meson-a1-power.h b/include/dt-bindin=
gs/power/meson-a1-power.h
new file mode 100644
index 00000000000..8e39dfc0b62
--- /dev/null
+++ b/include/dt-bindings/power/meson-a1-power.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ * Author: Alexey Romanov <avromanov@sberdevices.ru>
+ */
+
+#ifndef _DT_BINDINGS_MESON_A1_POWER_H
+#define _DT_BINDINGS_MESON_A1_POWER_H
+
+#define PWRC_DSPA_ID	8
+#define PWRC_DSPB_ID	9
+#define PWRC_UART_ID	10
+#define PWRC_DMC_ID	11
+#define PWRC_I2C_ID	12
+#define PWRC_PSRAM_ID	13
+#define PWRC_ACODEC_ID	14
+#define PWRC_AUDIO_ID	15
+#define PWRC_OTP_ID	16
+#define PWRC_DMA_ID	17
+#define PWRC_SD_EMMC_ID	18
+#define PWRC_RAMA_ID	19
+#define PWRC_RAMB_ID	20
+#define PWRC_IR_ID	21
+#define PWRC_SPICC_ID	22
+#define PWRC_SPIFC_ID	23
+#define PWRC_USB_ID	24
+#define PWRC_NIC_ID	25
+#define PWRC_PDMIN_ID	26
+#define PWRC_RSA_ID	27
+#define PWRC_MAX_ID	28
+
+#endif
--=20
2.38.1

