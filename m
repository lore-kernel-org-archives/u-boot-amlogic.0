Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web12.6296.1581246368648151795
 for <u-boot-amlogic@groups.io>;
 Sun, 09 Feb 2020 03:06:08 -0800
Received: by mail-pg1-f196.google.com with SMTP id l24so2312528pgk.2
        for <u-boot-amlogic@groups.io>; Sun, 09 Feb 2020 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VxMbbkKwgqY/Ag2p/6hEPwPraER40aY3pzmn9wIAbbs=;
        b=KqEjG3sjcB9y/LEtnzSDkQooFdPE3Yjg+PM9mkKmA8+WyXbuuvMKSyRLmDZEMbfDXH
         hhfTfedW8bfXBC3VfsbgSfz8VXThm951ND54Hz4qQoDJJXsErO1Cvo+bnIhpYvOU2veE
         Mrd088vDP8KfAwE1SUs89u4lIdWtZxgV7yW1RxqsvaUPsrN1kfFpzB8FwNcGEe2vflGx
         fRzYTQv0+PliRj/vRM2psrrItmLus7t7Q4VQ9aUQsyJehc4vd0Kc2hetnds8wnKxojik
         SypQg6E2YjLue8fkoFZ/7iwGtzkkQVn5HmP0mWPVWYeja53L6/idFmMqeA8gZIxxbFGH
         +g1A==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv6 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
Date: Sun,  9 Feb 2020 11:05:53 +0000
Message-Id: <20200209110557.1996-2-linux.amoon@gmail.com>
In-Reply-To: <20200209110557.1996-1-linux.amoon@gmail.com>
References: <20200209110557.1996-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

As per mainline line kernel fix the clk tuning phase for mmc,
set Core=180, Tx=0, Rx=0 clk phase for mmc initialization.
As per S905, S905X, AGX and S922X datasheet set the default
values for clk tuning.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous
v5  Fix the commit message, configure as per mainline kernel.
    drop the RX_DELAY_MASK and TX_DELAY_MASK as they are not used.

v4  Fix the update mask value using FIELD_PREP macro.

v3  Fix the initialization of core clk tunning phase as per datasheet.
    Fix the commit message.

v2: Fix the clk phase macro to support PHASE_180
    drop the wrong CLK_CORE_PHASE_MASK macro.

v1: use the mainline kernel tuning for clk tuning.

Fixed the commmit messages.
Patch v1:
https://patchwork.ozlabs.org/patch/1201208/

Before these changes.
    clock is enabled (380953Hz)
    clock is enabled (25000000Hz)
After these changes
    clock is enabled (380953Hz)
    clock is enabled (25000000Hz)
    clock is enabled (52000000Hz)
Test on Odroid N2 and Odroid C2 with eMMC and microSD cards
---
 arch/arm/include/asm/arch-meson/sd_emmc.h | 24 +++++++++++--------
 drivers/mmc/meson_gx_mmc.c                | 28 +++++++++++++++++++----
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
index e3a72c8b66..f4299485dc 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
@@ -7,6 +7,7 @@
 #define __SD_EMMC_H__
 
 #include <mmc.h>
+#include <linux/bitops.h>
 
 #define SDIO_PORT_A			0
 #define SDIO_PORT_B			1
@@ -19,15 +20,20 @@
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
+#define   CLK_V2_ALWAYS_ON		BIT(24)
+
+#define   CLK_V3_ALWAYS_ON		BIT(28)
 
 #define MESON_SD_EMMC_CFG		0x44
 #define   CFG_BUS_WIDTH_MASK		GENMASK(1, 0)
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 86c1a7164a..b013c7c5fb 100644
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
@@ -51,11 +55,25 @@ static void meson_mmc_config_clock(struct mmc *mmc)
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
+	/* TX clock phase 0:180 */
+	meson_mmc_clk |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
+	/* RX clock phase 0:180 */
+	meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
+
+#ifdef CONFIG_MESON_GX
+	/* clk always on */
+	meson_mmc_clk |= CLK_V2_ALWAYS_ON;
+#endif
+#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
+	/* clk always on */
+	meson_mmc_clk |= CLK_V3_ALWAYS_ON;
+#endif
 
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
-- 
2.25.0

