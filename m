Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.133])
 by mx.groups.io with SMTP id smtpd.web11.2788.1583283628505108046
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Mar 2020 17:00:29 -0800
From: Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v3 3/3] usb: Migrate to support live DT for some driver
Date: Wed,  4 Mar 2020 08:59:50 +0800
Message-Id: <20200304005951.8225-4-kever.yang@rock-chips.com>
In-Reply-To: <20200304005951.8225-1-kever.yang@rock-chips.com>
References: <20200304005951.8225-1-kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: frank.wang@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>, Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Simon Glass <sjg@chromium.org>, Vignesh Raghavendra <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Use ofnode_ instead of fdt_ APIs so that the drivers can support live DT.
This patch updates usb_get_dr_mode() and usb_get_maximum_speed() to use
ofnode as parameter instead of fdt offset. And all the drivers who use
these APIs update to use live dt APIs at the same time.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- Squesh the 3rd~9th into one patch.

 drivers/usb/cdns3/core.c           | 15 ++++++---------
 drivers/usb/cdns3/gadget.c         |  2 +-
 drivers/usb/common/common.c        | 12 +++++-------
 drivers/usb/dwc3/dwc3-generic.c    | 16 +++++++---------
 drivers/usb/dwc3/dwc3-meson-g12a.c |  2 +-
 drivers/usb/gadget/dwc2_udc_otg.c  |  5 ++---
 drivers/usb/host/dwc3-sti-glue.c   | 20 +++++++-------------
 drivers/usb/host/ehci-mx6.c        |  2 +-
 drivers/usb/host/xhci-dwc3.c       |  3 +--
 drivers/usb/musb-new/ti-musb.c     | 12 +++++-------
 include/linux/usb/otg.h            | 10 ++++++----
 11 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index f947e6983c..ce846488a8 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -108,7 +108,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	enum usb_dr_mode dr_mode;
 	int ret = 0;
 
-	dr_mode = usb_get_dr_mode(dev_of_offset(dev));
+	dr_mode = usb_get_dr_mode(dev->node);
 	cdns->role = USB_ROLE_NONE;
 
 	/*
@@ -384,22 +384,20 @@ static const struct udevice_id cdns3_ids[] = {
 
 int cdns3_bind(struct udevice *parent)
 {
-	int from = dev_of_offset(parent);
-	const void *fdt = gd->fdt_blob;
 	enum usb_dr_mode dr_mode;
 	struct udevice *dev;
 	const char *driver;
 	const char *name;
-	int node;
+	ofnode node;
 	int ret;
 
-	node = fdt_node_offset_by_compatible(fdt, from, "cdns,usb3");
-	if (node < 0) {
+	node = ofnode_by_compatible(parent->node, "cdns,usb3");
+	if (!ofnode_valid(node)) {
 		ret = -ENODEV;
 		goto fail;
 	}
 
-	name = fdt_get_name(fdt, node, NULL);
+	name = ofnode_get_name(node);
 	dr_mode = usb_get_dr_mode(node);
 
 	switch (dr_mode) {
@@ -422,8 +420,7 @@ int cdns3_bind(struct udevice *parent)
 		goto fail;
 	};
 
-	ret = device_bind_driver_to_node(parent, driver, name,
-					 offset_to_ofnode(node), &dev);
+	ret = device_bind_driver_to_node(parent, driver, name, node, &dev);
 	if (ret) {
 		printf("%s: not able to bind usb device mode\n",
 		       __func__);
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 22e90a5717..8ebe64e8b3 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2579,7 +2579,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 	if (!priv_dev->onchip_buffers)
 		priv_dev->onchip_buffers = 256;
 
-	max_speed = usb_get_maximum_speed(dev_of_offset(cdns->dev));
+	max_speed = usb_get_maximum_speed(dev_ofnode(cdns->dev));
 
 	/* Check the maximum_speed parameter */
 	switch (max_speed) {
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index a55def5aba..0db281b970 100644
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
@@ -48,13 +47,12 @@ static const char *const speed_names[] = {
 	[USB_SPEED_SUPER] = "super-speed",
 };
 
-enum usb_device_speed usb_get_maximum_speed(int node)
+enum usb_device_speed usb_get_maximum_speed(ofnode node)
 {
-	const void *fdt = gd->fdt_blob;
 	const char *max_speed;
 	int i;
 
-	max_speed = fdt_getprop(fdt, node, "maximum-speed", NULL);
+	max_speed = ofnode_read_string(node, "maximum-speed");
 	if (!max_speed) {
 		pr_err("usb maximum-speed not found\n");
 		return USB_SPEED_UNKNOWN;
diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 3e116b2c5c..febcfc0f54 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -88,9 +88,9 @@ static int dwc3_generic_remove(struct udevice *dev,
 static int dwc3_generic_ofdata_to_platdata(struct udevice *dev)
 {
 	struct dwc3_generic_plat *plat = dev_get_platdata(dev);
-	int node = dev_of_offset(dev);
+	ofnode node = dev->node;
 
-	plat->base = devfdt_get_addr(dev);
+	plat->base = dev_read_addr(dev);
 
 	plat->maximum_speed = usb_get_maximum_speed(node);
 	if (plat->maximum_speed == USB_SPEED_UNKNOWN) {
@@ -284,13 +284,11 @@ struct dwc3_glue_ops ti_ops = {
 
 static int dwc3_glue_bind(struct udevice *parent)
 {
-	const void *fdt = gd->fdt_blob;
-	int node;
+	ofnode node;
 	int ret;
 
-	for (node = fdt_first_subnode(fdt, dev_of_offset(parent)); node > 0;
-	     node = fdt_next_subnode(fdt, node)) {
-		const char *name = fdt_get_name(fdt, node, NULL);
+	ofnode_for_each_subnode(node, parent->node) {
+		const char *name = ofnode_get_name(node);
 		enum usb_dr_mode dr_mode;
 		struct udevice *dev;
 		const char *driver = NULL;
@@ -322,7 +320,7 @@ static int dwc3_glue_bind(struct udevice *parent)
 			continue;
 
 		ret = device_bind_driver_to_node(parent, driver, name,
-						 offset_to_ofnode(node), &dev);
+						 node, &dev);
 		if (ret) {
 			debug("%s: not able to bind usb device mode\n",
 			      __func__);
@@ -400,7 +398,7 @@ static int dwc3_glue_probe(struct udevice *dev)
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
index ad7cf6e6b5..c99a1985cc 100644
--- a/drivers/usb/host/dwc3-sti-glue.c
+++ b/drivers/usb/host/dwc3-sti-glue.c
@@ -10,8 +10,6 @@
 #include <asm/io.h>
 #include <dm.h>
 #include <errno.h>
-#include <fdtdec.h>
-#include <linux/libfdt.h>
 #include <dm/lists.h>
 #include <regmap.h>
 #include <reset-uclass.h>
@@ -109,8 +107,7 @@ static int sti_dwc3_glue_ofdata_to_platdata(struct udevice *dev)
 	int ret;
 	u32 reg[4];
 
-	ret = fdtdec_get_int_array(gd->fdt_blob, dev_of_offset(dev),
-				   "reg", reg, ARRAY_SIZE(reg));
+	ret = ofnode_read_u32_array(dev->node, "reg", reg, ARRAY_SIZE(reg));
 	if (ret) {
 		pr_err("unable to find st,stih407-dwc3 reg property(%d)\n", ret);
 		return ret;
@@ -153,18 +150,15 @@ static int sti_dwc3_glue_ofdata_to_platdata(struct udevice *dev)
 static int sti_dwc3_glue_bind(struct udevice *dev)
 {
 	struct sti_dwc3_glue_platdata *plat = dev_get_platdata(dev);
-	int dwc3_node;
+	ofnode node, dwc3_node;
 
-	/* check if one subnode is present */
-	dwc3_node = fdt_first_subnode(gd->fdt_blob, dev_of_offset(dev));
-	if (dwc3_node <= 0) {
-		pr_err("Can't find subnode for %s\n", dev->name);
-		return -ENODEV;
+	/* Find snps,dwc3 node from subnode */
+	ofnode_for_each_subnode(node, dev->node) {
+		if (ofnode_device_is_compatible(node, "snps,dwc3"))
+			dwc3_node = node;
 	}
 
-	/* check if the subnode compatible string is the dwc3 one*/
-	if (fdt_node_check_compatible(gd->fdt_blob, dwc3_node,
-				      "snps,dwc3") != 0) {
+	if (!ofnode_valid(node)) {
 		pr_err("Can't find dwc3 subnode for %s\n", dev->name);
 		return -ENODEV;
 	}
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
index 00759f3e83..608facefa3 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -285,14 +285,12 @@ U_BOOT_DRIVER(ti_musb_peripheral) = {
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 static int ti_musb_wrapper_bind(struct udevice *parent)
 {
-	const void *fdt = gd->fdt_blob;
-	int node;
+	ofnode node;
 	int ret;
 
-	for (node = fdt_first_subnode(fdt, dev_of_offset(parent)); node > 0;
-	     node = fdt_next_subnode(fdt, node)) {
+	ofnode_for_each_subnode(node, parent->node) {
 		struct udevice *dev;
-		const char *name = fdt_get_name(fdt, node, NULL);
+		const char *name = ofnode_get_name(node);
 		enum usb_dr_mode dr_mode;
 		struct driver *drv;
 
@@ -306,7 +304,7 @@ static int ti_musb_wrapper_bind(struct udevice *parent)
 			ret = device_bind_driver_to_node(parent,
 							 "ti-musb-peripheral",
 							 name,
-							 offset_to_ofnode(node),
+							 node,
 							 &dev);
 			if (ret)
 				pr_err("musb - not able to bind usb peripheral node\n");
@@ -316,7 +314,7 @@ static int ti_musb_wrapper_bind(struct udevice *parent)
 			ret = device_bind_driver_to_node(parent,
 							 "ti-musb-host",
 							 name,
-							 offset_to_ofnode(node),
+							 node,
 							 &dev);
 			if (ret)
 				pr_err("musb - not able to bind usb host node\n");
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index d2604c5caf..c19b916be9 100644
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
@@ -18,20 +20,20 @@ enum usb_dr_mode {
 
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
- * @node: Node offset to the given device
+ * @node: ofnode of the given device
  *
  * The function gets phy interface string from property 'maximum-speed',
  * and returns the correspondig enum usb_device_speed
  */
-enum usb_device_speed usb_get_maximum_speed(int node);
+enum usb_device_speed usb_get_maximum_speed(ofnode node);
 
 #endif /* __LINUX_USB_OTG_H */
-- 
2.17.1



