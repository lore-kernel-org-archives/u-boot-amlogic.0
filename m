Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web11.338.1580742813031971422
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Feb 2020 07:13:33 -0800
Received: by mail-pg1-f196.google.com with SMTP id j15so934336pgm.6
        for <u-boot-amlogic@groups.io>; Mon, 03 Feb 2020 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AUMdmDeSZuLNuNy+eEUsVTDwLek94aTpts/MbOh/zEE=;
        b=SMSt/1zPJzcIPD02DLiWs08dTiZUc16VJVhwowRmJbU1hCbKpS8ASRAtis9sZ/zx0z
         8OSOd41ahpwoPiwWL7CnCEg331JaLB+6Uo8dEMvw7Ifd9CPuDpFSF9nopvymkD5c3oGP
         w02NI66WHGHSyHVUIYhoH8JAL02IlGX5MEWHbXrqYt5cKvDeMb1XVLbYp0dZmM/FEiQy
         FbLfnMrCkHtAo1/HNDQFr/cFOb/iEv1Eajvq3DLPIBP38u0npkI7dirAXku0ZIq7LjkI
         6UuTpIwAsKsQhc7beWo7pyHW71jerC8hnoh62HKwnvnpGq838zH7gnaEjZJUp1/UHpX4
         6Ubw==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
Date: Mon,  3 Feb 2020 15:13:19 +0000
Message-Id: <20200203151323.4615-2-linux.amoon@gmail.com>
In-Reply-To: <20200203151323.4615-1-linux.amoon@gmail.com>
References: <20200203151323.4615-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

As per mainline line kernel fix the clk tuning phase for mmc,
set Core=180, Tx=180, Rx=0 clk phase for mmc initialization.
As per S905, S905X, AGX and S922X datasheet set the default
values for clk tuning.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/include/asm/arch-meson/sd_emmc.h | 28 ++++++++++++------
 drivers/mmc/meson_gx_mmc.c                | 36 +++++++++++++++++++----
 2 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
index e3a72c8b66..b7a99947b3 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
@@ -7,6 +7,7 @@
 #define __SD_EMMC_H__
 
 #include <mmc.h>
+#include <linux/bitops.h>
 
 #define SDIO_PORT_A			0
 #define SDIO_PORT_B			1
@@ -19,15 +20,24 @@
 #define   CLK_MAX_DIV			63
 #define   CLK_SRC_24M			(0 << 6)
 #define   CLK_SRC_DIV2			(1 << 6)
-#define   CLK_CO_PHASE_000		(0 << 8)
-#define   CLK_CO_PHASE_090		(1 << 8)
-#define   CLK_CO_PHASE_180		(2 << 8)
-#define   CLK_CO_PHASE_270		(3 << 8)
-#define   CLK_TX_PHASE_000		(0 << 10)
-#define   CLK_TX_PHASE_090		(1 << 10)
-#define   CLK_TX_PHASE_180		(2 << 10)
-#define   CLK_TX_PHASE_270		(3 << 10)
-#define   CLK_ALWAYS_ON			BIT(24)
+
+#define   CRYSTAL_24MHZ			0
+#define   CLK_PHASE_0			0
+#define   CLK_PHASE_180			2
+
+#define   CLK_DIV_MASK			GENMASK(5, 0)
+#define   CLK_SRC_MASK			GENMASK(7, 6)
+#define   CLK_CORE_PHASE_MASK		GENMASK(9, 8)
+#define   CLK_TX_PHASE_MASK		GENMASK(11, 10)
+#define   CLK_RX_PHASE_MASK		GENMASK(13, 12)
+
+#define   CLK_V2_TX_DELAY_MASK		GENMASK(19, 16)
+#define   CLK_V2_RX_DELAY_MASK		GENMASK(23, 20)
+#define   CLK_V2_ALWAYS_ON		BIT(24)
+
+#define   CLK_V3_TX_DELAY_MASK		GENMASK(21, 16)
+#define   CLK_V3_RX_DELAY_MASK		GENMASK(27, 22)
+#define   CLK_V3_ALWAYS_ON		BIT(28)
 
 #define MESON_SD_EMMC_CFG		0x44
 #define   CFG_BUS_WIDTH_MASK		GENMASK(1, 0)
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 86c1a7164a..03fb70e717 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -16,6 +16,10 @@
 #include <asm/arch/sd_emmc.h>
 #include <linux/log2.h>
 
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <linux/bitfield.h>
+
 static inline void *get_regbase(const struct mmc *mmc)
 {
 	struct meson_mmc_platdata *pdata = mmc->priv;
@@ -51,11 +55,33 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	}
 	clk_div = DIV_ROUND_UP(clk, mmc->clock);
 
-	/* 180 phase core clock */
-	meson_mmc_clk |= CLK_CO_PHASE_180;
-
-	/* 180 phase tx clock */
-	meson_mmc_clk |= CLK_TX_PHASE_000;
+	/* Clock divider */
+	meson_mmc_clk |= CLK_DIV_MASK;
+	/* Clock source : Crystal 24MHz */
+	meson_mmc_clk |= FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
+	/* Core clock phase 2:180 */
+	meson_mmc_clk |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
+	/* TX clock phase 2:180 */
+	meson_mmc_clk |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_180);
+	/* RX clock phase 0:180 */
+	meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
+
+#ifdef CONFIG_MESON_GX
+	/* TX clock delay line */
+	meson_mmc_clk |= CLK_V2_TX_DELAY_MASK;
+	/* RX clock delay line */
+	meson_mmc_clk |= CLK_V2_RX_DELAY_MASK;
+	/* clk always on */
+	meson_mmc_clk |= CLK_V2_ALWAYS_ON;
+#endif
+#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
+	/* TX clock delay line */
+	meson_mmc_clk |= CLK_V3_TX_DELAY_MASK;
+	/* RX clock delay line */
+	meson_mmc_clk |= CLK_V3_RX_DELAY_MASK;
+	/* clk always on */
+	meson_mmc_clk |= CLK_V3_ALWAYS_ON;
+#endif
 
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
-- 
2.25.0

