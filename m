Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web10.10166.1611654675140585813
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Jan 2021 01:51:15 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210126095113euoutp01ff6655bfc7c42916936d2868560d1c5c~dv2Lm1j0B0631606316euoutp01j
	for <u-boot-amlogic@groups.io>; Tue, 26 Jan 2021 09:51:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210126095113euoutp01ff6655bfc7c42916936d2868560d1c5c~dv2Lm1j0B0631606316euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1611654673;
	bh=mSTenG0qvtejMC6XKx66WSlcX9pHGUqeB9GA4T22ZBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2yD8rkcSVFyj7h4BRp+pnSjw1+mXCx4/GkP+AOaO0XqX2XgH/jzD2W3FqFTLUXl8
	 /z4E1kD9VK4bIwoIQ8Gym5Q0Adfxg/sM9J+V58Gk12Qp4vavFaxdnv9Sj2+JBvjjve
	 9p+QKE8xR35GEvdeakSzD/u9XsdNPYr3mRbk9tQ0=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 2/4] button: add a simple Analog to Digital Converter device based button driver
Date: Tue, 26 Jan 2021 10:50:34 +0100
Message-Id: <20210126095036.6429-3-m.szyprowski@samsung.com>
In-Reply-To: <20210126095036.6429-1-m.szyprowski@samsung.com>
References: <20210126095036.6429-1-m.szyprowski@samsung.com>
	<CGME20210126095112eucas1p1af8ac76eaede4baf2b0cfeac561a6a06@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add a simple Analog to Digital Converter device based button driver. This
driver binds to the 'adc-keys' device tree node.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/button/Kconfig      |   8 ++
 drivers/button/Makefile     |   1 +
 drivers/button/button-adc.c | 156 ++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 drivers/button/button-adc.c

diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
index 6b3ec7e55d..6db3c5e93a 100644
--- a/drivers/button/Kconfig
+++ b/drivers/button/Kconfig
@@ -9,6 +9,14 @@ config BUTTON
 	  can provide access to board-specific buttons. Use of the device tree
 	  for configuration is encouraged.
 
+config BUTTON_ADC
+	bool "Button adc"
+	depends on BUTTON
+	help
+	  Enable support for buttons which are connected to Analog to Digital
+	  Converter device. The ADC driver must use driver model. Buttons are
+	  configured using the device tree.
+
 config BUTTON_GPIO
 	bool "Button gpio"
 	depends on BUTTON
diff --git a/drivers/button/Makefile b/drivers/button/Makefile
index fcc10ebe8d..bbd18af149 100644
--- a/drivers/button/Makefile
+++ b/drivers/button/Makefile
@@ -3,4 +3,5 @@
 # Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathome.com>
 
 obj-$(CONFIG_BUTTON) += button-uclass.o
+obj-$(CONFIG_BUTTON_ADC) += button-adc.o
 obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
new file mode 100644
index 0000000000..1901d59a0e
--- /dev/null
+++ b/drivers/button/button-adc.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ */
+
+#include <common.h>
+#include <adc.h>
+#include <button.h>
+#include <log.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <dm/of_access.h>
+#include <dm/uclass-internal.h>
+
+/**
+ * struct button_adc_priv - private data for button-adc driver.
+ *
+ * @adc: Analog to Digital Converter device to which button is connected.
+ * @channel: channel of the ADC device to probe the button state.
+ * @min: minimal raw ADC sample value to consider button as pressed.
+ * @max: maximal raw ADC sample value to consider button as pressed.
+ */
+struct button_adc_priv {
+	struct udevice *adc;
+	int channel;
+	int min;
+	int max;
+};
+
+static enum button_state_t button_adc_get_state(struct udevice *dev)
+{
+	struct button_adc_priv *priv = dev_get_priv(dev);
+	unsigned int val;
+	int ret;
+
+	ret = adc_start_channel(priv->adc, priv->channel);
+	if (ret)
+		return ret;
+
+	ret = adc_channel_data(priv->adc, priv->channel, &val);
+	if (ret)
+		return ret;
+
+	if (ret == 0)
+		return (val >= priv->min && val < priv->max) ?
+			BUTTON_ON : BUTTON_OFF;
+
+	return ret;
+}
+
+static int button_adc_probe(struct udevice *dev)
+{
+	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct button_adc_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	u32 treshold, up_treshold, t;
+	unsigned int mask;
+	ofnode node;
+	int ret, vdd;
+
+	/* Ignore the top-level button node */
+	if (!uc_plat->label)
+		return 0;
+
+	ret = dev_read_phandle_with_args(dev->parent, "io-channels",
+					 "#io-channel-cells", 0, 0, &args);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_ADC, args.node, &priv->adc);
+	if (ret)
+		return ret;
+
+	ret = ofnode_read_u32(dev_ofnode(dev->parent),
+			      "keyup-threshold-microvolt", &up_treshold);
+	if (ret)
+		return ret;
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "press-threshold-microvolt",
+			      &treshold);
+	if (ret)
+		return ret;
+
+	dev_for_each_subnode(node, dev->parent) {
+		ret = ofnode_read_u32(dev_ofnode(dev),
+				      "press-threshold-microvolt", &t);
+		if (ret)
+			return ret;
+
+		if (t > treshold)
+			up_treshold = t;
+	}
+
+	ret = adc_vdd_value(priv->adc, &vdd);
+	if (ret)
+		return ret;
+
+	ret = adc_data_mask(priv->adc, &mask);
+	if (ret)
+		return ret;
+
+	priv->channel = args.args[0];
+	priv->min = mask * (treshold / 1000) / (vdd / 1000);
+	priv->max = mask * (up_treshold / 1000) / (vdd / 1000);
+
+	return ret;
+}
+
+static int button_adc_bind(struct udevice *parent)
+{
+	struct udevice *dev;
+	ofnode node;
+	int ret;
+
+	dev_for_each_subnode(node, parent) {
+		struct button_uc_plat *uc_plat;
+		const char *label;
+
+		label = ofnode_read_string(node, "label");
+		if (!label) {
+			debug("%s: node %s has no label\n", __func__,
+			      ofnode_get_name(node));
+			return -EINVAL;
+		}
+		ret = device_bind_driver_to_node(parent, "button_adc",
+						 ofnode_get_name(node),
+						 node, &dev);
+		if (ret)
+			return ret;
+		uc_plat = dev_get_uclass_plat(dev);
+		uc_plat->label = label;
+	}
+
+	return 0;
+}
+
+static const struct button_ops button_adc_ops = {
+	.get_state	= button_adc_get_state,
+};
+
+static const struct udevice_id button_adc_ids[] = {
+	{ .compatible = "adc-keys" },
+	{ }
+};
+
+U_BOOT_DRIVER(button_adc) = {
+	.name		= "button_adc",
+	.id		= UCLASS_BUTTON,
+	.of_match	= button_adc_ids,
+	.ops		= &button_adc_ops,
+	.priv_auto	= sizeof(struct button_adc_priv),
+	.bind		= button_adc_bind,
+	.probe		= button_adc_probe,
+};
-- 
2.17.1

