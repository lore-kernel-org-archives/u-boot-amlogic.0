Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE9C41513
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:55:41 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.80796.1718697334110964515
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Jun 2024 00:55:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=PiI7yg07;
 spf=pass (domain: linaro.org, ip: 209.85.221.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-361b376236fso381752f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718697332; x=1719302132; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s6QvRaLgBM9BVS5oof8t32fnskrrrw/ilAd8VvZ3SI=;
        b=PiI7yg07H9zESUAxa/zcksMVX3npzT0fF7WyURrfylrjnaqqFVPlhoe1epGJQ9iBi2
         k/FdFSSPRJlzUJ8Mv7Y9gwJjoskYp+VBwGkMpL2D3ibn2Ho0/3TCIjZaRmkbbqy1z+UW
         D9UNlxuHv9Wln8qAXD7zVB9r1+vyZLWZRiAb/5SxfT+k0Dw6SJDB0bkJUn52c+s3o7Mg
         TSbKfVxH35Db/GZBsA2vv81VlUk3hm8/FGOf6oySFuLxi8h6TQGmQXhy9wqaAPd7DxEs
         FUtBfGT0MVCNUhjLzzGC7lFqxj+gtONf5PbsM/8/hFKLy0gSBZdGFtzvPT4/OSQHwV5H
         NI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697332; x=1719302132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s6QvRaLgBM9BVS5oof8t32fnskrrrw/ilAd8VvZ3SI=;
        b=jOFPGaiwUMLcAw8HeplzTRwEQB1mVRYWplVn2th3N2AFAJbFHyODFIRCtK7PTfxffc
         oZypIyHOrpYr6gdb2drhn4vbDYJKVh8oN6AANT4mQ8RuJClC4rthWgsOVRFWBkysScJp
         ELF3ZW9c3pZptYYDB9IH9nZD/fFQAllW6v8/vHy+2kRoHa9JEMBpsJDAwQd6J6+tOtV8
         sRbtYJzLcBC1VJnNn0wSJBcZb010mjKsbF9pQ2UaCu/GODg3MWehE1J56V91WbB/4a2b
         97bt9K2HQqcB2XvlfZ8t7zrjv2uN0KqmDfjdQB+j1OB68JmMF4NvG5ai8Oxqtc/xnwGJ
         KZOg==
X-Forwarded-Encrypted: i=1; AJvYcCX0A9bhDV0zubxqONdzgIshUyXFpJyxUGV+zgvYs2E7aXCcwiz8mj/+zM5a9T2oR4dDHLl3WtUB/PSf/Uv/kMhvB7UJVucS9UQ=
X-Gm-Message-State: AOJu0YyvNC1ZGM5tJe7x5ay7fazLjTSHmKdEMPuZH0s4ds1xFXXeQ8ur
	3TBRpGjGD4d7uCsU1a2/f5Tr5hg+zXOpy4NmrHV7rNSnCaBV3K1b6Fc2W7TGdQw=
X-Google-Smtp-Source: AGHT+IF21/QwqJhDtBK6s3EZUuS0nASQ5cPr1bnnMK4d5vu6wDEmxcfzs83bkBeNLVAUxGHOUVBEEg==
X-Received: by 2002:a5d:4c4f:0:b0:360:70c6:fe5b with SMTP id ffacd0b85a97d-3607a7e511amr8112704f8f.67.1718697332469;
        Tue, 18 Jun 2024 00:55:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:55:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:26 +0200
Subject: [PATCH 2/5] usb: dwc3: meson-gxl: switch to generic_phy_set_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-2-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GTrmp7WLhG6oe7Z7C9Uhs4G6Xkk3KHyHVOiiQerYuI0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1wap7LKjJwO8nC/puvhnQVgeA++lPwp7d7lP30
 sZ90iB+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cAAKCRB33NvayMhJ0az+EA
 CTCJHwU+nk9Qy1PElASIeUQmoQRXKQZIQjb6D6Lu19mFPdLRfe8GacxchRTQQRQagC9kQu8iBJp97M
 lxm3kS0LQh1bQA24iIZMh2yglve9SGmuJKSKtFVol3/cNAESEVuxhB4/CBtb+l+9vNBi4cvqG5Py/f
 3vgO181AUxBG5pGr9QaYzTQmIyqWVbO1vRANH/iWt6aPRpSllrjO3xdlx6ZVOT84t+9e30CMGh1Pmn
 KF4vURjXs3ZjZE4WQF/pIVH7NrbLNwCsr13zz4vg1ijs2hDTNId1nzq6ZZ2udHHXYXxqUuTjtdnpHf
 /K5KxdiXEs5xrnBchL08hfIaKG4SVmSU0tZVV/nUTnQelSRz7GWJ4Hps66z8PnY4vzH9v+kUy/Ccxx
 anlyv1zbXHHlJJJxMhI8bNmhtUUTzVbEGKrSqw5RfywY2kaPr8dhES+FckzP8/YXS8pmW/hirzH945
 LOmEAyxmQ9fWRxOyh06TL84fqDAtRh59s2kclaxkFv1MPm29EdQ6yOb4wY4Ym25fV5j3m6jNa5L9TC
 lkI7kmm/x3Dfqvf4KvvpO/mc5uraTpnCzJBOqZhQuGFynaa/4Hvjbt0M3ojBh74B3Pu+RYkRGy1IxM
 /rNhU1UV4z0G0QOBHmA9o406bR2KvzHnaFPvTpfL7VkEnYOFcqc7mI5EDETw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 07:55:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2300

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


