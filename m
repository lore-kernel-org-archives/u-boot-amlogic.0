Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4868CA5FAC
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:01:05 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2749.1790704859950092553
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:01:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=3NCQGMex;
 spf=pass (domain: brivo.com, ip: 74.125.230.204, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530e28a62abso67459301cf.1
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790704859; x=1791309659; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPIKFqFNfAsJh2si3aegTlSdSHRw2sKEWB5DaHLmFa0=;
        b=3NCQGMex0vz+durrVyoNE58rWWG8x/XF9Kc1Wl8311lqhyauIGbcJfyaf5IXRb3JSn
         2+U8/Ttfg5ESpsKzeN58mdXefsqN4SL6yd3Vgyfhy0yqW6/SgCidNMwLwlRabzYAjZ2/
         KyiLAJWmoxLbD2YwcnBqgD2lrW/b0bSPzBm/95Yp/bxWsuIzjATXHH+2stpGnyjjvdt0
         42J5JWLygOs11uULS150vB9kHUOJxukxa2ss4vGT7ZrR5ckJnrUBkcs0aBvo+H20EKJ6
         LBL19Wv7BGNHzqRZx4p15QKhro0kuje5A2TT6iF3WQTqFD7o8/pGZoP4X2ANf0DI4ISB
         ++/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790704859; x=1791309659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPIKFqFNfAsJh2si3aegTlSdSHRw2sKEWB5DaHLmFa0=;
        b=kcKq+hvpmcsFZzNJITC/JJn3aGOp5I44stI+VjDXqsFVav5Dpj10MaUw2VCkH+4R14
         /eCYRij8kNyWfJqhrsPEFEJkKymt4U0wWeRpIuez48y+9plhSqKNrVLZ8X/ZTFAttrAv
         6RywIhZZ9Vbman2EiEZGVhB8YBAy5++3fTNOEeMq0DLEeU4eIV1R35lBcZ4gZ4EyrmnO
         1TXargoddOt0mWeen84mlJuxiAl3by0EtVGiZ3alglFhLZ6h65pqzcgaHANtOp+jrDo/
         B0axfu37FGxjE+HKxyQLQwWN3IrAT+6mNaEicX5R7MOSlHwCpr/XhR6+UI+b0qLK9q4C
         gLWw==
X-Gm-Message-State: AFuF++n2rnjVcEijY7hpS4bzUGrNLWdbG5FHeEqaVPBWhXvQ0/kEhnLV
	54j5lKQtQ4rUD1dJSTXg1SgzgX+SE/d/kayowyDkA6k4NnVhA+T5MybKqEXKBaaqPOesQu2OlH+
	iuDN6J2hl6F+qxeeV6UHbe0aXVeBV72jZhUghbMHf0VPXHxfltB6hZQ==
X-Gm-Gg: AYBFou3FCH/m2G/sRBx7aW2gSUOa6ecL1eEdAQc/xRgcBF6YYmVe6iKb4n5WbgTW+T/
	1Y/V6yr75QE63LckUEN/PwTgfQMvB7o/qKoJCRRldT4VHMsX1lxS1A/Zj0W2a9PaufubLi2Gqr+
	SvXkWYxaRVvndnmoEz0u+rRc+GHOAt69VWP913YFQllatkgrCTjU2HeuDmbE/yrMlmafi+MEyD7
	AUxKtqbgLRkq5TsnDh+jjzmXcuD2lE3nVNB0WcdCw3dqFe3gtyVx/1T8Kvesva8NIYF+06v9pt2
	cNugcUDhzezmKlAgzuL8isZWC26g0CIv8Ezi72BEO0kVWTT7sCws90cRaosE0S9PASOzfKiDKaO
	37E8wO9mnVLiwrQ9O84et8Inm66JWCGcwdvcXX9JncTLUSyCejXT3G9jEqr9KsKoYBkwg7GP1PN
	TCqN8vBbMfMqaamJ6zCnWvIEjrintgEDLaG+rzoXvu6sxWZXLYRgyalvTz0zTotHg4
X-Received: by 2002:a05:622a:1816:b0:531:2243:436a with SMTP id d75a77b69052e-5336a5eba19mr159311cf.55.1790704858503;
        Tue, 29 Sep 2026 11:00:58 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53369c4dfe3sm895901cf.31.2026.09.29.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:00:57 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Ramon Fried <rfried.dev@gmail.com>,
	Tom Rini <trini@konsulko.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sean Anderson <sanderson@brivo.com>,
	Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH] net: designware: Fix MDIO bus getting bound multiple times
Date: Tue, 29 Sep 2026 14:00:53 -0400
Message-ID: <20260929180055.3439132-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:01:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3102

designware_eth_probe may be called multiple times for a given device.
such as if the first probe (or post_probe) fails for whatever reason.
When this happens, subsequent probes still try to bind the MDIO bus,
creating several duplicate copies of the bus (all possibly sharing the
same of_node). This can cause an infinite loop in dm_mdio_probe_devices
if we have been probed at least once already:

dm_mdio_probe_devices()
 device_probe(dwmac.mac0)
  device_probe(dwmac)
   designware_eth_probe()
    device_bind_driver_to_node(dwmac.mac1)
    return -EFOO
 device_probe(dwmac.mac1)
  ...

Prevent this by binding the MDIO bus in designware_eth_bind instead of
designware_eth_probe.

Fixes: 5160b4567c71 ("net: designware: add DM_MDIO support")
Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/net/designware.c    | 35 ++++++++++++++++++-----------------
 drivers/net/designware.h    |  1 +
 drivers/net/dwmac_meson8b.c |  3 +++
 drivers/net/dwmac_s700.c    |  3 +++
 drivers/net/dwmac_socfpga.c |  3 +++
 drivers/net/dwmac_thead.c   |  3 +++
 drivers/net/gmac_rockchip.c |  3 +++
 7 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 6ed9c6d538a..256e474a565 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -209,15 +209,14 @@ static int dw_mdio_init(const char *name, void *priv)
 }
 
 #if IS_ENABLED(CONFIG_DM_MDIO)
-static int dw_dm_mdio_init(const char *name, void *priv)
+int dw_dm_mdio_bind(struct udevice *dev)
 {
-	struct udevice *dev = priv;
+	struct udevice *mdiodev;
 	ofnode node;
 	int ret;
 
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		const char *subnode_name = ofnode_get_name(node);
-		struct udevice *mdiodev;
 
 		if (strcmp(subnode_name, "mdio"))
 			continue;
@@ -231,8 +230,10 @@ static int dw_dm_mdio_init(const char *name, void *priv)
 	}
 
 	printf("%s: mdio node is missing, registering legacy mdio bus", __func__);
-
-	return dw_mdio_init(name, priv);
+	ret = device_bind_driver(dev, "eth_designware_mdio", dev->name, &mdiodev);
+	if (ret)
+		debug("%s: not able to create mdio bus\n", __func__);
+	return ret;
 }
 #endif
 
@@ -855,6 +856,9 @@ static int designware_eth_bind(struct udevice *dev)
 		}
 	}
 
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	return dw_dm_mdio_bind(dev);
+#endif
 	return 0;
 }
 
@@ -961,19 +965,16 @@ int designware_eth_probe(struct udevice *dev)
 		}
 	} else
 #endif
-	{
-#if IS_ENABLED(CONFIG_DM_MDIO)
-		ret = dw_dm_mdio_init(dev->name, dev);
-#else
-		ret = dw_mdio_init(dev->name, dev);
-#endif
-		if (ret) {
-			err = ret;
-			goto mdio_err;
-		}
-		priv->bus = miiphy_get_dev_by_name(dev->name);
-		priv->dev = dev;
+
+	priv->dev = dev;
+#if !IS_ENABLED(CONFIG_DM_MDIO)
+	ret = dw_mdio_init(dev->name, dev);
+	if (ret) {
+		err = ret;
+		goto mdio_err;
 	}
+	priv->bus = miiphy_get_dev_by_name(dev->name);
+#endif
 
 	ret = dw_phy_init(priv, dev);
 	debug("%s, ret=%d\n", __func__, ret);
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index cccf9d54e02..3618300f4c5 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -249,6 +249,7 @@ struct dw_eth_dev {
 	struct mii_dev *bus;
 };
 
+int dw_dm_mdio_bind(struct udevice *dev);
 int designware_eth_of_to_plat(struct udevice *dev);
 int designware_eth_probe(struct udevice *dev);
 extern const struct eth_ops designware_eth_ops;
diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index fde4aabbace..cb9de81a819 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -157,6 +157,9 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
 	.id		= UCLASS_ETH,
 	.of_match	= dwmac_meson8b_ids,
 	.of_to_plat = dwmac_meson8b_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe		= dwmac_meson8b_probe,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index 76daab961c0..d95f2111a5b 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -56,6 +56,9 @@ U_BOOT_DRIVER(dwmac_s700) = {
 	.id     = UCLASS_ETH,
 	.of_match = dwmac_s700_ids,
 	.of_to_plat = dwmac_s700_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe  = dwmac_s700_probe,
 	.ops    = &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index a55f3e29f9f..64bb2dbfbe3 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -143,6 +143,9 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
 	.id		= UCLASS_ETH,
 	.of_match	= dwmac_socfpga_ids,
 	.of_to_plat = dwmac_socfpga_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe		= dwmac_socfpga_probe,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
diff --git a/drivers/net/dwmac_thead.c b/drivers/net/dwmac_thead.c
index 138d71a6202..5843bed49cb 100644
--- a/drivers/net/dwmac_thead.c
+++ b/drivers/net/dwmac_thead.c
@@ -280,6 +280,9 @@ U_BOOT_DRIVER(dwmac_thead) = {
 	.id		= UCLASS_ETH,
 	.of_match	= dwmac_thead_match,
 	.of_to_plat	= dwmac_thead_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe		= dwmac_thead_probe,
 	.ops		= &dwmac_thead_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 2b6080dd9ee..1d21cb2606d 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -790,6 +790,9 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
 	.id	= UCLASS_ETH,
 	.of_match = rockchip_gmac_ids,
 	.of_to_plat = gmac_rockchip_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe	= gmac_rockchip_probe,
 	.ops	= &gmac_rockchip_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: dw_mdio_bind

-- 
2.53.0


