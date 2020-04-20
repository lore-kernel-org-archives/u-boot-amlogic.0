Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.2167.1587390365993194575
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:46:06 -0700
Received: by mail-wm1-f66.google.com with SMTP id v8so73576wma.0
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F93BLxGkkMH81nwM3A01OVQgk6CwBZaoPz4kfmEz5yU=;
        b=fRZ6ASfl63AvudrRHItRFYNvGLaEiOtYBvDKOuXwgcWtH8KlHnvL+eSrdZxKfIlHkV
         JmYbclElK4yTeWciMCLdAmv39ohi1tij5ErSTkXfSQ3+7nAUWbBFb09nfy65T2q53ONy
         GMzS1uvdirf8xRsflcULBDuhagZ0cO8X39/cSbTIQyhWERRibIIF7Hq/nRuN9UJ6957e
         SjxCSNRpRqIaM46K7C58AXQ/w+F3J396PxAH0x9nneVjVM7Q3gNAp/KSZL3Wyd9qelrT
         brTcCRgWp+K3B/+Z0FKNHHl4EKOXBiW+3HeC7sF90uWJzx3SrDb5SWygP2HIu+OkGBLv
         x64Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] usb: dwc3-meson-g12a: add power-on/off of the PHYs
Date: Mon, 20 Apr 2020 15:46:01 +0200
Message-Id: <20200420134601.19863-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, marex@denx.de
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Power on/off the PHYs to enable power to the USB ports, fixing USB support
on Khadas VIM3/VIM3L boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index d4453f8784..8f4a2f3f82 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 			goto err_phy_init;
 	}
 
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		if (!priv->phys[i].dev)
+			continue;
+
+		ret = generic_phy_power_on(&priv->phys[i]);
+		if (ret)
+			goto err_phy_init;
+	}
+
 	return 0;
 
 err_phy_init:
@@ -430,6 +439,13 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
 
 	clk_release_all(&priv->clk, 1);
 
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		if (!priv->phys[i].dev)
+			continue;
+
+		 generic_phy_power_off(&priv->phys[i]);
+	}
+
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
-- 
2.22.0

