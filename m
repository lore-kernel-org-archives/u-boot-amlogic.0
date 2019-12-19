Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.994.1576780593260343356
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Dec 2019 10:36:33 -0800
Received: by mail-wr1-f68.google.com with SMTP id q6so6987554wro.9
        for <u-boot-amlogic@groups.io>; Thu, 19 Dec 2019 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fOSdYh2csJZy7XU7OoT6hUFJhBZ1zj0IfX5kPizxQug=;
        b=NFgxzgBk5ERWYJy4EPsJ5NqMmhNsv4RqbIkhuCe8p2uX6NBb41LLQHPFi/eerMSrpV
         sz3FeST9/dr6fDun+edjrjOEqBkUKeAtACmJyqSgqGQ2QSKDumKx1SZL260/izAqzP3a
         4YcSayzPkvuqtJGkctHIUg/l8Md7689mniADbILue6pvLDEIvNJVnwN62WScINzcfZCp
         qfpn0yRBmvuiaIU0fimE7kHm9ZDXoBQ/3DISW210gRy1ndqTgjLEnSfeiBNCrHM6Drdq
         6QULxDJEwkbsINQcYEokoRfi9yVuvXYby85MtDM1AL/91N6LEv4wpENq2f4C97Xbcqud
         EO/A==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/5] mmc: meson-gx: enable input clocks
Date: Thu, 19 Dec 2019 19:36:17 +0100
Message-Id: <20191219183620.1423118-3-jbrunet@baylibre.com>
In-Reply-To: <20191219183620.1423118-1-jbrunet@baylibre.com>
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
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

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/meson_gx_mmc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index b5f5122b1b7b..86c1a7164a93 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
@@ -241,12 +242,23 @@ static int meson_mmc_probe(struct udevice *dev)
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
2.23.0

