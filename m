Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E12DC41513
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:19 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.42407.1718869389882204684
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 00:43:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=tt/mEnWw;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217a96de38so4746695e9.1
        for <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718869388; x=1719474188; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s6QvRaLgBM9BVS5oof8t32fnskrrrw/ilAd8VvZ3SI=;
        b=tt/mEnWwOMSzdamtADKp74qBCKetQzglryDgrRcn+5PGt/ePz/OdsJKcOInXUBAs+y
         BNLnl2WxSIKPGML3reyK3irgJJGhjG8sk/FA64F8SrmpnGMHfzemgriU1qWK6ILDTgnO
         qrBCdHmLFrVDuPhVV54N13JzCSSJr1QARokGTLevjr8MB0OCMIv4DU+QQ2hWr/GgSGzO
         ZDbXsvsiG401d70j3zNKZyROOyZhaAhe1aJZRANhWDTU64If2wYVwWppy+kGQlXhqVEY
         VweZnJ742SEfcwb+tjQ7BJesXd+fm+HvMsulWr0UC6J6d+7/kBcE87wJxw9UC7HZhtq8
         hybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869388; x=1719474188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s6QvRaLgBM9BVS5oof8t32fnskrrrw/ilAd8VvZ3SI=;
        b=b8+sMaQ/rUhAf4UhxyBRIULN1Wja2AtOehjUGDUhDF/GKFlmL+vTBuL52bjVPL659Y
         //uaoLGmliikDCKU3tUySmJbenyJk1kICdEEWUMKixAPMSJldRAdZEOHhGJvafauvW+3
         qiBS9QexxNvsbveADLHNWHJn31nOR37nnrUrT+rm8vZbqdostF+aJvBtIwhB6Sv1Cwbj
         Sy+9v6oInp7xCqIsWnEHZETzCcBcsd7trHFNhFEiqJpbtG8LJtKQFj+PnIgWzTrcqgaJ
         K12uFY9QPXAf52PujH2OajuLKxOXbsFpXtkQ+QrHVuc+XMyfoNX3PZyF0rU9G/P2xmwG
         /8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNCCGSdyF2GzBJz+RZVbgl59arQCmgWCx5yPC0/w15kt3hY4Oe8RKkdEDFp3/xJmUSufmgjxzqWeTKvscGGjeb9K23bUGhw1o=
X-Gm-Message-State: AOJu0YyTd0rABgacurFmZq0XMV59tGcIq4KPrDWpOpacXo+y4FmqSTqD
	Y2F6B3UPfNQrxypPEODB2iFvOSLRF5UYL2dPVx1JgNZipi73wKORDbfCvyk1RWBuGY/5PnoN5ab
	qbNM=
X-Google-Smtp-Source: AGHT+IFy7tEBd0BNmmZyDb0au8TWFby4pc1AKz2pbecidxkyuhm8PTue9m64CfazxGxwbP2zvqPNqQ==
X-Received: by 2002:a05:600c:21a:b0:424:7bcf:2486 with SMTP id 5b1f17b1804b1-4247bcf275emr13205085e9.4.1718869388315;
        Thu, 20 Jun 2024 00:43:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:43:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:51 +0200
Subject: [PATCH v2 2/5] usb: dwc3: meson-gxl: switch to
 generic_phy_set_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-2-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GTrmp7WLhG6oe7Z7C9Uhs4G6Xkk3KHyHVOiiQerYuI0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92G0/IZjZzjkdX/z7K2yMmOecfZgFnq1gjztS6f
 FRdL47KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhgAKCRB33NvayMhJ0R3+EA
 ClSEndbXm5rHM4EtWNSP2BlvSa6wWxqlCA8EykuPr7CfUhBMNeYZg1juvpnQhwzz0jo7ybKZ7Cchq0
 V5T+Vw775CvMZTvIZpAF/y8TOI4vvZN+iBiOvaYiRrd2DQHN/ZFSs4tXbX9Id2Gd/6wxndXGv7Cy0m
 5fnNcHNaFdXqn6Qq0dopmz9ctkcip0BVvrXrLHLS9XfJd6GIIfbMBusnDPgnN9AjR0dHwBKkqXxqgp
 XnX/a8POCU0RhDG9X6PcO09xa6k3HukUJ4ae1jKaYrvQuGl8/zewpJaempmwL7v4uQknh54CXUPpI4
 UrgZbRoTgSw7OS2VbZ4mnRbES0tGRVPs1RfeclYK4iLwVCmUzw7pufq5JB58UxCwYR3Z2b4en3fnyh
 V4abYxiYco/bdilnAdH8E7HspC87weXOpoknt13eDnRyJ431PVGy8iUl4l8DklZq3NEHwS1JU8jhZo
 ugnQ80GXXXSAlcR175OwdxgZ9ifJE7TqnIqYCrGIKUX3MyaLMsOS4C6sV4mZrhPXFR9yehH+Ngfe+j
 Zn0bHpDaiib9/wXHjs4HSSCxouxa7eTixYRohJtWSYMx9qJol27HwtySSPDdkGen4ZrSH2ZYBKB2Qk
 F/Gx+5okayF7X2dkbal4Bmkbu4jx87VvjEPRtJchuXRUd+4V2rlO29fpN3Mg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 07:43:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2309

Use the PHY set_mode call instead of calling directly in the
PHY shared function.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/dwc3-meson-gxl.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 3e693c5ff3..290ac03a37 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -158,9 +158,9 @@ static int dwc3_meson_gxl_usb2_init(struct dwc3_meson_gxl *priv)
 		if (!priv->phys[i].dev)
 			continue;
 
-		phy_meson_gxl_usb2_set_mode(&priv->phys[i],
-				(i == USB2_OTG_PHY) ? USB_DR_MODE_PERIPHERAL
-						    : USB_DR_MODE_HOST);
+		generic_phy_set_mode(&priv->phys[i],
+				(i == USB2_OTG_PHY) ? PHY_MODE_USB_DEVICE
+						    : PHY_MODE_USB_HOST, 0);
 	}
 
 	return 0;
@@ -224,7 +224,9 @@ int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 #endif
 	priv->otg_phy_mode = mode;
 
-	phy_meson_gxl_usb2_set_mode(&priv->phys[USB2_OTG_PHY], mode);
+	generic_phy_set_mode(&priv->phys[USB2_OTG_PHY],
+			     mode == USB_DR_MODE_PERIPHERAL ? PHY_MODE_USB_DEVICE
+							    : PHY_MODE_USB_HOST, 0);
 
 	dwc3_meson_gxl_usb2_set_mode(priv, mode);
 
@@ -361,8 +363,9 @@ static int dwc3_meson_gxl_probe(struct udevice *dev)
 	}
 
 	if (priv->phys[USB2_OTG_PHY].dev)
-		phy_meson_gxl_usb2_set_mode(&priv->phys[USB2_OTG_PHY],
-					    priv->otg_phy_mode);
+		generic_phy_set_mode(&priv->phys[USB2_OTG_PHY],
+			priv->otg_phy_mode == USB_DR_MODE_PERIPHERAL ? PHY_MODE_USB_DEVICE
+								     : PHY_MODE_USB_HOST, 0);
 
 	dwc3_meson_gxl_usb2_set_mode(priv, priv->otg_phy_mode);
 

-- 
2.34.1


