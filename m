Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B45CC6B38
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 07:19:57 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16119.1792132729359147684
 for <u-boot-amlogic@groups.io>;
 Thu, 15 Oct 2026 23:38:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HYZRhV1p;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: imkyufie@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91b813ac020so77190856d6.3
        for <u-boot-amlogic@groups.io>; Thu, 15 Oct 2026 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792132728; x=1792737528; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rc+W73lTbahODgOogceftDxGGpq7Jo4OU0zm0qbwLJ8=;
        b=HYZRhV1pklEexiUN6B+J98qdJAO2qu+nF9+RgXkEIOXaEYwEpfwWq/9p22PyVDj5s/
         /O0ZnP6CeRORdACJNJ9lMXHWOSJCtA5BdNbXAnzcykcwQc6gSYITuYT6XKl4lT0qp03j
         xMgti8oqN22dwzM7gSr4M9YjLkYSAV7GdE/ayh6LHNj+0ZCuxg8JzMk117w1k25DswFq
         AOiYdpY6NGXVQVu0cK/+2ySOJUqyFZAWJv6mNmn2HHdSay0Y+Z8e9YYj6lCGKXg1m9a1
         AGiEzeUzTs+C4+9oWgi8p6HUC8PkLsE9s7f1NTpk7G47ITNZ62bEUf/p2x6HjM39fk23
         BLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792132728; x=1792737528;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rc+W73lTbahODgOogceftDxGGpq7Jo4OU0zm0qbwLJ8=;
        b=lr01nQZmakQqW8EixIPHkZwAmsJhDcEC0mGvzf0mfSdhV7QSKmkZZUlBr8Uj02tsEb
         jVGFZXbpFwVSBxIqFnjiRxKIGibw7bh0qY9YAh5go3iODXZePPOl9dC5yegUELADlEQl
         qIXCYKdu8+6C3Ra//SpsI8k4zk5qJUG0ISGvU2jPyGZKaW4RWWQO65TZ0ihm4MzgO/c5
         FDOqnOZj3QECJxylehjfF2OmwNOjjs+cdpfe81LfN7aIjaotrlpJk7foyZD2kWm5SxtU
         +ftoIt3Wb5ZZAWPSOxSJQDXvuhtdVjwiWJfyAqJ2XQXZQiqHxS033Qz4KHrNYnb+EUrs
         cXXA==
X-Forwarded-Encrypted: i=1; AKwUvBwXtJbmsiVJC5OXbFGA5WUKFXmRrKWseUkvmtzjyURhcTxaIL+ss8m2VwSMeFpTB2xKdJQq3kUJx9cBm8ZgEw==@groups.io
X-Gm-Message-State: AFq9FYLBCcOdj3oBHOAU0q8Fuzo1XoE4HQVUceDT5nY3Uz8N6kX1dIp6
	/wuPMo6wsIeEe1KeqYfxyr//PbqUbQfNB8hMwVRfqF4K7DwT08g4Yddw/wSG1Q==
X-Gm-Gg: AYBFou0CdMFmFXcDO+VRlI6a6ErX46pgYgaO4nECC/JBySxPVjPt+vd9jpXis13YTCt
	i2fmatEcNlp3R/CK2qYZlVWtDaBdii3h7/wM7Y5CCvLtGFolDjZJk/Bb2uk4hRl1KFCL7nm6uLC
	NwURcIyDwfsMLoJRS8UBDT2zh3QSqZVl1cW+hMMqR1KmrrEk/h5EzFceSQmK1r4lmyrLxhW1cH5
	t8iFM0jCNKvsTvBuD73/IPmxCRB7OiKZqqanKU+LxE7WMyQH8r3IQd2TpCaRm8UHNuShKrNNww8
	3Pr7fvRYAVyR4qkEY+GG3Lca8U8Vr6P9AbBx/B8Di5j0IpLsJNx4FgXPSlpm271Tp5zfZiwr300
	79YS62CTQ4Gic9QaSlAfGc69mddz9Do/lJBLP4GedSot6bA4e7S2iFpzyFQRnXW7bqqPT1AxJJ9
	Yv1Y/qnQ078brivIj0c1sE4ZyXtrIRIWge5UQYnktiI/921wFR435kMwczMgSOb1k=
X-Received: by 2002:a05:6a00:c591:20b0:89d:eb23:4e83 with SMTP id d2e1a72fcca58-89deb234f8amr4195039b3a.30.1792132283254;
        Thu, 15 Oct 2026 23:31:23 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:4ee1:1a8a:57cd:4423])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89febdc2209sm84691b3a.33.2026.10.15.23.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:31:22 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Fri, 16 Oct 2026 13:30:48 +0700
Subject: [PATCH v2] video: use bpp conversion helpers consistently
MIME-Version: 1.0
Message-Id: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ6CMBBFr0JmbU2nCCIr72FY0HaEMUCbFomGc
 HcB48LlS95/f4ZIgSlCmcwQaOLIblhBHRIwbT00JNiuDEqqHKXMhfZetNR5ClHYwuapRiVtUcO
 68IHu/Nprt+rL8akfZMYtsRktx9GF93434eb9ysVfeUKB4nTOLGqVYWou16avuTsa10O1LMsHY
 F4gyLgAAAA=
X-Change-ID: 20261006-bpp-helpers-d8d63b120d8a
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Eugen Hristev <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 16 Oct 2026 07:19:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3134

Many places open-code the conversion between log2 bits-per-pixel and
the actual number of bits or bytes per pixel, using expressions such as
"1 << bpix", "(1 << bpix) / 8" and "((1 << bpix) >> 3)". Meanwhile,
<video.h> already provides VNBITS() and VNBYTES() helpers for exactly
these conversions. Replace the open-coded expressions with the helpers.

Using the helpers makes the intent of the expression clear, removes
duplicated bit manipulation, and reduces the reliance on the specially
crafted VIDEO_BPP* enum values, since callers no longer need to know
that those values are log2 quantities which is also important for
future extensions.

Note that VNBYTES() is only correct for 8bpp and above, since it returns
a whole number of bytes per pixel and cannot represent sub-byte pixel
sizes. Every site converted to VNBYTES() here uses 16bpp or 32bpp, so
the result is identical to the original expression.

No functional change is made.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
Changes in v2:
- Convert uncaught conversion cases in the following files:
  - arch/sandbox/cpu/sdl.c
  - boot/fdt_simplefb.c
  - drivers/video/atmel_lcdfb.c
  - drivers/video/rockchip/rk_vop.c
  - drivers/video/sunxi/sunxi_de2.c
  - drivers/video/tegra/tegra124/display.c
- Updated commit message
- Link to v1: https://patch.msgid.link/20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com
---
 arch/sandbox/cpu/sdl.c                 | 4 ++--
 boot/fdt_simplefb.c                    | 2 +-
 cmd/bdinfo.c                           | 2 +-
 drivers/video/atmel_hlcdfb.c           | 2 +-
 drivers/video/atmel_lcdfb.c            | 4 ++--
 drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
 drivers/video/meson/meson_vpu.c        | 4 ++--
 drivers/video/mvebu_lcd.c              | 2 +-
 drivers/video/rockchip/rk_vop.c        | 4 ++--
 drivers/video/sunxi/sunxi_de2.c        | 8 ++++----
 drivers/video/tegra/dc.c               | 4 ++--
 drivers/video/tegra/tegra124/display.c | 4 ++--
 drivers/video/ti/tilcdc.c              | 4 ++--
 drivers/video/tidss/tidss_drv.c        | 4 ++--
 test/cmd/bdinfo.c                      | 2 +-
 15 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/sandbox/cpu/sdl.c b/arch/sandbox/cpu/sdl.c
index ed84646bd..ff823fb72 100644
--- a/arch/sandbox/cpu/sdl.c
+++ b/arch/sandbox/cpu/sdl.c
@@ -152,10 +152,10 @@ int sandbox_sdl_init_display(int width, int height, int log2_bpp,
 	if (!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1"))
 		printf("Unable to init hinting: %s", SDL_GetError());
 
-	sdl.src_depth = 1 << log2_bpp;
+	sdl.src_depth = VNBITS(log2_bpp);
 	if (log2_bpp != 4 && log2_bpp != 5)
 		log2_bpp = 5;
-	sdl.depth = 1 << log2_bpp;
+	sdl.depth = VNBITS(log2_bpp);
 	sdl.pitch = sdl.width * sdl.depth / 8;
 	sdl.screen = SDL_CreateWindow("U-Boot", SDL_WINDOWPOS_UNDEFINED,
 				      SDL_WINDOWPOS_UNDEFINED, sdl.vis_width,
diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 69c7c2e24..9b7ffe9ff 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -59,7 +59,7 @@ static int fdt_simplefb_configure_node(void *blob, int off)
 	}
 
 	return fdt_setup_simplefb_node(blob, off, fb_base, xsize, ysize,
-				       xsize * (1 << bpix) / 8, name);
+				       xsize * VNBYTES(bpix), name);
 }
 
 int fdt_simplefb_add_node(void *blob)
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index bf1eca759..37981764b 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -114,7 +114,7 @@ static void show_video_info(void)
 						   plat->copy_size);
 			}
 			printf("%-12s= %dx%dx%d\n", "FB size", upriv->xsize,
-			       upriv->ysize, 1 << upriv->bpix);
+			       upriv->ysize, VNBITS(upriv->bpix));
 		}
 	}
 }
diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.c
index 89bc0eeb6..8a0096cec 100644
--- a/drivers/video/atmel_hlcdfb.c
+++ b/drivers/video/atmel_hlcdfb.c
@@ -315,7 +315,7 @@ static int atmel_hlcdc_bind(struct udevice *dev)
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-				(1 << LCD_MAX_LOG2_BPP) / 8;
+				VNBYTES(LCD_MAX_LOG2_BPP);
 
 	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
 
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 281c3a1d6..29a24b8cd 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -69,7 +69,7 @@ static void atmel_fb_init(ulong addr, struct display_timing *timing, int bpix,
 
 	/* ...set frame size and burst length = 8 words (?) */
 	value = (timing->hactive.typ * timing->vactive.typ *
-		 (1 << bpix)) / 32;
+		 VNBITS(bpix)) / 32;
 	value |= ((ATMEL_LCDC_DMA_BURST_LEN - 1) << ATMEL_LCDC_BLENGTH_OFFSET);
 	lcdc_writel(reg, ATMEL_LCDC_DMAFRMCFG, value);
 
@@ -187,7 +187,7 @@ static int atmel_fb_lcd_bind(struct udevice *dev)
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-			(1 << VIDEO_BPP16) / 8;
+			VNBYTES(VIDEO_BPP16);
 	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
 
 	return 0;
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index 3a327b9e9..447644f5b 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -654,7 +654,7 @@ static int ipuv3_video_bind(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
-	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT * (1 << VIDEO_BPP32) / 8;
+	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT * VNBYTES(VIDEO_BPP32);
 
 	return 0;
 }
diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index a686faf9f..21ac60749 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -79,7 +79,7 @@ cvbs:
 
 	/* Move the framebuffer to the end of addressable ram */
 	meson_fb.fb_size = ALIGN(meson_fb.xsize * meson_fb.ysize *
-				 ((1 << VPU_MAX_LOG2_BPP) / 8) +
+				 VNBYTES(VPU_MAX_LOG2_BPP) +
 				 MESON_VPU_OVERSCAN, EFI_PAGE_SIZE);
 	meson_fb.base = gd->dram[0].start +
 			gd->dram[0].size - meson_fb.fb_size;
@@ -141,7 +141,7 @@ static int meson_vpu_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = VPU_MAX_WIDTH * VPU_MAX_HEIGHT *
-		(1 << VPU_MAX_LOG2_BPP) / 8;
+		VNBYTES(VPU_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/mvebu_lcd.c b/drivers/video/mvebu_lcd.c
index 9f1ea9c35..234b27c90 100644
--- a/drivers/video/mvebu_lcd.c
+++ b/drivers/video/mvebu_lcd.c
@@ -576,7 +576,7 @@ static int mvebu_video_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index 17dfe62c9..b8f56d94e 100644
--- a/drivers/video/rockchip/rk_vop.c
+++ b/drivers/video/rockchip/rk_vop.c
@@ -381,9 +381,9 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 		return ret;
 	}
 
-	rkvop_enable(dev, fbbase, 1 << l2bpp, &timing, &dclk_rst);
+	rkvop_enable(dev, fbbase, VNBITS(l2bpp), &timing, &dclk_rst);
 
-	ret = display_enable(disp, 1 << l2bpp, &timing);
+	ret = display_enable(disp, VNBITS(l2bpp), &timing);
 	if (ret)
 		return ret;
 
diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
index ab36ee159..2fec6a8ab 100644
--- a/drivers/video/sunxi/sunxi_de2.c
+++ b/drivers/video/sunxi/sunxi_de2.c
@@ -202,9 +202,9 @@ static int sunxi_de2_init(struct udevice *dev, ulong fbbase,
 	}
 
 	sunxi_de2_composer_init();
-	sunxi_de2_mode_set(mux, &timing, 1 << l2bpp, fbbase, is_composite);
+	sunxi_de2_mode_set(mux, &timing, VNBITS(l2bpp), fbbase, is_composite);
 
-	ret = display_enable(disp, 1 << l2bpp, &timing);
+	ret = display_enable(disp, VNBITS(l2bpp), &timing);
 	if (ret) {
 		debug("%s: Failed to enable display\n", __func__);
 		return ret;
@@ -218,7 +218,7 @@ static int sunxi_de2_init(struct udevice *dev, ulong fbbase,
 #ifdef CONFIG_EFI_LOADER
 	efi_add_memory_map(fbbase,
 			   timing.hactive.typ * timing.vactive.typ *
-			   (1 << l2bpp) / 8,
+			   VNBYTES(l2bpp),
 			   EFI_RESERVED_MEMORY_TYPE);
 #endif
 
@@ -279,7 +279,7 @@ static int sunxi_de2_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/tegra/dc.c b/drivers/video/tegra/dc.c
index ced497188..6aca106f1 100644
--- a/drivers/video/tegra/dc.c
+++ b/drivers/video/tegra/dc.c
@@ -278,7 +278,7 @@ static int setup_window(struct tegra_lcd_priv *priv,
 	win->out_w = priv->width;
 	win->out_h = priv->height;
 	win->phys_addr = priv->frame_buffer;
-	win->stride = priv->width * (1 << priv->log2_bpp) / 8;
+	win->stride = priv->width * VNBYTES(priv->log2_bpp);
 
 	log_debug("%s: depth = %d\n", __func__, priv->log2_bpp);
 
@@ -646,7 +646,7 @@ static int tegra_lcd_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return dm_scan_fdt_dev(dev);
 }
diff --git a/drivers/video/tegra/tegra124/display.c b/drivers/video/tegra/tegra124/display.c
index abe31e27d..6d485736e 100644
--- a/drivers/video/tegra/tegra124/display.c
+++ b/drivers/video/tegra/tegra124/display.c
@@ -448,7 +448,7 @@ static int tegra124_lcd_init(struct udevice *dev, void *lcdbase,
 	reset_set_enable(PERIPH_ID_DPAUX, 0);
 	reset_set_enable(PERIPH_ID_SOR0, 0);
 
-	ret = display_init(dev, lcdbase, 1 << l2bpp, &timing);
+	ret = display_init(dev, lcdbase, VNBITS(l2bpp), &timing);
 	if (ret)
 		return ret;
 
@@ -484,7 +484,7 @@ static int tegra124_lcd_bind(struct udevice *dev)
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-			(1 << VIDEO_BPP16) / 8;
+			VNBYTES(VIDEO_BPP16);
 	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
 
 	return 0;
diff --git a/drivers/video/ti/tilcdc.c b/drivers/video/ti/tilcdc.c
index b498e8186..6b2e591ce 100644
--- a/drivers/video/ti/tilcdc.c
+++ b/drivers/video/ti/tilcdc.c
@@ -430,8 +430,8 @@ static int tilcdc_bind(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
-	uc_plat->size = ((LCDC_MAX_WIDTH * LCDC_MAX_HEIGHT *
-			  (1 << LCDC_MAX_LOG2_BPP)) >> 3) + 0x20;
+	uc_plat->size = LCDC_MAX_WIDTH * LCDC_MAX_HEIGHT *
+			VNBYTES(LCDC_MAX_LOG2_BPP) + 0x20;
 
 	dev_dbg(dev, "frame buffer size 0x%x\n", uc_plat->size);
 	return 0;
diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
index c231fd034..7c8bfe418 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -986,8 +986,8 @@ static int tidss_drv_bind(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
-	uc_plat->size = ((LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-			  (1 << LCD_MAX_LOG2_BPP)) >> 3) + 0x20;
+	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
+			VNBYTES(LCD_MAX_LOG2_BPP) + 0x20;
 	return 0;
 }
 
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 7b7fb0894..f53665446 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -91,7 +91,7 @@ static int test_video_info(struct unit_test_state *uts)
 			}
 			ut_assert_nextline("%-12s= %dx%dx%d", "FB size",
 					   upriv->xsize, upriv->ysize,
-					   1 << upriv->bpix);
+					   VNBITS(upriv->bpix));
 		}
 	}
 

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261006-bpp-helpers-d8d63b120d8a

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>


