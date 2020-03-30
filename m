Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.46268.1585560465528300629
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Mar 2020 02:27:45 -0700
Received: by mail-wr1-f68.google.com with SMTP id 31so20681103wrs.3
        for <u-boot-amlogic@groups.io>; Mon, 30 Mar 2020 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EzZmmAYt6MavNnf5jh0NVmKdaimu/G7mTQnj8H8rE+Q=;
        b=gAXRyYBvB9NpcSC7YHQUU832rq9WpQTX6LthIqx3ivcW0xgHmceiEENFigv0NJSdI+
         2XxkS0S2DhdH5mm1kSLSI5qDachGOT+HGu8K2PFMNmavgGvjYx7zRRs3jULFLFGSkX7E
         crzjhSiCaTADpdq7I3qyViINzmoTW48jBXB5EQNKT96AF1IdLs/2tx4epdrH5ISQYRju
         ThSNBZjuswst40sDAW2HGPejQxkIevBYIgPPX4niGljIIQPxVnGY/nUZyHc6nl7XnnId
         QMnCFtyiX+z5J9M359Bi4M73vGu7SBUocI6io7eQrXXGusxt9+TwJUynYBNFdix3yZsT
         HSKQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 01/10] generic-phy: add generic_phy_get_by_node()
Date: Mon, 30 Mar 2020 11:27:23 +0200
Message-Id: <20200330092732.7198-2-narmstrong@baylibre.com>
In-Reply-To: <20200330092732.7198-1-narmstrong@baylibre.com>
References: <20200330092732.7198-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add generic_phy_get_by_node() to get a PHY phandle from a node instead
of a udevice.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/phy-uclass.c | 17 ++++++++++++-----
 include/generic-phy.h    | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index e201a90c8c..de2c3d2b8e 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -31,20 +31,20 @@ static int generic_phy_xlate_offs_flags(struct phy *phy,
 	return 0;
 }
 
-int generic_phy_get_by_index(struct udevice *dev, int index,
-			     struct phy *phy)
+int generic_phy_get_by_node(ofnode node, int index, struct phy *phy)
 {
 	struct ofnode_phandle_args args;
 	struct phy_ops *ops;
 	struct udevice *phydev;
 	int i, ret;
 
-	debug("%s(dev=%p, index=%d, phy=%p)\n", __func__, dev, index, phy);
+	debug("%s(node=%s, index=%d, phy=%p)\n",
+	      __func__, ofnode_get_name(node), index, phy);
 
 	assert(phy);
 	phy->dev = NULL;
-	ret = dev_read_phandle_with_args(dev, "phys", "#phy-cells", 0, index,
-					 &args);
+	ret = ofnode_parse_phandle_with_args(node, "phys", "#phy-cells", 0,
+					     index, &args);
 	if (ret) {
 		debug("%s: dev_read_phandle_with_args failed: err=%d\n",
 		      __func__, ret);
@@ -88,6 +88,12 @@ int generic_phy_get_by_index(struct udevice *dev, int index,
 
 err:
 	return ret;
+}
+
+int generic_phy_get_by_index(struct udevice *dev, int index,
+			     struct phy *phy)
+{
+	return generic_phy_get_by_node(dev_ofnode(dev), index, phy);
 }
 
 int generic_phy_get_by_name(struct udevice *dev, const char *phy_name,
diff --git a/include/generic-phy.h b/include/generic-phy.h
index 95caf58341..5873ffb2e0 100644
--- a/include/generic-phy.h
+++ b/include/generic-phy.h
@@ -193,6 +193,33 @@ int generic_phy_power_off(struct phy *phy);
 int generic_phy_get_by_index(struct udevice *user, int index,
 			     struct phy *phy);
 
+/**
+ * generic_phy_get_by_node() - Get a PHY device by integer index on ofnode
+ *
+ * @node:	the device node
+ * @index:	The index in the list of available PHYs
+ * @phy:	A pointer to the PHY port
+ *
+ * This looks up a PHY device for a client device based on its ofnode and on
+ * its position in the list of the possible PHYs.
+ *
+ * example:
+ * usb1: usb_otg_ss@xxx {
+ *       compatible = "xxx";
+ *       reg = <xxx>;
+ *   .
+ *   .
+ *   phys = <&usb2_phy>, <&usb3_phy>;
+ *   .
+ *   .
+ * };
+ * the USB2 phy can be accessed by passing index '0' and the USB3 phy can
+ * be accessed by passing index '1'
+ *
+ * @return 0 if OK, or a negative error code
+ */
+int generic_phy_get_by_node(ofnode node, int index, struct phy *phy);
+
 /**
  * generic_phy_get_by_name() - Get a PHY device by its name.
  *
-- 
2.22.0

