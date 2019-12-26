Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
 by mx.groups.io with SMTP id smtpd.web09.19655.1577360042249200057
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Dec 2019 03:34:02 -0800
Received: by mail-pg1-f194.google.com with SMTP id x7so12731192pgl.11
        for <u-boot-amlogic@groups.io>; Thu, 26 Dec 2019 03:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z7tSe9CKsGznFo3xd/MYyv+yoMfbCv8W9qI3L0337uo=;
        b=tjY3X6IZ/Uwf+eltoEkHdI1KO1a6y8A+2Blr0hsFso/zxPBWeiIq0en7dV07ZeWqq7
         Zy/rNJFDnVuogh2WAoyLeJ+WStp8C++EyPHyTO9/b+VpGR7NBvybZvpa3qCFkXCQCljQ
         bP9UwC/lpajZTBgXDuYOIoHOlOWewTGEojfFR87xT03dOXJVpBHdXmnOu3emR1Hyslyx
         E0jgzbCXUDKRY0H9TZOkLpdOdVJ68jIxkILkjHTGTlZ3Zz7h03I/DVTCEAnRrhBP229v
         2O4l5pQQxPrABFF5dj6OjHFsaxlxF5fPsZeGtdw74ZRsLlyTXCaXLcEr4UC7kNq4qWhf
         /aoQ==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv3 1/3] mmc: meson-gx: Fix clk phase tuning for MMC
Date: Thu, 26 Dec 2019 11:33:51 +0000
Message-Id: <20191226113353.1757-2-linux.amoon@gmail.com>
In-Reply-To: <20191226113353.1757-1-linux.amoon@gmail.com>
References: <20191226113353.1757-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

As per mainline line kernel fix the clk tunnig phase for
mmc, set Core=180, Tx=0, Rx=0 clk phase for mmc initialization.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous
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
 arch/arm/include/asm/arch-meson/sd_emmc.h | 14 ++++++--------
 drivers/mmc/meson_gx_mmc.c                |  9 +++++----
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
index e3a72c8b66..ee20c009e2 100644
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
+#define   CLK_PHASE_180 		2
+#define   CLK_TX_PHASE_MASK		GENMASK(11, 10)
+#define   CLK_RX_PHASE_MASK		GENMASK(13, 12)
+
 #define   CLK_ALWAYS_ON			BIT(24)
 
 #define MESON_SD_EMMC_CFG		0x44
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 86c1a7164a..ad697d3a5e 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -52,10 +52,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	clk_div = DIV_ROUND_UP(clk, mmc->clock);
 
 	/* 180 phase core clock */
-	meson_mmc_clk |= CLK_CO_PHASE_180;
-
-	/* 180 phase tx clock */
-	meson_mmc_clk |= CLK_TX_PHASE_000;
+	meson_mmc_clk |= CLK_PHASE_180;
+	/* 000 phase rx clock */
+	meson_mmc_clk |= CLK_RX_PHASE_MASK;
+	/* 000 phase tx clock */
+	meson_mmc_clk |= CLK_TX_PHASE_MASK;
 
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
-- 
2.24.1

