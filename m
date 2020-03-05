Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.10878.1583406775472734764
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Mar 2020 03:12:55 -0800
Received: by mail-wr1-f65.google.com with SMTP id n7so6465937wrt.11
        for <u-boot-amlogic@groups.io>; Thu, 05 Mar 2020 03:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7niIkfMjWd60+ZB1JRW0nvPviZ3stblf2ijpMl2xD0s=;
        b=sPkb5JWzVIKOHaShhzdZ/4sF0iSYqCWvFBZ2UowdtGDfzbjdnQuRCdMKKtH9S6seab
         ia5E3cRjUIJwwUlkahqSeTmiZTC4/+P/7ZNHzl5QhjEJB0qoTS7U3D3xoIx1jXuB/7Jc
         GayfFNdEGIvuwicXlNKwqPAQuua4ODoGD5IF3l1tzxIMUP0ua1rl6dTdT9djSBMRvnMs
         k3K8/GZ69Jrw5ESfc4CPRKTxS7ZlY5VF+ckNlDpCxy9De0XbliShVXRZ+jQAMZFJqYXl
         BEXa1/cEQLxMIZObMOP+ZjzL0Evnk1SgsyqDhs7cN5SDiV9wxrNbVhwcUuTqGhF63kFM
         t5Vw==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 3/6] clk: meson: reset mmc clock on probe
Date: Thu,  5 Mar 2020 12:12:37 +0100
Message-Id: <20200305111240.129010-4-jbrunet@baylibre.com>
In-Reply-To: <20200305111240.129010-1-jbrunet@baylibre.com>
References: <20200305111240.129010-1-jbrunet@baylibre.com>
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
index 7035b59a1379..4b0028d04bf6 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -291,6 +291,13 @@ static int meson_clk_probe(struct udevice *dev)
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
index 686d94ebfe85..9e6beca94ac3 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -977,6 +977,13 @@ static int meson_clk_probe(struct udevice *dev)
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
index e781e08d9d5d..5ef4dd794d52 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -887,6 +887,13 @@ static int meson_clk_probe(struct udevice *dev)
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

