Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.192338.1673946711035838320
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jan 2023 01:11:51 -0800
Received: by mail-wm1-f45.google.com with SMTP id k16so1049185wms.2
        for <u-boot-amlogic@groups.io>; Tue, 17 Jan 2023 01:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eDO8coD4YDnAYZyi8dwFLbs2H58cSViybgQ0P3IFyQ=;
        b=o0S1gx3oBv3Mi9H5rDrMVYzHcVq5bJehpHmQUx2UGepHVLI56GLHIGLJtPMwxu3CJJ
         N2GvkQbbZepBaIlrh9OH/IyQ3cGGgmqSs/QW9jLknCu4ECBWZVx3V8kBKsfQYDfkDiPM
         4lDy74G8dO9dgihPRsVvDHGtTCyHnkMb+rI64SIRSVia9G28PbgT/HUlUXrNsGVknGKL
         xeKG+aOxNCnpA4Em8i2PDUkGIvAWufYAMl72Ugxwg34vwdcpR6LzWkjFBchGy2KErXQV
         H1/hAQ/WkZv5/x1q+nstKbkPNmI/1MXMa4a8EsDPvD4Zk/T2QDIJdlDGCLXQXDOplRGF
         8lJg==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Tue, 17 Jan 2023 10:11:45 +0100
Subject: [PATCH 1/2] usb: dwc3-meson-gxl: force mode on child add/removal
MIME-Version: 1.0
Message-Id: <20230117-u-boot-usb-gxl-otg-dm-v1-1-2853f6d75b06@linaro.org>
References: <20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org>
In-Reply-To: <20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>
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

Thanks for Mattijs for the original work at [1].

[1] https://lore.kernel.org/all/20221024-meson-dm-usb-v1-1-2ab077a503b9@baylibre.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/dwc3-meson-gxl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 6c6d463203..d56f2747b6 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -408,6 +408,22 @@ static int dwc3_meson_gxl_remove(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
 
+static int dwc3_meson_gxl_child_pre_probe(struct udevice *dev)
+{
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-g12a-usb"))
+		return dwc3_meson_gxl_force_mode(dev->parent, USB_DR_MODE_PERIPHERAL);
+
+	return 0;
+}
+
+static int dwc3_meson_gxl_child_post_remove(struct udevice *dev)
+{
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-g12a-usb"))
+		return dwc3_meson_gxl_force_mode(dev->parent, USB_DR_MODE_HOST);
+
+	return 0;
+}
+
 static const struct udevice_id dwc3_meson_gxl_ids[] = {
 	{ .compatible = "amlogic,meson-axg-usb-ctrl" },
 	{ .compatible = "amlogic,meson-gxl-usb-ctrl" },
@@ -421,6 +437,8 @@ U_BOOT_DRIVER(dwc3_generic_wrapper) = {
 	.of_match = dwc3_meson_gxl_ids,
 	.probe = dwc3_meson_gxl_probe,
 	.remove = dwc3_meson_gxl_remove,
+	.child_pre_probe = dwc3_meson_gxl_child_pre_probe,
+	.child_post_remove = dwc3_meson_gxl_child_post_remove,
 	.plat_auto	= sizeof(struct dwc3_meson_gxl),
 
 };

-- 
2.34.1
