Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web08.12753.1608043386610661842
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 06:43:06 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201215144250euoutp01563f8bd00be25ead7233fa0a9f3e0d31~Q6uzpkPNN1401814018euoutp01Q
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 14:42:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201215144250euoutp01563f8bd00be25ead7233fa0a9f3e0d31~Q6uzpkPNN1401814018euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608043370;
	bh=0Xav+A+9dQCe2IQu9jP7gRV/iH3XCUGWANAZ0kxLTCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZXe+PSrM2Hb1NGD00NPbub5asu+wSRvzxz5mKnQaJ1KGEEhVm1y9gzIE76oXbbpR
	 oD7JhXi44QWyUYlqhSFJTsCnjANjp7mHydavOAg675WxX5KMLkEFfLvp/kE51IN01I
	 5pm3zFBtFQWdPk5dDCVr4RpZPkhklxyR1GNj2t4M=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 5/7] button: add a simple ADC-based button driver
Date: Tue, 15 Dec 2020 15:42:28 +0100
Message-Id: <20201215144230.9235-6-m.szyprowski@samsung.com>
In-Reply-To: <20201215144230.9235-1-m.szyprowski@samsung.com>
References: <20201215144230.9235-1-m.szyprowski@samsung.com>
	<CGME20201215144244eucas1p12404d7047f032e03ebcad27b88f23a25@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add a simple ADC-based button driver. This driver binds to the 'adc-keys'
device tree node.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/button/Kconfig      |   8 +++
 drivers/button/Makefile     |   1 +
 drivers/button/button-adc.c | 117 ++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/button/button-adc.c

diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
index 6b3ec7e55d..283367f2bd 100644
--- a/drivers/button/Kconfig
+++ b/drivers/button/Kconfig
@@ -9,6 +9,14 @@ config BUTTON
 	  can provide access to board-specific buttons. Use of the device tree
 	  for configuration is encouraged.
 
+config BUTTON_ADC
+	bool "Button adc"
+	depends on BUTTON
+	help
+	  Enable support for buttons which are connected to ADC lines. The ADC
+	  driver must use driver model. Buttons are configured using the device
+	  tree.
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
index 0000000000..086c676c02
--- /dev/null
+++ b/drivers/button/button-adc.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ */
+
+#include <common.h>
+#include <button.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <dm/uclass-internal.h>
+#include <log.h>
+#include <adc.h>
+
+struct button_adc_priv {
+	struct udevice *adc;
+	int channel;
+};
+
+static enum button_state_t button_adc_get_state(struct udevice *dev)
+{
+	struct button_adc_priv *priv = dev_get_priv(dev);
+	unsigned int val, mask;
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
+	ret = adc_data_mask(priv->adc, &mask);
+	if (ret)
+		return ret;
+
+	/* getting state is simplified a bit */
+	if (ret == 0)
+		return (val < mask / 2) ? BUTTON_ON : BUTTON_OFF;
+
+	return ret;
+}
+
+static int button_adc_probe(struct udevice *dev)
+{
+	struct button_uc_plat *uc_plat = dev_get_uclass_platdata(dev);
+	struct button_adc_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	int ret;
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
+	ret = uclass_get_device_by_name(UCLASS_ADC, ofnode_get_name(args.node),
+					&priv->adc);
+	if (ret)
+		return ret;
+
+	priv->channel = args.args[0];
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
+		uc_plat = dev_get_uclass_platdata(dev);
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
+	.priv_auto_alloc_size = sizeof(struct button_adc_priv),
+	.bind		= button_adc_bind,
+	.probe		= button_adc_probe,
+};
-- 
2.17.1

