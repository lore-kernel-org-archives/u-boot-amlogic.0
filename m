Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web09.9937.1579694789275110160
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Jan 2020 04:06:29 -0800
Received: by mail-pg1-f196.google.com with SMTP id b9so3369991pgk.12
        for <u-boot-amlogic@groups.io>; Wed, 22 Jan 2020 04:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E55KWHaFn8cMx5l6yw9KgTOndIYMJmB62+66OgKTXVM=;
        b=Q3Esgf3bTyLnluvCIWaBxk0djTIRfSnuppcqKGnV69TmxcKx+PtP/Ktbis66nN7FDW
         72c+t358ZU6c7H4UI7jJhAJW36w8Pnh8ALSIBwU2s4cg5+FAQpUjzrmMUTDDPFAjMSuh
         LxQTzFMSkNIYFF2qyoW8mGBV02HeNBpSEyhbNDT3eyL0Ovm3zCZHZ1NCPgwyHNL9wAcj
         LVcH26E312K14VQxevAOX86LI33Pbe/QT/HtO3cL6xIk9nmHHwjGrMKe72h5Blt2aN0j
         WTWZz8f1H1Z/DA+9DRDLNNYiTsU6EqmJs6ARrR+PR4bJ2fOIyNMDzb3h1hv8L1KIfjBP
         o2+w==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [Patchv4 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
Date: Wed, 22 Jan 2020 12:06:18 +0000
Message-Id: <20200122120620.8699-2-linux.amoon@gmail.com>
In-Reply-To: <20200122120620.8699-1-linux.amoon@gmail.com>
References: <20200122120620.8699-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

As per mainline line kernel fix the clk tunig phase for
mmc, set Core=180, Tx=180, Rx=0 clk phase for mmc initialization.
As per S905X and S922X datasheet set the default values
for clk tuning.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous
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
 arch/arm/include/asm/arch-meson/sd_emmc.h | 11 ++-----
 drivers/mmc/meson_gx_mmc.c                | 38 +++++++++++++++++++----
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
index e3a72c8b66..c193547aad 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
@@ -7,6 +7,7 @@
 #define __SD_EMMC_H__
 
 #include <mmc.h>
+#include <linux/bitops.h>
 
 #define SDIO_PORT_A			0
 #define SDIO_PORT_B			1
@@ -19,14 +20,8 @@
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
+#define	  UPDATE(x, h, l)		(((x) << (l)) & GENMASK((h), (l)))
+
 #define   CLK_ALWAYS_ON			BIT(24)
 
 #define MESON_SD_EMMC_CFG		0x44
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 86c1a7164a..67b1b075ab 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -51,12 +51,38 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	}
 	clk_div = DIV_ROUND_UP(clk, mmc->clock);
 
-	/* 180 phase core clock */
-	meson_mmc_clk |= CLK_CO_PHASE_180;
-
-	/* 180 phase tx clock */
-	meson_mmc_clk |= CLK_TX_PHASE_000;
-
+	/* Clock divider */
+	meson_mmc_clk = GENMASK(5, 0);
+	/* Clock source 1: Fix PLL, 1000MHz */
+	meson_mmc_clk |= UPDATE(1, 7, 6);
+	/* Core clock phase 2:180 */
+	meson_mmc_clk |= UPDATE(2, 9, 8);
+	/* TX clock phase 2:180 */
+	meson_mmc_clk |= UPDATE(2, 11, 10);
+	/* RX clock phase 0:180 */
+	meson_mmc_clk |= UPDATE(0, 13, 12);
+#ifdef CONFIG_MESON_GX
+	/* TX clock delay line */
+	meson_mmc_clk |= GENMASK(19, 16);
+	/* RX clock delay line */
+	meson_mmc_clk |= GENMASK(23, 20);
+	/* clk always on */
+	meson_mmc_clk |= BIT(20);
+	/* clk irq sdio sleep */
+	meson_mmc_clk |= BIT(25);
+#endif
+#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
+	/* TX clock delay line */
+	meson_mmc_clk |=  GENMASK(21, 16);
+	/* RX clock delay line */
+	meson_mmc_clk |=  GENMASK(27, 22);
+	/* clk always on */
+	meson_mmc_clk |= BIT(28);
+	/* clk irq sdio sleep */
+	meson_mmc_clk |= BIT(29);
+	/* clk irq sdio sleep_ds */
+	meson_mmc_clk |= BIT(30);
+#endif
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
 	meson_mmc_clk |= clk_div;
-- 
2.25.0

