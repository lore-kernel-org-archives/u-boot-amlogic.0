Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web12.2175.1587390395142012014
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:46:35 -0700
Received: by mail-wm1-f68.google.com with SMTP id e26so11089103wmk.5
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ifw6seAQ6HrF5j4n4+l1Izrck9aOD0HjJuw95stFwXc=;
        b=DU8+c1+m8JNDggtezR43IsKw3RKZHnL2555RJRUauyaXMdjDkSq2ts4ph46aWYMXfi
         1L93erj94cO/zLCCExZlrBxN1mhrG0U/Ws2imwJoz+EMLndLHKS5WTbQSEl1YdGNv4bB
         1y6XtA/HOkbbULqSkp+w+P5rndSH3WS4syy8vXU9nOs+O25Ok1FT1uHq6fdEKZGLPg0Q
         OsMY4vcZoxSMr6nTvrscyv/ipWHjm5oKnocUgbcucoTgg2tcVaKA/aGy56swEq3j+x6X
         NSBw9KmFEpK+Sds4j2jNlEhiS1gZSdf64ihf3wQhJ0mTkZq+SB+P8kAdWXQrQXkQzBO6
         loNg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] clk: meson: g12a: add missing SD_EMMC_A controller gates
Date: Mon, 20 Apr 2020 15:46:30 +0200
Message-Id: <20200420134630.19935-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add missing SD_EMMC_A controller gates needed for probe of the A
controller, otherwise leading to a freeze of the SoC after b3d69aa596.

Fixes: b3d69aa596 ("clk: meson: reset mmc clock on probe")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index c1976aa1ef..6089f8474e 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -112,6 +112,7 @@ static struct meson_gate gates[NUM_CLKS] = {
 	MESON_GATE(CLKID_I2C, HHI_GCLK_MPEG0, 9),
 	MESON_GATE(CLKID_UART0, HHI_GCLK_MPEG0, 13),
 	MESON_GATE(CLKID_SPICC1, HHI_GCLK_MPEG0, 14),
+	MESON_GATE(CLKID_SD_EMMC_A, HHI_GCLK_MPEG0, 4),
 	MESON_GATE(CLKID_SD_EMMC_B, HHI_GCLK_MPEG0, 25),
 	MESON_GATE(CLKID_SD_EMMC_C, HHI_GCLK_MPEG0, 26),
 	MESON_GATE(CLKID_ETH, HHI_GCLK_MPEG1, 3),
@@ -127,6 +128,7 @@ static struct meson_gate gates[NUM_CLKS] = {
 	MESON_GATE(CLKID_FCLK_DIV4, HHI_FIX_PLL_CNTL1, 21),
 	MESON_GATE(CLKID_FCLK_DIV5, HHI_FIX_PLL_CNTL1, 22),
 	MESON_GATE(CLKID_FCLK_DIV7, HHI_FIX_PLL_CNTL1, 23),
+	MESON_GATE(CLKID_SD_EMMC_A_CLK0, HHI_SD_EMMC_CLK_CNTL, 7),
 	MESON_GATE(CLKID_SD_EMMC_B_CLK0, HHI_SD_EMMC_CLK_CNTL, 23),
 	MESON_GATE(CLKID_SD_EMMC_C_CLK0, HHI_NAND_CLK_CNTL, 7),
 	MESON_GATE(CLKID_VPU_0, HHI_VPU_CLK_CNTL, 8),
-- 
2.22.0

