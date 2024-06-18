Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE566C2BA1A
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:55:41 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.80797.1718697335078913268
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Jun 2024 00:55:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fpWEqKxP;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-361785bfa71so6619f8f.2
        for <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718697333; x=1719302133; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/iQ5rHKQ6Qq2bKKIszSJByGXybAQV0e6TYGSJ5WwuU=;
        b=fpWEqKxPCi3lsYvE2hCLt8v9oN6d2hjSs/RCxrdWR0+ViQR3Ng6V+VI70pi1oZyH+j
         uLTrnTt/N+tWwVH2R4W3elpbYHfBJeOLnx+tVPTB9RQz56iCE3yBCdZDnKetVAwPvbYn
         5chZlomH6hYw2d1Rx0ShFaPYNkAg+lBNEIUR4ZLLQLnH6hAajbjasKP7eGKpiqrAYXBL
         AviIX6fTdxsw1uQjaywyGa3MVomU7lekP7KKTQrStMPot7/6zLVCyjKIT4aUEgDw70zd
         3gge6iBUl4EMN1lWZXaHhaGqSc5AGtosGWxCB5ElHoRFLtd9LLBSvG1yOZGy5CZY4wSa
         WdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697333; x=1719302133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/iQ5rHKQ6Qq2bKKIszSJByGXybAQV0e6TYGSJ5WwuU=;
        b=vHgw2eGEDZ4aLQoTPzITToesZbONcr850iqZg2Fas+AnwU2dPXMmt0mcxjwZ4Kmls0
         AIxNdSilwKKibyY0Z+h6stmrePlw5cTJEcQgdOMTvywWYhrUO7hCpuWKn81aesRVyadA
         y4ep95BU9Ugj8eMhixPPg8omX5Jv8Y6A8NV8/wXj56hzdCTum6Td1J/ohZCdcRx/GY1P
         BIhOO1fpettdJNd8Qo0BRH/JMu7cVwBmkkdUix1y9SRQrmTMAFqNpHcnVcl+NnIfC3f7
         bJVFh47l1cpKF4bYtCLw0iYBKulzTmkX0auJNBs3DpDENxQzyExRMgEpKMXqFKUpOElY
         qitw==
X-Forwarded-Encrypted: i=1; AJvYcCVGN2cR5B1uFsyPuJRjoy9JbicJhIYZ60xQDSdNbk2khIRNNRYlpVd2QMlMVdsT8y/PWPskEfw8e3ZezWYsWlbLT5OMz8e2mNI=
X-Gm-Message-State: AOJu0YylmjzYycxmTpYv1aG5bKV+PXQUzech6IoIwqL6Dwe6gh2hzlrZ
	q7Dv31qSlJbkPigc0ZDtCkJDDmvNUZXbAj7e9CMph4sRho8IeS0V2xlXkA4DR5rAH1so+RTY9Pi
	s2JA=
X-Google-Smtp-Source: AGHT+IFrFLoDUurw4xX1qIzO8jwkltBWyS76brXrifjeuGyIj9Xnh/P08PXQKPnS2iSQ5Xu+63F5aA==
X-Received: by 2002:adf:f646:0:b0:35f:209e:21be with SMTP id ffacd0b85a97d-3607a747550mr7428576f8f.1.1718697333266;
        Tue, 18 Jun 2024 00:55:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:55:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:27 +0200
Subject: [PATCH 3/5] phy: meson-gxl-usb2: remove
 phy_meson_gxl_usb2_set_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3hRKRk6rCcuBEMaskR4Fabd3ekP9rmERjxPgzCepr+I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1xv5HZWG6Uy+enJg8x+wOL8NpmfHTDt57dm+04
 CUtvl/+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cQAKCRB33NvayMhJ0d/+D/
 oCzgBETPsi7H7UNs7Sinscau3l3wA8BQSamxQluuUKfiqnkdulcIQgVZIGMGe3eWjwjxzKk+Sh4DoT
 V4luk4LGpZeU06342w6pssgExOfBHm6BZwo9F6+L6JYZWi4se7hUkXRou3AnDbhV8EOos4CnPn75L4
 PZqYpGjZhILK8URoiWd8YsvwLAVYJfbMV7cGV3/qjg3a40XoxXxowwCs9HxdMKjq4CkAWqs65FGszN
 iPiHDmjIUsijBzGf+BxICg8iXutYcjOEef9BiGPJLfSnA5Wy/4+cpfiioFj3Ay65MzzUcM2wxeszxE
 GAAzlqiJLhRfHAtoZGWiEFYgVaRacMz/RJn8/f5/qKtnUuYhkuybJ0uVTH9dNvNvsyGYVZQI0cS937
 bAk5Q0eY6ZfNxrSe/WH68tv31EHt4o1sb+ZK4ZFMRmp82buc3+UgTAxqpwJTO5mE2wK9s24ZnmpC1o
 Zis+ZfpjJY7ke40yvoMMpbRMdqb52m6gKHD+yY1ANIC91CzYdFTWDqonImZ6bu4j7QcbrP4qSdS9n0
 cwj2GIObCARPkGxwHJbSKfZjDGx145nmuvryy/Jf56xcs0tU8gmASzisQ+5X3rSVZDpJk4mYJ33go1
 65kR3lhxSavrhg3SHeu4tIooWH6gEsLNDi4xJIsXs97bNkmDH3RB+92JLxhg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 07:55:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2301

Remove the public phy_meson_gxl_usb2_set_mode and move
the implementation in the the set_mode callback.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb-gx.h |  3 ---
 drivers/phy/meson-gxl-usb2.c             | 45 ++++++++++----------------------
 2 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb-gx.h b/arch/arm/include/asm/arch-meson/usb-gx.h
index 61f1809df9..966d401730 100644
--- a/arch/arm/include/asm/arch-meson/usb-gx.h
+++ b/arch/arm/include/asm/arch-meson/usb-gx.h
@@ -9,9 +9,6 @@
 #include <generic-phy.h>
 #include <linux/usb/otg.h>
 
-/* TOFIX add set_mode to struct phy_ops */
-void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode);
-
 int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode);
 
 #endif
diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index e051e66224..140e936b47 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -19,8 +19,6 @@
 #include <linux/printk.h>
 #include <linux/usb/otg.h>
 
-#include <asm/arch/usb-gx.h>
-
 #include <linux/bitops.h>
 #include <linux/compat.h>
 
@@ -121,54 +119,39 @@ static void phy_meson_gxl_usb2_reset(struct phy_meson_gxl_usb2_priv *priv)
 	udelay(RESET_COMPLETE_TIME);
 }
 
-void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode)
+static int phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct udevice *dev = phy->dev;
 	struct phy_meson_gxl_usb2_priv *priv = dev_get_priv(dev);
 	uint val;
 
+	if (submode)
+		return -EOPNOTSUPP;
+
 	regmap_read(priv->regmap, U2P_R0, &val);
 
 	switch (mode) {
-	case USB_DR_MODE_UNKNOWN:
-	case USB_DR_MODE_HOST:
-	case USB_DR_MODE_OTG:
-		val |= U2P_R0_DM_PULLDOWN;
-		val |= U2P_R0_DP_PULLDOWN;
-		val &= ~U2P_R0_ID_PULLUP;
-		break;
-
-	case USB_DR_MODE_PERIPHERAL:
+	case PHY_MODE_USB_DEVICE:
 		val &= ~U2P_R0_DM_PULLDOWN;
 		val &= ~U2P_R0_DP_PULLDOWN;
 		val |= U2P_R0_ID_PULLUP;
 		break;
-	}
-
-	regmap_write(priv->regmap, U2P_R0, val);
-
-	phy_meson_gxl_usb2_reset(priv);
-}
-
-static int _phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
-{
-	if (submode)
-		return -EOPNOTSUPP;
-
-	switch (mode) {
-	case PHY_MODE_USB_DEVICE:
-		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_PERIPHERAL);
-		break;
 
 	case PHY_MODE_USB_HOST:
 	case PHY_MODE_USB_OTG:
-		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
+		val |= U2P_R0_DM_PULLDOWN;
+		val |= U2P_R0_DP_PULLDOWN;
+		val &= ~U2P_R0_ID_PULLUP;
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
+	regmap_write(priv->regmap, U2P_R0, val);
+
+	phy_meson_gxl_usb2_reset(priv);
+
 	return 0;
 }
 
@@ -183,7 +166,7 @@ static int phy_meson_gxl_usb2_power_on(struct phy *phy)
 	val &= ~U2P_R0_POWER_ON_RESET;
 	regmap_write(priv->regmap, U2P_R0, val);
 
-	_phy_meson_gxl_usb2_set_mode(phy, PHY_MODE_USB_HOST, 0);
+	phy_meson_gxl_usb2_set_mode(phy, PHY_MODE_USB_HOST, 0);
 
 	return 0;
 }
@@ -205,7 +188,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
 struct phy_ops meson_gxl_usb2_phy_ops = {
 	.power_on = phy_meson_gxl_usb2_power_on,
 	.power_off = phy_meson_gxl_usb2_power_off,
-	.set_mode = _phy_meson_gxl_usb2_set_mode,
+	.set_mode = phy_meson_gxl_usb2_set_mode,
 };
 
 int meson_gxl_usb2_phy_probe(struct udevice *dev)

-- 
2.34.1


