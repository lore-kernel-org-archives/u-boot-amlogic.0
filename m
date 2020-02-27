Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.2700.1582802866344262356
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Feb 2020 03:27:46 -0800
Received: by mail-wm1-f65.google.com with SMTP id t14so2953776wmi.5
        for <u-boot-amlogic@groups.io>; Thu, 27 Feb 2020 03:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVtHtYjfWsF6ejVxZarCObZM6caqrx/HBDZ9+UPAZhg=;
        b=TGmeto0XQQmfhGtslnEylfQcStqaAOeQxeqdTpeywtemx0Bl+ZUXak3MIOfhtQ4f5F
         pio+3NJA7Dd74ip5TsealZF4vz9MuFvgwZIiVF+K8h0FXvm24JfLNs3qIFJHsNrIis34
         OyyFgjuVyDuo3VlOqEDQICMIhxPqAEDKhybo66cJ0ylSv/XnoI4EXaiBTOgeM4r49KUB
         HYGVAmN1DbmRNfBBsBlsmM6nXwkZrq5GPD2iCBgkmcwOm9yKa2r2I0sBQVJZXHdQ0y84
         21IBBI4MXttZx3HKMBgKLrr+5LOTDOOyoVdhKwqrnIDd4y4lFp+Rj73qznk6aja/QtUd
         i4Xg==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 3/6] clk: meson: reset mmc clock on probe
Date: Thu, 27 Feb 2020 12:27:35 +0100
Message-Id: <20200227112738.494579-4-jbrunet@baylibre.com>
In-Reply-To: <20200227112738.494579-1-jbrunet@baylibre.com>
References: <20200227112738.494579-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Anand Moon <linux.amoon@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On some SoCs, depending on the boot device, the MMC clock block may be
left in a weird state by the ROM code, in which no decent clock may be
provided. Reset the related register to make sure a sane MMC clock is
ready for the controller.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
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
2.24.1

