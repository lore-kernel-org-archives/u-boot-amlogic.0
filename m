Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.6232.1581930641891988605
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Feb 2020 01:10:42 -0800
Received: by mail-wm1-f65.google.com with SMTP id a9so17513570wmj.3
        for <u-boot-amlogic@groups.io>; Mon, 17 Feb 2020 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHeJdEUD0Mgqm4efmsXme5r+hrkTdHh5xXk74Ajnc3Y=;
        b=0HgfcXXH1jEuiQEJCYR8+cwU9U3YYpfFraMMPgzrskg0E2RBFTHnZ7pY43v/VhcWk1
         MVBiud6xrCxKN8tdeMS1waVn1YDaD6h1W7Udwxe2MOM7zbcz3t7iToEZhNNQCHdhHTSC
         1mtuHNeobM2G0KLMyn1jpIVPUKYSJUhoxXViweq8rQMCX8CN0SYQe/xqozp4I1+FJHt6
         dBuIXc7xmrzN1wqutRh5Cr7oI9Aa6az6z0GJdG/2Kq5JLCO98Z9+KAJqo91usZzb8VYm
         KLCYeuUJ4hUs7H8egjODqqJatrZnniwRo1080KKuDYtf1HcRv+AME710R3aAsqzyfl4n
         5cXg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] Revert "dm: core: device: switch off power domain after device removal"
Date: Mon, 17 Feb 2020 10:10:36 +0100
Message-Id: <20200217091036.19028-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org, trini@konsulko.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, oliver.graute@gmail.com, agust@denx.de, u-boot@lists.denx.de, u-boot-amlogic@groups.io, lokeshvutla@ti.com, sbabic@denx.de
List-ID: <u-boot-amlogic@groups.io>

This commit breaks Linux boot on Amlogic libretech-cc, libretech-ac, sei510,
sei610 board by automatically disabling the power domain after device removal.
This because the power domain associated to the video driver must be kept
enabled for linux to boot.

The only way is to use the introduced flag DM_FLAG_DEFAULT_PD_CTRL_OFF, which
removes automatic handling of power domain.
This flag is not a complete solution since it will force reverting to manually
enable the power domain from the driver probe.

Instead a flag to keep the power domain enabled after removal should be
introduced.

In the meantime revert this commit until a proper solution is found.

This reverts commit 52edfed65de967a86983a55c51ba0727090efc43.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi Simon, Tom,

This revert is the simplest fix to make the boards boot again on v2020.04,
the goal is to make this behavior happen again with a proper flag to keep the
power domain enabled on specific drivers.

I can push it on my next PR on my branch, is it ok ?

Neil

 drivers/core/device-remove.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index 444e34b492..5540053d3c 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -16,7 +16,6 @@
 #include <dm/uclass.h>
 #include <dm/uclass-internal.h>
 #include <dm/util.h>
-#include <power-domain.h>
 
 int device_chld_unbind(struct udevice *dev, struct driver *drv)
 {
@@ -194,10 +193,6 @@ int device_remove(struct udevice *dev, uint flags)
 		}
 	}
 
-	if (!(drv->flags & DM_FLAG_DEFAULT_PD_CTRL_OFF) &&
-	    (dev != gd->cur_serial_dev))
-		dev_power_domain_off(dev);
-
 	if (flags_remove(flags, drv->flags)) {
 		device_free(dev);
 
-- 
2.22.0

