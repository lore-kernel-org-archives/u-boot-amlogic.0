Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web08.5510.1613720489863422849
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Feb 2021 23:41:30 -0800
Received: by mail-wm1-f46.google.com with SMTP id o15so6052093wmq.5
        for <u-boot-amlogic@groups.io>; Thu, 18 Feb 2021 23:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlotbfUt+I9XyLIJG71XU0aeJzz/JJhjKKNEoZp5x9o=;
        b=TTMTYOcXI0HwXq0RJI9+quu2hZ7r4N08t6YKsKqbq//DEsw7bllNK5i141yAOO2GgE
         dre3F+HyNvONc8mE/wrolm7iVQrMNwEhEFWjKrqLWO6YQcvAOs+2Y0jOECYADPOpZ4Jd
         V6UCl6sSnOp65miKXZmwlb0NdXLo3Sr9CDE8GhxiL0bKUVmWMBvlS2iC6vQQcsJMtwab
         3wuYinAHg7CmBsxIMzmAfLFj8qO6pscIGZbXZnCWAV1FxTFcdS/t1VNcHx30S8oN7LVl
         e+29XAfwx0giPsq6PGE5vgSElCh5fxFgH3JHNe9hbrs49PyIV2RRObNJy/SHqaB5EJYw
         8hZA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] button: add udevice forward declaration
Date: Fri, 19 Feb 2021 08:41:24 +0100
Message-Id: <20210219074124.1571269-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Simon Glass <sjg@chromium.org>, xypron.glpk@gmx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, m.szyprowski@samsung.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, philippe.reynes@softathome.com
List-ID: <u-boot-amlogic@groups.io>

After 401d1c4f5d2d ("common: Drop asm/global_data.h from common header")
build fails with :

drivers/button/button-uclass.c:13:5: error: conflicting types for 'button_get_by_label'
int button_get_by_label(const char *label, struct udevice **devp)
    ^~~~~~~~~~~~~~~~~~~

Adding struct udevice forward declaration in button.h solves the build error.

Fixes: 401d1c4f5d2d ("common: Drop asm/global_data.h from common header")
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi,

This is needed to fix build on vim3/vim3l after [1] is applied.

[1] https://patchwork.ozlabs.org/project/uboot/cover/20210218103318.18915-1-m.szyprowski@samsung.com/

 include/button.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/button.h b/include/button.h
index 688b63b082..ee14fadf0c 100644
--- a/include/button.h
+++ b/include/button.h
@@ -6,6 +6,8 @@
 #ifndef __BUTTON_H
 #define __BUTTON_H
 
+struct udevice;
+
 /**
  * struct button_uc_plat - Platform data the uclass stores about each device
  *
-- 
2.25.1

