Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web09.6877.1642602253121399348
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Jan 2022 06:24:13 -0800
Received: by mail-ed1-f50.google.com with SMTP id c24so10342665edy.4
        for <u-boot-amlogic@groups.io>; Wed, 19 Jan 2022 06:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdR+k1/d3/O4q1d+IQOWoMrdgyVhIzhfctJZPZxWdDE=;
        b=mCHJC0HJOrvw0ha3Wphjhk+ieUABbNaC3K0fMHtLVJvZd9uTt+/fh/YdW9SWh9L0Ln
         olm20HPErf8WFbsPvVpjF9iuqsASdpWBCPtj0jbxQSCjOU0GoZONxPlTkEaWyRxvtOUx
         gjlYNZQKKz0KCWMLvpQwCPZ2Aig+TRM7VkRq6g7BJ68QwTH5F509W6EjrZqnSGA5n/LG
         9NHbpuyq8Nt7vHHg+WqIfJlnsKaNN96fhew3WdzSD1MSLsuDpG4dXriJik5NepOU8PAT
         FgXId3J6RZ4O2YQQ8TyA66eWkFieWL47sfOQtmDNs0FdYoCo9rK2SbdEjZU7GzrZdegX
         d1cQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH] board: amlogic: vim3: configure serial# from ethaddr
Date: Wed, 19 Jan 2022 15:24:00 +0100
Message-Id: <20220119142400.127342-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Khadas VIM3 and VIM3L boards, which are supported in Android via
Yukawa [1] need a serial number for usb/fastboot enumeration.

Whenever the environment does not provide a serial#, use the eth mac
address as serial#.

[1] https://source.android.com/setup/build/devices#vim3_and_vim3l_boards
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 board/amlogic/vim3/vim3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 5d9ac6458d68..fcd60ab1e058 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -153,6 +153,7 @@ int misc_init_r(void)
 {
 	u8 mac_addr[MAC_ADDR_LEN];
 	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
+	char serial_string[EFUSE_MAC_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
@@ -177,5 +178,13 @@ int misc_init_r(void)
 		eth_env_get_enetaddr("ethaddr", mac_addr);
 	}
 
+	if (!env_get("serial#")) {
+		eth_env_get_enetaddr("ethaddr", mac_addr);
+		sprintf(serial_string, "%02X%02X%02X%02X%02X%02X",
+			mac_addr[0], mac_addr[1], mac_addr[2],
+			mac_addr[3], mac_addr[4], mac_addr[5]);
+		env_set("serial#", serial_string);
+	}
+
 	return 0;
 }
-- 
2.32.0

