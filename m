Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web08.5070.1620204115172029386
 for <u-boot-amlogic@groups.io>;
 Wed, 05 May 2021 01:41:55 -0700
Received: by mail-wm1-f41.google.com with SMTP id l24-20020a7bc4580000b029014ac3b80020so2914260wmi.1
        for <u-boot-amlogic@groups.io>; Wed, 05 May 2021 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSBZFLrkO4bRgaq/RwJ1ZGVkf0QEoOwjCn5y1DIy6Kk=;
        b=UpnzVl4aZTYYsOdN976CT7NVzQzNDWjPd1jgTTWVhsbc6jD8JD704C1g/7h2BxL98e
         t1+o8iODm2BKtM57k+Kr5gEd0lnrbRHxKWJZ31LPInBIRRgyOvxnNac8Cl8rd6y7v1zy
         WseOJeIhOCyAS+Un7zOKkE5PdVtIVcBVi//vXOWxSD/NA4JR2h5ykrIeKQ5avmYEU76F
         OoVCd1iyY+QMydXtMZX3xUWWbt0b6VpWHxD4TmiRxelMYFh2mG6v9CDeKx6GDW+hzBAG
         cqmRT1n254PQI46Q6Ynpg8Yc4SdhXT0jcdMYRQXwTKujpH8thCYmvhjSjGyMbYiqtT1/
         wTyA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] usb: dwc3-meson-g12a: skip phy on -ENODATA aswell
Date: Wed,  5 May 2021 10:41:50 +0200
Message-Id: <20210505084150.3862010-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

If the PHY isn't specified in the DT, -ENODATA means it should be skipped,
handle it like -ENOENT.

With that, devices without USB3 supported can have USB working (Odroid-HC4).

Fixes: adb049abf7 ("usb: dwc3: Add Meson G12A USB Glue")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index bd8bf227c8..90418ddc1d 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -298,7 +298,7 @@ static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = generic_phy_get_by_name(priv->dev, phy_names[i],
 					      &priv->phys[i]);
-		if (ret == -ENOENT)
+		if (ret == -ENOENT || ret == -ENODATA)
 			continue;
 
 		if (ret)
-- 
2.25.1

