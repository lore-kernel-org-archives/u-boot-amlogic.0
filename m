Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
 by mx.groups.io with SMTP id smtpd.web11.345.1580742824699472352
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Feb 2020 07:13:44 -0800
Received: by mail-pg1-f193.google.com with SMTP id 6so8001146pgk.0
        for <u-boot-amlogic@groups.io>; Mon, 03 Feb 2020 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qAKTqMqw+UO/u9cpNO61qHuN1v/CrUpnvcUN/hzj1E0=;
        b=t6nu+EnZMFj3/amIUMbQTkpHLI3FMKdqFltUNWvZLq/Cj8vmxSi4W5GUEuRJWdSEU1
         QSzjTcLwP3Q9MQNJlBgc4v665Vv7P0IvLVXDjMUgI+tIrvtO0Ny0A7Z5sxL+WqTOfOlR
         rgFAq/SOiHPSqhvL2d2YgxhZckh26w8ai+Sz5U6nSxQitXsoYlz1LMHRSWnGD3vOSeNc
         mkt0beMauXsEJkoXoro/py46+1rWkKQm5fb13rfTmKEgBBE+1UfA6gDQ1byWhcXWzqDU
         A9X6GvPVgJjANNte+EXdO+PcYhYkFTw/qecYQVy5KT/6Awl4zNmao7SZL58ymJUhhAAm
         phRA==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 2/5] mmc: meson-gx: Use proper compatible string as per the dts
Date: Mon,  3 Feb 2020 15:13:20 +0000
Message-Id: <20200203151323.4615-3-linux.amoon@gmail.com>
In-Reply-To: <20200203151323.4615-1-linux.amoon@gmail.com>
References: <20200203151323.4615-1-linux.amoon@gmail.com>
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
New patch in this series.
---
---
 arch/arm/include/asm/arch-meson/sd_emmc.h |  7 +++
 drivers/mmc/meson_gx_mmc.c                | 62 +++++++++++++++--------
 2 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
index b7a99947b3..bb48b97ed1 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
@@ -13,6 +13,12 @@
 #define SDIO_PORT_B			1
 #define SDIO_PORT_C			2
 
+enum mmc_compatible {
+	MMC_COMPATIBLE_GXBB,
+	MMC_COMPATIBLE_GX,
+	MMC_COMPATIBLE_AXG,
+};
+
 #define SD_EMMC_CLKSRC_24M		24000000	/* 24 MHz */
 #define SD_EMMC_CLKSRC_DIV2		1000000000	/* 1 GHz */
 
@@ -91,6 +97,7 @@
 struct meson_mmc_platdata {
 	struct mmc_config cfg;
 	struct mmc mmc;
+	int compat;
 	void *regbase;
 	void *w_buf;
 };
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 03fb70e717..bf613e00ca 100644
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
@@ -66,22 +67,28 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	/* RX clock phase 0:180 */
 	meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
 
-#ifdef CONFIG_MESON_GX
-	/* TX clock delay line */
-	meson_mmc_clk |= CLK_V2_TX_DELAY_MASK;
-	/* RX clock delay line */
-	meson_mmc_clk |= CLK_V2_RX_DELAY_MASK;
-	/* clk always on */
-	meson_mmc_clk |= CLK_V2_ALWAYS_ON;
-#endif
-#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
-	/* TX clock delay line */
-	meson_mmc_clk |= CLK_V3_TX_DELAY_MASK;
-	/* RX clock delay line */
-	meson_mmc_clk |= CLK_V3_RX_DELAY_MASK;
-	/* clk always on */
-	meson_mmc_clk |= CLK_V3_ALWAYS_ON;
-#endif
+	switch (pdata->compat) {
+	case MMC_COMPATIBLE_GXBB:
+	case MMC_COMPATIBLE_GX:
+		/* TX clock delay line */
+		meson_mmc_clk |= CLK_V2_TX_DELAY_MASK;
+		/* RX clock delay line */
+		meson_mmc_clk |= CLK_V2_RX_DELAY_MASK;
+		/* clk always on */
+		meson_mmc_clk |= CLK_V2_ALWAYS_ON;
+		break;
+	case MMC_COMPATIBLE_AXG:
+		/* TX clock delay line */
+		meson_mmc_clk |= CLK_V3_TX_DELAY_MASK;
+		/* RX clock delay line */
+		meson_mmc_clk |= CLK_V3_RX_DELAY_MASK;
+		/* clk always on */
+		meson_mmc_clk |= CLK_V3_ALWAYS_ON;
+		break;
+	default:
+		debug("no compatible supported");
+		break;
+	}
 
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
@@ -93,9 +100,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 static int meson_dm_mmc_set_ios(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	struct meson_mmc_platdata *pdata =
+		(struct meson_mmc_platdata *)dev_get_driver_data(dev);
 	uint32_t meson_mmc_cfg;
 
-	meson_mmc_config_clock(mmc);
+	meson_mmc_config_clock(mmc, pdata);
 
 	meson_mmc_cfg = meson_read(mmc, MESON_SD_EMMC_CFG);
 
@@ -332,9 +341,22 @@ int meson_mmc_bind(struct udevice *dev)
 	return mmc_bind(dev, &pdata->mmc, &pdata->cfg);
 }
 
+static const struct meson_mmc_platdata gxbb_data = {
+	.compat = MMC_COMPATIBLE_GXBB,
+};
+
+static const struct meson_mmc_platdata gx_data = {
+	.compat = MMC_COMPATIBLE_GX,
+};
+
+static const struct meson_mmc_platdata axg_data = {
+	.compat = MMC_COMPATIBLE_AXG,
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

