Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web09.9390.1608627401752162446
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Dec 2020 00:56:42 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201222085640euoutp02e632a058db68c35dd38cdd87bed6352e~S-hj0PgvE0258702587euoutp02G
	for <u-boot-amlogic@groups.io>; Tue, 22 Dec 2020 08:56:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201222085640euoutp02e632a058db68c35dd38cdd87bed6352e~S-hj0PgvE0258702587euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608627400;
	bh=lOS4um473VZDTxF5b1DiXy4UNgSyVQmYqFnigws4pAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SooVQAtQ9SlXibOkPSrH20dI70yMYcneOHneKMhM59vufg/sPGHZwNbdYdbL5D0Bl
	 aDzV34QrE0ebhOKiWJpDkdr9DcN4uwGssc6urqm+L9TeShoY315zhKm5UiD9h8M6U8
	 jHfnOZ3t7ulc4d6W/+3GmuHBlMyhv4vR9XN6HGG8=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 2/3] button: add a simple Analog to Digital Converter device based button driver
Date: Tue, 22 Dec 2020 09:56:32 +0100
Message-Id: <20201222085633.10194-3-m.szyprowski@samsung.com>
In-Reply-To: <20201222085633.10194-1-m.szyprowski@samsung.com>
References: <20201222085633.10194-1-m.szyprowski@samsung.com>
	<CGME20201222085639eucas1p1db16b6bc2ae790ed711a09bcc5f176e5@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add a simple Analog to Digital Converter device based button driver. This
driver binds to the 'adc-keys' device tree node.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/button/Kconfig      |   8 +++
 drivers/button/Makefile     |   1 +
 drivers/button/button-adc.c | 121 ++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
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
index 0000000000..bf99dd8b43
--- /dev/null
+++ b/drivers/button/button-adc.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ */
+
+#include <common.h>
+#include <adc.h>
+#include <button.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <dm/uclass-internal.h>
+
+/**
+ * struct button_adc_priv - private data for button-adc driver.
+ *
+ * @adc: Analog to Digital Converter device to which button is connected.
+ * @channel: channel of the ADC device to probe the button state.
+ */
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
+	ret = uclass_get_device_by_ofnode(UCLASS_ADC, args.node, &priv->adc);
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

