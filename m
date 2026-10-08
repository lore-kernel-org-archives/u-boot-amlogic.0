Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D461CA6019
	for <webhook@archiver.kernel.org>; Fri,  9 Oct 2026 09:23:14 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16204.1791467834032637132
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 06:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=N1ofVGM9;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: imkyufie@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-49ddddefadbso1168596fac.1
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791467833; x=1792072633; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dn8RF1SlB8ReJPw/P8YPsbYZ55Bt7/tGU57ZmuSD/eE=;
        b=N1ofVGM9+KzHPYRH+t01wvoOgap/hNK4LI0/AVi+CpyC5ayl8WfOBp1F/or5hAoxfi
         NRuma70KdwJ/gSS86OFhjJQ4UIxcUslK6HoOu8cmZ6Dm4scXK9BmERUhP/hUFfyi1VjO
         FByyuqmduXnuOAYcVNSOId9IxJPEUS4JT+V0rulDmTnHAYzfIQd7a8YrCGStxFIpXH00
         G5Qks/pPDquAFuEMZNVDuPZf+7unpartFasZ/UbfoR0GwbGHSLtYSjmMJ5FCyq4lRTrd
         qxfv2yVPTWAQ1qS6QXw1JR4mBBfqvUwbHW11prY5OgxgzoRXBAghoue6ovvQIfCZv6n3
         ztkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467833; x=1792072633;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dn8RF1SlB8ReJPw/P8YPsbYZ55Bt7/tGU57ZmuSD/eE=;
        b=ID0VvlROD5HwDW3aLXmDdhRVVYMG6TwcEFhpiO22O1PGv5B5gglXh3P73zHBidRQLQ
         Dmy+8yMTm6S3y31bUrNmnjpKNMjyx38FS2dPp6Qf/m07tnonhNilBzvZxCa/1Criog2f
         izXYGBK0LRr41iqvAZtLaQDM+w5j6XjBIfeHQNZ2lAQB23vEhslqVYZeBAPbBoNwDLnA
         hb7fFp2bicaFPDR29lXXlRaw9QzbAmB4QxhEXyMr86hPFzv4iNrbkXJZF48XEYCDH1h7
         0RB7qJkobArunv88xmU39uOggHUYatVajqYro7F3EnnOBp9bATRYd0pBviDtURNO0dxX
         dZIQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9X4Nf7EYu/RavfGlxCBQhs0qGT/YtHKVBk2ZyNRiQGwmzmc9F3NNppAhO5Bxm3eTgIU3IfFsMjTJ68YsNPg==@groups.io
X-Gm-Message-State: AFq9FYJYG7BmOBsDF73RFofT1tb5s2FZ+szkxGjZPxhmBbUigKWBP8PQ
	i69SVfJ7Edb4yZOLxUr/q3L8XzDTWVQxubP55wDA9jbvmsrxCJdcAIv7/+qSdw==
X-Gm-Gg: AYBFou3HWCIgoErhK8DU78rUe1Ev7jcJGICHeYGEvpKvZ5hXANEEzH69A8IKRtp+Lnu
	CQFKKveN1Z+MPMPln4IheZWImeQX5dBYN+bQh0Bi2rViVs14BR1jNGOdJBlI6Hfks1cbV6LvHH3
	qCwc0rQ+5Sz6AcXvHShFwj77bG5/cd8vIvHivveRP8oxN7fJJuB/HPek25P0zQ25Ich7izpHQz9
	rTKr4JmO1b/e2JaO/sqWzjgRD22Ie+7hm67xdgu4EfdAX9eaSLItv3h4DZofju00joFs+DN+ZZ6
	NIS4aBgEJSzaY1xaHSH12L0FeRwiu1bJM3tvoOzdzxmcduktCGM/ohmFijK3OUD5QgqkLL81+Ut
	q6lUT4bBRD0AfVvos9mzvM44pwwI+BSyHC0dcs+GUPeVpUNZiKRINcSgXz1OFUbtq7/9rS3LB5r
	LR0ObINLLhZVdSkW0EIKSkmcjKazlIAbkhBSlnDSbFe16WyvIerR1nzftNmW9Y
X-Received: by 2002:a17:903:3910:b0:2dd:c0ff:e727 with SMTP id d9443c01a7336-2e600545a20mr48417325ad.57.1791467527446;
        Thu, 08 Oct 2026 06:52:07 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:8916:e003:1be:df99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046fe391sm25019425ad.29.2026.10.08.06.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:52:06 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Thu, 08 Oct 2026 20:51:38 +0700
Subject: [PATCH] video: use bpp conversion helpers consistently
MIME-Version: 1.0
Message-Id: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBBA0avErBPUQKKrRAvNqSbCxKkIortnt
 XyL/y9gTIQMTXFBwoOY1pChygL6yYYRBfls0FIbJaURLkYx4RIxsfC1N5VTWvraQi5iwoHO79Z
 2v3l3M/bbu4D7fgDGOK8jbwAAAA==
X-Change-ID: 20261006-bpp-helpers-d8d63b120d8a
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Eugen Hristev <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 Oct 2026 09:23:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3125

Use bpp conversion helpers for consistency and to reduce the
reliance on the specially crafted VIDEO_BPP* enum values. No
functional change is made.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 cmd/bdinfo.c                           | 2 +-
 drivers/video/atmel_hlcdfb.c           | 2 +-
 drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
 drivers/video/meson/meson_vpu.c        | 4 ++--
 drivers/video/mvebu_lcd.c              | 2 +-
 drivers/video/sunxi/sunxi_de2.c        | 2 +-
 drivers/video/tegra/dc.c               | 4 ++--
 drivers/video/tegra/tegra124/display.c | 2 +-
 drivers/video/ti/tilcdc.c              | 4 ++--
 drivers/video/tidss/tidss_drv.c        | 4 ++--
 test/cmd/bdinfo.c                      | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

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
diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
index ab36ee159..9039fb2e6 100644
--- a/drivers/video/sunxi/sunxi_de2.c
+++ b/drivers/video/sunxi/sunxi_de2.c
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
index abe31e27d..fd2b92c5e 100644
--- a/drivers/video/tegra/tegra124/display.c
+++ b/drivers/video/tegra/tegra124/display.c
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


