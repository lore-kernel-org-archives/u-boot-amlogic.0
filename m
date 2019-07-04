Received: by mail-wr1-f67.google.com with SMTP id b2so5499142wrx.11
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2019 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwiGuXU951s4yt+UxjjQdhtHcFPb7/GYOeJp+XiRbmI=;
        b=S/C+Qlab+NCiVDgr4iJ5rVf3eGln4oEdQzvkUgECT83O0pr3KE9WYlmgRsLQqt+qAE
         sZNAOLjUu9yMXqJ7u5tjecQuvGMg9ROHO+nXYxI4iZJYarTw9h68mlAx9aQH4QgM14iz
         cJarC84tqlTlVb/rWPjmF7fUoO357JWKo8Tmj66JtIxmWB7G68JjJEhT5VezvfxLZ0pS
         jqEnDuKemVXj9fGzTPbK/5Cbv0OMwm0CMod2oh2mMge/DUCVpp5jyGoUwCouxDBOwN4H
         bnTjnx3Bq98SdYVzAzOdKXu6xhaCLsq8zG0+k+DqXkWQUaF7NCCmPNq3UjtIFr5W+jvB
         6GWQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/3] video: display: use edid_get_timing_validate() variant to filter supported EDID modes
Date: Thu,  4 Jul 2019 15:52:07 +0200
Message-Id: <20190704135208.32104-3-narmstrong@baylibre.com>
In-Reply-To: <20190704135208.32104-1-narmstrong@baylibre.com>
References: <20190704135208.32104-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Introduce a new display op, mode_valid() to be used with the newly
introduced edid_get_timing_validate() function, to filter supported
monitor timings if handled by the display driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/video/display-uclass.c | 15 ++++++++++++++-
 include/display.h              | 10 ++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/video/display-uclass.c b/drivers/video/display-uclass.c
index 99ef5e76f5..1a29ce5d85 100644
--- a/drivers/video/display-uclass.c
+++ b/drivers/video/display-uclass.c
@@ -37,6 +37,17 @@ int display_enable(struct udevice *dev, int panel_bpp,
 	return 0;
 }
 
+static bool display_mode_valid(void *priv, const struct display_timing *timing)
+{
+	struct udevice *dev = priv;
+	struct dm_display_ops *ops = display_get_ops(dev);
+
+	if (ops && ops->mode_valid)
+		return ops->mode_valid(dev, timing);
+
+	return true;
+}
+
 int display_read_timing(struct udevice *dev, struct display_timing *timing)
 {
 	struct dm_display_ops *ops = display_get_ops(dev);
@@ -53,7 +64,9 @@ int display_read_timing(struct udevice *dev, struct display_timing *timing)
 	if (ret < 0)
 		return ret;
 
-	return edid_get_timing(buf, ret, timing, &panel_bits_per_colour);
+	return edid_get_timing_validate(buf, ret, timing,
+					&panel_bits_per_colour,
+					display_mode_valid, dev);
 }
 
 bool display_in_use(struct udevice *dev)
diff --git a/include/display.h b/include/display.h
index 16f317c9c8..66294616ea 100644
--- a/include/display.h
+++ b/include/display.h
@@ -80,6 +80,16 @@ struct dm_display_ops {
 	 */
 	int (*enable)(struct udevice *dev, int panel_bpp,
 		      const struct display_timing *timing);
+
+	/**
+	 * mode_valid() - Check if mode is supported
+	 *
+	 * @dev:	Device to enable
+	 * @timing:	Display timings
+	 * @return true if supported, false if not
+	 */
+	bool (*mode_valid)(struct udevice *dev,
+			   const struct display_timing *timing);
 };
 
 #define display_get_ops(dev)	((struct dm_display_ops *)(dev)->driver->ops)
-- 
2.21.0

