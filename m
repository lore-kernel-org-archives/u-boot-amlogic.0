Received: by mail-wr1-f68.google.com with SMTP id p10so20925034wrq.1
        for <u-boot-amlogic@groups.io>; Wed, 03 Apr 2019 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MuMpV53KBouqoq3eqvgTuauCQS8kn8Wasq6/xxnqR5I=;
        b=yisSpF0anatfqE1y8aGeFYcsuVJOhT81iYabVFhDK6BeuUVShUJ0G2Y1Gn1JMBOQ+9
         +r6KqvSyZWORPAC0pqrGOg2VHoYZ34gYQqxEMvOl4mD854H5o5G+2PUclc1K02aimZRe
         96Ehi+xNtP5NnjxE5Ru+9NaEwJtKFgt1XwiqrqKwIct13HpX8nWcFBd6PytQlVCxvWBe
         SVbMB7kAANZcOKH9yV+3y0awFdqtg3CkmT1zff/TpP3Qp3tqRGyux4MntkQvlRcuOqev
         UlilTtwvZlbJcUflr5uVw1OfkilJA67fW2Xx2kUHmOvFhxSHCo8/CKrM4nSLM/mafDT+
         lUug==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/2] phy: Also allow MESON_GXM for MESON_GXL_USB_PHY
Date: Wed,  3 Apr 2019 13:46:36 +0200
Message-Id: <20190403114637.32068-2-narmstrong@baylibre.com>
In-Reply-To: <20190403114637.32068-1-narmstrong@baylibre.com>
References: <20190403114637.32068-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de, ldevulder@suse.de, trini@konsulko.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The MESON_GXL_USB_PHY is also used on the Amlogic Meson GXM SoCs.

Fixes: 2960e27e38 ("phy: Add Amlogic Meson USB2 & USB3 Generic PHY drivers")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 825ee7c3be..32bbf41dd1 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -141,7 +141,7 @@ config PHY_STM32_USBPHYC
 
 config MESON_GXL_USB_PHY
 	bool "Amlogic Meson GXL USB PHYs"
-	depends on PHY && ARCH_MESON && MESON_GXL
+	depends on PHY && ARCH_MESON && (MESON_GXL || MESON_GXM)
 	imply REGMAP
 	help
 	  This is the generic phy driver for the Amlogic Meson GXL
-- 
2.21.0

