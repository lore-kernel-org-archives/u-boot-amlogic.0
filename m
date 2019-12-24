Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
 by mx.groups.io with SMTP id smtpd.web09.2625.1577193961114640282
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Dec 2019 05:26:01 -0800
Received: by mail-pj1-f68.google.com with SMTP id n59so1237583pjb.1
        for <u-boot-amlogic@groups.io>; Tue, 24 Dec 2019 05:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PYu4iMlrIANJ6xs1O134gVgwE442m1SVv0uOKsRIuZc=;
        b=aeWbw/u1jrFEdyzoA4UPkzVdVgxsdEiTjRT/T0btKCIh2aS/HHprXKzlxjonLXN87a
         hC36lAERK8mmw3oref72P/4zHpIbz8/xiCb0Gq3kBabeOSxa6JG/qAO7kLeAj/L/GuBw
         L20kJpE8HY3UOv9hU3MagVFS/E0Y03PC0NAnWnAsl2V6arrNRxAMhn5FOW7BmnQfu84T
         BlfOvj6oyV/BCJNrNbgEBzubLb+ZZaHo7Jhr+9uBiylJDjCh21Q8CFgZ7E/45aQWNPNk
         Gc33qfcMD9itSlChtTQ1hVXmPvoUfSSbPlg2ksQN0TB3O6lpEL0fLj0ML5xhcdEbFUja
         4aog==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCHv2 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
Date: Tue, 24 Dec 2019 13:25:49 +0000
Message-Id: <20191224132551.1427-2-linux.amoon@gmail.com>
In-Reply-To: <20191224132551.1427-1-linux.amoon@gmail.com>
References: <20191224132551.1427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

As per mainline line kernel fix the clk tunnig phase for
mmc, set Core=180, Tx=0, Rx=0 clk phase for mmc initialization.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous
use the mainline kernel tuning for clk tuning.
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
 arch/arm/include/asm/arch-meson/sd_emmc.h | 14 ++++++--------
 drivers/mmc/meson_gx_mmc.c                |  9 +++++----
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
index e3a72c8b66..d70fe4f03e 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
@@ -7,6 +7,7 @@
 #define __SD_EMMC_H__
 
 #include <mmc.h>
+#include <linux/bitops.h>
 
 #define SDIO_PORT_A			0
 #define SDIO_PORT_B			1
@@ -19,14 +20,11 @@
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
+
+#define   CLK_CORE_PHASE_MASK		GENMASK(9, 8)
+#define   CLK_TX_PHASE_MASK		GENMASK(11, 10)
+#define   CLK_RX_PHASE_MASK		GENMASK(13, 12)
+
 #define   CLK_ALWAYS_ON			BIT(24)
 
 #define MESON_SD_EMMC_CFG		0x44
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 86c1a7164a..402981c3bb 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -52,10 +52,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	clk_div = DIV_ROUND_UP(clk, mmc->clock);
 
 	/* 180 phase core clock */
-	meson_mmc_clk |= CLK_CO_PHASE_180;
-
-	/* 180 phase tx clock */
-	meson_mmc_clk |= CLK_TX_PHASE_000;
+	meson_mmc_clk |= CLK_CORE_PHASE_MASK;
+	/* 000 phase rx clock */
+	meson_mmc_clk |= CLK_RX_PHASE_MASK;
+	/* 000 phase tx clock */
+	meson_mmc_clk |= CLK_TX_PHASE_MASK;
 
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
-- 
2.24.1

