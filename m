Received: by mail-wr1-f66.google.com with SMTP id k17so5687356wrx.10
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyeLGZmjVFHbMvWnxcs946gnfHZD6xHvFj7fMPWePqk=;
        b=i0cjo3rl3o58ap95mW+jXmlZhbVYmULfc21oJGBPxNkWFIJvatZMjlbUctFGeFX9vK
         Zie50ZIt8mZAhWiaBS5VPFTCeZ49/DYRJgDV1z1fBhYp0GoyENywSdUprYIlUTLlYchT
         yK6gEkasWWvZ966ILHLfq/66Ra+OU09Q9DT8RpDtOfhJZIOt3XI7kHNppO3pjRSAkwzw
         GsYntkFebsIHhhyMFvaVsFq3fduVFrEXjyE6l3QgBydCyUVVmVxDihv9SQtTpq8rcvlh
         4roIKvyNtURik26edzVGQke1nnZxS3wz8QlW5isBIcf1ZRqV33Cb9OGQa5mt1Op1kV3g
         Pu/Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] reset-meson: Add AXG reset compatible
Date: Tue, 26 Mar 2019 11:25:44 +0100
Message-Id: <20190326102544.10102-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/reset/reset-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 92f04695ec..31aa4d41e8 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -69,6 +69,7 @@ struct reset_ops meson_reset_ops = {
 
 static const struct udevice_id meson_reset_ids[] = {                          
 	{ .compatible = "amlogic,meson-gxbb-reset" },                                  
+	{ .compatible = "amlogic,meson-axg-reset" },
 	{ }                                                                     
 };  
 
-- 
2.21.0

