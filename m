Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.4957.1620201330567743414
 for <u-boot-amlogic@groups.io>;
 Wed, 05 May 2021 00:55:31 -0700
Received: by mail-wr1-f49.google.com with SMTP id d11so727458wrw.8
        for <u-boot-amlogic@groups.io>; Wed, 05 May 2021 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAPn2NgYZwoHilGE4P4M0ZJ34sdcPcsp6Mem7ihXxd8=;
        b=WGPlWmPpmFVJrO/oUDjRpLMQhATb6sYeC7oJ85jolgKD2uPggzQblNLfRa0E7XzOdP
         nZs8iToCNx7Q2o9xD+DuWjvbv0C+naHQMohRuwvoHnB6cKRFCm1tFathaFd28Yv8PzaU
         /My5NZKqOri+q5+vabYbRB7Vd2dBaH9kny1Zv4LvQg+n5EqOHliuZqySl7oluF2inEuw
         TmB3O3R8SGLLowySU0dpEHwAe8cn5eoRK8c/XdzvqlUaUUQ3PXLljlByY7zwIwiEZatn
         vl5X32WYlPUiclR2iiPK/1RO0CN+Rl2u85ciWdB1QTEaAUJ1r7WXUbgplLLLtHNeu/kt
         SJzA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] net: dwmac_meson8b: do not set TX delay in TXID & RXID
Date: Wed,  5 May 2021 09:55:26 +0200
Message-Id: <20210505075526.3838291-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: joe.hershberger@ni.com, rfried.dev@gmail.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, martin.blumenstingl@googlemail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

When the PHY interface is set as TXID & RXID, the delays should be taken from DT,
but first they should not be hardcoded since the PHY driver will set them.

Fixes: 798424e857 ("net: designware: add Amlogic Meson8b & later glue driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/net/dwmac_meson8b.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index c0b6ef4994..40cd8370b0 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -59,8 +59,6 @@ static int dwmac_setup_axg(struct udevice *dev, struct eth_pdata *edata)
 	switch (edata->phy_interface) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* Set RGMII mode */
 		setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
 						     AXG_ETH_REG_0_TX_PHASE(1) |
@@ -69,6 +67,15 @@ static int dwmac_setup_axg(struct udevice *dev, struct eth_pdata *edata)
 						     AXG_ETH_REG_0_CLK_EN);
 		break;
 
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		/* TOFIX: handle amlogic,tx-delay-ns & rx-internal-delay-ps from DT */
+		setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
+						     AXG_ETH_REG_0_TX_RATIO(4) |
+						     AXG_ETH_REG_0_PHY_CLK_EN |
+						     AXG_ETH_REG_0_CLK_EN);
+		break;
+
 	case PHY_INTERFACE_MODE_RMII:
 		/* Set RMII mode */
 		out_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RMII |
@@ -90,8 +97,6 @@ static int dwmac_setup_gx(struct udevice *dev, struct eth_pdata *edata)
 	switch (edata->phy_interface) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* Set RGMII mode */
 		setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
 						     GX_ETH_REG_0_TX_PHASE(1) |
@@ -101,6 +106,16 @@ static int dwmac_setup_gx(struct udevice *dev, struct eth_pdata *edata)
 
 		break;
 
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		/* TOFIX: handle amlogic,tx-delay-ns & rx-internal-delay-ps from DT */
+		setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
+						     GX_ETH_REG_0_TX_RATIO(4) |
+						     GX_ETH_REG_0_PHY_CLK_EN |
+						     GX_ETH_REG_0_CLK_EN);
+
+		break;
+
 	case PHY_INTERFACE_MODE_RMII:
 		/* Set RMII mode */
 		out_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_INVERT_RMII_CLK |
-- 
2.25.1

