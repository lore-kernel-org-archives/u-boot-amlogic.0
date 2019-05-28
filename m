Received: by mail-wm1-f68.google.com with SMTP id t5so2393235wmh.3
        for <u-boot-amlogic@groups.io>; Tue, 28 May 2019 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FfjjCOPYtUCk+5w0wZvvEdeZiJmbKO9k+VZlHt6sWqY=;
        b=UC2JxDENSlU5fTCJ8mVqp2AOr7GTYsvQRwWUYL06IpLispVRKvloNZnLIFivqL6E0T
         L0Dcc/6GyugY7E29OJ6YEfLieXLEO4onwDoI4jN8WnbHrZsrFFfwLZc3X8/ixd5E6i+Q
         j7GhxxbgV2KCOD6jS3E6titsLJjRaKYMyDHAjVmbGIcrWtIwT6bJeeSK255QBg+S8PoX
         aBoZntNrRIsh/31dX0U1IY+71WW+ggDfGKvB3ETodDW+QFKAAGFtb4BeF33fr17IUhnu
         l3ucZMrAKNhMA9nKRQqjVzKHb64OuDRkvxIsNIG1QJtNhOl5hra4PFVNAFcVspJAVOI+
         CUag==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] boards: amlogic-g200: remove phy reset
Date: Tue, 28 May 2019 13:15:15 +0200
Message-Id: <20190528111515.1660-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The PHY reset is now handled by the MAC driver, remove this leftover.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/q200/q200.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/board/amlogic/q200/q200.c b/board/amlogic/q200/q200.c
index 1932c14aa2..2ea97c362e 100644
--- a/board/amlogic/q200/q200.c
+++ b/board/amlogic/q200/q200.c
@@ -26,12 +26,6 @@ int misc_init_r(void)
 
 	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
 
-	/* Reset PHY on GPIOZ_14 */
-	clrbits_le32(GX_GPIO_EN(3), BIT(14));
-	clrbits_le32(GX_GPIO_OUT(3), BIT(14));
-	mdelay(10);
-	setbits_le32(GX_GPIO_OUT(3), BIT(14));
-
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
 					  mac_addr, EFUSE_MAC_SIZE);
-- 
2.21.0

