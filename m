Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
 by mx.groups.io with SMTP id smtpd.web12.5651.1572191721524301313
 for <u-boot-amlogic@groups.io>;
 Sun, 27 Oct 2019 08:55:21 -0700
Received: by mail-il1-f195.google.com with SMTP id h5so2604895ilh.11
        for <u-boot-amlogic@groups.io>; Sun, 27 Oct 2019 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yo7it+q/6+9ZB/PjkPwSdzylweXnUrpL/nTgqZzaEKA=;
        b=F0MpRJ52kAgxIg3ICM8uJ9WDRGoCAydMd+tT93rFD7ZF9QO1dvBcT/hmZbMcN3yPmq
         vKRF4/M65aQUXt2Av2qvYJ3QWFFHyjmCZWnG6IagrKHPN0DxLXYCu4P+bYkhfgoDz+KF
         0EETgE4LBL91BKKAXqPRZVQRnGnngGYPjrYRs=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH 23/30] video: meson: Drop unnecessary header includes
Date: Sun, 27 Oct 2019 09:54:03 -0600
Message-Id: <20191027155410.187957-23-sjg@chromium.org>
In-Reply-To: <20191027155410.187957-1-sjg@chromium.org>
References: <20191027155410.187957-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

These files should not be included in meson header files. Drop them and
tidy up the affected C files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/meson/meson_canvas.c   |  4 ++++
 drivers/video/meson/meson_plane.c    |  5 +++++
 drivers/video/meson/meson_vclk.c     |  2 ++
 drivers/video/meson/meson_venc.c     |  4 ++++
 drivers/video/meson/meson_vpu.c      | 18 +++++++++++++++---
 drivers/video/meson/meson_vpu.h      | 17 +++++------------
 drivers/video/meson/meson_vpu_init.c |  4 ++++
 include/video.h                      |  2 ++
 8 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/video/meson/meson_canvas.c b/drivers/video/meson/meson_canvas.c
index b71cbfcc0b..eccac2f8f2 100644
--- a/drivers/video/meson/meson_canvas.c
+++ b/drivers/video/meson/meson_canvas.c
@@ -6,6 +6,10 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
+#include <common.h>
+#include <dm.h>
+#include <asm/io.h>
+
 #include "meson_vpu.h"
 
 /* DMC Registers */
diff --git a/drivers/video/meson/meson_plane.c b/drivers/video/meson/meson_plane.c
index 2bc9327e1e..8edf451f13 100644
--- a/drivers/video/meson/meson_plane.c
+++ b/drivers/video/meson/meson_plane.c
@@ -6,6 +6,11 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
+#include <common.h>
+#include <dm.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+
 #include "meson_vpu.h"
 
 /* OSDx_BLKx_CFG */
diff --git a/drivers/video/meson/meson_vclk.c b/drivers/video/meson/meson_vclk.c
index 0f628e920b..01bfa4bcb8 100644
--- a/drivers/video/meson/meson_vclk.c
+++ b/drivers/video/meson/meson_vclk.c
@@ -6,6 +6,8 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
+#include <common.h>
+#include <dm.h>
 #include <edid.h>
 #include "meson_vpu.h"
 #include <linux/iopoll.h>
diff --git a/drivers/video/meson/meson_venc.c b/drivers/video/meson/meson_venc.c
index 5da4b3f096..89e859b02a 100644
--- a/drivers/video/meson/meson_venc.c
+++ b/drivers/video/meson/meson_venc.c
@@ -6,7 +6,11 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
+#include <common.h>
+#include <dm.h>
 #include <edid.h>
+#include <fdtdec.h>
+#include <asm/io.h>
 #include "meson_vpu.h"
 
 enum {
diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index c3af9b013c..4eb66398d0 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -6,13 +6,17 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson_vpu.h"
+#include <common.h>
+#include <display.h>
+#include <dm.h>
 #include <efi_loader.h>
-#include <dm/device-internal.h>
-#include <dm/uclass-internal.h>
 #include <fdt_support.h>
 #include <linux/sizes.h>
 #include <asm/arch/mem.h>
+#include <dm/device-internal.h>
+#include <dm/uclass-internal.h>
+
+#include "meson_vpu.h"
 #include "meson_registers.h"
 #include "simplefb_common.h"
 
@@ -27,6 +31,14 @@ static struct meson_framebuffer {
 	bool is_cvbs;
 } meson_fb = { 0 };
 
+bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
+			     enum vpu_compatible family)
+{
+	enum vpu_compatible compat = dev_get_driver_data(priv->dev);
+
+	return compat == family;
+}
+
 static int meson_vpu_setup_mode(struct udevice *dev, struct udevice *disp)
 {
 	struct video_uc_platdata *uc_plat = dev_get_uclass_platdata(dev);
diff --git a/drivers/video/meson/meson_vpu.h b/drivers/video/meson/meson_vpu.h
index 0d9fddad2e..d9588c3775 100644
--- a/drivers/video/meson/meson_vpu.h
+++ b/drivers/video/meson/meson_vpu.h
@@ -9,14 +9,12 @@
 #ifndef __MESON_VPU_H__
 #define __MESON_VPU_H__
 
-#include <common.h>
-#include <dm.h>
 #include <video.h>
-#include <display.h>
-#include <linux/io.h>
-#include <linux/bitfield.h>
 #include "meson_registers.h"
 
+struct display_timing;
+struct udevice;
+
 enum {
 	/* Maximum size we support */
 	VPU_MAX_WIDTH		= 3840,
@@ -38,13 +36,8 @@ struct meson_vpu_priv {
 	void __iomem *dmc_base;
 };
 
-static inline bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
-					   enum vpu_compatible family)
-{
-	enum vpu_compatible compat = dev_get_driver_data(priv->dev);
-
-	return compat == family;
-}
+bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
+			     enum vpu_compatible family);
 
 #define hhi_update_bits(offset, mask, value) \
 	writel_bits(mask, value, priv->hhi_base + offset)
diff --git a/drivers/video/meson/meson_vpu_init.c b/drivers/video/meson/meson_vpu_init.c
index 12f8c4194a..8408c59eaa 100644
--- a/drivers/video/meson/meson_vpu_init.c
+++ b/drivers/video/meson/meson_vpu_init.c
@@ -8,6 +8,10 @@
 
 #define DEBUG
 
+#include <common.h>
+#include <dm.h>
+#include <asm/io.h>
+
 #include "meson_vpu.h"
 
 /* HHI Registers */
diff --git a/include/video.h b/include/video.h
index 485071d072..e7c58e86cb 100644
--- a/include/video.h
+++ b/include/video.h
@@ -17,6 +17,8 @@
 
 #include <stdio_dev.h>
 
+struct udevice;
+
 struct video_uc_platdata {
 	uint align;
 	uint size;
-- 
2.24.0.rc0.303.g954a862665-goog

