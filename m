Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.8767.1614242687661504873
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Feb 2021 00:44:47 -0800
Received: by mail-wr1-f47.google.com with SMTP id e10so4155403wro.12
        for <u-boot-amlogic@groups.io>; Thu, 25 Feb 2021 00:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5T7zBBuAoSamT5fzJg4szJMz7xK6y2iJD0u3Zya85Q=;
        b=a3McdxQ2qJtLcC2wK1tBvKGzLvH7sClxUKcsZgsKzjkD5Tg5OBq++9a8QrmxSIg/uQ
         qJd2+ans8NoDTKRD0AvF7RTiOtTz4uTRg1503oG43wk66lqzv+wQ7oOEh4cWPmyYmzlW
         0CZ8e70mn2mULm2uzJLZ14ewvkKwmKlWFzMzd86Wz5lpfQDUrFvW1hxsJyAF44wkfqJD
         UxAbUvriEk7hoPC4BLInSdfzLelawCGEqDjbIXo7Lred/45dS89HB56HaiPrFCbCD1Q5
         ymjbtNWxC2scbmcbCq1R0bxwXZ8oia12Z6t3gVU4nTT4FOf64vakKysPO20H6RRpZDaW
         rzvA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RFC/RFT 3/7] arm: meson: remove static MDIO mux handling
Date: Thu, 25 Feb 2021 09:44:34 +0100
Message-Id: <20210225084438.2964558-4-narmstrong@baylibre.com>
In-Reply-To: <20210225084438.2964558-1-narmstrong@baylibre.com>
References: <20210225084438.2964558-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, christianshewitt@gmail.com, b.galvani@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The static MDIO mux handling in mach-meson is no more needed, delete it.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-g12a.c | 33 --------------------------------
 arch/arm/mach-meson/board-gx.c   | 14 ++------------
 2 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index bb75d4f8ad..bfd40fe14f 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -97,31 +97,6 @@ static struct mm_region g12a_mem_map[] = {
 
 struct mm_region *mem_map = g12a_mem_map;
 
-static void g12a_enable_external_mdio(void)
-{
-	writel(0x0, ETH_PHY_CNTL2);
-}
-
-static void g12a_enable_internal_mdio(void)
-{
-	/* Fire up the PHY PLL */
-	writel(0x29c0040a, ETH_PLL_CNTL0);
-	writel(0x927e0000, ETH_PLL_CNTL1);
-	writel(0xac5f49e5, ETH_PLL_CNTL2);
-	writel(0x00000000, ETH_PLL_CNTL3);
-	writel(0x00000000, ETH_PLL_CNTL4);
-	writel(0x20200000, ETH_PLL_CNTL5);
-	writel(0x0000c002, ETH_PLL_CNTL6);
-	writel(0x00000023, ETH_PLL_CNTL7);
-	writel(0x39c0040a, ETH_PLL_CNTL0);
-	writel(0x19c0040a, ETH_PLL_CNTL0);
-
-	/* Select the internal MDIO */
-	writel(0x33000180, ETH_PHY_CNTL0);
-	writel(0x00074043, ETH_PHY_CNTL1);
-	writel(0x00000260, ETH_PHY_CNTL2);
-}
-
 /* Configure the Ethernet MAC with the requested interface mode
  * with some optional flags.
  */
@@ -138,7 +113,6 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 			     G12A_ETH_REG_0_TX_RATIO(4) |
 			     G12A_ETH_REG_0_PHY_CLK_EN |
 			     G12A_ETH_REG_0_CLK_EN);
-		g12a_enable_external_mdio();
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
@@ -146,13 +120,6 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 		out_le32(G12A_ETH_REG_0, G12A_ETH_REG_0_PHY_INTF_RMII |
 					G12A_ETH_REG_0_INVERT_RMII_CLK |
 					G12A_ETH_REG_0_CLK_EN);
-
-		/* Use G12A RMII Internal PHY */
-		if (flags & MESON_USE_INTERNAL_RMII_PHY)
-			g12a_enable_internal_mdio();
-		else
-			g12a_enable_external_mdio();
-
 		break;
 
 	default:
diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index f5273f42af..876405f0d4 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -126,10 +126,6 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 			     GX_ETH_REG_0_PHY_CLK_EN |
 			     GX_ETH_REG_0_CLK_EN);
 
-		/* Reset to external PHY */
-		if(!IS_ENABLED(CONFIG_MESON_GXBB))
-			writel(0x2009087f, GX_ETH_REG_3);
-
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
@@ -137,14 +133,8 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 		out_le32(GX_ETH_REG_0, GX_ETH_REG_0_INVERT_RMII_CLK |
 					 GX_ETH_REG_0_CLK_EN);
 
-		/* Use GXL RMII Internal PHY (also on GXM) */
-		if (!IS_ENABLED(CONFIG_MESON_GXBB)) {
-			if ((flags & MESON_USE_INTERNAL_RMII_PHY)) {
-				writel(0x10110181, GX_ETH_REG_2);
-				writel(0xe40908ff, GX_ETH_REG_3);
-			} else
-				writel(0x2009087f, GX_ETH_REG_3);
-		}
+		if (!IS_ENABLED(CONFIG_MESON_GXBB))
+			writel(0x10110181, GX_ETH_REG_2);
 
 		break;
 
-- 
2.25.1

