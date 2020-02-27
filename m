Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.2699.1582802865046909866
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Feb 2020 03:27:45 -0800
Received: by mail-wr1-f66.google.com with SMTP id v4so2842656wrs.8
        for <u-boot-amlogic@groups.io>; Thu, 27 Feb 2020 03:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YkquPcL5jBD3++tR7QxPPSvL68P8aniN4bVK2eYSeRE=;
        b=CVwz9mQt9ZsBYrV4LjNRwH6g27B+yEO1VEI7tDKUZoHtcTtfiC54A5+Gv4SnPe2EmA
         GadJqJGamUKsvf0xkQVdQtbGahZ4iMFdRyzXHZxouda2wWTBsoTOomt63WuzBzJ+IfLC
         lxJ3m8XjvgmfBu71GVDM1JN8VAHrUuOUcfmGd4LmBRfacxS81aNLIK173ngZR1Nm12E5
         SfAVdDsD9iVM1DBpyxKaVl/Df9VMkKM73IQ7CZeKqKTzVZUMe/hdTrM9Yl47ALAw1GRn
         aC6fdzJGuA8SqFA9WrNbw+EjHDKAWQJiZWUdd1VxeQD8HqsgIJsi8SvjUyYEPPDnLqb4
         SEqw==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 2/6] mmc: meson-gx: enable input clocks
Date: Thu, 27 Feb 2020 12:27:34 +0100
Message-Id: <20200227112738.494579-3-jbrunet@baylibre.com>
In-Reply-To: <20200227112738.494579-1-jbrunet@baylibre.com>
References: <20200227112738.494579-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Until now, the mmc clock was left in a good enough state by the ROM
code to be used by the controller. However on some SoC, if the ROM
code finds a bootloader on USB or SPI, it might leave the MMC clock
in state the controller cannot work with.

Enable the input clocks provided to the mmc controller. While the
u-boot mmc controller driver is not doing fancy settings like the Linux,
it at least needs to make these clocks are running.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/meson_gx_mmc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 031cc79ccb1f..7060f15787f6 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <clk.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <malloc.h>
@@ -240,12 +241,23 @@ static int meson_mmc_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct mmc *mmc = &pdata->mmc;
 	struct mmc_config *cfg = &pdata->cfg;
+	struct clk_bulk clocks;
 	uint32_t val;
+	int ret;
+
 #ifdef CONFIG_PWRSEQ
 	struct udevice *pwr_dev;
-	int ret;
 #endif
 
+	/* Enable the clocks feeding the MMC controller */
+	ret = clk_get_bulk(dev, &clocks);
+	if (ret)
+		return ret;
+
+	ret = clk_enable_bulk(&clocks);
+	if (ret)
+		return ret;
+
 	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
 			MMC_VDD_31_32 | MMC_VDD_165_195;
 	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
-- 
2.24.1

