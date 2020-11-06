Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.9586.1604655002445941763
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:30:02 -0800
Received: by mail-wr1-f66.google.com with SMTP id p1so553194wrf.12
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjppC7PrkxvbDrQmO5gQPRV4XH6BwuKajbVUPyT2fYw=;
        b=ph1VWBMH5G/6jP+HXEJsiOOw+++F2MwoUspS8uj5Lcqgsfy9o9Yh+yBfWhxOl43/2c
         htDv67QA1HstUnd2/l/NfjpMtURHi4ayDMqAa4udnHBnZeKmfR2goe3isMuLSgfRq7hS
         xa1YKmKSpv/MSfwj/jIblXdZmDormOhfNoKb07f697OcfBBy8zqC+Y+DKWdY8gcjd2IR
         bIbuPNwcndNatpE0mX1bsWfcsA8zeg7cETLWPo10O92B4E4dw76nSQdZGMkBCQ6PvcYa
         rUVf1WppFRMxZq9GPtBrilULoX3Ixo9YMiHOKd8AzfifEJkzkS4ftGRhYQL5cAZ6Hhvh
         p+eg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/3] mmc: meson-gx: move arch header to local header
Date: Fri,  6 Nov 2020 10:27:53 +0100
Message-Id: <20201106092755.2250773-2-narmstrong@baylibre.com>
In-Reply-To: <20201106092755.2250773-1-narmstrong@baylibre.com>
References: <20201106092755.2250773-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Move the asm/arch-meson/sd_emmc.h to a local meson_gx_mmc.h,
remove the useless if/then and fix the meson_gx_mmc.c include.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/meson_gx_mmc.c                                 | 4 ++--
 .../asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)
 rename arch/arm/include/asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h (97%)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 719dd1e5e5..9350edf3fa 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -13,9 +13,9 @@
 #include <mmc.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
-#include <asm/arch/sd_emmc.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
+#include "meson_gx_mmc.h"
 
 static inline void *get_regbase(const struct mmc *mmc)
 {
@@ -265,7 +265,7 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
 			MMC_MODE_HS_52MHz | MMC_MODE_HS;
 	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
-	cfg->f_max = 100000000; /* 100 MHz */
+	cfg->f_max = 100000000; /* 100 MHz */;
 	cfg->b_max = 511; /* max 512 - 1 blocks */
 	cfg->name = dev->name;
 
diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/drivers/mmc/meson_gx_mmc.h
similarity index 97%
rename from arch/arm/include/asm/arch-meson/sd_emmc.h
rename to drivers/mmc/meson_gx_mmc.h
index 1e9f8cf498..b4544b5562 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/drivers/mmc/meson_gx_mmc.h
@@ -3,14 +3,11 @@
  * (C) Copyright 2016 Carlo Caione <carlo@caione.org>
  */
 
-#ifndef __SD_EMMC_H__
-#define __SD_EMMC_H__
+#ifndef __MESON_GX_MMC_H__
+#define __MESON_GX_MMC_H__
 
 #include <mmc.h>
-#ifndef __ASSEMBLY__
 #include <linux/bitops.h>
-#endif
-
 
 #define SDIO_PORT_A			0
 #define SDIO_PORT_B			1
-- 
2.25.1

