Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.9545.1618995485646157796
 for <u-boot-amlogic@groups.io>;
 Wed, 21 Apr 2021 01:58:06 -0700
Received: by mail-wm1-f47.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so827747wma.1
        for <u-boot-amlogic@groups.io>; Wed, 21 Apr 2021 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YY4EKbPZ4X3TRNYd7ZaxnPwykoIyEAcm254c4mw5+/Q=;
        b=C7En6djEAA9MQGaAZjphYUZ+irg0F3TmXWfzZJTYUZhzkSZ59AQYrpPYIHkQKcyFQo
         EoOTF0nyjSGPTPiS/wbAKqkT2T6LVk1KemXRMtdZgJPOt6CZOGJJ1Hhm0pEQRaFJcHxk
         2Zx+xjypbJRscru6WcJh2OM931tsCAtLlQnjmZH9itk2TSQyZsFO3459pUJcnNgyNllO
         VGdSo4C91lKxrAxyb4DBJucx3XPwJDOLbhPjBchhq+euSKngcqJXwCiy4boHw4rrtdbP
         +rvzj2iQYgynbofDIFtyPOzHJCEp8snjjYz/wJL+1bHO3TXINcWCg0Cq2JbMds91nvuF
         niug==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] net: designware: fix PHY reset with DM_MDIO
Date: Wed, 21 Apr 2021 10:58:01 +0200
Message-Id: <20210421085801.3100215-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: joe.hershberger@ni.com, rfried.dev@gmail.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Mark Kettenis <mark.kettenis@xs4all.nl>
List-ID: <u-boot-amlogic@groups.io>

The dw_eth_pdata is not accessible from the mdio device, it gets the mdio bus plat
leading to random sleeps (-10174464 on Odroid-HC4).

This moves the dw_mdio_reset function to a common one taking the ethernet
device as parameter and use it from the dw_mdio_reset and dm_mdio variant functions.

Fixes: 5160b4567c net: designware: add DM_MDIO support
Reported-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/net/designware.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index b8ba00b7c0..5d92257e74 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -91,9 +91,8 @@ static int dw_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
 }
 
 #if defined(CONFIG_DM_ETH) && CONFIG_IS_ENABLED(DM_GPIO)
-static int dw_mdio_reset(struct mii_dev *bus)
+static int __dw_mdio_reset(struct udevice *dev)
 {
-	struct udevice *dev = bus->priv;
 	struct dw_eth_dev *priv = dev_get_priv(dev);
 	struct dw_eth_pdata *pdata = dev_get_plat(dev);
 	int ret;
@@ -122,6 +121,13 @@ static int dw_mdio_reset(struct mii_dev *bus)
 
 	return 0;
 }
+
+static int dw_mdio_reset(struct mii_dev *bus)
+{
+	struct udevice *dev = bus->priv;
+
+	return __dw_mdio_reset(dev);
+}
 #endif
 
 #if IS_ENABLED(CONFIG_DM_MDIO)
@@ -142,9 +148,10 @@ int designware_eth_mdio_write(struct udevice *mdio_dev, int addr, int devad, int
 #if CONFIG_IS_ENABLED(DM_GPIO)
 int designware_eth_mdio_reset(struct udevice *mdio_dev)
 {
-	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
+	struct mdio_perdev_priv *mdio_pdata = dev_get_uclass_priv(mdio_dev);
+	struct udevice *dev = mdio_pdata->mii_bus->priv;
 
-	return dw_mdio_reset(pdata->mii_bus);
+	return __dw_mdio_reset(dev->parent);
 }
 #endif
 
-- 
2.25.1

