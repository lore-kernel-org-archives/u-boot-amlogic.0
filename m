Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.10010.1604658716339840252
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:31:56 -0800
Received: by mail-wm1-f52.google.com with SMTP id h22so853030wmb.0
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 02:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKmtbwOmgyEnTgk7aLOQ7avLL51luW5vRCrtPASR6nM=;
        b=n2JX2oSsamk+QXvCY5j6YI/87X/TvzSGlGDI7fy1ydiqAWGHfFci/QaZxzgUZngXc1
         s6i8R1D5nyblHCPushSLtdwFzDDZQcT/abd2KO1qMHqT70kLXF3CQSqztCa5t8EDlQmy
         ubEmxf/R7EIX0AHnFK3uBr1fEmbBLnxjSycNj/wM4459REXPCd7weKeeFZ7l4/mAk07p
         DyLDzImWIVbb8VEMXHIZYpSc7PGYry4sZ2CN1KIEnEzxtzBOy2tIZ//JaBYZ/Q8QZm08
         3sjoc2Wb6ex69CgAAODvgcxYUEL053TITrwlN/UjCmCC9LNRquPaSkdKTD2R5LuJRFCh
         j8qA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] video: add TDO tl070wsh30 panel driver
Date: Fri,  6 Nov 2020 11:29:47 +0100
Message-Id: <20201106102947.2477568-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This adds support for the TDO TL070WSH30 TFT-LCD panel module.
The panel has a 1024×600 resolution and uses 24 bit RGB per pixel.
It provides a MIPI DSI interface to the host, a built-in LED backlight
and touch controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/video/Kconfig          |   9 ++
 drivers/video/Makefile         |   1 +
 drivers/video/tdo-tl070wsh30.c | 155 +++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 drivers/video/tdo-tl070wsh30.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 998271b9b6..9fef1a6d29 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -449,6 +449,15 @@ config VIDEO_LCD_SSD2828_RESET
 	The reset pin of SSD2828 chip. This takes a string in the format
 	understood by 'name_to_gpio' function, e.g. PH1 for pin 1 of port H.
 
+config VIDEO_LCD_TDO_TL070WSH30
+	bool "TDO TL070WSH30 DSI LCD panel support"
+	depends on DM_VIDEO
+	select VIDEO_MIPI_DSI
+	default n
+	help
+	Say Y here if you want to enable support for TDO TL070WSH30
+	1024x600 DSI video mode panel.
+
 config VIDEO_LCD_HITACHI_TX18D42VM
 	bool "Hitachi tx18d42vm LVDS LCD panel support"
 	depends on VIDEO
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 67a492a2d6..649901360f 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
 obj-$(CONFIG_VIDEO_LCD_ORISETECH_OTM8009A) += orisetech_otm8009a.o
 obj-$(CONFIG_VIDEO_LCD_RAYDIUM_RM68200) += raydium-rm68200.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
+obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_MB862xx) += mb862xx.o videomodes.o
 obj-${CONFIG_VIDEO_MESON} += meson/
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_dsi.o
diff --git a/drivers/video/tdo-tl070wsh30.c b/drivers/video/tdo-tl070wsh30.c
new file mode 100644
index 0000000000..ae9d11f475
--- /dev/null
+++ b/drivers/video/tdo-tl070wsh30.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+#include <common.h>
+#include <backlight.h>
+#include <dm.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <asm/gpio.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+struct tl070wsh30_panel_priv {
+	struct udevice *reg;
+	struct udevice *backlight;
+	struct gpio_desc reset;
+};
+
+static const struct display_timing default_timing = {
+	.pixelclock.typ		= 47250000,
+	.hactive.typ		= 1024,
+	.hfront_porch.typ	= 46,
+	.hback_porch.typ	= 100,
+	.hsync_len.typ		= 80,
+	.vactive.typ		= 600,
+	.vfront_porch.typ	= 5,
+	.vback_porch.typ	= 20,
+	.vsync_len.typ		= 5,
+	.flags			= DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH,
+};
+
+static int tl070wsh30_panel_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_platdata(dev);
+	struct mipi_dsi_device *device = plat->device;
+	struct tl070wsh30_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mipi_dsi_attach(device);
+	if (ret < 0)
+		return ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(device);
+	if (ret)
+		return ret;
+
+	mdelay(200);
+
+	ret = mipi_dsi_dcs_set_display_on(device);
+	if (ret)
+		return ret;
+
+	mdelay(20);
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tl070wsh30_panel_get_display_timing(struct udevice *dev,
+					    struct display_timing *timings)
+{
+	memcpy(timings, &default_timing, sizeof(*timings));
+
+	return 0;
+}
+
+static int tl070wsh30_panel_ofdata_to_platdata(struct udevice *dev)
+{
+	struct tl070wsh30_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DM_REGULATOR)) {
+		ret =  device_get_supply_regulator(dev, "power-supply",
+						   &priv->reg);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Warning: cannot get power supply\n");
+			return ret;
+		}
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "Warning: cannot get reset GPIO\n");
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		dev_err(dev, "Cannot get backlight: ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tl070wsh30_panel_probe(struct udevice *dev)
+{
+	struct tl070wsh30_panel_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_platdata(dev);
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DM_REGULATOR) && priv->reg) {
+		ret = regulator_set_enable(priv->reg, true);
+		if (ret)
+			return ret;
+	}
+
+	mdelay(10);
+
+	/* reset panel */
+	dm_gpio_set_value(&priv->reset, true);
+	
+	mdelay(10);
+
+	dm_gpio_set_value(&priv->reset, false);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_BURST |
+			   MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static const struct panel_ops tl070wsh30_panel_ops = {
+	.enable_backlight = tl070wsh30_panel_enable_backlight,
+	.get_display_timing = tl070wsh30_panel_get_display_timing,
+};
+
+static const struct udevice_id tl070wsh30_panel_ids[] = {
+	{ .compatible = "tdo,tl070wsh30" },
+	{ }
+};
+
+U_BOOT_DRIVER(tl070wsh30_panel) = {
+	.name			  = "tl070wsh30_panel",
+	.id			  = UCLASS_PANEL,
+	.of_match		  = tl070wsh30_panel_ids,
+	.ops			  = &tl070wsh30_panel_ops,
+	.ofdata_to_platdata	  = tl070wsh30_panel_ofdata_to_platdata,
+	.probe			  = tl070wsh30_panel_probe,
+	.platdata_auto_alloc_size = sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto_alloc_size	= sizeof(struct tl070wsh30_panel_priv),
+};
-- 
2.25.1

