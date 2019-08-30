Received: by mail-wm1-f66.google.com with SMTP id g207so3081199wmg.5
        for <u-boot-amlogic@groups.io>; Fri, 30 Aug 2019 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AcQ/cFG3YG7iA6b4U7bMRYZ5zYmDN1esLt0DsYquyxY=;
        b=nzHm1scC0KdGkaOc7FjO8/D8nbvwbkaAZeOQdZnKGX65nHNU4izZUtSygNHzR8vNaK
         kJ9sYYxpqX7pBAblMnuL5B9EEB57GHk2UBNvc+ZDV/Mfk0meMrW9TiBAe0Y5Z29bny6T
         gY6rAWP1QWz+QLb8lialz7PaNNo0pA2zmXF0Et8kkWBsIDeRFlBEXj387oL8QQvbEapH
         cHYr2jbZkDR/QMjfstUY0UecMImo7IbKRv5jyTn8B5sSI7imeATwBA9+o1HATkuK/JWk
         jf7AGLpQr20JyEV2t0jRDfuhMH7sVyo7aWpbLB3lXjvd0x5kL8BqfwuGPnJXHFA66uN7
         281g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 5/8] video: meson: add compatible for Amlogic G12A
Date: Fri, 30 Aug 2019 14:09:25 +0200
Message-Id: <20190830120928.23890-6-narmstrong@baylibre.com>
In-Reply-To: <20190830120928.23890-1-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, agust@denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Finally add the Amlogic G12A SoC compatible for the VPU driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/video/meson/meson_vpu.c | 1 +
 drivers/video/meson/meson_vpu.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index 34d35749eb..c3af9b013c 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -86,6 +86,7 @@ static const struct udevice_id meson_vpu_ids[] = {
 	{ .compatible = "amlogic,meson-gxbb-vpu", .data = VPU_COMPATIBLE_GXBB },
 	{ .compatible = "amlogic,meson-gxl-vpu", .data = VPU_COMPATIBLE_GXL },
 	{ .compatible = "amlogic,meson-gxm-vpu", .data = VPU_COMPATIBLE_GXM },
+	{ .compatible = "amlogic,meson-g12a-vpu", .data = VPU_COMPATIBLE_G12A },
 	{ }
 };
 
diff --git a/drivers/video/meson/meson_vpu.h b/drivers/video/meson/meson_vpu.h
index 3412dac052..0d9fddad2e 100644
--- a/drivers/video/meson/meson_vpu.h
+++ b/drivers/video/meson/meson_vpu.h
@@ -28,6 +28,7 @@ enum vpu_compatible {
 	VPU_COMPATIBLE_GXBB = 0,
 	VPU_COMPATIBLE_GXL = 1,
 	VPU_COMPATIBLE_GXM = 2,
+	VPU_COMPATIBLE_G12A = 3,
 };
 
 struct meson_vpu_priv {
-- 
2.22.0

