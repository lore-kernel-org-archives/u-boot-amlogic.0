Received: by mail-wr1-f67.google.com with SMTP id e16so8936319wrn.1
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhpVHBa1GjUPbgrbSm7KGBfaJVchbgNmoWFxOfaOZcw=;
        b=AjzYIADlSHFIz47S3oRona3mhTVQYf5YESdyZGPcknV3FXeS/kgGrK1kbt/2gaEah+
         bp5t1N+i1JJD6i1BElbF26RP6iUmoE5p2XfOcrN9ZcSMohaxyk4qfknoAISqUcwtlUsi
         x1TsHBWh7b5Ge4s6RIkTKOTwdYzs/MmdgCBTms/m/cDb0i80HE8GQNHfeBtpsbuYG0aY
         jmm9IMaoQcBWdMiT3VzW3aU4pj+6jecun3miGnRB/BHKou9BhzXAhKBQYyzF1qIV6ita
         AaXyY+jO9vxs7vrj68OjTIgb6Kl5ew7zirwne8CkNnLIjz9rzI5fdO1Bo0wDH03cPmfO
         8SoA==
Return-Path: <mjourdan@baylibre.com>
From: Maxime Jourdan <mjourdan@baylibre.com>
Subject: [PATCH] video: meson: hdmi-supply regulator should be optional
Date: Tue,  4 Jun 2019 22:26:19 +0200
Message-Id: <20190604202619.6332-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Some boards don't have such a regulator, and don't need one to enable
HDMI display. Make it optional, fixing hdmi display for those boards.

Also surround the regulator code with a config check on DM_REGULATOR.

Reported-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/video/meson/meson_dw_hdmi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index 7a1c060856..483c93f6b6 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -361,13 +361,19 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 	priv->hdmi.i2c_clk_high = 0x67;
 	priv->hdmi.i2c_clk_low = 0x78;
 
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	ret = device_get_supply_regulator(dev, "hdmi-supply", &supply);
-	if (ret)
+	if (ret && ret != -ENOENT) {
+		pr_err("Failed to get HDMI regulator\n");
 		return ret;
+	}
 
-	ret = regulator_set_enable(supply, true);
-	if (ret)
-		return ret;
+	if (!ret) {
+		ret = regulator_set_enable(supply, true);
+		if (ret)
+			return ret;
+	}
+#endif
 
 	ret = reset_get_bulk(dev, &resets);
 	if (ret)
-- 
2.21.0

