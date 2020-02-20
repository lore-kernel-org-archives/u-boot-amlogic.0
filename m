Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.web12.187.1582165979331493470
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Feb 2020 18:32:59 -0800
Received: by mail-pj1-f65.google.com with SMTP id ep11so228861pjb.2
        for <u-boot-amlogic@groups.io>; Wed, 19 Feb 2020 18:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3/yYMI7fSW/fyeOL73uBPuMERIg8Zg8ILuMGFpLBr+Q=;
        b=g1NK9k4KYHDvu+aZ5LyAqPpZVUHzqmNvzTq11xh0WbF1kmcgoqT1Kb3HWmkSopi3jS
         WKaK4So/6pspYXWSr24HAKm9yNaClgJ2oXwZdbdjyCy1J8JcDNmn5yqrzwStOZV7JZeq
         zGXhn3d+9SBfBua7wuYs1L1kqNsddmBeG7DIJUc5DKS8l8IYGykdFp51JgDKYc/KWdyS
         PM5HFwhUUBUl00BD6nHIfVDJF1NmwQOvUEXSlfWfx4cjmPTQJS9+KxzRqi8KBVjxTlyp
         8zsyHlRGqBOmBNwOeiQWPc2R8GXOT0FzWpFZLQwUX+sxCXjunYdPcqyxPrOdpFTHreNg
         rvrg==
Return-Path: <kever.yang@gmail.com>
Sender: Kever Yang <kever.yang@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v2 8/9] usb: Use ofnode as usb_get_dr_mode() parameter
Date: Thu, 20 Feb 2020 10:32:23 +0800
Message-Id: <20200220023224.32146-9-kever.yang@rock-chips.com>
In-Reply-To: <20200220023224.32146-1-kever.yang@rock-chips.com>
References: <20200220023224.32146-1-kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: frank.wang@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>, Adam Ford <aford173@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Simon Glass <sjg@chromium.org>, Vignesh Raghavendra <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

ofnode is more common and no need to convert to offset after we migrate
other API to use ofnode.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---

Changes in v2:
- add ofnode.h in otg.h to avoid build error

 drivers/usb/cdns3/core.c           | 4 ++--
 drivers/usb/common/common.c        | 7 +++----
 drivers/usb/dwc3/dwc3-generic.c    | 6 +++---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
 drivers/usb/gadget/dwc2_udc_otg.c  | 5 ++---
 drivers/usb/host/dwc3-sti-glue.c   | 2 +-
 drivers/usb/host/ehci-mx6.c        | 2 +-
 drivers/usb/host/xhci-dwc3.c       | 3 +--
 drivers/usb/musb-new/ti-musb.c     | 2 +-
 include/linux/usb/otg.h            | 6 ++++--
 10 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 75c3d4f200..ce846488a8 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -108,7 +108,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	enum usb_dr_mode dr_mode;
 	int ret = 0;
 
-	dr_mode = usb_get_dr_mode(dev_of_offset(dev));
+	dr_mode = usb_get_dr_mode(dev->node);
 	cdns->role = USB_ROLE_NONE;
 
 	/*
@@ -398,7 +398,7 @@ int cdns3_bind(struct udevice *parent)
 	}
 
 	name = ofnode_get_name(node);
-	dr_mode = usb_get_dr_mode(ofnode_to_offset(node));
+	dr_mode = usb_get_dr_mode(node);
 
 	switch (dr_mode) {
 #if defined(CONFIG_SPL_USB_HOST_SUPPORT) || \
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index a55def5aba..4300f711a9 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -7,7 +7,7 @@
  */
 
 #include <common.h>
-#include <linux/libfdt.h>
+#include <dm.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ch9.h>
 
@@ -20,13 +20,12 @@ static const char *const usb_dr_modes[] = {
 	[USB_DR_MODE_OTG]		= "otg",
 };
 
-enum usb_dr_mode usb_get_dr_mode(int node)
+enum usb_dr_mode usb_get_dr_mode(ofnode node)
 {
-	const void *fdt = gd->fdt_blob;
 	const char *dr_mode;
 	int i;
 
-	dr_mode = fdt_getprop(fdt, node, "dr_mode", NULL);
+	dr_mode = ofnode_read_string(node, "dr_mode");
 	if (!dr_mode) {
 		pr_err("usb dr_mode not found\n");
 		return USB_DR_MODE_UNKNOWN;
diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index ced0f53bfd..7178f12b47 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -98,7 +98,7 @@ static int dwc3_generic_ofdata_to_platdata(struct udevice *dev)
 		plat->maximum_speed = USB_SPEED_SUPER;
 	}
 
-	plat->dr_mode = usb_get_dr_mode(ofnode_to_offset(node));
+	plat->dr_mode = usb_get_dr_mode(node);
 	if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
 		pr_err("Invalid usb mode setup\n");
 		return -ENODEV;
@@ -295,7 +295,7 @@ static int dwc3_glue_bind(struct udevice *parent)
 
 		debug("%s: subnode name: %s\n", __func__, name);
 
-		dr_mode = usb_get_dr_mode(ofnode_to_offset(node));
+		dr_mode = usb_get_dr_mode(node);
 
 		switch (dr_mode) {
 		case USB_DR_MODE_PERIPHERAL:
@@ -398,7 +398,7 @@ static int dwc3_glue_probe(struct udevice *dev)
 	while (child) {
 		enum usb_dr_mode dr_mode;
 
-		dr_mode = usb_get_dr_mode(dev_of_offset(child));
+		dr_mode = usb_get_dr_mode(child->node);
 		device_find_next_child(&child);
 		if (ops && ops->select_dr_mode)
 			ops->select_dr_mode(dev, index, dr_mode);
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 832bcd70ff..d4453f8784 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -393,7 +393,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 	}
 #endif
 
-	priv->otg_mode = usb_get_dr_mode(dev_of_offset(dev));
+	priv->otg_mode = usb_get_dr_mode(dev->node);
 
 	ret = dwc3_meson_g12a_usb_init(priv);
 	if (ret)
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 496abf38e7..b9c814cf73 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -1039,13 +1039,12 @@ void dwc2_phy_shutdown(struct udevice *dev, struct phy *usb_phys, int num_phys)
 static int dwc2_udc_otg_ofdata_to_platdata(struct udevice *dev)
 {
 	struct dwc2_plat_otg_data *platdata = dev_get_platdata(dev);
-	int node = dev_of_offset(dev);
 	ulong drvdata;
 	void (*set_params)(struct dwc2_plat_otg_data *data);
 	int ret;
 
-	if (usb_get_dr_mode(node) != USB_DR_MODE_PERIPHERAL &&
-	    usb_get_dr_mode(node) != USB_DR_MODE_OTG) {
+	if (usb_get_dr_mode(dev->node) != USB_DR_MODE_PERIPHERAL &&
+	    usb_get_dr_mode(dev->node) != USB_DR_MODE_OTG) {
 		dev_dbg(dev, "Invalid mode\n");
 		return -ENODEV;
 	}
diff --git a/drivers/usb/host/dwc3-sti-glue.c b/drivers/usb/host/dwc3-sti-glue.c
index ae9573ab8a..c99a1985cc 100644
--- a/drivers/usb/host/dwc3-sti-glue.c
+++ b/drivers/usb/host/dwc3-sti-glue.c
@@ -164,7 +164,7 @@ static int sti_dwc3_glue_bind(struct udevice *dev)
 	}
 
 	/* retrieve the DWC3 dual role mode */
-	plat->mode = usb_get_dr_mode(ofnode_to_offset(dwc3_node));
+	plat->mode = usb_get_dr_mode(dwc3_node);
 	if (plat->mode == USB_DR_MODE_UNKNOWN)
 		/* by default set dual role mode to HOST */
 		plat->mode = USB_DR_MODE_HOST;
diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 1993ad620a..f2ceb51310 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -513,7 +513,7 @@ static int ehci_usb_ofdata_to_platdata(struct udevice *dev)
 	struct usb_platdata *plat = dev_get_platdata(dev);
 	enum usb_dr_mode dr_mode;
 
-	dr_mode = usb_get_dr_mode(dev_of_offset(dev));
+	dr_mode = usb_get_dr_mode(dev->node);
 
 	switch (dr_mode) {
 	case USB_DR_MODE_HOST:
diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index c1c681ca6c..9fcfa39d4b 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -9,7 +9,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <fdtdec.h>
 #include <generic-phy.h>
 #include <usb.h>
 #include <dwc3-uboot.h>
@@ -155,7 +154,7 @@ static int xhci_dwc3_probe(struct udevice *dev)
 
 	writel(reg, &dwc3_reg->g_usb2phycfg[0]);
 
-	dr_mode = usb_get_dr_mode(dev_of_offset(dev));
+	dr_mode = usb_get_dr_mode(dev->node);
 	if (dr_mode == USB_DR_MODE_UNKNOWN)
 		/* by default set dual role mode to HOST */
 		dr_mode = USB_DR_MODE_HOST;
diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index 69252a7222..608facefa3 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -297,7 +297,7 @@ static int ti_musb_wrapper_bind(struct udevice *parent)
 		if (strncmp(name, "usb@", 4))
 			continue;
 
-		dr_mode = usb_get_dr_mode(ofnode_to_offset(node));
+		dr_mode = usb_get_dr_mode(node);
 		switch (dr_mode) {
 		case USB_DR_MODE_PERIPHERAL:
 			/* Bind MUSB device */
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index d2604c5caf..4f1f8ceb54 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -9,6 +9,8 @@
 #ifndef __LINUX_USB_OTG_H
 #define __LINUX_USB_OTG_H
 
+#include <dm/ofnode.h>
+
 enum usb_dr_mode {
 	USB_DR_MODE_UNKNOWN,
 	USB_DR_MODE_HOST,
@@ -18,12 +20,12 @@ enum usb_dr_mode {
 
 /**
  * usb_get_dr_mode() - Get dual role mode for given device
- * @node: Node offset to the given device
+ * @node: ofnode of the given device
  *
  * The function gets phy interface string from property 'dr_mode',
  * and returns the correspondig enum usb_dr_mode
  */
-enum usb_dr_mode usb_get_dr_mode(int node);
+enum usb_dr_mode usb_get_dr_mode(ofnode node);
 
 /**
  * usb_get_maximum_speed() - Get maximum speed for given device
-- 
2.17.1

