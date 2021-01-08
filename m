Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web09.18.1610083018256465951
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Jan 2021 21:16:58 -0800
Received: by mail-io1-f46.google.com with SMTP id u26so8650607iof.3
        for <u-boot-amlogic@groups.io>; Thu, 07 Jan 2021 21:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgQFncliCvswesEcuzGqeNtFVt+wGkgj2Pm0NWsYDoc=;
        b=IDSFtM80N808VRf3aVH2Ujqh4qfUBUKEetFxqyAEcYrN5LWAranUd9bty3TXEGNfH/
         Aj43aNV6SW+2Lmmbn+dkTzKjW8AEj4p9pYVvFyGWijZKmrworH0aW+8s4fBT7WAwNPr+
         40iuPBSMmyAQn0MoHT4GG/oAbXW0Uh9kH86Zs=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v4 3/8] dm: Rename DM_FLAG_REMOVE_WITH_PD_ON
Date: Thu,  7 Jan 2021 22:16:31 -0700
Message-Id: <20210108051636.2928002-4-sjg@chromium.org>
In-Reply-To: <20210108051636.2928002-1-sjg@chromium.org>
References: <20210108051636.2928002-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Neil Armstrong <narmstrong@baylibre.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

This flag has the word 'REMOVE' in it which means it conflicts with
the DM_REMOVE flags. Rename it to DM_FLAG_LEAVE_PD_ON which seems to
indicate its purpose well enough.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/device-remove.c    | 2 +-
 drivers/video/meson/meson_vpu.c | 2 +-
 drivers/watchdog/rti_wdt.c      | 2 +-
 include/dm/device.h             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index 7e8f3afb2d6..7874d53c843 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -200,7 +200,7 @@ int device_remove(struct udevice *dev, uint flags)
 
 	if (!(flags & DM_REMOVE_NO_PD) &&
 	    !(drv->flags &
-	      (DM_FLAG_DEFAULT_PD_CTRL_OFF | DM_FLAG_REMOVE_WITH_PD_ON)) &&
+	      (DM_FLAG_DEFAULT_PD_CTRL_OFF | DM_FLAG_LEAVE_PD_ON)) &&
 	    dev != gd->cur_serial_dev)
 		dev_power_domain_off(dev);
 
diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index ca6933a6c54..558f9ba766c 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -212,5 +212,5 @@ U_BOOT_DRIVER(meson_vpu) = {
 	.probe = meson_vpu_probe,
 	.bind = meson_vpu_bind,
 	.priv_auto	= sizeof(struct meson_vpu_priv),
-	.flags  = DM_FLAG_PRE_RELOC | DM_FLAG_REMOVE_WITH_PD_ON,
+	.flags  = DM_FLAG_PRE_RELOC | DM_FLAG_LEAVE_PD_ON,
 };
diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index f64a39f6579..8335b20ae84 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -119,5 +119,5 @@ U_BOOT_DRIVER(rti_wdt) = {
 	.ops = &rti_wdt_ops,
 	.probe = rti_wdt_probe,
 	.priv_auto	= sizeof(struct rti_wdt_priv),
-	.flags = DM_FLAG_REMOVE_WITH_PD_ON,
+	.flags = DM_FLAG_LEAVE_PD_ON,
 };
diff --git a/include/dm/device.h b/include/dm/device.h
index f5b4cd6876e..a52bbdc3a63 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -71,7 +71,7 @@ struct driver_info;
  * Device is removed without switching off its power domain. This might
  * be required, i. e. for serial console (debug) output when booting OS.
  */
-#define DM_FLAG_REMOVE_WITH_PD_ON	(1 << 13)
+#define DM_FLAG_LEAVE_PD_ON		(1 << 13)
 
 /*
  * One or multiple of these flags are passed to device_remove() so that
-- 
2.30.0.284.gd98b1dd5eaa7-goog

