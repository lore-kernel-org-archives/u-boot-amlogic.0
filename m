Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.23270.1669218188952643614
 for <u-boot-amlogic@groups.io>;
 Wed, 23 Nov 2022 07:43:09 -0800
Received: by mail-wr1-f44.google.com with SMTP id cl5so29999304wrb.9
        for <u-boot-amlogic@groups.io>; Wed, 23 Nov 2022 07:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIupqewB2A8enZm8wo1bMl7ZZ/RxUc2BAe8Gk+tpkxY=;
        b=Tx/2Qpm6niar6xhjLyd3H5S4kaCkeeyP0AQBQOp5+REGyh0ylNUmoC4qpv7zLTeZhQ
         +uiZYnhi4IZdLt2WRHEouLe1FhDLcIglz2RoyXIXQOLW8EEz4+bONf4fJMIkPCR+I5Sy
         Lv6Tq3pltb3MtPEeCHcBq9Dd+TcwPDIx2yxlZO8iHDeTn8247K6an5IWDqk66KQOulNu
         LXB2+S5GPKhpDrY7cNVdHwy0Um//2SqgGKegLFSAsdKZ7QOpCjmMiYGPMrd1CuzERFXq
         SxcPvvezJ7VNizKtUpAkitzh/HDlMpR1mrgQi4qeHuREH2O/6/m101X2EFY35seBf1NZ
         wKFQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Date: Wed, 23 Nov 2022 16:42:49 +0100
Subject: [PATCH 1/2] usb: dwc3-meson-g12a: force mode on child add/removal
MIME-Version: 1.0
Message-Id: <20221024-meson-dm-usb-v1-1-2ab077a503b9@baylibre.com>
References: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
In-Reply-To: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <neil.armstrong@linaro.org>, Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

arch/mach-meson has some custom usb logic, in particular:
* on board_usb_init(), we force USB_DR_MODE_PERIPHERAL
* on board_usb_cleanup(), we force USB_DR_MODE_HOST

With DM_USB_GADGET=y, board_usb_init/cleanup() are no
longer used when we call usb_gadget_initialize().
Instead, the generic (from udc-uclass) initialization/release is
called, which itself calls the controller driver's probe()/remove().

Therefore, enabling DM_USB_GADGET=y will mean that this mode
switching will break.

To prepare for enabling DM_USB_GADGET, perform the mode switching
when the "amlogic,meson-g12a-usb" (dwc2) driver is
probed()/removed() instead.

This is achieved via the glue driver, which gets notified each time one
of its children is probed()/removed.

Note: this change should be harmless without DM_USB_GADGET=y
because the amlogic-g12a-usb driver is not probed via driver model.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 90418ddc1dab..c62e42de73f7 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -455,6 +455,22 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
 
+static int dwc3_meson_g12a_child_pre_probe(struct udevice *dev)
+{
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-g12a-usb"))
+		return dwc3_meson_g12a_force_mode(dev->parent, USB_DR_MODE_PERIPHERAL);
+
+	return 0;
+}
+
+static int dwc3_meson_g12a_child_post_remove(struct udevice *dev)
+{
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-g12a-usb"))
+		return dwc3_meson_g12a_force_mode(dev->parent, USB_DR_MODE_HOST);
+
+	return 0;
+}
+
 static const struct udevice_id dwc3_meson_g12a_ids[] = {
 	{ .compatible = "amlogic,meson-g12a-usb-ctrl" },
 	{ }
@@ -466,6 +482,8 @@ U_BOOT_DRIVER(dwc3_generic_wrapper) = {
 	.of_match = dwc3_meson_g12a_ids,
 	.probe = dwc3_meson_g12a_probe,
 	.remove = dwc3_meson_g12a_remove,
+	.child_pre_probe = dwc3_meson_g12a_child_pre_probe,
+	.child_post_remove = dwc3_meson_g12a_child_post_remove,
 	.plat_auto	= sizeof(struct dwc3_meson_g12a),
 
 };

-- 
b4 0.10.1
