Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F2C2BA18
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:19 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.42408.1718869391316467496
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 00:43:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LgBWnObp;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42165f6645fso5699935e9.2
        for <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718869390; x=1719474190; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQPN6Jt2rsPTvACxaljaQFZ6kE1AmkZWw/yLHFwcX74=;
        b=LgBWnObpn5sMpD5drp+d5yNV/GBdOABF3BZYswOa8joJj/Ij1kSkRVArs+rHUqSHq7
         YB7qchBMKHczzVtQRka0UZirvbbKeh2OZWAHSGgwOC8Qe/OBf/mOQOZ1Uu8n+b5ZYp8i
         OjBnJN20BUI/mjNqpPdt/I5OPX5hSF/5tLPd8YJbkaj1hQn+SCWb0qDiIyBpe2y3kAl5
         TqcuAkR07elVdRCvJGqIwYkMqFNll8N3EH+FKbsLW44ps8UtXMTNQxLAxB9njd76K/YK
         T16/vsfxl8XvI5eIKgXeVDkkgZ7fvAy0RNWJ8+GrlBsZe3PB07rp6q/9MBVhmx5w8ABO
         PJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869390; x=1719474190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQPN6Jt2rsPTvACxaljaQFZ6kE1AmkZWw/yLHFwcX74=;
        b=tE3tuGz61Oe2UjFh9tfL2oQ1EUWpxB6SJoI92l2qkbOqX/7rr+f2X587+RntMAOFzu
         Po9Xszi3fp9/19fCVxwcm4PAXnIoqglWSXTUTxnLTKMfsNfi2PIyJ/9su7DPwtUuAcye
         fUmVwFVt3xjpZ4hhl6uySpG13hb/ZS1VBVwDcfueL/O3TebachQF133ui62QrMZvO+Xw
         QcYCrWuDJEYcG3RROJdB7pFzKwDRoOZHYjtBskHqy1UYlsSsxZDCdlILzs2z7JCZLQqK
         0/bDLB1OlP+xUYZlDHfHQOm2aF/g4C/eCrB3VP2a+LRjzAA0TbStC6cGInqhT8eHZDCA
         UWeg==
X-Forwarded-Encrypted: i=1; AJvYcCXK26PmctcbLmcDFd4ibmK8bHLnE3rVr++Iiu9zPHL3UB6m38W8cpaNwD3dDdMU3beXQCmBA+ztBO4hFJt15GsseTUuI/EDixI=
X-Gm-Message-State: AOJu0YxYfaiyaIBmXyxJIKWtTjKUVvX+OlICaD+iYVLG5TvIg7RfZXZk
	iZpa2OfEyWbYHWZS4kmCZYGvRIyhUVJ86kq4YF4HACe709/jA0AcrGYxjpFJn3drgeDIRapRvjp
	ELd0=
X-Google-Smtp-Source: AGHT+IGzZoAqqGFJTuwd0O/AxQkB49TEPAANneHTP1/UMMepq8ogDnwIM8JHB9A9gUd59vAXzEz+rg==
X-Received: by 2002:a05:600c:3587:b0:422:6e65:a4cb with SMTP id 5b1f17b1804b1-4247507865fmr35879575e9.3.1718869389791;
        Thu, 20 Jun 2024 00:43:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:43:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:53 +0200
Subject: [PATCH v2 4/5] usb: dwc3: meson-gxl: drop usb-gx.h and make
 dwc3_meson_gxl_force_mode static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-4-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DpgZRKTgku+ys6NjVBIfERJR/6XmLyfT3EDY9DcHj8U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92G07oKuFEboJj68Jjm0C/wtJ1Ag9vmYVeZWVab
 ZikgUkGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhgAKCRB33NvayMhJ0SKWD/
 40OV74sIDmCJCVZaSeVpyn3Fu+Qe9yUZHcb6dHbv+gJQpzuFmrrvd4hBtkGLDxvdGxm3MkzL/LyhDL
 tIB/V8sM3/WR9G1coYQuUJia4Mer/VVnmBt2G9Op00idR70wWU9iq03EiciG/yvoAdOCvqhBFO/526
 6u3YnEnIucZtNdbWjW78MXitoTvG0/MceN3diw6ZkZHd2Iceim4ze5vusYth9lWSJ7yT7UUW5sbUyj
 KASISbBsXO4K/v65L1K7TqflEFi6tkx9DnTBrjk7JUD0crKJIkiCluvkqYX0BwFI/94GMaE54Y8EWe
 ZPWBuTM5F9yB5h57v5hGPqU7dXjT7sGTSrrgEJj2Qh1eca1tB5nov6fwgW55mXuBiQCKpvGAxUpQIx
 f6y1paesd5J8+xTn72HugjcX2wqij187mcohwt7xmqtgtRO2r0anxYK1ewZ50CoWPMYgqDJzob1gxp
 mPYiScxjpZ1TGH6Wu1yHhUvrdVF73bN4Dm9aUzG6np6KF7SE0Sloh16hn77CmRQGy2fW3L5pdF08vm
 2dC5UKLtqPOWN1oe9zSM7q6rxAacGsQ9zWpGonggHc/PmbBZcLbDy1LAn6yXeX/V9cPqyKAS/zoH7r
 hr3u5vhw/VEEaS8P3dkONXoFIFTI0EyGZvcvKcWB++07OrscE46NP2W23Cew==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 07:43:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2311

Drop this useless usb-gx.h and now make dwc3_meson_gxl_force_mode
static since only used in the dwc3-meson-gxl.c file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb-gx.h | 14 --------------
 drivers/usb/dwc3/dwc3-meson-gxl.c        |  3 +--
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb-gx.h b/arch/arm/include/asm/arch-meson/usb-gx.h
deleted file mode 100644
index 966d401730..0000000000
--- a/arch/arm/include/asm/arch-meson/usb-gx.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2019 BayLibre SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-#ifndef _ARCH_MESON_USB_GX_H_
-#define _ARCH_MESON_USB_GX_H_
-
-#include <generic-phy.h>
-#include <linux/usb/otg.h>
-
-int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode);
-
-#endif
diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 290ac03a37..5fb9b477ad 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -26,7 +26,6 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
-#include <asm/arch/usb-gx.h>
 
 /* USB Glue Control Registers */
 
@@ -193,7 +192,7 @@ static int dwc3_meson_gxl_usb_init(struct dwc3_meson_gxl *priv)
 	return 0;
 }
 
-int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
+static int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 {
 	struct dwc3_meson_gxl *priv = dev_get_plat(dev);
 

-- 
2.34.1


