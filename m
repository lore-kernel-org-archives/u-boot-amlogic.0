Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.446.1582607427326416631
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Feb 2020 21:10:27 -0800
Received: by mail-wr1-f65.google.com with SMTP id u6so13107032wrt.0
        for <u-boot-amlogic@groups.io>; Mon, 24 Feb 2020 21:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qquyljQ4ZPf+qj0RAerkiHXg0k3ZWtO3CZwbda5Dpnw=;
        b=GaCY98YA+O1d/SiiQGG/jv/yLaxenFbSPuaBZQDY4dPVBHVKNjtgMhXy9b1JWNMrRr
         6f309/Ds0XDMfg2Om0WlERsHBNu+OzPYgFfuRZSQmibTAP53hhFS58pYDU6JP5czCkgD
         iQ4vHnyb4fzHzTK5NlXpA09WpIF45yNjT7cKM=
Return-Path: <michael@amarulasolutions.com>
From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/2] video: meson: Use reserving memory function without kernel linear mapping
Date: Tue, 25 Feb 2020 06:10:21 +0100
Message-Id: <20200225051021.15311-3-michael@amarulasolutions.com>
In-Reply-To: <20200225051021.15311-1-michael@amarulasolutions.com>
References: <20200225051021.15311-1-michael@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Memory reserved for the simple framebuffer should not be used
and part of memory linear mapping. See
https://patchwork.kernel.org/patch/10486131/ for more detailed
background information and discussion.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes RFC -> v1:
	- Fix compilation issue on RFC
	- change node name from display_reserved to display-reserved
---
 drivers/video/meson/meson_vpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index 4eb66398d0..5bfad05d75 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -173,9 +173,9 @@ static void meson_vpu_setup_simplefb(void *fdt)
 	 * at the end of the RAM and we strip this portion from the kernel
 	 * allowed region
 	 */
-	mem_start = gd->bd->bi_dram[0].start;
-	mem_size = gd->bd->bi_dram[0].size - meson_fb.fb_size;
-	ret = fdt_fixup_memory_banks(fdt, &mem_start, &mem_size, 1);
+	mem_start = meson_fb.base;
+	mem_size = meson_fb.fb_size;
+	ret = fdt_fixup_reserved_memory(fdt, "display-reserved", &mem_start, &mem_size);
 	if (ret) {
 		eprintf("Cannot setup simplefb: Error reserving memory\n");
 		return;
-- 
2.17.1

