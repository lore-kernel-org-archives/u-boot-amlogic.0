Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web09.1167.1626158938114370632
 for <u-boot-amlogic@groups.io>;
 Mon, 12 Jul 2021 23:48:58 -0700
Received: by mail-pl1-f180.google.com with SMTP id d1so5375555plg.0
        for <u-boot-amlogic@groups.io>; Mon, 12 Jul 2021 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heSID91KULWbzteWuUhPXQxqA7/VUrvEkD1n/YJiyiM=;
        b=r+AzT3fTbh0bQkDu/AGe9FbIhcY389m7Lv6jTCDzMlFn7lLrk7VbxtDR+YpwwVigcy
         Z8oP10CYlmdn8UDyh9oLT1aIk2XVaJiGp/niFyQCvkmFy6ENvJ2QXSEtXSCllkoUBlsp
         DQ821H0Gtq+w1ACIfWi2TiUKaZBU8AAG8RQ7yf8FvOz0rsFAxFlQWf4QENKJWGdcRGz7
         5Hwd+c+IUN+y2OqaWEKeLypwWCYGC2LDATziUPkY8C1ykE6qhojMxI+b8tN2Ng3J8b6n
         0TUr9cDflJYyD5+K11RSxNMEGIJPOHWQmqVRX99FKY/liSD3dLCZGWoEnIG6RN6ddCa4
         S0YQ==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] board: amlogic: vim3: fix phy-names property setup
Date: Tue, 13 Jul 2021 14:48:47 +0800
Message-Id: <20210713064847.2468652-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

phy-names was improperly implemented resulting in an inoperable USB-OTG
port.

- phy-names = "usb2-phy0\0\0usb2-phy1\0";
+ phy-names = "usb2-phy0\0usb2-phy1";

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 board/amlogic/vim3/vim3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index c8ebd676..6a67a39c 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -109,8 +109,8 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
 		}
 
 		/* Update PHY names (mandatory to disable USB3.0) */
-		len = strlcpy(data, "usb2-phy0", 32) + 1;
-		len += strlcpy(&data[len], "usb2-phy1", 32 - len) + 1;
+		len = strlcpy(data, "usb2-phy0", 32);
+		len += strlcpy(&data[len], "usb2-phy1", 32 - len);
 		ret = fdt_setprop(blob, node, "phy-names", data, len);
 		if (ret < 0) {
 			printf("vim3: failed to update usb phy names property (%d)\n", ret);
-- 
2.25.1

