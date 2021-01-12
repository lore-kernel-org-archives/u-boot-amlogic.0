Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web12.5094.1610427883287722269
 for <u-boot-amlogic@groups.io>;
 Mon, 11 Jan 2021 21:04:43 -0800
Received: by mail-pf1-f182.google.com with SMTP id m6so674368pfm.6
        for <u-boot-amlogic@groups.io>; Mon, 11 Jan 2021 21:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=we+6l6zmD6SomSa7ADo0cD6JFlmtjNvGetmNmWIbFe4=;
        b=BAPSyINcTCuKra94ZHNj/DspcjW1Ev85FqjjOCSW1pK3EKFnUuJjDS6/gFYcAGVTo7
         hK+AttLhjKNS2WiI7gkMdNgXW00qxaLGknAf9qLJYm0rXx2Kk3OGtDyoev1tN8ehZmfw
         p1g0pvOxLHUQn6aH9qxkyV57r4lVq2fRVvZz123P2s5FRivNwQ0Ivi156byewpjacfHc
         D7BqH4Iqguf2QIdbUEmHE722qSsRtvAM97N2E7ymZVn0GxvnE/bC/+CNIy2Tci1xIZH1
         47KW2u068R1DiBEsEWsgDT2w9FVVoF7YFPEKJINCrgJpkL7CJ9E2sScYACjDEINZ+Q2y
         Wt1g==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] board: amlogic: vim3: fix setup ethernet mac from efuse
Date: Tue, 12 Jan 2021 13:03:08 +0800
Message-Id: <20210112050308.774189-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Fix reading built-in ethernet MAC address from efuse

NOTE: MAC is stored in ASCII format, 1bytes = 2characters by 0 offset

if mac from efuse not valid we use meson_generate_serial_ethaddr

NOTE: remake odroid-n2.c variant from Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 board/amlogic/vim3/vim3.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 824fff8262..87d9fe1f02 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -139,26 +139,42 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
 }
 
 #define EFUSE_MAC_OFFSET	0
-#define EFUSE_MAC_SIZE		6
+#define EFUSE_MAC_SIZE		12
+#define MAC_ADDR_LEN		6
 
 int misc_init_r(void)
 {
-	uint8_t mac_addr[EFUSE_MAC_SIZE];
+	uint8_t mac_addr[MAC_ADDR_LEN];
+	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
 	ssize_t len;
 
 	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
-					  mac_addr, EFUSE_MAC_SIZE);
+					  efuse_mac_addr, EFUSE_MAC_SIZE);
 		if (len != EFUSE_MAC_SIZE)
 			return 0;
 
+		/* MAC is stored in ASCII format, 1bytes = 2characters */
+		for (int i = 0; i < 6; i++) {
+			tmp[0] = efuse_mac_addr[i * 2];
+			tmp[1] = efuse_mac_addr[i * 2 + 1];
+			tmp[2] = '\0';
+			mac_addr[i] = simple_strtoul(tmp, NULL, 16);
+		}
+
 		if (is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
 		else
 			meson_generate_serial_ethaddr();
+
+		eth_env_get_enetaddr("ethaddr", mac_addr);
+		printf("[i] setup onboard mac %02X:%02X:%02X:%02X:%02X:%02X\n",
+			mac_addr[0],mac_addr[1],mac_addr[2],
+			mac_addr[3],mac_addr[4],mac_addr[5]);
 	}
 
 	return 0;
 }
+
-- 
2.25.1

