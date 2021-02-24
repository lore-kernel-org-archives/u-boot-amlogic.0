Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.7151.1614175364909589490
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Feb 2021 06:02:45 -0800
Received: by mail-wr1-f50.google.com with SMTP id t15so1973251wrx.13
        for <u-boot-amlogic@groups.io>; Wed, 24 Feb 2021 06:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rK3+to4D/vnpkSHEVluuKaeOIZ5kaTY80A8x/UwIIUA=;
        b=L8HxRiMrHflQXbexchdl1DC3jRyiSnwm1xfx/5QTmHhAvfu0wptMM0INQpj+hN5GeU
         Ndc4iyH04y+HyM8mYRYdiVE+moB8a4vAqB1JhLUidZ6hAmI64plN+eVR0EXJFebSjyP8
         ETLszs6F7bev6+7cvi4Y/iYoM4zrcMuxcDAuU7qqOA5HZYe0Hc+e28nucTiqOEanCj57
         DpzR2anCN40L9RifAloh10NKJoufR5AYE72bP9cCCkkotSubF5OzqQlSSa+O77WzW+om
         3lGoo8V6/qiW3HoiNAEliNhzQI9SV7Th/4tucqeC9/9XXNzGeQji9HlazTAuWDKN9Bt2
         Ls4Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] net: designware: add DM_MDIO support
Date: Wed, 24 Feb 2021 15:02:39 +0100
Message-Id: <20210224140239.2617642-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for DM_MDIO to connect to PHY and expose a MDIO device for the
internal MDIO bus in order to dynamically connect to MDIO PHYs with DT
with eventual MDIO muxes in between.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/net/designware.c | 93 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 9dba55adaa..acf3a82828 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -21,7 +21,9 @@
 #include <reset.h>
 #include <asm/cache.h>
 #include <dm/device_compat.h>
+#include <dm/device-internal.h>
 #include <dm/devres.h>
+#include <dm/lists.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -122,6 +124,55 @@ static int dw_mdio_reset(struct mii_dev *bus)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_DM_MDIO)
+int designware_eth_mdio_read(struct udevice *mdio_dev, int addr, int devad, int reg)
+{
+	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
+
+	return dw_mdio_read(pdata->mii_bus, addr, devad, reg);
+}
+
+int designware_eth_mdio_write(struct udevice *mdio_dev, int addr, int devad, int reg, u16 val)
+{
+	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
+
+	return dw_mdio_write(pdata->mii_bus, addr, devad, reg, val);
+}
+
+#if CONFIG_IS_ENABLED(DM_GPIO)
+int designware_eth_mdio_reset(struct udevice *mdio_dev)
+{
+	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
+
+	return dw_mdio_reset(pdata->mii_bus);
+}
+#endif
+
+static const struct mdio_ops designware_eth_mdio_ops = {
+	.read = designware_eth_mdio_read,
+	.write = designware_eth_mdio_write,
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	.reset = designware_eth_mdio_reset,
+#endif
+};
+
+static int designware_eth_mdio_probe(struct udevice *dev)
+{
+	/* Use the priv data of parent */
+	dev_set_priv(dev, dev_get_priv(dev->parent));
+
+	return 0;
+}
+
+U_BOOT_DRIVER(designware_eth_mdio) = {
+	.name = "eth_designware_mdio",
+	.id = UCLASS_MDIO,
+	.probe = designware_eth_mdio_probe,
+	.ops = &designware_eth_mdio_ops,
+	.plat_auto = sizeof(struct mdio_perdev_priv),
+};
+#endif
+
 static int dw_mdio_init(const char *name, void *priv)
 {
 	struct mii_dev *bus = mdio_alloc();
@@ -143,6 +194,34 @@ static int dw_mdio_init(const char *name, void *priv)
 	return mdio_register(bus);
 }
 
+#if IS_ENABLED(CONFIG_DM_MDIO)
+static int dw_dm_mdio_init(const char *name, void *priv)
+{
+	struct udevice *dev = priv;
+	ofnode node;
+	int ret;
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		const char *subnode_name = ofnode_get_name(node);
+		struct udevice *mdiodev;
+
+		if (strcmp(subnode_name, "mdio"))
+			continue;
+
+		ret = device_bind_driver_to_node(dev, "eth_designware_mdio",
+						 subnode_name, node, &mdiodev);
+		if (ret)
+			debug("%s: not able to bind mdio device node\n", __func__);
+
+		return 0;
+	}
+
+	printf("%s: mdio node is missing, registering legacy mdio bus", __func__);
+
+	return dw_mdio_init(name, priv);
+}
+#endif
+
 static void tx_descs_init(struct dw_eth_dev *priv)
 {
 	struct eth_dma_regs *dma_p = priv->dma_regs_p;
@@ -487,7 +566,14 @@ static int _dw_free_pkt(struct dw_eth_dev *priv)
 static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
 {
 	struct phy_device *phydev;
-	int phy_addr = -1, ret;
+	int ret;
+
+#if IS_ENABLED(CONFIG_DM_MDIO) && IS_ENABLED(CONFIG_DM_ETH)
+	phydev = dm_eth_phy_connect(dev);
+	if (!phydev)
+		return -ENODEV;
+#else
+	int phy_addr = -1;
 
 #ifdef CONFIG_PHY_ADDR
 	phy_addr = CONFIG_PHY_ADDR;
@@ -496,6 +582,7 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
 	phydev = phy_connect(priv->bus, phy_addr, dev, priv->interface);
 	if (!phydev)
 		return -ENODEV;
+#endif
 
 	phydev->supported &= PHY_GBIT_FEATURES;
 	if (priv->max_speed) {
@@ -759,7 +846,11 @@ int designware_eth_probe(struct udevice *dev)
 	priv->interface = pdata->phy_interface;
 	priv->max_speed = pdata->max_speed;
 
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	ret = dw_dm_mdio_init(dev->name, dev);
+#else
 	ret = dw_mdio_init(dev->name, dev);
+#endif
 	if (ret) {
 		err = ret;
 		goto mdio_err;
-- 
2.25.1

