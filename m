Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web11.3618.1574802735853807866
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2019 13:12:15 -0800
Received: by mail-pj1-f66.google.com with SMTP id r11so1018409pjp.12
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2019 13:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1gyCuNJdwq9fkWptRgSHTFv1PuwMVNoFlj9J3+lagf0=;
        b=Sm5uKdnLL/UvMFMPUmatQXBj03ydEN/4pdmbsT7QAtYHnDRRG1ej8eibEk+cEOGOvq
         haukSMbq0aA5sulBO8nxCtx7xqEpnBzeuXgUQLY86OmgJwPPuvKWEC9Y/PIBYFS/h/Tw
         aZmaUahMxCQsqH91uXgTQTm4VaJVYHO15EKMlDpSfHQjqZwPS6PNk4uYUWe9wH0+dU7F
         DjlEZogK9xQjqvfWBZ9S/1DiJPuAQk5hj0pxZ5g4wKhF3Fyr2wutlzRmH0lun0e/OfRm
         4qYlUtkseohqhelnjN3CKpu7oVxKvObiJOlLieMHSp9CKXg52VS293Ajx6C8sXfZE2T0
         VZwA==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCH 1/4] mmc: meson-gx: Fix tx phase in the tuning process
Date: Tue, 26 Nov 2019 21:12:03 +0000
Message-Id: <20191126211206.4537-2-linux.amoon@gmail.com>
In-Reply-To: <20191126211206.4537-1-linux.amoon@gmail.com>
References: <20191126211206.4537-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

odroid n2 eMMC module would failed to boot up,
because of TX phase clk failure, fix the typo in
TX phase macro to help tune correct clk freqency.

Before these changes.
  clock is enabled (380953Hz)
  clock is enabled (25000000Hz)
after these changes
  clock is enabled (380953Hz)
  clock is enabled (25000000Hz)
  clock is enabled (52000000Hz)
  clock is enabled (52000000Hz)
  clock is enabled (52000000Hz)

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on
new orange - eMMC AJNB4R 14.6 GiB MMC 5.1
old back   - eMMC CGND3R 58.2 GiB MMC 5.0
---
 drivers/mmc/meson_gx_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 031cc79ccb..87bea2888b 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -53,7 +53,7 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	meson_mmc_clk |= CLK_CO_PHASE_180;
 
 	/* 180 phase tx clock */
-	meson_mmc_clk |= CLK_TX_PHASE_000;
+	meson_mmc_clk |= CLK_TX_PHASE_180;
 
 	/* clock settings */
 	meson_mmc_clk |= clk_src;
-- 
2.24.0

