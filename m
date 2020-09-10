Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.17608.1599727714867616538
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 01:48:35 -0700
Received: by mail-wm1-f68.google.com with SMTP id k18so4935681wmj.5
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9nhu22lXnDrVOtUBl5Ns0uhHGyCJomUtMuf3giS7Pw=;
        b=m49YwEhfU3Wr5B/1+vP599GNwqq1W+TywvFbLO/wQmUoM6mEEEZKtgTA9AQnFJ7yta
         UM5DcvH4i5DtTpDtsGUwycFdM0GUo4TJEDaG3tgLwuk9FZmUVJyyIh5IyEZqa934yhxV
         1G9SnhNUpD/CE8hhihOnKGVuXsaCN+BJVwSBBZ7LqY/Vujoh4MK80fwHPqRXt+1+b4WG
         dENYjnXOEZmzKmNmah7MNx/MRn3ClwFrHM6n+MxYC4Knfp2hUNnhHbwl7ITHzbSzy0lo
         yDa4CULfXCrifWaXhlIYgsoLNccw6FE0KHbgOr89K+BFcYlblgOQp+rR01TQmp0cduvL
         wg+A==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 5/8] phy: meson-gxl-usb: depend on Meson AXG aswell
Date: Thu, 10 Sep 2020 10:48:16 +0200
Message-Id: <20200910084819.25312-6-narmstrong@baylibre.com>
In-Reply-To: <20200910084819.25312-1-narmstrong@baylibre.com>
References: <20200910084819.25312-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable build of meson-gxl-usb PHY for the AXG architecture aswell.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 9c775107e9..912e29f7b5 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -164,7 +164,7 @@ config MESON_GXBB_USB_PHY
 
 config MESON_GXL_USB_PHY
 	bool "Amlogic Meson GXL USB PHYs"
-	depends on PHY && ARCH_MESON && (MESON_GXL || MESON_GXM)
+	depends on PHY && ARCH_MESON && (MESON_GXL || MESON_GXM || MESON_AXG)
 	imply REGMAP
 	help
 	  This is the generic phy driver for the Amlogic Meson GXL
-- 
2.22.0

