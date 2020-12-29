Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.11769.1609250349650368798
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Dec 2020 05:59:09 -0800
Received: by mail-wr1-f41.google.com with SMTP id d13so14699650wrc.13
        for <u-boot-amlogic@groups.io>; Tue, 29 Dec 2020 05:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxmSo4YEIYtoXatpN2gwm7qBDJ/g/oXY9prnXg4jdO8=;
        b=v0Q5Qq5xl3iK1hZsw2mlslCB1B/WvaSnLt2vtV/36iowb2/D3Le9P/JcZNfw8H62Mb
         A871jfHDN06dF87BZWTfzkKHmLPTnCdGUwFahP9iHIhfRAO0ZNgh90vjxmh7o3STtXKl
         KiFGoV/GxhZJd914J2CBFBn6yl/j+RSIluN/UPS6Ae5BZbXcASSMtCmnmYiVXg/mUHQx
         tDrCovO3vMaSA05HNwsToRC2PumtH+OIT5LGOf4mEa3fzQ44d5CGZAJ7mpwpTBuQ/KmJ
         Ut637JnNBIm27X03JW7XeYx0bqx9QC4P6wKPQO7ZgYBYEsCY8ijfhDJymWy/dN0lCEM/
         R4Xw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/4] generic-phy: add configure op
Date: Tue, 29 Dec 2020 14:58:59 +0100
Message-Id: <20201229135901.30090-3-narmstrong@baylibre.com>
In-Reply-To: <20201229135901.30090-1-narmstrong@baylibre.com>
References: <20201229135901.30090-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, sjg@chromium.org
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add the PHY configure op callback to the generic PHY uclass to permit
configuring the PHY.

It's useful for MIPI DSI PHYs to setup the link timings.

Signed-off-by:￼Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/phy-uclass.c | 11 +++++++++++
 include/generic-phy.h    | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index ef03e3a502..43ffbcee0f 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -204,6 +204,17 @@ int generic_phy_power_off(struct phy *phy)
 	return ret;
 }
 
+int generic_phy_configure(struct phy *phy, void *params)
+{
+	struct phy_ops const *ops;
+
+	if (!generic_phy_valid(phy))
+		return 0;
+	ops = phy_dev_ops(phy->dev);
+
+	return ops->configure ? ops->configure(phy, params) : 0;
+}
+
 int generic_phy_get_bulk(struct udevice *dev, struct phy_bulk *bulk)
 {
 	int i, ret, count;
diff --git a/include/generic-phy.h b/include/generic-phy.h
index 5ab34cda03..a17d900e4b 100644
--- a/include/generic-phy.h
+++ b/include/generic-phy.h
@@ -122,6 +122,20 @@ struct phy_ops {
 	* @return 0 if OK, or a negative error code
 	*/
 	int	(*power_off)(struct phy *phy);
+
+	/**
+	* configure - configure a PHY device
+	*
+	* @phy:	PHY port to be configured
+	* @params: PHY Parameters, underlying data is specific to the PHY function
+	*
+	* During runtime, the PHY may need to be configured for it's main function.
+	* This function configures the PHY for it's main function following
+	* power_on/off() after beeing initialized.
+	*
+	* @return 0 if OK, or a negative error code
+	*/
+	int	(*configure)(struct phy *phy, void *params);
 };
 
 /**
@@ -183,6 +197,15 @@ int generic_phy_power_on(struct phy *phy);
  */
 int generic_phy_power_off(struct phy *phy);
 
+/**
+ * generic_phy_configure() - configure a PHY device
+ *
+ * @phy:	PHY port to be configured
+ * @params: 	PHY Parameters, underlying data is specific to the PHY function
+ * @return 0 if OK, or a negative error code
+ */
+int generic_phy_configure(struct phy *phy, void *params);
+
 
 /**
  * generic_phy_get_by_index() - Get a PHY device by integer index.
-- 
2.25.1

