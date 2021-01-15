Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web12.1184.1610698323197871795
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Jan 2021 00:12:03 -0800
Received: by mail-pf1-f174.google.com with SMTP id d2so5016742pfq.5
        for <u-boot-amlogic@groups.io>; Fri, 15 Jan 2021 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3Q8gcUuX8y0myj4nrIRMEHYXU2AzWyEwffh9+TTUko=;
        b=HdzwPZiwdkhcT+2R6Iyzm0QqqsGv6PEo1qJCHrP9sOTDw/DB2Cb7TsA4sOUyaSw8M0
         XVC5+bMPsYOrlOwn0B+udAdeJfcv3N8EvXQ5XCVjf8KqRI9XUo/ySHs9d1Xpwam03xdV
         AxTaMF0eVH5HukKU4PqQI1Cgl07fvW5rQRZtg3MQtRfqtv66tnLdxZBkn6dYGgDsCj56
         Y9BYRrK3X8Cpo51ga1fszaHenjizHaghnDMHh1OF6W1C2tJhUN0HxYAxjELgLs/prZ69
         OKnonnt0XVVvQumAd7GG0iwBM9YT0Usl1qjg+MdBaBQFc5ZMIFyaIzSf84hzy234ovUd
         Ho7w==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] video: meson: add HDMI fail-save FullHD option
Date: Fri, 15 Jan 2021 16:11:39 +0800
Message-Id: <20210115081139.567155-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

add VIDEO_MESON_HDMI_FAIL_SAVE_FULL_HD configuration option

ABOUT:

Force setup FullHD display mode, if proper timing cant readed.
from display! Its happens for some 4K display, which send
unsupported high timings, but same time can works as FullHD!
Also its will be useful for suspended or disconnected displays.

NOTE: this option disabled by default

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/video/meson/Kconfig     | 10 ++++++++++
 drivers/video/meson/meson_vpu.c | 19 +++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/video/meson/Kconfig b/drivers/video/meson/Kconfig
index 0c9ddeb8..55d67700 100644
--- a/drivers/video/meson/Kconfig
+++ b/drivers/video/meson/Kconfig
@@ -10,3 +10,13 @@ config VIDEO_MESON
 	select DISPLAY
 	help
 	  Enable Amlogic Meson Video Processing Unit video support.
+
+config VIDEO_MESON_HDMI_FAIL_SAVE_FULL_HD
+	bool "Enable HDMI fail-save FullHD mode"
+	depends on VIDEO_MESON
+	default n
+	help
+	  Force setup FullHD display mode, if proper timing cant readed.
+	  from display! Its happens for some 4K display, which send
+	  unsupported high timings, but same time can works as FullHD!
+	  Also its will be useful for suspended or disconnected displays
diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index 4868839f..af677a45 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -52,8 +52,23 @@ static int meson_vpu_setup_mode(struct udevice *dev, struct udevice *disp)
 	if (disp) {
 		ret = display_read_timing(disp, &timing);
 		if (ret) {
-			debug("%s: Failed to read timings\n", __func__);
-			goto cvbs;
+			if (IS_ENABLED(CONFIG_VIDEO_MESON_HDMI_FAIL_SAVE_FULL_HD)) {
+				printf("DISPLAY: setup failsave FullHD mode\n");
+				timing.pixelclock.typ = 148500000;
+				timing.hactive.typ = 1920;
+				timing.hfront_porch.typ = 88;
+				timing.hback_porch.typ = 148;
+				timing.hsync_len.typ = 44;
+				timing.vactive.typ = 1080;
+				timing.vfront_porch.typ = 4;
+				timing.vback_porch.typ = 36;
+				timing.vsync_len.typ = 5;
+				timing.flags = 10;
+				timing.hdmi_monitor = true;
+			} else {
+				debug("%s: Failed to read timings\n", __func__);
+				goto cvbs;
+			}
 		}
 
 		uc_priv->xsize = timing.hactive.typ;
-- 
2.25.1

