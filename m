Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.4858.1617868253330086471
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Apr 2021 00:50:53 -0700
Received: by mail-wm1-f49.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso720691wmi.0
        for <u-boot-amlogic@groups.io>; Thu, 08 Apr 2021 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4UK1HGpwacgQnIR66GrbloBcdaZEV/lJ1M+Zn93Zu4=;
        b=mDTQebQ7ijvs2C6BIUUzZEFt+d6T6LEK+QuqoepbPvbL8ksIQ2oE0OS+J81dwCvOAu
         L23YkSlySnV9XCfYqPeykd4ToEBOb//7si7+mSXBDSfm3gyPa+UxnBf673XRyTRRu1X6
         odD3RSQvRzLOQypzEZQPg06QmkxaHrMAhTheykmeOCV5ZzJHDNx73K3RyQ5ggqQIzI75
         UpuuK6qAEFSdnGQ6mr8GGN7cEQDqRwdkvnlLmHzZA0N9mY+14PxHwA+QDVPzLbAEU3k7
         i+wsg8dn957maysx8n69nveFfjK6q2j8MNXrvweL9qXwqGByBrD55SlZB1hwFRI+vNHQ
         DIDQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/5] clk: meson-g12a: add PCIe gates
Date: Thu,  8 Apr 2021 09:50:43 +0200
Message-Id: <20210408075047.4076954-2-narmstrong@baylibre.com>
In-Reply-To: <20210408075047.4076954-1-narmstrong@baylibre.com>
References: <20210408075047.4076954-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add missing gates used for PCIe.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 5058db1a47..e4fed8ddfb 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -120,7 +120,9 @@ static struct meson_gate gates[NUM_CLKS] = {
 	MESON_GATE(CLKID_SD_EMMC_C, HHI_GCLK_MPEG0, 26),
 	MESON_GATE(CLKID_ETH, HHI_GCLK_MPEG1, 3),
 	MESON_GATE(CLKID_UART1, HHI_GCLK_MPEG1, 16),
+	MESON_GATE(CLKID_PCIE_COMB, HHI_GCLK_MPEG1, 24),
 	MESON_GATE(CLKID_USB, HHI_GCLK_MPEG1, 25),
+	MESON_GATE(CLKID_PCIE_PHY, HHI_GCLK_MPEG1, 27),
 	MESON_GATE(CLKID_HTX_PCLK, HHI_GCLK_MPEG2, 4),
 	MESON_GATE(CLKID_USB1_DDR_BRIDGE, HHI_GCLK_MPEG2, 8),
 	MESON_GATE(CLKID_VPU_INTR, HHI_GCLK_MPEG2, 25),
-- 
2.25.1

