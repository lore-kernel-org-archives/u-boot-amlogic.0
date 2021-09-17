Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web09.9410.1631864234118687749
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Sep 2021 00:37:15 -0700
Received: by mail-wr1-f54.google.com with SMTP id g16so13601974wrb.3
        for <u-boot-amlogic@groups.io>; Fri, 17 Sep 2021 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoFjSCLZwSXmxyHhhk/Ax597M/UUEWobKLtvTw4CaqY=;
        b=dmbARtsKvcnC0PvCe6WWtvhWpdCe3zEhMfbwMumIStKvLHhL/Zdwssf5XS4Nzq2Evp
         VtJ+Bf4X37V3r5fBn0gAUCyPH+CySdF8fNnKJSdTc7tdPdmcuBVJpcxt/cGZDT5HMqSJ
         Oa6tZN8tcmL0fN3PAIdLqDxWsmfB5/ne6nPVxQlJaDOoPNOUyO9i72v2KOFFfyLnOkOM
         nhpNHNWkxezZQTB/EzMkX6ZWcZtC+Eda7qFsxYryP+qf4wdYoItBku0ScpJoLkURTKIn
         9O2a7HXQKklUFaR3EE3pnEPd7/2+6OhLfSXdZ02SEKeZ0jl+LfbiBGjovpxhl9MQ5+FA
         h4Pw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 02/10] usb: dwc3: meson-gxl: add AXG compatible
Date: Fri, 17 Sep 2021 09:37:01 +0200
Message-Id: <20210917073709.1052133-2-narmstrong@baylibre.com>
In-Reply-To: <20210917073709.1052133-1-narmstrong@baylibre.com>
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Vyacheslav Bocharov <adeep@lexina.in>
List-ID: <u-boot-amlogic@groups.io>

Upstream Linux uses the "amlogic,meson-axg-usb-ctrl" for AXG SoCs.

This adds it to the compatible list for this driver.

Reported-by: Vyacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-gxl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 08467d6210..b8f3886173 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -409,6 +409,7 @@ static int dwc3_meson_gxl_remove(struct udevice *dev)
 }
 
 static const struct udevice_id dwc3_meson_gxl_ids[] = {
+	{ .compatible = "amlogic,meson-axg-usb-ctrl" },
 	{ .compatible = "amlogic,meson-gxl-usb-ctrl" },
 	{ .compatible = "amlogic,meson-gxm-usb-ctrl" },
 	{ }
-- 
2.25.1

