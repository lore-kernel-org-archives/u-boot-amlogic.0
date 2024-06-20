Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A1C2D0CE
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:19 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.42276.1718869390937013310
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 00:43:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qd4PeltW;
 spf=pass (domain: linaro.org, ip: 209.85.128.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42138eadf64so5689435e9.3
        for <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718869389; x=1719474189; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/iQ5rHKQ6Qq2bKKIszSJByGXybAQV0e6TYGSJ5WwuU=;
        b=qd4PeltWVvBYHhNasew8/jYDkUDNFaw83Tc0VNZ8JtYBeOFSIsQ2Dn6VPWEFH/pwSQ
         PJbD4pwRzMX9M1aLw7Avdh5rDdFFAASUMmTwM2VQj9C/To7r02FUwU/q4zXL8kMG1ham
         VEPu6GkdQKLJK0CruAUHsyqK/3SMsfGpGY1hzCynyzk9nhOFH7mJuQEbxxxfG0y6hDQn
         cFl1cPhZxg+5+gSQy8auRrxt+6cPEoRn6YRHkONtS4L7RDlJWqXmVOwpFKYu7EyuDOYU
         WaWigpYpSdaNngCBwvxRLQGdCNw+UotgM9jAMNJBjRCGOPy8O2kZ+XDq1dUhlgpCyYwB
         JNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869389; x=1719474189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/iQ5rHKQ6Qq2bKKIszSJByGXybAQV0e6TYGSJ5WwuU=;
        b=qtjp8s1MQXpvZBLY06gpCscqQ1WKH3VgOdZJ18TJGdmlBeWCUYnOPGtVBhTWa7jlgG
         a/QBsMfOH3TMr6UjLqxL7nIk5azLem0pHugY385X54TDWL8209Kop2hnito8bd/UT6qQ
         OtkUHIJ4C9QZ/zH6AP6zQ5acByq76N9O4X4Kx/lL8N+NgR3r9rvRtqf0NvXuHJfunZMC
         XYAz9dJegJhP6a6+v2/Y39u1Cas3QFau+vJbZczLmT+63ioTQA+hjbYjYosLlLC0Adnq
         b2Kink/9hbTArEdoICMYNqUhIr1+ml4HVJT+mjnmsA7OTPiZ4NSQvpsN4sAwAeDPzZus
         la6A==
X-Forwarded-Encrypted: i=1; AJvYcCWCoBDq2kOlFG1LmRhrksr3eMeYb8q0tYXqgCbKYefopPWO9LhpXEHekOMBdqZL3AzVIIIbvv5LeGPZK3ehuMF8o1QPeqkU0JA=
X-Gm-Message-State: AOJu0Yzjvv2wYpWYxxYJZc0eAUwjlebDdOjlnPWsPY7PLJFW6vWj1VVg
	iPpiM04Vp3rgb8fRQYWApwf/b7JOCs8/S5nbaZjTM6IjcfVcEJB0+NXjMl5eGpvK2FHa5a3Pic5
	KwUg=
X-Google-Smtp-Source: AGHT+IE5yLyB2usJSfw5QfQ9nO+rQhTHgciquRgOoWHaS6UtGNI5rKfK87NHPyWIY+TL7R23OGfgRw==
X-Received: by 2002:a05:600c:4a9a:b0:422:720a:1be9 with SMTP id 5b1f17b1804b1-4247517f131mr34503125e9.20.1718869389066;
        Thu, 20 Jun 2024 00:43:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:43:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:52 +0200
Subject: [PATCH v2 3/5] phy: meson-gxl-usb2: remove
 phy_meson_gxl_usb2_set_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-3-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3hRKRk6rCcuBEMaskR4Fabd3ekP9rmERjxPgzCepr+I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92GUd8gu/sa0iYjRPPVS5Ey43bKMiVGhhiH9hDp
 L05y3HqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhgAKCRB33NvayMhJ0XkXEA
 CL+GL4Vku+xMyV4xavRt4+2oiJZ9JmsvNgMkMt0nwjw35d+116gnjYX33hyT6XsMAYqnPY9JY0pRgL
 4h+/0jPcsHVzos3sCf8jU6Pn5Wm74TdlkBVKT/E0fZOnaKN1VVOn7wDrObkZCrLoOWVmtkarRGI3hC
 JVbJNCdBLDEzGifCjRuRHZLSp+JzrQxKQI5W7kR+zVawMbElYHcscMhIkE4ySN+plpfY68PW0CUyb7
 KrUspPk4j3FCI4YGL43r/jnsNYnJW48+emnAPVpvV+BRs4ey+3eXWcBNDJCbJmd31RDxeU943SdstZ
 oD7VlMCR6MlGuv6qfIIjjV9/VxDTi2YIlK/0yXPk9Hc9fKmBxy7oBN6sBUa56ZgUgvDPPBIRElYW4g
 PBun3XO5W0rYepiTmkfEf/YS/sUY6jgSeo778OCmxQ7ijYiGQz/7BDQeT91yO5gUHj/B8XjR52HDRS
 dw+NGK3iWWuMtE71b85zb2nS1e8AykLmmK5ZUt+a+V0/JTphL5ZeciqXGFDdMnhTOY5Ju3LbQobD5P
 QsVgBzOXdaOH2IEZPW1lfjm4wSE18EiJGwBhr27aZ6D+vOEP4utjLGFzSI00K2vlmIWwaedvyRfhRe
 qzRanpLNQ7v7hfJSAir+vl4wu5n3j5vdHTWEHRtWR9CmYFCCbK5gZ9vERWXw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 07:43:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2310

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


