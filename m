Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web11.9587.1604655003729423904
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:30:04 -0800
Received: by mail-wm1-f67.google.com with SMTP id k18so664481wmj.5
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6lf+d6uFt5Cp26dATeppQeRxqpNUSXTpM90BKJ6/fs=;
        b=S+Xz5PBCOhYsOubhUTLNIN60gSoy8H3DAJWzuKKXZqNA9qMHZSkBPy7qTzHjFrWzMP
         vHz07zJmC0gQxo7rPveuTd7p2c2BRwAg/yNsCTHGDFSfcMPnPv0mRsjEL6qCK36/ebzb
         6Of9+QOZmrumAlqJDzLUHYxDrF1t7LJDouzFt4/nHbTi8WSfvXsNkQ8ALT4P5W12YSNb
         +H6iVFyVG06HPnJ+kIo9kb3fShqVL3xpPqef0lrWofYtX/1KsyAzGKJA557VSSlH1hJv
         kVW/MbPbIFEApQvzTFNcBcgEU1q50z41tOK6EyCvhAtcmi8FxkpmvL0/NJm5j8mcf23j
         mL3A==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/3] mmc: meson-gx: limit max frequency on SM1 SoCs
Date: Fri,  6 Nov 2020 10:27:54 +0100
Message-Id: <20201106092755.2250773-3-narmstrong@baylibre.com>
In-Reply-To: <20201106092755.2250773-1-narmstrong@baylibre.com>
References: <20201106092755.2250773-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Amlogic SM1 SoCs doesn't handle very well high clocks from the DIV2 input
Thus we limit the max freq to 26MHz on SM1 SoCs until we handle higher
frequencies via the first input from a composite clock.

Here 26MHz corresponds to MMC_HS clock speed.

We also add a u-boot only sm1 compatible to distinguish the controller.

Finally a TOFIX is added to precise the clock management should use
the clock controller instead of local management with fixed clock rates.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/meson_gx_mmc.c | 26 +++++++++++++++++++++++---
 drivers/mmc/meson_gx_mmc.h |  5 +++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 9350edf3fa..2c6b6cd15b 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -17,6 +17,14 @@
 #include <linux/log2.h>
 #include "meson_gx_mmc.h"
 
+bool meson_gx_mmc_is_compatible(struct udevice *dev,
+				enum meson_gx_mmc_compatible family)
+{
+	enum meson_gx_mmc_compatible compat = dev_get_driver_data(dev);
+
+	return compat == family;
+}
+
 static inline void *get_regbase(const struct mmc *mmc)
 {
 	struct meson_mmc_platdata *pdata = mmc->priv;
@@ -42,6 +50,8 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	if (!mmc->clock)
 		return;
 
+	/* TOFIX This should use the proper clock taken from DT */
+
 	/* 1GHz / CLK_MAX_DIV = 15,9 MHz */
 	if (mmc->clock > 16000000) {
 		clk = SD_EMMC_CLKSRC_DIV2;
@@ -265,7 +275,16 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
 			MMC_MODE_HS_52MHz | MMC_MODE_HS;
 	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
-	cfg->f_max = 100000000; /* 100 MHz */;
+	/*
+	 * TOFIX SM1 SoCs doesn't handle very well high clocks from the DIV2 input
+	 * Thus we limit the max freq to 26MHz on SM1 SoCs until we handle higher
+	 * frequencies via the first input from a composite clock
+	 * 26MHz corresponds to MMC_HS clock speed
+	 */
+	if (meson_gx_mmc_is_compatible(dev, MMC_COMPATIBLE_SM1))
+		cfg->f_max = 26000000; /* 26 MHz */
+	else
+		cfg->f_max = 100000000; /* 100 MHz */
 	cfg->b_max = 511; /* max 512 - 1 blocks */
 	cfg->name = dev->name;
 
@@ -308,8 +327,9 @@ int meson_mmc_bind(struct udevice *dev)
 }
 
 static const struct udevice_id meson_mmc_match[] = {
-	{ .compatible = "amlogic,meson-gx-mmc" },
-	{ .compatible = "amlogic,meson-axg-mmc" },
+	{ .compatible = "amlogic,meson-gx-mmc", .data = MMC_COMPATIBLE_GX },
+	{ .compatible = "amlogic,meson-axg-mmc", .data = MMC_COMPATIBLE_GX },
+	{ .compatible = "amlogic,meson-sm1-mmc", .data = MMC_COMPATIBLE_SM1 },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/mmc/meson_gx_mmc.h b/drivers/mmc/meson_gx_mmc.h
index b4544b5562..92aec5329f 100644
--- a/drivers/mmc/meson_gx_mmc.h
+++ b/drivers/mmc/meson_gx_mmc.h
@@ -9,6 +9,11 @@
 #include <mmc.h>
 #include <linux/bitops.h>
 
+enum meson_gx_mmc_compatible {
+	MMC_COMPATIBLE_GX,
+	MMC_COMPATIBLE_SM1,
+};
+
 #define SDIO_PORT_A			0
 #define SDIO_PORT_B			1
 #define SDIO_PORT_C			2
-- 
2.25.1

