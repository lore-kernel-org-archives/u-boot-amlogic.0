Received: by mail-wm1-f68.google.com with SMTP id v22so2388150wml.1
        for <u-boot-amlogic@groups.io>; Tue, 28 May 2019 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZNybwO+P8OqWE83XT4MAlODyyv2CY1NCWOis0oF7ew=;
        b=zBGZVRCB66Y8U+/guob2goY5gGnHPbH/u2q1sVFdqSpAyTqSA0yQXxSJtLUk40g+4d
         lk6/7gMCcGvb9HWMXzpqw1eOCRxvPHHFVez+Uwp27e0EJ89qgq6eEuxtIShDo0j3lxuh
         DGRV5z7eViKcPNRQaIZYEFbHnvvBAxdKSCiGHntqxOHqv0tc+QBrh2DB8RPEqEPyrD7g
         0DALcUrcgs2Jpxf03qGvOdsLkcrUoaFwbudt19quOLLyuEWCDEEU23vApqslA7pkKkqn
         3++EMKzG0ta7ylYEue2AUGF/Qi2M0IdfRqCjTKCcvzhPI8HmPS/Ya2keUgb1R2G0e6VH
         K3SQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] ARM: meson-gx: Reset GXL/GXM to external PHY when not using internal PHY
Date: Tue, 28 May 2019 13:13:19 +0200
Message-Id: <20190528111319.1244-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

When using External PHY, reset the mux to use the external PHY in case U-Boot
was chainloaded from a misconfigured bootloader.

Fixes: 33e3378091 ("ARM: meson: rework soc arch file to prepare for new SoC")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-gx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index e41552db52..2b0614b79b 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -112,6 +112,11 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 			     GX_ETH_REG_0_TX_RATIO(4) |
 			     GX_ETH_REG_0_PHY_CLK_EN |
 			     GX_ETH_REG_0_CLK_EN);
+
+		/* Reset to external PHY */
+		if(!IS_ENABLED(CONFIG_MESON_GXBB))
+			writel(0x2009087f, GX_ETH_REG_3);
+
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
@@ -119,11 +124,13 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 		out_le32(GX_ETH_REG_0, GX_ETH_REG_0_INVERT_RMII_CLK |
 					 GX_ETH_REG_0_CLK_EN);
 
-		/* Use GXL RMII Internal PHY */
-		if (IS_ENABLED(CONFIG_MESON_GXL) &&
-		    (flags & MESON_USE_INTERNAL_RMII_PHY)) {
-			writel(0x10110181, GX_ETH_REG_2);
-			writel(0xe40908ff, GX_ETH_REG_3);
+		/* Use GXL RMII Internal PHY (also on GXM) */
+		if (!IS_ENABLED(CONFIG_MESON_GXBB)) {
+			if ((flags & MESON_USE_INTERNAL_RMII_PHY)) {
+				writel(0x10110181, GX_ETH_REG_2);
+				writel(0xe40908ff, GX_ETH_REG_3);
+			} else
+				writel(0x2009087f, GX_ETH_REG_3);
 		}
 
 		break;
-- 
2.21.0

