Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web10.6153.1581246374094766412
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 03:06:14 -0800
Received: by mail-pj1-f66.google.com with SMTP id ep11so2909780pjb.2
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 03:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sslSgqoOrArq9v6myL25h/2/2jKeu71YeRQLrX2CkNE=;
        b=Vq++snJypyvBOnYRABifvkf0M5/NQ7x0duPjfilf50FlriQimG88Bri98qqQ6QLzCX
         YeJ7QNocTvgxiNyTkElW/j81hohzvTbpWTQKT792V7DHjE4LHAt7fZOA401O84FhkH/F
         Mfnh+EhaxNvAO4/vBoHnBjOdBqsdjbbHqq5SPXzgzb9vtJT7TC/WPASBkwLFn/uqUTT9
         SiczIP9rr8I4cn12GE5M9sknTdaD20cOgoLF7Q2ktaqjICyuvfP71UAKZxvEKWPD+s2c
         oxBxUSJbheUb0FMIdNSQe0Ty3HqV960jHWE/jN4lNew09uy4oV3iQIbRIjc9IPKxN3dU
         80uA==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv6 2/5] mmc: meson-gx: Use proper compatible string as per the dts
Date: Sun,  9 Feb 2020 11:05:54 +0000
Message-Id: <20200209110557.1996-3-linux.amoon@gmail.com>
In-Reply-To: <20200209110557.1996-1-linux.amoon@gmail.com>
References: <20200209110557.1996-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Use proper compatible string as per the dts so that mmc driver
could be tuned properly. SoC family S905, S905X have common clk
tuning parameters setting, while AGX and G12 have common clk tuning
parameters setting for mmc driver.

Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
No changes.
---
 arch/arm/include/asm/arch-meson/sd_emmc.h |  7 ++++
 drivers/mmc/meson_gx_mmc.c                | 46 +++++++++++++++++------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
index f4299485dc..83142d5d3f 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
@@ -13,6 +13,12 @@
 #define SDIO_PORT_B			1
 #define SDIO_PORT_C			2
 
+enum mmc_compatible {
+        MMC_COMPATIBLE_GXBB,
+        MMC_COMPATIBLE_GX,
+        MMC_COMPATIBLE_AXG,
+};
+
 #define SD_EMMC_CLKSRC_24M		24000000	/* 24 MHz */
 #define SD_EMMC_CLKSRC_DIV2		1000000000	/* 1 GHz */
 
@@ -87,6 +93,7 @@
 struct meson_mmc_platdata {
 	struct mmc_config cfg;
 	struct mmc mmc;
+	int compat;
 	void *regbase;
 	void *w_buf;
 };
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index b013c7c5fb..1aefe360c4 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -37,7 +37,8 @@ static inline void meson_write(struct mmc *mmc, uint32_t val, int offset)
 	writel(val, get_regbase(mmc) + offset);
 }
 
-static void meson_mmc_config_clock(struct mmc *mmc)
+static void meson_mmc_config_clock(struct mmc *mmc,
+				   struct meson_mmc_platdata *pdata)
 {
 	uint32_t meson_mmc_clk = 0;
 	unsigned int clk, clk_src, clk_div;
@@ -66,14 +67,20 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	/* RX clock phase 0:180 */
 	meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
 
-#ifdef CONFIG_MESON_GX
-	/* clk always on */
-	meson_mmc_clk |= CLK_V2_ALWAYS_ON;
-#endif
-#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
-	/* clk always on */
-	meson_mmc_clk |= CLK_V3_ALWAYS_ON;
-#endif
+	switch (pdata->compat) {
+	case MMC_COMPATIBLE_GXBB:
+	case MMC_COMPATIBLE_GX:
+		/* clk always on */
+		meson_mmc_clk |= CLK_V2_ALWAYS_ON;
+		break;
+	case MMC_COMPATIBLE_AXG:
+		/* clk always on */
+		meson_mmc_clk |= CLK_V3_ALWAYS_ON;
+		break;
+	default:
+		debug("no compatible supported");
+		break;
+	}
 
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
@@ -85,9 +92,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 static int meson_dm_mmc_set_ios(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	struct meson_mmc_platdata *pdata =
+		(struct meson_mmc_platdata *)dev_get_driver_data(dev);
 	uint32_t meson_mmc_cfg;
 
-	meson_mmc_config_clock(mmc);
+	meson_mmc_config_clock(mmc, pdata);
 
 	meson_mmc_cfg = meson_read(mmc, MESON_SD_EMMC_CFG);
 
@@ -324,9 +333,22 @@ int meson_mmc_bind(struct udevice *dev)
 	return mmc_bind(dev, &pdata->mmc, &pdata->cfg);
 }
 
+static const struct meson_mmc_platdata gxbb_data = {
+        .compat = MMC_COMPATIBLE_GXBB,
+};
+
+static const struct meson_mmc_platdata gx_data = {
+        .compat = MMC_COMPATIBLE_GX,
+};
+
+static const struct meson_mmc_platdata axg_data = {
+        .compat = MMC_COMPATIBLE_AXG,
+};
+
 static const struct udevice_id meson_mmc_match[] = {
-	{ .compatible = "amlogic,meson-gx-mmc" },
-	{ .compatible = "amlogic,meson-axg-mmc" },
+	{ .compatible = "amlogic,meson-gxbb-mmc", .data = (ulong)&gxbb_data },
+	{ .compatible = "amlogic,meson-gx-mmc",	.data = (ulong)&gx_data },
+	{ .compatible = "amlogic,meson-axg-mmc", .data = (ulong)&axg_data },
 	{ /* sentinel */ }
 };
 
-- 
2.25.0

