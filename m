Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web09.8778.1614242692142842899
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Feb 2021 00:44:52 -0800
Received: by mail-wm1-f48.google.com with SMTP id p3so3952818wmc.2
        for <u-boot-amlogic@groups.io>; Thu, 25 Feb 2021 00:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAjq3SIpzuRJka+cscK8qb29AZulu6WA3Q1iakALxXY=;
        b=MkzqV/C9JRAkmiSGXWaYqfs3wcWlTMNryA2AWtq+j4Zlkej/YQJZWvyY5vJ6AAW46U
         75T6wxnRXkb58VuW8+UbCNwa79UYuNa79qQ8mCFgC3VThfbPBtbfmZEUybfTyLm+BHzQ
         4HgcHOFQ76C4t6G2+reoozeZ0d28bIow6EwX9FsBm2oFS2eNY209msjr9Ftoy7SOOsoP
         x+vNyUOQ7tVZhwkIoWaDuk2n4kmskU73BXAJIMmMJZ1+GdlDrN+Jbg6kIzjWw1aMVR4P
         /HFqFaAYY2qENIqiUCqXNLS5LtNWnlw+vD8r/4nlLiR74Wcg5LuSEc3uBA3aBGsiLna4
         I2lg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RFC/RFT 6/7] arm: meson: remove static ethernet memory power domain enable
Date: Thu, 25 Feb 2021 09:44:37 +0100
Message-Id: <20210225084438.2964558-7-narmstrong@baylibre.com>
In-Reply-To: <20210225084438.2964558-1-narmstrong@baylibre.com>
References: <20210225084438.2964558-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, christianshewitt@gmail.com, b.galvani@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The ethernet memory power domain is handled by the meson-ee-pwrc driver,
delete the static code.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-g12a.c | 3 ---
 arch/arm/mach-meson/board-gx.c   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index bfd40fe14f..cc7e01d014 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -126,9 +126,6 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 		printf("Invalid Ethernet interface mode\n");
 		return;
 	}
-
-	/* Enable power gate */
-	clrbits_le32(G12A_MEM_PD_REG_0, G12A_MEM_PD_REG_0_ETH_MASK);
 }
 
 #if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index 876405f0d4..cae7af5afb 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -142,9 +142,6 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 		printf("Invalid Ethernet interface mode\n");
 		return;
 	}
-
-	/* Enable power gate */
-	clrbits_le32(GX_MEM_PD_REG_0, GX_MEM_PD_REG_0_ETH_MASK);
 }
 
 #if CONFIG_IS_ENABLED(USB_DWC3_MESON_GXL) && \
-- 
2.25.1

