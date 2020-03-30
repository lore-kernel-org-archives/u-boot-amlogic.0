Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.46456.1585560466189432633
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:46 -0700
Received: by mail-wr1-f66.google.com with SMTP id a25so20738019wrd.0
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBjluRFHjGXpsEUa9vKZkvTGEREuThi4nylIwC++0q8=;
        b=JfkzrG3j67b6Nngd/bqyRQi+vP1Ai+WLB1OMXmwb3t8jQ6AeC6KdIrk8+ZCaZnaJlL
         fOYl1FQChzFMR2uDE7YHvMEa3Jjkj1BbfUGCSgRVr8bfLSCu9+5KvmOsg8P+a+URNRWX
         Ba/swPRfbRGBd2ilxkjF3RhR3eEPQU81rGcCyjCmgSgay/gq57IRtj02kWh9V/YuP+Y6
         AHbjDQm4TyLysD3XE/aS6RAfiM+voC8oY/pmQY9fRK5AU4e3cx3H8WlIoVLKRWLbyLOL
         zdfK0hobFx8Se0mj6mmj3s9+/jkrr+lykKhar/YG+g7FOPas19eaxTDop/0MTI1A4VNP
         vWRg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 02/10] phy: meson-gxl-usb: add set_mode call to force switch to peripheral mode
Date: Mon, 30 Mar 2020 11:27:24 +0200
Message-Id: <20200330092732.7198-3-narmstrong@baylibre.com>
In-Reply-To: <20200330092732.7198-1-narmstrong@baylibre.com>
References: <20200330092732.7198-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add set_mode function in the Amlogic GXL PHYs that will be called by
the arch code to switch PHYs from/to gadget mode.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/usb-gx.h | 16 +++++++++
 drivers/phy/meson-gxl-usb2.c             | 30 ++++++++++++----
 drivers/phy/meson-gxl-usb3.c             | 44 +++++++++++++++++-------
 3 files changed, 72 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-meson/usb-gx.h

diff --git a/arch/arm/include/asm/arch-meson/usb-gx.h b/arch/arm/include/asm/arch-meson/usb-gx.h
new file mode 100644
index 0000000000..aeb8e0c673
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/usb-gx.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2019 BayLibre SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+#ifndef _ARCH_MESON_USB_GX_H_
+#define _ARCH_MESON_USB_GX_H_
+
+#include <generic-phy.h>
+#include <linux/usb/otg.h>
+
+/* TOFIX add set_mode to struct phy_ops */
+void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode);
+void phy_meson_gxl_usb3_set_mode(struct phy *phy, enum usb_dr_mode mode);
+
+#endif
diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index c98d12b627..b4f4c3c76b 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -17,6 +17,9 @@
 #include <regmap.h>
 #include <power/regulator.h>
 #include <clk.h>
+#include <linux/usb/otg.h>
+
+#include <asm/arch/usb-gx.h>
 
 #include <linux/bitops.h>
 #include <linux/compat.h>
@@ -121,15 +124,30 @@ static void phy_meson_gxl_usb2_reset(struct phy_meson_gxl_usb2_priv *priv)
 	udelay(RESET_COMPLETE_TIME);
 }
 
-static void
-phy_meson_gxl_usb2_set_host_mode(struct phy_meson_gxl_usb2_priv *priv)
+void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode)
 {
+	struct udevice *dev = phy->dev;
+	struct phy_meson_gxl_usb2_priv *priv = dev_get_priv(dev);
 	uint val;
 
 	regmap_read(priv->regmap, U2P_R0, &val);
-	val |= U2P_R0_DM_PULLDOWN;
-	val |= U2P_R0_DP_PULLDOWN;
-	val &= ~U2P_R0_ID_PULLUP;
+
+	switch (mode) {
+	case USB_DR_MODE_UNKNOWN:
+	case USB_DR_MODE_HOST:
+	case USB_DR_MODE_OTG:
+		val |= U2P_R0_DM_PULLDOWN;
+		val |= U2P_R0_DP_PULLDOWN;
+		val &= ~U2P_R0_ID_PULLUP;
+		break;
+
+	case USB_DR_MODE_PERIPHERAL:
+		val &= ~U2P_R0_DM_PULLDOWN;
+		val &= ~U2P_R0_DP_PULLDOWN;
+		val |= U2P_R0_ID_PULLUP;
+		break;
+	}
+
 	regmap_write(priv->regmap, U2P_R0, val);
 
 	phy_meson_gxl_usb2_reset(priv);
@@ -146,7 +164,7 @@ static int phy_meson_gxl_usb2_power_on(struct phy *phy)
 	val &= ~U2P_R0_POWER_ON_RESET;
 	regmap_write(priv->regmap, U2P_R0, val);
 
-	phy_meson_gxl_usb2_set_host_mode(priv);
+	phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
 
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->phy_supply) {
diff --git a/drivers/phy/meson-gxl-usb3.c b/drivers/phy/meson-gxl-usb3.c
index c2a8593b39..227efa7a17 100644
--- a/drivers/phy/meson-gxl-usb3.c
+++ b/drivers/phy/meson-gxl-usb3.c
@@ -16,6 +16,9 @@
 #include <generic-phy.h>
 #include <regmap.h>
 #include <clk.h>
+#include <linux/usb/otg.h>
+
+#include <asm/arch/usb-gx.h>
 
 #include <linux/bitops.h>
 #include <linux/compat.h>
@@ -93,20 +96,35 @@ struct phy_meson_gxl_usb3_priv {
 #endif
 };
 
-static int
-phy_meson_gxl_usb3_set_host_mode(struct phy_meson_gxl_usb3_priv *priv)
+void phy_meson_gxl_usb3_set_mode(struct phy *phy, enum usb_dr_mode mode)
 {
+	struct udevice *dev = phy->dev;
+	struct phy_meson_gxl_usb3_priv *priv = dev_get_priv(dev);
 	uint val;
 
-	regmap_read(priv->regmap, USB_R0, &val);
-	val &= ~USB_R0_U2D_ACT;
-	regmap_write(priv->regmap, USB_R0, val);
-
-	regmap_read(priv->regmap, USB_R4, &val);
-	val &= ~USB_R4_P21_SLEEP_M0;
-	regmap_write(priv->regmap, USB_R4, val);
-
-	return 0;
+	switch (mode) {
+	case USB_DR_MODE_UNKNOWN:
+	case USB_DR_MODE_HOST:
+	case USB_DR_MODE_OTG:
+		regmap_read(priv->regmap, USB_R0, &val);
+		val &= ~USB_R0_U2D_ACT;
+		regmap_write(priv->regmap, USB_R0, val);
+
+		regmap_read(priv->regmap, USB_R4, &val);
+		val &= ~USB_R4_P21_SLEEP_M0;
+		regmap_write(priv->regmap, USB_R4, val);
+		break;
+
+	case USB_DR_MODE_PERIPHERAL:
+		regmap_read(priv->regmap, USB_R0, &val);
+		val |= USB_R0_U2D_ACT;
+		regmap_write(priv->regmap, USB_R0, val);
+
+		regmap_read(priv->regmap, USB_R4, &val);
+		val |= USB_R4_P21_SLEEP_M0;
+		regmap_write(priv->regmap, USB_R4, val);
+		break;
+	}
 }
 
 static int phy_meson_gxl_usb3_power_on(struct phy *phy)
@@ -122,7 +140,9 @@ static int phy_meson_gxl_usb3_power_on(struct phy *phy)
 	val |= FIELD_PREP(USB_R5_ID_DIG_TH_MASK, 0xff);
 	regmap_write(priv->regmap, USB_R5, val);
 
-	return phy_meson_gxl_usb3_set_host_mode(priv);
+	phy_meson_gxl_usb3_set_mode(phy, USB_DR_MODE_HOST);
+
+	return 0;
 }
 
 static int phy_meson_gxl_usb3_power_off(struct phy *phy)
-- 
2.22.0

