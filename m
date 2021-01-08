Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.179.1610084698668165880
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Jan 2021 21:44:58 -0800
Received: by mail-pj1-f44.google.com with SMTP id v1so3063413pjr.2
        for <u-boot-amlogic@groups.io>; Thu, 07 Jan 2021 21:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RlgdZkwdkx4kqHLB8cVhgAklPndmqRj2qvoJWUkoe8=;
        b=q21ak/u8fVVzY1qA6HpcmM74VlSx65aM0D6zDzRx7L7UHSQKn7F/7mgQkIyVXrZZiJ
         +E5doA5sS1f6FbwTpZb3JqjaMHmrJGV3TZU469bQcoER48NJ3lklj8gbumIa35qlIXwM
         B/OFBxj4yfXnNkjhsX0/wzdRZn+pOCQmZw3asZwzAcYxiGIKkB1Uu9RQEWEG+ZdltSpH
         DWrUnyif1HBwTiAI2mR2U7md34QwgPhGt4rD22u6pmPnQqciVfxfkpxMwWmoWlEgnHnv
         dQzfcfNRgYV4lu2DzzsOSRIQe2f2JSyu8JNlcoNSN6Nvd+pW0KkA7S7fmm8sFDGgtJGK
         yJcQ==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] board: amlogic: vim3: ethernet mac fixed from serial
Date: Fri,  8 Jan 2021 13:43:23 +0800
Message-Id: <20210108054323.1449108-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Fixed randomly generated ethernet mac address!

Used meson_generate_serial_ethaddr for generate mac address from
board serial number, if ethaddr variable not defined.

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 board/amlogic/vim3/vim3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 09ef39ff30..0315eaf569 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -133,5 +133,14 @@ int misc_init_r(void)
 {
 	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
 
+	u8 mac_addr[6];
+	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
+		meson_generate_serial_ethaddr();
+		eth_env_get_enetaddr("ethaddr", mac_addr);
+		printf("[i] serial eth mac %02X:%02X:%02X:%02X:%02X:%02X\n",
+			mac_addr[0],mac_addr[1],mac_addr[2],
+			mac_addr[3],mac_addr[4],mac_addr[5]);
+	}
+
 	return 0;
 }
-- 
2.25.1

