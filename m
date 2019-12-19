Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web12.1023.1576780594821510751
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Dec 2019 10:36:35 -0800
Received: by mail-wm1-f67.google.com with SMTP id f129so6711112wmf.2
        for <u-boot-amlogic@groups.io>; Thu, 19 Dec 2019 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNnU9hadrNE6q1PVHOTCVOO8hoxVzr/4Y1CMyeywwzU=;
        b=qwvHvbKh7U/KxAv/BR+45d4VLfNuXsCHxX03k8nMJ8mH+PlFKRK3c6rL9vkXu0YoCm
         kSbzFPFAf6HK3nelwB2F2/yTyX6TjT5A3mVxlPWIcGVRuCZK4wrFz+6JyA7bEvM28zd1
         HeNLzg/NVS5Hke+jINvIR0WmPQS/L3UIViWurspACq1prtZslW2Gl+2YajgC+k86U4Aq
         SKnNnzNYDqwb4gZfwfrFbOXpv3X4hb0e1C8icR1DYR9fkACKuTLawQnHYNkQOo/wFvRB
         XE3uRJRL/M5QSsro2Vgpq25Dn0Z0C+qy3C5bjhBupcQMs/iIgJjkvt1IVIs1YvJxP8r9
         AJ3g==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/5] clk: meson: reset mmc clock on probe
Date: Thu, 19 Dec 2019 19:36:18 +0100
Message-Id: <20191219183620.1423118-4-jbrunet@baylibre.com>
In-Reply-To: <20191219183620.1423118-1-jbrunet@baylibre.com>
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On some SoCs, depending on the boot device, the MMC clock block may be
left in a weird state by the ROM code, in which no decent clock may be
provided. Reset the related register to make sure a sane MMC clock is
ready for the controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c  | 7 +++++++
 drivers/clk/meson/g12a.c | 7 +++++++
 drivers/clk/meson/gxbb.c | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 32cbf752aed8..0ba6c303e122 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -290,6 +290,13 @@ static int meson_clk_probe(struct udevice *dev)
 	if (IS_ERR(priv->map))
 		return PTR_ERR(priv->map);
 
+	/*
+	 * Depending on the boot src, the state of the MMC clock might
+	 * be different. Reset it to make sure we won't get stuck
+	 */
+	regmap_write(priv->map, HHI_NAND_CLK_CNTL, 0);
+	regmap_write(priv->map, HHI_SD_EMMC_CLK_CNTL, 0);
+
 	debug("meson-clk-axg: probed\n");
 
 	return 0;
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 1b2523bbf1fe..03d885d986b8 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -976,6 +976,13 @@ static int meson_clk_probe(struct udevice *dev)
 	if (IS_ERR(priv->map))
 		return PTR_ERR(priv->map);
 
+	/*
+	 * Depending on the boot src, the state of the MMC clock might
+	 * be different. Reset it to make sure we won't get stuck
+	 */
+	regmap_write(priv->map, HHI_NAND_CLK_CNTL, 0);
+	regmap_write(priv->map, HHI_SD_EMMC_CLK_CNTL, 0);
+
 	debug("meson-clk-g12a: probed\n");
 
 	return 0;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index abb5337e7829..aedba991603f 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -886,6 +886,13 @@ static int meson_clk_probe(struct udevice *dev)
 	if (IS_ERR(priv->map))
 		return PTR_ERR(priv->map);
 
+	/*
+	 * Depending on the boot src, the state of the MMC clock might
+	 * be different. Reset it to make sure we won't get stuck
+	 */
+	regmap_write(priv->map, HHI_NAND_CLK_CNTL, 0);
+	regmap_write(priv->map, HHI_SD_EMMC_CLK_CNTL, 0);
+
 	debug("meson-clk: probed\n");
 
 	return 0;
-- 
2.23.0

